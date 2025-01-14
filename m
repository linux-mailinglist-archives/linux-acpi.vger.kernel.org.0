Return-Path: <linux-acpi+bounces-10617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E01A10B33
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B467A2822
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B81FBEBC;
	Tue, 14 Jan 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOu7auQn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A11FC7DC;
	Tue, 14 Jan 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869146; cv=none; b=BFWdAfUdJ6xai4pVnkEB96u0yCnE8vIHVUclgQJfBP8dZbkV/SG1ozWyKXMPnT+lxnVBcjGvEHUfFsCjYvget6uqYH0rdzNkT3kmjH0l9P3LXXIdynuXgbe/cCv6Ijr9+bgkfckFdgemRgUC+/IZJScmbBHU24pkmqDhBH7xneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869146; c=relaxed/simple;
	bh=ROyNfhHztIhHzZbMmoDMWDw1eW+LxDgmvN+AM24ykqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aY7rXY0AQff2LWpENu1Mnft0YH95f7DGRsNo80PreWO+Y44zbqxmXK0pyiSvtTgskmDq6pgWxgiiWBzlZ1LBB7e20nhdNpeCOPkdFK9YV23rvwo718XyMnG7M5tS7GBxFhskVN3G0d7uHX9TCRE+ZKzSdJXe/La7VDvCT+FsgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOu7auQn; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-518c46cc6e4so1854282e0c.3;
        Tue, 14 Jan 2025 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869142; x=1737473942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzP2hTHD0TqiTIAcB2t2QVINU/zqlmF+FkQkand+7x0=;
        b=TOu7auQnb/Y2uXRJM38+MXS/i9rsa+K9DW67rlBG61lUZ2NwFluRb34ozuGEFZIaDQ
         x5zZLor4R6MHIw5gMZpgCvl0TrqjIRIViNNHY4N1beCFsddQLQC4UBqm93Dze8J9MJ5b
         VmdeWzkPE1WgBA1oIPJ9GOOZ8pSuw+A/T7c53ByJbWN5Pv65jyLkh8sx1gp6vyrQJ0uV
         ks4XnsLyQRrZq4WGXJe9mTypMzgO/Vp5UAn8g8Ht1GrLjxR6fcvM0UymV3ISyF9Rj1J1
         AWAqLls+Fc7IMugcQf8AoqEedR5Hbh2UrrR4stLqKUZejrVJN7iuI3edFA8aHkoLEwK9
         A1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869142; x=1737473942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzP2hTHD0TqiTIAcB2t2QVINU/zqlmF+FkQkand+7x0=;
        b=BBgbmeCIyqyZlmbjL2TN7NuWqD4F0S1pUEGvvh4aO0PoURuHiqE+mH7bYN4q6c6Nsx
         LU7Iuxm3y6gTyypcnFBq6W0RDMTjwPFZFBOyyKelHBLCuX0XZR3tkYCnVcOCZQ3CD7iL
         Y7ZZ9BPRPBfHK9iXGQY+rT61TKj+maz4vuPoOCrI7YtL0/ApXaem5PsJkyHlXr0UIQCU
         AcLEqRT5lVH5LwfCAH5+PBsHtK5Oe41raDy+fHlSGkpWxxMGAFaos6Yv/PhHOIJyJGY5
         wM87GieL5G8KTEHByPyRoeOFV976pTeeqIyjLwZpesxi5dZjLmoEMRNowb3jkOkVUGow
         9qWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1sFpKkKGbKlsj8Fr4PQ86t+VKmQ/PdMjdf8Ckwo/0zwF93F9v9wgyv+PI8Qq7yPpJlyQBbaUF9uYJ@vger.kernel.org, AJvYcCWi1cigyg4DN2RhBXnFXDU68foG/ydPwnncdBqmCs2a1hPdrNqi/579aHERqX0t8gfGeBbHPK5qU0pSq6h2@vger.kernel.org
X-Gm-Message-State: AOJu0YzSv3xJwAz04OpTOMNVDduPRvLACQRGO+Mg+toOHKAVAB88EEt7
	ZEaZAdSxBkEeaU+c3aKQv0r8HNtYSZDPiSKp3jcMniq5ZvpgK1vNpXsawQ==
X-Gm-Gg: ASbGncuMC5Tph0870KDeJnDbKtUGNhCf4BY8LW4VVfJ6X7yVuo19bOMz0Fxi497eSrR
	DSND+f66E+BY9G3HzMgGDbrtdYSaPSgwRPDtYDn1W1dK8CAMhzCVCS77BfUwOw+SJw2m3OnaBDa
	xWB/k0rdvHf1Gq8tite6QbBx7maErr/LfsM7Cf9M/7j16Q31ZukSVro7ZDL5wuWxhlgHnw0AC2z
	2rCZ92eu90vKQ1S4xpAeOinv1ynNxN2DoZ029kh6EoUogdkHHnignPLS9jF692z
X-Google-Smtp-Source: AGHT+IHSfnlrvlpRrJ7IMJQaExILy6q/8BPZZxDod0VoCG7AZ05EOEZtNjZCoJh/7uR6oK3GiBTooA==
X-Received: by 2002:a05:6122:180d:b0:518:a2af:d666 with SMTP id 71dfb90a1353d-51c6c439cf2mr18935353e0c.1.1736869142594;
        Tue, 14 Jan 2025 07:39:02 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:39:01 -0800 (PST)
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
Subject: [PATCH v2 16/18] ACPI: platform_profile: Move platform_profile_handler
Date: Tue, 14 Jan 2025 10:37:24 -0500
Message-ID: <20250114153726.11802-17-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114153726.11802-1-kuurtb@gmail.com>
References: <20250114153726.11802-1-kuurtb@gmail.com>
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
index 2fae5e2fc962..f1749eb7b21b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -15,6 +15,15 @@
 
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
2.47.1


