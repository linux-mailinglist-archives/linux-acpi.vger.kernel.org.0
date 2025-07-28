Return-Path: <linux-acpi+bounces-15374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1BB137DE
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7F0189ACB9
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85125A2AB;
	Mon, 28 Jul 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QNYcZ3wP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D325744F
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695768; cv=none; b=U5i3rJaIRLUmEaexTjUrdqT3qbQS0RAvk1yY8Cm6vucawZAxPFzV6LufJpQ0cwh1578C0F0d9JTFsuwHWVV9Hp1nKW8iC9EbuBZuB0rcP0Vh8XenHMp5mZlf0eiGlp/SnTy8P5UaRj45fSysHn2thtnQqoSAGv01hV2I2Es1wP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695768; c=relaxed/simple;
	bh=sbelvMc++opfxCsxTvRuuhoDW5jErxOHLIiEYhi1zkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umy0NwYRAaA2vo6ntEnBLfHZm8AiGyN1Fg3F25WVB71eG1mYkpUblV43EHuxyAcyVqlSHuNhfKHK5Ud3Yb0JQwfvDeML4LGDn60yAEEvUsl0D0BpsVVXXnU8zmCYVp3eTl/EtF8qpmm25H6QNtydXYFPgPWQFyDncF3pRbtVy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QNYcZ3wP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso4163832a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695767; x=1754300567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=QNYcZ3wPDDDGy7LGkXhiNI18qfdtLYwEviHqt9PtlmAAg5V7N/LdvZU8fgMW78IPv5
         4aJjQo7w8nzSvMpoe4ylFIVxfpdzDbq5er8Ca+HuysGqN5E7pf+//0ez6065cPkTliow
         jLK//ifHEeY8p6eqLIoU+YQ1y5H42Wz7Dk09XE/VeN0qfTCSR8FuzZyPXjZOfjfwNM09
         CSTtWbq91HaAETn+HmfbSWLH0FdEw5knYYCdf0xlLz/e/m1382aaVXC1A/vjkte99Fgo
         OZ2vHBxDJ3JaGNbggRvf+cWwbKQLzrJJPcsvd7H6Yhzwqv3wyec/VuIFk+BgMRKgxwSb
         vsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695767; x=1754300567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=RLVv9dKKCp94WXG7Vz+s5V3O1Owpo3S+Kpxr6ShlnI4BnxG/lOLQcvQ8HavUPXQTKh
         2DbQ1wEms1yA/hEyrGSvs4/vUMXoOHQEB//B6kvLER3XIb4vS8wbJkj7p7RS+IapDt5t
         j8A+lIPH8qc2IjjNpxNI0he4q3cHf+RWYWB4Kb0sX3u61l7rIvi/hFGD4BdeYUzsUlYh
         H12ZDqxtzAjs8HFuFv5tote56FM//fj2UK5J8azohAa2pGsgghT5UKJ13GvGhRsFVDXa
         Z+aYWzwioZ2ySAidDufNIjVihk/fNfBZha9sH00chucJ0QpIrolspqCYS7PRjqbDMNuC
         NyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3xXGpCk0ily4GAvcOLZP/cW6DZjSSJujNf7MJ0pMcT0Z5oidBoRE1K+JOA8xbA6ax2/Rt8m6nhG7q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VcTho6ihxRXB1YpHbwpj3YgeCtSsLLbLSWpzwvHpAMA+V6AL
	WUTdTArXyH1Hr/tQ5q4NGUnwBoPK0YpzQ+KbPqBFFtTD0XqXHDSz6DqLUrtsGo71N3k=
X-Gm-Gg: ASbGncuVCyQiVuRW9bwLBKNz8DM5HbaL8sagQysjTbO2fA+PuHSosB2c920qw1WoMJt
	FsPsBUmOVrUoFhnMaOBLm/BnRma3FNGLmhMQH66puAjrtYx3MbPhPnDp9gN8il3rzuuAa55A2/r
	e7jQ4QFRIUS2jj8BPzSrUmxY/gpa2vpeufhIbRS/E0DeLoNwtxeqdF4zTs2oMo5JBDzwjYbLMIX
	cMyttMtJ0YDKXYjMWARI+WKkh/ojQLXxQvWlCsKgMmImVeiefyqunVEdphmzEx8UGksgV/hwUW2
	6AmRz3xo3rykfk8Fy/eUK9hYBYm5Iby71RCq/4/kYd1QT9B2fXQtRT/Bg/5nlV2X0FLDG9salml
	+UGTTG6ZroZQH738l4/RIeqT7YmIntGwmq0EBTQjA0mb6Sf+oFkPocDo9Ytp+Kh6Kzsstmz8=
X-Google-Smtp-Source: AGHT+IGcRASmkNddGc4f04TprnWEk/VB91d1zyko2zPkLaF073cuPivETe+66fbsndZxOaOB4DsHkA==
X-Received: by 2002:a17:90b:3ecb:b0:31e:e066:c81c with SMTP id 98e67ed59e1d1-31ee066d220mr5005093a91.6.1753695766325;
        Mon, 28 Jul 2025 02:42:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:42:45 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 11/24] dt-bindings: Add RPMI system MSI message proxy bindings
Date: Mon, 28 Jul 2025 15:10:19 +0530
Message-ID: <20250728094032.63545-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the RPMI system MSI service group
based message proxy implemented by the SBI implementation (machine
mode firmware or hypervisor).

The RPMI system MSI service group is defined by the RISC-V
platform management interface (RPMI) specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../riscv,rpmi-mpxy-system-msi.yaml           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
new file mode 100644
index 000000000000..1991f5c7446a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI system MSI service group based message proxy
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines system MSI service group which
+  allow application processors to receive MSIs upon system events
+  such as P2A doorbell, graceful shutdown/reboot request, CPU hotplug
+  event, memory hotplug event, etc from the platform microcontroller.
+  The SBI implementation (machine mode firmware or hypervisor) can
+  implement an SBI MPXY channel to allow RPMI system MSI service
+  group access to the supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-system-msi
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+        compatible = "riscv,rpmi-mpxy-system-msi";
+        mboxes = <&rpmi_shmem_mbox 0x2>;
+        riscv,sbi-mpxy-channel-id = <0x2000>;
+    };
+...
-- 
2.43.0


