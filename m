Return-Path: <linux-acpi+bounces-10663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3291A11AAE
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6345167534
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B30236A6E;
	Wed, 15 Jan 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFAvq1vp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53221234CE7;
	Wed, 15 Jan 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925188; cv=none; b=MaDMP6mkBx7zrZtQzbF53NtgQ2UmvlVOmEIQmEA75v0/brz28gxH+zlN9U8nXGJS+WF9auTpRpLAJ7D3ifK8YRt8OlEebeWWcT056wxOT9oxvBKNQXCt2omGiKPYmRaLejvnjwtFm7ezKTnW7US07v/oxXbfZU7aZ96h9Hrburc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925188; c=relaxed/simple;
	bh=oUgiIM4eBZS5JrQtSe6eSHxl6CCoDN8UTAtVQ3qCp5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnznjIC+EukGW+AsOtyfi/bJVST3kvoKeAWj6emS5TVdzx7LKzP6o7vNPfIuqIawwLgtpp+sC4To4kVLhg8IWxteRDyGTcjURKQ5C4eQy6BYh7rkoeunul5DUcQuRtIrDS1Q/QAs3aa2KafBuB0j70wGGWV0W2l1GrQe2cCeBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFAvq1vp; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5187f0b893dso2229764e0c.3;
        Tue, 14 Jan 2025 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925185; x=1737529985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICKIA+CnJ0rKyaBoi1C3JqntZBHRctlAyF7OogW1eOc=;
        b=NFAvq1vp+WzQBO6HIZHMFJO2I8EOWadNabhzoicM7JuQbSKnfN1ch7smvDVu2VzHqq
         G0sZiwzCkL1ugSwvwLST/eYnU1bMG6duBE8WGbL9HU9fu+sd888c0jYsI6D/u1pKbFpd
         krXMQr87+92jEzej2WcPi2+F2MCYAhc/poIqkmHo9zTBq5ylOLij43fWRdwoIpnlQLli
         dhdOuA7uYTfTsYlFVwnSL66tQ12vpHJDTc/c7qpCJRgmUBHUXDygvXsFC14H88odwY+G
         Pt+8WZ9ldE06V9bBKtw48OsJHshg2rANwGcnLbpH4kz7Z+X5VX+jpy2XP92LMLTWAkR9
         GgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925185; x=1737529985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICKIA+CnJ0rKyaBoi1C3JqntZBHRctlAyF7OogW1eOc=;
        b=fREyGgB5OqpEzG8znxVvY5av+W2sLL031+BCds624oNb00Vaef9VdloXCbBVf3m1gH
         AVlGuzucqMAcwYOSQ4jfFfiaQpmamXZqIeTuKfTpJl3VSdTz5e6HUs45qVf2hamCxSuI
         u5US1Rouxm+fFbIkms4/TmtbyGhQqdSM5ikuKriZ7MD+YxoIHMPCSNl/vmg9xK8wJNba
         3ekrjdGJ3+wmuSLwnp/W0/wYL29vUHCpMyvU+2Us5mnDB/QCDNSUnk6IX1MnRZ3HyL8o
         m0n21amxxRIlKTYGKh4SD8Ab3LAJRKPXh3U54BQ3C8oVoHhcEUBFeQdeQG4bPzCXHnhd
         CPag==
X-Forwarded-Encrypted: i=1; AJvYcCVg7qVv4rVujosXJn01ofL+e5Anj7zKuu8LrLeeXVD4xHjy/qyv0kOyrgyF8DfmEA+1Kh+d4THLwvQa@vger.kernel.org, AJvYcCVy2IMljVOoWTwis/iwpuOv1wHGoSsi7FIHERVVJG/CiTnHGLH/wutL9fXMp78rBTEKQzvnhgB/2lsRYW0F@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTD5DPqobDvC6/ENO5SBZcbiDGRql0dvPGYuIYe5tIaRvdxlr
	K+Bb3GugQgdR/RIud0lHmBClr8rkucSyrZhuqpbVDqjG48wCXvYypFyhPg==
