Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609B5F156D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfKFLvS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 06:51:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21478 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727652AbfKFLvS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2019 06:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573041077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nLEH9lcnH2lSbcqL7i7SMc6euCO54pLcRyPUEa5TIHs=;
        b=T4rOe7XpacEfq5eKU2Jxr2WGRbw2ljPRrVVy2bCmmYstvMRLwuAcZLYchwBZho8cjlay8E
        CCnAb1uF2jM0NwvgtAdgDEq5Sbqw1ITsj2fYwqlQ9tmwx9bKP2n06Ws/vnNzPQUJstBzk7
        8xMKDpAetpCbAIB+VZs94WX1g1cwzz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-pOTk_qxlP06ID003yIQDCw-1; Wed, 06 Nov 2019 06:51:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B55621800D53;
        Wed,  6 Nov 2019 11:51:12 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-167.ams2.redhat.com [10.36.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5111860BF4;
        Wed,  6 Nov 2019 11:51:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add Terra Pad 1061 to the run_edge_events_on_boot_blacklist
Date:   Wed,  6 Nov 2019 12:51:09 +0100
Message-Id: <20191106115109.119346-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pOTk_qxlP06ID003yIQDCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Terra Pad 1061 has the usual micro-USB-B id-pin handler, but instead
of controlling the actual micro-USB-B it turns the 5V boost for the
tablet's USB-A connector and its keyboard-cover connector off.

The actual micro-USB-B connector on the tablet is wired for charging only,
and its id pin is *not* connected to the GPIO which is used for the
(broken) id-pin event handler in the DSDT.

While at it not only add a comment why the Terra Pad 1061 is on the
blacklist, but also fix the missing comment for the Minix Neo Z83-4 entry.

Fixes: 61f7f7c8f978 ("gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_bo=
ot option and blacklist")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2911dd6f2625..5372652c38eb 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1307,11 +1307,28 @@ late_initcall_sync(acpi_gpio_handle_deferred_reques=
t_irqs);
=20
 static const struct dmi_system_id run_edge_events_on_boot_blacklist[] =3D =
{
 =09{
+=09=09/*
+=09=09 * The Minix Neo Z83-4 has a micro-USB-B id-pin handler for
+=09=09 * a non existing micro-USB-B connector which puts the HDMI
+=09=09 * DDC pins in GPIO mode, breaking HDMI support.
+=09=09 */
 =09=09.matches =3D {
 =09=09=09DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
 =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
 =09=09}
 =09},
+=09{
+=09=09/*
+=09=09 * The Terra Pad 1061 has a micro-USB-B id-pin handler, which
+=09=09 * instead of controlling the actual micro-USB-B turns the 5V
+=09=09 * boost for its USB-A connector off. The actual micro-USB-B
+=09=09 * connector is wired for charging only.
+=09=09 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Wortmann_AG"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "TERRA_PAD_1061"),
+=09=09}
+=09},
 =09{} /* Terminating entry */
 };
=20
--=20
2.23.0

