Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8D25F88F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgIGKiC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 06:38:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:32891 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgIGKh5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 06:37:57 -0400
IronPort-SDR: mZeD8wls5F5S2Bi3ZWanrzBVDKRpcn/cs4d74C0lvU9NckviAtIAsEy0QENsW72Flf1e2JBYR6
 FVhljztSfHJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="219541987"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="219541987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 03:37:56 -0700
IronPort-SDR: 2v0jBQexHQ1isO8h0VOFHpNc+pVLmUp3rTELXM7y3KUnzYbpWMUdZNmxwD4TVIr4bOn5Dqg/zd
 3Ip2RUA055Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406801326"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 03:37:55 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] Documentation: Remove device connection documentation
Date:   Mon,  7 Sep 2020 13:37:50 +0300
Message-Id: <20200907103750.9093-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907103750.9093-1-heikki.krogerus@linux.intel.com>
References: <20200907103750.9093-1-heikki.krogerus@linux.intel.com>
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
 1 file changed, 43 deletions(-)
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
-- 
2.28.0

