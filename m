Return-Path: <linux-acpi+bounces-16778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE7AB5576D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BD91C2632B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C334F462;
	Fri, 12 Sep 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awUsnbAi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5834AAEE;
	Fri, 12 Sep 2025 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707623; cv=none; b=oRRpIjuIF10JEIL5d3eciQ+4mCfTWuSsoBxbT85Ue/fE6I9Tu/HFDb9iv8utPETpQvfwoisuDZNKCEd6OUvDq7ZVi2UhE5pfXOJ50Efly0Qr6YmnCkFuCLsxfOMPdMZaNY1JNwu2GYMLlq9GRISESP7AmaOh4jKZtjic7oOyWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707623; c=relaxed/simple;
	bh=OQ6C7FNvSJ81Ma+gZUDbeJhd+soSIz4xyxq597SsjT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C37m/yj9q5stEs7trsr5lL5j0lhY6cP7MZ5Pz+xEn/dvrEYFGbjiKVXV5kEJfvYrvo3SR+MBsye3q3SGTYH6RWBSNq90IUzEvc9fo6sRer8kM3XjWN2FZoy2y3fGUQWh2G0T+uvAG2xInMTn1U1/wjt3mv7xhKn1rQLa6xjnrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awUsnbAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2A8C4CEF1;
	Fri, 12 Sep 2025 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707622;
	bh=OQ6C7FNvSJ81Ma+gZUDbeJhd+soSIz4xyxq597SsjT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awUsnbAi484dcH20fbZ/gql2TnmYSTr8F9fbAJnaEQ4TBaoyJx968ar/Y/odicYvT
	 YGnIH7lrCjNXWrjxhzJcbBTxI191YIwRoRIuuXCW/EUlw+A5UFNerpFJ19L8lFo7XJ
	 yVApBt3da8cdv/VO3+vWbhNvDqc6fqFG3z/lnP66I3jRuRx2fXbFw2gzPcuJ+4oAL3
	 AFLVhChfGKPrk5hgplmfW2WsWG+pieS3e8hNAmx/Es6NbtDcgABS1IPwBtV3ZC7TUN
	 L7ewvzXRLJz9xeMCltdpH286w6cJkiw02Bh4ck+5AP6i/BqH/ICmBGQYYNWzzqo52Y
	 fVn/P2I1mE6ZQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 02/16] ACPICA: Remove redundant "#ifdef" definitions
Date: Fri, 12 Sep 2025 21:53:30 +0200
Message-ID: <3656949.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Zhe Qiao <qiaozhe@iscas.ac.cn>

Link: https://github.com/acpica/acpica/commit/204776a3
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psopinfo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 5168b4a04670..ca867d9407f9 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -34,9 +34,6 @@ static const u8 acpi_gbl_argument_count[] =
 
 const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 {
-#ifdef ACPI_DEBUG_OUTPUT
-
-#endif
 
 	ACPI_FUNCTION_NAME(ps_get_opcode_info);
 
-- 
2.51.0





