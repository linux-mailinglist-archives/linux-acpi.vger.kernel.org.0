Return-Path: <linux-acpi+bounces-13479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9493FAAAB6C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 03:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1932E3B8F5F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B5284B5E;
	Mon,  5 May 2025 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoWBRHnO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC628643A;
	Mon,  5 May 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486186; cv=none; b=rSJx80kDP3A9qIMtV2X0sqv2o5CEz9eAndaIUr83qzhbGBr95hfxfGVbqdbKcuIL0rbHIu9MyzFsovCbHoSxXmrgNawE2Rr2EHVsm6asQQNigzfOCxDdMrBSy5/M8Fp9271ZEng1NKsUg2NdN1STKlyJWPnq2tte88MGOmZ/8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486186; c=relaxed/simple;
	bh=KxLftJXMcxBhqTMpwF3Do4ToKuaFC/nLHHWSzDlw2Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLsGPTNKMJyJBPLhU2QokuuyKJtIpVyNt5TqxAu3FujTMBBeWifgKwHMv3q2p37tPPfVUYHGfBqenIJIbUGQFjgsh7sAaA/W0WuMbbOiJttbPUJcJHi+ciP0RHiPPsLe1SNJwJhRiKRnsMuou3/p3B1KNAwe5m8HtqEP/WLu2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoWBRHnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85257C4CEED;
	Mon,  5 May 2025 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486186;
	bh=KxLftJXMcxBhqTMpwF3Do4ToKuaFC/nLHHWSzDlw2Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BoWBRHnOmopgMO+CE+ZjOncJbGfJgDjGIClp14PelaH0I2Y89cCmNj+0msx8lLHA0
	 LAePgISqVd59IyxnxNfzE9TDfN5Fv0cIvIDnDNAu8X41KtbHeL4+c+VlUpZ1rU0gEo
	 7us4lGm5GI1ZBSNesT2WhruxjNFqCMbd5OVOlIst3iy6/HI6fJOCKBYDoCeMQ3FRXy
	 h+tc6CwXotYYh3qFYjiVrHLxxJIozAtMo4TDiVr3XKAZKE9HbIjg7+L4kPvbr86iVn
	 IiYfMUcoSqDG7++5it702n8Q4UPybpWuAG3t78ILmMkfnRmfzfXpf8SCjNHp7BNktD
	 CRvdjCj/Gu89A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaofei Tan <tanxiaofei@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 193/294] ACPI: HED: Always initialize before evged
Date: Mon,  5 May 2025 18:54:53 -0400
Message-Id: <20250505225634.2688578-193-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Xiaofei Tan <tanxiaofei@huawei.com>

[ Upstream commit cccf6ee090c8c133072d5d5b52ae25f3bc907a16 ]

When the HED driver is built-in, it initializes after evged because they
both are at the same initcall level, so the initialization ordering
depends on the Makefile order.  However, this prevents RAS records
coming in between the evged driver initialization and the HED driver
initialization from being handled.

If the number of such RAS records is above the APEI HEST error source
number, the HEST resources may be exhausted, and that may affect
subsequent RAS error reporting.

To fix this issue, change the initcall level of HED to subsys_initcall
and prevent the driver from being built as a module by changing ACPI_HED
in Kconfig from "tristate" to "bool".

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Link: https://patch.msgid.link/20250212063408.927666-1-tanxiaofei@huawei.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/Kconfig | 2 +-
 drivers/acpi/hed.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc50..648228831f5e8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -438,7 +438,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 46c6f8c35b436..2e01eaa8d8cd5 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -80,7 +80,12 @@ static struct acpi_driver acpi_hed_driver = {
 		.remove = acpi_hed_remove,
 	},
 };
-module_acpi_driver(acpi_hed_driver);
+
+static int __init acpi_hed_driver_init(void)
+{
+	return acpi_bus_register_driver(&acpi_hed_driver);
+}
+subsys_initcall(acpi_hed_driver_init);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
-- 
2.39.5


