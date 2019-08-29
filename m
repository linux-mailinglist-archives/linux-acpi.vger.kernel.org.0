Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D764BA1592
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfH2KLY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 06:11:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:20183 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfH2KKo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Aug 2019 06:10:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:10:44 -0700
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="210487297"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:10:42 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 47AFC208A7;
        Thu, 29 Aug 2019 13:10:40 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i3HO7-0006Vb-AX; Thu, 29 Aug 2019 13:10:43 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/10] software node: Make argument to to_software_node const
Date:   Thu, 29 Aug 2019 13:10:35 +0300
Message-Id: <20190829101043.24963-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
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

