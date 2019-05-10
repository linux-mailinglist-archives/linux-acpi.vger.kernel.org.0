Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0717319AE5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfEJJqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 05:46:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:47717 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfEJJqA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 05:46:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 02:45:59 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2019 02:45:58 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id 91AAC20A47;
        Fri, 10 May 2019 12:45:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP26O-0003kB-KR; Fri, 10 May 2019 12:46:04 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 2/2] Documentation: ACPI: Direct references are allowed to devices only
Date:   Fri, 10 May 2019 12:46:03 +0300
Message-Id: <20190510094603.14345-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
References: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In ACPI it is possible to make references to device objects only, not to
other objects inside a device. In practice this means that hierarchical
data extension targets must be in parentheses to make them strings.

Otherwise an acpica warning is produced.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../firmware-guide/acpi/dsd/data-node-references.rst         |  6 +++---
 Documentation/firmware-guide/acpi/dsd/graph.rst              | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index 1351984e767c8..febccbc5689d0 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -45,8 +45,8 @@ the ANOD object which is also the final target node of the reference.
 	    Name (_DSD, Package () {
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "node@0", NOD0 },
-		    Package () { "node@1", NOD1 },
+		    Package () { "node@0", "NOD0" },
+		    Package () { "node@1", "NOD1" },
 		}
 	    })
 	    Name (NOD0, Package() {
@@ -58,7 +58,7 @@ the ANOD object which is also the final target node of the reference.
 	    Name (NOD1, Package() {
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "anothernode", ANOD },
+		    Package () { "anothernode", "ANOD" },
 		}
 	    })
 	    Name (ANOD, Package() {
diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 8a9019a38b66d..1a6ce7afba5ea 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -45,7 +45,7 @@ with "port" and must be followed by the "@" character and the number of the
 port as its key. The target object it refers to should be called "PRTX", where
 "X" is the number of the port. An example of such a package would be::
 
-    Package() { "port@4", PRT4 }
+    Package() { "port@4", "PRT4" }
 
 Further on, endpoints are located under the port nodes. The hierarchical
 data extension key of the endpoint nodes must begin with
@@ -54,7 +54,7 @@ endpoint. The object it refers to should be called "EPXY", where "X" is the
 number of the port and "Y" is the number of the endpoint. An example of such a
 package would be::
 
-    Package() { "endpoint@0", EP40 }
+    Package() { "endpoint@0", "EP40" }
 
 Each port node contains a property extension key "port", the value of which is
 the number of the port. Each endpoint is similarly numbered with a property
@@ -91,7 +91,7 @@ A simple example of this is show below::
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "port@0", PRT0 },
+		    Package () { "port@0", "PRT0" },
 		}
 	    })
 	    Name (PRT0, Package() {
@@ -101,7 +101,7 @@ A simple example of this is show below::
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "endpoint@0", EP00 },
+		    Package () { "endpoint@0", "EP00" },
 		}
 	    })
 	    Name (EP00, Package() {
@@ -121,7 +121,7 @@ A simple example of this is show below::
 	    Name (_DSD, Package () {
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "port@4", PRT4 },
+		    Package () { "port@4", "PRT4" },
 		}
 	    })
 
@@ -132,7 +132,7 @@ A simple example of this is show below::
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "endpoint@0", EP40 },
+		    Package () { "endpoint@0", "EP40" },
 		}
 	    })
 
-- 
2.11.0

