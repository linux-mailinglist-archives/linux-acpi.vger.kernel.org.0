Return-Path: <linux-acpi+bounces-18344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B26C1C333
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3B3A5A16B7
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056933F8AD;
	Wed, 29 Oct 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAX1bq4d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8B37A3CC
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755627; cv=none; b=p7tfPoDw2Uopk8vbbNgDKwNQZNZfUq1+79cIMjwLDVFilHd/tHvKxij1apmXGXUx7kOv2IznMfA0TKJXOdy0C3W1Ai75pRB8PikuPBnB8E0muyqNp0i1MYnruaMmIlh51frZINjLkB0lEEUAmRv1FSY1cHlAPo4veSFQ+P0ozHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755627; c=relaxed/simple;
	bh=VSWqE9UpOBc+UzSqvFu6yaqBRnD97EehWNgVqMvq8m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kP0LUIeAsYMJeBF0a2I/cNEiyOL25NsCb8yKHphfj+kOD9D5kswlG2YpKs3Ds2zdxU/LGoymhJCy5i2lBH6JF6DbMZ3sHBCSYvI3U28xWu3SRzQb2RhqjU3bVrXSd6uEWkUzRzp6MKLFuXNL5VeOsSm2P2d2vnHe1zqr+1dMoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAX1bq4d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso841469f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 09:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755623; x=1762360423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAflKtaWcrVF6Nhfrfoz1N7w/0F8UwSgA56H4g4glHQ=;
        b=GAX1bq4dj6jJVRSQm6jSXKZmSqRgwU87dqTgUmOQq6VRG73NQv9ndmUqp5OYx15oEx
         3g1f4C8WxQQjrFA1gXw/darKeaRzgTHzF7xbEaU1koYOsa8PvidyiA5+RbtpoTvN44fY
         Y0bfMqK6gk707vhmLJvmEZzz6E42ZVyRgXg1vt2VNsg6V2toOefxP0mMIYJpCdxETDqm
         /Rb1UfXA3jTNlI7E718XG+k13ZnqmUQzAjxKoM1t1ros/IpMuvNJzEze7zQGEfGiocNy
         1RobH/KL8Aq1QIMpEnZKKJEqbTO8ebew6uuWf1aMOFG07jHjm+2t8itoqO3l2icckgev
         ez1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755623; x=1762360423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAflKtaWcrVF6Nhfrfoz1N7w/0F8UwSgA56H4g4glHQ=;
        b=YkZ1SsVztpu4WO4NIzzBJqIiz0A4pOi+4+I4G8Gx6pI0W+VeGbWtbCP9xN3alFwjVX
         R3HtslI0CNOep5D1CC6UsojopKcS8EbqNpZEpDw2Qu/21rjYRfRxYBSqzca3Xl/YSOEX
         OwM5G+6fySAsrQNVeGpOAqogCRnyZiluXasCQ1QAS/4l44lNRbptrzCzKeiGw01kwmIZ
         sEri2MnYyE8KjAnVv5fV3fZVxAghsEoblvPHlxRiCdpIxzCwwB58EsmkU0OVguhp94Ie
         xsjtd3OUo1JO9HtXV6gHRhjhQE8wtQ4h8Kb/EH0ZKj31Jmg52qBbg2v+9ZBQXE/I+mqJ
         IsUw==
X-Forwarded-Encrypted: i=1; AJvYcCVP1mNP4OCgWSGvkywb9GJQ8O2YcivRfPVbrmQLr+7IoSSHxdqLNni4kZjJwe8E+LPypzubhr+l4gRo@vger.kernel.org
X-Gm-Message-State: AOJu0YwBN8hT3up861GuHOErcQSnEYl8PuB2SBU73Gu5SSP/JPI7ZuTn
	/eCYhszuKhgq7bnmSrgMTFLcSta/cOLiBbepygB6kC1PUTtbHAng/TgWeMuGeg==
