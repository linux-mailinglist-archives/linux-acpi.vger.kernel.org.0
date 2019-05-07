Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5715C30
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfEGGBj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 02:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfEGFgD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 May 2019 01:36:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A392420B7C;
        Tue,  7 May 2019 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207362;
        bh=B/gkt7iNSmPmscq9jO/iJBG7GmmIjSdgYLzaZQRpVmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2eFw6OY7htbyuF6kXuXcMlHCKY2VYGGSwXXA13vZUeb6EcqvAsW9unn6AFWuygK3p
         Z0p7GPNBaq/Hb5QAuSJTyd0Z4wr8sAdNRlxJ0bC9hcs7S+3mkcm7GjS+TBvGhafYnO
         zj/hovWJ09kQljXGkazMylYaXBlwG/qmG3N3WlUs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/81] acpi/nfit: Always dump _DSM output payload
Date:   Tue,  7 May 2019 01:34:35 -0400
Message-Id: <20190507053554.30848-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 351f339faa308c1c1461314a18c832239a841ca0 ]

The dynamic-debug statements for command payload output only get emitted
when the command is not ND_CMD_CALL. Move the output payload dumping
ahead of the early return path for ND_CMD_CALL.

Fixes: 31eca76ba2fc9 ("...whitelisted dimm command marshaling mechanism")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 925dbc751322..8340c81b258b 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -542,6 +542,12 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		goto out;
 	}
 
+	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
+			cmd_name, out_obj->buffer.length);
+	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
+			out_obj->buffer.pointer,
+			min_t(u32, 128, out_obj->buffer.length), true);
+
 	if (call_pkg) {
 		call_pkg->nd_fw_size = out_obj->buffer.length;
 		memcpy(call_pkg->nd_payload + call_pkg->nd_size_in,
@@ -560,12 +566,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		return 0;
 	}
 
-	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
-			cmd_name, out_obj->buffer.length);
-	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
-			out_obj->buffer.pointer,
-			min_t(u32, 128, out_obj->buffer.length), true);
-
 	for (i = 0, offset = 0; i < desc->out_num; i++) {
 		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i, buf,
 				(u32 *) out_obj->buffer.pointer,
-- 
2.20.1

