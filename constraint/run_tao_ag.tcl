set_device -family {PolarFireSoC} -die {MPFS250T_ES} -speed {STD}
read_verilog -mode system_verilog -lib COREAPB3_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vlog/core/coreapb3_muxptob3.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vlog/core/coreapb3_iaddr_reg.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vlog/core/coreapb3.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/APB3/APB3.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/ResetSycnc.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/MasterAddressDecoder.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/DependenceChecker.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/BitScan0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/TransactionController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/MasterControl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/RoundRobinArb.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/TargetMuxController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/AddressController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/Revision.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/DERR_Slave.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/DualPort_FF_SyncWr_SyncRd.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/DualPort_Ram_SyncWr_SyncRd.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/RdFifoDualPort.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/ReadDataMux.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/RequestQual.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/ReadDataController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/RDataController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/SlaveDataMuxController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/RespController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/FifoDualPort.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/WriteDataMux.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/WDataController.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4CrossBar/Axi4CrossBar.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/AHBL_Ctrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/AXI4_Read_Ctrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/AXI4_Write_Ctrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/AHB_SM.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/MstrAHBtoAXI4Converter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/Bin2Gray.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/CDC_grayCodeCounter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/CDC_rdCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/CDC_wrCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/RAM_BLOCK.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/CDC_FIFO.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/MstrClockDomainCrossing.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_CmdFifoWriteCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/Hold_Reg_Ctrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_Hold_Reg_Rd.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_preCalcCmdFifoWrCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_widthConvrd.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/FIFO_CTRL.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/FIFO.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/byte2bit.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_readWidthConv.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_Hold_Reg_Wr.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_widthConvwr.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_brespCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_DownConv_writeWidthConv.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DownConverter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_AChannel.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_BChannel.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_RChannel_SlvRid_Arb.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_RChan_Ctrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_preCalcRChan_Ctrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/FIFO_downsizing.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_RChannel.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_WChan_Hold_Reg.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_WChan_ReadDataFifoCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_Wchan_WriteDataFifoCtrl.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/FIFO_upsizing.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_WChannel.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/DWC_UpConv_preCalcAChannel.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/UpConverter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/MstrDataWidthConv.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/MstrProtocolConverter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/RegSliceFull.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/RegisterSlice.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/MasterConvertor.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvClockDomainCrossing.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvDataWidthConverter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvAxi4ProtConvRead.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvAxi4ProtConvWrite.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvAxi4ProtocolConv.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvAxi4ProtConvAXI4ID.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlvProtocolConverter.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/Axi4Convertors/SlaveConvertor.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4INTERCONNECT/2.8.103/rtl/vlog/core/CoreAxi4Interconnect.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/AXI4INTERCONNECT/AXI4INTERCONNECT.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/CORERESET/CORERESET_0/core/corereset_pf.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/CORERESET/CORERESET.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_axi4_lite_slave_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_ctrl_if_mux_cdc.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_axi4_stream_slave_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_control_registers.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_int_controller_fifo.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_int_x_ctrl.v}
 add_include_path  {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0}
 add_include_path  {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_int_controller.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_axi4_master_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_cache.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_round_robin_arbiter_w_ack.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_dma_start_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_int_status_mux.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_round_robin_arbiter.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_fixed_priority_arbiter.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_int_ext_dscrptr_cache.v}
 add_include_path  {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0}
 add_include_path  {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_dma_arbiter.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_dscrptr_src_mux.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_trans_ack.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_wr_tran_queue.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_rd_tran_queue.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_wr_tran_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_int_error_ctrl_fsm.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_rd_tran_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_dma_tran_ctrl.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_ext_dscrptr_fetch_fsm.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_dma_controller.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_ram_1k20_wrapper.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/Actel/DirectCore/COREAXI4DMACONTROLLER/2.0.100/rtl/vlog/core_obfuscated/coreaxi4dmacontroller_buffer_descriptors.v}
