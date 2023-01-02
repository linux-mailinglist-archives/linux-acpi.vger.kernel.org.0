Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB27365B61B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jan 2023 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjABSBn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Jan 2023 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjABSB2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jan 2023 13:01:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C938BD
        for <linux-acpi@vger.kernel.org>; Mon,  2 Jan 2023 10:01:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id co23so27006196wrb.4
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jan 2023 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3POAW24Ia6Q6A+aQpi4Ruj0SmwaygTczZXF7y8o1qdY=;
        b=HTYIjR510LBjsWbfxE9VaopKOa5/Xr077RkfF8WnFgFGDU8JLmuRws9sjNaQ4PWy4g
         +NqPU3DAkmPBR9NLjN9clgGhgu5WTMu+iq/sMhKryWNqKNwJU9oS7CBYLN8yXgJex2Nv
         RXaN3kkfM3kRNIeDQ0ULuLPIM1870Q+EbFVAI8at7YtU0TD0W2yLYU9PXNZjZHV7VxiC
         fM7Phn92mVdsMaL6Y33b7OawzHZyjBcdJvk2Q0I+m8m6GaZ71LzBLVhvX2pztvLSmbiv
         pwUlgZB9YBSj0OsbdsaCqzuSuNkM0EV/3WHTBUGk35koMjUceQvkDyZ2ze5NVr1e+CfP
         SFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3POAW24Ia6Q6A+aQpi4Ruj0SmwaygTczZXF7y8o1qdY=;
        b=BuK2TMyza7l/fQIWgkmJd/KcaRs161E/9oenG6/CLxBa2vtWHgN+LOE+2p8Cx0J/f0
         JPKR4viPH5If/vpD/+fKz2JUX1IwyzcmplSIXwoB+F8dMo/pXvt3ThiYJBr4OQjEhh2q
         0wSYXj4F/XkizYGDSfuvHfrPaFu1B1Gdv7m2QnOg7cbdDiT3M12lz1kf1xK9yUp3bwR2
         bItNd2qmbLjeaHqeXM3a2x2HsyUfqfzw2AzRfnoWjopxu0llf3jeVMQe2XyK6ZlZY5cU
         XiqC1nHIwxo/Fed6EyuqrbKclILImvmKmTgmlDd6MxW08mz4V22Ew99g5me5vueY528b
         Z5kw==
X-Gm-Message-State: AFqh2kpgpqp078KPBZlKMOlJFvkq4zRdX8DXZzcI8g/n5g2NisBCk20+
        iME49eCTUQo9cAt7cXoEZD2YhQ==
X-Google-Smtp-Source: AMrXdXstrEmEY5GESCPVDDdHHvZcc3FS3MM/lfrjVSY0rg9P4mTlz1JvVcFUp7droAgj/omnG9C7fw==
X-Received: by 2002:adf:f00c:0:b0:242:63e5:fdaa with SMTP id j12-20020adff00c000000b0024263e5fdaamr23363745wro.62.1672682485581;
        Mon, 02 Jan 2023 10:01:25 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b0027cb20605e3sm21375588wrs.105.2023.01.02.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 10:01:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/3] thermal/drivers/intel: Use generic trip points for intel_pch
Date:   Mon,  2 Jan 2023 19:01:11 +0100
Message-Id: <20230102180112.1954082-3-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
References: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert the ops content logic into generic trip points and register
them with the thermal zone.

In order to consolidate the code, use the ACPI thermal framework API
to fill the generic trip point from the ACPI tables.

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/intel/intel_pch_thermal.c | 88 +++++------------------
 1 file changed, 19 insertions(+), 69 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dabf11a687a1..530fe9b38381 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -65,6 +65,8 @@
 #define WPT_TEMP_OFFSET	(PCH_TEMP_OFFSET * MILLIDEGREE_PER_DEGREE)
 #define GET_PCH_TEMP(x)	(((x) / 2) + PCH_TEMP_OFFSET)
 
+#define PCH_MAX_TRIPS 3 /* critical, hot, passive */
+
 /* Amount of time for each cooling delay, 100ms by default for now */
 static unsigned int delay_timeout = 100;
 module_param(delay_timeout, int, 0644);
