Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22A68A05C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjBCReb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjBCReA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:34:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6EA2A76
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:33:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so1913558wms.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5nHHSh5TfhObVB27BdAlj0+jr/HbFgiMaA9A4Ts7wk=;
        b=woZ+KOPPRvuO4deKvfXWa7zhtaLVQWO5ATsvUf7wxj9cB3oCEOS6Y6K6ah2x9jepdA
         qpLNa35s8wIuA1S9XvXx04R1O1IzpRNF+u+r2keduAfcCF6HX+1+IlpmjSgj6ewCzA+B
         4XxyYtdpZx3geySdx1BzE53jCY7KAVsHL9Hb66OCeDjnhHxutTZz/feVkmWZp8DSM44E
         6pKC0axYJJcwE5FLkAgEl1+KK2DskUOYq1UrzvzymvwXRrlsHCAm63KtiW0pfBSck/Dq
         sUDFYUBxnQEx9G05J7csNae1o9MS+3Covr3I6OYA6mEFxj5j3+BTwf3A3TYycZksUeVm
         1vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5nHHSh5TfhObVB27BdAlj0+jr/HbFgiMaA9A4Ts7wk=;
        b=YfNOHW+UYaAeuRSgesku5zJ6L4RH3AUcVfFk/ewnveo3EPURCIK4GpCEUtt62kV/Ff
         LCxQq8YqOK6fBzRNreN3UvK2uiPKZbox3lUA2KYYtD+t77q4Im6nNCFZwYuZcwykyA12
         y21npGUiyTaBy9d7IIJgRpmZURgkjWuxz8JWSjiGY4DlfyoqCSaPtSVQ+vFB3NhkdY4/
         QYYN57BB6YcqlLgBMkiqwgGO95Jp2FiHpQX+oWtKHEtDzCfWwId4BTHw6JqTj+mZsSTd
         S5w9Bc6hT0731hDByPNINctACE/hkY/yMH7mpL8s6aRx3OEetXRAdyZL2hNRkrf7kWZR
         /8DA==
X-Gm-Message-State: AO0yUKV9p3Z5euS+s2yazjOTVzsh+QfKbES2Q+Pn595JygvgEgY2B0jC
        zfgFEEMResNAkd30xSoBlwcGdg==
X-Google-Smtp-Source: AK7set+k0me/dNpH027FFE99Aq3Zx/Td1bgtZAPMpVvitBqCbqoOVBVBewTdZG7+54W77XptFi1i7A==
X-Received: by 2002:a1c:f603:0:b0:3df:dea7:8ec with SMTP id w3-20020a1cf603000000b003dfdea708ecmr6280583wmc.20.1675445636284;
        Fri, 03 Feb 2023 09:33:56 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 08/11] thermal/acpi: Remove active and enabled flags
Date:   Fri,  3 Feb 2023 18:33:28 +0100
Message-Id: <20230203173331.3322089-9-daniel.lezcano@linaro.org>
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

The 'active' field in the struct acpi_thermal_state is never used.

The 'enabled' field of the structure acpi_thermal_state_flags is
assigned but never used.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c7c2b3d63e90..316a16ac1a09 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -117,14 +117,12 @@ struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
 	u8 passive:1;
-	u8 active:1;
 	u8 reserved:4;
 	int active_index;
 };
 
 struct acpi_thermal_state_flags {
 	u8 valid:1;
-	u8 enabled:1;
 	u8 reserved:6;
 };
 
@@ -1138,17 +1136,14 @@ static int acpi_thermal_resume(struct device *dev)
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!tz->trips[i].flags.valid)
 			break;
-		tz->trips[i].flags.enabled = 1;
+
 		for (j = 0; j < tz->trips[i].devices.count; j++) {
 			result = acpi_bus_update_power(
 					tz->trips[i].devices.handles[j],
 					&power_state);
-			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->trips[i].flags.enabled = 0;
+			if (result || (power_state != ACPI_STATE_D0))
 				break;
-			}
 		}
-		tz->state.active |= tz->trips[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

