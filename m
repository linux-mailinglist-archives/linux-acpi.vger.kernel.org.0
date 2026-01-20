Return-Path: <linux-acpi+bounces-20447-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2INACckwcGkSXAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20447-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 02:50:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 899464F592
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6C6E5E78C5
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6442314F;
	Tue, 20 Jan 2026 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="GwdeRM5O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8E423147;
	Tue, 20 Jan 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908192; cv=none; b=pN4oFfBUHGgoawluCrZG4H8qpo8aOZmpggiE5rznneu30seddnPigi5Co2xpTNCsJHBp1/0C3HrOdslUb+/FsD5I+wCWongUKFpPMdOfEruUIw4QFyYSSsSUpscYXIhZzhGDw32q3VY3ieVRCM4y8eOlt9J4eVmQGZ/kXfWJht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908192; c=relaxed/simple;
	bh=PzT+QO0kJ9zYvI5hNi18tO9yvBDSw0oQQ2MtF4UCYdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp+SnLtcBdEl7GI241dGqHVpKpV1Pdsd4kvx1YAsliHnYPFnjOqsMLAfmr3oLNytBGeh5Lyy6bJceY20g3/YqV/a6KGI8A2dqOwfHioQ22GN9TX3dWcC3Zy45Umdodbfm0sO/KIzgqtSjW715qB+6N10g0CmDF1Y3HZ2nDYQYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=GwdeRM5O; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3s7cqoF1GXsTSogLy+zL5S3zwezjc3g5MkRqQadZ/so=;
	b=GwdeRM5O3+EPiYKOYHoK+yMBTHDJwQ/1Md+gDYzJ0sPAGPLmNpSnKA3CcSwEF4AmGDrDT0qin
	4FdHlXrsY/I5kieGgZrN7Zjxp8NatVMYT/J48TqCf9Esbl7m12b+iWXbVYzrbncFebp8UrlnLD4
	Fn3TnvdvU7DBH9UA0pcHD+4=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dwPx615qvz1cySb;
	Tue, 20 Jan 2026 19:19:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id DD52C40539;
	Tue, 20 Jan 2026 19:23:00 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:23:00 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 19:23:00 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 3/3] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
Date: Tue, 20 Jan 2026 19:22:58 +0800
Message-ID: <20260120112258.1595164-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260120112258.1595164-1-lihuisong@huawei.com>
References: <20260120112258.1595164-1-lihuisong@huawei.com>
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
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : No valid SPF, DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20447-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email,huawei.com:mid];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 899464F592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The platform used LPI need check if the LPI support and the entry
method is valid by the acpi_processor_ffh_lpi_probe(). But the return
of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
isn't verified by any caller.

What's more, acpi_processor_get_power_info() is a more logical place for
verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev().
So move acpi_processor_ffh_lpi_probe() from the latter to the former and
verify its return.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ba4cde028b0e..4b2c740da86f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1237,7 +1237,7 @@ static void acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 }
 
 /**
- * acpi_processor_setup_cpuidle_dev - prepares and configures CPUIDLE
+ * acpi_processor_setup_cpuidle_dev - configures CPUIDLE
  * device i.e. per-cpu data
  *
  * @pr: the ACPI processor
@@ -1250,12 +1250,8 @@ static void acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
 		return;
 
 	dev->cpu = pr->id;
-	if (pr->flags.has_lpi) {
-		acpi_processor_ffh_lpi_probe(pr->id);
-		return;
-	}
-
-	acpi_processor_setup_cpuidle_cx(pr, dev);
+	if (!pr->flags.has_lpi)
+		acpi_processor_setup_cpuidle_cx(pr, dev);
 }
 
 static int acpi_processor_get_power_info(struct acpi_processor *pr)
@@ -1264,7 +1260,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 
 	ret = acpi_processor_get_lpi_info(pr);
 	if (ret)
-		ret = acpi_processor_get_cstate_info(pr);
+		return acpi_processor_get_cstate_info(pr);
+
+	if (pr->flags.has_lpi) {
+		ret = acpi_processor_ffh_lpi_probe(pr->id);
+		if (ret)
+			pr_err("Processor FFH LPI state is invalid.\n");
+	}
 
 	return ret;
 }
-- 
2.33.0


