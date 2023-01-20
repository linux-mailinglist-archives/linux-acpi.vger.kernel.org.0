Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480D676158
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jan 2023 00:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjATXQK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 18:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjATXP5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 18:15:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186C56ED2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 15:15:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso5362731wmn.5
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 15:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfXu0aEKsZLPUd+pHK859PYllaHR7EY7wWkz0R5COZw=;
        b=Tl731lC4eJNEQzgrxEEY88dg1tPBIxMUGDqde7ZvFY99qHF0zK5OmGGcnjmFGkAVTQ
         TRd0zwhXaUN6x4yrz8wqy+4WbB3xT2To99C6yMN6EM6RPUn/Qo/QZ/awyavUJJyja/ZZ
         atNltk3M2B/mLXWt5qF/4h7pvp91BZihBzV8h+OOV+cpDILGrfLvbpob09N8FzUhTnzm
         e/o763z6uk+lBA+242ZTpZDKK2/2t/JafESCP0CDEsKS2//+VZy39pUISLyae+KVeNB5
         m680m02XgIk0ccLJblEZPATneLgdPLSo3z+3Iwif6QOnP+tNE97I6iyA+jxgXS2fJUZm
         Y1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfXu0aEKsZLPUd+pHK859PYllaHR7EY7wWkz0R5COZw=;
        b=71m+iyMwlR2v9Uc/AcuSo+bQ+cJO8cD8GXaHO+hZbJnQG3VOKuJj/d5YbPusUBkXDD
         6GXy2fFannb8GmFs3ZZdQ/E9igiXL/cGzIviMHoZjr7f4ADZPhRDtoLqmzfhFfY2hgpM
         OGdEGm+2tJmNc4Bw5Ggpcfm8zo6hHdlQeHZ/jk/st01MIruYK1jdxJMIl6o/6QO7Czs+
         EKs6pSquemDFv22JGPbL+O1nx3NkskTo6cTgV2iRA8dtdh21dmbCGEAmvHyiaqhlGDG8
         ygRBfz0aQzhBMgrgNGECyzMxjDjih7KX3+uhrSqN9dBjFcS4dtWm6m5p4XcE5FFqmRHq
         FDSA==
X-Gm-Message-State: AFqh2koovrJTjYEIXc+xygxM+2IWlAefzIHJSv1Pf3OW9eQfVuTQH0qz
        g0xpaq7A3OK6yl5bUzdr7o+SEQ==
X-Google-Smtp-Source: AMrXdXv+Z8ROOXP4P8fLXQ1qAhmp+4JB1+9wUNzHLOzlLKkKqm3Wfxk0atCMqpG9iPyyat0Hxv5niw==
X-Received: by 2002:a1c:ed1a:0:b0:3da:c07:c5fe with SMTP id l26-20020a1ced1a000000b003da0c07c5femr12264817wmh.5.1674256552166;
        Fri, 20 Jan 2023 15:15:52 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm36436828wrx.21.2023.01.20.15.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 15:15:51 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 3/3] thermal/drivers/intel: Use generic trip points int340x
Date:   Sat, 21 Jan 2023 00:15:30 +0100
Message-Id: <20230120231530.2368330-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
References: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert the ops content logic into generic trip points and register
them with the thermal zone.

In order to consolidate the code, use the ACPI thermal framework API
to fill the generic trip point from the ACPI tables.

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
---
   V6:
      - Changed thermal ACPI function names according the changes done in the first patch
      - Put back the GTSH function here as it is specific to int340x

   V3:
      - The driver Kconfig option selects CONFIG_THERMAL_ACPI
      - Change the initialization to use GTSH for the hysteresis on
        all the trip points

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 168 +++++-------------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 3 files changed, 46 insertions(+), 133 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 5d046de96a5d..b7072d37101d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -9,6 +9,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
+	select THERMAL_ACPI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 228f44260b27..c0cd1d4283d6 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -37,65 +37,6 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
-					 int trip, int *temp)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	int i;
-
-	if (trip < d->aux_trip_nr)
-		*temp = d->aux_trips[trip];
-	else if (trip == d->crt_trip_id)
-		*temp = d->crt_temp;
-	else if (trip == d->psv_trip_id)
-		*temp = d->psv_temp;
-	else if (trip == d->hot_trip_id)
-		*temp = d->hot_temp;
-	else {
-		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-			if (d->act_trips[i].valid &&
-			    d->act_trips[i].id == trip) {
-				*temp = d->act_trips[i].temp;
-				break;
-			}
-		}
-		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
-					 int trip,
-					 enum thermal_trip_type *type)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	int i;
-
-	if (trip < d->aux_trip_nr)
-		*type = THERMAL_TRIP_PASSIVE;
-	else if (trip == d->crt_trip_id)
-		*type = THERMAL_TRIP_CRITICAL;
-	else if (trip == d->hot_trip_id)
-		*type = THERMAL_TRIP_HOT;
-	else if (trip == d->psv_trip_id)
-		*type = THERMAL_TRIP_PASSIVE;
-	else {
-		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-			if (d->act_trips[i].valid &&
-			    d->act_trips[i].id == trip) {
-				*type = THERMAL_TRIP_ACTIVE;
-				break;
-			}
-		}
-		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 				      int trip, int temp)
 {
@@ -109,20 +50,15 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	d->aux_trips[trip] = temp;
-
 	return 0;
 }
 
