Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518592626F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfEVKvY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:51:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbfEVKvY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:24 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:22 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 04/16] software node: Use kobject name when finding child nodes by name
Date:   Wed, 22 May 2019 13:51:01 +0300
Message-Id: <20190522105113.11153-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using the kobject name of the node instead of a device
property "name" in software_node_get_named_child_node().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ef1a48fec718..2d925fc2255f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -546,17 +546,13 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 				   const char *childname)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-	const struct property_entry *prop;
 	struct swnode *child;
 
 	if (!swnode || list_empty(&swnode->children))
 		return NULL;
 
 	list_for_each_entry(child, &swnode->children, entry) {
-		prop = property_entry_get(child->node->properties, "name");
-		if (!prop)
-			continue;
-		if (!strcmp(childname, prop->value.str)) {
+		if (!strcmp(childname, kobject_name(&child->kobj))) {
 			kobject_get(&child->kobj);
 			return &child->fwnode;
 		}
-- 
2.20.1

