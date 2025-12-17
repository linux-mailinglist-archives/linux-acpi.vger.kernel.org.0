Return-Path: <linux-acpi+bounces-19624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F7CC765C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144F430C228C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11DE33FE12;
	Wed, 17 Dec 2025 11:32:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D233893C;
	Wed, 17 Dec 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971127; cv=none; b=d8Xu35MXOoQ6JxCgxbrDaQ50saXy0VexE22aAb+vyGP9zknVfAAerSIpsQ1yZ0xJXjCLjRvEt5NX5jr1W6knnFxwfbfdlxGjkM7sg6o8hLdoNm/juepwSH6OYceG9bkjw2YYIfBvaQlXSNIAs4v4JMBR/+dESEZayb8mCnwAoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971127; c=relaxed/simple;
	bh=N2v9bsf7j7PYYsfqFDEyn/Yauym+j4KV8NEbr5nawRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B18ec824z2aM4AXGM0IkfuSUQKuJzjD7PbJosJChwB3WTZz56jOoPAmvI5Ntk+fOvdQvU0QoKjhSg3lvsGIAdnvYvE0G/O+tPlFJPnmI/6S9geML2QPKZ1DZ2DJxsAA5GMHCoPcdOwujAx3wyLMs+8hAWlxHA6R7khL6wZCdryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C89169C;
	Wed, 17 Dec 2025 03:31:55 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9843F73B;
	Wed, 17 Dec 2025 03:32:00 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: [PATCH 12/12] doc: ras: describe firmware-first estatus flow
Date: Wed, 17 Dec 2025 11:28:45 +0000
Message-ID: <20251217112845.1814119-13-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217112845.1814119-1-ahmed.tiba@arm.com>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a short section to the RAS admin guide that explains how the new
estatus core and DeviceTree provider are enabled, and point readers to
the binding that describes the firmware-first CPER layout.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 Documentation/admin-guide/RAS/main.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
index 5a45db32c49b..adff8b4bc84b 100644
--- a/Documentation/admin-guide/RAS/main.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -205,6 +205,30 @@ Architecture (MCA)\ [#f3]_.
 .. [#f3] For more details about the Machine Check Architecture (MCA),
   please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kernel tree.
 
+Firmware-first CPER status providers
+------------------------------------
+
+Some systems expose Common Platform Error Record (CPER) data via firmware
+interfaces instead of relying on CPU machine-check banks. The kernel routes
+those records through the shared *estatus* core:
+
+* ``CONFIG_RAS_ESTATUS_CORE`` hosts the in-kernel data movers and notifiers.
+  It is selected automatically when ACPI/APEI GHES support is enabled or when
+  the DeviceTree provider below is built.
+* ``CONFIG_RAS_ESTATUS_DT`` adds the ``drivers/ras/estatus-dt.c`` provider that
+  maps a firmware-advertised CPER status block on non-ACPI platforms. The
+  DeviceTree binding is documented in
+  ``Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml`` and describes the
+  status-buffer region and the notification signal (interrupt or polling) that
+  firmware uses to advertise new records.
+
+Once a platform describes a firmware-first provider, both ACPI GHES and the
+DeviceTree driver reuse the same code paths: CPER sections are iterated with
+``estatus_for_each_section()``, logged through ``cper_estatus_print()``, and
+handed to the RAS notifier chains that trigger memory-offline, PCIe AER, or
+vendor-specific handlers. This keeps the behaviour consistent regardless of
+whether the error source is described via ACPI tables or DeviceTree.
+
 EDAC - Error Detection And Correction
 *************************************
 
-- 
2.43.0


