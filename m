Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83E6AE0D3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 14:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCGNih (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 08:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCGNiQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 08:38:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859D168BA
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 05:38:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f11so12137295wrv.8
        for <linux-acpi@vger.kernel.org>; Tue, 07 Mar 2023 05:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r31ohlDpv5otoAeD1bVOzDiFSts1H09pvgDJbkHz6kE=;
        b=TrUavH00tT8Tlc+XRCN+f0574vfg/jdmj2Iyd/dME2zutf2oub0jR4gbiET5ga102A
         HyoDuym9ddEz4WOlG7ymyFBAaTKtxu+JAFJi5Z7z+L0cp/yEFhaHHLbYheaxkxzuUXPy
         /MP2+UF36Miaj3r6lQxR2JuGjCQFo5LhpOEWKBzraqBuzEtNIz6qoqHylZVuvqIHHqkV
         ZFAsAGbVOyNoQOH739V4xtKjtdSnEIDUf6hL9ZlHLf79ausXxl3+oAdbr9E5ZtRbSV8T
         4PHv71I2DWaXwgT1BbkhdL++T6oHDj8AniwXTJRSSBTVdBLohG05y+6BJ2+okXwyF/UX
         vBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r31ohlDpv5otoAeD1bVOzDiFSts1H09pvgDJbkHz6kE=;
        b=My0aARx7vhyuA5z0KxTz9PeVFZV4qm3gyrNglrxJF57/nD5zTePeSxfJOxxoBGIYZX
         bz0LI9MbsuyaIqOaEBzi0xlQC22aJ/VCMPuN2eUiEE5ed1XMIM8923h7leW9AFf3PZnp
         4AR6hxMTpoA0J9/DooTo6lmltU/zuM8gZlSlbcOwDrY17i9dIywIJ6vIkmfP2yqA6ag0
         4UBzE9sMvIN/NcO4GDAD0eRRPfn2CwElEgipl847y0WjU5tJIhfd+BOTwkdlB3wAGozF
         hrLZk9QIVIzV9hiYIIHj1k1gV3X/O4qD/ujBDT/p5cAIpV/WUdIUXyuwf0qygN1U4rnL
         IysQ==
X-Gm-Message-State: AO0yUKW1EjkDE0M5uxiHO0/vVwgW1kdMMZ/bum5wIQkmsGBLSVUhSv8e
        lbMgXy+RB4qAzSaf5OynYGdoQQ==
X-Google-Smtp-Source: AK7set+Tx3PciiUAChxOXg06dWYuz/nGFE4lhye4WaWUJHVZ6BSEpSWXgQBpiWbJ17Umzi/bfQDSOA==
X-Received: by 2002:adf:e30f:0:b0:2c8:309d:77b0 with SMTP id b15-20020adfe30f000000b002c8309d77b0mr9443409wrj.0.1678196285292;
        Tue, 07 Mar 2023 05:38:05 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:38:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 11/11] thermal/acpi: Use the thermal zone parameter to specify the device link
Date:   Tue,  7 Mar 2023 14:37:35 +0100
Message-Id: <20230307133735.90772-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The thermal framework can create a cyclic link between the driver and
the device via the thermal zone parameters when registering the
thermal zone.

As this option is supported by the thermal core code, let's use it and
remove the specific code in the ACPI driver. This change has the
benefit of self-encapsulate the thermal zone device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 255efa73ed70..7d5c56564556 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -789,6 +789,7 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct thermal_zone_params tzp = { .linked_dev = &tz->device->dev };
 	int trips = 0;
 	int result;
 	acpi_status status;
@@ -808,33 +809,23 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 	if (tz->trips.passive.flags.valid)
 		tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
-								&acpi_thermal_zone_ops, NULL,
+								&acpi_thermal_zone_ops, &tzp,
 								tz->trips.passive.tsp * 100,
 								tz->polling_frequency * 100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops, NULL,
+						     &acpi_thermal_zone_ops, &tzp,
 						     0, tz->polling_frequency * 100);
 
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
-	result = sysfs_create_link(&tz->device->dev.kobj,
-				   &tz->thermal_zone->device.kobj, "thermal_zone");
-	if (result)
-		goto unregister_tzd;
-
-	result = sysfs_create_link(&tz->thermal_zone->device.kobj,
-				   &tz->device->dev.kobj, "device");
-	if (result)
-		goto remove_tz_link;
-
 	status =  acpi_bus_attach_private_data(tz->device->handle,
 					       tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
-		goto remove_dev_link;
+		goto unregister_tzd;
 	}
 
 	result = thermal_zone_device_enable(tz->thermal_zone);
@@ -848,20 +839,13 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 acpi_bus_detach:
 	acpi_bus_detach_private_data(tz->device->handle);
-remove_dev_link:
-	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
-remove_tz_link:
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
-
 	return result;
 }
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
-	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
-- 
2.34.1

