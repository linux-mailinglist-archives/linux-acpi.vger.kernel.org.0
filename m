Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE61355E72
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbhDFWFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243439AbhDFWFa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:30 -0400
IronPort-SDR: vgqaEP60PbgeUAz6hy/pu4C4AJLV5+mQAXtegfs68euAhBiZ8Z6+CIEosZKhplV/zd4u5hvHm0
 5zTO8aaz8XwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640469"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640469"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: RxNZ6rw92EA8OJ9ripVByddzwhOAPQkFvy5AdEFYDSWpyUPSLjaN7AmwmsPXSu3RrtfFJoMQU1
 cxyCdE7IRIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581762"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:09 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 16/22] ACPICA: ACPI 6.4: add CSI2Bus resource template
Date:   Tue,  6 Apr 2021 14:30:22 -0700
Message-Id: <20210406213028.718796-17-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This commit the result of squashing the following:
ACPICA commit 21a316fdaa46b3fb245a1920f3829cb05d6ced6e
ACPICA commit f5506fc7dad08c2a25ef52cf836c2d67385a612c

Link: https://github.com/acpica/acpica/commit/21a316fd
Link: https://github.com/acpica/acpica/commit/f5506fc7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acresrc.h     |  4 ++
 drivers/acpi/acpica/acutils.h     |  1 +
 drivers/acpi/acpica/amlresrc.h    | 19 +++++++-
 drivers/acpi/acpica/rscalc.c      |  4 +-
 drivers/acpi/acpica/rsdump.c      |  8 ++++
 drivers/acpi/acpica/rsdumpinfo.c  | 26 +++++++++++
 drivers/acpi/acpica/rsinfo.c      |  6 ++-
 drivers/acpi/acpica/rslist.c      |  9 +++-
 drivers/acpi/acpica/rsmisc.c      | 19 ++++++++
 drivers/acpi/acpica/rsserial.c    | 75 +++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utresdecode.c | 10 ++++-
 drivers/acpi/acpica/utresrc.c     |  1 +
 include/acpi/acrestyp.h           |  9 +++-
 13 files changed, 183 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 0cb975a3e01d..37c47e185fd4 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -46,6 +46,7 @@ typedef enum {
 	ACPI_RSC_1BITFLAG,
 	ACPI_RSC_2BITFLAG,
 	ACPI_RSC_3BITFLAG,
+	ACPI_RSC_6BITFLAG,
 	ACPI_RSC_ADDRESS,
 	ACPI_RSC_BITMASK,
 	ACPI_RSC_BITMASK16,
@@ -102,6 +103,7 @@ typedef enum {
 	ACPI_RSD_1BITFLAG,
 	ACPI_RSD_2BITFLAG,
 	ACPI_RSD_3BITFLAG,
+	ACPI_RSD_6BITFLAG,
 	ACPI_RSD_ADDRESS,
 	ACPI_RSD_DWORDLIST,
 	ACPI_RSD_LITERAL,
@@ -295,6 +297,7 @@ extern struct acpi_rsconvert_info acpi_rs_convert_address64[];
 extern struct acpi_rsconvert_info acpi_rs_convert_ext_address64[];
 extern struct acpi_rsconvert_info acpi_rs_convert_gpio[];
 extern struct acpi_rsconvert_info acpi_rs_convert_fixed_dma[];
+extern struct acpi_rsconvert_info acpi_rs_convert_csi2_serial_bus[];
 extern struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[];
 extern struct acpi_rsconvert_info acpi_rs_convert_spi_serial_bus[];
 extern struct acpi_rsconvert_info acpi_rs_convert_uart_serial_bus[];
@@ -349,6 +352,7 @@ extern struct acpi_rsdump_info acpi_rs_dump_gpio[];
 extern struct acpi_rsdump_info acpi_rs_dump_pin_function[];
 extern struct acpi_rsdump_info acpi_rs_dump_fixed_dma[];
 extern struct acpi_rsdump_info acpi_rs_dump_common_serial_bus[];
+extern struct acpi_rsdump_info acpi_rs_dump_csi2_serial_bus[];
 extern struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[];
 extern struct acpi_rsdump_info acpi_rs_dump_spi_serial_bus[];
 extern struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[];
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index be6de7149e67..bccae0d3db75 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -28,6 +28,7 @@ extern const char *acpi_gbl_max_decode[];
 extern const char *acpi_gbl_mem_decode[];
 extern const char *acpi_gbl_min_decode[];
 extern const char *acpi_gbl_mtp_decode[];
+extern const char *acpi_gbl_phy_decode[];
 extern const char *acpi_gbl_rng_decode[];
 extern const char *acpi_gbl_rw_decode[];
 extern const char *acpi_gbl_shr_decode[];
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index a9d91a3c2994..b98123210281 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -40,6 +40,7 @@
 #define ACPI_RESTAG_IORESTRICTION               "_IOR"
 #define ACPI_RESTAG_LENGTH                      "_LEN"
 #define ACPI_RESTAG_LINE                        "_LIN"
+#define ACPI_RESTAG_LOCALPORT                   "_PRT"
 #define ACPI_RESTAG_MEMATTRIBUTES               "_MTP"	/* Memory(0), Reserved(1), ACPI(2), NVS(3) */
 #define ACPI_RESTAG_MEMTYPE                     "_MEM"	/* non_cache(0), Cacheable(1) Cache+combine(2), Cache+prefetch(3) */
 #define ACPI_RESTAG_MAXADDR                     "_MAX"
@@ -49,6 +50,7 @@
 #define ACPI_RESTAG_MODE                        "_MOD"
 #define ACPI_RESTAG_PARITY                      "_PAR"
 #define ACPI_RESTAG_PHASE                       "_PHA"
+#define ACPI_RESTAG_PHYTYPE                     "_PHY"
 #define ACPI_RESTAG_PIN                         "_PIN"
 #define ACPI_RESTAG_PINCONFIG                   "_PPI"
 #define ACPI_RESTAG_PINCONFIG_TYPE              "_TYP"
@@ -316,12 +318,26 @@ struct aml_resource_gpio {
 #define AML_RESOURCE_I2C_SERIALBUSTYPE          1
 #define AML_RESOURCE_SPI_SERIALBUSTYPE          2
 #define AML_RESOURCE_UART_SERIALBUSTYPE         3
-#define AML_RESOURCE_MAX_SERIALBUSTYPE          3
+#define AML_RESOURCE_CSI2_SERIALBUSTYPE         4
+#define AML_RESOURCE_MAX_SERIALBUSTYPE          4
 #define AML_RESOURCE_VENDOR_SERIALBUSTYPE       192	/* Vendor defined is 0xC0-0xFF (NOT SUPPORTED) */
 
 struct aml_resource_common_serialbus {
 AML_RESOURCE_LARGE_HEADER_COMMON AML_RESOURCE_SERIAL_COMMON};
 
+struct aml_resource_csi2_serialbus {
+	AML_RESOURCE_LARGE_HEADER_COMMON AML_RESOURCE_SERIAL_COMMON
+	    /*
+	     * Optional fields follow immediately:
+	     * 1) Vendor Data bytes
+	     * 2) Resource Source String
+	     */
+};
+
+#define AML_RESOURCE_CSI2_REVISION              1	/* ACPI 6.4 */
+#define AML_RESOURCE_CSI2_TYPE_REVISION         1	/* ACPI 6.4 */
+#define AML_RESOURCE_CSI2_MIN_DATA_LEN          0	/* ACPI 6.4 */
+
 struct aml_resource_i2c_serialbus {
 	AML_RESOURCE_LARGE_HEADER_COMMON
 	    AML_RESOURCE_SERIAL_COMMON u32 connection_speed;
@@ -510,6 +526,7 @@ union aml_resource {
 	struct aml_resource_i2c_serialbus i2c_serial_bus;
 	struct aml_resource_spi_serialbus spi_serial_bus;
 	struct aml_resource_uart_serialbus uart_serial_bus;
+	struct aml_resource_csi2_serialbus csi2_serial_bus;
 	struct aml_resource_common_serialbus common_serial_bus;
 	struct aml_resource_pin_function pin_function;
 	struct aml_resource_pin_config pin_config;
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index fcf129d27baa..90583db459a2 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -677,10 +677,10 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 		*size_needed += buffer_size;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_RESOURCES,
-				  "Type %.2X, AmlLength %.2X InternalLength %.2X\n",
+				  "Type %.2X, AmlLength %.2X InternalLength %.2X%8X\n",
 				  acpi_ut_get_resource_type(aml_buffer),
 				  acpi_ut_get_descriptor_length(aml_buffer),
-				  buffer_size));
+				  ACPI_FORMAT_UINT64(*size_needed)));
 
 		/*
 		 * Point to the next resource within the AML stream using the length
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 6601e71b45e3..611bc71c193f 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -87,6 +87,9 @@ void acpi_rs_dump_resource_list(struct acpi_resource *resource_list)
 			    ("Invalid descriptor type (%X) in resource list\n",
 			     resource_list->type);
 			return;
+		} else if (!resource_list->type) {
+			ACPI_ERROR((AE_INFO, "Invalid Zero Resource Type"));
+			return;
 		}
 
 		/* Sanity check the length. It must not be zero, or we loop forever */
@@ -258,6 +261,11 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 					   table->pointer[*target & 0x07]);
 			break;
 
