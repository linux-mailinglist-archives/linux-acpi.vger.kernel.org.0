Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989B02E8ED8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbhACXOQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbhACXOP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEDAC061794;
        Sun,  3 Jan 2021 15:13:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v14so16482219wml.1;
        Sun, 03 Jan 2021 15:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0IksVC5+HqVFsvTagMFtY4dHxSpSETaaDeLny9BEfw=;
        b=Y9aPVluz7ZiRNBE0VAq/PA+USLmHzlynN076j5LcQRt5Lmd950T4iLSq8q7RGOb0WQ
         SGtMCrav5wg2DuBdX8vozpqDfu9GRUuPw5o+n9xc6M+bveKCXWkllqcmupfAqzoUXJF+
         yOWqz+6I5qVfAwCWO3yyQjiGVwmJnxjD5nuCBZHUiM+XkjDnMUq7TNmqOH4fa/pvmLaj
         QelOUZ7Fnw9vkjWuxOIMiyucsXqmw0MP22MCPPSmjG3hBZBcQTZrWTEqHjSKMuQ11KV9
         RzJvZxTT4v7QP6S619vzTh3HCB2ZNPbpMFhj9q916VTc/J9SxV4THDgT1C2XLsyUmfPm
         veAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0IksVC5+HqVFsvTagMFtY4dHxSpSETaaDeLny9BEfw=;
        b=J8vRNCpF4+hmlV5EgxUAGdSy89+ag1SjFHbxTGrAaMYoJOev278PO+WePnyYB8xs7J
         wywdGd4Le63xO8cqUHhvhTz+vg7XVyw0sa6AsG3deBob0+q5D8jBNc6tXoBwD5aFg6US
         xdL2R6IlL9OWag0RuPH7eOPbUIQlfioe9KHjX0t5/qT2KZ5QcttVHgtpjXEcEbUZfZex
         XEKVLLQTBzApQigCn5WD+GsCM8XVAawiRk0TgW8/WynlPI1TC4h0AFxFmLpi4fg2TuBY
         Wnag6IZIb2qtMP9AwwBotmF/2YzluEh9fTHMZdEZfEIoetZ+ADYdwEAiZnza8PO8s36T
         OpMw==
X-Gm-Message-State: AOAM531nNVFaY1EVDN+HvmIkK4J5FMVCzkUCreuiqGQKMS4bRC/3Mbo+
        UMTiuFH/NvS2qWGlpFT2Gedsb3bUUdftr/Mm
X-Google-Smtp-Source: ABdhPJyoQNwu5kDmlT2r51ee7jBxl5CzLzgqmIhb+UFbCKBPhrz74lukUIkXZ3OIv3ESgytELY0CUw==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr24298282wmg.109.1609715580503;
        Sun, 03 Jan 2021 15:13:00 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:00 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 05/15] software_node: Enforce parent before child ordering of nodes arrays
Date:   Sun,  3 Jan 2021 23:12:25 +0000
Message-Id: <20210103231235.792999-6-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- None

 drivers/base/swnode.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 615a0c93e116..ade49173ff8d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -692,7 +692,11 @@ swnode_register(const struct software_node *node, struct swnode *parent,
  * software_node_register_nodes - Register an array of software nodes
  * @nodes: Zero terminated array of software nodes to be registered
  *
- * Register multiple software nodes at once.
+ * Register multiple software nodes at once. If any node in the array
+ * has its .parent pointer set (which can only be to another software_node),
+ * then its parent **must** have been registered before it is; either outside
+ * of this function or by ordering the array such that parent comes before
+ * child.
  */
 int software_node_register_nodes(const struct software_node *nodes)
 {
@@ -700,14 +704,23 @@ int software_node_register_nodes(const struct software_node *nodes)
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
 
@@ -715,18 +728,23 @@ EXPORT_SYMBOL_GPL(software_node_register_nodes);
  * software_node_unregister_nodes - Unregister an array of software nodes
  * @nodes: Zero terminated array of software nodes to be unregistered
  *
- * Unregister multiple software nodes at once.
+ * Unregister multiple software nodes at once. If parent pointers are set up
+ * in any of the software nodes then the array **must** be ordered such that
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

