Return-Path: <linux-acpi+bounces-10653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5BA11A8C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752A33A2E21
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DA2309AA;
	Wed, 15 Jan 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCAGGfJh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1678234D05;
	Wed, 15 Jan 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925113; cv=none; b=blfOc5eZ+47Iq/be4nErdDd53zDCnw2avJn1xDK7Qgeesyh+D3eTDgmbvsLSDrbiC8GXwWZsWxcmMRpvCHBRdU6yWG7nPRGE83wXmLGm2Tgt5mfq6rKSWqT9m4b9ZoMEu9thGJJ+E/JhdrT1yTQzlsCVPe/DZkfjVzS0G1d30gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925113; c=relaxed/simple;
	bh=I4dGQg4/mioqynhS1VaZWHDTdwnWXhAjF2EDr2pmRpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX2Uqa3lbcF2w8Gj/U3gcjXm1EfR1xAFH0Mp5+wAOSpr3JBhkn/xpXeJtauw1YHyTn9OZklLTGtD7QL+6ycgEBSz2+Y19m4bIp4KLHLetqmO63e6c8Ur7fK7vBNh3fo4/9XN5RcLGPSTn7+CQasStLVUZPauToT5mk/7SfOpa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCAGGfJh; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afdfd3124dso1803539137.2;
        Tue, 14 Jan 2025 23:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925110; x=1737529910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWEcGrVkcb9JKYQeu9uxP3hL/sO05nt+ccZzlfeAzFQ=;
        b=GCAGGfJhka44ukQfGMcR5kJi9M5EirTDOtgO5XKSoBKRI/LpxKbxJDKDev4UNpe1lh
         zT7a8ywSuJbWYFW2mps+NWajSF8myQLTebr3jNRQuWuh8MSLHs8COszLiVwbo+lCO1ff
         IdEQht2kLYKXP4kueOuYQn2nMTz8FHl74Fo+aI+P1jyWFzrjcwN/E9TonbQUpnMrbMPd
         QpefQR3aGj+S0YhgymvpMP92fTRar3g4LFsjJ8G46Jncj5y3MvYpTZKInoHHrPUCLELe
         kQTS0IaVxQ5iHtPdS/HEIU2ovG/5u+WC34s+1cdR4CEAu+Q7XyFUSMPYfP5kxrPyqktd
         E+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925110; x=1737529910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWEcGrVkcb9JKYQeu9uxP3hL/sO05nt+ccZzlfeAzFQ=;
        b=PIBO3Xd2wAD55YEsA/QZ8unyMdu1aHj8TILbWR8cBCOTiaYgGJSJ/1HmB6i464+XJm
         SmgTtZNPFF1AcsEO0S3OCupdCQz0DRNS9L7xUYeXkV8BqIQKav4Uo8y3WKGCGfF+3trk
         KdCsi9t5NMm3TDO8UF4Z3YarPIkXxtr31W+fSyMlKEO+3S6o/dAkEoeENUVA9goJV++d
         fpyxsauOeYUXxzo8Tko27kOA4kjPVhKu3vGnX/wQEOlHfTp50Xz50QHCh2zd/Is/4HEc
         PoeZ/Yaz3PulXBkbI1PF6wsdVBJjsDDpzLU0P+tn/ZHIL12CTVEOqHClLOruADJHq7XL
         94mg==
X-Forwarded-Encrypted: i=1; AJvYcCVuhh8ilvRxAj8QN+s9xxuSeQVZ+70U4dpje/4oIya8hs02MlZvVpzp5L8FCbYx+rqW+Z73bIQu7T2x@vger.kernel.org, AJvYcCXoizRaBOLIk6QZ5hmQizPnm4ixBugPndZtDExvy5TCndxpOjVi4+RruLU3yJ2JznW3OznjesBJj2stzbHu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzetuels64NXGa0Tfnf+i5uUk9u6QhA9L9tfbVX/y+6xHuoNUEe
	ewiK+MG4PCen0puxuZ3CGTUSEmoZvYajDhreM26Jh/cQ4eWtMYEuesc+Rw==
