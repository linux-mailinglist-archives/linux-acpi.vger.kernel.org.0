Return-Path: <linux-acpi+bounces-19622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D5CC7650
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0685730B0930
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74833D4E1;
	Wed, 17 Dec 2025 11:31:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6C336EDE;
	Wed, 17 Dec 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971098; cv=none; b=hj75EPEqpBF+8nA7MiqpHcwBoplOJPwpY53WpQ5w8SD07kETE4BrZ/DG5b5/h30TsXVxBCJqh1J2sxgYaFhqol7a+G+yhw6+NuKAE91omAflE8+9RgQ3hV/mhJUhBZpGiO0gGENrtkmdsGiQjkY3ncwb1n7zYTEg/HEBXX6ADeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971098; c=relaxed/simple;
	bh=HJ2p5Js025v3wO/P5mbEbfuHyxf4Zo27KMR/lqKFSJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOw/Bw7w00Ihh9mPJv6nLqUjzd/3hcaIl1007s2+g/3JT9zBueBlEUZm1hRVHoFRRfQFIsMp4MHHGDpf1PR9yIgNBI7XcCAOBU5dV6zEXjuPnSk+hX6ajvuuTtuvlJML0fD5phKusf8lqWsPetqyjVi/b6rx/7cQSQZXEpZwCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 446E51691;
	Wed, 17 Dec 2025 03:31:25 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0C73F73B;
	Wed, 17 Dec 2025 03:31:30 -0800 (PST)
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
Subject: [PATCH 10/12] dt-bindings: ras: document estatus provider
Date: Wed, 17 Dec 2025 11:28:43 +0000
Message-ID: <20251217112845.1814119-11-ahmed.tiba@arm.com>
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

Add a binding for firmware-first CPER providers described via
DeviceTree. It covers the shared status block, optional acknowledgment
registers, interrupt versus polling modes and the SEA notification
flag so non-ACPI platforms can describe their error sources.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 .../devicetree/bindings/ras/arm,ras-ffh.yaml  | 95 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml

diff --git a/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml b/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
new file mode 100644
index 000000000000..0d2acbf8e8a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ras/arm,ras-ffh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Firmware-First Handler (FFH) CPER provider
+
+maintainers:
+  - Ahmed Tiba <ahmed.tiba@arm.com>
+
+description: |
+  Some Arm platforms describe a firmware-first error handler that exposes a
+  Common Platform Error Record (CPER) buffer directly via DeviceTree. The OS
+  maps the buffer to consume the error records, and firmware signals that a new
+  record is ready either by asserting an interrupt or by relying on a periodic
+  poll. This binding describes the buffer and the associated notification
+  signal. If firmware delivers the error via Synchronous External Abort (SEA),
+  the optional sea-notify flag marks the source accordingly.
+
+properties:
+  compatible:
+    const: arm,ras-ffh
+
+  reg:
+    minItems: 1
+    items:
+      - description: CPER status block exposed by firmware
+      - description:
+          Optional 32- or 64-bit acknowledgment register. Firmware watches this
+          register and expects bit 0 to be written to 1 once the OS consumes the
+          status buffer so it can reuse the record.
+
+  reg-names:
+    items:
+      - const: status
+      - const: ack
+
+  interrupts:
+    maxItems: 1
+    description:
+      Optional interrupt used to signal that a new status record is ready. If
+      omitted, the OS relies on the polling interval property.
+
+  poll-interval:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    description:
+      Optional polling interval, in milliseconds, for platforms that cannot
+      route an interrupt.
+
+  arm,sea-notify:
+    type: boolean
+    description:
+      Set if the platform delivers these errors as Synchronous External Aborts.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        poll-interval: false
+    then:
+      required:
+        - interrupts
+  - if:
+      properties:
+        interrupts: false
+    then:
+      required:
+        - poll-interval
+  - if:
+      properties:
+        reg:
+          minItems: 2
+    then:
+      required:
+        - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ras-ffh@fe800000 {
+        compatible = "arm,ras-ffh";
+        reg = <0xfe800000 0x1000>,
+              <0xfe810000 0x4>;
+        reg-names = "status", "ack";
+        interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 67d79d4e612d..6b2ef2ddc0c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21760,6 +21760,7 @@ F:	drivers/rapidio/
 RAS ERROR STATUS
 M:	Ahmed Tiba <ahmed.tiba@arm.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
 F:	drivers/firmware/efi/estatus.c
 F:	include/linux/estatus.h
 
-- 
2.43.0


