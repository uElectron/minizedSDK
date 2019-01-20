# ----------------------------------------------------------------------------  
#       __ __
#      / / \ \
#     / /   \ \
#    / /     \ \ 
#   / / AVNET \ \          www.minized.org
#
# ----------------------------------------------------------------------------
# 
#  Created With Avnet Constraints Generator V0.8.0 
#     Date: Thursday, May 04, 2017 
#     Time: 11:03:09 AM 
# 
#  This design is the property of Avnet.  Publication of this
#  design is not authorized without written consent from Avnet.
#  
#  Please direct any questions to:
#     MiniZed Community Forums
#     http://minized.org
# 
#  Disclaimer:
#     Avnet, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". Avnet, Inc assumes no responsibility for
#     any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. Avnet, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2017 Avnet, Inc.
#                              All rights reserved.
# 
# ----------------------------------------------------------------------------
# 
#  Notes: 
# 
#  08 Jun 2017 -- Initial release
#  13 Jun 2017 -- Adding LED and Switch GPIO, which are shared with ARDUINO_A[3:5]
#
#     IO standards for Bank 34, Bank 35 Vcco supply are fixed at 3.3V.  
# 
#     Net names are not allowed to contain hyphen characters '-' since this
#     is not a legal VHDL87 or Verilog character within an identifier.  
#     HDL net names are adjusted to contain no hyphen characters '-' but 
#     rather use underscore '_' characters.  Comment net name with the hyphen 
#     characters will remain in place since these are intended to match the 
#     schematic net names in order to better enable schematic search.
#
# ----------------------------------------------------------------------------
  
# ----------------------------------------------------------------------------
# Arduino Expansion using Samtec Connectors
# ---------------------------------------------------------------------------- 
# Bank 35
set_property PACKAGE_PIN F14 [get_ports {ARDUINO_A0     }];  # "F14.ARDUINO_A0"
set_property PACKAGE_PIN F13 [get_ports {ARDUINO_A1     }];  # "F13.ARDUINO_A1"
set_property PACKAGE_PIN F12 [get_ports {ARDUINO_A2     }];  # "F12.ARDUINO_A2"
# Note that ARDUINO_A[3:5] are shared with LEDs and a switch. Therefore
# these next three pin locations get repeated. Depending on which features
# you use, one or the other constraints should be commented out.
set_property PACKAGE_PIN E13 [get_ports {ARDUINO_A3     }];  # "E13.ARDUINO_A3"
set_property PACKAGE_PIN E12 [get_ports {ARDUINO_A4     }];  # "E12.ARDUINO_A4"
set_property PACKAGE_PIN E11 [get_ports {ARDUINO_A5     }];  # "E11.ARDUINO_A5"
# Bank 34
set_property PACKAGE_PIN R8  [get_ports {ARDUINO_IO0    }];  # "R8.ARDUINO_IO0"
set_property PACKAGE_PIN P8  [get_ports {ARDUINO_IO1    }];  # "P8.ARDUINO_IO1"
set_property PACKAGE_PIN P9  [get_ports {ARDUINO_IO2    }];  # "P9.ARDUINO_IO2"
set_property PACKAGE_PIN R7  [get_ports {ARDUINO_IO3    }];  # "R7.ARDUINO_IO3"
set_property PACKAGE_PIN N7  [get_ports {ARDUINO_IO4    }];  # "N7.ARDUINO_IO4"
set_property PACKAGE_PIN R10 [get_ports {ARDUINO_IO5    }];  # "R10.ARDUINO_IO5"
set_property PACKAGE_PIN P10 [get_ports {ARDUINO_IO6    }];  # "P10.ARDUINO_IO6"
set_property PACKAGE_PIN N8  [get_ports {ARDUINO_IO7    }];  # "N8.ARDUINO_IO7"
set_property PACKAGE_PIN M9  [get_ports {ARDUINO_IO8    }];  # "M9.ARDUINO_IO8"
set_property PACKAGE_PIN N9  [get_ports {ARDUINO_IO9    }];  # "N9.ARDUINO_IO9"
set_property PACKAGE_PIN M10 [get_ports {ARDUINO_IO10   }];  # "M10.ARDUINO_IO10"
set_property PACKAGE_PIN M11 [get_ports {ARDUINO_IO11   }];  # "M11.ARDUINO_IO11"
set_property PACKAGE_PIN R11 [get_ports {ARDUINO_IO12   }];  # "R11.ARDUINO_IO12"
set_property PACKAGE_PIN P11 [get_ports {ARDUINO_IO13   }];  # "P11.ARDUINO_IO13"

