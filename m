Return-Path: <linux-acpi+bounces-10652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5CA11A8A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F047A1940
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1172234964;
	Wed, 15 Jan 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4oepZOZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000422FE15;
	Wed, 15 Jan 2025 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925106; cv=none; b=SAy0xFDddr5pLiEm7OugozAqPK7z0TsKFxPvAL1iq4n2N9V077HTDqyJns5dcxa6CMLq7yzR9E5pzNFpKfkSeCEFg0youRpmi55xunCaIaqgyd+MrC6KiBgydTbcqAXx7WAlqFSoTtyG/qfsDJc/7vtYMt8NRn6C1cdh+0H/CAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925106; c=relaxed/simple;
	bh=XEz9oJAUBT2RwLxUnHLdSRU8aJjoAvp9C2HU2zGLkJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r81paWNUOlCqFRxh+kGsfUqokw/KLKcMNwmC/RAVdhsI9E31CyerwIdPWa3hcouT43ZD7/7jvNbljIZgMMYo/uKRCtHuXrW1iLHxf53P8tsVqwP0B6RI5Z1+VuhKk9pD/GSQ/xOetm3HbuwyQmViptzZOtLNIwTvSGTRSW68brA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4oepZOZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85c436db302so291688241.0;
        Tue, 14 Jan 2025 23:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925103; x=1737529903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e49qYcPnDENsUUC2orJ2fqi6GUiaqPE5ESOJS7IvRv0=;
        b=f4oepZOZi7cnlTtRBjTqMnbaAqpALTLXkNFmeJOAs7WpVQxHizcMDCvH/8Dai0SWvH
         nVsfkssEJIDsilmT12JInxsAOpQpfrOEHgilfbPj5jOE5rMSoQuLrYfPQdvqhJsVl1rc
         cRboQwDJK47vD5uMBVAf6ZT0NrYVYydPaKheDYDxpKvRnhen0b+MMdDLZ516+FiLapcf
         uKS85AF/xDwGXeuBCAcl03UeqO2XJJKgPgzHLUeCnhWpisb1+Dp4RxtFzTZQNq9346lY
         wj6KpLpdqhNU+tp1X/NB5z4zoMcmjH1sL01UcXn8kDRfpa21RvbPtEnRzHBhZW3/sMEN
         fe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925103; x=1737529903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e49qYcPnDENsUUC2orJ2fqi6GUiaqPE5ESOJS7IvRv0=;
        b=VS6LjQcSDz4MjGHIm9JBOg0suznRi3NOI4lcGsesI/JDn0+14oQ9MrqRMeVKovpO/M
         gnlxgNWVLERXLAv3zwEmNI+7vjc2lMzBcyZpFayjbAnbkkVKikSybebaUZbtxxyciNdE
         6wS0ZLRGMp5yBwv1pz2UnLl4Sfpal8j5HvPfagL92j1TDL7on50Vexdx42r5s8t2q8ET
         F+lwvAbAatK0CzAM0h3ukyazGDeZ1lS7AhjEImqhMhTr2Wi7ewrgJH1JyM6mXEQpl2IQ
         rApkR7kmRVjeirmkUbGlbwUtm3r3CCOIaGrWcNO55QW13F3+gVblmoIomH7/8d4ezWoX
         Xaqg==
X-Forwarded-Encrypted: i=1; AJvYcCV289xybPscgnFanDhtsi3ykG7Iy17y8qXDJgSAq1AT7Y8HYyxYuhw2WiowVr06dhcXMyvyVsqvx1mX@vger.kernel.org, AJvYcCVM/cBg8rIW0TXvbY3FPyCOCQ+wBV/HcA+V0cBt7rhkzI1u8T37q4Ih5VKu8phuhW2cvTuVgso6NkhU4KEI@vger.kernel.org
X-Gm-Message-State: AOJu0YxekA81UXhsUK1AzRW536FrhyKVx2wYvfbp49+l30lDyAFLVPO1
	gZQXlhRmVRb/2b+K7ThWV896k0sE9ZxNPiW05sHgxqyNAdoFyju41bzRdA==
