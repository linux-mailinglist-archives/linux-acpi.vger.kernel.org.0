Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3D025C503
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Sep 2020 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgICPVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Sep 2020 11:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728494AbgICLYX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Sep 2020 07:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599132260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y73Fo+LL3s7ZWkvjroKn4rnnokL4shRdg8EOZEgl13g=;
        b=iJFo0pUwq+PF4nvYWdcZW01y0up5OOOQdzsln/2HBSqWeUbfjnxuawMJBBQ0w29mSKpRTw
        /DbMz722W5LR1f0sl86uPybvdTGvBxEHSSmDbUHlVPbUbRrN/loXCQr5QKeUGfrDOW/89e
        Wqo2YCImoGQZ7Wqe9IDfV6zivP4wSxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-52q8BwU6PuGWcy1tNvY-QA-1; Thu, 03 Sep 2020 07:24:18 -0400
X-MC-Unique: 52q8BwU6PuGWcy1tNvY-QA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E5464087;
        Thu,  3 Sep 2020 11:24:16 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-3.ams2.redhat.com [10.36.113.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6B505C1C2;
        Thu,  3 Sep 2020 11:24:12 +0000 (UTC)
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
Subject: [PATCH v10 09/17] pwm: crc: Fix off-by-one error in the clock-divider calculations
Date:   Thu,  3 Sep 2020 13:23:29 +0200
Message-Id: <20200903112337.4113-10-hdegoede@redhat.com>
In-Reply-To: <20200903112337.4113-1-hdegoede@redhat.com>
References: <20200903112337.4113-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The CRC PWM controller has a clock-divider which divides the clock with
a value between 1-128. But as can seen from the PWM_DIV_CLK_xxx
defines, this range maps to a register value of 0-127.

So after calculating the clock-divider we must subtract 1 to get the
register value, unless the requested frequency was so high that the
calculation has already resulted in a (rounded) divider value of 0.

Note that before this fix, setting a period of PWM_MAX_PERIOD_NS which
corresponds to the max. divider value of 128 could have resulted in a
bug where the code would use 128 as divider-register value which would
have resulted in an actual divider value of 0 (and the enable bit being
set). A rounding error stopped this bug from actually happen. This
same rounding error means that after the subtraction of 1 it is impossible
to set the divider to 128. Also bump PWM_MAX_PERIOD_NS by 1 ns to allow
setting a divider of 128 (register-value 127).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Introduce crc_pwm_calc_clk_div() here instead of later in the patch-set
  to reduce the amount of churn in the patch-set a bit
---
 drivers/pwm/pwm-crc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index c056eb9b858c..44ec7d5b63e1 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -22,7 +22,7 @@
 #define PWM_MAX_LEVEL		0xFF
 
 #define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
-#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
+#define PWM_MAX_PERIOD_NS	5461334	/* 183 Hz */
 
 /**
  * struct crystalcove_pwm - Crystal Cove PWM controller
@@ -39,6 +39,18 @@ static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
 	return container_of(pc, struct crystalcove_pwm, chip);
 }
 
+static int crc_pwm_calc_clk_div(int period_ns)
+{
+	int clk_div;
+
+	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
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
@@ -68,11 +80,10 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 	}
 
 	if (pwm_get_period(pwm) != period_ns) {
-		int clk_div;
+		int clk_div = crc_pwm_calc_clk_div(period_ns);
 
 		/* changing the clk divisor, need to disable fisrt */
 		crc_pwm_disable(c, pwm);
-		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
 
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
-- 
2.28.0

