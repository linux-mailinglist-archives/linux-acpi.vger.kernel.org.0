Return-Path: <linux-acpi+bounces-10989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4125A300C7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BB216782B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60526139A;
	Tue, 11 Feb 2025 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRyWHi2D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21233261396;
	Tue, 11 Feb 2025 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237541; cv=none; b=Xk8D9CDTD8z+cliLbtf1D8dNRbbeCBstowJtDOSlrpZizRj+LWZZyrB6nRkiIEDAdz01mXlh3cxn+xXy93ZwvkzBaqRJ+rRxGyDPLp6FP6s7a7Vxw3GVo+fO1ixks4ZhHbHchc0qtYWQBqt2mmAh27zK+zhSyomUGTNnNyCGhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237541; c=relaxed/simple;
	bh=Mj6lPEzi5CoByDW4fvSUWy0YuXZUK5Fomf5vHtaigzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0HUm9yJJyuaYdfr/KiESppOjlbZ0pzfF0bcr8mYn+ToRYwYrSsVIXtVGCJs23xYXiW26EDK2FzMafl4usPFXeW9zPhly1Xh/RI7Xgfa4qSJljN8Upiy7JZN13lpVB7GUhnn8Y4l1watCI8fiaAW97gEbIjdEJ0PJw2EGwy7sKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRyWHi2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B01C4CEE8;
	Tue, 11 Feb 2025 01:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237541;
	bh=Mj6lPEzi5CoByDW4fvSUWy0YuXZUK5Fomf5vHtaigzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRyWHi2D+aj3BVdIObTR8fwAZLy9xTXk8uV37e/vokNcDZVSGHf+UNGlrtjnpHcQs
	 VOShy5TEeYWYFwR8Sk0FlpQ+f+EG2z7TGaTd9+A1LqsrdXBkn+nZX5hUtuXT6xz+Wi
	 vtq5J7Kn1L2nI85WjMhvHO0rB2sntqi7/WMwLRUNKxueKVz7V/DoqiNRa484VdlorQ
	 SJGxmQs8Z/OxXPJSGRwRdqmPQpKjdJCrRwAgv2bg2VR1afUDGSdGQLnd2uEZ1290LP
	 Aiq1fYVoejLpdWxocYdEcsRDyRmYMKUg+PMTQle2p07nGN0wu1axu1Hulx+1/daT75
	 X1GQYRGJHcwrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/11] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 10 Feb 2025 20:32:03 -0500
Message-Id: <20250211013206.4098522-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013206.4098522-1-sashal@kernel.org>
References: <20250211013206.4098522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Gannon Kolding <gannon.kolding@gmail.com>

[ Upstream commit 607ab6f85f4194b644ea95ac5fe660ef575db3b4 ]

The Eluktronics MECH-17 (GM7RG7N) needs IRQ overriding for the
keyboard to work.

Adding a DMI_MATCH entry for this laptop model makes the internal
keyboard function normally.

Signed-off-by: Gannon Kolding <gannon.kolding@gmail.com>
Link: https://patch.msgid.link/20250127093902.328361-1-gannon.kolding@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 34cb7894e54ee..d4fb1436f9f57 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -553,6 +553,12 @@ static const struct dmi_system_id maingear_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
-- 
2.39.5


