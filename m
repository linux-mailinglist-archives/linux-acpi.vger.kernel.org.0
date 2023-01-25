Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB867C015
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 23:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjAYWlb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 17:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjAYWl0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 17:41:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC4611CB;
        Wed, 25 Jan 2023 14:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686485; x=1706222485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vczEtI6tZHOh8hKhAAnFHCXO0eh21I5sndJPhhUbec0=;
  b=jZEWbgxvJHlRp0COX/y+Ppka2FxZcTm0oRlYEHZxcpy/0ZEVhfW4zOG6
   DtEYjXNDbJDT1rtuhlHq+Y0ySQxdyC+oh46tpqoHM3Z4AVDQLoqgiN3VY
   4FebrYX58NZHuzeFcoL/zbzJBvDnhSBfrEmN3yyM8k96B4Qd+CWq6o7qs
   f3IkhUm+N1pZAb4LhPQSaQ874942doMGUhSL75OfQsYRSvZwZDtbODmY7
   gddg2XJ5pjVdkB4oQ8foGwTqNaJzhO8Sx9EQfy0ijSdthBxEYd72XZj0T
   gi/DeF88ewHq2c8flyHnO2/jI6nGgz8A4crafYY83t8gqgECzb2hqhMVU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326727212"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326727212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="662646446"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="662646446"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:21 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 5961B122730;
        Thu, 26 Jan 2023 00:41:14 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pKoS7-001gPU-BM; Thu, 26 Jan 2023 00:41:11 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v3 5/8] ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
Date:   Thu, 26 Jan 2023 00:40:58 +0200
Message-Id: <20230125224101.401285-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
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
index 5dbdf33a13831..b81bfa1edd8ad 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -629,16 +629,32 @@ static void init_port_csi2_remote(struct acpi_device *device,
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

