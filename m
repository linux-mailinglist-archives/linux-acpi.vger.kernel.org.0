Return-Path: <linux-acpi+bounces-10702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767DA12FC3
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334AC163638
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A64502B;
	Thu, 16 Jan 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPQP7EkS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6C3F9FB;
	Thu, 16 Jan 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987282; cv=none; b=i2nF/ha8+4v0u12Dyji6pN1VBZbPr8zYCA3W+hATswszRf2mdW0lc2j8qZCdgVplyT5jrFmsmTvjpG7vwHOVfF0e3+bpeJtyWq89e+1WizH1akRkGNXhCgdjuIWkxgKrHQRNbMYEysTxJ05pLEse4ydKk3ZTmqX5jeYYYpHXpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987282; c=relaxed/simple;
	bh=iE3N2ksfRMs4Es8ACXPbNZbQMOriUIrtlhn0+9UeoHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llnFB8YdAReMgjsWRJ+y5lzrTMlRGTXRyjQy5SXzGEQ7S7H9tYpU/68R7LhNQGqH2NITkm1X782tGdpt5fvVAud3BV5PmDNSNvTt64+aHFUPA7GWseTy7V5+CzjCoD53Pki6Yduc3vS8H3euTGgntDd2/Pg8uBB2cQX9jLW63Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPQP7EkS; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso531433276.2;
        Wed, 15 Jan 2025 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987278; x=1737592078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSLOPh6k78erNKS43gH5D7zw00ZieCRwCaLe/FNZ+qM=;
        b=BPQP7EkS6TIiRRquVJD8taQpxWHXusys1lW/QFNXd2uY4y0LoiE93j/RGYd5yhuDxN
         l3u1bmjVK61mkd4+U8lvU3QSlZGVP/m0sd8bMo7OxtnbnbeNUuOuamF1cDdHL4GNC/QF
         T+/rcz4mqdqErY4fFHaVIhuLROMtwANsh/JJ2DoyHQgyS9ARF07rRJmTc3/n55d7Mk+g
         cRFTpzVLI/Vh8wkIEb9mV9TcjsykBVK/upSWDP0QE2NwtwAl2Jvd4LEmot4dHK1YJWMP
         JedfZtQHdemGBPfJkFNn3a1QmOpkBbrkwA/Mw196ZbVrmUCQzOK/IxrIqj+qg6FGXEYX
         nKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987278; x=1737592078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSLOPh6k78erNKS43gH5D7zw00ZieCRwCaLe/FNZ+qM=;
        b=kVmDi/U05J1WkNhmPRVwvZp4AsFkl1JcZBI/2SNkZDYog3EOHK+aRgv6FgRxxGtnNR
         XRDmQq/5mqduqUczG85fqj/JFnwegc5OXF+rcQo3gEKmTjQu6U5aVFTPpVCFOTKyJQDQ
         vU2AZdPAJMCpIlVfGa3Znjx6wqrYFnhS0MG3urfNwtkG9T7jR8V2CjGrwL9HTuxWFfZD
         +i0W6Lg/WAOmbnZeFLYkDhCaes3Pw5Lw62QejXcSU7l3c2wPA1qqn5+OH74UKI+ecmCh
         D76d1dtTVK1L3GV42+tHtOC1ejazYZWx0NfMVqpSg8pStlb/Iym99fIDO81SsMlsFTtY
         Uj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVuLN2EJ+mUSxcXC/4s7uH/Nzwko+j5JXPMy68AmKZafPOzDiSpCC+4yLCN61+aeKpyfaWQD2y7TElb@vger.kernel.org, AJvYcCW0KL9hoiHRqC55JksYNfK1bfgY/UJeLtfT9jTag0mMkU5+IKU9jonk+wg9jFFNNNqxj2ceRSbA1m7gmit+@vger.kernel.org
X-Gm-Message-State: AOJu0YxVD+db6LVguwGbJQ9EdBSfXG6ymjDWFI8IJOBQhn9oR511MMi1
	Tr8iPM97zFEaysDM3wbFsaH2+pO0dnlvgtwYpuNkthzl7mDcDVwQnCP+Ow==
X-Gm-Gg: ASbGncvELFtIizOM21/77nZALkSfaoOd+k0KfIUqcx3g9uAv43TAqW7XDFVOUqJzo0X
	lNpIsC2bMbVJQM3kE/3DVk8Lz9hOAvKqpV/BP0Noc9wAT2IwymANI2Kxx1uKdq6GlLiIElWd1ai
	Xugf1i/KBHcsbr2puWu9zx5I1/r7uirmH+BhbXNUtFEXapvgq77uNfXE3ujNacqEc+LBFVNR3Ra
	orqWqCjHvbbQu1uGseb4qysQRb3o4MG7CGSUP8iqb3r4imC5iBQZAG+wlG6K1kl
