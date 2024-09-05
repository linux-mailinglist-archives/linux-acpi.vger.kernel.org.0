Return-Path: <linux-acpi+bounces-8177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B996DFB0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E966528538E
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36BC1A08D7;
	Thu,  5 Sep 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiKBvbsH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF41A08B8;
	Thu,  5 Sep 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553819; cv=none; b=IdndIHY89/cUzm0vKTHFjJ/jJsorS4vdauhwoG1vPu1UfDLvV3qdhrEXEK09Bo5VZMykrxGBQFP9s2n/VWl1M40XHK/XXFdplaXJsqhV3OY730RgbaWend2dDwun8jfPXPHVC1znRMbIJ3wM4SX69eUb4fJxTBfW9yG7PSNu2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553819; c=relaxed/simple;
	bh=ZAeOThCVIA/Hdzu0NXAoIn+TTinxpUo0rpgK3LbmGIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOhctowY2sH6CS2MVExpC8zsxA4gn+VMDX1WZ9F1xShDoHNzuXlLOlyjw5cR9Vu7J9HYW+shmNIAjMNxabXHoEeRf8e4pf1HZF3529eP9ei2zt6MAaqv8I0fQJI7dFrnQPHPAYoA64Q/NiD/R2q6u8TXIwkmD0d5FDnAkGE/quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiKBvbsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CCBC4CECA;
	Thu,  5 Sep 2024 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553819;
	bh=ZAeOThCVIA/Hdzu0NXAoIn+TTinxpUo0rpgK3LbmGIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiKBvbsHvPtuPoqorYewNsdu9tW97uv9mpiJBViIE+5LELearMNhjMRhGHLWF7ZNH
	 vleUPwo2AeGNfiG/RImGl8ECC7w30pINS/dkcD9I/S3gICk6pU7ohrYnMqv4IihviH
	 HiLOGD+XXhcmndeBRtzh7mhmdBKTJ9qL7sa8dOJiW9ZXoIlmQrdlPR/UFa55f8naxJ
	 FmkHfAakiYN3ILZdr+7GFR9R+GHPlcYdhPX0GqX481MnmOXntqa7Db2yDfuyMMVxId
	 M07O2GSEp5Kaw0EVIi4x2MO6YJP+8dngMmJQwSxgxslCQPTz+8YJpItZO0PFeQS7GI
	 Hd1ozyupkLJZQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 02/11] ACPI: CPPC: Adjust return code for inline functions in !CONFIG_ACPI_CPPC_LIB
Date: Thu,  5 Sep 2024 11:29:58 -0500
Message-ID: <20240905163007.1350840-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
References: <20240905163007.1350840-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Checkpath emits the following warning:
```
WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
```

Adjust the code accordingly.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tag
---
 include/acpi/cppc_acpi.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4d..409a7190a4a86 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -162,31 +162,31 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_set_enable(int cpu, bool enable)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline bool cppc_perf_ctrs_in_pcc(void)
 {
@@ -210,27 +210,27 @@ static inline bool cpc_ffh_supported(void)
 }
 static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 #endif /* !CONFIG_ACPI_CPPC_LIB */
 
-- 
2.43.0


