Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E4C9E95
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2019 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfJCMdG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Oct 2019 08:33:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:55990 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfJCMcW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Oct 2019 08:32:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 05:32:21 -0700
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="203942896"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 05:32:19 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id F1A2120F88;
        Thu,  3 Oct 2019 15:32:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1iG0HL-0002wE-Ln; Thu, 03 Oct 2019 15:32:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v9 02/12] software node: Make argument to to_software_node const
Date:   Thu,  3 Oct 2019 15:32:09 +0300
Message-Id: <20191003123219.11237-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

to_software_node() does not need to modify the fwnode_handle it operates
on; therefore make it const. This allows passing a const fwnode_handle to
to_software_node().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 4 ++--
 include/linux/property.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a7cb41812cfda..951e7efd47c23 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -71,9 +71,9 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
-const struct software_node *to_software_node(struct fwnode_handle *fwnode)
+const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 {
-	struct swnode *swnode = to_swnode(fwnode);
+	const struct swnode *swnode = to_swnode(fwnode);
 
 	return swnode ? swnode->node : NULL;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 5a910ad795910..421c76e53708d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -418,7 +418,8 @@ struct software_node {
 };
 
 bool is_software_node(const struct fwnode_handle *fwnode);
-const struct software_node *to_software_node(struct fwnode_handle *fwnode);
+const struct software_node *
+to_software_node(const struct fwnode_handle *fwnode);
 struct fwnode_handle *software_node_fwnode(const struct software_node *node);
 
 int software_node_register_nodes(const struct software_node *nodes);
-- 
2.20.1

