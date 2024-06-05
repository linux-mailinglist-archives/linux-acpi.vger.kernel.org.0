Return-Path: <linux-acpi+bounces-6200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76438FCF8A
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEF91C20615
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453953BE;
	Wed,  5 Jun 2024 13:15:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21419D880
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jun 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593307; cv=none; b=On5Owekie4unE9OdO2gLMc7ww7scevw6IG8FPyzkI8PGVZIPvnXxq184rMvdRtxfDO6Evksg1k84e8WETH+kbCG9dkSwsSXgzsQlsHEYLYfTRaQYSjw1RT1t/ppPofy9WHHq47W+RCBSkWcvm/LGtoP0nTxW47lnTVMfMSkiKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593307; c=relaxed/simple;
	bh=OtOS56ZD7EAxz4tl7uFkwAbLTAOpYrzzQCRflPkYO2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBtnKIB+7rTfwKmnOwPdHUP3PII/wBK2I5HVft3JQYD6Us5zKHwOds5CmbSm8WkQO5KD2wXcsRRa6cIHKrCnBg7DtyK6H0KVaojxkKr/Gyk4uNHO2tgdqIwTdVF16A/OuVsT/uL4CrXX9zY0rIDjODcTt6xvqjyN1aQFVYJ6sOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1679DA7;
	Wed,  5 Jun 2024 06:15:27 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5737E3F792;
	Wed,  5 Jun 2024 06:15:02 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/3] ACPI: arm64: Sort entries alphabetically
Date: Wed,  5 Jun 2024 14:14:56 +0100
Message-ID: <20240605131458.3341095-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605131458.3341095-1-sudeep.holla@arm.com>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the entries in the Makefile alphabetically.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/arm64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 726944648c9b..7d7fd6512bca 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
-obj-$(CONFIG_ACPI_IORT) 	+= iort.o
-obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
+obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
 obj-y				+= thermal_cpufreq.o
-- 
2.45.2


