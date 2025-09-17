Return-Path: <linux-acpi+bounces-17066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4CFB7CAC4
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAC3284BF
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AFC37C0E6;
	Wed, 17 Sep 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6qE10gz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40F37429A
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110857; cv=none; b=Qdkb1aS8OHMwSazuipW7ePiQSkm70uPXENRi51Xx55jwlTSByMrp7+Aj9RUxwE2LeMfMo67WwlHm+LFZEeUDlHkYKMvAyfiTN9gHVcTSMvxJV4aG3ilnZ0pRRHLV8esv0V7ec4AeiCsCKbuHphEad6St7jf5td8L3RGzt5haQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110857; c=relaxed/simple;
	bh=CfXS5/PPeqiRHOfIV/RY4aKkXODckn9t5qURcuM16r0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jyx0yplnTXc+4m2E7y+rRC4b+0axIQAELfYmQDHtxeed+2xMLdpwvg6O7x6TosJ4Vd1UsMdDjenF5OBz28ocBlh3oeLo1wgNrGZ1Zh+vbJp8dmUMEYJrAIYv/1cW/3CrzFOtuvcKuFCAh3jsujo/HN7NySKLhz4zANOG7/SwpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6qE10gz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so16548895e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110853; x=1758715653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXPpYw5PptfhxuGeyMlPO4iaL9Igmx+1S+SUZwA7GbM=;
        b=W6qE10gzXtVTlHE7Kgr0vxxauDXDlrd5kZ+zAg8KgvTVzLo15ZY/O1YuSdXeSNckGd
         epX67hBza6sHzvUOl8yMKucNdfxMcLOYnZ5GDbQH1zQxzjAgZHG7iZKjlkIg1Y71fkHO
         WmFGGxu+BhrOvlCx3UGAxinlbg5vnY4Vu49kJbR6KIIzeczBlPrM2hYSaUjkA/8dBlWm
         lcP1xiD9a5wK8466Pcyh8fHb7IS8UsUe8MQta8cKvZa2aRgfLA7YJKEFUg3cFgSF6Lr4
         WKNv4UXtjyIsx0e2CWb/BMruxdfl8eViWsnoIHgWNaeWDtbRz/bY/Q36kZAUgjkGaVv3
         Oskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110853; x=1758715653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXPpYw5PptfhxuGeyMlPO4iaL9Igmx+1S+SUZwA7GbM=;
        b=v5hwTiAlCOmzhXIpDld7LSkp5iNzsr+s5QwpgfI6cmdPdhmhxj0IxKuBkHDcx0VPk3
         6P42k6xjhYCO4gqeFEwASfQoK6/w0tQeErvzvzThtrDeFxiFEcPken3bv3vqlC4U2tVp
         M+ulh5FBYcu5VzBEbK+De8UH6LXQu8uhsXy+tC+KZg0coN5EC9BZxoS7bp/Lk6L+mT9g
         63zvun6dv3Eo6TW0MDthZAyKioVAr84AMp4bc7IewDRQQTkGbhDTkqe8eQOpIZ3BXTZ2
         eROSk7iO1BFzp/ZRsk1EmrePhTtdT19JbYEhgvRTpg4oVOYTRj5WDKhpZ6KwqZs6b40z
         0naQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKPRBqxA+Fz+oWEWYWIv8YROBKlBXpdIsEnr4bWhs7aZJvwHpksCwIEYXVQs9CjV3WHwPsbwfdSnac@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1C1g7tGBZzGb/ChvtUnXYC00uvhBtxcyOg/HM9lwgsYnCnePa
	7lyYZvYQlg7y6zDaJIgy2sYcFiCnalRK6h4mdI3kx9pWoxd1amL10RLel3gsVFaQZ8thubRfTwp
	0MoZn3A==
X-Google-Smtp-Source: AGHT+IG5EYuiZGTb0cN7pl1n8KbdAeBSylPX3GcroguKVU2xV9KwaI/F70l4wkEMjhLkEIA7QuUMhQPK0SM=
X-Received: from wmsr5.prod.google.com ([2002:a05:600c:8b05:b0:459:7c15:15b9])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b09:b0:45f:27a3:6e0e
 with SMTP id 5b1f17b1804b1-46202de0b19mr20212145e9.14.1758110853279; Wed, 17
 Sep 2025 05:07:33 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:14 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-2-srosek@google.com>
Subject: [PATCH v2 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
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
 drivers/thermal/intel/Kconfig       | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

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
index e0268fac7093..47950859b790 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -45,6 +45,7 @@ config INTEL_SOC_DTS_IOSF_CORE
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
 	depends on X86 && PCI && ACPI
+	select INT340X_THERMAL
 	select INTEL_SOC_DTS_IOSF_CORE
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
-- 
2.51.0.384.g4c02a37b29-goog


