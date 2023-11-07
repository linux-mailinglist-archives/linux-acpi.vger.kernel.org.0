Return-Path: <linux-acpi+bounces-1330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA197E3EB3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098651C2085A
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A630CE4
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKSKN3Yx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12F2DF9A
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 12:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69162C433CA;
	Tue,  7 Nov 2023 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359099;
	bh=4oOYIcnoxIxV6g1ChuQv7zCVzuFMdjbfN1SJdr13zis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKSKN3YxDp/Az4dvizf1bUI5LcaWkcThntW6OjPQJh+iO0UnVPRrUW4fHuwev2oMv
	 aOkI98KWEj+bxSi8KASKfeC14T/NFEN3fmLtT3JK2Xnr5Om+WZaCr8hms5EOSUy39D
	 TNA4Zeg63KahhTXEFsnFy9I3TxI3XJps5Ohn7ARJ3kwLaa/+mkjHtK1XPfCGsnv2NT
	 tDTdiN7pwKfZiMHkIbDwC/YNmwxAj7DbcTBPk4pKz9A/Mf6yxrdKVaKjaLim2pbJxN
	 Jd6s3/Iee8KGa+qaySUJUOkYfe0UrWwJ3EfcPCqWQfQfYbfyQ6ktiyxaKhSGLbYBj7
	 R7k2mKEc0SBvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Denose <jdenose@chromium.org>,
	Jonathan Denose <jdenose@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/18] ACPI: EC: Add quirk for HP 250 G7 Notebook PC
Date: Tue,  7 Nov 2023 07:10:45 -0500
Message-ID: <20231107121104.3757943-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121104.3757943-1-sashal@kernel.org>
References: <20231107121104.3757943-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit

From: Jonathan Denose <jdenose@chromium.org>

[ Upstream commit 891ddc03e2f4395e24795596e032f57d5ab37fe7 ]

Add GPE quirk entry for HP 250 G7 Notebook PC.

This change allows the lid switch to be identified as the lid switch
and not a keyboard button. With the lid switch properly identified, the
device triggers suspend correctly on lid close.

Signed-off-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8bb233d2d1e48..77d1f2cb89ef3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1897,6 +1897,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
 		},
 	},
+	{
+		/*
+		 * HP 250 G7 Notebook PC
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.42.0


