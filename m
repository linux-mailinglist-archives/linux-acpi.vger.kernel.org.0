Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25F4593AA
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhKVRJM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238011AbhKVRJM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHRVk9mwl6o7eTVfhuIFOGogtA4RddRE1ivJhOTwi8o=;
        b=dcBXhNWQu9zL7ORUJ+QVnpea+VPCwTD0F1zNDw0dzBd0hUePd5p8Zd2QIMr56pbPJEk+py
        YcGTxFcgrKgVptkTMkjRmhpy3IKcWqBve1PIm+VH5X0jHXFZ3HDbW/Szk7WAr9hCm3+YoG
        +wtdftvpLoOn2WCMmjoLdt9MsdEOx6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-IeYhJ6DdP0uek1prr0GYrw-1; Mon, 22 Nov 2021 12:05:59 -0500
X-MC-Unique: IeYhJ6DdP0uek1prr0GYrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED3D91B18BC0;
        Mon, 22 Nov 2021 17:05:57 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 609775D6D5;
        Mon, 22 Nov 2021 17:05:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 5/7] ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list
Date:   Mon, 22 Nov 2021 18:05:34 +0100
Message-Id: <20211122170536.7725-6-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
References: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Xiaomi Mi Pad 2 has backlit LEDs behind the capacitive menu, home
and back buttons below the screen which are controlled by the PWM2
controller of the CHT SoC. This PWM2 controller gets hidden by the
firmware, add it to the always_present_ids table so that we can use
the PWM controller to control the backlighting of the buttons.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rebase on top of other patches in this series
- Add to this series since it now relies on other patches from this series
---
 drivers/acpi/x86/utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index b3fb428461c6..a2ae1ac41319 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -71,6 +71,12 @@ static const struct override_status_id override_status_ids[] = {
 	PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
 	PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
 
+	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
+	PRESENT_ENTRY_HID("80862289", "2", ATOM_AIRMONT, {
+		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+	      }),
+
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
-- 
2.33.1

