Return-Path: <linux-acpi+bounces-12894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DADFA8207D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2219D3AAF71
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22A253F01;
	Wed,  9 Apr 2025 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nllHcR2y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC12528FC
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188475; cv=none; b=Njp7Kz1GZbdt26N2j5VQTahe8z6W1jyogYcfTUN0YsnsFVRG9ajOWxrJKbfuN5cUVJS7k3SldkAR2mFinvLjuDvxPV1SX/X5nefA6Oq9JpJUeC4jv+lCzfj4gP3gg2KtIyJ/4+eXhB207JRIo4ESwuNYhkGZ8dlcFxjedK8PNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188475; c=relaxed/simple;
	bh=UD9Mocissa4fokiQzuQ/tlOvVyhhG/hBqSqiFoJFB+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zo1BIoDT3gxzt16eqRWh2mI42x53bRD2jJ8lE0rDw0pVxcIVGRnIAsY6HEUsFmsLZo5ZiRNMeWq/HAhs3prDps4t/2xAlF0EurPCj/A5J3QtdOJOLFdqiQf0bDYlIzl14Vw6QvK5Tcoz7v7lYn59OnX9h4vZGx1VNlPXPBHLqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nllHcR2y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744188474; x=1775724474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UD9Mocissa4fokiQzuQ/tlOvVyhhG/hBqSqiFoJFB+s=;
  b=nllHcR2yIOyeBuOe2u/FreeNp/kwXPDkHD8Q1/vr4/m7ym0Xfk9ZFB9O
   eBML+XMBKl+IcQKP1YJaVDSCAhzxK9U9yKdtRKtxAdTvJImuhCbtcjVtw
   JSYMrOLMHPQDFuq+WuFkLyYkZPczN0pZSFt1taul9owuYNkLq1MVhyFE8
   gmp0f6YaZg7v4vNS0qHgMStYoh/mTKsfLdaoXFxpkrlfRJaCNDAV7mu3u
   TEPJHsyKIZirQTz48n4AJJGO7DWYrmkLxsDb3VvbVGMzHBJR2nvyLCZhM
   qgLVVZ6EwLFA8yBBSZVtSZW0wtURNyE3qKXbdlM/G43KVqDNVD77h8rwo
   w==;
X-CSE-ConnectionGUID: r1adSvXgQCSkX7krRnId0A==
X-CSE-MsgGUID: b6yZNgF/S/Opv28zzcM7GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="57022892"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="57022892"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:47:53 -0700
X-CSE-ConnectionGUID: SCAUA//IQseSMTq2JZxCOA==
X-CSE-MsgGUID: L45bQcjBSLCLJv7rB/STGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128260047"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:47:51 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 54F0211FB1F;
	Wed,  9 Apr 2025 11:47:48 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2R64-00FLNL-0q;
	Wed, 09 Apr 2025 11:47:48 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/1] Documentation: ACPI: Use all-string data node references
Date: Wed,  9 Apr 2025 11:47:38 +0300
Message-Id: <20250409084738.3657079-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that references to data nodes shall use string-only references
instead of a device reference and a succession of the first package
entries of hierarchical data node references.

Fixes: 9880702d123f ("ACPI: property: Support using strings in reference properties")
Cc: stable@vger.kernel.org # for 6.8 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../acpi/dsd/data-node-references.rst         | 26 +++++++++----------
 .../firmware-guide/acpi/dsd/graph.rst         | 11 +++-----
 .../firmware-guide/acpi/dsd/leds.rst          |  7 +----
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index 8d8b53e96bcf..8d91fab37d89 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -12,11 +12,14 @@ ACPI in general allows referring to device objects in the tree only.
 Hierarchical data extension nodes may not be referred to directly, hence this
 document defines a scheme to implement such references.
 
