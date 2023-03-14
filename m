Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575386B8E5B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Mar 2023 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCNJQD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Mar 2023 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCNJQB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2023 05:16:01 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD115AB66;
        Tue, 14 Mar 2023 02:15:59 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F32C2056DC3;
        Tue, 14 Mar 2023 02:15:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F32C2056DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678785358;
        bh=L91Q/pWuok+CEvHHL6cmP9pyIjoRYt8GHHEbzCNE1UI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I5/b9lBOEDncMXw/62M6vQjJKU+mado24GPsb0khPJs0/l2TZlaO3kXjW0tLQ7IEv
         ELUrjV2HdJKI37n73aki7EQeF9Xco798AJqiucGyDIL80p67DzogecJjoYeSnF5/ze
         FCqgvgBoeD3Q1VITcnTCjF2MguH0FD6oy/QPkqv8=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v8 4/5] dt-bindings: bus: VMBus
Date:   Tue, 14 Mar 2023 02:15:49 -0700
Message-Id: <1678785350-20400-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
References: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add dt-bindings for Hyper-V VMBus.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/bus/microsoft,vmbus.yaml         | 54 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
new file mode 100644
index 000000000000..a8d40c766dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/microsoft,vmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Hyper-V VMBus
+
+maintainers:
+  - Saurabh Sengar <ssengar@linux.microsoft.com>
+
+description:
+  VMBus is a software bus that implement the protocols for communication
+  between the root or host OS and guest OSs (virtual machines).
+
+properties:
+  compatible:
+    const: microsoft,vmbus
+
+  ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <1>;
+        bus {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            ranges;
+
+            vmbus@ff0000000 {
+                compatible = "microsoft,vmbus";
+                #address-cells = <2>;
+                #size-cells = <1>;
+                ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 25a0981c74b6..c4f4c8cd9276 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9544,6 +9544,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
+F:	Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
 F:	Documentation/virt/hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
 F:	arch/arm64/hyperv
-- 
2.34.1

