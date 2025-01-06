Return-Path: <linux-acpi+bounces-10361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46721A01EA6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 05:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574037A146E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 04:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAA1D5174;
	Mon,  6 Jan 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETT2u6ZM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E841C7F;
	Mon,  6 Jan 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138815; cv=none; b=sPyw8HdvAznNcN0HjTh0hu4c6H6c53v9zoI3PB4P/ig/E/wwS6aEL/lqoqpg9zlA1jSxyxmOekMVb+Hf2PA13eF6fv7tAUMSNiYzz0PIDm69Weeopk5jWsl8H5gPg7OfJYJQanE9vXrFQiTJ7w0bOkTSXdJky7It84n74n4zBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138815; c=relaxed/simple;
	bh=7sTwsn5fhRpKqwr+KgkCgwUcMWIj9Zrs6hBSIYHXWk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwohtCHyLFpGlAFf+XgWAucQk77CkBtiRN1E7FUwjrjT1DSt3hPOa2VweMMMByO+f3MfAac2LirfArFu/171yJx0YbfzCWDonFGctsLbK7G+pIH8Ga4cu7kul4D1VyKKNcvMwH0T9XvnS7Yp1eUGNwxHCGNh56dMMtvUpGOLBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETT2u6ZM; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85b88a685e6so5779092241.2;
        Sun, 05 Jan 2025 20:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736138811; x=1736743611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hblwEIAZFbdlwF+mphchL8/O5FbVv8+XycWtdMpU6QM=;
        b=ETT2u6ZMZFAW0FskhTU5T0ia9A87HQaizcPrfFk2dmV7FC0NctA0cPar3Ty09NJ9mE
         OrBte/sALG0/dQAJWvXG9lzjvMBcDZLm6FMClZW2rtL0S3LuOMLEr12IaQKEy5YdO3Kf
         XLxNjSSAs2LLjkmrwZcrMgvLN2bheUA4WHIWRD58qPxcs7+n4HZ9R1UOuZV6ymJOZltW
         ZJL8AaQUjpo4b6AwQIFKiXr1EwUvd/0guPxAiRcp7BLN1B6S5dAF+KfAXm0NtshGF/HD
         KAiW3bOWuxmvcdbRln4aPTQ8uZapc5QHUQZjYnsjrRiUed+o2xRlPUqCixmFXi2BFquO
         Qzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736138811; x=1736743611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hblwEIAZFbdlwF+mphchL8/O5FbVv8+XycWtdMpU6QM=;
        b=skSrZza7aRZtZp/N67R8UIVPhWT9krtw3a5arP8ts2vfzIH3Z5AYEa8/ZKOCfFFVUS
         5gwc+7R4KcFoRm7kkxOBF6MNJ6fn2uJmx5GrxN+Iuw0fnuVE9M5bSVfcv5mdTWQFOmHG
         3wtetNoz7P/VWPqBpu9dqThhh76d8PbRtTrfx/ou1RCgVxZMnM2lfQwHgZ2W9t/HiGnn
         I5bAYX+LxCoyUdhP36TZlMOKVdwcgAAMS39pQXhIoj7T7SmBoYlpXpTvdIhXCGcl+J9Y
         XJfjehV448Voy2Rz96SzZJZWREPzXzld13bJmGoAepdk1gsV6wp+PJ1idc4uqwgRFtLs
         sqFg==
X-Forwarded-Encrypted: i=1; AJvYcCUwd0L6LFoC9GjnyfPYwLFiYgvTg3ah5VR2TwdGqVNYi/2FmxLasuhz3ODt4C3bilnpVXJKbm1akwS/zfES@vger.kernel.org, AJvYcCVlyXtE6xSltKhQcNe+3rYLKamslYgPKWsGifVGc5mOJRs4Zuy4rvy0NrG4jPgWgAVd41LRb3PTBjUe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vZEt3UFuoIQVcwx6RmQH5ieEVG+f3DcgI2QGo9qaPfJqo9h6
	mW45soWrJkdNB6KnUfhrRHYzCVJgOFj5Td/3hAMPfCVLCa8X81YYJVZTJNCw
X-Gm-Gg: ASbGncuQtdbr0/wR+4qZGtOuBRY3t5MgNt9vJuIrWBQLnDqIYK9kRuzQ2LcbKBT85jj
	UbFrGOF3BjXnjgttPwPA7KX/SFQ2qOq+Ld1qiE6KpY3a9tb85TjPBS09dzHbpDlMD5srWQ6NVyf
	OZegkPgWcTzxxX1WgZ8OFGndlgaTOyjVx/fPPWJ3EOhNcK1uib8jt+DuRzlrdXXb3dlwnYKaO6B
	1m5VX08eq6mwObgu5UqysmnP/hADdR6FmLqBWThY008arUAN8J2tnVRE1MnTMbb
