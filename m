Return-Path: <linux-acpi+bounces-18332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD72C1A759
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65432188A1B0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F93557E8;
	Wed, 29 Oct 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Fps+S7L+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703EA345CDE
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740944; cv=none; b=BbZ4egjvrlRfJEArkn5Fg2m4qjsFztoJqpQIO7Y0xSxOTRA9Lx5pmZaU2LIEbOah4pRdSrtVD7fuMloyttRwLBnc1JKWmWtH6QpSTZdGfSeF6Oppg/VSBTcZc45KeHtJNqf+2be7/8dX6RZuVmPXi3m4YMumPF4il4advWqpN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740944; c=relaxed/simple;
	bh=NNGvjwESjllaEF7LxK3T1yowFNpjBHh1JCstJa8YZdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k33aVXegol9uU+i6SWNggKoQZjc6PguekkDe12Ba5OeUfoWYNjY1stuoQHR9NvgEiKxvrDj2CjWuoIoNq/6KgALlT2EKGDFRnHe3pT9rIXtQPZ3BYeOs91uj/GDsUX1DrJCxOgVR6Fhx7RM9gjn/xrol9lUBGohNu17Py+U7y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Fps+S7L+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47721743fd0so3490015e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740939; x=1762345739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzbX/LcA5Dz6VEQqEws9evNBv2Yi49eBen6kb0VfhlE=;
        b=Fps+S7L+QV2ezvhDz6w13RtuAVSObqOXel2aGPb6YBczdvQQkf/9zh3AwiHJnWhKt7
         kTiB29pAgzijdwNE0HY1Aih8g30VyyYj4dFaPfiWDd8Il7MQXPpxvHe5DYikvu7G84Br
         cGm3iUbfiA/eUb6GqzU2byNUk6I3cZavWEbx2wz+rUWqYJyF3SJRrQ17fI7vttYmjTOL
         JCu7Yg7XvGg2ihM3Kkj3RKzytpMrimvvlEScGpCS5JN3BABCeYB9ORtY0NEdCM7Qwczq
         KSqA4ETFIct7rxP1Ul/DEO4VtCtvARl35utAQUOzXJc2dqUrXT/VNhtzfMvyljdi4Z7C
         oZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740939; x=1762345739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzbX/LcA5Dz6VEQqEws9evNBv2Yi49eBen6kb0VfhlE=;
        b=BfvEmsdLM983KcbTbW/swPIwFFyKtGA9UEBKXBG5Fyxm6me8eUtAMuKuNZMYSM2WY+
         GbFuSWV8YFJoDQ5IpuN6jfM/9EwcOZ7JWdDhSfyhbYkB9XQ5cR5ufXzHsD6DUw1hfqLF
         hoA6t5a7J70t7UwFDIGtja+PQjVPl+Hw9JHXOf3QvO4xJZP7sNmjRoxydCtOR8gaqfGU
         sEsu6f4WR4N/FsL45/25n5JcVBYpHAqaeW5A9mBaeU3+rGNrTQH5T2NSBg8PYtAl2H3+
         PCqIZvuIgNwyJmop4l+9sVnu/yRrjSktZEPmigIqgb8ZUfXeUGHXxYCZtVPwBxVGFQl7
         fI4A==
X-Forwarded-Encrypted: i=1; AJvYcCX7j0fVS0w9iX8OYA7zZex5VhPhATHTem8B+a8BPoX1U8K1MWVUOgM/ErjCTT3w5U9KyGgbT2oX4b8e@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGVEieZqRA2zRqRqWfxMXDgAAvxx4i0hz8I/QkP/vg/RM0iWt
	kcTBpzDiU/BaTUHxZbbr3x9oo8r3XHbJNn/FANrKEQyMh1jgPrTS/U7zQpx+NqSM1os=
