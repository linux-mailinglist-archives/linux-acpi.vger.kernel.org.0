Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1F2C8E6A
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbgK3Tss (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:48:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:18524 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388163AbgK3Tss (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:48 -0500
IronPort-SDR: xvOHPqr5IAWLwORR0l/58JE0vN1OUQ9RrwiIQT4OO/XCHWgZuaZ1MN/s8y+dsLhoCBlp3y0Rol
 wwuRPf0Ex/dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954748"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:58 -0800
IronPort-SDR: RW+OQS/5NOtwe/YSKhGSScOgBmVMDU+bIrxfu/0Q4/D+2fTdZd+nsGQvDWTpfgVmyTxNZb8TUY
 XmJjCVn7FDgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844928"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:47:58 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 4/6] ACPICA: Add function trace macros to improve debugging
Date:   Mon, 30 Nov 2020 11:20:46 -0800
Message-Id: <20201130192048.3093726-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 87b8dba05b4cf8c111948327023c710e2b6b5a05

The namespace repair mechanism does not have function tracing macros.
Add several trace macros to improve debuggability.

Link: https://github.com/acpica/acpica/commit/87b8dba0
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nspredef.c  | 10 +++++----
 drivers/acpi/acpica/nsprepkg.c  | 38 +++++++++++++++++----------------
 drivers/acpi/acpica/nsrepair2.c | 24 ++++++++++++---------
 3 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 0cea9c363ace..167a1c2495ab 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -71,11 +71,13 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 	acpi_status status;
 	const union acpi_predefined_info *predefined;
 
+	ACPI_FUNCTION_TRACE(ns_check_return_value);
+
 	/* If not a predefined name, we cannot validate the return object */
 
 	predefined = info->predefined;
 	if (!predefined) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
@@ -83,7 +85,7 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 	 * validate the return object
 	 */
 	if ((return_status != AE_OK) && (return_status != AE_CTRL_RETURN_VALUE)) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
@@ -102,7 +104,7 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 	if (acpi_gbl_disable_auto_repair ||
 	    (!predefined->info.expected_btypes) ||
 	    (predefined->info.expected_btypes == ACPI_RTYPE_ALL)) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
@@ -163,7 +165,7 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 		node->flags |= ANOBJ_EVALUATED;
 	}
 
-	return (status);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 237b3ddeb075..1875b1cba202 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -59,7 +59,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	u32 count;
 	u32 i;
 
-	ACPI_FUNCTION_NAME(ns_check_package);
+	ACPI_FUNCTION_TRACE(ns_check_package);
 
 	/* The package info for this name is in the next table entry */
 
@@ -88,14 +88,14 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 	 */
 	if (!count) {
 		if (package->ret_info.type == ACPI_PTYPE1_VAR) {
-			return (AE_OK);
+			return_ACPI_STATUS(AE_OK);
 		}
 
 		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 				      info->node_flags,
 				      "Return Package has no elements (empty)"));
 
-		return (AE_AML_OPERAND_VALUE);
+		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
 	/*
@@ -152,7 +152,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 							   package->ret_info.
 							   object_type1, i);
 			if (ACPI_FAILURE(status)) {
-				return (status);
+				return_ACPI_STATUS(status);
 			}
 
 			elements++;
@@ -186,7 +186,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 							      object_type[i],
 							      i);
 				if (ACPI_FAILURE(status)) {
-					return (status);
+					return_ACPI_STATUS(status);
 				}
 			} else {
 				/* These are the optional package elements */
@@ -198,7 +198,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 							      tail_object_type,
 							      i);
 				if (ACPI_FAILURE(status)) {
-					return (status);
+					return_ACPI_STATUS(status);
 				}
 			}
 
@@ -214,7 +214,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 		    acpi_ns_check_object_type(info, elements,
 					      ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
-			return (status);
+			return_ACPI_STATUS(status);
 		}
 
 		elements++;
@@ -234,7 +234,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 		    acpi_ns_check_object_type(info, elements,
 					      ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
-			return (status);
+			return_ACPI_STATUS(status);
 		}
 
 		/*
@@ -279,7 +279,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 			    acpi_ns_wrap_with_package(info, return_object,
 						      return_object_ptr);
 			if (ACPI_FAILURE(status)) {
-				return (status);
+				return_ACPI_STATUS(status);
 			}
 
 			/* Update locals to point to the new package (of 1 element) */
