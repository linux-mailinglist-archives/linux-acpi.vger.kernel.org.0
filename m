Return-Path: <linux-acpi+bounces-3752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75085CBDB
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B071C1C21B9F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE41154BE3;
	Tue, 20 Feb 2024 23:14:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3015445E;
	Tue, 20 Feb 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470871; cv=none; b=hGLAfAl6FvA6LyuvgXPQO/7vOyYwS8KpHvf2BDpoK29N+xwmbOOTGRtPixc51wrvCORFbe7uIktlL6lF8goXWnZdKd4YR+VPfYgzcyXQxM3W0p+0HrWCExGes7WFLB3peXM4dUa3DVxRdxzzU/AdyVpxPRCDNNjL5ceuOne0uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470871; c=relaxed/simple;
	bh=dQg8qsH9X2bvNB7hkGaWd6M7hfVRVXFX3lldxs4yKlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxaNFgyB/8cqgzNnDQL/T+3bllr5ckKKenv0lAyw7h8vyFW3rp7bH40O2e3ypsH7zkt/YtYJSCIfW0mYee4kKtQECChCH/TwETJRgdWSboORZmj7Pbqc8PtBisJzGyEzMaBDLjOXGPOeupNCi8lD56mFy1oP51cFowDlQtytmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D178C433F1;
	Tue, 20 Feb 2024 23:14:30 +0000 (UTC)
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
Subject: [PATCH v6 09/12] cxl/region: Calculate performance data for a region
Date: Tue, 20 Feb 2024 16:12:38 -0700
Message-ID: <20240220231402.3156281-10-dave.jiang@intel.com>
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
 drivers/cxl/core/cdat.c   | 65 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c |  2 ++
 drivers/cxl/cxl.h         |  4 +++
 3 files changed, 71 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 02e97a90a43c..40052666ebf1 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -9,6 +9,7 @@
 #include "cxlmem.h"
 #include "core.h"
 #include "cxl.h"
+#include "core.h"
 
 struct dsmas_entry {
 	struct range dpa_range;
@@ -515,3 +516,67 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 }
 
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
+	struct cxl_dpa_perf *perf;
+	int rc;
+
+	switch (cxlr->mode) {
+	case CXL_DECODER_RAM:
+		perf = &mds->ram_perf;
+		break;
+	case CXL_DECODER_PMEM:
+		perf = &mds->pmem_perf;
+		break;
+	default:
+		return;
+	}
+
+	lockdep_assert_held(&cxl_dpa_rwsem);
+
+	if (!range_contains(&perf->dpa_range, &dpa))
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
index 4c7fd2d5cccb..9a0d2d7621de 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1752,6 +1752,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	cxl_region_perf_data_calculate(cxlr, cxled);
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index de477eb7f5d5..95864ce7b394 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -517,6 +517,7 @@ struct cxl_region_params {
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
  * @params: active + config params for the region
+ * @coord: QoS access coordinates for the region
  */
 struct cxl_region {
 	struct device dev;
@@ -527,6 +528,7 @@ struct cxl_region {
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
 	struct cxl_region_params params;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 };
 
 struct cxl_nvdimm_bridge {
@@ -881,6 +883,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
 int cxl_hb_get_perf_coordinates(struct cxl_port *port,
 				struct access_coordinate *coord);
+void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
+				    struct cxl_endpoint_decoder *cxled);
 
 void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
 
-- 
2.43.0


