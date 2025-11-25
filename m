Return-Path: <linux-acpi+bounces-19229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7428FC83154
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 03:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE84E21AA
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715E19B5A7;
	Tue, 25 Nov 2025 02:24:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F049659;
	Tue, 25 Nov 2025 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764037454; cv=none; b=YqGZoPHzgmPXL4+Y+lq6dtBNiwKbtik2m0oNrCCNiHjNJeK3cxB++ejhCXWse0fLvr/Ki2f7aHNJ4LNoxJYRTLHyIkKNaNsksD95EBSCCeTUy5hEW+JduqbKkCpdY6HcQlH/WSb+vQaHu6UgAEUjfEjBT0KqhnCO56QM0NrHbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764037454; c=relaxed/simple;
	bh=KR/2AGRVzal7akXtah41ASt3P61QJxnnfYDX5vvldmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N11lgQXFD1m3s0lFnTT4y82VxviM1qYMy7oJQfy6UxrA5ks341jDxMY3WaV0npN6O4/mYsJo3yqIpeEVzMIeLLrXavOfEdFkqsnMblw8iMDZORy3OgQy49sE68czb+zxUHQfK2W2GFQH7qByronCYRaIA/52Xlr01eED7eTqQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202511251024051638;
        Tue, 25 Nov 2025 10:24:05 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 25 Nov 2025 10:24:05 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 25 Nov 2025 10:24:05 +0800
Received: from localhost.localdomain.com (unknown [10.94.14.191])
	by app1 (Coremail) with SMTP id YAJkCsDw_DdFEyVpaCIFAA--.138S4;
	Tue, 25 Nov 2025 10:24:05 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] ACPI: PM: Fix a spelling mistake
Date: Tue, 25 Nov 2025 10:24:03 +0800
Message-ID: <20251125022403.2614-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDw_DdFEyVpaCIFAA--.138S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZryxurW7Ww15Gr47CFyfZwb_yoW3Zrb_u3
	WkWFs7Gr1UGr92gwnFyr93ury2yry3WFn7u3WSgFySyFy8A393AayDZr13X345Wr4jkFZx
	tFZ7Kr13ur17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?lUBtGJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KfgVwiAgHBMi9MRyPzO97y/MswGns/RYFkZrCtTOE0xa9U80N4LJB/JcYsqclFx5EeLB
	hPRdjJSmdwWvliGHyzQ=
Content-Type: text/plain
tUid: 202511251024055844109ef4302d2445f5b9255e5fd082
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The spelling of the word "interrups" is incorrect; it should be "interrupts".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/acpi/sleep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index aaf57d0aaa19..66ec81e306d4 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -642,7 +642,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/*
 	 * Disable all GPE and clear their status bits before interrupts are
 	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
-	 * prevent them from producing spurious interrups.
+	 * prevent them from producing spurious interrupts.
 	 *
 	 * acpi_leave_sleep_state() will reenable specific GPEs later.
 	 *
-- 
2.43.7


