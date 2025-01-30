Return-Path: <linux-acpi+bounces-10867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6DA2364B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E03167205
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3441F0E31;
	Thu, 30 Jan 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CktmXLCg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45C1AC884;
	Thu, 30 Jan 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271125; cv=none; b=IXwzJEseTIAmxM2R+jcp9HLBxPeLbt7WAwIi2CZTNoq00Klzr8MreWm6KA1Xj+SE64VehyrFPcFjr5wVkzKxdIUFwO50QYq5XUzZoZE5oOKmWXI03B5CdR74MIiblncKfPjRg1gLb04Qj2ERmPeU2Vj1vGXiXQFABbTKSw33DMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271125; c=relaxed/simple;
	bh=B5q0cekV/A57rJ13BmoTgj0fb8mihExQTI5chuZIFn0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ScdmSJXhKsPD5eo91AXdPuiUcmvEihgYnyoHAZfGdy2q7yo8ZOFfAMZ9EgeU8Iliq3pGg4nelrF0aQejkWWY3vRXwuw/XuKQ9WaQcdPGLcXZ0RtSAet+3N+IC0zRKnhqMIuli5tLP24rfuSnMU3gGstvqhhH4jkpH9KS8dWg//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CktmXLCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B180C4CEE1;
	Thu, 30 Jan 2025 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738271125;
	bh=B5q0cekV/A57rJ13BmoTgj0fb8mihExQTI5chuZIFn0=;
	h=From:Date:Subject:To:Cc:From;
	b=CktmXLCgPDYSrNjjRqcT+4/t/t/B6EY+SkJIAgNrq7jUDU2S/joTK+lxfxuiXoocc
	 bt2mJfaS7vCW2RZPW4JGNmb98TQbDVqQep9x1RYtNHgZ04EpTmDsH54q24ANt0Rdt0
	 OCwmJlQpRZeh6rY3yQHNPEs0HTH3BQVsQnU/GFBQzrXtLuDQs4Ww3DiJNRM44tmUaa
	 LHE913AeSKUSXUgFghClHeTv7Kg9l2p1DJzEVolptWyVObkie7K6hFxyHnHkHEYQoH
	 avbT/ego8LxjG44dc9vhl0X2xXo3EMKBZ89ZtRQYJPzthDw6VA37+gw8Z5NiE0ygau
	 TRkv+Et7EP0BQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e565708beso726104a34.1;
        Thu, 30 Jan 2025 13:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6EcXT2hHKZckal5ouHvcIEb0otAyx75Y2rSvKKBZL0qXTLYcxXs9N6Zn5F2Oi/no2XJpIhSrTebOcEQh9@vger.kernel.org, AJvYcCXjdCj+lGfUELfF5sGlp/jT9yGRMqO1cRVXsWOO/q14EHxtBuYFOpfdZ4r6LWlaew9UVFu3BsDOd97B@vger.kernel.org
X-Gm-Message-State: AOJu0YzETgfWSiQPKwp6E85n5K28FMq1JzxQcKPjlkiC1VHGsCSyu97I
	pfqBT9azjtZFf3JsBN71h0vlTIcOibmleZN3hAS5FCkokJncLw9dhfuVOfxt8Z/xzChw4A5lMN2
	xp2Fxb1h9fhxlIxvAlI6a0noEMkM=
X-Google-Smtp-Source: AGHT+IH8PhMNyAd6wBLUU4cnsXflb2rjsqiEj1XdYwkojCqYJzRO0GTQLNByPpt6UPHcmVVGSVM2DgjUv9EPBT8Fd/0=
X-Received: by 2002:a05:6830:6381:b0:71d:5f22:afec with SMTP id
 46e09a7af769-7265678da24mr6191718a34.12.1738271124372; Thu, 30 Jan 2025
 13:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Jan 2025 22:05:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ip_MwjtS+2MfUqkdC+y6nSevQf8-bUosMkLt1yYJEpqA@mail.gmail.com>
