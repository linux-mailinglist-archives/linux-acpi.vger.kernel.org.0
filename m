Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F144C101
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 13:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhKJMNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 07:13:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:21815 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhKJMNH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 07:13:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="213384604"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="213384604"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 04:10:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="669779902"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 04:10:03 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 6FB13205BA;
        Wed, 10 Nov 2021 14:10:01 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1mkmQg-0080VY-NM; Wed, 10 Nov 2021 14:10:14 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>
Subject: [PATCH 1/1] Documentation: ACPI: Fix non-D0 probe _DSC object example
Date:   Wed, 10 Nov 2021 14:10:14 +0200
Message-Id: <20211110121014.1908531-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The original patch adding the example used _DSC Name when Method was
intended. Fix this.

Also replace spaces used for indentation with tabs in the example.

Fixes: ed66f12ba4b1 ("Documentation: ACPI: Document _DSC object usage for enum power state")
Reported-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/firmware-guide/acpi/non-d0-probe.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
index 78781e1ab6a3d..7afd16701a02e 100644
--- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
+++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
@@ -62,7 +62,7 @@ objects not relevant from the example point of view have been omitted.
 .. code-block:: text
 
 	Device (CAM0)
-        {
+	{
 		Name (_HID, "SONY319A")
 		Name (_UID, Zero)
 		Name (_CRS, ResourceTemplate ()
@@ -71,8 +71,8 @@ objects not relevant from the example point of view have been omitted.
 				     AddressingMode7Bit, "\\_SB.PCI0.I2C0",
 				     0x00, ResourceConsumer)
 		})
-		Name (_DSC, 0, NotSerialized)
+		Method (_DSC, 0, NotSerialized)
 		{
 			Return (0x4)
-                }
+		}
 	}
-- 
2.30.2

