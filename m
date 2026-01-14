Return-Path: <linux-acpi+bounces-20300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCABD1EDA7
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B6E307767C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB739B499;
	Wed, 14 Jan 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+33kC8C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800C399A79;
	Wed, 14 Jan 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394517; cv=none; b=l/iCu1pI+q+GHstkoUYVNcrgv+6Rdagp8BahQCPWwfgA4nwqPAU9e1D/uobU4RmksC+9Zpbc/G5cLWzxZKP6I14atNhmu0wUc25c6U/JH6orDyaluwJteehEHfehVSvV9bIajyjAKB+7Rg+m3JKqJt0fWoPa4CiketSfeMc4cIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394517; c=relaxed/simple;
	bh=6tYFTvvd9kjBEwnncEds/jH92vDYWXEgPZCwJESo4j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+GmM/ZV5uTXzaF1t6gxAe4ekOJZ7cuT7WbLuzk+YRKa5BPYMpDLQaFYD27sPGFtszPWZiywt8L9F9EalZkE9p1w8W+mqQzoq+tCWNZDdoFEhJiwUFqTPJ8WdLWXFYDgzw2s6//k83c+BQzRBw3QlJIcRcTETZv3RyXbcNpyfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+33kC8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3101FC16AAE;
	Wed, 14 Jan 2026 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394517;
	bh=6tYFTvvd9kjBEwnncEds/jH92vDYWXEgPZCwJESo4j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+33kC8CngrLvNxhPAe2a9LaAHf6JEa+KQyDzYRucZPhSuWRsdZa2vt3Pxn15mARl
	 F9hZOCiXuvfQfB54ooKp/ab+7FWgAnMKxI3d9D9AHXmqUfxQlJGCYyefFi+6Y0e+WY
	 9eYAGc1IwZ3Gwn4yvmy05zjNx50KmQ8h0oFY1vrM2NfxT6djoiWf/dEVJX00XVjOrd
	 0AhIXrtNALAXbeb4wIuNSP04VUj0uIJQ1GWOs88TPh07omgS5wDL/Tc2djElcFlwRe
	 2jPIqjejLizSiAA/3vGhGTXphpuzQLDy3QvZ2IC5R2ETTwSPH9SmHkF3pxMSVKWJ/A
	 M122PKgLeMjzA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 17/26] ACPICA: actbl3.h: ACPI 6.6: SRAT: New flag in Memory
 Affinity Structure
Date: Wed, 14 Jan 2026 13:31:59 +0100
Message-ID: <3868802.MHq7AAxBmi@rafael.j.wysocki>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

ACPI 6.6 introduces Specific-Purpose flag to Memory Affinity structure.

Link: https://github.com/acpica/acpica/commit/cfce3b689b5e
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl3.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 79d3aa5a4bad..7ca456e88377 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -238,6 +238,7 @@ struct acpi_srat_mem_affinity {
 #define ACPI_SRAT_MEM_ENABLED       (1)	/* 00: Use affinity structure */
 #define ACPI_SRAT_MEM_HOT_PLUGGABLE (1<<1)	/* 01: Memory region is hot pluggable */
 #define ACPI_SRAT_MEM_NON_VOLATILE  (1<<2)	/* 02: Memory region is non-volatile */
+#define ACPI_SRAT_MEM_SPEC_PURPOSE  (1<<3)	/* 03: Memory is intended for specific-purpose usage */
 
 /* 2: Processor Local X2_APIC Affinity (ACPI 4.0) */
 
-- 
2.51.0





