#include <stdio.h>
#include <unistd.h>
#include "platform.h"
#include "xil_printf.h"

#include "xparameters.h"
#include "xiic.h"

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define IIC_BASE_ADDRESS	XPAR_IIC_0_BASEADDR


/*
 * The following constant defines the address of the IIC device on the IIC bus.  Note that since
 * the address is only 7 bits, this  constant is the address divided by 2.
 */
#define MAGNETOMETER_ADDRESS  0x1E /* LIS3MDL on Arduino shield */
#define MINIZED_MOTION_SENSOR_ADDRESS_SA0_LO  0x1E /* 0011110b for LIS2DS12 on MiniZed when SA0 is pulled low*/
#define MINIZED_MOTION_SENSOR_ADDRESS_SA0_HI  0x1D /* 0011101b for LIS2DS12 on MiniZed when SA0 is pulled high*/

#define LIS2DS12_ACC_WHO_AM_I         0x43
/************** Device Register  *******************/
#define LIS2DS12_ACC_SENSORHUB_OUT1  	0X06
#define LIS2DS12_ACC_SENSORHUB_OUT2  	0X07
#define LIS2DS12_ACC_SENSORHUB_OUT3  	0X08
#define LIS2DS12_ACC_SENSORHUB_OUT4  	0X09
#define LIS2DS12_ACC_SENSORHUB_OUT5  	0X0A
#define LIS2DS12_ACC_SENSORHUB_OUT6  	0X0B
#define LIS2DS12_ACC_MODULE_8BIT  	0X0C
#define LIS2DS12_ACC_WHO_AM_I_REG  	0X0F
#define LIS2DS12_ACC_CTRL1  	0X20
#define LIS2DS12_ACC_CTRL2  	0X21
#define LIS2DS12_ACC_CTRL3  	0X22
#define LIS2DS12_ACC_CTRL4  	0X23
#define LIS2DS12_ACC_CTRL5  	0X24
#define LIS2DS12_ACC_FIFO_CTRL  	0X25
#define LIS2DS12_ACC_OUT_T  	0X26
#define LIS2DS12_ACC_STATUS  	0X27
#define LIS2DS12_ACC_OUT_X_L  	0X28
#define LIS2DS12_ACC_OUT_X_H  	0X29
#define LIS2DS12_ACC_OUT_Y_L  	0X2A
#define LIS2DS12_ACC_OUT_Y_H  	0X2B
#define LIS2DS12_ACC_OUT_Z_L  	0X2C
#define LIS2DS12_ACC_OUT_Z_H  	0X2D
#define LIS2DS12_ACC_FIFO_THS  	0X2E
#define LIS2DS12_ACC_FIFO_SRC  	0X2F
#define LIS2DS12_ACC_FIFO_SAMPLES  	0X30
#define LIS2DS12_ACC_TAP_6D_THS  	0X31
#define LIS2DS12_ACC_INT_DUR  	0X32
#define LIS2DS12_ACC_WAKE_UP_THS  	0X33
#define LIS2DS12_ACC_WAKE_UP_DUR  	0X34
#define LIS2DS12_ACC_FREE_FALL  	0X35
#define LIS2DS12_ACC_STATUS_DUP  	0X36
#define LIS2DS12_ACC_WAKE_UP_SRC  	0X37
#define LIS2DS12_ACC_TAP_SRC  	0X38
#define LIS2DS12_ACC_6D_SRC  	0X39
#define LIS2DS12_ACC_STEP_C_MINTHS  	0X3A
#define LIS2DS12_ACC_STEP_C_L  	0X3B
#define LIS2DS12_ACC_STEP_C_H  	0X3C
#define LIS2DS12_ACC_FUNC_CK_GATE  	0X3D
#define LIS2DS12_ACC_FUNC_SRC  	0X3E
#define LIS2DS12_ACC_FUNC_CTRL  	0X3F


XIic IicInstance;	/* The instance of the IIC device. */

int ByteCount;
u8 send_byte;
u8 write_data [256];
u8 read_data [256];
u8 i2c_device_addr = MINIZED_MOTION_SENSOR_ADDRESS_SA0_HI; //by default

u8 LIS2DS12_WriteReg(u8 Reg, u8 *Bufp, u16 len)
{
	write_data[0] = Reg;
	for (ByteCount = 1;ByteCount <= len; ByteCount++)
	{
		write_data[ByteCount] = Bufp[ByteCount-1];
	}
	ByteCount = XIic_Send(IIC_BASE_ADDRESS, i2c_device_addr, &write_data[0], (len+1), XIIC_STOP);
	return(ByteCount);
}

u8 LIS2DS12_ReadReg(u8 Reg, u8 *Bufp, u16 len)
{
	write_data[0] = Reg;
	ByteCount = XIic_Send(IIC_BASE_ADDRESS, i2c_device_addr, (u8*)&write_data, 1, XIIC_REPEATED_START);
	ByteCount = XIic_Recv(IIC_BASE_ADDRESS, i2c_device_addr, (u8*)Bufp, len, XIIC_STOP);
	return(ByteCount);
}

