Return-Path: <linux-acpi+bounces-7443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAA94BE3B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1352D283FF8
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C9188012;
	Thu,  8 Aug 2024 13:10:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD401E511
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122608; cv=none; b=pdxtn0AK/RssHGufbssJNX7oCPWg9FBzrJmw+kMHYeuutq/lxqJbERTTZLs+TPHmOfLX9EkWoeNe3KSMVCZnsC+F8mvLeWu1qE6ATc/Qjnm0e0WMCaD4I+fIvhzBcQET+X7gMxmqafFiHyQs5fw5sCguOJIXq6TLgBrGXtNVWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122608; c=relaxed/simple;
	bh=cTSl+Uv9QjHQ3ackfz0FuChKFO+Dhw5pG+4kQqMU90Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VH9yGJQniJu8lqtItdPO9W//ozto3u6wM3xCo1dkpUezSIp/6agOCyv9gYjW5BQGzIrgjdGUfZnl0De9h1HSvqsUexqu0zVf74AOI1K1Vdi8EnfV2uz24+E1QljOPcqxamGEto+tGjpUX8plZ0dgQGVdV3erRopfwbZJLc3ESBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WfnMc43Zmz1S7Mb;
	Thu,  8 Aug 2024 21:05:16 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D9A0180018;
	Thu,  8 Aug 2024 21:10:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 21:10:00 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: ARM64: add acpi_iort.h to MAINTAINERS
Date: Thu, 8 Aug 2024 21:09:46 +0800
Message-ID: <20240808130946.1028376-1-guohanjun@huawei.com>
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
 dggpemf500002.china.huawei.com (7.185.36.57)

IORT(Input Output Remapping Table) represents the I/O topology of an
Arm-based system for use with the ACPI, so acpi_iort.h is for arm64
only.

This helps git-send-email to figure out the proper maintainers when
touching the file.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..1f45e5f3c08b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -334,6 +334,7 @@ L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
+F:	include/linux/acpi_iort.h
 
 ACPI FOR RISC-V (ACPI/riscv)
 M:	Sunil V L <sunilvl@ventanamicro.com>
-- 
2.25.1


