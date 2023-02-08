Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188B768F203
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBHP3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBHP2y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E10460BF;
        Wed,  8 Feb 2023 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870132; x=1707406132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vcWMBKlz+OO3heBJN0y+bDZXQvJoEQwiD8J8LdmTHI=;
  b=e/fjJ4V5IshfZuduXvcBZdsyBRi7gcKITnxWCuFar6/OLVo1g3LJl6YC
   WTOX6A2j8C95whQcIfO2G+6SbKBowMsOjqgomPbqvwqW1euI21mRLkaFS
   2jpX3vR75JfN+IYbEhGVqov0Nx0jhu95P8EfkD7DJTPg1lECbCLbYfrYn
   mDGmVh69Uem9kwduPPCmL74/RL89IPrZXZ6pYVd3qrGy9FmgK+hShjulF
   eD/P8/nAPi6u6nDdfUT+T+RyX7vEDSRdANlnigQKYc67BdE9tnzhDdYZt
   9eshQODzSIzF9YLQ/Y/fUOk1xrvGhC73RZ4KGaOINHtL01gFp13JcYWlW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182285"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182285"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237832"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237832"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:45 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 05B89120DF3;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAD-Fb; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 1/8] ACPI: property: Parse data node string references in properties
Date:   Wed,  8 Feb 2023 17:28:00 +0200
Message-Id: <20230208152807.3064242-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for parsing property references using strings, besides
reference objects that were previously supported. This allows also
referencing data nodes which was not possible with reference objects.

Also add pr_fmt() macro to prefix printouts.

While at it, update copyright.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index b8d9eb9a433ed..4db7701aeaf5c 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -2,14 +2,17 @@
 /*
  * ACPI device specific properties support.
  *
- * Copyright (C) 2014, Intel Corporation
+ * Copyright (C) 2014-2023, Intel Corporation
  * All rights reserved.
  *
  * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
- *          Darren Hart <dvhart@linux.intel.com>
- *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *	    Darren Hart <dvhart@linux.intel.com>
+ *	    Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *	    Sakari Ailus <sakari.ailus@linux.intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 static int acpi_get_ref_args(struct fwnode_reference_args *args,
 			     struct fwnode_handle *ref_fwnode,
 			     const union acpi_object **element,
-			     const union acpi_object *end, size_t num_args)
+			     const union acpi_object *end, size_t num_args,
+			     bool subnode_string)
 {
 	u32 nargs = 0, i;
 
@@ -803,13 +807,16 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
 	 * Find the referred data extension node under the
 	 * referred device node.
 	 */
-	for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
-	     (*element)++) {
-		const char *child_name = (*element)->string.pointer;
-
-		ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode, child_name);
-		if (!ref_fwnode)
-			return -EINVAL;
+	if (subnode_string) {
+		for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
+		     (*element)++) {
+			const char *child_name = (*element)->string.pointer;
+
+			ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
+								      child_name);
+			if (!ref_fwnode)
+				return -EINVAL;
+		}
 	}
 
 	/*
@@ -820,7 +827,8 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
 	for (i = 0; (*element) + i < end && i < num_args; i++) {
 		acpi_object_type type = (*element)[i].type;
 
-		if (type == ACPI_TYPE_LOCAL_REFERENCE)
+		if (type == ACPI_TYPE_LOCAL_REFERENCE ||
+		    (!subnode_string && type == ACPI_TYPE_STRING))
 			break;
 
 		if (type == ACPI_TYPE_INTEGER)
@@ -844,6 +852,43 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
 	return 0;
 }
 
+static struct fwnode_handle *
+acpi_parse_string_ref(const struct fwnode_handle *fwnode, const char *refstring)
+{
+	acpi_handle scope, handle;
+	struct acpi_data_node *dn;
+	struct acpi_device *device;
+	acpi_status status;
+
+	if (is_acpi_device_node(fwnode)) {
+		scope = to_acpi_device_node(fwnode)->handle;
+	} else if (is_acpi_data_node(fwnode)) {
+		scope = to_acpi_data_node(fwnode)->handle;
+	} else {
+		pr_err("bad node type for node %pfw\n", fwnode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	status = acpi_get_handle(scope, refstring, &handle);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(scope, "can't get handle for %s", refstring);
+		return ERR_PTR(-EINVAL);
+	}
+
+	device = acpi_fetch_acpi_dev(handle);
+	if (device)
+		return acpi_fwnode_handle(device);
+
+	status = acpi_get_data_full(handle, acpi_nondev_subnode_tag,
+				    (void **)&dn, NULL);
+	if (ACPI_FAILURE(status) || !dn) {
+		acpi_handle_debug(handle, "can't find subnode");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &dn->fwnode;
+}
+
 /**
  * __acpi_node_get_property_reference - returns handle to the referenced object
  * @fwnode: Firmware node to get the property from
@@ -886,6 +931,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	const union acpi_object *element, *end;
 	const union acpi_object *obj;
 	const struct acpi_device_data *data;
+	struct fwnode_handle *ref_fwnode;
 	struct acpi_device *device;
 	int ret, idx = 0;
 
@@ -909,16 +955,29 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
+		return 0;
+	case ACPI_TYPE_STRING:
+		if (index)
+			return -ENOENT;
+
+		ref_fwnode = acpi_parse_string_ref(fwnode, obj->string.pointer);
+		if (IS_ERR(ref_fwnode))
+			return PTR_ERR(ref_fwnode);
+
+		args->fwnode = ref_fwnode;
+		args->nargs = 0;
+
 		return 0;
 	case ACPI_TYPE_PACKAGE:
 		/*
 		 * If it is not a single reference, then it is a package of
-		 * references followed by number of ints as follows:
+		 * references, followed by number of ints as follows:
 		 *
 		 *  Package () { REF, INT, REF, INT, INT }
 		 *
-		 * The index argument is then used to determine which reference
-		 * the caller wants (along with the arguments).
+		 * Here, REF may be either a local reference or a string. The
+		 * index argument is then used to determine which reference the
+		 * caller wants (along with the arguments).
 		 */
 		break;
 	default:
@@ -942,7 +1001,26 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						acpi_fwnode_handle(device),
-						&element, end, num_args);
+						&element, end, num_args, true);
+			if (ret < 0)
+				return ret;
+
+			if (idx == index)
+				return 0;
+
+			break;
+		case ACPI_TYPE_STRING:
+			ref_fwnode =
+				acpi_parse_string_ref(fwnode,
+						      element->string.pointer);
+			if (IS_ERR(ref_fwnode))
+				return PTR_ERR(ref_fwnode);
+
+			element++;
+
+			ret = acpi_get_ref_args(idx == index ? args : NULL,
+						ref_fwnode, &element, end,
+						num_args, false);
 			if (ret < 0)
 				return ret;
 
-- 
2.30.2

