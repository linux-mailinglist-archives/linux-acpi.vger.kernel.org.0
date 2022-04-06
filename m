Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E24F6462
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiDFPwC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Apr 2022 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiDFPvT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 11:51:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C9174B91
        for <linux-acpi@vger.kernel.org>; Wed,  6 Apr 2022 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649250691; x=1680786691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fu5hmcAKX1Vkm47BT7H7tahTmbhKpbaDoNEM/dxiPOk=;
  b=hVl9yVtrYT2J+qVuJI4zRUtxzVocp5Vb27ThN7gnfJOFYs/zBv08QGiE
   VGZNGGtXvQI2xz2GKvh9ljTZWN4ivf+aLbIePMAgc4gM6KQwxcfy7ak2f
   uX3nMmMtUnHv4l9m7NuUvjisS9h8UGMOWHWDxWfW7qPPURVteSBNPnoEJ
   bcAFVs2dmIfbg4u2kTrubxss4evhSZ9XbMjCOmUBSggNxhv6E+OadRPY2
   VD7Wq0AlMogp2ZBLEKrUARA9BRdwA44uS3lrVWuGAOmt1v9G4v1dHDBNE
   okOcAd4Nt3/+X+9KAMTu0HQtYVoyaNJsZCt900XILIAqeIOY1AxkC80tl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="240971306"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="240971306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:11:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="652353012"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:11:23 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 0856620371;
        Wed,  6 Apr 2022 16:11:21 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nc5SD-002X5z-1J; Wed, 06 Apr 2022 16:12:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com
Subject: [PATCH 1/1] ACPI: property: Release subnode properties with data nodes
Date:   Wed,  6 Apr 2022 16:12:08 +0300
Message-Id: <20220406131208.603830-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

struct acpi_device_properties describes one source of properties present
on either struct acpi_device or struct acpi_data_node. When properties are
parsed, both are populated but when released, only those properties that
are associated with the device node are freed.

Fix this by also releasing memory of the data node properties.

Fixes: 5f5e4890d57a ("ACPI / property: Allow multiple property compatible _DSD entries")
Cc: stable@vger.kernel.org (for v4.20 and up)
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3fceb4681ec9f..2da5e7cd28134 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -433,6 +433,16 @@ void acpi_init_properties(struct acpi_device *adev)
 		acpi_extract_apple_properties(adev);
 }
 
+static void acpi_free_device_properties(struct list_head *list)
+{
+	struct acpi_device_properties *props, *tmp;
+
+	list_for_each_entry_safe(props, tmp, list, list) {
+		list_del(&props->list);
+		kfree(props);
+	}
+}
+
 static void acpi_destroy_nondev_subnodes(struct list_head *list)
 {
 	struct acpi_data_node *dn, *next;
@@ -445,22 +455,18 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
 		wait_for_completion(&dn->kobj_done);
 		list_del(&dn->sibling);
 		ACPI_FREE((void *)dn->data.pointer);
+		acpi_free_device_properties(&dn->data.properties);
 		kfree(dn);
 	}
 }
 
 void acpi_free_properties(struct acpi_device *adev)
 {
-	struct acpi_device_properties *props, *tmp;
-
 	acpi_destroy_nondev_subnodes(&adev->data.subnodes);
 	ACPI_FREE((void *)adev->data.pointer);
 	adev->data.of_compatible = NULL;
 	adev->data.pointer = NULL;
-	list_for_each_entry_safe(props, tmp, &adev->data.properties, list) {
-		list_del(&props->list);
-		kfree(props);
-	}
+	acpi_free_device_properties(&adev->data.properties);
 }
 
 /**
-- 
2.30.2

