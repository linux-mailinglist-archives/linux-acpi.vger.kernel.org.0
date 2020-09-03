Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96E25BF96
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Sep 2020 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgICKwI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Sep 2020 06:52:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgICKv4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Sep 2020 06:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599130308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Rq/kCXPxZ99tToUWUU0yMgHL5+0bXmVGSvD9UR0a2I=;
        b=TGEK1IWQFoAMsv+pagHDOddRXRZ56u3TLsvas4grXgFV7F7WOYmSGmiAY5QkwGFiTKJfkM
        y2M6RrI1HQlSCLPyWGMb7lZRJdRdJKPqn86jioeFqqtjMR2KqImbdh+R3yuj9P/t1H8+3C
        d1s0cM3qUYR98LxBHJXaZOENTYvAgSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-mC2r8vZPMYefjWZfgXqY-w-1; Thu, 03 Sep 2020 06:51:44 -0400
X-MC-Unique: mC2r8vZPMYefjWZfgXqY-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0A1801AF2;
        Thu,  3 Sep 2020 10:51:42 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-4.ams2.redhat.com [10.36.115.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 868B47EEAE;
        Thu,  3 Sep 2020 10:51:39 +0000 (UTC)
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
Subject: [PATCH v9 07/17] pwm: lpss: Remove suspend/resume handlers
Date:   Thu,  3 Sep 2020 12:51:04 +0200
Message-Id: <20200903105114.9969-8-hdegoede@redhat.com>
In-Reply-To: <20200903105114.9969-1-hdegoede@redhat.com>
References: <20200903105114.9969-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PWM controller drivers should not restore the PWM state on resume. The
convention is that PWM consumers do this by calling pwm_apply_state(),
so that it can be done at the exact moment when the consumer needs
the state to be stored, avoiding e.g. backlight flickering.

The only in kernel consumers of the pwm-lpss code, the i915 driver
and the pwm-class sysfs interface code both correctly restore the
state on resume, so there is no need to do this in the pwm-lpss code.

More-over the removed resume handler is buggy, since it blindly
restores the ctrl-register contents without setting the update
bit, which is necessary to get the controller to actually use/apply
the restored base-unit and on-time-div values.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c |  1 -
 drivers/pwm/pwm-lpss.c          | 24 ------------------------
 drivers/pwm/pwm-lpss.h          |  3 ---
 3 files changed, 28 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 48f34d20aecd..c6502cf7a7af 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -89,7 +89,6 @@ static int pwm_lpss_prepare(struct device *dev)
 
 static const struct dev_pm_ops pwm_lpss_platform_pm_ops = {
 	.prepare = pwm_lpss_prepare,
-	SET_SYSTEM_SLEEP_PM_OPS(pwm_lpss_suspend, pwm_lpss_resume)
 };
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 9c5c7217c9b6..3444c56b4bed 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -260,30 +260,6 @@ int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_remove);
 
-int pwm_lpss_suspend(struct device *dev)
-{
-	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
-	int i;
-
-	for (i = 0; i < lpwm->info->npwm; i++)
-		lpwm->saved_ctrl[i] = readl(lpwm->regs + i * PWM_SIZE + PWM);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pwm_lpss_suspend);
-
-int pwm_lpss_resume(struct device *dev)
-{
-	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
-	int i;
-
-	for (i = 0; i < lpwm->info->npwm; i++)
-		writel(lpwm->saved_ctrl[i], lpwm->regs + i * PWM_SIZE + PWM);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pwm_lpss_resume);
-
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 7909fa12fca2..70db7e389d66 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -19,7 +19,6 @@ struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	const struct pwm_lpss_boardinfo *info;
-	u32 saved_ctrl[MAX_PWMS];
 };
 
 struct pwm_lpss_boardinfo {
@@ -37,7 +36,5 @@ struct pwm_lpss_boardinfo {
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
-int pwm_lpss_suspend(struct device *dev);
-int pwm_lpss_resume(struct device *dev);
 
 #endif	/* __PWM_LPSS_H */
-- 
2.28.0

