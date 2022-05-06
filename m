Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951E51D864
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392207AbiEFNCZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392206AbiEFNCS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F439606C4
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841915; x=1683377915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi5cjQFC1838grmpR4io2PGlZVTBTN4P4rakv1O9iwM=;
  b=Jg1rFYTuRZmb7n/dTdDtk6zANlJ+YIhS2eWeiTqSdo5CTxegP1dqtA8b
   5anXqBgppLAo84+I5HpSCJDpOoPVKQgYsUYlmAewREjaHVyEfIMe50bk+
   WMqiebwo3gFuoo9QhEXFatB/276C39KWcSPNJ0umLFns5vcL+MVfFJV4m
   8u8sk44fch5QOeH64fgWYNqmF5IUGwBEkZzp++RT/XVGlidpTc5CS3c/O
   K+pAApDkzIoml96Ku47pMmgDqx3+qyNGV2y7ys212USyI1Tl4V2VK/8d/
   Mwtz7Aog/jhODRoTbc6YcNauvbKlOKckqnvYXWHwCA06YfXjA/6xIQYOq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266051621"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266051621"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735671840"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:33 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id C674C20DCB;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480a-DC; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 05/11] ACPI: property: Move property ref argument parsing into a new function
Date:   Fri,  6 May 2022 16:00:19 +0300
Message-Id: <20220506130025.984026-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

