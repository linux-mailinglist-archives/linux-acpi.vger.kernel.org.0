Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC12964BD
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Oct 2020 20:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508547AbgJVSlH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Oct 2020 14:41:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:57974 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368378AbgJVSlG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Oct 2020 14:41:06 -0400
IronPort-SDR: BzjGf1CUWejDhUDOWFdiKlM+IUnYGZ7xouNO4q2yrO8uonY/BOZPKWF82A722LL7F6i84fzxU7
 ImsTQIxACASg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="252275051"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="252275051"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:41:05 -0700
IronPort-SDR: 0knoJF85qr+HSIlXxpirUi01Gz84DUAuhpuudZHt2wauH2Md8TItJZrWsUmwEwI7C6mVvuSRsI
 QK8g6iRBM5Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="466787107"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2020 11:41:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A063F2; Thu, 22 Oct 2020 21:41:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v1 2/2] device property: Don't clear secondary pointer for shared primary firmware node
Date:   Thu, 22 Oct 2020 21:41:00 +0300
Message-Id: <20201022184100.71659-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It appears that firmware nodes can be shared between devices. In such case
when a (child) device is about to be deleted, its firmware node may be shared
and ACPI_COMPANION_SET(..., NULL) call for it breaks the secondary link
of the shared primary firmware node.

In order to prevent that, check, if the device has a parent and parent's
firmware node is shared with its child, and avoid crashing the link.

Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
Reported-by: Ferry Toth <fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 41feab679fa1..78114ddac755 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4264,6 +4264,7 @@ static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
  */
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 {
+	struct device *parent = dev->parent;
 	struct fwnode_handle *fn = dev->fwnode;
 
 	if (fwnode) {
@@ -4278,7 +4279,8 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 	} else {
 		if (fwnode_is_primary(fn)) {
 			dev->fwnode = fn->secondary;
-			fn->secondary = ERR_PTR(-ENODEV);
+			if (!(parent && fn == parent->fwnode))
+				fn->secondary = ERR_PTR(-ENODEV);
 		} else {
 			dev->fwnode = NULL;
 		}
-- 
2.28.0

