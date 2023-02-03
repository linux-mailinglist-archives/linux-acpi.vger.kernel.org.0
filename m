Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8868A0A0
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjBCRoo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBCRom (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:44:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF61A642B
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:44:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so5318352wrv.10
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0WMeqO1vZNLVskDd96ga8DPKCx7MU4pvjHfg5TCNV4=;
        b=eDdQGU+o+vQBj916o88d/DuKFcRUq1sVlFHxSPl+uAEDmb/AbcpCoUSEbz/4e5P9jg
         2X9+igApY6B6gHQ4RsKf6WQPYg730TJw9eCrZ5o+ZaJrTLiONzrGZz8U4T4JKFLe0FOY
         lWEHvR03BaPUo9aa8fRHBLYvgpu9MSPIiWbxakQXKtDR+id+CrCTf1zRdgEi60iAwtP8
         J2p3oEsCfWg/56/y/5/w/2cg0N9KNDEgNuUgdFpneLcqkM/i1LMBDFcc0l/UMEh4itAD
         gtsmBZ/InnJundV9aXm5lZAyKjWMWMESV58rhonGg1HvnM1noBVCyWuIOsgGih9NHBNk
         478A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0WMeqO1vZNLVskDd96ga8DPKCx7MU4pvjHfg5TCNV4=;
        b=iDrLnfGqlV8ujDP3Gi+MOaXpLcE5l4QT+W+Wqjd86+q+fW9iEpKDGZr35Q8UMJRidh
         1TFCqTd5tAExMIYxNcbQZF89wv7UZMIZx8oz6KG4B5bvVc9Xu6kMruXCvPqClbjqKkae
         5RI3plaUeae/LfnxLrt5Jnm+Ua08V1K19mE7c6YBAPfkwyQ778ofXiPAYhZcEr1c4fMc
         pFPyN1lptfXKx4Y7EQp8pkLFu2/S5BWuJJpmFRRpHAomA/ottiDRo1yutIY7A2B3wMRH
         AoHgKjaFYFOb0i+wEOAV9oJ/AzrYy0OYMU749RDHMkG1Qf9haiDWzYVsH2pN7OhBYVMP
         038w==
X-Gm-Message-State: AO0yUKVCFsGj+K4Gn8ZMA+1Mcwxm1T6hArHy5pPVLiUZUVUFuIpjeSby
        /TfD0MSK14ZIL10YImGNPOH/Hg==
X-Google-Smtp-Source: AK7set+0jHFe+Z/yjIND1hVAz99WlzWujvqJ4GcisGqVhzdiy1r15yfrZS6s1smJgRB9NsRvDqEuJg==
X-Received: by 2002:adf:e9c3:0:b0:2bb:eb3d:8d20 with SMTP id l3-20020adfe9c3000000b002bbeb3d8d20mr8795450wrn.43.1675446280703;
        Fri, 03 Feb 2023 09:44:40 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:40 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/11] thermal/acpi: Simplifify the condition check
Date:   Fri,  3 Feb 2023 18:44:25 +0100
Message-Id: <20230203174429.3375691-8-daniel.lezcano@linaro.org>
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

The condition:

if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE))

and on the other side: ACPI_TRIPS_INIT (... | ACPI_TRIPS_ACTIVE)

So if the first predicate is true, the second is also true.

The 'valid' flag for the trip point is also checked before, so it is
pointless to redo the same check again and again as it is unchanged.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index a3a8130c955f..c7c2b3d63e90 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -321,6 +321,9 @@ static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
 	int valid = 0;
 
 	valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	if (!valid)
+		return 0;
+
 	if (psv == -1) {
 		status = AE_SUPPORT;
 	} else if (psv > 0) {
@@ -398,13 +401,16 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
+
 		valid = tz->trips[i].flags.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->trips[i].flags.valid)) {
+		if (!tz->trips[i].flags.valid)
+			continue;
+		
+		if (flag & ACPI_TRIPS_ACTIVE)  {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
@@ -436,7 +442,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[i].flags.valid ) {
+		if (flag & ACPI_TRIPS_DEVICES) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
@@ -455,6 +461,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
+
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
 			if (valid != tz->trips[i].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
@@ -495,8 +502,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
-		(flag == ACPI_TRIPS_INIT)) {
+	if (flag & ACPI_TRIPS_PASSIVE) {
 		acpi_thermal_trips_update_passive(tz, flag);
 	}
 
-- 
2.34.1

