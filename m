Return-Path: <linux-acpi+bounces-17500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DDBB3C2B
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5579F16A2C8
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912430F934;
	Thu,  2 Oct 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLlJpLf1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0026A0A7
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404850; cv=none; b=ZjAEaoiNJ/Qmc4oIIUPoGa1AEcDUPbHjB3iTPNFRcnOrpa6MYn66bHZFYPTcrzrbi5I9vN0rgC7Tkeorh7Rn0hHenILub6Y4RDVW3DcQ7kRp/AMR1bkPSAKfJychZPqpsks1ZVERMcSpeAlA+0HoSRyj03YGAH6WM1jlUEOHQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404850; c=relaxed/simple;
	bh=OSzoS5rtTLi/B+hMV5Q0JgIBDtwwSwS8cCrabNTJlVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UnfoK1rAS/gL75JzXM0buzElYa5X6ehjdDfsHkgcKhqAV/t2aPu6X8dxGBftWghKs7LWSzPYvr39b+pamfbyO5qpUFn/icLmg4allZtSYgkpo75qfcDH1LbLNZ6X9bjp4WR8g8ooWiY4iol3M4EH9G6LdG5Ds7rnswn11CYX0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLlJpLf1; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6232f49fc79so912113a12.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404847; x=1760009647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt82+dwcyqqy/z3wY/WnDR+0tOJqjHYe0Y3q58yXyz0=;
        b=hLlJpLf1LBpyxi1QHdOwLXUB0LjIP5F3rOJbd4A+jwmBoL1PdHLmRBg0BYOmbykquh
         uGDNak7CUUS1dToS5LW3PU+iNWM+twOgH7ITW6xH/AgD3qmgph8H5Gfz+WEK8dHcsECc
         YHElEXWihUiBuPeeZQNm8CfkYMvQMzHL4bSWp6wMWMSI1Y3FgfSSQuiIRlyGFQ6lwARA
         2v4CnCkFuDAnls5n7ehtNmB0x6XRmi+k0zHRcaWRh0ushvU6fbHdCTOLllSbbEYI3QlO
         JF9tURnRyghVZefw6o97C4EWewyAEoQr7JphNoS5x2mohNwwdUsmx68k150O+gOenYnS
         c8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404847; x=1760009647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt82+dwcyqqy/z3wY/WnDR+0tOJqjHYe0Y3q58yXyz0=;
        b=NzI+c4WFmpHXaS9aA41jnRUS0ULcMOblRC1L3k0CseiSs6bLZM+rvnd5lEtzIZd1Vl
         +IyEU9qAs+O3wttYLf+GdzARjQlLw1B03z/PemE0YThqJndNQwbxgM2IrgeGW3IzXqQB
         YHC6lEbxGi7H2hKlB2cC7k54/CYqSh5ZbH3gl32oxUGlehGKK5+lBna/4O9I0C3HvTW6
         wY9nA/yRrvVErXF2GccEeUP01/imV1QrEipw8PxofHWoDPq22Yo0y2zsM7K1H+OSzUSf
         T4CjRqILtbB8WEdSZMHewuqQk3MPlE38NOtcz1FTyOuXLy+JWoIp/53xQjckfVqMhbah
         A2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUuH0F9xVZ/p74qcqFCEmL8ZhncXCSGFAxfqONqkjgp2ff+dNuLlXCyzwXV0BWMnQB9R/hiUHIBo+dA@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCk/somxF2wW/AsK77slsK1E+3xlMAATr8ioLlZkB2on+StpN
	Nz8rOUaJ47HPYwLKW/s5LGJbF53NIXhplj/zvPm4yzLW2iHBmvUyx/8QF/lGPY3TqfLAOVyzVwi
	1P6jZHQ==
X-Google-Smtp-Source: AGHT+IE+4068072UB8enIKGqreBK+V8kMqDIEgu9uXCRHP5CJrH3i0Dac1P6YuynTCl4M7Vi7LVvL4CfTWc=
X-Received: from edsf20.prod.google.com ([2002:aa7:d854:0:b0:62f:c143:5d77])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:c60c:0:b0:634:bc7b:440e
 with SMTP id 4fb4d7f45d1cf-63678c9f531mr6099293a12.36.1759404847361; Thu, 02
 Oct 2025 04:34:07 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:33:59 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-2-srosek@google.com>
Subject: [PATCH v3 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
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

The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
critical overheating notification. The IRQ 86 is described in the _CRS
control method of INT3401 device, thus Intel SoC DTS thermal driver
requires INT3401 device to be enumerated.

Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE()
macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
is updated to ensure proper enumeration of INT3401 device.

Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Intel SoC DTS thermal driver")
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
index e0268fac7093..f9e275538e29 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -44,7 +44,8 @@ config INTEL_SOC_DTS_IOSF_CORE
 
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
-	depends on X86 && PCI && ACPI
+	depends on X86_64 && PCI && ACPI
+	select INT340X_THERMAL
 	select INTEL_SOC_DTS_IOSF_CORE
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
-- 
2.51.0.618.g983fd99d29-goog


