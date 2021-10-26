Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD943B736
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhJZQcw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 12:32:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:23947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhJZQcw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 12:32:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="290793442"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="290793442"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 09:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="486260445"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2021 09:30:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 381A1E7; Tue, 26 Oct 2021 19:30:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        YE Chengfeng <cyeaa@connect.ust.hk>
Subject: [PATCH v1 1/1] device property: Drop redundant NULL checks
Date:   Tue, 26 Oct 2021 19:29:54 +0300
Message-Id: <20211026162954.89811-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In cases when functions are called via fwnode operations,
we already know that this is software node we are dealing
with, hence no need to check if it's NULL, it can't be,

Reported-by: YE Chengfeng <cyeaa@connect.ust.hk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index c46f6a8e14d2..4debcea4fb12 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -413,9 +413,6 @@ software_node_get_name(const struct fwnode_handle *fwnode)
 {
 	const struct swnode *swnode = to_swnode(fwnode);
 
-	if (!swnode)
-		return "(null)";
-
 	return kobject_name(&swnode->kobj);
 }
 
@@ -507,9 +504,6 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	int error;
 	int i;
 
-	if (!swnode)
-		return -ENOENT;
-
 	prop = property_entry_get(swnode->node->properties, propname);
 	if (!prop)
 		return -ENOENT;
-- 
2.33.0

