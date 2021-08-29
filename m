Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC11E3FABF1
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Aug 2021 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhH2NXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 29 Aug 2021 09:23:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:8392 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbhH2NXi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 29 Aug 2021 09:23:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="197722819"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="197722819"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 06:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="644731144"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2021 06:22:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B198C5; Sun, 29 Aug 2021 16:22:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v1 1/1] Documentation: ACPI: Align the SSDT overlays file with the code
Date:   Sun, 29 Aug 2021 16:22:43 +0300
Message-Id: <20210829132243.82281-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This updates the following:

1) The ASL code to follow latest ACPI requirements, i.e.
   - static buffer to be defined outside of the method
   - The _ADR and _HID shouldn't be together for the same device

2) EFI section relies on the additional kernel configuration option,
   i.e. CONFIG_EFI_CUSTOM_SSDT_OVERLAYS

3) Refer to ACPI machine language as AML (capitalized)

4) Miscellaneous amendments

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../admin-guide/acpi/ssdt-overlays.rst        | 49 ++++++++++---------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
index 5d7e25988085..b5fbf54dca19 100644
--- a/Documentation/admin-guide/acpi/ssdt-overlays.rst
+++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
@@ -30,22 +30,21 @@ following ASL code can be used::
         {
             Device (STAC)
             {
-                Name (_ADR, Zero)
                 Name (_HID, "BMA222E")
+                Name (RBUF, ResourceTemplate ()
+                {
+                    I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
+                                AddressingMode7Bit, "\\_SB.I2C6", 0x00,
+                                ResourceConsumer, ,)
+                    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
+                            "\\_SB.GPO2", 0x00, ResourceConsumer, , )
+                    { // Pin list
+                        0
+                    }
+                })
 
                 Method (_CRS, 0, Serialized)
                 {
-                    Name (RBUF, ResourceTemplate ()
-                    {
-                        I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
-                                    AddressingMode7Bit, "\\_SB.I2C6", 0x00,
-                                    ResourceConsumer, ,)
-                        GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
-                                "\\_SB.GPO2", 0x00, ResourceConsumer, , )
-                        { // Pin list
-                            0
-                        }
-                    })
                     Return (RBUF)
                 }
             }
@@ -75,7 +74,7 @@ This option allows loading of user defined SSDTs from initrd and it is useful
 when the system does not support EFI or when there is not enough EFI storage.
 
 It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
-aml code must be placed in the first, uncompressed, initrd under the
+AML code must be placed in the first, uncompressed, initrd under the
 "kernel/firmware/acpi" path. Multiple files can be used and this will translate
 in loading multiple tables. Only SSDT and OEM tables are allowed. See
 initrd_table_override.txt for more details.
@@ -103,12 +102,14 @@ This is the preferred method, when EFI is supported on the platform, because it
 allows a persistent, OS independent way of storing the user defined SSDTs. There
 is also work underway to implement EFI support for loading user defined SSDTs
 and using this method will make it easier to convert to the EFI loading
-mechanism when that will arrive.
+mechanism when that will arrive. To enable it, the
+CONFIG_EFI_CUSTOM_SSDT_OVERLAYS shoyld be chosen to y.
 
-In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
-parameter can be used. The argument for the option is the variable name to
-use. If there are multiple variables with the same name but with different
-vendor GUIDs, all of them will be loaded.
+In order to load SSDTs from an EFI variable the ``"efivar_ssdt=..."`` kernel
+command line parameter can be used (the name has a limitation of 16 characters).
+The argument for the option is the variable name to use. If there are multiple
+variables with the same name but with different vendor GUIDs, all of them will
+be loaded.
 
 In order to store the AML code in an EFI variable the efivarfs filesystem can be
 used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
@@ -127,7 +128,7 @@ variable with the content from a given file::
 
     #!/bin/sh -e
 
-    while ! [ -z "$1" ]; do
+    while [ -n "$1" ]; do
             case "$1" in
             "-f") filename="$2"; shift;;
             "-g") guid="$2"; shift;;
@@ -167,14 +168,14 @@ variable with the content from a given file::
 Loading ACPI SSDTs from configfs
 ================================
 
-This option allows loading of user defined SSDTs from userspace via the configfs
+This option allows loading of user defined SSDTs from user space via the configfs
 interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
 mounted. In the following examples, we assume that configfs has been mounted in
-/config.
+/sys/kernel/config.
 
-New tables can be loading by creating new directories in /config/acpi/table/ and
-writing the SSDT aml code in the aml attribute::
+New tables can be loading by creating new directories in /sys/kernel/config/acpi/table
+and writing the SSDT AML code in the aml attribute::
 
-    cd /config/acpi/table
+    cd /sys/kernel/config/acpi/table
     mkdir my_ssdt
     cat ~/ssdt.aml > my_ssdt/aml
-- 
2.33.0

