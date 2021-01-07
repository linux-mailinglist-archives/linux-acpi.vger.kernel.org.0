Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627842ED0C0
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbhAGNaQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbhAGNaP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5BC0612FA;
        Thu,  7 Jan 2021 05:29:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r3so5660982wrt.2;
        Thu, 07 Jan 2021 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoQRyLJn4HZP02GVt4BbpkjI446/7MndnoeDuXQdaLY=;
        b=B/r6+OoleWGiyRkTVXU3BM4qFszVckAJZAhgfWRBaYALy5OJCfd9udz79qvn7zrd+Q
         mkNfX1wep/YJfubivi/Z+H1c92yvJkXiIvlROPk5Bii4NiWMtw2M3wrQOYimnnlKunsW
         ha8sFmpcC8YWVWvaDCF4MwCUxhsgDbRF22/ruzKL+zsidW16K0W9J/zw4b0ASddQHy7c
         V35J71/YsTl/rgFgvUNk27jMjZPchT33eInnkefK+vJ9+IqUUdTCvwwJiRnHTR9SuT5c
         3oWhzO3+Wm9h+hbKBZyRA+dmNFXBwxRisFS0xTmcF2KWrSvBF0N3YiEhp1RIegewtOej
         gr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoQRyLJn4HZP02GVt4BbpkjI446/7MndnoeDuXQdaLY=;
        b=N+DUIh0X/r2cI0fb5MU35BsF/4G6afp16AevFOQVs+9Ub77mYPbLqkd3uANw11I/ql
         AOYAN6m+0Sf75ZtxmKfdZC2Ai8TA7u3Q3FnrUtn4YAfo2V5Y4HP8lg3Zn1Gx3Z5MN9QW
         pwNkeGgKXDVq2vS4Rb/Ja8G6Gw3m1XL+3IbNcS0tXc593J1p91CVOLyry4OtaxdEB+wC
         4qFWxqZMjw1YhpRcu1g+mR+w/tV4+kUAm9ed9slNIodKDTI7lvOFpI6M85+qrc5nZAtr
         CROco/XjUbH6EcgRz/k5Znv+KSdZ4ttcQdmffi0rgeY0PTXh6ZIEu460BR0ghRaz/Nve
         K6vA==
X-Gm-Message-State: AOAM530TOWO33rA5PcVQWC65luMs+f+wmWLPoFhrFsCnxu57TSZAVGLp
        rJ79cAFXdjCYFsV2dVWI8+2u8vOS+7rRuova
X-Google-Smtp-Source: ABdhPJxDJek+JC0RYDWgMEwdVAKNskeIQx7EzhapycQhzKkZJ8UzWky8izjrk8B5LCq/s+LfbB/j6Q==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr9132835wrv.132.1610026140455;
        Thu, 07 Jan 2021 05:29:00 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:28:59 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 05/15] software_node: Enforce parent before child ordering of nodes arrays
Date:   Thu,  7 Jan 2021 13:28:28 +0000
Message-Id: <20210107132838.396641-6-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

	- None

 drivers/base/swnode.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4fcc1a6fb724..166c5cc73f39 100644
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

