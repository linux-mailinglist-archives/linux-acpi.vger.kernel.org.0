Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04D129D4F9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 22:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJ1Vz6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 17:55:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:53633 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgJ1VyU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:20 -0400
IronPort-SDR: 0TZ02arCaffaWXgWLOpCvlGR1rGxEZkk1Ed2KdV86GX1WyQZ0IQLDpL+ZnNtXkPOkB/sV5eXra
 UtMXd0HoXTWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="232515258"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="232515258"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 13:51:04 -0700
IronPort-SDR: lUz14BhZ0bOy9bxk/dn+mhE+ng82CIC2VPK0JtiqKz9Yj3kiU+N+bDLuHCl4SsKP53GWej/8jw
 4NI17j8yw6yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="361254374"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2020 13:51:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51E204E1; Wed, 28 Oct 2020 22:51:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] Documentation: firmware-guide: gpio-properties: Clarify initial output state
Date:   Wed, 28 Oct 2020 22:51:01 +0200
Message-Id: <20201028205101.47583-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

GpioIo() doesn't provide an explicit state for an output pin.
Linux tries to be smart and uses a common sense based on other
parameters. Document how it looks like in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

