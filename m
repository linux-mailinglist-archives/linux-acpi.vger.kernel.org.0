Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864EE4E88C6
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Mar 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiC0QPn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Mar 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiC0QPi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Mar 2022 12:15:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FF27FF5;
        Sun, 27 Mar 2022 09:13:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m30so17071446wrb.1;
        Sun, 27 Mar 2022 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On9c+G9wOwaq0PXoo//3sjDSnBW1cAGDzfd4Bq86hek=;
        b=Oq1fS/ddvMVMh5iisU3oCJE3wkCPlUAh9Rd3zskheaOOfLmrZS1oawdQPjNesF8S8k
         bFwD1HpiEq6zOppBX+c8m3J6ka813oxk5C0XVicBhD9jZV/awQnP9lA6K21Wh9Wah5Rq
         1G6TTuALlzSFv4y3BKVMCSbSCId9jhCwMtj0rLQX+gLFwTtLXPcu7Cv2BFUegTd0GInS
         +ElwKRFUEWo5rnqIepvAc0VmPgm02ztt9iZZRpQUDEpT5wb2Yn9t2Adrjd7kk4jSSd4a
         4ADsGIuIbqy/hMlZMmAcLNwpV+zYkgux9T0ZzrpfVXq3QcYnTnq1ppxgQSPdj5BkTkCj
         E1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On9c+G9wOwaq0PXoo//3sjDSnBW1cAGDzfd4Bq86hek=;
        b=Bcljxo3dxw7F7l6PV5E60xxKYy5mKfaFAM5WcSW/ZODijyUx3I8nNVvuBxq9N6Jjjx
         CHeHPk9SjfdVFEW6zA8aLy/IpfmBWD+CfKKd1/BAZGomIKZMUoe6V38TZREvqC4WBsFs
         EHYjaxmODZCuclp1u7j13UThpBStpZ1n0Ow9NYSZP9iATni5tW0iupI+UowHjvjedV6C
         r4TRwh26LZ75RQtXKLcxzTud8UfqHEs/VmxZXeTAxPGblTUU421cDa6Cnbx/vIyoD2F5
         yUMvN0Qe1tmg7mLONwJGBWXyPJWYOJOLr5MwX+VYGkb9YrcWJ9DW+jluEBorhOKmgi5n
         ZUww==
X-Gm-Message-State: AOAM531GVTgBAkLfv+a1wkLEnwmVZB3neHdkATGmsjJJe/TWUQFAVV3Y
        ldfetchoHvE+RHByri1syMOEOVcfBhE=
X-Google-Smtp-Source: ABdhPJx86+5yxFGWi0F7jkpq8gRKFmb/EqMC7WdZoXYKMhyxPFV16sWURSfIqm84P4103aRrnn4dSQ==
X-Received: by 2002:a5d:5704:0:b0:203:f9bb:b969 with SMTP id a4-20020a5d5704000000b00203f9bbb969mr17509860wrv.459.1648397638085;
        Sun, 27 Mar 2022 09:13:58 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm13764924wme.39.2022.03.27.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:13:57 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v2 5/5] platform/x86: int3472: Add board data for Surface Go2 IR camera
Date:   Sun, 27 Mar 2022 17:13:44 +0100
Message-Id: <20220327161344.50477-6-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327161344.50477-1-djrscally@gmail.com>
References: <20220327161344.50477-1-djrscally@gmail.com>
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- None

 .../x86/intel/int3472/tps68470_board_data.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
index dfb9431e4b1b..3573c46e7993 100644
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
@@ -76,12 +85,36 @@ static const struct regulator_init_data surface_go_tps68470_vsio_reg_init_data =
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
 		[TPS68470_ANA]  = &surface_go_tps68470_ana_reg_init_data,
 		[TPS68470_VCM]  = &surface_go_tps68470_vcm_reg_init_data,
 		[TPS68470_VSIO] = &surface_go_tps68470_vsio_reg_init_data,
+		[TPS68470_AUX1] = &surface_go_tps68470_aux1_reg_init_data,
+		[TPS68470_AUX2] = &surface_go_tps68470_aux2_reg_init_data,
 	},
 };
 
-- 
2.25.1

