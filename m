Return-Path: <linux-acpi+bounces-10464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B206CA07B5A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA01695C8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580822332C;
	Thu,  9 Jan 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqA4Os84"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5421E0B2;
	Thu,  9 Jan 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435367; cv=none; b=GzJxxELZASjBq76kvKKQK8y28ylKyjKaa56LTqEnvwERHapNrNVmA7QEcmN6Q6SvoREHRpKi0fb08GoSUXRii+KNO8LVr0vrUjGGAdTfwddw5JvN7wAUyEaj3uh+B941/7R93AjI5hML2b4J5aid3QmMjXY0R3/yPV4cN1rT0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435367; c=relaxed/simple;
	bh=i1hkCbOJ7q5N58BzzZuDKEF4nYTEIMOkaF5e1YHrW2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtFaQ6jDYKNbj1E2qjGin7ccIv+hN53JHW93dGGoTtBiIWAYJ8q4KhROvmoFWczPEUKp1HbtfCr87JDOC3HlysBkqV4Jm3wAAMGXhFWTWG88PuMD1X5Y4ywD/9LxoxgC+JKbgVH4Kkjm7luXTW5QSBVMPwAagR+YLn0CDqARahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqA4Os84; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afd68271b6so369736137.0;
        Thu, 09 Jan 2025 07:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435363; x=1737040163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtwVtWXb7+6+BigRjgrXxEKF2qLe5aBj3AnEv8mSJuQ=;
        b=WqA4Os84wMQb74Anzzv3qSWiGSyddbVYCkn5Mpru41TJyYx8ISAjYvOVV7Q9iu2aSL
         VbM/AcFs6LIginWARq4XFTr3Q+uuiPAcAHYooBL2W2A4IQReraB7f64NkppAnbZS0ZiF
         nZfI3Y6TuhwDZ6RRGmdyxAO+ouq1UdeWOJ4rHkuHopSWsA7kd2f7f8r7H4FGuxZ7byem
         2ZFXtbtYEockIhgZpzuc1LQPafhAeHfpPZdvgn5fiGE3Bl2LK/HPdl4rlmyt5WNpx8II
         UkfwQ+qt5tK7z6hVdGzKnwhZOCFkfwmNIWO27Xw8gpZkeJDp5e4Cj2nPH06qYz1eQbXX
         jSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435363; x=1737040163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtwVtWXb7+6+BigRjgrXxEKF2qLe5aBj3AnEv8mSJuQ=;
        b=oyIg/lqW8ohSYEE1XdHgHgwIs9j0uvSkDoYfLW+b0oQw7IHqv1tB8mZcp8+SuGhFFa
         eJwxwDGoL7Pgm0tfjH5itNjRTbfOFFp8pC1qMDQsFUByEvSjOaXvYKAIKwh+YLm291Dj
         HfRTXPSqNDbBYcQxmJCfiWdASeLpx77SdJHQ0em3k8f/BILVPy6DAJPXE9LPHFu/yNcI
         ZH9z4xiIsXnlEs3fTkdhs3c6VkOLhSzvydFgtYdrPL7nT/3FP0m48rWb3ei13X+2uKDr
         z2wqgw81bnXcze52JYkxUbz2SRia7VC+qYLayG+gAmGZ2Zz5eneijtbArk+NSwmZfB4f
         TphA==
X-Forwarded-Encrypted: i=1; AJvYcCU2K2ToofpUNfferNDmw4N/QRW7hnSmhA9Ufoh3NbXKKN9jzsRm7fTo1hCHNhrXL83Y1rvpIqiIpYsMoSY4@vger.kernel.org, AJvYcCUISdFgW4+Ed3Rbrihv2S8dvjO6vVz/bGudlhLfKk/1OGbcQYQUKIPRyxAE3fwLzoGHApkbGd449Hp4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4a2I8fK9k+2gGhc/3p2ychWUCxoDe3V2F8mPAb+Wzv44Yyet
	NCtuf+hZrGQ8KLWitd5Qf2DxIe9MUfETqqDM+nYEDjxTO5vdoWT2d0vf09qD