X-Google-Smtp-Source: AGHT+IFIoDXEH31LNfZWVcnk8OshU8BiPsAwabS9yPIsuTm+FZXBflf4Nh5CL/pxF7s6KXRS8kBYkg==
X-Received: by 2002:a05:690c:b04:b0:6f6:cdfd:7e2c with SMTP id 00721157ae682-6f6cdfd8107mr37249277b3.15.1736987278239;
        Wed, 15 Jan 2025 16:27:58 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:57 -0800 (PST)
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
Subject: [PATCH v4 05/19] ACPI: platform_profile: Add `probe` to platform_profile_ops
Date: Wed, 15 Jan 2025 19:27:07 -0500
Message-ID: <20250116002721.75592-6-kuurtb@gmail.com>
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

Add a `probe` callback to platform_profile_ops, which lets drivers
initialize the choices member manually.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               | 15 +++-
 .../surface/surface_platform_profile.c        | 16 ++--
 drivers/platform/x86/acer-wmi.c               | 88 ++++++++++---------
 drivers/platform/x86/amd/pmf/sps.c            | 15 ++--
 drivers/platform/x86/asus-wmi.c               | 16 ++--
 drivers/platform/x86/dell/alienware-wmi.c     | 24 +++--
 drivers/platform/x86/dell/dell-pc.c           | 26 +++---
 drivers/platform/x86/hp/hp-wmi.c              | 29 ++++--
 drivers/platform/x86/ideapad-laptop.c         | 15 ++--
 .../platform/x86/inspur_platform_profile.c    | 14 ++-
 drivers/platform/x86/thinkpad_acpi.c          | 15 ++--
 include/linux/platform_profile.h              |  1 +
 12 files changed, 172 insertions(+), 102 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 161a05d57b0f..120f8402facd 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -465,12 +465,23 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
 	int err;
 
 	/* Sanity check the profile handler */
-	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
+	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
+	    !pprof->ops->probe) {
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
 
+	err = pprof->ops->probe(drvdata, pprof->choices);
+	if (err) {
+		dev_err(pprof->dev, "platform_profile probe failed\n");
+		return err;
+	}
+
+	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
+		dev_err(pprof->dev, "Failed to register a platform_profile class device with empty choices\n");
+		return -EINVAL;
+	}
+
 	guard(mutex)(&profile_lock);
 
 	/* create class interface for individual handler */
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 76967bfeeef8..48cfe9cb89c8 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -201,7 +201,18 @@ static int ssam_platform_profile_set(struct device *dev,
 	return tp;
 }
 
+static int ssam_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops ssam_platform_profile_ops = {
+	.probe = ssam_platform_profile_probe,
 	.profile_get = ssam_platform_profile_get,
 	.profile_set = ssam_platform_profile_set,
 };
@@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
-
 	return platform_profile_register(&tpd->handler, tpd);
 }
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 63e6bd1fe339..4d62a61cb241 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2019,7 +2019,53 @@ acer_predator_v4_platform_profile_set(struct device *dev,
 	return 0;
 }
 
+static int
+acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	unsigned long supported_profiles;
+	int err;
+
+	err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
+					   (u8 *)&supported_profiles);
+	if (err)
+		return err;
+
+	/* Iterate through supported profiles in order of increasing performance */
+	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_ECO, &supported_profiles)) {
+		set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+		acer_predator_v4_max_perf =
+			ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
+	}
+
+	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET, &supported_profiles)) {
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
+		acer_predator_v4_max_perf =
+			ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
+	}
+
+	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED, &supported_profiles)) {
+		set_bit(PLATFORM_PROFILE_BALANCED, choices);
+		acer_predator_v4_max_perf =
+			ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
+	}
+
+	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE, &supported_profiles)) {
+		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+		acer_predator_v4_max_perf =
+			ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE;
+	}
+
+	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO, &supported_profiles)) {
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+		acer_predator_v4_max_perf =
+			ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
+	}
+
+	return 0;
+}
+
 static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
+	.probe = acer_predator_v4_platform_profile_probe,
 	.profile_get = acer_predator_v4_platform_profile_get,
 	.profile_set = acer_predator_v4_platform_profile_set,
 };
@@ -2027,7 +2073,6 @@ static const struct platform_profile_ops acer_predator_v4_platform_profile_ops =
 static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
-		unsigned long supported_profiles;
 		int err;
 
 		platform_profile_handler.name = "acer-wmi";
