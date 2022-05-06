Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6351D860
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392205AbiEFNCY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbiEFNCV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BAD63383
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841915; x=1683377915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DxZC8syyR9C+xK5/dPtjALY1tEDptkd13YlvwScvvMM=;
  b=JEx6NPE2vHi7B9R2gMU3IfpcXCIupmjnqTPJyrctRgUYPaUQn0S+3diD
   KQ3N+AuXbOJt7miO8vs8AEWQEKQ7G59619cUOUQPci6GwqQAQwSCIwaon
   tx7uRItCaMoUBUWQPIrEoav9NoiCt7nH9UFuqBN4sCW0TRWPYKoFbdIPE
   +3DPpT/+Vk6PI4Cpo+Q8Sg8b5niUB0OadSftM8y9Q2eHdXf/5OhLpARpk
   AgFUOc0sd224j2pzsVYA42wQxUODtC+5ttkMM0FmQMygm6dF9tuUL77nc
   1NJ6x4w/zxRA3cdhdVKutka+r9vQ3JM+HhFJI2xFxtfJt2nnqUdjmJxkM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331447752"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331447752"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665467965"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:33 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D43CD20DD5;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480d-Ez; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 06/11] ACPI: property: Switch node property referencing from ifs to a switch
Date:   Fri,  6 May 2022 16:00:20 +0300
Message-Id: <20220506130025.984026-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

