Return-Path: <linux-acpi+bounces-10453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C0A07B36
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC73A7FEB
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4075621CA1F;
	Thu,  9 Jan 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzeJ/puM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2B21C19F;
	Thu,  9 Jan 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435297; cv=none; b=PrsqqRQmvQcbNICmTGngTIgUKn1JGcuZGUhPNE5F6wtO6XFMYd+WNCYDSo8EP4mf4wriIp8bEW3ot99FwJ0kJuvy3dPiyB+pyx88NtG9d5zz0yHVLxEZsllSq7u/e3WAvpk/3A6so4J2fGuZJFAEEcdWzb0uf49MBp7zDUqlEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435297; c=relaxed/simple;
	bh=kwXBt4b3+q4Y39p8H6JPM3rIsgMPMUcZC/17KDplxYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJzuzOYvkVAwSboVYtBX7sQMmuEX2RsYhSb7KumKZZCjpj6t38txuALCzL5Nbr14yWJiL6BWhJZ7774qcIMNn+6/5KqqgMJ6XVv2sxNIQIo3TMc3X27CjR+U/cd56GWl84kbIaZIj4Hmj63pye2D6ZY7yohdjTpnbS7rEcA+S+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzeJ/puM; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b2c0a7ef74so656216137.2;
        Thu, 09 Jan 2025 07:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435294; x=1737040094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKirfVfr3JrJ4phvSlQyJq6q5S3I1b+zwqhd331cro8=;
        b=DzeJ/puMoUjUzSPzdIaS8G2A0kD+rLVwo5gJur3s1Bep2GseSczmjXFH8dibH8RBp7
         +bBYILCEYVtbJj7rbtmrvxzdzxwvlvswRw2y/Nd9+EBkAalMALvf/rd9h1au8ydDg5Rf
         hxP7iK7r9Lleof+2/ztWcnJHKC4jb9brh4KtLvIgfDHrCXcJAtNRTZaaY6gOW7GBe1+e
         p3lk/juuswDhug0815zfbrAZNkfz1gcdYNfK6icGgQwbVjkfBuwY06ICfoG13xbei0gW
         RSmu1vb2gFq2+6HL7B+8FHABEsDS3AOp72YGvzWWERKeXbiQQXLAqckJivrlgOkPgzGt
         1I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435294; x=1737040094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKirfVfr3JrJ4phvSlQyJq6q5S3I1b+zwqhd331cro8=;
        b=PBSIwtB2bXAnHtt9eNTwjZGKmhNsxyzkCDyqkqfN41veSCs1wco0rf4WuoX5zwL/60
         sb/vRBe//4HT736x2WOQm5P8Z1RTrk9fTm0984/oxhBOg8flpKjmHAXJmTNlGNnU1WNn
         INBsQUE2UZj8t1qnQArpB7dM7xPaC4nDwsjw7SR+oxjI37tgdPBTgN01XSxTAr/Yg39W
         fWlomgIRUT41OD3GGp9fXF6Exzd6dtmb+lEGYeQpibQthhlSjyajJ5F4Jo3P5um6irM0
         ZzdKrDcnUeVkO0IRYZcaCopdZWWCnt83X4ijbsspz3nHlldQxzanMWG98aZ9xsbc3LR6
         Rbkg==
X-Forwarded-Encrypted: i=1; AJvYcCWjKTQacazykICa9NO+gAfSo+uBvgnMHhE7RUuL2F9zhhq4f6vHagiopUUP+giC3xkT21hrDw49biks@vger.kernel.org, AJvYcCX6SxIxVbzW8mr9lx6ouvSwCMSbhTZ822JJQvI5T4BauCadhN8M1SieInR4EPFI4U96uyrJupaW6YokU+MO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m2Ab4H5wc4Vxceu+Jo5hmBQ1OGUCDwmYpZLWLRKy6Dnbg4O2
	5t9MhR6Lq9LnrnnAkSo9v0Ro538UBOUbf7i0bB9NMh1rr9WRZM3FaWxpJjGf
X-Gm-Gg: ASbGncuElhgvpBD3iW1zzv38d8K3LyGXirDV+Sbc9aMdU4z31dz5DlhUef+Y32CaI2w
	Fd4ZIeBXOxSkxX1LEukb6i7XizGCyJD1PrlpM0fZ/xZu+dBhdyOi9WCmSkbTG5Mz617GxctaFT/
	9yiXSI0fYvSVtppEnqjYyyXCV56wcEyy7NLmtPfbm3jeb30Hi/ik/KbX21wxRXHvp1Knfn1ZpFx
	PJRSRO6bwhfelaASP1CCs6ugXKjawHbfPtYrdw6A0F44nCzdUTkH4vT4NwC9T76
