Return-Path: <linux-acpi+bounces-18463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E86C2D289
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8504B4274F0
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5931961D;
	Mon,  3 Nov 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2I0Hmlu4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079003168E7
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187125; cv=none; b=kHfnA2NxtYs5OCduWOTPNa/JRjrfaP/DmBjX3288hJRrDSNC2R3d2whxhnQ9V8rtYdMKVwBTqxNBCMSFA9V1cXLCoQYuTgyZMN6tVaOLoTLiwbuZ+Nu/kWAgnjwQ4OEnZKFnuQ0b+B1LpuiGHBq/pzCjHvnnNbCyC/Hyulx7nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187125; c=relaxed/simple;
	bh=Wvo7AOBVr+mO/whwsgkD9mvbbAbtW3kvpX/+zaln/XQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trYs42A53/ViuDnJ2GPjt0xavyGGs3WLCivCc1LbbwbNWOebM1CO6QVN6YhUCBPqcelrJnCs04yy4VcdfRWzO1EslZwqFzeybLowsG7KBPma+IIONTmcZQWwEwkQNxOnsNSf9+d1gfp0hWSyzKvmHjPRkvD9yw02tDKz/PoQeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2I0Hmlu4; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-640cc916e65so951850a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762187121; x=1762791921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs/Y/eJJdxTMG9oupGnuvElM7OnZXDeoHwxQXmc30Mc=;
        b=2I0Hmlu4P1cOWVdXT1rQq4OSd+bCR5yluIuY5Vjhua1g/gBPTO1c1nmHtWuc+OMG1O
         kpPK9ULOEa+qKqFFpQ5dFVDZhjKTk888AD7hQdNdb6F4N5pW+bkXI86rSq5r5844SCuy
         pxA4zYQdYR8i1Lcykz5Naybg1eAVVbSEhl0BOOAP59bpKEd/rsr0272BRprUdKvefUHv
         xWOI8aOHBRQFrvGL8PzbAgI7pNv/ML5dYxeYCrXzcHS8Ah4ANZAptoiDmilclWydoeGU
         mM+lzcxn1ty9PPSTU8DoB0mgWVpC2faxZ2FBtCGyvSDmuKW58qmCjhAoCr+qrrKxsdMZ
         GFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187121; x=1762791921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs/Y/eJJdxTMG9oupGnuvElM7OnZXDeoHwxQXmc30Mc=;
        b=S1KMNNar8BuqoDGLNzPWjKG8EDpvidx6Ojnkcd/Tkafc3S9AIv3jaUwXON9U+ad2SD
         q23Yh045Zs40o1zT57lvbCQ2gyIcQOXSO9DmHtTuxjcPp7EMELpGZhfEoOgTEzBL0LC6
         nMA7a5mcnGn+yRfVLeEEMOboKABnFkhyNG6PByMnzCIYjPokiUAvfiLtDdYS0g+PgPXz
         ewY1/sUTL7h8mZnrQJF1ScfGrSLN70tHgZBhK8ONRLw/+LWiDgrNTAULQfzs0uqXjtSp
         oOqKsevcHIUyoLOD9kW3i8923+JmfLviQH/fofXAYXfCb1KyqDFmTcsXZ4dBj/xOndZ6
         drwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXg988CdTcPSXY5dpNhNXbffh9ntlhzCgOMY0iSQXn3iBPG+MhlSd7pXsZfisJ2N2LGEWi6Ni7VeEl@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrS4oUiJPeRQ7uCmM9NZayuBgdH0tL2UocGXFGTwDNBnbzpq/
	jKpWkmBfcGjupBZ61ySNIOM1g6oc3MOW1SQDNJi0rT/hYHyUKZGVYZS/s3sAidQz360OS8dEER0
	xjpfr+A==
X-Google-Smtp-Source: AGHT+IFQGiIYFKNXAfI0IJGk8GJWoQwdfCcDKVgBuoISnz/eHAmO+lpaTPqNtTBAsJEpg4CSWC10r/1aB6U=
X-Received: from edyg9.prod.google.com ([2002:a05:6402:1809:b0:637:e23c:77e0])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5215:b0:640:c454:e9
 with SMTP id 4fb4d7f45d1cf-640c4540435mr3095791a12.4.1762187121269; Mon, 03
 Nov 2025 08:25:21 -0800 (PST)
Date: Mon,  3 Nov 2025 16:25:15 +0000
In-Reply-To: <20251103162516.2606158-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103162516.2606158-1-srosek@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103162516.2606158-2-srosek@google.com>
Subject: [PATCH v4 1/2] ACPI: DPTF: Ignore SoC DTS thermal while scanning
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

The IRQ used by the Intel SoC DTS thermal device for critical
overheating notification is listed in _CRS of device INT3401 which
therefore needs to be enumerated for Intel SoC DTS thermal to work.

The enumeration happens by binding the int3401_thermal driver to the
INT3401 platform device. Thus CONFIG_INT340X_THERMAL is in fact
necessary for enumerating it, so checking CONFIG_INTEL_SOC_DTS_THERMAL
in int340x_thermal_handler_attach() is pointless and INT340X_THERMAL
may as well be selected by INTEL_SOC_DTS_THERMAL.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 7 +------
 drivers/thermal/intel/Kconfig       | 3 ++-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index a222df059a16..947fe50c2ef6 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -11,10 +11,9 @@
 
 #include "../internal.h"
 
-#define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3400"},
-	{"INT3401", INT3401_DEVICE},
+	{"INT3401"},
 	{"INT3402"},
 	{"INT3403"},
 	{"INT3404"},
@@ -76,10 +75,6 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 {
 	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
 		acpi_create_platform_device(adev, NULL);
-	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
-	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
-		 id->driver_data == INT3401_DEVICE)
-		acpi_create_platform_device(adev, NULL);
 	return 1;
 }
 
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index e0268fac7093..347c59bc87d6 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -44,7 +44,8 @@ config INTEL_SOC_DTS_IOSF_CORE
 
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
-	depends on X86 && PCI && ACPI
+	depends on X86_64 && PCI && ACPI && NET
+	select INT340X_THERMAL
 	select INTEL_SOC_DTS_IOSF_CORE
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
-- 
2.51.1.930.gacf6e81ea2-goog


