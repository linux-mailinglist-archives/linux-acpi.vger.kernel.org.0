Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51652DDBFD
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgLQXoj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgLQXoj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:44:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B1C061282;
        Thu, 17 Dec 2020 15:43:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w5so210717wrm.11;
        Thu, 17 Dec 2020 15:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRG6Du2Q5gaJecr0crPPKYS4mZ7zwOVeReLwF06dy8c=;
        b=R+U8hHBVOD1dvXrSoEvLCKxYu3++5n4YZ2k3P4lwKlX4SZ7F46ClpBb9F/YER/1WwL
         4oRx7vRZYnNXfQMX17iB9DpJHjMKRI2rODDS5quQ/+umxqg69V5hJSQcCwpzCCzLwMhr
         dx2UIHoiI2lNRhpsstpR0reE1k8dn3KFvj835qp+C8kJe2G72jcom+f/QIkpXdaBrUrp
         DC94LUztpChvH/lDnHz6CgvK11muVctOTSin4ClAkp4H+YgyaK5Z20iD053EOC9Vdjt7
         KQJUSmbRd7f7AYpNj9M1SjxndEbsp4ZKDHu2nM3ZEDZE+97/TARte/nS1oQy4FiQ5U9i
         psdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRG6Du2Q5gaJecr0crPPKYS4mZ7zwOVeReLwF06dy8c=;
        b=nC1nwKKARnX6tHJlkCE1MAgDJGYoHxFq4NY8GvW+A9RP4LNZYkYG7rFgseCMDlBygu
         e8Xz3ctIOlPgfdNLsNJzZiu4yIGDKkRAqoqWWXCqiiuzooTQIJKRIqzaMFnlCK5x1Hsk
         lHyXwas7iUwt3cVMWOuNVGFjX2uQQTEuwbMMGvLPHULi3pWFd0mJW1L4U7zM6+RXHWUV
         StKbyJD6AQKFbQxHt82bpg68j+nzYXjIr1uZVQVaxXrbptUm0N83iQM9UlHw+Yv1Jg0G
         RSUrlsM1CyktOukPoyfq7SO+4GjE0s7Wa4KPxc8h8lQzv6YRxULwh6CcqiDcPT/oX0QW
         iyeA==
X-Gm-Message-State: AOAM531Pg58q2AwXcYtYw8lM/5GJ1ADajHtL2piYtScggHzhvPTKRrql
        eKLkXf0SEXl6blB6GKAGHKN4kVMH7ZKSI4XI
X-Google-Smtp-Source: ABdhPJw7/NIJWKtof/Iqcc4Lel2jeNJDl8wRWMDmfXSr1kBk/rln+Zxy4omURinH+gaxl7UvniPhKw==
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr1255839wrr.230.1608248637431;
        Thu, 17 Dec 2020 15:43:57 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:56 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: [PATCH v2 04/12] software_node: Enforce parent before child ordering of nodes arrays
Date:   Thu, 17 Dec 2020 23:43:29 +0000
Message-Id: <20201217234337.1983732-5-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Registering software_nodes with the .parent member set to point to a
currently unregistered software_node has the potential for problems,
so enforce parent -> child ordering in arrays passed in to
software_node_register_nodes().

Software nodes that are children of another software node should be
unregistered before their parent. To allow easy unregistering of an array
of software_nodes ordered parent to child, reverse the order in which
software_node_unregister_nodes() unregisters software_nodes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- Squashed the patches that originally touched these separately
	- Updated documentation

 drivers/base/swnode.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 615a0c93e116..cfd1faea48a7 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -692,7 +692,10 @@ swnode_register(const struct software_node *node, struct swnode *parent,
  * software_node_register_nodes - Register an array of software nodes
  * @nodes: Zero terminated array of software nodes to be registered
  *
- * Register multiple software nodes at once.
+ * Register multiple software nodes at once. If any node in the array
+ * has it's .parent pointer set, then it's parent **must** have been
+ * registered before it is; either outside of this function or by
+ * ordering the array such that parent comes before child.
  */
 int software_node_register_nodes(const struct software_node *nodes)
 {
@@ -700,33 +703,47 @@ int software_node_register_nodes(const struct software_node *nodes)
 	int i;
 
 	for (i = 0; nodes[i].name; i++) {
-		ret = software_node_register(&nodes[i]);
-		if (ret) {
-			software_node_unregister_nodes(nodes);
-			return ret;
+		const struct software_node *parent = nodes[i].parent;
+
+		if (parent && !software_node_to_swnode(parent)) {
+			ret = -EINVAL;
+			goto err_unregister_nodes;
 		}
+
+		ret = software_node_register(&nodes[i]);
+		if (ret)
+			goto err_unregister_nodes;
 	}
 
 	return 0;
+
+err_unregister_nodes:
+	software_node_unregister_nodes(nodes);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(software_node_register_nodes);
 
 /**
  * software_node_unregister_nodes - Unregister an array of software nodes
- * @nodes: Zero terminated array of software nodes to be unregistered
+ * @nodes: Zero terminated array of software nodes to be unregistered.
  *
- * Unregister multiple software nodes at once.
+ * Unregister multiple software nodes at once. If parent pointers are set up
+ * in any of the software nodes then the array MUST be ordered such that
+ * parents come before their children.
  *
- * NOTE: Be careful using this call if the nodes had parent pointers set up in
- * them before registering.  If so, it is wiser to remove the nodes
- * individually, in the correct order (child before parent) instead of relying
- * on the sequential order of the list of nodes in the array.
+ * NOTE: If you are uncertain whether the array is ordered such that
+ * parents will be unregistered before their children, it is wiser to
+ * remove the nodes individually, in the correct order (child before
+ * parent).
  */
 void software_node_unregister_nodes(const struct software_node *nodes)
 {
-	int i;
+	unsigned int i = 0;
+
+	while (nodes[i].name)
+		i++;
 
-	for (i = 0; nodes[i].name; i++)
+	while (i--)
 		software_node_unregister(&nodes[i]);
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
-- 
2.25.1

