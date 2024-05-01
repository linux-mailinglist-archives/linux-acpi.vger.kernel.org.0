Return-Path: <linux-acpi+bounces-5573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BB38B89E7
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 14:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21F2280E24
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622F130487;
	Wed,  1 May 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oSiHZ+2D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1D12FF9E
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566017; cv=none; b=A+WhIDHD4X3m25CWsvmdJSJnGCS4+8UMHPLnALUTxQsu+MEfYJciSadFAHl1/aXGGOxzmhV3VacgwwT/Ao/pIB3o9D6Ew64zziQoSFgeo+gnGnAoygYGQBkIwCsDEi/DKcoHi7aBCfsk1eWLf7wBUOWFSuRTkR/uV9P//pHt7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566017; c=relaxed/simple;
	bh=VlgCsjgHFwA68EYgPCGJqFoun4py/yY/7/kh2NDKDJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZY3EW1/gly5aBRETyUPtj6xeSKnwEmQTv3nCmTPrsU/R+4pQ2BBhqJ8Bida8NSuTVg9a9MKJ4tRSPo2BkEjaPrAyzLI8w31E55LdRVOCe/S4dIauxcmbjuoxodAEaqnzvKnKrSoYes8A0GJ2m0cRhUsAgg1SHB2665DXrjJ8Rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oSiHZ+2D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so33078595ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714566016; x=1715170816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA6fALA+ztvPArpqc5Jdn/FWi0fZsP181uxTjKG28r0=;
        b=oSiHZ+2D/vk3bc2Nx/NetSxMuHATrwxm7wpYyTRVF80sSy3QRXEWcEjxmV47MwlqCI
         DS6qxn975Eu6Vc7lXDz+1+Gu2jAzKcOT/Dc7d1nsdRxIbgrhsQZm4Mn5Y9G7/FP7haKy
         XsgQcjdboh+wsApzfuwdRpJteY8zsI+LS8IdTF93LDNlPGyDPdAU/uMxN/eXjW6LU06l
         XNPfzruUqN+lS3I02sfI0z/cg5uB1UEDWIhZPm34DnMPuzEo27yaNAfISi8d/2KpL1MR
         KtKImzTRbWzOSAC1icPR0hVzabEnjEqFPFktxed0tW9wQG8mUUc0YWUCuGiJO2Uamd3N
         zfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714566016; x=1715170816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA6fALA+ztvPArpqc5Jdn/FWi0fZsP181uxTjKG28r0=;
        b=TMwqEmKCDj2Z6zp4yijziFYUUIf6+CWZdDIXfx7j8WOoQgCjYMTlxL4tLTZmaHwuOV
         Yy61BCFXX1KVoL+52gSt7JwcJE2GpECVbmVXo6kVPqMb2qLGvh1bINruoIvlfoVPYA4r
         E3ztyaw03Wu4YnVbTT0e/mq8ITfA1KaK2b2gmEJzl0BWTn6sbfhnSCRfLbGEVTfr7wUR
         HsedV4IV780SIL8yt/kwxlyjb11g1wvII7JJYHpdpv9zlecRJikZ8k2RGUureE9dXxsL
         8IvWAxxdD3zdHGbJ3tRiGKBlvi8QvmSsvyk/lJzNCp8jrgyN5lbrucIYnXcxkmUz4zMz
         moFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1mHjfCB9NOgfaZe4SJ1slZp9wUVAsLQ3xGwGjxLqMtjdSQEd6bNNq6dMB/riVXztU6EIUWXo6NaQ18LbaWBy9AtKUai5g+AjUcA==
X-Gm-Message-State: AOJu0YxCVuuOwFooLSBzL+ivRgFIE3DaHaoJip36LYwelrZB1QqFgR3l
	8fHyyPkKXLjUY+HG+2tkp/fKnHWgWzFmH6joNbV4+3BxeYLx5NDZyjUdaUA5Oos=
X-Google-Smtp-Source: AGHT+IHYfyPObdgft5ubD0a+EdF/ZUFESa543BOMp550uRgpGcGY3JeWyQR+nmnrayByMoL+UjNZmA==
X-Received: by 2002:a17:902:ed01:b0:1eb:494f:dc66 with SMTP id b1-20020a170902ed0100b001eb494fdc66mr2209312pld.23.1714566015601;
        Wed, 01 May 2024 05:20:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:20:15 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Date: Wed,  1 May 2024 17:47:42 +0530
