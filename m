Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D672F17DE
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 15:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbhAKOPv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 09:15:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:16819 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbhAKOPu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 09:15:50 -0500
IronPort-SDR: 33Lji3lI5WhBwd9SZKlASCbz2XQJAUBkjlHFasLyhgnSj7cbzc37lVFECPC5o5Y7wP7Yvdlfqy
 SYdZXZdSFEDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157645656"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157645656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 06:10:56 -0800
IronPort-SDR: 80nKZa5+vzdWdub2518utsZrmhx4RamZ6dnQTww03pLys3O8rRQnG8fFqiXFEZ0EuWSa0S4QD8
 Qmk152lNN33w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464171628"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 06:10:54 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 3/3] usb: dwc3: pci: ID for Tiger Lake CPU
Date:   Mon, 11 Jan 2021 17:10:45 +0300
Message-Id: <20210111141045.14027-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tiger Lake SOC (the versions of it that have integrated USB4
controller) may have two DWC3 controllers. One is part of
the PCH (Platform Controller Hub, i.e. the chipset) as
usual, and the other is inside the actual CPU block.

On all Intel platforms that have the two separate DWC3
controllers, the one inside the CPU handles USB3 and only
USB3 traffic, while the PCH version handles USB2 and USB2
alone. The reason for splitting the two busses like this is
to allow easy USB3 tunneling over USB4 connections. As USB2
is not tunneled over USB4, it has dedicated USB controllers
(both xHCI and DWC3).

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 037bc21bffa66..51029cec119ed 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -41,6 +41,7 @@
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
 #define PCI_DEVICE_ID_INTEL_JSP			0x4dee
 #define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
+#define PCI_DEVICE_ID_INTEL_TGL			0x9a15
 
 #define PCI_INTEL_BXT_DSM_GUID		"732b85d5-b7a7-4a1b-9ba0-4bbd00ffd511"
 #define PCI_INTEL_BXT_FUNC_PMU_PWR	4
@@ -384,6 +385,9 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLS),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGL),
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
+
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB),
 	  (kernel_ulong_t) &dwc3_pci_amd_swnode, },
 	{  }	/* Terminating Entry */
-- 
2.29.2

