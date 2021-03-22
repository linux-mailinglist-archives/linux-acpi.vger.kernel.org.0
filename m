Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4398A3452D0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 00:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCVXKM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 19:10:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:20267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhCVXJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 19:09:39 -0400
IronPort-SDR: mCsnSVcirBx9ct9KCaUco82pCgY1rspmWjBXdGbWVXMn9sIN9oUEyCCU8akEEE6g+blaiKdY7e
 Tt5O/tdZmQEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251718883"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251718883"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:09:37 -0700
IronPort-SDR: hC0Sogm/hJ4oAUyOQRuXJ3TUSRX1YIm9Uzw5IGRT2kVsftQzFYk8UphCU74lF3BpcUyv4GL+GU
 axiF7XswcS8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607510499"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2021 16:09:37 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v3 2/4] ACPICA: Add support for PlatformRtMechanism OperationRegion handler
Date:   Mon, 22 Mar 2021 15:37:05 -0700
Message-Id: <20210322223707.1838823-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322223707.1838823-1-erik.kaneda@intel.com>
References: <20210322223707.1838823-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Writing a buffer to a PlatformRtMechanism fieldunit invokes a
bidirectional transaction. The input buffer contains 26 bytes
containing 9 bytes of status, a command byte and a 16-byte UUID.
This change will will simply pass this incoming buffer to a handler
registered by the OS.

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acutils.h  |  2 ++
 drivers/acpi/acpica/exfield.c  |  8 +++++--
 drivers/acpi/acpica/exserial.c | 12 ++++++++++
 drivers/acpi/acpica/utuuid.c   | 41 ++++++++++++++++++++++++++++++++++
 include/acpi/acconfig.h        |  2 ++
 5 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index be6de7149e67..dd72d589babe 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -736,6 +736,8 @@ const char *acpi_ah_match_uuid(u8 *data);
  */
 #if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_HELP_APP)
 void acpi_ut_convert_string_to_uuid(char *in_string, u8 *uuid_buffer);
+
+acpi_status acpi_ut_convert_uuid_to_string(char *uuid_buffer, char *out_string);
 #endif
 
 #endif				/* _ACUTILS_H */
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 32f03ee81785..06f3c9df1e22 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -139,7 +139,9 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_GSBUS
 		    || obj_desc->field.region_obj->region.space_id ==
-		    ACPI_ADR_SPACE_IPMI)) {
+		    ACPI_ADR_SPACE_IPMI
+		    || obj_desc->field.region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_PLATFORM_RT)) {
 
 		/* SMBus, GSBus, IPMI serial */
 
@@ -301,7 +303,9 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_GSBUS
 		    || obj_desc->field.region_obj->region.space_id ==
-		    ACPI_ADR_SPACE_IPMI)) {
+		    ACPI_ADR_SPACE_IPMI
+		    || obj_desc->field.region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_PLATFORM_RT)) {
 
 		/* SMBus, GSBus, IPMI serial */
 
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 8e8d95f7947b..10d68a5f76a3 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -195,6 +195,12 @@ acpi_ex_read_serial_bus(union acpi_operand_object *obj_desc,
 		function = ACPI_READ | (accessor_type << 16);
 		break;
 
+	case ACPI_ADR_SPACE_PLATFORM_RT:
+
+		buffer_length = ACPI_PRM_INPUT_BUFFER_SIZE;
+		function = ACPI_READ;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
@@ -311,6 +317,12 @@ acpi_ex_write_serial_bus(union acpi_operand_object *source_desc,
 		function = ACPI_WRITE | (accessor_type << 16);
 		break;
 
+	case ACPI_ADR_SPACE_PLATFORM_RT:
+
+		buffer_length = ACPI_PRM_INPUT_BUFFER_SIZE;
+		function = ACPI_WRITE;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index 090e44b6b6c7..dca9061518ab 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -61,4 +61,45 @@ void acpi_ut_convert_string_to_uuid(char *in_string, u8 *uuid_buffer)
 					       1]);
 	}
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_convert_uuid_to_string
+ *
+ * PARAMETERS:  uuid_buffer         - 16-byte UUID buffer
+ *              out_string          - 36-byte formatted UUID string
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert 16-byte UUID buffer to 36-byte formatted UUID string
+ *              out_string must be 37 bytes to include null terminator.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_convert_uuid_to_string(char *uuid_buffer, char *out_string)
+{
+	u32 i;
+
+	if (!uuid_buffer || !out_string) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	for (i = 0; i < UUID_BUFFER_LENGTH; i++) {
+		out_string[acpi_gbl_map_to_uuid_offset[i]] =
+		    acpi_ut_hex_to_ascii_char(uuid_buffer[i], 4);
+
+		out_string[acpi_gbl_map_to_uuid_offset[i] + 1] =
+		    acpi_ut_hex_to_ascii_char(uuid_buffer[i], 0);
+	}
+
+	/* Insert required hyphens (dashes) */
+
+	out_string[UUID_HYPHEN1_OFFSET] =
+	    out_string[UUID_HYPHEN2_OFFSET] =
+	    out_string[UUID_HYPHEN3_OFFSET] =
+	    out_string[UUID_HYPHEN4_OFFSET] = '-';
+
+	out_string[UUID_STRING_LENGTH] = 0;	/* Null terminate */
+	return (AE_OK);
+}
 #endif
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index e92f84fa8c68..0362cbb72359 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -188,6 +188,8 @@
 #define ACPI_MAX_GSBUS_DATA_SIZE        255
 #define ACPI_MAX_GSBUS_BUFFER_SIZE      ACPI_SERIAL_HEADER_SIZE + ACPI_MAX_GSBUS_DATA_SIZE
 
+#define ACPI_PRM_INPUT_BUFFER_SIZE      26
+
 /* _sx_d and _sx_w control methods */
 
 #define ACPI_NUM_sx_d_METHODS           4
-- 
2.29.2

