Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB05A39F2D4
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHJwP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 05:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230460AbhFHJwO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 05:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623145821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLuOJm59BBsmVv3HBaFp3IWN/LyRQUaKZB5tVtOKbSQ=;
        b=Q8ukgt9ThRXZYrnEm3w3oUFhtWbAGcI44ID8tlp1Iw7OMxQNP4Has4TYVgLB2ADhfccY0v
        seNlVT8x+o1V/3zGzUjO2AD3TTNGjpEx/XxJt04RLr1+RUf/gs1JdLe+MpROsWOZcVvvgD
        /9O/rPgtY0ovSnHNs4f9jJS+b8quFeQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-siHE4Wd6NHybhLJh_q0Tcg-1; Tue, 08 Jun 2021 05:50:18 -0400
X-MC-Unique: siHE4Wd6NHybhLJh_q0Tcg-1
Received: by mail-ed1-f71.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so10632548edt.23
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 02:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=XLuOJm59BBsmVv3HBaFp3IWN/LyRQUaKZB5tVtOKbSQ=;
        b=f4neqEXAT31c9eHWaAe3FY1LF/V4/L3Aa7fEp/mI8b0GFvPRfdDvDoWhYAlDhoYLms
         XevgmLYpbHOSrsiyy4PPhGZvL2MY/rFIz3mD5ggEmkLjmV85l4d9242s3vZmAZQTp/d1
         oc4giqCjeio68obFbS7FHKU9AYg3vN6gtaKj825EYCvOpZuFjoiBDnfo4N5J+QLBr7R6
         gVOMVHisQ2y/eNy1VLCJPWNcxtNnXOKh6Au+K90Gd82mG7wpPIheHfn+pi6jSNcmH1Zc
         om1gaBneDiPAmlDnywULnPVOnOZIaFiBkFONNufEzWmOvmJFmkXVgtIZAriqlhIq/gI+
         PfQA==
X-Gm-Message-State: AOAM533cczRtv453QYDMb9EMO9xT6/ZGMp3e5BeKEsDmtaxUtW1F+PVm
        /NAd+LgNxJ2DZno0O+n9I5s+oSJj3lh12guRWUOLd8hEj2EZ4gnDtXV6/WC7gTMxRs5sMg8wAE5
        xBUO/LyuqlktbQHULgPC/UVwBmZIt9FvP9UqGi7V9mYklbLRwvSxeC4dtXuhTUNGV9u3cenX1sQ
        ==
X-Received: by 2002:a05:6402:31f3:: with SMTP id dy19mr24555181edb.153.1623145816647;
        Tue, 08 Jun 2021 02:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpDiQht87I/BdAXhGVIopw9TY8HtJl5MzU8sEoUUeKSo8KrHKVBi6KuOrnEHqrUUVCh18qCw==
X-Received: by 2002:a05:6402:31f3:: with SMTP id dy19mr24555163edb.153.1623145816445;
        Tue, 08 Jun 2021 02:50:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ox3sm7469325ejb.45.2021.06.08.02.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 02:50:15 -0700 (PDT)
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@outlook.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
 <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
 <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
 <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
 <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
 <209a230c-a7a6-7a8e-0515-97fb534d7401@redhat.com>
