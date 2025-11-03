Return-Path: <linux-acpi+bounces-18464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F301C2D1CB
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBD9E4E94FC
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116731A545;
	Mon,  3 Nov 2025 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e94N6K86"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323D3191DF
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187126; cv=none; b=QLSGqdTOtyMxxcfT4CdGA6Awosl1s0UbOm9h4/l7Vz4FlAdvyG/SbCcxWa/q9gfrQ5MupwMtOPJJD+5s5+DU4RPJSe6UsJHojs2LmGTI+xaeJ3axm63Sl9IpNyG9z/1KORtxWT6YQgVdhq0a/2TqDmk2hB5pi0F/vw1jfPXLPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187126; c=relaxed/simple;
	bh=LxQZgf2HnuUMeU9edGXcDUt73WkU+A0YSngIF9fVyAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oi8o2ZbsjfY25gh/OKMnASjGfB4OtWUFtYwClcwdeo7b2kQfdX7Wx8UOzXSxwyxh/8bHUjutn77VcmzrJsQPz+Flk1PmsViBFypvMdvPfwM+PgzOAHACYz4nZ79L444ZqnNd/B+xGRI2qKzpjVUKcdBd3TY7ICzqWJdOW+ZGnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e94N6K86; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64095177aedso3304207a12.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 08:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762187122; x=1762791922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOz0Kbi3roD0dL0luBu5UZaKp5cFDGW+xLFvY383548=;
        b=e94N6K86jXC+Oojak43YrnkCmwaOAjgOVLYjbmuaI7Ayh6MBgFTyNVRM593UpH4caT
         F+j6pmu7IHGIToGEHXwg9vt6uVDLy2j+OD1zQUO21R1fA+/tiQNiVkdd71UzNaxsGyPj
         DFenS35CsYflUVYRSF07hQSqoYNj6bZlPOogw8UaB2cDXmuYdxMIPVAJa7unNYamKBx9
         bcMXGOhPmqFcFpMJLO/SC/pM8IvG0CATVim5cDrjMyhIyvVDfFVPlYkKcunCuAZYM/IJ
         +1EHAUJRZ7tIorYBBoyF6K3yYSCoZ9WioEVZ2Oet5s/q8SGGI4V+WNh8iKDTxA9GSvAR
         cchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187122; x=1762791922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOz0Kbi3roD0dL0luBu5UZaKp5cFDGW+xLFvY383548=;
        b=uzn/zZESSf/zV2UAxVHVWqdoKtpUce9dKqAQiPlZXjEYUTJmu9tfvrD8p8oUQ2ZE/B
         Kqmo5tIaYnCjnyWFRKt59JjiCRpNtD4KwpOxT0U3Zdd+be7Ui+6q0OAyw4WBDb7KhlrV
         fd/06IA57CUXGWyy174Je11T7YLZhcJb5DLjY3XZa4q2m2xQT1qxYIxx+fHI1zWiXitq
         pRHfPXnVRcn8rEDoEq33HMRD2DdgQFPzXABtLWeq72miR2s9btu+PLeg38cKGBOD1lqe
         a9EtVgov3PxnniReywbpzei8uf1ZmfnvDewHkrN6x438dcPtjsg8VQlVs741onPLAGrB
         U33g==
X-Forwarded-Encrypted: i=1; AJvYcCVKezM6GzJn8dmbq3RqNGTbk+tvCuXtsgOTWimDn6OhVXAEWxG3e7j8gAuoIYq4ApquUvXPBV8p0jcx@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIFi8tDFsD5+0QReEyMCQz2/Q6CV4Crg6YLMvDhXPNX0buR4C
	KgmgugEwQpDdPqyv6R/mJpDqBj0+GMs/7vrJxbvHJ/mxLUm0zGIyTGPw2b2CFi/EIvjVZiIe2Vs
	05kvi/Q==
X-Google-Smtp-Source: AGHT+IEo7Aky75NVYGYwD0Pfqo7jVj/fGD3ob+vOIpBrprD2ZKbijg/FNXrgLvmuPpvaV70fpiXT65V17EI=
X-Received: from edaa26.prod.google.com ([2002:a05:6402:24da:b0:640:76f3:8bf0])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4504:b0:640:bafb:3598
 with SMTP id 4fb4d7f45d1cf-640bafb3740mr3199107a12.38.1762187122220; Mon, 03
 Nov 2025 08:25:22 -0800 (PST)
