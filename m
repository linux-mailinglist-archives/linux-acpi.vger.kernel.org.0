Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6576389007
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbhESOOJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:44091 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347116AbhESOOE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:04 -0400
IronPort-SDR: t8TwEIXxIvNMHuMbL6HbIn1TRnMYpGT1BPivoN7pG6loUfk5yLSgl8rP5LmlIjBm+JYFPFCT5h
 2mlHC3jAdaiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262212441"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262212441"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:45 -0700
IronPort-SDR: qwgYwJ55Dy6j5oqu5C77pEbBaMNVAYZSKVFGZtjNLYGd7+tpFtO3FwFcxw88qnCWHVDtzYZGDm
 OWHJyta9/EXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="394421818"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2021 07:12:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B26DE702; Wed, 19 May 2021 17:12:59 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 8/9] thunderbolt: Add WRITE_ONLY and AUTHENTICATE_ONLY NVM operations for retimers
Date:   Wed, 19 May 2021 17:12:58 +0300
Message-Id: <20210519141259.84839-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

The same way we support these two operations for USB4 routers we can
extend the retimer NVM operations to support retimers also.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         |  2 +-
 drivers/thunderbolt/retimer.c                 | 51 ++++++++++++++-----
 drivers/thunderbolt/tb.h                      |  2 +
 drivers/thunderbolt/usb4.c                    | 15 +++++-
 4 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index da580b504c87..95c21d6c9a84 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -221,7 +221,7 @@ Description:	When new NVM image is written to the non-active NVM
 		  and flush it to the storage area.
 		- Writing "3" will authenticate the image that is
 		  currently written in the storage area. This is only
-		  supported with USB4 devices.
+		  supported with USB4 devices and retimers.
 
 		When read holds status of the last authentication
 		operation if an error occurred during the process. This
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 05af0feefe84..3aa790aa6500 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -103,6 +103,7 @@ static int tb_retimer_nvm_validate_and_write(struct tb_retimer *rt)
 	unsigned int image_size, hdr_size;
 	const u8 *buf = rt->nvm->buf;
 	u16 ds_size, device;
+	int ret;
 
 	image_size = rt->nvm->buf_data_size;
 	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
@@ -140,8 +141,25 @@ static int tb_retimer_nvm_validate_and_write(struct tb_retimer *rt)
 	buf += hdr_size;
 	image_size -= hdr_size;
 
-	return usb4_port_retimer_nvm_write(rt->port, rt->index, 0, buf,
-					   image_size);
+	ret = usb4_port_retimer_nvm_write(rt->port, rt->index, 0, buf,
+					 image_size);
+	if (!ret)
+		rt->nvm->flushed = true;
+
+	return ret;
+}
+
+static int tb_retimer_nvm_authenticate(struct tb_retimer *rt, bool auth_only)
+{
+	int ret;
+
+	if (auth_only) {
+		ret = usb4_port_retimer_nvm_set_offset(rt->port, rt->index, 0);
+		if (ret)
+			return ret;
+	}
+
+	return usb4_port_retimer_nvm_authenticate(rt->port, rt->index);
 }
 
 static ssize_t device_show(struct device *dev, struct device_attribute *attr,
@@ -176,8 +194,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tb_retimer *rt = tb_to_retimer(dev);
-	bool val;
-	int ret;
+	int val, ret;
 
 	pm_runtime_get_sync(&rt->dev);
 
@@ -191,7 +208,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 		goto exit_unlock;
 	}
 
-	ret = kstrtobool(buf, &val);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		goto exit_unlock;
 
@@ -199,16 +216,22 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	rt->auth_status = 0;
 
 	if (val) {
-		if (!rt->nvm->buf) {
-			ret = -EINVAL;
-			goto exit_unlock;
+		if (val == AUTHENTICATE_ONLY) {
+			ret = tb_retimer_nvm_authenticate(rt, true);
+		} else {
+			if (!rt->nvm->flushed) {
+				if (!rt->nvm->buf) {
+					ret = -EINVAL;
+					goto exit_unlock;
+				}
+
+				ret = tb_retimer_nvm_validate_and_write(rt);
+				if (ret || val == WRITE_ONLY)
+					goto exit_unlock;
+			}
+			if (val == WRITE_AND_AUTHENTICATE)
+				ret = tb_retimer_nvm_authenticate(rt, false);
 		}
-
-		ret = tb_retimer_nvm_validate_and_write(rt);
-		if (ret)
-			goto exit_unlock;
-
-		ret = usb4_port_retimer_nvm_authenticate(rt->port, rt->index);
 	}
 
 exit_unlock:
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 53f6bb85b178..725104c83e3d 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1082,6 +1082,8 @@ int usb4_port_retimer_write(struct tb_port *port, u8 index, u8 reg,
 			    const void *buf, u8 size);
 int usb4_port_retimer_is_last(struct tb_port *port, u8 index);
 int usb4_port_retimer_nvm_sector_size(struct tb_port *port, u8 index);
+int usb4_port_retimer_nvm_set_offset(struct tb_port *port, u8 index,
+				     unsigned int address);
 int usb4_port_retimer_nvm_write(struct tb_port *port, u8 index,
 				unsigned int address, const void *buf,
 				size_t size);
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 76d7335aa440..ceddbe7e9f93 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1513,8 +1513,19 @@ int usb4_port_retimer_nvm_sector_size(struct tb_port *port, u8 index)
 	return ret ? ret : metadata & USB4_NVM_SECTOR_SIZE_MASK;
 }
 
-static int usb4_port_retimer_nvm_set_offset(struct tb_port *port, u8 index,
-					    unsigned int address)
+/**
+ * usb4_port_retimer_nvm_set_offset() - Set NVM write offset
+ * @port: USB4 port
+ * @index: Retimer index
+ * @address: Start offset
+ *
+ * Exlicitly sets NVM write offset. Normally when writing to NVM this is
+ * done automatically by usb4_port_retimer_nvm_write().
+ *
+ * Returns %0 in success and negative errno if there was a failure.
+ */
+int usb4_port_retimer_nvm_set_offset(struct tb_port *port, u8 index,
+				     unsigned int address)
 {
 	u32 metadata, dwaddress;
 	int ret;
-- 
2.30.2

