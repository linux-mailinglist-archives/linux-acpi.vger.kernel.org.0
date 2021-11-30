Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE08463A1A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhK3Pf0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 10:35:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:17657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234607AbhK3PfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 10:35:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236467033"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="236467033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:31:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="654208301"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:31:54 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 2145220983;
        Tue, 30 Nov 2021 17:31:52 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ms57i-003vRP-DX; Tue, 30 Nov 2021 17:32:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: [PATCH 4/7] Documentation: ACPI: Update references
Date:   Tue, 30 Nov 2021 17:32:47 +0200
Message-Id: <20211130153250.935726-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Update references for the ACPI _DSD documentation. In particular:

- Substitute _DSD property and hierarchical data extension documents with
  the newer DSD guide that replaces both, and use its HTML form.

- Refer to the latest ACPI spec.

- Add data node reference documentation reference to graph documentation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../acpi/dsd/data-node-references.rst         | 11 ++----
 .../firmware-guide/acpi/dsd/graph.rst         | 39 ++++++++-----------
 .../firmware-guide/acpi/dsd/leds.rst          | 24 +++++-------
 Documentation/firmware-guide/acpi/dsd/phy.rst | 21 +++++-----
 4 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index 166bf9a944bc8..87012dbd0a456 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -33,7 +33,7 @@ extension key.
 Example
 =======
 
-In the ASL snippet below, the "reference" _DSD property [2] contains a
+In the ASL snippet below, the "reference" _DSD property contains a
 device object reference to DEV0 and under that device object, a
 hierarchical data extension key "node@1" referring to the NOD1 object
 and lastly, a hierarchical data extension key "anothernode" referring to
@@ -89,10 +89,5 @@ Documentation/firmware-guide/acpi/dsd/graph.rst.
 References
 ==========
 
-[1] Hierarchical Data Extension UUID For _DSD.
-<https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
-referenced 2018-07-17.
-
-[2] Device Properties UUID For _DSD.
-<https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
-referenced 2016-10-04.
+[1] DSD Guide. https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.adoc,
+    referenced 2021-11-30.
diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 0ced07cb1be31..5d27cd10b53ba 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -7,11 +7,11 @@ Graphs
 _DSD
 ====
 
-_DSD (Device Specific Data) [7] is a predefined ACPI device
+_DSD (Device Specific Data) [3] is a predefined ACPI device
 configuration object that can be used to convey information on
 hardware features which are not specifically covered by the ACPI
-specification [1][6]. There are two _DSD extensions that are relevant
-for graphs: property [4] and hierarchical data extensions [5]. The
+specification [4]. There are two _DSD extensions that are relevant
+for graphs: property [3] and hierarchical data extensions. The
 property extension provides generic key-value pairs whereas the
 hierarchical data extension supports nodes with references to other
 nodes, forming a tree. The nodes in the tree may contain properties as
@@ -36,8 +36,9 @@ Ports and endpoints
 ===================
 
 The port and endpoint concepts are very similar to those in Devicetree
-[3]. A port represents an interface in a device, and an endpoint
-represents a connection to that interface.
+[1, 2]. A port represents an interface in a device, and an endpoint
+represents a connection to that interface. Also see [6] for generic data
+node references.
 
 All port nodes are located under the device's "_DSD" node in the hierarchical
 data extension tree. The data extension related to each port node must begin
@@ -153,25 +154,19 @@ the "ISP" device and vice versa.
 References
 ==========
 
-[1] _DSD (Device Specific Data) Implementation Guide.
-    https://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
-    referenced 2016-10-03.
+[1] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
 
