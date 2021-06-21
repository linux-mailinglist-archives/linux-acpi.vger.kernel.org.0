Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAA3AF85F
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFUWWQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 18:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUWWP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2021 18:22:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A40C061574;
        Mon, 21 Jun 2021 15:20:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e22so9118353pgv.10;
        Mon, 21 Jun 2021 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FcXnNZ9U3EXOCeDJdHA00lEKEfxkroafndXnf6d9J+M=;
        b=q8eAfI8djd1odX+ack4WkrTxvAPnRtt9GALTIomTBkPuP/qCohno/Yf+ohoU4Rcyr/
         nGp4e9Yy06jCDWOIhDH2xirC2XC9o/JqlRqcCVmFLGXmaJ9mQD6hjWVD6oGeBJ3XxDw/
         JZsZvN03EtNx+YO7/IUNnH425LlS28ramk9XmNaVVjEe1jMY6rRW23SghLkLrIA2kVfS
         GDKimQdwGhv/RkmKel8OSiG7yQj3vAqcdXYc883hvn7a8uHRpBX4ihRhvDMdWgtyuQVp
         4By5uGzAjMTouBR5nlul0RwmPb5KYHFv5N/bVgBkYY7+uCjsvD1PPukzV69TcYrOzYR7
         43FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FcXnNZ9U3EXOCeDJdHA00lEKEfxkroafndXnf6d9J+M=;
        b=NAGvpC552wqPgc6zG+l0UXYdOIayucdqOpG8xg7oy3mA6Iws8v/3ULYsybcpBKcfM6
         HlKEIkP5ktL3KshCcnomOwclE0DNLXqkFNxT34T8fIhxqkNzOrf86PJukK1BJ4Xhtr1E
         /H4aZl+jSLlNcr9fp9Q5Q+3VBuOTRdv8TovVgI3iIj4/bqPylmF+RJP1sTzb7/gthoCa
         ifvBq+LkR/FJCyBjZjiLbr8ztKgUW+VO1Sk/PDIBm8X2SdIa8I6gurYXIscGA1mR+ma2
         YUOAEAj0mJGIxDNbhDvngwHh+NWAnHDMezfAenPVvG+Hgg2xZmDIH1yV1+YNVNsHS1kn
         8b+w==
X-Gm-Message-State: AOAM533rPKLYBYbYya4wR9Xac3wOzny7/EEa3WolGQQehtIRhywkBvtw
        nkecPFnCBoMBLL1JyTA/288=
X-Google-Smtp-Source: ABdhPJxQnHUKT5ex8AB9nf9Voy7H5noXmNmRnVyAjMRubzPWJRMNDYW35WDgr9JtYz7SxfLZVhXc2g==
X-Received: by 2002:a63:ff1f:: with SMTP id k31mr616678pgi.315.1624313999503;
        Mon, 21 Jun 2021 15:19:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a276:c46e:ab3a:dce2])
        by smtp.gmail.com with ESMTPSA id lt14sm49661pjb.47.2021.06.21.15.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:19:58 -0700 (PDT)
Date:   Mon, 21 Jun 2021 15:19:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PM: postpone bringing devices to D0 unless we need them
Message-ID: <YNEQjAzq6iWNgnBc@google.com>
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
 drivers/acpi/device_pm.c | 46 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 096153761ebc..00b412ccb2e0 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1131,17 +1131,52 @@ static int acpi_subsys_resume_noirq(struct device *dev)
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
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	int ret;
 
-	if (dev_pm_skip_resume(dev))
-		return 0;
+	if (dev_pm_skip_resume(dev)) {
+		ret = 0;
+	} else if (!pm || pm->resume_early) {
+		ret = acpi_dev_resume(dev);
+		if (!ret)
+			ret = pm_generic_resume_early(dev);
+	} else {
+		if (adev)
+			acpi_device_wakeup_disable(adev);
+
+		dev_dbg(dev, "postponing D0 transition to normal resume stage\n");
+		ret = 0;
+	}
+
+	return ret;
+}
+
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
 
-	ret = acpi_dev_resume(dev);
-	return ret ? ret : pm_generic_resume_early(dev);
+	return ret ? ret : pm_generic_resume(dev);
 }
 
 /**
@@ -1236,6 +1271,7 @@ static struct dev_pm_domain acpi_general_pm_domain = {
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
