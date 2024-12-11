Return-Path: <linux-acpi+bounces-10107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0769ED53F
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 19:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB71889F27
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E422446AB;
	Wed, 11 Dec 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqWAQq30"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF32446A4;
	Wed, 11 Dec 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943104; cv=none; b=hF3Gh3cynYOdJcRibvzLDqtuf0R4oPhDldChUBFqu2x5nl8NFua6MQ1mR7ndDJdazKN0D24q23Lc6df+miCbqNmADtHuJoeMerv9HFDjqQ11uXI+NCLr5Yyt6KE1IocWQvYdpjSVmMmN+htfUVa4eJoRfmSn+tG4isUd/8iyvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943104; c=relaxed/simple;
	bh=Q8NU/o+9jYTC9l0pFFRpT4IbDpPxD0RNgZFIK8z6V8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN/U3mduLkE9g5liCYCOp2lYPDeq22Q0bHI9uuZhNHC/452yuAtRdLVIYQ9+SV20nmhMRZDv4n5lrgr+HZT/T0fQMyBs0WoIUH5mA/iGbAM9XVsl/5i5sP8Ctgg1y3tj9p6kOEea6XB97zUzwVb0CmkBPVCEf8kWZYmHRaR4RC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqWAQq30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B54C4CED2;
	Wed, 11 Dec 2024 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943104;
	bh=Q8NU/o+9jYTC9l0pFFRpT4IbDpPxD0RNgZFIK8z6V8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqWAQq30T4UVCiDAWf7YvHrQJ9frLO9a1Fg87J/j1D8k6KH+CXAF6wn05RkBhRcMY
	 jDXmFAHaYm7IaKvCkZN6/zf4kB+ZHiy/QTYLyvrbdD4bWleTanXz3KSWOPbtQkP3cG
	 Vo0yb8rps2+f3hzpw/AxHH0Cim2TlW5XUukTxyQLrEz3hKSmBzlKn7M7NeKi1PG8Xv
	 SlrDSG6Wfc8zkhi0JbcuIaUhpZwBwXVuBT+G6A/3u22l+dGqQvRmihTARpXpLB+9Ux
	 0HmXE0conMktH1IWPaD9nisuYWmi8ANJ65TdAl+eYNcSa3B53nRCP4BMQ1T0+MbEVN
	 casIJpH8VjLgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qinxin Xia <xiaqinxin@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	corbet@lwn.net,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 30/36] ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A
Date: Wed, 11 Dec 2024 13:49:46 -0500
Message-ID: <20241211185028.3841047-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Qinxin Xia <xiaqinxin@huawei.com>

[ Upstream commit c2b46ae022704a2d845e59461fa24431ad627022 ]

HiSilicon HIP09A platforms using the same SMMU PMCG with HIP09
and thus suffers the same erratum. List them in the PMCG platform
information list without introducing a new SMMU PMCG Model.

Update the silicon-errata.rst as well.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
Link: https://lore.kernel.org/r/20241205013331.1484017-1-xiaqinxin@huawei.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arch/arm64/silicon-errata.rst | 5 +++--
 drivers/acpi/arm64/iort.c                   | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 65bfab1b18614..a678ea0ae4a00 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -255,8 +255,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
-|                | ,11} SMMU PMCG  |                 |                             |
+| Hisilicon      | Hip{08,09,09A,10| #162001900      | N/A                         |
+|                | ,10C,11}        |                 |                             |
+|                | SMMU PMCG       |                 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4c745a26226b2..bf3be532e0895 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1703,6 +1703,8 @@ static struct acpi_platform_list pmcg_plat_info[] __initdata = {
 	/* HiSilicon Hip09 Platform */
 	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
 	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
+	{"HISI  ", "HIP09A  ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
 	/* HiSilicon Hip10/11 Platform uses the same SMMU IP with Hip09 */
 	{"HISI  ", "HIP10   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
 	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
-- 
2.43.0


