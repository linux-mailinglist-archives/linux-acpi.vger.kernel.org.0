Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3368F9B6
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjBHV2F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 16:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjBHV15 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 16:27:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8F1EBCA;
        Wed,  8 Feb 2023 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675891676; x=1707427676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaTgRfZ4Xtjvs+w3o38crr9RxbAl9moVLRuSOPlk7u0=;
  b=L+Ioxvuy/CxM7aG2lkSv79uLki9vUR011s/533wi+sfg553dYTrnibjM
   SghuEB+jBGrj6JuLOknuYs9GST67WYtsRhTJm2EN8mo9pJ4Zam3BHP5t9
   5/Xy851movwaAPCoaoBAOPLwFUTDAZIwyqlwicsWsMObiIBRmGnLVDey1
   SI+VReSgCM11FbuaQ25YOqe3zExw/FNBhyykyQuKh4JnKtzqY9Sezk5sT
   HAJD0VQAA+R2En3n2iD+ghssotRsqBuUkN+YKciN7e24W81li9arprsz+
   ZPpnZJweJtemGUQukSd73xYr8KNuneIuU74n+OsCFooenmB06h58crhuN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="327625778"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="327625778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667394086"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667394086"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:54 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id C6B72122887;
        Wed,  8 Feb 2023 23:27:47 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPryM-00DMZM-Sb; Wed, 08 Feb 2023 23:27:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v5 5/8] ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
Date:   Wed,  8 Feb 2023 23:27:09 +0200
Message-Id: <20230208212712.3184953-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
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
index f81a3bb860609..08e67163b2b80 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -667,10 +667,12 @@ static void init_port_csi2_remote(struct acpi_device *device,
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
@@ -679,6 +681,21 @@ void acpi_init_swnodes(struct acpi_device *device)
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

