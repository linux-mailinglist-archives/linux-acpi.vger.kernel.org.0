Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D552668F206
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjBHP3P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjBHP2z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB8457D7;
        Wed,  8 Feb 2023 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870133; x=1707406133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QgsTm/eNP+J/CEq8iJYGGEPvC2UZDdgN7uh3TsL06mk=;
  b=GUiyrhmoBv8yUYqbZMU/sbX2pZUH+wVIZTmlGD1WvazlK7dMNNhlBeXJ
   8YuiLwkR6oL3m+RXHCESOMKMvNo/8ogG330n8QOXKPjRlLJ7rpSFyhnEr
   FEj0Kcx5jL5rmr3+6gsSlqbP9X7qIm07hKSGABgZxWaNmzUHxo5mMI+/7
   s59Be51U/35D81d29qGyfna4suUHzNcBiknfIoatihx/bcM6vJP7jjGi4
   xjNhY/ajMghsAkMzFYX4FkoYKweAgrQGieLObLf5z13RxOY2eOCaEyBOj
   zy6WKJ42H1ZLXr8CQftTvnnj1IrBbN+fE+Rd9qz25ufVYYDMXiKAaN8Yr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182298"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182298"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237844"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237844"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:48 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 114D3122319;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAP-Hi; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 5/8] ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
Date:   Wed,  8 Feb 2023 17:28:04 +0200
Message-Id: <20230208152807.3064242-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
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
 drivers/acpi/mipi.c     | 16 ++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index c3ceee1d119e7..584c08c2b8989 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -667,16 +667,32 @@ static void init_port_csi2_remote(struct acpi_device *device,
  */
 void acpi_init_swnodes(struct acpi_device *device)
 {
+	struct fwnode_handle *fwnode = acpi_fwnode_handle(device);
 	struct acpi_device_software_nodes *ads;
 	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
 	struct fwnode_handle *primary;
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
+	    ACPI_SUCCESS(acpi_get_physical_device_location(acpi_device_handle(device),
+							   &pld))) {
+		ads->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
+			PROPERTY_ENTRY_U32("rotation", pld->rotation * 45U);
+		kfree(pld);
+	}
+
 	if (ACPI_FAILURE(acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer))) {
 		acpi_handle_warn(acpi_device_handle(device), "cannot get path name\n");
 		return;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e05d1c1f6ac23..f73e65a21b894 100644
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

