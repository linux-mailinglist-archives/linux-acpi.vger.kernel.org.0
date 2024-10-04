Return-Path: <linux-acpi+bounces-8562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8C9910D4
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 22:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277E61F2293F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843A13957B;
	Fri,  4 Oct 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTMWDLkY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B02231CAE;
	Fri,  4 Oct 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074933; cv=none; b=Z+UWJom4UmcXi2MZPUxkKWz3/7GGivVjR0dOUp+H2e09wcXOuO/UeeViivT+Y/Js2wKYd+OvAj7iWX2QLMA9Fij+lmUEp3BJeOxsLjvOS5jvgdmzjg5RpkFbiy9xFuDJiGb37f21YnnnYEm199UTF4IGtpSXlvRFHdd6lacBh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074933; c=relaxed/simple;
	bh=JjcTsSRlL+TG+XePePBv0xoIjY+Mi6GJKME0LYVDJLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=coFm6RqdW/uV0nqnRJYvrnv5NgGL3eU5nPwoXaVWk7NGRynUzl3fhTprLiZcR8QcJaQxHRpR33RuKZFu2ng1cbjpGtgjvWjTCthXuybees9SgIxm7ubbSt0riIiv7EQ5pXhsZGGatuRpakGbwZ9ozFbCnNvD1x4ne2EXurOjmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTMWDLkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFBC4CEC6;
	Fri,  4 Oct 2024 20:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728074932;
	bh=JjcTsSRlL+TG+XePePBv0xoIjY+Mi6GJKME0LYVDJLg=;
	h=From:To:Cc:Subject:Date:From;
	b=qTMWDLkYpA0U+bchqE8cI/aYWco4M8EkyA2F2TSB6lLhXdIggrEiP41X4W9OYnca0
	 AGp1j+aBYgshU2VJ6LdBXu8pEFtJ33xk+5xP1VXWTu5U9ZMtSo0X2MMaf7tjaKTOhn
	 wZZNu45GcEVzvqSPP/sIQENukAVs9TjcgcYOSZoBQq/Xg5toNtvoqS0iWCNDyZ652r
	 XM2povD2pF56r9+DPz3qniLcD45Aq/HvgpZJl/LMkELtb7yrY0/XmoAh1bJZQG5Vbc
	 4BVZMobMKiqnMKHm3ltxIQR3duOGXIMWZ/Dz8F8vV1JDPEZbasgV044Vnp6YPQZRU6
	 yP5aqKj5UEQ0w==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] acpi: allow building without CONFIG_HAS_IOPORT
Date: Fri,  4 Oct 2024 20:47:35 +0000
Message-Id: <20241004204845.970951-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_HAS_IOPORT will soon become optional and cause a build time
failure when it is disabled but a driver calls inb()/outb(). At the
moment, all architectures that can support ACPI have port I/O, but
this is not necessarily the case in the future. The result is
a set of errors like:

drivers/acpi/osl.c: In function 'acpi_os_read_port':
include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT

In function 'acpi_ec_read_status',
    inlined from 'advance_transaction' at drivers/acpi/ec.c:665:11:
include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT

Since the embedded controller can only exist when port I/O is
active, it makes sense to disable that code on targets that don't
have it. The same is true for anything using acpi_os_read_port()
and similar functions.

Add compile-time conditionals around all of those and their callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Should this be split up into smaller patches?
---
 drivers/acpi/Kconfig             | 1 +
 drivers/acpi/Makefile            | 2 +-
 drivers/acpi/acpica/Makefile     | 4 +++-
 drivers/acpi/acpica/evhandler.c  | 3 ++-
 drivers/acpi/acpica/exregion.c   | 2 ++
 drivers/acpi/acpica/hwregs.c     | 6 ++++--
 drivers/acpi/acpica/hwxface.c    | 3 ++-
 drivers/acpi/apei/apei-base.c    | 4 ++++
 drivers/acpi/bus.c               | 9 ++++++---
 drivers/acpi/cppc_acpi.c         | 6 ++++--
 drivers/acpi/osl.c               | 2 ++
 drivers/acpi/processor_perflib.c | 3 ++-
 drivers/acpi/scan.c              | 3 ++-
 13 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b8924077163b..5ec58c4e0332 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -134,6 +134,7 @@ config ACPI_REV_OVERRIDE_POSSIBLE
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
+	depends on HAS_IOPORT
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 61ca4afe83dc..132357815324 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,7 +41,7 @@ acpi-y				+= resource.o
 acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
 acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
-acpi-y				+= ec.o
+acpi-$(CONFIG_HAS_IOPORT)	+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 8d18af396de9..9ba5e71348cb 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -80,10 +80,12 @@ acpi-y +=		\
 	hwgpe.o		\
 	hwregs.o	\
 	hwsleep.o	\
-	hwvalid.o	\
 	hwxface.o	\
 	hwxfsleep.o
 
