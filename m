Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49796676150
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jan 2023 00:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjATXPz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 18:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjATXPv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 18:15:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8D151421
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 15:15:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y1so1600898wru.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GqNUBNPb4FrqrObowiEfJdLlDOURdpHlsNV8vYm+w0=;
        b=V+dqd01OtC9x9HcxN1eVQup28u1BdorVv9yEq5mIhZebGtanPITQZo87sKVgl8WxGF
         qtAKzftadJC6ZqrGiA4fKTg8XElnrlZ5kH9Qnc2u7dyZ0O9oHnpCHodx/k3t/VY17uzZ
         lmdrI8CMrzWbe+oIfRBA/at+MJDZaMsDswa0Gf9k8SADxotas8KISB1cRT2zTCyXSkR6
         641K/RsuzCiUDZCZ474ILOp/YFl6yftrmEs//G+wh29VNgkdMwSiMs2x+pHuVmxayMgx
         uIsrNPZOydME0ZEQnZUDYLrIhv9EsIIaOSAe5XhFCV57KbZ6Vb9lzK4Po9nZndELHa+k
         2IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GqNUBNPb4FrqrObowiEfJdLlDOURdpHlsNV8vYm+w0=;
        b=hlLNoYR2U0jMNw+tHFjjNSzCi1Q7iSiDjDyEwLLUxy7GIAnZ/KgD4PcUA/1ubi2jLl
         PKATYDGbbmLt/dZCb7d/YEtYDsTsmpV7IMCGivHp4u5q689xmHHss2Gu20yGz4tnGv7O
         PBC2MdRYyrqCEsPdijyMuQHfopFAibfGSicetVHSp4gvnqXNXRuwM5IlCyuRmeA29IQO
         qpgOvDJ/1mvBYT2Kdr7EYC9uElkXjJGZzmKMyxYoqf8OeJOmDqDUZpd29Xx9WckQy+ZA
         U0hnm/SZ95+1We9rufEqcOFGRm4+Lhq4znhx9zGlKqzWIhhEVNoTXf14NuZW7n5tQf6W
         3RDw==
X-Gm-Message-State: AFqh2kpymCWjAz9rxYEZqVQnziGw52yIqFwBx6zx9+u8nFh/wWuy3EDh
        tzTzGjrVw2bVyMtrsluNfXDRsg==
X-Google-Smtp-Source: AMrXdXvitctFbFhUa7Up0/SYPSpjhYvhHY9dLKo4Cx5DlJWsL/uLN4kf44Hx6rJVlb9hr76LKVKjCg==
X-Received: by 2002:a5d:4103:0:b0:2be:5408:5d6d with SMTP id l3-20020a5d4103000000b002be54085d6dmr4037839wrp.21.1674256548930;
        Fri, 20 Jan 2023 15:15:48 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm36436828wrx.21.2023.01.20.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 15:15:48 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr,
        Amit Kucheria <amitk@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v6 2/3] thermal/drivers/intel: Use generic trip points for intel_pch
Date:   Sat, 21 Jan 2023 00:15:29 +0100
Message-Id: <20230120231530.2368330-3-daniel.lezcano@linaro.org>
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
     - Propagate the function name change from thermal ACPI

   V4:
     - Changed select THERMAL_ACPI if ACPI in order to prevent
      dependency inconsistency

   V3:
     - The driver Kconfig option selects CONFIG_THERMAL_ACPI

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/Kconfig             |  1 +
 drivers/thermal/intel/intel_pch_thermal.c | 88 +++++------------------
 2 files changed, 20 insertions(+), 69 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index f0c845679250..7d68c076c23d 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -75,6 +75,7 @@ config INTEL_BXT_PMIC_THERMAL
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
 	depends on X86 && PCI
+	select THERMAL_ACPI if ACPI
 	help
 	  Enable this to support thermal reporting on certain intel PCHs.
 	  Thermal reporting device will provide temperature reading,
diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dabf11a687a1..5f1568270fc7 100644
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
+	ret = thermal_acpi_passive_trip_temp(adev, &ptd->trips[*nr_trips]);
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

