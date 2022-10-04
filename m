Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A075F4873
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Oct 2022 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJDR1b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Oct 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJDR1W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 13:27:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6095509F
        for <linux-acpi@vger.kernel.org>; Tue,  4 Oct 2022 10:27:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a3so10114618wrt.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Oct 2022 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHWVJjYFys4E4VnwcJwmNb2PtDiS0NwkDLnS2KTt1pw=;
        b=pluwJqgQQFeUu18QT/MQePJPn3oDIyzD7d3xvyWidLpLiqJYr2mv2B7kxxfq4pFNp3
         q1iDaVs1NMANu/AENgfAuBgGZjFcXTEa6xK9NWBzn4OFc8b715HSsrSH6Ll0+BLsqjmU
         9P7fvpWx7WqegwnAoVCXgjSPAqU1hvQx9Jlxs8AAIxdC/UrHztzHcIyCoYSMxuWnxkyc
         sx0Z3A6l2mud8VVSuhlSITHntNnxsRj4bwAdbJuthhG6gBeRsCUKrjWbuGiWHegCYs4M
         Ey9MxqUJi+fVkenpvV1JyTC9kKUJT5IGMGV7sfcd28JipsyjbflWA+WFUIPxliJ1ht/U
         7Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHWVJjYFys4E4VnwcJwmNb2PtDiS0NwkDLnS2KTt1pw=;
        b=N2Be4cOTzYdMmat2KfcEBCZCA2JNdm2iBZPl2RIbDx+fmQd+8iPaBWjoCNOhI14Dte
         g3FiCuXjaVAMuF1yF6JeZw2z+NIQ4WrqT6l7ytram9lhdgXD7/ALyvYDUKl3ReSJwUDl
         5CW6eFcSRYii4umJFqn2b+cF7RSyOH8vPqOzHdXvCpQ1aoQqLjGYTIttEsHV+LGNTrZP
         PIySvBRBzoASt4e2VyLH0naf9pbzeUAp9txg6ipxFm6fvfoJN/VAg1YL1R0M5PXhGZKE
         rjymzzqcyRpKs4C0FUvSCVlNAKF+8c0IffPMBAk2XRUST2CBQ0zK4eyXXoU1V7ow7wad
         DF2g==
X-Gm-Message-State: ACrzQf0PYDITy0Z+4/Uko4zKjfGo6ukTUkTiGLYt8gwibu33dkuj01Pq
        3cylA/VJ0qDOIgZsV1LccZjwIjDnmIePsw==
X-Google-Smtp-Source: AMsMyM5UpumukXIoVvrJrUKr894WHOr/KlXAAce/RDZZCESdtJwSKZmswqVXZTJz+gGA8M12fmPDpA==
X-Received: by 2002:a05:6000:144f:b0:22a:94f1:25d6 with SMTP id v15-20020a056000144f00b0022a94f125d6mr16343460wrx.422.1664904438890;
        Tue, 04 Oct 2022 10:27:18 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 9/9] thermal/acpi: Rewrite the trip point intialization to use the generic thermal trip
Date:   Tue,  4 Oct 2022 19:26:58 +0200
Message-Id: <20221004172658.2302511-10-daniel.lezcano@linaro.org>
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

We can use the thermal trip points defined in the thermal.h.

