Return-Path: <linux-acpi+bounces-8941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926299AD997
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 04:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1AEB2211E
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35A175A6;
	Thu, 24 Oct 2024 02:16:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB393D69;
	Thu, 24 Oct 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736176; cv=none; b=O27Og3xt9VxC39zhKVgTQFprpuq42d1Jz9rxA5uYmv0HMFkJsrJzxBFIowT2GvS8J9kGxRLJ8Q9zhQwjapOlPH+9K5dNtrz74re77LsvI/rcCvsoBeuYkpf38Pit82WA6orBQHW7/lGwEGbSrHnhodUPiGbcw9EfU+MEfKUWu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736176; c=relaxed/simple;
	bh=p+G2AcOoCkBvlUjYy6aT15l0q4IcI/xUhywccyK9ZxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQelx2uie3UU8+qJ9j2NMZyNn9Og65m8IxNSVKpcV5eOWWaOYocWuCqRawJPyhgHKDgtczNhx0SmjHxccCl3TO/7Xp1LqG7i8Kl4bRndQCygblcW1jqXShOOEEBfHi/8gpxzyZaJQaYkviX6V2uJgED7VBuOktJkYB+NkCG8dX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYqHV1W53z1jvqb;
	Thu, 24 Oct 2024 10:14:46 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 06D401A0188;
	Thu, 24 Oct 2024 10:16:10 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemj200003.china.huawei.com
 (7.202.194.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 10:16:09 +0800
From: liwei <liwei728@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <viresh.kumar@linaro.org>,
	<Pierre.Gondois@arm.com>, <vincent.guittot@linaro.org>, <mingo@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bobo.shaobowang@huawei.com>, <liwei728@huawei.com>
Subject: [PATCH v3] cpufreq/cppc: fix perf_to_khz/khz_to_perf conversion exception
Date: Thu, 24 Oct 2024 10:29:52 +0800
Message-ID: <20241024022952.2627694-1-liwei728@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemj200003.china.huawei.com (7.202.194.15)

When the nominal_freq recorded by the kernel is equal to the lowest_freq,
and the frequency adjustment operation is triggered externally, there is
a logic error in cppc_perf_to_khz()/cppc_khz_to_perf(), resulting in perf
and khz conversion errors.

Fix this by adding the branch processing logic when nominal_freq is equal
to lowest_freq.

Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
Signed-off-by: liwei <liwei728@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
v2:
    - Fix similar issue in cppc_khz_to_perf()
---
v3:
    - Add acked-by tag
---
 drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b73b3aa92f3f..c3fc2c05d868 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1916,9 +1916,15 @@ unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
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
@@ -1939,11 +1945,17 @@ unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq)
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