+		case ACPI_RSD_6BITFLAG:
+
+			acpi_rs_out_integer8(name, (ACPI_GET8(target) & 0x3F));
+			break;
+
 		case ACPI_RSD_SHORTLIST:
 			/*
 			 * Short byte list (single line output) for DMA and IRQ resources
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index cafa8134b4c6..b8b37449011b 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -421,6 +421,32 @@ struct acpi_rsdump_info acpi_rs_dump_common_serial_bus[11] = {
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS
 };
 
+struct acpi_rsdump_info acpi_rs_dump_csi2_serial_bus[11] = {
+	{ ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_csi2_serial_bus),
+	 "Camera Serial Bus", NULL },
+	{ ACPI_RSD_UINT8, ACPI_RSD_OFFSET(csi2_serial_bus.revision_id),
+	 "RevisionId", NULL },
+	{ ACPI_RSD_UINT8, ACPI_RSD_OFFSET(csi2_serial_bus.type), "Type",
+	 acpi_gbl_sbt_decode },
+	{ ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(csi2_serial_bus.producer_consumer),
+	 "ProducerConsumer", acpi_gbl_consume_decode },
+	{ ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(csi2_serial_bus.slave_mode),
+	 "SlaveMode", acpi_gbl_sm_decode },
+	{ ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(csi2_serial_bus.phy_type),
+	 "PhyType", acpi_gbl_phy_decode },
+	{ ACPI_RSD_6BITFLAG,
+	 ACPI_RSD_OFFSET(csi2_serial_bus.local_port_instance),
+	 "LocalPortInstance", NULL },
+	{ ACPI_RSD_UINT8, ACPI_RSD_OFFSET(csi2_serial_bus.type_revision_id),
+	 "TypeRevisionId", NULL },
+	{ ACPI_RSD_UINT16, ACPI_RSD_OFFSET(csi2_serial_bus.vendor_length),
+	 "VendorLength", NULL },
+	{ ACPI_RSD_SHORTLISTX, ACPI_RSD_OFFSET(csi2_serial_bus.vendor_data),
+	 "VendorData", NULL },
+	{ ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(csi2_serial_bus.resource_source),
+	 "ResourceSource", NULL },
+};
+
 struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[14] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_i2c_serial_bus),
 	 "I2C Serial Bus", NULL},
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index 6e2e596902eb..eaeb7ab58c2a 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -96,13 +96,14 @@ struct acpi_rsconvert_info *acpi_gbl_get_resource_dispatch[] = {
 	acpi_rs_convert_pin_group_config,	/* 0x12, ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG */
 };
 
