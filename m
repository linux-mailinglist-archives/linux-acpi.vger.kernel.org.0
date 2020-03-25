Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F01925EA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 11:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCYKkH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 06:40:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29317 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbgCYKkH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Mar 2020 06:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585132806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/jKQY/v3TwgChoX1/mwdlEYnDrnQ21fmszGm2dRlcU=;
        b=R9LbvC/MvnRxyjqLuscUkK5zBT6z8oTPZkujsj0cslUhjUylX0HMRYfstVwEVN/f4Y3e/Y
        6OMG7L/fewoL/N//Yosah8KR9bB9JeMWva7r/fMzRvDOq/x2w0cD9MF8M27H5gunqXq3Zb
        1YtgjdG+luhvEeYxyCmep7Xue/NOZg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-maCLJrR3NPaCbcypwcHXmA-1; Wed, 25 Mar 2020 06:40:02 -0400
X-MC-Unique: maCLJrR3NPaCbcypwcHXmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 253138017DF;
        Wed, 25 Mar 2020 10:40:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-75.ams2.redhat.com [10.36.115.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87BD1BBBE5;
        Wed, 25 Mar 2020 10:39:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH resend] gpiolib: acpi: Add missing __init(const) markers to initcall-s
Date:   Wed, 25 Mar 2020 11:39:56 +0100
Message-Id: <20200325103956.109284-2-hdegoede@redhat.com>
In-Reply-To: <20200325103956.109284-1-hdegoede@redhat.com>
References: <20200325103956.109284-1-hdegoede@redhat.com>
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

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
2.26.0.rc2