-[2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
+[2] Common bindings for device graphs (Devicetree).
+    https://github.com/devicetree-org/dt-schema/blob/main/schemas/graph.yaml,
+    referenced 2021-11-30.
 
-[3] Documentation/devicetree/bindings/graph.txt
+[3] DSD Guide. https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.adoc,
+    referenced 2021-11-30.
 
-[4] Device Properties UUID For _DSD.
-    https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
-    referenced 2016-10-04.
+[4] Advanced Configuration and Power Interface Specification.
+    https://uefi.org/specifications/ACPI/6.4/, referenced 2021-11-30.
 
-[5] Hierarchical Data Extension UUID For _DSD.
-    https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
-    referenced 2016-10-04.
-
-[6] Advanced Configuration and Power Interface Specification.
-    https://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
-    referenced 2016-10-04.
-
-[7] _DSD Device Properties Usage Rules.
+[5] _DSD Device Properties Usage Rules.
     Documentation/firmware-guide/acpi/DSD-properties-rules.rst
+
+[6] Documentation/firmware-guide/acpi/dsd/data-node-references.rst
diff --git a/Documentation/firmware-guide/acpi/dsd/leds.rst b/Documentation/firmware-guide/acpi/dsd/leds.rst
index b99fff8e06f28..d7c8b605eba39 100644
--- a/Documentation/firmware-guide/acpi/dsd/leds.rst
+++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
@@ -5,7 +5,7 @@
 Describing and referring to LEDs in ACPI
 ========================================
 
-Individual LEDs are described by hierarchical data extension [6] nodes under the
+Individual LEDs are described by hierarchical data extension [5] nodes under the
 device node, the LED driver chip. The "reg" property in the LED specific nodes
 tells the numerical ID of each individual LED output to which the LEDs are
 connected. [3] The hierarchical data nodes are named "led@X", where X is the
@@ -17,7 +17,7 @@ documentation. In short, LEDs are directly referred to by using phandles.
 While Device tree allows referring to any node in the tree[1], in ACPI
 references are limited to device nodes only [2]. For this reason using the same
 mechanism on ACPI is not possible. A mechanism to refer to non-device ACPI nodes
-is documented in [7].
+is documented in [6].
 
 ACPI allows (as does DT) using integer arguments after the reference. A
 combination of the LED driver device reference and an integer argument,
@@ -90,22 +90,16 @@ where
 References
 ==========
 
-[1] Device tree. https://www.devicetree.org, referenced 2019-02-21.
+[1] Devicetree. https://www.devicetree.org, referenced 2019-02-21.
 
 [2] Advanced Configuration and Power Interface Specification.
-    https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf,
-    referenced 2019-02-21.
+    https://uefi.org/specifications/ACPI/6.4/, referenced 2021-11-30.
 
-[3] Documentation/devicetree/bindings/leds/common.txt
+[3] Documentation/devicetree/bindings/leds/common.yaml
 
-[4] Documentation/devicetree/bindings/media/video-interfaces.txt
+[4] Documentation/devicetree/bindings/media/video-interfaces.yaml
 
-[5] Device Properties UUID For _DSD.
-    https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
-    referenced 2019-02-21.
+[5] DSD Guide. https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.adoc,
+    referenced 2021-11-30.
 
-[6] Hierarchical Data Extension UUID For _DSD.
-    https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
-    referenced 2019-02-21.
-
-[7] Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+[6] Documentation/firmware-guide/acpi/dsd/data-node-references.rst
diff --git a/Documentation/firmware-guide/acpi/dsd/phy.rst b/Documentation/firmware-guide/acpi/dsd/phy.rst
index 680ad179e5f9d..c22f25012848d 100644
--- a/Documentation/firmware-guide/acpi/dsd/phy.rst
+++ b/Documentation/firmware-guide/acpi/dsd/phy.rst
@@ -11,10 +11,10 @@ Later, for connecting these PHYs to their respective MACs, the PHYs registered
 on the MDIO bus have to be referenced.
 
 This document introduces two _DSD properties that are to be used
-for connecting PHYs on the MDIO bus [3] to the MAC layer.
+for connecting PHYs on the MDIO bus [2] to the MAC layer.
 
 These properties are defined in accordance with the "Device
-Properties UUID For _DSD" [2] document and the
+Properties UUID For _DSD" [4] document and the
 daffd814-6eba-4d8c-8a91-bc9bbf4aa301 UUID must be used in the Device
 Data Descriptors containing them.
 
@@ -48,22 +48,22 @@ as device object references (e.g. \_SB.MDI0.PHY1).
 phy-mode
 --------
 The "phy-mode" _DSD property is used to describe the connection to
-the PHY. The valid values for "phy-mode" are defined in [4].
+the PHY. The valid values for "phy-mode" are defined in [3].
 
 managed
 -------
 Optional property, which specifies the PHY management type.
-The valid values for "managed" are defined in [4].
+The valid values for "managed" are defined in [3].
 
 fixed-link
 ----------
 The "fixed-link" is described by a data-only subnode of the
 MAC port, which is linked in the _DSD package via
 hierarchical data extension (UUID dbb8e3e6-5886-4ba6-8795-1319f52a966b
-in accordance with [5] "_DSD Implementation Guide" document).
+in accordance with [4] "_DSD Implementation Guide" document).
 The subnode should comprise a required property ("speed") and
 possibly the optional ones - complete list of parameters and
-their values are specified in [4].
+their values are specified in [3].
 
 The following ASL example illustrates the usage of these properties.
 
@@ -190,10 +190,9 @@ References
 
 [1] Documentation/networking/phy.rst
 
-[2] https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+[2] Documentation/firmware-guide/acpi/DSD-properties-rules.rst
 
-[3] Documentation/firmware-guide/acpi/DSD-properties-rules.rst
+[3] Documentation/devicetree/bindings/net/ethernet-controller.yaml
 
-[4] Documentation/devicetree/bindings/net/ethernet-controller.yaml
-
-[5] https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf
+[4] DSD Guide. https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.adoc,
+    referenced 2021-11-30.
-- 
2.30.2