# ----------------------------------------------------------------------------
# GPIO
# ---------------------------------------------------------------------------- 
# Bank 35
# Note that the LEDs and switch are shared with ARDUINO_A[3:5]. Therefore
# these next three pin locations get repeated. Depending on which features
# you use, one or the other constraints should be commented out.
set_property PACKAGE_PIN E13 [get_ports {PL_LED_G       }];  # "E13.ARDUINO_A3"
set_property PACKAGE_PIN E12 [get_ports {PL_LED_R       }];  # "E12.ARDUINO_A4"
set_property PACKAGE_PIN E11 [get_ports {PL_SW          }];  # "E11.ARDUINO_A5"

# ----------------------------------------------------------------------------
# ST Micro MP34DT05 Microphone Input
# ---------------------------------------------------------------------------- 
# Bank 34
set_property PACKAGE_PIN L12 [get_ports {AUDIO_CLK      }];  # "L12.AUDIO_CLK"
set_property PACKAGE_PIN M12 [get_ports {AUDIO_DO       }];  # "M12.AUDIO_DO"

# ----------------------------------------------------------------------------
# Murata 1DX Wi-Fi and Bluetooth Module
# ---------------------------------------------------------------------------- 
# Bank 34 -- Bluetooth UART
set_property PACKAGE_PIN G12 [get_ports {BT_CTS_IN_N    }];  # "G12.BT_CTS_IN_N"
set_property PACKAGE_PIN H14 [get_ports {BT_HOST_WAKE   }];  # "H14.BT_HOST_WAKE"
set_property PACKAGE_PIN H13 [get_ports {BT_REG_ON      }];  # "H13.BT_REG_ON"
set_property PACKAGE_PIN H12 [get_ports {BT_RTS_OUT_N   }];  # "H12.BT_RTS_OUT_N"
set_property PACKAGE_PIN G11 [get_ports {BT_RXD_IN      }];  # "G11.BT_RXD_IN"
set_property PACKAGE_PIN G14 [get_ports {BT_TXD_OUT     }];  # "G14.BT_TXD_OUT"
# Bank 34 -- Wi-Fi SDIO
set_property PACKAGE_PIN K12 [get_ports {WL_HOST_WAKE   }];  # "K12.WL_HOST_WAKE"
set_property PACKAGE_PIN K11 [get_ports {WL_REG_ON      }];  # "K11.WL_REG_ON"
set_property PACKAGE_PIN J15 [get_ports {WL_SDIO_CLK_R  }];  # "J15.WL_SDIO_CLK_R"
set_property PACKAGE_PIN J11 [get_ports {WL_SDIO_CMD    }];  # "J11.WL_SDIO_CMD"
set_property PACKAGE_PIN J13 [get_ports {WL_SDIO_D0     }];  # "J13.WL_SDIO_D0"
set_property PACKAGE_PIN H11 [get_ports {WL_SDIO_D1     }];  # "H11.WL_SDIO_D1"
set_property PACKAGE_PIN K15 [get_ports {WL_SDIO_D2     }];  # "K15.WL_SDIO_D2"
set_property PACKAGE_PIN J14 [get_ports {WL_SDIO_D3     }];  # "J14.WL_SDIO_D3"

# ----------------------------------------------------------------------------
# I2C bus -- ST Micro LIS2DS12TR Accelerometer and temperature
#            Dialog DA9062
# ---------------------------------------------------------------------------- 
# Bank 35
set_property PACKAGE_PIN G15 [get_ports {I2C_SCL        }];  # "G15.I2C_SCL"
set_property PACKAGE_PIN F15 [get_ports {I2C_SDA        }];  # "F15.I2C_SDA"

