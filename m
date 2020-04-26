Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B21B8F0C
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDZKr1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 06:47:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbgDZKr1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 Apr 2020 06:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rR1VWAX5n/MzP2zWX8Dox7ig/TvsvH/ThCSY7sIXksw=;
        b=cO16BoF/DtP0qwtMropNdth8UtneFMXS6ZfMGz3X0mCZjLe0+uClp1NLBHKiTpJm4MHZqP
        Ir6yd7Xbchwt3juLpEs4MXA/bKAzQvA5ZcSnYNuMk8P6+NCU0/kKMPuD00WrRXJOEnGkxx
        Z1D76X3s5eiKv3vvh8YRqlnQkvNBt5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-oY_6SS6PNzqWjCWyv53M5A-1; Sun, 26 Apr 2020 06:47:21 -0400
X-MC-Unique: oY_6SS6PNzqWjCWyv53M5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C11107ACCA;
        Sun, 26 Apr 2020 10:47:19 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2356E5D716;
        Sun, 26 Apr 2020 10:47:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: i2c-multi-instantiate: Add flag for passing fwnode
Date:   Sun, 26 Apr 2020 12:47:12 +0200
Message-Id: <20200426104713.216896-2-hdegoede@redhat.com>
In-Reply-To: <20200426104713.216896-1-hdegoede@redhat.com>
References: <20200426104713.216896-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In some cases the driver for the i2c_client-s which i2c-multi-instantiate
instantiates may need access some fields / methods from to the ACPI fwnod=
e
for which i2c_clients are being instantiated.

An example of this are CPLM3218 ACPI device-s. These contain CPM0 and
CPM1 packages with various information (e.g. register init values) which
the driver needs.

Passing the fwnode through the i2c_board_info struct also gives the
i2c-core access to it, and if we do not pass an IRQ then the i2c-core
will use the fwnode to get an IRQ, see i2c_acpi_get_irq().

This is a problem when there is only an IRQ for 1 of the clients describe=
d
in the ACPI device we are instantiating clients for. If we unconditionall=
y
pass the fwnode, then i2c_acpi_get_irq() will assign the same IRQ to all
clients instantiated, leading to kernel-oopses like this (BSG1160 device)=
:

[   27.340557] genirq: Flags mismatch irq 76. 00002001 (bmc150_magn_event=
) vs. 00000001 (bmc150_accel_event)
[   27.340567] Call Trace:
...

So we cannot simply always pass the fwnode. This commit adds a PASS_FWNOD=
E
flag, which can be used to pass the fwnode in cases where we do not have
the IRQ problem and the driver for the instantiated client(s) needs acces=
s
to the fwnode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platf=
orm/x86/i2c-multi-instantiate.c
index 6acc8457866e..dcafb1a29d17 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -20,6 +20,8 @@
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
=20
+#define PASS_FWNODE		BIT(2)
+
 struct i2c_inst_data {
 	const char *type;
 	unsigned int flags;
@@ -93,6 +95,10 @@ static int i2c_multi_inst_probe(struct platform_device=
 *pdev)
 		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
 			 inst_data[i].type, i);
 		board_info.dev_name =3D name;
+
+		if (inst_data[i].flags & PASS_FWNODE)
+			board_info.fwnode =3D dev->fwnode;
+
 		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
 		case IRQ_RESOURCE_GPIO:
 			ret =3D acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
--=20
2.26.0

