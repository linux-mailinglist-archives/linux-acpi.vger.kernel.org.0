Return-Path: <linux-acpi+bounces-138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4697AF0B4
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 10D712816EE
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89934188
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:30:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5110EF
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 14:59:54 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3FB116
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 07:59:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32167a4adaaso8732732f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695740391; x=1696345191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfLYtgRnxIhfGIuZ3AuQPnmd6mF7Zk5St0BXq4vGsIQ=;
        b=TLzw53xlfCA4B2yyekGcmN2Gow3tYsMQZDMag7APmsRKZLKRwPcuPoc7Xfm9pZ1N8A
         i8XZ6fbmgckGNwnl/tB/4I5ppkDl4KZpStL4Xiv9ChBKbHtPW+I1ipHDcBULsm4XLdE3
         aBu2drv72zmlMLQSx51xCIobXP2ySCWI7bFE7fqUuQCm41h1B3nTdBqVBLZk+3Wqr9TQ
         UQcxODnyP08mnU+n1WxUthfrUHGcjCBdV14jAzYfqloN4c3Y2vLkGRyoEGR/WlHc5Kh+
         TuNVFJ7KMX7DuFMdygi7a54VJGyS0URP4mSdyyDhwbZ4H+ipRDjnQ5o8xw/GHYglb4jt
         R8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740391; x=1696345191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfLYtgRnxIhfGIuZ3AuQPnmd6mF7Zk5St0BXq4vGsIQ=;
        b=GC2dLYSp1YGYOg/Vo0qk3Y0DyNaPzgdUQAIf9yHi1MlzaRR1FO8D828RIHLJoqbJs+
         qLnJQmbM9PDmTBjB6fDd6uASpOXDIAs4uq1QAdDzGrvESOOsUvki18TZ5YZoCnHTadjg
         0rZJlvAsNp67b3Xm6p/dKhBh5Qk55XEpvlaodpmSP+SOIXF5sayG8DX45+4COqaN4DGG
         kzmzF7BHEyT9Txmo5LtrqYN1+XkH2+AVNqaRcObIngyrRqDh9uYtDKdUWJkH+uKRIJFr
         mIekMkvJNHgg1TI8QsuK1wVXFbs9NTEtFbwtbZshLzIMFgqnzoJgX14xHQyYYvFbg1aO
         meZw==
X-Gm-Message-State: AOJu0YwvMp8M4VGSt/2KPZ0Q7K8B20dhkz53D156TjM57avbA62ke/Y1
	RefIL5n8qutmcn/bBdniEgx+D0aWeJ/jfpVoNtA=
X-Google-Smtp-Source: AGHT+IHPHclId6kylza566id26/po9Ed756snf6AMpJqfTNPum1ErtRmJjfjJVGvOnVFQwtK5zDvsw==
X-Received: by 2002:a5d:44ca:0:b0:31f:d52a:82af with SMTP id z10-20020a5d44ca000000b0031fd52a82afmr8678818wrr.49.1695740391015;
        Tue, 26 Sep 2023 07:59:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:686:c497:30b1:d2b9])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b0031f82743e25sm14871634wrt.67.2023.09.26.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:59:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH 0/4] platform/x86: int3472: don't use gpiod_toggle_active_low()
Date: Tue, 26 Sep 2023 16:59:39 +0200
Message-Id: <20230926145943.42814-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpiod_toggle_active_low() is a badly designed API that should have never
been used elsewhere then in the MMC code. And even there we should find
a better solution.

Replace the uses of it in the int3472 driver with the good old temporary
lookup table trick. This is not very pretty either but it's the lesser
evil.

Bartosz Golaszewski (4):
  platform/x86: int3472: provide a helper for getting GPIOs from lookups
  platform/x86: int3472: led: don't use gpiod_toggle_active_low()
  platform/x86: int3472: clk_and_regulator: use GPIO lookup tables
  gpio: acpi: remove acpi_get_and_request_gpiod()

 drivers/gpio/gpiolib-acpi.c                   | 28 ------------------
 .../x86/intel/int3472/clk_and_regulator.c     | 22 ++++++--------
 drivers/platform/x86/intel/int3472/common.c   | 29 +++++++++++++++++++
 drivers/platform/x86/intel/int3472/common.h   |  9 ++++++
 drivers/platform/x86/intel/int3472/led.c      | 12 +++-----
 include/linux/gpio/consumer.h                 |  8 -----
 6 files changed, 51 insertions(+), 57 deletions(-)

-- 
2.39.2


