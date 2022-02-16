Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D0C4B9431
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiBPWxl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiBPWxj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BD2271E3;
        Wed, 16 Feb 2022 14:53:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso4802341wmj.2;
        Wed, 16 Feb 2022 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8LwkZa9RC/yBPhmXnAl2Q6p50g9U5AICTQRMA//U54=;
        b=o/LMG9kdIvpGncLOvlUGcSrF6wkSx3mN2HeKY0GOxa7aSWUsyHsZPDVPffjT23+G5B
         Ll18JA7wd95BmV1FlTLcVF/kZXJ6gxwXbQUiWlLcZvbwLdTFAPbpSj+winHfGF15jC3w
         /zc3f+ER4LaJ7YntU8G8XAzAZmyo+x1fPDuH7GRJ45h5fd5zI6kpFEMi5HYMPqA1kj20
         FOESqvLx89qzlUhf75erUMwWnlEpTQE0rVPNAEDZg/Jim5RcFJ88HPjfiUyRYtLiEKD8
         PQuHEKU/BHbUX3PgnRW18hRTUVXF3r6NeISBBSLnDTD7Pg9CSGoPThKdsdveheAmV6cf
         /p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8LwkZa9RC/yBPhmXnAl2Q6p50g9U5AICTQRMA//U54=;
        b=7h2VlbGmf+WESwGR1dNMRpWZLlkGG/dIBf356qf27lBXbXzMRXOoCflwAzZ1VEheei
         KS/QcnKuG7tpeWNA5y8+Dtz250epGHUJAG3xFvOsTyrqUN+Bzy8Z4a8miPiDuulnO/Nj
         G9jVOuICLX91mwkeIe5F4AM5CdfHOlTNsC7Pbe4WB9N2iLPBfRGw6AFmL7F/uSW4RTa5
         SbrosJ70XNZBYF/wbisTvkskTwMhO2nDj7rKBQKMqawax0IRgoWuFvw/Txhtm81I/0vi
         11R/RYzrpvZH+v584sWhR6dMb0dyQ8VhmsmYQtvHTv5YTfLQPkt1LBRxdc6eYeEGPARf
         Z/dg==
X-Gm-Message-State: AOAM533u+iyVXUptsPa6V1OZFzyPMwrw0XxRsyvyXESH8MR7yQ+kY1hL
        /0LxYl286AYcoYDPuWzz1Hf9/YhEhYoC2Q==
X-Google-Smtp-Source: ABdhPJxBhyVN4jUcqHq3VuXLR3wU5ZvfW0i5DiMPtQFONZIKWpNxl/duNVnXoUjXmuQ3tef4zae6Cg==
X-Received: by 2002:a05:600c:2e0c:b0:37c:3615:c52 with SMTP id o12-20020a05600c2e0c00b0037c36150c52mr123856wmf.43.1645052004133;
        Wed, 16 Feb 2022 14:53:24 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:23 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 4/6] platform/x86: int3472: Add terminator to gpiod_lookup_table
Date:   Wed, 16 Feb 2022 22:53:02 +0000
Message-Id: <20220216225304.53911-5-djrscally@gmail.com>
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

Without the terminator, if a con_id is passed to gpio_find() that
does not exist in the lookup table the function will not stop looping
correctly, and eventually cause an oops.

Fixes: 1596ef1251b5 ("platform/x86: int3472: Pass tps68470_regulator_platform_data to the tps68470-regulator MFD-cell")
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/platform/x86/intel/int3472/tps68470_board_data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
index f93d437fd192..525f09a3b5ff 100644
--- a/drivers/platform/x86/intel/int3472/tps68470_board_data.c
+++ b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
@@ -100,7 +100,8 @@ static struct gpiod_lookup_table surface_go_tps68470_gpios = {
 	.dev_id = "i2c-INT347A:00",
 	.table = {
 		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW)
+		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW),
+		{ }
 	}
 };
 
-- 
2.25.1

