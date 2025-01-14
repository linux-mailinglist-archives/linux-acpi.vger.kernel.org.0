Return-Path: <linux-acpi+bounces-10604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF0A10B06
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAC67A16F9
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E31BEF6F;
	Tue, 14 Jan 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RztDmSFx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7501B86D5;
	Tue, 14 Jan 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869100; cv=none; b=fhbfqUijRUeNfKdEEi2yiiG9IzhtpNw6L+ow5Ym/yXUljyyuEqqnMkJgS7HCTUThc5px8NHokF8oMOzjDYaQH9Os2AaDRihR0w0tZno6y5xb0rgSZijohxKLyrf+yiK46o8Z9v4+3LE+fQEO40jezKsc9TYadSNjvD+yTLa3qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869100; c=relaxed/simple;
	bh=82eQC9klNSFqtGaT329SfgzrJxkXMUZBCWK1h1R6ST8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oomm6duQG/edTJzO38Y3Y6N8Zx8mjlq1kIKISVJw5ZJitbLyyJ3RvXtY8fpDOZIQoDfwBewLaIhdQWNsPzjbHNTe395ic+i21QJT6+O5rr7VTdM3q8SNmZ57F99PIEV5rZ9O8WrYO5M62I4Rx/ATEQjw40ELGaEA4aHK8Ud5pBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RztDmSFx; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51640f7bbd3so1964346e0c.2;
        Tue, 14 Jan 2025 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869097; x=1737473897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySI44wHMd6hWEJyphRfrgYl/KVBkiGy3++Z8m9ef+ig=;
        b=RztDmSFx0E5d7/u0vLnnUunWKnJ3WAXYi0Or9gfKterqXETS2iqC0nCmGX5xhBmaqs
         dOoYPC9NdbnVwi9+M2Lto2E1hn9rj3QODw06MLr5AGpqhoqbptkZRHJqiOIJfpJSoBVj
         cOtwjsysB32vk0oeKoy6e7EQ9PYwEdJKOmLYgCCCDVieLpv9Xx53dgmxT/ZY8KzbgCK2
         zrqLPR2x6PpoC8LV5zr4Zt4pKubXQZKWW2M2NUxRcxpd3UvFniG1ZtXYiNHX6IiKJund
         EniKauBzoDjbel5+UWKyLrlC//12FOkAwZuuXAYd5DIF/erYrzIBn+k67GAxX2/K0sF1
         4eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869097; x=1737473897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySI44wHMd6hWEJyphRfrgYl/KVBkiGy3++Z8m9ef+ig=;
        b=R/GFGUm4mrz0+7wGQkqUJ39Zpjx0+TYsfDAk6/BMlcw0lusVpcyD+vE6JYfUkSy45o
         CxtIbSPmsWrlk9nmlcT5NI+6gUSQEHjVeJ6A/7z/8S4IAZOf8te3vSAiRLUnBNTexDJr
         2F+h2d6po4kG8I2/v3HgzMaw7r4oVJk+39K0XzbwRyO2VhT/JFeOAWaw7qIhVca/6eEJ
         EDV56ufCBpPeGB0c9RyCPmmVZ2ro2k/YkZLV3omJU8zB+byJwPWACFLhLmwhHQaYaOjo
         rsXVdwjKlgVb5Ir2wzj9qSJesE6mhfcUfVEFQmo/wbJ5YawpO+3qJdLFH7ozhAfx2UhD
         /j/w==
X-Forwarded-Encrypted: i=1; AJvYcCUdqUN18ljTWe7qg1LvdP3ceDPxpE06EjnTYM5qFCI+o27CQv7E3nUGnB2Os32GCPrwtHsw4MAdZBKOeBdZ@vger.kernel.org, AJvYcCX0+KWbaALdQHXWUq6/lSHWTU3PynMyQadGpF5T7bXIsVfhs9HhSDAL4WCXbBQ5CUQWGF2WLY/N1RAr@vger.kernel.org
X-Gm-Message-State: AOJu0YzUCHua6A5KjiAN33mOTAw7uTAzUcOFNPMShDP5hd/s2r/zcRz6
	BL4J3iv95IgnVUqQeIg5MC/eJNN2ocsWwfJldWFOll+za3CDf7Wrg9cLaw==
X-Gm-Gg: ASbGncuLQ9gKG6bR6tWk8zRgTGWpKbulDlDIkpiKCirpmki+puOlzpZLZufRmVm5ZPc
	ffs9KJZroyh4xqBkMSr3JPCM4WmXNet4N9jcWxOmj+a7AIHAT/K7YJ5WjVBkIhZdjpKJNWWJKMU
	9w9K+2+zdnEuX1inbYd0McYgNG0kZO+1PJoUL5L/jzNx/1aKCsWL471G1o1SvVsEVQ0MTyvnfAb
	qN8J3kRBPpnOr9sthVhazt7mFCg9AIrc/lAsByjVePKOUnFdgz50g/LH3qaYgBY
X-Google-Smtp-Source: AGHT+IEHUlCP3LuXN1vX4qy3WDkCIQd+CmblebYqZ2uA8LzKrX9+rmFFDIdKYr5SQr1nK5zSx7VLqg==
X-Received: by 2002:a1f:c743:0:b0:51c:c23e:8cd3 with SMTP id 71dfb90a1353d-51cc23e8d8bmr3850273e0c.4.1736869096554;
        Tue, 14 Jan 2025 07:38:16 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:16 -0800 (PST)
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
Subject: [PATCH v2 03/18] ACPI: platform_profile: Remove platform_profile_handler from callbacks
Date: Tue, 14 Jan 2025 10:37:11 -0500
Message-ID: <20250114153726.11802-4-kuurtb@gmail.com>
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

Devices can now set drvdata to the class device, thus passing the
platform_profile_handler to callbacks is unnecessary. Instead pass the
class device.

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
index f8741201deea..66170fe436f0 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -66,7 +66,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->profile_set(handler, *bit);
+	return handler->profile_set(dev, *bit);
 }
 
 /**
@@ -103,7 +103,7 @@ static int get_class_profile(struct device *dev,
 
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
index 4594beb4b9d7..d609bd105db3 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1843,7 +1843,7 @@ static int acer_toggle_turbo(void)
 }
 
 static int
-acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
+acer_predator_v4_platform_profile_get(struct device *dev,
 				      enum platform_profile_option *profile)
 {
 	u8 tp;
@@ -1878,7 +1878,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
 }
 
 static int
-acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
+acer_predator_v4_platform_profile_set(struct device *dev,
 				      enum platform_profile_option profile)
 {
 	int tp;
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
index 0c68635a0aa3..9bed170abb92 100644
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
index 28c39e25228e..b8131b803368 100644
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
index fe37c26891d8..47f87bb213a9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10414,7 +10414,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
  * dytc_profile_get: Function to register with platform_profile
  * handler. Returns current platform profile.
  */
-static int dytc_profile_get(struct platform_profile_handler *pprof,
+static int dytc_profile_get(struct device *dev,
 			    enum platform_profile_option *profile)
 {
 	*profile = dytc_current_profile;
@@ -10489,7 +10489,7 @@ static int dytc_cql_command(int command, int *output)
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
2.47.1


