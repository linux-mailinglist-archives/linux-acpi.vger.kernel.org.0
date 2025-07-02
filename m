Return-Path: <linux-acpi+bounces-14893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D76AF0A3C
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8827C3AA197
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4571F416C;
	Wed,  2 Jul 2025 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CUEbXs1w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FB1E9B3D
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433256; cv=none; b=GQS7wNWi2WdSYXhMomVQB4ug8MT0cgNrtMDVFB9BEy0Sw/PJWUyH37cPNC8JqG5qur+J5/3XqbslDbeBKPNJZwmizBzqPk96QOQ/f6Pd5xFMv0YbHPylzxEepL2dqSPhfqCW1xNQcGAfM+7M/8Ny5Den7eLgIZ7BQbdNPmHJbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433256; c=relaxed/simple;
	bh=B3l9G9xHfhvz8EaPHO3ldfTP94vcz4sc4fSmpOQNlnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwPrAhGRzbbj7na2n2Jlm8P/0atv+zYFluW9eUjrJe64CB6fUKz+UHmXHiz8TXN/AEhfmY+QN+ubox8pbenqPlyqbm6hXR9243RUUWpiQwA2VkXvSPNkbxLgUB9rz7hNdF/zCo5+q2rROpjBv4OV3s9pImfrWMgINR4kRIovDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CUEbXs1w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-237311f5a54so36406945ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433254; x=1752038054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziNNelNAtU8Lu0O2/2Qc6bW/trdK9/SPi3ZGrwyyiyE=;
        b=CUEbXs1wfPVpM5SlMDp6JSbwtfqmuKO5QY0gW/x9Q84ErxhUZ/j+nCSsTzoOJQ/7eC
         OKnxh7Xu4nVxy6C1CIr3farra+tXG7q5z9v3TuqH3pFAbv/ViQ6SuSbrCDkxTupcbbdX
         67/sXNCd3rNMUnMmRuqPaPKmlbwQ2TLuzmTI/b2fULZQ8uKFsDPNuc1ZjT1KQjMVc/ea
         sOEIfbei5e7wu3hzo4DWWqDP+qhQthRagePdeO2lFQ6iJzfEZXTSmwgwsTVhKN67Kkmx
         1g5FW+THzXQ9hDIS5t9P146cKmaivU5Mq5UYhgR6QU0/o6iS/RX3UvZGtZJhAGkuYZLL
         cOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433254; x=1752038054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziNNelNAtU8Lu0O2/2Qc6bW/trdK9/SPi3ZGrwyyiyE=;
        b=G+ZkLPhWHRcPYOk2Gm6TnQzjF29k/qLPE5BJBAR1CXWPWLdC8i6WMYrGE6pdXSdps6
         tF7wKDD4bEDwYlfffeRYk+74ab3ldhBo9w/tUZlJCMHKdzvcTe8k946LRbR7vg+D+Qaf
         Js8AEVGvCxziAvA7zLmDvPboUtsQtYlxD4qJ03/BI9T92yAeTgSVzkJg6MV4KapmjwcS
         5pLQXKwAVRr+hSvUT2jwLgs5dvnB2KfrEBur/bFOWOYMB1TLt7aslXX0TH1zwdSGHxVk
         Sy7Fh5mFelOfS/oItDrimivb9DG4+W5rJQETV87p8vDL1nK859HzI336BK5/R05J+xRV
         Omlg==
X-Forwarded-Encrypted: i=1; AJvYcCWHxprshA/X11h2dQolgvYeFqwmkKYB13mNsWOk7X6QkolKK/Kd8pZxvD3SL58uvgQp12cs776n6wDj@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlY80R3/4p8fp5SUTPvDRpt/aMOsIL7adZXQuEcTeutleej2X
	oJp3eAJRepFj6XjwshFCpqkZhuFWwKT11tzImmbD5/jhkr6oRFji0lQorDXdDN2cX8A=
X-Gm-Gg: ASbGncsPlJr/db7n07k7Oy6SGeLmU4903YPokZwLhjEGEzLMX0X371vfLHSd0sbFN5m
	fWA3+MWNlnelxYLVGiOI5EWdZhMNkT3aPUSj5rQ9xe934VM2gCOY8adh8bLp7MFflxb1xsFleR4
	9uuwQKgm3wf5Ayt4sUfMxq4U+CK9JR9RfKn8YsnbPKEPWApmKaHYkg/nd1Ud2XZqaRODqF7iCEe
	DbDlBfAXXarZGP8fyr+A+LBinvLvqnsmE6wxnAz27HouwY92/MxCUkfV5V01jYsR6SRIyh4Dgxr
	Re0Lql0NzkmsdMuSseOIgxUPTfIfIsRAh9s43ny3fwXGwZ8Pm/IbAX4Po26lciRIHz/hZhAzh4x
	77iXbl62ANbOS288Z
X-Google-Smtp-Source: AGHT+IH1zQLMeLZCjz953CYwcFQdb4n2Jpuxqc1/A4tWexX1v4V8AZfDafl9hgJbDhtKkT2fEqefSw==
X-Received: by 2002:a17:903:1aee:b0:21f:4649:fd49 with SMTP id d9443c01a7336-23c6e5e0440mr23121485ad.49.1751433254208;
        Tue, 01 Jul 2025 22:14:14 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:14:13 -0700 (PDT)
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
Subject: [PATCH v7 01/24] dt-bindings: mailbox: Add bindings for RPMI shared memory transport
Date: Wed,  2 Jul 2025 10:43:22 +0530
Message-ID: <20250702051345.1460497-2-apatel@ventanamicro.com>
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


