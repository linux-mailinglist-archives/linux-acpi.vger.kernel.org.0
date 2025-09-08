Return-Path: <linux-acpi+bounces-16475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85774B49557
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D0F7AE01E
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5430F93B;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJH0y4mb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBED30F929;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349108; cv=none; b=tu1ebLnYq0YvQ2vVXr9BscJfW4HyeNQR9wQohsY05hbkwnffHrnx4KPPFs2lmbz8/4u2q907+guLLJ6GpLhiVv3l/8H33u1mgaX+sdOM61xvg+shxXsX5xiTGtF713XIRWtpndaas3bAMpjd6zc5Ewvxa7aKG/dRL/kybDLFGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349108; c=relaxed/simple;
	bh=cpc5ly2o2WQkQtPbUB4Zjuk/c/FKDFEpv7UIsfK58hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mbt+DRiMR0c1gD9thuUO6OjMmO79k9FXXn/dFqN1p1z6jqWj3bXYm0+UKNEKmnLMM1nbOasJmeyrwJgpitjjj2H3XLTs1PBT1tq8EaGrdplqgGRBOaNSYufC8yKXG6mN1J3o+i9PxpDS7FNRBh1ERCz8eOsYmG67xEQ/Ip5+vnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJH0y4mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC17C4CEF1;
	Mon,  8 Sep 2025 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349108;
	bh=cpc5ly2o2WQkQtPbUB4Zjuk/c/FKDFEpv7UIsfK58hc=;
	h=From:To:Cc:Subject:Date:From;
	b=GJH0y4mbdzkVCZ4Wwr0lx+LuuZlWdOjKSPTIzYTYorWiKUArCpwpr47W4IgwLh65n
	 BDM7+tj4C2eD9W1wzE4rvfMBNM8P1Y0NDo5ywrLXT/FbkFvnO82gIfMru+1z3hHhKs
	 SdKTclX/K8ZrD/P29wwSqtuVR+CDVVyWhw+hSU2SkwbF6bkjqrw3E/r8Pte0gQNtq/
	 lj6TTZHQcgwQ3h8geM2Gsffecal16DcsNhbtAAF0YhARBsj3JtXMpHgDC6YfarRYgW
	 zzzzq3GW5oDTzRLSJrlLwCbF/izc74/VAv09wXwfRQtoouTiqR1BT+E/UcBjx6p9F2
	 M3JNP2LC0SWaA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemP-00000004NTm-1gja;
	Mon, 08 Sep 2025 16:31:45 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 00/25] genirq: Add support for percpu_devid IRQ affinity
Date: Mon,  8 Sep 2025 17:31:02 +0100
Message-Id: <20250908163127.2462948-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The percpu_devid class of interrupts represent interrupts that are
generally produced by CPUs or per-CPU devices (timer, PMU), and are
more or less directly wired to that same CPU.

The core code has a baked-in assumption that all CPUs have the same
devices wired to the same interrupt, making the whole system
homogeneous in that respect.

Unfortunately, this is wishful thinking, and the big-little
contraption has proved more often than not that sanity was not
necessarily part of the design requirements.

The typical problem on ARM systems is that while all CPUs have a PMU,
not all PMUs are the same and require a slightly different programing
model. The driver therefore has to treat them differently. Another
problem is that some devices are only present on a subset of the CPUs,
and not others.

All in all, it means that these percpu_devid interrupts (which are
represented as PPIs on the GIC class of interrupt controllers) are not
ideally handled by the core code.

At least two interrupt controllers (GICv3 and Apple AIC) have invented
their own schemes to paper over these problems. In the GICv3 case (the
most over-engineered one), the low-level irqchip creates a mux irqchip
for each PPI (up to 64 of them), and each possible affinity class
represents an interrupt in this mux. Like this (compressed for
readability):

# grep pmu /proc/interrupts 
 38: 0    0    0    0    0    0  GICv3-23   0 Level     arm-pmu
 39: 0    0    0    0    0    0  GICv3-23   1 Level     arm-pmu

Yes, this is nuts. But by hiding that the PPI is split between two
affinity groups, and exposing two interrupts that are apparently
system-wide, we trick the core code into not exploding.

While this solution has worked for the past 9 years, it creates its
own class of issues. The most glaring one is that we cannot configure
these interrupts as NMIs, as they are muxed interrupts and we don't
allow NMIs outside of the root interrupt controller (this would imply
taking locks that are not safe in this context). As it turns out, some
of the heaviest users of profiling are also users of the most crazy
systems out there (cough phones cough)...

It is also pretty bad that the core IRQ code cannot handle natively
what has become an extremely common HW setup, for better or worse.

Finally, I have no desire to replicate the same horror on the next
generation of ARM interrupt controller (GICv5), and this is the
opportunity to put things right.

This series therefore aims at teaching the core code about these
interrupts, removing all sort of irqchip-specific handling, and allow
NMIs to be naturally handled in these setups.

We want:

- a single irqdesc representing the system-wide percpu interrupt

- the irqaction to carry the affinity the handler applies to

For that, we have a few problems to solve:

