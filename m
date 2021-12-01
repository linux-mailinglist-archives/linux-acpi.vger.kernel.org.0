Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4427A464E4E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 13:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbhLANCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:02:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:14076 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349438AbhLANCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:02:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236395264"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236395264"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="540816522"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:36 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A2A652093F;
        Wed,  1 Dec 2021 14:58:34 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPCw-003vlA-Td; Wed, 01 Dec 2021 14:59:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: [PATCH v2 3/7] Documentation: ACPI: Fix data node reference documentation
Date:   Wed,  1 Dec 2021 14:59:31 +0200
Message-Id: <20211201125934.936953-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The data node reference documentation was missing a package that must
contain the property values, instead property name and multiple values
being present in a single package. This is not aligned with the _DSD spec.
Fix it by adding the package for the values.

Also add the missing "reg" properties to two numbered nodes.

Fixes: b10134a3643d ("ACPI: property: Document hierarchical data extension references")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../firmware-guide/acpi/dsd/data-node-references.rst   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index b7ad47df49de0..8b65b32e6e40e 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -5,7 +5,7 @@
 Referencing hierarchical data nodes
 ===================================
 
-:Copyright: |copy| 2018 Intel Corporation
+:Copyright: |copy| 2018, 2021 Intel Corporation
 :Author: Sakari Ailus <sakari.ailus@linux.intel.com>
 
 ACPI in general allows referring to device objects in the tree only.
@@ -52,12 +52,14 @@ the ANOD object which is also the final target node of the reference.
 	    Name (NOD0, Package() {
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
+		    Package () { "reg", 0 },
 		    Package () { "random-property", 3 },
 		}
 	    })
 	    Name (NOD1, Package() {
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
+		    Package () { "reg", 1 },
 		    Package () { "anothernode", "ANOD" },
 		}
 	    })
@@ -74,7 +76,11 @@ the ANOD object which is also the final target node of the reference.
 	    Name (_DSD, Package () {
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
-		    Package () { "reference", ^DEV0, "node@1", "anothernode" },
+		    Package () {
+			"reference", Package () {
+			    ^DEV0, "node@1", "anothernode"
+			}
+		    },
 		}
 	    })
 	}
-- 
2.30.2

