Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64F68A059
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjBCReS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCRd6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:33:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42AA58FF
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:33:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k16so4435715wms.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0WMeqO1vZNLVskDd96ga8DPKCx7MU4pvjHfg5TCNV4=;
        b=XHOfdsZuhQ64j8+pZNPju1LBEDBsM5d7gyUiAOkeKBc9vEbcIvqsDaDN4IETWMjbQp
         ZrHX0rW380A/WYefqmUKfScwbTttISBpjVzSochOvs0f77cBjt6Opf4+uMTSi3nMbhkf
         9uAy4fsfmLxX4t6ph19DRXFq8zC5ccMJq2eIgSsQtPTNl+7KmMuGpfWjhOA7GQoSYGR7
         I/pmwdxj0LZGeSJA7345nd2y3mpcQEJBQczKp0umtrTV/VgcWUZ5uVjqDN+n3IEVqlqX
         C/HK95ys11iiPgpVOTS9Xt08cuAUDcdf9kdNJFo6IS2wDlij0h6vZ6p7qj5A7J3wqE6z
         XLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0WMeqO1vZNLVskDd96ga8DPKCx7MU4pvjHfg5TCNV4=;
        b=UKqaR1MV9Np8uS+sS/KtcO3bD7J8U8aXQob+BSBQKZod1EdP7k4U2xufHkbyWkbwTn
         dc0hU2fwhz9ZUfE8yyq3v5eaNvEp62lvGHDMEAvsIiIbPAZUqSmZAkr8ha04sNCYf8XA
         o+ZZEzt0VW/DOjoHiNq8bdDDCNsl411jSNMYQtItImUDXIytBQhvc7JiRu9evIH1DCbZ
         htfxA3iVDE0a0g1oyB1rjFtPGehDZdLACuwaBEQHFbK0lD/yWHXMiBexdWkUAh8CT6aX
         4eO+DrNdD3M29L3LC4jazyhOShsa72X7McuFabGo2XIsToFPSlQqux0K1zA3iOw8hRGE
         Vm7w==
X-Gm-Message-State: AO0yUKUOLavtiuhQjvWqc1hKoaUA+wkXc1RY8sq2C55yIcGJQjXxYvbL
        ksgQMTbrdH1R7t8s+RpxeC8grQ==
X-Google-Smtp-Source: AK7set/A4wcRT11js8yRxZfmDtYaDcnd2kwsk+y5GKgd6N03vChREEmJXTS3+QEPXWGoVAtrPW7ocw==
X-Received: by 2002:a05:600c:3ba3:b0:3dc:58a2:3900 with SMTP id n35-20020a05600c3ba300b003dc58a23900mr10266362wms.29.1675445635238;
        Fri, 03 Feb 2023 09:33:55 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:54 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 07/11] thermal/acpi: Simplifify the condition check
Date:   Fri,  3 Feb 2023 18:33:27 +0100
Message-Id: <20230203173331.3322089-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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
pointless to redo the same check again and again as it is unchanged.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index a3a8130c955f..c7c2b3d63e90 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -321,6 +321,9 @@ static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
 	int valid = 0;
 
 	valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	if (!valid)
+		return 0;
+
 	if (psv == -1) {
 		status = AE_SUPPORT;
 	} else if (psv > 0) {
@@ -398,13 +401,16 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
+
 		valid = tz->trips[i].flags.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->trips[i].flags.valid)) {
+		if (!tz->trips[i].flags.valid)
+			continue;
+		
+		if (flag & ACPI_TRIPS_ACTIVE)  {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
@@ -436,7 +442,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[i].flags.valid ) {
+		if (flag & ACPI_TRIPS_DEVICES) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
@@ -455,6 +461,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
+
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
 			if (valid != tz->trips[i].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
@@ -495,8 +502,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
-		(flag == ACPI_TRIPS_INIT)) {
+	if (flag & ACPI_TRIPS_PASSIVE) {
 		acpi_thermal_trips_update_passive(tz, flag);
 	}
 
-- 
2.34.1

