Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934C612A832
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2019 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfLYN0b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Dec 2019 08:26:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38499 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbfLYN0a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Dec 2019 08:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577280389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L7WSXUXrDekyyxHlOvSluDf8OYKM0nQS2GsCYmkQvfs=;
        b=eWbwpbZwq1xJgpuPjrVmJIoGLKClMpQR6nuwrUMxDTN+K8axBYxjQd6fRd8wtl1QB1Ez35
        GXI8pDz6/YFuNcv6OhNAaS/Lf9jDGjRmkmr1G4/G6pzGr2BBMlEJLRcgxIiombDqbAoiCd
        9ZMbJbpZho3X9P2N0Sfauc5kEWJ1Glk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-E7SwG9ruPRS9PROKPPYGHg-1; Wed, 25 Dec 2019 08:26:27 -0500
X-MC-Unique: E7SwG9ruPRS9PROKPPYGHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 421B3801E6C;
        Wed, 25 Dec 2019 13:26:26 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-79.ams2.redhat.com [10.36.116.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5402E19C5B;
        Wed, 25 Dec 2019 13:26:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] pinctrl: baytrail: Remove WARN when setting direct-irq pin to output
Date:   Wed, 25 Dec 2019 14:26:22 +0100
Message-Id: <20191225132622.90592-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Suspending Goodix touchscreens requires changing the interrupt pin to
output before sending them a power-down command. Followed by wiggling
the interrupt pin to wake the device up, after which it is put back
in input mode.

On Cherry Trail device the interrupt pin is listed as a GpioInt ACPI
resource so we can do this without problems as long as we release the
irq before changing the pin to output mode.

On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
in combination with listing the pin as a normal GpioIo resource. This
works fine, but this triggers the WARN in byt_gpio_set_direction-s output
path because direct-irq support is enabled on the pin.

This commit removes the WARN call, fixing a bunch of WARN splats in
dmesg on each suspend/resume cycle.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/i=
ntel/pinctrl-baytrail.c
index c6f53ed626c9..e7cdfdb4a189 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -811,15 +811,7 @@ static int byt_gpio_set_direction(struct pinctrl_dev=
 *pctl_dev,
 	value &=3D ~BYT_DIR_MASK;
 	if (input)
 		value |=3D BYT_OUTPUT_EN;
-	else
-		/*
-		 * Before making any direction modifications, do a check if gpio
-		 * is set for direct IRQ.  On baytrail, setting GPIO to output
-		 * does not make sense, so let's at least warn the caller before
-		 * they shoot themselves in the foot.
-		 */
-		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
-		     "Potential Error: Setting GPIO with direct_irq_en to output");
+
 	writel(value, val_reg);
=20
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
--=20
2.24.1