-/* Subtype table for serial_bus -- I2C, SPI, and UART */
+/* Subtype table for serial_bus -- I2C, SPI, UART, and CSI2 */
 
 struct acpi_rsconvert_info *acpi_gbl_convert_resource_serial_bus_dispatch[] = {
 	NULL,
 	acpi_rs_convert_i2c_serial_bus,
 	acpi_rs_convert_spi_serial_bus,
 	acpi_rs_convert_uart_serial_bus,
+	acpi_rs_convert_csi2_serial_bus
 };
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
@@ -142,6 +143,7 @@ struct acpi_rsdump_info *acpi_gbl_dump_serial_bus_dispatch[] = {
 	acpi_rs_dump_i2c_serial_bus,	/* AML_RESOURCE_I2C_BUS_TYPE */
 	acpi_rs_dump_spi_serial_bus,	/* AML_RESOURCE_SPI_BUS_TYPE */
 	acpi_rs_dump_uart_serial_bus,	/* AML_RESOURCE_UART_BUS_TYPE */
+	acpi_rs_dump_csi2_serial_bus,	/* AML_RESOURCE_CSI2_BUS_TYPE */
 };
 #endif
 
@@ -226,6 +228,7 @@ const u8 acpi_gbl_aml_resource_serial_bus_sizes[] = {
 	sizeof(struct aml_resource_i2c_serialbus),
 	sizeof(struct aml_resource_spi_serialbus),
 	sizeof(struct aml_resource_uart_serialbus),
+	sizeof(struct aml_resource_csi2_serialbus),
 };
 
 const u8 acpi_gbl_resource_struct_serial_bus_sizes[] = {
@@ -233,4 +236,5 @@ const u8 acpi_gbl_resource_struct_serial_bus_sizes[] = {
 	ACPI_RS_SIZE(struct acpi_resource_i2c_serialbus),
 	ACPI_RS_SIZE(struct acpi_resource_spi_serialbus),
 	ACPI_RS_SIZE(struct acpi_resource_uart_serialbus),
+	ACPI_RS_SIZE(struct acpi_resource_csi2_serialbus),
 };
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 0307675d37be..e46efaa889cd 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -59,7 +59,7 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 		    AML_RESOURCE_MAX_SERIALBUSTYPE) {
 			conversion_table = NULL;
 		} else {
-			/* This is an I2C, SPI, or UART serial_bus descriptor */
+			/* This is an I2C, SPI, UART, or CSI2 serial_bus descriptor */
 
 			conversion_table =
 			    acpi_gbl_convert_resource_serial_bus_dispatch
@@ -89,6 +89,11 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 		return_ACPI_STATUS(status);
 	}
 
