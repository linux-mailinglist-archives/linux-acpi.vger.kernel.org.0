Return-Path: <linux-acpi+bounces-10699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1FA12FBB
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FABC3A63F8
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7396D1CD1F;
	Thu, 16 Jan 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8fc9/Op"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC03208AD;
	Thu, 16 Jan 2025 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987271; cv=none; b=KOrJ1R0sFVsWijzaXoEvJUxAlYnXpgujXPrRh0mKPmOYhwDNOAwF6q0+zR4b6e9IdMcVYIFCK8wut+gifLrAS81JD2ZXibHJ50lWkrkuIoNDo5rqlCePXgrgEi0LFrFEKWpqjjG6l/3f8VPGgmi5coGPw2MiInP55Ye+wIOl6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987271; c=relaxed/simple;
	bh=F+HcE/0p+CKbsDcVTWR2OX7VCGoTadDXZpeSIydZ3y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ6vcnkBjCYyzqFa8Slt9ZHYlfGt4N6LIf1LV8mMhRa70ehJuxfhOw5S3lVEhkHDskZ58kBce5lJlh7VcolaD3oSDYdy22gD7XBYINoSi/tF4sTE+Bv5ZO9FKkPIeXvZqY7kfJ/tLGla7+6Htic0W3r48pfwzi68tW3U4OLRXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8fc9/Op; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4419a47887so617756276.0;
        Wed, 15 Jan 2025 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987268; x=1737592068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6wH2VMUqHiPLE+uONX9vuz+cOLoy/9tEInPoy3izOU=;
        b=M8fc9/OpAzZuSIgVNjBNon3vKY6JpLni//2+L29q/do6M664Y/yGShlT1Dq4rszArN
         2/2dxZkeAgk7mW5yQM3Toqa7rdog5RGPhMIQ+3P1FB8CzgsnrLTe0e/kyVcBYvc2X8uU
         qz6wtaKDaZmvh0UKYqfOA7Gr2abD71FpmdnOFGmNO95NA9oT93eRt747i/CVCVmw/u1G
         j9uFWWOrp/GMvnkO0eonP/jhLHEPPtDYRZWYfteDsrHFc+lFjoY94SEffuZhRC0WFedn
         QeuHZyBToYR3HGRRDaBIgGDillzJe1A1+CnKQd/hvaPpZWuClg4I4ro5RWe5/U8YkoPV
         XewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987268; x=1737592068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6wH2VMUqHiPLE+uONX9vuz+cOLoy/9tEInPoy3izOU=;
        b=umcno7y7JKO/n6/lxetTRp4XqVfA5rwlFuDZ9oeAHwm43n0ZsMl5y9k/dFQPhfjJoO
         BJmnFCh9Yfy+kA/Pr8G4qQeMnZH0VK+jhIQ2zijb7gfPN7IR5yMovTKMSGfPD8OKgAbM
         TCnAyRfd9KyxKf73LULfZAtnoRNIpaW8bDGFKbpbsurt4Dk38sQCtpZw/pe9pHuzAM0g
         B+A+DFSoOzV5mx0TG3T44iOeCRmH2Ud9BtwCe2/YsRzodQZmR+LrPuw1UsPdA2h5g9hB
         FRqeb01aQaufbGaPo+H3jKOqXPBQKyS5ExJsuveF76X1bI6caKEqQsBFMwobK688x4uj
         MXvA==
X-Forwarded-Encrypted: i=1; AJvYcCV4DxpB+S4J0WpCpm2i1rFB8WNeG0vieDE+u/z2IXDMxvqDdF2YosMsGFgBb3tNxWx1UN6GM5tuLan/@vger.kernel.org, AJvYcCViIfoz+F7XxkGZxAZNfYhHSQnt7xkqCJsPDGtyZlmui/y6WFn9SEtbvS+M1RxUPq9EcZdlSI8W/PlYYuM/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PbhmjmCgPIq18ArMXoxvTT+yeMycNfnOEZBMTk20wgIeYDFT
	Kw2O8g2wSlEgB8ArlXr26Zy0V2p49UXykXueSHuMtfWYTlZ7PZwI72KB6g==
