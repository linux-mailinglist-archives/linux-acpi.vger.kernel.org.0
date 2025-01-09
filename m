Return-Path: <linux-acpi+bounces-10451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD62A07B2F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBD1882B36
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67A21CFED;
	Thu,  9 Jan 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntSwJ80r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DED21CFEC;
	Thu,  9 Jan 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435285; cv=none; b=DtL6wOX+6eJiNtUP9mk/D4hoc90ExRw5dtqv3q2yiiBgUs86K4U/WODxaj8pxEqI5vtCy84ouWj9pzYG3v1zsA2/L2O/rphlT7KDnF63W7wdMBSjB+XyGYIbflR5zU0B5FMXWPc750oUs40Noj14h6Kcm+PntQfkrkNG/ugeUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435285; c=relaxed/simple;
	bh=rRetxo8v9LWZ8uozl4d/SR2xB+xG/A+f6yMZOFXQVnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPT+ERr0cOdWtsaKcwDdceqX9ueahD9Tbs4q1AzZ0KBwz9hRfm5sfrmGJPc1bdrPk+ngN7Ga5gG3GXr+AFMNtT9toIkheiuSbyQpvU8o34DYMoCi8CMV3Uo9H/Zd+b5SsJjGcGB/zOa2+5N/Jma3HMvEmCzQ95Wg04XXgOoTGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntSwJ80r; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4aff5b3845eso467667137.2;
        Thu, 09 Jan 2025 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435282; x=1737040082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7/ilE4wKe17fP2dMeHsDJvp4dxl8L2B6sowIvQLZLk=;
        b=ntSwJ80rBR15JdnLWZblCWREltpzXYcM328rDvf5GetBu3taBfs61TEMbYm3BUeMB+
         qBKo1n60tHcJENHFVaenCHituaGA+KCp7KJCnmjDXOS/E5OA3kOtZt7RM5R4bGwULyQS
         VRdz976WASSSlwN1wwNVCxA4qW0AlS5dthE/ZgZVa82puVt2yHqLPpXGRXYstSQG+Oam
         d5hjDX4RuDkVdKFhQ3Wg+x2Hl0jH4w/0KNEZKqnKHbvYCaZhetp2tl03/CJ+IbWsWA+G
         7DMe/hgb+jsLLn2yheXgqM9iAQmMXv0//mzH2+zyi1j1pkVGm9B79hN4aI+RjZUnR/LY
         mmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435282; x=1737040082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7/ilE4wKe17fP2dMeHsDJvp4dxl8L2B6sowIvQLZLk=;
        b=nH3GPmr4bDh4WxsxKF+CD/rRtQ+tbIHI6pb60JZSB/Yh+80oIL8jRoUpZDt16RvxCO
         An5UrCnqUZM3uqwUIaGuJvBzNSRHEid4jR9ngIMG+oYn0bi4QMZn0OdDtmqbM3+k1vkO
         p6I95zyVCb0VdjU1Tw/4vIEkhur8eePwmT67WAxsUtIz18S9JKLjkUDKIrb5NbNDlbES
         nlzFNjR3aBOzkjaQXi/set6W7C5ESoRQR75BOb6k81nlA/MOmcHhs45n5TrZLurnvVY8
         d5o63f9bbOhW0iym4R0Fm5Yiv2z7MnKNw7fYw3Jha18zLA7yXxdh9VZCcOMAGkzhLd67
         Y+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAIPn+gkbRyJODVk9ZtIeC0HI9GB9SI+xafgBZXYLpOcmt7b9IBcGLe8Xe2YpQTA23nT2p2KHeNUzY@vger.kernel.org, AJvYcCWonTIeJaoMtzm7M1WXQy0WUzwWrFqWjP9gzJm22gUUOoEUoRUvzwdYYrKO0LWHSqBI2auk40Xh/LVskJYL@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0z57r+Xv2Ikuzh6Dy65VGVOnRSuOTLMzKoOlSJ45SLPnIBQZ
	LVgfxbCRZ6lgC9Gl7f1V4tOooYNf38zFGLQu8f/LtjjaOAPbV5kjke22bm/W
X-Gm-Gg: ASbGncuxOehSki+IMbt918mOv6lH/9LuoYzDKGO1HUaJzSQCFpwVfWgjOQIeCunPTo5
	p14WG5UNLa+OIOGkc6LUp2jILPSBdagVXN+dRCw9todyJjbm4Imf9Gr/TXUz058X3V6PYmvdPAq
	IokaSSFcRBjNNGfZaXjKfG9bEkoHm72RmKOS7s/3n0e2fhBtXPdlAbMnItWSrDDWjFcNiQLqqAy
	08+V/Atm3pVlD4dB77eKy6Ldd/u+D80342iNcxoC/NEq+qN8oC+skNplLILZIfm
X-Google-Smtp-Source: AGHT+IFguFKf1b92s0mVyF7N4sniR6KrG7JkdNcMGWyYMmpLnYoCmUSh5BO+i26XkRYHZZrb0D/tZg==
X-Received: by 2002:a05:6102:5128:b0:4af:a98a:bd67 with SMTP id ada2fe7eead31-4b3d0f619f7mr6263797137.3.1736435281416;
        Thu, 09 Jan 2025 07:08:01 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:01 -0800 (PST)
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
Subject: [PATCH 02/18] ACPI: platform_profile: Add `choices` to platform_profile_ops
Date: Thu,  9 Jan 2025 10:06:15 -0500
Message-ID: <20250109150731.110799-3-kuurtb@gmail.com>
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

