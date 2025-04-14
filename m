Return-Path: <linux-acpi+bounces-13020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC3BA8838D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B77E16E9AD
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3650275113;
	Mon, 14 Apr 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIH6LjM9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9625275115;
	Mon, 14 Apr 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637463; cv=none; b=Wl0vVmYeCrSOzrOUgXXZSsbw4ipqGSoNd+iUolwTvV4hTV91bWcFatStgMCZuIubKcK500poVVd9/ySvsB5Mx1+SlPSYvyl3kmI73nwsU4sI7O4iXqdHyVx7Yz2lqcysGpdACi9c0CjQClwvToGpJZt5x9ZEtHXlMzNu5n+InSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637463; c=relaxed/simple;
	bh=AT8ZBV92Pg0o34lrQX/0mtWbJPjVgHzE3+zanxfSwJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJ10Wyg7tfL19Ikg9Zdo5tjxmP857BxDm+QxNrLVD7BlHTGXQ/sEXOzq9wcQLPslVK0INbtvg5VupTivGggn+JF+UAOwdJwmQQDf9Uw6jNyKSuzm/lyMsWBQzV0yRsFl8bMvrjUI+hGp3WlXjuCk9/vyVIpM+fB3yblI2WhWWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIH6LjM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C060C4CEE2;
	Mon, 14 Apr 2025 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637463;
	bh=AT8ZBV92Pg0o34lrQX/0mtWbJPjVgHzE3+zanxfSwJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIH6LjM9K/56Yp/v06r8caFLFgfOfGlK6VMikt+ucLLSsrWUfOveXADOo4pGUILtH
	 obEHCYO2j9o4Kr0TICzNEZr9SoyE5P0e3ViIsnazjuLKN5MVcpAMlT8Lx/VRrpNXSA
	 bdnAHQj8+HKLpcgRK/5rvGvIbqB4Ss7H1JqqP5W7CMsHqwUNzwNJDV+lGOhEOvZza/
	 /AAaci8uf9LZQZwt3TapCOSNTh0DlaLFvooDkyP4Ld+A07Nuy7DrNQmPEUT4sz/oRN
	 BmLuoJSYWPugCwy2BEmhsuJHfpPbJBQcTTP5MUFJEav3a26cmkn2UyiYlgYHS22GEY
	 Lsw1W38ML1h/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jean-Marc Eurin <jmeurin@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/17] ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls
Date: Mon, 14 Apr 2025 09:30:38 -0400
Message-Id: <20250414133048.680608-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index ced3eb15bd8b7..79a83d8236cb3 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -217,7 +217,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	while ((unsigned long)entry + proc_sz < table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
@@ -258,7 +258,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
 	while ((unsigned long)entry + proc_sz < table_end) {
-- 
2.39.5


