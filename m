Return-Path: <linux-acpi+bounces-10700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A0A12FBC
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11893164B9D
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A015282F0;
	Thu, 16 Jan 2025 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTO8tQMB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2FA957;
	Thu, 16 Jan 2025 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987274; cv=none; b=qavoCxFcxeCikhRfiMStS7k6lbAk29JMRipMaPbZZrvGemZdNcmOobbiJr3DvQY1MlKmuPf50XFPaJLAX4Hg+q9IAQnawWx4/EGJGiekImzeR6HTfYSephkZu7yjMEbTZUxtAtFiw+ddxo8+XMgZUOmscINF/OjrlJ57dNjYd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987274; c=relaxed/simple;
	bh=3kdDOFZWWufGw3RSkFoQVe5z+IUQJa2ihjOhqsLeZ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoEx2d9zS/5EoUxfdRdcnRiuPC4Rhwp1vDBXcZFCdLnZD1xYwFGcDG5Z68w8psncloWwEoIA2xHxrDZYcFHIk9eS9m5VIyyLHux1eRfSas7NK0+Kp8SfIGoBXWgOp5ir54/VR+eTTioOkplJsCkR1CMnn4lJ76gOYmnXF0zDF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTO8tQMB; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so720070276.3;
        Wed, 15 Jan 2025 16:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987271; x=1737592071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDI29vG4CBZHcoqjRpqC2IPTRaOT+SQ30E9UCtEjb4E=;
        b=NTO8tQMBtxsQ+MPpBBn8H2Q6ltM4n5X2cVW34ux7ZPXe5SEATPQnsFjzVqUQCII2JG
         BpjQpSjHvLAvenA1rpgoKzPAPUeM0lvIEcAla74bwHk9qIQKFWc6+FGdKFl8eXX+ejVb
         8LaIlRmduTINDLzS8M2QI7TmUvopddSInwdHZOWHpW1m7RLKFFg248nnF09jrUM/o2Bn
         NxbFBXLigqaAgDbhtpMg3+KmOBz1bR7KiKZ6HgYb8eJ4rUfa1BubYCBeoXVe2fl+y0jg
         w7Vc0+U5d5F9gzxN4rzBAxszsHXaqkIDWZ7KC3g6Z0LsZKcmFsDPSkeDSWXIq3lfY9WD
         71mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987271; x=1737592071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDI29vG4CBZHcoqjRpqC2IPTRaOT+SQ30E9UCtEjb4E=;
        b=QrFQKE6LNSvpbLS87dsEaFNlKRJVkPbDqaNvM5hon3mOvGp/5prFeZQEIS8yDoWQkW
         /e7SgLmYPQiLz1wW2TZQRGz1/BOY96CCP19F7UIUVvC0C8Xk6vyIs0JsNac46AugH8j0
         mnKkDWCw0IP2u0d384rqpASL5VOppDA+sHE7ET9dGhsuIAu5G7hXnh0o0oG6i7lPq4SC
         +8wWasbWInNXlx/9HhGOj2Id4+R6R/OBN7GfmUBfOf8GHyt6qUrooTz6NIUHFS/j17lO
         G863eEObgua4UY3unPlspliYgwWrswC1xRbrlBhdZR1acHcpYzDUN2m+hxVeet9XUzQD
         Dj/w==
X-Forwarded-Encrypted: i=1; AJvYcCUkaTRayiK543qYIoC9tdez/cSCq/mTCtdM669BgrOfMKbfs6r7O5ReTyxLa+mibz4OTKNTQiPO7lNiwKUG@vger.kernel.org, AJvYcCXdb6KR/Ct6ihqprqLxlaRzMyOwqtyI5cnRewq2ZAAWfrXBprkE1pHC4uj09RiK11apONUhIONdBGZx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvc6N7KmlgxPZPJG85V3gSVA15rpbgTpNOeMSHH3CKdOrCTFvb
	u/zr4VvvPT0gZ47z2U9T+e3c7+5ex1xymBSCtz8o1Mt/CDGET0kQfZdJFw==
