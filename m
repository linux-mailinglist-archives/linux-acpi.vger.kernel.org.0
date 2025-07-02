Return-Path: <linux-acpi+bounces-14903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18142AF0A61
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4273C1C01CC9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DC20D4FC;
	Wed,  2 Jul 2025 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Lsr5t3D4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F061F4621
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433332; cv=none; b=UxA3OzYWZUcMjh1FWuJtuGesV4Ap8pPtUkir57nTWqAWBvl00bW/JZsIyETg6vh0Bof07tLqgTSx8a4Cp22QCXyN6eXBytXCMyf+z1cYkYEdWDQyrZ59PveMbIFnWpQLLLWJJnkeRYjZFOIvJ0Mt0JQhB7fiTgtF664wVQ8jOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433332; c=relaxed/simple;
	bh=sbelvMc++opfxCsxTvRuuhoDW5jErxOHLIiEYhi1zkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3VnJHDJN05XNlBgy1rHqdng2ZUY0rI/+jKhfzr94RGhNu5N7vkFJdTiCOS2Hq5m6K3kIA35KBsX0YemI1WRHj45aPXm/vUIq54xhWI2tDaKC5O1llih8JWlYRNl8j3oWiHsrcGKC1LP+CGN0IAH/+X7MEzyos8V+0U0GylDRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Lsr5t3D4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234c5b57557so39440905ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433330; x=1752038130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=Lsr5t3D40qQ1yumxUnR/nGd+nCXQCKgcMoaHusA5OcNH3o/PkOvqUZstalX15HZTtu
         ix/iUpfQopoHa/TfS3Qp6r3sefcs3iX6y5pmEs+tSLdc34dL/QkLeTpBDQf/qRbXietH
         GNsGVXNOld1YY43bOAyDmEt0j4vkwePFK5bWVzwFxdmWY+EFTsvCxYD9mC3xqRcHr1sb
         JoAMiM0CiEysMtY+13R4glVhln+Sa3z6tX4NNpmkFW2kivTV463OeKGo/92M3pzkPuKM
         IyURgHmHQuvyER9eYs/Szzv4kb4wv63bSYTOOzbsSEMzH04KSagOxpiF3B/jOMHxl74z
         M3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433330; x=1752038130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9cEkN+1nA6DRTpT1SF2rNqhyyXGV6gcs+oqiG40Gi8=;
        b=v2SsPDC25q6fcK5FEaTO8ztm6uy3XgBLxlXU3aihMbTTtKVfFjhtpA9dahgq1EjqPr
         DEeyGUweRXziE6SL7AjlN4wSEhEnXz0NFJDeO09ZfgYCAXhOsFkWOXCuDW2x4SyviGkx
         MpThDKJFSgdoXkemxK5KdTVPwxn5nq7VPHXSYfBeWY8WlXWGv6AC/qqGcglsoTC6grps
         KiUU3VdaDnQNL03siHV05yMFlnkKhwJIN9x7+gslNgaA+3iLbwH+ryOLwfdJaeZj5w79
         MK8Tk3VEsHZ6larRxsflecytPbuvO+aNSXs4XXEAU2NzLGhC4sPy4nzkVFtJdK0ZX8q4
         3gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMLvCudzCBspSsIgFWVPVo8DrXEWbPKaHU3adNKRbN0hzS9jZX6WdTCooC/gI4G1LZhj0Fu3trF8x2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6f0d9jILOBiKSgnTXLiWcIPq9Ladj+IbJTKvJAbU7uFDpzF7x
	qbno/qK3pSYH/3lqDJrp6bUNzbPYs8vl8uuemHsGB1PvrMs/IsAgOolmhC3k4BWxxgc=
X-Gm-Gg: ASbGnctACipso14c2oadhlUgpupxXtTjq6ZCsoExgfW05Fl/O8zGpQ9u2ok9ADBgv5q
	kceeCFBeAlGSNw1Ef7vPc8HhpO6aoKKm0cPsVDoxLZ/9ttWNZA0v7bwaaP0KzZuZoLGVdB9oVoW
	tqD0SShtvT8ALL8OPKZZIC4Hoaw+cTEma8uIo3XQ+Jw7iC58vqibwaTltvJdGxdLpFJv5Pm87vn
	aAy+2u0nLUzVlZOjgjMmYGMywb/m0xExOBGhTCcEGfZNGq7XJibshKVA+1gDWQSVNGDOq4wBVPm
	Bin8CxPpF0vfMqVzYbmvP0yK8vND8w3hIty25NDMDqI3h/kGcBH8xF4cXexS5YyZGkZLR54v1gL
	RVxQAOGFIwnRTXUuE
X-Google-Smtp-Source: AGHT+IFkSVDLCtizadO6/SefSREM+o/lLAXhKCmmv4wW4SQI87DpfrniV0LznmsSNzm//rR3xEBV7g==
X-Received: by 2002:a17:903:1983:b0:234:d7b2:2ab4 with SMTP id d9443c01a7336-23c6e4b9073mr19484855ad.17.1751433330503;
        Tue, 01 Jul 2025 22:15:30 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:15:30 -0700 (PDT)
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
Subject: [PATCH v7 11/24] dt-bindings: Add RPMI system MSI message proxy bindings
Date: Wed,  2 Jul 2025 10:43:32 +0530
Message-ID: <20250702051345.1460497-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702051345.1460497-1-apatel@ventanamicro.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
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


