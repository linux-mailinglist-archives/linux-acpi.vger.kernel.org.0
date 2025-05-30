Return-Path: <linux-acpi+bounces-14028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EABAC95C7
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F7EA26B1B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BD239E9A;
	Fri, 30 May 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMh3+OAq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1691D554;
	Fri, 30 May 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631011; cv=none; b=Dl6kMo0XbjcF2GR+L3iUCdqEHZQQMuxbG9hzAQpFou1zHcwcZ+U6JPhjykZoarcCIa6QIg00j2KRadkbF+NUVqG8sS3/SQEfXAUYaisK6MIxFne5Z5iehjP0JhFYWHl8vVEVfEB8ix6Rf7AA6zovdqBwjpHjqA6oVS2AhWnpvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631011; c=relaxed/simple;
	bh=WHZlm4pkgAEEcDghKLa2sRpP9wjXqL+XkDebT7GqAHo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gjasg3MSfuJMsJzzUTwDWeD3rMZ6U0MEU9objamNZdA94pcdmYNmtbyyDpYhis3Hu9pAp9jZR2WonTk++ZXdHO5rHQ5yZuO4lHglQk8CNWQoQLreLY2blBsK9SWiWV6wZCeCO/9YYRtLro4UYdBq4sJM0KbuEujA0KcisWo/568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMh3+OAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E984BC4CEE9;
	Fri, 30 May 2025 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748631009;
	bh=WHZlm4pkgAEEcDghKLa2sRpP9wjXqL+XkDebT7GqAHo=;
	h=From:Date:Subject:To:Cc:From;
	b=FMh3+OAq3YvT9qIW40lNDExUeilQsVhxCrx/j0MRaX3FQWjwxhrT0oCTiPNrtaQsE
	 hNypyXSR4SIXqCss4u8P2bn7Lb/ixAmUlx2xNUoT++k/S5U0GqyH8VFCv7ImE9zaqn
	 tz4tMFopJHPzkU5i2VINMQsQRnYe6hfxXSqKZrCLQvwAENZUR9EvaQaEQ/hnIZurKP
	 Ve4tGhuXro8shQAOsrshAex2QUbl9nZeodVwIcZRKnN+3KZpweGghiUMaV6R57ZNMU
	 iD4HNlVqoNkgK397tmmkgXke0h5HzAw53LzbG1SI218OxXAuJhFv0Mej4c0xPOGeON
	 6+gCDl6j5mUHA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-400fa6eafa9so1635706b6e.1;
        Fri, 30 May 2025 11:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXe1OPLJ9O4qXBMO/59SHeJz65Yvw539uv1GzNLgoV+ZU8W5FINLCgnSSgWgyRPryyYTjw/0pjSkuK@vger.kernel.org, AJvYcCXD3sq/dSVHivOaqgJe61TD3CK1X8adJ/QsSnZivGdUDnvpPY2QA8zFdzj3NUoXWG/E64I+CY8QRkiSAzpn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JA2v57r8CmXl4mkG7LLPl4uVViWA8ygRLwU6YkRrl8OiMBYS
	h4PjSOnPz6ZeW4dsqdcXiOyunTasVLTfiNQeL/UH14AfokD3CHgD0dyHojGKIJZGEI994KaelB/
	r24CmblG3dZuHeZOrtqKaFZsB7ctFPIU=
X-Google-Smtp-Source: AGHT+IFEl5wOxBWO0AWs6Xm08CvEXrt0l2bttoyZLHOeAJ/czgii7mBWyV9Cr9OMCqxM1amJ6WR66mWVE51qYVijPCA=
X-Received: by 2002:a05:6808:a95:b0:404:d126:2e44 with SMTP id
 5614622812f47-406797abb33mr2232778b6e.34.1748631009321; Fri, 30 May 2025
 11:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 May 2025 20:49:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5C_Zk5-PxsO+W-ef=1oDgbb-PCMYq8UmE9uPi9bASvg@mail.gmail.com>