X-Gm-Gg: ASbGncvSdqav9ZhGpegXtAbCcKCOcnN4w2Tf6/U9Pmuyf+zDiZyBKyNzUkxb3gNdCe5
	A8TbONMUezLn2Ps4BR+S8TqP7qqpOPELlyRMF+ga57CfGS3HIIyR7P83l5fDsIo083OAwCBAnT2
	d01LOt7LIMCODI6fsnWpno0IeYzIjnfZzZFGEML3SQmU+I/8vktAX/7/OSCQRpr5djjtYVWa2sQ
	cv+VhF8NgYjF2vn5V7yuLTyNdFqT77xx3mf8Sg8j0Hud4JebYMkaEzP/E4DvMF6
X-Google-Smtp-Source: AGHT+IETg/BwY+aZAFd3WmHt1zEfaced2n/Pz3ys7wrt3luRNZmZKBQ/vQpKaaV1dr417rxAoNCLcg==
X-Received: by 2002:a05:690c:d96:b0:6ef:a4bc:8b9f with SMTP id 00721157ae682-6f531236c89mr266209527b3.19.1736987267722;
        Wed, 15 Jan 2025 16:27:47 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:47 -0800 (PST)
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
Subject: [PATCH v4 02/19] ACPI: platform_profile: Let drivers set drvdata to the class device
Date: Wed, 15 Jan 2025 19:27:04 -0500
Message-ID: <20250116002721.75592-3-kuurtb@gmail.com>
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

Add *drvdata to platform_profile_register() signature and assign it to
the class device.

While at it, pass specific driver state as drvdata to replace uses of
container_of() with dev_get_drvdata().

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c                     | 7 ++++---
 drivers/platform/surface/surface_platform_profile.c | 6 +++---
 drivers/platform/x86/acer-wmi.c                     | 2 +-
 drivers/platform/x86/amd/pmf/sps.c                  | 6 +++---
 drivers/platform/x86/asus-wmi.c                     | 6 +++---
 drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 6 +++---
 drivers/platform/x86/inspur_platform_profile.c      | 8 +++-----
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 4 ++--
 12 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 15f24adc57d4..689541d2e66c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -460,7 +460,7 @@ int platform_profile_cycle(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-int platform_profile_register(struct platform_profile_handler *pprof)
+int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
 {
 	int err;
 
@@ -480,6 +480,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	pprof->class_dev.class = &platform_profile_class;
 	pprof->class_dev.parent = pprof->dev;
+	dev_set_drvdata(&pprof->class_dev, drvdata);
 	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
 	err = device_register(&pprof->class_dev);
 	if (err) {
@@ -529,7 +530,7 @@ static void devm_platform_profile_release(struct device *dev, void *res)
 	platform_profile_remove(*pprof);
 }
 
-int devm_platform_profile_register(struct platform_profile_handler *pprof)
+int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
 {
 	struct platform_profile_handler **dr;
 	int ret;
@@ -538,7 +539,7 @@ int devm_platform_profile_register(struct platform_profile_handler *pprof)
 	if (!dr)
 		return -ENOMEM;
 
-	ret = platform_profile_register(pprof);
+	ret = platform_profile_register(pprof, drvdata);
 	if (ret) {
 		devres_free(dr);
 		return ret;
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 6c87e982bfc8..edb9362003a4 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -161,7 +161,7 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
 	enum ssam_tmp_profile tp;
 	int status;
 
-	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
+	tpd = dev_get_drvdata(&pprof->class_dev);
 
 	status = ssam_tmp_profile_get(tpd->sdev, &tp);
 	if (status)
@@ -181,7 +181,7 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
 	struct ssam_platform_profile_device *tpd;
 	int tp;
 
-	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
+	tpd = dev_get_drvdata(&pprof->class_dev);
 
 	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
 	if (tp < 0)
@@ -224,7 +224,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
 
-	return platform_profile_register(&tpd->handler);
+	return platform_profile_register(&tpd->handler, tpd);
 }
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index acf610d59168..1aedf0ef4189 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2073,7 +2073,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 				ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
 		}
 
-		err = platform_profile_register(&platform_profile_handler);
+		err = platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
 
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index bd2bd6cfc39a..259a598acd3e 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -285,7 +285,7 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
 static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
 			       enum platform_profile_option *profile)
 {
-	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
+	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
 
 	*profile = pmf->current_profile;
 	return 0;
@@ -366,7 +366,7 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 			       enum platform_profile_option profile)
 {
-	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
+	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
 	int ret = 0;
 
 	pmf->current_profile = profile;
@@ -416,7 +416,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dev->pprof);
+	err = platform_profile_register(&dev->pprof, dev);
 	if (err)
 		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
 			err);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 6c674de60ec0..f91099792cb9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3806,7 +3806,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	struct asus_wmi *asus;
 	int tp;
 
