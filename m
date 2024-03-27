Return-Path: <linux-acpi+bounces-4489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987CD88D7D0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 08:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFFE1C24FC0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF82D611;
	Wed, 27 Mar 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlL7TfST"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A52E851
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525536; cv=none; b=kz4+BnL5OM9aOAC6+8hVRz3lqyYbjLohj6Jgjm/WZ6Af8GveKsST/2hKIgDxI4uZ/L4jvU5OTugehkaTqPTXXGtUrUqlWsgASfSZ754LXj23F1l7/GhFIvjOvsOT7GqVa0qilySif8U6ufDeOUMeypXi+VOvLo9OJKN+L8L9rUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525536; c=relaxed/simple;
	bh=x5aBOi8571kgH/70+hqSUTH/KgH7MbeR57HwVOqbl9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrC/FFqDBt2Jj2xn0pfx3WiRJhe1iwT8Bv1msyvpKSrAeOgmlMKkA2vd4xFGJVhDxCWPNnllf0IHl3ivYW0cxp+smEMWLCi2EoZ4NL9hdDEHC/fx49hfInoEB3wkDVoMammaK8PZsP+idM4CLteDuVdd9EB7bD/DHB3IQGkZbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JlL7TfST; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515a81928a1so5318899e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525532; x=1712130332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUVarvI29GYf8qbvusCvjKrNApOji+ZWbF/VfN3ERLQ=;
        b=JlL7TfSTI7IzJF7wlaMV36/JAZagPWDX0zxD7r6koBVDMZBiDo3Z+ATDX5UVdbM4s0
         pThU5kwgU4NwXlMQfFFutc8AfMZQyZx8MqAgpZ6sRofxgcISJUnOqa4HteB5DT5FYelR
         501hymjzrkxcREr3m2g++cmqj5FeQV6uzFWNkxPn+V8oqpDMtlxPjbCeLlyWQZQ5r3JY
         Zm8EQ3Md+W5Cih43ny//onibDHBsi1JE5FWTe8R4ktQpldf59XCLhoJqrh1RMXT2ojNI
         wqvy/iEG3nTLRMx7CdsyCi4NXsRnQMZNTezodw2O/LeRytY86AO8spRicxTzRQBdJS4o
         nDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525532; x=1712130332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUVarvI29GYf8qbvusCvjKrNApOji+ZWbF/VfN3ERLQ=;
        b=YwbHTcbQWGXzliuVdI26hERojt5r0btjFnyiQERbuV9Ku5YSGJD7j80vilCmdnmNGS
         u+gtcg/bhq3mO4Kq3z+huCXX3Ig4WpMRyjO3/bPMAhVLl/M5g2RkLA5/5wvc1rwxv70R
         7DUKKroXrawqv78xjOKBcFe3xBPlplMdpm4lc1mg3DB60GatGKDP+qgXmPuhTX5AADg0
         5aJ0LvMV+8P9bgyprVC7W/uIWncziuoxl+o4ha7KDtCMfhWIo/OGVZEHJ+l5vuYbtZ9a
         Z2/PIQBLfKLIV4IS0e5Mte0e0QSRIcbFJgSk1e5iVBtpELTn85ZwGlD6b7h4olsUrbO7
         pRLg==
X-Gm-Message-State: AOJu0YyCzB+Hi+QYUJbjpY+fmyIXFoYr4UULUGckAiu3ptvR2nH7lkD6
	m215vIonkMMDUpiLdthZQNpKk0vUQ7qb2QDrgmoESnV5gXRJl0Y5edh/a7qNKx8=
X-Google-Smtp-Source: AGHT+IH43p45oeCz29sanitb4HfB/d5qNm5GGwH5K1q6QtQ2IhsVB/nu/NZBEW4M+613n7w7MV8gog==
X-Received: by 2002:a05:6512:3d1:b0:515:a9d5:aab6 with SMTP id w17-20020a05651203d100b00515a9d5aab6mr1344695lfp.18.1711525532566;
        Wed, 27 Mar 2024 00:45:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:44:00 +0100
Subject: [PATCH 13/19] platform/x86/toshiba_acpi: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-13-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=716;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=x5aBOi8571kgH/70+hqSUTH/KgH7MbeR57HwVOqbl9w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85WYaPnCni2SJTIfYMu6nl8u8HCpyEBx/zm+
 akXWB+YnymJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOVgAKCRDBN2bmhouD
 1zwaEACAjYbKdJXrMSUbxc4nKtGoFPWrLCKVqSibV0vxi34qgJolGqwGNMlDf1EbR7zNuWkRWf1
 SAkSo/ZjSy9ljMZTB+PVf/rBCZhEjLGaVJcUcu4lvaHpjYqA3flInybJXH/dnis6s7GQJEjwCbI
 Urg4xT3YL+pEwOQEaxZ+RR784CtgfPRcRZJ/y2hZHbLqGolVcrygiCisFvxmNBfyX2IgW8qzVtw
 ZC9sexJanCjRdDdeSqqoW8HfiFLv3kL6o5lvq01gJQ+Ch0QEcyMkKF69nwS+99sLA+gczGBSIdO
 HA/LUt7UtZGA5BqNtXGRxvIHU3JcNctMDbgUNU51zZTuMLPOR5zAy+pZPbScboBEobH8u3buYyI
 0MazJJzSYkzF1E9pEayUzam31VNJzF9LDQdXf71xL7c5hQvhEOgLrdYtd+NHHcT8QJ6KyGkXlJq
 S8ohVQ33OfFfZmCqNmFeUuE6sgFOi3yXk3mCrwgakKm0j9xool6qTEqAYFK35jBiH1RZjMS2/3b
 20vZcrPTTv/1steGsyfHnqoRnmquIwWJU7cpmZtp7sfrP9VtakfLAk/Skb4bey9hgdxJa0dQ2Nd
 /jAUhNyL/u5mTZ8NAZuDN7KrPv8hyTPaqwNDWOE/y2HXvWNm321FRUqeoMm/Zu3myuyaUrVfESB
 n7esZW5XGAls0CA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/toshiba_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 291f14ef6702..6f9bd675f044 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3581,7 +3581,6 @@ static SIMPLE_DEV_PM_OPS(toshiba_acpi_pm,
 
 static struct acpi_driver toshiba_acpi_driver = {
 	.name	= "Toshiba ACPI driver",
-	.owner	= THIS_MODULE,
 	.ids	= toshiba_device_ids,
 	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops	= {

-- 
2.34.1