@@ -82,12 +84,7 @@ struct pch_thermal_device {
 	const struct pch_dev_ops *ops;
 	struct pci_dev *pdev;
 	struct thermal_zone_device *tzd;
-	int crt_trip_id;
-	unsigned long crt_temp;
-	int hot_trip_id;
-	unsigned long hot_temp;
-	int psv_trip_id;
-	unsigned long psv_temp;
+	struct thermal_trip trips[PCH_MAX_TRIPS];
 	bool bios_enabled;
 };
 
@@ -102,33 +99,22 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 				      int *nr_trips)
 {
 	struct acpi_device *adev;
-
-	ptd->psv_trip_id = -1;
+	int ret;
 
 	adev = ACPI_COMPANION(&ptd->pdev->dev);
-	if (adev) {
-		unsigned long long r;
-		acpi_status status;
-
-		status = acpi_evaluate_integer(adev->handle, "_PSV", NULL,
-					       &r);
-		if (ACPI_SUCCESS(status)) {
-			unsigned long trip_temp;
-
-			trip_temp = deci_kelvin_to_millicelsius(r);
-			if (trip_temp) {
-				ptd->psv_temp = trip_temp;
-				ptd->psv_trip_id = *nr_trips;
-				++(*nr_trips);
-			}
-		}
-	}
+	if (!adev)
+		return;
+		
+	ret = thermal_acpi_trip_psv(adev, &ptd->trips[*nr_trips]);
+	if (ret)
+		return;
+
+	++(*nr_trips);
 }
 #else
 static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 				      int *nr_trips)
 {
-	ptd->psv_trip_id = -1;
 
 }
 #endif
@@ -163,21 +149,19 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	}
 
 read_trips:
-	ptd->crt_trip_id = -1;
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->crt_temp = GET_WPT_TEMP(trip_temp);
-		ptd->crt_trip_id = 0;
+		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[*nr_trips].type = THERMAL_TRIP_CRITICAL;
 		++(*nr_trips);
 	}
 
-	ptd->hot_trip_id = -1;
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->hot_temp = GET_WPT_TEMP(trip_temp);
-		ptd->hot_trip_id = *nr_trips;
+		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[*nr_trips].type = THERMAL_TRIP_HOT;
 		++(*nr_trips);
 	}
 
@@ -298,39 +282,6 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 	return	ptd->ops->get_temp(ptd, temp);
 }
 
-static int pch_get_trip_type(struct thermal_zone_device *tzd, int trip,
-			     enum thermal_trip_type *type)
-{
-	struct pch_thermal_device *ptd = tzd->devdata;
-
-	if (ptd->crt_trip_id == trip)
-		*type = THERMAL_TRIP_CRITICAL;
-	else if (ptd->hot_trip_id == trip)
-		*type = THERMAL_TRIP_HOT;
-	else if (ptd->psv_trip_id == trip)
-		*type = THERMAL_TRIP_PASSIVE;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *temp)
-{
-	struct pch_thermal_device *ptd = tzd->devdata;
-
-	if (ptd->crt_trip_id == trip)
-		*temp = ptd->crt_temp;
-	else if (ptd->hot_trip_id == trip)
-		*temp = ptd->hot_temp;
-	else if (ptd->psv_trip_id == trip)
-		*temp = ptd->psv_temp;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static void pch_critical(struct thermal_zone_device *tzd)
 {
 	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
@@ -338,8 +289,6 @@ static void pch_critical(struct thermal_zone_device *tzd)
 
 static struct thermal_zone_device_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
-	.get_trip_type = pch_get_trip_type,
-	.get_trip_temp = pch_get_trip_temp,
 	.critical = pch_critical,
 };
 
@@ -423,8 +372,9 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_cleanup;
 
-	ptd->tzd = thermal_zone_device_register(bi->name, nr_trips, 0, ptd,
-						&tzd_ops, NULL, 0, 0);
+	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
+							   nr_trips, 0, ptd,
+							   &tzd_ops, NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
 			bi->name);
-- 
2.34.1