X-Gm-Features: AX0GCFuNHXE3aioYfjUWsQzRGK-Xbjcr-jTManwuaAN14n51hJR3uq6sOuqzClk
Message-ID: <CAJZ5v0g5C_Zk5-PxsO+W-ef=1oDgbb-PCMYq8UmE9uPi9bASvg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc1-2

with top-most commit 3d031d0d8daab86f9c3e9e89c80fec08367fb304

 Merge branch 'pm-cpuidle'

on top of commit 9d230d500b0e5f7be863e2bf2386be5f80dd18aa

 Merge tag 'driver-core-6.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core

to receive more power management updates for 6.16-rc1.

These revert an x86 commit that introduced a nasty power regression
on some systems, fix PSCI cpuidle driver and ACPI cpufreq driver
regressions, add Rust abstractions for cpufreq, OPP, clk, and
cpumasks, add a Rust-based cpufreq-dt driver, and do a minor
SCMI cpufreq driver cleanup:

 - Revert an x86 commit that went into 6.15 and caused idle power,
   including power in suspend-to-idle, to rise rather dramatically
   on systems booting with "nosmt" in the kernel command line (Rafael
   Wysocki).

 - Prevent freeing an uninitialized pointer in the error path of
   dt_idle_state_present() in the PSCI cpuidle driver (Dan Carpenter).

 - Use KHz as the nominal_freq units in get_max_boost_ratio() in the
   ACPI cpufreq driver (iGautham Shenoy).

 - Add Rust abstractions for CPUFreq framework (Viresh Kumar).

 - Add Rust abstractions for OPP framework (Viresh Kumar).

 - Add basic Rust abstractions for Clk and Cpumask frameworks (Viresh
   Kumar).

 - Clean up the SCMI cpufreq driver somewhat (Mike Tipton).

Thanks!


---------------

Anisse Astier (1):
      rust: macros: enable use of hyphens in module names

Dan Carpenter (1):
      cpuidle: psci: Fix uninitialized variable in dt_idle_state_present()

Gautham R. Shenoy (1):
      acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()

Mike Tipton (1):
      cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs

Rafael J. Wysocki (1):
      Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"

Viresh Kumar (16):
      rust: cpumask: Add few more helpers
      rust: cpumask: Add initial abstractions
      MAINTAINERS: Add entry for Rust cpumask API
      rust: clk: Add helpers for Rust code
      rust: clk: Add initial abstractions
      rust: cpu: Add from_cpu()
      rust: opp: Add initial abstractions for OPP framework
      rust: opp: Add abstractions for the OPP table
      rust: opp: Add abstractions for the configuration options
      rust: cpufreq: Add initial abstractions for cpufreq framework
      rust: cpufreq: Extend abstractions for policy and driver ops
      rust: cpufreq: Extend abstractions for driver registration
      rust: opp: Extend OPP abstractions with cpufreq support
      cpufreq: Add Rust-based cpufreq-dt driver
      rust: opp: Make the doctest example depend on CONFIG_OF
      rust: opp: Move `cfg(CONFIG_OF)` attribute to the top of doc test

---------------

 MAINTAINERS                     |   11 +
 arch/x86/kernel/smpboot.c       |   54 +-
 drivers/cpufreq/Kconfig         |   12 +
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/acpi-cpufreq.c  |    2 +-
 drivers/cpufreq/rcpufreq_dt.rs  |  226 +++++++
 drivers/cpufreq/scmi-cpufreq.c  |   36 +-
 drivers/cpuidle/cpuidle-psci.c  |    9 +-
 rust/bindings/bindings_helper.h |    4 +
 rust/helpers/clk.c              |   66 ++
 rust/helpers/cpufreq.c          |   10 +
 rust/helpers/cpumask.c          |   25 +
 rust/helpers/helpers.c          |    2 +
 rust/kernel/clk.rs              |  334 ++++++++++
 rust/kernel/cpu.rs              |   30 +
 rust/kernel/cpufreq.rs          | 1321 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/cpumask.rs          |  330 ++++++++++
 rust/kernel/lib.rs              |    7 +
 rust/kernel/opp.rs              | 1146 +++++++++++++++++++++++++++++++++
 rust/macros/module.rs           |   20 +-
 20 files changed, 3624 insertions(+), 22 deletions(-)

