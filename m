Return-Path: <linux-acpi+bounces-15088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE322B0097E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627251C8856B
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D082F0027;
	Thu, 10 Jul 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2UKz81w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FD2797A0;
	Thu, 10 Jul 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166998; cv=none; b=k3ePJHeIxiVcuWTaWXz+05nbT/xDjt40ZBqFuaGBfzK7jGDi4h9hxhpL/KX/4cnr117bfvAsgY3WvqDKTUfqPebgrLvtc9vjqPHpqZzxDZ8r0VyTe4UXs8tiV/rV7MFCQ3ZuGb7qtPS+o9xNoLdga2XN3ZNKfCBWAA7KsiyFzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166998; c=relaxed/simple;
	bh=W7zbUH+rxVwiXWiCIcevxN/uLfmclgsMQLofiJFemE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpE11Fzch2RRJ+vgGOG5j7P6S6iyDiwPBchPr4NlwAjjvScgP93hQ6CKn0V11Sm5BblcOqVbAcliEwia7lYeQTJHsvHxGEwvB10wNMvL67uo4YtYVdeimH2zZ15tpi5ABVyYELs0QmJYk+toti++kF+gkS9AWwalEAN3Gg9FHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2UKz81w; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166997; x=1783702997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W7zbUH+rxVwiXWiCIcevxN/uLfmclgsMQLofiJFemE8=;
  b=g2UKz81w9OmiifzRG7UjxBwNPU2lRFSL4JOnnSPaOc7/ga863nI/zehy
   3wyO+F/IGfQvQjsJ1v/vu0FCpL7oWt5aGVjRrWxNboyJX6VLoXbDlXqQz
   ZdIaWIVHzAqLpxl+3FgVkuF8xSDKhI9uXuCrl6zSUv+DcIRb+8zwrfZX6
   t40MG4QYkUfje8tNDzF1yjqn2sDa85ezg+pQxJ613FfRBHduGHf0Pz2Cb
   N8i0iMoTfq+IVj9WT4DJNpZG6xnBvzwMXBuOtedTkf3dEvWEW14RPCJoA
   9K/CIz8srGkNElYckqId1DpvrCsBNB/aDOpPqmTCKw8UDVkbRhcTwFPyz
   Q==;
X-CSE-ConnectionGUID: 7j6GJ7G4TxC8T0HKNDv6Fw==
X-CSE-MsgGUID: FcXhll5BQZ2PDrz2+Tb2fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54611069"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54611069"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 10:02:32 -0700
X-CSE-ConnectionGUID: e3p89pHySIe68v8tQzAc5g==
X-CSE-MsgGUID: Jwe4w9AYQymXoADwzaUQow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161710434"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 10:02:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C43FB1A1; Thu, 10 Jul 2025 20:02:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Yevhen Kondrashyn <e.kondrashyn@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] Documentation: ACPI: Fix parent device references
Date: Thu, 10 Jul 2025 20:00:23 +0300
Message-ID: <20250710170225.961303-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _CRS resources in many cases want to have ResourceSource field
to be a type of ACPI String. This means that to compile properly
we need to enclosure the name path into double quotes. This will
in practice defer the interpretation to a run-time stage, However,
this may be interpreted differently on different OSes and ACPI
interpreter implementations. In particular ACPICA might not correctly
recognize the leading '^' (caret) character and will not resolve
the relative name path properly. On top of that, this piece may be
used in SSDTs which are loaded after the DSDT and on itself may also
not resolve relative name paths outside of their own scopes.
With this all said, fix documentation to use fully-qualified name
paths always to avoid any misinterpretations, which is proven to
work.

Fixes: 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
Reported-by: Yevhen Kondrashyn <e.kondrashyn@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Rafael, I prefer, if no objections, to push this as v6.16-rc6 material since
the reported issue was detected on old (v5.10.y) and still LTS kernel. Would be
nice for people to not trap to it in older kernels.

 Documentation/firmware-guide/acpi/i2c-muxes.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
index 3a8997ccd7c4..f366539acd79 100644
--- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -14,7 +14,7 @@ Consider this topology::
     |      |   | 0x70 |--CH01--> i2c client B (0x50)
     +------+   +------+
 
-which corresponds to the following ASL::
+which corresponds to the following ASL (in the scope of \_SB)::
 
     Device (SMB1)
     {
@@ -24,7 +24,7 @@ which corresponds to the following ASL::
             Name (_HID, ...)
             Name (_CRS, ResourceTemplate () {
                 I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                            AddressingMode7Bit, "^SMB1", 0x00,
+                            AddressingMode7Bit, "\\_SB.SMB1", 0x00,
                             ResourceConsumer,,)
             }
 
@@ -37,7 +37,7 @@ which corresponds to the following ASL::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
                                     ResourceConsumer,,)
                     }
                 }
@@ -52,7 +52,7 @@ which corresponds to the following ASL::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
                                     ResourceConsumer,,)
                     }
                 }
-- 
2.47.2


