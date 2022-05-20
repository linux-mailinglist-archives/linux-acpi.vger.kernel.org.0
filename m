Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB43752E4D1
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbiETGLs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbiETGLm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770199680
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027101; x=1684563101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DxZC8syyR9C+xK5/dPtjALY1tEDptkd13YlvwScvvMM=;
  b=ZNjsn+qz9SG07Bhz3+Vr2GDl1KKEZqxzU1Tr4roryYBU/+jRPKm3Zilh
   ZYM6DKSceTGEGYXf3aoiL+MCJS+saP0mhOf0kLe9xy67wlGuOB5OYf/Y3
   J6nWKH2PuJSMomFTP5l0EV58cAenlX2EJsvXoW4Hf8AknIr2XU5178yIS
   GpQkeyIbukvF9fWG1NXYgtq/ER0SBiVzUOKCnDUnQGThrSMoznFkZINi+
   pb/dwVLjLi9skK8KRHQWDdOzD2AG7EAMJ8YTG+qfPqrSi0gDItpdFFiAp
   cKGRZn//BhGUxS9hgP1UjqbWpC8viCFFLOnF+GM0iZ0HIK+zjmdxNm+0X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="333128686"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="333128686"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570642281"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:40 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 24BC220E17;
        Fri, 20 May 2022 09:11:35 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005Zl-9s; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 5/8] ACPI: property: Switch node property referencing from ifs to a switch
Date:   Fri, 20 May 2022 09:11:45 +0300
Message-Id: <20220520061148.21366-6-sakari.ailus@linux.intel.com>
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

