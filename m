Return-Path: <linux-acpi+bounces-10463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE65A07B61
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D757A317E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34B21E0A8;
	Thu,  9 Jan 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX0AJALi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC921C9F1;
	Thu,  9 Jan 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435361; cv=none; b=E+Eic/uh1H4gd9ThIblIG0wSbIo7swzTOKDM701f4YFhuIztYqhdxwp3ZT8RIWbdAVjJjzCDJ7W2Vtry6UF3Un0IF+pF6wGmANMX8ffI5wI60XHzZz+ITKmreUWoSeLbEeitlJKoV88eHbnUKbR4KFqMTvC1uuqVOLJK+WSL2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435361; c=relaxed/simple;
	bh=3iJGuulPAYHJM2VGs5Cig15HMex4vup9V3Jh9EOnmSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub9ElN5WADa1FPEMGThqhcBiG7q4FjPyq2D4dK40kAO3tbqYISI4WPmAhdnUA6qCHEhLQycu2e008GD8HebtqlM5+99H2Oj5M0MVxUqswj6cFMHAgWtZg41l9620ViSAbz6toRtg6+QJA4RvnsimF5kjKF43nZXyue5rkMuqh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX0AJALi; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4aff31b77e8so427660137.1;
        Thu, 09 Jan 2025 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435357; x=1737040157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0XNXY/JMeEK+RY7wfbv5qEFmZNkd0qCHPSEjoe+4/U=;
        b=LX0AJALiMEzIsYbT0Uc1o2SitTPhRJiSiqRFCrg2o9KVY4NreOO1Vqw6th9ambox9r
         VjYTkX13Xps/TV1z3aPhQBz5tYP++ztnxrv+T2rqSbCyxPFtc40FXuLOrgShHWup3aYo
         vE5b9izcM2hVW87HDoRiJRzis5ojwy9b8sEERhpPNHxdAnfI/2bpAi/sAd7DuWlCBriB
         MT/p3tYt9GtCBLdecFfWgG1fY9EXuS2dCY1Q1ThAMEjvreI4DqU++pF2CETtbzpOSJtv
         u65bchcUAiwE61BrRNJ0ld2a1czF6Y0YshvbJ/+niDVPLlQPaIgVntyjwbClRyPQ/avu
         t/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435357; x=1737040157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0XNXY/JMeEK+RY7wfbv5qEFmZNkd0qCHPSEjoe+4/U=;
        b=rAdKj/cXFbesTHUS1GTMIyCxxMmMAYERo3VxuhheNzq+xd2J2qoNb/6/DEmjGgxZT8
         e33aRgaqsBOG1QD1En9fD4Hj8QFJODYFk5uPBhLhv4bdtbzqL5Rm8kjc0YJCwk0cNC4P
         9OpDCkHDL6AIjxiIz5oyX+BYDfoGZ6F5+fakDtG0/8ahKv8CsRfsot4F6RamV29uNs1c
         dmYuG9LuZFNAWnx+2iRRc/hQPNNG6MqAj8wy6j9qbJ7hrwkbCPa9xgMPnCf9B5tPqhBM
         9ypNJQ5ugmr88J2xqI/Y+Q88NVgRN56mVrMPbRx0t7wQsqvI+IxP2flX2Qv9rHNX+pmC
         xtqg==
X-Forwarded-Encrypted: i=1; AJvYcCULwvZXkWvw8FPCPaQwNIFLyOfG9PHiobT2FSX4C0L0JaZItvdHHIN+J2qjWzIpfco5kJ5Uu3v6ZWSZ@vger.kernel.org, AJvYcCV2CSkkLiwXM1xXKDK8pSXs7XioJ+LBjuWKHB+j0b0n4MhZepadTJD2XIeqsaOi0U/PdD+1CTEun07135fv@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZykQRyLCDmX+wP5jKhy7BUf6ZoteaJy575mN2LIBubxEMVNy
	XuGq77fRaGvqk02nZD/8JsdpeOBg7mYQZ1NMIN2x5VTYfjFq/z1/ckhurG6W
X-Gm-Gg: ASbGncvBRP43Ue9qfPr53O2chGEl4ow21o5sM3sWFw3380ZTUqwspaKKL6u31kbnL7x
	op/sxM45jE7D+sK03tOR171SME2ujKTZcd+rhdw0J5LeZpJEXrxYKHFOcIORkwNNMcoaea4uPlW
	sa02QQTGBGIya0qYDpwrx6J51d5P58rkgpi2b5E5ayQlwLK3KtBk54S8q7WdJAyWELxkjKyZRae
	C0NyNDq2neIc1hXUWxIF23os4Ea/6oi59i5mpgbq8UAv1S4Rqp3RTpAQuICKa7T
