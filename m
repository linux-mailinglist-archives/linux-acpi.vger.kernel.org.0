Return-Path: <linux-acpi+bounces-10465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0D9A07B6D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751037A434A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C522333F;
	Thu,  9 Jan 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+FEqLfU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DE223339;
	Thu,  9 Jan 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435372; cv=none; b=THQ+pfdDx4aNtDSUAtm3VeU91s+Dl04rCWx1ggAAYluG5j3R3s7FZpqmV9mCWp1ASK1HDRvBfMQd7IOCqym22eB0bFRvB9e73t+xn9dDGD/Gy+yPTwYg0/Jfl5NVMHThp4+tTlCp7cHVdOpFqikiSGiPwzxtAPimhahW1GIsMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435372; c=relaxed/simple;
	bh=hd4xcYLw3nB/xyzAEl3lcxHF1IrhA0+QO6bMSUHHYl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+/ieewXI4l0WLTV5DXK4yA4VO+0E71CAO5ikKxr4zZUA3WmYsJPvudp+NZgs5ekOejVtUknX9KNQv5qGNggKNAkyy5kOmx3p7NGtyQvICGCFoXUu8FXI5lsbPZN+5tkOuP61E81r/d44P3N/po2OI5OYeI5XMo3Lulic0G/LZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+FEqLfU; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afe2f6cecdso994542137.1;
        Thu, 09 Jan 2025 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435370; x=1737040170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCPUh3IUWcLS4g8ZtG6u3bDbqVNKgPDzo14k9ivGOUE=;
        b=j+FEqLfUTEZp4dmfmJhkapPfU7FlhaAZul+uw5c3m1cI3/Gj1RmNaYveEfQ7lm4atj
         VolFj20yT0NMt9TK7fsIN0cPXtQQ2mUR4O9n8/e36pXZaDqc6lseimdg4yn1s3xyilmz
         0NjYC+sTMpNmWQ7z2LPeaiNQQCSvsNU/3oxZoUQpt7WMFS3xztF2YHM1lgDPo32Js5gx
         BSeVyCa7maiVLUp3S0sQ/KQqInlVd3WKUc7YaQlONNfrTbYo5OG25rx8cZixwtkw1Czq
         nv7MnnpJhbigOXHLzzzl0om3rW/Gzh7lebkOapDtsNdaofwtgLcwqBcfFDaQRPHq9diI
         5oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435370; x=1737040170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCPUh3IUWcLS4g8ZtG6u3bDbqVNKgPDzo14k9ivGOUE=;
        b=C3t5m2wXZ3+P7GZggRmmbiAbKltUsihDODkMgDuXyZqUmqmrRqd9Syq3RBleuVOT2G
         VJYsmf7feb7qiXHJ24AgDoL9zLSz3tWKoo0DiVThAGu1XVLhSKkcm4GPfssCUzcuQ0BT
         cxF97V3y23x566cGQGrqE0GLaCjLwYpzZpNYdaIJL3FIVhAYSW9oUS+liDQ620Sd18+3
         1rUkhhTGM8qhTASo1CLp1lXP39JVBToV0CHEBFsdX69pPBz4blXH3L2K0AD+LacJ+8MY
         /AUsnofzBMaN9YpeAWVmUkUzVFLmarA9YxboN26X1tI7D+dtZ5/nFRuUeiEzxxu8OiZg
         /U6w==
X-Forwarded-Encrypted: i=1; AJvYcCVuD7lT1pfmSJokG9814qc5aqN4Up8Q67S0ruMjig1r+TLz+iDhTXM1dB4DkuEzjzZ/oTWY4Vx8Vwje@vger.kernel.org, AJvYcCXaGA8ByuaGGLHN4j3aXZrG/+FPgNumDz/2IDtx0CW0L9UCG/cMoWAMgQTj2lFMjp3zx8JOlynAKo9Ko65S@vger.kernel.org
X-Gm-Message-State: AOJu0YxswBSc43+/DUbx+IetGz7eY9J1WLhNQN5UEdxX9f3MZ4ic4xfI
	OMP8QjLZgpjYttDzW77zyvs7D7gzG8TeKsFY47qxtHfpCa2ELLIjr/G4SBOM
X-Gm-Gg: ASbGncv94ZIEmb0b4Ezj8LyJIN5Q7SNIsiwN2hltdUCLwlKYFh2S3agY00zlAV0tzse
	teBUuVKEPaO/Qjw4rRx5Wly39IcqJ1qq4WHuVm4CinhHdwmlb6r0PXiSohN36JU/+n+BvaKZ/ni
	DOxHYzRDcoASYQzH++RFVF5mkCwSXkAFWbixPfUGbwGk/qh6eCUfYcFyCONscwqkJOzMD6rHVZP
	mTmAEcTqq7nl1voAymhuLpbJgdqN5CDYK6hichkfZZWYGdDvamtzGX88vH/JIz9
X-Google-Smtp-Source: AGHT+IElwwsp4NqbvFdkiIUnAd+c3k1JAKYhoPpPzIupjHSpN5n+crDibgLtTHnzuH71WFxJFnotuw==
X-Received: by 2002:a05:6102:3c92:b0:4af:ed5a:b68d with SMTP id ada2fe7eead31-4b6092b35f5mr2035296137.6.1736435369783;
        Thu, 09 Jan 2025 07:09:29 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:28 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Joshua Grisham <josh@joshuagrisham.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 16/18] ACPI: platform_profile: Move platform_profile_handler
Date: Thu,  9 Jan 2025 10:06:29 -0500
Message-ID: <20250109150731.110799-17-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109150731.110799-1-kuurtb@gmail.com>
References: <20250109150731.110799-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_profile_handler is now an internal structure. Move it to
platform_profile.c.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  |  9 +++++++++
 include/linux/platform_profile.h | 11 -----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 8d034d928e32..c7a867bd01df 100644
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
index 0824a12b9998..2c99aff7cd19 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,23 +28,12 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-struct platform_profile_handler;
-
 struct platform_profile_ops {
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
 	int (*choices)(void *drvdata, unsigned long *choices);
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