X-Gm-Gg: ASbGncvS5+K93zfEcGvrT0zISAuW9QJR2NhDl7Lj8NBl1jOWi0QnQvlD7Bd9qjXv57/
	tJyUwt4Gr2IjBfUqoQBKgSEMdS0LRhgQ4KW7MPw6zwTG5ceWoHls8WTcqNNAGvxehVAJx/j7p+l
	OabaIjRZDQ5++JiXQMDecb3gaZnPnJon3KWrD2d8JX78cmCDlQvYzRMpRqvDNFs+NSvzwMC9RU+
	NxVzl7FZzYZGCYAq60eSRMe240/kqF6HsPdyG+pMXikVFOAd56ZXs0Yn5/NPvdp
X-Google-Smtp-Source: AGHT+IFB98FERXAuK8vT36AbKOk0AtWALtMhD8Pu3Gyw7qPgrxYmtWWKsLwWa6L4aEIV011ihAs8TQ==
X-Received: by 2002:a05:6102:2acb:b0:4b1:11c6:d3c6 with SMTP id ada2fe7eead31-4b3d0ee45a7mr22905711137.5.1736925184608;
        Tue, 14 Jan 2025 23:13:04 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:13:03 -0800 (PST)
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
Subject: [PATCH v3 15/19] ACPI: platform_profile: Remove platform_profile_handler from exported symbols
Date: Wed, 15 Jan 2025 02:10:18 -0500
Message-ID: <20250115071022.4815-16-kuurtb@gmail.com>
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

In order to protect the platform_profile_handler from API consumers,
allocate it in platform_profile_register() and modify it's signature
accordingly.

Remove the platform_profile_handler from all consumer drivers and
replace them with a pointer to the class device, which is
now returned from platform_profile_register().

Replace *pprof with a pointer to the class device in the rest of
exported symbols.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               | 98 ++++++++++++-------
 .../surface/surface_platform_profile.c        | 11 +--
 drivers/platform/x86/acer-wmi.c               | 18 ++--
 drivers/platform/x86/amd/pmf/pmf.h            |  2 +-
 drivers/platform/x86/amd/pmf/sps.c            | 17 ++--
 drivers/platform/x86/asus-wmi.c               | 20 ++--
 drivers/platform/x86/dell/alienware-wmi.c     | 10 +-
 drivers/platform/x86/dell/dell-pc.c           | 22 ++---
 drivers/platform/x86/hp/hp-wmi.c              | 19 ++--
 drivers/platform/x86/ideapad-laptop.c         | 15 +--
 .../platform/x86/inspur_platform_profile.c    |  9 +-
 drivers/platform/x86/thinkpad_acpi.c          | 14 +--
 include/linux/platform_profile.h              | 12 ++-
 13 files changed, 132 insertions(+), 135 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 120f8402facd..a1dfa168f51f 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -4,6 +4,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
@@ -212,9 +213,17 @@ static struct attribute *profile_attrs[] = {
 };
 ATTRIBUTE_GROUPS(profile);
 
