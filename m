Return-Path: <linux-acpi+bounces-14991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED40AF8871
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE1B1894B08
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACC2741AD;
	Fri,  4 Jul 2025 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QUrn5pQj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34CD271A9A
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612671; cv=none; b=glJRUow63PLNFNQZ7BUJwVyK3XS4l8gdyzk+zxLtocjFpSgrTf9SomnJvln7Cf/aqDUPz2yqtOLtpm+QYMLqaMD6GRaHxmGNw9irREtoHbkSrBospoTcbW1vOxx5ctOjPZw8R3VHfHz/Kk4qW3XnUVbAXlUJ2Z+kzB+8g6VwWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612671; c=relaxed/simple;
	bh=B3l9G9xHfhvz8EaPHO3ldfTP94vcz4sc4fSmpOQNlnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw2KZn8AS9dQmjRiNWh3IyqFZzbkcodtMNaByHhuIm3lgbIEyN+iDooXfZxTD/oggRTq1F98F6phkuVmFr0zWhY1wd8JBgfCRx182f6GHZ9tHcVA+/4YFW2rNyUHRIXiZjfmWWf9YFaKdLF3M1bhgf0H7+0WVg3rWsmtTXrioFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QUrn5pQj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso710066a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612669; x=1752217469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziNNelNAtU8Lu0O2/2Qc6bW/trdK9/SPi3ZGrwyyiyE=;
        b=QUrn5pQjvPETMKI/90S82gies/GiVDFGuuxTkUPPzYyAgKX4uy/XHiA9DVRCnNnwJB
         NHtl9yENiCIRkzGb7QQHWObhhKGeCq3l7C9hlLFXjWHe1etKgTn2C6WeN+uuXNtVuduv
         ltT3EnCMh9exHHC3SjqWZR/djUNyls57KKxNgxW9MxdZyn/TdUBO4Z8AIauuz3aQI+U9
         2zSprzyZsmsOAVeDi9VmAqJOvUW17WUxhvgEBho9iUbxoYA9sDEh9ABSnTOFdxx3af2C
         lOBcd0OnsoQc69KFKRzl7tA8YGuxHZMHqK+pIFhmH0k4otCErPKUAv48bAfUHlqFtpM+
         KO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612669; x=1752217469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziNNelNAtU8Lu0O2/2Qc6bW/trdK9/SPi3ZGrwyyiyE=;
        b=iPvYJscP76gPKxN7HSjjyChvx49vkvcErGR88VkwDY6mTpNKevbGjNbQRT/sUSaCAK
         ZL8OZIrRzGQpyod6Wod2D9KHUVt+0q7vocXffif5Witd2ufKobU4ZBuIEVF+e0Bd21Jh
         UQJrYwd2O41iV1ZDPbbN3fZveYC3Tg9Nec7MrVyv+x1oYWxtByJeFu7BYlReu15bQojZ
         6OPw871PX26c5BA+z0SIeg1NUXiV3RgiVFGx+ZI7PldT4336TQ9NXHwNavgl7f77lA3+
         UhYWT16tL3ADcekywVcd3jQ6PC4nivrRwtN+lK8wOzyp1NSZ/l3JI3abB8+C1AX8zvKU
         OHxw==
X-Forwarded-Encrypted: i=1; AJvYcCUVEyYVAKvPjcRV1FQ64uOc11ITZAq+8OPiiaZdDNfOb3vHHEhrtE3TQ3ugC9JPp8RPV+wLxx3r4TFi@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAeiFNu8RIQl8FD/XcTvUw5xQylWxcy0/ayNLKWHH9iuqnZ+K
	XrIWvoZvIO6rLFDcafLDY3eAlAB8p1ZxLxdyDCUshkYNjNVOS/vWICT1i1zX6UtKaEs=
X-Gm-Gg: ASbGncsXt0h2HZjyTd8MKzpswrQdkkWJnFKQJbK7voJfa3JWP1he5p9Tpi89friQlbe
	T2fvvfCaMvPi06E/6w0n59GUQzuCZJAFZo+4G9RVQ66oR9ocoXWsF8cI6ZDWKwdeebhr9Qe0LAq
	FQfnBljjASrWU0p5uRhzuvXQ0Nt6xcXCc0beGeqUngQCxbFyf+Xan3IA9F6UeQy4bVAmDhMdZHN
	/nn3MG0SSfpHkgW+DJmNhvT+YysD7QYMkkqkJm20BEglAECWadpCtwwqIb77IzfrtT5J/WufPU2
	NMD57cH3Ad2YhA+e3uK4N49K4TeGsothTnLtZb5RE3yz5CISidX9/ABzoTZKXrGV0TuFXvppKmA
	lRzcynnQl+l7Do7gPwuclkcPG8g==
