Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CE30433F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404398AbhAZP7n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 10:59:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:33515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404401AbhAZP7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 10:59:17 -0500
IronPort-SDR: CO34Df8XAU24WbLREn4D2SqWDHn6pa+UTSbqPyw4892Lx9GeOlz46AL2YnHEs2bqjCinDTslFV
 5fyoFosm2vIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180066869"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="180066869"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:28 -0800
IronPort-SDR: 2BvbJ83PtWtTzwiSEdoW5oz/CKkDYJdafRsEiBYkgmqDLzj/owbFQwpIZYM5Yx1POD4TRFnXFF
 pKpXDdaCnVtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="402785447"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2021 07:57:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2F26D17F; Tue, 26 Jan 2021 17:57:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/6] thunderbolt: Add support for PCIe tunneling disabled (SL5)
Date:   Tue, 26 Jan 2021 18:57:19 +0300
Message-Id: <20210126155723.9388-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Recent Intel Thunderbolt firmware connection manager has support for
another security level, SL5, that disables PCIe tunneling. This option
can be turned on from the BIOS.

When this is set the driver exposes a new security level "nopcie" to the
userspace and hides the authorized attribute under connected devices.

While there we also hide it when "dponly" security level is enabled
since it is not really usable in that case anyway.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-thunderbolt |  2 ++
 Documentation/admin-guide/thunderbolt.rst       |  7 +++++++
 drivers/thunderbolt/domain.c                    | 12 +++++++++++-
 drivers/thunderbolt/switch.c                    |  6 +++++-
 include/linux/thunderbolt.h                     |  3 +++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 581dea95245b..d7f09d011b6d 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -85,6 +85,8 @@ Description:	This attribute holds current Thunderbolt security level
 		usbonly  Automatically tunnel USB controller of the
 			 connected Thunderbolt dock (and Display Port). All
 			 PCIe links downstream of the dock are removed.
+		nopcie   USB4 system where PCIe tunneling is disabled from
+			 the BIOS.
 		=======  ==================================================
 
 What: /sys/bus/thunderbolt/devices/.../authorized
diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/admin-guide/thunderbolt.rst
index 0d4348445f91..f18e881373c4 100644
--- a/Documentation/admin-guide/thunderbolt.rst
+++ b/Documentation/admin-guide/thunderbolt.rst
@@ -47,6 +47,9 @@ be DMA masters and thus read contents of the host memory without CPU and OS
 knowing about it. There are ways to prevent this by setting up an IOMMU but
 it is not always available for various reasons.
 
+Some USB4 systems have a BIOS setting to disable PCIe tunneling. This is
+treated as another security level (nopcie).
+
 The security levels are as follows:
 
   none
@@ -77,6 +80,10 @@ The security levels are as follows:
     Display Port in a dock. All PCIe links downstream of the dock are
     removed.
 
+  nopcie
+    PCIe tunneling is disabled/forbidden from the BIOS. Available in some
+    USB4 systems.
+
 The current security level can be read from
 ``/sys/bus/thunderbolt/devices/domainX/security`` where ``domainX`` is
 the Thunderbolt domain the host controller manages. There is typically
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 9ba2181464cc..a1c79c9c4f66 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -118,6 +118,7 @@ static const char * const tb_security_names[] = {
 	[TB_SECURITY_SECURE] = "secure",
 	[TB_SECURITY_DPONLY] = "dponly",
 	[TB_SECURITY_USBONLY] = "usbonly",
+	[TB_SECURITY_NOPCIE] = "nopcie",
 };
 
 static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
@@ -243,8 +244,14 @@ static ssize_t deauthorization_show(struct device *dev,
 				    char *buf)
 {
 	const struct tb *tb = container_of(dev, struct tb, dev);
+	bool deauthorization = false;
 
-	return sprintf(buf, "%d\n", !!tb->cm_ops->disapprove_switch);
+	/* Only meaningful if authorization is supported */
+	if (tb->security_level == TB_SECURITY_USER ||
+	    tb->security_level == TB_SECURITY_SECURE)
+		deauthorization = !!tb->cm_ops->disapprove_switch;
+
+	return sprintf(buf, "%d\n", deauthorization);
 }
 static DEVICE_ATTR_RO(deauthorization);
 
@@ -452,6 +459,9 @@ int tb_domain_add(struct tb *tb)
 			goto err_ctl_stop;
 	}
 
+	tb_dbg(tb, "security level set to %s\n",
+	       tb_security_names[tb->security_level]);
+
 	ret = device_add(&tb->dev);
 	if (ret)
 		goto err_ctl_stop;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cdba05e72486..60fd92113740 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1768,7 +1768,11 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	if (attr == &dev_attr_device.attr) {
+	if (attr == &dev_attr_authorized.attr) {
+		if (sw->tb->security_level == TB_SECURITY_NOPCIE ||
+		    sw->tb->security_level == TB_SECURITY_DPONLY)
+			return 0;
+	} else if (attr == &dev_attr_device.attr) {
 		if (!sw->device)
 			return 0;
 	} else if (attr == &dev_attr_device_name.attr) {
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 034dccf93955..659a0a810fa1 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -45,6 +45,8 @@ enum tb_cfg_pkg_type {
  * @TB_SECURITY_USBONLY: Only tunnel USB controller of the connected
  *			 Thunderbolt dock (and Display Port). All PCIe
  *			 links downstream of the dock are removed.
+ * @TB_SECURITY_NOPCIE: For USB4 systems this level is used when the
+ *			PCIe tunneling is disabled from the BIOS.
  */
 enum tb_security_level {
 	TB_SECURITY_NONE,
@@ -52,6 +54,7 @@ enum tb_security_level {
 	TB_SECURITY_SECURE,
 	TB_SECURITY_DPONLY,
 	TB_SECURITY_USBONLY,
+	TB_SECURITY_NOPCIE,
 };
 
 /**
-- 
2.29.2

