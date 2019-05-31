Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9466130FD5
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEaOPz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:15:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfEaOPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:15:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:15:54 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:15:53 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 02/16] software node: Simplify software_node_release() function
Date:   Fri, 31 May 2019 17:15:33 +0300
Message-Id: <20190531141547.22728-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's possible to release the node ID immediately when
fwnode_remove_software_node() is called, no need to wait for
software_node_release() with that.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/swnode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 30077454eb68..7b321bf8424c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -557,13 +557,6 @@ static void software_node_release(struct kobject *kobj)
 {
 	struct software_node *swnode = kobj_to_swnode(kobj);
 
-	if (swnode->parent) {
-		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
-		list_del(&swnode->entry);
-	} else {
-		ida_simple_remove(&swnode_root_ids, swnode->id);
-	}
-
 	ida_destroy(&swnode->child_ids);
 	property_entries_free(swnode->properties);
 	kfree(swnode);
@@ -610,9 +603,6 @@ fwnode_create_software_node(const struct property_entry *properties,
 	INIT_LIST_HEAD(&swnode->children);
 	swnode->parent = p;
 
-	if (p)
-		list_add_tail(&swnode->entry, &p->children);
-
 	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
 				   p ? &p->kobj : NULL, "node%d", swnode->id);
 	if (ret) {
@@ -626,6 +616,9 @@ fwnode_create_software_node(const struct property_entry *properties,
 		return ERR_PTR(ret);
 	}
 
+	if (p)
+		list_add_tail(&swnode->entry, &p->children);
+
 	kobject_uevent(&swnode->kobj, KOBJ_ADD);
 	return &swnode->fwnode;
 }
@@ -638,6 +631,13 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 	if (!swnode)
 		return;
 
+	if (swnode->parent) {
+		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
+		list_del(&swnode->entry);
+	} else {
+		ida_simple_remove(&swnode_root_ids, swnode->id);
+	}
+
 	kobject_put(&swnode->kobj);
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
-- 
2.20.1

