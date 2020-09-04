Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D725D8F6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgIDMvb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 08:51:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:65320 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgIDMv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 08:51:28 -0400
IronPort-SDR: 7xDDal0LZIPoUCZ/brb28xw00hXN/ikrOliYB7F/UWtSlNmzVHc+LQoA7SxJOROE1+KipO1CvL
 sJ/vopDsGvQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="221944953"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="221944953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 05:51:28 -0700
IronPort-SDR: MkbYrqDk36fw4OU4au8dgcDQPSSGcg8WlZ3N775UkmoI54ioIOXddtaJs/irQDt6g+TRqvhJg8
 OE88fuO/5fdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="405834936"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2020 05:51:26 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/4] device connection: Remove device_connection_find()
Date:   Fri,  4 Sep 2020 15:51:20 +0300
Message-Id: <20200904125123.83725-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
References: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are no users for that function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c  | 73 ------------------------------------------
 include/linux/device.h |  2 --
 2 files changed, 75 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 14e2178e09f83..51ad546303ddb 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -133,79 +133,6 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 }
 EXPORT_SYMBOL_GPL(device_connection_find_match);
 
-extern struct bus_type platform_bus_type;
-extern struct bus_type pci_bus_type;
-extern struct bus_type i2c_bus_type;
-extern struct bus_type spi_bus_type;
-
-static struct bus_type *generic_match_buses[] = {
-	&platform_bus_type,
-#ifdef CONFIG_PCI
-	&pci_bus_type,
-#endif
-#ifdef CONFIG_I2C
-	&i2c_bus_type,
-#endif
-#ifdef CONFIG_SPI_MASTER
-	&spi_bus_type,
-#endif
-	NULL,
-};
-
-static void *device_connection_fwnode_match(struct device_connection *con)
-{
-	struct bus_type *bus;
-	struct device *dev;
-
-	for (bus = generic_match_buses[0]; bus; bus++) {
-		dev = bus_find_device_by_fwnode(bus, con->fwnode);
-		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
-			return dev;
-
-		put_device(dev);
-	}
-	return NULL;
-}
-
-/* This tries to find the device from the most common bus types by name. */
-static void *generic_match(struct device_connection *con, int ep, void *data)
-{
-	struct bus_type *bus;
-	struct device *dev;
-
-	if (con->fwnode)
-		return device_connection_fwnode_match(con);
-
-	for (bus = generic_match_buses[0]; bus; bus++) {
-		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
-		if (dev)
-			return dev;
-	}
-
-	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the other device to show up.
-	 */
-	return ERR_PTR(-EPROBE_DEFER);
-}
-
-/**
- * device_connection_find - Find two devices connected together
- * @dev: Device with the connection
- * @con_id: Identifier for the connection
- *
- * Find a connection with unique identifier @con_id between @dev and
- * another device. On success returns handle to the device that is connected
- * to @dev, with the reference count for the found device incremented. Returns
- * NULL if no matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a
- * connection was found but the other device has not been enumerated yet.
- */
-struct device *device_connection_find(struct device *dev, const char *con_id)
-{
-	return device_connection_find_match(dev, con_id, NULL, generic_match);
-}
-EXPORT_SYMBOL_GPL(device_connection_find);
-
 /**
  * device_connection_add - Register a connection description
  * @con: The connection description to be registered
diff --git a/include/linux/device.h b/include/linux/device.h
index 1c78621fc3c01..4a98cd2d442c7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -319,8 +319,6 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 void *device_connection_find_match(struct device *dev, const char *con_id,
 				   void *data, devcon_match_fn_t match);
 
-struct device *device_connection_find(struct device *dev, const char *con_id);
-
 void device_connection_add(struct device_connection *con);
 void device_connection_remove(struct device_connection *con);
 
-- 
2.28.0

