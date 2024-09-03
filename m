Return-Path: <linux-acpi+bounces-8112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB8E96A86F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79567B221DA
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3D1D58A6;
	Tue,  3 Sep 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccdCYhaz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FD1D589E;
	Tue,  3 Sep 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395829; cv=none; b=d3DKuNifDiPC2JQOP9aN//YtcgwYvkgPqMozQYBtmMOT7F9MLJsE0HXh9hVqJcBTAyHf99oI21EE3vaUsrpuh395eLfrLk3Xpv9uPtwYAa16ySHecLMjV33HcEdpxWsXweRiH5lRH4MDBmQGMX6pJRnDzEBAIS3gRSylpO//aOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395829; c=relaxed/simple;
	bh=Mi1XSn3QoyV1uL2WVnu3MhCF+ygtF1cHWIq1Uh3dUTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO2gm9lnQcP2DgnM08S94TwVY2T/WQUikpujpNIQBREaddliisa5Dg1HXPjov9QotJJvJgVbHeyzd53iK67zvtKrAzo6Ku7yEeyI0erNBLLqJK17182Impme2oloBnDOkoP8XpgVsLaT5dNQ2OH+RG7YbeREbS/WSgyF91eYNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccdCYhaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9426AC4CEC4;
	Tue,  3 Sep 2024 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395829;
	bh=Mi1XSn3QoyV1uL2WVnu3MhCF+ygtF1cHWIq1Uh3dUTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccdCYhazE0Qws6hOVIwICtk+5zOZoMoL1F1kGV0dg01m0F49IXDQGmAwtt5FE4pRp
	 VCJdFZZL8ivV7L48TFdKHThEPIR0ZfzF6zN88mZB0m5H8iLWDDmATQSdwAprOPn6IG
	 McITN4pGXFQikkIqz8Kn6ubSdEKASa0vuFuP/qeRh1BwqAP53Cq8L1c8BdcTaa7lhq
	 didkmuvLUmY/fUk5oIx/ZlrfYOXLNY+0n6n268CElsrsY2G2YzB+kmtTz5DCxEJ2Th
	 Zo+3DIYdMbK0DuqQWGN7e9V+BckMLN1q5U2wBbkxBekEkRaxQCYk+N6e+h5wpynXT7
	 LE/yRiTxmlX6w==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 02/11] ACPI: CPPC: Adjust return code for inline functions in !CONFIG_ACPI_CPPC_LIB
Date: Tue,  3 Sep 2024 15:36:52 -0500
Message-ID: <20240903203701.2695040-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903203701.2695040-1-superm1@kernel.org>
References: <20240903203701.2695040-1-superm1@kernel.org>
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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


