Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3593B0F8C
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVVmB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 17:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFVVmA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 17:42:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B82C061574;
        Tue, 22 Jun 2021 14:39:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y14so6740579pgs.12;
        Tue, 22 Jun 2021 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vf1QqRY1JZECqUtWVK03lwMiK0KNaFZdl1pyWINOrhI=;
        b=W/RV2iMnTS0ylpmZRCnwjRo5o67Qkz7coNidavtUhvO9yVsyrcobEjerT100lyTC/n
         8Z4EWoF415y7KiQ+TMeh3KJ2QVdAlripbqNJmpf9E0snFiyGejGnzhKHLDjom7TFgDSi
         GGPin7ybTDVk9Sx21jvP8J2yjz7+NDM4/y3PMtmcwzL6O0P8YAUT89ZqUmO8oQ6vQ2v8
         PD2kGS/O8dhxMwzvBkJtfNYmu7kOB3JLknIlpIwDyf2K+xFvky95RbLcS0DlXdb89fyq
         3na+Z9zDKy4CUSN3YKp4VieLCufl39knOvd//4et2XKrEA+5hyEL85l2g2yESfQlmYPS
         tEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vf1QqRY1JZECqUtWVK03lwMiK0KNaFZdl1pyWINOrhI=;
        b=eUi0s62qODSIFloAhlJWucOkZM5/j+rb7X/9Ca6EFcUG0Ilen4F/t/p6YpeJyV4ay7
         iV0I2T9cEP43+EtikVnRy3yl8YOg3G+4JhfrPS/hRh9zIHroMR1BQ8e1Nbh33EWtzVRA
         suOj0OhWLVqqboRbZZXUYLCwWEgxZRbKX7JKSsJGFf1Zsa9PzEBZRiCnDsh4mMISPx/h
         lSA12VmUP+VRpAAcimyIBhVussKyyG3SPwTgf4XqI5Av8Im6cOcTIoh7tziMOP+r3CI5
         FtxcehHGAL+Ua/lryrKZcREciXCYpHxGKIFupyHdajjqg63FK9x8PvmozC+b/0Gvisqk
         R7mA==
X-Gm-Message-State: AOAM5311wqm5MuAK5VyJbVS9kE5rhXC13ouuDXhG07OIp1sp6msDMjEK
        NFyw3ah8UAP72zx5zSHvOmw=
X-Google-Smtp-Source: ABdhPJwZy39F3LlgQBU5rUiN0mtsiLZpfYinKyCjSORRVuKUHK+MddVOeY3NBJJtrbrk1d0OXP+LMg==
X-Received: by 2002:a62:5444:0:b029:2e9:c69d:dc64 with SMTP id i65-20020a6254440000b02902e9c69ddc64mr5588398pfb.32.1624397983037;
        Tue, 22 Jun 2021 14:39:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b7e7:569c:6adc:f5e8])
        by smtp.gmail.com with ESMTPSA id a25sm254014pff.54.2021.06.22.14.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:39:42 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:39:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: PM: postpone bringing devices to D0 unless we need
 them
Message-ID: <YNJYm34h3Z9yfm+k@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently ACPI power domain brings devices into D0 state in the "resume
early" phase. Normally this does not cause any issues, as powering up
happens quickly. However there are peripherals that have certain timing
requirements for powering on, for example some models of Elan
touchscreens need 300msec after powering up/releasing reset line before
they can accept commands from the host. Such devices will dominate
the time spent in early resume phase and cause increase in overall
resume time as we wait for early resume to complete before we can
proceed to the normal resume stage.

There are ways for a driver to indicate that it can tolerate device
being in the low power mode and that it knows how to power the device
back up when resuming, bit that requires changes to individual drivers
that may not really care about details of ACPI controlled power
management.

This change attempts to solve this issue at ACPI power domain level, by
postponing powering up device until we get to the normal resume stage,
unless there is early resume handler defined for the device, or device
does not declare any resume handlers, in which case we continue powering
up such devices early. This allows us to shave off several hundred
milliseconds of resume time on affected systems.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2:

- do not call acpi_device_wakeup_disable() in early resume when
  we postponing transition to D0, do it all in normal resume phase
  (Rafael's feedback)

- reduce patch noise in acpi_subsys_resume_early() per Rafael's
  comments

 drivers/acpi/device_pm.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 096153761ebc..8afa66bdb3ce 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1131,19 +1131,48 @@ static int acpi_subsys_resume_noirq(struct device *dev)
  *
  * Use ACPI to put the given device into the full-power state and carry out the
  * generic early resume procedure for it during system transition into the
- * working state.
+ * working state, but only do that if device either defines early resume
+ * handler, or does not define power operations at all. Otherwise powering up
+ * of the device is postponed to the normal resume phase.
  */
 static int acpi_subsys_resume_early(struct device *dev)
 {
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int ret;
 
 	if (dev_pm_skip_resume(dev))
 		return 0;
 
+	if (pm && !pm->resume_early) {
+		dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
+		return 0;
+	}
+
 	ret = acpi_dev_resume(dev);
 	return ret ? ret : pm_generic_resume_early(dev);
 }
 
+/**
+ * acpi_subsys_resume - Resume device using ACPI.
+ * @dev: Device to Resume.
+ *
+ * Use ACPI to put the given device into the full-power state if it has not been
+ * powered up during early resume phase, and carry out the generic resume
+ * procedure for it during system transition into the working state.
+ */
+static int acpi_subsys_resume(struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	int ret = 0;
+
+	if (!dev_pm_skip_resume(dev) && pm && !pm->resume_early) {
+		dev_dbg(dev, "executing postponed D0 transition\n");
+		ret = acpi_dev_resume(dev);
+	}
+
+	return ret ? ret : pm_generic_resume(dev);
+}
+
 /**
  * acpi_subsys_freeze - Run the device driver's freeze callback.
  * @dev: Device to handle.
@@ -1236,6 +1265,7 @@ static struct dev_pm_domain acpi_general_pm_domain = {
 		.prepare = acpi_subsys_prepare,
 		.complete = acpi_subsys_complete,
 		.suspend = acpi_subsys_suspend,
+		.resume = acpi_subsys_resume,
 		.suspend_late = acpi_subsys_suspend_late,
 		.suspend_noirq = acpi_subsys_suspend_noirq,
 		.resume_noirq = acpi_subsys_resume_noirq,
-- 
2.32.0.288.g62a8d224e6-goog


-- 
Dmitry
