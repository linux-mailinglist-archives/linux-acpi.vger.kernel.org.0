Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802373573D4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhDGSCx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 14:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234175AbhDGSCw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 14:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617818561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7ehjgK6RINiK/yl9HBkU3LoriM4xfDLflETYOr86Gw=;
        b=eivKU3h4M2ANJCV6HmCNBuJwBj0Hi0u+VAkRSUOzQ7jst+boOTWw/aa5H04wRal5auupi+
        oNWWNNgm+oFOEQrNaCr6kHeisWPLig6RaFQ4UAyyKYbUtI0xVdkWiqoFNh9L2NQ1kiwbGs
        VLGp3bxHBXScmQ1D2DRICqgoKuY2F8E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-fB7KB7iXP-qTJPWM4WFqww-1; Wed, 07 Apr 2021 14:02:40 -0400
X-MC-Unique: fB7KB7iXP-qTJPWM4WFqww-1
Received: by mail-ej1-f69.google.com with SMTP id v27so7229595ejq.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Apr 2021 11:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7ehjgK6RINiK/yl9HBkU3LoriM4xfDLflETYOr86Gw=;
        b=UtY9YUSBk7x6CZWFcUowhAitQCHb1kWVlTixaw6Px9BpOvHA0jQTH7xMHDn0iMf85b
         YYi2a+m3PIoFmoPSGbe5vdOfBuj0GlDNOSaLqTt2maf7Rc7Ld13POkw62fO+Hv9JyvZi
         hCc7++xq45zSJndUR3dwRBxvGXMABZoakHVHFoh4DgaVmACPdIAkLKWafc143OgUKDFY
         cUj6wULmpawCkPhvbT5U/MCbN1GI8R83fLrW+CFEK8H8KeN9DLaOgVOa8ezw/ANiJ4b4
         WO0Ja7fsw6u7gCplBZyb+Hwj3Ael+m1M1P7wQIBNI+Dq7sPyG1RM43bmejzvm+5zyTNm
         MBwg==
X-Gm-Message-State: AOAM530DhxcZe7ZW7zKndDEhCZtoq1D26AKPLySAEnkHhATOlGj39EBT
        Xr1O8u28scXiINXHpv/C9kMQAIt0V1R2mxdwY5XjF8Bq2ledstAb3ATX1GDgyRwwDlxUHOwyX3M
        jW6RTBwpwYT8I6wrsHz6Yv5AiYzSfg8m0BOcifhNyaM2rYe5/RlVRCSbNsCf6MMYL07cDK/sXgg
        ==
X-Received: by 2002:a17:906:f9c2:: with SMTP id lj2mr5071029ejb.195.1617818558742;
        Wed, 07 Apr 2021 11:02:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK725+ILnRkQ4vSs3I2qAt0qEtqKhNqM91f7PqiD8a6kwG8A8HSEm6GE7+u+tEw45FVG0T4g==
X-Received: by 2002:a17:906:f9c2:: with SMTP id lj2mr5071006ejb.195.1617818558501;
        Wed, 07 Apr 2021 11:02:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u13sm7669561ejr.100.2021.04.07.11.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:02:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210406211653.182338-1-hdegoede@redhat.com>
 <CAJZ5v0h6=_U+_=G8YL5rA701pTLGfyg4PmBudc3tFRKG=Wxh4A@mail.gmail.com>
 <4e796690-0a45-77e9-6b5d-61b3efa4b301@redhat.com>
 <CAJZ5v0jYUA8GHqYvnkp=Q0fzMKcsXtuZ-RcSS3jc_exKjtsewA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f24d4fef-3d20-8627-272c-36f4f5a5c493@redhat.com>
Date:   Wed, 7 Apr 2021 20:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jYUA8GHqYvnkp=Q0fzMKcsXtuZ-RcSS3jc_exKjtsewA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/7/21 7:50 PM, Rafael J. Wysocki wrote:
> On Wed, Apr 7, 2021 at 7:43 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 4/7/21 7:13 PM, Rafael J. Wysocki wrote:
>>> On Tue, Apr 6, 2021 at 11:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Add a getter for the acpi_gbl_reduced_hardware variable so that modules
>>>> can check if they are running on an ACPI reduced-hw platform or not.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  drivers/acpi/utils.c    | 11 +++++++++++
>>>>  include/acpi/acpi_bus.h |  1 +
>>>>  include/linux/acpi.h    |  5 +++++
>>>>  3 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
>>>> index 682edd913b3b..4cb061d3169a 100644
>>>> --- a/drivers/acpi/utils.c
>>>> +++ b/drivers/acpi/utils.c
>>>> @@ -872,6 +872,17 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>>>>  }
>>>>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>>>>
>>>> +/**
>>>> + * acpi_reduced_hardware - Return if this is an ACPI-reduced-hw machine
>>>> + *
>>>> + * Return true when running on an ACPI-reduced-hw machine, false otherwise.
>>>> + */
>>>> +bool acpi_reduced_hardware(void)
>>>> +{
>>>> +       return acpi_gbl_reduced_hardware;
>>>> +}
>>>> +EXPORT_SYMBOL(acpi_reduced_hardware);
>>>
>>> EXPORT_SYMBOL_GPL()?
>>
>> Yes, that was my intention, no idea what happened here.

I just prepped and send out v2 and I think I know what happened, all
the other functions in drivers/acpi/utils.c are EXPORT_SYMBOL, so I probably
just copy-and-pasted this without too much thinking.

It might be worthwhile to see if we should also mark some other functions
as EXPORT_SYMBOL_GPL() here.

>> Before I send a v2, do you have any remarks on patch 2/2 (which is actually
>> the more interesting patch) ?
> 
> I thought that basing that check on the ACPICA's global variable may
> be too coarse grained for some cases, but then I've decided to do it
> as is now and we'll see.

Yes, the whole code for selecting which backlight driver to use is mostly
heuristics, so "we'll see" indeed . With that said I'm pretty confident
that this change should not cause problems. Platforms which actually
set acpi_gbl_reduced_hardware=true seem to be quite rare. I'm actually
only aware of Bay Trail-T based devices doing this.

Regards,

Hans

