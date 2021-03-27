Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9714734B9D1
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhC0WUm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:65376 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhC0WUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:17 -0400
IronPort-SDR: D53/jTRqBiC8KHfLxdTKpY0b0HvldNRYeVdVpdN+2mdgwwItW3UmEP7DJgFqOdW+gi/e4FbY/y
 Fqhdoqlb5YzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="190792947"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="190792947"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:16 -0700
IronPort-SDR: 5DfQiHwmGsP7+A7jagnJtH2O2k9EIk8wQElRcu5zLIITcLtIGtySJgxt+NcWLaU5zxGLyti+F3
 Rvybxj7xrn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="594591279"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2021 15:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0110ECC4; Sun, 28 Mar 2021 00:20:27 +0200 (EET)
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
Subject: [PATCH v1 5/8] software node: Imply kobj_to_swnode() to be no-op
Date:   Sun, 28 Mar 2021 00:20:09 +0200
Message-Id: <20210327222012.54103-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we don't use structure field layout randomization
the manual shuffling can affect some macros, in particular
kobj_to_swnode(), which becomes a no-op when kobj member
is the first one in the struct swnode.

Bloat-o-meter statistics:

  add/remove: 0/0 grow/shrink: 2/10 up/down: 9/-100 (-91)
  Total: Before=7217, After=7126, chg -1.26%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 22f81688af2c..ae53c48f84b1 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -13,10 +13,10 @@
 #include <linux/sysfs.h>
 
 struct swnode {
-	int id;
 	struct kobject kobj;
 	struct fwnode_handle fwnode;
 	const struct software_node *node;
+	int id;
 
 	/* properties in sysfs */
 	struct kobj_attribute *property_attrs;
-- 
2.30.2

