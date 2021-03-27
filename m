Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8734B9D2
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhC0WUl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:65376 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhC0WUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:17 -0400
IronPort-SDR: Xoq7TagD7rdSeABGU20yDwb7C1SndxULbZfqA/QSpUv63EgOCoPrfAgRZ5SUt3avb8TvAvEYbU
 IdurenMTkIcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="190792949"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="190792949"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:16 -0700
IronPort-SDR: Fm30aeXPCvAm5sdq9f22Q7ZzXtWWAW+bh5SrIxPsTasYOT1OuV3Y9X7Y5AC0VxWy5KLtXNEbka
 iRjLdNX/M3zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="594591281"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2021 15:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C980411F; Sun, 28 Mar 2021 00:20:27 +0200 (EET)
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
Subject: [PATCH v1 1/8] software node: Free resources explicitly when swnode_register() fails
Date:   Sun, 28 Mar 2021 00:20:05 +0200
Message-Id: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently we have a slightly twisted logic in swnode_register().
It frees resources that it doesn't allocate on error path and
in once case it relies on the ->release() implementation.

Untwist the logic by freeing resources explicitly when swnode_register()
fails. Currently it happens only in fwnode_create_software_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index fa3719ef80e4..456f5fe58b58 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -767,22 +767,19 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	int ret;
 
 	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
-	if (!swnode) {
-		ret = -ENOMEM;
-		goto out_err;
-	}
+	if (!swnode)
+		return ERR_PTR(-ENOMEM);
 
 	ret = ida_simple_get(parent ? &parent->child_ids : &swnode_root_ids,
 			     0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(swnode);
-		goto out_err;
+		return ERR_PTR(ret);
 	}
 
 	swnode->id = ret;
 	swnode->node = node;
 	swnode->parent = parent;
-	swnode->allocated = allocated;
 	swnode->kobj.kset = swnode_kset;
 	fwnode_init(&swnode->fwnode, &software_node_ops);
 
@@ -803,16 +800,17 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * Assign the flag only in the successful case, so
+	 * the above kobject_put() won't mess up with properties.
+	 */
+	swnode->allocated = allocated;
+
 	if (parent)
 		list_add_tail(&swnode->entry, &parent->children);
 
 	kobject_uevent(&swnode->kobj, KOBJ_ADD);
 	return &swnode->fwnode;
-
-out_err:
-	if (allocated)
-		property_entries_free(node->properties);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -963,6 +961,7 @@ struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent)
 {
+	struct fwnode_handle *fwnode;
 	struct software_node *node;
 	struct swnode *p = NULL;
 	int ret;
@@ -987,7 +986,13 @@ fwnode_create_software_node(const struct property_entry *properties,
 
 	node->parent = p ? p->node : NULL;
 
-	return swnode_register(node, p, 1);
+	fwnode = swnode_register(node, p, 1);
+	if (IS_ERR(fwnode)) {
+		property_entries_free(node->properties);
+		kfree(node);
+	}
+
+	return fwnode;
 }
 EXPORT_SYMBOL_GPL(fwnode_create_software_node);
 
-- 
2.30.2

