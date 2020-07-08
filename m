Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3421219214
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jul 2020 23:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgGHVPF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Jul 2020 17:15:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbgGHVPE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2020 17:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594242903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/xQY2ndEh9mW9MwVPKpVHE1H/7u+wSTzv3ok3js0g0=;
        b=P5tVifPI1IvxUAf4uG0Nw0oo6AK2yD4vmTni4nnpR4fldCNSEG2q14ZuU+xHZGloMHi7Cd
        avyY1d7OXcj12gYqxa4+zgLGc3VCL1MLt7r3RQ2bCHyYLjo7QtAANJb/PYTBFKpMuYjeHo
        PXp6+xo3+aV5vSuO+rOewGiSf//ofhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-19y8WGWLN02ld0J7Wx2r2A-1; Wed, 08 Jul 2020 17:14:58 -0400
X-MC-Unique: 19y8WGWLN02ld0J7Wx2r2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F8FC80BCA3;
        Wed,  8 Jul 2020 21:14:56 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-5.ams2.redhat.com [10.36.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07380797F2;
        Wed,  8 Jul 2020 21:14:53 +0000 (UTC)
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
Subject: [PATCH v4 07/16] pwm: crc: Fix period / duty_cycle times being off by a factor of 256
Date:   Wed,  8 Jul 2020 23:14:23 +0200
Message-Id: <20200708211432.28612-8-hdegoede@redhat.com>
In-Reply-To: <20200708211432.28612-1-hdegoede@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While looking into adding atomic-pwm support to the pwm-crc driver I
noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
there is a clock-divider which divides this with a value between 1-128,
and there are 256 duty-cycle steps.

The pwm-crc code before this commit assumed that a clock-divider
setting of 1 means that the PWM output is running at 6 MHZ, if that
is true, where do these 256 duty-cycle steps come from?

This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
seems unlikely for a PMIC which is using a silicon process optimized for
power-switching transistors. It is way more likely that there is an 8
bit counter for the duty cycle which acts as an extra fixed divider
wrt the PWM output frequency.

The main user of the pwm-crc driver is the i915 GPU driver which uses it
for backlight control. Lets compare the PWM register values set by the
video-BIOS (the GOP), assuming the extra fixed divider is present versus
the PWM frequency specified in the Video-BIOS-Tables:

Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
Asus T100TA 	200			200
Asus T100HA 	200			200
Lenovo Miix 2 8	23437			20000
Toshiba WT8-A	23437			20000

So as we can see if we assume the extra division by 256 then the register
values set by the GOP are an exact match for the VBT values, where as
otherwise the values would be of by a factor of 256.

This commit fixes the period / duty_cycle calculations to take the
extra division by 256 into account.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Use NSEC_PER_USEC instead of adding a new (non-sensical) NSEC_PER_MHZ define
---
 drivers/pwm/pwm-crc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 272eeb071147..c056eb9b858c 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -21,8 +21,8 @@
 
 #define PWM_MAX_LEVEL		0xFF
 
-#define PWM_BASE_CLK		6000000  /* 6 MHz */
-#define PWM_MAX_PERIOD_NS	21333    /* 46.875KHz */
+#define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
+#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
 
 /**
  * struct crystalcove_pwm - Crystal Cove PWM controller
@@ -72,7 +72,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 
 		/* changing the clk divisor, need to disable fisrt */
 		crc_pwm_disable(c, pwm);
-		clk_div = PWM_BASE_CLK * period_ns / NSEC_PER_SEC;
+		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
 
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
-- 
2.26.2

