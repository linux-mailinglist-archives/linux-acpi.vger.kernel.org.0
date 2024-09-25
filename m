Return-Path: <linux-acpi+bounces-8412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86996985EA9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B860D1C25504
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D32141DF;
	Wed, 25 Sep 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4xdqz8T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244D2141D6;
	Wed, 25 Sep 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266353; cv=none; b=reeJgpKM+q0z+GM8iTONKC14sIGyzc3SW9+2FMgaM3QqTYWrfD0dj1i3DuyQQjOkTjAHU31G7hs7u0ynQFEU2yWCtEqQ6TDdayY+pNHgWK/GxT6zoAd+tnmyhpyzuHTn/7IOPImpFZuj+O5UWPgCc7rkiaUgbPFLpCqOVjboPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266353; c=relaxed/simple;
	bh=ucPwAgw8KvVBNrW6Xo2FelKHWD3f1Zj/DLVASpGK6o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzU8zFheZxPbHJ6KXvsG7aM4cAS06mbKY6Krgu0r5t6WIUXZ9uvaJAT0Be25bPof5OUuH+SpvwDu01x34qiRrzhUlbKFCLLs0ofQhCjEljj7+07prVBKnnxjX2h0bQcYD5cvNClvaUvkfzuRkfh+MMlqFMu2p4Rf4G5Y2D8MzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4xdqz8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D91C4CEC3;
	Wed, 25 Sep 2024 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266353;
	bh=ucPwAgw8KvVBNrW6Xo2FelKHWD3f1Zj/DLVASpGK6o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4xdqz8TW/4iX80qT1abUEOxOqc1Pezh1HLudzTCfkVtn3NIrkxkB4Tj8TWdsa5Z5
	 0IblZb7PhSfsKbi+mdq6U4Tk0VyAuuEwkRRLiPmvGlf79/gqlTgSOCaDOEAFivOS/V
	 RdXTHHPqvO3asKCa4lnw8fmO3hOHNzJ7xS4jhRFbU86NKwBGRYXJV+0Lefm//VXfyF
	 ypFcSf3hgeuuz6YHQCcNg/hFspXr9FkmD+U7Wq5zywA/eeAonxKQfh+0+SFY19P2hu
	 i6dbV98QJk1/mp/rnPTrnES4ysxY2zJwHVv6n+AX/IByjgqcZDNE+OZQogOudkhUgs
	 4KZy28W9VEnPg==
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
Subject: [PATCH AUTOSEL 6.6 024/139] ACPI: CPPC: Add support for setting EPP register in FFH
Date: Wed, 25 Sep 2024 08:07:24 -0400
Message-ID: <20240925121137.1307574-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index d6934ba7a3154..c00f9fa2c0b99 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -100,6 +100,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
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
@@ -1479,9 +1484,12 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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


