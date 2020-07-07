Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87F42163C5
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 04:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGCPR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 22:15:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:43231 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGCPQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 22:15:16 -0400
IronPort-SDR: THL3/P6f4E9zYLMxmi7VTuRpKsuMOS8CVV7+i01Lzg923ZcLLpiy48T8QY516Bb2iy+lLoLV4q
 SONq/P6aXs4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="147538430"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="147538430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:16 -0700
IronPort-SDR: KWr+41UF5dK/EYqIBkmvjCHmMhXGfr/dDGAD67iDdqulXAw0gLqjYLgg6fGNi1+pkyIcBoVPVz
 Tnjb5sFUxFdg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="482894773"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:15 -0700
Subject: [PATCH v2 05/12] tools/testing/nvdimm: Add command debug messages
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 18:59:00 -0700
Message-ID: <159408714018.2385045.16027230217932492420.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Arrange the for nfit_test_ctl() path to dump command payloads similarly
to the acpi_nfit_ctl() path. This is useful for comparing the
sequence of command events between an emulated ACPI-NFIT platform and a
real one.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index ddf9b3095bfa..9c6f475befe4 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1192,6 +1192,29 @@ static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 	return i;
 }
 
+static void nfit_ctl_dbg(struct acpi_nfit_desc *acpi_desc,
+		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
+		unsigned int len)
+{
+	struct nfit_test *t = container_of(acpi_desc, typeof(*t), acpi_desc);
+	unsigned int func = cmd;
+	unsigned int family = 0;
+
+	if (cmd == ND_CMD_CALL) {
+		struct nd_cmd_pkg *pkg = buf;
+
+		len = pkg->nd_size_in;
+		family = pkg->nd_family;
+		buf = pkg->nd_payload;
+		func = pkg->nd_command;
+	}
+	dev_dbg(&t->pdev.dev, "%s family: %d cmd: %d: func: %d input length: %d\n",
+			nvdimm ? nvdimm_name(nvdimm) : "bus", family, cmd, func,
+			len);
+	print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 16, 4,
+			buf, min(len, 256u), true);
+}
+
 static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc)
@@ -1205,6 +1228,8 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		cmd_rc = &__cmd_rc;
 	*cmd_rc = 0;
 
+	nfit_ctl_dbg(acpi_desc, nvdimm, cmd, buf, buf_len);
+
 	if (nvdimm) {
 		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 		unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);