+static void pprof_device_release(struct device *dev)
+{
+	struct platform_profile_handler *pprof = to_pprof_handler(dev);
+
+	kfree(pprof);
+}
+
 static const struct class platform_profile_class = {
 	.name = "platform-profile",
 	.dev_groups = profile_groups,
+	.dev_release = pprof_device_release,
 };
 
 /**
@@ -408,10 +417,10 @@ static const struct attribute_group platform_profile_group = {
 	.is_visible = profile_class_is_visible,
 };
 
-void platform_profile_notify(struct platform_profile_handler *pprof)
+void platform_profile_notify(struct device *dev)
 {
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
-		_notify_class_profile(&pprof->class_dev, NULL);
+		_notify_class_profile(dev, NULL);
 	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -460,42 +469,54 @@ int platform_profile_cycle(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
+struct device *platform_profile_register(struct device *dev, const char *name,
+					 void *drvdata,
+					 const struct platform_profile_ops *ops)
 {
+	struct device *ppdev;
+	int minor;
 	int err;
 
-	/* Sanity check the profile handler */
-	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
-	    !pprof->ops->probe) {
-		pr_err("platform_profile: handler is invalid\n");
-		return -EINVAL;
-	}
+	/* Sanity check */
+	if (WARN_ON_ONCE(!dev || !name || !ops || !ops->profile_get ||
+	    !ops->profile_set || !ops->probe))
+		return ERR_PTR(-EINVAL);
+
+	struct platform_profile_handler *pprof __free(kfree) = kzalloc(
+		sizeof(*pprof), GFP_KERNEL);
+	if (!pprof)
+		return ERR_PTR(-ENOMEM);
 
-	err = pprof->ops->probe(drvdata, pprof->choices);
+	err = ops->probe(drvdata, pprof->choices);
 	if (err) {
-		dev_err(pprof->dev, "platform_profile probe failed\n");
-		return err;
+		dev_err(dev, "platform_profile probe failed\n");
+		return ERR_PTR(err);
 	}
 
 	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
-		dev_err(pprof->dev, "Failed to register a platform_profile class device with empty choices\n");
-		return -EINVAL;
+		dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
+		return ERR_PTR(-EINVAL);
 	}
 
 	guard(mutex)(&profile_lock);
 
 	/* create class interface for individual handler */
-	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
-	if (pprof->minor < 0)
-		return pprof->minor;
+	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
+	if (minor < 0)
+		return ERR_PTR(minor);
 
+	pprof->name = name;
+	pprof->ops = ops;
+	pprof->minor = minor;
 	pprof->class_dev.class = &platform_profile_class;
-	pprof->class_dev.parent = pprof->dev;
+	pprof->class_dev.parent = dev;
 	dev_set_drvdata(&pprof->class_dev, drvdata);
 	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
-	err = device_register(&pprof->class_dev);
+	/* device_register() takes ownership of ppdev */
+	ppdev = &no_free_ptr(pprof)->class_dev;
+	err = device_register(ppdev);
 	if (err) {
-		put_device(&pprof->class_dev);
+		put_device(ppdev);
 		goto cleanup_ida;
 	}
 
@@ -505,20 +526,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
 	if (err)
 		goto cleanup_cur;
 
-	return 0;
+	return ppdev;
 
 cleanup_cur:
-	device_unregister(&pprof->class_dev);
+	device_unregister(ppdev);
 
 cleanup_ida:
-	ida_free(&platform_profile_ida, pprof->minor);
+	ida_free(&platform_profile_ida, minor);
 
