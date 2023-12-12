Return-Path: <linux-acpi+bounces-2341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B980F9BC
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 22:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA00B20EC0
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628D6415E;
	Tue, 12 Dec 2023 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIfrdAcF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40E65A98
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 21:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616BEC433C7;
	Tue, 12 Dec 2023 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702417729;
	bh=BPAdG+oACXLZR8/adiQ5gMuFjpTAdv8WeoWfNUPMLGs=;
	h=From:To:Cc:Subject:Date:From;
	b=tIfrdAcFA7VhDmw1ujVQSY0BkueuygHvl6NJMj3NNfyft50rA+tKCoi9lO4beB4+r
	 l45CQ2WVFiW0Nyx+Pidlls+qP3E3NRTTwdsfjKnm+QnI2hzHO4nKKRJM3ebUeah2r8
	 inwoqJCWg+oY7INHYk5ex19Wi+bgg3TnwwlvJFm24A7c7P2XW43zGrumH0MOdi9eUB
	 bzwHZILIVbNE+urUkkqB+uEZhcdpsn5aHVg2x/be/gGTfJTarycnyISGxPd04xD5Vz
	 htSoG00k3vpD+zPZBrUVe4F54Fh1KhrZOAxvr0bRkzhroIdqnYO2s2JyjafwR1IjHP
	 txJf8HjxmhYtA==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Srikar Srimath Tirumala <srikars@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: arm64: export acpi_arch_thermal_cpufreq_pctg
Date: Tue, 12 Dec 2023 22:48:38 +0100
Message-Id: <20231212214843.256622-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The cpufreq code can be in a loadable module, so the architecture support
for it has to be exported:

ERROR: modpost: "acpi_arch_thermal_cpufreq_pctg" [drivers/acpi/processor.ko] undefined!

Fixes: 310293a2b941 ("ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/arm64/thermal_cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
index d524f2cd6044..582854914c5c 100644
--- a/drivers/acpi/arm64/thermal_cpufreq.c
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
+#include <linux/export.h>
 
 #include "../internal.h"
 
@@ -18,3 +19,4 @@ int acpi_arch_thermal_cpufreq_pctg(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(acpi_arch_thermal_cpufreq_pctg);
-- 
2.39.2