X-Gm-Gg: ASbGncuBGV8+WTzEqLx65lXaKylRAEGDdO0iBEhDz/5Ra4EOrS9V5zB79PU61ORkgAs
	Fo53EnYAvukvotUX7ByVxZ7Loum0c0YMrQfcak6+5whbwsUwKsUigVGtGKHgitaiWfeAtowbyZb
	UJq40j58gx5B9Rld0iql8tDQUifvu9qR4jZfnDCLkxKTtJxqGXVGhhYw0xOxq/GRwqwd0fGc3wD
	n80/WbNBkh6qfzanzKTvSDiGs7HK9oqcpquTCAUwA58I6RpvJiuOm5WyunB3q204GXh+OW6n9Bj
	gDF6kYW9oaE1qwD/bbfYMcrB7ZQXFsmuyBgLN730rS0t6fS18slaYhd84eHsxWoxLGWCi00+dH1
	UkNL/2B6JfMtjN4Gt87gwGxNwkrdnkuTtSXgUdAyqeUPyh4jxJBooOvxaNGxaJAe3qrlqHJytRJ
	gFZcU2Q8Q1E9D8NlgoftzWEbcVMRGSnIFgIKZky9dKg5m5w7r8I3N5Nyj6hF8LvEp3htBJ
X-Google-Smtp-Source: AGHT+IHTmDPmMpNCDFFQsAevLNP6qOs7nF+wicDIMZb/6KQd4rRWs7Qottj+hraNqh61j+yol+JE4g==
X-Received: by 2002:a05:6000:430c:b0:425:86da:325f with SMTP id ffacd0b85a97d-429b4c5303emr258811f8f.27.1761755622916;
        Wed, 29 Oct 2025 09:33:42 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952da12dsm27463002f8f.29.2025.10.29.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:41 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] syscore: Pass context data to callbacks
Date: Wed, 29 Oct 2025 17:33:29 +0100
Message-ID: <20251029163336.2785270-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Hi Greg, Rafael,

sorry, this took a while to rework because I had to find a large enough
block of free time to push through. I played around a bit with different
ideas based on our discussion and ended up with a mix between Rafael's
and my proposal. struct syscore_ops is now split out and can be made
const. struct syscore is introduced to contain the variable data such
as the list head and the driver data. It also has a pointer to the ops
structure. Registration APIs are changed accordingly. I initially wanted
to avoid this churn, but then realized I was already touching all of the
files anyway, so might as well make it all consistent. As a result the
series is about twice as large in terms of LOC, but that's mostly due to
the structure split.

For anyone who hasn't seen this yet, here's the full cover letter:

Hi,

Something that's been bugging me over the years is how some drivers have
had to adopt file-scoped variables to pass data into something like the
syscore operations. This is often harmless, but usually leads to drivers
not being able to deal with multiple instances, or additional frameworks
or data structures needing to be created to handle multiple instances.

This series proposes to "objectify" struct syscore_ops by passing driver
specific data to the syscore callbacks. The contextual data is stored in
a new struct syscore before registering the structure with the framework
and the structure can be embedded in driver-specific data to make it per
instance.

Patch 1 contains the bulk of these changes. It's fairly intrusive
because it does the conversion of the function signature all in one
patch. An alternative would've been to introduce new callbacks such that
these changes could be staged in. However, the amount of changes here
are not quite numerous enough to justify that, in my opinion, and
syscore isn't very frequently used, so the risk of another user getting
added while this is merged is rather small. All in all I think merging
this in one go is the simplest way.

Patches 2-7 are conversions of some existing drivers to take advantage
of this new parameter and tie the code to per-instance data.

