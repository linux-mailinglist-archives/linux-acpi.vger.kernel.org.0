Return-Path: <linux-acpi+bounces-16393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E5B45127
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 10:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8C6540E2A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F023043CE;
	Fri,  5 Sep 2025 08:19:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3482301488;
	Fri,  5 Sep 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060353; cv=none; b=cEDvmZJ0JlTaocJL40pPBri44YSF+TSmlF4SGBTXZRuHdtU9maSP1CYM2Ej7S5hXpG3DEnvYXSvpQ+QR4egrZmhMx6552t85cubC9MCBOjzDaopl82qc8CLD3574W0ZbHs75NgRjZVqcYvF0wJWQumuasRAcojqLP+bozrDvTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060353; c=relaxed/simple;
	bh=7miSWgnG8UrDriLWjuLtnCeX0nVUoyuHZuBm3OomKmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQvOqNVYN6ldEoSFmURif2XpnmLdS9kBjbrDGKwjX/kithW4jh8mND++0hz3g+5USkHSEmpu6U5oN+Ecj3vmz1da7h4Lih5/4y60GUYM5u8tu1VhkQ79tS6muNwEvDvMKudMUzA8+LKCcZBFM5Ezr3NqSN1BjKub+FEm6avsxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cJ8KT1RLQz13NPd;
	Fri,  5 Sep 2025 16:15:09 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 167A8140147;
	Fri,  5 Sep 2025 16:19:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:19:02 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:19:02 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 3/3] ACPI: processor: Fix acpi_processor_ffh_lpi_xxx() declaration
Date: Fri, 5 Sep 2025 16:19:00 +0800
Message-ID: <20250905081900.663869-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250905081900.663869-1-lihuisong@huawei.com>
References: <20250905081900.663869-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

To unify the place of function declaration of processor_idle.c, move
acpi_processor_ffh_lpi_probe and acpi_processor_ffh_lpi_enter to one
place. And remove 'extern' key word in declaration by the way.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 include/acpi/processor.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d6a87dc42a9a..34d6ecfece39 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -425,6 +425,8 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
 void acpi_processor_register_idle_driver(void);
 void acpi_processor_unregister_idle_driver(void);
+int acpi_processor_ffh_lpi_probe(unsigned int cpu);
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
@@ -447,11 +449,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 }
 #endif	/* CONFIG_CPU_FREQ */
 
-#ifdef CONFIG_ACPI_PROCESSOR_IDLE
-extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
-extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
-#endif
-
 void acpi_processor_init_invariance_cppc(void);
 
 #endif
-- 
2.33.0


