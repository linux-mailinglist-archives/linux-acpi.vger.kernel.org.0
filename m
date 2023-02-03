Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149FD68A046
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjBCRd5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBCRdw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:33:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78BA428B
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:33:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so2952125wms.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLokg2NHvRs8lyMVKIrJy/BKSUdWDoE+8uppdEp+JpA=;
        b=P0Y2vZ3XD8ktpIwFi/Qr/mOT/TImaxqPg5YbVDEPDqt5Gmg813D89bZXpB7ukNEcWO
         kqAC4G0t1LLUG3CJJg0/lcgD7DkbjiqJnUHluYvRh0rHKu1l/29IeQ8e0/G1Mqm2q1DD
         CxwrCrmCreJxZnshMYmGprWbq72ic3XBKengj+YrZBU/R4mYuKOPMbdEmM+dnRooTYC3
         nvdLhCNedc1TcVindRjoSgnBDTN0K8w8ONMf7q5WQhXxHtFAVEA8Xim9c5jF89AjlPVz
         ntYw0prj5hx7nzXDjWU4Em3RVeSp54kYTwYrsWV9bu9m/fy0sTT4pAg7NfDsy7/KQR23
         Xf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLokg2NHvRs8lyMVKIrJy/BKSUdWDoE+8uppdEp+JpA=;
        b=3v0VAgW5hEVHJum7p8jDZB2rH98+eTd2ks68C6SV4PKnm+6pDiuRvgKu88+43YdozB
         I4KVDDT0a797Kst/Ysl0CzYz9ktuXiadKpEMECCw/W38PmJH6yxzrDrJAqg4Zbd/LlR9
         srnYUa6TCB6JpNV/UAiFakv+GW2aF352tsQyGp8JQpbYNRfZQ3s1RIQlJ4sUGWGHhESB
         iqXqDVs9FhGRNHfBefb/qJO8uFoRxoq83BmKgQa8SPDEI0QVlDUmw3wkTGk2Jai7rZHv
         Lm1hjVwKV3oOc/bXKbJ+snjY9XJvhZL582ucHE/JyO0rQF6BVw05xOUqsUZcpas/Bh6T
         9zYA==
X-Gm-Message-State: AO0yUKUpCXA4jGZLcAIQ4MOh+2gkyA5zTpMRUsETzMrttHt9/EUwNVDD
        53TGaPylHsLVbayibGk5IPF56ZyO1EipHnss
X-Google-Smtp-Source: AK7set8rFztc7uiBabtRGluqWDn2MiYkV28+v5RhxZDOYVNv50VfbLOJK9qzMtxxCUn33wb80YPGUA==
X-Received: by 2002:a05:600c:1e24:b0:3da:f665:5b66 with SMTP id ay36-20020a05600c1e2400b003daf6655b66mr13119621wmb.6.1675445629774;
        Fri, 03 Feb 2023 09:33:49 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 02/11] thermal/acpi: Change to a common acpi_thermal_trip structure
Date:   Fri,  3 Feb 2023 18:33:22 +0100
Message-Id: <20230203173331.3322089-3-daniel.lezcano@linaro.org>
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

The acpi trip point definition are very similar whatever their
types. Instead of creating a different structure for each trip type,
let's define and use a common one.

With this change we move a step forward to the generic trip point.

No functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0dbce190cacc..e27b0b71fcf8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -119,36 +119,13 @@ struct acpi_thermal_state_flags {
 	u8 reserved:6;
 };
 
-struct acpi_thermal_critical {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-};
-
-struct acpi_thermal_hot {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-};
-
-struct acpi_thermal_passive {
+struct acpi_thermal_trip {
 	struct acpi_thermal_state_flags flags;
+	struct acpi_handle_list devices;
 	unsigned long temperature;
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
-	struct acpi_handle_list devices;
-};
-
-struct acpi_thermal_active {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-	struct acpi_handle_list devices;
-};
-
-struct acpi_thermal_trips {
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
-	struct acpi_thermal_passive passive;
-	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
 };
 
 struct acpi_thermal_flags {
@@ -166,10 +143,10 @@ struct acpi_thermal {
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
-	struct acpi_thermal_passive passive;
-	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
+	struct acpi_thermal_trip critical;
+	struct acpi_thermal_trip hot;
+	struct acpi_thermal_trip passive;
+	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
-- 
2.34.1

