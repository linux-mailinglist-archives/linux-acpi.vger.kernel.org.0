Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0A5F486A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Oct 2022 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJDR11 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Oct 2022 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJDR1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 13:27:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52795A82E
        for <linux-acpi@vger.kernel.org>; Tue,  4 Oct 2022 10:27:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w18so13654431wro.7
        for <linux-acpi@vger.kernel.org>; Tue, 04 Oct 2022 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/wkXK/VoNshwYJ83FzY4wXHrBNAZHWyNhQmshjdi+0=;
        b=ULlderE9PrJ6jo1NnPTqYQLkjZBAtWAa2Jgc3YfPEKyMdp8aCVIc75YB7FJ0/e42mk
         z09bZEWgoFsxxNSNJPl6DBhs6JjholHc616znfP78OR4S7rx745fcGkR7gAFWBNXh/2d
         h3HFUygS3z7pgEw5JE6zKpNuIKdGK9Gp/P80cExsbxNL5PY1tiL7ut2tlEhcjlgB+4Cw
         layLN59rADcM4r3rywzo2N9pIW4dCpRAbiBjvuKC6L8Zyst0tThrhyZWzLJp6q8uQx7N
         BFWm0MFEMSe78zJXJM3zABJjZDRtK7v07rEcxsgYqQptebaKtD9SxxlAuW5lqs6WuPVR
         yfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/wkXK/VoNshwYJ83FzY4wXHrBNAZHWyNhQmshjdi+0=;
        b=mAams55aoMN6esbSjUfgy9KcxnS25jVI+EmA4nQ/xMm1vUg8fhjsUniKQ+keQHk1W8
         lQYl36d68IbwpWU/RRbarFhEuegLjeXv/mJJQUtuEuHTDJBud54gS9+yemx4SKHLoTQH
         ZHIY6C0fbJ6zL32c9TUFEl1Xh17+yUXOIApXcKTteGkOCZEu6rsZe0pFs+ThMqgSNkQP
         bsjjH8MlaVFnSggFCNiQLAGU9SOzMy3U2a8rXLxwZ63t75JTw0n6V4W/ym0aHG0feDyx
         87Sj2QrryBNvDsTxBfZZYevcJOgdub2fzK1zJfwpg5tEUxzXsp13sJhYshjEP9teQS3I
         INUw==
X-Gm-Message-State: ACrzQf0VsxYqDOZV00CUXhst0fPffb1sD8stD1C4Q1CS9Wl29P+FHbVP
        PDKocedMkmxGz+oCM+IV2x//Ng==
X-Google-Smtp-Source: AMsMyM7Xp8iqAHHWmGPM3+tdztVeDOHDC954tnbDHhlpH4EBnUFR9rfsqtLQlv0GC7PyhdYdnD1n/Q==
X-Received: by 2002:a05:6000:1861:b0:22a:bb41:886d with SMTP id d1-20020a056000186100b0022abb41886dmr16757834wri.661.1664904436154;
        Tue, 04 Oct 2022 10:27:16 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 7/9] thermal/acpi: Simplifify the condition check
Date:   Tue,  4 Oct 2022 19:26:56 +0200
Message-Id: <20221004172658.2302511-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The condition:

if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE))

and on the other side: ACPI_TRIPS_INIT (... | ACPI_TRIPS_ACTIVE)

So if the first predicate is true, the second is also true.

The 'valid' flag for the trip point is also checked before, so it is
pointless to redo the same check again and again.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e62381561255..116e5cf19c5d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -323,6 +323,9 @@ static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
 	int valid = 0;
 
 	valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	if (!valid)
+		return 0;
+
 	if (psv == -1) {
 		status = AE_SUPPORT;
 	} else if (psv > 0) {
@@ -401,13 +404,16 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
+
 		valid = tz->trips[i].flags.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
-			tz->trips[i].flags.valid)) {
+		if (!tz->trips[i].flags.valid)
+			continue;
+		
+		if (flag & ACPI_TRIPS_ACTIVE)  {
 			status = acpi_evaluate_integer(tz->device->handle,
 							name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
@@ -437,7 +443,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[i].flags.valid ) {
+		if (flag & ACPI_TRIPS_DEVICES) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
@@ -456,6 +462,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
+
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
 			if (valid != tz->trips[i].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
@@ -497,8 +504,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
-		(flag == ACPI_TRIPS_INIT)) {
+	if (flag & ACPI_TRIPS_PASSIVE) {
 		acpi_thermal_trips_update_passive(tz, flag);
 	}
 
-- 
2.34.1

