Return-Path: <linux-acpi+bounces-8394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DD985882
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41696B241D7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957418E76E;
	Wed, 25 Sep 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRpDzjmM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23218E767;
	Wed, 25 Sep 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264266; cv=none; b=mA/qk7me3s7PAeX2PvVtUkycNv7P8tw0fa/bw2WfwM46qeBpWk9ZGq4/FANl8AKFiRZ4Da3jpvErbOjT9u5GMYrJD9RiU6kuY7anUggwuOA2NDhw3qqBPa7Ju0UpqIROoHwuMkHmSs0neMvrD1v+U6axxgVf7F60uQhOpPgODbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264266; c=relaxed/simple;
	bh=43PNlekTPh48k01lhekEHPyaIH3a8W2Fp1duzv17bG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYnS/nd/PQLuHnyEVxRcRJ9AKxpftLXXHNNuQIaiRNVe/vzke2md+aTkNAnFOaOquLXBdLdy03zit2YFmTrXBstIWPi+DzK9dKFcKbRoIscyBXtxya8nTNOar/JXyHU5vpy4INdDITV70GAZupi0jRDvJAati7hqzvGtxk/yK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRpDzjmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC138C4CECD;
	Wed, 25 Sep 2024 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264266;
	bh=43PNlekTPh48k01lhekEHPyaIH3a8W2Fp1duzv17bG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRpDzjmMNLPC1GtIFKm9TvbfYGTs2MOYkdV2MHzOXtq9FBYygUFdavVES0uSCN4UK
	 5Xj0cUmOJJdGEeoD69mDDRPm4s9qfC12pF37qh7wxmp1z7E76KGRqBTQLNQsQ+eohV
	 LA9YEdrIfNeC7Fq4eyWScxHs906DVdRZMMd2us1Mua9HSvXZ8mLRVXAlugK4D7VgWt
	 p3ojd75+nuJIDn0ovWmox077k/7vyulzle1li/gRLfep5yijYkqusY2pN4brndqnr7
	 v5rwT69Uv0daEgNGtjuO4DsuvwNf9LttqCSt8z5S/Ktc/dkHYUCo9mANQiA80XP8C5
	 IMrre/KIKpGwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	al0uette@outlook.com,
	vderp@icloud.com,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 029/244] ACPI: CPPC: Add support for setting EPP register in FFH
Date: Wed, 25 Sep 2024 07:24:10 -0400
Message-ID: <20240925113641.1297102-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit aaf21ac93909e08a12931173336bdb52ac8499f1 ]

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
Link: https://patch.msgid.link/20240910031524.106387-1-superm1@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index dd3d3082c8c76..3b5b695bb80b1 100644
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


