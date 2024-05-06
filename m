Return-Path: <linux-acpi+bounces-5630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24038BC8FA
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EACE1C213B5
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5201420D0;
	Mon,  6 May 2024 07:59:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B141140E23;
	Mon,  6 May 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982384; cv=none; b=airYsZZMiYy60v02OyaA7FZAYtTbqqeznnBwS1VxgFekyaFFIl90/+LxAMU7k2OE+C+wDBCbsyZP2e9McG+Op7zUG6b0p/rFbJYXQ3dDv+Y83X+u4PYO6gKl3JV5VyIqdLjauGPpBBl9R5EfBg38b0v9TdVFiAvBa+ZKTsOq48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982384; c=relaxed/simple;
	bh=mrMc4UwV2GXg/vdxlNdq7LIgtP98hWJIuB7PNLcVgqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l6DI4Wtpb8a1U6L279TqQx2R7ojBdko233953HtxboC7qenhgrxUGrEfs0Cx/NdSMgCrZhsjVbd0tplErDKg700bh/KCCrSoB41kVQFYXgd13Xx+nHFBgh3e5P4ySY2Z9cvG1ncEka0hLdbwVc2wjkGOQfQJ6IlMAIudqaBK7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VXtzB4FXSzNw35;
	Mon,  6 May 2024 15:56:54 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id 06A7118007C;
	Mon,  6 May 2024 15:59:39 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 15:59:38 +0800
From: liwei <liwei728@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <Pierre.Gondois@arm.com>,
	<viresh.kumar@linaro.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>, <liwei728@huawei.com>
Subject: [PATCH v2] cpufreq/cppc: fix perf_to_khz/khz_to_perf conversion exception
Date: Mon, 6 May 2024 15:58:16 +0800
Message-ID: <20240506075816.1325303-1-liwei728@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500018.china.huawei.com (7.185.36.111)

When the nominal_freq recorded by the kernel is equal to the lowest_freq,
and the frequency adjustment operation is triggered externally, there is
a logic error in cppc_perf_to_khz()/cppc_khz_to_perf(), resulting in perf
and khz conversion errors.

Fix this by adding the branch processing logic when nominal_freq is equal
to lowest_freq.

Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
Signed-off-by: liwei <liwei728@huawei.com>
---
v2:
    - Fix similar issue in cppc_khz_to_perf()

 drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a40b6f3946ef..e3a0d6b46b24 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1869,9 +1869,15 @@ unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
 	u64 mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_freq - caps->lowest_freq;
+		/* Avoid special case when nominal_freq is equal to lowest_freq */
+		if (caps->lowest_freq == caps->nominal_freq) {
+			mul = caps->nominal_freq;
+			div = caps->nominal_perf;
+		} else {
+			mul = caps->nominal_freq - caps->lowest_freq;
+			div = caps->nominal_perf - caps->lowest_perf;
+		}
 		mul *= KHZ_PER_MHZ;
-		div = caps->nominal_perf - caps->lowest_perf;
 		offset = caps->nominal_freq * KHZ_PER_MHZ -
 			 div64_u64(caps->nominal_perf * mul, div);
 	} else {
@@ -1892,11 +1898,17 @@ unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq)
 {
 	s64 retval, offset = 0;
 	static u64 max_khz;
-	u64  mul, div;
+	u64 mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_perf - caps->lowest_perf;
-		div = caps->nominal_freq - caps->lowest_freq;
+		/* Avoid special case when nominal_freq is equal to lowest_freq */
+		if (caps->lowest_freq == caps->nominal_freq) {
+			mul = caps->nominal_perf;
+			div = caps->nominal_freq;
+		} else {
+			mul = caps->nominal_perf - caps->lowest_perf;
+			div = caps->nominal_freq - caps->lowest_freq;
+		}
 		/*
 		 * We don't need to convert to kHz for computing offset and can
 		 * directly use nominal_freq and lowest_freq as the div64_u64
-- 
2.25.1


