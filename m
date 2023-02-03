Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A226868A050
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjBCReC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjBCRd5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:33:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBBA4284
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:33:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so6505449wmb.4
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImiRnspQldFz7aUHwWWQjNaQE6HDsbMFrGvzaxyK5ic=;
        b=DrUrXi+3MZkKGS1YkNuyIUAsszP2BKSd0lj3kjyE32lDqIQzjAc32ARNByxftBoL/L
         bECIbPXeJlDE12N+JgqGeUucqOHSkO+7huARpQlwgpwwAoJw/Jk0qCoVxF2Eei/03wci
         MNDGHZpZn1oBctXywwrApgshMLnVywL1UzrInacXI7ASed8Ibc5CNGtvXOHXl/snQcUB
         YTbLPBwy6uv1CgqJAkIfMhQc8auPb0Lh2L98VSq/2mXHLfsm2qeGAGTrHwlSXCRK/k1v
         +xnP1sAufZJWvvFZMKcU+v+6DJGGs859kK1uQG3LuY9txUs1xJURgTNai1rBhukduh+O
         w1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImiRnspQldFz7aUHwWWQjNaQE6HDsbMFrGvzaxyK5ic=;
        b=kTP8hn7acJwsBzqieki2LHFQY5DK9JbUXbqhWHMN0ZG282oz2r13tsc+3qAbuIXGiC
         i8U2RHiROJ/dXW+y8IxkGEgRzGAfNpv8deDCmEGIEpi5Sis6Kn1tpLMmK/J7PA7M7wdu
         XQ/NnQbyZp80KZynhNk/ZRJiZh5VgCekQu5jC5aPTxRzbw0Parp0P0jwhmWa8Ok9xxKe
         9Zee6PSTdR73REZQDDkRrQPW9UXn1DIDkJ24uNx44zifDW+LIGDE3k+5rKuj0lfFF8zZ
         oXrh3td84wNTr9ZRrik7AW8J8/0d8BNOFsz0ldZ76gvrDgIBi7ILEgz/cdDX7N6XZCJz
         NDWQ==
X-Gm-Message-State: AO0yUKVxUGijByV9EZbyI4Jb0+KGMGveHiVNDiraI1LPODvymMfci4yL
        WMdCI0qpR6clYGm0O9vgWXt2kw==
X-Google-Smtp-Source: AK7set+eMPg1WZNepDpu7gVBu0BxBwV+B1QdmNepYQkXk/BukKkfYSTe5vSBs4tqpjqwGxCTRlrvng==
X-Received: by 2002:a05:600c:3ba7:b0:3df:50eb:7ca6 with SMTP id n39-20020a05600c3ba700b003df50eb7ca6mr8334613wms.15.1675445633074;
        Fri, 03 Feb 2023 09:33:53 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 05/11] thermal/acpi: Optimize get_trip_points()
Date:   Fri,  3 Feb 2023 18:33:25 +0100
Message-Id: <20230203173331.3322089-6-daniel.lezcano@linaro.org>
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

The function has two purposes. Initialize the trip points by reading
the ACPI table and then doing a check trip points exists.

This check will go through all the trip points and at the end if a
valid trip point is found, the parsing is considered valid.

Instead of checking all the trip points, exit when a valid trip point
is found.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 903f0e3d95f5..c4fd583fbf5c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -461,23 +461,20 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	int i, valid, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+	int i, ret;
 
+	ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 	if (ret)
 		return ret;
 
-	valid = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid |
-		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
-		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (tz->trips[i].flags.valid)
+			return 0;
+	}
 
-	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->trips[i].flags.valid;
+	pr_warn(FW_BUG "No valid trip found\n");
 
-	if (!valid) {
-		pr_warn(FW_BUG "No valid trip found\n");
-		return -ENODEV;
-	}
-	return 0;
+	return -ENODEV;
 }
 
 /* sys I/F for generic thermal sysfs support */
-- 
2.34.1