read_verilog -mode system_verilog -lib COREAXI4DMACONTROLLER_LIB {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER_0/rtl/vlog/core_obfuscated/coreaxi4dmacontroller.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/DMACONTROLLER/DMACONTROLLER.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/GPIO/GPIO_0/rtl/vlog/core/coregpio.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/GPIO/GPIO.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/ICICLE_MSS/ICICLE_MSS.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/INIT_MONITOR/INIT_MONITOR_0/INIT_MONITOR_INIT_MONITOR_0_PFSOC_INIT_MONITOR.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/INIT_MONITOR/INIT_MONITOR.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/LSRAM/PF_TPSRAM_AHB_AXI_0/LSRAM_PF_TPSRAM_AHB_AXI_0_PF_TPSRAM.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/LSRAM/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM_MAINCTRL_ECC.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/LSRAM/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM_MAINCTRL.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/LSRAM/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM_SLVIF.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/LSRAM/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/LSRAM/LSRAM.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_AXI_0/PCIE_AXI_0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_AXI_1/PCIE_AXI_1.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_CLK_DIV_C0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_PF_CLK_DIV_C0_0_PF_CLK_DIV.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_CLK_DIV_C0/PF_CLK_DIV_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_DRI_C0/PF_DRI_C0_0/PF_DRI_C0_PF_DRI_C0_0_PF_DRI.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_DRI_C0/PF_DRI_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_NGMUX_C0/PF_NGMUX_C0_0/PF_NGMUX_C0_PF_NGMUX_C0_0_PF_NGMUX.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_NGMUX_C0/PF_NGMUX_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_OSC_C0/PF_OSC_C0_0/PF_OSC_C0_PF_OSC_C0_0_PF_OSC.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_OSC_C0/PF_OSC_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_PCIE_C0/PF_PCIE_C0_0/PF_PCIE_C0_PF_PCIE_C0_0_PF_PCIE.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_PCIE_C0/PF_PCIE_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_TX_PLL_C0/PF_TX_PLL_C0_0/PF_TX_PLL_C0_PF_TX_PLL_C0_0_PF_TX_PLL.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_TX_PLL_C0/PF_TX_PLL_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_XCVR_REF_CLK_C0/PF_XCVR_REF_CLK_C0_0/PF_XCVR_REF_CLK_C0_PF_XCVR_REF_CLK_C0_0_PF_XCVR_REF_CLK.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_XCVR_REF_CLK_C0/PF_XCVR_REF_CLK_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_BASE/PCIE_BASE.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/COREAXITOAXICONNECT_C0/COREAXITOAXICONNECT_C0_0/rtl/vlog/core/COREAXITOAXICONNECT.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/COREAXITOAXICONNECT_C0/COREAXITOAXICONNECT_C0.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/table.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/aes_256.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/round.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/simple_dpram_sclk.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/fifo.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/shift_reg.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/aes256_fifo.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/word_block.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/key_ram.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/crypto-accel.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/crypto_mmio/crypto_mmio.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/hdl/SDIO_register.v}
read_verilog -mode system_verilog {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/MPFS_ICICLE_KIT_BASE_DESIGN/MPFS_ICICLE_KIT_BASE_DESIGN.v}
set_top_level {MPFS_ICICLE_KIT_BASE_DESIGN}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_CLK_DIV_C0/PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_PF_CLK_DIV_C0_0_PF_CLK_DIV.sdc}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_TX_PLL_C0/PF_TX_PLL_C0_0/PF_TX_PLL_C0_PF_TX_PLL_C0_0_PF_TX_PLL.sdc}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_AXI_0/PCIE_AXI_0_0/PCIE_AXI_0.sdc}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PF_PCIE_C0/PF_PCIE_C0_0/PF_PCIE_C0_PF_PCIE_C0_0_PF_PCIE.sdc}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/PCIE_AXI_1/PCIE_AXI_1_0/PCIE_AXI_1.sdc}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/ICICLE_MSS/ICICLE_MSS.sdc}
read_sdc -component {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/component/work/AXI4INTERCONNECT/AXI4INTERCONNECT_0/AXI4INTERCONNECT.sdc}
derive_constraints
write_sdc {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/constraint/MPFS_ICICLE_KIT_BASE_DESIGN_derived_constraints.sdc}
write_pdc {/home/gui/Dev/icicle-kit-reference-design/MPFS_ICICLE_eMMC/constraint/fp/MPFS_ICICLE_KIT_BASE_DESIGN_derived_constraints.pdc}
