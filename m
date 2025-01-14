Return-Path: <linux-acpi+bounces-10603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541CA10B03
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D111882E30
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A61B4F3D;
	Tue, 14 Jan 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu0gf5+j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7511B2180;
	Tue, 14 Jan 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869096; cv=none; b=t1CSluiIduNksJwROwG9inTuoZmcIApqs9eQkSo9ma4nmt/Ysgtc4GNet+vXv8m2zFwFnahsK+5NFz0HpOBbdD27CYMUSMeOzk/chYKwQ1z3d7HkwflwOaBD86+Am0wuTexNmFXFbOE6mtQSUxF9n801C2WNE1seyAE5VlYflgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869096; c=relaxed/simple;
	bh=r+bsVlyFzFpbHqSj4c9OYq3GkNMBB/wpcgctc9O9CEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4poC+hzu0TERGhr90+zgWBICYcQii8+sIL18mZ1kISyaEVo1yStf2c75r6bph81yoa5juup7o8QutzpONUsl5FSHJFm8UYJib7TJ5jCgwz5zziqwHaiNkeRilBx/8n7QxFoxK68lBA3G7sEKO3IDAQTpV2QQYB6g/Q+Yaypau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu0gf5+j; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85c5eb83a7fso2818820241.2;
        Tue, 14 Jan 2025 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869093; x=1737473893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxdIsyQy+fqhcIUx5D1/+V3snqo0VYYQ5aEbJ1vjIu0=;
        b=fu0gf5+jwSh23lGRghE/Rq4FN51N2BaIpptY8cm4qBYXePRaLevre0RJM+sOTXo/qi
         e8loVYqM1hUyXQmc6kShfVGFgZkNcHNsoYg1aJMMVF9n96B2glfsg56lwbwAbpQJhywC
         zdLWVmhVNarkgdPdtPvdO4OqTF9SL4vT7fo8PZU28Y/F2aEQK5xCaqv34/dnT2+/WJLC
         U687uI7R3QlebytiHbwZWiprEmA5muA70ndDsibS809fmBdBBQ9cHPtKLfxXT6ekV2am
         yf9Iz7oHEX1OuJobtahZ4dbDizoUw24o4KtlIMWYHEhEvL4Gp90V/p7bdLP1RTa/6wfS
         wyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869093; x=1737473893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxdIsyQy+fqhcIUx5D1/+V3snqo0VYYQ5aEbJ1vjIu0=;
        b=W159U+1ltCIyN3OVne7ZeFoJ692wqIkORCqzn0/cbPOHZHyMO/LiLUUjgtYELTOhA+
         ZrLwz01SfjQaTlLogb+uvc7gWdgPoTaNJ5yA4A1dqhCEia2YPPttmiWFvQrMqD4GZeuZ
         CzenVkKg9du2PB2R7TTRIkxlZHx10afrWd8gUfx54twhtrDZgvv+y9EDBxod7pxN25+n
         qzZwRd/cxhMtaZAkunxvGUMZwcxkB48weHQTkvIliHqC7VNR56c+dV2vxU4QfGLg2zaL
         vOtG0soKbWOUJFQXyXF1jBBrcokeFePSuhr2AfmQunaEBe6CExx51UtrMlJiEXbd7/DL
         oJHw==
X-Forwarded-Encrypted: i=1; AJvYcCULWsjRv1/jQy2ZzDc9FgpLEh9R6jfA8DHWVTxhi4yu0PIEOeK02foLCwlUirhXg4O6QvJJ6gfg57PdD/4I@vger.kernel.org, AJvYcCX9nmOLvz1+onoO66GXwgsu+xaL135+1dUD3sVvxTGWX4l6kxARoRiak9/s+GPkUpspTY2WwY6uM5yt@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPUzQI6aUYIYAIQbMO6ms6QehAgNs+ZFGGK0fsCr7y+TLWsyN
	/O11uYZqOr56JYPgXc20OgLX496HXFuo25fBl9W2r3KGD4KLRyKTwGq96w==
X-Gm-Gg: ASbGncs45ugjMr3nUSYubU53MtSxWq75suNQkG5JBS4ThVXFx6CRPdLrkGKKZ1elu7k
	Cpz5nSg4Fe+DMhmkQrLF9AGiAQBH8Z7VrZmMNN2HGKK4he/Y+qIFd0ImvsOoxf7WiRXa5/UUZIv
	RdTtUwDeJtvl41H2n2fgBa4qYYQUiCTUCIL0LRB36lMaMeoTdnFFVCrJx7aR8mwo9oa7kU2AD3S
	gztixTbktt83/2yIuGlxpYoMmmb2DHT7bbTmM/y6ONjkG+ObkF5pIu/ehMFFSoo
X-Google-Smtp-Source: AGHT+IEZdlokqZy+0PbZq4/IY2fHa2O0pDrMWEBQy/0cvoF2is6daIGIXNxBu8lM/2zDKFj+X/tfmg==
X-Received: by 2002:a05:6122:c84:b0:518:9040:6700 with SMTP id 71dfb90a1353d-51c6c32df5emr21071908e0c.11.1736869093067;
        Tue, 14 Jan 2025 07:38:13 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:12 -0800 (PST)
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
Subject: [PATCH v2 02/18] ACPI: platform_profile: Let drivers set drvdata to the class device
Date: Tue, 14 Jan 2025 10:37:10 -0500
Message-ID: <20250114153726.11802-3-kuurtb@gmail.com>
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
index a89f64f13e44..f8741201deea 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -461,7 +461,7 @@ int platform_profile_cycle(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-int platform_profile_register(struct platform_profile_handler *pprof)
+int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
 {
 	int err;
 
@@ -481,6 +481,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	pprof->class_dev.class = &platform_profile_class;
 	pprof->class_dev.parent = pprof->dev;
+	dev_set_drvdata(&pprof->class_dev, drvdata);
 	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
 	err = device_register(&pprof->class_dev);
 	if (err) {
@@ -530,7 +531,7 @@ static void devm_platform_profile_release(struct device *dev, void *res)
 	platform_profile_remove(*pprof);
 }
 
-int devm_platform_profile_register(struct platform_profile_handler *pprof)
+int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
 {
 	struct platform_profile_handler **dr;
 	int ret;
@@ -539,7 +540,7 @@ int devm_platform_profile_register(struct platform_profile_handler *pprof)
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
index 57d6b680f5b9..4594beb4b9d7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1939,7 +1939,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		set_bit(PLATFORM_PROFILE_LOW_POWER,
 			platform_profile_handler.choices);
 
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
index fdeebab96fc0..0c68635a0aa3 100644
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
index b4b43f3e3fd9..28c39e25228e 100644
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
index 22f871e9f53c..fe37c26891d8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10640,7 +10640,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
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
2.47.1


