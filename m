Return-Path: <linux-acpi+bounces-10713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124BAA12FE2
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F39F188864F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5A170A13;
	Thu, 16 Jan 2025 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcL3c4kG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E45125B9;
	Thu, 16 Jan 2025 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987318; cv=none; b=pypArcUXb2P6q0oyW/PfHmDjpe94CWMI0vh4/FAb6u6jY7eHx1uRE9nWHRssLlJ+3BZBTYB7dwC/O10I07VDm+ZObmlXdbuTIR++Daalelw5/ObeadIBDC3ZslCQGCfZIXuWxVz09DHgajmM2V+cJXw5UsI47+VV9FWDvDwq9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987318; c=relaxed/simple;
	bh=+66kqFpqhzN/s4ymNKJxWJYi8U7LK+BMCLwY6OMttgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAYh8LaI4I9MaT00SNDUhLPLv5RLsVYTxAQPaI+5Cx2/J3rli1YU2Iu50ql/uBnr/fz7t6EZ17R9C9XkcLnF5mzFRufg7VF569IGslZcnT2YSTOJKYt/o/EQQTeMBvXIn4RKpLRnIQiqH3vUOiE+YENPTkhG7PY5kVHMdkIDOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcL3c4kG; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53a91756e5so723303276.1;
        Wed, 15 Jan 2025 16:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987316; x=1737592116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRk8UrGC//ApPTeGyX4nKWjjwhb50pfUBdhCMtK9xUc=;
        b=XcL3c4kGYE0oXMdY1FS4RiACT76supJfPvsFLtdzakegitCMznH88qO90Y5mMYxSS/
         40uhw+3W9jUmhHEkAn8jBh685KiYC1rkxEJieebHmaRIbj1qbHhxBYIfLQOeMcVkye6y
         Bq9zqfdAQodT1zGHTr6U6vmhBpogmfu87eGx8QHEbOZLvwRZmaTu0sVKcWNn8wg+iaKF
         dqARXEfZcrFJBU1ZdX8YGw0stmWnTrjTFAailWPu7hhCF3za9+vS78X5u6L3Z6bsu5Xx
         g6K1BxXRtpAcoEWAPXoRWXXdbgFdkX3XV8vfujO8wF4uYi28vM8VDLhy869HW86LPoM9
         Ap8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987316; x=1737592116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRk8UrGC//ApPTeGyX4nKWjjwhb50pfUBdhCMtK9xUc=;
        b=SF9VA6vgJgHPG+hkUAFk294bpSPWmAwr76rIJB6LS+DsxjDOWQuA2AKEWYksgqWVkX
         nkF64wolYyLs0kUQlkpd1sv9RL0pGzayoyBFB5JY5zP+2AsnIcGOlIBEV8Spas8aoAPE
         jDWzHAAYQsdWQs63J/by7FOnp4m0mCoItcPS1OdEE/BiasIdf87F5R0WcnhfuPaI8tjY
         2x5HOuVuM1geRUx4/JtYaKdGayd91SbNGxcDF6e8ZIeTFz/xxm91b3/J4u2RYAUxpkUs
         R73z1Nk3nM9YbH2YsCYdulb96ivv/OT4PijEX45eg5vAlNZ+Xxt2gprH8Adi8F4PSoIZ
         7ZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWbEXgkVhVr3kKm1HilFguOpTNgpnLEBWXs0aBy2Vm6IiYX5DcgKGnE8TGDNWlQmF2SRDNZQQT7zfX@vger.kernel.org, AJvYcCXLH22gCjXkd1xN3/Hadzaw+4+XLfyv2eKsSPwmqxO4yi34ozTUp0k1ueG8d427Buj5JscAQMR0IE2M0gp1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wonhW5R8V1Q3ZsfbxIdZ/vSbxYOc54Iim7uY7et5txwoUeoR
	eDD++zAtsa5l+bLN1OQumoJe+3ftIeWfs7hfaalNcwD/RsfQt6wsX1Q/jg==
X-Gm-Gg: ASbGncu1yHPr1ouhrYe79V3lLoy3T+OWGndqzHhRB7Kusblsu6wGZkhFrhCLYMSSWxW
	gPk9OS30pqjyscNB5rBUhXRKbu9pW9+b7Qy5EE2bCcDYqe+nuALrR3pCtbeZnSoytl8Cpsru0ir
	rZ6NwKHKWljc40TsDY5UExximbdZzluSGNCub5NFLLrraRuiYQXykAcdwo04OO1jr2cXDfshEAq
	4UmB7B+JotFTkaosDAjqVOaFAsSxBH91X40LlrWSuMAJMvLCTOO9qUCIWghtpwo
X-Google-Smtp-Source: AGHT+IFB+GCdkVxES2VCitBds6dMudZWunGB0HpJM9yyZDv09SNlFEYBf8sf4EG8BIr+4rh1PnSGyg==
X-Received: by 2002:a05:690c:6b02:b0:6e5:9cb7:853c with SMTP id 00721157ae682-6f5312a2e9cmr290416457b3.31.1736987315753;
        Wed, 15 Jan 2025 16:28:35 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:35 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Kurt Borja" <kuurtb@gmail.com>,
	"Maximilian Luz" <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Lyndon Sanche" <lsanche@lyndeno.ca>,
	"Ike Panhc" <ike.pan@canonical.com>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Mark Pearson" <mpearson-lenovo@squebb.ca>,
	"Alexis Belmonte" <alexbelm48@gmail.com>,
	"Ai Chao" <aichao@kylinos.cn>,
	"Gergo Koteles" <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v4 16/19] ACPI: platform_profile: Move platform_profile_handler
Date: Wed, 15 Jan 2025 19:27:18 -0500
Message-ID: <20250116002721.75592-17-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_profile_handler is now an internal structure. Move it to
platform_profile.c.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  |  9 +++++++++
 include/linux/platform_profile.h | 11 -----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a1dfa168f51f..f27005a267a1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -14,6 +14,15 @@
 
 static DEFINE_MUTEX(profile_lock);
 
+struct platform_profile_handler {
+	const char *name;
+	struct device *dev;
+	struct device class_dev;
+	int minor;
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	const struct platform_profile_ops *ops;
+};
+
 static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
 	[PLATFORM_PROFILE_COOL] = "cool",
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 778d4c661c3c..eea1daf85616 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,23 +28,12 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-struct platform_profile_handler;
-
 struct platform_profile_ops {
 	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
 };
 
-struct platform_profile_handler {
-	const char *name;
-	struct device *dev;
-	struct device class_dev;
-	int minor;
-	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	const struct platform_profile_ops *ops;
-};
-
 struct device *platform_profile_register(struct device *dev, const char *name,
 					 void *drvdata,
 					 const struct platform_profile_ops *ops);
-- 
2.48.1


