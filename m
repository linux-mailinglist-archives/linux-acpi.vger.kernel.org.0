Return-Path: <linux-acpi+bounces-7566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A659518B8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAC41F23F1E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B21AE026;
	Wed, 14 Aug 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU6wVMF6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A01AC43A;
	Wed, 14 Aug 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631268; cv=none; b=nztXeTzJqkpKJ7hBjeRUcZqTZ2BOcp9bwBA5BOPiCdjmwjUu9L1zcDRzHFw0ianJxHAtB85fz1UuIyJPjJMFQ1Bk8LzZaxxm3kwmRj32hU5gVFU39cX4Vz5t+Fagunxbs7EhnHY7ZRokm5ha/M6jT/gdvTLKobQxsRhE/C7t9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631268; c=relaxed/simple;
	bh=ZhTmHqjXaQBILdiONQIN6v/xVvTLH3Rx+dvH0bwsvSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cd7xf3/mSRh5T48UCrblvV0uqXn1WQD4LDZBCiyjDPWpb+gJgfJc/hDbTQAZCawENunAyGxtEYjmOQnAHLY8H/34rlS4zkwxSqhsGQZ+q9cPuPzsd7yHQN4YI2TW+DQcDFJDYQdUlJiof7uk5dv1Ewgztfst5SNXKbgD5/SnrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU6wVMF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DBCC32786;
	Wed, 14 Aug 2024 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723631267;
	bh=ZhTmHqjXaQBILdiONQIN6v/xVvTLH3Rx+dvH0bwsvSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YU6wVMF6VZSdfXli0Okq23tMgExTzNZzCnkqQ2r/MsD89dSDwDHM9egy1dgZ5m2wT
	 D9QOT5Yz2swBk1hfy0p8Y3BY+WNpt9zRGOjQmmr0ou9lwPbacRDLvupdVKK8ArXLw7
	 /opxwavZj6/w1xAcP8iFFX/tdpPOLkAFLBR1fmeDV48OBrZ/o+chFYAhAqg7PGCxRB
	 Z0kLRefsk+VrZhreN+ZdmC4AWCmsvT56jOLX+7su8SpPVPncvmUlTWzVWfFVnUc6sX
	 kOiFRuO1CBSVWZV3eUfJDd8RFYGieHNxf3e+I9qTMqni8DvtPgMJuHm/F3k35rXsd5
	 QSZ1ibWsI1HCQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Aug 2024 12:27:26 +0200
Subject: [PATCH v3 2/3] dt-bindings: platform: Add Surface System
 Aggregator Module
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-topic-sam-v3-2-a84588aad233@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
In-Reply-To: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723631251; l=2139;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=bf//05XYHKVSJhxuviOZL6SJekmC4n9LkYKQjhk7dhA=;
 b=VbBHpogwXt2IKhPriw1IM8R2HHZkdAEMICXDrSijxynwqvYhY5SaredoZDg8XZJwdjpEMMWsN
 E92eNCqcp96COEOKHGdy/R30rOXLpJb2ZKtc1/6SuOcH0FtHv4HBW9b
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
 .../bindings/platform/microsoft,surface-sam.yaml   | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
new file mode 100644
index 000000000000..b33d26f15b2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
@@ -0,0 +1,47 @@
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
+  current-speed: true
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


