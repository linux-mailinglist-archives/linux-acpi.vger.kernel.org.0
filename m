Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B621792E49
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjIETHK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjIETHJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:07:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A99CE2
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:06:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so1697752a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940727; x=1694545527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPYbcmhlviFwWzuYOu9Z0ne7hiPspJP6iTCWdpKZ06M=;
        b=W05ZQP+7woy9fEAa+8/j3O7XU6WqIFB2gVzVh/TtggNF5S4CUIavUDZonVh0jbLBdR
         +OpQKYWTn19jdc1UDWc17ju8dyZKBDEAnXGmpCHk9FYJPTq7FL7ccVIkOzwR776Vf2yH
         cJ3eEIxSbt27Enpe21sICFSNJ8xRJtLQLWyac8fGvQBrIGYiBpaZtqqwQLwkjGt9MJHv
         1Ryo47EAi1hbtuNFFk+6e64O0GkfR+0YVFDfuwDjp1OjSBvjXyJUdq+CUTVoYZX445bC
         UNHoCWu9iPjCugdNXQwnshYis8Gl9bFqME52VW4S8YusA6aOg1x+/yoOTU0Cb7+v/s6p
         8oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940727; x=1694545527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPYbcmhlviFwWzuYOu9Z0ne7hiPspJP6iTCWdpKZ06M=;
        b=HnFrvaQmn9uC/s/2VHHfhX/8rddtDOenV1MYNv2v/MuO+QgbE4w2/HW6Ek08N/KjsS
         M/t5XzLw0B8p9O0chi0xVVvonhBh1VmBDI95anieuScrcT2OwoYdn/peHs+21UnRT7xT
         yuDXYHzpAvCfpCxzG0UN9V2HuuLrcA5VvoH+QogKU8vQ3OvnmbslYxI8DBMRt7lD/Vrf
         SzLouRtCbov0rGvQXLOK5aRZAY691QVETBaXXkie2OS577Z5KXOxjpPb1W9HMA/4mjIy
         gJkbfEYNQGYHrpbuFoawZItGBBcrmqVmD4ApUKjiKA8/tbclXPuIuOGQU/Rvr6pA7BVV
         0s4g==
X-Gm-Message-State: AOJu0YxUboDEgLQgpAkvf5CWVf7RZ8X9rOvTnHQkLRbvi2wuNS2vBmyk
        pX150RFZmcTjjSMqd5XryfSHLsDSmGtxjKjDN90=
X-Google-Smtp-Source: AGHT+IH7bFhmwhJkbEP09mNLLK4toqHl75c1c56y8lKZfC2ULSFpMzvdc2De5dyozg7UIqDbZnvopw==
X-Received: by 2002:a7b:cb96:0:b0:3fe:d6bf:f314 with SMTP id m22-20020a7bcb96000000b003fed6bff314mr414148wmi.39.1693940021910;
        Tue, 05 Sep 2023 11:53:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 13/21] hte: tegra194: improve the GPIO-related comment
Date:   Tue,  5 Sep 2023 20:53:01 +0200
Message-Id: <20230905185309.131295-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Using any of the GPIO interfaces using the global numberspace is
deprecated. Make it clear in the comment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/hte/hte-tegra194.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 6fe6897047ac..9fd3c00ff695 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -407,12 +407,15 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
 		return -EINVAL;
 
 	/*
+	 * GPIO consumers can access GPIOs in two ways:
 	 *
-	 * There are two paths GPIO consumers can take as follows:
-	 * 1) The consumer (gpiolib-cdev for example) which uses GPIO global
-	 * number which gets assigned run time.
-	 * 2) The consumer passing GPIO from the DT which is assigned
-	 * statically for example by using TEGRA194_AON_GPIO gpio DT binding.
+	 * 1) Using the global GPIO numberspace.
+	 *
+	 * This is the old, now DEPRECATED method and should not be used in
+	 * new code. TODO: Check if tegra is even concerned by this.
+	 *
+	 * 2) Using GPIO descriptors that can be assigned to consumer devices
+	 * using device-tree, ACPI or lookup tables.
 	 *
 	 * The code below addresses both the consumer use cases and maps into
 	 * HTE/GTE namespace.
-- 
2.39.2

