Return-Path: <linux-acpi+bounces-12203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB3A5F9DD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BD07AB810
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F31269820;
	Thu, 13 Mar 2025 15:29:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0C267F4F;
	Thu, 13 Mar 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879759; cv=none; b=b9oUlH7RtMqXt7zMc79PKvaRaMzTVwJcd4zrCKhwLxNqNH5iPwIGwwUw/hqi2mNHlRf76swnllHfHafUL7+NB/prCTjYeZet4FkFQWjyWC9WFJCvO46NJ76WcwyhSLEL2hTUl5noWfZ4tH1ZxLJGoMKN5y8VyMA+O9MTZxGhukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879759; c=relaxed/simple;
	bh=3ZwsMl0pgl+y8ZnbR+YoOttJ0rCuNXNsiO6IGFcuJRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgePFMUG7+K5mpKLu8x44177IEK/E/VTqMrjosPJM5OJ1iQuLIeLgwYvLRkhApX33LonOV2XlUgcggJnMk3hmRF/NT7va1mM5qMYIFMBU4H+5RIIboaCJJY87ZPM/oSd1o8HDaaxz3eksrWbF9WrfirQX1+j6h6HUjNq1H4C3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED7B1516;
	Thu, 13 Mar 2025 08:29:27 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394F23F694;
	Thu, 13 Mar 2025 08:29:16 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:50 +0000
Subject: [PATCH v3 04/13] mailbox: pcc: Return early if no GAS register
 from pcc_mbox_cmd_complete_check
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-4-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=3ZwsMl0pgl+y8ZnbR+YoOttJ0rCuNXNsiO6IGFcuJRU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnEmDNJPNaozKa092u5uXkRHi5LaWrlvYKW2
 4BLdaHznrKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mHZYD/oDNIiIkLk5rhaoMs5PbiGy0XpVThEY1aTHsOlyOR6TrB7nBf8qjIvRi+SxtYzd41EzxKr
 2Psx7fAjPsOhMBfFgXPWCeC9PE/sZdVDJP1YgOJz+Jbj6DjySb0N5YlmFJX0mDibxUUVbFE/iq0
 sMz4EC1KFHq3j9MetkP4/aX0NDyPKeleFIPCb5e8kcPztjv76fiPk7Mh/rBfac58INJlXLiG3n0
 cvHZ+J1O+NaM9l5tTc/cLQfWoth7g/mQdjABiFo7jzLPzbsltFcCrI0B6ClAK3VAzLpvUEBPPMN
 NZlRALtEAJwTYJCRf5Y9qZEGkVYIbbqWZwS0jyvf+dQ551r0RY6h+BgAA5tzTwj3Sy0bOm+VAoR
 Ii8nG2t9iHI8jPgIrMiQ0gMd1mz8FwbJSl0RNhMNwelIILj6TdSFLuYJMtSLRKq9NJ/sQEeFZxu
 ovmRDWlVqPxhJY+oxFpPWMgRCacwzmWCx0mmie8Hr4YMMy1u7CTeRJV4ZOaVVxNVOBAk7lGwunu
 VnDQsEZAiaWHPIIqvcJDt5VyWRCkp8z859waeUy809GmQjQYtxA8sOX+qgepNubB9gbJ6iRvBrQ
 4O1hhz2nVuJ3J0DFgJ+HPNl9IZMjfugwu4fzBvkQM+TimIl6i35EvcUiF+S4sdnckpzNfcSqwi2
 PyNmD0AD/in7SiA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

pcc_mbox_cmd_complete_check() accesses pchan->cmd_complete.gas to check
command completion status. Even if GAS is NULL, pcc_chan_reg_read() gets
called which returns success doing nothing and then we return.

Add an early return if pchan->cmd_complete.gas == NULL before performing
any operations.

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 9cf0ca772c1adb73ceb91d25a2abd1d12c678d90..7105dd6bc2fc6b8d36cb62f7ecd1b578361f89b6 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -245,13 +245,13 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	u64 val;
 	int ret;
 
+	if (!pchan->cmd_complete.gas)
+		return true;
+
 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
 	if (ret)
 		return false;
 
-	if (!pchan->cmd_complete.gas)
-		return true;
-
 	/*
 	 * Judge if the channel respond the interrupt based on the value of
 	 * command complete.

-- 
2.34.1


