Return-Path: <linux-acpi+bounces-14476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B9AE1BD3
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7C164CF4
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BA28B3FA;
	Fri, 20 Jun 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="HiLE34Cx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E3284662;
	Fri, 20 Jun 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425266; cv=pass; b=bdnEV+C3u4k2nq/yxhp09iNrazE7wb6kkblvvSHVsP3g5jmUFpaT9D1o7EKCLZ59u906uwD3p72ZFlzS2eDMK60Bgn9eQSyk856c8Eol30niWyuNqoyrPYalul5NrIQaXm+ta2/oVkKWt7gtljNj/o7uRCnZ2HKVxcEymSyatXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425266; c=relaxed/simple;
	bh=H5R8o0kXd66u4+i/qXbUVwWj9FSg3AdZtj4azxMfffE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyfuAvdZGhqSGkwpaAhRwdBKqGb5/i37S8ppsnRlydUHdnDNCUTLcKmI0rzLHQsiSEmqAklrT64+R3ZxNWEA3PLvqHYIaNXX/ruZCIyXraYuztuQxL+WRVoPZ4myJACIP3CYc10SV2H1CCxd0wUy81uRuJNaFadJ0Me5Xj1KR8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=HiLE34Cx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1750425204; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LtFC76nXKkFcv7Pm+hMID0+38hoRWwyfw9Hkc2V7QGmcf927r2g7WVUOBO+W/OXmvjXGgkFBgtYpFdfTSuK6sGRRo+j9MUbdodofRpSFwX/bMtCO3RC/0AWQCC4MG6AAQinSqEaDTYbo+ty6r1K5/zXAXKPL0/40SFmsWBxjN6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750425204; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ih0cPhQO9yl9dR3mzLUlHo55Ox0dnBul4xmprtM+Rl4=; 
	b=SUQ4ZyVR+J/0ALRomHqjpSmsozz3fAD3oNOrh7wM/LRSllmSgD/31q4sAyf1nROcuDtQYd0y0mrF6kAe6hRkTyjJu6sDJ/f7X8b5v5g5w4PhQTFwaexh+CHNMi4qm5nDApW5NQbqhZB64sx8b3fKfVQwOAGQRorN03eoLbolw6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750425204;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ih0cPhQO9yl9dR3mzLUlHo55Ox0dnBul4xmprtM+Rl4=;
	b=HiLE34CxnUe43B8l8dOl4GSWJyGNGs5wH44+fK9LThUUfOh9NrZw2rY62ovYWVuk
	00WAy/0HMmc6a/Z3WZzfVmVl15ZjfK6mwXYVcLSdqbBd+kj4PQ3X2M89mjsOoiVlS/9
	75OwVo07G1m4ssYC71GY3kTRHAHy998KB7PWuMn4=
Received: by mx.zohomail.com with SMTPS id 1750425202690448.1427826058292;
	Fri, 20 Jun 2025 06:13:22 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is disabled
Date: Fri, 20 Jun 2025 21:13:07 +0800
Message-ID: <20250620131309.126555-2-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620131309.126555-1-me@linux.beauty>
References: <20250620131309.126555-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

If CONFIG_ACPI_SPCR_TABLE is disabled, acpi_parse_spcr()
currently returns 0, which may incorrectly suggest that
SPCR parsing was successful. This patch changes the behavior
to return -ENODEV to clearly indicate that SPCR support
is not available.

This prepares the codebase for future changes that depend
on acpi_parse_spcr() failure detection, such as suppressing
misleading console messages.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f102c0fe34318..71e692f952905 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1503,7 +1503,7 @@ int acpi_parse_spcr(bool enable_earlycon, bool enable_console);
 #else
 static inline int acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 {
-	return 0;
+	return -ENODEV;
 }
 #endif
 
-- 
2.49.0