@@ -2035,47 +2080,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
-						   (u8 *)&supported_profiles);
-		if (err)
-			return err;
-
-		/* Iterate through supported profiles in order of increasing performance */
-		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_ECO, &supported_profiles)) {
-			set_bit(PLATFORM_PROFILE_LOW_POWER,
-				platform_profile_handler.choices);
-			acer_predator_v4_max_perf =
-				ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
-		}
-
-		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET, &supported_profiles)) {
-			set_bit(PLATFORM_PROFILE_QUIET,
-				platform_profile_handler.choices);
-			acer_predator_v4_max_perf =
-				ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
-		}
-
-		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED, &supported_profiles)) {
-			set_bit(PLATFORM_PROFILE_BALANCED,
-				platform_profile_handler.choices);
-			acer_predator_v4_max_perf =
-				ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
-		}
-
-		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE, &supported_profiles)) {
-			set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
-				platform_profile_handler.choices);
-			acer_predator_v4_max_perf =
-				ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE;
-		}
-
-		if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO, &supported_profiles)) {
-			set_bit(PLATFORM_PROFILE_PERFORMANCE,
-				platform_profile_handler.choices);
-			acer_predator_v4_max_perf =
-				ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
-		}
-
 		err = platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 6ae82ae86d22..e710405b581f 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -387,7 +387,17 @@ static int amd_pmf_profile_set(struct device *dev,
 	return 0;
 }
 
+static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops amd_pmf_profile_ops = {
+	.probe = amd_pmf_profile_probe,
 	.profile_get = amd_pmf_profile_get,
 	.profile_set = amd_pmf_profile_set,
 };
@@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	dev->pprof.dev = dev->dev;
 	dev->pprof.ops = &amd_pmf_profile_ops;
 
-	/* Setup supported modes */
-	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
-
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dev->pprof, dev);
 	if (err)
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 992956c89d38..e775ec7371ce 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3852,7 +3852,17 @@ static int asus_wmi_platform_profile_set(struct device *dev,
 	return throttle_thermal_policy_write(asus);
 }
 
+static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
+	.probe = asus_wmi_platform_profile_probe,
 	.profile_get = asus_wmi_platform_profile_get,
 	.profile_set = asus_wmi_platform_profile_set,
 };
