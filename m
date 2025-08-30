Return-Path: <linux-acpi+bounces-16203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F1DB3C823
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE1C58354F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B420C004;
	Sat, 30 Aug 2025 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwv93U+K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984646447
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532065; cv=none; b=skrJuFhHRWfRua9i1h3E0SZ09ZoALQnOnTFCps/5FV9h1rd5EvAZBlRpu+/UQB5/Jy+FyCBS10ahmWa+/hm9W88mUZwM0l8aqCzvfczLwYPlAbYN+6GCudCxHa972xu1eI7GcP7gqT3ol0NPU2JG8ZtNCsdk0gxI9Xvsx8tDpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532065; c=relaxed/simple;
	bh=iGIdCJ04hc/rwVRFCfvh1JYYJkWYteHOW2SUCYh222w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m5s+quLer7ee887Z6gFdMWozsCOBn1kFevkp15T+Ipu9NkDhWTST1HvCgGD7hd0E1Y8TYR5B1l1HJxaqyEdPqSJ1eVhiU/JXvMuy1UzhGza6hy/Zh8fxHaOb4uB+le/BMV6T0ABh4j6YS+Uk1EPYwVu16OO5o24P5oxvXBtoC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwv93U+K; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61c69c2872cso2483872a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532062; x=1757136862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1fz0Wj5viu7XO3A8F0LCzyRbaDXNCECb8AHr1HvtkF8=;
        b=xwv93U+K84n1LuR6+glzFZQjnWkjr4rTVaAJd/Gl25kC75d0xJdfzxHF0XJtf1j0ri
         7xpnauUCjIRrr21SzZjqHnD2i5ctcyOCQxStIc5BrBR7ZCXlVaefk3u4bZkuphYI9pMe
         caIy5P5ufx38JD7LWe92TlBiEOhTBi1QB46Jcx0MuEPYXc+FA0umAj6P0ESncwFnYtTX
         krvtz0bQMoCCf4w83igLqWcXwASIFbhwcpvU0N+ZgNwDFrSZR72tfxPTTNyaiPLq5XPA
         2kGBWu3ROIALqsanECdwct92U9X3xqdP39vHKoKJxjn2ZqfYDaP2tfl8prMVhQsfxjsf
         OS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532062; x=1757136862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fz0Wj5viu7XO3A8F0LCzyRbaDXNCECb8AHr1HvtkF8=;
        b=p4yGZL9U9AHHNN9JWGOd8IvJ5RITO2OpyUpHWnt31eZneo4iY8yfulsBHCny55r5g+
         2c8geSjDKC+m7hMuzBa/pzVG9RCWCvBbZ7UgfCfNETm2n/OGR8ENCcTHgHtsZo4fThmI
         4N9AUuSEDktXH2AceiNvjIgTFPS9EhI2VOrZLYfR58MpcrTH4VwyEjuVWQaIhtGdYLxo
         5TgQxdLP0mttHshURBVEFLYe8K1HXu05eFlulpbaCpJFVTAZTqB6dGlYROw/JTAbEYMM
         st2BJnhBetK3o81pClq22KOeDr2NWTSJjvJpQST8N2jNHcjhGMYYHwv9VU2Uhs2HcjPu
         h/OA==
X-Forwarded-Encrypted: i=1; AJvYcCWYYWrKEv9oyBX6vG/tcNAYmfLzG/NAPhFB6UhmzXcIyIPTfivJSg3szb1Z033/GNDM3YkWJ7ni2Nun@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRSY96YaVmdcNSZwuLWWMN6gYpF+6n/LYde42ALUli4DUMzZN
	KSoYDGbhNP4KhHNCKugIOxSaPO4jOqipTkX0/Y+GDg2B+QfdjH4spL/4RPGNDOZs8tjOr1inkCY
	X+ZWToQ==
