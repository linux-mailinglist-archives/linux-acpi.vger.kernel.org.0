Return-Path: <linux-acpi+bounces-9608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABF9CFBB1
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 01:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B71B1F22C06
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D32114;
	Sat, 16 Nov 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lmlTPDZn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FB10E6;
	Sat, 16 Nov 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717183; cv=none; b=jUyZpbcbq2bp8+rvI6sRT7XT3DwDbKjEosPry6M3krq2adFPf1AHN9SwlX2g2ASbJeELJSVmeYtNCUHH/YxWCAyFe1+QR6fY13XocV8IN+EC9uSnk6ukD+JMGP/HvcqRdnU/iYUL4dtA3643vptY6qF+hY3f0zZKl+cAj7xOwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717183; c=relaxed/simple;
	bh=T7RtKM+FtjTcEG3IPQwos/zWrHkVgFDeK3pjo2QBvC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSVLfWTkzLjbKPOEZ5qcw60batYhVxx0r4z6UI8TWDt8xG2qNzYKIa4hqFWmtVQtbu8FpRh4vucGLckNWVPi/wj6J2g4LQ2m2SWHJ7OZXg6Du3LEATwCdGz3V4QkkZwhCmfHN3uQ4DEtjZD/kZ4ixZu/aF7MvG+nuLw0of10mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lmlTPDZn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=O69RYa26PSMBV2S9yrDOnpZxIdp5LpKg7DZPibj60YM=; b=lmlTPDZnE4F0PENa
	rs96Vt9CjL6fHsmROCUPK8M28fs62uFoWDV6gZlFjIpOBNGBhVNllDUA6ROsmpfmHUfPvXkegAQ9k
	OcvqOqnZzf2zPJsw/Rh4YMBcSwW8kczZitdXmz0xZAwB1+G0bjwqC8e2mkaGxKJGv5sqCGl6BIPLG
	44ic2otqRE7OtbRJZjarIrMJH6Is7nwUDT/ZsoGSx2DDow6/9HjBYgmlo1GbjoIdvyq5kaQc6ttAi
	E51VpHxLBcf2e4yOzGRD3Z/GIzJn1cyje+sf7zeezQA7ewEc4G0h2MTRfVtnH13V2fJppMYFMYBzP
	ZgXsJChKVEtp5mZr+w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tC6kA-000FLA-1D;
	Sat, 16 Nov 2024 00:32:54 +0000
From: linux@treblig.org
To: andriy.shevchenko@linux.intel.com,
	djrscally@gmail.com,
	heikki.krogerus@linux.intel.com,
	sakari.ailus@linux.intel.com,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] device: property: Remove deadcode
Date: Sat, 16 Nov 2024 00:32:53 +0000
Message-ID: <20241116003253.335337-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

fwnode_graph_get_endpoint_count() was added in 2021 by
commit c87b8fc56966 ("device property: Implement
fwnode_graph_get_endpoint_count()")

but has never been used.

fwnode_graph_get_remote_port() has been unused since 2017's
commit 6a71d8d77795 ("device property: Add fwnode_graph_get_port_parent")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/base/property.c  | 41 ----------------------------------------
 include/linux/property.h |  4 ----
 2 files changed, 45 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 837d77e3af2b..0cf8a7afaaee 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1116,22 +1116,6 @@ fwnode_graph_get_remote_port_parent(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
 
-/**
- * fwnode_graph_get_remote_port - Return fwnode of a remote port
- * @fwnode: Endpoint firmware node pointing to the remote endpoint
- *
- * Extracts firmware node of a remote port the @fwnode points to.
- *
- * The caller is responsible for calling fwnode_handle_put() on the returned
- * fwnode pointer.
- */
-struct fwnode_handle *
-fwnode_graph_get_remote_port(const struct fwnode_handle *fwnode)
-{
-	return fwnode_get_next_parent(fwnode_graph_get_remote_endpoint(fwnode));
-}
-EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
-
 /**
  * fwnode_graph_get_remote_endpoint - Return fwnode of a remote endpoint
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
@@ -1227,31 +1211,6 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 
-/**
- * fwnode_graph_get_endpoint_count - Count endpoints on a device node
- * @fwnode: The node related to a device
- * @flags: fwnode lookup flags
- * Count endpoints in a device node.
- *
- * If FWNODE_GRAPH_DEVICE_DISABLED flag is specified, also unconnected endpoints
- * and endpoints connected to disabled devices are counted.
- */
-unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
-					     unsigned long flags)
-{
-	struct fwnode_handle *ep;
-	unsigned int count = 0;
-
-	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		if (flags & FWNODE_GRAPH_DEVICE_DISABLED ||
-		    fwnode_graph_remote_available(ep))
-			count++;
-	}
-
-	return count;
-}
-EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_count);
-
 /**
  * fwnode_graph_parse_endpoint - parse common endpoint node properties
  * @fwnode: pointer to endpoint fwnode_handle
diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..4301f5130280 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -470,8 +470,6 @@ struct fwnode_handle *
 fwnode_graph_get_port_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_port_parent(
 	const struct fwnode_handle *fwnode);
-struct fwnode_handle *fwnode_graph_get_remote_port(
-	const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	const struct fwnode_handle *fwnode);
 
@@ -497,8 +495,6 @@ static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 				u32 port, u32 endpoint, unsigned long flags);
-unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
-					     unsigned long flags);
 
 #define fwnode_graph_for_each_endpoint(fwnode, child)				\
 	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\
-- 
2.47.0


