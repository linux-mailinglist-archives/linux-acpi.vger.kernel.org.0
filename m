Return-Path: <linux-acpi+bounces-10656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21419A11A98
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D20167801
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E8236A8B;
	Wed, 15 Jan 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRvDiCgT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56E2309B3;
	Wed, 15 Jan 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925135; cv=none; b=sRDmyH53RwViWDsB1YWyQtBYsb7AOCSRIOc51b7sd/F82aPE5BB4NxFZ1Qx1zv0dZb1fiaEWlCg8L8A3gXvudJd2KrDFxtRZZ+Of8FNyj4gTpkYKD+1l+qSLeYQyh8rbwIwKJLm5SGz5unDK9vynSEVbWDZnra4rFs+aTnuKraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925135; c=relaxed/simple;
	bh=oxgHftrvXpsaeUmf64aRPx7+pUW+fVHAj8lkNglYXtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROzkC/YYDOq6y6cLw7ekr47e+qbCsnmDlpVjx9hgNyZNPJteVudRFrV/5+tc2QSH8wuNChLrv83CKpVKMxPA3b8j/NeuAUiJ49ioy/NIIU6h9e7NXDHxdcfzcEslajFbqPm0GZlCTv5+N0JkZ0aMYW1m6x1ZeEvYhbvfCqGp+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRvDiCgT; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afdd15db60so1984132137.1;
        Tue, 14 Jan 2025 23:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925132; x=1737529932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lttd5e/XgGU5D1dWcZNa2fZ0ZfD8k7ZaaUNVAG5OZco=;
        b=VRvDiCgT9H3HnYL6Y53PTsxDHcfAScJTguJPnPAusZ8+sZIB/m5ahnBeQ90kej+GXp
         pqpZ5UrLfV8pspfT7qLMMzmgZopDfENd/dw+eA+Dl57L3Cx/m6/y70iI5tNGWCNYP2mL
         92LgfIwVavAju4hZ6mUK5f6yiSyLRkxdMD4vdkbQLOUcOUwIIVqiGxj75NEVpLBfne28
         grokMgMLrf+TZ8XqN+oAZ1ZOvBAXWWU3RCoR02isf/bE8K4TxDEW1fc0vQGyPtZlow8+
         +eYIs8D4L0TvoTDVy5eFI31IFO4OHk2G0teNAICetWjdicfBcMeDbEbj9mUZ+MzxYjxQ
         YZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925132; x=1737529932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lttd5e/XgGU5D1dWcZNa2fZ0ZfD8k7ZaaUNVAG5OZco=;
        b=Cy323rlaI09yIRv+dueUAeUgn1QVQd4y/0L5NyPix7F1hrJctKPDny7zJQPxrCS7mx
         aRaGPZMd5WdZmUY/IthDNnf0iJWFD7x3qbZN3fgVYT1b7v1SKY8Bn5Q3glKFafuhnlSC
         YBW2OHXZ5hor0RSepCJG7T5DQ/CCxwMoFp4Lsj+upPh46+Law4eCobSiC92onEuy7KOm
         CUARXt/WosgfeELeO89a9yDGOzs6olqHifHRS2oO66/klYaGQAjIFn+i58X+mQEHuAZh
         RXYw5vZ0Fzh0FVCBoWb+Azi9jBKtOtEVJHLRFPvp0kA/j8kouoaSGpmW6Eo6+0PPeqke
         MFxA==
X-Forwarded-Encrypted: i=1; AJvYcCUfkkqx1j5lJJWXnDDfFYW1DQPVkXU0fKxXnB/lGdmRo1eFSMvjApDX948IqvXJ6UR68BBOIFE9PJ1a@vger.kernel.org, AJvYcCXoBF9VJl+K6X4EpvkhHGZ01OxNmAGrwmF7OYNjvuA1lBwAeJy2Q7bIgErrpiMZxHNFNOIPIN2GodwYV76F@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAhlbN3YpAFgv75rRwKhLWMZDVypfExURaUlh359EtTFjnBkP
	fzx1neoxNkuD8ufAB3JNg7pK7lU7EocmZWLNYhQJvDAChEl0687YTvklcg==
X-Gm-Gg: ASbGncu8zw/lvV9AfcEjZy7+DUivEKbXRNPuyXum5U+ZcB8Vg/czekbD3iykXexKfiy
	oU0CvVcRhc4trONwgV4XxHI2SOzrBdh8/m2XHWYaxet8DxRumDqCFBzuRLg0spKdvWoOHmv4omG
	iEa46u4g1fDwhm69Rx4AAgvmJDi8bBRG4fGclHYJ2TTbjwiSEDiDxczrGBsyIo6LEGWBFcHqcrR
	kt1QP5jr6rdzI9A9hOqKRCTVGgryeraJCZYpn6tlP91DM3zbB93BC0q175Qt9KL
X-Google-Smtp-Source: AGHT+IHILB1uzLUhtVDU8UGO3sIb6FO+6bCvUtaVO9PY5aLhHwham5BMinNn19cI79JKKSvG7HWJcw==
X-Received: by 2002:a05:6102:b06:b0:4af:adf8:523f with SMTP id ada2fe7eead31-4b3d0f97294mr20423665137.9.1736925132467;
        Tue, 14 Jan 2025 23:12:12 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:11 -0800 (PST)
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
Subject: [PATCH v3 08/19] platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:11 -0500
Message-ID: <20250115071022.4815-9-kuurtb@gmail.com>
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
2.48.0


