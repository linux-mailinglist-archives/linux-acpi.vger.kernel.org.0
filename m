Return-Path: <linux-acpi+bounces-19462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3CCA9977
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 00:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8690F3031723
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20162F9DAE;
	Fri,  5 Dec 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By68nouB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5252225A38
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976402; cv=none; b=miOEjdJOF1wbYPD+jRfMVtyQVxbmuwf1CR5+AyiBJjfODeXK1a9PZut6vRr9dGkjg/U7cTAglFnl0o8EmPdZiT1olM2GDl0nLQk4bOCyjzJ4DNv9JddPfJNK58Rb7yGzawuDk6pLOJqxlfkk016ydg7zMXv7NBu96bsBpcngvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976402; c=relaxed/simple;
	bh=Z2TnggYnSPNTQQA0qeFMaIKiMc/QIExFwLuHda2smVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbyOHWgPcWnIcSHmHtiYQ0ZlPzbOnXcNKxCO4Fg0cQafj++rObw1pnbdMgV3IsiDmZvAAJkJEl3jvafI5EjDz9TEbQo4fV0tXxqQBkSmFqhaAn51t2KuOKmRcZYJPGTomaciYPUnXpac9zFyIG2xvR5o9rwARb+8MoZHiwhUNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By68nouB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5959105629bso2776264e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764976398; x=1765581198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok3XVC2kEB7d6LX2W7MFJKuf7Db93yAzAqWhVXvqPiI=;
        b=By68nouBGABZzZpDHHPfiQKoWSJIfkh9HRFeKVufKIhFcf/6Nfi7+gl50e75zXgh9J
         up9YTfO5T6MeQSqtFwTgm+PjOUVIj8AuX/tuMgoSjBBPY89tDxsFFGJgC6sDFlGSISXl
         teZQYe5X1vaFL52WoTZqrDs2tHmLS8btykVC8U0Scz7LAGA/kXFXshUt7b4XPk2G8ybs
         /tdb6xEuF09fB7POS9v+IWuWb/puLOVWKU/1zffiTdNnaqK+wq/waqirFHn4A8F7rIx6
         1qIXQpN4E8X2iE1uVy3KFgWKxVhMfOYxE0qXuXFOgnuyOXJF620Jlda5Q5eMCZAfLrIf
         0ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764976398; x=1765581198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok3XVC2kEB7d6LX2W7MFJKuf7Db93yAzAqWhVXvqPiI=;
        b=VU/2FFTXz+VwMStoOBnFbjVRbuCbsq/r1u8ly+D0vVc3oX9+YZDGBZ4dH7LAQ9xtLK
         o1HdCXHUSnLDiP6qkW/caAsnVX1tB1PESmqavisQEfsWf0l2yUImUUzD9XYrLSFJ2l6g
         G85d7wTIGaUCsrpIsKaaOS5ni6t5SseCPcpBdS9VO/OQfvbrYoi4EM4hudZdqXpaZt07
         4JITzzIN+elMDqY+QAGL/oC+bVIp7ZDuemVV/Agy/5s7XwXAvlX4t7HdD5k0EGNQJ1kk
         BZN91c5Uiq+2H3q4kC3CpIdYSr1AauZslJ5A2lCb1JFOtEkifii1eAVnuVhHGYw1bDZw
         HdVg==
X-Forwarded-Encrypted: i=1; AJvYcCWu6ksKrlJvXsQ6pCQ3c777CufHPwiGLWjoH/GhM14dfKOp6z2p2MG9AaMooSiv5tCmZTsk3cAo0IkH@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuvdKkItpq87y3dJn/Od8WvN3sHagOWwf2Z6zTHygqP9WGoNH
	TvlpS90ladV4wv5NrTLdlDZUuMWbo+e/q3TOmWwhQjrFeoHEIxhyHlqO
X-Gm-Gg: ASbGncsx9fotNIRgzk2kbf2k5NWeEM6ZJCcc/PBrIR3IJjzSpzefB15IKuG6owe8+UH
	TWanHuu+OIHvisffCgNR5pD87DHOryYsEq0QPegL1L31AQOabepMgVRh4joGwf+z1hA4rfMFZhv
	3WdkqJRXVeNl9sNmAqvgbUfz+iWEoS5FezwufK6I0SagHZKXcnDhbuUAXFcEC0rqyz/1o0JPysM
	m4ziLRASE1Og/997675NT7H5xSTTRWwmW7YIS7cCUwbeoMYmCJHT/EjKqpGIqMouKtEtGO7cnL5
	S6w0U7byqab+ByM3lVLESXqzy6LGbhxMGeI4H2KVaZIpqNTEnK9gla3zikJ3WUKhMHwHfsx4g+Q
	9C2BC7lcu8KRxbDaEH8MiRVi+B26AmMSLBLy0j5q7wrVXgVn1XjDv40inXP6UVGm+DlGYexpQpn
	9Eplgi22DyBPZJ7IhvgT4=
X-Google-Smtp-Source: AGHT+IHw+siol0Y/HCUauT594fFSjA/LYfEXRKCDELP7T7smqU9LZ6s7uqmUidrRDZEZmBY4flxMEA==
X-Received: by 2002:a05:6512:2353:b0:595:8200:9f7e with SMTP id 2adb3069b0e04-5987e8af414mr145380e87.20.1764976397518;
        Fri, 05 Dec 2025 15:13:17 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-597d7c1e2efsm1918614e87.56.2025.12.05.15.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 15:13:17 -0800 (PST)
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
	Askar Safin <safinaskar@zohomail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Fri,  5 Dec 2025 22:32:42 +0000
Message-ID: <20251205230724.2374682-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Reported-by: Askar Safin <safinaskar@zohomail.com>
Link: https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
Cc: <stable@vger.kernel.org>
Tested-by: Askar Safin <safinaskar@gmail.com>
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
 
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449 (v6.18)
-- 
2.47.3


