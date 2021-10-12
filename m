Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20542AB36
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhJLRx0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 13:53:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46916 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhJLRxY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 13:53:24 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id bcfb80dd1b5e0b5c; Tue, 12 Oct 2021 19:51:20 +0200
Received: from kreacher.localnet (unknown [213.134.187.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A58A166A819;
        Tue, 12 Oct 2021 19:51:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v1 1/7] gpio-amdpt: ACPI: Use the ACPI_COMPANION() macro directly
Date:   Tue, 12 Oct 2021 19:44:08 +0200
Message-ID: <2179627.iZASKD2KPV@kreacher>
In-Reply-To: <4369779.LvFx2qVVIh@kreacher>
References: <4369779.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.88
X-CLIENT-HOSTNAME: 213.134.187.88
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtkedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrdekkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdekkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgv
 rhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
macro and the ACPI handle produced by the former comes from the
ACPI device object produced by the latter, so it is way more
straightforward to evaluate the latter directly instead of passing
the handle produced by the former to acpi_bus_get_device().

Modify pt_gpio_probe() accordingly (no intentional functional impact).

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/gpio/gpio-amdpt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/gpio/gpio-amdpt.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpio-amdpt.c
+++ linux-pm/drivers/gpio/gpio-amdpt.c
@@ -72,12 +72,10 @@ static void pt_gpio_free(struct gpio_chi
 static int pt_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct acpi_device *acpi_dev;
-	acpi_handle handle = ACPI_HANDLE(dev);
 	struct pt_gpio_chip *pt_gpio;
 	int ret = 0;
 
-	if (acpi_bus_get_device(handle, &acpi_dev)) {
+	if (!ACPI_COMPANION(dev)) {
 		dev_err(dev, "PT GPIO device node not found\n");
 		return -ENODEV;
 	}



