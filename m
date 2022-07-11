Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA305700BE
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGKLgz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGKLgi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C28AB07
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538644; x=1689074644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RuUud+uK31dex1m6iS8IIrvWzluL4paahSNSvfsne1o=;
  b=QaTksEVyGjgzgHl4rVF99Gcw9PaAcoN9NPK+gsTiE31RziL0I0FAHXVX
   quY+Bq1xdqeFCI3sgEqpVqOq8dJgTedLGsTx2LHjpAaO/2xi3FkJXLbU4
   cIEhp5is7RLek14N2s73iiRMMO5YvyO6Ev/zWqRMxO9wNyQnH3o9MiGDr
   b6S0vJJAxOin4bPa9BiezN+DVVZug5EfsrToac3ok+NFbe6OGdiNG9dxl
   aZWWDhUEaEqCymadkhY2PjXiIBJlT1p9RWXJAAN9og0dDqvyXB3lgmFeO
   QmhlYPPqpglGyNdv8iBbr8oUndvk8kYlp2ML/2xHKjUqrbZG8C9YuORnb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282186965"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="282186965"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="840973462"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id EEF0C21AA1;
        Mon, 11 Jul 2022 14:23:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYX-BW; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 3/8] ACPI: property: Use acpi_object_type consistently in property ref parsing
Date:   Mon, 11 Jul 2022 14:26:01 +0300
Message-Id: <20220711112606.3050368-4-sakari.ailus@linux.intel.com>
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

The type of union acpi_object field type is acpi_object_type. Use that
instead of int.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 08b5292d2f89b..8d757ca2a58f3 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -793,7 +793,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 			 * nor integer, return an error, we can't parse it.
 			 */
 			for (i = 0; element + i < end && i < num_args; i++) {
-				int type = element[i].type;
+				acpi_object_type type = element[i].type;
 
 				if (type == ACPI_TYPE_LOCAL_REFERENCE)
 					break;
-- 
2.30.2

