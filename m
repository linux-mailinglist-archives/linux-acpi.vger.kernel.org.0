Return-Path: <linux-acpi+bounces-10456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4AAA07B45
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4529D188C553
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E321D580;
	Thu,  9 Jan 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVCd58VL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69921D018;
	Thu,  9 Jan 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435314; cv=none; b=inPFXH3kMccMuOgRKGAAzpfT5GPvXAyVch4Fajv2pS2SJaup1hL03gMEMKuGfZ+affb0+eam8lkxrLqWzLrGRzGhNw5LVFcT3XR4xndyeHV67goG9JYnbAlOWI5mkj+WcrVYgcBzhMaktMq/T15ndxryC8ts1I5YMfwEh3obm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435314; c=relaxed/simple;
	bh=AgiCZajH9sjLEAC/PKeyz7IcBzBLd4dscfluYeRgNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qxod6EW7n1MFiss2UlGjQgT67ThmOOc/a9Vi7gQjXZgjzbchxr83TWnMwN5B3mTg+Gpk/iRCijvq9Ce+zpPJF06GUUWOa5q7WKFnUfT4Z80l3nA9Afgr/xSYMoEm5syQDOyAe8IcJlB2c/dOd4jMkUYkSYNobHYHrY6H91OS5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVCd58VL; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b11a11a4f0so407920137.3;
        Thu, 09 Jan 2025 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435312; x=1737040112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtcPmrAHgkUUo4sRfcFR6W1QqvjqY3PBg9aacIt0Kcs=;
        b=kVCd58VLXvsl+oQY+aMD2nUBsa5iGZSEDA74emGCHCyWQe8Bh4mfrl3pVZrqMtH0+d
         QcJYszSAb/e8W5s9HwfYjyx4fRNAq3GUMMkGOfzBwoo3WjnpInP4LMsSAL0W4lir+RnC
         j1m1xuGhF1QGrhnxqWNmqahpszvnzfaFVZ6xIDol9iRnn2BIeTO4YQz2LSLk2oUF4erd
         HA+8cJnxZfjzdO1xx+vPwzelNLGrsa4bXwEBJ7CMIjRXGjq85Pvo2vWqo3VSYvbSIHVD
         mFvwPA/X5AtnPnSsN/niDdFAxkBPIZVIi/2Cf4Iwr3szcbJxP005dzv3JQ1r79XAs1pU
         MCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435312; x=1737040112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtcPmrAHgkUUo4sRfcFR6W1QqvjqY3PBg9aacIt0Kcs=;
        b=QVZSLIVVdut5AtXxIneJwilgYlGcW27ANeeWn25i6htghLEY1ZueEgBa6cK6AZjEyC
         GV26iUfwtObdAWDnQwgffc+1ICyWbPQugi5uAMB+8r0IdWLEgb//DdC2uNxCj+QOxjg7
         FrFaQPqPWUcAqi/I/uCPpYDJg3aRoxVI1/d7nJhxKI0u++rctInjBIGqEOJRRavAWYfD
         LpSxHUdfut3mh5WfpJEbZ0HFu9ktEnxnNOjIHfOhlFFmAJ6Lq/g8CEcfWAeANPLenRdm
         zYnzn4L0Y5UTOOHOu3uLF3IiGvKgd590cq76UCtC2/rqkPAk/nWnbQV2/a9dpecWb26g
         b9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVRB7nKMicQEVKfk9BrH9uDMgZmKtYke6rERx+JzVcqG9B36m1fZWD64KvDwQWmkMX23PqSDIymZ4hu@vger.kernel.org, AJvYcCXG/hGRAwU83qEnEkytXW3nF7ikJLv1O3XZqiMXeBOif5a3ZLHq8Nw0GEyV5MIqIBrwI/HQ5rIAupS8Dm7r@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QHJaUrPBay8fwUDCBMhF6mc/CIqiP43Pcmc8jiV5lAJQFLRu
	BZ+/nnLftM9dNH7bdeP7E+XPiZMDP3OkyveIPSO87JCDhpYw2aTVAnBjtHTJ
X-Gm-Gg: ASbGncvjiUWRU1hH/NfYhbvVeI/0W2fsZ/XecODMfXRHcUgqyQg5LC9yTV/YSu5IRn9
	MoYa+5cwUUcV/NIfZsv19YshG2sEtEIk/equKI91zkqVZE6I3436p1zo0nEy5HC4ucxJXiLWaJE
	BsNAQ5UT5jHkXWlqPvD/a9KPCDaM9hw+QDJTfw8jFSu0n5OKyZDQACAijONufMyxb5qQz+F7odq
	0vILH3nsH21WoXoTzTdm98hEkiTm9OHfi4XHnpLJS13tLAZxyZpICbnLH4EHAjQ
X-Google-Smtp-Source: AGHT+IFMtfJ8yR7tBbL8mxs/WV+A3Jnd18ab6j3DFPxW2nqJWpQEUJz65hKjWpLExsDmpWKF/fxEGA==
X-Received: by 2002:a05:6102:3ec1:b0:4b6:1a4e:9ed7 with SMTP id ada2fe7eead31-4b61a4ea005mr1464980137.5.1736435311971;
        Thu, 09 Jan 2025 07:08:31 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:31 -0800 (PST)
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
Subject: [PATCH 07/18] platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:20 -0500
Message-ID: <20250109150731.110799-8-kuurtb@gmail.com>
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
While at it, pass amd_pmf_dev to the class device as drvdata and replace
uses of container_of() with dev_get_drvdata().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/amd/pmf/core.c |  1 -
 drivers/platform/x86/amd/pmf/pmf.h  |  1 -
 drivers/platform/x86/amd/pmf/sps.c  | 11 +++--------
 3 files changed, 3 insertions(+), 10 deletions(-)

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
index 56024eb40266..198bfe3306be 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -764,7 +764,6 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
 void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
 			   struct amd_pmf_static_slider_granular *table);
 int amd_pmf_init_sps(struct amd_pmf_dev *dev);
-void amd_pmf_deinit_sps(struct amd_pmf_dev *dev);
 int apmf_get_static_slider_granular(struct amd_pmf_dev *pdev,
 				    struct apmf_static_slider_granular_output *output);
 bool is_pprof_balanced(struct amd_pmf_dev *pmf);
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 8e75ebd25e21..4f80a73eff9f 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -285,7 +285,7 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
 static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
 			       enum platform_profile_option *profile)
 {
-	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
+	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
 
 	*profile = pmf->current_profile;
 	return 0;
@@ -366,7 +366,7 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 			       enum platform_profile_option profile)
 {
-	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
+	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
 	int ret = 0;
 
 	pmf->current_profile = profile;
@@ -425,15 +425,10 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	dev->pprof.ops = &amd_pmf_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dev->pprof, NULL);
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