Add a `choices` callback to platform_profile_ops, which lets drivers
specify how to select available profiles.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               | 13 +++++++--
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
 12 files changed, 137 insertions(+), 71 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 39a22e27acc5..9cb82173947c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -464,12 +464,21 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	int err;
 
 	/* Sanity check the profile handler */
-	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
+	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
+	    !pprof->ops->choices) {
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
 
+	err = pprof->ops->choices(pprof);
+	if (err < 0)
+		return err;
+
+	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
+		pr_err("platform_profile: no available profiles\n");
+		return -EINVAL;
+	}
+
 	guard(mutex)(&profile_lock);
 
 	/* create class interface for individual handler */
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 2a9716372d56..b69fcc4c3858 100644
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
 	.profile_get = ssam_platform_profile_get,
 	.profile_set = ssam_platform_profile_set,
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
index ac7b3ab8fd2a..1fa0cd69da8c 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1900,9 +1900,22 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int
+acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
 	.profile_get = acer_predator_v4_platform_profile_get,
 	.profile_set = acer_predator_v4_platform_profile_set,
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
index 7c8391ac4dbb..37316bc3e071 100644
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
 	.profile_get = amd_pmf_profile_get,
 	.profile_set = amd_pmf_profile_set,
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
index ef4129d91656..3e94986078a6 100644
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
 	.profile_get = asus_wmi_platform_profile_get,
 	.profile_set = asus_wmi_platform_profile_set,
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
index c824414565b6..386b22e9c922 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,12 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static const struct platform_profile_ops awcc_platform_profile_ops = {
-	.profile_get = thermal_profile_get,
-	.profile_set = thermal_profile_set,
-};
-
-static int create_thermal_profile(struct platform_device *platform_device)
+static int thermal_profile_choices(struct platform_profile_handler *pprof)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1146,19 +1141,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
 		profile = wmax_mode_to_platform_profile[mode];
 		supported_thermal_profiles[profile] = out_data;
 
-		set_bit(profile, pp_handler.choices);
+		set_bit(profile, pprof->choices);
 	}
 
-	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
+	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST))
 		return -ENODEV;
 
 	if (quirks->gmode) {
 		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			WMAX_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
 	}
 
+	return 0;
+}
+
+static const struct platform_profile_ops awcc_platform_profile_ops = {
+	.profile_get = thermal_profile_get,
+	.profile_set = thermal_profile_set,
+	.choices = thermal_profile_choices,
+};
+
+static int create_thermal_profile(struct platform_device *platform_device)
+{
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
 	pp_handler.ops = &awcc_platform_profile_ops;
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 1751b7235031..ba366c28d9a6 100644
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
+		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+	if (supported_modes & DELL_COOL_BOTTOM)
+		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
+	if (supported_modes & DELL_BALANCED)
+		set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	if (supported_modes & DELL_PERFORMANCE)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static const struct platform_profile_ops dell_pc_platform_profile_ops = {
 	.profile_get = thermal_platform_profile_get,
 	.profile_set = thermal_platform_profile_set,
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
index c37e44f7606c..3c2d4549eb7f 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
+{
+	if (is_omen_thermal_profile()) {
+		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
+	} else if (is_victus_thermal_profile()) {
+		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+	} else {
+		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
+		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
+	}
+
+	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
+
+	return 0;
+}
+
 static int omen_powersource_event(struct notifier_block *nb,
 				  unsigned long value,
 				  void *data)
@@ -1568,16 +1585,19 @@ static inline void omen_unregister_powersource_event_handler(void)
 static const struct platform_profile_ops platform_profile_omen_ops = {
 	.profile_get = platform_profile_omen_get,
 	.profile_set = platform_profile_omen_set,
+	.choices = hp_wmi_platform_profile_choices,
 };
 
 static const struct platform_profile_ops platform_profile_victus_ops = {
 	.profile_get = platform_profile_victus_get,
 	.profile_set = platform_profile_victus_set,
+	.choices = hp_wmi_platform_profile_choices,
 };
 
 static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
 	.profile_get = hp_wmi_platform_profile_get,
 	.profile_set = hp_wmi_platform_profile_set,
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
index b49ee94f9bee..f5ea03763a54 100644
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
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
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
index 38d4745f6be1..8fa9308d4686 100644
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
 	.profile_get = inspur_platform_profile_get,
 	.profile_set = inspur_platform_profile_set,
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
index 04a292af2bfc..a35453c3c605 100644
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
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
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
index a9db95bc360d..972a62be60b2 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -34,6 +34,7 @@ struct platform_profile_ops {
 				enum platform_profile_option *profile);
 	int (*profile_set)(struct platform_profile_handler *pprof,
 				enum platform_profile_option profile);
+	int (*choices)(struct platform_profile_handler *pprof);
 };
 
 struct platform_profile_handler {
-- 
2.47.1


