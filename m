Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128D321922B
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jul 2020 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgGHVPi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Jul 2020 17:15:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44646 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgGHVPi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2020 17:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594242937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SL1iJkgudXbiRt+5sdrta73DHy47gF0CgIrRX8IsQec=;
        b=NU7lpJXM87W+8ItGvbG4f2KoQFuEw2foeP8CGjmzWO0hI71ivX2aS65cIvd5pAzWY21TXh
        UQTndsjHkX962CqREwkwBQXV6LfSnY1XryPtnSsImymbEcNf/IYSU4kwOOA4G7DJw6ul24
        8K/BPFaXn2CtvEZxPs15PXR3UKE1c2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Ml043AWOPZ-gl2emQgT6AA-1; Wed, 08 Jul 2020 17:15:33 -0400
X-MC-Unique: Ml043AWOPZ-gl2emQgT6AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D3F802780;
        Wed,  8 Jul 2020 21:15:31 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-5.ams2.redhat.com [10.36.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 614B9797F2;
        Wed,  8 Jul 2020 21:15:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
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
Subject: [PATCH v4 12/16] pwm: crc: Implement get_state() method
Date:   Wed,  8 Jul 2020 23:14:28 +0200
Message-Id: <20200708211432.28612-13-hdegoede@redhat.com>
In-Reply-To: <20200708211432.28612-1-hdegoede@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Implement the pwm_ops.get_state() method to complete the support for the
new atomic PWM API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- Use DIV_ROUND_UP when calculating the period and duty_cycle from the
  controller's register values

Changes in v3:
- Add Andy's Reviewed-by tag
- Remove extra whitespace to align some code after assignments (requested by
  Uwe Kleine-König)
---
 drivers/pwm/pwm-crc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 8a7f4707279c..e58b0979d708 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -119,8 +119,39 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
+	struct device *dev = crc_pwm->chip.dev;
+	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
+	int error;
+
+	error = regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
+	if (error) {
+		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
+		return;
+	}
+
+	error = regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg);
+	if (error) {
+		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
+		return;
+	}
+
+	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
+
+	state->period =
+		DIV_ROUND_UP(clk_div * NSEC_PER_USEC * 256, PWM_BASE_CLK_MHZ);
+	state->duty_cycle =
+		DIV_ROUND_UP(duty_cycle_reg * state->period, PWM_MAX_LEVEL);
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = !!(clk_div_reg & PWM_OUTPUT_ENABLE);
+}
+
 static const struct pwm_ops crc_pwm_ops = {
 	.apply = crc_pwm_apply,
+	.get_state = crc_pwm_get_state,
 };
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
-- 
2.26.2

