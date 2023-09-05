Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A976792DE0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbjIESzJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjIESzF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 14:55:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D7CF4
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 11:54:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401187f8071so1119325e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940020; x=1694544820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6tn4Tgcsi1O0hqP3FN/fJ4KrpHQM0EtczTKadJgTtw=;
        b=p5Pm7Z7GtX7f2t7IG4RS/bbIikv2+cKC0ePo8uJt1sCuIrmGSi86NIq34dHd7s1AVt
         74etZCM3bQp7igU+wbL4YcKx++R94GZw4O3msJcc9DJoTYfeSofvrznfchAy6NI+O8RW
         IHMiiaeuavak/TknzGviS7L60EHvlsoutDxhT13rp5cIOXQMd2Zd1ILUUC1N5cGMTXd6
         L+yTOcKMJghfURp7PP2aNNTJ+DwFLcMpDkuIMc7aZjR6rAfJo3JDtv5iboe4ZrRm1cjQ
         0U3ZhkRdlSb3VoRw3Dao7LqgdQlj4CQmMJgcFx1v7p2O/ONpGsK3UT2eWRRtIhCMJJ8A
         EdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940020; x=1694544820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6tn4Tgcsi1O0hqP3FN/fJ4KrpHQM0EtczTKadJgTtw=;
        b=Fp82AqWsIpQ1StIDLMXdrYOIXZULwrz3H6uUSw1L4OFdpnbGtr3rQ72Ib9/ftbnXX2
         6GMv/sq+xQlz2DljgpddOYQT+6BK5qzf4I11xz6J3Zje2MXDjnwtbxhAQqsDZCwrqJeP
         JMQVngxVnoupj+09YdsY9KCGr0SqMZeLJtccH1bhaNS8SLNzxhg1UNYgGKBV47KB0YdU
         RQu93b1N3ATy7NWpIxs4gbjOng3mshwhzmORhNIQK+R+EvHDDXEDGlTouhlYpf2GtXHf
         f1TZZR0UL2FJMLCepSUIOFjYDyy7YtWo5sZrdqNJglxOcKNleC/GYCgfpFshPPzTAv44
         1UmQ==
X-Gm-Message-State: AOJu0Yy57+nw3rsSUgF2hRubQL3uRr0xUMyHhKqrtcWraVeHrWOlmz7d
        SfizlF6mam7a6Bon8ZZ2b7Z2eA==
X-Google-Smtp-Source: AGHT+IHaOumSDU3nr/8PNaqRqHS3aAWO3c0eVyPkb5h63GCpGBG6kfLxrczPHvapwSdIRLtHe1YhsQ==
X-Received: by 2002:a7b:ce90:0:b0:3fe:1b5e:82 with SMTP id q16-20020a7bce90000000b003fe1b5e0082mr547652wmj.20.1693940020693;
        Tue, 05 Sep 2023 11:53:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:40 -0700 (PDT)
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
Subject: [PATCH 12/21] hte: allow building modules with COMPILE_TEST enabled
Date:   Tue,  5 Sep 2023 20:53:00 +0200
Message-Id: <20230905185309.131295-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/hte/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index cf29e0218bae..083e67492bf2 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -16,7 +16,7 @@ if HTE
 
 config HTE_TEGRA194
 	tristate "NVIDIA Tegra194 HTE Support"
-	depends on ARCH_TEGRA_194_SOC
+	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
 	help
 	  Enable this option for integrated hardware timestamping engine also
 	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194
@@ -25,7 +25,7 @@ config HTE_TEGRA194
 
 config HTE_TEGRA194_TEST
         tristate "NVIDIA Tegra194 HTE Test"
-        depends on HTE_TEGRA194
+        depends on (HTE_TEGRA194 || COMPILE_TEST)
         help
 	  The NVIDIA Tegra194 GTE test driver demonstrates how to use HTE
 	  framework to timestamp GPIO and LIC IRQ lines.
-- 
2.39.2