@@ -316,7 +316,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 							   package->ret_info.
 							   object_type1, 0);
 			if (ACPI_FAILURE(status)) {
-				return (status);
+				return_ACPI_STATUS(status);
 			}
 
 			/* Validate length of the UUID buffer */
@@ -326,14 +326,14 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 						      info->full_pathname,
 						      info->node_flags,
 						      "Invalid length for UUID Buffer"));
-				return (AE_AML_OPERAND_VALUE);
+				return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 			}
 
 			status = acpi_ns_check_object_type(info, elements + 1,
 							   package->ret_info.
 							   object_type2, 0);
 			if (ACPI_FAILURE(status)) {
-				return (status);
+				return_ACPI_STATUS(status);
 			}
 
 			elements += 2;
@@ -350,10 +350,10 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 				      "Invalid internal return type in table entry: %X",
 				      package->ret_info.type));
 
-		return (AE_AML_INTERNAL);
+		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
 
-	return (status);
+	return_ACPI_STATUS(status);
 
 package_too_small:
 
@@ -363,7 +363,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 			      "Return Package is too small - found %u elements, expected %u",
 			      count, expected_count));
 
-	return (AE_AML_OPERAND_VALUE);
+	return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 }
 
 /*******************************************************************************
@@ -708,6 +708,8 @@ acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 	acpi_status status;
 	u32 i;
 
+	ACPI_FUNCTION_TRACE(ns_check_package_elements);
+
 	/*
 	 * Up to two groups of package elements are supported by the data
 	 * structure. All elements in each group must be of the same type.
@@ -717,7 +719,7 @@ acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 		status = acpi_ns_check_object_type(info, this_element,
 						   type1, i + start_index);
 		if (ACPI_FAILURE(status)) {
-			return (status);
+			return_ACPI_STATUS(status);
 		}
 
 		this_element++;
@@ -728,11 +730,11 @@ acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 						   type2,
 						   (i + count1 + start_index));
 		if (ACPI_FAILURE(status)) {
-			return (status);
+			return_ACPI_STATUS(status);
 		}
 
 		this_element++;
 	}
 
-	return (AE_OK);
+	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 125143c41bb8..24c197d91f29 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -155,15 +155,17 @@ acpi_ns_complex_repairs(struct acpi_evaluate_info *info,
 	const struct acpi_repair_info *predefined;
 	acpi_status status;
 
+	ACPI_FUNCTION_TRACE(ns_complex_repairs);
+
 	/* Check if this name is in the list of repairable names */
 
 	predefined = acpi_ns_match_complex_repair(node);
 	if (!predefined) {
-		return (validate_status);
+		return_ACPI_STATUS(validate_status);
 	}
 
 	status = predefined->repair_function(info, return_object_ptr);
-	return (status);
+	return_ACPI_STATUS(status);
 }
 
 /******************************************************************************
@@ -344,17 +346,19 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 	u16 original_ref_count;
 	u32 i;
 
+	ACPI_FUNCTION_TRACE(ns_repair_CID);
+
 	/* Check for _CID as a simple string */
 
 	if (return_object->common.type == ACPI_TYPE_STRING) {
 		status = acpi_ns_repair_HID(info, return_object_ptr);
-		return (status);
+		return_ACPI_STATUS(status);
 	}
 
 	/* Exit if not a Package */
 
 	if (return_object->common.type != ACPI_TYPE_PACKAGE) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* Examine each element of the _CID package */
@@ -366,7 +370,7 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 
 		status = acpi_ns_repair_HID(info, element_ptr);
 		if (ACPI_FAILURE(status)) {
-			return (status);
+			return_ACPI_STATUS(status);
 		}
 
 		if (original_element != *element_ptr) {
@@ -380,7 +384,7 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 		element_ptr++;
 	}
 
-	return (AE_OK);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /******************************************************************************
@@ -500,7 +504,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	/* We only care about string _HID objects (not integers) */
 
 	if (return_object->common.type != ACPI_TYPE_STRING) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	if (return_object->string.length == 0) {
@@ -511,14 +515,14 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		/* Return AE_OK anyway, let driver handle it */
 
 		info->return_flags |= ACPI_OBJECT_REPAIRED;
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* It is simplest to always create a new string object */
 
 	new_string = acpi_ut_create_string_object(return_object->string.length);
 	if (!new_string) {
-		return (AE_NO_MEMORY);
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	/*
@@ -551,7 +555,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 
 	acpi_ut_remove_reference(return_object);
 	*return_object_ptr = new_string;
-	return (AE_OK);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /******************************************************************************
-- 
2.25.1

