Return-Path: <linux-acpi+bounces-20302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC383D1EDB0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3560307BD15
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1542399A5C;
	Wed, 14 Jan 2026 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYiMBNFo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C9395DB1;
	Wed, 14 Jan 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394526; cv=none; b=tedrAzgj6TfrFzV5tAaWDp/ilvyugM1aGzWIRuOi7Pj0Kr6gzQZxXxqfjFsMsln/wK1YDUwta8doYn4Z5+kV8QmoA7gcjkqZFEcEZ+iRVDHakjHfz9hdZUsknlh1lUg5NOHJLzWt+cDiAAS/nWSfod3Jiz+QYQM2qmHmDYesABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394526; c=relaxed/simple;
	bh=a/2w7oc6l/7Eqa+MO00WeOa+bPLtlxm5XRj21zfRumo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tP4nxereurSRsc0wEjXg8RIvdTjJMkRiGcyGygidREIlhiG4LK4THIG7kzEtRvJdvC4xX9yAPjVPprhXs6l0TR80DBhglngyHD/icPVm5vD3Kn56of9Yb8bWKcEeuIH/713uLQBdrAg9dJ7xoThhWpJKFFi+StGANY/Qt9UWDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYiMBNFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608AAC16AAE;
	Wed, 14 Jan 2026 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394524;
	bh=a/2w7oc6l/7Eqa+MO00WeOa+bPLtlxm5XRj21zfRumo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYiMBNFoeGKefp2vT5QeETFKPlh/it6K/P5TGQQU1QMd4Hc7D0l/xzyN21aq3fCAE
	 TyD8DqrUkNRaSPQUf4NfI13BmwfW2zrgNB6ZHSV1Usvns8WDwt/+NmdwtI74YCENxr
	 Lhz+BL5b5B4yS4m510foE4lCnxHnNQSbVMtCjbMbe2VWIDtzlMdXAgWipzSqUUO7Ro
	 kK/+DwFjAbQR/FMUmuwygEIU9v1hAeUDVj5Dq/lP3/9ojyLRYgB027qvoxW8YPksw0
	 8duugZscPkkjXDwSxPlqd7lYqr1WzbIXTLesgPQ+ktZeXfSOok+v+Jeedni8VKQv4T
	 64Yrq1NKLlgSQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 15/26] ACPICA: Add Arm IORT IWB node definitions
Date: Wed, 14 Jan 2026 13:29:59 +0100
Message-ID: <2691130.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Jose Marinho <jose.marinho@arm.com>

The IORT IUWB node is defined in IORT issue E.g
See https://developer.arm.com/documentation/den0049/eg

Link: https://github.com/acpica/acpica/commit/a90dc2f5380c
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 05ce897f1eeb..01dc35e4b60a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -682,6 +682,7 @@ enum acpi_iort_node_type {
 	ACPI_IORT_NODE_SMMU_V3 = 0x04,
 	ACPI_IORT_NODE_PMCG = 0x05,
 	ACPI_IORT_NODE_RMR = 0x06,
+	ACPI_IORT_NODE_IWB = 0x07,
 };
 
 struct acpi_iort_id_mapping {
@@ -860,6 +861,12 @@ struct acpi_iort_rmr_desc {
 	u32 reserved;
 };
 
+struct acpi_iort_iwb {
+	u64 base_address;
+	u16 iwb_index;		/* Unique IWB identifier matching with the IWB GSI namespace. */
+	char device_name[];	/* Path of the IWB namespace object */
+};
+
 /*******************************************************************************
  *
  * IOVT - I/O Virtualization Table
-- 
2.51.0





