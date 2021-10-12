Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6E42AD4E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 21:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJLTeK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 15:34:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48364 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLTeJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 15:34:09 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id ce40f750960f5126; Tue, 12 Oct 2021 21:32:06 +0200
Received: from kreacher.localnet (unknown [213.134.187.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C861766A7F3;
        Tue, 12 Oct 2021 21:32:05 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 5/7] surface: surface3_power: Drop redundant acpi_bus_get_device() call
Date:   Tue, 12 Oct 2021 21:32:04 +0200
Message-ID: <2503491.Lt9SDvczpP@kreacher>
In-Reply-To: <3089655.5fSG56mABF@kreacher>
References: <4369779.LvFx2qVVIh@kreacher> <3089655.5fSG56mABF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.88
X-CLIENT-HOSTNAME: 213.134.187.88
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrdekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdekkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhiimhgrgihimhhilhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmghhrohhssheslhhinhhugidr
 ihhnthgvlhdrtghomhdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

If the ACPI companion of a given device is not present, the result
of the ACPI_HANDLE() evaluation for it will be NULL, so calling
acpi_bus_get_device() on ACPI_HANDLE() result in order to validate
it is redundant.

Drop the redundant acpi_bus_get_device() call from mshw0011_notify()
along with a local variable related to it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---

v1 -> v2:
   * Instead of switching over to using ACPI_COMPANION(), just drop the
     redundant acpi_bus_get_device() call from mshw0011_notify() and
     update the subject and changelog accordingly.

---
 drivers/platform/surface/surface3_power.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/platform/surface/surface3_power.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface3_power.c
+++ linux-pm/drivers/platform/surface/surface3_power.c
@@ -159,12 +159,11 @@ mshw0011_notify(struct mshw0011_data *cd
 		unsigned int *ret_value)
 {
 	union acpi_object *obj;
-	struct acpi_device *adev;
 	acpi_handle handle;
 	unsigned int i;
 
 	handle = ACPI_HANDLE(&cdata->adp1->dev);
-	if (!handle || acpi_bus_get_device(handle, &adev))
+	if (!handle)
 		return -ENODEV;
 
 	obj = acpi_evaluate_dsm_typed(handle, &mshw0011_guid, arg1, arg2, NULL,



