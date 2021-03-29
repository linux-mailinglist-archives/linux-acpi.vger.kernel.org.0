Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970A34D36C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC2PMS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 11:12:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:63003 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhC2PMG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 11:12:06 -0400
IronPort-SDR: 7uU0xg+GgC9gIF08ThzdOejUE1dE5QTljuQ2cO3bVA8fjlsYanXM8RMsoU4DHFW37VFsJmx9m2
 51ARlQb3E0XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276730834"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="276730834"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:12:02 -0700
IronPort-SDR: xSUKaYj+AoGcgw9VlJLUci1NBKKxL4WelFvRMAkmhNl7hOVkjtG3V3C0AN63hkm929WW2dJol7
 5XGWSbpm+RPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="383599171"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2021 08:11:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 175E2132; Mon, 29 Mar 2021 18:12:13 +0300 (EEST)
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
Subject: [PATCH v2 3/6] software node: Deduplicate code in fwnode_create_software_node()
Date:   Mon, 29 Mar 2021 18:12:04 +0300
Message-Id: <20210329151207.36619-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Deduplicate conditional and assignment in fwnode_create_software_node(),
i.e. parent is checked in two out of three cases and parent software node
is assigned by to_swnode() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/base/swnode.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 19aa44bc2628..db982859171e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -973,15 +973,14 @@ fwnode_create_software_node(const struct property_entry *properties,
 {
 	struct fwnode_handle *fwnode;
 	struct software_node *node;
-	struct swnode *p = NULL;
-
-	if (parent) {
-		if (IS_ERR(parent))
-			return ERR_CAST(parent);
-		if (!is_software_node(parent))
-			return ERR_PTR(-EINVAL);
-		p = to_swnode(parent);
-	}
+	struct swnode *p;
+
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	p = to_swnode(parent);
+	if (parent && !p)
+		return ERR_PTR(-EINVAL);
 
 	node = software_node_alloc(properties);
 	if (IS_ERR(node))
-- 
2.30.2

