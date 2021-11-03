Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2950544436F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKCO3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 10:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230527AbhKCO3F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 10:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635949588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jP6b0RUIDTDajSxVoCaZFOoKEg+suRFFqbiKNM+LcL0=;
        b=XKHpgzq0AhqUlAi4q0Rnfh85e4ezF0pHyiWUY9woz6yZNjF7AJeAgicb7OZTW9mtNhYPUe
        mhUGpzuly2Hyvf51RC/Nmb218k/bwkROvRNybMzMzWtlEfGARMhsf6v9ecc5SOopqQaDiN
        hGKw9N3uls1PRcNVt6rVPzgZc1zLtU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-T5Hmju_JOT2NwfSeW3fkvg-1; Wed, 03 Nov 2021 10:26:25 -0400
X-MC-Unique: T5Hmju_JOT2NwfSeW3fkvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD9787D542;
        Wed,  3 Nov 2021 14:26:24 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.195.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0381E5C1D5;
        Wed,  3 Nov 2021 14:26:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: video: use platform backlight driver on Xiaomi Mi Pad 2
Date:   Wed,  3 Nov 2021 15:26:20 +0100
Message-Id: <20211103142620.36480-2-hdegoede@redhat.com>
In-Reply-To: <20211103142620.36480-1-hdegoede@redhat.com>
References: <20211103142620.36480-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Xiaomi Mi Pad 2 is a Cherry Trail based x86 tablet which does not
use the i915's driver backlight control support:
 i915 0000:00:02.0: [drm:intel_panel_setup_backlight [i915]] no backlight present per VBT

Like all Cherry Trail devices the ACPI tables on the Xiaomi Mi Pad 2
contain a broken ACPI-video implementation which causes 6 different
acpi_video backlights to get registered when used.

The lack of the i915 driver registering a BACKLIGHT_RAW (aka native) type
backlight causes acpi_video_get_backlight_type() to pick the broken
acpi_video backlight code as the backlight driver to use.

There actually is a separate lp8556 backlight controller connected
over I2C which gets registered as a BACKLIGHT_PLATFORM (aka vendor).

Add a quirk to force acpi_video_get_backlight_type() to return
acpi_backlight_vendor, so that the broken acpi_video backlight
interfaces do not get registered.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 7a1f8e823208..068e393ea0c6 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -154,6 +154,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	/* Xiaomi Mi Pad 2 */
+	.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+	},
 
 	/*
 	 * These models have a working acpi_video backlight control, and using
-- 
2.31.1

