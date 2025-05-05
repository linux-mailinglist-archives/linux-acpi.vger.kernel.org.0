Return-Path: <linux-acpi+bounces-13481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C1AAB091
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 05:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2351C3AEEC7
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 03:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD33F9FDD;
	Mon,  5 May 2025 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvthHW/A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133E3BE0C2;
	Mon,  5 May 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487409; cv=none; b=R3aNlQCrlKB5B95kdtlWIMkfvK5RJElADjJWwYOiiU63DWQLF5q2Ftnr0m3PrzWn7ZZX6aX07CScPmh8NV1AkVXXlH7r4kNwe5njIZFJxqqu2DwHePiFVdmVq0LrnJCF8FeYv9AFn+3ZtJaNWryTV7/XP5Phgi48EUPyHltbQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487409; c=relaxed/simple;
	bh=m3gj8PSzjfXPwRUTE5aW1/XgqUd/bkAgDJtD7cLr5FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaSIJDRdGUtCPnTJJcGG0Fcq2MUM4wSUbg+0u+aTTWxjt+DqM3wtaMPpAM4TNU6XDOSSg58m6mLkTS0Peyl14mf4lqonyy0Nn9BdM7WqBs764vEV2XZQjbELWtm8nMVWk6x/6b7Wvl0ZWYh16I9Ecxk43rFtytEd3yEFHUYuPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvthHW/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786C0C4CEEE;
	Mon,  5 May 2025 23:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487408;
	bh=m3gj8PSzjfXPwRUTE5aW1/XgqUd/bkAgDJtD7cLr5FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvthHW/ABfM7tUqf2GtoECcfbI/Cgp0siVuZKF0dt8GjpJuypHlLU1zxgSBrPmkDQ
	 IYt2LXIe20xAk3v5/yvWZ58VPMxi8Gm6ANTZt0P+dNGAmvs0OGVVNBQasHC9A08Dh0
	 lx795oiCOKV1wvRtyiB/6Zj3Sv3EI3Ii4WXVFPtKfouAYi9qKZR/rOAVt4k41An1uR
	 fSZ8uKp2pje02zo0PhiN7PIMux5EWUlOTnPuM8hTHIh7dpZuCOSnjjRBLTWzdy2WnU
	 HtnEihvJ2ysdtNOAIoov9fzPunAaK8yVcRcxqpHf7GH/hSuoFTBXF5W6D8R3H4Wvi2
	 mwbjLMC64nGsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaofei Tan <tanxiaofei@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 54/79] ACPI: HED: Always initialize before evged
Date: Mon,  5 May 2025 19:21:26 -0400
Message-Id: <20250505232151.2698893-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index ebe1e9e5fd81c..3902fe64c484d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -431,7 +431,7 @@ config ACPI_SBS
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


