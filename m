Return-Path: <linux-acpi+bounces-1414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97AC7E83D1
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 21:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A18AB20BB0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 20:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5A3B791
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395238DC1
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 19:45:31 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003FB6A48;
	Fri, 10 Nov 2023 11:45:24 -0800 (PST)
Received: from [10.28.138.149] (port=40524 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1r1XRP-0007NN-6C; Fri, 10 Nov 2023 22:45:20 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1102.mail.hosting.nic.ru (Exim 5.55)
	with id 1r1XRP-00H8mB-2j;
	Fri, 10 Nov 2023 22:45:19 +0300
Message-ID: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
Date: Fri, 10 Nov 2023 22:45:19 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPI: OSL: Initialize output value
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>,
 Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Buffer variable for result (value32) is not initialized.
This can lead to unexpected behavior, if underlying platform-specific
raw_pci_read fails to report error (uninitialized value will be treated
as valid pci-read result), or exposition of unexpected data to PCI 
config space reader.

Zeroing of buffer value addresses the later problem and makes the 
behavior in the former case somewhat more predictable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c5f0231ee6b0 ("ACPICA: Fix acpi_os_read_pci_configuration prototype")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/osl.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c09cc3c68633..d3c0f7f01a29 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -788,7 +788,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id 
*pci_id, u32 reg,
  			       u64 *value, u32 width)
  {
  	int result, size;
-	u32 value32;
+	u32 value32 = 0U;
   	if (!value)
  		return AE_BAD_PARAMETER;
-- 
2.34.1


