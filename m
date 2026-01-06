Return-Path: <linux-acpi+bounces-19973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED716CF7A82
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B5C300FEFA
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811ED30E0E9;
	Tue,  6 Jan 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXRS8HL4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4030DEA6;
	Tue,  6 Jan 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693710; cv=none; b=MvweDalUVCdWU7iLdFPBVeWP+Qj2z3XckoqKZYn8AfJd+P4+5+SZkit6t7Tvlm54yGoe4nGyP0rj8yIKPLP+Ok8YBPgQcYb1hMmVN8tmda4Sjh4p2Tr+mrnclIr/uvuGxmuEWgESWPMJZAkmERD/91Zc/+/J/2nWTAlY0NlaN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693710; c=relaxed/simple;
	bh=9VmWRogAQpxaWnZ1HlwLtjxIGkfqfYOU297RmfywkiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G44Q5qAekTjEmvSqY7nhBpmn4iJ77BYCUEc3ei607BtCje7SdeD/9XRHrG7cGnG8xOgoZE9hD8+KRaLPLTo/tWYQK8lpaIdF9/czU+bCC6u/us47Lpu+UzjYWdR28ZR3/XRjuxnrwiZt5JSKWhwtgxTCqnKDxamlQYpcwA5dP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXRS8HL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5387C19424;
	Tue,  6 Jan 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767693709;
	bh=9VmWRogAQpxaWnZ1HlwLtjxIGkfqfYOU297RmfywkiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXRS8HL46e1Lw8onfIFdnPyuJH4Jdh3Y6JDXglgPXfe3Fz05Ha53uf+UEMzYwhf15
	 xiaRtfoJPhTip+9sF4KlHTW/jUxqmUXC5OWorshajTSAB/lZ7j9ysusH3NmvdftPcb
	 LJ7Ib2TPCl3iYD9axHk0iZgQlfbUPzShtSgyFi7fWVjLTxoCIaaBuSCqeE2oDk9rnX
	 K3AOJwQzXKweBvbNLTyLl2DpvB7icSTvQQzqCSWsF1rdzRIodu0/gXeCspShClmgsj
	 wc6nDKm9Yfdz8X7Pe6TpHIXAdowojvTQ3C4vShTATL2E/irsu1x5DOaUwP8MONs16M
	 DYGiTB378MRww==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vd3sq-000000008ZQ-07JF;
	Tue, 06 Jan 2026 11:01:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] apei/ghes: ensure that won't go past CPER allocated record
Date: Tue,  6 Jan 2026 11:01:37 +0100
Message-ID: <8731f124c82a48850648695530a5442d60034de1.1767693532.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767693532.git.mchehab+huawei@kernel.org>
References: <cover.1767693532.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The logic at ghes_new() prevents allocating too large records, by
checking if they're bigger than GHES_ESTATUS_MAX_SIZE (currently, 64KB).
Yet, the allocation is done with the actual number of pages from the
CPER bios table location, which can be smaller.

Yet, a bad firmware could send data with a different size, which might
be bigger than the allocated memory, causing an OOPS:

