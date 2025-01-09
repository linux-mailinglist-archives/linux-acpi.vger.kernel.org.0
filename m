Return-Path: <linux-acpi+bounces-10462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C16A07B55
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE5D3A89CE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4BA223302;
	Thu,  9 Jan 2025 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Qy2JFq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FB21CA15;
	Thu,  9 Jan 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435353; cv=none; b=e9ZJjvOZX/HiVnZCr+T3paujAx2F03JtXp9IrurqjTBTBrk5rGcIutjazf0Myv/A4B57CyHg18iUKOmaIJA+WG5BzO9aiAdKihjYsNCKoRZRTQ9aD5sQ0CCa6MQHBo7uVEMr4wnHy8sEoT5crYd/OIxCon4l8jYB4k6MJobsavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435353; c=relaxed/simple;
	bh=9Y6ZRZMbCwK5Qs2xCOR7ZHjxG1pU8jAdhife7DbEr6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7yUlM3B2+bVMNZQqL9/0Ds9DDNb0FXFx7jFCRvhqua20hVCTEktCbUTpm42DE6rlDZfclTicCa8amXlBF5lj6bLf1ApLnerqpESmfCpqm0KIAjJ/fbGCYOxJ1em0KL8MtYHlo9JLQO1CrwXroUPrZmY7wZvJuNOQjSNn7wW31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Qy2JFq; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4aff620b232so402897137.0;
        Thu, 09 Jan 2025 07:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435350; x=1737040150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cadwM7mu1HtIGfCND4i7fxTwuLTCfqLApVy4IXNFf3k=;
        b=P5Qy2JFq+ZIDsXfwh6g/levH92YrMLv6tRDvdqB0Mk0RURYHtyql2ebOJNgXaK1FDZ
         tBcd9gpgn1jd4lIAeBor/HWoK979LogItj5RvBzLOQuinT2b2ZkZDfutPN8DZKYVcRzp
         yu3IVFrbOQCtWSCY1PFc+iYIcny/nne9fWUIraVcCzeN+RerxyPXYEOlGh1yZ4dl7f3v
         J3+uHldZjWcj9G0jVCLX9nEANwlH5baDhqUdXXTEzaiPBwNU6aZ7s1l4G+mVZMaP4ClQ
         OQphQOe2kS3t1jSQsbmAxELD8PJ7aU9UqFIWQaL3Z7bJuceJJlsu+7CIk3yv8o0W9pAM
         Hw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435350; x=1737040150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cadwM7mu1HtIGfCND4i7fxTwuLTCfqLApVy4IXNFf3k=;
        b=DWo/v5tfzI867X3J2hzJCH3wObRFerpja1eFdI2sPU/a5x0vPftwxHzJSU625IiJ5I
         yGvY2joV4gnkf9OwN06qx6JJ+eImjphRfQkwUu4dQv913RIhbqoYyclA0KeMFhaYhPLG
         JVkBMZvT/0RuOx7Q2OrfZEZBBCrWD5DHv0oKgs9SZAj+bxRlQG8wPfm9yMaFR640lYuE
         zPP3kW+xWyrST5T2T5D91Wshz2BRAIRyeX1Yd9+hya4E+jBNVHtiSQlu5Tgs+Ais4pTK
         uQxhM8HGz36cIyCswbTAjlquFV1SWgt2LQ/9kr7znGraMwq8DnuAeOTFQ0mv9VSTg6xi
         iU9g==
X-Forwarded-Encrypted: i=1; AJvYcCVCPSMEFJlLbqZtSJZYgHIiMhhE331fEJrgKybvEnuZ/d58jbX4X/eqDXBkU6tcDaAEuxuP47ySHkQE@vger.kernel.org, AJvYcCXvcdKTjXnNJspt0DI9oKe6IZ1e2IA2Qel/4iWsTj5JYuX87xyQGCMI/CH5S453oui/N0lijtymLWAMFPbE@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTqgxGCevcaBBBMzNtp0DGfiftXWAnd6YfR1anKHc1nxtaVGd
	lOoeM+T2RUSmxAIBoidZ120XsEub+YjHCSfUdlNaBWNxUvbDavF9zMrPBEHn
X-Gm-Gg: ASbGncs/zIUZY9AsfnhehSL3YViE39A+sNnMwoWnzdET7yYI1fBLgfxAM4L9g/EZobb
	E0Cf43aCJcw+G47+pOG3mHSWlcKEyaiXrJyvu/7Qggsrbvt5sD22EBNwgfhotb03t1fwHWo6WRg
	4YL36R+ITUKCJkCiOa+O2fYldMTR0D2DfNPdp3kb2LYnmL+JU8Yf2uh8zt3qUfCKt35QXUk2qUI
	6EXrTKHqUmBvd0/xjO5YCG7Ks1SkBQlQ/YuFmezb53s8gh4AIL2jhkq0JHLmYWK
X-Google-Smtp-Source: AGHT+IFxq39jA6F7LUlex8wfOW9jZaQhVh2rXzXrM/QBMJz1bHhNNth0HMSULAyeCs1uEIg6wvHO4A==
X-Received: by 2002:a05:6102:6d1:b0:4b1:8b53:2987 with SMTP id ada2fe7eead31-4b3d0f66c6cmr5904087137.1.1736435350353;
        Thu, 09 Jan 2025 07:09:10 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:10 -0800 (PST)
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
Subject: [PATCH 13/18] platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:26 -0500
Message-ID: <20250109150731.110799-14-kuurtb@gmail.com>
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

Replace platform_profile_register() with it's device managed version.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a72790cc5e0e..a0b8987bc328 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10649,7 +10649,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dytc_profile, NULL);
+	err = devm_platform_profile_register(&dytc_profile, NULL);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
@@ -10667,14 +10667,8 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	return 0;
 }
 
-static void dytc_profile_exit(void)
-{
-	platform_profile_remove(&dytc_profile);
-}
-
 static struct ibm_struct  dytc_profile_driver_data = {
 	.name = "dytc-profile",
-	.exit = dytc_profile_exit,
 };
 
 /*************************************************************************
-- 
2.47.1