+	if (!resource->length) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Zero-length resource returned from RsConvertAmlToResource"));
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_RESOURCES,
 			  "Type %.2X, AmlLength %.2X InternalLength %.2X\n",
 			  acpi_ut_get_resource_type(aml), length,
@@ -158,7 +163,7 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 			    AML_RESOURCE_MAX_SERIALBUSTYPE) {
 				conversion_table = NULL;
 			} else {
-				/* This is an I2C, SPI, or UART serial_bus descriptor */
+				/* This is an I2C, SPI, UART or CSI2 serial_bus descriptor */
 
 				conversion_table =
 				    acpi_gbl_convert_resource_serial_bus_dispatch
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 1763a3dbc9b1..c2dd9aae4745 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -70,6 +70,8 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 	 */
 	count = INIT_TABLE_LENGTH(info);
 	while (count) {
+		target = NULL;
+
 		/*
 		 * Source is the external AML byte stream buffer,
 		 * destination is the internal resource descriptor
@@ -120,6 +122,14 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 				  ((ACPI_GET8(source) >> info->value) & 0x07));
 			break;
 
+		case ACPI_RSC_6BITFLAG:
+			/*
+			 * Mask and shift the flag bits
+			 */
+			ACPI_SET8(destination,
+				  ((ACPI_GET8(source) >> info->value) & 0x3F));
+			break;
+
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
@@ -509,6 +519,15 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 				      value));
 			break;
 