Date: Mon,  3 Nov 2025 16:25:16 +0000
In-Reply-To: <20251103162516.2606158-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103162516.2606158-1-srosek@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103162516.2606158-3-srosek@google.com>
Subject: [PATCH v4 2/2] ACPI: DPTF: Remove int340x thermal scan handler
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Using the IS_ENABLED() macro in the int340x_thermal_handler_attach()
forces the kernel to be recompiled when thermal drivers are enabled
or disabled, which is a significant limitation of its modularity.
The IS_ENABLED() macro is particularly problematic for the Android
Generic Kernel Image (GKI) project which uses unified core kernel
while SoC/board support is moved to loadable vendor modules.

The Intel Dynamic Platform and Thermal Framework (DPTF) requires
thermal drivers to be loaded at runtime, thus ACPI bus scan handler
is not needed and acpi_default_enumeration() may create all platform
devices, regardless of the actual setting of CONFIG_INT340X_THERMAL.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/Makefile          |  1 -
 drivers/acpi/dptf/int340x_thermal.c | 89 -----------------------------
 drivers/acpi/internal.h             |  1 -
 drivers/acpi/scan.c                 |  1 -
 4 files changed, 92 deletions(-)
 delete mode 100644 drivers/acpi/dptf/int340x_thermal.c

diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
index 297340682f66..e912a3be1d28 100644
--- a/drivers/acpi/dptf/Makefile
+++ b/drivers/acpi/dptf/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI)             += int340x_thermal.o
 obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
 obj-$(CONFIG_DPTF_PCH_FIVR)	+= dptf_pch_fivr.o
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
deleted file mode 100644
index 947fe50c2ef6..000000000000
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * ACPI support for int340x thermal drivers
- *
- * Copyright (C) 2014, Intel Corporation
- * Authors: Zhang Rui <rui.zhang@intel.com>
- */
-
-#include <linux/acpi.h>
-#include <linux/module.h>
-
-#include "../internal.h"
-
-static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT3400"},
-	{"INT3401"},
-	{"INT3402"},
-	{"INT3403"},
-	{"INT3404"},
-	{"INT3406"},
-	{"INT3407"},
-	{"INT3408"},
-	{"INT3409"},
-	{"INT340A"},
-	{"INT340B"},
-	{"INT3532"},
-	{"INTC1040"},
-	{"INTC1041"},
-	{"INTC1042"},
-	{"INTC1043"},
-	{"INTC1044"},
-	{"INTC1045"},
-	{"INTC1046"},
-	{"INTC1047"},
-	{"INTC1048"},
-	{"INTC1049"},
-	{"INTC1050"},
-	{"INTC1060"},
-	{"INTC1061"},
-	{"INTC1062"},
-	{"INTC1063"},
-	{"INTC1064"},
-	{"INTC1065"},
-	{"INTC1066"},
-	{"INTC1068"},
-	{"INTC1069"},
-	{"INTC106A"},
-	{"INTC106B"},
-	{"INTC106C"},
-	{"INTC106D"},
-	{"INTC10A0"},
-	{"INTC10A1"},
-	{"INTC10A2"},
-	{"INTC10A3"},
-	{"INTC10A4"},
-	{"INTC10A5"},
-	{"INTC10D4"},
-	{"INTC10D5"},
-	{"INTC10D6"},
-	{"INTC10D7"},
-	{"INTC10D8"},
-	{"INTC10D9"},
-	{"INTC10FC"},
-	{"INTC10FD"},
-	{"INTC10FE"},
-	{"INTC10FF"},
-	{"INTC1100"},
-	{"INTC1101"},
-	{"INTC1102"},
-	{""},
-};
-
-static int int340x_thermal_handler_attach(struct acpi_device *adev,
-					const struct acpi_device_id *id)
-{
-	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
-		acpi_create_platform_device(adev, NULL);
-	return 1;
-}
-
-static struct acpi_scan_handler int340x_thermal_handler = {
-	.ids = int340x_thermal_device_ids,
-	.attach = int340x_thermal_handler_attach,
-};
-
-void __init acpi_int340x_thermal_init(void)
-{
-	acpi_scan_add_handler(&int340x_thermal_handler);
-}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 63354972ab0b..40f875b265a9 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -27,7 +27,6 @@ static inline void acpi_pci_link_init(void) {}
 void acpi_processor_init(void);
 void acpi_platform_init(void);
 void acpi_pnp_init(void);
-void acpi_int340x_thermal_init(void);
 int acpi_sysfs_init(void);
 void acpi_gpe_apply_masked_gpes(void);
 void acpi_container_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ef16d58b2949..b74cb80ff587 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2711,7 +2711,6 @@ void __init acpi_scan_init(void)
 	acpi_watchdog_init();
 	acpi_pnp_init();
 	acpi_power_resources_init();
-	acpi_int340x_thermal_init();
 	acpi_init_lpit();
 
 	acpi_scan_add_handler(&generic_device_handler);
-- 
2.51.1.930.gacf6e81ea2-goog


