Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B925FA25
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgIGMHd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 08:07:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:8886 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgIGMFj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:05:39 -0400
IronPort-SDR: schj4sZXXsm3jR4qgi3fIKafDUyqKRG8lBJyJu0pNTxIkhz9KdWiJKFsCOTy4VThq5bPgIbJtt
 mkT5Q9IYsIaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="138043156"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="138043156"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:05:38 -0700
IronPort-SDR: u3kyUqM+DzJMN1nqoCID/BSaawI1ZfVxVB69PrOnOu6JskkaUh9tjcBJrtNahUNpfu4CURW2SH
 7lg5Fl5hEiRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406818249"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 05:05:37 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation: Remove device connection documentation
Date:   Mon,  7 Sep 2020 15:05:32 +0300
Message-Id: <20200907120532.37611-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
References: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The API that allowed device connection descriptions to
be added is now removed, so removing also the documentation
for it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../driver-api/device_connection.rst          | 43 -------------------
 Documentation/driver-api/index.rst            |  1 -
 2 files changed, 44 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
deleted file mode 100644
index ba364224c349b..0000000000000
--- a/Documentation/driver-api/device_connection.rst
+++ /dev/null
@@ -1,43 +0,0 @@
-==================
-Device connections
-==================
-
-Introduction
-------------
-
-Devices often have connections to other devices that are outside of the direct
-child/parent relationship. A serial or network communication controller, which
-could be a PCI device, may need to be able to get a reference to its PHY
-component, which could be attached for example to the I2C bus. Some device
-drivers need to be able to control the clocks or the GPIOs for their devices,
-and so on.
-
-Device connections are generic descriptions of any type of connection between
-two separate devices.
-
-Device connections alone do not create a dependency between the two devices.
-They are only descriptions which are not tied to either of the devices directly.
-A dependency between the two devices exists only if one of the two endpoint
-devices requests a reference to the other. The descriptions themselves can be
-defined in firmware (not yet supported) or they can be built-in.
-
-Usage
------
-
-Device connections should exist before device ``->probe`` callback is called for
-either endpoint device in the description. If the connections are defined in
-firmware, this is not a problem. It should be considered if the connection
-descriptions are "built-in", and need to be added separately.
-
-The connection description consists of the names of the two devices with the
-connection, i.e. the endpoints, and unique identifier for the connection which
-is needed if there are multiple connections between the two devices.
-
-After a description exists, the devices in it can request reference to the other
-endpoint device, or they can request the description itself.
-
-API
----
-
-.. kernel-doc:: drivers/base/devcon.c
-   :functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 5ef2cfe3a16b3..6e7c702e0268d 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -22,7 +22,6 @@ available subsections can be seen below.
    pm/index
    clk
    device-io
-   device_connection
    dma-buf
    device_link
    component
-- 
2.28.0