X-Gm-Features: AWEUYZn_eAHsjLNxc2BZTdvBXwdn51GRCUMt92WQdyHOg3APtmunIzI198VNsSg
Message-ID: <CAJZ5v0ip_MwjtS+2MfUqkdC+y6nSevQf8-bUosMkLt1yYJEpqA@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.14-rc1-2

with top-most commit a01e0f47a7a10668c178f058bcf136f8ec897286

 Merge branch 'pm-sleep'

on top of commit f4b9d3bf44d59ca4489bd8c489539c27c02e5c6a

 Merge tag 'pm-6.14-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.14-rc1.

These are mostly fixes on top of the previously merged power management
material with the addition of some teo cpuidle governor updates, some
of which may also be regarded as fixes:

 - Add missing error handling for syscore_suspend() to the hibernation
   core code (Wentao Liang).

 - Revert a commit that added unused macros (Andy Shevchenko).

 - Synchronize the runtime PM status of devices that were runtime-
   suspended before a system-wide suspend and need to be resumed during
   the subsequent system-wide resume transition (Rafael Wysocki).

 - Clean up the teo cpuidle governor and make the handling of short idle
   intervals in it consistent regardless of the properties of idle
   states supplied by the cpuidle driver (Rafael Wysocki).

 - Fix some boost-related issues in cpufreq (Lifeng Zheng).

 - Fix build issues in the s3c64xx and airoha cpufreq drivers (Viresh
   Kumar).

 - Remove unconditional binding of schedutil governor kthreads to the
   affected CPUs if the cpufreq driver indicates that updates can happen
   from any CPU (Christian Loehle).

Thanks!


---------------

Andy Shevchenko (1):
      PM: Revert "Add EXPORT macros for exporting PM functions"

Christian Loehle (1):
      cpufreq/schedutil: Only bind threads if needed

Lifeng Zheng (4):
      cpufreq: Fix re-boost issue after hotplugging a CPU
      cpufreq: Introduce a more generic way to set default per-policy boost flag
      cpufreq: CPPC: Fix wrong max_freq in policy initialization
      cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()

Rafael J. Wysocki (11):
      cpuidle: teo: Rearrange idle state lookup code
      cpuidle: teo: Reorder candidate state index checks
      cpuidle: teo: Combine candidate state index checks against 0
      cpuidle: teo: Drop local variable prev_intercept_idx
      cpuidle: teo: Clarify two code comments
      cpuidle: teo: Simplify counting events used for tick management
      cpuidle: teo: Skip getting the sleep length if wakeups are very frequent
      cpuidle: teo: Simplify handling of total events count
      cpuidle: teo: Replace time_span_ns with a flag
      cpuidle: teo: Skip sleep length computation for low latency constraints
      PM: sleep: core: Synchronize runtime PM status of parents and children

Viresh Kumar (2):
      cpufreq: s3c64xx: Fix compilation warning
      cpufreq: airoha: Depends on OF

Wentao Liang (1):
      PM: hibernate: Add error handling for syscore_suspend()

---------------

 drivers/base/power/main.c         |  29 ++++--
 drivers/cpufreq/Kconfig.arm       |   2 +-
 drivers/cpufreq/acpi-cpufreq.c    |   5 -
 drivers/cpufreq/cppc_cpufreq.c    |   5 +-
 drivers/cpufreq/cpufreq.c         |  20 +++-
 drivers/cpufreq/s3c64xx-cpufreq.c |  11 ++-
 drivers/cpuidle/governors/teo.c   | 197 +++++++++++++++++++-------------------
 include/linux/pm.h                |   5 +-
 kernel/power/hibernate.c          |   7 +-
 kernel/sched/cpufreq_schedutil.c  |   6 +-
 kernel/sched/syscalls.c           |   7 ++
 11 files changed, 162 insertions(+), 132 deletions(-)

