Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2C44F37A
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Nov 2021 14:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhKMNzV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 13 Nov 2021 08:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232430AbhKMNzV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 13 Nov 2021 08:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636811535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OlaybinXD5Es5yA/uJQcVayqIZ805F8wENjgLjtUelU=;
        b=jHT+JWEqkQq7aVGCBopwAb8tzxLnTIDL4uIHdodu4fVc27SoYo9p1iC5g0OAXE6EdDeYW0
        zv5noXg2bXnT6Vk+MUCymy6iYrwve7VA/NeIKQUjjl6GSBgRU3+v0NL/b65Pe9w3i/Fo8P
        fDxM3aAa+dT7pOMXNy4eE6+cFO4d03M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-w7tT5k4gPhe_fsZpzLF2hw-1; Sat, 13 Nov 2021 08:52:11 -0500
X-MC-Unique: w7tT5k4gPhe_fsZpzLF2hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 576BE2FD01;
        Sat, 13 Nov 2021 13:52:10 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAC419D9D;
        Sat, 13 Nov 2021 13:52:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] ACPI / x86: Revert: Make PWM2 device always present at Lenovo Yoga Book
Date:   Sat, 13 Nov 2021 14:52:06 +0100
Message-Id: <20211113135206.5384-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It turns out that there is a WMI object which controls the PWM2 device
used for the keyboard backlight and that WMI object also provides some
other useful functionality.

The upcoming lenovo-yogabook-wmi driver will offer both backlight
control and the other functionality, so there no longer is a need
to have the lpss-pwm driver binding to PWM2 for backlight control;
and this is now actually undesirable because this will cause both
the WMI code and the lpss-pwm driver to poke at the same PWM
controller.

Revert commit ff6cdfd71495 ("ACPI / x86: Make PWM2 device always present
at Lenovo Yoga Book"), removing the always-present quirk for the PWM2
ACPI-device, so that the lpss-pwm controller will no longer bind to it.

Cc: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index cb988f9b23a1..bfcb76888ca7 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -54,10 +54,6 @@ static const struct always_present_id always_present_ids[] = {
 	ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
 	ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
 
-	/* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
-	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
-		}),
 	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
 	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
-- 
2.31.1

