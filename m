Return-Path: <linux-acpi+bounces-13014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBAA882A0
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 15:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BE8176E26
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96528DEFF;
	Mon, 14 Apr 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aem5JENe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280928DEFA;
	Mon, 14 Apr 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637274; cv=none; b=lU2C54rhOyUjAj02lAxCAP+8X7pYRboGTgVhCWXjhkbQ8JMKuDQh90wX1erKYoK3il8p0KD0wkT+jZHLCLvO0Y/NIZngMlCzTSNIk6RkG2UHrLjbAmyDPfPTcarMtD5m5njSdZdveRPkeOcmtso3kdKYPdxb2aaZdl/5CDHxAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637274; c=relaxed/simple;
	bh=AwcB7sgJ2b3w3rrwnUM1rfisGcuuzSfBoHqPMRdTGF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5IybXcRmtr7WUdVfTQihmnClSpMWz0Da+5tVOcvigefAyS8JIOGxy9o7mWhkbmgwSIcZ6UhkXXPQage3uZ5nnw/nLwE1GtWjhczG6353TyY5+Z5ruOCaRiD4nwRum7oThRnnNiqhPAVdnge4mRxHzZyyCO8FtLj4rb8sy4yLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aem5JENe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AB3C4CEEB;
	Mon, 14 Apr 2025 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637274;
	bh=AwcB7sgJ2b3w3rrwnUM1rfisGcuuzSfBoHqPMRdTGF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aem5JENeG9vN9CQJVO0qttmjooKwcXN+0MDZuIFjQzEdmywY5zlz5DIlr50QwPvYA
	 1AefUDXX2h01MXgT4UdMV3nDMFWmwOkcgk2tWJG6bFp8NJCt/afvauOWbjlF+mv8bZ
	 rUBjcvfcoHxOadxln/xUx4kJsqlDr6Y9T6+Z5CQMoBoTGUxdQiNfwQxyBHzrF0m1tJ
	 O7yPC9j6NdCPatWrrmAp5YpvGsip5E5ModHLT9FrZ2eLL2mWfuNZN/VSseCqaQJSNw
	 SCXqWTzPEvsW8FTvmiKuyah4rOnJwuP1Hfg5aAdjLOZLDyBjfYqFJzBClbZ4M2XmAU
	 IhLlZ+BQHC8Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jean-Marc Eurin <jmeurin@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 12/34] ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls
Date: Mon, 14 Apr 2025 09:27:06 -0400
Message-Id: <20250414132729.679254-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Jean-Marc Eurin <jmeurin@google.com>

[ Upstream commit 7ab4f0e37a0f4207e742a8de69be03984db6ebf0 ]

The end of table checks should be done with the structure size,
but 2 of the 3 similar calls use the pointer size.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
Link: https://patch.msgid.link/20250402001542.2600671-1-jmeurin@google.com
[ rjw: Subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pptt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index a35dd0e41c270..f73ce6e13065d 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -229,7 +229,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	while ((unsigned long)entry + proc_sz < table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
@@ -270,7 +270,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
 	while ((unsigned long)entry + proc_sz < table_end) {
-- 
2.39.5


