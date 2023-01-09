Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF84663232
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbjAIVFX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 16:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjAIVE7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 16:04:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805778B523
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673297847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JxivtNO15kfEhXSMYwuZ/uLbnXccY2i9uozRcRx7JYc=;
        b=DGImgxgr/PC53hsS7rVFVKgVSezQI6Q/nSsImrIZGKPHuXUe46VklSAA38C5cD29lPe4sb
        q2GvUNM8fMBkBmT+8dk6dXRmpPF+LpfHZwW+nWyqOXR8MN6fLYYXyLvPHBj82GkrsUe3yR
        g1Hnvw9imoE/W3OnHBA4RR0j5AWzSis=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-UzuVsKOeMEaDeUoAKvhHjA-1; Mon, 09 Jan 2023 15:57:24 -0500
X-MC-Unique: UzuVsKOeMEaDeUoAKvhHjA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF0E93804066;
        Mon,  9 Jan 2023 20:57:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6081492B00;
        Mon,  9 Jan 2023 20:57:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: Fix selecting the wrong ACPI fwnode for the iGPU on some Dell laptops
Date:   Mon,  9 Jan 2023 21:57:21 +0100
Message-Id: <20230109205721.60694-1-hdegoede@redhat.com>
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
acpi_find_child_device() return. This breaks the ACPI video code, leading
to non working backlight control in some cases.

Make find_child_checks() return a higher score for children which have
pnp-ids set by various scan helpers like acpi_is_video_device(), so
that it picks the right companion-device.

An alternative approach would be to directly call acpi_is_video_device()
from find_child_checks() but that would be somewhat computationally
expensive given that acpi_find_child_device() iterates over all the
PCI0 children every time it is called.

Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/glue.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 204fe94c7e45..2055dfd7678b 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -75,7 +75,7 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
 }
 
 #define FIND_CHILD_MIN_SCORE	1
-#define FIND_CHILD_MAX_SCORE	2
+#define FIND_CHILD_MAX_SCORE	3
 
 static int match_any(struct acpi_device *adev, void *not_used)
 {
@@ -89,15 +89,25 @@ static bool acpi_dev_has_children(struct acpi_device *adev)
 
 static int find_child_checks(struct acpi_device *adev, bool check_children)
 {
+	int score = FIND_CHILD_MIN_SCORE;
 	unsigned long long sta;
 	acpi_status status;
 
 	if (check_children && !acpi_dev_has_children(adev))
 		return -ENODEV;
 
+	/*
+	 * For devices without a _STA method, prefer devices without a _HID
+	 * (which conflicts with having an _ADR) but which have been matched
+	 * in some other way, like e.g. by acpi_is_video_device() over devices
+	 * with no ids at all.
+	 */
+	if (!adev->pnp.type.platform_id && adev->pnp.type.hardware_id)
+		score++;
+
 	status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
 	if (status == AE_NOT_FOUND)
-		return FIND_CHILD_MIN_SCORE;
+		return score;
 
 	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_ENABLED))
 		return -ENODEV;
-- 
2.39.0

