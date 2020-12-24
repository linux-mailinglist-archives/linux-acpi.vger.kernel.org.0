Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290602E2353
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgLXBL0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbgLXBKp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA5EC061257;
        Wed, 23 Dec 2020 17:09:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g185so387183wmf.3;
        Wed, 23 Dec 2020 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C55+0/XEmdu1aVF/9CWLFX22O4BxQ3unitEM97OwnJ8=;
        b=FNU82cH6Zo7Az4EQLq3LGGrJlGVC6CrVr6YiJMnO1M5HOe4Zi5zdKeICTFO8oxqPK2
         nF8CiAMTWSlCr1hRMIkhcRWg8MiCEgjtoc2/9sYJrd3/pNsumyWKN6iTl+EwQH+mX4Oy
         VS+nH9pANBPJIvWAwsGBeWy61LJTuGT3e3Ctrff7iLDSRfekKkNnX/K8ZUosQEFg5c0h
         6lA964Fp8NEY2QDo9/fGyU8FtGO8i5MuhGCTsL5VYofYiYJ4Hy4eXTTPsWVaT6AN6tlY
         4O0e+tzs014T+bGPtcEQBk3yMnbc8JaaeqDismMNb0NLsetI4ZjyGY02hOaEpjTPgxpY
         njDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C55+0/XEmdu1aVF/9CWLFX22O4BxQ3unitEM97OwnJ8=;
        b=G01v0El6ewXPOl0i2FlXsjKUbxLtysyaa1loFZ51ZbhWnujN6O7zxqyVkyGxfQAlEv
         yYFhpfckIE2sqZLyPjZLo3nDcu7WIN7eLV+c5qjVB6pbrdzeTgrHMydfuST/McPSXBqZ
         7K03X+yMJR15G4PaOZ41V5D808jNRsJCpw7+o607JRrQwoFnUKQXwoLCBonDtSBEqIL1
         dCYmPP/YXZazLylgiw7lzGDNGG1D6daCrw1ruOI7wotrnH/C/JXhnVHCx3BJ1uK2+tMj
         iiXSnS6L7Caz5jo/9jf1Kz2nAhh4H2obgvUXe1eKfJRncxwl6DOi/ZpLEUpYKUeO3RXI
         EG/A==
X-Gm-Message-State: AOAM530/bsEhPRdYA47j78kzsRfJSAbFk6vcvjHIfZw3PtxAGw0ekcjl
        PZKPVpl6C7lQSGPQ/QUO4w07YhSqgKcDxRcs
X-Google-Smtp-Source: ABdhPJzZBU94HF0KJnfgAsXmvCFikk/DLnxUPljhvm5wfKiJmtQaY85SXX2kdHr0NkkNkUQvboj/lA==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr1971894wmf.142.1608772171216;
        Wed, 23 Dec 2020 17:09:31 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:30 -0800 (PST)
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
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v3 07/14] software_node: Add support for fwnode_graph*() family of functions
Date:   Thu, 24 Dec 2020 01:09:00 +0000
Message-Id: <20201224010907.263125-8-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
	- Changed software_node_get_next_endpoint() to drop the variable
	named "old"
	- Used the macros defined in 06/14 instead of magic numbers
	- Added some comments to explain behaviour a little where it's unclear

 drivers/base/swnode.c | 112 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 2d07eb04c6c8..ff690029060d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,6 +540,112 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
+		 * ports have naming style "port@n", so we search for children
+		 * that follow that convention (but without assuming anything
+		 * about the index number)
+		 */
+		if (!strncmp(to_swnode(port)->node->name, "port@",
+			     FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
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
+	int ret;
+
+	/* Ports have naming style "port@n", we need to select the n */
+	ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
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
@@ -551,7 +657,11 @@ static const struct fwnode_operations software_node_ops = {
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

