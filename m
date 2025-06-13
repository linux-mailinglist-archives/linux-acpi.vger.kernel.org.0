Return-Path: <linux-acpi+bounces-14366-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1919AD9617
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 22:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C16188AB09
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF82405E3;
	Fri, 13 Jun 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezk7zOS9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE320E717;
	Fri, 13 Jun 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845729; cv=none; b=dpDpcPyF4H5RBRwLwGkavuor0YoDAimT0A9o8LKrelzkgUN+/OQ0DHx663zfd2fcuOCd/tZCuQ8DorNx0A2AJ6AczjFN1UBAgK5NaNeZPOVB4964a0u0OU54yKigjk5O82wDD8NiFvDY5hldzdIh3EwjetpsfAYR5SP7mq2GTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845729; c=relaxed/simple;
	bh=7uLjyUvffaigqJ3AEqRaDo96HV0nyW1QomE1lz0AoMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b2v3vG2vJaUUuPyklx1AcCWrkIngqMia8mtN0RO10lY83dA2mbS/vSZK0byV4olV5SsZwMTigaCaL6U2stft0KmnV0Zmbp19PSENg2bcAEhaAhelSmjpPzphGSjYqEcoJlgk2tXdjbKkQVWTzM22TsGAkBmyuexL5pDHKYnax0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezk7zOS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C252C4CEE3;
	Fri, 13 Jun 2025 20:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845729;
	bh=7uLjyUvffaigqJ3AEqRaDo96HV0nyW1QomE1lz0AoMI=;
	h=From:Date:Subject:To:Cc:From;
	b=Ezk7zOS9xEEQtbzKYg3/aWutE4jpTFUJGppvkr1p96NxNtrcvijxvXeEYfBdSss7C
	 c+8P/Ctv+MdyHEYERbTiEDDF9dQufgw7Ihoujf3FW1rs8S77goQgpb0lITZbOc9VGZ
	 xqHvODfinAm1ds+UihQwys8gc4I5R74cejGMBawXGQxz2ukCUjgPRlNIhr/1M6lxtr
	 clLJAwICoIizND3F17XuP39AC+46wapb0EhjYaRHpVsKuMnzBfEInxv/2FuxZCQx6J
	 TWjCAwI8cyn5D/ONp5b7oLDVoir1eV/vzy3kB5wzUuZHGJOjmytz+5RbN5nqc1FEFu
	 QRVLN3LCqNjMQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60d6303a11eso1336852eaf.0;
        Fri, 13 Jun 2025 13:15:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlj5tPDrDEO6fQ94TvkDCoC7SsfEWeAglXEgHZVnKkdEKN8VZFS2+USVchieBTEePhotmT9UbtEbpC@vger.kernel.org, AJvYcCUrRuzXH06ZrGs9YHpcTQ3lBDvWb8yUfSfzYNuzVC+8Fw8sh52ttyJmlo81NyPodcEWIaGnXAcSmY3DYdKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxECB3OozWV38b+ShXvw1ZExPRyDWh5hOEOKZFmYD/q859Pe20t
	W0cdgg9E7nfSP5HguAkPrTSHbk3I7rzNzdg+sZNArb3bpKfURneWzPmaALYgeo9iIA2SzHb+SkK
	+FRNChdm6u18GtcVuIjQq/R2zWUfAeuA=
X-Google-Smtp-Source: AGHT+IEJdHo8wW2tLfkVDlyRj+JgNom6RzmP5SDPrTdXuVsU+IfMIry5EXqN3vRNUOI6gu2fwARjjV+wH7RT7KDvWbg=
X-Received: by 2002:a05:6820:1518:b0:60f:16d3:df3 with SMTP id
 006d021491bc7-61110ea4fddmr609724eaf.1.1749845728462; Fri, 13 Jun 2025
 13:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Jun 2025 22:15:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jYie5HkuPkRiWrvaG3szhVO2HyHbN5=D0KQsNjrwMzZQ@mail.gmail.com>
X-Gm-Features: AX0GCFsLRu5FELmZsuLPlNqZSm1NDBi2NLQfAP5-ER8p-s206IYJkPfv3KnjmQo
Message-ID: <CAJZ5v0jYie5HkuPkRiWrvaG3szhVO2HyHbN5=D0KQsNjrwMzZQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.16-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc2

with top-most commit dd3581853c5f190c3a7bd1de78f5ecb2905a77a7

 Merge branch 'pm-cpuidle'

on top of commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

 Linux 6.16-rc1

to receive power management updates for 6.16-rc2.

These fix the cpupower utility installation, fix up the recently added
Rust abstractions for cpufreq and OPP, restore the x86 update
eliminating mwait_play_dead_cpuid_hint() that has been reverted during
the 6.16 merge
window along with preventing the failure caused by it from happening, and
clean up mwait_idle_with_hints() usage in intel_idle:

 - Implement CpuId Rust abstraction and use it to fix doctest failure
   related to the recently introduced cpumask abstraction (Viresh Kumar).

 - Do minor cleanups in the `# Safety` sections for cpufreq abstractions
   added recently (Viresh Kumar).

 - Unbreak cpupower systemd service units installation on some systems
   by adding a unitdir variable for specifying the location to install
   them (Francesco Poli).

 - Eliminate mwait_play_dead_cpuid_hint() again after reverting its
   elimination during the 6.16 merge window due to a problem with
   handling "dead" SMT siblings, but this time prevent leaving them in
   C1 after initialization by taking them online and back offline when
   a proper cpuidle driver for the platform has been registered (Rafael
   Wysocki).

 - Update data types of variables passed as arguments to
   mwait_idle_with_hints() to match the function definition
   after recent changes (Uros Bizjak).

Thanks!


---------------

Francesco Poli (wintermute) (1):
      cpupower: split unitdir from libdir in Makefile

Rafael J. Wysocki (5):
      intel_idle: Use subsys_initcall_sync() for initialization
      x86/smp: PM/hibernate: Split arch_resume_nosmt()
      intel_idle: Rescan "dead" SMT siblings during initialization
      ACPI: processor: Rescan "dead" SMT siblings during initialization
      Reapply "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"

Uros Bizjak (1):
      intel_idle: Update arguments of mwait_idle_with_hints()

Viresh Kumar (4):
      cpufreq: Convert `/// SAFETY` lines to `# Safety` sections
      rust: cpu: Introduce CpuId abstraction
      rust: Use CpuId in place of raw CPU numbers
      rust: cpu: Add CpuId::current() to retrieve current CPU ID

---------------

 MAINTAINERS                     |   1 +
 arch/x86/kernel/smp.c           |  24 ++++++
 arch/x86/kernel/smpboot.c       |  54 ++-----------
 arch/x86/power/hibernate.c      |  19 ++---
 drivers/acpi/internal.h         |   6 ++
 drivers/acpi/processor_driver.c |   3 +
 drivers/acpi/processor_idle.c   |   8 ++
 drivers/cpufreq/rcpufreq_dt.rs  |   4 +-
 drivers/idle/intel_idle.c       |  12 +--
 include/linux/cpu.h             |   3 +
 rust/helpers/cpu.c              |   8 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/cpu.rs              | 125 ++++++++++++++++++++++++++++-
 rust/kernel/cpufreq.rs          | 173 +++++++++++++++++++++++++++++-----------
 rust/kernel/cpumask.rs          |  51 ++++++++----
 tools/power/cpupower/Makefile   |   9 ++-
 16 files changed, 368 insertions(+), 133 deletions(-)

