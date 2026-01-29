Return-Path: <linux-acpi+bounces-20752-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP55OLfeemmf/AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20752-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 05:14:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8CABA18
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 05:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72C69300461A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D622C3248;
	Thu, 29 Jan 2026 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Y2WTxmyJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716E7478;
	Thu, 29 Jan 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660080; cv=none; b=FtJWZQ8wazkfLjkWlLKy0cOIu+GDJYWRwefeRGn7aoDKLwviBuciTT5C5Cqw5hvcWFe/suOUtkBDRPsVbbteHrvbcta/z23Fa+jUXTz8Tfh1+q/nIrjS4vvrgpaRUtuBLeBpQkI6lRSiGChg8lJ9nbXsZw3ycFzrjo5JmhDUkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660080; c=relaxed/simple;
	bh=E6q2/VrZ9ELAnn5GuCJm5IUTLz7o1aAFQFjxdzw5usI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa9PYjFY5Z+vTsAbhl/CYL0QhIPs8UxBVBrQQSKWO+s0HMmb1nySCqomPkEiB8TfTIvY/pXLjaGeVAU63RynXQYbkOi4xf8ETGWQy1v1e5eZYwC/EU0ArfOXCaqtIQ8qfraGIguZ8RUaFEhI9hY3c6sSH1Ndpldt1gj9Ylv0xEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Y2WTxmyJ; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ktQ1ErrXJLweZ2VUDJa/pKteFm448tMGx38WMYAYBKs=;
	b=Y2WTxmyJKeKJsRJtykoefInTdHg5HLNx1x+cP55C/Z5PLfSXyc0gsf3ojk1K0tPYm/rF1vcoz
	CrMkl7A4a7PKyJG6aiehl+Ge3WFbX7W8HMB16GDeG0991XKlT34FeiNIhypQtk3ay06fObK990U
	A22bOddnRmugJhV0q4eR7lI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f1m0W3pGFzLlSZ;
	Thu, 29 Jan 2026 12:11:07 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 55D5B40561;
	Thu, 29 Jan 2026 12:14:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 12:14:35 +0800
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
Subject: [PATCH 2/2] ACPI: processor: Remove redundant static variable and rename cstate check function
Date: Thu, 29 Jan 2026 12:14:33 +0800
Message-ID: <20260129041433.3458902-3-lihuisong@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20752-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:dkim,huawei.com:mid,huawei.com:email];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13E8CABA18
X-Rspamd-Action: no action

The function acpi_processor_cstate_first_run_checks() is currently called
only once during initialization in acpi_processor_register_idle_driver().
Because its execution is already limited by the caller's lifecycle, the
internal static 'first_run' variable is redundant and can be safely
removed.  Additionally, the current function name is no longer descriptive
of its behavior.  Rename the function to acpi_processor_update_max_cstate()
to better reflect its actual purpose.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 083f85c0d530..35b55081bc10 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -819,19 +819,13 @@ static void acpi_processor_setup_cstates(struct acpi_processor *pr)
 	drv->state_count = count;
 }
 
-static inline void acpi_processor_cstate_first_run_checks(void)
+static inline void acpi_processor_update_max_cstate(void)
 {
-	static int first_run;
-
-	if (first_run)
-		return;
 	dmi_check_system(processor_power_dmi_table);
 	max_cstate = acpi_processor_cstate_check(max_cstate);
 	if (max_cstate < ACPI_C_STATES_MAX)
 		pr_notice("processor limited to max C-state %d\n", max_cstate);
 
-	first_run++;
-
 	if (nocst)
 		return;
 
@@ -840,7 +834,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 #else
 
 static inline int disabled_by_idle_boot_param(void) { return 0; }
-static inline void acpi_processor_cstate_first_run_checks(void) { }
+static inline void acpi_processor_update_max_cstate(void) { }
 static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 {
 	return -ENODEV;
@@ -1391,7 +1385,7 @@ void acpi_processor_register_idle_driver(void)
 		if (!pr)
 			continue;
 
-		acpi_processor_cstate_first_run_checks();
+		acpi_processor_update_max_cstate();
 		ret = acpi_processor_get_power_info(pr);
 		if (!ret) {
 			pr->flags.power_setup_done = 1;
-- 
2.33.0


