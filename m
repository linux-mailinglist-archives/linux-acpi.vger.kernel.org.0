Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD78D29F54A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 20:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgJ2Tcs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 15:32:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:17021 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJ2Tcr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 15:32:47 -0400
IronPort-SDR: sPH5oPLfY3KNrsrWeOxtSlx3n9EWDeiRoJWuDGQEWaJqBItWIXhSLxDJGN363aXck/Z7NhGO3X
 EwLRQ9F9Eb/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="148352867"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="148352867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 12:32:47 -0700
IronPort-SDR: IbNylUpetUiBiHFWGtpCiAIKZOBjsPia5w++7vzP/k5kMsFjBL1tf59cCl4aQD2xSXDGDgEzAv
 dDZ3n4r5osAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="304542735"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2020 12:32:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E4E80567; Thu, 29 Oct 2020 21:32:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] Documentation: firmware-guide: gpio-properties: Clarify initial output state
Date:   Thu, 29 Oct 2020 21:32:43 +0200
Message-Id: <20201029193243.61546-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029193243.61546-1-andriy.shevchenko@linux.intel.com>
References: <20201029193243.61546-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

GpioIo() doesn't provide an explicit state for an output pin.
Linux tries to be smart and uses a common sense based on other
parameters. Document how it looks like in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v2: added Rb tag (Mika)
 .../firmware-guide/acpi/gpio-properties.rst   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index 370fe46c6af9..59aad6138b6e 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -61,6 +61,29 @@ must be 0. GpioInt() resource has its own means of defining it.
 In our Bluetooth example the "reset-gpios" refers to the second GpioIo()
 resource, second pin in that resource with the GPIO number of 31.
 
+The GpioIo() resource unfortunately doesn't explicitly provide an initial
+state of the output pin which driver should use during its initialization.
+
+Linux tries to use common sense here and derives the state from the bias
+and polarity settings. The table below shows the expectations:
+
+=========  =============  ==============
+Pull Bias     Polarity     Requested...
+=========  =============  ==============
+Implicit     x            AS IS (assumed firmware configured for us)
+Explicit     x (no _DSD)  as Pull Bias (Up == High, Down == Low),
+                          assuming non-active (Polarity = !Pull Bias)
+Down         Low          as low, assuming active
+Down         High         as low, assuming non-active
+Up           Low          as high, assuming non-active
+Up           High         as high, assuming active
+=========  =============  ==============
+
+That said, for our above example the both GPIOs, since the bias setting
+is explicit and _DSD is present, will be treated as active with a high
+polarity and Linux will configure the pins in this state until a driver
+reprograms them differently.
+
 It is possible to leave holes in the array of GPIOs. This is useful in
 cases like with SPI host controllers where some chip selects may be
 implemented as GPIOs and some as native signals. For example a SPI host
-- 
2.28.0

