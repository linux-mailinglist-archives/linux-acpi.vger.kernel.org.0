Return-Path: <linux-acpi+bounces-19228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD8C8313E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 03:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ADAD4E2E4F
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 02:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AEF7262B;
	Tue, 25 Nov 2025 02:15:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4933EC;
	Tue, 25 Nov 2025 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036952; cv=none; b=GhL60hWTD2Q+lZqjF/p9qboviRVnqFwD61SMIW+x3cfxh7a6SSw3OyIm45uxUgVxD0lvZoFKASxh1bWKS4hBetCOSogpGzrx8wNCFOWrHpKLQbVhYM4zGY+yqZHePbdHSXEa79JYm0BrbRyfOl91uecrGyoG17XTXsCn8T3btZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036952; c=relaxed/simple;
	bh=PNwY+toMSfnQFeda4NZ7g5BET4N84+MYBgnPDsBG1wM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GaMSaQt+fS7kwl4LFj2H4jtxMkJmFkNb2j7DnCTpa1JoFFM39jDHN8wjWgZwvigCzlDxWXmNqvVQ1vNpLOtxH7bBFwGG60CCECl2wuYOV4C+r7UMiTUb7KHpSeWAdBry8GCgPkGyVCUSoTsdQsNqTNMFL9SPa4T7vrAtmI6+7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202511251014351479;
        Tue, 25 Nov 2025 10:14:35 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 25 Nov 2025 10:14:34 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 25 Nov 2025 10:14:34 +0800
Received: from localhost.localdomain.com (unknown [10.94.14.191])
	by app1 (Coremail) with SMTP id YAJkCsDwKDUJESVpHhoFAA--.154S4;
	Tue, 25 Nov 2025 10:14:34 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] ACPI: LPSS: Fix a spelling mistake
Date: Tue, 25 Nov 2025 10:14:31 +0800
Message-ID: <20251125021431.2243-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwKDUJESVpHhoFAA--.154S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWkZw43CryrCr1rCw1ftFb_yoWfXrc_WF
	s7uF1xWw45Cas3ur1xAr1Y9ryYka17ZFn5Ja1SqF90vw1fXa47Jry3uws8tF13Ww1UKrW3
	Za1Dtr1UZ343ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUozVbDUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?9eQjn5RRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KYt3PVmTm0oy90frNahkriWkDgHPT+OrmMuEmQdqw17ylsY+IgCgvSkZIa5e7sFuw0RA
	ELO7OPljwsHtZRjzt00=
Content-Type: text/plain
tUid: 20251125101435c18a10a48139c8feb7e2c41388400c92
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The spelling of the word "successfull" is incorrect; it should be "successful".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/acpi/x86/lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 6daa6372f980..1dcb80ab0d23 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -181,7 +181,7 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	acpi_status status;
 	u64 uid;
 
-	/* Expected to always be successfull, but better safe then sorry */
+	/* Expected to always be successful, but better safe then sorry */
 	if (!acpi_dev_uid_to_integer(pdata->adev, &uid) && uid) {
 		/* Detect I2C bus shared with PUNIT and ignore its d3 status */
 		status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
-- 
2.43.7


