Return-Path: <linux-acpi+bounces-2600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066AF81D0B8
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 01:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286851C214D2
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 00:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821D182;
	Sat, 23 Dec 2023 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQhcVHaR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C77EE;
	Sat, 23 Dec 2023 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703290249; x=1734826249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=afU5wIxdwWlNn3gp/rwS4T6JsOud7wKWimp37CFAj40=;
  b=WQhcVHaRD7VwUO+YFCJTm+dK2fORDmmy1sU9ISXjeeIJabSLMrq5x/Ya
   pGMqqG5JV9Jo/No7ucw8DyGYBmRrG9Y2Zy5x+jz7LlZ7/F79k2LizTIxX
   mql8wbg1O9l5WYKjyiUmMs18OAEWVTBVVnkJh8ELttVRL1yM2qo2i4AVu
   igfhJYH6fESnUWxPBO75h0HBMVR905bwvFn/kYo1WsO/6F/u3yacbzXa1
   qUzSeMCx4bxBFxk4rTCd8dslZM0wv1IRjKAMri6k9IwkEXZOrLJAyjYQa
   lL6yU7Ul7hvEGzBxt0I4eIcwum6h1OJom+XUCr9XHt7bFscGqV5gsybaR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="14850201"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="14850201"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="900641890"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="900641890"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.160.53])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:10:47 -0800
From: alison.schofield@intel.com
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH v2] ACPI: NUMA: Fix overlap when extending memblks to fill CFMWS
Date: Fri, 22 Dec 2023 16:10:44 -0800
Message-Id: <20231223001044.1401226-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When the BIOS only partially describes a CFMWS Window in the SRAT
the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
to fill the entire CFMWS Window, thereby applying the proximity domain
to the entire CFMWS.

The calculation of the memblks to fill has an off-by-one error, that
causes numa_init to fail when it sees the overlap:

[] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
[] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
[] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]

Fix by making the 'end' parameter to numa_fill_memblks() exclusive.

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Send to ACPI maintainer, reviewer, and mailing list.


 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 12f330b0eac0..b99062f7c412 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
-	end = cfmws->base_hpa + cfmws->window_size;
+	end = cfmws->base_hpa + cfmws->window_size - 1;
 
 	/*
 	 * The SRAT may have already described NUMA details for all,

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3


