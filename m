Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870B22F75E7
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbhAOJw2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 04:52:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:51117 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbhAOJw1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 04:52:27 -0500
IronPort-SDR: V9n0IZqqLGcF/MWWZWF6UxPih8NdNvXYA5bFBi1QEUVHWNXLhMT7gicweslN+QNktgc7LLJQeU
 fEghD05DKSTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166195741"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166195741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:49:28 -0800
IronPort-SDR: rwaTZ4a1Tqz8CAN764orIUjovWeFNTacOHQ+WPIUXIlWBuQ9WPDfWdKDRshFrY+qFjoNW0TTgn
 zv/TplXA7iNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="465538747"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 01:49:25 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 4/4] usb: dwc3: pci: add support for the Intel Alder Lake-P
Date:   Fri, 15 Jan 2021 12:49:14 +0300
Message-Id: <20210115094914.88401-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch adds the necessary PCI ID for Intel Alder Lake-P
devices.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 51029cec119ed..3d3918a8d5fbc 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -40,6 +40,7 @@
 #define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
 #define PCI_DEVICE_ID_INTEL_JSP			0x4dee
+#define PCI_DEVICE_ID_INTEL_ADLP		0x51ee
 #define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
 
@@ -382,6 +383,9 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLP),
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
+
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLS),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
-- 
2.29.2

