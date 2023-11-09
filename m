Return-Path: <linux-acpi+bounces-1389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C727B7E6C71
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648171F213BC
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66E200B8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D61E529
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 14:01:45 +0000 (UTC)
X-Greylist: delayed 733 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 06:01:44 PST
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35D2D77
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 06:01:44 -0800 (PST)
Received: from [10.28.138.148] (port=33836 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1r15PS-0005CE-BH; Thu, 09 Nov 2023 16:49:26 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1r15PS-00E7MJ-1K;
	Thu, 09 Nov 2023 16:49:26 +0300
Message-ID: <262a7526-9e0a-4688-85b4-8546a6580ad0@ancud.ru>
Date: Thu, 9 Nov 2023 16:49:25 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPI: video: check for error while searching for backlit
 device parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

If acpi_get_parent called in acpi_video_dev_register_backlight fails
(for example, acpi_ut_acquire_mutex fails inside acpi_get_parent),
this can lead to incorrect (uninitialized) acpi_parent handler being
passed to acpi_get_pci_dev for detecting parent pci device.

Check acpi_get_parent result and set parent device only in case of success.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9661e92c10a9 ("acpi: tie ACPI backlight devices to PCI devices if 
possible")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/acpi_video.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0b7a01f38b65..1d550887349a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1717,12 +1717,12 @@ static void 
acpi_video_dev_register_backlight(struct acpi_video_device *device)
  		return;
  	count++;
  -	acpi_get_parent(device->dev->handle, &acpi_parent);
-
-	pdev = acpi_get_pci_dev(acpi_parent);
-	if (pdev) {
-		parent = &pdev->dev;
-		pci_dev_put(pdev);
+	if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
+		pdev = acpi_get_pci_dev(acpi_parent);
+		if (pdev) {
+			parent = &pdev->dev;
+			pci_dev_put(pdev);
+		}
  	}
   	memset(&props, 0, sizeof(struct backlight_properties));
-- 
2.34.1


