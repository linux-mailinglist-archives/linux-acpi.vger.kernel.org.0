Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17F68A10B
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjBCR7Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjBCR7P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:59:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593192E82C
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:59:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q5so5415076wrv.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAXndW8cnBV3+ngs0K02NLGwczyzotwAPD8N8ShiwYk=;
        b=PWLPACbQ/nV+Qzotx45Bi6IXcdXtrj+EUb+UtwhJ56Od/Z8LMacFOyHwodvU05vtlZ
         SSUgUkrW0cAlFBAE8V4RAqv6JIrJnb7NQVipdNgMeN9Dj78JeSbW2nP3uiTSif15ooUs
         +zIIpxXbE8VCVLs2r+Ou3mFf6M06ZvA2neVUUKwYzp+Y0wQgCgYGU0e2qhgmBag+ORX7
         2N8jGa5gwq7EAiSPcG7doVI9ZOM1x0iJSzp7jdtzvEp+s4Aad2YOoCbOE2NkBPIJS2Ix
         1Eg/R3FrTP8SpoxGR6jA+FayvDBct913m3j6QJBUXAiB58bQ0QvfqDJf3RvNkN+MsYLf
         D6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAXndW8cnBV3+ngs0K02NLGwczyzotwAPD8N8ShiwYk=;
        b=iEx/4Q70LxFBMx/zchVtrKPpl5F+nBnR8E8vSh54PdIH1lmFn5sYnaJUBpbxZ1Htu/
         5y9osC4u30d2sdTc420ZhSnw6wTvSXAxkaz26yBhy3b9XcrQw9zSKTDwD5kiTioYEZGb
         3LYrtNQYTwc7Go1aWDLPMKY6UjqnNudwdb37rrjqFoQ5BZiXt/VXGCx4Ji3l7QEHotMg
         O5HHnkzQsGt+IPRRUGAHAzfaFGipVliKzvnC+2E9E07Kno33nxbdEZtwwxwAcPFJjJbP
         ePKQrwFkCD1QWFs2xHHWJJFxR1IRrYjOUyOZOjV3TD4Pns/owAq/jhIyTPKzzVIgfH3T
         LpYg==
X-Gm-Message-State: AO0yUKXlJCM0stTSTluAt7x5+lgP0y/O+9Ms41+IWe6e8tmVKVzxqlhY
        CNWek7wNYZwZjlkSfU+6mdtaoA==
X-Google-Smtp-Source: AK7set8ijXCv3HYsShNElZlKs0hYepcRyZAUe7b95uq7Zb3BQnwNsE7WskLXcPjZnTB3tOJK7iIFNA==
X-Received: by 2002:adf:fb03:0:b0:2be:57a6:8161 with SMTP id c3-20020adffb03000000b002be57a68161mr8387433wrr.46.1675447150846;
        Fri, 03 Feb 2023 09:59:10 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id s14-20020adfa28e000000b002c3be49ef94sm2599012wra.52.2023.02.03.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:59:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: Hunt zero trip points thermal zones usage
Date:   Fri,  3 Feb 2023 18:58:31 +0100
Message-Id: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Some drivers are declaring a thermal zone without any thermal trip
points.

On the other side, we are introducing the function
thermal_zone_device_register_with_trips() which provides an array of
generic thermal trip points. When all the drivers will be converted to
the generic trip points, keeping two functions will be useless.

Most of the drivers are now using
thermal_zone_device_register_with_trips() with the generic trip
points. As soon as the remaining drivers are merged, the
thermal_zone_device_register_with_trips() will be renamed to
thermal_zone_device_register().

Obviously this renaming can only happen if there are no more user of
the thermal_zone_device_register() function.

This change uses thermal_zone_device_register_with_trips() with a NULL
parameter for the trip point array instead of
thermal_zone_device_register().

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/power/supply/power_supply_core.c                | 2 +-
 drivers/thermal/armada_thermal.c                        | 4 ++--
 drivers/thermal/dove_thermal.c                          | 4 ++--
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 6 +++---
 drivers/thermal/kirkwood_thermal.c                      | 4 ++--
 drivers/thermal/spear_thermal.c                         | 5 +++--
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 7c790c41e2fe..208a849a71d9 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1166,7 +1166,7 @@ static int psy_register_thermal(struct power_supply *psy)
 
 	/* Register battery zone device psy reports temperature */
 	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
-		psy->tzd = thermal_zone_device_register(psy->desc->name,
+		psy->tzd = thermal_zone_device_register_with_trips(psy->desc->name, NULL,
 				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
 		if (IS_ERR(psy->tzd))
 			return PTR_ERR(psy->tzd);
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 99e86484a55c..83a4080bffc7 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -856,8 +856,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Wait the sensors to be valid */
 		armada_wait_sensor_validity(priv);
 
-		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
-						  &legacy_ops, NULL, 0, 0);
+		tz = thermal_zone_device_register_with_trips(priv->zone_name, NULL, 0, 0, priv,
+							     &legacy_ops, NULL, 0, 0);
 		if (IS_ERR(tz)) {
 			dev_err(&pdev->dev,
 				"Failed to register thermal zone device\n");
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 056622a58d00..fce15af5a7f6 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -142,8 +142,8 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	thermal = thermal_zone_device_register("dove_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	thermal = thermal_zone_device_register_with_trips("dove_thermal", NULL, 0, 0,
+							  priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index d0295123cc3e..dac60b6a281c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -609,9 +609,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	evaluate_odvp(priv);
 
-	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
-						priv, &int3400_thermal_ops,
-						&int3400_thermal_params, 0, 0);
+	priv->thermal = thermal_zone_device_register_with_trips("INT3400 Thermal", NULL, 0, 0,
+								priv, &int3400_thermal_ops,
+								&int3400_thermal_params, 0, 0);
 	if (IS_ERR(priv->thermal)) {
 		result = PTR_ERR(priv->thermal);
 		goto free_art_trt;
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index bec7ec20e79d..4506b7dfb474 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -74,8 +74,8 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
-	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	thermal = thermal_zone_device_register_with_trips("kirkwood_thermal", NULL, 0, 0,
+							  priv, &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 6a722b10d738..0d20bc9c5c0b 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -122,8 +122,9 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	stdev->flags = val;
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
-	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
-				stdev, &ops, NULL, 0, 0);
+	spear_thermal = thermal_zone_device_register_with_trips("spear_thermal",
+								NULL, 0, 0,
+								stdev, &ops, NULL, 0, 0);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
-- 
2.34.1

