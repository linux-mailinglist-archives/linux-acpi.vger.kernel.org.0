Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF552DA453
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 00:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLNXmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 18:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLNXlI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 18:41:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965B2C061257
        for <linux-acpi@vger.kernel.org>; Mon, 14 Dec 2020 15:40:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so16795667wme.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Dec 2020 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HR6fxnctcFG0S2fOhN1StND9v+I0KlYE3gnQEW5jseo=;
        b=I4+ur7/JqkDvRM9rhYAD8XbIRYlOOoS5VmC+0o3cupQmlhxvVdRe5zc1ugCTN2c50N
         rUCImwC/t6kBthv1M2bwbWgHCayE1VisBLU4Etxmli/UZw03f3d976Ws99Ep9PcZoQDN
         MEXTGyToiCQh1Y6IhO6g6Y4yY7GOQveUouYtNOk1UMvM0XGxJkxPRvsqmo4UdosctfW8
         pMTaP7uJMLDlFOhOd656vO7TunBRhFr32P3JgME36WPwQSkCrSJE4ldXKhOk1elfhuzc
         4Ozvb0ZZLcQBBvaAv24A8g9JNIOfBNGMc+mpd1WCCDQ1ZZx8aR8mya6qP0gdMWp1jCxs
         EI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HR6fxnctcFG0S2fOhN1StND9v+I0KlYE3gnQEW5jseo=;
        b=a2fw4Z9IGrKwM6a/coAVUpbmFBo/DkZ12/hDP3edu8xqYZDYsG+ccdI+fmToBQi/Y0
         wsbbKaC5vsUY4wAdAtdyZrkVmpTSx6FoUcuvL2UduCuz6aHuNFdJ3KCCNWM+8q5ekJE+
         q6eYpCjaVOL9uEKpRt5wehUihWfLHjBn6obMn/fW/q11aB2pkVkO0qzJSIJoJWF0KYhY
         qaPZYAnnINxvX8IlRz7NoNRIjhreTnRCh29DYE7pWBWtBAXDAUhGq0ufDTyRHfpWBkz8
         nNBNbZOnk3J1vP8XzXaKnjg+MA+ZINb+L90ZKq77uMBqtDZ+9hyKr7GD+tqgNmyuH4Ur
         7kig==
X-Gm-Message-State: AOAM531NNqPs5oj4WC+i3jOyKpI2YSXydmTnTWAO1el/u5Iv5B/WQUf7
        5MFPv1yEaRnRUgO5FFGB2ubILw==
X-Google-Smtp-Source: ABdhPJy7Yk7b8Tx5ebVkN303VPChAZspl2TDmQ7lnf4hy9dgarasNh2bFkcPl+Ftld8ZcrfTN396vA==
X-Received: by 2002:a1c:81d5:: with SMTP id c204mr29695087wmd.156.1607989202159;
        Mon, 14 Dec 2020 15:40:02 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:40:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling device binding
Date:   Tue, 15 Dec 2020 00:38:07 +0100
Message-Id: <20201214233811.485669-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The loop is here to create default cooling device binding on the
THERMAL_TRIPS_NONE number which is used to be the 'forced_passive'
feature. However, we removed all code dealing with that in the thermal
core, thus this binding does no longer make sense.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b5e4bc9e3282..26a89ff80a0e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -764,25 +764,6 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		}
 	}
 
-	for (i = 0; i < tz->devices.count; i++) {
-		handle = tz->devices.handles[i];
-		status = acpi_bus_get_device(handle, &dev);
-		if (ACPI_SUCCESS(status) && (dev == device)) {
-			if (bind)
-				result = thermal_zone_bind_cooling_device
-						(thermal, THERMAL_TRIPS_NONE,
-						 cdev, THERMAL_NO_LIMIT,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_WEIGHT_DEFAULT);
-			else
-				result = thermal_zone_unbind_cooling_device
-						(thermal, THERMAL_TRIPS_NONE,
-						 cdev);
-			if (result)
-				goto failed;
-		}
-	}
-
 failed:
 	return result;
 }
-- 
2.25.1