X-Gm-Gg: ASbGncv1cIyG8nNUCKYNMzRIplpXTYeUxxTG2PjbW2F9fHAKLDXrYHixmSV5GMz0eR/
	YTb/u4Rve9umGESH5uDDKAhKxUPOmQ44JUBtARqpJSM2v72GnIa98kvzV6iPXEWcpSMFW47I6bP
	caIAGh2aHCUZ4YeRUmTwcwcU/veF7YQGleYLjHXl0LYdSKqnJruFhxrHNgLRgJ/KzSLGIVu2EeU
	ZHDDOiD40XOKz6L12Txf3fgFrMawzraVJzP1aT7ksJXKqfJlWQbmOfQFuWiTmRG
X-Google-Smtp-Source: AGHT+IEMJjK53/5tqcyv5W9ab1/qYLjDiCsFQ9+SvzwlB5Ic3l/z2qaQ4b3TjqaR47c4JzoeCMxiOg==
X-Received: by 2002:a05:6102:290f:b0:4b2:5d63:a0f3 with SMTP id ada2fe7eead31-4b3d0f2d89cmr5797297137.15.1736435363284;
        Thu, 09 Jan 2025 07:09:23 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:22 -0800 (PST)
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
Subject: [PATCH 15/18] ACPI: platform_profile: Remove platform_profile_handler from callbacks
Date: Thu,  9 Jan 2025 10:06:28 -0500
Message-ID: <20250109150731.110799-16-kuurtb@gmail.com>
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

Devices can now set drvdata to the class device, thus passing the
platform_profile_handler to callbacks is unnecessary. Instead pass the
class device.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               |  6 ++--
 .../surface/surface_platform_profile.c        | 18 ++++++------
 drivers/platform/x86/acer-wmi.c               | 16 +++++------
 drivers/platform/x86/amd/pmf/sps.c            | 16 +++++------
 drivers/platform/x86/asus-wmi.c               | 16 +++++------
 drivers/platform/x86/dell/alienware-wmi.c     | 12 ++++----
 drivers/platform/x86/dell/dell-pc.c           | 14 +++++-----
 drivers/platform/x86/hp/hp-wmi.c              | 28 +++++++++----------
 drivers/platform/x86/ideapad-laptop.c         | 16 +++++------
 .../platform/x86/inspur_platform_profile.c    | 16 +++++------
 drivers/platform/x86/thinkpad_acpi.c          | 12 ++++----
 include/linux/platform_profile.h              |  8 ++----
 12 files changed, 88 insertions(+), 90 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fdf79b81b62e..8d034d928e32 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -67,7 +67,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
