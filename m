Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B725A2163CA
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 04:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGGCPd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 22:15:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:6131 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgGGCPc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 22:15:32 -0400
IronPort-SDR: 9H6lfX4oenwTfrwH3YGkEDtGgDyUCv9mwSUam45j4BzCbE06VdveUkHHAUppi3Zd5joMJ8gh7X
 YhSHRr7jllmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135773833"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="135773833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:32 -0700
IronPort-SDR: p964sKowv8pQxg4gDuyjfX52+jWJ/wp2F14EjBK4GbqgsChN4O7vAXRJL+BI1E4+94JlmtR/0s
 vYuY0HEIF+xg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="297197361"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:31 -0700
Subject: [PATCH v2 08/12] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 18:59:16 -0700
Message-ID: <159408715653.2385045.10226724984566744787.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A common pattern for using plain DEVICE_ATTR() instead of
DEVICE_ATTR_RO() and DEVICE_ATTR_RW() is for attributes that want to
limit read to only root.  I.e. many users of DEVICE_ATTR() are
specifying 0400 or 0600 for permissions.

Given the expectation that CAP_SYS_ADMIN is needed to access these
sensitive attributes add an explicit helper with the _ADMIN_ identifier
for DEVICE_ATTR_ADMIN_{RO,RW}.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/device.h |    4 ++++
 include/linux/sysfs.h  |    7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024..d7c2570368fa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -128,8 +128,12 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 		__ATTR_PREALLOC(_name, _mode, _show, _store)
 #define DEVICE_ATTR_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
+#define DEVICE_ATTR_ADMIN_RW(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
 #define DEVICE_ATTR_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
+#define DEVICE_ATTR_ADMIN_RO(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
 #define DEVICE_ATTR_WO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
 #define DEVICE_ULONG_ATTR(_name, _mode, _var) \
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 86067dbe7745..34e84122f635 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -123,6 +123,13 @@ struct attribute_group {
 	.show	= _name##_show,						\
 }
 
+#define __ATTR_RW_MODE(_name, _mode) {					\
+	.attr	= { .name = __stringify(_name),				\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+	.show	= _name##_show,						\
+	.store	= _name##_store,					\
+}
+
 #define __ATTR_WO(_name) {						\
 	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
 	.store	= _name##_store,					\

