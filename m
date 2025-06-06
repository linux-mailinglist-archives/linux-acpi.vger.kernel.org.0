Return-Path: <linux-acpi+bounces-14185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C93ACFD7C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 09:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D93175BE0
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81573283FF1;
	Fri,  6 Jun 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="cvmCZpHk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A2149C7B;
	Fri,  6 Jun 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194931; cv=pass; b=E/Q7Rydau3jxe548xfIEQSdrZjbqmbsc+fY22gycDt1K4+f4zQbV/KNTMqaPAGU/3QE06f0/mlq6ndm4ySiaDycFTtVrYpqkNBwjidRxiw+XQHzr7lM4aFlhJ5zMpWdVQDZDuicL4eYxlNJ7kGMXxbHi3OWtMfjY3a0wPNlr8Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194931; c=relaxed/simple;
	bh=JKnkwcSrgs5gO7wyzBEgKh6rE6FuB78ADu5/P8iCndg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fBH7hJHeC04MPLn9TIUAqWeugxP4WdSn2vDIv72b2MIy9gtTvFg0NVb7jNcg7Vyl5JGabkX1Y7hoxIS8//Vy6P3wMDzooKZ7Ft1dZtav/aLSwnKs1xgxgFcpYeOaQ/gU9RNNbqr4ysWcybURTRRYmKSv15GitoVz3NXER8jRWGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=cvmCZpHk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1749194895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nM12F+oVjbDuWMsFKHZ4wuPfqaGvmq7/U8QBvi5BKhJA/Nb1u8fKbgOWZ1FrqwHs0M3Uin4HWBXpokSf1DSz7hsUmgtW7+EB5DbAifepx8odD0dbBGizuXBKy9DOTYVeqFEh9gZeGjSYKpZ1Fcl+4Op1XY3RsdUKSQt/1ubXcqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749194895; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=tRy24lqfKv3gXyTkphs/dHJ5gyZkpcLuoO/gcsCQCXg=; 
	b=EpdUcsSPGETB/rsmVUkCK9JUfJmu3V2vvjQvx92FRZYRP2UlP1yDKqdf9sSujOiwp068IG/nSY7WrIj8k7pKN0J/8HwDLRplDpY3r/yo2bTS7cE0Y/gkZAav5+PBYxFJxdwWMziMqvLOpoCYXfo9JzF5K0BBPEkmp45JrXaP8VI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749194895;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=tRy24lqfKv3gXyTkphs/dHJ5gyZkpcLuoO/gcsCQCXg=;
	b=cvmCZpHk17i/hxDj0tUQgMU4P11hTY2SUJjRFsgCCLKjHL6PNKbeLBP+pUlG1Wkn
	TRLvc+xRErmccoC3jCA09lrIpATkKwqNR0f8Oyq9275XqM3Nndz0nz/wgf7JdRByQst
	nv1sENfqMHN6n9sihdcyb5sfwdgwgP9iSc7vzLf4=
Received: by mx.zohomail.com with SMTPS id 1749194893001866.070129665492;
	Fri, 6 Jun 2025 00:28:13 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] ACPI: Improve SPCR handling and messaging on SPCR-less systems
Date: Fri,  6 Jun 2025 15:27:43 +0800
Message-ID: <20250606072802.191580-1-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

This small series improves the kernel behavior and output when the ACPI SPCR
table is not present or not supported.

Currently, even on systems that completely lack an SPCR table, the kernel prints:
"Use ACPI SPCR as default console: Yes"

Or if with acpi=nospcr:
"Use ACPI SPCR as default console: No"

This may mislead users into thinking an SPCR table exists
when in fact there is no such table at all. This series addresses this in two steps:

Patch 1 ensures that acpi_parse_spcr() returns -ENODEV if CONFIG_ACPI_SPCR_TABLE is disabled.

Patch 2 updates arm64 acpi_boot_table_init() to only print the SPCR console message
if acpi_parse_spcr() succeeds.

This results in cleaner and more accurate boot logs on ARM64.

Tested on both SPCR-enabled and SPCR-less qemu-system arm64 virt platform. [1]

[1]: https://patchew.org/QEMU/20250528105404.457729-1-me@linux.beauty/

Li Chen (2):
  ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is
    disabled
  ACPI: Suppress misleading SPCR console message when SPCR table is
    absent

 arch/arm64/kernel/acpi.c | 9 ++++++---
 include/linux/acpi.h     | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.49.0