Message-ID: <0f733402-ae3b-b4e7-13c4-e6161f9c7e81@redhat.com>
Date:   Tue, 8 Jun 2021 11:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <209a230c-a7a6-7a8e-0515-97fb534d7401@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------9E1B8F6A92A6B83F7256AC02"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------9E1B8F6A92A6B83F7256AC02
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/7/21 9:18 PM, Hans de Goede wrote:
> Hi,
> 
> On 6/7/21 6:08 PM, Mika Westerberg wrote:
>> Hi,
>>
>> Tried now on ADL-P and TGL systems and the _OSC still works properly.
>>
>> Thanks Hans for fixing!
>>
>> Feel free to add my Tested-by.
> 
> Thank you for testing, unfortunately so far from the comments here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=213023
> 
> it seems that my patch does not help resolve the issues caused
> by commit 719e1f561afb ("ACPI: Execute platform _OSC also with query
> bit clear"), where as reverting that commit does resolve them :|
> 
> Does anyone have any other ideas how to fix this ?

The reporter who has done the bisect has commented out the new/second
_OSC call and that fixes things for them. So I've written a new fix
(attached), note just as before this is untested ATM.

Mika, if you can test this one (it replaces the previous one)
on machines with native USB4 support to check those don't regress then
that would be great.

I've asked the various reporters from the 2 bugzilla's for this to also
test this new patch. I'll let you know how that goes.

Regards,

Hans




>> On Mon, Jun 07, 2021 at 01:01:59PM +0000, Mario Limonciello wrote:
>>>    Mika,
>>>
>>>    Can you have a try and make sure this modification still works properly
>>>    on the series in the hardware we originally did it for?
>>>      __________________________________________________________________
>>>
>>>    From: Rafael J. Wysocki <rafael@kernel.org>
>>>    Sent: Monday, June 7, 2021 6:13:21 AM
>>>    To: Hans de Goede <hdegoede@redhat.com>
>>>    Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; Mario Limonciello
>>>    <mario.limonciello@outlook.com>; linux-acpi
>>>    <linux-acpi@vger.kernel.org>
>>>    Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
>>>
>>>    On Mon, Jun 7, 2021 at 12:05 PM Hans de Goede <hdegoede@redhat.com>
>>>    wrote:
>>>    >
>>>    > HI,
>>>    >
>>>    > On 6/7/21 11:43 AM, Hans de Goede wrote:
>>>    > > Hi,
>>>    > >
>>>    > > On 6/3/21 7:26 PM, Hans de Goede wrote:
>>>    > >> Hi Rafael,
>>>    > >>
>>>    > >> I've been helping some users with trying to get to the bottom of
>>>    some
>>>    > >> new ACPI errors with kernel 5.12, see:
>>>    > >>
>>>    > >> [1]https://bugzilla.kernel.org/show_bug.cgi?id=213023
>>>    > >>
>>>    > >> After looking at dmesg output; and after editing the dmesg output
>>>    > >> a bit so that I could do diff -u on it, the following stands out:
>>>    > >>
>>>    > >> --- dmesg_5.10.38-1-lts      2021-06-03 16:29:41.372922210 +0200
>>>    > >> +++ dmesg_linux-5.12.5-arch1-1       2021-06-03 16:30:01.013031634
>>>    +0200
>>>    > >> @@ -92,7 +92,7 @@
>>>    > >>  ACPI: IRQ9 used by override.
>>>    > >>  Using ACPI (MADT) for SMP configuration information
>>>    > >>  ACPI: HPET id: 0x8086a201 base: 0xfed00000
>>>    > >> -ACPI: Core revision 20200925
>>>    > >> +ACPI: Core revision 20210105
>>>    > >>  PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096
>>>    bytes)
>>>    > >>  PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff]
>>>    (7274496 bytes)
>>>    > >>  ACPI FADT declares the system doesn't support PCIe ASPM, so
>>>    disable it
>>>    > >> @@ -113,10 +113,6 @@
>>>    > >>  ACPI: Dynamic OEM Table Load:
>>>    > >>  ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL
>>>    20160527)
>>>    > >>  ACPI: Dynamic OEM Table Load:
>>>    > >> -ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL
>>>    20160527)
>>>    > >> -ACPI: Dynamic OEM Table Load:
>>>    > >> -ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL
>>>    20160527)
>>>    > >> -ACPI: Dynamic OEM Table Load:
>>>    > >>  ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL
>>>    20160527)
>>>    > >>  ACPI: Dynamic OEM Table Load:
>>>    > >>  ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL
>>>    20160527)
>>>    > >>
>>>    > >> Note how for some reason the kernel is no longer loading the
>>>    Cpu0Hwp and
>>>    > >> HwpLvt SSDT-s ?
>>>    > >>
>>>    > >> Do you have any ideas what might be causing this ?
>>>    > >
>>>    > > Good news, a very similar bug is being tracked here:
>>>    > >
>>>    > > [2]https://bugzilla.redhat.com/show_bug.cgi?id=1963717
>>>    > >
>>>    > > And one of the reporters there has done a git bisect and has found
>>>    the commit which is causing the problem for them:
>>>    > >
>>>    > > """
>>>    > > git-bisect points to 719e1f561afbe020ed175825a9bd25ed62ed1697 :
>>>    > > "ACPI: Execute platform _OSC also with query bit clear".
>>>    > >
>>>    > > Tested 5.12.9 kernel with the commit reverted, and confirmed that
>>>    the error
>>>    > > messages are gone. (I had to revert
>>>    > > 5a6a2c0f0f43676df27632d657a3f18b151a7ef8 for dependency too.)
>>>    > >
>>>    > > It also brings back the /sys/devices/system/cpu/cpu0/acpi_cppc
>>>    which is absent
>>>    > > in the stable 5.12.x
>>>    > >
>>>    > > Hope this helps
>>>    > > """
>>>    >
>>>    > I've taken a quick look at commit 719e1f561afb ("ACPI: Execute
>>>    platform _OSC also with query bit clear") and I think I may have found
>>>    the problem.
>>>    >
>>>    > I've attached a patch which I think may fix this (and I've asked the
>>>    reporters of the bugs to test this).
>>>    Thank you, the patch looks reasonable to me.
>>>    It looks like commit 719e1f561afb went a bit too far.
>>>
>>> References
>>>
>>>    1. https://bugzilla.kernel.org/show_bug.cgi?id=213023
>>>    2. https://bugzilla.redhat.com/show_bug.cgi?id=1963717
>>

