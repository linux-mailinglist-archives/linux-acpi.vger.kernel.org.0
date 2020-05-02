Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3791C27BD
	for <lists+linux-acpi@lfdr.de>; Sat,  2 May 2020 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgEBSaX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 May 2020 14:30:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59813 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728592AbgEBSaL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2020 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588444210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YsgUF1C7OvxapW2kOGl/SeXQ11P/c0ZuQmVKNq3BzFE=;
        b=SmXxSX6Ph+owdqNTQtsaMYe0UcES+LtXIe1/w9jnjKaIwXr/kKc+sO8+oNK3GhaPseiaB4
        8LmpAuYKPcrN+IyM5YrfUsZTP2/iWYlpQJyvOLzHoA1diyDO6GVQielZaCZiNIZjIrN7dq
        m9EXF9YIjuFmkwWzCn9NEmCSizgu6as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-r-IdcUsxNU6-Ya_7iakpmA-1; Sat, 02 May 2020 14:30:06 -0400
X-MC-Unique: r-IdcUsxNU6-Ya_7iakpmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F12F1009613;
        Sat,  2 May 2020 18:30:05 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE89D605DE;
        Sat,  2 May 2020 18:30:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode switch on "Detachable" and "Portable" chassis-types
Date:   Sat,  2 May 2020 20:29:50 +0200
Message-Id: <20200502182951.114231-5-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-1-hdegoede@redhat.com>
References: <20200502182951.114231-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
switch on 2-in-1's") added a DMI chassis-type check to avoid accidentally
reporting SW_TABLET_MODE =3D 1 to userspace on laptops.

Some devices with a detachable keyboard and using the intel-vbnt (INT33D6=
)
interface to report if they are in tablet mode (keyboard detached) or not=
,
report 32 / "Detachable" as chassis-type, e.g. the HP Pavilion X2 series.

Other devices with a detachable keyboard and using the intel-vbnt (INT33D=
6)
interface to report SW_TABLET_MODE, report 8 / "Portable" as chassis-type=
.
The Dell Venue 11 Pro 7130 is an example of this.

Extend the DMI chassis-type check to also accept Portables and Detachable=
s
so that the intel-vbtn driver will report SW_TABLET_MODE on these devices=
.

Note the chassis-type check was originally added to avoid a false-positiv=
e
tablet-mode report on the Dell XPS 9360 laptop. To the best of my knowled=
ge
that laptop is using a chassis-type of 9 / "Laptop", so after this commit
we still ignore the tablet-switch for that chassis-type.

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode=
 switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Looking at the Microsoft Windows documentation for tablet-mode reporting:
https://docs.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-=
implementation

Then the presence of a tablet-mode switch is indicated by the presence
of a PNP0C60 compatible ACPI devices. There are 2 ways in which this devi=
ce
can report the tablet-mode. 1. Directly providing a GpioInt resource insi=
de
the PNP0C60 device, 2. Through injecting events from a Windows driver.

It seems that the intel-vbtn / the INT33D6 ACPI device is the ACPI side
of Intel's generic solution for the case where the tablet-mode comes from
the embedded-controller and needs to be "injected".

This all suggests that it might be better to replace the chassis-type
check with a acpi_dev_present("PNP0C60", NULL, -1) check.

Mario, can you provide an acpidump and alsa-info.sh output for the
Dell XPS 9360, so that I can check if that might help with the issue
there, and thus is a potential candidate to replace the chassis-type
check?
---
 drivers/platform/x86/intel-vbtn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-vbtn.c
index 500fae82e12c..4921fc15dc6c 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -158,12 +158,22 @@ static void detect_tablet_mode(struct platform_devi=
ce *device)
 static bool intel_vbtn_has_switches(acpi_handle handle)
 {
 	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
+	unsigned long chassis_type_int;
 	unsigned long long vgbs;
 	acpi_status status;
=20
-	if (!(chassis_type && strcmp(chassis_type, "31") =3D=3D 0))
+	if (kstrtoul(chassis_type, 10, &chassis_type_int))
 		return false;
=20
+	switch (chassis_type_int) {
+	case  8: /* Portable */
+	case 31: /* Convertible */
+	case 32: /* Detachable */
+		break;
+	default:
+		return false;
+	}
+
 	status =3D acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	return ACPI_SUCCESS(status);
 }
--=20
2.26.0

