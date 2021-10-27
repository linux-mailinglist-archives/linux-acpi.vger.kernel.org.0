Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8867E43CB9C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbhJ0OLW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 10:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242428AbhJ0OLW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 10:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635343736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgdeyFxPGuqP7X+NdKI/OrLvd/C9GODgzNmDVSEMqQ0=;
        b=eednj7AeIlPS2rtxTGFIFCOLHIlHd9RC2fPorwKNLeE8A1WBUBuqBbHDBL3FBUNq+TRZJ7
        XGMpCBdy49kS/7BF1BhKD5LZfJPhVgc+C6TUJr+QD0R/ZtyT8mMxQUcoTf239RqNYo2RMj
        soRNpDBvP/hpzFQJ6UstLYL4znMU284=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-pty0fajRNBOydWlTw_DtNw-1; Wed, 27 Oct 2021 10:08:54 -0400
X-MC-Unique: pty0fajRNBOydWlTw_DtNw-1
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a05640250d000b003dd8167857aso2477482edb.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Oct 2021 07:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wgdeyFxPGuqP7X+NdKI/OrLvd/C9GODgzNmDVSEMqQ0=;
        b=YO01/Ta/cG0FSPnaESCzj1QnVmQ7MTJRplkqGRvzti6HJW7eb/dwacQEUCeaIFEhOs
         4dNx+KiIuikNG4xMYn4ZIq75fitsUxPYymX8Fhcf1myYhC6wPTpy+Cwy4U13WTfql20b
         ynU3fWbw6W1mGtqs5IFGMJDHBKbCutscPlv0BlLDu8Ck7rheCg/DTCKxAd3DHzddchk3
         N76ZyZIcoRdfyEse5DlKJA60r5+V/011e0W0z6uobP9PEa1LPsx0MMG/GgqkvGR1DXbj
         DC4xDkUlxGcfDvenQHw7a9JI3Ufmp1AojvJZ3vj2ks8PbLaV86e6td4bp27SHXkoHTqL
         HnyA==
X-Gm-Message-State: AOAM5314V+xjHJy3JlP+dbNkRCvO4WdNs8F/ApMUN0QhDmuZnkk4zmfK
        JYBKL7cxQn4+4sIYVKUBoN7GaEltgrGCiL7LFntzhLlpyocJkyx8g08A+X7MQmUmO1+opbVm7Bi
        uIyNn5ltws2Df5o4RnS57ig==
X-Received: by 2002:aa7:de83:: with SMTP id j3mr45938566edv.312.1635343732834;
        Wed, 27 Oct 2021 07:08:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+UUV3Yl/79WVSquPk3+QAo+NRVNHuOpU1mwgdsycapt1Wdqf2kPi7xam7IHCPbkuKpJIyEQ==
X-Received: by 2002:aa7:de83:: with SMTP id j3mr45938552edv.312.1635343732644;
        Wed, 27 Oct 2021 07:08:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c5sm69098eds.81.2021.10.27.07.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:08:52 -0700 (PDT)
Message-ID: <e00e3f20-96d9-ee5f-505e-46bcfe0daee5@redhat.com>
Date:   Wed, 27 Oct 2021 16:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/3] platform/x86: asus-wmi: rename platform_profile_*
 function symbols
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, markpearson@lenovo.com,
        linux-acpi@vger.kernel.org
References: <20211026190835.10697-1-mario.limonciello@amd.com>
 <20211026190835.10697-3-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211026190835.10697-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/26/21 21:08, Mario Limonciello wrote:
> An upcoming change to platform profiles will export `platform_profile_get`
> as a symbol that can be used by other drivers. Avoid the collision.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/asus-wmi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index e14fb5fa7324..8f067ac4e952 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2169,8 +2169,8 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  static DEVICE_ATTR_RW(throttle_thermal_policy);
>  
>  /* Platform profile ***********************************************************/
> -static int platform_profile_get(struct platform_profile_handler *pprof,
> -				enum platform_profile_option *profile)
> +static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
>  {
>  	struct asus_wmi *asus;
>  	int tp;
> @@ -2196,8 +2196,8 @@ static int platform_profile_get(struct platform_profile_handler *pprof,
>  	return 0;
>  }
>  
> -static int platform_profile_set(struct platform_profile_handler *pprof,
> -				enum platform_profile_option profile)
> +static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
>  {
>  	struct asus_wmi *asus;
>  	int tp;
> @@ -2236,8 +2236,8 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  
>  	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
>  
> -	asus->platform_profile_handler.profile_get = platform_profile_get;
> -	asus->platform_profile_handler.profile_set = platform_profile_set;
> +	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
> +	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
>  
>  	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
>  	set_bit(PLATFORM_PROFILE_BALANCED,
> 

