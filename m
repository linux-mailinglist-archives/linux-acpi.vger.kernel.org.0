Return-Path: <linux-acpi+bounces-18333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B36C1A727
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8087E5066DE
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950733557F7;
	Wed, 29 Oct 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iLMFvC+e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A788354AD8
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740944; cv=none; b=M2mRQQBKl9i69lXYUgvTtKV85POkSpdy1OzYmg3UyHY9gUFgNFCAV21lWKzggpIffx7gVkswveBu8utzavUIh4dsu/HKeTqAnKynwkEhqUlWoKpGA+PsBSi77mYDDkyFJ3l/p3URyK8E64wduW4Ts54Jac8aIibG736ofPhVqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740944; c=relaxed/simple;
	bh=X6AXe1jSRBq4KEJrHmdBq6xZuD9cdi0d/HUSMjgRwhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srH04/pXBOB6Qy8GFX8hD8yHR6YqnXCeoR679VsJrHunfBorN3/etBSadj+XDoSoDLReqzpGz+W/ahXib21LiWALjsNS608AlEoCshiAInHNOKSKTCjW3GuPxbwXblconvok0ESEE/5Os9/Z1n5ZhH/0FTHZBKF0pNJhyEuH2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iLMFvC+e; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso60717925e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740940; x=1762345740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2edun2hn2o8/WMgJNeA0p3kxXswqKrNqwNnjThzAN6Y=;
        b=iLMFvC+elPkSAJK7/CDVNUI9srbHdViP/k/4U2EhPUzPZhgK4N27lnsPl1GR7nZb3W
         s2hK9LewT3Q152667XC9bx6m+6z+mu3PjLz9O67oZr0A7zZWOAMGdopWt80z1flbWvKT
         eegS4S2ll0zRq2qfRsgCny/ZSmgLpG9WMl2f5llPSp2R8H02GPIYR36wunaqVaCBTKjq
         GoSuBlr9Zgtfuuzfx4T0/2zEONW2trPI07bxU/FZZLXesapPzOXsfWjWQ7fV6wuW9BOL
         jzeW0JarxS3glXttu1IvM8ofRC56jED93witvhfp1rUC4e4U4zrexVZuWXULjimar2lH
         SUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740940; x=1762345740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2edun2hn2o8/WMgJNeA0p3kxXswqKrNqwNnjThzAN6Y=;
        b=hsYiakL2GfvMAPkUHNaVWDcAuzMK6i2HBWQB6K8Ha2vtZrJEbj+2Jx+9kjd8ykSbsF
         vHFXsUkwlsp9UaSOIush7oXG7om63a63ecHQrhfoawYQ6ZDadcZVjpIMCjzxzThiN3rC
         XvU1Sy0+VkpKBcG9SXz7H9WEM5rSTLDoaIuO/oWR1BewCI0j43mnstGz2ykzwt7LHaT7
         7OZh1T9cQG4f6pBlWztIZ8a4dHwKlgK8XkDpQMmdiD/1PDPDDigYi39P+DNgBpSfOHl2
         F6hCHr3T9FpNXMLc6aS888Oh+LywjtzXsKs7BuyLMq5gunVcJsMxOAmS63DTuOSr+CwQ
         AdEg==
X-Forwarded-Encrypted: i=1; AJvYcCU7YIRGZr37ZT+6vip1v8UnA5qJrchaRHcjInbDOJBF4XE6wxwebLILqagu1WVLKMbnodkokElBXQEo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9tA5QrYhlb6uFlMI/qd0NC8sV5zU9RuhYeprcnyablI8vgsi
	b9MY2Ktl8SmM5tsdsNobfYn8JNzs1a++eRvAUv4y8YKDItNBNfIl/9MqLVaHDrYNYiM=
X-Gm-Gg: ASbGncuJu8gned/HFBVWl7vKTUhsoSyQSGn0k2h45gAjC7H2dfikhv8oUS7cvD6E2TZ
	+65pI/tKXbjdH4MsQaAx/U0qzrwkGbb/po24Aj5iVjY6WOalEDi9Cj7wOdK1NiUa06G1zhBk+KC
	Tx6PsmfNhApWc/lZUK5g6Lse9GF5jwptlRt6A7N6VxCNZhHi14Evya8vHktswVbG/lMPiEKzigD
	s37S11YeweJjHH4hyKzTKOAK7hNwDSCeQxu/encegHl4yzqBMUbYvQDx7eep2QmlFC7lNiaTeXP
	E+cKF7XnjnfsLsugj1KiC8zhy7TxU1M7sxFfuaDc39sAXo+LzwXFafwASAg2lXAqIPiU+5BFX60
	DXssjuJFOUnMhFGt23wq6nuCLJ2eM/v0qghYnwvfH3ClKr+vW/ovRSyNVIyySg+PJHagzn/0cxK
	ktyPIl
X-Google-Smtp-Source: AGHT+IHS+VsWEygsOc+A8x/7XjIirk6Z2+ec/QSTP9F+rFxuXxZu/OJVHHDmiPLgNVJdADJ0GzGP8w==
X-Received: by 2002:a05:600c:3b25:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-4771e206a1cmr25175295e9.37.1761740940574;
        Wed, 29 Oct 2025 05:29:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:41 +0100
Subject: [PATCH v3 07/10] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-7-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3ioQwKPzou2lSqn80K030vy/XMiDzWorAZyKbBrMyu8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh+MShEqQi36ZJ7GYHN2epnXfOxGOvyPD1Az
 5/iBt5biO2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfgAKCRARpy6gFHHX
 cqHuEADhMa/O5AM464uKfoc66jVysImTGSoaQVrgEg9g7bMaCDLylQVbwPvg6yni0h0pv0L1nC8
 6tfSb4WukhgO7unX57B/aDfU6Q5ciGVydTOP0U9mPCF4ZNr980kwoeu/Sobff7HOgO0Tl6SE3yC
 U++TW2n1YcHTfITwhDpFWhAs7d+fLPGV674ppjfhDpPTTdU7iJzpNj/A0Zd0WB2WQmQLVyb4LWm
 XIg4qoDnUpJ7CohXFNUouo7Am4W0PGzOSXn5umca3GryiCfvLC8N4FwhMe/1xyhZgWWAqvTJk5L
 HOqjKOV7mi/QLqYSdcPGCMJe/QKT1/kflUsh9XaNpiQbfEInr29F8r43s/+rcxWYyMNEInjbFjj
 +K/95NOGBvtwDek2aOtPzBJeqpCvywFYrjGXM6eR5902TGgldJE2BI/Kpxkffly6Uv9G2aL7XDH
 i/MTU4p1W+TAFXYYMx8Kmwwz/8gKFVfcH5wq3dkRGDIRuhsn54om1ZAkJRKpVFMlNvaddMSQx6F
 P3xlGOCEMplHH3zF9amoENjn7rchB/OHvAV41oU1iBcNPvgQPae58HchHSsiDSsOpyxKL1C4k4K
 8o+kUGmobz0he/dyHF03N4E4cmejU7quIjfhYqxrvXDBcnTugaYSZR72LgIOw5vvSGxSZIyBO6M
 94NPbHZ/QPPoQDA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance order the includes
alphabetically.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae531c6efba3ce92cc73a2d57397762..5a696e2dbcc224a633e2b321da53b7bc699cb5f3 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,19 +4,20 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>

-- 
2.48.1


