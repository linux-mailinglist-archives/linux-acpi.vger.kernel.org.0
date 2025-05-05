Return-Path: <linux-acpi+bounces-13478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C936DAAAA42
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 03:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2005F1BA2E78
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04D2DBB35;
	Mon,  5 May 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHKWvRw9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2A283151;
	Mon,  5 May 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485443; cv=none; b=GxTKFj13mIOMgwYCHU/dk/EeeQWQBX5mQw6pjPZF9H206j6ECsZPXm7pufnTTDp6/zSij64JZeqdOBFLPbUkbl33sZWjfQAQMcWqcXwfXqZ9keRFPD0+Kk9uo0nnNKMwkg/HrXcN//XE3vga1HUksoLeELu6qIFdUzPmmX9XCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485443; c=relaxed/simple;
	bh=aJNIKnlLpyEAIbrOLzQzOOGP8QDshHeybDdkCTHJi30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F53zHSN75EUQJbK8eFgFL/6WUKOuIvx08nxuU9M2Bu6jpvfLmMDhmHgkLnLFU2SQ6t9wj8gpyqMFQW/nqHbXou4NhqHj98tiSenzdplAPSo+Qr9+JFjQ/BDJ0Nt1Gk7mVibuLZoOR5/kLt+VZuLqyz7kxLHk9RE1NpyUl9HE9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHKWvRw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B54EC4CEED;
	Mon,  5 May 2025 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485442;
	bh=aJNIKnlLpyEAIbrOLzQzOOGP8QDshHeybDdkCTHJi30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHKWvRw9Rdm7oYaS+RNnkzrLYCOMrR9xzgdCFdJyM7h9m5VCgFefHfyZtUfHD60BO
	 sU+40XP/xDEPVRoT8bNtoVvtHz5Ml1djK6PRl7GXs4U2o70hH42/DpH2wRmVGtv50z
	 AZv5xioH9a7ZOsyX76NlKX7XvcV91bDmyPoPGT64RgHDLiJ8z8Q56WZHISlrB8oL46
	 X4UHmyGD+FCHmQmMB8WuP/xG3g7dNR0VrlhqSLszW6U0ifcNl+UzkIfYoG4sToiNXw
	 X99IB/W/+Uh4CEDOIP8XxhmcZVbUx0NcXvOjhtkEYFdll/7C/Io523D4u6QOqguwub
	 HEzb1XOIas6Cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaofei Tan <tanxiaofei@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 314/486] ACPI: HED: Always initialize before evged
Date: Mon,  5 May 2025 18:36:30 -0400
Message-Id: <20250505223922.2682012-314-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index d67f63d93b2ab..89fa569d63702 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -443,7 +443,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 7652515a6be1e..3499f86c411e3 100644
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