# ----------------------------------------------------------------------------
# PL Pmod #1 using Samtec Connectors
# ---------------------------------------------------------------------------- 
# Bank 34
set_property PACKAGE_PIN M15 [get_ports {PMOD1_D0_N     }];  # "M15.PMOD1_D0_N"
set_property PACKAGE_PIN L15 [get_ports {PMOD1_D0_P     }];  # "L15.PMOD1_D0_P"
set_property PACKAGE_PIN M14 [get_ports {PMOD1_D1_N     }];  # "M14.PMOD1_D1_N"
set_property PACKAGE_PIN L14 [get_ports {PMOD1_D1_P     }];  # "L14.PMOD1_D1_P"
set_property PACKAGE_PIN L13 [get_ports {PMOD1_D2_N     }];  # "L13.PMOD1_D2_N"
set_property PACKAGE_PIN K13 [get_ports {PMOD1_D2_P     }];  # "K13.PMOD1_D2_P"
set_property PACKAGE_PIN N14 [get_ports {PMOD1_D3_N     }];  # "N14.PMOD1_D3_N"
set_property PACKAGE_PIN N13 [get_ports {PMOD1_D3_P     }];  # "N13.PMOD1_D3_P"

# ----------------------------------------------------------------------------
# PL Pmod #2 using Samtec Connectors
# ---------------------------------------------------------------------------- 
# Bank 34
set_property PACKAGE_PIN P14 [get_ports {PMOD2_D0_N     }];  # "P14.PMOD2_D0_N"
set_property PACKAGE_PIN P13 [get_ports {PMOD2_D0_P     }];  # "P13.PMOD2_D0_P"
set_property PACKAGE_PIN N12 [get_ports {PMOD2_D1_N     }];  # "N12.PMOD2_D1_N"
set_property PACKAGE_PIN N11 [get_ports {PMOD2_D1_P     }];  # "N11.PMOD2_D1_P"
set_property PACKAGE_PIN R15 [get_ports {PMOD2_D2_N     }];  # "R15.PMOD2_D2_N"
set_property PACKAGE_PIN P15 [get_ports {PMOD2_D2_P     }];  # "P15.PMOD2_D2_P"
set_property PACKAGE_PIN R13 [get_ports {PMOD2_D3_N     }];  # "R13.PMOD2_D3_N"
set_property PACKAGE_PIN R12 [get_ports {PMOD2_D3_P     }];  # "R12.PMOD2_D3_P"

# ----------------------------------------------------------------------------
# IOSTANDARD Constraints
#
# Note that these IOSTANDARD constraints are applied to all IOs currently
# assigned within an I/O bank.  If these IOSTANDARD constraints are 
# evaluated prior to other PACKAGE_PIN constraints being applied, then 
# the IOSTANDARD specified will likely not be applied properly to those 
# pins.  Therefore, bank wide IOSTANDARD constraints should be placed 
# within the XDC file in a location that is evaluated AFTER all 
# PACKAGE_PIN constraints within the target bank have been evaluated.
# ---------------------------------------------------------------------------- 

# Set the bank voltage for IO Bank 34 to 3.3V
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];

# Set the bank voltage for IO Bank 35 to 3.3V
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];

