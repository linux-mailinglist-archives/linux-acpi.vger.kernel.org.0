Return-Path: <linux-acpi+bounces-10767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6998A173EE
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 22:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B913188AC43
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AEA19597F;
	Mon, 20 Jan 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtDPDQ2D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F09195FE8;
	Mon, 20 Jan 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407253; cv=none; b=qFYIPbRR5X42n2VgpVCvKT8or7roRNa9W9WnJZv/Tt/XWxbr3L3EeaDvC1HWM5p+iTOc0nlfyaDufU91L1PsOjEGuifmnLKQ1hXUJ+YdGwuVT+nnQg7s0IYfsA0GsV/IVjBWPp8TZQ4vMezccDey4KfOIHOKR8YjWQddlGGtWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407253; c=relaxed/simple;
	bh=tVMmI5ADh/mjExxx6RkciKW8c08gfs+hI2aVssBaQLs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Np6yRNMrSvMqjQ8w0h+rKKy05De2NdQm0ZxfBwzVWSB+hujc30gu7u4xVr4izo18UZiwFdNCScNaWKaJsblnANjlgMFHwyF9tYqJUszYrv7SFv0SF0RuKnf7haW+KDTFpYGYLVM+cmFAHPmGcSbR9MpZEWvr0PUB4r5D+wTB3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtDPDQ2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D891C4CEE4;
	Mon, 20 Jan 2025 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737407253;
	bh=tVMmI5ADh/mjExxx6RkciKW8c08gfs+hI2aVssBaQLs=;
	h=From:Date:Subject:To:Cc:From;
	b=YtDPDQ2DABHv8x7Vie6FuqfeiimvYT9ZVOHrRiGS43NMOxt7pkcjVndPmxlECtADZ
	 5xqpUIUkZwtTYN/6aFj7BdRTbbh96psHu6PSQySdfgZp42JlwSCmcxOU3WGV/jAec3
	 YTX1PpdwPDNLqOaenXFoU5+y6nRUQIrnpJVu6CRh6RywR0ptDO19Azfpba3Gi30ePb
	 yy48S2mCG1USzD3AG6ELDYyA8JFErXOkUhl16jOVV3m1Hq6bHvpa9qlZQ6hNiEqRWn
	 FJot5edk2q+vCq5YluEfec4pEyD0L7z9P/vAHq4muUvP2QgS2Z43jk3oa5HkHsmGa4
	 Sv/t5A5ZbQ0fw==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eba50d6da7so1134722b6e.2;
        Mon, 20 Jan 2025 13:07:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGATXrr9RVcrdZRmilW13w8EGaJeyfs/ezJGk3jNg/kChd4Vbsiyol1SBuAQoj6wPskyLxle//fCEG@vger.kernel.org, AJvYcCWmPsZY575OHfhtcLkHMtWvmLB90xRKxPsP0JaT43Vj4GQeb8ZKahKPHm0ag4paWVGb7YSX1XtKr8iCAkxl@vger.kernel.org
X-Gm-Message-State: AOJu0YwRq2En+u4DFvWgHgWMHFTwShTp0sr9axn6VqWeyLhcqqn7tevH
	i0QKw3ggrz78LqNMRfrVSOZdKlpRHzcHmYoad8IlBaGmpFH1REqyvW4KK1I7rlo9vPun51MJn9E
	iFWgpB4YCNwXoC6r7OimLRLXAEuo=
X-Google-Smtp-Source: AGHT+IEPdnQrpFjfne2ZWgsrclawbDz3bkY/MxoHnL6HBYkc0ElO8wpR6LK42gKaVzyT4hAL0eGKZVpe4tbMLW60weU=
X-Received: by 2002:a05:6808:399b:b0:3ea:5be6:a697 with SMTP id
 5614622812f47-3f19fc54cc6mr9957030b6e.13.1737407252302; Mon, 20 Jan 2025
 13:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 22:07:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gF8OwN3W5uLXf_DVtcKgPc0cTy4XWfyE1mcG2iSkRe=Q@mail.gmail.com>
X-Gm-Features: AbW1kvbgUhTrU6yL2ONitM06shn8xRkfLy9fM_mHTMh-eRA7sabYQ8dhRhB1dVo
Message-ID: <CAJZ5v0gF8OwN3W5uLXf_DVtcKgPc0cTy4XWfyE1mcG2iSkRe=Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.14-rc1

with top-most commit 2dc748695568a02199e813d408a8f6f58919f4bd

 Merge branch 'thermal-intel'

on top of commit 5bc55a333a2f7316b58edc7573e8e893f7acb532

 Linux 6.13-rc7

to receive thermal control updates for 6.14-rc1.

These add support for Intel Panther Lake processors in multiple places,
modify Intel thermal drivers to stop selecting the user space thermal
governor which is not necessary for them to work any more and clean
up the thermal core somewhat:

 - Add support for Panther Lake processors in multiple places (Zhang
   Rui, Srinivas Pandruvada).

 - Remove explicit user_space governor selection from Intel thermal
   drivers (Srinivas Pandruvada).

 - Rename a few things and relocate a comment in the thermal
   subsystem (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (3):
      thermal: core: Rename callback functions in two governors
      thermal: gov_bang_bang: Relocate regulation logic description
      thermal: core: Rename function argument related to trip crossing

Srinivas Pandruvada (4):
      thermal: intel: Remove explicit user_space governor selection
      thermal: intel: int340x: Panther Lake DLVR support
      thermal: intel: int340x: Panther Lake power floor and workload
hint support
      thermal: intel: Fix compile issue when CONFIG_NET is not defined

Zhang Rui (3):
      powercap: intel_rapl: Add support for Panther Lake platform
      thermal: intel: int340x: processor: Enable MMIO RAPL for Panther Lake
      ACPI: DPTF: Support Panther Lake

---------------

 drivers/acpi/dptf/dptf_pch_fivr.c                  |  1 +
 drivers/acpi/dptf/dptf_power.c                     |  2 +
 drivers/acpi/dptf/int340x_thermal.c                |  6 +++
 drivers/acpi/fan.h                                 |  1 +
 drivers/powercap/intel_rapl_common.c               |  1 +
 drivers/thermal/gov_bang_bang.c                    | 57 +++++++++++-----------
 drivers/thermal/gov_user_space.c                   | 12 ++---
 drivers/thermal/intel/Kconfig                      |  4 +-
 drivers/thermal/intel/int340x_thermal/Kconfig      |  4 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  2 +-
 .../intel/int340x_thermal/int3403_thermal.c        |  1 +
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  1 -
 .../int340x_thermal/processor_thermal_device.h     |  1 +
 .../int340x_thermal/processor_thermal_device_pci.c |  4 +-
 drivers/thermal/thermal_core.c                     | 10 ++--
 drivers/thermal/thermal_core.h                     |  2 +-
 16 files changed, 61 insertions(+), 48 deletions(-)

