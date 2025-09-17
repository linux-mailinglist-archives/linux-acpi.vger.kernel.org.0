Return-Path: <linux-acpi+bounces-17065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB13B7CA77
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620C7580DD1
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4437429A;
	Wed, 17 Sep 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euMQjirx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6237428E
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110848; cv=none; b=q1L+ijN1Uf2AzihBneOYIPcVp6F/dfCzHXmkkqEi+zMiyOOOBsbGxMYaA5jhkV9Y9eUQMZakWZj3OiDO0IO06VSMKzV9yCLUkV8rePASRfbaUhJF/ek2Om00ppRnML8fcCj2q7YQ0AJC7cDANh/n4TIC+FRL4KV3JLGw/LSBjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110848; c=relaxed/simple;
	bh=9YsOK7xOkBmqSXAsGz41A8TfQISRyzo2HhwCFSvVyL8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Eo5wN1+hD3B643dG6hXl02JRmc0SO3UQH9UHNKj6Iorr3s5EqcyVVQzIwE4xe5ABkztUM9ErLzs9lCgvFkVmBdru+HYsGuKX3nRgp1CQrczfN2tpwus83PUI1WZc50HBj9p24qfWMwsiFnkgF8GITjH0iNWeYZW8y7eCg9WePns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euMQjirx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62f9cfb8075so104182a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110845; x=1758715645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oUSdiy6K/FdW7+NZhKD0MWSuKUWi3Six21x+wvEODfc=;
        b=euMQjirxt+darB1wsav+RBep6Q23AjZOnzloiQ9fttRr6DuuNoXnBrSViRYCMx/oG8
         /CLTKrkf6FFadgFoDy/mVoYtd0eR/xsSvQMTFRco1GD8t1CWJSB0pXA+LGY0XOtFTkJ6
         ACcTZ4mNBSWFR/SqlUqTvOJghdTcO2HD0PNext0cTz0/8wkyACSxeY4w6w6wN9OTDagu
         jn6zi/sU9W2ctPwSWITQ7iCAEn2VgOMw4wQywWoW8PV88OT/kVc2JlBArtLy3AI7LeAG
         imixOmCh4fkgPuVSdgkEwD+HntSQvS2xrZd9IV7VELZqffMz1MjkmJhUsnMmQRtZVTmw
         Cf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110845; x=1758715645;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUSdiy6K/FdW7+NZhKD0MWSuKUWi3Six21x+wvEODfc=;
        b=j/299UH6au+uooEXcsqBICGYWXwAmHLv8mOrYJGGdxj/TBqhNzZ0C58fjGD5qkJ7eG
         w2NlJXFOdXje0wOn9iIg6wZO/5l/MYSh3JlBABBUrPyb3G+X9104PpMaN5BxQ3jgZaFp
         0Jq0UOSVjd4w1Uh+svUO4JXURcmNrE2kDhKP4zQyRblYxb8WLBeY7YC8sSxJgsOGf0uh
         3QY8TARHaqYC6NbwrvF6/V3euDOczyhdaL40PBqP6ybePGD0GN0d/Vr2jYDoBwdS+Ig3
         NjAOM4zQ5k3D2SNxXJKofy2qUa6M/y5UntTPERbZbHyBKsq+qbJ1pytD3JNF32aNs8yn
         WY5A==
X-Forwarded-Encrypted: i=1; AJvYcCWW6u1wt0asBlU+3etgM+zvFg7xu1uFLP30A/hQF0SqKhSGfUqidiTSTPIj87y9FrSK6WrtXp4ZXqD5@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPdgJHGCahZEMvw/jFSrVpHbTdWo17C9gZbmhfbIBIDPHjKwg
	zlMvVfBYJKxXPtt8kEUoCF0hbsaHJnhNsSxeLW6IiASkd9yL8gDElMKof9fNmaw40ORL6hya1Y0
	JdPlhGA==
X-Google-Smtp-Source: AGHT+IF/Up2kM8AayYk2fWIelBsJluwkobfI62XMvAqfgyqmhTCwPUqTNtia/rvIr6vUEF42cBfglmWXKmI=
X-Received: from edj19.prod.google.com ([2002:a05:6402:3253:b0:61e:ed05:2161])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:21cb:b0:62f:9cfb:7d75
 with SMTP id 4fb4d7f45d1cf-62f9cfb7f95mr226755a12.2.1758110845149; Wed, 17
 Sep 2025 05:07:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:13 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-1-srosek@google.com>
Subject: [PATCH v2 0/6] ACPI: DPTF: Move INT340X enumeration from DPTF core to
 thermal drivers
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


Slawomir Rosek (6):
  ACPI: DPTF: Ignore SoC DTS thermal while scanning
  ACPI: DPTF: Move INT340X device IDs to header
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
 drivers/platform/x86/intel/hid.c              | 33 +-------
 drivers/platform/x86/intel/vbtn.c             | 30 +-------
 drivers/thermal/intel/Kconfig                 |  1 +
 .../intel/int340x_thermal/int3400_thermal.c   | 12 +--
 .../intel/int340x_thermal/int3401_thermal.c   |  5 +-
 .../intel/int340x_thermal/int3402_thermal.c   |  5 +-
 .../intel/int340x_thermal/int3403_thermal.c   | 12 +--
 .../intel/int340x_thermal/int3406_thermal.c   |  5 +-
 include/linux/platform_device.h               | 17 +++++
 16 files changed, 163 insertions(+), 178 deletions(-)
 create mode 100644 drivers/acpi/int340x_thermal.h

-- 
2.51.0.384.g4c02a37b29-goog


