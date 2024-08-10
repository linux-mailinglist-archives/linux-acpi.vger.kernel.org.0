Return-Path: <linux-acpi+bounces-7490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685E94D9D1
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 03:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C01C1F22E6B
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969013B2B6;
	Sat, 10 Aug 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbsL3WEX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D0624;
	Sat, 10 Aug 2024 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723253351; cv=none; b=Vq8QncS9KB0aJFPtLj3Z5BM5hqDh39JC5zPcg2644XWFUPZwUtMYNsrO6mdtUaqbNMqzSu64FD5Pp9lIla5nhb9cwldduqORhJ9GvXoNRohoroZhM3jkn+6MvS7TLKwQbOd4tPMSXpgUvZWFw21NsI9408lcuYsS3xYfcwup0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723253351; c=relaxed/simple;
	bh=saNUSormgrEjNTSTivpz7L+CKcywqBkfM5zmF2N9xeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwMnIA1Y1YgDK2ASEEhx3rvhUA7FFdfX9YvKKj3WbaBHOmEcitUdD318a5tnY5L0YJZDs1av0qwc9kB57WSIwDtMyyEC4UO1JJsyAiHnvdr61/hkkROs3zdBW6XIMM9iscsoKEFghCdcTEGOcANmPOfVEgLrpDXQo16c9CQbOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbsL3WEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4A9C4AF0F;
	Sat, 10 Aug 2024 01:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723253351;
	bh=saNUSormgrEjNTSTivpz7L+CKcywqBkfM5zmF2N9xeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EbsL3WEXtj6X0rsIoRKdRlrQTUoZqThJryFgMi8BjaVpK7HGWT/s41VpsyjlXVKpG
	 75ygDl6072o3VO0jreMP+DoQj4Hk+9+b3EgCXwaORvWwmnLlBIyOr/LZMkBvTLXF5O
	 0drAB6ZbPQXrIy0a/VadxPaSfSfrbhJpsYAd+Q4VUbDRO/Y04OYeXd7wSN1NxrgjtV
	 v2fBpDefGTEEzu2fdyxjwSoqg1seLdeTFx9rKKtWBXzrodHVBDk0osJ8fyQuXkZYiP
	 B80ZFzkyg9F7WOE0gUzf+OvOAPVv1quT8u4F386kEbbT6oXjcxHEAyjC7sbjRKFLYn
	 BagP283dWXumg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Sat, 10 Aug 2024 03:28:39 +0200
Subject: [PATCH v2 2/3] dt-bindings: platform: Add Surface System
 Aggregator Module
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240810-topic-sam-v2-2-8a8eb368a4f0@quicinc.com>
References: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
In-Reply-To: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723253333; l=2301;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=SOihdCDjA8pZjnLElCJSnk3cELdk7fp9U7fR3qgjwq0=;
 b=QqpCnIM/t2ggZ5bzIuNZUKX1/hyOoA2c2jVMr93UTyWpB3lnsdAkR1/qMR8t0+XAOxAyWHutZ
 I07o/ft1z+KDRVpEJTHkv0FzMRcY7dJVyHMr5cvPwQD0iPwSbQH8FO6
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


