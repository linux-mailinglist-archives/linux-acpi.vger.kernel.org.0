Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F011934B9D3
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhC0WUl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:20237 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhC0WUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:17 -0400
IronPort-SDR: pM0Dis63SoBZ7fNy4JwA+Gf6AuttayFpCX5qJCu4TfAXG3rLzl55OitmJGpLRZEmsC+POmWO84
 CtQmjzwOD2Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="170732004"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="170732004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:17 -0700
IronPort-SDR: LkmIsYHL0BkahnxczuekWaqkoWewS8vWFqP55myOp50unfu6GOYYoKajQLSDypCzBBlJKtVTxp
 oAVFpbAFz3vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="417064275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2021 15:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB6C26F1; Sun, 28 Mar 2021 00:20:27 +0200 (EET)
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
Subject: [PATCH v1 4/8] software node: Deduplicate code in fwnode_create_software_node()
Date:   Sun, 28 Mar 2021 00:20:08 +0200
Message-Id: <20210327222012.54103-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
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
 drivers/base/swnode.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index d7fe1a887d2d..22f81688af2c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1100,15 +1100,14 @@ fwnode_create_software_node(const struct property_entry *properties,
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

