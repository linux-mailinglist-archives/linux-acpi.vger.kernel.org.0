Return-Path: <linux-acpi+bounces-4213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A67876C9D
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F7282D2A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3DB5FB9B;
	Fri,  8 Mar 2024 22:01:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBD5CDC9;
	Fri,  8 Mar 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935303; cv=none; b=tasDnSdoeey8KgUVZoWuAVshVHPNfPhXehQM3UREgDo0L/eovcAelKaIPBHiFSe/aBXT5YSXoOw7h0TY8dBbe2nBizwydtX5d3cuDCE9tG6lls9ddlEj3mPpQhbEroPArVGiK0dU4xguCwJoI7vRN93P5TmJVRhXzNON6pTBOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935303; c=relaxed/simple;
	bh=0sMVhejLYhWkYGL21Hij29k53qrZpPrNmYYMznJq7nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faufMx3n7Af4ktYsIvRcpOApTflRBblymet2VWa+8ObShNbJKQa21yCvX6aHmABGnyS3krtj7m1RXCK0ZOoBN/8oeh+c15DHPDWNDb0EuF+p150PwvLNVWq9/o/w1ygOzNs4/W5NkEHbMvgdnfKgCfw4W8IyPgas4qcPeFbNOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45760C433C7;
	Fri,  8 Mar 2024 22:01:41 +0000 (UTC)
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
Subject: [PATCH v7 06/12] cxl: Split out host bridge access coordinates
Date: Fri,  8 Mar 2024 14:59:25 -0700
Message-ID: <20240308220055.2172956-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308220055.2172956-1-dave.jiang@intel.com>
References: <20240308220055.2172956-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The difference between access class 0 and access class 1 for 'struct
access_coordinate', if any, is that class 0 is for the distance from
the target to the closest initiator and that class 1 is for the distance
from the target to the closest CPU. For CXL memory, the nearest initiator
may not necessarily be a CPU node. The performance path from the CXL
endpoint to the host bridge should remain the same. However, the numbers
extracted and stored from HMAT is the difference for the two access
classes. Split out the performance numbers for the host bridge (generic
target) from the calculation of the entire path in order to allow
calculation of both access classes for a CXL region.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 28 ++++++++++++++++++++++------
 drivers/cxl/core/port.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c1ede0ef9185..04dfda9d1f1b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,15 +162,22 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
-	struct access_coordinate c;
+	struct access_coordinate ep_c;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
 	unsigned long index;
 	int rc;
 
-	rc = cxl_endpoint_get_perf_coordinates(port, &c);
+	rc = cxl_endpoint_get_perf_coordinates(port, &ep_c);
 	if (rc) {
-		dev_dbg(&port->dev, "Failed to retrieve perf coordinates.\n");
+		dev_dbg(&port->dev, "Failed to retrieve ep perf coordinates.\n");
+		return rc;
+	}
+
+	rc = cxl_hb_get_perf_coordinates(port, coord);
+	if (rc)  {
+		dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
 		return rc;
 	}
 
@@ -185,10 +192,19 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	xa_for_each(dsmas_xa, index, dent) {
 		int qos_class;
 
-		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
+		cxl_coordinates_combine(&dent->coord, &dent->coord, &ep_c);
+		/*
+		 * Keeping the host bridge coordinates separate from the dsmas
+		 * coordinates in order to allow calculation of access class
+		 * 0 and 1 for region later.
+		 */
+		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_LOCAL],
+					&coord[ACCESS_COORDINATE_LOCAL],
+					&dent->coord);
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
-					      &qos_class);
+		rc = cxl_root->ops->qos_class(cxl_root,
+					      &coord[ACCESS_COORDINATE_LOCAL],
+					      1, &qos_class);
 		if (rc != 1)
 			continue;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index af9458b2678c..b2a2f6c34886 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2096,6 +2096,38 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
+/**
+ * cxl_hb_get_perf_coordinates - Retrieve performance numbers between initiator
+ *				 and host bridge
+ *
+ * @port: endpoint cxl_port
+ * @coord: output access coordinates
+ *
+ * Return: errno on failure, 0 on success.
+ */
+int cxl_hb_get_perf_coordinates(struct cxl_port *port,
+				struct access_coordinate *coord)
+{
+	struct cxl_port *iter = port;
+	struct cxl_dport *dport;
+
+	if (!is_cxl_endpoint(port))
+		return -EINVAL;
+
+	dport = iter->parent_dport;
+	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
+		iter = to_cxl_port(iter->dev.parent);
+		dport = iter->parent_dport;
+	}
+
+	coord[ACCESS_COORDINATE_LOCAL] =
+		dport->hb_coord[ACCESS_COORDINATE_LOCAL];
+	coord[ACCESS_COORDINATE_CPU] =
+		dport->hb_coord[ACCESS_COORDINATE_CPU];
+
+	return 0;
+}
+
 /**
  * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
  *				   of CXL path
@@ -2137,9 +2169,6 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		dport = iter->parent_dport;
 	}
 
-	/* Augment with the generic port (host bridge) perf data */
-	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
-
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
 	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fab2da4b1f04..de477eb7f5d5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -879,6 +879,8 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
 
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
+int cxl_hb_get_perf_coordinates(struct cxl_port *port,
+				struct access_coordinate *coord);
 
 void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
 
-- 
2.44.0


