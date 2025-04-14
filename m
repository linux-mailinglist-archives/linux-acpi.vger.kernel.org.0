Return-Path: <linux-acpi+bounces-13021-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0ECA883CA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B1F176094
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73C2DAF77;
	Mon, 14 Apr 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMSRRuxt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E52DAF68;
	Mon, 14 Apr 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637499; cv=none; b=uSHn/ElRt9npMfk1tZSsTK3qGrdPF5TDB52gMC9A4NzbEN7f0RMn80SZjbH2Alv5sAsVmFcWLRggMz5hGLwZFPyr9OYXvRMIv5bwUKcVbmi0JwSnXzL2n2KWoK2c/765Q/QqDw7Asz5B5AyyXTMn9VpxiPq4ZjWL/QOYwWWdbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637499; c=relaxed/simple;
	bh=iYcLTOzH/QQBjqu4jFyefvHnG9vgkuMfOrEul7k28do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KG/YWjBlu7n+jgUaFkRsiJiKiaIcozjrQN2YTjyLVBRn0LMkCntdu8CNgaA9bSvlGJqSIwk9KVBsSLgnZFrR7e5MPAWkOlnd3HjUncA21FsMtPr8JjsrnTM6Pq++TPn1JxrmS737PYToFcJGmzyokNoTs8tRHRystzNeU3Ea3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMSRRuxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B6FC4CEE2;
	Mon, 14 Apr 2025 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637499;
	bh=iYcLTOzH/QQBjqu4jFyefvHnG9vgkuMfOrEul7k28do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMSRRuxtv12YiRLWm8oaqC3yrYC9OfehX6+ev9G2lPHv2RrreIZzkci/RGPr8A9zT
	 fR2YuApB5HO2xPZZZQvLlDEp9IfjYT3fm4g1oYLl9ofcv0bjD7ZXYTzToOrXQBPC1F
	 zpgB7fglHoKhmfiZLYt0apofWtiXD6Y9kNo8TpcljXS8MYvv2TZ7CCFhILv9ZuD9my
	 LwElV7HIBmjHRVxJDAMd7hLDqHh/d0nZeVPMyAJKiBeMP6W4VshZjThbz/euz1c43B
	 Zzidue3/BEWmYxB0ZM8ow49jLeytyUpxnK3clz7H5iRpt0TZL20Tc/Px+RTcvoTug7
	 sYiETsv7FyxDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jean-Marc Eurin <jmeurin@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/15] ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls
Date: Mon, 14 Apr 2025 09:31:16 -0400
Message-Id: <20250414133126.680846-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
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
index fe69dc518f31e..9fa339639d0c0 100644
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