# ----------------------------------------------------------------------------
# PS MIO - 
# For reference only - these are assigned in the FSBL
# Pin Location and IOSTANDARD constraints are not necessary
# ---------------------------------------------------------------------------- 
# Micron DDR3L
#     set_property PACKAGE_PIN P1  [get_ports {D3L_A0         }];  # "P1.D3L_A0"
#     set_property PACKAGE_PIN N1  [get_ports {D3L_A1         }];  # "N1.D3L_A1"
#     set_property PACKAGE_PIN J1  [get_ports {D3L_A10        }];  # "J1.D3L_A10"
#     set_property PACKAGE_PIN L2  [get_ports {D3L_A11        }];  # "L2.D3L_A11"
#     set_property PACKAGE_PIN M2  [get_ports {D3L_A12        }];  # "M2.D3L_A12"
#     set_property PACKAGE_PIN K2  [get_ports {D3L_A13        }];  # "K2.D3L_A13"
#     set_property PACKAGE_PIN K1  [get_ports {D3L_A14        }];  # "K1.D3L_A14"
#     set_property PACKAGE_PIN M1  [get_ports {D3L_A2         }];  # "M1.D3L_A2"
#     set_property PACKAGE_PIN M4  [get_ports {D3L_A3         }];  # "M4.D3L_A3"
#     set_property PACKAGE_PIN P3  [get_ports {D3L_A4         }];  # "P3.D3L_A4"
#     set_property PACKAGE_PIN P4  [get_ports {D3L_A5         }];  # "P4.D3L_A5"
#     set_property PACKAGE_PIN P5  [get_ports {D3L_A6         }];  # "P5.D3L_A6"
#     set_property PACKAGE_PIN M5  [get_ports {D3L_A7         }];  # "M5.D3L_A7"
#     set_property PACKAGE_PIN P6  [get_ports {D3L_A8         }];  # "P6.D3L_A8"
#     set_property PACKAGE_PIN N4  [get_ports {D3L_A9         }];  # "N4.D3L_A9"
#     set_property PACKAGE_PIN M6  [get_ports {D3L_BA0        }];  # "M6.D3L_BA0"
#     set_property PACKAGE_PIN R1  [get_ports {D3L_BA1        }];  # "R1.D3L_BA1"
#     set_property PACKAGE_PIN N6  [get_ports {D3L_BA2        }];  # "N6.D3L_BA2"
#     set_property PACKAGE_PIN R5  [get_ports {D3L_CAS_N      }];  # "R5.D3L_CAS_N"
#     set_property PACKAGE_PIN N2  [get_ports {D3L_CK_N       }];  # "N2.D3L_CK_N"
#     set_property PACKAGE_PIN N3  [get_ports {D3L_CK_P       }];  # "N3.D3L_CK_P"
#     set_property PACKAGE_PIN L3  [get_ports {D3L_CKE        }];  # "L3.D3L_CKE"
#     set_property PACKAGE_PIN R2  [get_ports {D3L_CS_N       }];  # "R2.D3L_CS_N"
#     set_property PACKAGE_PIN D4  [get_ports {D3L_DQ0        }];  # "D4.D3L_DQ0"
#     set_property PACKAGE_PIN A2  [get_ports {D3L_DQ1        }];  # "A2.D3L_DQ1"
#     set_property PACKAGE_PIN E2  [get_ports {D3L_DQ10       }];  # "E2.D3L_DQ10"
#     set_property PACKAGE_PIN E3  [get_ports {D3L_DQ11       }];  # "E3.D3L_DQ11"
#     set_property PACKAGE_PIN F3  [get_ports {D3L_DQ12       }];  # "F3.D3L_DQ12"
#     set_property PACKAGE_PIN G1  [get_ports {D3L_DQ13       }];  # "G1.D3L_DQ13"
#     set_property PACKAGE_PIN H1  [get_ports {D3L_DQ14       }];  # "H1.D3L_DQ14"
#     set_property PACKAGE_PIN H2  [get_ports {D3L_DQ15       }];  # "H2.D3L_DQ15"
#     set_property PACKAGE_PIN C4  [get_ports {D3L_DQ2        }];  # "C4.D3L_DQ2"
#     set_property PACKAGE_PIN C1  [get_ports {D3L_DQ3        }];  # "C1.D3L_DQ3"
#     set_property PACKAGE_PIN B4  [get_ports {D3L_DQ4        }];  # "B4.D3L_DQ4"
#     set_property PACKAGE_PIN A4  [get_ports {D3L_DQ5        }];  # "A4.D3L_DQ5"
#     set_property PACKAGE_PIN C3  [get_ports {D3L_DQ6        }];  # "C3.D3L_DQ6"
#     set_property PACKAGE_PIN A3  [get_ports {D3L_DQ7        }];  # "A3.D3L_DQ7"
#     set_property PACKAGE_PIN E1  [get_ports {D3L_DQ8        }];  # "E1.D3L_DQ8"
#     set_property PACKAGE_PIN D1  [get_ports {D3L_DQ9        }];  # "D1.D3L_DQ9"
#     set_property PACKAGE_PIN B1  [get_ports {D3L_LDM        }];  # "B1.D3L_LDM"
#     set_property PACKAGE_PIN B2  [get_ports {D3L_LDQS_N     }];  # "B2.D3L_LDQS_N"
#     set_property PACKAGE_PIN C2  [get_ports {D3L_LDQS_P     }];  # "C2.D3L_LDQS_P"
#     set_property PACKAGE_PIN K3  [get_ports {D3L_ODT        }];  # "K3.D3L_ODT"
#     set_property PACKAGE_PIN R6  [get_ports {D3L_RAS_N      }];  # "R6.D3L_RAS_N"
#     set_property PACKAGE_PIN L4  [get_ports {D3L_RST_N      }];  # "L4.D3L_RST_N"
#     set_property PACKAGE_PIN D3  [get_ports {D3L_UDM        }];  # "D3.D3L_UDM"
#     set_property PACKAGE_PIN F2  [get_ports {D3L_UDQS_N     }];  # "F2.D3L_UDQS_N"
#     set_property PACKAGE_PIN G2  [get_ports {D3L_UDQS_P     }];  # "G2.D3L_UDQS_P"
#     set_property PACKAGE_PIN R3  [get_ports {D3L_WE_N       }];  # "R3.D3L_WE_N"
# Micron eMMC
#     set_property PACKAGE_PIN B7  [get_ports {EMMC_CLK_R     }];  # "B7.EMMC_CLK_R"
#     set_property PACKAGE_PIN B10 [get_ports {EMMC_CMD       }];  # "B10.EMMC_CMD"
#     set_property PACKAGE_PIN D6  [get_ports {EMMC_D0        }];  # "D6.EMMC_D0"
#     set_property PACKAGE_PIN C6  [get_ports {EMMC_D1        }];  # "C6.EMMC_D1"
#     set_property PACKAGE_PIN B9  [get_ports {EMMC_D2        }];  # "B9.EMMC_D2"
#     set_property PACKAGE_PIN D10 [get_ports {EMMC_D3        }];  # "D10.EMMC_D3"
# USB-UART
#     set_property PACKAGE_PIN D13 [get_ports {FPGA_RXD_IN    }];  # "D13.FPGA_RXD_IN"
#     set_property PACKAGE_PIN B12 [get_ports {FPGA_TXD_OUT   }];  # "B12.FPGA_TXD_OUT"
# Spare MIO
#     set_property PACKAGE_PIN B6  [get_ports {MIO8           }];  # "B6.MIO8"
# Reset
#     set_property PACKAGE_PIN B5  [get_ports {PS_2_AS_RST    }];  # "B5.PS_2_AS_RST"
# User I/O
#     set_property PACKAGE_PIN C13 [get_ports {PS_LED_G       }];  # "C13.PS_LED_G"
#     set_property PACKAGE_PIN A12 [get_ports {PS_LED_R       }];  # "A12.PS_LED_R"
#     set_property PACKAGE_PIN D8  [get_ports {PS_PB          }];  # "D8.PS_PB"
# Micron QSPI
#     set_property PACKAGE_PIN A10 [get_ports {QSPI_CLK_MIO6_R}];  # "A10.QSPI_CLK-MIO6_R"
#     set_property PACKAGE_PIN A5  [get_ports {QSPI_CS_N      }];  # "A5.QSPI_CS_N"
#     set_property PACKAGE_PIN A8  [get_ports {QSPI_D0_MIO2   }];  # "A8.QSPI_D0-MIO2"
#     set_property PACKAGE_PIN A7  [get_ports {QSPI_D1_MIO3   }];  # "A7.QSPI_D1-MIO3"
#     set_property PACKAGE_PIN C8  [get_ports {QSPI_D2_MIO4   }];  # "C8.QSPI_D2-MIO4"
#     set_property PACKAGE_PIN A9  [get_ports {QSPI_D3_MIO5   }];  # "A9.QSPI_D3-MIO5"
# USB 2.0 Host with Microchip USB3320
#     set_property PACKAGE_PIN B14 [get_ports {USB_CLK        }];  # "B14.USB_CLK"
#     set_property PACKAGE_PIN E15 [get_ports {USB_D0         }];  # "E15.USB_D0"
#     set_property PACKAGE_PIN C11 [get_ports {USB_D1         }];  # "C11.USB_D1"
#     set_property PACKAGE_PIN D15 [get_ports {USB_D2         }];  # "D15.USB_D2"
#     set_property PACKAGE_PIN A14 [get_ports {USB_D3         }];  # "A14.USB_D3"
#     set_property PACKAGE_PIN A15 [get_ports {USB_D4         }];  # "A15.USB_D4"
#     set_property PACKAGE_PIN C14 [get_ports {USB_D5         }];  # "C14.USB_D5"
#     set_property PACKAGE_PIN A13 [get_ports {USB_D6         }];  # "A13.USB_D6"
#     set_property PACKAGE_PIN D14 [get_ports {USB_D7         }];  # "D14.USB_D7"
#     set_property PACKAGE_PIN D11 [get_ports {USB_DIR        }];  # "D11.USB_DIR"
#     set_property PACKAGE_PIN C12 [get_ports {USB_NXT        }];  # "C12.USB_NXT"
#     set_property PACKAGE_PIN D9  [get_ports {USB_RST_N_MIO7 }];  # "D9.USB_RST_N-MIO7"
#     set_property PACKAGE_PIN B15 [get_ports {USB_STP        }];  # "B15.USB_STP"