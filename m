Return-Path: <linux-acpi+bounces-18390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B930C234EF
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 06:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03AD84E31F5
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECDA29AAEA;
	Fri, 31 Oct 2025 05:53:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240028C854;
	Fri, 31 Oct 2025 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890029; cv=none; b=EljH8g1YbIHvV2MGCVLkuw2OO71lwDvrc4iFk8lEyvHBqd4uFyDM2ZV1c3SQdSwhyFeUZvs2KD6Fcdccr9xXGBEGiyR0N+O4kpt3bBMPJ6WmattkQjjOzRXmDF8LXzqClzLtlGRbl/K0wd9a436u/7UVrplkCdvtbWr4ktUqk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890029; c=relaxed/simple;
	bh=eaRIVQgynbj6uU7XhSXun0qtbjx9gLDY6bCGnkT3/sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SFS/f6KTZC+fsxLIwxWjWke4xmlFvnFQAIMhNCCueXWaXpjdokfle2vWqMS2j8WoVsk1h+yqoFSh30X91ib1hbGHFR02Hh88upactpYpr3JICTJSuk6KdbiBu1mQWFLXL0pJ9kTLA3jPhaGznWFOrNRFJSVz0Kn5ny/MLs+ggNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510311353399875;
        Fri, 31 Oct 2025 13:53:39 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 31 Oct 2025 13:53:38 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 31 Oct 2025 13:53:38 +0800
Received: from localhost.com (unknown [10.94.18.144])
	by app1 (Coremail) with SMTP id YAJkCsDwEnbhTgRpkOY5AA--.2627S4;
	Fri, 31 Oct 2025 13:53:38 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] ACPI: CPPC: Fix a typo error
Date: Fri, 31 Oct 2025 13:52:40 +0800
Message-ID: <20251031055240.2791-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwEnbhTgRpkOY5AA--.2627S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4UWw4DWF1kGF17JFWkWFg_yoW3Gwc_CF
	yxXF1IqrWvyr1kt3W7GrWa9rWayw17uF4rAFZaqFy3Cr18XFW5XFyq9wn3XrWUGFy0g3Wq
	vw1Fqr18ur1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?QlHvl5RRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KR0Drn8FO8/5oyKXUg3GQFMvprDKO9EzsCTVpfORBaeF5GSdBd1bx+Cqml6uzF55m6Sd
	Zq4rKE2MxN2UmPCFOWI=
Content-Type: text/plain
tUid: 202510311353391b1a8abd065f8875cdcd3874f909f1a8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The correct term here should be "package"

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab4651205e8a..6c684e54fe01 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -750,7 +750,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 
 	/*
-	 * Disregard _CPC if the number of entries in the return pachage is not
+	 * Disregard _CPC if the number of entries in the return package is not
 	 * as expected, but support future revisions being proper supersets of
 	 * the v3 and only causing more entries to be returned by _CPC.
 	 */
-- 
2.43.7


