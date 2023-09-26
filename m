Return-Path: <linux-acpi+bounces-140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84297AF0B6
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 88EF9280E61
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4634193
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:30:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB310EF
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 14:59:56 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7D3126
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 07:59:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3214d4ecd39so7686171f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695740393; x=1696345193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOR2X/AoUnTx42nPhZDbyArkpmdX3bsMYj2lZRsFUms=;
        b=zOZwMSAXHjeLQGWcL2Uhltnz2hlI7XNV9ewI0AYTJIyufx2fw5+odUKZX3SF3OdVo2
         UlQEE0zam+rMuUY+dmj78myXlrMmWSkfn37NQb+yQn2yRzuAYt1mHQeX69fRpj3LWgoq
         DnRkDh1CFa3VtNEjAJi12cVCeQPSzMIuLFEBnrWlbPdaoXkN0akjsISOdCiNgMPoHRLF
         r7kNO0MescDjiY5P31lLEnDKROy/OtDt6ZI8ox9V10HkOMJPo00rSnEjLYDdN9ij1f9G
         l36r3oZGDy/tqplSiP6d6VejCSKVhHopDn8QC2mOJlzpGtJlbgtq+H3NJEoLoy5x/ooi
         jU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740393; x=1696345193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOR2X/AoUnTx42nPhZDbyArkpmdX3bsMYj2lZRsFUms=;
        b=mCmlDwNO24aQ/NK/rfE376BlOo8i90uhobQuC/XZ6PtPi6xTQXIK5BJMNMPQATiZiM
         vipJ9ahgQIO4gUk0WB7SmDD6a4lQ5XrcZI0D3TevLlknbplaV0HOqt3K4jrcKn3nj+Va
         QXxgXN2nfMOtefl5YSQRx+ZaxkrMtOoUEjZNG1r5jIHAqdTdckH1bQQr70DDZC+olLHE
         Dy0zsygohMXO1FUrlRLg6SuJj97zs6mPMLa7DKqE0j6Zd2cYF9qjh5A/Zy+mbKfZBqq1
         uM7t8dYW02xXmgv33Sz62Gvxm0c4kqlhQkLBrwNex2q9P4YYfW2rUSeFXZMnaM1ceTs7
         im3Q==
X-Gm-Message-State: AOJu0Yzxs36NVjV3sWedzEPs5B0eNXRQDkck0HRJGQ6ux1EyHzhLn/Qo
	TdqioMNE7WmDucVq9r8NnCRscw==
X-Google-Smtp-Source: AGHT+IFvuYKk7b6vwmISUaGLDlo/gV93nTCl+wOrw03xkUp5qRrel4E8uHLcxNK3RPdoDpL8HMIuqw==
X-Received: by 2002:adf:f044:0:b0:319:7134:a3cf with SMTP id t4-20020adff044000000b003197134a3cfmr9483453wro.31.1695740393042;
        Tue, 26 Sep 2023 07:59:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:686:c497:30b1:d2b9])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b0031f82743e25sm14871634wrt.67.2023.09.26.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:59:52 -0700 (PDT)
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
Subject: [RFT PATCH 2/4] platform/x86: int3472: led: don't use gpiod_toggle_active_low()
Date: Tue, 26 Sep 2023 16:59:41 +0200
Message-Id: <20230926145943.42814-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926145943.42814-1-brgl@bgdev.pl>
References: <20230926145943.42814-1-brgl@bgdev.pl>
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

Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), use
temporary lookup tables with appropriate lookup flags.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/platform/x86/intel/int3472/led.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
index bca1ce7d0d0c..62e0cd5207a7 100644
--- a/drivers/platform/x86/intel/int3472/led.c
+++ b/drivers/platform/x86/intel/int3472/led.c
@@ -25,18 +25,14 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
 	if (int3472->pled.classdev.dev)
 		return -EBUSY;
 
-	int3472->pled.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,privacy-led");
+	int3472->pled.gpio = skl_int3472_gpiod_get_from_temp_lookup(
+				int3472->dev, path, agpio->pin_table[0],
+				"int3472,privacy-led", polarity,
+				GPIOD_OUT_LOW);
 	if (IS_ERR(int3472->pled.gpio))
 		return dev_err_probe(int3472->dev, PTR_ERR(int3472->pled.gpio),
 				     "getting privacy LED GPIO\n");
 
-	if (polarity == GPIO_ACTIVE_LOW)
-		gpiod_toggle_active_low(int3472->pled.gpio);
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->pled.gpio, 0);
-
 	/* Generate the name, replacing the ':' in the ACPI devname with '_' */
 	snprintf(int3472->pled.name, sizeof(int3472->pled.name),
 		 "%s::privacy_led", acpi_dev_name(int3472->sensor));
-- 
2.39.2


