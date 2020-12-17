Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E491B2DDC0C
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgLQXpO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgLQXpO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0F3C061248;
        Thu, 17 Dec 2020 15:44:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c5so232302wrp.6;
        Thu, 17 Dec 2020 15:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gU5HhP1TeKrMyBxy7gnZuPRoeb13x3wsqwC/lwANoFU=;
        b=o0nqPDOoz78PdLm4/ZdIUMMVLu3XQvGP2Bp8YwXHCO9SWEIJ23FgNBp41yH5JZz8iJ
         Z1Nfq38KXTats2hEXlLkjowypJr6nbfSjq+bQ3/wQ6G8Om/O8yz07CudjoZO5Yt24p/d
         ep5Rv5Uxs7+9/eNzF8XPnZOTQVf0lKfQzkJSfjRmkqfNXRQJikHzAVbbpQfvoCV/JiZi
         yo0JtKsP5rnBwwSz+A/KS4JsZuSG1Z/eUDh2gzj9bUaPuOaMfews1PvSvt2FXqFHOqtF
         XK5U2K+m46yCq+LZrtyroRIFe1a+mbPhTkylwyTzJ/SB9PKozUu2H4uGZvTK8VV5+wVG
         jIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gU5HhP1TeKrMyBxy7gnZuPRoeb13x3wsqwC/lwANoFU=;
        b=fcvW5S6zBiLXkn2Z3QcybwxhpXRzLDiJIG5a/hlWa+Wez7SYeuXfnUxwtei7+hTsRi
         B2wN9gGvsZOQ6kWWIc6FqX3+cCOTmAOncg0Iuh70ZiAsQPVY/Kh48XUnSUwCdkpcsQwU
         BNLBUDLNxQvD/PMediTPwy2BlNCfjO5vzc1elsjoJK16UkTdcp3WQ0aMBWazqBmE4dfb
         7CxXKWq0E16jsg0J/1LabW0gbyQql7pQqcGxOB6skBdV7DbijNGpfzSGgiPcmN3ZLzvM
         2+nn6amDa2MUD4EEslF2ouLPX10cp652un3BL3jq0SMWoOepjDIpzdf5hIIPJMVuojv/
         2TEg==
X-Gm-Message-State: AOAM5314HmVAHsePkOWS9HFHN20e7YjR6QDTAG40jo20nvPDNsc2Ep8e
        WFcmJc2n2lnrXBr3437+Yr2YudENu22SmZVQ
X-Google-Smtp-Source: ABdhPJy0Hiw1DqKEpVPX2hJdAPhEMPAAGgEu0x7pQTOCwMf1fsd4tWtZPbLEhnIPMlLHJ4ACfe5UuA==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr1221389wrv.93.1608248640141;
        Thu, 17 Dec 2020 15:44:00 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:59 -0800 (PST)
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
Subject: [PATCH v2 06/12] software_node: Add support for fwnode_graph*() family of functions
Date:   Thu, 17 Dec 2020 23:43:31 +0000
Message-Id: <20201217234337.1983732-7-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This implements the remaining .graph_* callbacks in the
fwnode operations structure for the software nodes. That makes
the fwnode_graph*() functions available in the drivers also
when software nodes are used.

The implementation tries to mimic the "OF graph" as much as
possible, but there is no support for the "reg" device
property. The ports will need to have the index in their
name which starts with "port@" (for example "port@0", "port@1",
...) and endpoints will use the index of the software node
that is given to them during creation. The port nodes can
also be grouped under a specially named "ports" subnode,
just like in DT, if necessary.

The remote-endpoints are reference properties under the
endpoint nodes that are named "remote-endpoint".

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Daniel Scally <djrscally@gmail.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- Changed commit to specify port name prefix as port@
	- Accounted for that rename in *parse_endpoint()

 drivers/base/swnode.c | 110 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 2b90d380039b..0d14d5ebe441 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,6 +540,110 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static struct fwnode_handle *
+swnode_graph_find_next_port(const struct fwnode_handle *parent,
+			    struct fwnode_handle *port)
+{
+	struct fwnode_handle *old = port;
+
+	while ((port = software_node_get_next_child(parent, old))) {
+		if (!strncmp(to_swnode(port)->node->name, "port", 4))
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
+	struct fwnode_handle *old = endpoint;
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
+		endpoint = software_node_get_next_child(port, old);
+		if (endpoint) {
+			fwnode_handle_put(port);
+			break;
+		}
+
+		/* No more endpoints for that port, so stop passing old */
+		old = NULL;
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
+	struct fwnode_handle *parent;
+
+	if (!strcmp(swnode->parent->node->name, "ports"))
+		parent = &swnode->parent->parent->fwnode;
+	else
+		parent = &swnode->parent->fwnode;
+
+	return software_node_get(parent);
+}
+
+static int
+software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
+				   struct fwnode_endpoint *endpoint)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+	int ret;
+
+	ret = kstrtou32(swnode->parent->node->name + 5, 10, &endpoint->port);
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
@@ -551,7 +655,11 @@ static const struct fwnode_operations software_node_ops = {
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

