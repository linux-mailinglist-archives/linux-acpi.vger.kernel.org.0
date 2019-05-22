Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12EA26278
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfEVKwJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:52:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbfEVKvf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:34 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:32 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 09/16] device connection: Find connections also by checking the references
Date:   Wed, 22 May 2019 13:51:06 +0300
Message-Id: <20190522105113.11153-10-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We can also use this API to find named references that the
device nodes have by using fwnode_property_get_reference_args()
function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c     | 26 ++++++++++++++++++++++++++
 drivers/usb/roles/class.c |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae235e4..f7035fc12b92 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -38,6 +38,28 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static void *
+fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+		    void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { };
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		con.fwnode = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(con.fwnode))
+			break;
+
+		ret = match(&con, -1, data);
+		fwnode_handle_put(con.fwnode);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -65,6 +87,10 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
 		if (ret)
 			return ret;
+
+		ret = fwnode_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
 	}
 
 	mutex_lock(&devcon_lock);
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index f45d8df5cfb8..86defca6623e 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -101,7 +101,7 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 	struct device *dev;
 
 	if (con->fwnode) {
-		if (!fwnode_property_present(con->fwnode, con->id))
+		if (con->id && !fwnode_property_present(con->fwnode, con->id))
 			return NULL;
 
 		dev = class_find_device(role_class, NULL, con->fwnode,
-- 
2.20.1

