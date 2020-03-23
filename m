Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546A318FE3C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Mar 2020 20:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgCWTzs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Mar 2020 15:55:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:63557 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCWTzs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Mar 2020 15:55:48 -0400
IronPort-SDR: V+YADPK+c+cy1HPF2ntklSIz8XkYYNJT8O+uXaQdAvVnJVxBvaodpyNlopThNcmGBz4AtHKigG
 +7DzaMCESgvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:55:47 -0700
IronPort-SDR: GkUSmEDGXADXUGzv+vM/PvPrrIgt6AA7AKWJVbEOlQmSkaKHPHFu3YQsbfCddWyR3Dwy/RElBV
 StY9pnHwTE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="419623397"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 12:55:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 68C4914B; Mon, 23 Mar 2020 21:55:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] usb: core: Add ACPI support for USB interfaces
Date:   Mon, 23 Mar 2020 21:55:43 +0200
Message-Id: <20200323195543.51050-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI companion of the device has to be set for USB interfaces
in order to read and attach the properties described in the ACPI table.
Use ACPI_COMPANION_SET macro to set this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/core/message.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 5adf489428aa..d5f834f16993 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -5,6 +5,7 @@
  * Released under the GPLv2 only.
  */
 
+#include <linux/acpi.h>
 #include <linux/pci.h>	/* for scatterlist macros */
 #include <linux/usb.h>
 #include <linux/module.h>
@@ -1941,6 +1942,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 			intf->dev.of_node = usb_of_get_interface_node(dev,
 					configuration, ifnum);
 		}
+		ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
 		intf->dev.driver = NULL;
 		intf->dev.bus = &usb_bus_type;
 		intf->dev.type = &usb_if_device_type;
-- 
2.25.1

