Return-Path: <linux-acpi+bounces-10609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E5A10B17
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F47169EEF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110B1F8EF3;
	Tue, 14 Jan 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJhzbCPz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91A1B2199;
	Tue, 14 Jan 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869117; cv=none; b=tIdvFsOoNcXKstWE2j4KII7r1C4I0rPCweREw+gH7AtsbVsouSu2H6lDRxO+A8W7vrI9pQY4f25e+Xqxa5+uAgeozL/r4g7Qre6+o/eK32nW6/rukAEVwPIsUXwGV9DTHTfNyWn5ODOV0DCIgGHyuLTS0dDzpfg7JWrD42JrvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869117; c=relaxed/simple;
	bh=zkjAivanrILN0QwKTQomumxo5DHvP/B4R+arBJ3ZtKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Drx520FdPBVXNr9dK+U5+RNRbTZL2CeKRi9X78iowM/ooXmaDgFKX7qXiC+iseAWaHElD+yayQqpUBtHSOHNnSmqMYOV8baHWcprxylb2olzXvO7ivqSJ206yzs3c57GJfqW8WIoF9KZ339qVSjXUpsJbq4K1iEZWE9GWMa5xmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJhzbCPz; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c559ed230so1284050241.0;
        Tue, 14 Jan 2025 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869114; x=1737473914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD4+zxqyF6rDN55QCqbXpu0oMdAVgFHxRkeXOF8oJvE=;
        b=FJhzbCPzceQ/RSkc+04VnCiEh6Z6Gj2FaAfI1K15FH/4Do2zmdPwJuiOSFyPs6MsXP
         f0PKclbXwBS802zTUtB/jwlWVnCH3UkQZhl6wpqbeyPvx83/oZmQ+Jak+CN86tXhmhNw
         O0XbEseeESl6bGhyysDkMLxjAnryT2xKitDcDQ81QLWGwslh7i7f46TMrCvH2MBaCcT/
         guEP1h9gGWNtEx/pIVMpY545w2zWmcdXgd0GYacP92X7K2MrzSf4kGXwqbZ8DD6KHevE
         ia+kDZw6127M079Wb8U0ctHjAYQhk0L2fWzW5hiAPF+Eiq8QuDsYR3ZDnuuMxvhAXgyz
         rxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869114; x=1737473914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD4+zxqyF6rDN55QCqbXpu0oMdAVgFHxRkeXOF8oJvE=;
        b=P3QTLQ73I1/5RPtSaHc7MpEVtVlVhXr601mekkgS/osthIZfVi+vPifYL64yfmKFM7
         1oyJ1wmUDXi+f3MjBo5L1c4ouKEivbO3ajTGoE8/+junyKN4e4Yuea06nD6udSwnJ6Iy
         hhcbfmSCvRJIDvmXQbgUMihhiSOMYPaHQ83ZjUbJaSS0wmp+Gv6gpllHWa6t83mY6eWX
         TnDTJ2KJdsSL7W1Gkaf+NOMSruyFiW4SGiTDWTlgVeWEMK/CP0Gz2PKeJy3Ls/dKpDcb
         J92G6T0CzHl8DNCARL+jGjSRHpHOWbEcjdGTK79H9UUBDpz4ueiua3eKS4QIbm0J0q6g
         0oig==
X-Forwarded-Encrypted: i=1; AJvYcCWkY/QcasY9nD4uE/NudAvwLLINfnS7fPfPzIRBeEgaDjikIq1UnCAGkFHdMD6B6+11qQjVK06bgkX4HeTk@vger.kernel.org, AJvYcCX4l9T8j4N+OVum1wovOwTtAiDC3DdqmfhRRYuQuWo/IIMk4kg1BvrI8cnz3JuwSr86BE5SNVhjVNOC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e9Basro1v1POR8hUOTbmKLhMyqjViMSS5LwbBH1LIw9dtkpb
	doOv9G6NYV5CGx3a9caVGj2Mps5NN17yx/vhEKQq/3I/w/X0rJ3czNG3SQ==
X-Gm-Gg: ASbGnctfgGh3Kjdfaoe0PSwXEoNVMZzVVAFT4Odlb9bWa7T8+GARgtkx46fgARfs636
	HYmMO2ksXLYTWB1dmPv3EcR5Cbq4EXB+xLT9M6Q/pD1uW9CjbbgOFu/7hLwCEtf3yKw+D4vcbjG
	3J/b4WezD3zLxlOXWRQTvdPk6QmBhKK5jI2xRYQ3LgIwbdmCzVKeh5FE0Y2WVIjcFr57OgViunb
	kfd5412RdvM56D9n+8ylB5KSVYSXKVY1+j7OBL1D2K1fcLdgznm20RTwoejeqey
X-Google-Smtp-Source: AGHT+IGlPSc8xaym7V4UN0dZ4GF8gO3oMJ5nUCqxvkaKnzbl3wrr9CpllwxhQbjiRXMtVZLA75/O4g==
X-Received: by 2002:a05:6122:3d04:b0:515:d2d1:7c0d with SMTP id 71dfb90a1353d-51c6c4691c4mr20013183e0c.5.1736869114289;
        Tue, 14 Jan 2025 07:38:34 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:33 -0800 (PST)
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
Subject: [PATCH v2 08/18] platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:16 -0500
Message-ID: <20250114153726.11802-9-kuurtb@gmail.com>
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
2.47.1


