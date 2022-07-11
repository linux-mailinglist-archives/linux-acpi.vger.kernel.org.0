Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407345700C5
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiGKLhS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGKLgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E248CC83
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538653; x=1689074653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QpHao9gHcDm8aajq6jUIYt3R7xeDPpVj8JfzaffUFnw=;
  b=Ik+czpxrKSXGGOmQRMtRhNScEAfP2BYZcK+UPuvrEdON0YOUX2kMFnFi
   xIdVk2pP+RTWVR1cSfP7PYWOlPYxlMWyDpVrT0qDmdR7nO/+Xeo0hML12
   1QXuUX7TKTyQPP6zFwRago5pDxIWy9qQr3tiJdvxz12N8pJuzD0QJwaog
   Z3pow72bnBvehWznI9AvxbEdJ+MAr8A+rffqZO/6p/KAXlB6Ozn9oqMqe
   ZHQ8oMT+aSAFsBrc48q4sVW0baBgyuNt2f+81VnToGIEqoM6+ltpK1lBD
   j1HYqSl/Ez7pwRpj0wXMYRF0Wp7Iw+s3wkDaG55mRczr5siKIpkB5VlAE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310239430"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="310239430"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="684350396"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 0871F21AFD;
        Mon, 11 Jul 2022 14:23:58 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYa-D1; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 4/8] ACPI: property: Move property ref argument parsing into a new function
Date:   Mon, 11 Jul 2022 14:26:02 +0300
Message-Id: <20220711112606.3050368-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Split out property reference argument parsing out of the
__acpi_node_get_property_reference() function into a new one,
acpi_get_ref_args(). The new function will be needed also for parsing
string references soon.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 103 ++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8d757ca2a58f3..a2733f8981c7f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -673,6 +673,58 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static int acpi_get_ref_args(struct fwnode_reference_args *args,
+			     struct fwnode_handle *ref_fwnode,
+			     const union acpi_object **element,
+			     const union acpi_object *end, size_t num_args)
+{
+	u32 nargs = 0, i;
+
+	/*
+	 * Find the referred data extension node under the
+	 * referred device node.
+	 */
+	for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
+	     (*element)++) {
+		const char *child_name = (*element)->string.pointer;
+
+		ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode, child_name);
+		if (!ref_fwnode)
+			return -EINVAL;
+	}
+
+	/*
+	 * Assume the following integer elements are all args. Stop counting on
+	 * the first reference or end of the package arguments. In case of
+	 * neither reference, nor integer, return an error, we can't parse it.
+	 */
+	for (i = 0; (*element) + i < end && i < num_args; i++) {
+		acpi_object_type type = (*element)[i].type;
+
+		if (type == ACPI_TYPE_LOCAL_REFERENCE)
+			break;
+
+		if (type == ACPI_TYPE_INTEGER)
+			nargs++;
+		else
+			return -EINVAL;
+	}
+
+	if (nargs > NR_FWNODE_REFERENCE_ARGS)
+		return -EINVAL;
+
+	if (args) {
+		args->fwnode = ref_fwnode;
+		args->nargs = nargs;
+		for (i = 0; i < nargs; i++)
+			args->args[i] = (*element)[i].integer.value;
+	}
+
+	(*element) += nargs;
+
+	return 0;
+}
+
 /**
  * __acpi_node_get_property_reference - returns handle to the referenced object
  * @fwnode: Firmware node to get the property from
@@ -761,61 +813,22 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	end = element + obj->package.count;
 
 	while (element < end) {
-		u32 nargs, i;
-
 		if (element->type == ACPI_TYPE_LOCAL_REFERENCE) {
-			struct fwnode_handle *ref_fwnode;
-
 			device = acpi_fetch_acpi_dev(element->reference.handle);
 			if (!device)
 				return -EINVAL;
 
-			nargs = 0;
 			element++;
 
-			/*
-			 * Find the referred data extension node under the
-			 * referred device node.
-			 */
-			for (ref_fwnode = acpi_fwnode_handle(device);
-			     element < end && element->type == ACPI_TYPE_STRING;
-			     element++) {
-				ref_fwnode = acpi_fwnode_get_named_child_node(
-					ref_fwnode, element->string.pointer);
-				if (!ref_fwnode)
-					return -EINVAL;
-			}
-
-			/*
-			 * Assume the following integer elements are all args.
-			 * Stop counting on the first reference or end of the
-			 * package arguments. In case of neither reference,
-			 * nor integer, return an error, we can't parse it.
-			 */
-			for (i = 0; element + i < end && i < num_args; i++) {
-				acpi_object_type type = element[i].type;
-
-				if (type == ACPI_TYPE_LOCAL_REFERENCE)
-					break;
-				if (type == ACPI_TYPE_INTEGER)
-					nargs++;
-				else
-					return -EINVAL;
-			}
-
-			if (nargs > NR_FWNODE_REFERENCE_ARGS)
-				return -EINVAL;
-
-			if (idx == index) {
-				args->fwnode = ref_fwnode;
-				args->nargs = nargs;
-				for (i = 0; i < nargs; i++)
-					args->args[i] = element[i].integer.value;
+			ret = acpi_get_ref_args(idx == index ? args : NULL,
+						acpi_fwnode_handle(device),
+						&element, end, num_args);
+			if (ret < 0)
+				return ret;
 
+			if (idx == index)
 				return 0;
-			}
 
-			element += nargs;
 		} else if (element->type == ACPI_TYPE_INTEGER) {
 			if (idx == index)
 				return -ENOENT;
-- 
2.30.2

