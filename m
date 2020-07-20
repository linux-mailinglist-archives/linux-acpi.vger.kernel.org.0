Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42A2227244
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 00:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGTWYD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 18:24:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:59865 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgGTWYD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 18:24:03 -0400
IronPort-SDR: BSEOtqvsI3zy8iU+PYiy9rCFo03mfqDK3jYH6f1nckyfIgwBzXhkqvp/hsCQh4ERoGy9UHKRJN
 noVHW/qaIOzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="150005133"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="150005133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:03 -0700
IronPort-SDR: Mf2MJZofu5ZLWOMugflSD2QywH0CbLojclHm1ksmIs8JlHCh0kz2HF3dintBLaDwk6hliqYJIg
 F81Qvy337srA==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="270258499"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:03 -0700
Subject: [PATCH v3 04/11] tools/testing/nvdimm: Cleanup dimm index passing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 15:07:46 -0700
Message-ID: <159528286610.993790.13399000933811867354.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ND_CMD_CALL path only applies to the nfit_test0 emulated DIMMs.
Cleanup occurrences of (i - t->dcr_idx) since that offset fixup only
applies to cases where nfit_test1 needs a bus-local index.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index a59174ba1d2a..ddf9b3095bfa 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1224,6 +1224,11 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 			i = get_dimm(nfit_mem, func);
 			if (i < 0)
 				return i;
+			if (i >= NUM_DCR) {
+				dev_WARN_ONCE(&t->pdev.dev, 1,
+						"ND_CMD_CALL only valid for nfit_test0\n");
+				return -EINVAL;
+			}
 
 			switch (func) {
 			case NVDIMM_INTEL_GET_SECURITY_STATE:
@@ -1252,11 +1257,11 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 				break;
 			case NVDIMM_INTEL_OVERWRITE:
 				rc = nd_intel_test_cmd_overwrite(t,
-						buf, buf_len, i - t->dcr_idx);
+						buf, buf_len, i);
 				break;
 			case NVDIMM_INTEL_QUERY_OVERWRITE:
 				rc = nd_intel_test_cmd_query_overwrite(t,
-						buf, buf_len, i - t->dcr_idx);
+						buf, buf_len, i);
 				break;
 			case NVDIMM_INTEL_SET_MASTER_PASSPHRASE:
 				rc = nd_intel_test_cmd_master_set_pass(t,
@@ -1272,48 +1277,45 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 				break;
 			case ND_INTEL_FW_GET_INFO:
 				rc = nd_intel_test_get_fw_info(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_START_UPDATE:
 				rc = nd_intel_test_start_update(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_SEND_DATA:
 				rc = nd_intel_test_send_data(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_FINISH_UPDATE:
 				rc = nd_intel_test_finish_fw(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_FINISH_QUERY:
 				rc = nd_intel_test_finish_query(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_SMART:
 				rc = nfit_test_cmd_smart(buf, buf_len,
-						&t->smart[i - t->dcr_idx]);
+						&t->smart[i]);
 				break;
 			case ND_INTEL_SMART_THRESHOLD:
 				rc = nfit_test_cmd_smart_threshold(buf,
 						buf_len,
-						&t->smart_threshold[i -
-							t->dcr_idx]);
+						&t->smart_threshold[i]);
 				break;
 			case ND_INTEL_SMART_SET_THRESHOLD:
 				rc = nfit_test_cmd_smart_set_threshold(buf,
 						buf_len,
-						&t->smart_threshold[i -
-							t->dcr_idx],
-						&t->smart[i - t->dcr_idx],
+						&t->smart_threshold[i],
+						&t->smart[i],
 						&t->pdev.dev, t->dimm_dev[i]);
 				break;
 			case ND_INTEL_SMART_INJECT:
 				rc = nfit_test_cmd_smart_inject(buf,
 						buf_len,
-						&t->smart_threshold[i -
-							t->dcr_idx],
-						&t->smart[i - t->dcr_idx],
+						&t->smart_threshold[i],
+						&t->smart[i],
 						&t->pdev.dev, t->dimm_dev[i]);
 				break;
 			default:

