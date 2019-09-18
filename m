Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A5B649E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfIRNek (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 09:34:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:63140 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730727AbfIRNeJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 09:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:34:09 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="194063182"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:34:06 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 520DD21232;
        Wed, 18 Sep 2019 16:34:00 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1iAa68-00025w-OP; Wed, 18 Sep 2019 16:34:20 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v7 10/13] lib/vsprintf: Make use of fwnode API to obtain node names and separators
Date:   Wed, 18 Sep 2019 16:34:16 +0300
Message-Id: <20190918133419.7969-11-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Instead of implementing our own means of discovering parent nodes, node
names or counting how many parents a node has, use the newly added
functions in the fwnode API to obtain that information.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index df59818537b52..1195a11d99ba2 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -38,6 +38,7 @@
 #include <net/addrconf.h>
 #include <linux/siphash.h>
 #include <linux/compiler.h>
+#include <linux/property.h>
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 #endif
@@ -1863,32 +1864,25 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	return format_flags(buf, end, flags, names);
 }
 
-static const char *device_node_name_for_depth(const struct device_node *np, int depth)
-{
-	for ( ; np && depth; depth--)
-		np = np->parent;
-
-	return kbasename(np->full_name);
-}
-
 static noinline_for_stack
-char *device_node_gen_full_name(const struct device_node *np, char *buf, char *end)
+char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
+			      char *end)
 {
 	int depth;
-	const struct device_node *parent = np->parent;
 
-	/* special case for root node */
-	if (!parent)
-		return string_nocheck(buf, end, "/", default_str_spec);
+	/* Loop starting from the root node to the current node. */
+	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
+		struct fwnode_handle *__fwnode =
+			fwnode_get_nth_parent(fwnode, depth);
 
-	for (depth = 0; parent->parent; depth++)
-		parent = parent->parent;
-
-	for ( ; depth >= 0; depth--) {
-		buf = string_nocheck(buf, end, "/", default_str_spec);
-		buf = string(buf, end, device_node_name_for_depth(np, depth),
+		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
+			     default_str_spec);
+		buf = string(buf, end, fwnode_get_name(__fwnode),
 			     default_str_spec);
+
+		fwnode_handle_put(__fwnode);
 	}
+
 	return buf;
 }
 
@@ -1933,10 +1927,11 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 
 		switch (*fmt) {
 		case 'f':	/* full_name */
-			buf = device_node_gen_full_name(dn, buf, end);
+			buf = fwnode_full_name_string(of_fwnode_handle(dn), buf,
+						      end);
 			break;
 		case 'n':	/* name */
-			p = kbasename(of_node_full_name(dn));
+			p = fwnode_get_name(of_fwnode_handle(dn));
 			precision = str_spec.precision;
 			str_spec.precision = strchrnul(p, '@') - p;
 			buf = string(buf, end, p, str_spec);
@@ -1946,7 +1941,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
 			break;
 		case 'P':	/* path-spec */
-			p = kbasename(of_node_full_name(dn));
+			p = fwnode_get_name(of_fwnode_handle(dn));
 			if (!p[1])
 				p = "/";
 			buf = string(buf, end, p, str_spec);
-- 
2.20.1

