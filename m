Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8154351DC8
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhDASb7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 14:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240307AbhDASaC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 14:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617301802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BYqcPFvd7erxJJQksdxDiamrI2D3JHsuC1F2bJEaarg=;
        b=N7a7d+h9Wh+JtGP5gAlbib4fomLJLF/DDXYj2taiBobbrzhxIo9qjx6SSJ4Rm0lvEAI+/X
        RkW1atvlBk1oqkywnb07ofFy/ZL9BujwB3FHjDXc9CTbp97SYLsjsQ4NprdF7hd+qY1Vq0
        QyAWKAQGC9YvsEzs2dydaLGTimt2lSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-yFeNfdZDMlazm9Y6sTUXBg-1; Thu, 01 Apr 2021 12:27:44 -0400
X-MC-Unique: yFeNfdZDMlazm9Y6sTUXBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B1EBA0CA0;
        Thu,  1 Apr 2021 16:27:42 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-79.ams2.redhat.com [10.36.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD5517BB6;
        Thu,  1 Apr 2021 16:27:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add quirk to ignore EC wakeups on Dell Venue 10 Pro 5055
Date:   Thu,  1 Apr 2021 18:27:40 +0200
Message-Id: <20210401162740.4602-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Like some other Bay and Cherry Trail SoC based devices the Dell Venue
10 Pro 5055 has an embedded-controller which uses ACPI GPIO events to
report events instead of using the standard ACPI EC interface for this.

The EC interrupt is only used to report battery-level changes and
it keeps doing this while the system is suspended, causing the system
to not stay suspended.

Add an ignore-wake quirk for the GPIO pin used by the EC to fix the
spurious wakeups from suspend.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 1aacd2a5a1fd..174839f3772f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1438,6 +1438,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.no_edge_events_on_boot = true,
 		},
 	},
+	{
+		/*
+		 * The Dell Venue 10 Pro 5055, with Bay Trail SoC + TI PMIC uses an
+		 * external embedded-controller connected via I2C + an ACPI GPIO
+		 * event handler on INT33FFC:02 pin 12, causing spurious wakeups.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 10 Pro 5055"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "INT33FC:02@12",
+		},
+	},
 	{
 		/*
 		 * HP X2 10 models with Cherry Trail SoC + TI PMIC use an
-- 
2.30.2

