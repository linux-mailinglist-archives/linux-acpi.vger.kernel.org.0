Return-Path: <linux-acpi+bounces-7095-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E0993E23E
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7073B1F2133B
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6C18E748;
	Sun, 28 Jul 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwbXElAM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B018D4DD;
	Sun, 28 Jul 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127787; cv=none; b=IbawjflADUL1lTzXF9Qj1BaVj9GBv/AKqmVrEBHtDqyC1fp7hcCO4jTTcxSdpveA0YnB1M2R43RfRn55J6FFikjJcEhPbd6GyKVtK9roPr0YXuZrOSDIr2LKRn3mANBD0bYOqqi9zQ9vmsAC8vt1/o6hb7vH6KRCjTquV4bEeP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127787; c=relaxed/simple;
	bh=rltdtsY6gsKIG7uNCBAvwI183udJmPz/rWfP8DXDUhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hliv2n8JjSLBVJA6pWuj7PbobuCs4++3jitwFpDWl7xy0aGxbY1JKR1piut7lPnFWDSIpKl2qyYNKJnULoRd3K7v9qQj5CZvmTcFLYLxKiYbK//K9acgOOFAfm2awH2rP6qBDJZC9126sB0s5b9B6ir+HNpyyJKCPU48z4jRbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwbXElAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E7C32781;
	Sun, 28 Jul 2024 00:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127787;
	bh=rltdtsY6gsKIG7uNCBAvwI183udJmPz/rWfP8DXDUhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwbXElAMGWcXeCY53cWbCwq5bxdqQwPSIEX7mWfCE0BBA6Jhkgg9DGEVDYmqVmgD9
	 QB/Kmr5m2PJSOxx2v3rRrcitZuyytSRMVf8IyLPm0vpxOWyLNky9/GBS9CBb0bXbRM
	 f09v3suwRIftMjJoM0pQqcxP3i/IuKUBqsq+9xSdgUEiiQ0xKPJoPJJbRieDMpFyEG
	 Gg5dg8n/92AoLGChPZMSvOatffPgfj+85IhS8/kqurgvfsQjb1M6rnxruoqdS18mam
	 yg/7/+611Vio22S4B2Y0BXbJHQPBvCVtgUQLx9O2VwfKDX69DnmQ2GE8Lt6UGE8o6l
	 MiPG2AQNyuBkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tamim Khan <tamim@fusetak.com>,
	Amber Connelly <amb3r.dev@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 8/9] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MJ
Date: Sat, 27 Jul 2024 20:49:28 -0400
Message-ID: <20240728004934.1706375-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004934.1706375-1-sashal@kernel.org>
References: <20240728004934.1706375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Tamim Khan <tamim@fusetak.com>

[ Upstream commit e2e7f037b400aebbb3892d8010fb3d9cae6f426e ]

Similar to other Asus Vivobooks, the Asus Vivobook Pro N6506MJ has a DSDT table
that describes IRQ 1 as ActiveLow, whereas the kernel overrides it to Edge_High.
This discrepancy prevents the internal keyboard from functioning properly. This
patch resolves this issue by adding this laptop to the override table that prevents
the kernel from overriding this IRQ.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218929
Tested-by: Amber Connelly <amb3r.dev@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
Link: https://patch.msgid.link/20240708000557.83539-1-tamim@fusetak.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b3ae5f9ac5510..df5d5a554b388 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -531,6 +531,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506MJ */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MJ"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.43.0


