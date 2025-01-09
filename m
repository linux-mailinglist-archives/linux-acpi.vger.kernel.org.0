Return-Path: <linux-acpi+bounces-10450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D20A07B2A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1B188424E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A021C19D;
	Thu,  9 Jan 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw8STjil"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832C215162;
	Thu,  9 Jan 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435278; cv=none; b=c8okXu2hMdntq0rYbgCspPZfxPpSSOA/6AdsNM6/MUDI3oPwxE5IhP5cq8ykyVSEkFd9+R1DjjjA313kW+94rOrj7FeVjcEOWpYs+2G3F1K5DzSzD8qgmLVJG00Ga5Huz9+wYOsbylnZ1H3FMfQDoqdT/xPTLJ+jx3g2UHSDGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435278; c=relaxed/simple;
	bh=QuDC9olJP1pupf4cEnH8ZTzBo82H5X4uKF7YUC/eND0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orfHHsWnuCosCk+airFX25pV118138Oj8zV/PEmylKd9YSFyxpsqjJP9wwj5wks7dId6B5Q0kKi/lc6nUnQQALVwplp6w4bDER8AJsxSUXSeePx0/fqyVpD63E7/YViiRm3Cr4TI4A+UHFi4jiZMQUS11iPQxTyQYlaH5Rz9oUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw8STjil; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afed7b7d1bso379483137.2;
        Thu, 09 Jan 2025 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435275; x=1737040075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgHdvr7181OCnJ8fFRDqSKuSAsUo7zC8uwySsOgNu/E=;
        b=Fw8STjil1l6wt5xkoCpXcXyRMThhYvCMZ1INo62D0MfRQ22Irja/DUvFgUcbSktRjS
         OkdWvfczlVjbpp0OUt69RRms6dKqtK/R8tpNmv9HHfauNPPPGEQr5S0GtZ3nbUJNp4Ku
         yavrqnWULhpUBanKb1puSavYIjIAbt09LxgKif1RThhAeuBkf8AK5tYwXqmXAbMxekgA
         7q8/y/zzQdlSb0LIcSYYOcI49D0yWayOK2iyU/c14YJJo4CaVNFgK8gM+hr22VJ7Kef2
         NoayyIMKaDYAk9N7NfYz3JzS9S/7+XhaiZTJ1ytgp8Bw2yGYeUy5wPsFfh2KgOLuy/Ij
         wrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435275; x=1737040075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgHdvr7181OCnJ8fFRDqSKuSAsUo7zC8uwySsOgNu/E=;
        b=D/S9+S69vlhik70ywUpKxHUZ21q6Vq7TingZYos7R64o3cBPK1XYexexEuuV1KtC7U
         BVeJIx8vJEnKSvfECiVoFXeBtF4eCvSpp+2w8ZIJwmJBqU7wcIgD9bkqhrA/OEsCuFab
         j2Y1MrcCTV+MDJXNR1g6LM8CD9Y7vQ80CSwwxiFUV4dDTS1y5K5I+ss1hXYVUguQ65QZ
         8yUWRStDSOz7L3CTGK/OCOHLBJ21uwey/FDxifg1lR8EMaZUrHZT09AOhY7IJadfARkZ
         QfsIIgou4dgTr4WWXm5GZ8yS44BF1XD+ED6DaKOUW3zIioNdA0kfSaybzryU2P1al41p
         0oGw==
X-Forwarded-Encrypted: i=1; AJvYcCWRWwpGTBy5/6CE+rt3ChDdDH9cIkQJS7kkWoo+Ib9edi78y6X4I+GdZkIp6yWBDfjdlL6vJsr9g2srPwWU@vger.kernel.org, AJvYcCXfH0/fs2Fjsyp6dddgVYRy02uy9dlQheXbOZqNC7HPMZD2y8e5tf8EBH8BYAiBn0TfPopy1dzsWgNv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy3Wzr3YtwyXYGk/k35XitZGTvrQ5kKqbTeA3j3vgPo1pyooE
	eJNV8LWS8fydWYyntAumbKXZQuEADjBOt3JeGnk9iRRCMPnCkVAZO8KoDSQf
