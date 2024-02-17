Return-Path: <linux-acpi+bounces-3658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD68592B3
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 21:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4948280EE8
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE77F464;
	Sat, 17 Feb 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFvRVGFQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE417F49D;
	Sat, 17 Feb 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201776; cv=none; b=P3ZBnfz9VVQJDaCRGjti5E7UDuWOHCimMd0MXOs+L4E+FTRUGhF5PHiuDbWdGWgxznt8apR6ujcUiwM5TVmTcO3pTj0N0rBLSHYy5Hxgo2ThrqGewr3m2MOy9+S9yzyiEnaphJnsQ6A8AdCCJwlB+2nMOeaYBLaDk/7/gv5FcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201776; c=relaxed/simple;
	bh=4T66unsvJn3PcUSKKf9muh02buFk97P7ecnXtMuBpvg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=GCsktPHt7deCjU18+O6gHz29A4qsVynDVUbjKVjWIljsRQWU9jicTXH7zBTmlcS7rKGKMEIOIYQpd3uH46NlErbuQkBeLBSo22r3OJ18uFOsRd5N71oKlgAs+JVGrQXy7ZBH2x469/pDpRu/hdGaqIUilzFFABGzt+BZMLVzJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFvRVGFQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708201774; x=1739737774;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4T66unsvJn3PcUSKKf9muh02buFk97P7ecnXtMuBpvg=;
  b=aFvRVGFQPqJVBPNen4JFfyuI5QWP+xoXNT2su1GFM2amGofV3daynOhG
   s1cLg3+COUq2/PsqeYZzdYP7JpcZuGe8jEYGsCFoYzqbJf+VQifUEWXI7
   fuxNpTfGhNUNACdD+oO/PyuvZxamMbaxU7q0qjw1DW5LyoXrGmmJPqBAP
   wyS4Da+MY/3+7xAybLGBGJn9mQla2bI1NwF9hirKivBXrIG2/gDCr6SGD
   sgQn9LMTlHa3eG/sBmeVbelwH1V0pK8G8EWTwtwK9O15Aj6Kx/l8IRxiZ
   MlNqxRZWnEGa9L7m6P8ge/cmZPWNotNHEO9eg/ogeLO/LCMlIGU9Yywcf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="27764455"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="27764455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 12:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="8746315"
Received: from pyuvaraj-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.230.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 12:29:33 -0800
Subject: [PATCH] cxl/acpi: Fix load failures due to single window creation
 failure
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org
Date: Sat, 17 Feb 2024 12:29:32 -0800
Message-ID: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The expectation is that cxl_parse_cfwms() continues in the face the of
failure as evidenced by code like:

    cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
    if (IS_ERR(cxlrd))
    	return 0;

There are other error paths in that function which mistakenly follow
idiomatic expectations and return an error when they should not. Most of
those mistakes are innocuous checks that hardly ever fail in practice.
However, a recent change succeed in making the implementation more
fragile by applying an idiomatic, but still wrong "fix" [1]. In this
failure case the kernel reports:

    cxl root0: Failed to populate active decoder targets
    cxl_acpi ACPI0017:00: Failed to add decode range: [mem 0x00000000-0x7fffffff flags 0x200]

...which is a real issue with that one window (to be fixed separately),
but ends up failing the entirety of cxl_acpi_probe().

Undo that recent breakage while also removing the confusion about
ignoring errors. Update all exits paths to return an error per typical
expectations and let an outer wrapper function handle dropping the
error.

Fixes: 91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()") [1]
Cc: <stable@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |   45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dcf2b39e1048..53d2dff0c7a3 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -316,31 +316,27 @@ static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
 };
 
-static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
-			   const unsigned long end)
+static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
+			     struct cxl_cfmws_context *ctx)
 {
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
-	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
 	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
-	struct acpi_cedt_cfmws *cfmws;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
 	struct resource *res;
 	int rc;
 
-	cfmws = (struct acpi_cedt_cfmws *) header;
-
 	rc = cxl_acpi_cfmws_verify(dev, cfmws);
 	if (rc) {
 		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
 			cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1);
-		return 0;
+		return rc;
 	}
 
 	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
@@ -376,7 +372,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
 	if (IS_ERR(cxlrd))
-		return 0;
+		return PTR_ERR(cxlrd);
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
@@ -420,16 +416,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		put_device(&cxld->dev);
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
-	if (rc) {
-		dev_err(dev, "Failed to add decode range: %pr", res);
-		return rc;
-	}
-	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
-		dev_name(&cxld->dev),
-		phys_to_target_node(cxld->hpa_range.start),
-		cxld->hpa_range.start, cxld->hpa_range.end);
-
-	return 0;
+	return rc;
 
 err_insert:
 	kfree(res->name);
@@ -438,6 +425,28 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	return -ENOMEM;
 }
 
+static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
+			   const unsigned long end)
+{
+	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
+	struct cxl_cfmws_context *ctx = arg;
+	struct device *dev = ctx->dev;
+	int rc;
+
+	dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
+		phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
+		cfmws->base_hpa + cfmws->window_size - 1);
+	rc = __cxl_parse_cfmws(cfmws, ctx);
+	if (rc)
+		dev_err(dev,
+			"Failed to add decode range: [%#llx - %#llx] (%d)\n",
+			cfmws->base_hpa,
+			cfmws->base_hpa + cfmws->window_size - 1, rc);
+
+	/* never fail cxl_acpi load for a single window failure */
+	return 0;
+}
+
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 					      struct device *dev)
 {


