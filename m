Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896F119AE4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfEJJqB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 05:46:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:41413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfEJJqA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 05:46:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 02:45:59 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2019 02:45:57 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id 1A4F020800;
        Fri, 10 May 2019 12:45:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP26O-0003k8-6J; Fri, 10 May 2019 12:46:04 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 1/2] Documentation: ACPI: Use tabs for indentation
Date:   Fri, 10 May 2019 12:46:02 +0300
Message-Id: <20190510094603.14345-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
References: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use tabs to indent the graph documentation, not spaces.

Fixes: f2dde1ed0f28 ("Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and convert to reST")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/firmware-guide/acpi/dsd/graph.rst | 116 ++++++++++++------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index e0baed35b037e..8a9019a38b66d 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -82,68 +82,68 @@ A simple example of this is show below::
 
     Scope (\_SB.PCI0.I2C2)
     {
-        Device (CAM0)
-        {
-            Name (_DSD, Package () {
-                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-                Package () {
-                    Package () { "compatible", Package () { "nokia,smia" } },
-                },
-                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-                Package () {
-                    Package () { "port@0", PRT0 },
-                }
-            })
-            Name (PRT0, Package() {
-                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-                Package () {
-                    Package () { "reg", 0 },
-                },
-                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-                Package () {
-                    Package () { "endpoint@0", EP00 },
-                }
-            })
-            Name (EP00, Package() {
-                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-                Package () {
-                    Package () { "reg", 0 },
-                    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
-                }
-            })
-        }
+	Device (CAM0)
+	{
+	    Name (_DSD, Package () {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "compatible", Package () { "nokia,smia" } },
+		},
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "port@0", PRT0 },
+		}
+	    })
+	    Name (PRT0, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "reg", 0 },
+		},
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "endpoint@0", EP00 },
+		}
+	    })
+	    Name (EP00, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "reg", 0 },
+		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
+		}
+	    })
+	}
     }
 
     Scope (\_SB.PCI0)
     {
-        Device (ISP)
-        {
-            Name (_DSD, Package () {
-                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-                Package () {
-                    Package () { "port@4", PRT4 },
-                }
-            })
-
-            Name (PRT4, Package() {
-                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-                Package () {
-                    Package () { "reg", 4 }, /* CSI-2 port number */
-                },
-                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-                Package () {
-                    Package () { "endpoint@0", EP40 },
-                }
-            })
-
-            Name (EP40, Package() {
-                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-                Package () {
-                    Package () { "reg", 0 },
-                    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
-                }
-            })
-        }
+	Device (ISP)
+	{
+	    Name (_DSD, Package () {
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "port@4", PRT4 },
+		}
+	    })
+
+	    Name (PRT4, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "reg", 4 }, /* CSI-2 port number */
+		},
+		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+		Package () {
+		    Package () { "endpoint@0", EP40 },
+		}
+	    })
+
+	    Name (EP40, Package() {
+		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+		Package () {
+		    Package () { "reg", 0 },
+		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
+		}
+	    })
+	}
     }
 
 Here, the port 0 of the "CAM0" device is connected to the port 4 of
-- 
2.11.0

