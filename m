Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76316BEB5
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 11:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgBYK2H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 05:28:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbgBYK2H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Feb 2020 05:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582626486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FW3JytNzre5px7xTb4SFkBL4h8KNuQAlJJzUt+mc2q8=;
        b=LN1Bc3VBU0oOEx07ZGcV14G1A7m0PSTWSWTT41lwhmA6qjhTyjpOK86geJXlOyLGj1dhH6
        DDsHnfsN3cyUNTpqgCDPjVNrOGv/qYarZHgGhlGGLiEYEa/TJdDwHc1h7RHUBVP+Ash3rw
        zQR/zC7v6jSQJ1c+kI09m2zClJndgGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Svm5HHX3PvGza0KcTE4XFQ-1; Tue, 25 Feb 2020 05:28:04 -0500
X-MC-Unique: Svm5HHX3PvGza0KcTE4XFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF76F107ACC9;
        Tue, 25 Feb 2020 10:28:02 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44CB5101E811;
        Tue, 25 Feb 2020 10:28:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH resend 3/3] gpiolib: acpi: Add quirk to ignore EC gpio wakeups for 1 more HP x2 10 model
Date:   Tue, 25 Feb 2020 11:27:53 +0100
Message-Id: <20200225102753.8351-4-hdegoede@redhat.com>
In-Reply-To: <20200225102753.8351-1-hdegoede@redhat.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are at least 3 variants of the HP x2 10 models:

Bay Trail SoC + AXP288 PMIC
Cherry Trail SoC + AXP288 PMIC
Cherry Trail SoC + TI PMIC

Like on the Bay Trail + AXP288 PMIC model, we also need to ignore wakeups
for the GPIO which is (ab)used for embedded-controller events on the
Cherry Trail + AXP288 PMIC model.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + qui=
rk mech
Reported-and-tested-by: Marc Lehmann <schmorp@schmorp.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 83103efa5862..46b2d74c610c 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1400,6 +1400,21 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] =3D {
 		},
 		.driver_data =3D (void *)QUIRK_IGNORE_WAKE(0x1c),
 	},
+	{
+		/*
+		 * HP X2 10 models with Cherry Trail SoC + AXP288 PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI
+		 * GPIO event handler for pin 0x00, causing spurious wakeups.
+		 * Unlike the Cherry Trail + TI PMIC models, we do want to
+		 * honor the ACPI wake flag on the other GPIOs.
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_MATCH(DMI_BOARD_NAME, "813E"),
+		},
+		.driver_data =3D (void *)QUIRK_IGNORE_WAKE(0x00),
+	},
 	{} /* Terminating entry */
 };
=20
--=20
2.25.1

