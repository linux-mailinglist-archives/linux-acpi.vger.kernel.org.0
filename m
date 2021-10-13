Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEE42C60A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhJMQSp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 12:18:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63068 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhJMQSk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 12:18:40 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 7be1e79e199bd7e8; Wed, 13 Oct 2021 18:16:35 +0200
Received: from kreacher.localnet (unknown [213.134.161.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AD8B166A871;
        Wed, 13 Oct 2021 18:16:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 4/7] surface: surface3-wmi: Use ACPI_COMPANION() directly
Date:   Wed, 13 Oct 2021 18:10:55 +0200
Message-ID: <12896717.uLZWGnKmhe@kreacher>
In-Reply-To: <3414042.iIbC2pHGDl@kreacher>
References: <4369779.LvFx2qVVIh@kreacher> <3414042.iIbC2pHGDl@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.244
X-CLIENT-HOSTNAME: 213.134.161.244
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddutddgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudeiuddrvdeggeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedurddvgeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmghhrohhssheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehluhiimhgrgihimhhilhhirghn
 sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
macro and the ACPI handle produced by the former comes from the
ACPI device object produced by the latter, so it is way more
straightforward to evaluate the latter directly instead of passing
the handle produced by the former to acpi_bus_get_device().

Modify s3_wmi_check_platform_device() accordingly (no intentional
functional impact).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
---

v1 -> v2:
   * Resend with a different From and S-o-b address and with R-by from
     Maximilian.  No other changes.

---
 drivers/platform/surface/surface3-wmi.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/platform/surface/surface3-wmi.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface3-wmi.c
+++ linux-pm/drivers/platform/surface/surface3-wmi.c
@@ -139,13 +139,12 @@ static acpi_status s3_wmi_attach_spi_dev
 
 static int s3_wmi_check_platform_device(struct device *dev, void *data)
 {
-	struct acpi_device *adev, *ts_adev = NULL;
-	acpi_handle handle;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *ts_adev = NULL;
 	acpi_status status;
 
 	/* ignore non ACPI devices */
-	handle = ACPI_HANDLE(dev);
-	if (!handle || acpi_bus_get_device(handle, &adev))
+	if (!adev)
 		return 0;
 
 	/* check for LID ACPI switch */
@@ -159,7 +158,7 @@ static int s3_wmi_check_platform_device(
 	    strlen(SPI_CTL_OBJ_NAME)))
 		return 0;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, adev->handle, 1,
 				     s3_wmi_attach_spi_device, NULL,
 				     &ts_adev, NULL);
 	if (ACPI_FAILURE(status))