X-Google-Smtp-Source: AGHT+IHydhLYtgQsx/kgFwyDE9RvuLwoMStmH7TgFjyQTvlhgeI0SCRWQV+WfdwDV1yH8hV7OV8ZOQ==
X-Received: by 2002:a17:90b:5488:b0:313:bdbf:36c0 with SMTP id 98e67ed59e1d1-31aac31c367mr3216531a91.0.1751612668833;
        Fri, 04 Jul 2025 00:04:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:04:28 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 01/24] dt-bindings: mailbox: Add bindings for RPMI shared memory transport
Date: Fri,  4 Jul 2025 12:33:33 +0530
Message-ID: <20250704070356.1683992-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the common RISC-V Platform Management
Interface (RPMI) shared memory transport as a mailbox controller.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
new file mode 100644
index 000000000000..3aabc52a0c03
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/riscv,rpmi-shmem-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Platform Management Interface (RPMI) shared memory mailbox
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a common shared
+  memory based RPMI transport. This RPMI shared memory transport integrates as
+  mailbox controller in the SBI implementation or supervisor software whereas
+  each RPMI service group is mailbox client in the SBI implementation and
+  supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+properties:
+  compatible:
+    const: riscv,rpmi-shmem-mbox
+
+  reg:
+    minItems: 2
+    items:
+      - description: A2P request queue base address
+      - description: P2A acknowledgment queue base address
+      - description: P2A request queue base address
+      - description: A2P acknowledgment queue base address
+      - description: A2P doorbell address
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: a2p-req
+      - const: p2a-ack
+      - enum: [ p2a-req, a2p-doorbell ]
+      - const: a2p-ack
+      - const: a2p-doorbell
+
+  interrupts:
+    maxItems: 1
+    description:
+      The RPMI shared memory transport supports P2A doorbell as a wired
+      interrupt and this property specifies the interrupt source.
+
+  msi-parent:
+    description:
+      The RPMI shared memory transport supports P2A doorbell as a system MSI
+      and this property specifies the target MSI controller.
+
+  riscv,slot-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 64
+    description:
+      Power-of-2 RPMI slot size of the RPMI shared memory transport.
+
+  riscv,a2p-doorbell-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x1
+    description:
+      Value written to the 32-bit A2P doorbell register.
+
+  riscv,p2a-doorbell-sysmsi-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The RPMI shared memory transport supports P2A doorbell as a system MSI
+      and this property specifies system MSI index to be used for configuring
+      the P2A doorbell MSI.
+
+  "#mbox-cells":
+    const: 1
+    description:
+      The first cell specifies RPMI service group ID.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - riscv,slot-size
+  - "#mbox-cells"
+
+anyOf:
+  - required:
+      - interrupts
+  - required:
+      - msi-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    // Example 1 (RPMI shared memory with only 2 queues):
+    mailbox@10080000 {
+        compatible = "riscv,rpmi-shmem-mbox";
+        reg = <0x10080000 0x10000>,
+              <0x10090000 0x10000>;
+        reg-names = "a2p-req", "p2a-ack";
+        msi-parent = <&imsic_mlevel>;
+        riscv,slot-size = <64>;
+        #mbox-cells = <1>;
+    };
+  - |
+    // Example 2 (RPMI shared memory with only 4 queues):
+    mailbox@10001000 {
+        compatible = "riscv,rpmi-shmem-mbox";
+        reg = <0x10001000 0x800>,
+              <0x10001800 0x800>,
+              <0x10002000 0x800>,
+              <0x10002800 0x800>,
+              <0x10003000 0x4>;
+        reg-names = "a2p-req", "p2a-ack", "p2a-req", "a2p-ack", "a2p-doorbell";
+        msi-parent = <&imsic_mlevel>;
+        riscv,slot-size = <64>;
+        riscv,a2p-doorbell-value = <0x00008000>;
+        #mbox-cells = <1>;
+    };
-- 
2.43.0


