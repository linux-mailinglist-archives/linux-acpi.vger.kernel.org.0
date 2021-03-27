Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF8234B9D5
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhC0WUm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:65376 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhC0WUU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:20 -0400
IronPort-SDR: Q7Ero3yrRke3CGQyaRc7UAtqiJhfTfddVO3lbdCc7cuR/xNSU7w8StPBvJnwadObDS7jBtXHZv
 MNi6m0VqI6hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="190792953"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="190792953"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:20 -0700
IronPort-SDR: LhG7xf+BuoyNl4R4hy8jxmugAsxSSOE8VsQgak4lujKzEqWNii4HddQ+TONzEADfJsGOn9JkMi
 MO7VYCMrzlUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="605906453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2021 15:20:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0B0D9CDD; Sun, 28 Mar 2021 00:20:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 6/8] software node: Simplify swnode_register() a bit
Date:   Sun, 28 Mar 2021 00:20:10 +0200
Message-Id: <20210327222012.54103-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By introducing two temporary variables simplify swnode_register() a bit.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ae53c48f84b1..1e81aaf5f6a1 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -894,6 +894,8 @@ static struct fwnode_handle *
 swnode_register(const struct software_node *node, struct swnode *parent,
 		unsigned int allocated)
 {
+	struct ida *ids = parent ? &parent->child_ids : &swnode_root_ids;
+	struct kobject *kobj_parent = parent ? &parent->kobj : NULL;
 	struct swnode *swnode;
 	int ret;
 
@@ -901,8 +903,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	if (!swnode)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(parent ? &parent->child_ids : &swnode_root_ids,
-			     0, 0, GFP_KERNEL);
+	ret = ida_simple_get(ids, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(swnode);
 		return ERR_PTR(ret);
@@ -920,12 +921,10 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 
 	if (node->name)
 		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-					   parent ? &parent->kobj : NULL,
-					   "%s", node->name);
+					   kobj_parent, "%s", node->name);
 	else
 		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-					   parent ? &parent->kobj : NULL,
-					   "node%d", swnode->id);
+					   kobj_parent, "node%d", swnode->id);
 	if (ret) {
 		kobject_put(&swnode->kobj);
 		return ERR_PTR(ret);
-- 
2.30.2