X-Google-Smtp-Source: AGHT+IFgH3W/KdvqRrNrwfpOOUxIGtaWXK9uZdSbZkYvIWAKPZKw6IJ4yfSisxYpkg28GcoPU0ipZA==
X-Received: by 2002:a05:6102:290e:b0:4b0:49ba:8278 with SMTP id ada2fe7eead31-4b3d0ff5da9mr6050866137.25.1736435357192;
        Thu, 09 Jan 2025 07:09:17 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:16 -0800 (PST)
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
	Ai Chao <aichao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 14/18] ACPI: platform_profile: Remove platform_profile_handler from exported symbols
Date: Thu,  9 Jan 2025 10:06:27 -0500
Message-ID: <20250109150731.110799-15-kuurtb@gmail.com>
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

In order to protect the platform_profile_handler from API consumers,
allocate it in platform_profile_register() and modify it's signature
accordingly.

Remove the platform_profile_handler from all consumer drivers and
replace them with a pointer to the class device, which is
now returned from platform_profile_register().

Replace *pprof with a pointer to the class device in the rest of
exported symbols.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c               | 93 ++++++++++++-------
 .../surface/surface_platform_profile.c        | 11 +--
 drivers/platform/x86/acer-wmi.c               | 18 ++--
 drivers/platform/x86/amd/pmf/pmf.h            |  2 +-
 drivers/platform/x86/amd/pmf/sps.c            | 15 +--
 drivers/platform/x86/asus-wmi.c               | 17 ++--
 drivers/platform/x86/dell/alienware-wmi.c     | 10 +-
 drivers/platform/x86/dell/dell-pc.c           | 22 ++---
 drivers/platform/x86/hp/hp-wmi.c              | 19 ++--
 drivers/platform/x86/ideapad-laptop.c         | 14 +--
 .../platform/x86/inspur_platform_profile.c    |  9 +-
 drivers/platform/x86/thinkpad_acpi.c          | 14 +--
 include/linux/platform_profile.h              | 12 ++-
 13 files changed, 131 insertions(+), 125 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 5a867b912964..fdf79b81b62e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -3,6 +3,7 @@
 /* Platform profile sysfs interface */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/kdev_t.h>