Message-Id: <20240501121742.1215792-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V has non-PNP generic 16550A compatible UART which needs to be
enumerated as ACPI platform device. Add driver support for such devices
similar to 8250_of.

The driver is enabled when the CONFIG_SERIAL_ACPI_PLATFORM option is
enabled. Enable this option for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/configs/defconfig        |  1 +
 drivers/tty/serial/8250/8250_acpi.c | 96 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  8 +++
 drivers/tty/serial/8250/Makefile    |  1 +
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_acpi.c

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 3cae018f9315..bea8241f52eb 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -150,6 +150,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_ACPI_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
diff --git a/drivers/tty/serial/8250/8250_acpi.c b/drivers/tty/serial/8250/8250_acpi.c
new file mode 100644
index 000000000000..3682443bb69c
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_acpi.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Serial Port driver for ACPI platform devices
+ *
+ * This driver is for generic 16550 compatible UART enumerated via ACPI
+ * platform bus instead of PNP bus like PNP0501. This is not a full
+ * driver but mostly provides the ACPI wrapper and uses generic
+ * 8250 framework for rest of the functionality.
+ */
+
+#include <linux/acpi.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
+
+#include "8250.h"
+
+struct acpi_serial_info {
+	int	line;
+};
+
+static int acpi_platform_serial_probe(struct platform_device *pdev)
+{
+	struct acpi_serial_info *data;
+	struct uart_8250_port port8250;
+	struct device *dev = &pdev->dev;
+	struct resource *regs;
+
+	int ret, irq;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(dev, "no registers defined\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	memset(&port8250, 0, sizeof(port8250));
+
+	spin_lock_init(&port8250.port.lock);
+
+	port8250.port.mapbase           = regs->start;
+	port8250.port.irq               = irq;
+	port8250.port.type              = PORT_16550A;
+	port8250.port.flags             = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
+					  UPF_IOREMAP | UPF_FIXED_TYPE;
+	port8250.port.dev               = dev;
+	port8250.port.mapsize           = resource_size(regs);
+	port8250.port.iotype            = UPIO_MEM;
+	port8250.port.irqflags          = IRQF_SHARED;
+
+	port8250.port.membase = devm_ioremap(dev, port8250.port.mapbase, port8250.port.mapsize);
+	if (!port8250.port.membase)
+		return -ENOMEM;
+
+	ret = uart_read_and_validate_port_properties(&port8250.port);
+	if (ret)
+		return -EINVAL;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->line = serial8250_register_8250_port(&port8250);
+	if (data->line < 0)
+		return data->line;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static void acpi_platform_serial_remove(struct platform_device *pdev)
+{
+	struct acpi_serial_info *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+}
+
+static const struct acpi_device_id acpi_platform_serial_table[] = {
+	{ "RSCV0003", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
+
+static struct platform_driver acpi_platform_serial_driver = {
+	.driver = {
+		.name			= "acpi_serial",
+		.acpi_match_table	= ACPI_PTR(acpi_platform_serial_table),
+	},
+	.probe			= acpi_platform_serial_probe,
+	.remove_new		= acpi_platform_serial_remove,
+};
+
+builtin_platform_driver(acpi_platform_serial_driver);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 47ff50763c04..fbfe4d3501b1 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -576,3 +576,11 @@ config SERIAL_OF_PLATFORM
 	  are probed through devicetree, including Open Firmware based
 	  PowerPC systems and embedded systems on architectures using the
 	  flattened device tree format.
+
+config SERIAL_ACPI_PLATFORM
+	tristate "ACPI platform bus based probing for 8250 ports"
+	depends on SERIAL_8250 && ACPI
+	default n
+	help
+	  This option is used for generic 8250 compatible serial ports
+	  that are enumerated through ACPI platform bus.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index ea2e81f58eac..8c0ef357fc4e 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 
 obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
+obj-$(CONFIG_SERIAL_ACPI_PLATFORM)	+= 8250_acpi.o
 obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
-- 
2.40.1


