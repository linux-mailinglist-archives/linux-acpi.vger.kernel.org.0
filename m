Return-Path: <linux-acpi+bounces-2950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476AA832E15
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7EA1C226BF
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961F55E42;
	Fri, 19 Jan 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvfZJnCc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1A54BEE;
	Fri, 19 Jan 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685038; cv=none; b=UCPGYHjQWMuWGKb54y0+eKABAH2SKoK2wTjA7SgdfQTCoLzqVgynRLhP9ExLlE+23uijcHf55nV1uEjjBsiqdQWiArMVOVDdzHXfHgaOVRbUxKS7MPjvyyQFA+6JO9TSrR9mgei4xIUO2w2afVM+sDzVi97lnZSs4aD32VgvHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685038; c=relaxed/simple;
	bh=4vSnUmljeRQwFzEWfTTAKDPST70dc7aDcN6IoFNFNPg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpRNBp3Udg5CqFYeK+1e9r3DDuAJD99tmyUNwS/+UqnD1l4QMZ5l1iobUZ2J9S41tw8rIkZ52P4wIrIhgNffTQw1HqI0uSwmhI+FLW3gSVuS2uS20t6Fsnd62eETmH6erCTXVBzSX0aRuu8J1gCTlxDIVNa4yRpDRh79ZCnnulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvfZJnCc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685036; x=1737221036;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vSnUmljeRQwFzEWfTTAKDPST70dc7aDcN6IoFNFNPg=;
  b=hvfZJnCcEn3rSwvh6ENlZp45U5aKYMvYcVE2PpkPnoKCsf9cK/jewj4Q
   QsIJr+E8iVfvGsgtaYeM+F2faWTmenrgy3vI4LZbrtuBaFMInGlIPEKed
   vTn4ZYJlmnB4PRQ78eQf8qivxo1m7Us7KahwdAMSCEr7YEnN8p4DQnLWI
   CYWS5Fzda9cMMxn0rReXMhYvGLFHTp3gpG/4ScVan23y0WlpoEPebKxC0
   XRuDbVkLmCsonyQkIPuDGeJ7vMRHHAxwbQqz/atLnpqNvGN4x4LWvudKf
   nGd6iLhYxGvivRvHsjKM3E8Axc2mPsDpjrnZMyPFz39h9mJJvejcn9Ohs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7487509"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7487509"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032001820"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1032001820"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:52 -0800
Subject: [PATCH v4 08/11] cxl/region: Calculate performance data for a region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:52 -0700
Message-ID: <170568503239.1008395.2633682569497108646.stgit@djiang5-mobl3>
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

Calculate and store the performance data for a CXL region. Find the worst
read and write latency for all the included ranges from each of the devices
that attributes to the region and designate that as the latency data. Sum
all the read and write bandwidth data for each of the device region and
that is the total bandwidth for the region.

The perf list is expected to be constructed before the endpoint decoders
are registered and thus there should be no early reading of the entries
from the region assemble action. The calling of the region qos calculate
function is under the protection of cxl_dpa_rwsem and will ensure that
all DPA associated work has completed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Calculate access classes 0 and 1 by retrieving host bridge coords
- Add lockdep assert for cxl_dpa_rwsem (Dan)
- Clarify that HMAT code is HMEM_REPORTING code. (Dan)
---
 drivers/cxl/core/cdat.c   |   74 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c |    2 +
 drivers/cxl/cxl.h         |    4 ++
 3 files changed, 80 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6e3998723aaa..7acb5837afad 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -8,6 +8,7 @@
 #include "cxlpci.h"
 #include "cxlmem.h"
 #include "cxl.h"
+#include "core.h"
 
 struct dsmas_entry {
 	struct range dpa_range;
@@ -546,3 +547,76 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 EXPORT_SYMBOL_NS_GPL(cxl_coordinates_combine, CXL);
 
 MODULE_IMPORT_NS(CXL);
+
+void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
+				    struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxlmd->endpoint;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate coord;
+	struct range dpa = {
+			.start = cxled->dpa_res->start,
+			.end = cxled->dpa_res->end,
+	};
+	struct list_head *perf_list;
+	struct cxl_dpa_perf *perf;
+	bool found = false;
+	int rc;
+
+	switch (cxlr->mode) {
+	case CXL_DECODER_RAM:
+		perf_list = &mds->ram_perf_list;
+		break;
+	case CXL_DECODER_PMEM:
+		perf_list = &mds->pmem_perf_list;
+		break;
+	default:
+		return;
+	}
+
+	lockdep_assert_held(&cxl_dpa_rwsem);
+
+	list_for_each_entry(perf, perf_list, list) {
+		if (range_contains(&perf->dpa_range, &dpa)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return;
+
+	rc = cxl_hb_get_perf_coordinates(port, hb_coord);
+	if (rc)  {
+		dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
+		return;
+	}
+
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		/* Pickup the host bridge coords */
+		cxl_coordinates_combine(&coord, &hb_coord[i], &perf->coord);
+
+		/* Get total bandwidth and the worst latency for the cxl region */
+		cxlr->coord[i].read_latency = max_t(unsigned int,
+						    cxlr->coord[i].read_latency,
+						    coord.read_latency);
+		cxlr->coord[i].write_latency = max_t(unsigned int,
+						     cxlr->coord[i].write_latency,
+						     coord.write_latency);
+		cxlr->coord[i].read_bandwidth += coord.read_bandwidth;
+		cxlr->coord[i].write_bandwidth += coord.write_bandwidth;
+
+		/*
+		 * Convert latency to nanosec from picosec to be consistent
+		 * with the resulting latency coordinates computed by the
+		 * HMAT_REPORTING code.
+		 */
+		cxlr->coord[i].read_latency =
+			DIV_ROUND_UP(cxlr->coord[i].read_latency, 1000);
+		cxlr->coord[i].write_latency =
+			DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000);
+	}
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 57a5901d5a60..7f19b533c5ae 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1722,6 +1722,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	cxl_region_perf_data_calculate(cxlr, cxled);
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 80e6bd294e18..f6637fa33113 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -519,6 +519,7 @@ struct cxl_region_params {
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
  * @params: active + config params for the region
+ * @coord: QoS access coordinates for the region
  */
 struct cxl_region {
 	struct device dev;
@@ -529,6 +530,7 @@ struct cxl_region {
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
 	struct cxl_region_params params;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 };
 
 struct cxl_nvdimm_bridge {
@@ -880,6 +882,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
 int cxl_hb_get_perf_coordinates(struct cxl_port *port,
 				struct access_coordinate *coord);
+void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
+				    struct cxl_endpoint_decoder *cxled);
 
 void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,