X-Gm-Gg: ASbGncsdONXByHNPt5K/z00Spxr3eLpH/yz33LzvY/LGn8CLDHnzsc5QbJz0r4tuQi5
	xJhgPvUfs5illjIbVVv4z+V8lhZXBT2XFRvfboOPOc4ek4HYYV2WOS4H+TTOfd/wMQ39rZ++kiK
	wNEUvQEPwje4NLxMD3cBCpAPvBvoS5INxM+XV5lmh4Ffk+wdNMxb6FcQrBFlcoYjZdbsEXjDNJP
	q1SJX80rXLK3cipjB+27b0jr8bAt2qejUumeSHXpaYjiZ9SS2hefjIIWJpmhTfJ
X-Google-Smtp-Source: AGHT+IHVcrKUi7wErwOfwZpS/PaRFWvaghQ5ibM4XLj21ds5s29oRt3+lCg6lLFKavl2+qdqlzbt3g==
X-Received: by 2002:a05:6102:c90:b0:4af:f740:c1b4 with SMTP id ada2fe7eead31-4b3d0f6193fmr5928394137.5.1736435274889;
        Thu, 09 Jan 2025 07:07:54 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:07:54 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 01/18] ACPI: platform_profile: Add `ops` member to handlers
Date: Thu,  9 Jan 2025 10:06:14 -0500
Message-ID: <20250109150731.110799-2-kuurtb@gmail.com>
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
index 4c4200a0b1a6..39a22e27acc5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -64,7 +64,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->profile_set(handler, *bit);
+	return handler->ops->profile_set(handler, *bit);
 }
 
 /**
@@ -101,7 +101,7 @@ static int get_class_profile(struct device *dev,
 
 	lockdep_assert_held(&profile_lock);
 	handler = dev_get_drvdata(dev);
-	err = handler->profile_get(handler, &val);
+	err = handler->ops->profile_get(handler, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
 		return err;
@@ -465,7 +465,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	/* Sanity check the profile handler */
 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-	    !pprof->profile_set || !pprof->profile_get) {
+	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 6c87e982bfc8..2a9716372d56 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -201,6 +201,11 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
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
index b3043d78a7b3..ac7b3ab8fd2a 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1900,6 +1900,11 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
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
index bd2bd6cfc39a..7c8391ac4dbb 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -387,6 +387,11 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
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
index fdeebab96fc0..ef4129d91656 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3852,6 +3852,11 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
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
index 7b3ee2d6a23d..c824414565b6 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,6 +1108,11 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
+static const struct platform_profile_ops awcc_platform_profile_ops = {
+	.profile_get = thermal_profile_get,
+	.profile_set = thermal_profile_set,
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
index 3797a5721dbd..1751b7235031 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -231,6 +231,11 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
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
index 6d6e13a0c6e2..c37e44f7606c 100644
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
index dc98f862a06d..b49ee94f9bee 100644
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
index 53af73a7fbf7..38d4745f6be1 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -166,6 +166,11 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
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
@@ -179,8 +184,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 	priv->handler.name = "inspur-wmi";
 	priv->handler.dev = &wdev->dev;
-	priv->handler.profile_get = inspur_platform_profile_get;
-	priv->handler.profile_set = inspur_platform_profile_set;
+	priv->handler.ops = &inspur_platform_profile_ops;
 
 	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f51662861738..04a292af2bfc 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,12 +10538,16 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
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
index f1cd4b65e351..a9db95bc360d 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,16 +27,22 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
+struct platform_profile_handler;
+
+struct platform_profile_ops {
+	int (*profile_get)(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile);
+	int (*profile_set)(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile);
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


