Return-Path: <linux-acpi+bounces-13480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A21AAB00D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 05:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D40188C0CC
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1F28DF49;
	Mon,  5 May 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lliWnBaL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC233397A52;
	Mon,  5 May 2025 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487254; cv=none; b=tL2Uvhb/i8+n+Xs31nz87KJ5FWyB8w5NAGBV8PNfsew4XQ8zzNk0Fq2OCQToYQ/iO4+4tO0Ch6J1GacNDjZCf/jIA64GpHS7NSTV+0s1jEl2zBb5iwQ6zrzqJDRzmab456qI1kNV56xVrdS/PIIn+BuI6QxmQvycnoq10ew0DNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487254; c=relaxed/simple;
	bh=NxJNsoAxLeDBk9yF6lFLn9BWm/zUoZR/evMbI6ZeLjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hn9NxU8u+TWK5AXslocx4yf7z3Wb2s9tm5DFnzJJLS3Z1rdx7jvNvuLvXjcM4gojs105TRJYbT2cOvt5sxWTf3umafQJD8fRHVwIBaIEs/geO3OaHw27NAttX+v1VWj5dADIj1xLVr7yQW8gaXaXaM5n6ndPHdhpVNI6ja7h/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lliWnBaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD31C4CEED;
	Mon,  5 May 2025 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487252;
	bh=NxJNsoAxLeDBk9yF6lFLn9BWm/zUoZR/evMbI6ZeLjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lliWnBaLUyVIFkO10sniy1mblN2uMJwrEN8x5Av5+3vH2HhnPyOpW2XQBlDRHfS1q
	 A5qoo6XWHjZ+vjDGOWU4EkTq/BBICpFKSTUSArZZ+Ay+ZhmDX0Ol6loSkrSJBugRCW
	 zujSQQx/IhEi2FVjdV1PRDaqv0pyNptmSJ0JzwHUde+1VjQUQKvD5xIBMd9nasYAZ9
	 OAZkUx63HfltpeZMNLf7pYKunXss6Ouo//a1/mzjT0b2oAVbfzxU32i8/psd5qSvCN
	 kM1Lu472brmeaozCVfJ9GBictJmWApwWCcj88ivy3/vDD7y6e08oAzewfv7XB9h7ky
	 brVrkqfbuoQ+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaofei Tan <tanxiaofei@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 081/114] ACPI: HED: Always initialize before evged
Date: Mon,  5 May 2025 19:17:44 -0400
Message-Id: <20250505231817.2697367-81-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index b5ea34c340ccc..3ef66a39111c0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -432,7 +432,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index cf148287e2baf..75166839c99e0 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -72,7 +72,12 @@ static struct acpi_driver acpi_hed_driver = {
 		.notify = acpi_hed_notify,
 	},
 };
-module_acpi_driver(acpi_hed_driver);
+
+static int __init acpi_hed_driver_init(void)
+{
+	return acpi_bus_register_driver(&acpi_hed_driver);
+}
+subsys_initcall(acpi_hed_driver_init);
 
 ACPI_MODULE_NAME("hed");
 MODULE_AUTHOR("Huang Ying");
-- 
2.39.5