--------------9E1B8F6A92A6B83F7256AC02
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-Only-run-_OSC-without-the-query-flag-on-machine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-Only-run-_OSC-without-the-query-flag-on-machine.pa";
 filename*1="tch"

From b758a6c48d418a89f8d2bc08c5daa778b162b5b3 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 7 Jun 2021 11:55:57 +0200
Subject: [PATCH] ACPI: Only run _OSC without the query flag on machines with
 native USB4 support

Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
clear") makes acpi_bus_osc_negotiate_platform_control() not only query
the platforms capabilities but it also commits the result back to the
firmware to report which capabilities are supported by the OS back to the
firmware.

This reporting back of the OS supported capabilities is necessary for
USB4 support, but it is causing problems on some other devices, causing
some SSDTs to no longer load on these devices.

Make the reporting back of the capabilities (the _OSC call with the
query flag cleared) conditional on the queried capabilities including
native USB4 support, skipping it when there is no native USB4 support
to fix the regressions caused by doing this on some machines without
native USB4 support.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
Cc: Mario Limonciello <mario.limonciello@outlook.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23fad76..9a56a6f653cc 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -286,7 +286,7 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
-	u32 capbuf[2], *capbuf_ret;
+	u32 capbuf[2], caps = 0;
 	struct acpi_osc_context context = {
 		.uuid_str = sb_uuid_str,
 		.rev = 1,
@@ -330,34 +330,31 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length <= OSC_SUPPORT_DWORD) {
-		kfree(context.ret.pointer);
-		return;
+	if (context.ret.length > OSC_SUPPORT_DWORD) {
+		u32 *capbuf_ret = context.ret.pointer;
+
+		caps = capbuf_ret[OSC_SUPPORT_DWORD];
 	}
+	kfree(context.ret.pointer);
+
+	osc_sb_apei_support_acked = caps & OSC_SB_APEI_SUPPORT;
+	osc_pc_lpi_support_confirmed = caps & OSC_SB_PCLPI_SUPPORT;
+	osc_sb_native_usb4_support_confirmed = caps & OSC_SB_NATIVE_USB4_SUPPORT;
 
 	/*
-	 * Now run _OSC again with query flag clear and with the caps
-	 * supported by both the OS and the platform.
+	 * On machines with native USB4 support, run _OSC again with the query
+	 * flag cleared and with the caps supported by both the OS and the
+	 * platform to let the firmware know we support native USB4.
 	 */
-	capbuf[OSC_QUERY_DWORD] = 0;
-	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
-	kfree(context.ret.pointer);
+	if (osc_sb_native_usb4_support_confirmed) {
+		capbuf[OSC_QUERY_DWORD] = 0;
+		capbuf[OSC_SUPPORT_DWORD] = caps;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
+		if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+			return;
 
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length > OSC_SUPPORT_DWORD) {
-		osc_sb_apei_support_acked =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-		osc_pc_lpi_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-		osc_sb_native_usb4_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
+		kfree(context.ret.pointer);
 	}
-
-	kfree(context.ret.pointer);
 }
 
 /*
-- 
2.31.1


--------------9E1B8F6A92A6B83F7256AC02--

