Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78052E4CE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbiETGLl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244942AbiETGLj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C27A812
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027098; x=1684563098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5b95Kaj7dMb6Y2XDMJXvWieDst0bDySoTHaHwIApcQ=;
  b=PYIA4gHkKfBg7ZR2mLAuSI5v+apes2WGx+hAxNQUiiGwPyiVWoGl+9a2
   ZNdUqCNHXZ/bHhEquYoBcWFZsg3sLTi1fKYnI8R4Fn+NTFzY42KRPZIvW
   Bu7O3YmXn7UvtcYm2CyU+AgP4jHzWVtJxlRmUbR2KIuM+fj4Abi6D7N3n
   6NSkD+ZMc8NLbSIwy8oWWkUV2jDtzsBjFg1r1WU0LbppNm7Zk97DzZwKt
   ycQItdtBLPzHoYMhunwhajmg9xwetSTh/BtQ982HkmVPX2kdJuFbuDQA9
   sOY6endZd9sbYMUlBtjWq9tNzveiqNMWHkjDvbDh5q7AKPCtBGiz8NF+A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297813972"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="297813972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743339746"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:37 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id E9FE020656;
        Fri, 20 May 2022 09:11:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005ZZ-3p; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 1/8] ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool
Date:   Fri, 20 May 2022 09:11:41 +0300
Message-Id: <20220520061148.21366-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

