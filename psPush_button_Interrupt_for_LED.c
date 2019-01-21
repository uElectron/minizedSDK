
/*****************************************************************************/
/**
* @file psPush_button_Interrupt_for_LED.c
*
* This file contains a design example using the GPIO driver (XGpioPs) in an
* interrupt driven mode of operation.
*
* The example uses the interrupt capability of the GPIO to detect push button
* events and set the output LEDs based on the input.
*
* @note
* This example assumes that there is a Uart device in the HW design for Minized Board.
* Here Input pin is 0'(sw3 i.e., PS Push Button ) and Output Pins are
* 52(Red Element of PS LED) and 53(Green/Yellow Element of PS LED)
*
* This Program Creates an Interrupt whenever the PS Push Button is Pressed
* by using Raising Edge Triggered Interrupt on that Input Pin '0' where the
* Push Button is connected to PS
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xgpiops.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xplatform_info.h"
#include <xil_printf.h>

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the names of the hardware instances that
 * were created in the EDK XPS system.  They are defined here such that
 * the user can easily change all the needed device IDs in one place.
 */
#define GPIO_DEVICE_ID		0
#define INTC_DEVICE_ID		0
#define GPIO_INTERRUPT_ID	XPAR_XGPIOPS_0_INTR

/* The following constants define the GPIO banks that are used. */
#define GPIO_BANK	XGPIOPS_BANK0  /* Push Button Connected at Bank 0 of the GPIO Device */


#define LED_DELAY		10000000

#define LED_MAX_BLINK		0x10	/* Number of times the LED Blinks */

#define printf			xil_printf	/* Smalller foot-print printf */

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

static void GpioIntrExample(XScuGic *Intc, XGpioPs *Gpio, u16 DeviceId,
			   u16 GpioIntrId);
static void IntrHandler(void *CallBackRef, u32 Bank, u32 Status);//Called whenever we press the Switch
static int SetupInterruptSystem(XScuGic *Intc, XGpioPs *Gpio, u16 GpioIntrId);


/************************** Variable Definitions *****************************/

/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger.
 */
static XGpioPs Gpio; /* The Instance of the GPIO Driver */

static XScuGic Intc; /* The Instance of the Interrupt Controller Driver */

static volatile u32 pattern=0; /* Intr status of the bank */
static u32 Input_Pin = 0u; /* Switch button */

static u32 Output_Pin_R = 52u,Output_Pin_G = 53u; /* LEDs Pin Positions for Minized Board */
//@Note : we can also Define them as macros instead of Static Variables

/****************************************************************************/
/**
*
* Main function that invokes the GPIO Interrupt example.
*
* @param	None.
*
* @return
*		- XST_SUCCESS if the example has completed successfully.
*		- XST_FAILURE if the example has failed.
*
* @note		None.
*
*****************************************************************************/
int main(void)
{
	xil_printf("GPIO Interrupt Example Test \r\n");

	/*
	 *GpioIntrExample is the Actual Heart of our Application
	 */
	GpioIntrExample(&Intc, &Gpio, GPIO_DEVICE_ID, GPIO_INTERRUPT_ID);

	return XST_SUCCESS;
}

