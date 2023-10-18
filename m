Return-Path: <linux-acpi+bounces-738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBDA7CE038
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C64B20FF8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB2737C9A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ZFeV9n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7036B1A
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 14:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6FCC43395;
	Wed, 18 Oct 2023 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638414;
	bh=Eq+PPVSM2rBiAVjQk6U7aACJBqCPayr1FzMmHI5I8sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/ZFeV9niTdSgxPpJBDFAnWbidjhLO6/MtSA4Y52YkzPGWyw/1o3q3A6RXDTS/UCC
	 igaMtYs9DG7DYjL+CXrEXyzTipb138HYbzaCIOvQxxfiGLF6SlzgGwGJgUtpJgCO/F
	 7luhQQPR8nD36zxF0gxDnnSWsseNzZSWBQioSYLZ291NeZo8xT8sJnSVvVc85JrpDq
	 oSndYirBxgA0m/KBXcfoFVasdpzNWv7skMNsxnuHc3GdSPsFSsH02/rbbFEYP6jG2B
	 Ib1+AlO1SL8n3fakDRDRsoXiLubJ1dRP9WsSzkPdMzM2lHcK5G1oPnNL0OTl2KekI4
	 V8y+m9k/Jgxow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/19] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
Date: Wed, 18 Oct 2023 10:13:06 -0400
Message-Id: <20231018141323.1334898-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit cd4aece493f99f95d41edcce32927d70a5dde923 ]

Added GPE quirk entry for the HP Pavilion Gaming 15-dk1xxx.
There is a quirk entry for 2 15-c..... laptops, this is
for a new version which has 15-dk1xxx as identifier.

This fixes the LID switch and rfkill and brightness hotkeys
not working.

Closes: https://github.com/systemd/systemd/issues/28942
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ee4c812c8f6cc..8bb233d2d1e48 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1886,6 +1886,17 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
 		},
 	},
+	{
+		/*
+		 * HP Pavilion Gaming Laptop 15-dk1xxx
+		 * https://github.com/systemd/systemd/issues/28942
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.40.1


