Return-Path: <linux-acpi+bounces-8205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239B97278E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 05:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B5A1F24CBE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 03:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D04A22638;
	Tue, 10 Sep 2024 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibXSuYYg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FA4A08;
	Tue, 10 Sep 2024 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938133; cv=none; b=RmyXXc4Zc98gbscTanK3ZI/ilnBzEDHNi2XAfw0OtDgJ1M1jFa2+rkpIk3TM4wH67kj0vHwl6sqRHeo5Kk3I9hhTGF0XFQBTP4ZgaSs425oPT/kl7dDOo/rsATxQ8MKFqQ+abgNTBbdscjPThyaKvStgv8K8paSBn2AqJ1EzEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938133; c=relaxed/simple;
	bh=hTAOs59CgV6SRUGLIoHXb+0/cJ7kH3pMVMFLng6clnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=krlNGkANjcI2aTgEN2/tQ5uhyk07HXc9IovygWQqRHsb4vuC4cTxFN4XctI7gn5eDVD0dlD/3pgNqGbs27DWoaiWtAJDtmClw4qBZk/zWp7UA9k33aJpP1IzJWQQz6/veLN5D2orh+SLssPFDpqNJbGkGy7dK7iCWvTlwQmCZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibXSuYYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DAEC4CEC5;
	Tue, 10 Sep 2024 03:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725938133;
	bh=hTAOs59CgV6SRUGLIoHXb+0/cJ7kH3pMVMFLng6clnY=;
	h=From:To:Cc:Subject:Date:From;
	b=ibXSuYYgxKVTygALuYMlrzi1W0L/Kof5ESpR20KJN2kt3K2Mf5gDCCaYwh1meIW5r
	 UcUo0Ro2Var+yPliBcbZhbw5qgRXf6vbYU7gSRunCzbDXZYxjg3rK3YHCuu6KZl0sR
	 TXfRnKHJXcDyAOHItUZim+5wAABkoit1Fqm4Z5OliEYhA6wv6cG/LvPKL7odpoFlfK
	 DK+tBijaJNiOwKCgEe9vfJNz8NuqSt/mIswhqqXBKbeDqtKXzUQqeka6LpmwkFtlTF
	 SKi98SxmMfSmLp5ZKQ0QuxHYLu+sIKR5sy0o6SyjOYlUT5U0E9DWBnLFJyOVV82PTd
	 dZ0qDfbwRpoSQ==
From: Mario Limonciello <superm1@kernel.org>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perry.yuan@amd.com,
	gautham.shenoy@amd.com,
	luke@ljones.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	al0uette@outlook.com,
	vderp@icloud.com
Subject: [PATCH] ACPI: CPPC: Add support for setting EPP register in FFH
Date: Mon,  9 Sep 2024 22:15:24 -0500
Message-ID: <20240910031524.106387-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Some Asus AMD systems are reported to not be able to change EPP values
because the BIOS doesn't advertise support for the CPPC MSR and the PCC
region is not configured.

However the ACPI 6.2 specification allows CPC registers to be declared
in FFH:
```
Starting with ACPI Specification 6.2, all _CPC registers can be in
PCC, System Memory, System IO, or Functional Fixed Hardware address
spaces. OSPM support for this more flexible register space scheme
is indicated by the “Flexible Address Space for CPPC Registers” _OSC
bit.
```

If this _OSC has been set allow using FFH to configure EPP.

Reported-by: al0uette@outlook.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
Suggested-by: al0uette@outlook.com
Tested-by: vderp@icloud.com
Tested-by: al0uette@outlook.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index dd3d3082c8c7..3b5b695bb80b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -103,6 +103,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(cpc)->cpc_entry.reg.space_id ==	\
 				ACPI_ADR_SPACE_PLATFORM_COMM)
 
+/* Check if a CPC register is in FFH */
+#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_FIXED_HARDWARE)
+
 /* Check if a CPC register is in SystemMemory */
 #define CPC_IN_SYSTEM_MEMORY(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&	\
 				(cpc)->cpc_entry.reg.space_id ==	\
@@ -1486,9 +1491,12 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
+	} else if (osc_cpc_flexible_adr_space_confirmed &&
+		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
+		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
 	} else {
 		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC is not supported\n");
+		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
 	}
 
 	return ret;
-- 
2.43.0