@@ -213,9 +214,17 @@ static struct attribute *profile_attrs[] = {
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
@@ -409,10 +418,10 @@ static const struct attribute_group platform_profile_group = {
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
@@ -461,40 +470,57 @@ int platform_profile_cycle(void)
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
-	    !pprof->ops->choices) {
+	/* Sanity check */
+	if (!dev || !name || !ops || !ops->profile_get ||
+	    !ops->profile_set || !ops->choices) {
 		pr_err("platform_profile: handler is invalid\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	err = pprof->ops->choices(pprof);
+	struct platform_profile_handler *pprof __free(kfree) = kzalloc(
+		sizeof(*pprof), GFP_KERNEL);
+	if (!pprof)
+		return ERR_PTR(-ENOMEM);
+
+	err = ops->choices(pprof);
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
 
 	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
 		pr_err("platform_profile: no available profiles\n");
-		return -EINVAL;
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
 	err = device_register(&pprof->class_dev);
-	if (err)
+	if (err) {
+		put_device(&no_free_ptr(pprof)->class_dev);
 		goto cleanup_ida;
+	}
+
+	/* After this point, device_unregister will free pprof on error */
+	ppdev = &no_free_ptr(pprof)->class_dev;
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -502,20 +528,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
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
 
@@ -533,30 +560,32 @@ EXPORT_SYMBOL_GPL(platform_profile_remove);
 
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
+	if (IS_ERR(dev)) {
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
index efb6653ed1d5..965940223892 100644
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
+	tpd->ppdev =  devm_platform_profile_register(
+		&sdev->dev, "Surface Platform Profile", tpd, &ssam_platform_profile_ops);
+
+	return PTR_ERR_OR_ZERO(tpd->ppdev);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 70ec667e0cbf..2059b29dd36b 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -742,7 +742,7 @@ static const struct dmi_system_id non_acer_quirks[] __initconst = {
 	{}
 };
 
-static struct platform_profile_handler platform_profile_handler;
+static struct device *platform_profile_device;
 static bool platform_profile_support;
 
 /*
@@ -1921,16 +1921,10 @@ static const struct platform_profile_ops acer_predator_v4_platform_profile_ops =
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
 
@@ -2017,7 +2011,7 @@ static int acer_thermal_profile_change(void)
 		if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
 			last_non_turbo_profile = tp;
 
-		platform_profile_notify(&platform_profile_handler);
+		platform_profile_notify(platform_profile_device);
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index 198bfe3306be..3806f9efaff8 100644
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
index 4f80a73eff9f..e8d2de9bb646 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -420,15 +420,16 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 		amd_pmf_set_sps_power_limits(dev);
 	}
 
-	dev->pprof.name = "amd-pmf";
-	dev->pprof.dev = dev->dev;
-	dev->pprof.ops = &amd_pmf_profile_ops;
-
 	/* Create platform_profile structure and register */
-	err = devm_platform_profile_register(&dev->pprof, dev);
-	if (err)
+	dev->ppdev = devm_platform_profile_register(
+		dev->dev, "amd-pmf", dev, &amd_pmf_profile_ops);
+	if (IS_ERR(dev->ppdev)) {
+		err = PTR_ERR(dev->ppdev);
 		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
 			err);
 
-	return err;
+		return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 5c7099dc6109..809ab0353b68 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -313,7 +313,7 @@ struct asus_wmi {
 	bool mid_fan_curve_available;
 	struct fan_curve_data custom_fan_curves[3];
 
-	struct platform_profile_handler platform_profile_handler;
+	struct device *platform_profile_device;
 	bool platform_profile_support;
 
 	// The RSOC controls the maximum charging percentage.
@@ -3789,7 +3789,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	 * Ensure that platform_profile updates userspace with the change to ensure
 	 * that platform_profile and throttle_thermal_policy_mode are in sync.
 	 */
-	platform_profile_notify(&asus->platform_profile_handler);
+	platform_profile_notify(asus->platform_profile_device);
 
 	return count;
 }
@@ -3891,15 +3891,10 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
-	asus->platform_profile_handler.name = "asus-wmi";
-	asus->platform_profile_handler.dev = dev;
-	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
-
-	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
-	if (err == -EEXIST) {
-		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
-		return 0;
-	} else if (err) {
+	asus->platform_profile_device = devm_platform_profile_register(
+		dev, "asus-wmi", asus, &asus_wmi_platform_profile_ops);
+	if (IS_ERR(asus->platform_profile_device)) {
+		err = PTR_ERR(asus->platform_profile_device);
 		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
 		return err;
 	}
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index a8961de004ab..1eaa746eb4f1 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -414,7 +414,6 @@ static struct platform_device *platform_device;
 static struct device_attribute *zone_dev_attrs;
 static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
-static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
 static struct platform_driver platform_driver = {
@@ -1165,11 +1164,12 @@ static const struct platform_profile_ops awcc_platform_profile_ops = {
 
 static int create_thermal_profile(struct platform_device *platform_device)
 {
-	pp_handler.name = "alienware-wmi";
-	pp_handler.dev = &platform_device->dev;
-	pp_handler.ops = &awcc_platform_profile_ops;
+	struct device *ppdev;
 
-	return devm_platform_profile_register(&pp_handler, NULL);
+	ppdev = devm_platform_profile_register(
+		&platform_device->dev, "alienware-wmi", NULL, &awcc_platform_profile_ops);
+
+	return PTR_ERR_OR_ZERO(ppdev);
 }
 
 static int __init alienware_wmi_init(void)
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index dda6f13295e8..4ff80ed4f157 100644
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
+	ppdev = devm_platform_profile_register(
+		&platform_device->dev, "dell-pc", NULL, &dell_pc_platform_profile_ops);
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
index 8a620d36f926..1b9e176f8d6f 100644
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
+	platform_profile_device = devm_platform_profile_register(
+		&device->dev, "hp-wmi", NULL, ops);
+	if (IS_ERR(platform_profile_device))
+		return PTR_ERR(platform_profile_device);
 
 	platform_profile_support = true;
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d34d565172f5..55aac0190624 100644
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
 
@@ -1117,15 +1117,15 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 
 	mutex_init(&priv->dytc->mutex);
 
-	priv->dytc->pprof.name = "ideapad-laptop";
-	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
-	priv->dytc->pprof.ops = &dytc_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = devm_platform_profile_register(&priv->dytc->pprof, &priv->dytc);
-	if (err)
+	priv->dytc->ppdev = devm_platform_profile_register(
+		&priv->platform_device->dev, "ideapad-laptop", &priv->dytc, &dytc_profile_ops);
+	if (IS_ERR(priv->dytc->ppdev)) {
+		err = PTR_ERR(priv->dytc->ppdev);
 		goto pp_reg_failed;
+	}
 
 	/* Ensure initial values are correct */
 	dytc_profile_refresh(priv);
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 543e4bce1a57..9e2f24de0207 100644
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
+	priv->ppdev = devm_platform_profile_register(
+		&wdev->dev, "inspur-wmi", priv, &inspur_platform_profile_ops);
 
-	return devm_platform_profile_register(&priv->handler, priv);
+	return PTR_ERR_OR_ZERO(priv->ppdev);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a0b8987bc328..964f842ef756 100644
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
 	.choices = dytc_profile_choices,
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
+	tpacpi_pprof = devm_platform_profile_register(
+		&tpacpi_pdev->dev, "thinkpad-acpi", NULL, &dytc_profile_ops);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
 	 */
-	if (err)
+	if (IS_ERR(tpacpi_pprof))
 		return -ENODEV;
 
 	/* Ensure initial values are correct */
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index cadbd3168d84..97ce9bd476ab 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -47,10 +47,14 @@ struct platform_profile_handler {
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
2.47.1