+acpi-$(CONFIG_HAS_IOPORT) += \
+	hwvalid.o
+
 acpi-$(CONFIG_PCI) += hwpci.o
 acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 1c8cb6d924df..20f61936ff9b 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -358,12 +358,13 @@ acpi_ev_install_space_handler(struct acpi_namespace_node *node,
 			handler = acpi_ex_system_memory_space_handler;
 			setup = acpi_ev_system_memory_region_setup;
 			break;
-
+#ifdef CONFIG_HAS_IOPORT
 		case ACPI_ADR_SPACE_SYSTEM_IO:
 
 			handler = acpi_ex_system_io_space_handler;
 			setup = acpi_ev_io_space_region_setup;
 			break;
+#endif
 #ifdef ACPI_PCI_CONFIGURED
 		case ACPI_ADR_SPACE_PCI_CONFIG:
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index c49b9f8de723..8f96828614ed 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -261,6 +261,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	return_ACPI_STATUS(status);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_system_io_space_handler
@@ -319,6 +320,7 @@ acpi_ex_system_io_space_handler(u32 function,
 
 	return_ACPI_STATUS(status);
 }
+#endif
 
 #ifdef ACPI_PCI_CONFIGURED
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index f62d5d024205..845d88a01272 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -239,7 +239,8 @@ acpi_status acpi_hw_read(u64 *value, struct acpi_generic_address *reg)
 							ACPI_DIV_8
 							(access_width),
 							&value64, access_width);
-			} else {	/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
+			} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
+				/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
 
 				status = acpi_hw_read_port((acpi_io_address)
 							   address +
@@ -336,7 +337,8 @@ acpi_status acpi_hw_write(u64 value, struct acpi_generic_address *reg)
 							 ACPI_DIV_8
 							 (access_width),
 							 value64, access_width);
-			} else {	/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
+			} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
+				/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
 
 				status = acpi_hw_write_port((acpi_io_address)
 							    address +
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index c31f803995c6..022e706e10a1 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -45,7 +45,8 @@ acpi_status acpi_reset(void)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	if (reset_reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reset_reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		/*
 		 * For I/O space, write directly to the OSL. This bypasses the port
 		 * validation mechanism, which may block a valid write to the reset
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7c26872f4ce..19357f951bae 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -661,12 +661,14 @@ int apei_read(u64 *val, struct acpi_generic_address *reg)
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
+#ifdef CONFIG_HAS_IOPORT
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		status = acpi_os_read_port(address, (u32 *)val,
 					   access_bit_width);
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -694,11 +696,13 @@ int apei_write(u64 val, struct acpi_generic_address *reg)
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
+#ifdef CONFIG_HAS_IOPORT
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		status = acpi_os_write_port(address, val, access_bit_width);
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
+#endif
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 16917dc3ad60..535d6a72ce1b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1356,7 +1356,8 @@ static int __init acpi_bus_init(void)
 	 * Do that before calling acpi_initialize_objects() which may trigger EC
 	 * address space accesses.
 	 */
-	acpi_ec_ecdt_probe();
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_ecdt_probe();
 
 	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
@@ -1391,7 +1392,8 @@ static int __init acpi_bus_init(void)
 	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
 	 * is necessary to enable it as early as possible.
 	 */
-	acpi_ec_dsdt_probe();
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_dsdt_probe();
 
 	pr_info("Interpreter enabled\n");
 
@@ -1464,7 +1466,8 @@ static int __init acpi_init(void)
 	acpi_arm_init();
 	acpi_riscv_init();
 	acpi_scan_init();
-	acpi_ec_init();
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 5b06e236aabe..cb545cdfdc19 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1017,7 +1017,8 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 	size = GET_BIT_WIDTH(reg);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		u32 val_u32;
 		acpi_status status;
 
@@ -1090,7 +1091,8 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 
 	size = GET_BIT_WIDTH(reg);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 78a81969d90e..28eb5ff123a9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -638,6 +638,7 @@ u64 acpi_os_get_timer(void)
 		(ACPI_100NSEC_PER_SEC / HZ);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 width)
 {
 	u32 dummy;
@@ -680,6 +681,7 @@ acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 }
 
 EXPORT_SYMBOL(acpi_os_write_port);
+#endif
 
 int acpi_os_read_iomem(void __iomem *virt_addr, u64 *value, u32 width)
 {
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 4265814c74f8..8be453d89ef8 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -455,7 +455,8 @@ int acpi_processor_pstate_control(void)
 {
 	acpi_status status;
 
-	if (!acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT) ||
+	    !acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
 		return 0;
 
 	pr_debug("Writing pstate_control [0x%x] to smi_command [0x%x]\n",
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7ecc401fb97f..9d5e6dd542bf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2293,7 +2293,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (device->handler)
 		goto ok;
 
-	acpi_ec_register_opregions(device);
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		acpi_ec_register_opregions(device);
 
 	if (!device->flags.initialized) {
 		device->flags.power_manageable =
-- 
2.39.2


