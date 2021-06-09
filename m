Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D03A1291
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhFIL1E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 07:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237862AbhFIL1E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 07:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623237909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ce5hbpY90l7m7u+rQlQtBmV2WViixAR0dn/BAf3WzIY=;
        b=gmz7yQOAQWMoJzN0uJNQnJ47Hwl+R+PC7WQi0V6WytGqpwiXREsdieVjlmgUbDAfWZpM79
        Ugo8R4z8zjPi3C2dZ3VYxdl1m3clol0NnIbA3peBekdkRDh1V9Vluk5TOqvv4Xu/y0mZn5
        Rxn8lWvKrWF/OscVfOvrtzqgPqYSdtM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-YETe9g4AMqaviOlP0e_6wQ-1; Wed, 09 Jun 2021 07:25:08 -0400
X-MC-Unique: YETe9g4AMqaviOlP0e_6wQ-1
Received: by mail-ed1-f72.google.com with SMTP id s25-20020aa7c5590000b0290392e051b029so7243355edr.11
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 04:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ce5hbpY90l7m7u+rQlQtBmV2WViixAR0dn/BAf3WzIY=;
        b=NvvqgjCo4XZEw/tPte8YKHG0CfjMwqJ+q11p7BF+gJMylRpr39PjeBaWbNwmATmGTZ
         3yGW8t1elGY2H0cYJ4VDp+I/YZW1bL8vQNwdD549pspKld4SHWuIo6Nc/jkL9gkR/+LD
         NQWY9SC9KVVOGa8wHk23dHJGh2Zo2Pi+q6RnFGhkDVTrZTpQh4NYIKgA9XeuP+/5maHo
         AZ1y2etq8TZo6M9DGs4SopHHyFlVm0MiA78H0Xu1+2WaXtafwF09iYGeflLMoSfT/jF5
         MwbHFDRoVcg8aqm86cka3SR1RIwawirppR0GWEVS96HmY+cJoGafFqU/+XDbId3iUOX/
         mCqg==
X-Gm-Message-State: AOAM533jNsgO6ftS1kKetaRFEyfRXxTAzUlxbDxUopnEJ/XTeuQ5qVQh
        lWcUedUnawzBN9+wePMD5w532zoEGVAM6G3+CBntzp/C+cza6W3SK+3zkZpSxbSBRV3rdliFVw2
        FRwcYK+aYQ9AbDOfTRwsTMapQLeN+4yEPcXU5f7cqRuKW3EOcIovj34zKLC/P2pc4Ge8Hg1VyJA
        ==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr30329959edu.370.1623237906861;
        Wed, 09 Jun 2021 04:25:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIaTryVD6wx+Cqf5zfZUHjZC+FrjvNZBQfZdHcIyIdUeXFlYR5MfFxakvNZgMnvbXbnpTmBA==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr30329941edu.370.1623237906560;
        Wed, 09 Jun 2021 04:25:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n18sm981717ejx.41.2021.06.09.04.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:25:06 -0700 (PDT)
Subject: Re: [PATCH v2] ACPI: Pass the same capabilities to the _OSC
 regardless of the query flag
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        linux-acpi@vger.kernel.org
References: <20210609102533.6565-1-mika.westerberg@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <54a5da2d-255c-4617-b2fa-8bc8e8746360@redhat.com>
Date:   Wed, 9 Jun 2021 13:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609102533.6565-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/9/21 12:25 PM, Mika Westerberg wrote:
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
> While there drop the context.ret.length checks which were wrong to begin
> with (as the length is number of bytes not elements). This is already
> checked in acpi_run_osc() that also returns an error in that case.
> 
> Includes fixes by Hans de Goede.
> 
> [1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#sequence-of-osc-calls
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> Cc: Mario Limonciello <mario.limonciello@outlook.com>
> cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes from v1:
> 
>  - Include fixup suggested by Hans
> 
> Was not sure how to attribute that so I just mention it in the commit log
> for now. Please let me know if there is more standard way :)
> 
>  drivers/acpi/bus.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..a4bd673934c0 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -330,32 +330,21 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>  		return;
>  
> -	capbuf_ret = context.ret.pointer;
> -	if (context.ret.length <= OSC_SUPPORT_DWORD) {
> -		kfree(context.ret.pointer);
> -		return;
> -	}
> +	kfree(context.ret.pointer);
>  
> -	/*
> -	 * Now run _OSC again with query flag clear and with the caps
> -	 * supported by both the OS and the platform.
> -	 */
> +	/* Now run _OSC again with query flag clear */
>  	capbuf[OSC_QUERY_DWORD] = 0;
> -	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> -	kfree(context.ret.pointer);
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