-A reference consist of the device object name followed by one or more
-hierarchical data extension [dsd-guide] keys. Specifically, the hierarchical
-data extension node which is referred to by the key shall lie directly under
-the parent object i.e. either the device object or another hierarchical data
-extension node.
+A reference to a _DSD hierarchical data node consist of the device object
+reference followed by a dot (".") and the data node object name as a string. Do
+not use non-string references as this will result in a copy of the hierarchical
+data node itself, not a reference!
+
+The hierarchical data extension node which is referred to shall have a
+followable path of hierarchical data node reference under a device it resides
+[dsd-guide].
 
 The keys in the hierarchical data nodes shall consist of the name of the node,
 "@" character and the number of the node in hexadecimal notation (without pre-
@@ -33,11 +36,9 @@ extension key.
 Example
 =======
 
-In the ASL snippet below, the "reference" _DSD property contains a
-device object reference to DEV0 and under that device object, a
-hierarchical data extension key "node@1" referring to the NOD1 object
-and lastly, a hierarchical data extension key "anothernode" referring to
-the ANOD object which is also the final target node of the reference.
+In the ASL snippet below, the "reference" _DSD property contains a string
+reference to a hierarchical data extension node ANOD under DEV0 under the parent
+of DEV1 device object. ANOD is also the final target node of the reference.
 ::
 
 	Device (DEV0)
@@ -76,10 +77,7 @@ the ANOD object which is also the final target node of the reference.
 	    Name (_DSD, Package () {
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
-		    Package () {
-			"reference", Package () {
-			    ^DEV0, "node@1", "anothernode"
-			}
+		    Package () { "reference", "^DEV0.ANOD" }
 		    },
 		}
 	    })
diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index b9dbfc73ed25..d6ae5ffa748c 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -66,12 +66,9 @@ of that port shall be zero. Similarly, if a port may only have a single
 endpoint, the number of that endpoint shall be zero.
 
 The endpoint reference uses property extension with "remote-endpoint" property
-name followed by a reference in the same package. Such references consist of
-the remote device reference, the first package entry of the port data extension
-reference under the device and finally the first package entry of the endpoint
-data extension reference under the port. Individual references thus appear as::
+name followed by a string reference in the same package. [data-node-ref]::
 
-    Package() { device, "port@X", "endpoint@Y" }
+    "device.datanode"
 
 In the above example, "X" is the number of the port and "Y" is the number of
 the endpoint.
@@ -109,7 +106,7 @@ A simple example of this is show below::
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
 		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
+		    Package () { "remote-endpoint", "\\_SB.PCI0.ISP.EP40" },
 		}
 	    })
 	}
@@ -141,7 +138,7 @@ A simple example of this is show below::
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
 		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
+		    Package () { "remote-endpoint", "\\_SB.PCI0.I2C2.CAM0.EP00" },
 		}
 	    })
 	}
diff --git a/Documentation/firmware-guide/acpi/dsd/leds.rst b/Documentation/firmware-guide/acpi/dsd/leds.rst
index 93db592c93c7..a97cd07d49be 100644
--- a/Documentation/firmware-guide/acpi/dsd/leds.rst
+++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
@@ -15,11 +15,6 @@ Referring to LEDs in Device tree is documented in [video-interfaces], in
 "flash-leds" property documentation. In short, LEDs are directly referred to by
 using phandles.
 
-While Device tree allows referring to any node in the tree [devicetree], in
-ACPI references are limited to device nodes only [acpi]. For this reason using
-the same mechanism on ACPI is not possible. A mechanism to refer to non-device
-ACPI nodes is documented in [data-node-ref].
-
 ACPI allows (as does DT) using integer arguments after the reference. A
 combination of the LED driver device reference and an integer argument,
 referring to the "reg" property of the relevant LED, is used to identify
@@ -74,7 +69,7 @@ omitted. ::
 			Package () {
 				Package () {
 					"flash-leds",
-					Package () { ^LED, "led@0", ^LED, "led@1" },
+					Package () { "^LED.LED0", "^LED.LED1" },
 				}
 			}
 		})
-- 
2.39.5