X-Google-Smtp-Source: AGHT+IH7/2iuI7gomqx/Ms4EDMM9L3zD9vGRqiS5T/muUAhfgeOtaNhn89G1Rd7KQjm4wDksXrUzfhrB69o=
X-Received: from edf21.prod.google.com ([2002:a05:6402:21d5:b0:61c:986a:6ca6])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:23d4:b0:618:528b:7f9b
 with SMTP id 4fb4d7f45d1cf-61d26ebc064mr744264a12.31.1756532061658; Fri, 29
 Aug 2025 22:34:21 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:52 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-1-srosek@google.com>
Subject: [PATCH v1 00/12] ACPI: DPTF: Move INT340X enumeration from DPTF core
 to thermal drivers
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

The Intel Dynamic Platform and Thermal Framework (DPTF) relies on
the INT340X ACPI device objects. The temperature information and
cooling ability are exposed to the userspace via those objects.

Since kernel v3.17 the ACPI bus scan handler is introduced to prevent
enumeration of INT340X ACPI device objects on the platform bus unless
related thermal drivers are enabled. However, using the IS_ENABLED()
macro in the ACPI scan handler forces the kernel to be recompiled
when thermal drivers are enabled or disabled, which is a significant
limitation of its modularity. The IS_ENABLED() macro is particularly
problematic for the Android Generic Kernel Image (GKI) project which
uses unified core kernel while SoC/board support is moved to loadable
vendor modules.

This patch set moves enumeration of INT340X ACPI device objects on
the platform bus from DPTF core to thermal drivers. It starts with
some code cleanup and reorganization to eventually remove IS_ENABLED()
macro from the ACPI bus scan handler. Brief list of changes is listed
below:

1) Remove SOC DTS thermal driver case from the ACPI scan handler
   since its dependency on INT340X driver is unrelated to DPTF
2) Move all INT340X ACPI device ids to the common header and update
   the DPTF core and thermal drivers accordingly
3) Move dynamic enumeration of ACPI device objects on the platform bus
   from the intel-hid and intel-vbtn drivers to the ACPI platform core
4) Move enumeration of INT340X ACPI device objects on the platform bus
   from DPTF core to thermal drivers using ACPI platform core methods


Slawomir Rosek (12):
  ACPI: DPTF: Ignore SoC DTS thermal while scanning
  ACPI: DPTF: Move INT3400 device IDs to header
  ACPI: DPTF: Move INT3401 device IDs to header
  ACPI: DPTF: Move INT3402 device IDs to header
  ACPI: DPTF: Move INT3403 device IDs to header
  ACPI: DPTF: Move INT3404 device IDs to header
  ACPI: DPTF: Move INT3406 device IDs to header
  ACPI: DPTF: Move INT3407 device IDs to header
  ACPI: DPTF: Move PCH FIVR device IDs to header
  ACPI: DPTF: Remove not supported INT340X IDs
  ACPI: platform: Add macro for acpi platform driver
  ACPI: DPTF: Move INT340X enumeration to modules

 drivers/acpi/acpi_platform.c                  | 27 +++++++
 drivers/acpi/dptf/dptf_pch_fivr.c             | 10 +--
 drivers/acpi/dptf/dptf_power.c                | 20 +----
 drivers/acpi/dptf/int340x_thermal.c           | 76 ++++---------------
 drivers/acpi/fan.h                            | 10 +--
 drivers/acpi/fan_core.c                       |  2 +-
 drivers/acpi/int340x_thermal.h                | 76 +++++++++++++++++++
 drivers/platform/x86/intel/hid.c              | 41 +---------
 drivers/platform/x86/intel/vbtn.c             | 30 +-------
 drivers/thermal/intel/Kconfig                 |  1 +
 .../intel/int340x_thermal/int3400_thermal.c   | 12 +--
 .../intel/int340x_thermal/int3401_thermal.c   |  5 +-
 .../intel/int340x_thermal/int3402_thermal.c   |  5 +-
 .../intel/int340x_thermal/int3403_thermal.c   | 12 +--
 .../intel/int340x_thermal/int3406_thermal.c   |  5 +-
 include/linux/platform_device.h               | 17 +++++
 16 files changed, 161 insertions(+), 188 deletions(-)
 create mode 100644 drivers/acpi/int340x_thermal.h

-- 
2.51.0.318.gd7df087d1a-goog