X-Gm-Gg: ASbGncuZWJAFG+m0DPwy2U0Kxm7gEZj42Qtw49wzg2rr7cW+RlcBQD50k1d5lM0SwnH
	JtNhfUGXQVFuPi8vCDZ+4i9hAfDxJ6VLMQmSlsYoA3ijSq9clknO1UajTQrqN+0acVd8/JoGJa7
	++F1bqotyyIKjmzBDRY5LPMBJqMg5wLYesSdY+8LFDqlKtUXlXpppr+cr2toU5LU2HbJZpZVDf8
	q4L/4K6DPlByU2li8b1UJiFc6HoSRVmL3syr1LXv9e+xsnqktc0iX+3LCkvqN+D3YDEI1BFu16C
	TZaPX9s5DlnkWPaZ+sF2AWDWUGchY+ZxSX39qupPtwEY8P8YjTicQLvTLjI1+8VAqT915vaGlop
	JM0aZXEtxWIHocwa3PtsTlvhiz+j6nx96rt/5+CGLvMSPXNa3HCGY4P0PK2Ywf1LWcbfOxVxTdL
	L9MJ4c
X-Google-Smtp-Source: AGHT+IG8g6hB5SNsI9e3DFIiomt04U0/8paaItGpGlO3FT91y0uqvdH+5yl4I4VWVEOoGHFf1gWiAA==
X-Received: by 2002:a05:600c:3e87:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4771e21ed24mr24759875e9.22.1761740938806;
        Wed, 29 Oct 2025 05:28:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:40 +0100
Subject: [PATCH v3 06/10] gpio: swnode: update the property definitions
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-6-638a4cb33201@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=D+u+srU0OvfgxDXNvd1XP1KSLBihAFjsPd14v+EnoX0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh+2HH+Su1AAscYKxfH8/3rvA7k8r533eDCn
 Ldd6OcmdAiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfgAKCRARpy6gFHHX
 che6D/9p4upU6sk3sQDuS0I2iQxv92BNCBoKjG+TgACcJJkxU6gyOeuHQXE50IpbE2xosVdtrP7
 1IAIOU8xIMZEKdejFaDCJGSQcEt736bVQxE2dAL1nHzEptoQpighIlHrvFoNh74kaRPEZzbW3OC
 4JEokhbUb1skelTNCxcnEpBBwZU/eOTRmSlzaMJJ1ZDeDyZYMzDxEf0iQ4Kbt7czKAAqG6d+hH9
 L43IIu1QqjdhFq9ohwnFSauLOtF5e1XYSsQICLuu2YPDzjh4xw3/oPfl/fZnrwJyhGaCrAleiJX
 Zy2OgE4pqXz0aMNzU03IZwR83zUqHcTpWZLH4oIR+qbf1EdDNCVtygCu/LPVUVJvuh1azuRtxUb
 Ku4UpH4CCWJCfak/Rh/CQrvhADdIMHlxu5NeQNHvryNmg4qaZgnZQN8n7F8v6OfOrlcY+7BV1mL
 m8SwgjxaXSk2c4NdQ5edxIYIkHkNSdco4z7f4CvIhHBzk5VTHiYtKsAYs72npndQqVNDtMs8kYy
 uHOo56N1n3r0traQSanJWHCKUqSdYXakyXCzsbk+mc07XKLcWDds55EFV9AznhCcTI1Fqi9BqEu
 fvBdoEQZE02c0hWqhu2jAAO4tHluPPK0xXvuPdVHONE5e++f7qgmRAqpAS5TGgYh1+JxYIr/FT0
 GbxVZXq6EdNM5zg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the recommended macros for creating references to software and
firmware nodes attached to GPIO providers.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/property.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
index 0d220930800276a21b5ba96a68371ce66fc4ae3e..6b1c2ed9c57594bf3ead5edc82439f9fb7f514fd 100644
--- a/include/linux/gpio/property.h
+++ b/include/linux/gpio/property.h
@@ -7,7 +7,10 @@
 struct software_node;
 
 #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
-	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
+	PROPERTY_ENTRY_REF_SWNODE(_name_, _chip_node_, _idx_, _flags_)
+
+#define PROPERTY_ENTRY_GPIO_FWNODE(_name_, _chip_node_, _idx_, _flags_) \
+	PROPERTY_ENTRY_REF_FWNODE(_name_, _chip_node_, _idx_, _flags_)
 
 extern const struct software_node swnode_gpio_undefined;
 

-- 
2.48.1


