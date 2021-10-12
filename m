Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8E42AB2E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJLRxY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 13:53:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63658 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJLRxR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 13:53:17 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 0f511b32cbeb5915; Tue, 12 Oct 2021 19:51:13 +0200
Received: from kreacher.localnet (unknown [213.134.187.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1450C66A819;
        Tue, 12 Oct 2021 19:51:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 5/7] surface: surface3_power: Use ACPI_COMPANION() directly
Date:   Tue, 12 Oct 2021 19:46:47 +0200
Message-ID: <3089655.5fSG56mABF@kreacher>
In-Reply-To: <4369779.LvFx2qVVIh@kreacher>
References: <4369779.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.88
X-CLIENT-HOSTNAME: 213.134.187.88
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrdekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdekkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhgrhhoshhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgrnhes
 ghhmrghilhdrtghomhdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
macro and the ACPI handle produced by the former comes from the
ACPI device object produced by the latter, so it is way more
straightforward to evaluate the latter directly instead of passing
the handle produced by the former to acpi_bus_get_device().

Modify mshw0011_notify() accordingly (no intentional functional
impact).

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/platform/surface/surface3_power.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/platform/surface/surface3_power.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface3_power.c
+++ linux-pm/drivers/platform/surface/surface3_power.c
@@ -160,15 +160,14 @@ mshw0011_notify(struct mshw0011_data *cd
 {
 	union acpi_object *obj;
 	struct acpi_device *adev;
-	acpi_handle handle;
 	unsigned int i;
 
-	handle = ACPI_HANDLE(&cdata->adp1->dev);
-	if (!handle || acpi_bus_get_device(handle, &adev))
+	adev = ACPI_COMPANION(&cdata->adp1->dev);
+	if (!adev)
 		return -ENODEV;
 
-	obj = acpi_evaluate_dsm_typed(handle, &mshw0011_guid, arg1, arg2, NULL,
-				      ACPI_TYPE_BUFFER);
+	obj = acpi_evaluate_dsm_typed(adev->handle, &mshw0011_guid, arg1, arg2,
+				      NULL, ACPI_TYPE_BUFFER);
 	if (!obj) {
 		dev_err(&cdata->adp1->dev, "device _DSM execution failed\n");
 		return -ENODEV;



