Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7D6644E3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jan 2023 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjAJPcH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Jan 2023 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbjAJPb0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2023 10:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3B28CBE6
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2023 07:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673364642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=amzhvsJZmMqABs7DVJRLK5eAX330bhJ3I2jvqEZEJrg=;
        b=UEwnFycx4hYoCKJH4dhjvBg5Xijhdn1lyLzgYYBAp/eUdPMVuyqAPfKFVJ25VZQ+Low4nx
        k15XW9Lj+rHdKx+RUsBAYQ6iyijBKxvi86i68ALqZ/PijOouiurQHG79390tIF1ElmZ3hp
        ++TKhAj8n5vvV6Lf3Hxhd0u+8wGjW2U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-0zz8v5JRMH-a9S6SlNRiYA-1; Tue, 10 Jan 2023 10:30:41 -0500
X-MC-Unique: 0zz8v5JRMH-a9S6SlNRiYA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B662B8828C6;
        Tue, 10 Jan 2023 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C75492B00;
        Tue, 10 Jan 2023 15:30:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] ACPI: Fix selecting the wrong ACPI fwnode for the iGPU on some Dell laptops
Date:   Tue, 10 Jan 2023 16:30:28 +0100
Message-Id: <20230110153028.183294-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Dell Latitude E6430 both with and without the optional NVidia dGPU
has a bug in its ACPI tables which is causing Linux to assign the wrong
ACPI fwnode / companion to the pci_device for the i915 iGPU.

Specifically under the PCI root bridge there are these 2 ACPI Device()s :

 Scope (_SB.PCI0)
 {
     Device (GFX0)
     {
         Name (_ADR, 0x00020000)  // _ADR: Address
     }

     ...

     Device (VID)
     {
         Name (_ADR, 0x00020000)  // _ADR: Address
         ...

         Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
         {
             VDP8 = Arg0
             VDP1 (One, VDP8)
         }

         Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
         {
             ...
         }
         ...
     }
 }

The non-functional GFX0 ACPI device is a problem, because this gets
returned as ACPI companion-device by acpi_find_child_device() for the iGPU.

This is a long standing problem and the i915 driver does use the ACPI
companion for some things, but works fine without it.

However since commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
acpi_get_pci_dev() relies on the physical-node pointer in the acpi_device
and that is set on the wrong acpi_device because of the wrong
acpi_find_child_device() return. This breaks the ACPI video code,
leading to non working backlight control in some cases.

Add a type.backlight flag, mark ACPI video bus devices with this and make
find_child_checks() return a higher score for children with this flag set,
so that it picks the right companion-device.

Co-developed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Switch to Rafael's suggested implementation using a type.backlight flag
  and only make find_child_checks() return a higher score when this is set
---
 drivers/acpi/glue.c     | 14 ++++++++++++--
 drivers/acpi/scan.c     |  7 +++++--
 include/acpi/acpi_bus.h |  3 ++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 204fe94c7e45..a194f30876c5 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -75,7 +75,8 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
 }
 
 #define FIND_CHILD_MIN_SCORE	1
-#define FIND_CHILD_MAX_SCORE	2
+#define FIND_CHILD_MID_SCORE	2
+#define FIND_CHILD_MAX_SCORE	3
 
 static int match_any(struct acpi_device *adev, void *not_used)
 {
@@ -96,8 +97,17 @@ static int find_child_checks(struct acpi_device *adev, bool check_children)
 		return -ENODEV;
 
 	status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
-	if (status == AE_NOT_FOUND)
+	if (status == AE_NOT_FOUND) {
+		/*
+		 * Special case: backlight device objects without _STA are
+		 * preferred to other objects with the same _ADR value, because
+		 * it is more likely that they are actually useful.
+		 */
+		if (adev->pnp.type.backlight)
+			return FIND_CHILD_MID_SCORE;
+
 		return FIND_CHILD_MIN_SCORE;
+	}
 
 	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_ENABLED))
 		return -ENODEV;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 274344434282..0c6f06abe3f4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1370,9 +1370,12 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 		 * Some devices don't reliably have _HIDs & _CIDs, so add
 		 * synthetic HIDs to make sure drivers can find them.
 		 */
-		if (acpi_is_video_device(handle))
+		if (acpi_is_video_device(handle)) {
 			acpi_add_id(pnp, ACPI_VIDEO_HID);
-		else if (acpi_bay_match(handle))
+			pnp->type.backlight = 1;
+			break;
+		}
+		if (acpi_bay_match(handle))
 			acpi_add_id(pnp, ACPI_BAY_HID);
 		else if (acpi_dock_match(handle))
 			acpi_add_id(pnp, ACPI_DOCK_HID);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cd3b75e08ec3..e44be31115a6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -230,7 +230,8 @@ struct acpi_pnp_type {
 	u32 hardware_id:1;
 	u32 bus_address:1;
 	u32 platform_id:1;
-	u32 reserved:29;
+	u32 backlight:1;
+	u32 reserved:28;
 };
 
 struct acpi_device_pnp {
-- 
2.39.0

