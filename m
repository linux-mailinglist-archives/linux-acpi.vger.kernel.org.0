Return-Path: <linux-acpi+bounces-2947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A67832E12
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8E8287F7A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671985577D;
	Fri, 19 Jan 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C61D0Z7M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61954BEE;
	Fri, 19 Jan 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685021; cv=none; b=NxgfMJx6s5Ai7L2JjSKET90bqRfhIoSCYsBNsAUf1tJue8s4ziS/lf2uSNFOtNcM4njNBf2kKEPax+uPtsskI1dZjHBCywkIjB9QA7WMy5HhG1pYo1hKUmeFOSm+nUSZr8x7qg7vA5RLteIkhh7/7jOkI/L/yKUcUYfcgrL9MGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685021; c=relaxed/simple;
	bh=5GAZeDTvS8gY8dtRvNTZowaEuTcyWJ8qdZTwaszg0qU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNhwG9Yaw39YGRSFGxiBb2UOYA/ERiZwceuLE2IH56/gDgtg6tVesfPpcr7c/6sUa4yw4NWckzfS3ngoIQ+D+J1wAS3vCAfToWKpE8JAZeP1Vz+mAtAbLNCdgIKhiptjYlnJs8DHm9NS8T8yAO3lRIBEz1sKuwgdMrg1ZwHYQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C61D0Z7M; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685016; x=1737221016;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5GAZeDTvS8gY8dtRvNTZowaEuTcyWJ8qdZTwaszg0qU=;
  b=C61D0Z7MWR029J+A+V9gvJKO9whRL0cEb6jbwtju7x0U0YW4wDOlIwWu
   yHOZxaxaZXnwHQJVxA0K58BdxYwviK7z4zlPML/iBjprTvYEW7mtOlk/j
   u0pSlh68gt06n2ldcUVrH7mRRFiwsBc7qijO4hq27ErZFCCYkFnspxjTB
   Ii3Dy5op8D1AKK5DaNIBjhy0jN5bOZ0Rdfw9RIXc3SRQWrSd7O02STfLb
   n+EW+2A4gGZT4sBpuvu67NvSPgjp5Z69bs0zXE6BUu3ikxCPd3o/aIIg2
   P7nre7e1/PCgMgaqLt0hOWfkqi9O8Y8+CeA3BepkpYdZy295NUOe1FUIi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7487447"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7487447"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032001713"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1032001713"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:34 -0800
Subject: [PATCH v4 05/11] cxl: Split out combine_coordinates() for common
 shared usage
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 brice.goglin@gmail.com, nifan.cxl@gmail.com, rafael@kernel.org,
 gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:34 -0700
Message-ID: <170568501456.1008395.7903809557943927970.stgit@djiang5-mobl3>
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

Refactor the common code of combining coordinates in order to reduce code.
Create a new function cxl_cooordinates_combine() it combine two 'struct
access_coordinate'.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   32 +++++++++++++++++++++++---------
 drivers/cxl/core/port.c |   18 ++----------------
 drivers/cxl/cxl.h       |    4 ++++
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..4d542627d02d 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -183,15 +183,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
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
 		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
 		if (rc != 1)
@@ -514,4 +506,26 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
 
+/**
+ * cxl_coordinates_combine - Combine the two input coordinates into the first
+ *
+ * @c1: first coordinate, to be written to
+ * @c2: second coordinate
+ */
+void cxl_coordinates_combine(struct access_coordinate *out,
+			     struct access_coordinate *c1,
+			     struct access_coordinate *c2)
+{
+		if (c2->write_bandwidth)
+			out->write_bandwidth = min(c1->write_bandwidth,
+						   c2->write_bandwidth);
+		out->write_latency = c1->write_latency + c2->write_latency;
+
+		if (c2->read_bandwidth)
+			out->read_bandwidth = min(c1->read_bandwidth,
+						  c2->read_bandwidth);
+		out->read_latency = c1->read_latency + c2->read_latency;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_coordinates_combine, CXL);
+
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7a5eff45e1e2..1d3a04ef8b4f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2095,20 +2095,6 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
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
@@ -2142,7 +2128,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * nothing to gather.
 	 */
 	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		combine_coordinates(&c, &dport->sw_coord);
+		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
 
@@ -2151,7 +2137,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	}
 
 	/* Augment with the generic port (host bridge) perf data */
-	combine_coordinates(&c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
+	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0fc06455233d..0a0a121ee780 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -879,6 +879,10 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
 
+void cxl_coordinates_combine(struct access_coordinate *out,
+			     struct access_coordinate *c1,
+			     struct access_coordinate *c2);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.



