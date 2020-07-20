Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9122724F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 00:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGTWYZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 18:24:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:33768 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGTWYZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 18:24:25 -0400
IronPort-SDR: o6TgkDfu2QLyI10ecnrGTMCAC58rCrVrPIjsJm1aR4yuEzg5ctE4W1X6XU6XGNeIeWGSfA2kR0
 PA2a8YHzzsJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="147966589"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="147966589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:24 -0700
IronPort-SDR: 6FBNJWGcBCpI6Zitti5qkNj5ViUANRiDp9dki/pzUJ2cDoPQlHm56Ujj6bdgEFw/GG5LoCZKHw
 9QAL2uhUPbXw==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="271553180"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:24 -0700
Subject: [PATCH v3 08/11] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 15:08:07 -0700
Message-ID: <159528288766.993790.5647904882591265970.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
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

