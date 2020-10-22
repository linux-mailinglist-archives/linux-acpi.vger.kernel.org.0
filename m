Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492302964BB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Oct 2020 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368409AbgJVSlG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Oct 2020 14:41:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:27682 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508547AbgJVSlF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Oct 2020 14:41:05 -0400
IronPort-SDR: d5beLKTj8r6NGfBCzDUJhXFWmxB0g+veuvIvl2A4rKIu+poV+yPfZIP/SGL/Ony3EZ+FQK9M41
 sBiQyWxZPkDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="146868811"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="146868811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:41:04 -0700
IronPort-SDR: NCBHGHbo+kfepfXk4T6LK4GcCSAFHyc6OtB5xm31DPHZOES2k00d5BlkCU0ygBQjmNl9CrAQk3
 loZRUJI2o2SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="302516299"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2020 11:41:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 44DA811E; Thu, 22 Oct 2020 21:41:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v1 1/2] device property: Keep secondary firmware node secondary by type
Date:   Thu, 22 Oct 2020 21:40:59 +0300
Message-Id: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Behind primary and secondary we understand the type of the nodes
which might define their ordering. However, if primary node gone,
we can't maintain the ordering by definition of the linked list.
Thus, by ordering secondary node becomes first in the list.
But in this case the meaning of it is still secondary (or auxiliary).
The type of the node is maintained by the secondary pointer in it:

	secondary pointer		Meaning
	NULL or valid			primary node
	ERR_PTR(-ENODEV)		secondary node

So, if by some reason we do the following sequence of calls

	set_primary_fwnode(dev, NULL);
	set_primary_fwnode(dev, primary);

we should preserve secondary node.

This concept is supported by the description of set_primary_fwnode()
along with implementation of set_secondary_fwnode(). Hence, fix
the commit c15e1bdda436 to follow this as well.

Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
Cc: Ferry Toth <fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index c852f16c111b..41feab679fa1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4278,7 +4278,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 	} else {
 		if (fwnode_is_primary(fn)) {
 			dev->fwnode = fn->secondary;
-			fn->secondary = NULL;
+			fn->secondary = ERR_PTR(-ENODEV);
 		} else {
 			dev->fwnode = NULL;
 		}
-- 
2.28.0

