Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030768F9B2
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBHV15 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjBHV1y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 16:27:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8518145;
        Wed,  8 Feb 2023 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675891673; x=1707427673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vcWMBKlz+OO3heBJN0y+bDZXQvJoEQwiD8J8LdmTHI=;
  b=FqPo+8zIPBnkZ8TRFi3TSd23L1ZSbRcOod04vGHwhKUdiUwM5MHet115
   GlVqoq3cfN2waa6iOo/anbXnLglybO95t4e54lMm9iddX3Pc9UqibZzlQ
   PIO4A7mhPWvGZPJtR/rMuQZ1/BqdgkJjyxBxbcARUmHC+ljr+4BTrRN+Y
   LvBlM57nStzMkFwImLICyyk3LrQCHJO7ql2580sx/wKsoI0I9Fc+BQfrZ
   kjIq09G6sm2EoAGWcWmkoMCQH6CQPFWFLsX6pB1Rzg+O1PXKCImWnHDFt
   F5yK+V9aHLnQHplUkrE7HkDg7FumN5eN0iHTHEEq3E5bFXIQBwuGmJeqf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313566176"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313566176"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756180455"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="756180455"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:49 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id AF862122808;
        Wed,  8 Feb 2023 23:27:47 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPryM-00DMZA-P5; Wed, 08 Feb 2023 23:27:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v5 1/8] ACPI: property: Parse data node string references in properties
Date:   Wed,  8 Feb 2023 23:27:05 +0200
Message-Id: <20230208212712.3184953-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

