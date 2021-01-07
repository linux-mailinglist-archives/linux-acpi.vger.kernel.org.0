Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C142ED0D8
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbhAGNbJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbhAGNaR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AFBC0612FD;
        Thu,  7 Jan 2021 05:29:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a6so5163180wmc.2;
        Thu, 07 Jan 2021 05:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4i6s7/VLVeW8cmhjedIhbBrwFwI0HednQDhcygFPUk=;
        b=eCVXX8QOlddbkO5fbSW13fDBxrWGjADa/YOp5tnEQagV/Hk0HS5i5Hw+vM8JdFec7+
         TIg1+S4XacTcdVNpLHQCXt93JQg42VYb/x64nvTvlbpnWTp4u0xrKphgJLYpGhUKuvmJ
         7PUvqFZ+/6ljFoSVqJI0iRWJrXJsTwxtUpKVO1xzhxjd2uIpiwhGNSvvyfBmqBSriqQx
         WDKRbst2tu+6pTCteLN53X0Vzddl34ZHfJ2mwE93NoeT9oSmfj2jfDmZujwDph/RJq2V
         AybtPlPYuJtuHtL+wcYBDvzy3h3gQFTKBVyt/OAF5OYoJB9vAYRoXJ0Fzu5t/L+7N3VH
         bFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4i6s7/VLVeW8cmhjedIhbBrwFwI0HednQDhcygFPUk=;
        b=ehI8XGzQXn0PAnUtsRtAmVxy9GOIvk1nkmnq96pNIiWhpUJ9UvZZTNbB97IGh1RoGv
         dOv+ohmvCif2Pn8pqAZ0bgOTwsb7KXRfZTENjYa1qK+ZcgeEt+qpK3Fb9AVn+5xE9uQU
         I47ywI9z/O+OOYQ8NvCPyLe5fhLAq4G/23SE/AxvXXzcaemisUXKwCbVkyvoy6HiZBkt
         5yNoU70Ccif/08CefCWfOUqej9Ip7kulOLpC0LIUnGJ8EwK8I9NUVjVzaJbSolv0USyG
         z/2G81uM9/QHWJLn9h6vqATKLjrGSL1/uKH5dMSaQv+vRK0v/J3SVS+bK3fe6D3+fdQt
         /MhA==
X-Gm-Message-State: AOAM530JZTa4PclqV8ZHDiO1YfRUETB4+X3PEa4ToCWJePwrZcSL987T
        Ib2TB9lCmqVIGSHbTYRViAkTU7rHrapH3BU2
X-Google-Smtp-Source: ABdhPJxVXEx6ZLkRtmTnGyC/WdLIt8C2C0uh8N3fJGAe7IpZWSZdlUCwP41uMu2Gmeh/LmsEWSPJ5g==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr7935159wma.152.1610026144707;
        Thu, 07 Jan 2021 05:29:04 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:04 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 08/15] software_node: Add support for fwnode_graph*() family of functions
Date:   Thu,  7 Jan 2021 13:28:31 +0000
Message-Id: <20210107132838.396641-9-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This implements the remaining .graph_*() callbacks in the fwnode
operations structure for the software nodes. That makes the
fwnode_graph_*() functions available in the drivers also when software
nodes are used.

The implementation tries to mimic the "OF graph" as much as possible, but
there is no support for the "reg" device property. The ports will need to
have the index in their  name which starts with "port@" (for example
"port@0", "port@1", ...) and endpoints will use the index of the software
node that is given to them during creation. The port nodes can also be
grouped under a specially named "ports" subnode, just like in DT, if
necessary.

The remote-endpoints are reference properties under the endpoint nodes
that are named "remote-endpoint".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Daniel Scally <djrscally@gmail.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v5:

	- Cosmetic changes only

 drivers/base/swnode.c | 115 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 6f7443c6d3b5..9104a0abd531 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,6 +540,115 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static struct fwnode_handle *
+swnode_graph_find_next_port(const struct fwnode_handle *parent,
+			    struct fwnode_handle *port)
+{
+	struct fwnode_handle *old = port;
+
+	while ((port = software_node_get_next_child(parent, old))) {
+		/*
+		 * fwnode ports have naming style "port@", so we search for any
+		 * children that follow that convention.
+		 */
+		if (!strncmp(to_swnode(port)->node->name, "port@",
+			     strlen("port@")))
+			return port;
+		old = port;
+	}
+
+	return NULL;
+}
+
+static struct fwnode_handle *
+software_node_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
+				      struct fwnode_handle *endpoint)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+	struct fwnode_handle *parent;
+	struct fwnode_handle *port;
+
+	if (!swnode)
+		return NULL;
+
+	if (endpoint) {
+		port = software_node_get_parent(endpoint);
+		parent = software_node_get_parent(port);
+	} else {
+		parent = software_node_get_named_child_node(fwnode, "ports");
+		if (!parent)
+			parent = software_node_get(&swnode->fwnode);
+
+		port = swnode_graph_find_next_port(parent, NULL);
+	}
+
+	for (; port; port = swnode_graph_find_next_port(parent, port)) {
+		endpoint = software_node_get_next_child(port, endpoint);
+		if (endpoint) {
+			fwnode_handle_put(port);
+			break;
+		}
+	}
+
+	fwnode_handle_put(parent);
+
+	return endpoint;
+}
+
+static struct fwnode_handle *
+software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+	const struct software_node_ref_args *ref;
+	const struct property_entry *prop;
+
+	if (!swnode)
+		return NULL;
+
+	prop = property_entry_get(swnode->node->properties, "remote-endpoint");
+	if (!prop || prop->type != DEV_PROP_REF || prop->is_inline)
+		return NULL;
+
+	ref = prop->pointer;
+
+	return software_node_get(software_node_fwnode(ref[0].node));
+}
+
+static struct fwnode_handle *
+software_node_graph_get_port_parent(struct fwnode_handle *fwnode)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+
+	swnode = swnode->parent;
+	if (swnode && !strcmp(swnode->node->name, "ports"))
+		swnode = swnode->parent;
+
+	return swnode ? software_node_get(&swnode->fwnode) : NULL;
+}
+
+static int
+software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
+				   struct fwnode_endpoint *endpoint)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+	const char *parent_name = swnode->parent->node->name;
+	int ret;
+
+	if (strlen("port@") >= strlen(parent_name) ||
+	    strncmp(parent_name, "port@", strlen("port@")))
+		return -EINVAL;
+
+	/* Ports have naming style "port@n", we need to select the n */
+	ret = kstrtou32(parent_name + strlen("port@"), 10, &endpoint->port);
+	if (ret)
+		return ret;
+
+	endpoint->id = swnode->id;
+	endpoint->local_fwnode = fwnode;
+
+	return 0;
+}
+
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
@@ -551,7 +660,11 @@ static const struct fwnode_operations software_node_ops = {
 	.get_parent = software_node_get_parent,
 	.get_next_child_node = software_node_get_next_child,
 	.get_named_child_node = software_node_get_named_child_node,
-	.get_reference_args = software_node_get_reference_args
+	.get_reference_args = software_node_get_reference_args,
+	.graph_get_next_endpoint = software_node_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = software_node_graph_get_remote_endpoint,
+	.graph_get_port_parent = software_node_graph_get_port_parent,
+	.graph_parse_endpoint = software_node_graph_parse_endpoint,
 };
 
 /* -------------------------------------------------------------------------- */
-- 
2.25.1

