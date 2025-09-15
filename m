Return-Path: <linux-acpi+bounces-16895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ADAB573BE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F87A6DC5
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403B2F3628;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH7y4IrF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE32F28E7;
	Mon, 15 Sep 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926633; cv=none; b=cILAT3F0lnOWT/GkOYnll04KbfH3SLrymaZ9/rB4SQnywSgzQMMxC17zyyJ45Jb9BaRWQzUvvaH6usI54/v8FV5B+rfB1WRmTQYMGEVSkOShealPM7XYVccYk9hwm+/8+oX2yq6shTZUmigkR9O6O0d+bkl1M1freKX8wYDsrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926633; c=relaxed/simple;
	bh=5E+Yes9XOWiH81I9dVAZpfFciGGWYGCSQDF6XHckgR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JypPN/Xfs7cbK2y6/qtkuHNljB7IYezvK2rZ0STxCir4DUZbTZeasIEUgcarC2asTidyoP8dAU5fGJnpU6sOCL0zCwrTU4h7fjZ0xsV9iJZ4Fc2Jv1Ep48Su4hmMxAZt5Z6YtDVsyGqGzlYYJKVnwk8IhZ2cwlz0/JnV7K70q9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH7y4IrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740FCC4CEF1;
	Mon, 15 Sep 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926633;
	bh=5E+Yes9XOWiH81I9dVAZpfFciGGWYGCSQDF6XHckgR8=;
	h=From:To:Cc:Subject:Date:From;
	b=sH7y4IrFh198drJ40DUGs8+te89u3vEmFcBK6a7wiHEzlKVJh2DxGIw7k+xjcnvGR
	 wpylXBu851ownBXwOlOcixK9YBSteVCnfS8D/YskqXZ1ULAiGUR5CsF0bMVshodFnI
	 1+r73Rk9HgTm5c+wWQeJrG0aro9VrNZwonqb/QDrG3qvISyiMFDRZ4TyRAV1HgRAs3
	 mtSeChf8Ps6dRrI58ikYtNMGt0048WpExcaqI1yTFhkBwrAW2PQPptH1l9rd9w5YMu
	 pYSMqpX5xQkKJh2WxpaHZOfDSdWIg/zS6RAm8i7XXfT6wxnRoR0WNnEd0BB5sp/K81
	 EFhTuz+6osXig==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51L-00000006IHP-0QON;
	Mon, 15 Sep 2025 08:57:11 +0000
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
Subject: [PATCH v2 00/25] genirq: Add support for percpu_devid IRQ affinity
Date: Mon, 15 Sep 2025 09:56:37 +0100
Message-Id: <20250915085702.519996-1-maz@kernel.org>
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

This is the second version of this series, originally posted at [1],
which aims at allowing percpu_devid interrupt requests on the basis of
an affinity mask. See the original submission for the details of why
this is a desirable outcome.

From v1, we have a number of changes, both functional and cosmetic,
but the fundamentals are pretty much the same (change log below), with
an even more appealing diffstat.

Thanks to Will, Thomas and Raphael for their constructive review
comments.

FWIW, I've pushed a branch at [2].

* From v1 [1]:

  - Fixed NMI handling by getting rid of the NMI-specific flow
    handler, which was pretty useless anyway (Will)

  - As a result, killed a metric buttload worth of GICv3 code

  - Moved irq_fwspec out of irq_fwspec_info, and passed it as a
    parameter to irq_get_fwspec_info(), renamed from irq_get_info(),
    and applied some generous sanitisation of the structure (Thomas)

  - Dropped the rather useless fwspec validity flag (Thomas)

  - Rejigged the PMU per-CPU handling to better deal with the DT/ACPI
    differences, and drop some now useless patches (Will)

  - Plenty of cosmetic rework (Raphael, Thomas)

[1] https://lore.kernel.org/r/20250908163127.2462948-1-maz@kernel.org
[2] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/ppi-affinity

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
  irqchip/gic-v3: Switch high priority PPIs over to
    handle_percpu_devid_irq()
  genirq: Kill handle_percpu_devid_fasteoi_nmi()
  genirq: Merge irqaction::{dev_id,percpu_dev_id}
  genirq: Factor-in percpu irqaction creation
  genirq: Add affinity to percpu_devid interrupt requests
  genirq: Update request_percpu_nmi() to take an affinity
  genirq: Allow per-cpu interrupt sharing for non-overlapping affinities
  genirq: Add request_percpu_irq_affinity() helper
  perf: arm_spe_pmu: Request specific affinities for percpu IRQ
  coresight: trbe: Request specific affinities for percpu IRQ
  irqchip/gic-v3: Drop support for custom PPI partitions
  irqchip/apple-aic: Drop support for custom PMU irq partitions
  irqchip: Kill irq-partition-percpu
  genirq: Kill irq_{g,s}et_percpu_devid_partition()
  perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer

Will Deacon (1):
  perf: arm_pmu: Request specific affinities for percpu NMI/IRQ

 arch/arm64/kernel/smp.c                      |   2 +-
 drivers/acpi/irq.c                           |  19 ++
 drivers/base/platform.c                      |  60 ++++-
 drivers/hwtracing/coresight/coresight-trbe.c |   9 +-
 drivers/irqchip/Kconfig                      |   4 -
 drivers/irqchip/Makefile                     |   1 -
 drivers/irqchip/irq-apple-aic.c              |  56 +++--
 drivers/irqchip/irq-gic-v3.c                 | 224 +++++------------
 drivers/irqchip/irq-partition-percpu.c       | 241 -------------------
 drivers/of/irq.c                             |  20 ++
 drivers/perf/arm_pmu.c                       |  50 ++--
 drivers/perf/arm_pmu_acpi.c                  |   2 +-
 drivers/perf/arm_pmu_platform.c              |  20 +-
 drivers/perf/arm_pmuv3.c                     |   2 +-
 drivers/perf/arm_spe_pmu.c                   |  13 +-
 include/linux/acpi.h                         |   7 +
 include/linux/interrupt.h                    |  24 +-
 include/linux/irq.h                          |   5 -
 include/linux/irqchip/irq-partition-percpu.h |  53 ----
 include/linux/irqdesc.h                      |   1 -
 include/linux/irqdomain.h                    |  28 +++
 include/linux/of_irq.h                       |   7 +
 include/linux/perf/arm_pmu.h                 |   6 +-
 include/linux/platform_device.h              |   2 +
 kernel/irq/chip.c                            |  36 +--
 kernel/irq/irqdesc.c                         |  24 +-
 kernel/irq/irqdomain.c                       |  32 ++-
 kernel/irq/manage.c                          | 124 +++++++---
 28 files changed, 423 insertions(+), 649 deletions(-)
 delete mode 100644 drivers/irqchip/irq-partition-percpu.c
 delete mode 100644 include/linux/irqchip/irq-partition-percpu.h

-- 
2.39.2