X-Gm-Gg: ASbGncsVHZxGSvpHYMUCtOI7O/RRp+GXscBi7NBZqcMKhbf4Ux/0lKbxS+tLCOHkFWf
	79Rfwj20w4Wpg6MBm8YxN9mW+neo6b9zVcEI82lxBvYblACkE+N7kDw09wxiYjzuGpG23TLKGZ5
	pzl/iRXePUUcD7y09RNB6bAKGVeTThDckVwUPJkF+4m0gfaCYjq4aS5hvGJsPNdKCjL8yS5jDa3
	5HbJF3IWpZbpKxgBIVGKNGkMytPt9BfWPz5obk7dNMhHG3lkgVonNLw8wk3pILW
X-Google-Smtp-Source: AGHT+IG9vaoz8DYuqwJ6j0c8tgR+ZVeLx2RiNfM/PTEzwScw70iTMG5exgOpaMsjR9HXFbN+/S3Wtw==
X-Received: by 2002:a05:690c:6a81:b0:6ef:5013:bfd9 with SMTP id 00721157ae682-6f531224addmr281455977b3.10.1736987271000;
        Wed, 15 Jan 2025 16:27:51 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:50 -0800 (PST)
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
Subject: [PATCH v4 03/19] ACPI: platform_profile: Remove platform_profile_handler from callbacks
Date: Wed, 15 Jan 2025 19:27:05 -0500
Message-ID: <20250116002721.75592-4-kuurtb@gmail.com>
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

Devices can now set drvdata to the class device, thus passing the
platform_profile_handler to callbacks is unnecessary. Instead pass the
class device.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c                    |  4 ++--
 .../platform/surface/surface_platform_profile.c    |  8 ++++----
 drivers/platform/x86/acer-wmi.c                    |  4 ++--
 drivers/platform/x86/amd/pmf/sps.c                 |  8 ++++----
 drivers/platform/x86/asus-wmi.c                    |  8 ++++----
 drivers/platform/x86/dell/alienware-wmi.c          |  4 ++--
 drivers/platform/x86/dell/dell-pc.c                |  4 ++--
 drivers/platform/x86/hp/hp-wmi.c                   | 14 +++++++-------
 drivers/platform/x86/ideapad-laptop.c              |  8 ++++----
 drivers/platform/x86/inspur_platform_profile.c     |  8 ++++----
 drivers/platform/x86/thinkpad_acpi.c               |  4 ++--
 include/linux/platform_profile.h                   |  6 ++----
 12 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 689541d2e66c..bd90aa4e8371 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -65,7 +65,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->profile_set(handler, *bit);
