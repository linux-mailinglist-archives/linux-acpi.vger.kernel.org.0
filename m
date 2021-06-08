Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E4A39FD44
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFHRMq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 13:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231261AbhFHRMp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 13:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623172252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9X4QK9342T+Zb5+qQlDChKFMJOt8Xm3s2ue9klbIZQ=;
        b=OzEOZsXDx1Q1SZ9rzv0EoVDl1gPvpnh3ilo72/MUY6BdOI2TZ90SqL3DsBMl3ISypDwAkm
        1iZjDH+DFUwO96r1fx9VQEUqvpYJ1pWROtzhWTQEyIegp6VRkmn6QI0pXvw9g56yW3BSUt
        MBK5OcNJeDOJRxxqRCaRtdNpT7X6/Us=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-KV_QViOZO7qqtVGLjsGQaw-1; Tue, 08 Jun 2021 13:10:50 -0400
X-MC-Unique: KV_QViOZO7qqtVGLjsGQaw-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020aa7d60c0000b029038fccdf4390so11142907edr.9
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 10:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L9X4QK9342T+Zb5+qQlDChKFMJOt8Xm3s2ue9klbIZQ=;
        b=OVTwB6ITwIdeMpquB3oKlRJTazgl3nHAuYZ9pCslqXH9+5feI/rVyfBANPsZlrHg02
         4HWQNu9Ji+Euzr5OoXtpP48xH6xuiPLuPYHMbxRNrqnPja0AqpL2joL+5QYZDWXVHPkc
         t7g6Pn4oUtYn37RTMunkajCrs9WWCWvuE0N4197Bz9kDvcUO6VYkLjD+sCfk0RDizeH7
         0Ka4PMbf8HLOYWJk6PiXv9x/i/Uy4V31c/f7d+rsLsimlm+TDRNbT8rGaotFen8dE2L3
         1db4XeCWLHZO589QTsGArPdXGTSifp7tG3hI7IdKWvJ3Y0ZK7gYdwcFv6dR+yg0gbvIY
         bhPw==
X-Gm-Message-State: AOAM5322B99Zn+DiNpFq668RAeFE5xPQbAhSXFkNboN3BUSVXIdFY7BL
        f4ntSci71pgMAYdcMlODYenMaw72uJjMBr6EcIFmYgXep844a5IixY+RDUeehtWGCaBUcw4c01V
        P5KrK8PK0dt6TZp5yPj3QzqiiXhnHsdvI7YKn3ip1940GRbEM4v31hp9oMf/NV4VW4n6+X3jKnA
        ==
X-Received: by 2002:a17:906:4ac4:: with SMTP id u4mr23606911ejt.229.1623172249403;
        Tue, 08 Jun 2021 10:10:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybLz0HyRZGhjHhl6BCIyIyDkFU5lKlj0oNx5pGPREx33ZX0uUJrUk03eBb1lK5xGc5EPGYrg==
X-Received: by 2002:a17:906:4ac4:: with SMTP id u4mr23606864ejt.229.1623172248971;
        Tue, 08 Jun 2021 10:10:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id di16sm128848edb.62.2021.06.08.10.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 10:10:48 -0700 (PDT)
Subject: Re: [PATCH] ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        linux-acpi@vger.kernel.org
References: <YL+Gqh9dT06SBLCx@lahna.fi.intel.com>
 <20210608163810.18071-1-mika.westerberg@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d0bdb868-95c9-8908-06e1-01f1364f12a0@redhat.com>
Date:   Tue, 8 Jun 2021 19:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608163810.18071-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/8/21 6:38 PM, Mika Westerberg wrote:
> Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
> clear") makes acpi_bus_osc_negotiate_platform_control() not only query
> the platforms capabilities but it also commits the result back to the
> firmware to report which capabilities are supported by the OS back to
> the firmware
> 
> On certain systems the BIOS loads SSDT tables dynamically based on the
> capabilities the OS claims to support. However, on these systems the
> _OSC actually clears some of the bits (under certain conditions) so what
> happens is that now when we call the _OSC twice the second time we pass
> the cleared values and that results errors like below to appear on the
> system log:
> 
>   ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
>   ACPI Error: Aborting method \_PR.PR01._CPC due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
> 
> In addition the ACPI 6.4 spec says following [1]:
> 
>   If the OS declares support of a feature in the Support Field in one
>   call to _OSC, then it must preserve the set state of that bit
>   (declaring support for that feature) in all subsequent calls.
> 
> Based on the above we can fix the issue by passing the same set of
> capabilities to the platform wide _OSC in both calls regardless of the
> query flag.
> 
> While there drop the context.ret.length check which was wrong to begin
> with (as the length is number of bytes not elements). This is already
> checked in acpi_run_osc() that also returns an error in that case.
> 
> [1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#sequence-of-osc-calls
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> Cc: Mario Limonciello <mario.limonciello@outlook.com>
> cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..61e8c02595ac 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -336,26 +336,19 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  		return;
>  	}
>  
> -	/*
> -	 * Now run _OSC again with query flag clear and with the caps
> -	 * supported by both the OS and the platform.
> -	 */
> +	/* Now run _OSC again with query flag clear */
>  	capbuf[OSC_QUERY_DWORD] = 0;
> -	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> -	kfree(context.ret.pointer);

This kfree needs to be moved up, rather then be completely removed
and you are still leaving 1 of the unnecessary length checks in place.

I've added this fixup on top, to fix both these issues:

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -330,11 +330,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length <= OSC_SUPPORT_DWORD) {
-		kfree(context.ret.pointer);
-		return;
-	}
+	kfree(context.ret.pointer);
 
 	/* Now run _OSC again with query flag clear */
 	capbuf[OSC_QUERY_DWORD] = 0;

I'll ask the reporters of:
https://bugzilla.kernel.org/show_bug.cgi?id=213023
https://bugzilla.redhat.com/show_bug.cgi?id=1963717

To test the (fixed-up) patch, so that they can confirm if this indeed
fixes things.

Regards,

Hans




>  
>  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>  		return;
>  
>  	capbuf_ret = context.ret.pointer;
> -	if (context.ret.length > OSC_SUPPORT_DWORD) {
> -		osc_sb_apei_support_acked =
> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> -		osc_pc_lpi_support_confirmed =
> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> -		osc_sb_native_usb4_support_confirmed =
> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
> -	}
> +	osc_sb_apei_support_acked =
> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> +	osc_pc_lpi_support_confirmed =
> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> +	osc_sb_native_usb4_support_confirmed =
> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
>  
>  	kfree(context.ret.pointer);
>  }
> 

