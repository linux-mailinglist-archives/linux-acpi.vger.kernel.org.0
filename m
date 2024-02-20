Return-Path: <linux-acpi+bounces-3748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CD85CBD7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD11F22B2D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCBF154451;
	Tue, 20 Feb 2024 23:14:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148915444E;
	Tue, 20 Feb 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470864; cv=none; b=Iu1zQySlYFG5JUmZpMErc4vfqskJC1nS7Q8qRsIzF+RbyCbFHGpCPbcl90SHA+/6HSVZyhXi5xa/x41DcOFKaY5wXBgX3tj62ZSpR646mL1aLgEntxToLBsaoOOgS5+zh9vrJ82PvKz1rOS5A7NzTwGdr+lFDBR/NeasV/nCQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470864; c=relaxed/simple;
	bh=xoUy8TQs3TQ1ymXl5XnMlhU74fEQoe4sVuQxyNiKDUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1FEJ9qZaFKdxinvQXJ9ZdkdQ2VXLowRKWGA+H1llRElhKKv8XEur1yRQlygmFNbxwi/0kan8qWk+N3QNvIvO7I70717qIIjz1m8zd5T8EmdNCtJcm4xDBPXy/3xI6ThajmwXbFEH/Mft7EdhoLcPnw5OrASW1j8vDkMizW8bT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E6C433F1;
	Tue, 20 Feb 2024 23:14:23 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v6 05/12] cxl: Split out combine_coordinates() for common shared usage
Date: Tue, 20 Feb 2024 16:12:34 -0700
Message-ID: <20240220231402.3156281-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231402.3156281-1-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the common code of combining coordinates in order to reduce code.
Create a new function cxl_cooordinates_combine() it combine two 'struct
access_coordinate'.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Fix comment header parameter descriptions. (Jonathan)
- Check both input bandwidth to be valid. (Jonathan)
---
 drivers/cxl/core/cdat.c | 32 +++++++++++++++++++++++---------
 drivers/cxl/core/port.c | 18 ++----------------
 drivers/cxl/cxl.h       |  4 ++++
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 08fd0baea7a0..c1ede0ef9185 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -185,15 +185,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	xa_for_each(dsmas_xa, index, dent) {
 		int qos_class;
 
-		dent->coord.read_latency = dent->coord.read_latency +
-					   c.read_latency;
-		dent->coord.write_latency = dent->coord.write_latency +
-					    c.write_latency;
-		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
-						   dent->coord.read_bandwidth);
-		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
-						    dent->coord.write_bandwidth);
-
+		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
 		dent->entries = 1;
 		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
 					      &qos_class);
@@ -484,4 +476,26 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
 
+/**
+ * cxl_coordinates_combine - Combine the two input coordinates
+ *
+ * @out: Output coordinate of c1 and c2 combined
+ * @c1: input coordinates
+ * @c2: input coordinates
+ */
+void cxl_coordinates_combine(struct access_coordinate *out,
+			     struct access_coordinate *c1,
+			     struct access_coordinate *c2)
+{
+		if (c1->write_bandwidth && c2->write_bandwidth)
+			out->write_bandwidth = min(c1->write_bandwidth,
+						   c2->write_bandwidth);
+		out->write_latency = c1->write_latency + c2->write_latency;
+
+		if (c1->read_bandwidth && c2->read_bandwidth)
+			out->read_bandwidth = min(c1->read_bandwidth,
+						  c2->read_bandwidth);
+		out->read_latency = c1->read_latency + c2->read_latency;
+}
+
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 612bf7e1e847..af9458b2678c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2096,20 +2096,6 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
-static void combine_coordinates(struct access_coordinate *c1,
-				struct access_coordinate *c2)
-{
-		if (c2->write_bandwidth)
-			c1->write_bandwidth = min(c1->write_bandwidth,
-						  c2->write_bandwidth);
-		c1->write_latency += c2->write_latency;
-
-		if (c2->read_bandwidth)
-			c1->read_bandwidth = min(c1->read_bandwidth,
-						 c2->read_bandwidth);
-		c1->read_latency += c2->read_latency;
-}
-
 /**
  * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
  *				   of CXL path
@@ -2143,7 +2129,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * nothing to gather.
 	 */
 	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		combine_coordinates(&c, &dport->sw_coord);
+		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
 
@@ -2152,7 +2138,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	}
 
 	/* Augment with the generic port (host bridge) perf data */
-	combine_coordinates(&c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
+	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fe7448f2745e..fab2da4b1f04 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -882,6 +882,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 
 void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
 
+void cxl_coordinates_combine(struct access_coordinate *out,
+			     struct access_coordinate *c1,
+			     struct access_coordinate *c2);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
-- 
2.43.0


