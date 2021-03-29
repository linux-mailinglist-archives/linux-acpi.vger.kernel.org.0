Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D034D363
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2PMQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 11:12:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:23742 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhC2PMC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 11:12:02 -0400
IronPort-SDR: ppj+xSqRv6wfjh3RM+HzwkxPkWu0s0ZG2AhtfPNshQjTDacJWsspEmDdjzKaWy8e8qk/2z5QMv
 JoJCopAatKgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171582221"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="171582221"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:12:01 -0700
IronPort-SDR: mqFNJXh7sI/3nSCz0WXPLJ5IbRgwJ/VXVjGJKaCURHVGFXf1iDcpcNWxRvTh+rHNakJOG6tLla
 H3ic8gZQIJAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="444809902"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 08:11:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23DF01AD; Mon, 29 Mar 2021 18:12:13 +0300 (EEST)
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
Subject: [PATCH v2 4/6] software node: Imply kobj_to_swnode() to be no-op
Date:   Mon, 29 Mar 2021 18:12:05 +0300
Message-Id: <20210329151207.36619-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we don't use structure field layout randomization
the manual shuffling can affect some macros, in particular
kobj_to_swnode(), which becomes a no-op when kobj member
is the first one in the struct swnode.

Bloat-o-meter statistics for swnode.o:

  add/remove: 0/0 grow/shrink: 2/10 up/down: 9/-100 (-91)
  Total: Before=7217, After=7126, chg -1.26%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added the object file name against which bloat-o-meter was run (Greg)
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index db982859171e..e83028e11f50 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -12,10 +12,10 @@
 #include <linux/slab.h>
 
 struct swnode {
-	int id;
 	struct kobject kobj;
 	struct fwnode_handle fwnode;
 	const struct software_node *node;
+	int id;
 
 	/* hierarchy */
 	struct ida child_ids;
-- 
2.30.2

