Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3581B30FE2
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfEaOQI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfEaOQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:08 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:06 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 08/16] device property: Introduce fwnode_find_reference()
Date:   Fri, 31 May 2019 17:15:39 +0300
Message-Id: <20190531141547.22728-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In most cases the references that the drivers look for don't
have any arguments. This introduces a wrapper function for
fwnode_property_get_reference_args() that looks for
references by using only the name and index.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/property.c  | 24 ++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 348b37e64944..81bd01ed4042 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -484,6 +484,30 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
+/**
+ * fwnode_find_reference - Find named reference to a fwnode_handle
+ * @fwnode: Firmware node where to look for the reference
+ * @name: The name of the reference
+ * @index: Index of the reference
+ *
+ * @index can be used when the named reference holds a table of references.
+ *
+ * Returns pointer to the reference fwnode, or ERR_PTR. Caller is responsible to
+ * call fwnode_handle_put() on the returned fwnode pointer.
+ */
+struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
+					    const char *name,
+					    unsigned int index)
+{
+	struct fwnode_reference_args args;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(fwnode, name, NULL, 0, index,
+						 &args);
+	return ret ? ERR_PTR(ret) : args.fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_find_reference);
+
 /**
  * device_remove_properties - Remove properties from a device object.
  * @dev: Device whose properties to remove.
diff --git a/include/linux/property.h b/include/linux/property.h
index abcde2f236a0..088d4db7e949 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -79,6 +79,10 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
 
+struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
+					    const char *name,
+					    unsigned int index);
+
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.20.1

