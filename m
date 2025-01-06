Return-Path: <linux-acpi+bounces-10360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389CA01EA3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 05:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1667A1348
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 04:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1019E7ED;
	Mon,  6 Jan 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOTwGKhW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D788150994;
	Mon,  6 Jan 2025 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138812; cv=none; b=YCKSq2fjMoXUFHJkWcKlVR/UvV+OMFwsCEFFteikrj0InsUMUXb4DewJxs9XGIYj1c/buXf4//z5+MxZHZ1DeEkYcqp0EjZ6ZUBirw3VsMDVpmHEXA6AZmJse+Qn9TxAi5ZwNgqViDA66TqokevJFK9hfcXkSKdzbWjod1R6YEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138812; c=relaxed/simple;
	bh=hNoOmTtpygDtHLi90bIBQNHWmmBhBobktYmj2GBwsig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZWMOch+65Vvee3k3aCV8lHugUXK9Tubw6xDwrD+/ghQksZESyVjgKPzCU5YPmrZJItVy1ALMYBUaf39BCRVZVRMHRhpLT8l6wfaCjZo/hBVoe2LZdpMQUlBWPTS/vBNDrh0L+0+vqUyb3hgFIoM98POATFkyXfdPVvi3xAWIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOTwGKhW; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4b11a110e4eso3975802137.1;
        Sun, 05 Jan 2025 20:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736138804; x=1736743604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD7WMWOAd80Nt6/qQ4cAZAHdnAvIu6D3de0Y1uQuWrQ=;
        b=BOTwGKhWSKkUyESOtKCJJ/FnwqXW6Vns+BliYgr12TYeAzMpLbNX4yEmQN/rnuTvFw
         CxTv4Fiuz9skTek5vkEPvN2iFPQznyIofJcLi/szdH5F6f3v4esD18sH4RbGqXDiDmZu
         lRYZEBrpDXFkLd5b+f8O5JWXxYf3d3tgivjLdUE9qurPTvgB7cnTrM/v4Dc877JTozYa
         ezZL3rS3XICxCApVGx0z1ZvU73dRleZHqB3iR8B3rCpq2jxw3jtYwiPXw8Nr5kWrPIZy
         cZwGen9o6PxaZFkDCZm1t4J3gj8P0yndm5Ws4N49mV+zwGNDAvgH+cNihQIQyOpoNQoR
         OlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736138804; x=1736743604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD7WMWOAd80Nt6/qQ4cAZAHdnAvIu6D3de0Y1uQuWrQ=;
        b=ArXXqWoGNtC/dbBnsmfORPXDR5UlvznXK9GQgMoc9QSWDRmKef8DCKVsxQMxLc5Etn
         agVIQ7GEG00Ly6mjBQykxNTnMYgSSIuzHupB3uMXfKTwPzJ1F3bvwwG5thowuVdT4Isu
         PR9zqmbmZKPJ9UYcoxUZlcCN9ipYr82jPIWUHLXfEwTaslDDDrevYITUveR/znpd2gJy
         kRVhKfbU9mBAKyxHNKpreBdynUYFTumsEgFYt4l//yrukw9arlvQ5sRwl8tkEJN7AlhI
         zH4dzVQLh/OYs+r4Zf2R30yCXBU+5shqcPNhrfFoC1Jcpea37jui9hrRTQuyi16DjMyW
         l0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX6kNunO869LRZpTFB04K1jOLCUCQmdPBv0dPNO6lQ5EHtS1NC9uKZ+9/3ODjTzGG8eNtWN0Px0KYco@vger.kernel.org, AJvYcCXIXHpgHTawcSA/ovHwa9gYgbNJypTx58Tj05hVA5mA40yXwpNtZ7hJh5BFKJbuUIz9hP2oyzwCWEMzXs/k@vger.kernel.org
X-Gm-Message-State: AOJu0Yydty17G1TM5P7Oozy17xXbw2AMaqYYBnAnybDRwFWjcNl104GC
	2nyUEP2WhqCqWaRoxgZB+I3w6cYMLgriaGdvsCkOKnZ5RfyPN0OaWwOUiUH1
X-Gm-Gg: ASbGnct0Pug0b7QfrT0X2/aT06nuM0YMJua3kgmaTQyD2gm6rJ/ig2kEpBjaSyi4ZOy
	/pk14k8vkyWEtQXJt2Rn3RwsFMMmZWUxa2znBDKNSUhINvQeda0XlKVv402fxMdXiweanDKvbRF
	Ap13qDj5vZfiMxvDT0VKshtRfGTTTcV54TQUbzm4tjoHd2O/F6hZSsIcwOVYBpCgS6bHU6GkApN
	E3gHH4WsVn53SUDPedTNNuV+xDHcWVhC3Xu8f7aeorKlwOlv8genLUSah9CU0gX
X-Google-Smtp-Source: AGHT+IFy18U4Tujs8UsAWQwVGQejPKKPBiQQh0rIbSavLpNKany3JOJMrHm/+RQhZHTsr2S+DFcDVA==
X-Received: by 2002:a05:6102:4422:b0:4b2:ad82:1318 with SMTP id ada2fe7eead31-4b2cc48d1bcmr50567309137.26.1736138803877;
        Sun, 05 Jan 2025 20:46:43 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf98d1c9sm7083507137.4.2025.01.05.20.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 20:46:42 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: josh@joshuagrisham.com,
	hridesh699@gmail.com,
	derekjohn.clark@gmail.com,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Armin Wolf <W_Armin@gmx.de>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [RFC PATCH 1/3] ACPI: platform_profile: Add ops member to handlers
