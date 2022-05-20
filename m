Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9E52E4CC
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiETGLo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbiETGLj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BC7CB19
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027098; x=1684563098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi5cjQFC1838grmpR4io2PGlZVTBTN4P4rakv1O9iwM=;
  b=LNpFUnv7GgMEZ2DZ0h1UCttT5K157OUm4PUccrB2N3fRs9HJ5JxVF85w
   UsQ+c65LSQSZ3fCMoHwm30+xdUnBfj02dWdSQzzrrrtBq4H844JyEzb7o
   8UuWXtOXKog9puLBTb8+82FXi54YlF3GzbPzvI8bKR7E+02oq6L4z7dN7
   0GMFfpK1b9EdrRd/E8vflJEgi0u1YZIm5yXWnWj1BbtC1Lo0/r7WGZHsK
   6DgTwvSBnunFIuuzs4UqnBaeCBAY1PDYAGvtqObPO6s3pbLGOsWpU/FC6
   jjq+igI4C3IP5cpmH0zHeb2RN/28fINksUaBVTqmsT5NR2zibZMiTULeE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="333128675"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="333128675"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="640173112"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:37 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 17F9B20C9E;
        Fri, 20 May 2022 09:11:35 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005Zi-8B; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 4/8] ACPI: property: Move property ref argument parsing into a new function
Date:   Fri, 20 May 2022 09:11:44 +0300
Message-Id: <20220520061148.21366-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/acpi/property.c | 105 +++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index b36cb7e36e420..dd6cce955ee28 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -673,6 +673,60 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static int
+acpi_get_ref_args(struct fwnode_reference_args *args,
+		  struct fwnode_handle *ref_fwnode,
+		  const union acpi_object **element,
+		  const union acpi_object *end, size_t num_args)
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
+		ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
+							      child_name);
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
@@ -761,61 +815,22 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
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

