Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9171F533D1B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiEYNBH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbiEYNBF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938CA5AA9
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483664; x=1685019664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DxZC8syyR9C+xK5/dPtjALY1tEDptkd13YlvwScvvMM=;
  b=cW6Sfp13NKpu3YWrKdXO4qu+J8oTK+xbvE5B41aFg8bI6svb4r3J3HKr
   BusUxHyeO+KWCPty0jSISwAjuLFmu2OiRlNwPtr2jXW0DHPnDASBChLUs
   ytFbErGBH3YeL3evqricd5dX/KsgQQmRy3xV4sx8P6OqPcucKQQQoYRVV
   8BAOqOTh9UL8Qp+jeSboEf3Z5KCW+rXgZvC+b3uttcxWfESxq1Hatk//b
   dn8aCHst10+ZIArtYRM+56E8rusKr7GGdpzTf9dbhGc0Hcq6WVtxSp2ae
   MTfC6FOwJSQ7tM/ALSLvZMOI915jKdA0kKkLT9955xA/g3tikw0of5n8f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255868693"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255868693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="609109397"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:02 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id AA71E20862;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003Dej-IH; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 5/8] ACPI: property: Switch node property referencing from ifs to a switch
Date:   Wed, 25 May 2022 16:01:20 +0300
Message-Id: <20220525130123.767410-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

__acpi_node_get_property_reference() uses a series of if () statements for
testing the same variable. There's soon going to be one more value to be
tested.

Switch to use switch() instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index dd6cce955ee28..a8e8a214a524f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -780,11 +780,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	if (ret)
 		return ret == -EINVAL ? -ENOENT : -EINVAL;
 
-	/*
-	 * The simplest case is when the value is a single reference.  Just
-	 * return that reference then.
-	 */
-	if (obj->type == ACPI_TYPE_LOCAL_REFERENCE) {
+	switch (obj->type) {
+	case ACPI_TYPE_LOCAL_REFERENCE:
+		/* Plain single reference without arguments. */
 		if (index)
 			return -ENOENT;
 
@@ -795,19 +793,21 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
 		return 0;
+	case ACPI_TYPE_PACKAGE:
+		/*
+		 * If it is not a single reference, then it is a package of
+		 * references followed by number of ints as follows:
+		 *
+		 *  Package () { REF, INT, REF, INT, INT }
+		 *
+		 * The index argument is then used to determine which reference
+		 * the caller wants (along with the arguments).
+		 */
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	/*
-	 * If it is not a single reference, then it is a package of
-	 * references followed by number of ints as follows:
-	 *
-	 *  Package () { REF, INT, REF, INT, INT }
-	 *
-	 * The index argument is then used to determine which reference
-	 * the caller wants (along with the arguments).
-	 */
-	if (obj->type != ACPI_TYPE_PACKAGE)
-		return -EINVAL;
 	if (index >= obj->package.count)
 		return -ENOENT;
 
@@ -815,7 +815,8 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	end = element + obj->package.count;
 
 	while (element < end) {
-		if (element->type == ACPI_TYPE_LOCAL_REFERENCE) {
+		switch (element->type) {
+		case ACPI_TYPE_LOCAL_REFERENCE:
 			device = acpi_fetch_acpi_dev(element->reference.handle);
 			if (!device)
 				return -EINVAL;
@@ -831,11 +832,13 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 			if (idx == index)
 				return 0;
 
-		} else if (element->type == ACPI_TYPE_INTEGER) {
+			break;
+		case ACPI_TYPE_INTEGER:
 			if (idx == index)
 				return -ENOENT;
 			element++;
-		} else {
+			break;
+		default:
 			return -EINVAL;
 		}
 
-- 
2.30.2