X-Google-Smtp-Source: AGHT+IGKTAwSpiJ8SGjIft2TI8gKEnxb9QJ6i+BpdL7nW8Rzqj5GDRg1bHJmy+56DoKZ5izIEj6T4A==
X-Received: by 2002:a05:6102:548f:b0:4b2:ae3e:3ff with SMTP id ada2fe7eead31-4b2cc48a5eemr40103759137.27.1736138811496;
        Sun, 05 Jan 2025 20:46:51 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf98d1c9sm7083507137.4.2025.01.05.20.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 20:46:50 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [RFC PATCH 2/3] ACPI: platform_profile: Add `choices` to platform_profile_ops
Date: Sun,  5 Jan 2025 23:45:50 -0500
Message-ID: <20250106044605.12494-3-kuurtb@gmail.com>
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

Add a `choices` callback to platform_profile_ops, which lets drivers
specify how to select available profiles.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               | 12 ++++++--
 .../surface/surface_platform_profile.c        | 16 ++++++----
 drivers/platform/x86/acer-wmi.c               | 24 ++++++++-------
 drivers/platform/x86/amd/pmf/sps.c            | 15 ++++++----
 drivers/platform/x86/asus-wmi.c               | 16 ++++++----
 drivers/platform/x86/dell/alienware-wmi.c     | 21 ++++++++------
 drivers/platform/x86/dell/dell-pc.c           | 26 ++++++++++-------
 drivers/platform/x86/hp/hp-wmi.c              | 29 +++++++++++++------
 drivers/platform/x86/ideapad-laptop.c         | 15 ++++++----
 .../platform/x86/inspur_platform_profile.c    | 14 ++++++---
 drivers/platform/x86/thinkpad_acpi.c          | 15 ++++++----
 include/linux/platform_profile.h              |  1 +
 12 files changed, 133 insertions(+), 71 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 68e496ff5176..ec749c2d0695 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -464,14 +464,22 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	int err;
 
 	/* Sanity check the profile handler */
-	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-	    !pprof->ops->set || !pprof->ops->get) {
+	if (!pprof || !pprof->ops->set || !pprof->ops->get || !pprof->ops->choices) {
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
 
 	guard(mutex)(&profile_lock);
 
+	err = pprof->ops->choices(pprof);
+	if (err < 0)
+		return err;
+
+	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
+		pr_err("platform_profile: no available profiles\n");
+		return -EINVAL;
+	}
+
 	/* create class interface for individual handler */
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
 	if (pprof->minor < 0)
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 8077d556e616..173f89d59c31 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -201,9 +201,20 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
 	return tp;
 }
 
+static int ssam_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops ssam_platform_profile_ops = {
 	.get = ssam_platform_profile_get,
 	.set = ssam_platform_profile_set,
+	.choices = ssam_platform_profile_choices,
 };
 
 static int surface_platform_profile_probe(struct ssam_device *sdev)
@@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
-
 	return platform_profile_register(&tpd->handler);
 }
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 26d6b9cdfd12..deaadada5506 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1900,9 +1900,22 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int
+acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, platform_profile_handler.choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
 	.get = acer_predator_v4_platform_profile_get,
 	.set = acer_predator_v4_platform_profile_set,
+	.choices = acer_predator_v4_platform_profile_choices,
 };
 
 static int acer_platform_profile_setup(struct platform_device *device)
@@ -1915,17 +1928,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
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
 		err = platform_profile_register(&platform_profile_handler);
 		if (err)
 			return err;
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 1b87254a7120..e6132edcab1b 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -387,9 +387,19 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int amd_pmf_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops amd_pmf_profile_ops = {
 	.get = amd_pmf_profile_get,
 	.set = amd_pmf_profile_set,
+	.choices = amd_pmf_profile_choices,
 };
 
 int amd_pmf_init_sps(struct amd_pmf_dev *dev)
@@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	dev->pprof.dev = dev->dev;
 	dev->pprof.ops = &amd_pmf_profile_ops;
 
-	/* Setup supported modes */
-	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
-
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dev->pprof);
 	if (err)
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d0828b1499b1..850225adf05c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3852,9 +3852,19 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	return throttle_thermal_policy_write(asus);
 }
 
+static int asus_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
 	.get = asus_wmi_platform_profile_get,
 	.set = asus_wmi_platform_profile_set,
+	.choices = asus_wmi_platform_profile_choices,
 };
 
 static int platform_profile_setup(struct asus_wmi *asus)
@@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED,
-		asus->platform_profile_handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE,
-		asus->platform_profile_handler.choices);
-
 	err = platform_profile_register(&asus->platform_profile_handler);
 	if (err == -EEXIST) {
 		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index dd6b7d16b567..28cc9f01f70c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,12 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static const struct platform_profile_ops awcc_platform_profile_ops = {
-	.get = thermal_profile_get,
-	.set = thermal_profile_set,
-};
-
-static int create_thermal_profile(struct platform_device *platform_device)
+static int thermal_profile_choices(struct platform_profile_handler *pprof)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1149,9 +1144,6 @@ static int create_thermal_profile(struct platform_device *platform_device)
 		set_bit(profile, pp_handler.choices);
 	}
 