+		case ACPI_RSC_6BITFLAG:
+			/*
+			 * Mask and shift the flag bits
+			 */
+			ACPI_SET_BIT(*ACPI_CAST8(destination), (u8)
+				     ((ACPI_GET8(source) & 0x3F) << info->
+				      value));
+			break;
+
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 1b937d88980f..f9267956535c 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -185,6 +185,81 @@ struct acpi_rsconvert_info acpi_rs_convert_pin_function[13] = {
 	 0},
 };
 
+/*******************************************************************************
+ *
+ * acpi_rs_convert_csi2_serial_bus
+ *
+ ******************************************************************************/
+
+struct acpi_rsconvert_info acpi_rs_convert_csi2_serial_bus[14] = {
+	{ ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_SERIAL_BUS,
+	 ACPI_RS_SIZE(struct acpi_resource_csi2_serialbus),
+	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_csi2_serial_bus) },
+
+	{ ACPI_RSC_INITSET, ACPI_RESOURCE_NAME_SERIAL_BUS,
+	 sizeof(struct aml_resource_csi2_serialbus),
+	 0 },
+
+	{ ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.common_serial_bus.revision_id),
+	 AML_OFFSET(common_serial_bus.revision_id),
+	 1 },
+
+	{ ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.csi2_serial_bus.type),
+	 AML_OFFSET(csi2_serial_bus.type),
+	 1 },
+
+	{ ACPI_RSC_1BITFLAG,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.producer_consumer),
+	 AML_OFFSET(csi2_serial_bus.flags),
+	 1 },
+
+	{ ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.csi2_serial_bus.slave_mode),
+	 AML_OFFSET(csi2_serial_bus.flags),
+	 0 },
+
+	{ ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.csi2_serial_bus.phy_type),
+	 AML_OFFSET(csi2_serial_bus.type_specific_flags),
+	 0 },
+
+	{ ACPI_RSC_6BITFLAG,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.local_port_instance),
+	 AML_OFFSET(csi2_serial_bus.type_specific_flags),
+	 2 },
+
+	{ ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.csi2_serial_bus.type_revision_id),
+	 AML_OFFSET(csi2_serial_bus.type_revision_id),
+	 1 },
+
+	/* Vendor data */
+
+	{ ACPI_RSC_COUNT_SERIAL_VEN,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.vendor_length),
+	 AML_OFFSET(csi2_serial_bus.type_data_length),
+	 AML_RESOURCE_CSI2_MIN_DATA_LEN },
+
+	{ ACPI_RSC_MOVE_SERIAL_VEN,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.vendor_data),
+	 0,
+	 sizeof(struct aml_resource_csi2_serialbus) },
+
+	/* Resource Source */
+
+	{ ACPI_RSC_MOVE8,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.resource_source.index),
+	 AML_OFFSET(csi2_serial_bus.res_source_index),
+	 1 },
+
+	{ ACPI_RSC_COUNT_SERIAL_RES,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.resource_source.string_length),
+	 AML_OFFSET(csi2_serial_bus.type_data_length),
+	 sizeof(struct aml_resource_csi2_serialbus) },
+
+	{ ACPI_RSC_MOVE_SERIAL_RES,
+	 ACPI_RS_OFFSET(data.csi2_serial_bus.resource_source.string_ptr),
+	 AML_OFFSET(csi2_serial_bus.type_data_length),
+	 sizeof(struct aml_resource_csi2_serialbus) },
+};
+
 /*******************************************************************************
  *
  * acpi_rs_convert_i2c_serial_bus
diff --git a/drivers/acpi/acpica/utresdecode.c b/drivers/acpi/acpica/utresdecode.c
index 0a9c337346e8..85730fcd7d00 100644
--- a/drivers/acpi/acpica/utresdecode.c
+++ b/drivers/acpi/acpica/utresdecode.c
@@ -82,6 +82,13 @@ const char *acpi_gbl_mtp_decode[] = {
 	"AddressRangeNVS"
 };
 
+const char *acpi_gbl_phy_decode[] = {
+	"Type C",
+	"Type D",
+	"Unknown Type",
+	"Unknown Type"
+};
+
 const char *acpi_gbl_rng_decode[] = {
 	"InvalidRanges",
 	"NonISAOnlyRanges",
@@ -161,7 +168,8 @@ const char *acpi_gbl_sbt_decode[] = {
 	"/* UNKNOWN serial bus type */",
 	"I2C",
 	"SPI",
