Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2521B8F0F
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgDZKr2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 06:47:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23870 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgDZKr1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 Apr 2020 06:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ameLghCB4urIBaiOFKoYPKuTDYVd0O7mLx3+vt0PmiM=;
        b=bMWRnq5lSpP8NTk2O+0lPhqV35DrtWlf26dbI1gx+cprtT7ydKlNxfYitU+Q+72oDt67zb
        B/C7Mv8nytk7cP2zyL1cYJElzBgO2oSmZ1Qn/BGlpktB9N1deHWeNOUmF6XPjdKgZavzp7
        F0pab9xsfM/z1uWAdA+/Yq5PF4MLeCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-qLBDTMThPXi08NF_M3g5Hg-1; Sun, 26 Apr 2020 06:47:23 -0400
X-MC-Unique: qLBDTMThPXi08NF_M3g5Hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE8B800D24;
        Sun, 26 Apr 2020 10:47:21 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2C55D715;
        Sun, 26 Apr 2020 10:47:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI / scan: Create platform device for CPLM3218 ACPI nodes
Date:   Sun, 26 Apr 2020 12:47:13 +0200
Message-Id: <20200426104713.216896-3-hdegoede@redhat.com>
In-Reply-To: <20200426104713.216896-1-hdegoede@redhat.com>
References: <20200426104713.216896-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some CPLM3218 ACPI nodes also put the SMBus Alert Response Address (0x0c)
in their ACPI resource table; and they put it there as the first entry,
here is an example from the CPLM3218 device in the DSDT of an Asus T100TA=
:

 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
 {
     Name (SBUF, ResourceTemplate ()
     {
         I2cSerialBusV2 (0x000C, ControllerInitiated, 0x00061A80,
             AddressingMode7Bit, "\\_SB.I2C3",
             0x00, ResourceConsumer, , Exclusive,
             )
         I2cSerialBusV2 (0x0048, ControllerInitiated, 0x00061A80,
             AddressingMode7Bit, "\\_SB.I2C3",
             0x00, ResourceConsumer, , Exclusive,
             )
         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
         {
             0x00000033,
         }
     })
     Return (SBUF) /* \_SB_.I2C3.ALSD._CRS.SBUF */
 }

The actual I2C address of the sensor in this case is the 0x48 address
from the second resource-table entry. On some other devices
(e.g. HP X2 Bay Trail models, Acer SW5-012) the CPLM3218 node contains
only 1 I2C resource.

Add the CPLM3218 to the I2C multi instantiate list, so that the
i2c-multi-instantiate.c driver can handle it.

Note in the case where there are 2 I2C resources we simply instatiate
i2c-clients for both and let the cm32181 driver figure out that the
first one is not the one it wants.

Doing things this way is actually desirable because on devices where
there are 2 I2C resources it seems that we first need to do a SMBus
read of the 0x0c address before the sensor will respond to I2C transfers
on its actual address.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c                          | 1 +
 drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6d3448895382..937d72fc212c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1544,6 +1544,7 @@ static bool acpi_device_enumeration_by_parent(struc=
t acpi_device *device)
 	static const struct acpi_device_id i2c_multi_instantiate_ids[] =3D {
 		{"BSG1160", },
 		{"BSG2150", },
+		{"CPLM3218", },
 		{"INT33FE", },
 		{"INT3515", },
 		{}
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platf=
orm/x86/i2c-multi-instantiate.c
index dcafb1a29d17..e1cdc44e6f57 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -180,6 +180,12 @@ static const struct i2c_inst_data int3515_data[]  =3D=
 {
 	{}
 };
=20
+static const struct i2c_inst_data cplm3218_data[]  =3D {
+	{ "cm32181", PASS_FWNODE },
+	{ "cm32181", PASS_FWNODE },
+	{}
+};
+
 /*
  * Note new device-ids must also be added to i2c_multi_instantiate_ids i=
n
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -187,6 +193,7 @@ static const struct i2c_inst_data int3515_data[]  =3D=
 {
 static const struct acpi_device_id i2c_multi_inst_acpi_ids[] =3D {
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ "BSG2150", (unsigned long)bsg2150_data },
+	{ "CPLM3218", (unsigned long)cplm3218_data },
 	{ "INT3515", (unsigned long)int3515_data },
 	{ }
 };
--=20
2.26.0

