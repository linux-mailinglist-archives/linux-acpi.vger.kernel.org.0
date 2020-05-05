Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B51C56A3
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEENVr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 09:21:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728960AbgEENVr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 09:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588684906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C62A7ZX2Fzn6OxQtLQ6cG85T/2JvqNh73Sjw5wOf4Z8=;
        b=QxmYFoggaTCs8eH0/zkKtBjJTN9LPiWIhGP5+kt5D+RBv7KRos8oN8oXY+L6ihRQNVMg6e
        OZZq/Ah2iM8ilbG2QIe7C4SINHbLaTnuGgekHaRNSNb5KzjmekTh9cHRRKu5eowNKXqzMl
        6GGkCR5vgsri3CAvDfbvXGPdn/fCk6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-1qLHArz8Prq-zst2h12iQw-1; Tue, 05 May 2020 09:21:44 -0400
X-MC-Unique: 1qLHArz8Prq-zst2h12iQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E35C0107ACF6;
        Tue,  5 May 2020 13:21:42 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120236060E;
        Tue,  5 May 2020 13:21:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/3] ACPI / hotplug / PCI: Use the new acpi_evaluate_reg() helper
Date:   Tue,  5 May 2020 15:21:27 +0200
Message-Id: <20200505132128.19476-3-hdegoede@redhat.com>
In-Reply-To: <20200505132128.19476-1-hdegoede@redhat.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the new acpi_evaluate_reg() helper in the acpiphp_glue.c code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
index b3869951c0eb..fd77eb1d460c 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -385,20 +385,11 @@ static unsigned char acpiphp_max_busnr(struct pci_b=
us *bus)
 static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
 {
 	struct acpiphp_func *func;
-	union acpi_object params[2];
-	struct acpi_object_list arg_list;
=20
-	list_for_each_entry(func, &slot->funcs, sibling) {
-		arg_list.count =3D 2;
-		arg_list.pointer =3D params;
-		params[0].type =3D ACPI_TYPE_INTEGER;
-		params[0].integer.value =3D ACPI_ADR_SPACE_PCI_CONFIG;
-		params[1].type =3D ACPI_TYPE_INTEGER;
-		params[1].integer.value =3D 1;
-		/* _REG is optional, we don't care about if there is failure */
-		acpi_evaluate_object(func_to_handle(func), "_REG", &arg_list,
-				     NULL);
-	}
+	list_for_each_entry(func, &slot->funcs, sibling)
+		acpi_evaluate_reg(func_to_handle(func),
+				  ACPI_ADR_SPACE_PCI_CONFIG,
+				  ACPI_REG_CONNECT);
 }
=20
 static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_d=
ev *dev)
--=20
2.26.0

