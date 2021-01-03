Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA712E8EF3
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbhACXPB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbhACXOR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8DC06179F;
        Sun,  3 Jan 2021 15:13:05 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t16so30020222wra.3;
        Sun, 03 Jan 2021 15:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMBjHrDajRxhZCxkXr9vhrFFi4tMzpNdjaV8TI7S6Ak=;
        b=UPkolQeptJMKA21+5Cs+zd++s6U9W82+sYYcioUfXzRaaxsL6WSDmM11lrkcheOPFA
         nVIQoKDSWKIntaVfusvkwGBTveMi6I8r9QAkP7w6Chmc33tDNSi/IbbNp1QvE/bgizJe
         s8zW9evx0Ws/XpDOYZBCd1ZzskGFgfmQ/eUzDhe3tXQbIo9P4WipJT1Rt78ZeXGp82UZ
         62arTiw/6t1KmjtS1TaFEJalHZ9SQOLltLKoomn7o9Y5vkIlI5PxcDeuS9Gcqxry2RKA
         WCu6VnzsKTaksGXzpKnAye8MHou/kUJB7BN2f8OXO8DURrupxQz/ceo/dKnYFvJbnga0
         OB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMBjHrDajRxhZCxkXr9vhrFFi4tMzpNdjaV8TI7S6Ak=;
        b=YnPzfOiDoc4fuMx5N9BisaWX0KX+CVW498eZW9j8Qg5Da4a2jzs1Q3s9HMw6iA0w/b
         mu0XKPzIREpfX7hAml6O6dJalmhQkb0B/piUYREwrnyzuj54KXAZsVn2c2RU9ldhn8yf
         MVZsdGbfaTy7w93JsS/CNM2b0h8UgZtgeblIsZjyz24BStDHntbPj1WHoZEqU8eYm6p1
         kq1QnEYItq6iWcVbyyFSE0QS+v//sw7zmkGOxv7AYpv9oa/GMAJtcA9z27N+/5LwW+Ms
         /542JiUYre+zwe9VkGh4qwgtbkRDbYGV4EjwlZXig41rFS56byfuavqFB3+peLYybTKy
         1ZkQ==
X-Gm-Message-State: AOAM533Lnw41CxXX6D0tjoEvC74GvWJgGgo/F47bQ8LWMS9zaeAnY5Pr
        bVFnGtwf9TU4pcrWFcXxMONeIhLYk4hQ9p4X
X-Google-Smtp-Source: ABdhPJyTSbiIytS7HH+5Qdkwc2HBnomxoC5XL6m5CTdupO+adpTYvQaWIDqEA0cJIcmYeVrTCI+Ihg==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr54457867wrn.376.1609715584526;
        Sun, 03 Jan 2021 15:13:04 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:04 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 08/15] software_node: Add support for fwnode_graph*() family of functions
Date:   Sun,  3 Jan 2021 23:12:28 +0000
Message-Id: <20210103231235.792999-9-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

	- Replaced the FWNODE_GRAPH_PORT_NAME_PREFIX_LEN macro with
	  strlen("port@") throughout
	- Added a check to software_node_graph_parse_endpoint() to ensure
	  the name of the endpoint's parent matches the expected port@n
	  format

 drivers/base/swnode.c | 116 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1f43c51b431e..82f9d6326110 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,6 +540,116 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
+	if (!(strlen(parent_name) > strlen("port@")) ||
+	    strncmp(parent_name, "port@", strlen("port@")))
+		return -EINVAL;
+
+	/* Ports have naming style "port@n", we need to select the n */
+	ret = kstrtou32(parent_name + strlen("port@"),
+			10, &endpoint->port);
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
@@ -551,7 +661,11 @@ static const struct fwnode_operations software_node_ops = {
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

