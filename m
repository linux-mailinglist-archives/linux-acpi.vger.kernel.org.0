Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6E175948
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCBLMh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 06:12:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbgCBLMh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 06:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583147555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51M0hz7eWo18fQGg2vxHhABcHcFJDcVUuKLU3QKmQP8=;
        b=CnSstQ+ckp7FtBRoCivWeq/88kK6TFSsDu5I7LqJMh5EY/oQ3V1FlKx79gfn8rAwbIYR/L
        rxZZBpc3g+6sHP7KF5+503CfcCKTkUWp7ukA/gXuTymcE4ZG8f885hAM6MXoXUTvVYzJ0Q
        x09uxTl4CzD3QTP+M9OU0wQWVXnzmYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-hZ6Q3mUJNg6nspnlGpFQAg-1; Mon, 02 Mar 2020 06:12:34 -0500
X-MC-Unique: hZ6Q3mUJNg6nspnlGpFQAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDE841005510;
        Mon,  2 Mar 2020 11:12:32 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 649145D9C9;
        Mon,  2 Mar 2020 11:12:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 3/4] gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 BYT + AXP288 model
Date:   Mon,  2 Mar 2020 12:12:24 +0100
Message-Id: <20200302111225.6641-3-hdegoede@redhat.com>
In-Reply-To: <20200302111225.6641-1-hdegoede@redhat.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
quirk mechanism") was added to deal with spurious wakeups on one specific
model of the HP x2 10 series. In the mean time I have learned that there
are at least 3 different HP x2 10 models:

Bay Trail SoC + AXP288 PMIC
Cherry Trail SoC + AXP288 PMIC
Cherry Trail SoC + TI PMIC

And the original quirk is only correct for (and only matches the)
Cherry Trail SoC + TI PMIC model.

The Bay Trail SoC + AXP288 PMIC model has different DMI strings, has
the external EC interrupt on a different GPIO pin and only needs to ignor=
e
wakeups on the EC interrupt, the INT0002 device works fine on this model.

This commit adds an extra DMI based quirk for the HP x2 10 BYT + AXP288
model, ignoring wakeups for ACPI GPIO events on the EC interrupt pin
on this model. This fixes spurious wakeups from suspend on this model.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + qui=
rk mechanism")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Split out new quirk addition into its own patch
---
 drivers/gpio/gpiolib-acpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 87bb0d3c69da..d1ef060a5873 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1422,6 +1422,21 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] =3D {
 			.ignore_wake =3D "INT33FF:01@0,INT0002:00@2",
 		},
 	},
+	{
+		/*
+		 * HP X2 10 models with Bay Trail SoC + AXP288 PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI GPIO
+		 * event handler on INT33FC:02 pin 28, causing spurious wakeups.
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_MATCH(DMI_BOARD_NAME, "815D"),
+		},
+		.driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake =3D "INT33FC:02@28",
+		},
+	},
 	{} /* Terminating entry */
 };
=20
--=20
2.25.1

