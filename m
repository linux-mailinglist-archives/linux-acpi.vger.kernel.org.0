Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF62163C3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 04:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGGCPL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 22:15:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:6220 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGCPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 22:15:11 -0400
IronPort-SDR: I0todIceofEy5RJlL7pfhaNIoaOtkn6H0fktysxtspZKaiQOUZnwT9iEhMMCxw3fbdm/i3VWOH
 fsQDvEoDPe+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127614660"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="127614660"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:10 -0700
IronPort-SDR: 8cjKsX6iiwrrWvCxP5EkqEBJft6v6i1QXccRUD3WhUna/HYI4kqetiBoPy+bjYVCIuxK7BRmhQ
 jNNeCuycNSaw==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="279456883"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:10 -0700
Subject: [PATCH v2 04/12] tools/testing/nvdimm: Cleanup dimm index passing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 18:58:55 -0700
Message-ID: <159408713507.2385045.7759465411330693892.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
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

