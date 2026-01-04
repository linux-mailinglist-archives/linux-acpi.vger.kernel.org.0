Return-Path: <linux-acpi+bounces-19940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A75CF0E00
	for <lists+linux-acpi@lfdr.de>; Sun, 04 Jan 2026 13:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5453009ABB
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Jan 2026 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0928CF66;
	Sun,  4 Jan 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fYpT1OtX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1752580FB;
	Sun,  4 Jan 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767528254; cv=none; b=s+1xYh2qPiP0/tn/q6YohwleFHYL7wQyqpCCgWhv/wiqcYbbVF1H+x9LvFe7zyjqLY0u7pUB+tO/rlaATPOee1p4tAWoSiMQwGBuqNuy/uiTEw89u0iofLDgnUSE0m8F+QLUuHI0DpizqDkJc78vLNtE6DSygwYFG5E8xRrApUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767528254; c=relaxed/simple;
	bh=3q+bpYdFAJRWWsqEA79qyjG0X/sZfHRbBbD1w+3hvpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Twzg2TkSzyburriuqtCRwVD1cCbHqjFBkP0WdcKEGmweLqtriAWh4uWnUz2PRSb5M5IcT9ATQJmqJXIHCid/AtgY8mCieQ1SH0lEDWwxwv4+jy1cQXVKLfcv2WoKpuf0K5NJlIwM8p4S/2fDHRfTI8SukL80m61efCV0II3wpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fYpT1OtX; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767528248; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mjJn91a3UZpUeV1X7S0RFkCZaZYFn5ohkv28FYV6OIQ=;
	b=fYpT1OtXw0nUYKY63RzgQDyul3Z2Nft4ekXS/jo/NeShzwM53Wx9FtPsIUJ0wHkOPeSB1no2h4VNCTGMacR8UqSWloBrtPjIDbY6iGOhrOwRjWmPzHrpLKKhbHMWeC2BwJSwMWElV5XaCLoHHdYHvyP4FD9d4ZXW4VUROeyG9sw=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwEgE0C_1767528246 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 20:04:07 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	yazen.ghannam@amd.com
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
	rafael@kernel.org,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v2 0/3] ACPI: APEI: GHES: Performance improvements for error notification handlers
Date: Sun,  4 Jan 2026 20:04:02 +0800
Message-Id: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/acpi/apei/ghes.c | 111 ++++++++++++++++++++++++++++++++++++---
 include/acpi/ghes.h      |   1 +
 2 files changed, 106 insertions(+), 6 deletions(-)

-- 
2.39.3