-
-static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
-		int trip, int *temp)
+static int int340x_thermal_get_global_hyst(struct acpi_device *adev, int *temp)
 {
-	struct int34x_thermal_zone *d = zone->devdata;
 	acpi_status status;
 	unsigned long long hyst;
 
-	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
+	status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
 	if (ACPI_FAILURE(status))
 		*temp = 0;
 	else
@@ -131,6 +67,7 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 	return 0;
 }
 
+
 static void int340x_thermal_critical(struct thermal_zone_device *zone)
 {
 	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
@@ -138,58 +75,36 @@ static void int340x_thermal_critical(struct thermal_zone_device *zone)
 
 static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
-	.get_trip_temp	= int340x_thermal_get_trip_temp,
-	.get_trip_type	= int340x_thermal_get_trip_type,
 	.set_trip_temp	= int340x_thermal_set_trip_temp,
-	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
 	.critical	= int340x_thermal_critical,
 };
 
-static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
-				      int *temp)
-{
-	unsigned long long r;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(handle, name, NULL, &r);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = deci_kelvin_to_millicelsius(r);
-
-	return 0;
-}
-
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
 {
-	int trip_cnt = int34x_zone->aux_trip_nr;
-	int i;
+	int trip_cnt;
+	int i, ret;
 
-	int34x_zone->crt_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
-					     &int34x_zone->crt_temp))
-		int34x_zone->crt_trip_id = trip_cnt++;
+	trip_cnt = int34x_zone->aux_trip_nr;
 
-	int34x_zone->hot_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_HOT",
-					     &int34x_zone->hot_temp))
-		int34x_zone->hot_trip_id = trip_cnt++;
+	ret = thermal_acpi_critical_trip_temp(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
-	int34x_zone->psv_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_PSV",
-					     &int34x_zone->psv_temp))
-		int34x_zone->psv_trip_id = trip_cnt++;
+	ret = thermal_acpi_hot_trip_temp(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
+
+	ret = thermal_acpi_passive_trip_temp(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
 
-		if (int340x_thermal_get_trip_config(int34x_zone->adev->handle,
-					name,
-					&int34x_zone->act_trips[i].temp))
+		ret = thermal_acpi_active_trip_temp(int34x_zone->adev, &int34x_zone->trips[trip_cnt], i);
+		if (ret)
 			break;
 
-		int34x_zone->act_trips[i].id = trip_cnt++;
-		int34x_zone->act_trips[i].valid = true;
+		trip_cnt++;
 	}
 
 	return trip_cnt;
@@ -208,7 +123,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	acpi_status status;
 	unsigned long long trip_cnt;
 	int trip_mask = 0;
-	int ret;
+	int i, ret;
 
 	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
 				      GFP_KERNEL);
@@ -228,32 +143,35 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		int34x_thermal_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (ACPI_FAILURE(status))
-		trip_cnt = 0;
-	else {
-		int i;
-
-		int34x_thermal_zone->aux_trips =
-			kcalloc(trip_cnt,
-				sizeof(*int34x_thermal_zone->aux_trips),
-				GFP_KERNEL);
-		if (!int34x_thermal_zone->aux_trips) {
-			ret = -ENOMEM;
-			goto err_trip_alloc;
-		}
-		trip_mask = BIT(trip_cnt) - 1;
+	if (!ACPI_FAILURE(status)) {
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
-		for (i = 0; i < trip_cnt; ++i)
-			int34x_thermal_zone->aux_trips[i] = THERMAL_TEMP_INVALID;
+		trip_mask = BIT(trip_cnt) - 1;
+	}
+
+	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
+					     (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
+					      GFP_KERNEL);
+	if (!int34x_thermal_zone->trips) {
+		ret = -ENOMEM;
+		goto err_trips_alloc;
 	}
 
 	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
 
+	for (i = 0; i < trip_cnt; ++i)
+		int340x_thermal_get_global_hyst(adev, &int34x_thermal_zone->trips[i].hysteresis);
+
+	for (i = 0; i < int34x_thermal_zone->aux_trip_nr; i++) {
+		int34x_thermal_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
+		int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
+	}
+	
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register(
+	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),
+						int34x_thermal_zone->trips,
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
 						int34x_thermal_zone->ops,
@@ -272,9 +190,9 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 err_enable:
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 err_thermal_zone:
+	kfree(int34x_thermal_zone->trips);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
-err_trip_alloc:
+err_trips_alloc:
 	kfree(int34x_thermal_zone->ops);
 err_ops_alloc:
 	kfree(int34x_thermal_zone);
@@ -287,7 +205,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
 {
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
+	kfree(int34x_thermal_zone->trips);
 	kfree(int34x_thermal_zone->ops);
 	kfree(int34x_thermal_zone);
 }
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index e28ab1ba5e06..0c2c8de92014 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -10,6 +10,7 @@
 #include <acpi/acpi_lpat.h>
 
 #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
+#define INT340X_THERMAL_MAX_TRIP_COUNT INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3
 
 struct active_trip {
 	int temp;
@@ -19,15 +20,8 @@ struct active_trip {
 
 struct int34x_thermal_zone {
 	struct acpi_device *adev;
-	struct active_trip act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
-	unsigned long *aux_trips;
+	struct thermal_trip *trips;
 	int aux_trip_nr;
-	int psv_temp;
-	int psv_trip_id;
-	int crt_temp;
-	int crt_trip_id;
-	int hot_temp;
-	int hot_trip_id;
 	struct thermal_zone_device *zone;
 	struct thermal_zone_device_ops *ops;
 	void *priv_data;
-- 
2.34.1

