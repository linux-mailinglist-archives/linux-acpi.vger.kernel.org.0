Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956F81AEDAB
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Apr 2020 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDRNxW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Apr 2020 09:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDRNsY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 18 Apr 2020 09:48:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F9122240;
        Sat, 18 Apr 2020 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217703;
        bh=6zGuVlsnnAF2MBnoLbzHZy4QBMSzi7A2hpbIrg/pvyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sjz0FABcTdemgyS73Voi6gkuYKueGJoNGa0+Lr0pURax4G6sQHyFNfZG85Ivccwug
         4YkDP3maTVO3TgLdiVHxzPiNaUceImyrh+A6DK+u/ggmU1SvB4CMLRkR9yRy3s05C0
         rCIMFQDEKr+Dc5Wa3kRFXDRcZbWlnrhKC8IaBjeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 06/73] acpi/nfit: improve bounds checking for 'func'
Date:   Sat, 18 Apr 2020 09:47:08 -0400
Message-Id: <20200418134815.6519-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 01091c496f920e634ea84b689f480c39016752a8 ]

The 'func' variable can come from the user in the __nd_ioctl().  If it's
too high then the (1 << func) shift in acpi_nfit_clear_to_send() is
undefined.  In acpi_nfit_ctl() we pass 'func' to test_bit(func, &dsm_mask)
which could result in an out of bounds access.

To fix these issues, I introduced the NVDIMM_CMD_MAX (31) define and
updated nfit_dsm_revid() to use that define as well instead of magic
numbers.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20200225161927.hvftuq7kjn547fyj@kili.mountain
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 10 ++++++----
 drivers/acpi/nfit/nfit.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a3320f93616de..d0090f71585c4 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -360,7 +360,7 @@ static union acpi_object *acpi_label_info(acpi_handle handle)
 
 static u8 nfit_dsm_revid(unsigned family, unsigned func)
 {
-	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][32] = {
+	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][NVDIMM_CMD_MAX+1] = {
 		[NVDIMM_FAMILY_INTEL] = {
 			[NVDIMM_INTEL_GET_MODES] = 2,
 			[NVDIMM_INTEL_GET_FWINFO] = 2,
@@ -386,7 +386,7 @@ static u8 nfit_dsm_revid(unsigned family, unsigned func)
 
 	if (family > NVDIMM_FAMILY_MAX)
 		return 0;
-	if (func > 31)
+	if (func > NVDIMM_CMD_MAX)
 		return 0;
 	id = revid_table[family][func];
 	if (id == 0)
@@ -492,7 +492,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	 * Check for a valid command.  For ND_CMD_CALL, we also have to
 	 * make sure that the DSM function is supported.
 	 */
-	if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
+	if (cmd == ND_CMD_CALL &&
+	    (func > NVDIMM_CMD_MAX || !test_bit(func, &dsm_mask)))
 		return -ENOTTY;
 	else if (!test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
@@ -3492,7 +3493,8 @@ static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 	if (nvdimm && cmd == ND_CMD_CALL &&
 			call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
 		func = call_pkg->nd_command;
-		if ((1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
+		if (func > NVDIMM_CMD_MAX ||
+		    (1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
 			return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 24241941181ce..b317f4043705f 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -34,6 +34,7 @@
 		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
 
 #define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
+#define NVDIMM_CMD_MAX 31
 
 #define NVDIMM_STANDARD_CMDMASK \
 (1 << ND_CMD_SMART | 1 << ND_CMD_SMART_THRESHOLD | 1 << ND_CMD_DIMM_FLAGS \
-- 
2.20.1

