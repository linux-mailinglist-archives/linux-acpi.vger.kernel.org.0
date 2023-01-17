Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3EA66DD68
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjAQMWX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjAQMWT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:22:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E332BF1E;
        Tue, 17 Jan 2023 04:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958138; x=1705494138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDSZujq+XtQrKm1vvqwkNrtKdKJtrb4ZIduGHFaghws=;
  b=aU3ExtznnZHv24hd1WkvY0QF6BAEW7zVjaRHb/7vQbgAjUCsc2Bo0FZL
   E/QhOn/U+Wgu9ojJQ7FWtusNnQQdDdLx0okD0ZzoxmFXKOImCyTWdsfrv
   r3qp1MwKT+iF6HZcCXqmOVvTWUjGmfbh/air7Nxe0k4gT7e1siHpejUHJ
   YA6vtpbOKgi7eXehLkl0DIyY+1ioJ+e9NPuZXK1TdHc52cxd2g1sJ9z4R
   dRf+FNWRk23NLcKEhvXtNBoBamHedMMNWHKj/8Y+6Onu5+hsEuyhYFCmF
   jMnAL7RYBuhGdkjJVDp0QThv8JjE80bLHY5lGsF7jnIQB6BV8QqbZvP3p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410920113"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410920113"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727772043"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727772043"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:17 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 047612093B;
        Tue, 17 Jan 2023 14:22:12 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pHkzE-00AgVJ-Ph; Tue, 17 Jan 2023 14:22:44 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH 5/8] ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
Date:   Tue, 17 Jan 2023 14:22:41 +0200
Message-Id: <20230117122244.2546597-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index cc80d79f4a381..bd09eac0a52e4 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -632,15 +632,32 @@ static void init_port_csi2_remote(struct acpi_device *device,
  */
 void acpi_init_swnodes(struct acpi_device *device)
 {
+	struct fwnode_handle *fwnode = acpi_fwnode_handle(device);
 	struct acpi_device_software_nodes *ads;
 	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
+	struct acpi_pld_info *pld;
+	unsigned int prop_index = 0;
 	unsigned int i;
+	u32 val;
 	int ret;
 
 	device->swnodes = ads = crs_csi2_swnode_get(device->handle);
 	if (!ads)
 		return;
 
+	/*
+	 * Check if "rotation" property exists and if it doesn't but there's a
+	 * _PLD object, then get the rotation value from there.
+	 */
+	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
+	    acpi_get_physical_device_location(acpi_device_handle(device),
+					      &pld) == AE_OK) {
+		ads->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
+			PROPERTY_ENTRY_U32("rotation",
+					   (u32)pld->rotation * 45U);
+		kfree(pld);
+	}
+
 	if (acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer) != AE_OK) {
 		acpi_handle_warn(acpi_device_handle(device), "cannot get path name\n");
 		return;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9a7729e96d14c..3c4a1daed33f1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -361,6 +361,7 @@ struct acpi_device_data {
 struct acpi_gpio_mapping;
 
 enum acpi_device_swnode_dev_props {
+	ACPI_DEVICE_SWNODE_DEV_ROTATION,
 	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
 	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
 };
-- 
2.30.2

