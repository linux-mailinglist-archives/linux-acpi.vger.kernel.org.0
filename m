Return-Path: <linux-acpi+bounces-10701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96FBA12FC0
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2128D7A248A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB732C190;
	Thu, 16 Jan 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGikgaLY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8252C859;
	Thu, 16 Jan 2025 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987278; cv=none; b=u3b8sPFPCBQb7OFB0zuWpGwWU+BeG30UGrW6lFmRTgyGX023hKOPr3cN3y8L/tw2/FCAfBaoRR+w6f7Smtgd2x9l+TuMkjlt314NyIxyvGvu4UsnYiyHTW/nn2HsbosBs5871+SxKel08Nvb5cMw1/WcLxk8WE9p4QFuR+67k7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987278; c=relaxed/simple;
	bh=Pev443RJrWuidmaXv0GXyB/iMTAludiQlwQOeS7lEXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScAavm21PEvLpsAkhCE+c6JDsRq3P5a2yXaZ3jiIfy5VLyCqoiFEajK+wkYhm9Jh9Bll+oblw28MQ09ZaZX7oNNy8s5pjMWrFarUJ2KtodDGOsbPy37UltK4kLA9v9IVGSGfIvDkdJb65HyTuMg3IwyId00Te1sE63IEst+xFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGikgaLY; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e46ebe19368so626923276.0;
        Wed, 15 Jan 2025 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987275; x=1737592075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBlndZsF2CWvhd+gmQFJf+dps8PTdoNsXloRCpz8OmQ=;
        b=AGikgaLYt888rkC56OF4qFBb/ogJQEQHasg5chJLmIkgrztxfqXwoTxP1hQaq+p9ic
         lspjgoPh8nUG1mlAdPuLtFfH5BrhfLhm6K2l2ODR3VylfUDAJgDL4aiG5m7UuwoPagMW
         iTUmFp57hyQEQ93HMcf0Ptux1wje8HrJkZvpiyaWDCyXJ6VmfuM663v2pQvxQldTBSLN
         6JqT7iGJrrFcoD0HhL4PcjwF4kLcqDY8bu6iBRqxpXUhEYpHl5nPRrkhqZ6iOtvVx/9w
         zE9BZJaF6E96I3VvMmWfDcQ7AICktksBma6q47db4jlxxarnzWVd7njHiR54ar4Y3bsY
         +6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987275; x=1737592075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBlndZsF2CWvhd+gmQFJf+dps8PTdoNsXloRCpz8OmQ=;
        b=Z6ZZs96DmHlLjRH6EwPIQVmWMGb8UROh6tOhfS4zH+ZmFkHtOq7xTzGK0nNd0Ie0mX
         /xIx4935w8KQqjtpfbW7LnAG2LfDxITcTzqLs8DQbM4Ft20dw18LI2Iorz8+BQsKUGrH
         OGuwhLNtQWUga2pnsWW9uYMg0X5UXGcS/ID0K/Kehli7oqt2WBO55fVNgrQ3iaKNEr8L
         djsdN81Pn9RTLLdjCmoVENiV31Fp7nN3ZZCbXNQ3h3/onO8NnIWJSv7jccUB6pwAIYW5
         7RnREqImhiuYTgcWAHRTQ3IEhEODdEwU63oVsI2ieWYiQ4wyWHF4vgjs8FmOqwwb9zPZ
         azvw==
X-Forwarded-Encrypted: i=1; AJvYcCVA7Vc5BJ+f8VU/kG2u7/pJNqn9O7nbmvCiBpLQKku4L05wa4SO0SM8AfQyvBRhFgd3Do4lzBwu068l2NnW@vger.kernel.org, AJvYcCXo7yPbFYNsHsZncJE9bN9TgQTRNEYUdLGP2fZFUy4XLCAatpck3tBHgL0/1F8VsVX3aiDBSasgy2F5@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBZ7wjq519nkDbU0B326ZCmKMQOxwvA73H5rBFTh4zTsEkICq
	iU2HPZfDXfvSO9lUqYPWEUwcwitB9xXse8qW1nuGcjanyeQh3H670OtFXw==
X-Gm-Gg: ASbGncv6pHNiwtEJWCmkyymoolLz+Xc59hciSUs+0m710KRUqFBPti63V0x8bWO2VyU
	wGECDuW/mZqpe3Jxk9+vlIashCp3rmYv2DbHStm/5toPXrkxNlxw2NExaZJc8qxsdTWwVDVM4pu
	tkKXdz8sELONrOwawTVHgJGGb0iGxCnGnyvb6IQbii1vURFnV12ApXYJ8ezFY97bND4zgLhoho7
	Mjtejl8a9LR2ku13zwkHjfeSGd7aw4ojVqinO4aSGdI8vpgYz3PwGBbVoowZZS2
X-Google-Smtp-Source: AGHT+IFFBpHo/cpd2UWnuE4SdC0l2vx31DI7PBy8TxEOt98gV0hnjVwnVQ//IRR0KAgS2N8zpL6Fpw==
X-Received: by 2002:a05:690c:9a8f:b0:6f4:4280:2433 with SMTP id 00721157ae682-6f531203177mr242397697b3.9.1736987274743;
        Wed, 15 Jan 2025 16:27:54 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:54 -0800 (PST)
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
Subject: [PATCH v4 04/19] ACPI: platform_profile: Add `ops` member to handlers
Date: Wed, 15 Jan 2025 19:27:06 -0500
Message-ID: <20250116002721.75592-5-kuurtb@gmail.com>
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
index c68c0d744a69..63e6bd1fe339 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2019,6 +2019,11 @@ acer_predator_v4_platform_profile_set(struct device *dev,
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
@@ -2027,10 +2032,8 @@ static int acer_platform_profile_setup(struct platform_device *device)
 
 		platform_profile_handler.name = "acer-wmi";
 		platform_profile_handler.dev = &device->dev;
-		platform_profile_handler.profile_get =
-			acer_predator_v4_platform_profile_get;
-		platform_profile_handler.profile_set =
-			acer_predator_v4_platform_profile_set;
+		platform_profile_handler.ops =
+			&acer_predator_v4_platform_profile_ops;
 
 		err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
 						   (u8 *)&supported_profiles);
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
index 6b8b30551d36..992956c89d38 100644
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
index 0346f8e88bf8..b8359b177a0f 100644
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
index 0abe22228fdb..9e26f5670fc7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10539,12 +10539,16 @@ static int dytc_profile_set(struct device *dev,
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
2.48.1