Date: Sun,  5 Jan 2025 23:45:49 -0500
Message-ID: <20250106044605.12494-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106044605.12494-1-kuurtb@gmail.com>
References: <20250106044605.12494-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace *profile_get and *profile_set members with a general *ops
member.

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
 include/linux/platform_profile.h              | 14 +++++++----
 12 files changed, 86 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4c4200a0b1a6..68e496ff5176 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -64,7 +64,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->profile_set(handler, *bit);
+	return handler->ops->set(handler, *bit);
 }
 
 /**
@@ -101,7 +101,7 @@ static int get_class_profile(struct device *dev,
 
 	lockdep_assert_held(&profile_lock);
 	handler = dev_get_drvdata(dev);
-	err = handler->profile_get(handler, &val);
+	err = handler->ops->get(handler, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
 		return err;
@@ -465,7 +465,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	/* Sanity check the profile handler */
 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-	    !pprof->profile_set || !pprof->profile_get) {
+	    !pprof->ops->set || !pprof->ops->get) {
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 6c87e982bfc8..8077d556e616 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -201,6 +201,11 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
 	return tp;
 }
 
+static const struct platform_profile_ops ssam_platform_profile_ops = {
+	.get = ssam_platform_profile_get,
+	.set = ssam_platform_profile_set,
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
index b3043d78a7b3..26d6b9cdfd12 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1900,6 +1900,11 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
+	.get = acer_predator_v4_platform_profile_get,
+	.set = acer_predator_v4_platform_profile_set,
+};
+
 static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
@@ -1907,10 +1912,8 @@ static int acer_platform_profile_setup(struct platform_device *device)
 
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
index bd2bd6cfc39a..1b87254a7120 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -387,6 +387,11 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static const struct platform_profile_ops amd_pmf_profile_ops = {
+	.get = amd_pmf_profile_get,
+	.set = amd_pmf_profile_set,
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
index fdeebab96fc0..d0828b1499b1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3852,6 +3852,11 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	return throttle_thermal_policy_write(asus);
 }
 
+static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
+	.get = asus_wmi_platform_profile_get,
+	.set = asus_wmi_platform_profile_set,
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
index 7b3ee2d6a23d..dd6b7d16b567 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,6 +1108,11 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
+static const struct platform_profile_ops awcc_platform_profile_ops = {
+	.get = thermal_profile_get,
+	.set = thermal_profile_set,
+};
+
 static int create_thermal_profile(struct platform_device *platform_device)
 {
 	u32 out_data;
@@ -1154,10 +1159,9 @@ static int create_thermal_profile(struct platform_device *platform_device)
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
 	}
 
-	pp_handler.profile_get = thermal_profile_get;
-	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
+	pp_handler.ops = &awcc_platform_profile_ops;
 
 	return devm_platform_profile_register(&pp_handler);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3797a5721dbd..9af63a9bdefe 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -231,6 +231,11 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static const struct platform_profile_ops dell_pc_platform_profile_ops = {
+	.get = thermal_platform_profile_get,
+	.set = thermal_platform_profile_set,
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
index 6d6e13a0c6e2..dbd19d93fdd6 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1565,6 +1565,21 @@ static inline void omen_unregister_powersource_event_handler(void)
 	unregister_acpi_notifier(&platform_power_source_nb);
 }
 
+static const struct platform_profile_ops platform_profile_omen_ops = {
+	.get = platform_profile_omen_get,
+	.set = platform_profile_omen_set,
+};
+
+static const struct platform_profile_ops platform_profile_victus_ops = {
+	.get = platform_profile_victus_get,
+	.set = platform_profile_victus_set,
+};
+
+static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
+	.get = hp_wmi_platform_profile_get,
+	.set = hp_wmi_platform_profile_set,
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
index dc98f862a06d..f3414964c3b9 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1063,6 +1063,11 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
 	{}
 };
 
+static const struct platform_profile_ops dytc_profile_ops = {
+	.get = dytc_profile_get,
+	.set = dytc_profile_set,
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
index 53af73a7fbf7..6113b87c4858 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -166,6 +166,11 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static const struct platform_profile_ops inspur_platform_profile_ops = {
+	.get = inspur_platform_profile_get,
+	.set = inspur_platform_profile_set,
+};
+
 static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct inspur_wmi_priv *priv;
@@ -179,8 +184,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 	priv->handler.name = "inspur-wmi";
 	priv->handler.dev = &wdev->dev;
-	priv->handler.profile_get = inspur_platform_profile_get;
-	priv->handler.profile_set = inspur_platform_profile_set;
+	priv->handler.ops = &inspur_platform_profile_ops;
 
 	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f51662861738..519d9cb0af57 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,10 +10538,14 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return err;
 }
 
+static const struct platform_profile_ops dytc_profile_ops = {
+	.get = dytc_profile_get,
+	.set = dytc_profile_set,
+};
+
 static struct platform_profile_handler dytc_profile = {
 	.name = "thinkpad-acpi",
-	.profile_get = dytc_profile_get,
-	.profile_set = dytc_profile_set,
+	.ops = &dytc_profile_ops,
 };
 
 static void dytc_profile_refresh(void)
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f1cd4b65e351..8031bf801d70 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,16 +27,22 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
+struct platform_profile_handler;
+
+struct platform_profile_ops {
+	int (*get)(struct platform_profile_handler *pprof,
+			enum platform_profile_option *profile);
+	int (*set)(struct platform_profile_handler *pprof,
+			enum platform_profile_option profile);
+};
+
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
 	struct device *class_dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(struct platform_profile_handler *pprof,
-				enum platform_profile_option *profile);
-	int (*profile_set)(struct platform_profile_handler *pprof,
-				enum platform_profile_option profile);
+	const struct platform_profile_ops *ops;
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-- 
2.47.1