[13095.899926] Unable to handle kernel paging request at virtual address fff00000f9b40000
[13095.899961] Mem abort info:
[13095.900017]   ESR = 0x0000000096000007
[13095.900088]   EC = 0x25: DABT (current EL), IL = 32 bits
[13095.900156]   SET = 0, FnV = 0
[13095.900181]   EA = 0, S1PTW = 0
[13095.900211]   FSC = 0x07: level 3 translation fault
[13095.900255] Data abort info:
[13095.900421]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[13095.900486]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[13095.900525]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[13095.900713] swapper pgtable: 4k pages, 52-bit VAs, pgdp=000000008ba16000
[13095.900752] [fff00000f9b40000] pgd=180000013ffff403, p4d=180000013fffe403, pud=180000013f85b403, pmd=180000013f68d403, pte=0000000000000000
[13095.901312] Internal error: Oops: 0000000096000007 [#1]  SMP
[13095.901659] Modules linked in:
[13095.902201] CPU: 0 UID: 0 PID: 303 Comm: kworker/0:1 Not tainted 6.19.0-rc1-00002-gda407d200220 #34 PREEMPT
[13095.902461] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
[13095.902719] Workqueue: kacpi_notify acpi_os_execute_deferred
[13095.903778] pstate: 214020c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[13095.903892] pc : hex_dump_to_buffer+0x30c/0x4a0
[13095.904146] lr : hex_dump_to_buffer+0x328/0x4a0
[13095.904204] sp : ffff800080e13880
[13095.904291] x29: ffff800080e13880 x28: ffffac9aba86f6a8 x27: 0000000000000083
[13095.904704] x26: fff00000f9b3fffc x25: 0000000000000004 x24: 0000000000000004
[13095.905335] x23: ffff800080e13905 x22: 0000000000000010 x21: 0000000000000083
[13095.905483] x20: 0000000000000001 x19: 0000000000000008 x18: 0000000000000010
[13095.905617] x17: 0000000000000001 x16: 00000007c7f20fec x15: 0000000000000020
[13095.905850] x14: 0000000000000008 x13: 0000000000081020 x12: 0000000000000008
[13095.906175] x11: ffff800080e13905 x10: ffff800080e13988 x9 : 0000000000000000
[13095.906733] x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000020
[13095.907197] x5 : 0000000000000030 x4 : 00000000fffffffe x3 : 0000000000000000
[13095.907623] x2 : ffffac9aba78c1c8 x1 : ffffac9aba76d0a8 x0 : 0000000000000008
[13095.908284] Call trace:
[13095.908866]  hex_dump_to_buffer+0x30c/0x4a0 (P)
[13095.909135]  print_hex_dump+0xac/0x170
[13095.909179]  cper_estatus_print_section+0x90c/0x968
[13095.909336]  cper_estatus_print+0xf0/0x158
[13095.909348]  __ghes_print_estatus+0xa0/0x148
[13095.909656]  ghes_proc+0x1bc/0x220
[13095.909883]  ghes_notify_hed+0x5c/0xb8
[13095.909957]  notifier_call_chain+0x78/0x148
[13095.910180]  blocking_notifier_call_chain+0x4c/0x80
[13095.910246]  acpi_hed_notify+0x28/0x40
[13095.910558]  acpi_ev_notify_dispatch+0x50/0x80
[13095.910576]  acpi_os_execute_deferred+0x24/0x48
[13095.911161]  process_one_work+0x15c/0x3b0
[13095.911326]  worker_thread+0x2d0/0x400
[13095.911775]  kthread+0x148/0x228
[13095.912082]  ret_from_fork+0x10/0x20
[13095.912687] Code: 6b14033f 540001ad a94707e2 f100029f (b8747b44)
[13095.914085] ---[ end trace 0000000000000000 ]---

Prevent that by taking the actual allocated are into account when
checking for CPER length.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++++-
 include/acpi/ghes.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fc3f8aed99d5..350f666b7783 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -29,6 +29,7 @@
 #include <linux/cper.h>
 #include <linux/cleanup.h>
 #include <linux/platform_device.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
@@ -294,6 +295,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		error_block_length = GHES_ESTATUS_MAX_SIZE;
 	}
 	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
+	ghes->error_block_length = error_block_length;
 	if (!ghes->estatus) {
 		rc = -ENOMEM;
 		goto err_unmap_status_addr;
@@ -365,13 +367,15 @@ static int __ghes_check_estatus(struct ghes *ghes,
 				struct acpi_hest_generic_status *estatus)
 {
 	u32 len = cper_estatus_len(estatus);
+	u32 max_len = min(ghes->generic->error_block_length,
+			  ghes->error_block_length);
 
 	if (len < sizeof(*estatus)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
 		return -EIO;
 	}
 
-	if (len > ghes->generic->error_block_length) {
+	if (!len || len > max_len) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
 		return -EIO;
 	}
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6e..5866f50bac0c 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -27,6 +27,7 @@ struct ghes {
 		struct timer_list timer;
 		unsigned int irq;
 	};
+	unsigned int error_block_length;
 	struct device *dev;
 	struct list_head elist;
 };
-- 
2.52.0


