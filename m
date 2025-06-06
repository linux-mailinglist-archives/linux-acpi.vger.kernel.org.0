Return-Path: <linux-acpi+bounces-14187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B068ACFD83
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17E93B0E0F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B396283FFB;
	Fri,  6 Jun 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="OP47TFlE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91271276051;
	Fri,  6 Jun 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194991; cv=pass; b=KnKB2pCYzdslNpHbg5gxW7lCbWPxbslXvUNI3EA+dryLDhA0EO+6TIW+P0FNVS6D5QH2qJ+EUu0/HTg4/DeNJxQox2lMb34MyAMaJbonoPfbRIg5EeJ6vfvNvHSlYxYh/awMeXg4CuqWM3jezGm7WCHsBJgM69d+1u76HUYGK1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194991; c=relaxed/simple;
	bh=PkE9IzA6eF7lcZSRpM8TLOhOBuPn8MAenMZuqetOh5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChSVvCreh4xytucyPm4JvpH0Rt10eAQOKLxQgr9d0AKV1EPTJaU1FVau/vJv1G1RJNANAvdvd5i5Bb7bvSue8eT4UFwXRnkW51YiPSfo2bulcOb/y2Pj4Lq5xyAH2W/HaADbDHpBiPDB8ICuJuhmPTpy9hGbyU2c8cvGSAqd4y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=OP47TFlE; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1749194910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O4fbyuuLCZ/UNw4Bf88gAVG9Y3YRG4bWdKbmU5i+G+zEgvkGQQKh+8kMMEWxA3m6yb+caboaEa43RsHiIkVzl+KVqtzqfcTah5264Jv65tS/7Wft9dkxs/PAYyesKVPRxvD/nG8E+TML9ZV+poJ1UUl+PvNS3bCyCPbOuBmrL7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749194910; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=wGYCSzqgyscwX5RWcWecTBpY7TJ/S+OUK1ejoxldwXU=; 
	b=Hs73Y7n2dALRul3MN3HwO09tjg8LoOjG3OTc19Ng3eix+uB1hn12afCjNmS/oQE0Qt9ZdsYZLk+5BKiYCDAN47VELlBXptsP/vPAf9nsz/NLJ32ri8kQfdLgPK4H/8Dx6fdRCCmBm9JnXmUW1Oke0yYs0w+mWsWKGc5ZbzMK9Fs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749194909;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=wGYCSzqgyscwX5RWcWecTBpY7TJ/S+OUK1ejoxldwXU=;
	b=OP47TFlEAXWTY1X4cNQ/pA4d2f/CH0AOSaRTAq8GBT4woSe57CoswFvcr8KisNVt
	3DTkNbroEYYq1x2SkM9hJhB87Nm9rS6o7pD0uHF253ZnD3+07D0ixoN1PRpFVNEgjgm
	OapyMhcJFNx1QyOSIaQmLM9cKXcepJ/F7rGqrBdQ=
Received: by mx.zohomail.com with SMTPS id 1749194907959941.1326295181373;
	Fri, 6 Jun 2025 00:28:27 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: Suppress misleading SPCR console message when SPCR table is absent
Date: Fri,  6 Jun 2025 15:27:45 +0800
Message-ID: <20250606072802.191580-3-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606072802.191580-1-me@linux.beauty>
References: <20250606072802.191580-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

The kernel currently prints:
"Use ACPI SPCR as default console: No/Yes "

even on systems that lack an SPCR table. This can
mislead users into thinking the SPCR table exists
on the machines without SPCR.

With this change, the message is only printed if
acpi_parse_spcr() succeeds (i.e., if the SPCR table
is present and parsed). This avoids user confusion
on SPCR-less systems.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 arch/arm64/kernel/acpi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index b9a66fc146c9f..bf29e7b668f1d 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -197,6 +197,8 @@ static int __init acpi_fadt_sanity_check(void)
  */
 void __init acpi_boot_table_init(void)
 {
+	int ret;
+
 	/*
 	 * Enable ACPI instead of device tree unless
 	 * - ACPI has been disabled explicitly (acpi=off), or
@@ -250,10 +252,11 @@ void __init acpi_boot_table_init(void)
 		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
 		 * table as default serial console.
 		 */
-		acpi_parse_spcr(earlycon_acpi_spcr_enable,
+		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		pr_info("Use ACPI SPCR as default console: %s\n",
-				param_acpi_nospcr ? "No" : "Yes");
+		if (!ret)
+			pr_info("Use ACPI SPCR as default console: %s\n",
+					param_acpi_nospcr ? "No" : "Yes");
 
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
-- 
2.49.0


