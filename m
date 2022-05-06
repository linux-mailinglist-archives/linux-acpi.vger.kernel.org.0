Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D24A51D866
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356050AbiEFNC5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392221AbiEFNCs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8C68F94
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841941; x=1683377941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5b95Kaj7dMb6Y2XDMJXvWieDst0bDySoTHaHwIApcQ=;
  b=gWOGNWBVdMdVkzvzZW8JNyRmzcHxL1pvn574t3duKe5zVFj6mlWxLQZx
   7bnRqdVYQyY2Z3SiE3T06BeQb9lMTfQ/Xm9EyAIOrkGwDjAURFBhpBuZ4
   y7dmJ7s2S+yihxIiIBGMwNRi/7zIFtb1/TCmRno1XY1wQ7EIWaazV2x32
   o3nw51Fd3KCmKMX+yNNKSaCDTx6p3ZENPGVV9FDR7HGzlzq+8bJDtHCh3
   4m1PQB6S/D/PcHCoUAPJeyGN6thLzNB30yRmn4UR6yvdEosgKh8ykT6+S
   CwPZD9dWl9ZfysF8K40wRPak7PIb7jvapxGvZpNg9+q0zqZvpGlYCJsuT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248365012"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248365012"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:59:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="654692333"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:59:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 9989E20621;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480O-7H; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 01/11] ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool
Date:   Fri,  6 May 2022 16:00:15 +0300
Message-Id: <20220506130025.984026-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

