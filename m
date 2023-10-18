Return-Path: <linux-acpi+bounces-736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8873B7CE034
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3FD1C20C26
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAC37C84
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqQo4qeQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349C36B1A
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 14:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8E7C433CB;
	Wed, 18 Oct 2023 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638330;
	bh=Fx7fqmGEpgzMOCUel/RgkUToOINnPMIGufOHI4Fg6FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqQo4qeQEPn45dKZf+Tcf06LXqWzPSwS3VO26C0yCK83+xvObw4rlH3nspTdLtNnb
	 52OOPpmlh+twbgI5TL2XoEGgW04ROFYghkT+d1Jt9F6e8DE77dg8y4qMgzdyivfkCN
	 62m08eGetHiyVTump8UIrr+ifY7N3mGRrMFsUVCIqzR1jEzY5+GJt037222hHp4ZsB
	 Vmj8p/oPAx85dBDeJu05NC/EPNMWUmxFVk/g+hg+ySakLckfzbpOU2/dHtAaBpljo9
	 XvmDtQ3XRqCbv0sXDFN4FqfixAEL1miIkA7t1Tjkui0+Gu7USY+Vi9yUtXsehtV4Hy
	 ee423FnVnMtsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 06/31] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
Date: Wed, 18 Oct 2023 10:11:23 -0400
Message-Id: <20231018141151.1334501-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
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
index 660834a49c1f9..c95d0edb0be9e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1913,6 +1913,17 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
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


