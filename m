Return-Path: <linux-acpi+bounces-20753-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKTEDc3eemmf/AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20753-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 05:15:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E2AABA2D
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 05:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E4D43007209
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4292298CC0;
	Thu, 29 Jan 2026 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="nteRaeOV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79B2C15A0;
	Thu, 29 Jan 2026 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660087; cv=none; b=E+0e9FjnErOccGXqRbBOv4geujCMuxLo1PlzngepskudJlTD8g5ujHUg88FqBtr4LSFkr+cFq+SDJV71Qfzg7Jsgkk7nuMWyR5JMzsPE32RqZgCsB+OIaw1R0vxnhqSiGBeeh56GW/k5GWnxWU+yFYM+54eAQ2v8AtGOpRvwYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660087; c=relaxed/simple;
	bh=frWWlfqTkFBqcVJmA7sIvGoSuLa1TYzljRZKHxjTUV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HatZ6hFYanJ+ohSUe5PSB2mVyc7wxu01p7eZIFEeHWloFiESNhL8i0QCUpTTszxHb8g+9CG0viYSdIKZYBB2loAQucE+Gd9WoeXiEOcQ7lpOBdDq1NovYm0yurxAmyNr1gd67wXkQrWegKX56SczOfOGZM89SdzrghRfrV1sZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=nteRaeOV; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uEZciVNglLPo/NJy8njNxpJowXxoedjz4Gzym97YaDA=;
	b=nteRaeOVEgXoNRiDjb50tI1/DBlcZw84BajJGuFpLaqNF4qA0oaJSQtyWbhGnhdI5/zPhZWyv
	xqlmjqy3xwWPsAO6IiIu+2OrNjNIlwcmHUMO2G0Wx7f0HFkeDflAtmtMYwC6pjfKOA5bgJJCE7n
	yqtD6E3Rx8PN07JLryP8REM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f1m010c2wz12Lc6;
	Thu, 29 Jan 2026 12:10:41 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DF06940363;
	Thu, 29 Jan 2026 12:14:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 12:14:34 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 12:14:34 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/2] ACPI: processor: Remove redundant cstate check in power init
Date: Thu, 29 Jan 2026 12:14:32 +0800
Message-ID: <20260129041433.3458902-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260129041433.3458902-1-lihuisong@huawei.com>
References: <20260129041433.3458902-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20753-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:dkim,huawei.com:mid,huawei.com:email];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 55E2AABA2D
X-Rspamd-Action: no action

The function acpi_processor_cstate_first_run_checks() is responsible
for updating max_cstate and performing initial hardware validation.
Currently, this function is invoked within acpi_processor_power_init().
However, the initialization flow already ensures this is called during
acpi_processor_register_idle_driver().  Therefore, the call in
acpi_processor_power_init() is redundant and effectively performs no work.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 1f6d4060c1f2..083f85c0d530 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1432,8 +1432,6 @@ void acpi_processor_power_init(struct acpi_processor *pr)
 	if (disabled_by_idle_boot_param())
 		return;
 
-	acpi_processor_cstate_first_run_checks();
-
 	if (!acpi_processor_get_power_info(pr))
 		pr->flags.power_setup_done = 1;
 
-- 
2.33.0


