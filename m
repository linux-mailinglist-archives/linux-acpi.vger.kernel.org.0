Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC141F0DBD
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jun 2020 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgFGSSz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Jun 2020 14:18:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730068AbgFGSSy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2020 14:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFSbgw+jMLXkeGeVQko9oA8LjxZw2ty0U8jf3NzNvyw=;
        b=BIvw9RizWQKdEr4qAXv6K2xwq03/3MiJYE8Yfv1NX4yX2huYQzoQpfC3rx6lLnbGW+z4+i
        qHmuqz9HrdvcfnOlPFC6LxinHFKM1XotxVTW9OeCilXJObg2Rm0lxMmGWl+QiATyetW4Uk
        9m2GGu0tXLpWycDTnVuxCMFosancbqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-NXJpie8tPKu-bZrlBUJo-w-1; Sun, 07 Jun 2020 14:18:51 -0400
X-MC-Unique: NXJpie8tPKu-bZrlBUJo-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ABFB7BAC;
        Sun,  7 Jun 2020 18:18:49 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 235DD5C1BD;
        Sun,  7 Jun 2020 18:18:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 01/15] ACPI / LPSS: Resume Cherry Trail PWM controller in no-irq phase
Date:   Sun,  7 Jun 2020 20:18:26 +0200
Message-Id: <20200607181840.13536-2-hdegoede@redhat.com>
In-Reply-To: <20200607181840.13536-1-hdegoede@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The DSDTs on most Cherry Trail devices have an ugly clutch where the PWM
controller gets poked from the _PS0 method of the graphics-card device:

	Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
	If (((Local0 & 0x03) == 0x03))
	{
	    PSAT &= 0xFFFFFFFC
	    Local1 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
	    RSTA = Zero
	    RSTF = Zero
	    RSTA = One
	    RSTF = One
	    PWMB |= 0xC0000000
	    PWMC = PWMB /* \_SB_.PCI0.GFX0.PWMB */
	}

Where PSAT is the power-status register of the PWM controller, so if it
is in D3 when the GFX0 device's PS0 method runs then it will turn it on
and restore the PWM ctrl register value it saved from its PS3 handler.
Note not only does it restore it, it ors it with 0xC0000000 turning it
on at a time where we may not want it to get turned on at all.

The pwm_get call which the i915 driver does to get a reference to the
PWM controller, already adds a device-link making the GFX0 device a
consumer of the PWM device. So it should already have been resumed when
the above AML runs and the AML should thus not do its undesirable poking
of the PWM controller register.

But the PCI core powers on PCI devices in the no-irq resume phase and
thus calls the troublesome PS0 method in the no-irq resume phase.
Where as LPSS devices by default are resumed in the early resume phase.

This commit sets the resume_from_noirq flag in the bsw_pwm_dev_desc
struct, so that Cherry Trail PWM controllers will be resumed in the
no-irq phase. Together with the device-link added by the pwm-get this
ensures that the PWM controller will be on when the troublesome PS0
method runs, which stops it from poking the PWM controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 5e2bfbcf526f..67892fc0b822 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -257,6 +257,7 @@ static const struct lpss_device_desc bsw_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
 	.prv_offset = 0x800,
 	.setup = bsw_pwm_setup,
+	.resume_from_noirq = true,
 };
 
 static const struct lpss_device_desc byt_uart_dev_desc = {
-- 
2.26.2