Given that the recipient list for this is huge, I'm limiting this to
Greg (because it's at the core a... core change) and a set of larger
lists for architectures and subsystems that are impacted.

Changes in v3:
- add separate syscore structure containing the modifiable fields,
  including driver-specific data, as well as a pointer to the constified
  syscore_ops structure
- change registration/unregistration API to make these changes more
  obvious

Changes in v2:
- kerneldoc fixes

Thanks,
Thierry

Thierry Reding (7):
  syscore: Pass context data to callbacks
  MIPS: PCI: Use contextual data instead of global variable
  bus: mvebu-mbus: Use contextual data instead of global variable
  clk: ingenic: tcu: Use contextual data instead of global variable
  clk: mvebu: Use contextual data instead of global variable
  irqchip/irq-imx-gpcv2: Use contextual data instead of global variable
  soc/tegra: pmc: Use contextual data instead of global variable

 arch/arm/mach-exynos/mcpm-exynos.c        | 12 ++--
 arch/arm/mach-exynos/suspend.c            | 48 +++++++------
 arch/arm/mach-pxa/generic.h               |  6 +-
 arch/arm/mach-pxa/irq.c                   | 10 ++-
 arch/arm/mach-pxa/mfp-pxa2xx.c            | 10 ++-
 arch/arm/mach-pxa/mfp-pxa3xx.c            | 10 ++-
 arch/arm/mach-pxa/pxa25x.c                |  4 +-
 arch/arm/mach-pxa/pxa27x.c                |  4 +-
 arch/arm/mach-pxa/pxa3xx.c                |  4 +-
 arch/arm/mach-pxa/smemc.c                 | 12 ++--
 arch/arm/mach-s3c/irq-pm-s3c64xx.c        | 12 ++--
 arch/arm/mach-s5pv210/pm.c                | 10 ++-
 arch/arm/mach-versatile/integrator_ap.c   | 12 ++--
 arch/arm/mm/cache-b15-rac.c               | 12 ++--
 arch/loongarch/kernel/smp.c               | 12 ++--
 arch/mips/alchemy/common/dbdma.c          | 12 ++--
 arch/mips/alchemy/common/irq.c            | 24 ++++---
 arch/mips/alchemy/common/usb.c            | 12 ++--
 arch/mips/pci/pci-alchemy.c               | 30 +++------
 arch/powerpc/platforms/cell/spu_base.c    | 10 ++-
 arch/powerpc/platforms/powermac/pic.c     | 12 ++--
 arch/powerpc/sysdev/fsl_lbc.c             | 12 ++--
 arch/powerpc/sysdev/fsl_pci.c             | 12 ++--
 arch/powerpc/sysdev/ipic.c                | 12 ++--
 arch/powerpc/sysdev/mpic.c                | 14 ++--
 arch/powerpc/sysdev/mpic_timer.c          | 10 ++-
 arch/sh/mm/pmb.c                          | 10 ++-
 arch/x86/events/amd/ibs.c                 | 12 ++--
 arch/x86/hyperv/hv_init.c                 | 12 ++--
 arch/x86/kernel/amd_gart_64.c             | 10 ++-
 arch/x86/kernel/apic/apic.c               | 12 ++--
 arch/x86/kernel/apic/io_apic.c            | 17 +++--
 arch/x86/kernel/cpu/aperfmperf.c          | 20 +++---
 arch/x86/kernel/cpu/intel_epb.c           | 16 +++--
 arch/x86/kernel/cpu/mce/core.c            | 14 ++--
 arch/x86/kernel/cpu/microcode/core.c      | 15 ++++-
 arch/x86/kernel/cpu/mtrr/legacy.c         | 12 ++--
 arch/x86/kernel/cpu/umwait.c              | 10 ++-
 arch/x86/kernel/i8237.c                   | 10 ++-
 arch/x86/kernel/i8259.c                   | 14 ++--
 arch/x86/kernel/kvm.c                     | 12 ++--
 drivers/acpi/pci_link.c                   | 10 ++-
 drivers/acpi/sleep.c                      | 12 ++--
 drivers/base/firmware_loader/main.c       | 12 ++--
 drivers/base/syscore.c                    | 82 ++++++++++++-----------
 drivers/bus/mvebu-mbus.c                  | 19 +++---
 drivers/clk/at91/pmc.c                    | 12 ++--
 drivers/clk/imx/clk-vf610.c               | 12 ++--
 drivers/clk/ingenic/jz4725b-cgu.c         |  2 +-
 drivers/clk/ingenic/jz4740-cgu.c          |  2 +-
 drivers/clk/ingenic/jz4755-cgu.c          |  2 +-
 drivers/clk/ingenic/jz4760-cgu.c          |  2 +-
 drivers/clk/ingenic/jz4770-cgu.c          |  2 +-
 drivers/clk/ingenic/jz4780-cgu.c          |  2 +-
 drivers/clk/ingenic/pm.c                  | 14 ++--
 drivers/clk/ingenic/pm.h                  |  2 +-
 drivers/clk/ingenic/tcu.c                 | 59 ++++++++--------
 drivers/clk/ingenic/x1000-cgu.c           |  2 +-
 drivers/clk/ingenic/x1830-cgu.c           |  2 +-
 drivers/clk/mvebu/common.c                | 19 ++++--
 drivers/clk/rockchip/clk-rk3288.c         | 12 ++--
 drivers/clk/samsung/clk-s5pv210-audss.c   | 12 ++--
 drivers/clk/samsung/clk.c                 | 12 ++--
 drivers/clk/tegra/clk-tegra210.c          | 12 ++--
 drivers/clocksource/timer-armada-370-xp.c | 12 ++--
 drivers/cpuidle/cpuidle-psci.c            | 12 ++--
 drivers/gpio/gpio-mxc.c                   | 12 ++--
 drivers/gpio/gpio-pxa.c                   | 12 ++--
 drivers/gpio/gpio-sa1100.c                | 12 ++--
 drivers/hv/vmbus_drv.c                    | 14 ++--
 drivers/iommu/amd/init.c                  | 12 ++--
 drivers/iommu/intel/iommu.c               | 12 ++--
 drivers/irqchip/exynos-combiner.c         | 14 ++--
 drivers/irqchip/irq-armada-370-xp.c       | 12 ++--
 drivers/irqchip/irq-bcm7038-l1.c          | 12 ++--
 drivers/irqchip/irq-gic-v3-its.c          | 12 ++--
 drivers/irqchip/irq-i8259.c               | 12 ++--
 drivers/irqchip/irq-imx-gpcv2.c           | 30 +++------
 drivers/irqchip/irq-loongson-eiointc.c    | 12 ++--
 drivers/irqchip/irq-loongson-htpic.c      | 10 ++-
 drivers/irqchip/irq-loongson-htvec.c      | 12 ++--
 drivers/irqchip/irq-loongson-pch-lpc.c    | 12 ++--
 drivers/irqchip/irq-loongson-pch-pic.c    | 12 ++--
 drivers/irqchip/irq-mchp-eic.c            | 12 ++--
 drivers/irqchip/irq-mst-intc.c            | 12 ++--
 drivers/irqchip/irq-mtk-cirq.c            | 12 ++--
 drivers/irqchip/irq-renesas-rzg2l.c       | 12 ++--
 drivers/irqchip/irq-sa11x0.c              | 12 ++--
 drivers/irqchip/irq-sifive-plic.c         | 12 ++--
 drivers/irqchip/irq-sun6i-r.c             | 18 +++--
 drivers/irqchip/irq-tegra.c               | 12 ++--
 drivers/irqchip/irq-vic.c                 | 12 ++--
 drivers/leds/trigger/ledtrig-cpu.c        | 14 ++--
 drivers/macintosh/via-pmu.c               | 12 ++--
 drivers/power/reset/sc27xx-poweroff.c     | 10 ++-
 drivers/sh/clk/core.c                     | 10 ++-
 drivers/sh/intc/core.c                    | 12 ++--
 drivers/soc/bcm/brcmstb/biuctrl.c         | 12 ++--
 drivers/soc/tegra/pmc.c                   | 21 ++++--
 drivers/thermal/intel/intel_hfi.c         | 12 ++--
 drivers/xen/xen-acpi-processor.c          | 12 ++--
 include/linux/syscore_ops.h               | 15 +++--
 kernel/cpu_pm.c                           | 12 ++--
 kernel/irq/generic-chip.c                 | 14 ++--
 kernel/irq/pm.c                           | 11 ++-
 kernel/printk/printk.c                    | 11 ++-
 kernel/time/sched_clock.c                 | 22 ++++--
 kernel/time/timekeeping.c                 | 22 ++++--
 virt/kvm/kvm_main.c                       | 18 +++--
 109 files changed, 930 insertions(+), 523 deletions(-)

-- 
2.51.0


