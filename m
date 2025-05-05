Return-Path: <linux-acpi+bounces-13485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7CAAB514
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 07:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C3E7A5ADA
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6A3A7856;
	Tue,  6 May 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsHAp6qX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD3284698;
	Mon,  5 May 2025 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487016; cv=none; b=SdNKN0+DAlvdJGePYGdrNuZiDBWsta0CGiHvDqEhRedkDHJ6iIXNh2TltPnGHf01ySClTyZZanxTmQnhqem1TLeUV3WOjLdMTqpGVxjzV1EF+lUJFQwSU8xD1538BZC9IStzfYgrQ7gT6BnqSdyDoemoFItk7k9I2EPCiD4eKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487016; c=relaxed/simple;
	bh=khnhXmagq4a7TPMzIk+VPWiuWvQNQtjNfkBupN1T8Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BvP7LiLdQPtboTvwKIX5BUI7NqWqWb3Vdm8ETUxFX+ieY2n1OduoAS/+bnuczshroEFKcCtD07YiKAKPILQ/uqAPOJN/STR4pa4akP48v0gLvVD2+kDF8mzVyVa7bDZJv2NR76suCCbDyYiUKPzmCnbjmjeeki4Y0crhr3+Ky7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsHAp6qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2089CC4CEEE;
	Mon,  5 May 2025 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487015;
	bh=khnhXmagq4a7TPMzIk+VPWiuWvQNQtjNfkBupN1T8Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JsHAp6qXTi8Cy1ntWqJ6VQLqtKANaj1m8r4aEvAzLBXy2RKNX3aZDJj6AyKEDG3Ly
	 SJ8T4mkoYCRiTHs2uQ1DXsL6mx5I6GnImaMRIvaWOnz4QrRDraA+nUkQtw22BzXdMJ
	 FbZ82+IBl9nmErQZ2JR63j/oPawVEivtoOkTHpbApLvkZSnANi164h3W4gHqlvvucE
	 DM2PzvJsPTsdZvPYkYB5kevsEzgA8hOkQvnbZ3wBRLaAF+ZjidDJjdz91/IZuU7RgY
	 fye+TXVLL485627VFAD3CJTVW/vm5b6ZM5nzUNCso2pbXXcniGDJvMwHhMo63nl8Y+
	 Qs+oLrDIteztQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiaofei Tan <tanxiaofei@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 109/153] ACPI: HED: Always initialize before evged
Date: Mon,  5 May 2025 19:12:36 -0400
Message-Id: <20250505231320.2695319-109-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 1da360c51d662..6a178e38fc4a8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -437,7 +437,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 60a2939cde6c5..e8e9b1ac06b88 100644
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
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
-- 
2.39.5


