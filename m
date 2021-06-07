Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D15739D942
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGKHU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 06:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhFGKHU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 06:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623060328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZSivJvfI8sRbp4GTuXApy3lrdMiQSZwL1pb7R7xZj4=;
        b=Y0Ex3UzJLHc6H2LF9gMIcvAZCAsejB/FDV/ELDwapg/ZnSTjXVtZZ9NTfFUpKgzsaZgRRp
        e9FCIsZjmVfT8MCkwAxvNiU8Vv1zMG1M8ExIiYQ1NyfN1xifDcW+QPWfV2LOkMnzDwr+2K
        bMcteu2hc0oYVBuwy+jx4z7i2n2M5Xs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-DtDCH6rlNKm49xR3Xid0nQ-1; Mon, 07 Jun 2021 06:05:27 -0400
X-MC-Unique: DtDCH6rlNKm49xR3Xid0nQ-1
Received: by mail-ej1-f72.google.com with SMTP id o5-20020a1709068605b02904034c0d7648so3356074ejx.8
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 03:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=mZSivJvfI8sRbp4GTuXApy3lrdMiQSZwL1pb7R7xZj4=;
        b=c61HEIEtpHO4b/nj1EUiCxHZet+wqHg02fNZIBNVHbZhZPLl1HpNYHpd94AxkT+e9Q
         44cm5hzLWVBMHIoBZ+ucx1dPO164/rbAqYAuPcuzoo9lXBPdIT1b6+b86xY3u4paNAfV
         6cY4+RPISrkNZpRvdUqRFhuOZVjPCHnI4woAkugkskdX4f12kv5yhjsVvulknecWkN6h
         cV4YorCPQtP1RMtfKez/grsQI9XEcCqZOvseBdVpVXR2rMXEAFHmalbV9vrugYx+BFP3
         pP8gUsubycd3M2MsRvcA7nTqOMH/2zmSP65+bD0o5Z8IqO9GMWBhkVe/ompXkHlQifd+
         h4rg==
X-Gm-Message-State: AOAM533jbmOs0vemjWG0BzSeM13xK4rqqCZCBVLFPqP9By+K8AO/r0ZB
        5JMEXa9WPf+upYHQsOaAJuTEu4IXJy4d/OHUPFM3ieUdb4pp8CP9sthmso8FkFwE3GZVo9SA8cb
        HqWoABAlFBPMTHaC8D/AUF8dtNr249GiuARbq0Kcx97Nrdm05BC1UgJw3QV/QHFiSv+GbZKA+ig
        ==
X-Received: by 2002:a17:906:d150:: with SMTP id br16mr17153586ejb.190.1623060326038;
        Mon, 07 Jun 2021 03:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYcpd8sDlsAubnqd8jc0DmX3xIQpUNL7G9bzmj7Uf9pcOp2f5fX34qDS+rI8tagyNXvqeISw==
X-Received: by 2002:a17:906:d150:: with SMTP id br16mr17153568ejb.190.1623060325788;
        Mon, 07 Jun 2021 03:05:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i12sm7398878edx.13.2021.06.07.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:05:25 -0700 (PDT)
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@outlook.com>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
Message-ID: <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
Date:   Mon, 7 Jun 2021 12:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------37771D4AA9A1EABC097E8427"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------37771D4AA9A1EABC097E8427
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

HI,

On 6/7/21 11:43 AM, Hans de Goede wrote:
> Hi,
> 
> On 6/3/21 7:26 PM, Hans de Goede wrote:
>> Hi Rafael,
>>
>> I've been helping some users with trying to get to the bottom of some
>> new ACPI errors with kernel 5.12, see:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=213023
>>
>> After looking at dmesg output; and after editing the dmesg output
>> a bit so that I could do diff -u on it, the following stands out:
>>
>> --- dmesg_5.10.38-1-lts	2021-06-03 16:29:41.372922210 +0200
>> +++ dmesg_linux-5.12.5-arch1-1	2021-06-03 16:30:01.013031634 +0200
>> @@ -92,7 +92,7 @@
>>  ACPI: IRQ9 used by override.
>>  Using ACPI (MADT) for SMP configuration information
>>  ACPI: HPET id: 0x8086a201 base: 0xfed00000
>> -ACPI: Core revision 20200925
>> +ACPI: Core revision 20210105
>>  PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096 bytes)
>>  PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff] (7274496 bytes)
>>  ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
>> @@ -113,10 +113,6 @@
>>  ACPI: Dynamic OEM Table Load:
>>  ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
>>  ACPI: Dynamic OEM Table Load:
>> -ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
>> -ACPI: Dynamic OEM Table Load:
>> -ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
>> -ACPI: Dynamic OEM Table Load:
>>  ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
>>  ACPI: Dynamic OEM Table Load:
>>  ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
>>
>> Note how for some reason the kernel is no longer loading the Cpu0Hwp and
>> HwpLvt SSDT-s ?
>>
>> Do you have any ideas what might be causing this ?
> 
> Good news, a very similar bug is being tracked here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> 
> And one of the reporters there has done a git bisect and has found the commit which is causing the problem for them:
> 
> """
> git-bisect points to 719e1f561afbe020ed175825a9bd25ed62ed1697 :
> "ACPI: Execute platform _OSC also with query bit clear".
> 
> Tested 5.12.9 kernel with the commit reverted, and confirmed that the error
> messages are gone. (I had to revert
> 5a6a2c0f0f43676df27632d657a3f18b151a7ef8 for dependency too.)
> 
> It also brings back the /sys/devices/system/cpu/cpu0/acpi_cppc which is absent
> in the stable 5.12.x
> 
> Hope this helps
> """

I've taken a quick look at commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear") and I think I may have found the problem.

I've attached a patch which I think may fix this (and I've asked the reporters of the bugs to test this).

Regards,

Hans


--------------37771D4AA9A1EABC097E8427
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-Use-_OSC-query-results-to-determine-caps-rather.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-Use-_OSC-query-results-to-determine-caps-rather.pa";
 filename*1="tch"

From d2ee8bc4ee24456fddef264f71628e2588e3144c Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 7 Jun 2021 11:55:57 +0200
Subject: [PATCH] ACPI: Use _OSC query results to determine caps rather then
 the commit results

Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
clear") makes acpi_bus_osc_negotiate_platform_control() not only query
the platforms capabilities but it also commits the result back to the
firmware to let the firmware know which capabilities are supported
back by the OS.

This also moved the code to set the osc_sb_apei_support_acked,
osc_pc_lpi_support_confirmed and osc_sb_native_usb4_support_confirmed
flags to after the commit. But it seems that some BIOS-es clear the
OSC_SUPPORT_DWORD on return when the query bit is not set.

Move the checking of the capabilities back to after the _OSC call with
the query bit set to restore the old behavior.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
Cc: Mario Limonciello <mario.limonciello@outlook.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23fad76..1e4953c0d5c2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -336,6 +336,10 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		return;
 	}
 
+	osc_sb_apei_support_acked = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
+	osc_pc_lpi_support_confirmed = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
+	osc_sb_native_usb4_support_confirmed = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
+
 	/*
 	 * Now run _OSC again with query flag clear and with the caps
 	 * supported by both the OS and the platform.
@@ -347,16 +351,6 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length > OSC_SUPPORT_DWORD) {
-		osc_sb_apei_support_acked =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-		osc_pc_lpi_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-		osc_sb_native_usb4_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
-	}
-
 	kfree(context.ret.pointer);
 }
 
-- 
2.31.1


--------------37771D4AA9A1EABC097E8427--

