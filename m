Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730EA1F0DD8
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jun 2020 20:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFGSTU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Jun 2020 14:19:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42957 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730113AbgFGSTT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2020 14:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQY8iWdUxeaJSt6cQARP9fYgzH7R1SLcHzNz2kLwBS0=;
        b=VszBbYXt2PrEpPGJTqwDme7PNPSyUwg1aDlknxLCJdBqSq2QgLJTeGzFNnYnpnflkGCmj3
        6khT3qC9f94tBEfzWuHf4HZHIdeiNSQ2fa0KSCUK/HVn6FUJ70oDZONg7pDNllL5cWCaS/
        DFW3T0rWc/MIsRVhppHPp05OJYRcZS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-97ED1xytN9CaHIlM8AERcg-1; Sun, 07 Jun 2020 14:19:15 -0400
X-MC-Unique: 97ED1xytN9CaHIlM8AERcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADD8107ACCA;
        Sun,  7 Jun 2020 18:19:14 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9629C5C1BD;
        Sun,  7 Jun 2020 18:19:11 +0000 (UTC)
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
Subject: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on enable/disable
Date:   Sun,  7 Jun 2020 20:18:34 +0200
Message-Id: <20200607181840.13536-10-hdegoede@redhat.com>
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

So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
this commit makes crc_pwm_disable() clear it on disable and makes
crc_pwm_enable() set it again on re-enable.

This should disable the internal (divided) PWM clock and tri-state the
PWM output pin when disabled, saving some power.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index ef49a6e3c4d6..53734bcf67e1 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -41,10 +41,24 @@ static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
 	return container_of(pc, struct crystalcove_pwm, chip);
 }
 
+static int crc_pwm_calc_clk_div(int period_ns)
+{
+	int clk_div;
+
+	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
+	/* clk_div 1 - 128, maps to register values 0-127 */
+	if (clk_div > 0)
+		clk_div--;
+
+	return clk_div;
+}
+
 static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
 
 	return 0;
@@ -53,8 +67,10 @@ static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
 }
 
 static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
@@ -70,16 +86,10 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 	}
 
 	if (pwm_get_period(pwm) != period_ns) {
-		int clk_div;
+		int clk_div = crc_pwm_calc_clk_div(period_ns);
 
 		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
-
-		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
-		/* clk_div 1 - 128, maps to register values 0-127 */
-		if (clk_div > 0)
-			clk_div--;
-
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
 	}
-- 
2.26.2

