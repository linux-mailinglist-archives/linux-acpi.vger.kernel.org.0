Return-Path: <linux-acpi+bounces-17974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0758BF13AD
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A2D423D8B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A2F3148B4;
	Mon, 20 Oct 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOYeQEiH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F2313E0A;
	Mon, 20 Oct 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963409; cv=none; b=tIijLkmB0mJK/qr0Eq8ab6Ed3OW+9ywKYaC4Yxq4UfCiF6J48Gve2QKWefq7M1l45sUCKr+QNbj5vA0T3dA480opYjJe8+vmD9BqfEb5F+aouSxZqEUwBzo3zmg4cSgA05LCLsovv3PDtcvHL84S9dMUfJ16MOt4O6LNQUVY5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963409; c=relaxed/simple;
	bh=xb/lnXZ7cyeI2Kiq/oDJcO0yuGXr40YVwbGy347cEi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExWIbYc9oOwOW0TQPFPuXhlif20jZkgglpfAaAdlIpFFHk2kRLRaSG8jZtRS2jCv+5uGA6J2ahz5CIYuC5cBh4fDYaVJBPEkoAI4o6+iur7VLipntQJaR8hiMkyi3xnTlgffFqL6bTu515JEcK3wZE8+0C+rTLnvRv0snxX1dpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOYeQEiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB9FC113D0;
	Mon, 20 Oct 2025 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963409;
	bh=xb/lnXZ7cyeI2Kiq/oDJcO0yuGXr40YVwbGy347cEi0=;
	h=From:To:Cc:Subject:Date:From;
	b=VOYeQEiHx1SU+kMdzV43TDLpRb/1X2OAi6PQIFcfwGAIFzadoDTyFta0UEI4rXH4B
	 hgYtCS6UuWatHtdKWWUu7+S4kkQiJqELiJ2w0+yM2qQ+EL2j96Vu7x8hjZL286TyRD
	 oupHx1nr1ArXNaWDVYP96bm8K8/p7xgEJ3vy2h5Sumy0YYnz5MnKiXS+dtb4Ke/ML/
	 Z/T303aL37zQp64TDGGeTQCM/8nU5Y62V85iuTKZeDgy0V2SIupCOjH0FzJgXBEUUf
	 Lee3TSVSAcnNkPXozbjR20EDn5K1Xk1bE6AUn3m1G5hgbGffesvFS0yr9qvac2kOx2
	 zkra8w+VY7joQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1b-0000000FUu2-0E4m;
	Mon, 20 Oct 2025 12:30:07 +0000
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
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 00/26] genirq: Add support for percpu_devid IRQ affinity
Date: Mon, 20 Oct 2025 13:29:17 +0100
Message-ID: <20251020122944.3074811-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com, ruanjinjie@huawei.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

This is the fourth version of this series, originally posted at [1],
which aims at allowing percpu_devid interrupt requests on the basis of
an affinity mask. See the original submission for the details of why
this is a desirable outcome.

From v3, we have some additional tidying up, thanks to Jonathan's
review, and a bunch of tags -- see changelog for details.

FWIW, I've pushed a branch at [0].

* From v3 [3]:

  - Additional cleanups in of_irq_get_affinity() (Jonathan)

  - Rebased on 6.18-rc2

  - Collected Abs, Rbs and Tbs, with thanks (Raphael, Jonathan,
    Jinjie, Suzuki, Sven, Will)

* From v2 [2]:

  - Turned of_node_to_fwnode() usage to of_fwnode_handle() (Jonathan)

  - Added a patch to finally kill of_node_to_fwnode()

  - Tidied-up documentation, comments and formatting (Jonathan)

  - Collected ABs and Rbs, with thanks (Jonathan, Suzuki, Sven)

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

[0] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/ppi-affinity
[1] https://lore.kernel.org/r/20250908163127.2462948-1-maz@kernel.org
[2] https://lore.kernel.org/r/20250915085702.519996-1-maz@kernel.org
[3] https://lore.kernel.org/r/20250922082833.2038905-1-maz@kernel.org

Marc Zyngier (25):
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
  irqdomain: Kill of_node_to_fwnode() helper
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
 drivers/perf/arm_pmu.c                       |  49 ++--
 drivers/perf/arm_pmu_acpi.c                  |   2 +-
 drivers/perf/arm_pmu_platform.c              |  20 +-
 drivers/perf/arm_pmuv3.c                     |   2 +-
 drivers/perf/arm_spe_pmu.c                   |  13 +-
 include/linux/acpi.h                         |   7 +
 include/linux/interrupt.h                    |  24 +-
 include/linux/irq.h                          |   5 -
 include/linux/irqchip/irq-partition-percpu.h |  53 ----
 include/linux/irqdesc.h                      |   1 -
 include/linux/irqdomain.h                    |  33 ++-
 include/linux/of_irq.h                       |   7 +
 include/linux/perf/arm_pmu.h                 |   6 +-
 include/linux/platform_device.h              |   2 +
 kernel/irq/chip.c                            |  33 +--
 kernel/irq/irqdesc.c                         |  24 +-
 kernel/irq/irqdomain.c                       |  32 ++-
 kernel/irq/manage.c                          | 125 +++++++---
 28 files changed, 419 insertions(+), 655 deletions(-)
 delete mode 100644 drivers/irqchip/irq-partition-percpu.c
 delete mode 100644 include/linux/irqchip/irq-partition-percpu.h

-- 
2.47.3


