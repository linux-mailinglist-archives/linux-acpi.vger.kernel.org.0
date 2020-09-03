Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A628E25BFA6
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Sep 2020 12:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgICKwc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Sep 2020 06:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728331AbgICKv4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Sep 2020 06:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599130304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVk4/afJyWb9pRR5r2+53kQrVqN8NW1p5YVuK1f/Xj0=;
        b=gsw9799jYx3RRNmwN7fMHLspS91uJ250sSRrjQ0cQ4bbKqp1a8arxoc2TTNSIfZcfstU8f
        FqF/tviK6Ga5pDwQJW3Q5mDCapImtzUrAK+zOnUdp5tFiz2FwFnNhRNc6R7HS8H0v0nI5q
        K1SA0bpIRwD+GlKS56irELPONTeQDUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-2Rz00j7dMPaimYbtNsUGlw-1; Thu, 03 Sep 2020 06:51:41 -0400
X-MC-Unique: 2Rz00j7dMPaimYbtNsUGlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B9301091062;
        Thu,  3 Sep 2020 10:51:39 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-4.ams2.redhat.com [10.36.115.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 858D6784A8;
        Thu,  3 Sep 2020 10:51:36 +0000 (UTC)
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
Subject: [PATCH v9 06/17] pwm: lpss: Make pwm_lpss_apply() not rely on existing hardware state
Date:   Thu,  3 Sep 2020 12:51:03 +0200
Message-Id: <20200903105114.9969-7-hdegoede@redhat.com>
In-Reply-To: <20200903105114.9969-1-hdegoede@redhat.com>
References: <20200903105114.9969-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Before this commit pwm_lpss_apply() was making 2 assuming
2 pre-conditions were met by the existing hardware state:

1. That the base-unit and on-time-div read back from the
control register are those actually in use, so that it
can skip setting the update bit if the read-back value
matches the desired values.

2. That the controller is enabled when the cached
pwm_state.enabled says that the controller is enabled.

As the long history of fixes for subtle (often suspend/resume)
lpss-pwm issues shows, this assumptions are not necessary
always true.

1. Specifically is not true on some (*) Cherry Trail devices
with a nasty GFX0._PS3 method which: a. saves the ctrl reg value.
b. sets the base-unit to 0 and writes the update bit to apply/commit
c. restores the original ctrl value without setting the update bit,
so that the 0 base-unit value is still in use.

2. Assumption 2. currently is true, but only because of the code which
saves/restores the state on suspend/resume. By convention restoring the
PWM state should be done by the PWM consumer and the presence of this
code in the pmw-lpss driver is a bug. Therefor the save/restore code will
be dropped in the next patch in this series, after which this assumption
also is no longer true.

This commit changes the pwm_lpss_apply() to make any assumptions about the
state the hardware is in. Instead it makes pwm_lpss_apply() always fully
program the PWM controller, making it much less fragile.

*) Seen on the Acer One 10 S1003, Lenovo Ideapad Miix 310 and 320 models
and various Medion models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 8a136ba2a583..9c5c7217c9b6 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -85,7 +85,7 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	unsigned long long on_time_div;
 	unsigned long c = lpwm->info->clk_rate, base_unit_range;
 	unsigned long long base_unit, freq = NSEC_PER_SEC;
-	u32 orig_ctrl, ctrl;
+	u32 ctrl;
 
 	do_div(freq, period_ns);
 
@@ -104,16 +104,14 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	do_div(on_time_div, period_ns);
 	on_time_div = 255ULL - on_time_div;
 
-	orig_ctrl = ctrl = pwm_lpss_read(pwm);
+	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~PWM_ON_TIME_DIV_MASK;
 	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 
-	if (orig_ctrl != ctrl) {
-		pwm_lpss_write(pwm, ctrl);
-		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
-	}
+	pwm_lpss_write(pwm, ctrl);
+	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
 }
 
 static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
@@ -124,8 +122,7 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 
 static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
 				   struct pwm_device *pwm,
-				   const struct pwm_state *state,
-				   bool enable)
+				   const struct pwm_state *state)
 {
 	int ret;
 
@@ -134,12 +131,12 @@ static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
 		return ret;
 
 	pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == false);
+	pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
 	ret = pwm_lpss_wait_for_update(pwm);
 	if (ret)
 		return ret;
 
-	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == true);
+	pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
 	return 0;
 }
 
@@ -152,11 +149,11 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
 			pm_runtime_get_sync(chip->dev);
-			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
+			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 			if (ret)
 				pm_runtime_put(chip->dev);
 		} else {
-			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
+			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-- 
2.28.0

