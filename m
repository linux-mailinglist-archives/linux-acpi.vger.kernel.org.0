Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE645F4868
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Oct 2022 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJDR1Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Oct 2022 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJDR1T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 13:27:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D743E4C
        for <linux-acpi@vger.kernel.org>; Tue,  4 Oct 2022 10:27:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so2799545wrp.10
        for <linux-acpi@vger.kernel.org>; Tue, 04 Oct 2022 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffflrD4DXIWja44hBCEf9IQ+O0RpUhCuc08rXykRjDg=;
        b=o8wah8z8XT1ziWccJxJ9Cmb/4HGi1U8gEOqZUzPdEc2rv/FmTnpl+gj2oR+bB7R+Ef
         quao0/x+CfVNyMiuCz15YAezFgCGNsq/caIMXmYbH9b4LAGOGUAWU4VnagwUqsS0Xu/5
         G+ioBlERSqNGsUSKVxkK3zyMaeTc0V+04Cq7QBC4s1r3uzf4rp9KSMq2PIJeL+3NS9Ax
         JSPW/EYHn6ERHfnr82Uzul0XpwAog3wGvvSzIldTaPnXXkLj0hNgL62Ft6YvPxT/umyD
         BMoO9V0TSlEilv2Q+4QuH4uX8U3Mwc+kBrJOr+tmwDFuFEGLQ9XAR5QGMPS5VcmC6a1e
         dTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffflrD4DXIWja44hBCEf9IQ+O0RpUhCuc08rXykRjDg=;
        b=FoXzNsDZ9f9OiHzas5Z+sLfAslb+apwJm/Kms2TBIOuaOjDmaGjgMfaGv83IdqSi7g
         X9LS0Cc/9RSUylYY35Uole76ehlMyB2GqwmK8rbdLOYmEzQ3p3HtfLLlY/HnFWBTjdfr
         HbENa6luOFEKAQC/mL42sA9/C6XGjgC2ToHMRcYIjO1MrqVH6pryzHoOzAzqqcHAMho/
         3coW+g95gx4HE2/WSqCR0wtNmw8O6iuQ+1xqvKEDVrXT2ad288OybQ2OghJiayeym0jN
         m0Lb268MCmQAL7uW7p1bIJiL9cqcRjleHcoq3kYQD7DRmI4FctzpiaoRiorEqLwJVgUs
         F06Q==
X-Gm-Message-State: ACrzQf3FmMJGjJ531PbNZtDuQvV9EyA0ylBPq1k8yTvk1m0xU6audZPM
        6i54glrYfn7Bc/td6W/77ASBuA==
X-Google-Smtp-Source: AMsMyM5NjECWapjJ7d70XwY9SIHtxnFliyPngXpj7L5b8H234DSD5P7SSw1R2URsRMaDYoK8HMsksw==
X-Received: by 2002:a05:6000:1a8f:b0:228:e3c3:679 with SMTP id f15-20020a0560001a8f00b00228e3c30679mr16757847wry.281.1664904433625;
        Tue, 04 Oct 2022 10:27:13 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 5/9] thermal/acpi: Optimize get_trip_points()
Date:   Tue,  4 Oct 2022 19:26:54 +0200
Message-Id: <20221004172658.2302511-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The function has two purposes. Initialize the trip points by reading
the ACPI table and then doing a check trip points exists.

This check will go through all the trip points and at the end if a
valid trip point is found, the parsing is considered valid.

Instead of checking all the trip points, exit when a valid trip point
is found.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index ce37494bd133..9841b597a9c7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -463,23 +463,20 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	int i, valid, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+	int i, ret;
 
+	ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 	if (ret)
 		return ret;
 
-	valid = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid |
-		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
-		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (tz->trips[i].flags.valid)
+			return 0;
+	}
 
-	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->trips[i].flags.valid;
+	pr_warn(FW_BUG "No valid trip found\n");
 
-	if (!valid) {
-		pr_warn(FW_BUG "No valid trip found\n");
-		return -ENODEV;
-	}
-	return 0;
+	return -ENODEV;
 }
 
 /* sys I/F for generic thermal sysfs support */
-- 
2.34.1

