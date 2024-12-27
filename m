Return-Path: <linux-acpi+bounces-10312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6869FD2A3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBA31625B4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7E5156676;
	Fri, 27 Dec 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IqRysj5I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF114B95A;
	Fri, 27 Dec 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735293275; cv=none; b=VPwPptXETcqD4Lr/EaHVupB/kQWdlfSOxNjWnu0NlkCkNbOpIzKKBMzsHWhW0F7vDpEZMwG16+YJjohkQMRzgcU4FbeOE0j1VswHs3g8H0//zdPlmsgRowIc2yPzEUexjJAHhuPALtS3e77HvSKMlwjtarc8mR4SYZ4FwGmpnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735293275; c=relaxed/simple;
	bh=+BuDGxE35QLYjzJzpm3l/mexwmlnX4WJryj840LV4Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jriyz9lUmvC2SvDw5dsZM9gGguyQMfxVAQHX/mMXvVH1F9wlxpi3KjO359H0udAbUE8r5VZys+mAvtVsMxwD/it9Fmc3T4LhEUm6uHWYgIi+GZc/z7S4znNaKZ4zKv3Yr6gDMEf+vYxm2S5zQOfxf8QN8LeZlNKow0iBhKycgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IqRysj5I; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735293264; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IcVxa8jX6N9CqPRS4pyMvj9wYh0OlHb85qBwCltl7JQ=;
	b=IqRysj5Il9DzPdcTCRVMJZ3GtVpGmty5vVVbxCD/qO6wV1nrmPT6xWVdKybEEM+i2bfKUiphhOUaR5k46Eca2DSNHnuBUfHyHOmdbCTHnCeTw4bXBJiABwLEYi0iiQZcjBfpTRSlT2M5LfnlXhakZ8jWiNEvvfJYU4acLMUubWo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WMKtN23_1735293262 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Dec 2024 17:54:23 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: rafael@kernel.org,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	ying.huang@linux.alibaba.com,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a parameter
Date: Fri, 27 Dec 2024 17:54:22 +0800
Message-Id: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a problem report that when debugging a hard-to-reproduce panic
issue, user wanted the kernel to not reboot by adding "panic=0" in
kernel cmdline, so that the panic context could be kept, say the panic
was caught randomly in the mid-night, and user hoped to check it in
the morning. GHES panic handler may overwrite that user setting and
force to reboot after 'ghes_panic_timeout'(30) seconds.

Make 'ghes_panic_timeout' a parameter can provide user some flexibility
to change the timeout on demand, without changing current behavior.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07789f0b59bc..a8a6310e476a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -174,6 +174,7 @@ static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_
 static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
+module_param(ghes_panic_timeout, int, 0644);
 
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
-- 
2.39.5 (Apple Git-154)


