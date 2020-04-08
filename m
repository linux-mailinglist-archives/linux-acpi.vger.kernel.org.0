Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B843E1A26E2
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Apr 2020 18:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgDHQJd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Apr 2020 12:09:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:25663 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbgDHQJb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:31 -0400
IronPort-SDR: 4sr+lDj9e8L9d9pyuf6VCuhKeUwcg61Fkk6CiHOUaGc1fVAeZo7eeQ8khGcKd7brsXhwsZldRg
 lI9OsqdL6rsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:31 -0700
IronPort-SDR: TjA+ciCjEebbP61BDavfwtxOOiIohUJ+M1KKjf1Vg1wm76UFFko+STHBvYiJL5I/8s4Lv760+3
 SJz20DewCbcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="361882381"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2020 09:09:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B61A1FD; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/6] software node: Allow register and unregister software node groups
Date:   Wed,  8 Apr 2020 19:09:02 +0300
Message-Id: <20200408160905.12101-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sometimes it's more convenient to register a set of individual software nodes
grouped together. Add couple of functions for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c    | 48 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index de8d3543e8fe..2079937ddb51 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -726,6 +726,54 @@ void software_node_unregister_nodes(const struct software_node *nodes)
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
 
+/**
+ * software_node_register_node_group - Register a group of software nodes
+ * @node_group: NULL terminated array of software node pointers to be registered
+ *
+ * Register multiple software nodes at once.
+ */
+int software_node_register_node_group(const struct software_node **node_group)
+{
+	unsigned int i;
+	int ret;
+
+	if (!node_group)
+		return 0;
+
+	for (i = 0; node_group[i]; i++) {
+		ret = software_node_register(node_group[i]);
+		if (ret) {
+			software_node_unregister_node_group(node_group);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(software_node_register_node_group);
+
+/**
+ * software_node_unregister_node_group - Unregister a group of software nodes
+ * @node_group: NULL terminated array of software node pointers to be unregistered
+ *
+ * Unregister multiple software nodes at once.
+ */
+void software_node_unregister_node_group(const struct software_node **node_group)
+{
+	struct swnode *swnode;
+	unsigned int i;
+
+	if (!node_group)
+		return;
+
+	for (i = 0; node_group[i]; i++) {
+		swnode = software_node_to_swnode(node_group[i]);
+		if (swnode)
+			fwnode_remove_software_node(&swnode->fwnode);
+	}
+}
+EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
+
 /**
  * software_node_register - Register static software node
  * @node: The software node to be registered
diff --git a/include/linux/property.h b/include/linux/property.h
index d86de017c689..c7b5f3db36aa 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -440,6 +440,9 @@ software_node_find_by_name(const struct software_node *parent,
 int software_node_register_nodes(const struct software_node *nodes);
 void software_node_unregister_nodes(const struct software_node *nodes);
 
+int software_node_register_node_group(const struct software_node **node_group);
+void software_node_unregister_node_group(const struct software_node **node_group);
+
 int software_node_register(const struct software_node *node);
 
 int software_node_notify(struct device *dev, unsigned long action);
-- 
2.25.1

