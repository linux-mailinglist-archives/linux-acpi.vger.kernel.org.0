Return-Path: <linux-acpi+bounces-18434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEFC2AC8D
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D800718934EC
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCE2F12B5;
	Mon,  3 Nov 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AmGj0Gfd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B352EFDA5
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162552; cv=none; b=awnvhgm7QFrOnPnZ2i3HsX/I1YzmzAq97vG/bpQXCFs2oPdACTcfTAigktZopTaMgU/GhjDLWqhLkPh/X7PJ+b1D4lJTmoDJ1UquElnBQlTqvrfPOqDqu4ATEu5vxwLdfYNtLrBjXgTBoRTsiQYkJ/1qJbg/xy8Qdo4DRFeebTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162552; c=relaxed/simple;
	bh=X8edYpKFxJakc/RTqEB+Pipzfl1zQL02ONMlmJvW7is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8pnY4tFyuRA2zv2mSZVovHwmEZ95oXzlj656uq7Y462EgtnXASNYFS9ATyCjS7uX5A9ulwkuI4KWThAi6l6n6fevMpfXl47/g8v3f6UJGPHcvWXcIkbEo/Xy+62U7CmXF/Ngiz0LMHq+c9uICVhcSCm9Vsd7jgQiiQjGaPhzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AmGj0Gfd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so33715415e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162549; x=1762767349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWWTasux6nuDvfpZkvePzyRGdU+qe2S0riWlt2ij+bg=;
        b=AmGj0GfdP/mDrRKWTedw4Rgv8zuFKIaNzeDXqjZc/Vjxl9ApdUYC/iC/XYkoNgnjLs
         cWLdOFIk11hdgvjLwn/GroEnrupCzDhR8rY/Tsq/8y8FBdN21/WQ47V6kuGbRKWnBS/+
         C0Y9TnipT4Ss9ZemYRowi1f0uwIap+ICcU44Ewu2/xv302E1lCMaZnvID7dUzvIy9CDo
         zXwd9uiHcw/Uc4Ck60t2/tz8FocENU+HYV90H5GoqbL+sQVNuS+IJj3ghSsyGnByqXll
         SQcEvnAv9DFA26cpNSAH8uNPr5gFlhF3MMxbczYG9aTIFYnW9LjQd7WngEVFOdjhIi7F
         So4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162549; x=1762767349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWWTasux6nuDvfpZkvePzyRGdU+qe2S0riWlt2ij+bg=;
        b=QCzqYjYApODDS37AOlIvbX+jrIzNfMveVhrw/Xp7PRNdLnUlOc/VvaKe42FPtUHRtc
         SrkG1hy0tUemTWQ1C+7serM78XyFLmnn5xcrwzOr/zDU2Fo4dQnheWvBsv11PF/KvPcy
         JHGvhKqYf/WrsRQk3Nds+ktsyi6fOE43uAM7vrAUsU1rxzAEb/BAn7NE3ubrGv8pcF0X
         7lzqZXy5FBG4uiAJvpal4jlftxda9DaFPZcyKNfWZEsf99s33m0YJ70yApMRRPjx5g96
         3VcIkqX6hriRiOXt3X5mUpeeKhDwqBvILX1aQbMWll5Zj05zOfYySJB9zf0OvFsJp3Qz
         tWog==
X-Forwarded-Encrypted: i=1; AJvYcCX/qUSsqlEvdZLFgzx6g17h3F/kW7t/wFzCpxsETduIC/zu7EUC9ahyjzBFuEFMSZDMzyUFnGS2jWFO@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkMvTc0jpw1/zjTkrb07VCglcFtiW5pwcYZu2RqwV8Ws80qye
	KKOoBpMwMeWV7ykCZ/6GjPI8wEY3Jp9ANIOvKA+fSdgsRxeFVjFUQo1eSFlh76+4KFA=
X-Gm-Gg: ASbGnctqFtAUtYxiHzuRaoXYJUTfbFyO6qjAJIy1j51pabuZEHV2lrZEFV5cb/nS7iF
	GPwNSVUqpoQ98Z37eJVHEqG7QGtEy6GvvYHgPnf7gXFSjEDTmJet6OIjDmvX3OXJoH0JttmNT3a
	OlySZ9MvwdH5bNpiHvF3b8GLIJ+57jRV4JuJSj0nb4kbmLGCXRPpiKY699qAhkWXuhMNBn7oibZ
	BI861ptrgCRYLCmmN7BCSNG6fDhr2U9O/YLYONA3ABGGugApjTbr4zDYP5tgGC7j+n/S9nSRmK/
	AYJFIkOWqkgCH0VJz1v3yJ5l33YemliK873/xiBVf8hYkL66ArDtvteCaZX8IJlkH5nAZcwvvrK
	MgliESi7tqaC3kz0rLC74TcZempOSyAT+5M6gURNYCkf2GLRTgedFfoGGzGaNz1plZdDrs00xw8
	uOhIUl
X-Google-Smtp-Source: AGHT+IHTI3Dcsqc4uC3LQQ73BmLmMpPwE9u0YqBqg1oMnpavHHPbOsA+9fvHiegS+pBrTB9gZhDBKg==
X-Received: by 2002:a05:600c:524f:b0:475:dc98:4489 with SMTP id 5b1f17b1804b1-477308be79dmr107241655e9.33.1762162548808;
        Mon, 03 Nov 2025 01:35:48 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:27 +0100
Subject: [PATCH v4 07/10] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-7-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
 bh=YAQBLalSG4YSjo0vg2GdIJVruVYhGTc+UD/iGlJqB84=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdlq6kd9Yl07Rn0ewcMbLfCxB7GjAIR7zLAt
 imA7T5evWSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZQAKCRARpy6gFHHX
 cm57EAC3PVKe2zUsYx1icgb79Xrv0aqVB2RM1/lt2Jx7FxN8V8efLZgwbdrIdJfE7RS6qIBMIqB
 o1Z5vzbNsmLvn+N4sn8IpnoRQxKjsTpGfQG/X3CM82URbN+O/QCn3xyyhgq3XxxrTY0i9DSnzmw
 V2Akd/1BNKlHTlAnxVugDd5MDIHv4PCi6Nqs06g7QrvN+ws2Fze6GGEyEbafvGMZgKPf4MwMvT8
 A1mVQlpKRqkofi3Ux8LSedqigF6P55B07oHMs3rm19gN9LKNWT8zpKvquM+9UMqeGwLSTgYeJWn
 zfifBMxDjt/OjOYye7hW3tY0PRqdbodf4Yh9n3QrJcQ4VGEgRUCTD6B7eD+w07+odweUMDTHzeb
 1l24dscgPw9pUoWd6x2y8KtlmkcclxqPv2eL1QTR0eqxNKMsyuqYPUcUO/BZVDV01a++FyeVjcj
 S2flkLwYXCArRgyw4CcTcqtv9i5H4QvN9GCD/kWXDDHhIbdaTAZ/ZiMfYNaraUqpaDuUMyJBmbW
 lO/ZQafaV+DCPlvWjG96NwStFRLI+QkWaZC4Sn5Kb58QCd8sLLK6QkcSRQJXi5JtcDsWdpG91ul
 eN/3F0DTLN543R8fcmxjO6FO25GurrDMS8xIjiz8NRVoy6OPy4Rrbo4PAZLdtpu+/dJLjixJg+j
 pfy8Pj7guhK5R/Q==
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
index 4fbaa67a6f79a4af62855c88f6b74f92c3d97159..a368b14144e7bc29ae23becab2eb7a96a4adbe44 100644
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
2.51.0