void sensor_init(void)
{
	u8 who_am_i;
	i2c_device_addr = MINIZED_MOTION_SENSOR_ADDRESS_SA0_HI; //default
	LIS2DS12_ReadReg(LIS2DS12_ACC_WHO_AM_I_REG, &who_am_i, 1);
	printf("With I2C device address 0x%02x received WhoAmI = 0x%02x\r\n", i2c_device_addr, who_am_i);
	if (who_am_i != LIS2DS12_ACC_WHO_AM_I)
	{
		//maybe the address bit was changed, try the other one:
		i2c_device_addr = MINIZED_MOTION_SENSOR_ADDRESS_SA0_LO;
		LIS2DS12_ReadReg(LIS2DS12_ACC_WHO_AM_I_REG, &who_am_i, 1);
		printf("With I2C device address 0x%02x received WhoAmI = 0x%02x\r\n", i2c_device_addr, who_am_i);
	}
	send_byte = 0x00; //No auto increment
	LIS2DS12_WriteReg(LIS2DS12_ACC_CTRL2, &send_byte, 1);

	//Write 60h in CTRL1	// Turn on the accelerometer.  14-bit mode, ODR = 400 Hz, FS = 2g
	send_byte = 0x60;
	LIS2DS12_WriteReg(LIS2DS12_ACC_CTRL1, &send_byte, 1);
	printf("CTL1 = 0x60 written\r\n");

	//Enable interrupt
	send_byte = 0x01; //Acc data-ready interrupt on INT1
	LIS2DS12_WriteReg(LIS2DS12_ACC_CTRL4, &send_byte, 1);
	printf("CTL4 = 0x01 written\r\n");

#if (0)
	write_data[0] = 0x0F; //WhoAmI
	ByteCount = XIic_Send(IIC_BASE_ADDRESS, MAGNETOMETER_ADDRESS, (u8*)&write_data, 1, XIIC_REPEATED_START);
	ByteCount = XIic_Recv(IIC_BASE_ADDRESS, MAGNETOMETER_ADDRESS, (u8*)&read_data[0], 1, XIIC_STOP);
	printf("Received 0x%02x\r\n",read_data[0]);
	printf("\r\n"); //Empty line
	//for (int n=0;n<1400;n++) //118 ms is too little
	for (int n=0;n<1500;n++) //128 ms
	{
		printf(".");
	};
	printf("\r\n");
#endif
} //sensor_init()

void read_temperature(void)
{
	int temp;
	u8 read_value;

	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_T, &read_value, 1);
	//Temperature is from -40 to +85 deg C.  So 125 range.  0 is 25 deg C.  +1 deg C/LSB.  So if value < 128 temp = 25 + value else temp = 25 - (256-value)
	if (read_value < 128)
	{
		temp = 25 + read_value;
	}
	else
	{
		temp = 25 - (256 - read_value);
	}
	printf("OUT_T register = 0x%02x -> Temperature = %i degrees C",read_value,temp);
	//printf("OUT_T register = 0x%02x -> Temperature = %i degrees C\r\n",read_value,temp);
} //read_temperature()

int u16_2s_complement_to_int(u16 word_to_convert)
{
	u16 result_16bit;
	int result_14bit;
	int sign;

	if (word_to_convert & 0x8000)
	{ //MSB is set, negative number
		//Invert and add 1
		sign = -1;
		result_16bit = (~word_to_convert) + 1;
	}
	else
	{ //Positive number
		//No change
		sign = 1;
		result_16bit = word_to_convert;
	}
	//We are using it in 14-bit mode
	//All data is left-aligned.  So convert 16-bit value to 14-but value
	result_14bit = sign * (int)(result_16bit >> 2);
	return(result_14bit);
} //u16_2s_complement_to_int()

void read_motion(void)
{
	int iacceleration_X;
	int iacceleration_Y;
	int iacceleration_Z;
	u8 read_value_LSB;
	u8 read_value_MSB;
	u16 accel_X;
	u16 accel_Y;
	u16 accel_Z;
	u8 accel_status;
	u8 data_ready;

	data_ready = 0;
	while (!data_ready)
	{ //wait for DRDY
		LIS2DS12_ReadReg(LIS2DS12_ACC_STATUS, &accel_status, 1);
		data_ready = accel_status & 0x01; //bit 0 = DRDY
	} //wait for DRDY


	//Read X:
	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_X_L, &read_value_LSB, 1);
	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_X_H, &read_value_MSB, 1);
	accel_X = (read_value_MSB << 8) + read_value_LSB;
	iacceleration_X = u16_2s_complement_to_int(accel_X);
	//Read Y:
	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_Y_L, &read_value_LSB, 1);
	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_Y_H, &read_value_MSB, 1);
	accel_Y = (read_value_MSB << 8) + read_value_LSB;
	iacceleration_Y = u16_2s_complement_to_int(accel_Y);
	//Read Z:
	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_Z_L, &read_value_LSB, 1);
	LIS2DS12_ReadReg(LIS2DS12_ACC_OUT_Z_H, &read_value_MSB, 1);
	accel_Z = (read_value_MSB << 8) + read_value_LSB;
	iacceleration_Z = u16_2s_complement_to_int(accel_Z);

	printf("  Acceleration = X: %+5d, Y: %+5d, Z: %+5d\r\n",iacceleration_X, iacceleration_Y, iacceleration_Z);
} //read_motion()

int main(void)
{
	sensor_init();

	while (1)
	{
		read_temperature();
		read_motion();
		//printf("\r\n"); //Blank line
		sleep(1); //seconds
	}

	return 0;
} //main()
