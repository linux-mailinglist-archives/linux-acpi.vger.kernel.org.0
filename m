Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B233D34D17F
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhC2Njg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 09:39:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44240 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhC2NjK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 09:39:10 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 39bb76406e738fc6; Mon, 29 Mar 2021 15:39:09 +0200
Received: from kreacher.localnet (89-64-81-131.dynamic.chello.pl [89.64.81.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8976F66915E;
        Mon, 29 Mar 2021 15:39:08 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: scan: Fix _STA getting called on devices with unmet dependencies
Date:   Mon, 29 Mar 2021 15:39:07 +0200
Message-ID: <11743876.O9o76ZdvQC@kreacher>
In-Reply-To: <20210328112000.12502-2-hdegoede@redhat.com>
References: <20210328112000.12502-1-hdegoede@redhat.com> <20210328112000.12502-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurddufedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddufedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sunday, March 28, 2021 1:20:00 PM CEST Hans de Goede wrote:
> Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
> _DEP lists") dropped the following 2 lines from acpi_init_device_object():
> 
> 	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
> 	device->dep_unmet = 1;
> 
> Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
> causes the acpi_bus_get_status() call in acpi_add_single_object() to
> actually call _STA, even though there maybe unmet deps, leading to errors
> like these:
> 
> [    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
>                [GenericSerialBus] (20170831/evregion-166)
> [    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
>                (20170831/exfldio-299)
> [    0.123618] ACPI Error: Method parse/execution failed
>                \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)
> 
> Fix this by moving the acpi_scan_dep_init() call done for devices added
> during the second pass done by acpi_bus_scan() to inside
> acpi_add_single_object(), so that dep_unmet is properly initialized
> before the acpi_bus_get_status() call.

I wonder why the change below can't be made instead.

The behavior would be closer to the original then AFAICS.

---
 drivers/acpi/scan.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1647,6 +1647,8 @@ void acpi_init_device_object(struct acpi
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps to start with. */
+	device->dep_unmet = 1;
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1957,7 +1959,13 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_CTRL_DEPTH;
 
 	acpi_scan_init_hotplug(device);
-	if (!check_dep)
+	/*
+	 * If check_dep is true at this point, the device has no dependencies,
+	 * or the creation of the device object would have been postponed above.
+	 */
+	if (check_dep)
+		device->dep_unmet = 0;
+	else
 		acpi_scan_dep_init(device);
 
 out:



