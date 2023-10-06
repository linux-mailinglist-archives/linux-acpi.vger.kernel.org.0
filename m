Return-Path: <linux-acpi+bounces-461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7BA7BBA56
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E192822AA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1A26E01
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bETbu+rA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39C1F604;
	Fri,  6 Oct 2023 12:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F24AC433C8;
	Fri,  6 Oct 2023 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696597177;
	bh=4MA/LskURMEJ12KVbP+fP6rhRzcvwd/Y3VAARsbtgKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bETbu+rA1puRoxryATnjVCGhe6ye4E0ESqOWM6iYAC/DHD1zut2RX78JHqc+hYyGD
	 7z2fo359Izt9OJ6Hs+5nywrwiZ9aa/o4oMbrsFy1GIHGEfRk/LmdxFIrsJsU1uIArh
	 rDdSMpM6jmotdHt3qsJXrcIYljGLxAUhLLvdrELcASS5Cs3JVXdvbXUbpats7CgkEC
	 dvbaWN4pbyoqOkvFo7ZHQgSMDQv2qyVORbjMuqEA5VGAI8Bg80N522iXxKGc1Ll9c7
	 obD9dwFN/dGaGqIOarT0IeFfTcKpMdf9iRq05P2TmVklXSHoZobiMFEGOZa/vvrc9c
	 uekebDszGTMxQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 0/5] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date: Fri,  6 Oct 2023 14:59:24 +0200
Message-Id: <20231006125929.48591-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905104721.52199-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is v3 of previous series:

v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org

v2 -> v3:
	- Added ACPICA temporary changes and ACPI changes to implement
	  ECR https://bugzilla.tianocore.org/show_bug.cgi?id=4557
	- ACPI changes are for testing purposes - subject to ECR code
	  first approval

v1 -> v2:
	- Updated DT bindings as per feedback
	- Updated patch[2] to use GIC quirks infrastructure

Original cover letter
---
The GICv3 architecture specifications provide a means for the
system programmer to set the shareability and cacheability
attributes the GIC components (redistributors and ITSes) use
to drive memory transactions.

Albeit the architecture give control over shareability/cacheability
memory transactions attributes (and barriers), it is allowed to
connect the GIC interconnect ports to non-coherent memory ports
on the interconnect, basically tying off shareability/cacheability
"wires" and de-facto making the redistributors and ITSes non-coherent
memory observers.

This series aims at starting a discussion over a possible solution
to this problem, by adding to the GIC device tree bindings the
standard dma-noncoherent property. The GIC driver uses the property
to force the redistributors and ITSes shareability attributes to
non-shareable, which consequently forces the driver to use CMOs
on GIC memory tables.

On ARM DT DMA is default non-coherent, so the GIC driver can't rely
on the generic DT dma-coherent/non-coherent property management layer
(of_dma_is_coherent()) which would default all GIC designs in the field
as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.

When a consistent approach is agreed upon for DT an equivalent binding will
be put forward for ACPI based systems.

Lorenzo Pieralisi (4):
  dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent
    property
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing
  ACPICA: Add new MADT GICC/GICR/ITS flags handling [code first]
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

Marc Zyngier (1):
  irqchip/gic-v3-its: Split allocation from initialisation of its_node

 .../interrupt-controller/arm,gic-v3.yaml      |  12 ++
 drivers/acpi/processor_core.c                 |  21 +++
 drivers/irqchip/irq-gic-common.h              |  12 ++
 drivers/irqchip/irq-gic-v3-its.c              | 174 +++++++++++-------
 drivers/irqchip/irq-gic-v3.c                  |  22 +++
 include/acpi/actbl2.h                         |  11 +-
 include/linux/acpi.h                          |   3 +
 7 files changed, 189 insertions(+), 66 deletions(-)

-- 
2.34.1


