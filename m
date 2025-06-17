Return-Path: <linux-acpi+bounces-14412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88868ADCB36
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 14:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8F71889DCF
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017602E06DE;
	Tue, 17 Jun 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyGF7Xk6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2392DE1E1;
	Tue, 17 Jun 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163013; cv=none; b=PbVysxLj79xlN2533DQzMULUi593rMBSWPm7i/kxekZxaTsGYo1OHBncLI9FA0ZVkTgl2lZ6fuyijTa4z+/FeFe1F7OAcjjz6m/zAO02xnQacSjYmeUhPAQnB82KHpkaDGG+jhUJrThp9zbuOhPl4/S32ALnLA1HkPNK4rI0TQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163013; c=relaxed/simple;
	bh=O9+JbbKlI3fjEUjmsG6yxlim6CZofgclow1ax2USBRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yv+/HIthOmoparG35xQRamB/nYe/OVO1Kgc71GaeTv5EKhPNACxIoquqEXeyPFOg2n89KZLz8hV4Sty5oG3SiTmHcCHEMaN6kVmlZ+rwENBl730Y6hsnSdsoPGIR8Upvy3TWmfynjttuDbMqls3J7vbsm5SrLxUgXoeEJvB3qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyGF7Xk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45DC4CEF0;
	Tue, 17 Jun 2025 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750163013;
	bh=O9+JbbKlI3fjEUjmsG6yxlim6CZofgclow1ax2USBRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyGF7Xk6vItycttAXe4cMhrylf5HK3S3b1kvZ08uUtY7ZScBWGf6onJKFRxN3A4g6
	 K2aCOkW2RyJLEdhU6u9MmGPQAT0aysrwu/bnstg2l4nlf6h1X3BGg4EjuzDSnx0Wna
	 nrQBgFKgraj1NLYkO2KbD7Xwge8W7sBfWaQKEbNLO6O7GNl7u7GV23O62G3Li3tl9J
	 EZk5HGecGPgHib5ivj3fCA0cQiJUKjZWbf5Mef0GZwVhYp65/9uC4jOILnog7eovTW
	 ItdEg8wUfBZQ7OnOKOmntoAfLL2Xl89pmFWLro5gYnR+pG44xzpmiKv5yKVH4ixrfk
	 vzTlg1XvU+NDA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/8] ACPI: resource: Use IRQ override on MACHENIKE 16P
Date: Tue, 17 Jun 2025 08:23:19 -0400
Message-Id: <20250617122322.1969649-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122322.1969649-1-sashal@kernel.org>
References: <20250617122322.1969649-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit c99ad987d3e9b550e9839d5df22de97d90462e5f ]

Use ACPI IRQ override on MACHENIKE laptop to make the internal
keyboard work.

Add a new entry to the irq1_edge_low_force_override structure, similar
to the existing ones.

Link: https://bbs.deepin.org.cn/zh/post/287628
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Link: https://patch.msgid.link/20250603122059.1072790-1-guanwentao@uniontech.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Bug Fix for Non-Functional Hardware**: The commit fixes a broken
   keyboard on MACHENIKE 16P laptops. The internal keyboard does not
   work without this IRQ override, which is a significant hardware
   functionality issue that affects users.

2. **Small and Contained Change**: The change is minimal - it only adds
   7 lines to add a new DMI match entry to the existing
   `irq1_edge_low_force_override` array:
  ```c
  +       {
  +               /* MACHENIKE L16P/L16P */
  +               .matches = {
  +                       DMI_MATCH(DMI_SYS_VENDOR, "MACHENIKE"),
  +                       DMI_MATCH(DMI_BOARD_NAME, "L16P"),
  +               },
  +       },
  ```

3. **Well-Established Pattern**: This follows an established pattern in
   the kernel. The code shows this is part of a long-standing mechanism
   for handling keyboard IRQ issues on AMD Zen platforms where "the DSDT
   specifies the kbd IRQ as falling edge and this must be overridden to
   rising edge, to have a working keyboard."

4. **Similar Commits Were Backported**: Looking at the historical
   commits provided:
   - "ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx" -
     marked with "Cc: All applicable <stable@vger.kernel.org>"
   - "ACPI: resource: Do IRQ override on MECHREV GM7XG0M" - includes
     both "Fixes:" tag and "Cc: All applicable <stable@vger.kernel.org>"
   - "ACPI: resource: Do IRQ override on Lunnen Ground laptops" - marked
     as YES for backporting
   - "ACPI: resource: IRQ override for Eluktronics MECH-17" - marked as
     YES for backporting

5. **No Risk of Regression**: The change is isolated to MACHENIKE 16P
   laptops only (via DMI matching), so it cannot affect other systems.
   The DMI match ensures this override only applies to the specific
   hardware that needs it.

6. **Critical Functionality**: A non-functional keyboard is a critical
   issue that prevents normal system usage. This is not a minor
   inconvenience but a complete loss of primary input functionality.

The only reason this commit might not have been explicitly marked for
stable is an oversight, as virtually identical commits for other laptop
models fixing the same keyboard IRQ issue have been consistently
backported to stable trees.

 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7c08cf69ca311..7e546d2b3884c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -638,6 +638,13 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/* MACHENIKE L16P/L16P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MACHENIKE"),
+			DMI_MATCH(DMI_BOARD_NAME, "L16P"),
+		},
+	},
 	{
 		/*
 		 * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel the
-- 
2.39.5


