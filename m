Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D231F0DDB
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jun 2020 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgFGSTY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Jun 2020 14:19:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730132AbgFGSTX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2020 14:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4xyCpsnyFP/IgmIE5mjiCG2zWFUJ/yjZ7Igp3ZZReY=;
        b=KttCUWPc/hfEtxRMaW8Awe29P1ewu8R1SBo9c/NWCcRTuGTWgIOz4S4NGVWQ6MAtfu1P/C
        o4g/0wTE+loJLCnkpjVZfbvMN4zeTfLmHLkMeBpwHn5zX0KXg0V8j3m0/0wyTy7ebYwlBR
        JI0mpQ2Yo80vC2AEFdgNIzhp7jF7TCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-iGresnhmPZG6fGIgQ3OmqQ-1; Sun, 07 Jun 2020 14:19:18 -0400
X-MC-Unique: iGresnhmPZG6fGIgQ3OmqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF44E7BAC;
        Sun,  7 Jun 2020 18:19:16 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61B4C5C1BD;
        Sun,  7 Jun 2020 18:19:14 +0000 (UTC)
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
Subject: [PATCH v2 10/15] pwm: crc: Implement apply() method to support the new atomic PWM API
Date:   Sun,  7 Jun 2020 20:18:35 +0200
Message-Id: <20200607181840.13536-11-hdegoede@redhat.com>
In-Reply-To: <20200607181840.13536-1-hdegoede@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the enable, disable and config pwm_ops with an apply op,
to support the new atomic PWM API.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 107 +++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 53734bcf67e1..58c7e9ef7278 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -41,70 +41,81 @@ static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
 	return container_of(pc, struct crystalcove_pwm, chip);
 }
 
-static int crc_pwm_calc_clk_div(int period_ns)
+static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
 {
-	int clk_div;
-
-	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
-	/* clk_div 1 - 128, maps to register values 0-127 */
-	if (clk_div > 0)
-		clk_div--;
-
-	return clk_div;
-}
-
-static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
-{
-	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
-	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
-
-	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
-	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
-
-	return 0;
-}
-
-static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
-{
-	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
-	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
-
-	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
-	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
-}
-
-static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
-{
-	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
+	int err, clk_div, level, pwm_output_enable;
 	struct device *dev = crc_pwm->chip.dev;
-	int level;
 
-	if (period_ns > PWM_MAX_PERIOD_NS) {
+	if (state->period > PWM_MAX_PERIOD_NS) {
 		dev_err(dev, "un-supported period_ns\n");
 		return -EINVAL;
 	}
 
-	if (pwm_get_period(pwm) != period_ns) {
-		int clk_div = crc_pwm_calc_clk_div(period_ns);
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -ENOTSUPP;
+
+	if (pwm_is_enabled(pwm) && !state->enabled) {
+		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
+		if (err) {
+			dev_err(dev, "Error writing BACKLIGHT_EN %d\n", err);
+			return err;
+		}
+	}
+
+	if (pwm_get_duty_cycle(pwm) != state->duty_cycle ||
+	    pwm_get_period(pwm) != state->period) {
+		level = state->duty_cycle * PWM_MAX_LEVEL / state->period;
 
+		err = regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
+		if (err) {
+			dev_err(dev, "Error writing PWM0_DUTY_CYCLE %d\n", err);
+			return err;
+		}
+	}
+
+	if (pwm_is_enabled(pwm) && state->enabled &&
+	    pwm_get_period(pwm) != state->period) {
 		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
-		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
-		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
-					clk_div | PWM_OUTPUT_ENABLE);
+		err = regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
+		if (err) {
+			dev_err(dev, "Error writing PWM0_CLK_DIV %d\n", err);
+			return err;
+		}
 	}
 
-	/* change the pwm duty cycle */
-	level = duty_ns * PWM_MAX_LEVEL / period_ns;
-	regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
+	if (pwm_get_period(pwm) != state->period ||
+	    pwm_is_enabled(pwm) != state->enabled) {
+		clk_div = PWM_BASE_CLK_MHZ * state->period /
+			  (256 * NSEC_PER_MHZ);
+		/* clk_div 1 - 128, maps to register values 0-127 */
+		if (clk_div > 0)
+			clk_div--;
+
+		pwm_output_enable = state->enabled ? PWM_OUTPUT_ENABLE : 0;
+
+		err = regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
+				   clk_div | pwm_output_enable);
+		if (err) {
+			dev_err(dev, "Error writing PWM0_CLK_DIV %d\n", err);
+			return err;
+		}
+	}
+
+	if (!pwm_is_enabled(pwm) && state->enabled) {
+		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
+		if (err) {
+			dev_err(dev, "Error writing BACKLIGHT_EN %d\n", err);
+			return err;
+		}
+	}
 
 	return 0;
 }
 
 static const struct pwm_ops crc_pwm_ops = {
-	.config = crc_pwm_config,
-	.enable = crc_pwm_enable,
-	.disable = crc_pwm_disable,
+	.apply = crc_pwm_apply,
 };
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
-- 
2.26.2

