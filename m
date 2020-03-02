Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE12D17594A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 12:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgCBLMj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 06:12:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727146AbgCBLMi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 06:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583147557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TJmlavzxpo1sG+sGuPYoxsgZCSCYz2PZPuzaP3aV9g=;
        b=FU25M/Kv+SBcGQWGECIhrYZ7/vcQqlU6mZoq9j6Iz4uy7ZwD0bqYVPx2rEjbNkyDF66FL8
        604zYTfKpE44WmlOl4rV4db5XK3+D/r3OaoBk24jle4fO8bqKtnUdwASjuQuI+MNKSuGh+
        YH2oqFZ2drYUfVZzP5CnzAI5bLPU8K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ov0BeJUIO2OiF4XaBZIIlg-1; Mon, 02 Mar 2020 06:12:36 -0500
X-MC-Unique: ov0BeJUIO2OiF4XaBZIIlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEDA13E4;
        Mon,  2 Mar 2020 11:12:34 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 407035D9C9;
        Mon,  2 Mar 2020 11:12:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/4] gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 CHT + AXP288 model
Date:   Mon,  2 Mar 2020 12:12:25 +0100
Message-Id: <20200302111225.6641-4-hdegoede@redhat.com>
In-Reply-To: <20200302111225.6641-1-hdegoede@redhat.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are at least 3 models of the HP x2 10 models:

Bay Trail SoC + AXP288 PMIC
Cherry Trail SoC + AXP288 PMIC
Cherry Trail SoC + TI PMIC

Like on the other HP x2 10 models we need to ignore wakeup for ACPI GPIO
events on the external embedded-controller pin to avoid spurious wakeups
on the HP x2 10 CHT + AXP288 model too.

This commit adds an extra DMI based quirk for the HP x2 10 CHT + AXP288
model, ignoring wakeups for ACPI GPIO events on the EC interrupt pin
on this model. This fixes spurious wakeups from suspend on this model.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + qui=
rk mech
Reported-and-tested-by: Marc Lehmann <schmorp@schmorp.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d1ef060a5873..0017367e94ee 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1437,6 +1437,21 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] =3D {
 			.ignore_wake =3D "INT33FC:02@28",
 		},
 	},
+	{
+		/*
+		 * HP X2 10 models with Cherry Trail SoC + AXP288 PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI GPIO
+		 * event handler on INT33FF:01 pin 0, causing spurious wakeups.
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_MATCH(DMI_BOARD_NAME, "813E"),
+		},
+		.driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake =3D "INT33FF:01@0",
+		},
+	},
 	{} /* Terminating entry */
 };
=20
--=20
2.25.1

