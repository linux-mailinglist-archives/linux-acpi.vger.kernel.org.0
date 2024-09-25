Return-Path: <linux-acpi+bounces-8404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B2985C61
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F625285DA6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0931CF28B;
	Wed, 25 Sep 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QroHBHyd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9401CF290;
	Wed, 25 Sep 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265567; cv=none; b=Jjv6WPs/sei01TGSha1N9tDbF2yFXB6Wu8vnKmjGMtRkE/f+fyNRzspa2e8s4Yol6rC0OAca2TVbEjowputGFwGvvUfpXr4fRy6oEz/AQGfQ6Z3ckTdx8UGCLZabuwQ32BHS3qLwhapUOVTNvd6+V/mtz/1leh8oCRGPxrLPq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265567; c=relaxed/simple;
	bh=cgxjf/T3Uz5zYcbLbGV/F5uz193bvyCtHKYdSRGRkzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC4ND9tJizmNuoJUhMsaSatZ5RoqgXY7WcA0BM1yBaBtpxWa8hb9LLIr+SW/U4pvTc6S4OQGt36gXZZS863z7M1wpZfLc6tgxQc8chC0GuNMTuGFfaTtaljcIwvnBAOETLj+rmAa/kDLQ0AKVNwO5mBJJN3iHZubwV1cJWfKK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QroHBHyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F2C4CEC3;
	Wed, 25 Sep 2024 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265567;
	bh=cgxjf/T3Uz5zYcbLbGV/F5uz193bvyCtHKYdSRGRkzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QroHBHyd0t89q/IIEFfeqTK8kcZ35vd22PWCvEgj5opgwbfSsOKfyfnsW5TLAWOtQ
	 2QsOfZSuOSEN0MYAFoikhalwbyxRi1PWAR3qMGQNGoCkb9GwSWPIpcel88dmG2kx7Y
	 Snh9R+jPUuMj5rZukq6XLhaItP+xy8sgMdx+I4qQICQrKOj/DMg8T7wwdkHXcxtOZy
	 TUEvUXOifqtDt4GxGMuo2Cfxj6u3sgm5h4j4hdHyOGEtnuJztsIdvr+NG2Jp1pzmL6
	 OkadDX3eXVSscvZ5QTfh+mhf9KoR+/a90spoQkVlW7dAWTL309so/N01lncqGiUDAP
	 TP04S+I0V8WBQ==
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
Subject: [PATCH AUTOSEL 6.10 026/197] ACPI: CPPC: Add support for setting EPP register in FFH
Date: Wed, 25 Sep 2024 07:50:45 -0400
Message-ID: <20240925115823.1303019-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 1d857978f5f40..9777369084d80 100644
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
@@ -1484,9 +1489,12 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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