-	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
-		return -ENODEV;
-
 	if (quirks->gmode) {
 		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			WMAX_THERMAL_MODE_GMODE;
@@ -1159,6 +1151,17 @@ static int create_thermal_profile(struct platform_device *platform_device)
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
 	}
 
+	return 0;
+}
+
+static const struct platform_profile_ops awcc_platform_profile_ops = {
+	.get = thermal_profile_get,
+	.set = thermal_profile_set,
+	.choices = thermal_profile_choices,
+};
+
+static int create_thermal_profile(struct platform_device *platform_device)
+{
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
 	pp_handler.ops = &awcc_platform_profile_ops;
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 9af63a9bdefe..ae49f6055aff 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -24,6 +24,7 @@
 #include "dell-smbios.h"
 
 static struct platform_device *platform_device;
+static int supported_modes;
 
 static const struct dmi_system_id dell_device_table[] __initconst = {
 	{
@@ -231,15 +232,29 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int thermal_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	if (supported_modes & DELL_QUIET)
+		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
+	if (supported_modes & DELL_COOL_BOTTOM)
+		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
+	if (supported_modes & DELL_BALANCED)
+		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
+	if (supported_modes & DELL_PERFORMANCE)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops dell_pc_platform_profile_ops = {
 	.get = thermal_platform_profile_get,
 	.set = thermal_platform_profile_set,
+	.choices = thermal_platform_profile_choices,
 };
 
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
 	ret = platform_profile_register(thermal_handler);
 	if (ret)
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index dbd19d93fdd6..3285e72f312d 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	if (is_omen_thermal_profile()) {
+		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	} else if (is_victus_thermal_profile()) {
+		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
+	} else {
+		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
+		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	}
+
+	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
+
+	return 0;
+}
+
 static int omen_powersource_event(struct notifier_block *nb,
 				  unsigned long value,
 				  void *data)
@@ -1568,16 +1585,19 @@ static inline void omen_unregister_powersource_event_handler(void)
 static const struct platform_profile_ops platform_profile_omen_ops = {
 	.get = platform_profile_omen_get,
 	.set = platform_profile_omen_set,
+	.choices = hp_wmi_platform_profile_choices,
 };
 
 static const struct platform_profile_ops platform_profile_victus_ops = {
 	.get = platform_profile_victus_get,
 	.set = platform_profile_victus_set,
+	.choices = hp_wmi_platform_profile_choices,
 };
 
 static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
 	.get = hp_wmi_platform_profile_get,
 	.set = hp_wmi_platform_profile_set,
+	.choices = hp_wmi_platform_profile_choices,
 };
 
 static int thermal_profile_setup(struct platform_device *device)
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
 
 	err = platform_profile_register(&platform_profile_handler);
 	if (err)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index f3414964c3b9..f5c286572e75 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return -EINTR;
 }
 
+static int dytc_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static void dytc_profile_refresh(struct ideapad_private *priv)
 {
 	enum platform_profile_option profile;
@@ -1066,6 +1075,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
 static const struct platform_profile_ops dytc_profile_ops = {
 	.get = dytc_profile_get,
 	.set = dytc_profile_set,
+	.choices = dytc_profile_choices,
 };
 
 static int ideapad_dytc_profile_init(struct ideapad_private *priv)
@@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.ops = &dytc_profile_ops;
 
-	/* Setup supported modes */
-	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
-
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&priv->dytc->pprof);
 	if (err)
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 6113b87c4858..c4e5ed5429a8 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -166,9 +166,19 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int inspur_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops inspur_platform_profile_ops = {
 	.get = inspur_platform_profile_get,
 	.set = inspur_platform_profile_set,
+	.choices = inspur_platform_profile_choices,
 };
 
 static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
@@ -186,10 +196,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->handler.dev = &wdev->dev;
 	priv->handler.ops = &inspur_platform_profile_ops;
 
-	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
-	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
-	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
-
 	return platform_profile_register(&priv->handler);
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 519d9cb0af57..b9702c29937e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,9 +10538,19 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return err;
 }
 
+static int dytc_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops dytc_profile_ops = {
 	.get = dytc_profile_get,
 	.set = dytc_profile_set,
+	.choices = dytc_profile_choices,
 };
 
 static struct platform_profile_handler dytc_profile = {
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
index 8031bf801d70..7f266a60b41a 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -34,6 +34,7 @@ struct platform_profile_ops {
 			enum platform_profile_option *profile);
 	int (*set)(struct platform_profile_handler *pprof,
 			enum platform_profile_option profile);
+	int (*choices)(struct platform_profile_handler *pprof);
 };
 
 struct platform_profile_handler {
-- 
2.47.1


