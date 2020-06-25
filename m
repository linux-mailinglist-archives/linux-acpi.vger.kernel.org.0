Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F220A99F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgFZAHT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jun 2020 20:07:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:31355 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFZAHS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jun 2020 20:07:18 -0400
IronPort-SDR: D9/DDZVMFhHFxPyMZxZiSmGNDCZ3nVjxrG2+DySLhaAuz7ZgRi7Ciw03IfnbOL8FMMAzZIrKcR
 BlBMVHWgsjcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="133533571"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="133533571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:18 -0700
IronPort-SDR: 76Ox8bokFZgyiPf263ilWt6Ewy5R1Ypt/xKK4Dm5hluCqIfGCUlvAhDrM6QsibCZ/3nZAGMAKW
 lHe2HlDkxb2g==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="453192861"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:18 -0700
Subject: [PATCH 08/12] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Jun 2020 16:51:03 -0700
Message-ID: <159312906372.1850128.11611897078988158727.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
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
sensitive attributes and an explicit helper with the _ADMIN_ identifier
for DEVICE_ATTR_ADMIN_{RO,RW}.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

