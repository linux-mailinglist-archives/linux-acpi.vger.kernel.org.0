Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EF29F54C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgJ2Tct (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 15:32:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:17021 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgJ2Tcs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 15:32:48 -0400
IronPort-SDR: /qXgwlgozUoKfq65vWS69Qq17PNv+GIggTvB6zhQ4qGybeHOnN4XtjUkpVHWdsonqj1jXR6Igl
 yqrlHFY4j+Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="148352866"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="148352866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 12:32:47 -0700
IronPort-SDR: TLNDv6kMssP6RdrjIUQ0u8sWENlKIf8ousODnOgEyRH5/wfMCsoTXGnLolOOMu69f0A/sHC6Qp
 npAzsTezQVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="304542734"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2020 12:32:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDEF0453; Thu, 29 Oct 2020 21:32:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] Documentation: firmware-guide: gpio-properties: Fix factual mistakes
Date:   Thu, 29 Oct 2020 21:32:41 +0200
Message-Id: <20201029193243.61546-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix factual mistakes and style issues in GPIO properties document.
This converts IoRestriction from InputOnly to OutputOnly as pins
in the example are used as outputs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: elaborated the mistakes the change fixes (Mika)
 .../firmware-guide/acpi/gpio-properties.rst   | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index bb6d74f23ee0..e6e65ceb2ca1 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -20,9 +20,9 @@ index, like the ASL example below shows::
 
       Name (_CRS, ResourceTemplate ()
       {
-          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
+          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
                   "\\_SB.GPO0", 0, ResourceConsumer) {15}
-          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
+          GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
                   "\\_SB.GPO0", 0, ResourceConsumer) {27, 31}
       })
 
@@ -49,7 +49,7 @@ index
 pin
   Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
 active_low
-  If 1 the GPIO is marked as active_low.
+  If 1, the GPIO is marked as active_low.
 
 Since ACPI GpioIo() resource does not have a field saying whether it is
 active low or high, the "active_low" argument can be used here.  Setting
@@ -112,8 +112,8 @@ Example::
   Package () {
       "gpio-line-names",
       Package () {
-          "SPI0_CS_N", "EXP2_INT", "MUX6_IO", "UART0_RXD", "MUX7_IO",
-          "LVL_C_A1", "MUX0_IO", "SPI1_MISO"
+          "SPI0_CS_N", "EXP2_INT", "MUX6_IO", "UART0_RXD",
+          "MUX7_IO", "LVL_C_A1", "MUX0_IO", "SPI1_MISO",
       }
   }
 
@@ -137,7 +137,7 @@ to the GPIO lines it is going to use and provide the GPIO subsystem with a
 mapping between those names and the ACPI GPIO resources corresponding to them.
 
 To do that, the driver needs to define a mapping table as a NULL-terminated
-array of struct acpi_gpio_mapping objects that each contain a name, a pointer
+array of struct acpi_gpio_mapping objects that each contains a name, a pointer
 to an array of line data (struct acpi_gpio_params) objects and the size of that
 array.  Each struct acpi_gpio_params object consists of three fields,
 crs_entry_index, line_index, active_low, representing the index of the target
@@ -154,13 +154,14 @@ question would look like this::
   static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
     { "reset-gpios", &reset_gpio, 1 },
     { "shutdown-gpios", &shutdown_gpio, 1 },
-    { },
+    { }
   };
 
 Next, the mapping table needs to be passed as the second argument to
-acpi_dev_add_driver_gpios() that will register it with the ACPI device object
-pointed to by its first argument.  That should be done in the driver's .probe()
-routine.  On removal, the driver should unregister its GPIO mapping table by
+acpi_dev_add_driver_gpios() or its managed analogue that will
+register it with the ACPI device object pointed to by its first
+argument. That should be done in the driver's .probe() routine.
+On removal, the driver should unregister its GPIO mapping table by
 calling acpi_dev_remove_driver_gpios() on the ACPI device object where that
 table was previously registered.
 
@@ -191,12 +192,12 @@ The driver might expect to get the right GPIO when it does::
 but since there is no way to know the mapping between "reset" and
 the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
 
-The driver author can solve this by passing the mapping explictly
-(the recommended way and documented in the above chapter).
+The driver author can solve this by passing the mapping explicitly
+(this is the recommended way and it's documented in the above chapter).
 
 The ACPI GPIO mapping tables should not contaminate drivers that are not
 knowing about which exact device they are servicing on. It implies that
-the ACPI GPIO mapping tables are hardly linked to ACPI ID and certain
+the ACPI GPIO mapping tables are hardly linked to an ACPI ID and certain
 objects, as listed in the above chapter, of the device in question.
 
 Getting GPIO descriptor
@@ -229,5 +230,5 @@ Case 2 explicitly tells GPIO core to look for resources in _CRS.
 Be aware that gpiod_get_index() in cases 1 and 2, assuming that there
 are two versions of ACPI device description provided and no mapping is
 present in the driver, will return different resources. That's why a
-certain driver has to handle them carefully as explained in previous
+certain driver has to handle them carefully as explained in the previous
 chapter.
-- 
2.28.0

