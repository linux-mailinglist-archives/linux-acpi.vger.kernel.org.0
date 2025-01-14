Return-Path: <linux-acpi+bounces-10605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F40AA10B0A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7D53A1021
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F811C5F0F;
	Tue, 14 Jan 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6diHZC5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3481C331E;
	Tue, 14 Jan 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869103; cv=none; b=UW3qZ712z1KJcFA8izRxHctUioeZwfYUebaWsen4NUSkSBImQgfY7EPd6feY+39zzRi3uiJ0+2SUHRL4xS8SLMT49C5bzY6P7Jd8NFwXI28IWGSCwHWowcTF9Cf93BoKz9vHy6aqPZBT3P3fR5cxsq9F1AWCMZPCkVw9vz0B+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869103; c=relaxed/simple;
	bh=T/QFTDFrJmix2FMos12pGVdJlsqCESYVneJp/YIiHcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd3GMJ+85LBRpL81Y6L96qWQLG6077Ji77x09t61tAepuMQj1pyPcy8FPALp9Ku4dz45s1it7kPVv6EjGgqeaH7s2heJ7VPs+rUMq47HGHErK+BqNwXE37r5Oxzgc50uImRtrwDeKE/HyqqAAkZNSIAO2XYPC6EqtozEYa4UO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6diHZC5; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51878d9511bso2143514e0c.0;
        Tue, 14 Jan 2025 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869100; x=1737473900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXQB1DgR6Y5cIB8SHvgVESJb8wq8cSSgNO5tJthL7m4=;
        b=a6diHZC5LrxYHlVTYWYoqsFj703w8auG65LNfLY4QEpfZ54ZZYfqiEHfRmbQU0MtWS
         YBSYvSeipgY7kySj3Ey19Q1a+20VLdfeOPdX773/2rIj0tlJnfJm2OZqb6Vq0pBhM5Sc
         UD08tLL4wbz4nVNCK5sLsmMWEf3834r6pnCaMZbauAgnNoYPRyIC9g9wMBgAFLLlyJbj
         5UZt7CBRO3RcDMvzyL26LYKwPxC5Rn7DYDHrtn4uXCoZFmgCYCIUlBVj0AGKl1jOAutd
         D3+BTyXfeFkU9xY85o+yMQwIgQGSGK+rKb3Daz3Qg6FKN0L8j5fh/eK7q6BdrTEegPBk
         WSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869100; x=1737473900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXQB1DgR6Y5cIB8SHvgVESJb8wq8cSSgNO5tJthL7m4=;
        b=oot4M/jJZcyz6zZUZhzzV5jj9q1R18jj/bRXxnAGORt2R3J0o04nGcOUKXdTM2jLZB
         AO7/IS2YPxZesO0NEgmzPJb7t5bz2FSFuefbYBRAi8eA2l9FDlIE2ai9tvIOM/Vpg10M
         Qd1S+6e0ChrHuyWuKCuXVhJDdk196woBBk00rewut+93ElMqmCwrqkzrBJYCk5rCO1C5
         sOTsD86Wgboo9WnSLva7Rljv+GmgpfFlRWj54n3FSYCJF7bw0fyxFTOMwE/penIusn+R
         M2vDwNY1QZ1CzQNeAGH/YNO5MqRARlqpbERP5hG0da75jYotb4CV7EpCFWtDlj4l4Mkj
         lxRw==
X-Forwarded-Encrypted: i=1; AJvYcCWvvMIdCCyPEBXgGN9NP2V+EyVXWLudIZWN1F7QqEIOPQ1+L2UcSvCe4eHdog/GJwKDggqzbvjAcICn@vger.kernel.org, AJvYcCX9FrHvfffrFdtD/aw9+esHSavlJ3NC0fzvVL+1EXDMXbHYTwjHIo70CZHwdGvyHLpxey3PlaYJb5LTrHvJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XWs9195oX80z2sZz6ZXcSDw0AALp2TVRlos/TkwxoBgEymuL
	U4G2wJUzrFEv3iDQmOiv7oCq+oUZDtdObLnQDs+e5vcryC2B/HQAFLcnOw==
X-Gm-Gg: ASbGncs20R6plC6ZT1W9wL0b+T3ym1p4d3UOTFx74i8yZPZhpI+Rx8GNscy0xHkGHgZ
	21r8rRpN+wJd8V4rspcIbZ3P13rzcLrY3dHFh70gjE4evqt1wvL8OP32h+UpIb9eP5BtVUY0V8j
	H5Agh+qT1ZaFrVgJluPrfKc1Yblo1aHs8iUgPG9MeBXx+fetMkROBpkrcF4QSdH5q7TmU8Bc/Vd
	a1h+vOwJNfM3fE944Ca5XGC1yLj49kKP+wPRizPBLtR6h8L/N1c0srXLFfGdjEN
X-Google-Smtp-Source: AGHT+IHfhVqUpJVMJKgxiTP9F9AtVc0MS/hgNaWoEp2T+wzctJAJVzbnGBWtGwf3ePoIA1v+KZ41AQ==
X-Received: by 2002:a05:6122:2a08:b0:516:18cd:c1fc with SMTP id 71dfb90a1353d-51c6c5259aemr18812538e0c.8.1736869099582;
        Tue, 14 Jan 2025 07:38:19 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:19 -0800 (PST)
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
Subject: [PATCH v2 04/18] ACPI: platform_profile: Add `ops` member to handlers
Date: Tue, 14 Jan 2025 10:37:12 -0500
Message-ID: <20250114153726.11802-5-kuurtb@gmail.com>
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
index 66170fe436f0..440654e21620 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -66,7 +66,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->profile_set(dev, *bit);
+	return handler->ops->profile_set(dev, *bit);
 }
 
 /**
@@ -103,7 +103,7 @@ static int get_class_profile(struct device *dev,
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	err = handler->profile_get(dev, &val);
+	err = handler->ops->profile_get(dev, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
 		return err;
@@ -467,7 +467,7 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
 
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
2.47.1


