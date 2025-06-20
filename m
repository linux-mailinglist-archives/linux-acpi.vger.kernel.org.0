Return-Path: <linux-acpi+bounces-14477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E2BAE1BCF
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6DC7ADDC2
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857D28BA9B;
	Fri, 20 Jun 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="UHG+C+w5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C795284662;
	Fri, 20 Jun 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425297; cv=pass; b=WSEAs/SACbBy8kTVVpEz2VPM0kSnNnTygx20SCCZ4Jp4u2dBjti1Ge49QTO7rIjfdrF8jGepqGPN48HQHfTepSbo/XsMiX8FfhRA3gLsUGgr66T6njyhZzWFbfMojWGonoGWLmU2y8Pb/QyGUQT7mNfjxoDqBPgPranMx8gwwdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425297; c=relaxed/simple;
	bh=JoqxZK5kKb3iGbF2HT2J3CanHyR4uWwtcC9OwzKn6kc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txTRXLCIlvfxTOStZZqxCshmU5QE15rbrk26JAdBAYXGwk13YXBaTHjBMj5CzAF8BXqcAbCWtDURq7Oc+SKi7wDilLh6qXvVmjw/rVg3rgAIMoB8FaCZ5ZXAvJTqnrKFeePM6TrwleyoLNMEz+b15pqbp+abRyClH68VKrKChcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=UHG+C+w5; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1750425208; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MNHPccnBs+XXqy/H38CYDXt+t1su8buoNkN2GLnJ8NF2v6G5p0nuG1vsO8RTsKLekpEN7rZNa5trxFxAQtJT3OjRBJm6GlSLsqctO+WIVxIBvzKqQ+QsjFOPnL0YY4LyBj/eGU8hPQdnYdw17FKpX/UiJky6R06GOtijle5FtE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750425208; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=P6KhJbmkVl7HuIV2HXHuYKvcE/VNTXSLGZUIxgNMypM=; 
	b=dcciD0HGu+lRgum+Jz0u5+lLYqFY7J9aZuIz2meefUVjEpWYo15ETJY3tyFKW19Fjtw60EUiGh607t7r/gMw6djQvez0GicvceRzprUCOXh+JbqPKPvXwJ2qCnsS+5VHYf01RMC6doPNEIJIa0bFKSRy0doEl9bSQiZpT/ZtLJk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750425208;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=P6KhJbmkVl7HuIV2HXHuYKvcE/VNTXSLGZUIxgNMypM=;
	b=UHG+C+w5Z4XSdDUJVC9HC7AjqBnOLQM2EiYpIDGXBLWk4SobNmSn+oBinQroOL53
	/A7e0coeFgopow0/dHxl1Akf1dKGiyQOJcrkw8Jfb63haR/o6tLZceApq/W7RJKHIz4
	vPEzqPZflBieXhzKF8RZAoVoa91hOKZhZZETC5vU=
Received: by mx.zohomail.com with SMTPS id 17504252076891004.916800415434;
	Fri, 20 Jun 2025 06:13:27 -0700 (PDT)
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
	linux-acpi@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Li Chen <chenl311@chinatelecom.cn>
Subject: [PATCH v2 2/2] ACPI: Suppress misleading SPCR console message when SPCR table is absent
Date: Fri, 20 Jun 2025 21:13:08 +0800
Message-ID: <20250620131309.126555-3-me@linux.beauty>
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

The kernel currently alway prints:
"Use ACPI SPCR as default console: No/Yes "

even on systems that lack an SPCR table. This can
mislead users into thinking the SPCR table exists
on the machines without SPCR.

With this change, the "Yes" is only printed if
the SPCR table is present, parsed and !param_acpi_nospcr.
This avoids user confusion on SPCR-less systems.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
changelog:
v2: refine the printk message logic as suggested by Hanjun Guo.

 arch/arm64/kernel/acpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index b9a66fc146c9f..4d529ff7ba513 100644
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
@@ -250,10 +252,12 @@ void __init acpi_boot_table_init(void)
 		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
 		 * table as default serial console.
 		 */
-		acpi_parse_spcr(earlycon_acpi_spcr_enable,
+		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		pr_info("Use ACPI SPCR as default console: %s\n",
-				param_acpi_nospcr ? "No" : "Yes");
+		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
+			pr_info("Use ACPI SPCR as default console: No\n");
+		else
+			pr_info("Use ACPI SPCR as default console: Yes\n");
 
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
-- 
2.49.0