X-Gm-Gg: ASbGncuGGXMJt0LyhCS6hDm2+rtkhiZ1FBF3NSGA5PWne1i32lldkxN4CfNLNYOhZy7
	FsuxHToiEAj+bG2jp/+SJdmF5rl1U1BMACJcYEELJEoE5XbjoTupY4ZZ53sS4soo8lMLmK+gewQ
	Jz/GB6c4qUoVEdgoTXWbniXR16jty4hq7ickjG8y0TJ2qNvk0WaRKk2KfOLh8KKLsFE7EqyL78r
	USl2ud37m2DZywnxxVA26YxkCAy7KBEtv2+Cwu+GKVrI2KPiLRxGuR1Y5YwXula
X-Google-Smtp-Source: AGHT+IEEdrS3q62CSm0iKBYHybP2NH0M3rXKaBQiKxk0Qm+uq7Lq/BJd0S2S768JFwkCnbwoEAS5/Q==
X-Received: by 2002:a05:6102:41a8:b0:4af:d4f8:caee with SMTP id ada2fe7eead31-4b669ed1c8dmr1325715137.1.1736925102978;
        Tue, 14 Jan 2025 23:11:42 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:11:42 -0800 (PST)
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
Subject: [PATCH v3 04/19] ACPI: platform_profile: Add `ops` member to handlers
Date: Wed, 15 Jan 2025 02:10:07 -0500
Message-ID: <20250115071022.4815-5-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115071022.4815-1-kuurtb@gmail.com>
References: <20250115071022.4815-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace *profile_get and *profile_set members with a general *ops
member.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               |  6 ++---
 .../surface/surface_platform_profile.c        |  8 +++++--
 drivers/platform/x86/acer-wmi.c               | 11 +++++----
 drivers/platform/x86/amd/pmf/sps.c            |  8 +++++--
 drivers/platform/x86/asus-wmi.c               |  8 +++++--
 drivers/platform/x86/dell/alienware-wmi.c     |  8 +++++--
 drivers/platform/x86/dell/dell-pc.c           |  8 +++++--
 drivers/platform/x86/hp/hp-wmi.c              | 24 ++++++++++++++-----
 drivers/platform/x86/ideapad-laptop.c         |  8 +++++--
 .../platform/x86/inspur_platform_profile.c    |  8 +++++--
 drivers/platform/x86/thinkpad_acpi.c          |  8 +++++--
 include/linux/platform_profile.h              | 10 ++++++--
 12 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index bd90aa4e8371..161a05d57b0f 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -65,7 +65,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->profile_set(dev, *bit);
