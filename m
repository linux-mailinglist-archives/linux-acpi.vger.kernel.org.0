Return-Path: <linux-acpi+bounces-10705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C14A12FCC
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C6166179
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627486355;
	Thu, 16 Jan 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cINRcIIA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEBA86338;
	Thu, 16 Jan 2025 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987291; cv=none; b=d5ZsZYYuLxnecuhKN0H/FFOLmrrvYqlowSfclADiVfxTB9hnHK1ghKI4ld4xovQaYKOl61MwgLXaDAYiKUe+PezzlC1j3diSlD3hD5XBWK0EgrJG3y2ZdLu5+SYI1AMTRDE2M7nbsT8Cg8GtTmoLgctLTS6MineSMILn7nMQACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987291; c=relaxed/simple;
	bh=ynLLD1hp1tS0pguRvY3r/dOdcInyalJ4WAMj2kYk6Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRqg0HtCo3saa5bhcTuX8fHmjoN6r/EOdy7Ccpso6E0gXEPvtAG4KOl3hJ51vk8fpbwfwvEC9Ety3RNe7G4NgCNpB9Ca1AiJWMoCtoDr79mUydKlwkEJucqZ74o1i0PMyVwZRPvm2vd3yW1XmHGTtV/upGpc7PXMomYMk617okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cINRcIIA; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so720318276.3;
        Wed, 15 Jan 2025 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987288; x=1737592088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh2IZ/+LRbJ3kOAnhYpwYwboDtnaDw9GF5Rr1PiGf6A=;
        b=cINRcIIAtzCfdpuXD8Jv6Be1+pcw1NFYA+tn5LdI8NC/GQ4+12dW0ofujvge+7w7H3
         9OQyviNpnlvfCVOopZVUECl+OY95Tw07mKKNaHfIkNUslqd4i8L5gDgGHOr6MI1tn4OQ
         5gBCpIjTKi+6hPRbA3aYxXHufHR4AlXgtGvCIkBTTWa5xepHtTgGPMi+TOG7eLPuY5iI
         PwYkaEZ2OWwMPOcc4tKNciSU8//mUf/ADCXVJGuX8el23U/mw9tn3b+6EOfKb21iKB3k
         15oNE5WEMOHQ3qm9Y6hRD7/3dOK4x2kAkYjK1AXc6QZoVER5LVsnncfK85IdFA1H+py9
         +kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987288; x=1737592088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh2IZ/+LRbJ3kOAnhYpwYwboDtnaDw9GF5Rr1PiGf6A=;
        b=L4uVgDOXhLCRDVgGQY+lIjvSDTwA9tKielMXxIYe0aWNsqng0ZS+Bh8dtFePh9dXMm
         YY3weVp3RMShvNsfUWxbxeW5i38ua92NNIT9vWlNJ7OE1bpeP5qpuhuAOm5ek5q6pKAn
         JDVoTr33H23wv+rTSFBmDaQjwuH+ccTBLBYlxjR4Voo/xRspFawKWH4TrcA4Imq9aRVI
         /xb+aP8AyQjela7dlOGUT9t+6QVtUSvo8rlVBMaRU/ApGZ7/BnTeMiwJSV0LvecUv59b
         cTlifJbyWnr+IJeBj3NQF9S67DZLIyzv72EPcItmJ9QoIL610/czBO1+LByJyk8V8MID
         jdqA==
X-Forwarded-Encrypted: i=1; AJvYcCUVyBCu48xRSSfJ5/BKlYU5QA40Csqu+mDahJczNnvVD7jajMp3kU6PN7ORypYdbNwLHwkRIoyxlM8E@vger.kernel.org, AJvYcCXv+LXIkohuAyMl8h2+2KXQ+cPBFiEv1igiS3lKN1xjcPbGiwN9B6aV/zlTh2WK4dwQ6gWezOAl90CUUTRd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2grq7NvpXTospVFykRltESg7Zs36RTddQv/OKFDTefTa9SmWk
	vrog6R58ox96HzyaPN9WqOJegvfhILOWFWWCIAYR24y8Ph7VBhx7jLZOjg==
X-Gm-Gg: ASbGncuY75m+9nBOgdkFAfkgQOqTE0Xw96RmWVRdiXG1CPuQ8IuFH/xc3UY5PlB8IX/
	f3zq1OK7lLGqk26hfR0qKvCqqp70hOOvn3lgoYdGKmWxp7oCcSzm39/DQhZONmVFRnxW1usio4x
	QKOph1vbZj6KgmbbZELdBw/aO7Xmqs4gFT0du7w8Nv50MfqLEoFwDFXcuB2J7mYXdtWNZwHti/P
	SBPiFtyZ7q2eLTjikyx5AdqpxEEsYPPPaTWNgq+widGTv4dYgbIsBr+ICd4EFRP
X-Google-Smtp-Source: AGHT+IGRIstU5oDeyumbVSqS1RR8+YLBpPlforsUvKu+zQH5iPy6xyRGkO4FzJjb66k2ZJqXXQkxPw==
X-Received: by 2002:a05:690c:ec4:b0:6ef:64e8:c704 with SMTP id 00721157ae682-6f53130e83bmr263573397b3.36.1736987288579;
        Wed, 15 Jan 2025 16:28:08 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:08 -0800 (PST)
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
Subject: [PATCH v4 08/19] platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:10 -0500
Message-ID: <20250116002721.75592-9-kuurtb@gmail.com>
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

Replace platform_profile_register() with it's device managed version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/amd/pmf/core.c | 1 -
 drivers/platform/x86/amd/pmf/pmf.h  | 1 -
 drivers/platform/x86/amd/pmf/sps.c  | 7 +------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 57ee95a327be..1211a753fee8 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -371,7 +371,6 @@ static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
 	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
 	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
 		power_supply_unreg_notifier(&dev->pwr_src_notifier);
-		amd_pmf_deinit_sps(dev);
 	}
 
 	if (dev->smart_pc_enabled) {
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index 080818dd173b..d99b3556205b 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -780,7 +780,6 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
 void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
 			   struct amd_pmf_static_slider_granular *table);
 int amd_pmf_init_sps(struct amd_pmf_dev *dev);
-void amd_pmf_deinit_sps(struct amd_pmf_dev *dev);
 int apmf_get_static_slider_granular(struct amd_pmf_dev *pdev,
 				    struct apmf_static_slider_granular_output *output);
 bool is_pprof_balanced(struct amd_pmf_dev *pmf);
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e710405b581f..7c7ed2b9de01 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -425,15 +425,10 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	dev->pprof.ops = &amd_pmf_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dev->pprof, dev);
+	err = devm_platform_profile_register(&dev->pprof, dev);
 	if (err)
 		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
 			err);
 
 	return err;
 }
-
-void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
-{
-	platform_profile_remove(&dev->pprof);
-}
-- 
2.48.1