-	"UART"
+	"UART",
+	"CSI2"
 };
 
 /* I2C serial bus access mode */
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index cba5505171da..16f9a7035b39 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -64,6 +64,7 @@ const u8 acpi_gbl_resource_aml_serial_bus_sizes[] = {
 	ACPI_AML_SIZE_LARGE(struct aml_resource_i2c_serialbus),
 	ACPI_AML_SIZE_LARGE(struct aml_resource_spi_serialbus),
 	ACPI_AML_SIZE_LARGE(struct aml_resource_uart_serialbus),
+	ACPI_AML_SIZE_LARGE(struct aml_resource_csi2_serialbus),
 };
 
 /*
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 9bccac9becd7..8e2319bbd0a2 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -381,7 +381,7 @@ struct acpi_resource_gpio {
 #define ACPI_IO_RESTRICT_OUTPUT                 2
 #define ACPI_IO_RESTRICT_NONE_PRESERVE          3
 
-/* Common structure for I2C, SPI, and UART serial descriptors */
+/* Common structure for I2C, SPI, UART, CSI2 serial descriptors */
 
 #define ACPI_RESOURCE_SERIAL_COMMON \
 	u8                                      revision_id; \
@@ -403,6 +403,7 @@ ACPI_RESOURCE_SERIAL_COMMON};
 #define ACPI_RESOURCE_SERIAL_TYPE_I2C           1
 #define ACPI_RESOURCE_SERIAL_TYPE_SPI           2
 #define ACPI_RESOURCE_SERIAL_TYPE_UART          3
+#define ACPI_RESOURCE_SERIAL_TYPE_CSI2          4
 
 /* Values for slave_mode field above */
 
@@ -505,6 +506,11 @@ struct acpi_resource_uart_serialbus {
 #define ACPI_UART_CLEAR_TO_SEND                 (1<<6)
 #define ACPI_UART_REQUEST_TO_SEND               (1<<7)
 
+struct acpi_resource_csi2_serialbus {
+	ACPI_RESOURCE_SERIAL_COMMON u8 local_port_instance;
+	u8 phy_type;
+};
+
 struct acpi_resource_pin_function {
 	u8 revision_id;
 	u8 pin_config;
@@ -634,6 +640,7 @@ union acpi_resource_data {
 	struct acpi_resource_i2c_serialbus i2c_serial_bus;
 	struct acpi_resource_spi_serialbus spi_serial_bus;
 	struct acpi_resource_uart_serialbus uart_serial_bus;
+	struct acpi_resource_csi2_serialbus csi2_serial_bus;
 	struct acpi_resource_common_serialbus common_serial_bus;
 	struct acpi_resource_pin_function pin_function;
 	struct acpi_resource_pin_config pin_config;
-- 
2.29.2

