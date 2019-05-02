Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD5120CE
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2019 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEBRE1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 May 2019 13:04:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:45691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBRE1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 May 2019 13:04:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 10:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="342792989"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga005.fm.intel.com with ESMTP; 02 May 2019 10:04:25 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id A233E2085C;
        Thu,  2 May 2019 20:04:24 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hMF8C-0007w6-42; Thu, 02 May 2019 20:04:24 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com
Subject: [PATCH 1/1] Documentation: ACPI: Direct references are allowed to devices only
Date:   Thu,  2 May 2019 20:04:23 +0300
Message-Id: <20190502170423.30468-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
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
 Documentation/acpi/dsd/data-node-references.txt |  6 +++---
 Documentation/acpi/dsd/graph.txt                | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/acpi/dsd/data-node-references.txt
index c3871565c8cfb..cd0971ea999a3 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/acpi/dsd/data-node-references.txt
@@ -41,8 +41,8 @@ Example
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
@@ -54,7 +54,7 @@ Example
 	    Name (NOD1, Package() {
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "anothernode", ANOD },
+		    Package () { "anothernode", "ANOD" },
 		}
 	    })
 	    Name (ANOD, Package() {
diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.txt
index b9ce910781dcd..aee673c96aa80 100644
--- a/Documentation/acpi/dsd/graph.txt
+++ b/Documentation/acpi/dsd/graph.txt
@@ -42,7 +42,7 @@ with "port" and must be followed by the "@" character and the number of the port
 as its key. The target object it refers to should be called "PRTX", where "X" is
 the number of the port. An example of such a package would be:
 
-    Package() { "port@4", PRT4 }
+    Package() { "port@4", "PRT4" }
 
 Further on, endpoints are located under the port nodes. The hierarchical
 data extension key of the endpoint nodes must begin with
@@ -51,7 +51,7 @@ endpoint. The object it refers to should be called "EPXY", where "X" is the
 number of the port and "Y" is the number of the endpoint. An example of such a
 package would be:
 
-    Package() { "endpoint@0", EP40 }
+    Package() { "endpoint@0", "EP40" }
 
 Each port node contains a property extension key "port", the value of which is
 the number of the port. Each endpoint is similarly numbered with a property
@@ -88,7 +88,7 @@ A simple example of this is show below:
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "port@0", PRT0 },
+		    Package () { "port@0", "PRT0" },
 		}
 	    })
 	    Name (PRT0, Package() {
@@ -98,7 +98,7 @@ A simple example of this is show below:
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "endpoint@0", EP00 },
+		    Package () { "endpoint@0", "EP00" },
 		}
 	    })
 	    Name (EP00, Package() {
@@ -118,7 +118,7 @@ A simple example of this is show below:
 	    Name (_DSD, Package () {
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "port@4", PRT4 },
+		    Package () { "port@4", "PRT4" },
 		}
 	    })
 
@@ -129,7 +129,7 @@ A simple example of this is show below:
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-		    Package () { "endpoint@0", EP40 },
+		    Package () { "endpoint@0", "EP40" },
 		}
 	    })
 
-- 
2.11.0

