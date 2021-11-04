Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE3445BDA
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhKDV47 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 17:56:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63504 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKDV46 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Nov 2021 17:56:58 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 85590c0a1e8a073d; Thu, 4 Nov 2021 22:54:19 +0100
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 62E01663077;
        Thu,  4 Nov 2021 22:54:18 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: PM: Fix device wakeup power reference counting error
Date:   Thu, 04 Nov 2021 22:54:17 +0100
Message-ID: <11862743.O9o76ZdvQC@kreacher>
In-Reply-To: <2606454.mvXUDI8C0e@kreacher>
References: <2606454.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggddugeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, November 4, 2021 6:21:51 PM CET Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fix a device wakeup power reference counting error introduced by
> commit a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power
> resources").
> 
> Fixes: a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power resources")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/power.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/acpi/power.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/power.c
> +++ linux-pm/drivers/acpi/power.c
> @@ -757,10 +757,8 @@ int acpi_disable_wakeup_device_power(str
>  
>  	mutex_lock(&acpi_device_lock);
>  
> -	if (dev->wakeup.prepare_count > 1) {
> +	if (dev->wakeup.prepare_count >= 1)
>  		dev->wakeup.prepare_count--;
> -		goto out;
> -	}
>  
>  	/* Do nothing if wakeup power has not been enabled for this device. */
>  	if (!dev->wakeup.prepare_count)

This is still not good.  It should be something like the patch below, but I
need to test that one.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] ACPI: PM: Fix device wakeup power reference counting error

Fix a device wakeup power reference counting error introduced by
commit a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power
resources").

Fixes: a2d7b2e004af ("ACPI: PM: Fix sharing of wakeup power resources")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Actually disable wakeup power when the reference count becomes zero.

---
 drivers/acpi/power.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -757,13 +757,11 @@ int acpi_disable_wakeup_device_power(str
 
 	mutex_lock(&acpi_device_lock);
 
-	if (dev->wakeup.prepare_count > 1) {
-		dev->wakeup.prepare_count--;
+	/* Do nothing if wakeup power has not been enabled for this device. */
+	if (dev->wakeup.prepare_count <= 0)
 		goto out;
-	}
 
-	/* Do nothing if wakeup power has not been enabled for this device. */
-	if (!dev->wakeup.prepare_count)
+	if (--dev->wakeup.prepare_count > 0)
 		goto out;
 
 	err = acpi_device_sleep_wake(dev, 0, 0, 0);




