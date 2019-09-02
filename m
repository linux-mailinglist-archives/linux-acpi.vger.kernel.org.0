Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5309A5887
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfIBN5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 09:57:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:40636 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730919AbfIBN5a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:29 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="266027120"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A10BF20B86;
        Mon,  2 Sep 2019 16:57:25 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4mpo-00067I-Ix; Mon, 02 Sep 2019 16:57:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v5 02/11] software node: Make argument to to_software_node const
Date:   Mon,  2 Sep 2019 16:57:23 +0300
Message-Id: <20190902135732.23455-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
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