- communicating the affinity of an interrupt from the firmware to the
  device driver.

  This is currently done via the irq_{g,s}et_percpu_devid_partition(),
  but this is stored on a per-irqdesc basis, which wouldn't work
  anymore with the scheme described above.

  For that, we expose a new irqdomain op, implemented by the irqchips,
  that can retrieve FW-specific information including interrupt
  affinity, which then gets processed by ACPI and OF helpers to report
  the affinity to the platform layer. A new platform-level API can
  retrieve both the interrupt and its affinity, and the three drivers
  that make use of such affinity are updated to use this interface.

- teaching the core code about affinity-specific interrupts by
  allowing a percpu interrupt to be requested for a specific affinity.

  This involves tracking the affinity at the irqaction level and
  enforce that it isn't possible to request the interrupt twice with
  overlapping affinities. A new flavour of request_irq() is provided
  for that purpose, and the drivers updated to make use of it.

- kill the irqchip-specific infrastructure, allowing the normal flow
  of interrupt request to be restored.

With that, we end-up with this on the same platform as above:

# grep pmu /proc/interrupts
 27: 0   0   0   0    0    0  GICv3  23 Level     arm-pmu, arm-pmu

which is much more satisfactory, and allows the use of NMIs. It
doesn't hurt that the whole thing ends up with a negative diffstat.

Patches on top of v6.17-rc5, tested on a bunch of asymmetric systems:

- RK3399 (GICv3, DT)
- O6 (GICv3, ACPI)
- M1 (AIC, DT)

as well as on a saner symmetric system (Synquacer).

Marc Zyngier (24):
  irqdomain: Add firmware info reporting interface
  ACPI: irq: Add IRQ affinity reporting interface
  of/irq: Add IRQ affinity reporting interface
  platform: Add firmware-agnostic irq and affinity retrieval interface
  irqchip/gic-v3: Add FW info retrieval support
  irqchip/apple-aic: Add FW info retrieval support
  coresight: trbe: Convert to new IRQ affinity retrieval API
  perf: arm_pmu: Convert to new IRQ affinity retrieval API
  perf: arm_spe_pmu: Convert to new IRQ affinity retrieval API
  perf: arm_pmu: Add PMU/CPU affinity tracking
  genirq: Merge irqaction::{dev_id,percpu_dev_id}
  genirq: Factor-in percpu irqaction creation
  genirq: Add affinity to percpu_devid interrupt requests
  genirq: Update request_percpu_nmi() to take an affinity
  genirq: Allow per-cpu interrupt sharing for non-overlapping affinities
  genirq: Add request_percpu_irq_affinity() helper
  perf: arm_pmu: Request specific affinities for percpu NMI/IRQ
  perf: arm_spe_pmu: Request specific affinities for percpu IRQ
  coresight: trbe: Request specific affinities for percpu IRQ
  irqchip/gic-v3: Drop support for custom PPI partitions
  irqchip/apple-aic: Drop support for custom PMU irq partitions
  irqchip: Kill irq-partition-percpu
  genirq: Kill irq_{g,s}et_percpu_devid_partition()
  perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer

Will Deacon (1):
  perf: arm_pmu: Use a backend-specific pointer for percpu interrupt
    request

 arch/arm64/kernel/smp.c                      |   2 +-
 drivers/acpi/irq.c                           |  15 ++
 drivers/base/platform.c                      |  60 ++++-
 drivers/hwtracing/coresight/coresight-trbe.c |   9 +-
 drivers/irqchip/Kconfig                      |   4 -
 drivers/irqchip/Makefile                     |   1 -
 drivers/irqchip/irq-apple-aic.c              |  59 +++--
 drivers/irqchip/irq-gic-v3.c                 | 172 +++++--------
 drivers/irqchip/irq-partition-percpu.c       | 241 -------------------
 drivers/of/irq.c                             |  20 ++
 drivers/perf/arm_pmu.c                       |  61 +++--
 drivers/perf/arm_pmu_acpi.c                  |   7 +-
 drivers/perf/arm_pmu_platform.c              |  24 +-
 drivers/perf/arm_pmuv3.c                     |   2 +-
 drivers/perf/arm_spe_pmu.c                   |  13 +-
 include/linux/acpi.h                         |   7 +
 include/linux/interrupt.h                    |  24 +-
 include/linux/irq.h                          |   4 -
 include/linux/irqchip/irq-partition-percpu.h |  53 ----
 include/linux/irqdesc.h                      |   1 -
 include/linux/irqdomain.h                    |  30 +++
 include/linux/of_irq.h                       |   7 +
 include/linux/perf/arm_pmu.h                 |   7 +-
 include/linux/platform_device.h              |   2 +
 kernel/irq/chip.c                            |   8 +-
 kernel/irq/irqdesc.c                         |  24 +-
 kernel/irq/irqdomain.c                       |  33 ++-
 kernel/irq/manage.c                          | 128 +++++++---
 28 files changed, 449 insertions(+), 569 deletions(-)
 delete mode 100644 drivers/irqchip/irq-partition-percpu.c
 delete mode 100644 include/linux/irqchip/irq-partition-percpu.h

-- 
2.39.2


