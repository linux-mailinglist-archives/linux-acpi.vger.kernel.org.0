Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790B417C0D3
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFOrg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 09:47:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbgCFOrf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2020 09:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583506051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yhpVk++MgudHcvpslxpK/BIUu9Ii09q0rWMNLFp+cOE=;
        b=A584X6Z24H5O9gUMzqXY0kNlmf88LzsmRuxOBQRw4e5zpCnKiL+/LkSPjpXSDD9sSdbE6n
        1S9fK/AGQnpPMV6isWxWH60Jtp3SyZXbeviZNhYQdRN0Vbj1BXlHQSMMeIB9E/jIrcsJV9
        VaQ/siPX+QJIcqjlkCw9p6b8v8Bb2IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-j4JDQbCKN0OZkk-BaHx0uA-1; Fri, 06 Mar 2020 09:47:28 -0500
X-MC-Unique: j4JDQbCKN0OZkk-BaHx0uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40EF31085935;
        Fri,  6 Mar 2020 14:47:26 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B98991D8E;
        Fri,  6 Mar 2020 14:47:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add missing __init(const) markers to initcall-s
Date:   Fri,  6 Mar 2020 15:47:22 +0100
Message-Id: <20200306144722.175298-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The gpiolib ACPI code uses 2 initcall-s and the called function
(and used DMI table) is missing __init(const) markers.

This commit fixes this freeing up some extra memory once the kernel
has completed booting.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 0017367e94ee..9276051663da 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1353,7 +1353,7 @@ int acpi_gpio_count(struct device *dev, const char =
*con_id)
 }
=20
 /* Run deferred acpi_gpiochip_request_irqs() */
-static int acpi_gpio_handle_deferred_request_irqs(void)
+static int __init acpi_gpio_handle_deferred_request_irqs(void)
 {
 	struct acpi_gpio_chip *acpi_gpio, *tmp;
=20
@@ -1371,7 +1371,7 @@ static int acpi_gpio_handle_deferred_request_irqs(v=
oid)
 /* We must use _sync so that this runs after the first deferred_probe ru=
n */
 late_initcall_sync(acpi_gpio_handle_deferred_request_irqs);
=20
-static const struct dmi_system_id gpiolib_acpi_quirks[] =3D {
+static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst =3D =
{
 	{
 		/*
 		 * The Minix Neo Z83-4 has a micro-USB-B id-pin handler for
@@ -1455,7 +1455,7 @@ static const struct dmi_system_id gpiolib_acpi_quir=
ks[] =3D {
 	{} /* Terminating entry */
 };
=20
-static int acpi_gpio_setup_params(void)
+static int __init acpi_gpio_setup_params(void)
 {
 	const struct acpi_gpiolib_dmi_quirk *quirk =3D NULL;
 	const struct dmi_system_id *id;
--=20
2.25.1

