Return-Path: <linux-acpi+bounces-1390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309F7E719B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1255B20C5C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24936AF5
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A920B14
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 18:09:08 +0000 (UTC)
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC0CE;
	Thu,  9 Nov 2023 10:09:07 -0800 (PST)
Received: from [10.28.138.151] (port=11776 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1r19Sf-00020H-DZ; Thu, 09 Nov 2023 21:09:01 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1103.mail.hosting.nic.ru (Exim 5.55)
	with id 1r19Sf-001rie-0S;
	Thu, 09 Nov 2023 21:09:01 +0300
Message-ID: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
Date: Thu, 9 Nov 2023 21:08:59 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

In lpit_update_residency there is a possibility of overflow
in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).

Change multiplication to mul_u32_u32.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) support")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/acpi_lpit.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index c5598b6d5db8..794962c5c88e 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -105,7 +105,7 @@ static void lpit_update_residency(struct 
lpit_residency_info *info,
  		return;
   	info->frequency = lpit_native->counter_frequency ?
-				lpit_native->counter_frequency : tsc_khz * 1000;
+				lpit_native->counter_frequency : mul_u32_u32(tsc_khz, 1000U);
  	if (!info->frequency)
  		info->frequency = 1;
  -- 2.34.1


