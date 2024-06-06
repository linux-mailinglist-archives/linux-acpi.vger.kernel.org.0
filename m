Return-Path: <linux-acpi+bounces-6214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA008FE33E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62741C26098
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8E154BE4;
	Thu,  6 Jun 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUDzTy5W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6C13FD84;
	Thu,  6 Jun 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666966; cv=none; b=YgLssORIe4fXmRW3uNJ3kOqsq2NN2qrbis4utNINpdjZhYwv/dyILIbhVXaCFn2+4oACtGNdp0DZ5uHDEQk/KZ2JpF+5zbUWI/IKb5t3z8+z+5emnK5KLy5gl6vUqiMOynBgBZSNPXBEs+LWxPs2koUUNRo1sPHGR1pFjhW5Y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666966; c=relaxed/simple;
	bh=hhaLQOadxU5defJpVRlf4Y1/QVE35uX/AEioCXExAuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcSx0KGBbvt1nY0Tps04blPBZbM9h400wOfKmMSEF0Xf1OBI3NESZ4zvRKg7j1MqRNuelcf+N/8ydwULTtN/fbswkgPtp+quMuIlci6ezljeRN7nFxzuc4dRde+dqPrh8PTDKhnzk8Cp6DcCY10XyFIjhXa76o+qhFJzHw4L36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUDzTy5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B3EC4AF12;
	Thu,  6 Jun 2024 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666965;
	bh=hhaLQOadxU5defJpVRlf4Y1/QVE35uX/AEioCXExAuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUDzTy5WbhukN6ofag3xN2VXHt++vU6Hl56rU71dTE82ZDQtLJJ9ILyDfVx482NPz
	 dSw47si84tHv5QwfT7gY8UlwRgvyO++ekoiTBovJFS6bjZCWju6HRJHkHf6LevKa0C
	 7EkCtLQ8BCGIhRyiBsN3nYt280V6B2B8PD4QzyOllbJm5aKmlHjqnqJJsmXJH7+hiZ
	 Rezrr6PiNGK+GLrV61IlrOMVyfxL24nzFXGpvwMVm0nheFoUL85QWi5oI1peWdBVGc
	 SRWVG0FSb8TKvWBJPw+cTk0xsEnaZ9/bP6NcJxElyHkqDN8Ezuk+Wkqc1HMi7l5ar/
	 d+qIVNditjErQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v6 0/1] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date: Thu,  6 Jun 2024 11:42:37 +0200
Message-Id: <20240606094238.757649-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110332.112797-1-lpieralisi@kernel.org>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is v6 of previous series:

v5: https://lore.kernel.org/all/20240123110332.112797-1-lpieralisi@kernel.org
v4: https://lore.kernel.org/all/20231227110038.55453-1-lpieralisi@kernel.org
v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org

v5 -> v6
	- Rebased against v6.10-rc1
	- Added Marc Zyngier's ACK

v4 -> v5
	- ACPICA patches merged for v6.8
	- Refactored ACPI parsing code according to review
	- Rebased against v6.8-rc1

v3 -> v4:
	- Dropped patches [1-3], already merged
	- Added Linuxized ACPICA changes accepted upstream
	- Rebased against v6.7-rc3

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

Lorenzo Pieralisi (1):
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

 drivers/acpi/processor_core.c    | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/linux/acpi.h             |  3 +++
 4 files changed, 31 insertions(+)

-- 
2.34.1


