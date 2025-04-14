Return-Path: <linux-acpi+bounces-13022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD64A8843C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1823B815F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0772D92FB;
	Mon, 14 Apr 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYHZZKi/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D392D92F8;
	Mon, 14 Apr 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637530; cv=none; b=jwC7nEMrXRVUrwYNkGhsB/NBQwaNPNA7jFhY4/5a5WkxDCpqFqV7mecV1kCSR6HkJjYXl3xw88MZLQ4MAc0+ARsbE+X1W0/yk32P9uNPeqJLT+Fa08r94S10ii0jsi40fFcDYfrcameQapr+EzCxEIDqUpmyosdUIXJj/xzkQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637530; c=relaxed/simple;
	bh=zFLAzkZnMWO9CqDaTcf0ey4neOIQfUEzKY6CyfFPLWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAPNanu+Nyui8rc5MkVtdUVXy//hEGBGqwyJBaj9nfTpBraH0rifCGmHw93b9pPOEYzJa+2/Wj2o0VxETPyLCjzFSwVFV3SMI998sujDQCzHQ0jf/G4HvErEsooZ1Y+rxRIDllNpCEiQtnd5AJSC7AOA6stOJydiAq9o46+OkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYHZZKi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F6C4CEEC;
	Mon, 14 Apr 2025 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637530;
	bh=zFLAzkZnMWO9CqDaTcf0ey4neOIQfUEzKY6CyfFPLWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYHZZKi/Z7hSJ6N0neoUZwCc39U9SQGUpyjROLYNOFwvRPCDBgjsua3ZoqTCYI8cB
	 Xhh+DrwiTtpkAIuGaGvi41lukpSwTSkdA6QhbmASJPtZ6ilN10VAVBqtVeeZNAf7Tv
	 j3qhJHzR8REUGk4CHUS0uFx7tpDymIG1jJ8cZJXzFAIDMFIj8hXdZZJozgeN69Mmsg
	 e+8i+RHU17+9a0HR3enImbunYNhbT5ixXp/xdCz4rOJDhws/p2r5DkTkxt0MGC7v28
	 Ul9/HYsLSX8TA0FMV46F73XiAHT5ft9BrR62yhtUcNn/y0Bn12CR+GdVENnuf3Xn/i
	 Fu4NayGVK4JxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jean-Marc Eurin <jmeurin@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/11] ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls
Date: Mon, 14 Apr 2025 09:31:52 -0400
Message-Id: <20250414133158.681045-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
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
index 4ae93350b70de..38581001811b4 100644
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


