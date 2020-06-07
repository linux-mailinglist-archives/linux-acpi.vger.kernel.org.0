Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D31F0DD5
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jun 2020 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgFGSTS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Jun 2020 14:19:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730116AbgFGSTQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2020 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzR5wJk9hqmAJndMjPuTZRIr7gmgMinW4Tv3VnbU63Q=;
        b=CEHfDl4J35rQzmtq8qyMe3obpNWvu2NQRpAzpaeP4n9KFbUunpzuD8dhB5FwOB4q99/cgF
        O/U2IBKbx0XzfH1NGhf90q4T1YTL8slfKXoyYzPlJHYQFeg7rFtGG6+aJ232H/U42SpBGq
        OInJkgTtd/5K6EB0az9GpggzuOymAIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Dlo-8yqPM_S6Y7K1Z09CFA-1; Sun, 07 Jun 2020 14:19:13 -0400
X-MC-Unique: Dlo-8yqPM_S6Y7K1Z09CFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0AD80B70A;
        Sun,  7 Jun 2020 18:19:11 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D21115C1BD;
        Sun,  7 Jun 2020 18:19:08 +0000 (UTC)
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
Subject: [PATCH v2 08/15] pwm: crc: Fix period changes not having any effect
Date:   Sun,  7 Jun 2020 20:18:33 +0200
Message-Id: <20200607181840.13536-9-hdegoede@redhat.com>
In-Reply-To: <20200607181840.13536-1-hdegoede@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pwm-crc code is using 2 different enable bits:
1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
2. bit 0 of the BACKLIGHT_EN register

I strongly suspect that the BACKLIGHT_EN register at address 0x51 really
controls a separate output-only GPIO which is connected to the LCD panels
backlight-enable input. Like how the PANEL_EN register at address 0x52
controls an output-only GPIO which is earmarked for the LCD panel's
enable pin. If this is correct then this GPIO should really be added to
the gpio-crystalcove.c driver and the PWM driver should stop poking it.
But I've been unable to come up with a definitive answer here, so I'm
keeping this as is for now.

As the comment in the old code already indicates we must disable the PWM
before we can change the clock divider. But the crc_pwm_disable() and
crc_pwm_enable() calls the old code make for this only change the
BACKLIGHT_EN register; and the value of that register does not matter for
changing the period / the divider. What does matter is that the
PWM_OUTPUT_ENABLE bit must be cleared before a new value can be written.

This commit modifies crc_pwm_config() to clear PWM_OUTPUT_ENABLE instead
when changing the period, so that period changes actually work.

Note this fix will cause a significant behavior change on some devices
using the CRC PWM output to drive their backlight. Before the PWM would
always run with the output frequency configured by the BIOS at boot, now
the period time specified by the i915 driver will actually be honored.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 5ba2a65c524c..ef49a6e3c4d6 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -72,8 +72,9 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 	if (pwm_get_period(pwm) != period_ns) {
 		int clk_div;
 
-		/* changing the clk divisor, need to disable fisrt */
-		crc_pwm_disable(c, pwm);
+		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
+		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
+
 		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
 		/* clk_div 1 - 128, maps to register values 0-127 */
 		if (clk_div > 0)
@@ -81,9 +82,6 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
-
-		/* enable back */
-		crc_pwm_enable(c, pwm);
 	}
 
 	/* change the pwm duty cycle */
-- 
2.26.2

