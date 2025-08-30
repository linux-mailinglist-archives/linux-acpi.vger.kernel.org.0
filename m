Return-Path: <linux-acpi+bounces-16207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE27BB3C835
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944D3585067
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A7283C93;
	Sat, 30 Aug 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36vHN7AF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08903243954
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532070; cv=none; b=TPxeCWWNI/h8PwHPDQq+zqzX9lFK7rP6Uk5ELO+qnadyTY/c/++8kFOxHil1wUPZvD4Uiqi0HkX2G+jm0E2nakKr2OUc2uG67+Wfjocn/FQcGW2LIK+lhuB0GkrHyXiroUV2ZfBbgR6mssuZYquSEPJHWLsGDbOdeLWHDZO2uo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532070; c=relaxed/simple;
	bh=yh1s/4XdOm4bfUnjYYkKcPd+/Q0qGHqKo6VPnyJx6aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q53xnIgUDxtHHlC+qxNhsd310piJujE6JMumVuGW3zl2wL1QFkXMEL+g4NwFxbpQy+Y0VNN5x52N87tLQrWIPRBXUqarQ2hSPGN8q4aE529uPFs+5h+i4ANQAjH4Av0dkE4nOzKxroMgYEau02mji4A0sV/zeXNNTP7+ykj9YYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36vHN7AF; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61d2ab4bc04so129673a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532066; x=1757136866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGlMhdHsRDhXgZTq2403xXjFFF1JZ/LTlsCLMGC7kp8=;
        b=36vHN7AFl/J69y0HFghxDuQ/x/ZRvkhRijIq1XGBn5f3m/uV3dH8nTH9IvMd0A2DnH
         U/m/R7H7bkRhfT1ZOGhyoaVoYEVsm3xF2tTGv011Q1b6jCWdzGe9rLydS8j7z3c7tLO6
         KCsJvzXtkmyd3jWrnQQg733qok+UX/KlOR+mXGrFPEDsuI9d+E2rT6dQmVAPF+BMJXVA
         mS1EKpYrCjKpPxsUKMKMW2SbEMdmBH9nrzLThLSLnshHWcWilaQqGMK9sdeLLxMUS3kW
         7YVdkHd1iqiqevQqU0zu3KNFqG19kOKIA1kQ8dMvTfxapNxeE49iXRLWirCLY34z8hZo
         HBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532066; x=1757136866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGlMhdHsRDhXgZTq2403xXjFFF1JZ/LTlsCLMGC7kp8=;
        b=gGeNB06SGb1/PnCVUEf4j5vrMQLzDR4rNNWxxe0hhqiQK4LB8SgJe6QJv+lWpl4ygO
         iDC8kqsZbLZcJGLWl9VhSlP80/qF2qHLvEyE5LrAGv68AymGUubORQXeepnId0bUUXOz
         o3frn/iEF+SCbUOexAcadb/iBECWtre2CTbWVKH0MpqFYqx0Jn3hVljY8h4957KkoNyl
         ODpvcxLFy0VoTL33GG2aoFP7Lt08QxghHvbyCx9Q0L4tJ5YU8O2D14xlGuVR4sqIkQuX
         P7YwRW7tH8h7gTPJN6H1uZ9abStK0UjRdh9lc6uDWObHdOWjn2+OdZh89IX/RxinM8DD
         uqZw==
X-Forwarded-Encrypted: i=1; AJvYcCVvIKAMXw289JPlQ4K2tzEdfvctVt6G6uW3REfKauPA55iYyNNmKoZfwCIEvAr6kQsMAzYPOdiRqZkL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Sn9XzFbvjKtfyOIAKeAOEhCYI/28yabnl5QAhOUuwZi+OhJ9
	+KONADqjIgxEja3oDNnP8eCfXkQXXXhyCKyFWZaMxmtJtVzxdMu5SVtpP5nWydBPUXvNyfOoVcD
	+pktDCw==
X-Google-Smtp-Source: AGHT+IEu5x1ALBVIzEezIw0LvztceM59QoeusqIvEaPTRqp1/Ww5fpBS+OVA8nT4EL6qEP+OLj4cZeZZbLo=
X-Received: from edf15.prod.google.com ([2002:a05:6402:21cf:b0:61c:a931:8740])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:84d:b0:61c:ea57:6d6a
 with SMTP id 4fb4d7f45d1cf-61d26fd0f04mr806898a12.24.1756532066455; Fri, 29
 Aug 2025 22:34:26 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:56 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-5-srosek@google.com>
Subject: [PATCH v1 04/12] ACPI: DPTF: Move INT3402 device IDs to header
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

The ACPI INT3402 device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c                     | 2 +-
 drivers/acpi/int340x_thermal.h                          | 3 +++
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 8fa85c866675..cf2e95a4f65a 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -15,7 +15,7 @@
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3400_DEVICE_IDS,
 	ACPI_INT3401_DEVICE_IDS,
-	{"INT3402"},
+	ACPI_INT3402_DEVICE_IDS,
 	{"INT3403"},
 	{"INT3404"},
 	{"INT3406"},
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index 3ecd6c4bf2ca..cc1dfa56fc09 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -21,4 +21,7 @@
 #define ACPI_INT3401_DEVICE_IDS	\
 	{"INT3401"}
 
+#define ACPI_INT3402_DEVICE_IDS	\
+	{"INT3402"}
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 57b90005888a..213d4535f2c1 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include "int340x_thermal_zone.h"
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 #define INT3402_PERF_CHANGED_EVENT	0x80
 #define INT3402_THERMAL_EVENT		0x90
@@ -84,7 +85,7 @@ static void int3402_thermal_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3402_thermal_match[] = {
-	{"INT3402", 0},
+	ACPI_INT3402_DEVICE_IDS,
 	{}
 };
 
-- 
2.51.0.318.gd7df087d1a-goog


