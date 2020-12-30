Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC612E7A6B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgL3Pi5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 10:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgL3Pi5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 10:38:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2889C06179B
        for <linux-acpi@vger.kernel.org>; Wed, 30 Dec 2020 07:38:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r4so5005335wmh.5
        for <linux-acpi@vger.kernel.org>; Wed, 30 Dec 2020 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5qU0u0BbjyAf7ASokX3PDKEGwUdQpw6OEstGnrNo58=;
        b=CN437dPVzQo0tvO2u2a4Jee8cmUZkWsILIxPzYq/EoNcgHYmX8y3d7PWXku/qVwxRy
         Zbih/MHCKJ0s5zdvYyotn+sgkUAbn783RjApS1XoiEBHja3W0TkLhDNloVKFYYkBmZPu
         bVcCOIdNJMbJDfBeXs3wHJX3reDJ/A3syjLGnD4ylznyFGeKC+MoVy8YK4APmzXAjBuS
         0bhWQJ3ohVhocsH0n4miWboYQILyBW2+Q/1yPdUqZRoLnu7Oxv4w/V8HvP9eJUXrlEoS
         SZml0TkX7+8HKCCONeQ51dWaKMKvDIxnFUWfQV7WtXsmlJz8yBd7fMn2d2wxfoRVGLPr
         821g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5qU0u0BbjyAf7ASokX3PDKEGwUdQpw6OEstGnrNo58=;
        b=BEZtPWqVH0BkyRcrICBxZbvroHpV0vsmoSuTc98Qvl8O91gksBIGNgXWQPjEKAYIUn
         PSpfHdZwOn2YCUdfdZFuy6jqxfIO4JcjUzYKFJY4NRwW3rFUQAPeJva7dRWErOshssP/
         n+JySuVgIlJuZw0xSGCeC0wj7/XR3vjTrZBDiYu8owXLnHnpXV37DFodMQ2NfRvqC9r/
         HOgIQLoqOLBtQsTDjXfiFakx1Asq2tONpw2fndAvIlXKnFvLDh+o5/+IfrA0RFvDfvqE
         uubNhVmhKUGm/MD4QNMa3iNzVjoz3RNhm3Mv9Ao8O2RlordeORJW7i/xk+Mk/kI0HCSA
         0Ydw==
X-Gm-Message-State: AOAM533gZ8XCZx+/F/QUE2ThIi5uzZcuPmGNI0TyiZJP0X/+SMzwkLTM
        a6e4+0JiaKuRcLYyZ0Br2oLOgw==
X-Google-Smtp-Source: ABdhPJzATfgVUVRnd0DMVpZVYIHm8h4tAgYslW1iLToSCwh2SN+9DdP1CGeN0glGGZOf/+K+y4Ot4w==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr8094776wmm.103.1609342694387;
        Wed, 30 Dec 2020 07:38:14 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.gmail.com with ESMTPSA id g191sm8634484wmg.39.2020.12.30.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 07:38:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod unresolved symbols
Date:   Wed, 30 Dec 2020 16:37:44 +0100
Message-Id: <20201230153744.15612-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
References: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

32 bits architectures do not support u64 division, so the macro
DIV_ROUND_CLOSEST is not adequate as the compiler will replace the
call to an unexisting function for the platform, leading to an
unresolved symbols.

Fix this by using the compatible macros:

DIV64_U64_ROUND_CLOSEST and DIV_ROUND_CLOSEST_ULL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 5b6857e9b064..0abcc439d728 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -99,8 +99,8 @@ static void __dtpm_rebalance_weight(struct dtpm *dtpm)
 		pr_debug("Setting weight '%d' for '%s'\n",
 			 child->weight, child->zone.name);
 
-		child->weight = DIV_ROUND_CLOSEST(child->power_max * 1024,
-						  dtpm->power_max);
+		child->weight = DIV64_U64_ROUND_CLOSEST(
+			child->power_max * 1024, dtpm->power_max);
 
 		__dtpm_rebalance_weight(child);
 	}
@@ -272,7 +272,7 @@ static int __set_power_limit_uw(struct dtpm *dtpm, int cid, u64 power_limit)
 			} else if (power_limit == dtpm->power_min) {
 				power = child->power_min;
 			} else {
-				power = DIV_ROUND_CLOSEST(
+				power = DIV_ROUND_CLOSEST_ULL(
 					power_limit * child->weight, 1024);
 			}
 
-- 
2.17.1

