Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305220A991
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 02:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgFZAG5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jun 2020 20:06:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:11576 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgFZAG5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jun 2020 20:06:57 -0400
IronPort-SDR: coOwfxotTKhf5cGzWFt71tnIPGd0g70oPjneoo/WCO4TXR0xEFF/plk2VJLz+4aRkYQOXvlV+L
 rMX4jXOQkdOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="229870844"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="229870844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:06:56 -0700
IronPort-SDR: rnMUlXvABKnvDX7FrKhx1Qg+l4cDNKEf+QmLz7CR9oEO2mUPxBRdSgTIvti8KqG7sE4CxI0ZQX
 8cKphOtS+N9Q==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="279989435"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:06:56 -0700
Subject: [PATCH 04/12] tools/testing/nvdimm: Cleanup dimm index passing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Jun 2020 16:50:42 -0700
Message-ID: <159312904210.1850128.9566374963556922854.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
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