+	return handler->ops->profile_set(dev, *bit);
 }
 
 /**
@@ -102,7 +102,7 @@ static int get_class_profile(struct device *dev,
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	err = handler->profile_get(dev, &val);
+	err = handler->ops->profile_get(dev, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
 		return err;
@@ -466,7 +466,7 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
 
 	/* Sanity check the profile handler */
 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-	    !pprof->profile_set || !pprof->profile_get) {
+	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 26c1230e75df..76967bfeeef8 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -201,6 +201,11 @@ static int ssam_platform_profile_set(struct device *dev,
 	return tp;
 }
 
+static const struct platform_profile_ops ssam_platform_profile_ops = {
+	.profile_get = ssam_platform_profile_get,
+	.profile_set = ssam_platform_profile_set,
+};
+
 static int surface_platform_profile_probe(struct ssam_device *sdev)
 {
 	struct ssam_platform_profile_device *tpd;
@@ -214,8 +219,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.dev = &sdev->dev;
-	tpd->handler.profile_get = ssam_platform_profile_get;
-	tpd->handler.profile_set = ssam_platform_profile_set;
+	tpd->handler.ops = &ssam_platform_profile_ops;
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index d609bd105db3..91ae48adf6cf 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1916,6 +1916,11 @@ acer_predator_v4_platform_profile_set(struct device *dev,
 	return 0;
 }
 
+static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
+	.profile_get = acer_predator_v4_platform_profile_get,
+	.profile_set = acer_predator_v4_platform_profile_set,
+};
+
 static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
@@ -1923,10 +1928,8 @@ static int acer_platform_profile_setup(struct platform_device *device)
 
 		platform_profile_handler.name = "acer-wmi";
 		platform_profile_handler.dev = &device->dev;
-		platform_profile_handler.profile_get =
-			acer_predator_v4_platform_profile_get;
-		platform_profile_handler.profile_set =
-			acer_predator_v4_platform_profile_set;
+		platform_profile_handler.ops =
+			&acer_predator_v4_platform_profile_ops;
 
 		set_bit(PLATFORM_PROFILE_PERFORMANCE,
 			platform_profile_handler.choices);
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index cf2e51f67787..6ae82ae86d22 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -387,6 +387,11 @@ static int amd_pmf_profile_set(struct device *dev,
 	return 0;
 }
 
+static const struct platform_profile_ops amd_pmf_profile_ops = {
+	.profile_get = amd_pmf_profile_get,
+	.profile_set = amd_pmf_profile_set,
+};
+
 int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 {
 	int err;
@@ -407,8 +412,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 	dev->pprof.name = "amd-pmf";
 	dev->pprof.dev = dev->dev;
-	dev->pprof.profile_get = amd_pmf_profile_get;
-	dev->pprof.profile_set = amd_pmf_profile_set;
+	dev->pprof.ops = &amd_pmf_profile_ops;
 
 	/* Setup supported modes */
 	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9bed170abb92..d88860dd028b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3852,6 +3852,11 @@ static int asus_wmi_platform_profile_set(struct device *dev,
 	return throttle_thermal_policy_write(asus);
 }
 
+static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
+	.profile_get = asus_wmi_platform_profile_get,
+	.profile_set = asus_wmi_platform_profile_set,
+};
+
 static int platform_profile_setup(struct asus_wmi *asus)
 {
 	struct device *dev = &asus->platform_device->dev;
@@ -3878,8 +3883,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	asus->platform_profile_handler.name = "asus-wmi";
 	asus->platform_profile_handler.dev = dev;
-	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
-	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
+	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
 	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED,
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index b8131b803368..f7a854d40575 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1078,6 +1078,11 @@ static int thermal_profile_set(struct device *dev,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
+static const struct platform_profile_ops awcc_platform_profile_ops = {
+	.profile_get = thermal_profile_get,
+	.profile_set = thermal_profile_set,
+};
+
 static int create_thermal_profile(struct platform_device *platform_device)
 {
 	enum platform_profile_option profile;
@@ -1124,10 +1129,9 @@ static int create_thermal_profile(struct platform_device *platform_device)
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
 	}
 
-	pp_handler.profile_get = thermal_profile_get;
-	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
+	pp_handler.ops = &awcc_platform_profile_ops;
 
 	return devm_platform_profile_register(&pp_handler, NULL);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index c86b05b5a1cb..9010a231f209 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -231,6 +231,11 @@ static int thermal_platform_profile_get(struct device *dev,
 	return 0;
 }
 
+static const struct platform_profile_ops dell_pc_platform_profile_ops = {
+	.profile_get = thermal_platform_profile_get,
+	.profile_set = thermal_platform_profile_set,
+};
+
 static int thermal_init(void)
 {
 	int ret;
@@ -258,8 +263,7 @@ static int thermal_init(void)
 	}
 	thermal_handler->name = "dell-pc";
 	thermal_handler->dev = &platform_device->dev;
-	thermal_handler->profile_get = thermal_platform_profile_get;
-	thermal_handler->profile_set = thermal_platform_profile_set;
+	thermal_handler->ops = &dell_pc_platform_profile_ops;
 
 	if (supported_modes & DELL_QUIET)
 		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index b8e62dc9cecd..60328b35be74 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1565,6 +1565,21 @@ static inline void omen_unregister_powersource_event_handler(void)
 	unregister_acpi_notifier(&platform_power_source_nb);
 }
 
+static const struct platform_profile_ops platform_profile_omen_ops = {
+	.profile_get = platform_profile_omen_get,
+	.profile_set = platform_profile_omen_set,
+};
+
+static const struct platform_profile_ops platform_profile_victus_ops = {
+	.profile_get = platform_profile_victus_get,
+	.profile_set = platform_profile_victus_set,
+};
+
+static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
+	.profile_get = hp_wmi_platform_profile_get,
+	.profile_set = hp_wmi_platform_profile_set,
+};
+
 static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
@@ -1582,8 +1597,7 @@ static int thermal_profile_setup(struct platform_device *device)
 		if (err < 0)
 			return err;
 
-		platform_profile_handler.profile_get = platform_profile_omen_get;
-		platform_profile_handler.profile_set = platform_profile_omen_set;
+		platform_profile_handler.ops = &platform_profile_omen_ops;
 
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	} else if (is_victus_thermal_profile()) {
@@ -1599,8 +1613,7 @@ static int thermal_profile_setup(struct platform_device *device)
 		if (err < 0)
 			return err;
 
-		platform_profile_handler.profile_get = platform_profile_victus_get;
-		platform_profile_handler.profile_set = platform_profile_victus_set;
+		platform_profile_handler.ops = &platform_profile_victus_ops;
 
 		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	} else {
@@ -1617,8 +1630,7 @@ static int thermal_profile_setup(struct platform_device *device)
 		if (err)
 			return err;
 
-		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
-		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
+		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
 
 		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index fc317f42bb82..96e99513b0b5 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1063,6 +1063,11 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
 	{}
 };
 
