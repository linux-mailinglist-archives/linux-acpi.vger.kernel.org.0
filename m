Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C235700C9
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiGKLh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiGKLg7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92246371B3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538674; x=1689074674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9HWFNT0qCPQRY1yL4Km4YWL+W1aFZnA3HRIUBMwNZU=;
  b=M45U9XiCEpl0612LMWB/iSURV/JLdMZpcHtJPRis69AgXhUlMlSmCt2W
   NK6eKLbdMmfjNIx0NpOX5pg4I5Yt934E1Gsf8apkCjHUl2Q6puM7Su7IF
   5+yTI3VR0YsuMSmsshE+vHAeiyjnkcjAgFkHPIBk0xaSW+kN5IyVr/PTP
   HcWwn6CcP8GEo6SDIY6wtD7SzySwQOR90X44R6UsaeiSdpJmPbaaifxYW
   zaBTurCNHXmisOOp7N46OWqxPrKd0RgPlYfed+j/V1g0Y5pVqOhFzxrVH
   KGY+ZR/xvemGoX77hoL5K21qh+5S0JSxH6tY/TIBQooOL1NaJdSY4UME2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310239562"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="310239562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="737059034"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:33 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 1360821D4A;
        Mon, 11 Jul 2022 14:23:58 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYd-Ep; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 5/8] ACPI: property: Switch node property referencing from ifs to a switch
Date:   Mon, 11 Jul 2022 14:26:03 +0300
Message-Id: <20220711112606.3050368-6-sakari.ailus@linux.intel.com>
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

__acpi_node_get_property_reference() uses a series of if () statements for
testing the same variable. There's soon going to be one more value to be
tested.

Switch to use switch() instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a2733f8981c7f..3411cd0433b88 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -778,11 +778,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
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
 
@@ -793,19 +791,21 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
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
 
@@ -813,7 +813,8 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	end = element + obj->package.count;
 
 	while (element < end) {
-		if (element->type == ACPI_TYPE_LOCAL_REFERENCE) {
+		switch (element->type) {
+		case ACPI_TYPE_LOCAL_REFERENCE:
 			device = acpi_fetch_acpi_dev(element->reference.handle);
 			if (!device)
 				return -EINVAL;
@@ -829,11 +830,13 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
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

