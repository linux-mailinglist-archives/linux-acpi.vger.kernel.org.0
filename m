Return-Path: <linux-acpi+bounces-19408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BBC9F097
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 14:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FA03A298C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AB1F63D9;
	Wed,  3 Dec 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rIH0LCwZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2111400C;
	Wed,  3 Dec 2025 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766983; cv=none; b=J14UYorBCHVjkRWhXaFqA1IzAORu2+tKt8TNb1KHVY5DM8JwwV3ROL1uDL0BW2PWf/zGDGmVu/Wodig3AvXSctcVaBq+xWgAhC8NVx6SVN1ASaiLy1Iz47I7mpY8T+kkjuxYoIwkYxXz6xktgJ3VpliZbLRYyXamQk6auVF8rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766983; c=relaxed/simple;
	bh=UKaes7Gd62XbeP82oCrikL91ZCs5NjZdLlUwPsOKgmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aq9gzX2CCjXMXnxctnsI3MSsAvdDA1ZDb+FUNyP5ykduMRMNjCdmIBYzh5pstw1b7pqMp4J9sGy/2HIiIwD5xPd8VTPNeLreZWIpAaAUn6Yzs7Y368HtpojbZ3ybbkEbXRlRAXbAbKvsCv3ZBPrImWcy0LpG3QC7ytftyOG+1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rIH0LCwZ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764766976; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GF2DnHV2Nfqks8pZ+IbPiWJuqqoJ7GMOxB8iNu2ZvSk=;
	b=rIH0LCwZ7vZc6eI3ppRFPG7RJp/BMKihA29OkkBxLkrpeNRGv9CRcWFjX6ewJ5RNAjOidiBr7ZdY1dau2ptDcgP7u03VWIy1gvUO0lrSLI2yhY8gKiRa/Zqae5fHtUs/F4NLqSaD45GRW4IkXXNrucZDiKMgU776um96DkOHewM=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wu.aDtF_1764766974 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Dec 2025 21:02:55 +0800
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
Subject: [PATCH 0/3] ACPI: APEI: GHES: Performance improvements for error notification handlers
Date: Wed,  3 Dec 2025 21:02:50 +0800
Message-Id: <20251203130253.73888-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