+	return handler->profile_set(dev, *bit);
 }
 
 /**
@@ -102,7 +102,7 @@ static int get_class_profile(struct device *dev,
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	err = handler->profile_get(handler, &val);
+	err = handler->profile_get(dev, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
 		return err;
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index edb9362003a4..26c1230e75df 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -154,14 +154,14 @@ static int convert_profile_to_ssam_fan(struct ssam_device *sdev, enum platform_p
 	}
 }
 
-static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
+static int ssam_platform_profile_get(struct device *dev,
 				     enum platform_profile_option *profile)
 {
 	struct ssam_platform_profile_device *tpd;
 	enum ssam_tmp_profile tp;
 	int status;
 
-	tpd = dev_get_drvdata(&pprof->class_dev);
+	tpd = dev_get_drvdata(dev);
 
 	status = ssam_tmp_profile_get(tpd->sdev, &tp);
 	if (status)
@@ -175,13 +175,13 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
+static int ssam_platform_profile_set(struct device *dev,
 				     enum platform_profile_option profile)
 {
 	struct ssam_platform_profile_device *tpd;
 	int tp;
 
-	tpd = dev_get_drvdata(&pprof->class_dev);
+	tpd = dev_get_drvdata(dev);
 
 	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
 	if (tp < 0)
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 1aedf0ef4189..c68c0d744a69 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1950,7 +1950,7 @@ static int acer_toggle_turbo(void)
 }
 
 static int
-acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
+acer_predator_v4_platform_profile_get(struct device *dev,
 				      enum platform_profile_option *profile)
 {
 	u8 tp;
@@ -1984,7 +1984,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
 }
 
 static int
-acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
+acer_predator_v4_platform_profile_set(struct device *dev,
 				      enum platform_profile_option profile)
 {
 	int err, tp;
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 259a598acd3e..cf2e51f67787 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -282,10 +282,10 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
 	return (pmf->current_profile == PLATFORM_PROFILE_BALANCED) ? true : false;
 }
 
-static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
+static int amd_pmf_profile_get(struct device *dev,
 			       enum platform_profile_option *profile)
 {
-	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
+	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
 
 	*profile = pmf->current_profile;
 	return 0;
@@ -363,10 +363,10 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 	return 0;
 }
 
-static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
+static int amd_pmf_profile_set(struct device *dev,
 			       enum platform_profile_option profile)
 {
-	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
+	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
 	int ret = 0;
 
 	pmf->current_profile = profile;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f91099792cb9..6b8b30551d36 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3800,13 +3800,13 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
-static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
+static int asus_wmi_platform_profile_get(struct device *dev,
 					enum platform_profile_option *profile)
 {
 	struct asus_wmi *asus;
 	int tp;
 
-	asus = dev_get_drvdata(&pprof->class_dev);
+	asus = dev_get_drvdata(dev);
 	tp = asus->throttle_thermal_policy_mode;
 
 	switch (tp) {
@@ -3826,13 +3826,13 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+static int asus_wmi_platform_profile_set(struct device *dev,
 					enum platform_profile_option profile)
 {
 	struct asus_wmi *asus;
 	int tp;
 
-	asus = dev_get_drvdata(&pprof->class_dev);
+	asus = dev_get_drvdata(dev);
 
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 154c417a438c..0346f8e88bf8 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1026,7 +1026,7 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
 	return 0;
 }
 
-static int thermal_profile_get(struct platform_profile_handler *pprof,
+static int thermal_profile_get(struct device *dev,
 			       enum platform_profile_option *profile)
 {
 	u32 out_data;
@@ -1052,7 +1052,7 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int thermal_profile_set(struct platform_profile_handler *pprof,
+static int thermal_profile_set(struct device *dev,
 			       enum platform_profile_option profile)
 {
 	if (quirks->gmode) {
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 1a0a721d706f..c86b05b5a1cb 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -185,7 +185,7 @@ static int thermal_set_mode(enum thermal_mode_bits state)
 	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
 }
 
-static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
+static int thermal_platform_profile_set(struct device *dev,
 					enum platform_profile_option profile)
 {
 	switch (profile) {
@@ -202,7 +202,7 @@ static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
 	}
 }
 
-static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
+static int thermal_platform_profile_get(struct device *dev,
 					enum platform_profile_option *profile)
 {
 	int ret;
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8e5e1422e024..b8e62dc9cecd 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1221,7 +1221,7 @@ static int platform_profile_omen_get_ec(enum platform_profile_option *profile)
 	return 0;
 }
 
-static int platform_profile_omen_get(struct platform_profile_handler *pprof,
+static int platform_profile_omen_get(struct device *dev,
 				     enum platform_profile_option *profile)
 {
 	/*
@@ -1318,7 +1318,7 @@ static int platform_profile_omen_set_ec(enum platform_profile_option profile)
 	return 0;
 }
 
-static int platform_profile_omen_set(struct platform_profile_handler *pprof,
+static int platform_profile_omen_set(struct device *dev,
 				     enum platform_profile_option profile)
 {
 	int err;
@@ -1345,7 +1345,7 @@ static int thermal_profile_set(int thermal_profile)
 							   sizeof(thermal_profile), 0);
 }
 
-static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
+static int hp_wmi_platform_profile_get(struct device *dev,
 					enum platform_profile_option *profile)
 {
 	int tp;
@@ -1374,7 +1374,7 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
+static int hp_wmi_platform_profile_set(struct device *dev,
 					enum platform_profile_option profile)
 {
 	int err, tp;
@@ -1440,11 +1440,11 @@ static int platform_profile_victus_get_ec(enum platform_profile_option *profile)
 	return 0;
 }
 
-static int platform_profile_victus_get(struct platform_profile_handler *pprof,
+static int platform_profile_victus_get(struct device *dev,
 				       enum platform_profile_option *profile)
 {
 	/* Same behaviour as platform_profile_omen_get */
