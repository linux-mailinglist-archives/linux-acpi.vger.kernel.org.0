Return-Path: <linux-acpi+bounces-17403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E16BA8ADD
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83073189E135
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7462D372D;
	Mon, 29 Sep 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mo7Sa8Vj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B12D0C73;
	Mon, 29 Sep 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138695; cv=none; b=XTUYrznA3RRe5nppzJ/qGpLbEDcNi+Q1mStLSOWUl+twGQCINAfb05ZlFo7b+RS/cQ/xZnJaqcDDT97E16JUNJHI++omSRNgnPvei2+V3tpfEkR9OpFQzqRmcSHL1+rPsdsOIa0CPetg9g67/JYTy4X7J50go4R1UD1hSWaXtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138695; c=relaxed/simple;
	bh=NTb4lUsX61zNEVNxD0FG221KpUCdLJX8HpZVWBDUEss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXUYDOHPoEeKalQXyJ25NMRo6yKbWtSm32BRVNSfc4xWg9WPtnFtUe/jZtc87oCHsxTXxSMfCgyc4Gp9v9UKktsaeKneAQtT+gZl86Me3JOTtOFCMNOo6XEOwtYpS5xlVr2FSp8QDDtuXE0BOnLmFlgd5Bd8X+GTndo06NFQPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mo7Sa8Vj; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cZwwh6P71zJsZ1;
	Mon, 29 Sep 2025 17:33:24 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/wkyv3RCRjtymdwhCTeRUrzyllXYW8Z+rSnNo2ni7ls=;
	b=mo7Sa8VjJUlWrzrugnU5PRpySx0GlmwTUWtRqX6X03t02UveqSwLecXU2eLCfFs3vN1lH4Kla
	lczSleQC1CzBfV02dDN/JeH2igOlsQ7e/1EhRfsn8VbYxetHSOWl6er1Q26plqAwMG93Z74aLb/
	jov3Yjhg6Gt87KxUYyhW91g=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZx255hkwznTWn;
	Mon, 29 Sep 2025 17:38:05 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 750081A0188;
	Mon, 29 Sep 2025 17:37:57 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:57 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:56 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 4/9] ACPI: processor: idle: Move the initialization of state->flags to acpi_processor_setup_cstates
Date: Mon, 29 Sep 2025 17:37:49 +0800
Message-ID: <20250929093754.3998136-5-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250929093754.3998136-1-lihuisong@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The acpi_processor_setup_cpuidle_cx() is called by
acpi_processor_setup_cpuidle_dev() which is used to setup cpuidle device.
However, acpi_processor_setup_cpuidle_cx() also initializes the states
in acpi_idle_driver, which isn't good. And acpi_processor_setup_cstates()
is aimed to initializes cstates in acpi_idle_driver. So the initialization
of state->flags should be here.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f36f9514b6c7..5684925338b3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -737,13 +737,11 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 {
 	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
-	struct cpuidle_state *state;
 
 	if (max_cstate == 0)
 		max_cstate = 1;
 
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
-		state = &acpi_idle_driver.states[count];
 		cx = &pr->power.states[i];
 
 		if (!cx->valid)
@@ -751,15 +749,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 
 		per_cpu(acpi_cstate[count], dev->cpu) = cx;
 
-		if (lapic_timer_needs_broadcast(pr, cx))
-			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
-
-		if (cx->type == ACPI_STATE_C3) {
-			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
-			if (pr->flags.bm_check)
-				state->flags |= CPUIDLE_FLAG_RCU_IDLE;
-		}
-
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
 			break;
@@ -818,6 +807,15 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 		if (cx->type != ACPI_STATE_C1 && !acpi_idle_fallback_to_c1(pr))
 			state->enter_s2idle = acpi_idle_enter_s2idle;
 
+		if (lapic_timer_needs_broadcast(pr, cx))
+			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+		if (cx->type == ACPI_STATE_C3) {
+			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
+			if (pr->flags.bm_check)
+				state->flags |= CPUIDLE_FLAG_RCU_IDLE;
+		}
+
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
 			break;
-- 
2.33.0


