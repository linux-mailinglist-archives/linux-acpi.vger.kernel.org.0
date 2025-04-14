Return-Path: <linux-acpi+bounces-13018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F37A8835D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F92E188C286
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979D2C1E2B;
	Mon, 14 Apr 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWvKx7qD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED82C1E1F;
	Mon, 14 Apr 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637417; cv=none; b=sBr4epGqx+m1/ee+mRy4xqgpcF1oubGwuwXYX7wmgPoKdPjNB31TXayf/IEBD5UTNPT9+tO8oa20wbAy9hpsK+H1CUD/5JypuUrp4Vnqk9qjmWlRXLZRu9RVVjiSJpqREqWY9CL/f57za5zs9sjjh4VP6I/y3IaqSbbsnyZOKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637417; c=relaxed/simple;
	bh=AwcB7sgJ2b3w3rrwnUM1rfisGcuuzSfBoHqPMRdTGF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRZe+d47tOu8YO7lopA5kY6ggVElKAPRDqA17ztGJmTdcIwk1/E2esG0gJ4b2xm3FvTu4d07lh+zyB5IS5Qe2Txx2WQq7BovVpvo+lcLvM4U5wyUeXgsoPGAR5pwmVZ7QXg/7In28AxuP84hCOXE0xUPGIOEj5xPieYL5j8kG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWvKx7qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478AC4CEE2;
	Mon, 14 Apr 2025 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637416;
	bh=AwcB7sgJ2b3w3rrwnUM1rfisGcuuzSfBoHqPMRdTGF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWvKx7qDLUGVRsvXmFR+XJkaBChQa4TXO+Wml9e+EDeNh6UsCp7h54CcUI2lHgoUn
	 bvQREnHs4TXnDqqxSYTITQbg0YIDdmvWLBB6XaO3DeQY2uwDFGYxNxfP8sydcbrB+W
	 eMzfSnT2G/+whuOCfBGy/UEw0daYN2x22chBxFGSx0qRpnSRF6Qugx1lmrtNwYjWfQ
	 w7gLFWzYVhCmsxLZnAcxrrGJAiDV+u3x+9x/tQzXXpGqbHeyQLWfpQPfY3OvXSOX3F
	 8xk+bsYTMeZ/ROwxkZUfypjuiYCkvy1yPFcW1TvFQZBWygmLKe5AzccIjqgBqVJ21O
	 EpJ6YuwtWuQTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jean-Marc Eurin <jmeurin@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/24] ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls
Date: Mon, 14 Apr 2025 09:29:42 -0400
Message-Id: <20250414132957.680250-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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


