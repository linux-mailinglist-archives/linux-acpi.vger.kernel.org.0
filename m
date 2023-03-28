Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BC6CBC3D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjC1KOW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjC1KOF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:14:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D5618B;
        Tue, 28 Mar 2023 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998436; x=1711534436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4n1xPmnGinau6jXLD/1LmxYOsooXVCKECX569xupM0=;
  b=SVTvzUjyOPV5lU70A5GkPznfZ8tMPfqiebQbGVsPpsFHQ929pZQPnnVi
   abPg7Zsc1yYYxR7qf4lgM1X8E2ACMwG+Ed2EsIiSmVJ8vH79B2Y4kH/Cd
   0BUwG3RE4kPNFIpB/0qNV7vkFw0Cff2GLCT03d41SJBagLm+fPziueO3n
   pG2IQZ3aYHRQL2sw2dOBqMPBhm0KHwpjh0DbgEcrXrhBbLuFiYQzB4VZA
   6nkCOYqAI5VLBTTbUvW/RBo18H3What4Ezj/iM8f71CmU847akHTApjxw
   zFLwcceH21g3punxUzroD79HnVQTSPx+RkUlqznqltrnlSoJ3UgM2OakZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328985350"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="328985350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827432706"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827432706"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:14 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id E309112233C;
        Tue, 28 Mar 2023 13:13:11 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v7 07/10] ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
Date:   Tue, 28 Mar 2023 13:13:00 +0300
Message-Id: <20230328101303.1458570-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dig "rotation" property value for devices with _CRS CSI2 resource
descriptor. The value comes from _PLD (physical location of device)
object, if it exists for the device.

This way camera sensor drivers that know the "rotation" property do not
need to care about _PLD on ACPI.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c     | 17 +++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 315f076b9208..9f29bf231eaf 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -654,10 +654,12 @@ static void init_port_csi2_remote(struct acpi_device *device,
  */
 void acpi_init_swnodes(struct acpi_device *device)
 {
+	struct fwnode_handle *fwnode = acpi_fwnode_handle(device);
 	struct acpi_device_software_nodes *ads;
 	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
 	acpi_handle handle = acpi_device_handle(device);
 	struct fwnode_handle *primary;
+	unsigned int prop_index = 0;
 	acpi_status status;
 	unsigned int i;
 	int ret;
@@ -666,6 +668,21 @@ void acpi_init_swnodes(struct acpi_device *device)
 	if (!ads)
 		return;
 
+	/*
+	 * Check if "rotation" property exists and if it doesn't but there's a
+	 * _PLD object, then get the rotation value from there.
+	 */
+	if (!fwnode_property_present(fwnode, "rotation")) {
+		struct acpi_pld_info *pld;
+
+		status = acpi_get_physical_device_location(handle, &pld);
+		if (ACPI_SUCCESS(status)) {
+			ads->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
+				PROPERTY_ENTRY_U32("rotation", pld->rotation * 45U);
+			kfree(pld);
+		}
+	}
+
 	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_warn(handle, "cannot get path name\n");
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9192b990394d..2465a336b15f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -362,6 +362,7 @@ struct acpi_device_data {
 struct acpi_gpio_mapping;
 
 enum acpi_device_swnode_dev_props {
+	ACPI_DEVICE_SWNODE_DEV_ROTATION,
 	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
 	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
 };
-- 
2.30.2

