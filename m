Return-Path: <linux-acpi+bounces-18219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB0C098FF
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBD9B34E4E4
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAC308F23;
	Sat, 25 Oct 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/s+Eoq0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191030BB81;
	Sat, 25 Oct 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409640; cv=none; b=Opz502L/Egd+JFvT2zeqX3YvQef2f0MMVl5fZYn0JYJKxT/q+wjf+r5QJdaqiMyElafvSTWbVze34YOWG+07CfovaZSpPcWbP7jF+uzRD8qZPXRQH7OSTWK5n9cTivsMOBefj5qckKzWJuegREzyOZ2eqFHeGulK4GZ3agoP7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409640; c=relaxed/simple;
	bh=BzK5MSbnikKVMVBl3CpIZyvVtiwzDtnUwx3iJLWc4o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNTL7/T+0dIFVa7eJXmxyvBf19n5Ue3n1i6BI69DZIMu+rxYG4vT3U+D1gTlnPVepULZ9k9/VTuw8v8ff1ADABdvIQptAf/VlHkn2Y5dGD0fM0SNXoMls+nARFXLyTASyU0yUW3JgDcT2WML4Jjulg77hPzp4B6epRDlB32El0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/s+Eoq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F71DC4CEF5;
	Sat, 25 Oct 2025 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409639;
	bh=BzK5MSbnikKVMVBl3CpIZyvVtiwzDtnUwx3iJLWc4o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/s+Eoq0aUEnsoC1dltYqTaorPiJ3wHMwXlfCvn4iqtOpwxndV1LFibP2BcrQi1Gg
	 YkE5cKanwGd/tH6Eym2ofnfDbwopaZ78rMJcQSYJwz2jqI1ne5bc3xAx1SEP5nW0aZ
	 dEhEcDVqkxIjxo/YPm69YcYXBsbPAcbK11yPIQlWhFLTN5n8iyiSNMsChqIxel7Y3F
	 u3abog3uOyvnTDNGnEIOEW3UUnxhevnZGOF6p4HQq9NzYF59X2m+pIdUz2IDhOs3HS
	 OKLUA2wpaB5rsFx7id4RKMbzEHE01VM3+lEtAqG2ogUaB4h/7orqtZhwcwlvv3Ny9F
	 sGHxgzNqYzTdw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-6.12] ACPI: scan: Update honor list for RPMI System MSI
Date: Sat, 25 Oct 2025 12:00:32 -0400
Message-ID: <20251025160905.3857885-401-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

[ Upstream commit 4215d1cf59e4b272755f4277a05cd5967935a704 ]

The RPMI System MSI interrupt controller (just like PLIC and APLIC)
needs to probed prior to devices like GED which use interrupts provided
by it. Also, it has dependency on the SBI MPXY mailbox device.

Add HIDs of RPMI System MSI and SBI MPXY mailbox devices to the honor
list so that those dependencies are handled.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Link: https://lore.kernel.org/r/20250818040920.272664-17-apatel@ventanamicro.com
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
**Why**
- The patch extends the `_DEP` honor list in
  `drivers/acpi/scan.c:856-866` so that ACPI dependencies pointing at
  the SBI MPXY mailbox (`RSCV0005`) and RPMI System MSI controller
  (`RSCV0006`) are actually enforced. Without these entries,
  `acpi_scan_add_dep()` never sets `dep->honor_dep` for those HIDs
  (`drivers/acpi/scan.c:2034-2049`), leaving `device->flags.honor_deps`
  clear and allowing consumers to enumerate even when their IRQ
  provider/mailbox is missing, because
  `acpi_dev_ready_for_enumeration()` only blocks devices when both
  `honor_deps` and `dep_unmet` are set
  (`drivers/acpi/scan.c:2481-2486`).
- On RISC-V ACPI systems the arch helper builds implicit dependencies
  between devices and their interrupt controllers
  (`drivers/acpi/riscv/irq.c:340-404`). GED and other consumers
  therefore get `_DEP` entries that reference the RPMI System MSI node.
  If the honor flag is missing, GED can probe before the MSI domain
  exists, causing its interrupt setup to fail.
- The RPMI System MSI driver itself requires the MPXY mailbox to be
  ready; it immediately requests a mailbox channel in probe
  (`drivers/irqchip/irq-riscv-rpmi-sysmsi.c:223-233`). A premature probe
  hits `-EPROBE_DEFER`, and without the dependency being honored the
  driver keeps churning instead of waiting for the mailbox to finish.
- Both suppliers call `acpi_dev_clear_dependencies()` once they succeed
  (`drivers/irqchip/irq-riscv-rpmi-sysmsi.c:298-303`,
  `drivers/mailbox/riscv-sbi-mpxy-mbox.c:974-979`), so honoring their
  `_DEP`s restores the intended sequencing with no behavioral change
  elsewhere.
- Change risk is minimal: it only adds two strings, matching the
  precedent already in place for other RISC-V interrupt controllers. It
  fixes a user-visible failure (missing interrupts / repeated probe
  defers) on ACPI RISC-V platforms that already shipped the new RPMI +
  MPXY support.

**Next Step**
- Boot-test on an ACPI RISC-V platform using RPMI/MPXY to confirm GED
  and dependent devices enumerate cleanly once the MSI controller and
  mailbox load.

 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a36..54181b03b345b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -858,6 +858,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"RSCV0005", /* RISC-V SBI MPXY MBOX */
+	"RSCV0006", /* RISC-V RPMI SYSMSI */
 	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
-- 
2.51.0