X-Gm-Gg: ASbGncu73SHY2Rd6Xwq0/9uL1DP6yJmumFGTWW332h3gvp94BB9aXiGbweyIgUALtRm
	eC8RvYxyqi6/UpbXGqJWsM86zPHllRfKp+wPNrBbmT/3BYvEBV+TlymioS3lGp1qHDwQj4oHPGe
	U1FjALkrVcMKV0aoCWLlB63Ih2tcN+wWeKbdYymGBSH2KJ49jyGsWPSdGYNyB8sDGBItZybgqzN
	4tCYuoKUfqzyqqGgDxAKXevK1OtCeZi+JVehHW5o4N1g5bzBy0J2UljYuQse9bS
X-Google-Smtp-Source: AGHT+IGm+Z4w/bz1Uk4SC2g2k9U9zRShbSSNv5Gug8R4N30esAKRpFmGXqjFk6j1Fji+wGsujabcCg==
X-Received: by 2002:a05:6102:dd2:b0:4b2:cca8:88d0 with SMTP id ada2fe7eead31-4b3d0ee4e60mr22417050137.1.1736925110247;
        Tue, 14 Jan 2025 23:11:50 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:11:49 -0800 (PST)
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
Subject: [PATCH v3 05/19] ACPI: platform_profile: Add `probe` to platform_profile_ops
Date: Wed, 15 Jan 2025 02:10:08 -0500
Message-ID: <20250115071022.4815-6-kuurtb@gmail.com>
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

Add a `probe` callback to platform_profile_ops, which lets drivers
initialize the choices member manually.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               | 15 ++++++++--
 .../surface/surface_platform_profile.c        | 16 ++++++----
 drivers/platform/x86/acer-wmi.c               | 24 ++++++++-------
 drivers/platform/x86/amd/pmf/sps.c            | 15 ++++++----
 drivers/platform/x86/asus-wmi.c               | 16 ++++++----
 drivers/platform/x86/dell/alienware-wmi.c     | 24 +++++++++------
 drivers/platform/x86/dell/dell-pc.c           | 26 ++++++++++-------
 drivers/platform/x86/hp/hp-wmi.c              | 29 +++++++++++++------
 drivers/platform/x86/ideapad-laptop.c         | 15 ++++++----
 .../platform/x86/inspur_platform_profile.c    | 14 ++++++---
 drivers/platform/x86/thinkpad_acpi.c          | 15 ++++++----
 include/linux/platform_profile.h              |  1 +
 12 files changed, 139 insertions(+), 71 deletions(-)

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
index 91ae48adf6cf..6953e36dbfde 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1916,7 +1916,20 @@ acer_predator_v4_platform_profile_set(struct device *dev,
 	return 0;
 }
 
+static int
+acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
+	.probe = acer_predator_v4_platform_profile_probe,
 	.profile_get = acer_predator_v4_platform_profile_get,
 	.profile_set = acer_predator_v4_platform_profile_set,
 };
@@ -1931,17 +1944,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE,
-			platform_profile_handler.choices);
-		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
-			platform_profile_handler.choices);
-		set_bit(PLATFORM_PROFILE_BALANCED,
-			platform_profile_handler.choices);
-		set_bit(PLATFORM_PROFILE_QUIET,
-			platform_profile_handler.choices);
-		set_bit(PLATFORM_PROFILE_LOW_POWER,
-			platform_profile_handler.choices);
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
index d88860dd028b..3d77f7454953 100644
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
index f7a854d40575..0146d2f93be6 100644
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
index 9978fd36a3d1..5c250867678f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,7 +10538,17 @@ static int dytc_profile_set(struct device *dev,
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
@@ -10584,11 +10594,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
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
2.48.0


