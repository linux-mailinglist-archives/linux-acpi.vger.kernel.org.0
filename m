Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0812E2332
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgLXBKK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgLXBKJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA03C061282;
        Wed, 23 Dec 2020 17:09:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so367993wmc.2;
        Wed, 23 Dec 2020 17:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLRZYS/XiFpA/R+VzuFliJ0iKwXJ0mePFvVmHUGHhWQ=;
        b=aKcyi/CgywK90dDzZFtZ/njuCWzotaIGtsSYSRuoHC+plDqIPX0WDn40fCdVK52yNH
         Kgg8YDTW+zOgrCpG28FLB2UdS8wa6K/v7VnkPInvmVrsX3gIMLV1FI8o3vG+wv8Ig7bJ
         RtyAFKMafLWmJaP48it1UYSS4zZIa83X4Phwnk2uFN1zh+lywKinGmnJvX2WSBUqUgwj
         3mYzDSBlIjVs01apC7euovzWmbltt2X65BMUIbeERDh2j1PirWyz6L6D0ldMvj/eTTRY
         EOHjsR8vTSUh6B41lZBkqg+orZdKDFTbplSQX0gppOPnZ3Baxc9mdZqB3IjTxnoo0lu/
         wtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLRZYS/XiFpA/R+VzuFliJ0iKwXJ0mePFvVmHUGHhWQ=;
        b=JdklmcNd0wGmh+pcNvDPwPZZMU8Gmnmdh4GNspnvjKIPWDRWa21P2GS3dM9jfnOxXS
         WcY8h3LAhA/uF3SG4zHSFWK41uPBPyQiqD1gSUYHWRqcERFc75k3ttLjB9K9RjjjK8c3
         nFl3soXPPUO5IzHYizkChvA9N/jFcAD2R1d9pwGFumvQdhGrdybOoov0xonvnYPxTX/o
         dZb9xfT/IojodzjaPVHEYA8iJ/6ast4kgMgDFs7zXmi/23ytW1AX1gCRhVQNWnJFfHr5
         vdXW6rAe5SwoqE6jntiYQNYFqYtr+Ux+FRgUlLOrKix40z5ksma9J5/Tl6Pz2EGIUlFr
         48+g==
X-Gm-Message-State: AOAM533UpplNIrH5C5LXX72M/2W07MU2YiABxSLLL9uXg9J7mOUpeCRi
        Cq055bJMWBLenE0U9oHSqKA8Xv6eVSjrV5Iv
X-Google-Smtp-Source: ABdhPJx1zBodos95DtqoTr9JbuG6zQ6De8U6dLDJudQOFpHdRJ2p5ZuAkxs3B3U2ES5FDevopyB5Tw==
X-Received: by 2002:a05:600c:218a:: with SMTP id e10mr1944501wme.27.1608772167161;
        Wed, 23 Dec 2020 17:09:27 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:26 -0800 (PST)
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
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 04/14] software_node: Enforce parent before child ordering of nodes arrays
Date:   Thu, 24 Dec 2020 01:08:57 +0000
Message-Id: <20201224010907.263125-5-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
	- kerneldoc comment cleanup

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

