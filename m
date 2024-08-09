Return-Path: <linux-acpi+bounces-7453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E294C83A
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 03:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C3F1C21542
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 01:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D64D515;
	Fri,  9 Aug 2024 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/mmpGL6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5E17991;
	Fri,  9 Aug 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168128; cv=none; b=HxEG45Bc+QrzPVA/4WvMG/Vzi209KnXb1LohdebFADTF8q4D0P21Ewnu2sVSvnNEyqsissIAoI8FV6yI6ZUh7Q5Oxo5ZA4ZVC/AMunU/MD5bx+kg0+9iCyN7kmruc/CQVfPkdQd7aWeQAx1GblX49t3MQrrH4gd7/MpLR+JAtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168128; c=relaxed/simple;
	bh=saNUSormgrEjNTSTivpz7L+CKcywqBkfM5zmF2N9xeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulw32ScGR/R0WkyWtUJCskUm/V2FjEnu7UbvIjbz7qWtW1fil1zMn4wYw5LOfl7QKsgqR01maQwYeHQA2ARLTKzANFJf7DRePemELBAQOI3SbRDXnSBd/llrJcmuqCL8PMJuX14YiEGJmj3nHMqBXpBh2toS2z/04eDfTk6EYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/mmpGL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD245C4AF0F;
	Fri,  9 Aug 2024 01:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723168128;
	bh=saNUSormgrEjNTSTivpz7L+CKcywqBkfM5zmF2N9xeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b/mmpGL6IzqBsuqx3k2tltDHLZ3fCqqvfwHT4CdK3JpDr5hbGQLTmGjuEt30rwdvf
	 SStoILPBzDmqcyti3CvW9zJB17tS2PG86bz2DIKY4VnGQ/GNlU4eLeKBlu/o7fGsBx
	 CMIKZ7cOBKfrtR7VtalOLH97fp+L+dTn3K1f2STVHxCOqDA/chF3wPACoPy+rTRMgj
	 6uKtoZzKbAylnXnifX2ehQQ+AHwSO5o7Pqu6wrIoE1304vCxKZU1oB8dunGdpJomOT
	 FJsnR42e6UBnVzko+he50c15m45PLbal0XNMPIUGPG4Egu/M0pyiOvyO5X9iIJP55k
	 +iJyJ+VUEsIcQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 09 Aug 2024 03:48:29 +0200
Subject: [PATCH 2/3] dt-bindings: platform: Add Surface System Aggregator
 Module
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-topic-sam-v1-2-05bca1932614@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
In-Reply-To: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <quic_kdybcio@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723168110; l=2301;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=SOihdCDjA8pZjnLElCJSnk3cELdk7fp9U7fR3qgjwq0=;
 b=AKECtolS4/f0m+Oi86CbcJyuI/53uwXhugbyI9A0ukBjhEvfi+Dgwi5+VMSp5BvYdfp+gUj1d
 bDkI5y+S9hyDwx1YL5/UaYoc43fz0OfYhJh49oA1wmOoEOP8Lub6efB
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <quic_kdybcio@quicinc.com>

Add bindings for the Surface System Aggregator Module (SAM/SSAM), the
Microsoft Surface-standard Embedded Controller, used on both x86- and
Qualcomm-based devices.

It provides a plethora of functions, depending on what's wired up to
it. That includes but is not limited to: fan control, keyboard/touchpad
support, thermal sensors, power control, special buttons, tablet mode.

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
---
 .../bindings/platform/microsoft,surface-sam.yaml   | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
new file mode 100644
index 000000000000..f613738aa31d
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/platform/microsoft,surface-sam.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Surface System Aggregator Module (SAM, SSAM)
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  Surface devices use a standardized embedded controller to let the
+  operating system interface with various hardware functions. The
+  specific functionalities are modeled as subdevices and matched on
+  five levels: domain, category, target, instance and function.
+
+properties:
+  compatible:
+    const: microsoft,surface-sam
+
+  interrupts:
+    maxItems: 1
+
+  current-speed:
+    description: The baudrate in bits per second of the device as it comes
+      online, current active speed.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    uart {
+        embedded-controller {
+            compatible = "microsoft,surface-sam";
+
+            interrupts-extended = <&tlmm 91 IRQ_TYPE_EDGE_RISING>;
+
+            pinctrl-0 = <&ssam_state>;
+            pinctrl-names = "default";
+
+            current-speed = <4000000>;
+        };
+    };

-- 
2.46.0


