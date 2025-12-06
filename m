Return-Path: <linux-acpi+bounces-19467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC118CAAC44
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 19:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4D830198E4
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74E92C3260;
	Sat,  6 Dec 2025 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Hn6TT8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DD2765C3
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046110; cv=none; b=o+kK1Fh6u9OCSV8zu3Ju8DXnYdYEG4+zbxv7O6qIlIbNN5C4SfoSzmQbVjTzNTlxl9RL91K75ajG4+d4sh8klWypR7+xS0qE6wlRc90jTbPL9jezUB4HjhsfYqtzLrnFrCR9Y8xjNhYz6RDwn8wzl8Q9q4rJ71KCsD64dnId8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046110; c=relaxed/simple;
	bh=2Xj9BvX5DJCNWMWbbzPbSZXRdRtJu6wOg59n92iAbNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pge5hu6+dtGlvVsdDQzMg8OIV7jyQdwOStqyvH2ki5Tdd6YEHrakwyXH3YJedulINsu7FzRO5UM9cOH41a5B9qgwo1L8k9Z1tc+jL/iSnkciw/rLuKPhoXHmugb+OXdg/FyGSaIdL/z6/0JjMG384CHVGWbDIzYhUO1RzQCxIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/Hn6TT8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-594270ec7f9so3598028e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 06 Dec 2025 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765046105; x=1765650905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBbB448ht3hgqVqiqj9wAU25sZQEfiyetfXCLvEq3so=;
        b=I/Hn6TT8iLH4JVy9MgQdBbonERZmmt6dv3kMvFnvwEmcPegq4M3EyZuAM93KgRYKeg
         Au2WWmCwvJ5sLJI2dVdRocT+9MYZIqUjOaqL870wu350DpWHKujPJJxd5FhiCHZkU9Uy
         ueCStBtDHPhN85XWZ8SPCEkqbMF/U8Y9rrtGANJ/tUH9/5+P6zMaIWJsZQThKRTy4UKh
         krzI8iPj6xYcEo7gnNawrr46QdPR6cJet4d7kvCxySUof6nC2QLIG1c8TQpErBsx70xF
         sDk1m1xBNMbyawGYD2+rMFsbeMCUgHAwbFcYn+Zz6HZHjHXhGAXHSgKwxm9UKJnHaO6U
         f1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765046105; x=1765650905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBbB448ht3hgqVqiqj9wAU25sZQEfiyetfXCLvEq3so=;
        b=dhiOQIRzLE3E0eC3Dv2KX2rm2ArnRzVmdD/YW6BahvewbPobFQ2mez2H60MTuIVAHt
         H0kwk+JL8RT/5yIWX6t6fM0BsT986mcSO5Lr1c4ttdHMYlBqVjrB9zLzCw7cgypYvyBc
         N2eMVBYQUnrIkGz3iNqdCzxu8JEUakDPiuQjyOWhiqhimx91KnBuC80/7qphsqhIeTK7
         fCa9PkEcaQ6AXLgnDR8ZoYa3tTZCHVZMSZ/TCtI1bO+DmILZFMhUKeDZIp9QZTfkWeve
         2z7QrNLbJjJBdC24EygvigaRxmR69OG5OpO2rwUpvgZXRT/H/FW0gHjRdUQwHYpNcagX
         U9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2CBmPG+kb35vH4r0YlWsAYncY5RrmuK6nj4jqh9pB6fsZ5ET+i6qk+mmlGQTq3vG9Wu2HzCfoFWnu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWJ2Dp/5rA+gsnF+fd76yqJgZ64M0cAic8KiuNew+eNI/UBp5
	lLb10uejQu6vqubbFjaHC2Z//VSMR+VAElQvkMxHVrSYaSkyV23GEDOo
X-Gm-Gg: ASbGncsFP4mfXEtP/BXEvYu7cCUGqWdeDD+7cU6zYAUNaWa409b95nTUKzvuVtQYDyq
	NSM6eBM3kciwAM0wWIyQ3OD42GW9JelxrAxNvYj6F7Gmo3eSIcat8EhbmRH93pWnhNuV4BfmLN1
	39vQBgJeIsuNepmVtdTUMileU71E2HzI/HcBntJ0TNVwO7KY6AaUQvmJqIp43ACkpFvbbwcvGcy
	djv6ZUFCcgAIZ85Tn07GTGRl1ED0LWWrzCLvQ/3MAxEaWcOLmzsQfN4tAjzgxoPBAt5Z5NQRHGu
	0vXNLkLA08xihpCW83RiV+m5PIZ9+TyZ+6j9+4cWAr6GEct4tEpUDZTXrz2JvUCheGpi6lRVVZO
	V7aTFCCyfXvnIhz23EbqkZgNNr7WcCV3rQe2Gh3xEATYcpX+IBlB03rO+vJDmx4VKkz1wDYcac9
	LSBzOqHtMw
X-Google-Smtp-Source: AGHT+IHnxnTE4IQRpHLhybpHqVatvtv9+syN2SM1jyy7DP6ZE+rzLXHDgj4+p7nmI+TmaroB84yRhg==
X-Received: by 2002:a05:6512:1113:b0:595:81ba:fb4 with SMTP id 2adb3069b0e04-598853c54e7mr893651e87.47.1765046104377;
        Sat, 06 Dec 2025 10:35:04 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-597d7c31520sm2588902e87.101.2025.12.06.10.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 10:35:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev,
	Dell.Client.Kernel@dell.com,
	Mario Limonciello <superm1@kernel.org>,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Sat,  6 Dec 2025 18:04:13 +0000
Message-ID: <20251206180414.3183334-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251206180414.3183334-1-safinaskar@gmail.com>
References: <20251206180414.3183334-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dell Precision 7780 often wakes up on its own from suspend. Sometimes
wake up happens immediately (i. e. within 7 seconds), sometimes it happens
after, say, 30 minutes.

Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
Link: https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
Cc: <stable@vger.kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 7b95d1b03361..a0116f004975 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -370,6 +370,28 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "ASCP1A00:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups, likely from touchpad controller
+		 * Dell Precision 7780
+		 * Found in BIOS 1.24.1
+		 *
+		 * Found in touchpad firmware, installed by Dell Touchpad Firmware Update Utility version 1160.4196.9, A01
+		 * ( Dell-Touchpad-Firmware-Update-Utility_VYGNN_WIN64_1160.4196.9_A00.EXE ),
+		 * released on 11 Jul 2024
+		 *
+		 * https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Precision"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7780"),
+			DMI_MATCH(DMI_BOARD_NAME, "0C6JVW"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "VEN_0488:00@355",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.47.3


