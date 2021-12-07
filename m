Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F446BDE9
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Dec 2021 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhLGOlg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Dec 2021 09:41:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:48412 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237998AbhLGOlf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Dec 2021 09:41:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237528445"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237528445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="657725119"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2021 06:38:02 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] usb: Link the ports to the connectors they are attached to
Date:   Tue,  7 Dec 2021 17:37:55 +0300
Message-Id: <20211207143757.21895-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Creating link to the USB Type-C connector for every new port
that is added when possible.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
 drivers/usb/core/port.c                 | 32 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 2ebe5708b4bc0..7efe31ed3a25c 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -244,6 +244,15 @@ Description:
 		is permitted, "u2" if only u2 is permitted, "u1_u2" if both u1 and
 		u2 are permitted.
 
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/connector
+Date:		December 2021
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Link to the USB Type-C connector when available. This link is
+		only created when USB Type-C Connector Class is enabled, and
+		only if the system firmware is capable of describing the
+		connection between a port and its connector.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index dfcca9c876c73..c2bbf97a79bec 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/component.h>
 
 #include "hub.h"
 
@@ -528,6 +529,32 @@ static void find_and_link_peer(struct usb_hub *hub, int port1)
 		link_peers_report(port_dev, peer);
 }
 
+static int connector_bind(struct device *dev, struct device *connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &connector->kobj, "connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&connector->kobj, &dev->kobj, dev_name(dev));
+	if (ret)
+		sysfs_remove_link(&dev->kobj, "connector");
+
+	return ret;
+}
+
+static void connector_unbind(struct device *dev, struct device *connector, void *data)
+{
+	sysfs_remove_link(&connector->kobj, dev_name(dev));
+	sysfs_remove_link(&dev->kobj, "connector");
+}
+
+static const struct component_ops connector_ops = {
+	.bind = connector_bind,
+	.unbind = connector_unbind,
+};
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -577,6 +604,10 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 
 	find_and_link_peer(hub, port1);
 
+	retval = component_add(&port_dev->dev, &connector_ops);
+	if (retval)
+		dev_warn(&port_dev->dev, "failed to add component\n");
+
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()
 	 * will drop once the PM_QOS_NO_POWER_OFF flag state has been set
@@ -619,5 +650,6 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	component_del(&port_dev->dev, &connector_ops);
 	device_unregister(&port_dev->dev);
 }
-- 
2.33.0

