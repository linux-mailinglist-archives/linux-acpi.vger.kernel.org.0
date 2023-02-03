Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CED68A0A5
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjBCRpA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjBCRoo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:44:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192D6DFC3
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:44:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o18so5343381wrj.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za8uPsw5SSvV8WX2HiDt+VQyx2NN7X9xXkrZzQ/66K8=;
        b=Y0BpwNoFg1Yst7n0lERp8nuJl2HJZTQZQ9zMTMXzLiAw44A1jdf7fp8FkJ5CjAMCge
         gxLKA0sTVyo5A7NBJgCZNWxdwmRNgvSoSO/XGwPpnwQzHDIdPsgWyYDq6UGGAEpMEvaP
         1umiZzO7PrR/fCpQOybQd6zbiX1wvjsKzRZTV0DU2jqo9dg//sseJJ/v6Lq5kBv8Hi9u
         miH2GTVjXJ2g3+vExVQYZbIM0vDCW1Msfbyc9SS016wWm8VCkUpvQc1mQ2mX/4L4bawE
         BWA0GvPfaGlkRY2OjgzY3Z4SAcMfieifO/3k8HbgladkMPcly4zIOO/nljtU60pzTu9x
         iE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za8uPsw5SSvV8WX2HiDt+VQyx2NN7X9xXkrZzQ/66K8=;
        b=KhrasFQG8pb5BFzrDOM/9ie3bHfcg58z13i69azOwK2lpsu+fmFneZPxnKsRxGzTie
         w/OCD1g2ZCqTncmGmuyHjZH/z9VrzKzpy6pnNk9AGo2xUAta03YkKpVnSzUucAx9VU2q
         1pWvmEPGNs45FmJQ+Rc602CCrWznSwz13hdKRM9WXECn7hd0BS9FnfJ1yaJXO+8kabCf
         zQrEyqiSA/P/qTLdhttk5rSKBEzHx8O2SCM3P2xABBo+NbJgXsBO6zZGWKT3u3T9hR53
         TAduASAR2l0gtxrUSoAXpbE8fHODa98TZD+B3WxtRQAhmAcH9IdUeBusxoP8gimjhBLH
         XruQ==
X-Gm-Message-State: AO0yUKUvvMBj41p/ckQ6iMtfxT2wrH4I2UVori1mV8RSZGj5WFjdyvc3
        K1BWfo6CYLcZscLk5yoC9vzO0g==
X-Google-Smtp-Source: AK7set91x7D76X7pVzQY6gXi/O7U+JN2LMvElRO431f2OILec/qIMHZSGBj5NaqCYKfmuuj4psxJLA==
X-Received: by 2002:adf:c754:0:b0:2bf:e533:3158 with SMTP id b20-20020adfc754000000b002bfe5333158mr10328604wrh.20.1675446279253;
        Fri, 03 Feb 2023 09:44:39 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/11] thermal/acpi: Encapsulate in functions the trip initialization
Date:   Fri,  3 Feb 2023 18:44:24 +0100
Message-Id: <20230203174429.3375691-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
References: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
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

