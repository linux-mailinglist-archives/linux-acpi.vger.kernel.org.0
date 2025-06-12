Return-Path: <linux-acpi+bounces-14301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E2AD78BF
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCAF3B4570
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449529B77B;
	Thu, 12 Jun 2025 17:14:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68513596B
	for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748449; cv=none; b=Jjidv1dZgxoepRsTjM5IwsQ1/wSlUkegUq0gFZ4B1U5j+XmJy6Gmcghb4BRW2XvBY65Tz6Kv6DvDeIPiOgo17qXtmsPCFYAsAC2/zR+yxMMazSHRWrk1YIb1jbJO2549YRDGLTD0jOzsKcwE3VORnnj2aeA2/2jwTshXrUQfVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748449; c=relaxed/simple;
	bh=2L5eZSW/6fjlPgItRmhuFePTAPbknSoR7GodSA9jumQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GlvNEgZ/vAmajyc5rl/5ePPbWvsOgwJGqZ7Mj2+Dz2xy+BNZWwbPMcdgO7KtKLSQOUwjhBP4fRAYeWek9s6aP99cdESqwPfYb+J2WLQpmnFgMoguafD8sf0fZ3nDEqtLXbsZjcCQVUcPFPzgOjt52rNqxR6vRS/QJSoNQzD8fS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A791C25;
	Thu, 12 Jun 2025 10:13:47 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D1283F59E;
	Thu, 12 Jun 2025 10:14:06 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	sudeep.holla@arm.com,
	jeremy.linton@arm.com,
	James Morse <james.morse@arm.com>
Subject: [PATCH 2/4] ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear levels
Date: Thu, 12 Jun 2025 17:13:34 +0000
Message-Id: <20250612171336.4858-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250612171336.4858-1-james.morse@arm.com>
References: <20250612171336.4858-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_count_levels() passes the number of levels back via a pointer argument.
It also passes this to acpi_find_cache_level() as the starting_level, and
preserves this value as it walks up the cpu_node tree counting the levels.

The only caller acpi_get_cache_info() happens to have already initialised
levels to zero, which acpi_count_levels() depends on to get the correct
result.

Explicitly zero the levels variable, so the count always starts at zero.
This saves any additional callers having to work out they need to do this.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/pptt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index aaf9b5a26d07..72e6bfc1e358 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -183,7 +183,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
  * @cpu_node: processor node we wish to count caches for
  * @levels: Number of levels if success.
  * @split_levels:	Number of split cache levels (data/instruction) if
- *			success. Can by NULL.
+ *			success. Can be NULL.
  *
  * Given a processor node containing a processing unit, walk into it and count
  * how many levels exist solely for it, and then walk up each level until we hit
@@ -196,6 +196,8 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
 			      struct acpi_pptt_processor *cpu_node,
 			      unsigned int *levels, unsigned int *split_levels)
 {
+	*levels = 0;
+
 	do {
 		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
-- 
2.39.5