@@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED,
-		asus->platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE,
-		asus->platform_profile_handler.choices);
-
 	err = platform_profile_register(&asus->platform_profile_handler, asus);
 	if (err == -EEXIST) {
 		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index b8359b177a0f..e7209863e7dc 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1078,12 +1078,7 @@ static int thermal_profile_set(struct device *dev,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static const struct platform_profile_ops awcc_platform_profile_ops = {
-	.profile_get = thermal_profile_get,
-	.profile_set = thermal_profile_set,
-};
-
-static int create_thermal_profile(struct platform_device *platform_device)
+static int thermal_profile_probe(void *drvdata, unsigned long *choices)
 {
 	enum platform_profile_option profile;
 	enum wmax_thermal_mode mode;
@@ -1116,19 +1111,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
 		profile = wmax_mode_to_platform_profile[mode];
 		supported_thermal_profiles[profile] = out_data;
 
-		set_bit(profile, pp_handler.choices);
+		set_bit(profile, choices);
 	}
 
-	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
+	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
 		return -ENODEV;
 
 	if (quirks->gmode) {
 		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			WMAX_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
+	return 0;
+}
+
+static const struct platform_profile_ops awcc_platform_profile_ops = {
+	.probe = thermal_profile_probe,
+	.profile_get = thermal_profile_get,
+	.profile_set = thermal_profile_set,
+};
+
+static int create_thermal_profile(struct platform_device *platform_device)
+{
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
 	pp_handler.ops = &awcc_platform_profile_ops;
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 9010a231f209..32b3be0723f8 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -24,6 +24,7 @@
 #include "dell-smbios.h"
 
 static struct platform_device *platform_device;
+static int supported_modes;
 
 static const struct dmi_system_id dell_device_table[] __initconst = {
 	{
@@ -231,7 +232,22 @@ static int thermal_platform_profile_get(struct device *dev,
 	return 0;
 }
 
+static int thermal_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	if (supported_modes & DELL_QUIET)
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
+	if (supported_modes & DELL_COOL_BOTTOM)
+		set_bit(PLATFORM_PROFILE_COOL, choices);
+	if (supported_modes & DELL_BALANCED)
+		set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	if (supported_modes & DELL_PERFORMANCE)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops dell_pc_platform_profile_ops = {
+	.probe = thermal_platform_profile_probe,
 	.profile_get = thermal_platform_profile_get,
 	.profile_set = thermal_platform_profile_set,
 };
@@ -239,7 +255,6 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
 static int thermal_init(void)
 {
 	int ret;
-	int supported_modes;
 
 	/* If thermal commands are not supported, exit without error */
 	if (!dell_smbios_class_is_supported(CLASS_INFO))
@@ -265,15 +280,6 @@ static int thermal_init(void)
 	thermal_handler->dev = &platform_device->dev;
 	thermal_handler->ops = &dell_pc_platform_profile_ops;
 
-	if (supported_modes & DELL_QUIET)
-		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
-	if (supported_modes & DELL_COOL_BOTTOM)
-		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
-	if (supported_modes & DELL_BALANCED)
-		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
-	if (supported_modes & DELL_PERFORMANCE)
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
-
 	/* Clean up if failed */
 	ret = platform_profile_register(thermal_handler, NULL);
 	if (ret)
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 60328b35be74..75bcd8460e7c 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct device *dev,
 	return 0;
 }
 
+static int hp_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	if (is_omen_thermal_profile()) {
+		set_bit(PLATFORM_PROFILE_COOL, choices);
+	} else if (is_victus_thermal_profile()) {
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
+	} else {
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
+		set_bit(PLATFORM_PROFILE_COOL, choices);
+	}
+
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static int omen_powersource_event(struct notifier_block *nb,
 				  unsigned long value,
 				  void *data)
@@ -1566,16 +1583,19 @@ static inline void omen_unregister_powersource_event_handler(void)
 }
 
 static const struct platform_profile_ops platform_profile_omen_ops = {
+	.probe = hp_wmi_platform_profile_probe,
 	.profile_get = platform_profile_omen_get,
 	.profile_set = platform_profile_omen_set,
 };
 
 static const struct platform_profile_ops platform_profile_victus_ops = {
+	.probe = hp_wmi_platform_profile_probe,
 	.profile_get = platform_profile_victus_get,
 	.profile_set = platform_profile_victus_set,
 };
 
 static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
+	.probe = hp_wmi_platform_profile_probe,
 	.profile_get = hp_wmi_platform_profile_get,
 	.profile_set = hp_wmi_platform_profile_set,
 };
@@ -1598,8 +1618,6 @@ static int thermal_profile_setup(struct platform_device *device)
 			return err;
 
 		platform_profile_handler.ops = &platform_profile_omen_ops;
-
-		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	} else if (is_victus_thermal_profile()) {
 		err = platform_profile_victus_get_ec(&active_platform_profile);
 		if (err < 0)
@@ -1614,8 +1632,6 @@ static int thermal_profile_setup(struct platform_device *device)
 			return err;
 
 		platform_profile_handler.ops = &platform_profile_victus_ops;
-
-		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	} else {
 		tp = thermal_profile_get();
 
@@ -1631,15 +1647,10 @@ static int thermal_profile_setup(struct platform_device *device)
 			return err;
 
 		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
-
-		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
-		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
 	platform_profile_handler.name = "hp-wmi";
 	platform_profile_handler.dev = &device->dev;
-	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
 	err = platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 96e99513b0b5..050919a28d2b 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct device *dev,
 	return -EINTR;
 }
 
+static int dytc_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static void dytc_profile_refresh(struct ideapad_private *priv)
 {
 	enum platform_profile_option profile;
@@ -1064,6 +1073,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
 };
 
 static const struct platform_profile_ops dytc_profile_ops = {
+	.probe = dytc_profile_probe,
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
@@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.ops = &dytc_profile_ops;
 
-	/* Setup supported modes */
-	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
-
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
 	if (err)
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index d0a8e4eebffa..06df3aae9a56 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -164,7 +164,17 @@ static int inspur_platform_profile_get(struct device *dev,
 	return 0;
 }
 
+static int inspur_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops inspur_platform_profile_ops = {
+	.probe = inspur_platform_profile_probe,
 	.profile_get = inspur_platform_profile_get,
 	.profile_set = inspur_platform_profile_set,
 };
@@ -184,10 +194,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->handler.dev = &wdev->dev;
 	priv->handler.ops = &inspur_platform_profile_ops;
 
-	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
-
 	return platform_profile_register(&priv->handler, priv);
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9e26f5670fc7..62b2ddfe7c0a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10539,7 +10539,17 @@ static int dytc_profile_set(struct device *dev,
 	return err;
 }
 
+static int dytc_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops dytc_profile_ops = {
+	.probe = dytc_profile_probe,
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
@@ -10585,11 +10595,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 {
 	int err, output;
 
-	/* Setup supported modes */
-	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
-
 	err = dytc_command(DYTC_CMD_QUERY, &output);
 	if (err)
 		return err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6013c05d7b86..5ad1ab7b75e4 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -31,6 +31,7 @@ enum platform_profile_option {
 struct platform_profile_handler;
 
 struct platform_profile_ops {
+	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
 };
-- 
2.48.1