-	return err;
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
-int platform_profile_remove(struct platform_profile_handler *pprof)
+int platform_profile_remove(struct device *dev)
 {
+	struct platform_profile_handler *pprof = to_pprof_handler(dev);
 	int id;
 	guard(mutex)(&profile_lock);
 
@@ -536,30 +558,32 @@ EXPORT_SYMBOL_GPL(platform_profile_remove);
 
 static void devm_platform_profile_release(struct device *dev, void *res)
 {
-	struct platform_profile_handler **pprof = res;
+	struct device **ppdev = res;
 
-	platform_profile_remove(*pprof);
+	platform_profile_remove(*ppdev);
 }
 
-int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
+struct device *devm_platform_profile_register(struct device *dev, const char *name,
+					      void *drvdata,
+					      const struct platform_profile_ops *ops)
 {
-	struct platform_profile_handler **dr;
-	int ret;
+	struct device *ppdev;
+	struct device **dr;
 
 	dr = devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	ret = platform_profile_register(pprof, drvdata);
-	if (ret) {
+	ppdev = platform_profile_register(dev, name, drvdata, ops);
+	if (IS_ERR(ppdev)) {
 		devres_free(dr);
-		return ret;
+		return ppdev;
 	}
 
-	*dr = pprof;
-	devres_add(pprof->dev, dr);
+	*dr = ppdev;
+	devres_add(dev, dr);
 
-	return 0;
+	return ppdev;
 }
 EXPORT_SYMBOL_GPL(devm_platform_profile_register);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index bbdc873cb788..0e479e35e66e 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -40,7 +40,7 @@ struct ssam_tmp_profile_info {
 
 struct ssam_platform_profile_device {
 	struct ssam_device *sdev;
-	struct platform_profile_handler handler;
+	struct device *ppdev;
 	bool has_fan;
 };
 
@@ -228,13 +228,12 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	tpd->sdev = sdev;
 	ssam_device_set_drvdata(sdev, tpd);
 
-	tpd->handler.name = "Surface Platform Profile";
-	tpd->handler.dev = &sdev->dev;
-	tpd->handler.ops = &ssam_platform_profile_ops;
-
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	return devm_platform_profile_register(&tpd->handler, tpd);
+	tpd->ppdev = devm_platform_profile_register(&sdev->dev, "Surface Platform Profile",
+						    tpd, &ssam_platform_profile_ops);
+
+	return PTR_ERR_OR_ZERO(tpd->ppdev);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 39ec236b7cdb..3e39465b3783 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -758,7 +758,7 @@ static const struct dmi_system_id non_acer_quirks[] __initconst = {
 	{}
 };
 
-static struct platform_profile_handler platform_profile_handler;
+static struct device *platform_profile_device;
 static bool platform_profile_support;
 
 /*
@@ -1937,16 +1937,10 @@ static const struct platform_profile_ops acer_predator_v4_platform_profile_ops =
 static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
-		int err;
-
-		platform_profile_handler.name = "acer-wmi";
-		platform_profile_handler.dev = &device->dev;
-		platform_profile_handler.ops =
-			&acer_predator_v4_platform_profile_ops;
-
-		err = devm_platform_profile_register(&platform_profile_handler, NULL);
-		if (err)
-			return err;
+		platform_profile_device = devm_platform_profile_register(
+			&device->dev, "acer-wmi", NULL, &acer_predator_v4_platform_profile_ops);
+		if (IS_ERR(platform_profile_device))
+			return PTR_ERR(platform_profile_device);
 
 		platform_profile_support = true;
 
@@ -2033,7 +2027,7 @@ static int acer_thermal_profile_change(void)
 		if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
 			last_non_turbo_profile = tp;
 
-		platform_profile_notify(&platform_profile_handler);
+		platform_profile_notify(platform_profile_device);
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index d99b3556205b..41b2b91b8fdc 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -338,7 +338,7 @@ struct amd_pmf_dev {
 	struct mutex lock; /* protects the PMF interface */
 	u32 supported_func;
 	enum platform_profile_option current_profile;
-	struct platform_profile_handler pprof;
+	struct device *ppdev; /* platform profile class device */
 	struct dentry *dbgfs_dir;
 	int hb_interval; /* SBIOS heartbeat interval */
 	struct delayed_work heart_beat;
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 7c7ed2b9de01..e6cf0b22dac3 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -404,8 +404,6 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
 
 int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 {
-	int err;
-
 	dev->current_profile = PLATFORM_PROFILE_BALANCED;
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
@@ -420,15 +418,12 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 		amd_pmf_set_sps_power_limits(dev);
 	}
 
-	dev->pprof.name = "amd-pmf";
-	dev->pprof.dev = dev->dev;
-	dev->pprof.ops = &amd_pmf_profile_ops;
-
 	/* Create platform_profile structure and register */
-	err = devm_platform_profile_register(&dev->pprof, dev);
-	if (err)
-		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
-			err);
+	dev->ppdev = devm_platform_profile_register(dev->dev, "amd-pmf", dev,
+						    &amd_pmf_profile_ops);
+	if (IS_ERR(dev->ppdev))
+		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %ld\n",
+			PTR_ERR(dev->ppdev));
 
-	return err;
+	return PTR_ERR_OR_ZERO(dev->ppdev);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f8437cff66df..aea1c4d805bd 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -313,7 +313,7 @@ struct asus_wmi {
 	bool mid_fan_curve_available;
 	struct fan_curve_data custom_fan_curves[3];
 
-	struct platform_profile_handler platform_profile_handler;
+	struct device *ppdev;
 	bool platform_profile_support;
 
 	// The RSOC controls the maximum charging percentage.
@@ -3789,7 +3789,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	 * Ensure that platform_profile updates userspace with the change to ensure
 	 * that platform_profile and throttle_thermal_policy_mode are in sync.
 	 */
-	platform_profile_notify(&asus->platform_profile_handler);
+	platform_profile_notify(asus->ppdev);
 
 	return count;
 }
@@ -3891,17 +3891,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
-	asus->platform_profile_handler.name = "asus-wmi";
-	asus->platform_profile_handler.dev = dev;
-	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
+	asus->ppdev = devm_platform_profile_register(dev, "asus-wmi", asus,
+						     &asus_wmi_platform_profile_ops);
+	if (IS_ERR(asus->ppdev)) {
+		pr_err("%s, failed at devm_platform_profile_register: %ld\n",
+		       __func__, PTR_ERR(asus->ppdev));
 
-	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
-	if (err == -EEXIST) {
-		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
-		return 0;
-	} else if (err) {
-		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
-		return err;
+		return PTR_ERR(asus->ppdev);
 	}
 
 	asus->platform_profile_support = true;
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 0146d2f93be6..d3564e24c782 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -406,7 +406,6 @@ struct wmax_u32_args {
 
 static struct platform_device *platform_device;
 static struct color_platform colors[4];
-static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
 static u8 interface;
@@ -1135,11 +1134,12 @@ static const struct platform_profile_ops awcc_platform_profile_ops = {
 
 static int create_thermal_profile(struct platform_device *platform_device)
 {
-	pp_handler.name = "alienware-wmi";
-	pp_handler.dev = &platform_device->dev;
-	pp_handler.ops = &awcc_platform_profile_ops;
+	struct device *ppdev;
 
-	return devm_platform_profile_register(&pp_handler, NULL);
+	ppdev = devm_platform_profile_register(&platform_device->dev, "alienware-wmi",
+					       NULL, &awcc_platform_profile_ops);
+
+	return PTR_ERR_OR_ZERO(ppdev);
 }
 
 /*
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 2759bb608b1a..1874d4adfb8a 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -109,8 +109,6 @@ MODULE_DEVICE_TABLE(dmi, dell_device_table);
 #define DELL_ACC_SET_FIELD	GENMASK(11, 8)
 #define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
 
-static struct platform_profile_handler *thermal_handler;
-
 enum thermal_mode_bits {
 	DELL_BALANCED    = BIT(0),
 	DELL_COOL_BOTTOM = BIT(1),
@@ -254,6 +252,7 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
 
 static int thermal_init(void)
 {
+	struct device *ppdev;
 	int ret;
 
 	/* If thermal commands are not supported, exit without error */
@@ -271,26 +270,17 @@ static int thermal_init(void)
 	if (IS_ERR(platform_device))
 		return PTR_ERR(platform_device);
 
-	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
-	if (!thermal_handler) {
-		ret = -ENOMEM;
-		goto cleanup_platform_device;
-	}
-	thermal_handler->name = "dell-pc";
-	thermal_handler->dev = &platform_device->dev;
-	thermal_handler->ops = &dell_pc_platform_profile_ops;
-
 	/* Clean up if failed */
-	ret = devm_platform_profile_register(thermal_handler, NULL);
-	if (ret)
+	ppdev = devm_platform_profile_register(&platform_device->dev, "dell-pc",
+					       NULL, &dell_pc_platform_profile_ops);
+	if (IS_ERR(ppdev)) {
+		ret = PTR_ERR(ppdev);
 		goto cleanup_thermal_handler;
+	}
 
 	return 0;
 
 cleanup_thermal_handler:
-	thermal_handler = NULL;
-
-cleanup_platform_device:
 	platform_device_unregister(platform_device);
 
 	return ret;
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 1304dfc65aab..435e3ef2e3e7 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -273,7 +273,7 @@ static DEFINE_MUTEX(active_platform_profile_lock);
 static struct input_dev *hp_wmi_input_dev;
 static struct input_dev *camera_shutter_input_dev;
 static struct platform_device *hp_wmi_platform_dev;
-static struct platform_profile_handler platform_profile_handler;
+static struct device *platform_profile_device;
 static struct notifier_block platform_power_source_nb;
 static enum platform_profile_option active_platform_profile;
 static bool platform_profile_support;
@@ -1602,6 +1602,7 @@ static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
 
 static int thermal_profile_setup(struct platform_device *device)
 {
+	const struct platform_profile_ops *ops;
 	int err, tp;
 
 	if (is_omen_thermal_profile()) {
@@ -1617,7 +1618,7 @@ static int thermal_profile_setup(struct platform_device *device)
 		if (err < 0)
 			return err;
 
-		platform_profile_handler.ops = &platform_profile_omen_ops;
+		ops = &platform_profile_omen_ops;
 	} else if (is_victus_thermal_profile()) {
 		err = platform_profile_victus_get_ec(&active_platform_profile);
 		if (err < 0)
@@ -1631,7 +1632,7 @@ static int thermal_profile_setup(struct platform_device *device)
 		if (err < 0)
 			return err;
 
-		platform_profile_handler.ops = &platform_profile_victus_ops;
+		ops = &platform_profile_victus_ops;
 	} else {
 		tp = thermal_profile_get();
 
@@ -1646,15 +1647,13 @@ static int thermal_profile_setup(struct platform_device *device)
 		if (err)
 			return err;
 
-		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
+		ops = &hp_wmi_platform_profile_ops;
 	}
 
-	platform_profile_handler.name = "hp-wmi";
-	platform_profile_handler.dev = &device->dev;
-
-	err = devm_platform_profile_register(&platform_profile_handler, NULL);
-	if (err)
-		return err;
+	platform_profile_device = devm_platform_profile_register(&device->dev, "hp-wmi",
+								 NULL, ops);
+	if (IS_ERR(platform_profile_device))
+		return PTR_ERR(platform_profile_device);
 
 	platform_profile_support = true;
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 87c1e087770a..dfb5d4b8c046 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -142,7 +142,7 @@ enum {
 
 struct ideapad_dytc_priv {
 	enum platform_profile_option current_profile;
-	struct platform_profile_handler pprof;
+	struct device *ppdev; /* platform profile device */
 	struct mutex mutex; /* protects the DYTC interface */
 	struct ideapad_private *priv;
 };
@@ -1050,7 +1050,7 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
 
 	if (profile != priv->dytc->current_profile) {
 		priv->dytc->current_profile = profile;
-		platform_profile_notify(&priv->dytc->pprof);
+		platform_profile_notify(priv->dytc->ppdev);
 	}
 }
 
@@ -1117,15 +1117,16 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 
 	mutex_init(&priv->dytc->mutex);
 
-	priv->dytc->pprof.name = "ideapad-laptop";
-	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
-	priv->dytc->pprof.ops = &dytc_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = devm_platform_profile_register(&priv->dytc->pprof, &priv->dytc);
-	if (err)
+	priv->dytc->ppdev = devm_platform_profile_register(&priv->platform_device->dev,
+							   "ideapad-laptop", &priv->dytc,
+							   &dytc_profile_ops);
+	if (IS_ERR(priv->dytc->ppdev)) {
+		err = PTR_ERR(priv->dytc->ppdev);
 		goto pp_reg_failed;
+	}
 
 	/* Ensure initial values are correct */
 	dytc_profile_refresh(priv);
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index e1631de6ad86..e02f5a55a6c5 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -32,7 +32,7 @@ enum inspur_tmp_profile {
 
 struct inspur_wmi_priv {
 	struct wmi_device *wdev;
-	struct platform_profile_handler handler;
+	struct device *ppdev;
 };
 
 static int inspur_wmi_perform_query(struct wmi_device *wdev,
@@ -190,11 +190,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
-	priv->handler.name = "inspur-wmi";
-	priv->handler.dev = &wdev->dev;
-	priv->handler.ops = &inspur_platform_profile_ops;
+	priv->ppdev = devm_platform_profile_register(&wdev->dev, "inspur-wmi", priv,
+						     &inspur_platform_profile_ops);
 
-	return devm_platform_profile_register(&priv->handler, priv);
+	return PTR_ERR_OR_ZERO(priv->ppdev);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 54ff3e6b8b1a..d4a5524a59f2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -962,6 +962,7 @@ static const struct proc_ops dispatch_proc_ops = {
 static struct platform_device *tpacpi_pdev;
 static struct platform_device *tpacpi_sensors_pdev;
 static struct device *tpacpi_hwmon;
+static struct device *tpacpi_pprof;
 static struct input_dev *tpacpi_inputdev;
 static struct mutex tpacpi_inputdev_send_mutex;
 static LIST_HEAD(tpacpi_all_drivers);
@@ -10553,11 +10554,6 @@ static const struct platform_profile_ops dytc_profile_ops = {
 	.profile_set = dytc_profile_set,
 };
 
-static struct platform_profile_handler dytc_profile = {
-	.name = "thinkpad-acpi",
-	.ops = &dytc_profile_ops,
-};
-
 static void dytc_profile_refresh(void)
 {
 	enum platform_profile_option profile;
@@ -10586,7 +10582,7 @@ static void dytc_profile_refresh(void)
 	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
 	if (!err && profile != dytc_current_profile) {
 		dytc_current_profile = profile;
-		platform_profile_notify(&dytc_profile);
+		platform_profile_notify(tpacpi_pprof);
 	}
 }
 
@@ -10647,14 +10643,14 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	dbg_printk(TPACPI_DBG_INIT,
 			"DYTC version %d: thermal mode available\n", dytc_version);
 
-	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = devm_platform_profile_register(&dytc_profile, NULL);
+	tpacpi_pprof = devm_platform_profile_register(&tpacpi_pdev->dev, "thinkpad-acpi",
+						      NULL, &dytc_profile_ops);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
 	 */
-	if (err)
+	if (IS_ERR(tpacpi_pprof))
 		return -ENODEV;
 
 	/* Ensure initial values are correct */
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 5ad1ab7b75e4..778d4c661c3c 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -45,10 +45,14 @@ struct platform_profile_handler {
 	const struct platform_profile_ops *ops;
 };
 
-int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
-int platform_profile_remove(struct platform_profile_handler *pprof);
-int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
+struct device *platform_profile_register(struct device *dev, const char *name,
+					 void *drvdata,
+					 const struct platform_profile_ops *ops);
+int platform_profile_remove(struct device *dev);
+struct device *devm_platform_profile_register(struct device *dev, const char *name,
+					      void *drvdata,
+					      const struct platform_profile_ops *ops);
 int platform_profile_cycle(void);
-void platform_profile_notify(struct platform_profile_handler *pprof);
+void platform_profile_notify(struct device *dev);
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.48.0