The thermal trip update function is a bit difficult to read, it is
very long and has everything put in there to initialize the trip
points. In order to improve its readability, let's encapuslate the
different parts into dedicated functions. So we can act individually
per trip type changes and will make easier to review the next changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 257 ++++++++++++++++++++++++-----------------
 1 file changed, 154 insertions(+), 103 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c4fd583fbf5c..a3a8130c955f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -246,113 +246,120 @@ do {	\
 		"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
-static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	unsigned long long tmp;
-	struct acpi_handle_list devices;
-	int valid = 0;
-	int i;
 
-	/* Critical Shutdown */
-	if (flag & ACPI_TRIPS_CRITICAL) {
-		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
-
-		/*
-		 * Treat freezing temperatures as invalid as well; some
-		 * BIOSes return really low values and cause reboots at startup.
-		 * Below zero (Celsius) values clearly aren't right for sure..
-		 * ... so lets discard those as invalid.
-		 */
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-			acpi_handle_debug(tz->device->handle,
-					  "No critical threshold\n");
-		} else if (tmp <= 2732) {
-			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
+	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
+	tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
+	/*
+	 * Treat freezing temperatures as invalid as well; some
+	 * BIOSes return really low values and cause reboots at startup.
+	 * Below zero (Celsius) values clearly aren't right for sure..
+	 * ... so lets discard those as invalid.
+	 */
+	if (ACPI_FAILURE(status)) {
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
+		acpi_handle_debug(tz->device->handle,
+				  "No critical threshold\n");
+	} else if (tmp <= 2732) {
+		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
+	} else {
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
+		acpi_handle_debug(tz->device->handle,
+				  "Found critical threshold [%lu]\n",
+				  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
+	}
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid == 1) {
+		if (crt == -1) {
 			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
-			acpi_handle_debug(tz->device->handle,
-					  "Found critical threshold [%lu]\n",
-					  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
-		}
-
-		if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
-			if (crt == -1) {
-				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-			} else if (crt > 0) {
-				unsigned long crt_k = celsius_to_deci_kelvin(crt);
+		} else if (crt > 0) {
+			unsigned long crt_k = celsius_to_deci_kelvin(crt);
 
-				/*
-				 * Allow override critical threshold
-				 */
-				if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
-					pr_info("Critical threshold %d C\n", crt);
+			/*
+			 * Allow override critical threshold
+			 */
+			if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
+				pr_info("Critical threshold %d C\n", crt);
 
-				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
-			}
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
 		}
 	}
 
-	/* Critical Sleep (optional) */
-	if (flag & ACPI_TRIPS_HOT) {
-		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
-			acpi_handle_debug(tz->device->handle,
-					  "No hot threshold\n");
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
-			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
-			acpi_handle_debug(tz->device->handle,
-					  "Found hot threshold [%lu]\n",
-					  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
-		}
+	return 0;
+}
+
+static int acpi_thermal_trips_update_hot(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+
+	status = acpi_evaluate_integer(tz->device->handle,
+				       "_HOT", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
+		acpi_handle_debug(tz->device->handle,
+				  "No hot threshold\n");
+	} else {
+		tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
+		acpi_handle_debug(tz->device->handle,
+				  "Found hot threshold [%lu]\n",
+				  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
 	}
 
-	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
-	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
-		if (psv == -1) {
-			status = AE_SUPPORT;
-		} else if (psv > 0) {
-			tmp = celsius_to_deci_kelvin(psv);
-			status = AE_OK;
-		} else {
-			status = acpi_evaluate_integer(tz->device->handle,
-						       "_PSV", NULL, &tmp);
-		}
+	return 0;
+}
 
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
-			if (flag == ACPI_TRIPS_INIT) {
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TC1", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TC2", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TSP", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
-			}
+static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status;
+	unsigned long long tmp;
+	struct acpi_handle_list devices;
+	int valid = 0;
+
+	valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	if (psv == -1) {
+		status = AE_SUPPORT;
+	} else if (psv > 0) {
+		tmp = celsius_to_deci_kelvin(psv);
+		status = AE_OK;
+	} else {
+		status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &tmp);
+	}
+
+	if (ACPI_FAILURE(status))
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+	else {
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
+		if (flag == ACPI_TRIPS_INIT) {
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TC1",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TC2",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TSP",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
 		}
 	}
+
 	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
@@ -372,12 +379,23 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
+
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
 		if (valid != tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
-	/* Active (optional) */
+	return 0;
+}
+
+static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+	struct acpi_handle_list devices;
+	int valid = 0;
+	int i;
+
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
 		valid = tz->trips[i].flags.valid;
@@ -445,17 +463,50 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			break;
 	}
 
-	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(devices));
-		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
-						 NULL, &devices);
-		if (ACPI_SUCCESS(status) &&
-		    memcmp(&tz->devices, &devices, sizeof(devices))) {
-			tz->devices = devices;
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
-		}
+	return 0;
+}
+
+static int acpi_thermal_trips_update_devices(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	struct acpi_handle_list devices;
+
+	memset(&devices, 0, sizeof(devices));
+	status = acpi_evaluate_reference(tz->device->handle, "_TZD", NULL, &devices);
+	if (ACPI_SUCCESS(status)
+	    && memcmp(&tz->devices, &devices, sizeof(devices))) {
+		tz->devices = devices;
+		ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
+	}
+
+	return 0;
+}
+
+static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+{
+	/* Critical Shutdown */
+	if (flag & ACPI_TRIPS_CRITICAL) {
+		acpi_thermal_trips_update_critical(tz, flag);
 	}
 
+	/* Critical Sleep (optional) */
+	if (flag & ACPI_TRIPS_HOT) {
+		acpi_thermal_trips_update_hot(tz, flag);
+	}
+
+	/* Passive (optional) */
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
+		acpi_thermal_trips_update_passive(tz, flag);
+	}
+
+	/* Active (optional) */
+	acpi_thermal_trips_update_active(tz, flag);
+
+	if (flag & ACPI_TRIPS_DEVICES) {
+		acpi_thermal_trips_update_devices(tz, flag);
+	}
+	
 	return 0;
 }
 
-- 
2.34.1