-	return platform_profile_omen_get(pprof, profile);
+	return platform_profile_omen_get(dev, profile);
 }
 
 static int platform_profile_victus_set_ec(enum platform_profile_option profile)
@@ -1472,7 +1472,7 @@ static int platform_profile_victus_set_ec(enum platform_profile_option profile)
 	return 0;
 }
 
-static int platform_profile_victus_set(struct platform_profile_handler *pprof,
+static int platform_profile_victus_set(struct device *dev,
 				       enum platform_profile_option profile)
 {
 	int err;
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index ed0d880a07a9..fc317f42bb82 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -933,10 +933,10 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
  * dytc_profile_get: Function to register with platform_profile
  * handler. Returns current platform profile.
  */
-static int dytc_profile_get(struct platform_profile_handler *pprof,
+static int dytc_profile_get(struct device *dev,
 			    enum platform_profile_option *profile)
 {
-	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
+	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
 
 	*profile = dytc->current_profile;
 	return 0;
@@ -986,10 +986,10 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
  * dytc_profile_set: Function to register with platform_profile
  * handler. Sets current platform profile.
  */
-static int dytc_profile_set(struct platform_profile_handler *pprof,
+static int dytc_profile_set(struct device *dev,
 			    enum platform_profile_option profile)
 {
-	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
+	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
 	struct ideapad_private *priv = dytc->priv;
 	unsigned long output;
 	int err;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 471fca50d1c9..47d2dbbf3392 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -84,10 +84,10 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
  *         0x0: No Error
  *         0x1: Error
  */
-static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
+static int inspur_platform_profile_set(struct device *dev,
 				       enum platform_profile_option profile)
 {
-	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
+	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
 	u8 ret_code[4] = {0, 0, 0, 0};
 	int ret;
 
@@ -131,10 +131,10 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
  *         0x1: Performance Mode
  *         0x2: Power Saver Mode
  */
-static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
+static int inspur_platform_profile_get(struct device *dev,
 				       enum platform_profile_option *profile)
 {
-	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
+	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
 	u8 ret_code[4] = {0, 0, 0, 0};
 	int ret;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 8be3f4e5366d..0abe22228fdb 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10415,7 +10415,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
  * dytc_profile_get: Function to register with platform_profile
  * handler. Returns current platform profile.
  */
-static int dytc_profile_get(struct platform_profile_handler *pprof,
+static int dytc_profile_get(struct device *dev,
 			    enum platform_profile_option *profile)
 {
 	*profile = dytc_current_profile;
@@ -10490,7 +10490,7 @@ static int dytc_cql_command(int command, int *output)
  * dytc_profile_set: Function to register with platform_profile
  * handler. Sets current platform profile.
  */
-static int dytc_profile_set(struct platform_profile_handler *pprof,
+static int dytc_profile_set(struct device *dev,
 			    enum platform_profile_option profile)
 {
 	int perfmode;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 1c8fdda51eaa..5296d886c243 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -34,10 +34,8 @@ struct platform_profile_handler {
 	struct device class_dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(struct platform_profile_handler *pprof,
-				enum platform_profile_option *profile);
-	int (*profile_set)(struct platform_profile_handler *pprof,
-				enum platform_profile_option profile);
+	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
+	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
-- 
2.48.1


