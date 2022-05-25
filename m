Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAE533D21
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiEYNBZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbiEYNBK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899C49D4E2
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483669; x=1685019669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5b95Kaj7dMb6Y2XDMJXvWieDst0bDySoTHaHwIApcQ=;
  b=K3MDUV2mXPgCFMlYrULiRL6V36LySQuVrcAhfNu7/oTGLniVAMn0gjfv
   gvkvvPVrmgndvbpq2Ftvo3PElZPs+t1dSW5Q6U5jcfdEMdmBjqE2zAnsT
   KwKELz2bFn4wKA81ZU/rZiTyX/iX5KSIWSgP/sp0+14S8Xr0iIgFqY/fo
   kviCgD0jR87PFrKp4zLMiN4WrP3d4KxO9t9eupgwFHJzoqJVjH0xEnClI
   aCoVs9gnxTkUctNCBnxEevAkTfO39p6f3J2cOZmGGjntr332c2OTRM84V
   eFNHCpXp8rzmSSD0iIwXt591mDXOTnlI5T31Uuph7QkE0Co/ae3pRwZ1g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273803063"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273803063"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="549013051"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:00:59 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 7A630205BD;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003DeX-C7; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 1/8] ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool
Date:   Wed, 25 May 2022 16:01:16 +0300
Message-Id: <20220525130123.767410-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The value acpi_add_nondev_subnodes() returns is bool so change the return
type of the function to match that.

Fixes: 445b0eb058f5 ("ACPI / property: Add support for data-only subnodes")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d3173811614ec..bc9a645f8bb77 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -155,10 +155,10 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
 }
 
-static int acpi_add_nondev_subnodes(acpi_handle scope,
-				    const union acpi_object *links,
-				    struct list_head *list,
-				    struct fwnode_handle *parent)
+static bool acpi_add_nondev_subnodes(acpi_handle scope,
+				     const union acpi_object *links,
+				     struct list_head *list,
+				     struct fwnode_handle *parent)
 {
 	bool ret = false;
 	int i;
-- 
2.30.2

