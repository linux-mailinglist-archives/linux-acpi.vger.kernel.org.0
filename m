Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94494B942C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiBPWxu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiBPWxk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DD2271E3;
        Wed, 16 Feb 2022 14:53:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so2675567wmq.3;
        Wed, 16 Feb 2022 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+uUHPaRW0+U9cBcYhuZP/dhS3pWpicIDdXLzyTxVks=;
        b=FV1Sl4rFc9LscmTaSkNE8UIwcEvRxnOJPtLVskZcTY1dZJCK12OASLPRNn5JGiNU+V
         4AXGah+Vhq/jOM/JtkM2WlgJLaPdq1XYaWUNYI97R96etxLEsvAZS1Bk0IdSOFK6lLwb
         FKp/HyVzyz+SW6pBZaGdjG62mdMIFpVZkkNZQrckkxnvzfrkZxhS2Tj8vKqVjSaXQ5JA
         QDV8a95XxaCLL83Z7cvpSHruqxj0gdVslejyfOrFtcC8D//yNUhiGXkZsMoCOVBTDb6F
         Ojj+gOJ0paz4XUmMDy00rxemK1qkK6ZxvGvswjfEeW05B55F28SunkLHw+tku9A+2H1Y
         Nl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+uUHPaRW0+U9cBcYhuZP/dhS3pWpicIDdXLzyTxVks=;
        b=oa1cRInIkFs24DnA5GqCogysU+4Q2KR/5ZK/uw87jvTJeTRwqF/QmDS20qNVz3GH3O
         Cam0GuK7sMh9gJMUOhgZu/u8Lbs+FprI1evHglFwMkEhyVj1qjdPSpuPhG/YIhOJCVPl
         2odJfalNcETNzmnfdpBIqcz1YMqy2b1N1GhbZDfD0/9LSbcDn8XZ1klXvgZMcmF6L9ot
         f0Ozt49KLXaSzqaRlSc6GGosVCJ5Bl3gg2PONIkdJuJ1O0l2sqEtcykLEu2je9LUJznS
         9oOauTfK9zUdnJPsrM6tWkdAvA3n2CbpXNNjkw2DhybTj/GVPOjxZ8RQzYRnGUZiYm15
         AqQA==
X-Gm-Message-State: AOAM532tvwttgnyuiCaWMLa4RX2dEIWgaf7BByo2QWy5BGZcuMr0Psj4
        x/hGSlV1/v9/zAaB5AXv5IHcy9/GhcAuJQ==
X-Google-Smtp-Source: ABdhPJzqPgn9j0leHfOsffu6ctdruNLH02FeQi1pUnvtOESsUKcCOpBL1Wucp+vo9sN2vFALUxJEXw==
X-Received: by 2002:a05:600c:4782:b0:37b:f836:78c7 with SMTP id k2-20020a05600c478200b0037bf83678c7mr3460007wmo.129.1645052006495;
        Wed, 16 Feb 2022 14:53:26 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:26 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 6/6] platform/x86: int3472: Add board data for Surface Go2 IR camera
Date:   Wed, 16 Feb 2022 22:53:04 +0000
Message-Id: <20220216225304.53911-7-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216225304.53911-1-djrscally@gmail.com>
References: <20220216225304.53911-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add the board data describing the regulators for the Microsoft
Surface Go line's IR camera.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 .../x86/intel/int3472/tps68470_board_data.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
index 442a8a2de224..49a3591c6d85 100644
--- a/drivers/platform/x86/intel/int3472/tps68470_board_data.c
+++ b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
@@ -30,6 +30,15 @@ static struct regulator_consumer_supply int347a_vcm_consumer_supplies[] = {
 static struct regulator_consumer_supply int347a_vsio_consumer_supplies[] = {
 	REGULATOR_SUPPLY("dovdd", "i2c-INT347A:00"),
 	REGULATOR_SUPPLY("vsio", "i2c-INT347A:00-VCM"),
+	REGULATOR_SUPPLY("vddd", "i2c-INT347E:00"),
+};
+
+static struct regulator_consumer_supply int347a_aux1_consumer_supplies[] = {
+	REGULATOR_SUPPLY("vdda", "i2c-INT347E:00"),
+};
+
+static struct regulator_consumer_supply int347a_aux2_consumer_supplies[] = {
+	REGULATOR_SUPPLY("vdddo", "i2c-INT347E:00"),
 };
 
 static const struct regulator_init_data surface_go_tps68470_core_reg_init_data = {
@@ -86,6 +95,28 @@ static const struct regulator_init_data surface_go_tps68470_vsio_reg_init_data =
 	.consumer_supplies = int347a_vsio_consumer_supplies,
 };
 
+static const struct regulator_init_data surface_go_tps68470_aux1_reg_init_data = {
+	.constraints = {
+		.min_uV = 2815200,
+		.max_uV = 2815200,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(int347a_aux1_consumer_supplies),
+	.consumer_supplies = int347a_aux1_consumer_supplies,
+};
+
+static const struct regulator_init_data surface_go_tps68470_aux2_reg_init_data = {
+	.constraints = {
+		.min_uV = 1800600,
+		.max_uV = 1800600,
+		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(int347a_aux2_consumer_supplies),
+	.consumer_supplies = int347a_aux2_consumer_supplies,
+};
+
 static const struct tps68470_regulator_platform_data surface_go_tps68470_pdata = {
 	.reg_init_data = {
 		[TPS68470_CORE] = &surface_go_tps68470_core_reg_init_data,
@@ -93,6 +124,8 @@ static const struct tps68470_regulator_platform_data surface_go_tps68470_pdata =
 		[TPS68470_VCM]  = &surface_go_tps68470_vcm_reg_init_data,
 		[TPS68470_VIO] = &surface_go_tps68470_vio_reg_init_data,
 		[TPS68470_VSIO] = &surface_go_tps68470_vsio_reg_init_data,
+		[TPS68470_AUX1] = &surface_go_tps68470_aux1_reg_init_data,
+		[TPS68470_AUX2] = &surface_go_tps68470_aux2_reg_init_data,
 	},
 };
 
-- 
2.25.1

