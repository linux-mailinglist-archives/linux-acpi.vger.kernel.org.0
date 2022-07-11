Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53205700BF
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGKLg4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGKLgi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAFF8AB13
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538644; x=1689074644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvVYEfjiHVi/nihMsg112ut3JOPPn8HoWlDQ3tjdcDY=;
  b=YrBDjllr4WjP/HpZrt3ZwFJ4Ccfo2ui/bQ+fntdkJ4k9CNf5nlPWhm5k
   3L3ncz0IIj0rdCr2ZUGujsQr7mtU7zAfvGkVY4MOYE40kiaYeup8ZUxfQ
   2s8jLDyWhOYMZ9wqEqgsLZZnbFzWWWdKV4iyd7HmeoxFxWMlBWUePvwqL
   rhHoRQXmHJNk9rZEt4rZiQBEg1CByzQI2OwM9QNX+PPpTZXmV9c80bNK1
   xbab70hNRwKAHi3elmUUIXDfj+QkAeGrQsajT/v7rdXJJwIpbNLcO6SEU
   7fmXAeBRCg2/pUFnwGOQ564u36p/KBgcy0vUH+eeH/DH0tejrVpqsiFhE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282186964"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="282186964"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="840973460"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D98892073E;
        Mon, 11 Jul 2022 14:23:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYR-8Y; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 1/8] ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool
Date:   Mon, 11 Jul 2022 14:25:59 +0300
Message-Id: <20220711112606.3050368-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
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

The value acpi_add_nondev_subnodes() returns is bool so change the return
type of the function to match that.

Fixes: 445b0eb058f5 ("ACPI / property: Add support for data-only subnodes")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e764f9ac9cf8f..6d698f3f83a0a 100644
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