Let's initialize them properly and when the code will be moved to the
generic thermal structure, we will be able to remove the specific acpi
trip points. Still WIP.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 211 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 186 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f530dbfa80db..994b96807be3 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -244,6 +244,171 @@ do {	\
 		"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
+static void acpi_thermal_trips_override_critical(struct thermal_trip *trip,
+						 int temperature)
+{
+        int ktemp = = celsius_to_deci_kelvin(temperature);
+
+	if (ktemp > trip->temperature)
+		pr_info("Overriding %d C\n", temperature);
+
+	trip->temperature = ktemp;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_thermal *tz,
+							      struct thermal_trip *trips,
+							      int *num_trips)
+{
+	acpi_status status = AE_OK;
+	unsigned long long temp;
+
+	/*
+	 * Module parameters disable the critical trip point
+	 */
+	if (crt < 0)
+		goto out;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
+		goto out;
+	}
+
+	if (temp <= 2732) {
+		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", temp);
+		goto out;
+	}
+
+	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+	if (!trips)
+		goto out;
+
+	memset(&trips[*num_trips], 0, sizeof(*trips));
+
+	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+	trips[*num_trips].type = THERMAL_TRIP_CRITICAL;
+
+	if (crt > 0)
+		acpi_thermal_trips_override_critical(&trips[*num_trips], crt);
+	
+	(*num_trips)++;
+out:
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_hot(struct acpi_thermal *tz,
+							 struct thermal_trip *trips,
+							 int *num_trips)
+{
+	acpi_status status = AE_OK;
+	unsigned long long temp;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
+		goto out;
+	}
+
+	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+	if (!trips)
+		goto out;
+
+	memset(&trips[*num_trips], 0, sizeof(*trips));
+
+	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+	trips[*num_trips].type = THERMAL_TRIP_HOT;
+	
+	(*num_trips)++;
+out:
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal *tz,
+							     struct thermal_trip *trips,
+							     int *num_trips)
+{
+	acpi_status status;
+	unsigned long long temp;
+
+	/*
+	 * Module parameters disable all passive trip points
+	 */
+	if (psv < 0)
+		goto out;
+	
+	status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No passive threshold\n");
+		goto out;
+	}
+
+	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+	if (!trips)
+		goto out;
+
+	memset(&trips[*num_trips], 0, sizeof(*trips));
+
+	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+	trips[*num_trips].type = THERMAL_TRIP_PASSIVE;
+	
+	(*num_trips)++;
+out:
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal *tz,
+							    struct thermal_trip *trips,
+							    int *num_trips)
+{
+	acpi_status status;
+	unsigned long long temp;
+	int i;
+
+	/*
+	 * Module parameters disable all active trip points
+	 */
+	if (act < 0)
+		return trips;
+
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
+
+		status = acpi_evaluate_integer(tz->device->handle, name, NULL, &temp);
+		if (ACPI_FAILURE(status))
+			break;
+
+		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+		if (!trips)
+			break;
+
+		memset(&trips[*num_trips], 0, sizeof(*trips));
+
+		trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+		trips[*num_trips].type = THERMAL_TRIP_ACTIVE;
+	
+		(*num_trips)++;
+	}
+
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc(struct acpi_thermal *tz, int *num_trips)
+{
+	struct thermal_trip *trips = NULL;
+
+	*num_trips = 0;
+
+	trips = acpi_thermal_trips_alloc_critical(tz, trips, num_trips);
+
+	trips = acpi_thermal_trips_alloc_hot(tz, trips, num_trips);
+
+	trips = acpi_thermal_trips_alloc_passive(tz, trips, num_trips);
+
+	trips = acpi_thermal_trips_alloc_active(tz, trips, num_trips);
+
+	return trips;
+}
+
 static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status = AE_OK;
@@ -824,36 +989,24 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.critical = acpi_thermal_zone_device_critical,
 };
 
-static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
+static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
+					      struct thermal_trip *trips,
+					      int num_trips)
 {
-	int trips = 0;
 	int result;
 	acpi_status status;
-	int i;
-
-	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid)
-		trips++;
-
-	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid)
-		trips++;
-
-	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
-		trips++;
-
-	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE &&
-			tz->trips[i].flags.valid; i++, trips++);
 
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
-						&acpi_thermal_zone_ops, NULL,
-						     tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
-						     tz->polling_frequency*100);
+			thermal_zone_device_register_with_trips("acpitz", trips, num_trips, 0, tz,
+								&acpi_thermal_zone_ops, NULL,
+								tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
+								tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
-						&acpi_thermal_zone_ops, NULL,
-						0, tz->polling_frequency*100);
+			thermal_zone_device_register_with_trips("acpitz", trips, num_trips, 0, tz,
+								&acpi_thermal_zone_ops, NULL,
+								0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
@@ -1060,7 +1213,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_thermal *tz = NULL;
-
+	struct thermal_trip *trips;
+	int num_trips;
 
 	if (!device)
 		return -EINVAL;
@@ -1081,9 +1235,13 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_thermal_guess_offset(tz);
 
-	result = acpi_thermal_register_thermal_zone(tz);
+	trips = acpi_thermal_trips_alloc(tz, &num_trips);
+	if (!trips)
+		goto free_trips;
+
+	result = acpi_thermal_register_thermal_zone(tz, trips, num_trips);
 	if (result)
-		goto free_memory;
+		goto free_trips;
 
 	refcount_set(&tz->thermal_check_count, 3);
 	mutex_init(&tz->thermal_check_lock);
@@ -1095,6 +1253,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 free_memory:
 	kfree(tz);
+free_trips:
+	kfree(trips);
 end:
 	return result;
 }
@@ -1109,6 +1269,7 @@ static int acpi_thermal_remove(struct acpi_device *device)
 	flush_workqueue(acpi_thermal_pm_queue);
 	tz = acpi_driver_data(device);
 
+	kfree(tz->trips);
 	acpi_thermal_unregister_thermal_zone(tz);
 	kfree(tz);
 	return 0;
-- 
2.34.1

