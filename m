Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7641C93C9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEGPJL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 11:09:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:51959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbgEGPJL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 11:09:11 -0400
IronPort-SDR: JHQzZOrils+cnIZOkyZRmmyzfrwStKKt/C1/5UoOeub1TdyXxvMXw4eiWtR6CyiHSLxJ3Ku1X9
 3BWGRIDcxA0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 08:09:10 -0700
IronPort-SDR: gmynGHQk0IViEpQLa+rwu7lXsYyoaa0EehZq5Gaps5+TSIqRYNHFlq0Hvxxr0LepVVQ/Vvh3iI
 Kkg3LQiYcEaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="370143323"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 08:09:08 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] usb: typec: Add firmware documentation for the Intel PMC mux control
Date:   Thu,  7 May 2020 18:08:59 +0300
Message-Id: <20200507150900.12102-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Adding documentation that describes how the PMC mux-agent
function is described in the ACPI tables.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../firmware-guide/acpi/intel-pmc-mux.rst     | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/firmware-guide/acpi/intel-pmc-mux.rst

diff --git a/Documentation/firmware-guide/acpi/intel-pmc-mux.rst b/Documentation/firmware-guide/acpi/intel-pmc-mux.rst
new file mode 100644
index 000000000000..99b86710f02b
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/intel-pmc-mux.rst
@@ -0,0 +1,153 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Intel North Mux-Agent
+=====================
+
+Introduction
+============
+
+North Mux-Agent is a function of the Intel PMC firmware that is supported on
+most Intel based platforms that have the PMC microcontroller. It's used for
+configuring the various USB Multiplexer/DeMultiplexers on the system. The
+platforms that allow the mux-agent to be configured from the operating system
+have an ACPI device object (node) with HID "INTC105C" that represents it.
+
+The North Mux-Agent (aka. Intel PMC Mux Control, or just mux-agent) driver
+communicates with the PMC microcontroller by using the PMC IPC method
+(drivers/platform/x86/intel_scu_ipc.c). The driver registers with the USB Type-C
+Mux Class which allows the USB Type-C Controller and Interface drivers to
+configure the cable plug orientation and mode (with Alternate Modes). The driver
+also registers with the USB Role Class in order to support both USB Host and
+Device modes. The driver is located here: drivers/usb/typec/mux/intel_pmc_mux.c.
+
+Port nodes
+==========
+
+General
+-------
+
+For every USB Type-C connector under the mux-agent control on the system, there
+is a separate child node under the PMC mux-agent device node. Those nodes do not
+represent the actual connectors, but instead the "channels" in the mux-agent
+that are associated with the connectors::
+
+	Scope (_SB.PCI0.PMC.MUX)
+	{
+	    Device (CH0)
+	    {
+		Name (_ADR, 0)
+	    }
+
+	    Device (CH1)
+	    {
+		Name (_ADR, 1)
+	    }
+	}
+
+_PLD (Physical Location of Device)
+----------------------------------
+
+The optional _PLD object can be used with the port (the channel) nodes. If _PLD
+is supplied, it should match the connector node _PLD::
+
+	Scope (_SB.PCI0.PMC.MUX)
+	{
+	    Device (CH0)
+	    {
+		Name (_ADR, 0)
+	        Method (_PLD, 0, NotSerialized)
+                {
+		    /* Consider this as pseudocode. */
+		    Return (\_SB.USBC.CON0._PLD())
+		}
+	    }
+	}
+
+Mux-agent specific _DSD Device Properties
+-----------------------------------------
+
+Port Numbers
+~~~~~~~~~~~~
+
+In order to configure the muxes behind a USB Type-C connector, the PMC firmware
+needs to know the USB2 port and the USB3 port that is associated with the
+connector. The driver extracts the correct port numbers by reading specific _DSD
+device properties named "usb2-port-number" and "usb3-port-number". These
+properties have integer value that means the port index. The port index number
+is 1's based, and value 0 is illegal. The driver uses the numbers extracted from
+these device properties as-is when sending the mux-agent specific messages to
+the PMC::
+
+	Name (_DSD, Package () {
+	    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+	    Package() {
+	        Package () {"usb2-port-number", 6},
+	        Package () {"usb3-port-number", 3},
+	    },
+	})
+
+Orientation
+~~~~~~~~~~~
+
+Depending on the platform, the data and SBU lines coming from the connector may
+be "fixed" from the mux-agent's point of view, which means the mux-agent driver
+should not configure them according to the cable plug orientation. This can
+happen for example if a retimer on the platform handles the cable plug
+orientation. The driver uses a specific device properties "sbu-orientation"
+(SBU) and "hsl-orientation" (data) to know if those lines are "fixed", and to
+which orientation. The value that these properties have is a string value, and
+it can be one that is defined for the USB Type-C connector orientation: "normal"
+or "reversed"::
+
+	Name (_DSD, Package () {
+	    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+	    Package() {
+	        Package () {"sbu-orientation", "normal"},
+	        Package () {"hsl-orientation", "normal"},
+	    },
+	})
+
+Example ASL
+===========
+
+The following ASL is an example that shows the mux-agent node, and two
+connectors under its control::
+
+	Scope (_SB.PCI0.PMC)
+	{
+	    Device (MUX)
+	    {
+	        Name (_HID, "INTC105C")
+
+	        Device (CH0)
+	        {
+	            Name (_ADR, 0)
+
+	            Name (_DSD, Package () {
+	                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+	                Package() {
+	                    Package () {"usb2-port-number", 6},
+	                    Package () {"usb3-port-number", 3},
+	                    Package () {"sbu-orientation", "normal"},
+	                    Package () {"hsl-orientation", "normal"},
+	                },
+	            })
+	        }
+
+	        Device (CH1)
+	        {
+	            Name (_ADR, 1)
+
+	            Name (_DSD, Package () {
+	                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+	                Package() {
+	                    Package () {"usb2-port-number", 5},
+	                    Package () {"usb3-port-number", 2},
+	                    Package () {"sbu-orientation", "normal"},
+	                    Package () {"hsl-orientation", "normal"},
+	                },
+	            })
+	        }
+	    }
+	}
-- 
2.26.2

