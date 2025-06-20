Return-Path: <linux-acpi+bounces-14475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C44AE1BC9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BF73A74EE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010D289E25;
	Fri, 20 Jun 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="QGlDSicn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB9258A;
	Fri, 20 Jun 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425236; cv=pass; b=b/vVp2gJGS/YvHQCU0O+u/8oUeMh/hZLB/qA4RhDIje5A5xyFvTvSOaadq2B6j/mz7zEEfKZj8BBSfaMcIfywupeNwk4i8dMlpf+3S8jMayHnNfq4ohPJgPxCbRwSS0cXRBLVmqV2qTzsYVhskX/gbfz7RiiJ1wK+TIPhLIe9h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425236; c=relaxed/simple;
	bh=RPGrsUiY9GGnw/6tXbjccCX3DGhS40+0nbnucG8R+Kk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BAifpIQ9yAVwc25zVqat278x9kxdrC8icGSmetWsSsr6AwIjjABE9YzyyLSgmNtgHZDI7p0s/YAfsJKCf/kJC1T1MsGtCGApmwVJiyJdYcazpSjvfrOKMRQUL/gK8zfMy5HSE1rdOMr6AIIrIMHJjeeqjigZjBsyGp7zLRp6uu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=QGlDSicn; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1750425200; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ag6sm19tCZyRI1BO2CAVBqUY3xmXRXJa92+mdmoKr64FDpX00OTD2KOnRqm91jz7XjJ+rmjaL+312oJM0bPTvEpue8+nIPxQEMelWaVu40gxosO422ZaXGDei0X9ocNE3svu+X4vyLT0Y14mK/Bbiz/fmH44sXyP/I0EYqdp5Xs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750425200; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Ydvxy1sRh0XdyUY78UINI/d5MUqA5T2bAotDmBZAf6w=; 
	b=ljK02p0OoIZuydQAGJsoVnGKSlUXXg0QKS3ddUTcdkWCokCBMfCVFlA8AmvhSxtWRpqTy5u3kUM2kdyV5j7ShRCSJqyop3xwf4xrWHRXIbzD+JHPnGpdIOwDBgw8jLAdf89++/DAnV4sAPjPSSMljYph4ZwZlDPSTaJCL2c9LfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750425200;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Ydvxy1sRh0XdyUY78UINI/d5MUqA5T2bAotDmBZAf6w=;
	b=QGlDSicnOv6qys1rQpkrOFbO9r5rCtI2Rg8ZI7nc19PanS3DdqWsz8p4fZOUwbeN
	EuQ/YhXGI5NXYINn7s+oEqtYJfFEyOcA+OCJ531usFR9aiVgMIc11iX987MPm7uWZ7d
	FOLJ/9kSeo7gw9QX3u4nV2Qo53E9Hlje4Ll985jg=
Received: by mx.zohomail.com with SMTPS id 175042519577329.422760089999883;
	Fri, 20 Jun 2025 06:13:15 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] ACPI: Improve SPCR handling and messaging on SPCR-less systems
Date: Fri, 20 Jun 2025 21:13:06 +0800
Message-ID: <20250620131309.126555-1-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

This small series improves the kernel behavior and output when the ACPI SPCR
table is not present or not supported.

Currently, even on systems that completely lack an SPCR table, the kernel prints:
"Use ACPI SPCR as default console: Yes"

This may mislead users into thinking an SPCR table exists
when in fact there is no such table at all. This series addresses this in two steps:

Patch 1 ensures that acpi_parse_spcr() returns -ENODEV if CONFIG_ACPI_SPCR_TABLE is disabled.

Patch 2 updates arm64 acpi_boot_table_init() to only print the Yes
if acpi_parse_spcr() succeeds.

This results in cleaner and more accurate boot logs on ARM64.

Tested on both SPCR-enabled and SPCR-less qemu-system arm64 virt platform. [1]

Changelog:
v2: refine the printk message logic as suggested by Hanjun Guo. [2]

[1]: https://patchew.org/QEMU/20250528105404.457729-1-me@linux.beauty/
[2]: https://www.spinics.net/lists/kernel/msg5730585.html

Li Chen (2):
  ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is
    disabled
  ACPI: Suppress misleading SPCR console message when SPCR table is
    absent

 arch/arm64/kernel/acpi.c | 10 +++++++---
 include/linux/acpi.h     |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.49.0


