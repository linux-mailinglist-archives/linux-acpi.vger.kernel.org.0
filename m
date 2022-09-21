Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A635E5692
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 01:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIUXE5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIUXEy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 19:04:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFFC59250;
        Wed, 21 Sep 2022 16:04:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g3so12549158wrq.13;
        Wed, 21 Sep 2022 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mYmlNW/kvE5Te9Epoe8eYigERXBZjlLl2bpj3cEE2Es=;
        b=SpuNUYLgGgvbSn5pRcc7+/m4OGVWOfPc7EQNdvwlyDfMiVavG8MDKhd8uP7xw1HnF4
         uCbRQurmwuxfEuShOkWEdGRQXknH+6lZ8itnpxpfpudjg2ijszNZ3K4UD8kl6ZjY4D0G
         R0Wn1LLV2msH/D94rVn92xmFoXtu7URSFc5tSoJJuBKWo/8/XglECwL88bnrviiI6Ee1
         Lf368RqQRaIB4pMr3KV3IgSc5S8ET3fYCLh+Ed/x4/olrZHYuhNmLcJ7Rs8HzLX1PZ29
         q5KL998BAjQRZN9HXuXKtpRS+lfpSlSgooUjlT79EF2pSYTN0mMbHXMEzV3VxprSYSFc
         FSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mYmlNW/kvE5Te9Epoe8eYigERXBZjlLl2bpj3cEE2Es=;
        b=v1voJI+NLdS9M7TLssNuJkhZAq+YSjbHC+MLOTyms/PER1EYc6iZPwWffWT6onoiA1
         yhEbPZkMYEeiE5J3URM8gKxsziPUi7gw7Ss+Z7n3ucg7JiyfSerrE7xTw7GsW6Cmfoig
         80+S4Bimd6jdac2E6VWFfThnohmQlynIvvbU7vENGNatnWakzNcrOE+L7uWZkrWFliqn
         R4hqGWE7UGXgUt9TSOP8hK6hphqFwmVkRq0EJt98IUb9LNmYnTUMzXp7ivc2UsaHBgjN
         xYpqlU6NrkyQcT+bsS7RzISigQqF+shh/G8OPggnmSprKrWKd6O/uG+ygWltrpJhWAA7
         QtPQ==
X-Gm-Message-State: ACrzQf1IRg8LHlDac3yw2qzNxjY+j4O7co+1pRtfveZHicqUrrSigvno
        JxdMg5/MuegrkfH6QLpPVMgLbDsGt6k=
X-Google-Smtp-Source: AMsMyM5J2t2iu7/Zw9vzJaL0kcXLnOhkNbyLAj4OO9WCDk4cVJqZJcibbHS/hCOxq7k+VO7A+Dgs0A==
X-Received: by 2002:a5d:5382:0:b0:22a:c36f:8e36 with SMTP id d2-20020a5d5382000000b0022ac36f8e36mr200173wrv.245.1663801492094;
        Wed, 21 Sep 2022 16:04:52 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm3519252wrs.58.2022.09.21.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:04:51 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v3 5/5] platform/x86: int3472: Add board data for Surface Go2 IR camera
Date:   Thu, 22 Sep 2022 00:04:39 +0100
Message-Id: <20220921230439.768185-6-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921230439.768185-1-djrscally@gmail.com>
References: <20220921230439.768185-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes since v2:

	- None

 .../x86/intel/int3472/tps68470_board_data.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
index e6cc8f40f5af..309eab9c0558 100644
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