+static const struct platform_profile_ops dytc_profile_ops = {
+	.profile_get = dytc_profile_get,
+	.profile_set = dytc_profile_set,
+};
+
 static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 {
 	int err, dytc_version;
@@ -1105,8 +1110,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	priv->dytc->pprof.name = "ideapad-laptop";
 	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
-	priv->dytc->pprof.profile_get = dytc_profile_get;
-	priv->dytc->pprof.profile_set = dytc_profile_set;
+	priv->dytc->pprof.ops = &dytc_profile_ops;
 
 	/* Setup supported modes */
 	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 47d2dbbf3392..d0a8e4eebffa 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -164,6 +164,11 @@ static int inspur_platform_profile_get(struct device *dev,
 	return 0;
 }
 
+static const struct platform_profile_ops inspur_platform_profile_ops = {
+	.profile_get = inspur_platform_profile_get,
+	.profile_set = inspur_platform_profile_set,
+};
+
 static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct inspur_wmi_priv *priv;
@@ -177,8 +182,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 	priv->handler.name = "inspur-wmi";
 	priv->handler.dev = &wdev->dev;
-	priv->handler.profile_get = inspur_platform_profile_get;
-	priv->handler.profile_set = inspur_platform_profile_set;
+	priv->handler.ops = &inspur_platform_profile_ops;
 
 	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 47f87bb213a9..9978fd36a3d1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,12 +10538,16 @@ static int dytc_profile_set(struct device *dev,
 	return err;
 }
 
-static struct platform_profile_handler dytc_profile = {
-	.name = "thinkpad-acpi",
+static const struct platform_profile_ops dytc_profile_ops = {
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
 
+static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
+	.ops = &dytc_profile_ops,
+};
+
 static void dytc_profile_refresh(void)
 {
 	enum platform_profile_option profile;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 5296d886c243..6013c05d7b86 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,14 +28,20 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
+struct platform_profile_handler;
+
+struct platform_profile_ops {
+	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
+	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
+};
+
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
 	struct device class_dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
-	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
+	const struct platform_profile_ops *ops;
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
-- 
2.48.0