/****************************************************************************/
/**
* This function shows the usage of interrupt fucntionality of the GPIO device.
* It is responsible for initializing the GPIO device, setting up interrupts and
* providing a foreground loop such that interrupts can occur in the background.
*
* @param	Intc is a pointer to the XScuGic driver Instance.
* @param	Gpio is a pointer to the XGpioPs driver Instance.
* @param	DeviceId is the XPAR_<Gpio_Instance>_PS_DEVICE_ID value
*		from xparameters.h.
* @param	GpioIntrId is XPAR_<GIC>_<GPIO_Instance>_VEC_ID value
*		from xparameters.h
*
* @return
*		- XST_SUCCESS if the example has completed successfully.
*		- XST_FAILURE if the example has failed.
*
* @note		None
*
*****************************************************************************/
void GpioIntrExample(XScuGic *Intc, XGpioPs *Gpio, u16 DeviceId, u16 GpioIntrId)
{
	XGpioPs_Config *ConfigPtr;	//stores the Configuration Settings of PS GPIO 
	int Status;

	ConfigPtr = XGpioPs_LookupConfig(DeviceId);//Load the Configuration settings required for PS GPIO_0

	XGpioPs_CfgInitialize(Gpio, ConfigPtr, ConfigPtr->BaseAddr);//Create PS GPIO device using settings from "ConfigPtr" and
	//store the driver at 1st parameter"Gpio" address , so that "Gpio" acts as the Required PS GPIO_0 Driver

	/* Set the direction for the PS Push Button pin to be input */
	XGpioPs_SetDirectionPin(Gpio, Input_Pin, 0x0);

	/* Set the direction for the Red LED pin to be output. */
	XGpioPs_SetDirectionPin(Gpio, Output_Pin_R, 1u);
	XGpioPs_SetOutputEnablePin(Gpio, Output_Pin_R, 1u);
	XGpioPs_WritePin(Gpio, Output_Pin_R, 0x0);

	/* Set the direction for the Green LED pin to be output. */
	XGpioPs_SetDirectionPin(Gpio, Output_Pin_G, 1u);
	XGpioPs_SetOutputEnablePin(Gpio, Output_Pin_G, 1u);
	XGpioPs_WritePin(Gpio, Output_Pin_G, 0x0);

	/*
	 * Setup the interrupts such that interrupt processing can occur. If
	 * an error occurs then exit.
	 */
	Status = SetupInterruptSystem(Intc, Gpio, GPIO_INTERRUPT_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("\n  SetupInterruptSystem() setup has failed");
		return XST_FAILURE;
	}

	xil_printf("\n Press The PUSH Button \n\r");
	pattern = 0U;	//Used to Change by Pressing Push Button

	/*
	 * Loop forever while the button changes are handled by the interrupt
	 * level processing.
	 */

	u32 delay;//stores the Delay in Each Cycle of While Loop
	u32 i;
	while(1){
		delay = LED_DELAY*(pattern+1);

		for (i = 0 ; i < delay; i++);
		XGpioPs_WritePin(Gpio, Output_Pin_R, 0x1);
		XGpioPs_WritePin(Gpio, Output_Pin_G, 0x0);

		for (i = 0 ; i < delay; i++);
		XGpioPs_WritePin(Gpio, Output_Pin_R, 0x0);
		XGpioPs_WritePin(Gpio, Output_Pin_G, 0x1);
	}

}

/****************************************************************************/
/**
* This function is the user layer callback function for the bank 0 interrupts of
* the GPIO device. It checks if all the switches have been pressed to stop the
* interrupt processing and exit from the example.
*
* @param	CallBackRef is a pointer to the upper layer callback reference.
* @param	Status is the Interrupt status of the GPIO bank.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void IntrHandler(void *CallBackRef, u32 Bank, u32 Status)
{

	 static u32 debouncer=0;
	 debouncer += 1;
	 if(debouncer % 2 == 0){
	 	 pattern = (++pattern >= 10) ? 0 : pattern ;
		xil_printf("\nInterrupt code run - %u times",pattern);
	 }
	 xil_printf("\n Our Handler Called - %u times",debouncer);
}

/*****************************************************************************/
/**
*
* This function sets up the interrupt system for the example. It enables falling
* edge interrupts for all the pins of bank 0 in the GPIO device.
*
* @param	GicInstancePtr is a pointer to the XScuGic driver Instance.
* @param	GpioInstancePtr contains a pointer to the instance of the GPIO
*		component which is going to be connected to the interrupt
*		controller.
* @param	GpioIntrId is the interrupt Id and is typically
*		XPAR_<GICPS>_<GPIOPS_instance>_VEC_ID value from
*		xparameters.h.
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None.
*
****************************************************************************/
static int SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio,u16 GpioIntrId)
{
	int Status;

	XScuGic_Config *IntcConfig; /* Instance of the interrupt controller */

	Xil_ExceptionInit();

	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(GicInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	/*
	 * Connect the interrupt controller interrupt handler to the hardware
	 * interrupt handling logic in the processor.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler)XScuGic_InterruptHandler,
				GicInstancePtr);

	/*
	 * Connect the device driver handler that will be called when an
	 * interrupt for the device occurs, the handler defined above performs
	 * the specific interrupt processing for the device.
	 */
	Status = XScuGic_Connect(GicInstancePtr, GpioIntrId,
				(Xil_ExceptionHandler)XGpioPs_IntrHandler,
				(void *)Gpio);
	if (Status != XST_SUCCESS) {
		return Status;
	}

	/* Enable Level edge interrupts for all the pins in bank 0 Except Pin "0" where Push Button is Connected. 
		For Pin '0' We set Raising Edge Triggered Interrupt		*/
	XGpioPs_SetIntrType(Gpio, GPIO_BANK, 0x01, 0xFFFFFFFF, 0x00);

	/* Set the handler for gpio interrupts. */
	XGpioPs_SetCallbackHandler(Gpio, (void *)Gpio, IntrHandler);


	/* Enable the GPIO interrupts of Bank 0. */
	XGpioPs_IntrEnable(Gpio, GPIO_BANK, (1 << Input_Pin));


	/* Enable the interrupt for the GPIO device. */
	XScuGic_Enable(GicInstancePtr, GpioIntrId);


	/* Enable interrupts in the Processor. */
	Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);

	return XST_SUCCESS;
}