-	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+	asus = dev_get_drvdata(&pprof->class_dev);
 	tp = asus->throttle_thermal_policy_mode;
 
 	switch (tp) {
@@ -3832,7 +3832,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	struct asus_wmi *asus;
 	int tp;
 
-	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+	asus = dev_get_drvdata(&pprof->class_dev);
 
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
@@ -3887,7 +3887,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	set_bit(PLATFORM_PROFILE_PERFORMANCE,
 		asus->platform_profile_handler.choices);
 
-	err = platform_profile_register(&asus->platform_profile_handler);
+	err = platform_profile_register(&asus->platform_profile_handler, asus);
 	if (err == -EEXIST) {
 		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
 		return 0;
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index d7f577e0d146..154c417a438c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1129,7 +1129,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
 
-	return devm_platform_profile_register(&pp_handler);
+	return devm_platform_profile_register(&pp_handler, NULL);
 }
 
 /*
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3797a5721dbd..1a0a721d706f 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -271,7 +271,7 @@ static int thermal_init(void)
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
 
 	/* Clean up if failed */
-	ret = platform_profile_register(thermal_handler);
+	ret = platform_profile_register(thermal_handler, NULL);
 	if (ret)
 		goto cleanup_thermal_handler;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 6d6e13a0c6e2..8e5e1422e024 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1629,7 +1629,7 @@ static int thermal_profile_setup(struct platform_device *device)
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
-	err = platform_profile_register(&platform_profile_handler);
+	err = platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index dc98f862a06d..ed0d880a07a9 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -936,7 +936,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
 static int dytc_profile_get(struct platform_profile_handler *pprof,
 			    enum platform_profile_option *profile)
 {
-	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
+	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
 
 	*profile = dytc->current_profile;
 	return 0;
@@ -989,7 +989,7 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
 static int dytc_profile_set(struct platform_profile_handler *pprof,
 			    enum platform_profile_option profile)
 {
-	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
+	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
 	struct ideapad_private *priv = dytc->priv;
 	unsigned long output;
 	int err;
@@ -1114,7 +1114,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&priv->dytc->pprof);
+	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
 	if (err)
 		goto pp_reg_failed;
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 53af73a7fbf7..471fca50d1c9 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -87,8 +87,7 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
 static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
 				       enum platform_profile_option profile)
 {
-	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
-						    handler);
+	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
 	u8 ret_code[4] = {0, 0, 0, 0};
 	int ret;
 
@@ -135,8 +134,7 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
 static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
 				       enum platform_profile_option *profile)
 {
-	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
-						    handler);
+	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
 	u8 ret_code[4] = {0, 0, 0, 0};
 	int ret;
 
@@ -186,7 +184,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
 
-	return platform_profile_register(&priv->handler);
+	return platform_profile_register(&priv->handler, priv);
 }
 
 static void inspur_wmi_remove(struct wmi_device *wdev)
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d99573e7a983..8be3f4e5366d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10641,7 +10641,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dytc_profile);
+	err = platform_profile_register(&dytc_profile, NULL);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8a9b8754f9ac..1c8fdda51eaa 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -40,9 +40,9 @@ struct platform_profile_handler {
 				enum platform_profile_option profile);
 };
 
-int platform_profile_register(struct platform_profile_handler *pprof);
+int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
 int platform_profile_remove(struct platform_profile_handler *pprof);
-int devm_platform_profile_register(struct platform_profile_handler *pprof);
+int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
 int platform_profile_cycle(void);
 void platform_profile_notify(struct platform_profile_handler *pprof);
 
-- 
2.48.1


