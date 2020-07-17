Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DD224314
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jul 2020 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGQSYz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jul 2020 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQSYz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2020 14:24:55 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC13C0619D2;
        Fri, 17 Jul 2020 11:24:54 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 120AEBC070;
        Fri, 17 Jul 2020 18:24:44 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, sakari.ailus@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Date:   Fri, 17 Jul 2020 20:24:36 +0200
Message-Id: <20200717182436.75214-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 .../firmware-guide/acpi/DSD-properties-rules.rst       |  4 ++--
 .../firmware-guide/acpi/dsd/data-node-references.rst   |  4 ++--
 Documentation/firmware-guide/acpi/dsd/graph.rst        | 10 +++++-----
 Documentation/firmware-guide/acpi/dsd/leds.rst         |  6 +++---
 Documentation/firmware-guide/acpi/lpit.rst             |  2 +-
 drivers/acpi/Kconfig                                   |  2 +-
 drivers/acpi/nfit/nfit.h                               |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
index 4306f29b6103..8b2d8d0864c2 100644
--- a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
+++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
@@ -96,5 +96,5 @@ contents.
 References
 ==========
 
-.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
+.. [1] https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+.. [2] https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index febccbc5689d..9b17dc77d18c 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -85,9 +85,9 @@ References
 ==========
 
 [1] Hierarchical Data Extension UUID For _DSD.
-<http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+<https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
 referenced 2018-07-17.
 
 [2] Device Properties UUID For _DSD.
-<http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+<https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
 referenced 2016-10-04.
diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 1a6ce7afba5e..7072db801aeb 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -154,23 +154,23 @@ References
 ==========
 
 [1] _DSD (Device Specific Data) Implementation Guide.
-    http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
+    https://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
     referenced 2016-10-03.
 
-[2] Devicetree. http://www.devicetree.org, referenced 2016-10-03.
+[2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
 
 [3] Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
-    http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
+    https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
     referenced 2016-10-04.
 
 [5] Hierarchical Data Extension UUID For _DSD.
-    http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
+    https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
     referenced 2016-10-04.
 
 [6] Advanced Configuration and Power Interface Specification.
-    http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
+    https://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
     referenced 2016-10-04.
 
 [7] _DSD Device Properties Usage Rules.
diff --git a/Documentation/firmware-guide/acpi/dsd/leds.rst b/Documentation/firmware-guide/acpi/dsd/leds.rst
index 946efe2b2936..aba1e9abfeeb 100644
--- a/Documentation/firmware-guide/acpi/dsd/leds.rst
+++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
@@ -90,7 +90,7 @@ where
 References
 ==========
 
-[1] Device tree. <URL:http://www.devicetree.org>, referenced 2019-02-21.
+[1] Device tree. <URL:https://www.devicetree.org>, referenced 2019-02-21.
 
 [2] Advanced Configuration and Power Interface Specification.
     <URL:https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf>,
@@ -101,11 +101,11 @@ References
 [4] Documentation/devicetree/bindings/media/video-interfaces.txt
 
 [5] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    <URL:https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
     referenced 2019-02-21.
 
 [6] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+    <URL:https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
     referenced 2019-02-21.
 
 [7] Documentation/firmware-guide/acpi/dsd/data-node-references.rst
diff --git a/Documentation/firmware-guide/acpi/lpit.rst b/Documentation/firmware-guide/acpi/lpit.rst
index aca928fab027..37922a903573 100644
--- a/Documentation/firmware-guide/acpi/lpit.rst
+++ b/Documentation/firmware-guide/acpi/lpit.rst
@@ -7,7 +7,7 @@ Low Power Idle Table (LPIT)
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
-http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
+https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
 
 Residencies for each low power state can be read via FFH
 (Function fixed hardware) or a memory mapped interface.
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ce2730d61a8f..16d7ca99ddbe 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -32,7 +32,7 @@ menuconfig ACPI
 	  Linux support for ACPI is based on Intel Corporation's ACPI
 	  Component Architecture (ACPI CA).  For more information on the
 	  ACPI CA, see:
-	  <http://acpica.org/>
+	  <https://acpica.org/>
 
 	  ACPI is an open industry specification originally co-developed by
 	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba. Currently,
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index f5525f8bb770..a303f0123394 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -16,7 +16,7 @@
 /* ACPI 6.1 */
 #define UUID_NFIT_BUS "2f10e7a4-9e91-11e4-89d3-123b93f75cba"
 
-/* http://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf */
+/* https://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf */
 #define UUID_NFIT_DIMM "4309ac30-0d11-11e4-9191-0800200c9a66"
 
 /* https://github.com/HewlettPackard/hpe-nvm/blob/master/Documentation/ */
-- 
2.27.0

