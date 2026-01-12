Return-Path: <linux-acpi+bounces-20164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4179D10759
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 04:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1ED3032101
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 03:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E7530BBB0;
	Mon, 12 Jan 2026 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eoyjeByx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A630B533;
	Mon, 12 Jan 2026 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188190; cv=none; b=Q751sTOdPZkkL8zg9txaaNTYys7hMk3YM02k/X9Apeb6nGxglIIjy6tL4mry4XIqKU4CYuR69LajrgHdQl5ZRC2ZWAamq9j35nbZxGix9HnSESj81JrpDKh9efuJTowY4LXvSQSVaRAYDwfKuHIuUCB1JCMuYUHa9yFVcvVkPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188190; c=relaxed/simple;
	bh=plRpsNWTo9A+H2k5qw6JdE0E1N2nBwjsVQD6EszROJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsH1EBDWpGoULcEUjfuTsTyWQPFPQ4guwwteaPjQxg1b2jHx9xA4cpElMGuNEbKmEfkKfslRF9kzflVB+CSzgmEUJeK0AO3LmpzQDwxH1SHnLMFA8QXSE3MO9Ztll9jj69FDV77ZhEFhMy708UrIiurCoBTPAN5TgOHgZbKEnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eoyjeByx; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768188180; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9JmuHLzsQWEipLbvxlenF82WTk6hUkcotvlLaNFMMow=;
	b=eoyjeByxYPbgO1nu2wUefKdK5fPmuEFEjvpSt97vzeGhhibX9SbyOSU9SXu4wdrFEBIN3VXE4cq13DQD/BJapRFIHRS65NsjEEHSiQCX5GQXX/Eo8HQosW1vFKK6gZMdCA7hVqOZ/RI/bcTVfT1cZtIZygktjyBTvNbh6kT7CGo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwntFxH_1768188163 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:22:59 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	dolinux.peng@gmail.com,
	yazen.ghannam@amd.com,
	rafael@kernel.org
Cc: dave.jiang@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	leitao@debian.org,
	pengdonglin@xiaomi.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	james.morse@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v3 0/3] ACPI: APEI: GHES: Performance improvements for error notification handlers
Date: Mon, 12 Jan 2026 11:22:36 +0800
Message-Id: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v2:
- Use `guard(rcu)()` instead of explicit `rcu_read_lock()`/`rcu_read_unlock()` per Donglin Peng

changes since v1:
- add Tested-by and Reviewed-by tags from Tony
- change return value from AE_BAD_ADDRESS to -EINVAL ghes_map_error_status per Hanjun
- remove unnecessary blank lines per Hanjun

This patch series improves the performance of GHES error notification handlers
(NMI and SEA) by optimizing how they check for active error conditions.

Currently, both ghes_notify_nmi() and ghes_notify_sea() perform expensive
operations on each invocation to determine if there are actual error records
to process. This includes mapping/unmapping physical addresses and accessing
hardware registers, which causes significant overhead especially on systems
with many cores.

The optimizations introduced in this series:
1. Pre-map error status registers during initialization
2. Directly check for active errors using mapped virtual addresses
3. Extract common functionality into reusable helper functions
4. Apply the same optimization to both NMI and SEA handlers

These changes significantly reduce the overhead of error checking:
- NMI handler: From ~15,000 TSC cycles to ~900 cycles
- SEA handler: From 8,138.3 ns to a much faster check

The initial idea for this optimization came from Tony Luck [1], who identified
and implemented the approach for the NMI handler. This series extends the
same concept to the SEA handler and refactors common code into shared helpers.

Patch 1 (Tony Luck): Improves ghes_notify_nmi() status check by pre-mapping
                     error status registers and avoiding repeated mappings.

Patch 2 (Shuai Xue): Extracts common helper functions for error status handling
                     to eliminate code duplication.

Patch 3 (Shuai Xue): Applies the same optimization to ghes_notify_sea() to improve
                     ARMv8 system performance.

https://lore.kernel.org/lkml/20251103230547.8715-1-tony.luck@intel.com/

Shuai Xue (2):
  ACPI: APEI: GHES: Extract helper functions for error status handling
  ACPI: APEI: GHES: Improve ghes_notify_sea() status check

Tony Luck (1):
  ACPI: APEI: GHES: Improve ghes_notify_nmi() status check

 drivers/acpi/apei/ghes.c | 107 ++++++++++++++++++++++++++++++++++++---
 include/acpi/ghes.h      |   1 +
 2 files changed, 102 insertions(+), 6 deletions(-)

-- 
2.39.3


