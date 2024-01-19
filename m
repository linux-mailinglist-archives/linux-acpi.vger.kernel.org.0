Return-Path: <linux-acpi+bounces-2948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662D832E13
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30C6B24259
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9955E4A;
	Fri, 19 Jan 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OszI13e6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329854BEE;
	Fri, 19 Jan 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685023; cv=none; b=ESbWU4L12pfgwsGtXWpeZ+vkhj6WX2HV2U1GYAxr4OgW/c6lGVyUIvwNX4DZ26MTBox89yqyr02Wqc6o0OmLyf4Nyi4rouwO2OoC+2J1Ff8zi/xsqDupINANYtskZ+yW8nQR/nrdPjBpDJkJfTyP17flqPWWKwJhjbldQpH13vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685023; c=relaxed/simple;
	bh=4nS1dF8R50DMwbbZZh69rnLH9od02PVsbnA79xan/PI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFqa3Fq1POZ3ZllT7SCXcfJEerKKry3lRSMqjoe5aWt88LhPRIO+ZrJfc0CuCcrL2X1jB8LEq0VQ1kQ8YNy6AC0ZxEa27mRYZnoL/WAlqjY4XVaPnUjPoylxPpVfQzE3vxgsO7dKbadBdDB5Pzja+Y7kid8xw9YJyywkm8Ejq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OszI13e6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685021; x=1737221021;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nS1dF8R50DMwbbZZh69rnLH9od02PVsbnA79xan/PI=;
  b=OszI13e6OXrnY2pRolgQmeALY99jFXA213d7go3AIv/dz92Gy5RK5oYi
   G3PQXDotG5oNRED1Olv0K76JZObNkX8f1Dnm1VSCN0nCmduirbLsPvIq8
   uV9S3ehg5zbDfQ1maIy1QpeNe7FPI1NpyiA7weMQ/9xMyYkPhuiUOGuLm
   7hMb97u/VohCz19Xs0lmSK+gwX/e0Di3D2Mfv0qUlMCXSLMMAB7JVeVhh
   2EbfKn2ZSFTp1mmcT+wUic9DKxK5oUkr48Mzp4XX/j6VQg46/3Jy6zL4t
   0YXCxXTEQR044E9fV+lsq6mGDazgnjfzRcYJHl+DiCCQNuFdltzlSz61w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7487466"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7487466"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032001760"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1032001760"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:40 -0800
Subject: [PATCH v4 06/11] cxl: Split out host bridge access coordinates
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 brice.goglin@gmail.com, nifan.cxl@gmail.com, rafael@kernel.org,
 gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:40 -0700
Message-ID: <170568502066.1008395.10410869430556415861.stgit@djiang5-mobl3>
In-Reply-To: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The difference between access class 0 and access class 1 for 'struct
access_coordinate', if any, is that class 0 is for the distance from
the target to the closest initiator and that class 1 is for the distance
from the target to the cloest CPU. For CXL memory, the nearest initiator
may not necessarily be a CPU node. The performance path from the CXL
endpoint to the host bridge should remain the same. However, the numbers
extracted and stored from HMAT is the difference for the two access
classes. Split out the performance numbers for the host bridge (generic
target) from the calculation of the entire path in order to allow
calculation of both access classes for a CXL region.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   27 ++++++++++++++++++++++-----
 drivers/cxl/core/port.c |   34 +++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h       |    2 ++
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 4d542627d02d..6e3998723aaa 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -161,7 +161,8 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
-	struct access_coordinate c;
+	struct access_coordinate ep_c;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct cxl_port *root_port;
 	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
@@ -169,9 +170,15 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
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
 
@@ -183,9 +190,19 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
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
-		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
+		rc = cxl_root->ops->qos_class(root_port,
+					      &coord[ACCESS_COORDINATE_LOCAL],
+					      1, &qos_class);
 		if (rc != 1)
 			continue;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d3a04ef8b4f..0e4e65cd3806 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2095,6 +2095,37 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
+/**
+ * cxl_hb_get_perf_coordinates - Retrieve performance numbers from host bridge
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
@@ -2136,9 +2167,6 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		dport = iter->parent_dport;
 	}
 
-	/* Augment with the generic port (host bridge) perf data */
-	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
-
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
 	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0a0a121ee780..80e6bd294e18 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -878,6 +878,8 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
 
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
+int cxl_hb_get_perf_coordinates(struct cxl_port *port,
+				struct access_coordinate *coord);
 
 void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,



