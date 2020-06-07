Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253981F0DC9
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jun 2020 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgFGSTJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Jun 2020 14:19:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730099AbgFGSTI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2020 14:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2T3eRMbyvrcLqFR6Ify+n4ofIKOt8s+1Ga6XZ53Ws0g=;
        b=NRJ3eVblCWQwJms90/vSrLgkLUFvgUHSajY6OP/rfFhd+uH2pFmtBFOeJ5OQjyAsoghdE2
        xBLkEHQeiEAtTrHlwPDvER287GBcTiIzzooBxCHwp0N8xqIxKIDpp5R2qX+2oEkTakCGHq
        latz9cpgJf/LcjlMTfzpIyJnuxiPilA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-D8qt0zuLPa6G1IRqiXZPDQ-1; Sun, 07 Jun 2020 14:19:03 -0400
X-MC-Unique: D8qt0zuLPa6G1IRqiXZPDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CA7880B70A;
        Sun,  7 Jun 2020 18:19:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DEA35C1BD;
        Sun,  7 Jun 2020 18:18:58 +0000 (UTC)
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
Subject: [PATCH v2 05/15] pwm: lpss: Set SW_UPDATE bit when enabling the PWM
Date:   Sun,  7 Jun 2020 20:18:30 +0200
Message-Id: <20200607181840.13536-6-hdegoede@redhat.com>
In-Reply-To: <20200607181840.13536-1-hdegoede@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On the LPSS PWM controller found on Bay Trail (BYT) and Cherry Trail (CHT)
platforms, the following sequence results in an output duty-cycle of 100%
independent of what the duty-cycle requested in the ctrl-reg is:

1. Clear ENABLE bit in ctrl register
2. Let the machine reach a S0i3 low power state
3. Set the ENABLE bit in the ctrl register

The LPSS PWM controller has a mechanism where the ctrl register value
and the actual base-unit and on-time-div values used are latched. When
software sets the SW_UPDATE bit then at the end of the current PWM cycle,
the new values from the ctrl-register will be latched into the actual
registers, and the SW_UPDATE bit will be cleared.  Note on BYT and CHT
the ENABLE bit must be set before waiting for the SW_UPDATE bit to clear,
otherwise the SW_UPDATE bit will never clear (this is indicated in the
pwm-lpss.c code by lpwm->info->bypass being false).

My theory about why this is happening is that when we hit S0i3 the part
which holds the latched values gets turned off and when its turned back on
again at least the on-time-div value has been lost and gets reset to 0
which corresponds to an output duty-cycle of 100%. Testing has shown that
setting the SW_UPDATE bit to request latching the ctrl-register values into
the actual registers (again) fixes this, confirming this theory.

In the past there have been issues where setting the SW_UPDATE bit when
nothing has changed would lead to the next ctrl register changing being
ignored, see commit 2153bbc12f77 ("pwm: lpss: Only set update bit if we are
actually changing the settings"), so we should only set the SW_UPDATE bit
when actually changing the ENABLE bit from 0 to 1.

When looking into how to fix this I noticed that on platforms where
lpwm->info->bypass == false we unnecessarily do 2 read-modify-write cycles
of the ctrl register, one to set the base-unit and on-time-div, immediately
followed by another to set the ENABLE bit.

This commit fixes the 100% duty cycle issue by folding the setting of the
ENABLE bit into pwm_lpss_prepare(), which already checks if any bits in
the ctrl-register have actually changed and if that is the case then sets
the SW_UPDATE bit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index a764e062103b..2cb0e2a9c08c 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -80,7 +80,7 @@ static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
 }
 
 static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+			     int duty_ns, int period_ns, bool enable)
 {
 	unsigned long long on_time_div;
 	unsigned long c = lpwm->info->clk_rate, base_unit_range;
@@ -115,6 +115,8 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
+	if (enable)
+		ctrl |= PWM_ENABLE;
 
 	if (orig_ctrl != ctrl) {
 		pwm_lpss_write(pwm, ctrl);
@@ -142,8 +144,9 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				pm_runtime_put(chip->dev);
 				return ret;
 			}
-			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
+			pwm_lpss_prepare(lpwm, pwm,
+					 state->duty_cycle, state->period,
+					 lpwm->info->bypass == false);
 			ret = pwm_lpss_wait_for_update(pwm);
 			if (ret) {
 				pm_runtime_put(chip->dev);
@@ -154,7 +157,8 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			ret = pwm_lpss_is_updating(pwm);
 			if (ret)
 				return ret;
-			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
+			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle,
+					 state->period, false);
 			return pwm_lpss_wait_for_update(pwm);
 		}
 	} else if (pwm_is_enabled(pwm)) {
-- 
2.26.2

