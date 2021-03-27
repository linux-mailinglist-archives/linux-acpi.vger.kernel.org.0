Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCDC34B9DC
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhC0WUn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:17399 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhC0WUV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:21 -0400
IronPort-SDR: jk0J+ETNiFr24/iBYFTzMup16JU+HRFbSmfBDJmZo9vZEZ9l4TVOXdUmwBC3AOBiQO/C6uRR9I
 hfK+CoDrw8NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="191370247"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="191370247"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:20 -0700
IronPort-SDR: 0fvhwCC9+0j/t7nQJoBLlVBy4I8mEvnIy94rHmIXlyeQntd0Fz5xnnF/GbbQSAzeDhyMwCMRAv
 8NXPr6RGJsRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="515505908"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2021 15:20:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 143DB10B0; Sun, 28 Mar 2021 00:20:28 +0200 (EET)
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
Subject: [PATCH v1 7/8] software node: Introduce SOFTWARE_NODE_REFERENCE() helper macro
Date:   Sun, 28 Mar 2021 00:20:11 +0200
Message-Id: <20210327222012.54103-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is useful to assign software node reference with arguments
in a common way. Moreover, we have already couple of users that
may be converted. And by the fact, one of them is moved right here
to use the helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/test/property-entry-test.c | 11 ++---------
 include/linux/property.h                | 13 ++++++++-----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index abe03315180f..c2e455d46ffd 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -370,15 +370,8 @@ static void pe_test_reference(struct kunit *test)
 	};
 
 	static const struct software_node_ref_args refs[] = {
-		{
-			.node = &nodes[0],
-			.nargs = 0,
-		},
-		{
-			.node = &nodes[1],
-			.nargs = 2,
-			.args = { 3, 4 },
-		},
+		SOFTWARE_NODE_REFERENCE(&nodes[0]),
+		SOFTWARE_NODE_REFERENCE(&nodes[1], 3, 4),
 	};
 
 	const struct property_entry entries[] = {
diff --git a/include/linux/property.h b/include/linux/property.h
index dd4687b56239..0d876316e61d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -254,6 +254,13 @@ struct software_node_ref_args {
 	u64 args[NR_FWNODE_REFERENCE_ARGS];
 };
 
+#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
+(const struct software_node_ref_args) {				\
+	.node = _ref_,						\
+	.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
+	.args = { __VA_ARGS__ },				\
+}
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
@@ -362,11 +369,7 @@ struct property_entry {
 	.name = _name_,							\
 	.length = sizeof(struct software_node_ref_args),		\
 	.type = DEV_PROP_REF,						\
-	{ .pointer = &(const struct software_node_ref_args) {		\
-		.node = _ref_,						\
-		.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
-		.args = { __VA_ARGS__ },				\
-	} },								\
+	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
 }
 
 struct property_entry *
-- 
2.30.2

