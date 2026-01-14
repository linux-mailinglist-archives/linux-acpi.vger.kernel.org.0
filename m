Return-Path: <linux-acpi+bounces-20305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BED1EDEC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9039C3054420
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3079399A4F;
	Wed, 14 Jan 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiNTtH6u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DA39A7EF;
	Wed, 14 Jan 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394534; cv=none; b=AhVoNe+wYa3gZG+ZUCIbrC8cxS2aLfZLOcykPoXTqatgr+CFeDEVKZT+OrfEaz2wHOEzc9V09WQK8VlkLYLYMd5yMv1IrR1mhQfdrZ0CFpMwVG21nBlF9jkaWCbDSzCevuArfUKb/V9k+PVOtdrR5tfGFScIVtoWdTQAQxdN8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394534; c=relaxed/simple;
	bh=OTNO7Lw4s1nhcViK5zRuy3HZ+JWEseliSCTB2yTRPGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMlN7hqgyTmPi0TNU5dGZzNegj7LVj8h+FrfKUkd5u4HKZUMncbtUcIfoLxSUaE/TV4C85C8oi4j1rXmUkrAUxffxgORZsAKHUmYgI0B03Yi0wXUvS7L7rAN6oraBrLgDCNoxFSCvnrnT7O2FvhTtEZqvMB4QJoWnBSCngE92n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiNTtH6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA91C4CEF7;
	Wed, 14 Jan 2026 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394534;
	bh=OTNO7Lw4s1nhcViK5zRuy3HZ+JWEseliSCTB2yTRPGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiNTtH6ukhBIEXNt+6y53RLp0Wp7fFsLR90u1peUlUm6A5+fZeAOzacBbtQvMHG52
	 QXTkpCRAhNfW0rddMVuA0byQiIiOPqVJ68PLUtXRTWFvPT5+A8ckFS88J/zwYHViRL
	 XxiNAeGEx7AaRECKvdqR94+Xf3u34upm2Hy+WluIt3OBaGyP7OOIwpdErC07h1+eM5
	 QIQXf9ePdh4JorDcp5O57sCo3OI57A/l1t/l22tgoWmnRsX+Y4aCmNmm7hp/2BREa3
	 HH6IlFbeKkDqwViXu28XSAhiizKjSp6k5utw6bA1Ueu8Lpc3C7TZxitn/Wg6Wq9ZId
	 mf3pPC2kBQv+A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 12/26] ACPICA: ACPI 6.4: PPTT: include all fields in subtable type1
Date: Wed, 14 Jan 2026 13:26:26 +0100
Message-ID: <1851677.VLH7GnMWUR@rafael.j.wysocki>
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

From: Ben Horgan <ben.horgan@arm.com>

In PPTT version 3 an extra field, Cache ID, was added to the Cache Type
Structure.  The struct, struct acpi_pptt_cache_v1, contains only this field. This
differs from the treatment of other versioned structures and is unexpected
for linux which reuses the actbl2.h header file. Include all the fields of
the new Cache Type Structure in struct acpi_pptt_cache_v1 and fix up all uses.

Link: https://github.com/acpica/acpica/commit/a9ec9105f552
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 617be4bd3d4a..15856ae8b1e1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2953,6 +2953,15 @@ struct acpi_pptt_cache {
 /* 1: Cache Type Structure for PPTT version 3 */
 
 struct acpi_pptt_cache_v1 {
+	struct acpi_subtable_header header;
+	u16 reserved;
+	u32 flags;
+	u32 next_level_of_cache;
+	u32 size;
+	u32 number_of_sets;
+	u8 associativity;
+	u8 attributes;
+	u16 line_size;
 	u32 cache_id;
 };
 
-- 
2.51.0