-	return handler->ops->profile_set(handler, *bit);
+	return handler->ops->profile_set(dev, *bit);
 }
 
 /**
@@ -104,7 +104,7 @@ static int get_class_profile(struct device *dev,
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	err = handler->ops->profile_get(handler, &val);
+	err = handler->ops->profile_get(dev, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
 		return err;
@@ -490,7 +490,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	if (!pprof)
 		return ERR_PTR(-ENOMEM);
 
-	err = ops->choices(pprof);
+	err = ops->choices(drvdata, pprof->choices);
 	if (err < 0)
 		return ERR_PTR(err);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 965940223892..0d059986cc5c 100644
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
@@ -201,12 +201,12 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
 	return tp;
 }
 
-static int ssam_platform_profile_choices(struct platform_profile_handler *pprof)
+static int ssam_platform_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 2059b29dd36b..2900ba060cc4 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1827,7 +1827,7 @@ static int acer_toggle_turbo(void)
 }
 
 static int
-acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
+acer_predator_v4_platform_profile_get(struct device *dev,
 				      enum platform_profile_option *profile)
 {
 	u8 tp;
@@ -1862,7 +1862,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
 }
 
 static int
-acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
+acer_predator_v4_platform_profile_set(struct device *dev,
 				      enum platform_profile_option profile)
 {
 	int tp;
@@ -1901,13 +1901,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 }
 
 static int
-acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
+acer_predator_v4_platform_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
-	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e8d2de9bb646..700a6ef39201 100644
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
@@ -387,11 +387,11 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int amd_pmf_profile_choices(struct platform_profile_handler *pprof)
+static int amd_pmf_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 809ab0353b68..11e5fcecf3a4 100644
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
@@ -3852,11 +3852,11 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	return throttle_thermal_policy_write(asus);
 }
 
-static int asus_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
+static int asus_wmi_platform_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 1eaa746eb4f1..19b7cd95018c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1055,7 +1055,7 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
 	return 0;
 }
 
-static int thermal_profile_get(struct platform_profile_handler *pprof,
+static int thermal_profile_get(struct device *dev,
 			       enum platform_profile_option *profile)
 {
 	u32 out_data;
@@ -1081,7 +1081,7 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int thermal_profile_set(struct platform_profile_handler *pprof,
+static int thermal_profile_set(struct device *dev,
 			       enum platform_profile_option profile)
 {
 	if (quirks->gmode) {
@@ -1107,7 +1107,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static int thermal_profile_choices(struct platform_profile_handler *pprof)
+static int thermal_profile_choices(void *drvdata, unsigned long *choices)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1140,17 +1140,17 @@ static int thermal_profile_choices(struct platform_profile_handler *pprof)
 		profile = wmax_mode_to_platform_profile[mode];
 		supported_thermal_profiles[profile] = out_data;
 
-		set_bit(profile, pprof->choices);
+		set_bit(profile, choices);
 	}
 
-	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST))
+	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
 		return -ENODEV;
 
 	if (quirks->gmode) {
 		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			WMAX_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 4ff80ed4f157..1ba2e58451e1 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -184,7 +184,7 @@ static int thermal_set_mode(enum thermal_mode_bits state)
 	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
 }
 
-static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
+static int thermal_platform_profile_set(struct device *dev,
 					enum platform_profile_option profile)
 {
 	switch (profile) {
@@ -201,7 +201,7 @@ static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
 	}
 }
 
-static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
+static int thermal_platform_profile_get(struct device *dev,
 					enum platform_profile_option *profile)
 {
 	int ret;
@@ -230,16 +230,16 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int thermal_platform_profile_choices(struct platform_profile_handler *pprof)
+static int thermal_platform_profile_choices(void *drvdata, unsigned long *choices)
 {
 	if (supported_modes & DELL_QUIET)
-		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
 	if (supported_modes & DELL_COOL_BOTTOM)
-		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
+		set_bit(PLATFORM_PROFILE_COOL, choices);
 	if (supported_modes & DELL_BALANCED)
-		set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+		set_bit(PLATFORM_PROFILE_BALANCED, choices);
 	if (supported_modes & DELL_PERFORMANCE)
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 1b9e176f8d6f..3849cf761a46 100644
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
@@ -1488,19 +1488,19 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
+static int hp_wmi_platform_profile_choices(void *drvdata, unsigned long *choices)
 {
 	if (is_omen_thermal_profile()) {
-		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
+		set_bit(PLATFORM_PROFILE_COOL, choices);
 	} else if (is_victus_thermal_profile()) {
-		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
 	} else {
-		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
-		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
+		set_bit(PLATFORM_PROFILE_QUIET, choices);
+		set_bit(PLATFORM_PROFILE_COOL, choices);
 	}
 
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 55aac0190624..1937a2f00bec 100644
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
@@ -1023,11 +1023,11 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return -EINTR;
 }
 
-static int dytc_profile_choices(struct platform_profile_handler *pprof)
+static int dytc_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 9e2f24de0207..3d45df807b8b 100644
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
 
@@ -164,11 +164,11 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int inspur_platform_profile_choices(struct platform_profile_handler *pprof)
+static int inspur_platform_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 964f842ef756..2e9740b7e328 100644
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
@@ -10539,11 +10539,11 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return err;
 }
 
-static int dytc_profile_choices(struct platform_profile_handler *pprof)
+static int dytc_profile_choices(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
 	return 0;
 }
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 97ce9bd476ab..0824a12b9998 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -31,11 +31,9 @@ enum platform_profile_option {
 struct platform_profile_handler;
 
 struct platform_profile_ops {
-	int (*profile_get)(struct platform_profile_handler *pprof,
-				enum platform_profile_option *profile);
-	int (*profile_set)(struct platform_profile_handler *pprof,
-				enum platform_profile_option profile);
-	int (*choices)(struct platform_profile_handler *pprof);
+	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
+	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
+	int (*choices)(void *drvdata, unsigned long *choices);
 };
 
 struct platform_profile_handler {
-- 
2.47.1