X-Google-Smtp-Source: AGHT+IFJxb1VK/f6PtdkYvY/B1TzEVKdzi4rM/myKllQrpU6mJlwSpnWhlKays2Qs1u0wNVapOwGNQ==
X-Received: by 2002:a05:6102:6e88:b0:4b4:27dc:ffe3 with SMTP id ada2fe7eead31-4b427dd0152mr4719591137.0.1736435294021;
        Thu, 09 Jan 2025 07:08:14 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:13 -0800 (PST)
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
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 04/18] ACPI: platform_profile: Let drivers set drvdata to the class device
Date: Thu,  9 Jan 2025 10:06:17 -0500
Message-ID: <20250109150731.110799-5-kuurtb@gmail.com>
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

Add *drvdata to platform_profile_register() signature and assign it to
the class device.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c                     | 7 ++++---
 drivers/platform/surface/surface_platform_profile.c | 2 +-
 drivers/platform/x86/acer-wmi.c                     | 2 +-
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 2 +-
 drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 2 +-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 4 ++--
 12 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 3cbde8dfed0b..5a867b912964 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -461,7 +461,7 @@ int platform_profile_cycle(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-int platform_profile_register(struct platform_profile_handler *pprof)
+int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
 {
 	int err;
 
@@ -490,6 +490,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	pprof->class_dev.class = &platform_profile_class;
 	pprof->class_dev.parent = pprof->dev;
+	dev_set_drvdata(&pprof->class_dev, drvdata);
 	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
 	err = device_register(&pprof->class_dev);
 	if (err)
@@ -537,7 +538,7 @@ static void devm_platform_profile_release(struct device *dev, void *res)
 	platform_profile_remove(*pprof);
 }
 
-int devm_platform_profile_register(struct platform_profile_handler *pprof)
+int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
 {
 	struct platform_profile_handler **dr;
 	int ret;
@@ -546,7 +547,7 @@ int devm_platform_profile_register(struct platform_profile_handler *pprof)
 	if (!dr)
 		return -ENOMEM;
 
-	ret = platform_profile_register(pprof);
+	ret = platform_profile_register(pprof, drvdata);
 	if (ret) {
 		devres_free(dr);
 		return ret;
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index b69fcc4c3858..00a1178e552f 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -234,7 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	return platform_profile_register(&tpd->handler);
+	return platform_profile_register(&tpd->handler, NULL);
 }
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 1fa0cd69da8c..585d54d8d80c 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1928,7 +1928,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		err = platform_profile_register(&platform_profile_handler);
+		err = platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
 
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 37316bc3e071..8e75ebd25e21 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -425,7 +425,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	dev->pprof.ops = &amd_pmf_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dev->pprof);
+	err = platform_profile_register(&dev->pprof, NULL);
 	if (err)
 		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
 			err);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3e94986078a6..248490571e8c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3895,7 +3895,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	err = platform_profile_register(&asus->platform_profile_handler);
+	err = platform_profile_register(&asus->platform_profile_handler, NULL);
 	if (err == -EEXIST) {
 		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
 		return 0;
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 386b22e9c922..a8961de004ab 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1169,7 +1169,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 	pp_handler.dev = &platform_device->dev;
 	pp_handler.ops = &awcc_platform_profile_ops;
 
-	return devm_platform_profile_register(&pp_handler);
+	return devm_platform_profile_register(&pp_handler, NULL);
 }
 
 static int __init alienware_wmi_init(void)
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index ba366c28d9a6..1b6e60a63491 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -281,7 +281,7 @@ static int thermal_init(void)
 	thermal_handler->ops = &dell_pc_platform_profile_ops;
 
 	/* Clean up if failed */
-	ret = platform_profile_register(thermal_handler);
+	ret = platform_profile_register(thermal_handler, NULL);
 	if (ret)
 		goto cleanup_thermal_handler;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 3c2d4549eb7f..2cf1da00d5f9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
 	platform_profile_handler.name = "hp-wmi";
 	platform_profile_handler.dev = &device->dev;
 
-	err = platform_profile_register(&platform_profile_handler);
+	err = platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index f5ea03763a54..43e4d9d8d595 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1123,7 +1123,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	priv->dytc->pprof.ops = &dytc_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&priv->dytc->pprof);
+	err = platform_profile_register(&priv->dytc->pprof, NULL);
 	if (err)
 		goto pp_reg_failed;
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 8fa9308d4686..43cb2a927fdf 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -196,7 +196,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->handler.dev = &wdev->dev;
 	priv->handler.ops = &inspur_platform_profile_ops;
 
-	return platform_profile_register(&priv->handler);
+	return platform_profile_register(&priv->handler, NULL);
 }
 
 static void inspur_wmi_remove(struct wmi_device *wdev)
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a35453c3c605..a72790cc5e0e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10649,7 +10649,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dytc_profile);
+	err = platform_profile_register(&dytc_profile, NULL);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f549067539af..cadbd3168d84 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -47,9 +47,9 @@ struct platform_profile_handler {
 	const struct platform_profile_ops *ops;
 };
 
-int platform_profile_register(struct platform_profile_handler *pprof);
+int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
 int platform_profile_remove(struct platform_profile_handler *pprof);
-int devm_platform_profile_register(struct platform_profile_handler *pprof);
+int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
 int platform_profile_cycle(void);
 void platform_profile_notify(struct platform_profile_handler *pprof);
 
-- 
2.47.1


