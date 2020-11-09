Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59B2AB599
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgKIK5j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 05:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgKIK5i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 05:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604919457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUnSDl5AAM1g8EjGly5ChvnIAkG2lb2m5JffVoaZ1nk=;
        b=emWNkrdUygEnPwqzRjIv/2czQ0WrS4BxFw1P5eO/RVuFqZSds2ri4OfCpF4PumdHkhbG59
        6ZrgXyiB2wZ+yR3lTudBLsUr3w1Bp4DjdyRmZeCgs/UUv1Hk/whSoIcc2vo4jXT7WdHfwk
        c8yo+qjf0h8l/WhpDQAZKgeqCGzuV14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-2f6ukMpxOlm5ufBosqpOrw-1; Mon, 09 Nov 2020 05:57:35 -0500
X-MC-Unique: 2f6ukMpxOlm5ufBosqpOrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF9657205;
        Mon,  9 Nov 2020 10:57:34 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E50876EF4B;
        Mon,  9 Nov 2020 10:57:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/3] pwm: lpss: Use DPM_FLAG_NO_DIRECT_COMPLETE instead of declaring a prepare handler
Date:   Mon,  9 Nov 2020 11:57:25 +0100
Message-Id: <20201109105726.121512-3-hdegoede@redhat.com>
In-Reply-To: <20201109105726.121512-1-hdegoede@redhat.com>
References: <20201109105726.121512-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI LPSS devices use direct-complete style suspend/resume handling by
default. We set the DPM_FLAG_SMART_PREPARE and define a prepare handler
to disable this on Cherry Trail devices.

Clean this up a bit by setting the DPM_FLAG_NO_DIRECT_COMPLETE flag for
Cherry Trail devices, instead of defining a prepare handler.

While at it also improve the comment explaining why this is necessary.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 35 ++++++++++++++-------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index c6502cf7a7af..ac33861edb48 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -58,7 +58,21 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lpwm);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
+	/*
+	 * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
+	 * is on and if it is not on it turns it on and restores what it
+	 * believes is the correct state to the PWM controller.
+	 * Because of this we must disallow direct-complete, which keeps the
+	 * controller (runtime)suspended on resume, to avoid 2 issues:
+	 * 1. The controller getting turned on without the linux-pm code
+	 *    knowing about this. On devices where the controller is unused
+	 *    this causes it to stay on during the next suspend causing high
+	 *    battery drain (because S0i3 is not reached)
+	 * 2. The state restoring code unexpectedly messing with the controller
+	 */
+	if (info->other_devices_aml_touches_pwm_regs)
+		dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
@@ -73,24 +87,6 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 	return pwm_lpss_remove(lpwm);
 }
 
-static int pwm_lpss_prepare(struct device *dev)
-{
-	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
-
-	/*
-	 * If other device's AML code touches the PWM regs on suspend/resume
-	 * force runtime-resume the PWM controller to allow this.
-	 */
-	if (lpwm->info->other_devices_aml_touches_pwm_regs)
-		return 0; /* Force runtime-resume */
-
-	return 1; /* If runtime-suspended leave as is */
-}
-
-static const struct dev_pm_ops pwm_lpss_platform_pm_ops = {
-	.prepare = pwm_lpss_prepare,
-};
-
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
 	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
@@ -104,7 +100,6 @@ static struct platform_driver pwm_lpss_driver_platform = {
 	.driver = {
 		.name = "pwm-lpss",
 		.acpi_match_table = pwm_lpss_acpi_match,
-		.pm = &pwm_lpss_platform_pm_ops,
 	},
 	.probe = pwm_lpss_probe_platform,
 	.remove = pwm_lpss_remove_platform,
-- 
2.28.0

