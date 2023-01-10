Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8E664453
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jan 2023 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjAJPSC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Jan 2023 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjAJPR7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2023 10:17:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD9479C4
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2023 07:17:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12168487wmb.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2023 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrcxCeeay0Rm4vOJUjbE6UuD6Dxuu4zcZgbIQYt9xa0=;
        b=ZnsA71f671Od9jsT5NTbvffLY1vxL7IRMs+51L/YgOkBU/xH3ZynHgDHvEmzph0pv0
         m1dilH3JwBScjeN+Tb214+/y9wK7V5VVsjDuc4LKqjpLvHQPvF5NdxTv4IdUpv2p8wMZ
         hN35mSLIrcRrX7jOczCnGRk0qVJf5oIdtY9WnMWrdwJYE4ZuZfxcwJUN1w8xjPaNiOXp
         mL+kKTu826r16FiOeb6ggi0Obyr9vdK8xiNqkUSTCh8/efwFqoTsEJ/xoAcLjeHFanIJ
         RzoHkDKLAV9Brgzyv/PGURQb7IaZoflS/O7fS8RZ4BSk/RwrNpOAv8YT9HbdiHXEkt1v
         XJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrcxCeeay0Rm4vOJUjbE6UuD6Dxuu4zcZgbIQYt9xa0=;
        b=vi4FQ8BZiysVk1zxUAT39tw+3gB1ytW9dKjO1nJ4ckHJxzTe7k3Ar/9iaC+9v9gWvm
         07Q65bu7D1L8ygQO3HNRzgWjBV74DFXYCyYIIPV7I3PxSxIHFimf40E1ogTV72MH5MxC
         mvdaSylp6/oSK/7F27iGzYpT3NJutguwyD9DEO9yF4flP95c4Lj8Oew0u+O3pAkFwDlr
         j494rLRtkmx+5Ordg+Wx9rXIlO7x4gGYsStou3KGFoFYA3zRUBBTL+zTpcHp671rgRZ0
         HaimmKnZQjVZPHpIAH6dA3h2nQT29fVUpZ1on4O3aiUKDKui/4wF4DXpp4cameWyzDY/
         MiQg==
X-Gm-Message-State: AFqh2kpUpmKIszBWdiU/R8sZ/bM7GFLX1jnv7YedV5U3GNAxJKm4mA7V
        /iJ10AfkTR6h67/II61U4I8iXg==
X-Google-Smtp-Source: AMrXdXvmR/gZ9W/bTxvtnkUGwwNJZQHLf/dTeL+yTCUwmb0UfLyeWCKHQY5FbUsgNcaURT4ejrAxsg==
X-Received: by 2002:a05:600c:4998:b0:3cf:68d3:3047 with SMTP id h24-20020a05600c499800b003cf68d33047mr48748373wmp.41.1673363874642;
        Tue, 10 Jan 2023 07:17:54 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm14857281wma.48.2023.01.10.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:17:54 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 1/3] thermal/acpi: Add ACPI trip point routines
Date:   Tue, 10 Jan 2023 16:17:43 +0100
Message-Id: <20230110151745.2546131-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ACPI specification describes the trip points, the device tree
bindings as well.

The OF code uses the generic trip point structures.

The ACPI has their own trip points structure and uses the get_trip_*
ops to retrieve them.

We can do the same as the OF code and create a set of ACPI functions
to retrieve a trip point description. Having a common code for ACPI
will help to cleanup the remaining Intel drivers and get rid of the
get_trip_* functions.

These changes add the ACPI thermal calls to retrieve the basic
information we need to be reused in the thermal ACPI and Intel
drivers.

The different ACPI functions have the generic trip point structure
passed as parameter where it is filled.

This structure aims to be the one used by all the thermal drivers and
the thermal framework.

After this series, a couple of Intel drivers and the ACPI thermal
driver will still have their own trip points definition but a new
series on top of this one will finish the conversion to the generic
trip point handling.

This series depends on the generic trip point added to the thermal
framework and available in the thermal/linux-next branch.

 https://lkml.org/lkml/2022/10/3/456

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
  V3:
    - Removed too simple wrappers
    - Changed the API to return an error and check the validity of the value
    - Removed the comments describing the objects
    - Added kerneldoc
    - Made the Kconfig option silent
    - Set the hysteresis value to zero by default

  V2:
    - Fixed the missing thermal_acpi.c in the patch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig        |   4 +
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_acpi.c | 211 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |   8 ++
 4 files changed, 224 insertions(+)
 create mode 100644 drivers/thermal/thermal_acpi.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..eaeb2b2ee6e9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -76,6 +76,10 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_ACPI
+       depends on ACPI
+       bool
+
 config THERMAL_WRITABLE_TRIPS
 	bool "Enable writable trip points"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..60f0dfa9aae2 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
+thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
 
 # governors
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
new file mode 100644
index 000000000000..db0463ed05ec
--- /dev/null
+++ b/drivers/thermal/thermal_acpi.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ * 
+ * ACPI thermal configuration
+ */
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/units.h>
+#include <uapi/linux/thermal.h>
+
+#include "thermal_core.h"
+
+/*
+ * An hysteresis value below zero is invalid and we can consider a
+ * value greater than 20°K/°C is invalid too.
+ */
+#define HYSTERESIS_MIN_DECIK	0
+#define HYSTERESIS_MAX_DECIK	200
+
+/*
+ * Minimum temperature for full military grade is 218°K (-55°C) and
+ * max temperature is 448°K (175°C). We can consider those values as
+ * the boundaries for the [trips] temperature returned by the
+ * firmware. Any values out of these boundaries can be considered
+ * bogus and we can assume the firmware has no data to provide.
+ */
+#define TEMPERATURE_MIN_DECIK	2180
+#define TEMPERATURE_MAX_DECIK	4480
+
+static int thermal_acpi_get_temperature_object(struct acpi_device *adev,
+					       char *object, int *temperature)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, object, NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(adev->handle, "No temperature object '%s'\n", object);
+		return -ENODEV;
+	}
+
+	if (temp < TEMPERATURE_MIN_DECIK || temp >= TEMPERATURE_MAX_DECIK) {
+		acpi_handle_info(adev->handle, "Invalid temperature '%llu deci°K' for object '%s'\n",
+				 temp, object);
+		return -ENODATA;
+	}
+
+	*temperature = deci_kelvin_to_millicelsius(temp);
+
+	return 0;
+}
+
+/**
+ * thermal_acpi_trip_gtsh() - Get the global hysteresis value
+ * @adev: the acpi device to get the description from
+ *
+ * Get the global hysteresis value for the trip points. If any call
+ * fail, we shall return a zero hysteresis value.
+ *
+ * Return: An integer between %HYSTERESIS_MIN_DECIK and %HYSTERESIS_MAX_DECIK
+ */
+int thermal_acpi_trip_gtsh(struct acpi_device *adev)
+{
+	unsigned long long hyst;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	if (hyst < HYSTERESIS_MIN_DECIK || hyst >= HYSTERESIS_MAX_DECIK) {
+		acpi_handle_info(adev->handle, "Invalid hysteresis '%llu deci°K' for object 'GTSH'\n",
+				 hyst);
+		return 0;
+	}
+
+	return (int)hyst;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_gtsh);
+
+/**
+ * thermal_acpi_trip_act() - Get the specified active trip point
+ * @adev: the acpi device to get the description from
+ * @trip: a &struct thermal_trip to be filled if the function succeed
+ * @id: an integer speciyfing the active trip point id
+ *
+ * The function calls the ACPI framework to get the "_ACTx" and the
+ * 'GTSH' objects which describe the active trip points. The @id
+ * builds the "_ACTx" string with the numbered active trip point
+ * name. Then it fills the @trip structure with the information
+ * retrieved from those objects.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODEV - Failed to retrieve the ACPI object
+ * * -ENODATA - The ACPI object value appears to be inconsistent
+ */
+int thermal_acpi_trip_act(struct acpi_device *adev,
+			  struct thermal_trip *trip, int id)
+{
+	char name[5];
+	int ret;
+
+	sprintf(name, "_AC%d", id);
+
+	ret = thermal_acpi_get_temperature_object(adev, name, &trip->temperature);
+	if (ret)
+		return ret;
+	
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_ACTIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_act);
+
+/**
+ * thermal_acpi_trip_psv() - Get the passive trip point
+ * @adev: the acpi device to get the description from
+ * @trip: a &struct thermal_trip to be filled if the function succeed
+ *
+ * The function calls the ACPI framework to get the "_PSV" object
+ * which describe the passive trip point. Then it fills the @trip
+ * structure with the information retrieved from those objects.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODEV - Failed to retrieve the ACPI object
+ * * -ENODATA - The ACPI object value appears to be inconsistent
+ */
+int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	int ret;
+
+	ret = thermal_acpi_get_temperature_object(adev, "_PSV", &trip->temperature);
+	if (ret)
+		return ret;
+
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv);
+
+/**
+ * thermal_acpi_trip_hot() - Get the near critical trip point
+ * @adev: the acpi device to get the description from
+ * @trip: a &struct thermal_trip to be filled if the function succeed
+ *
+ * The function calls the ACPI framework to get the "_HOT" and the
+ * 'GTSH' objects which describe the hot trip point. Then it fills the
+ * @trip structure with the information retrieved from those objects.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODEV - Failed to retrieve the ACPI object
+ * * -ENODATA - The ACPI object appears to be inconsistent
+ */
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	int ret;
+
+	ret = thermal_acpi_get_temperature_object(adev, "_HOT", &trip->temperature);
+	if (ret)
+		return ret;
+
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_HOT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_hot);
+
+/**
+ * thermal_acpi_trip_crit() - Get the critical trip point
+ * @adev: the acpi device to get the description from
+ * @trip: a &struct thermal_trip to be filled if the function succeed
+ *
+ * The function calls the ACPI framework to get the "_CRT" object
+ * which describe the critical trip point. Then it fills the @trip
+ * structure with the information retrieved from this object.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODEV - Failed to retrieve the ACPI object
+ * * -ENODATA - The ACPI object value appears to be inconsistent
+ */
+int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	int ret;
+	
+	ret = thermal_acpi_get_temperature_object(adev, "_CRT", &trip->temperature);
+	if (ret)
+		return ret;
+
+	/* 
+	 * The hysteresis value has no sense here because critical
+	 * trip point has no u-turn
+	 */
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_CRITICAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_crit);
+
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 30353e4b1424..ba2d5d4c23e2 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -334,6 +334,14 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_THERMAL_ACPI
+int thermal_acpi_trip_gtsh(struct acpi_device *adev);
+int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_act(struct acpi_device *adev, struct thermal_trip *trip, int id);
+#endif
+
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-- 
2.34.1

