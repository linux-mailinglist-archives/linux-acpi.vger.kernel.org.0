Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C42DD3F8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgLQPTD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 10:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLQPTD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 10:19:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29290C061794;
        Thu, 17 Dec 2020 07:18:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id g20so38437373ejb.1;
        Thu, 17 Dec 2020 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnERU2iVdKzX9RvnDhk1NZIz1JFzT1zaRxfnkrOcGto=;
        b=R1LEPagLOixZDyfDdu8KZryiHWwNFNsu1UYHnvzxJ0QynIuYO6kQGWnRq85pjTgx3e
         64VqsHgvLOlbQC8UTrxS1qfaLDl+SaxU3eg1q61127HqXOJNf9bThkfWvCim4wWfaRZW
         m8WTewS0mo68/sAc0z7R+HXxRfCflK2Ov/1e4Kkj5nRC/mXdm82gAR5ET/ZJ2a8m/ZOS
         52hWCeCaOqUExMLSwiHRDwWoKsL3WTICObqYTTJdDaLKDNl+7jjlMwZ7Fs33T3ZAat71
         e4kgSqbtW2iIuqV549vUikxxIcBLuVnnYvajR4ds/QdgSOrbvWUeULr7iGvvGajkyrFQ
         Pzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnERU2iVdKzX9RvnDhk1NZIz1JFzT1zaRxfnkrOcGto=;
        b=At7/2NGdxUGoObgJTtrBQrBb+VEh25ME4Mb9vz176vPTwnI7jJDO2b+CDpZ4Dh1e3O
         NNXKRG5v3EIuGOsQnBw44RHWetsj+hazIDFzObyHkD6Qh8cSzEp8i65hUQFeHzVzNhCq
         +WyrLtU26tBW4zOvEU9vTv3cqkTlUDoKmXg6rdm3nqMyBvGFWA4bJdVEPo3euxul+dpc
         H6LyJSSakz0v2swXw2sOCkAdPqQ1VYJ/H0RhAjMsUqt77dJDy5S/7EBHfp5nqSXV4I/d
         /P9Evr2mQNnSpY9NkCDlSPaV9bZkQ0pho74Mmg+x/txmdhEjQ9v7Mg54y77mY6BONK1j
         9nSA==
X-Gm-Message-State: AOAM531Dkr7KkXR1EA/BLDaEm1HtbJDi0pm9FaSWbDubjLUbM6USwAIb
        2QQVQ/eE/+MjDw2+odb+oS8=
X-Google-Smtp-Source: ABdhPJyh3vJiS+IMBB/ACL6va6jvpRnGNshpaQxGFQN6Zl8wMJLJPWvdHOQSEYYBTQGdAXOS1kIiUw==
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr37006277ejb.523.1608218301848;
        Thu, 17 Dec 2020 07:18:21 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a339.dip0.t-ipconnect.de. [217.229.163.57])
        by smtp.gmail.com with ESMTPSA id r24sm23805505edc.21.2020.12.17.07.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:18:21 -0800 (PST)
Subject: Re: [External] Re: [PATCH v6 2/3] ACPI: platform-profile: Add
 platform profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "njosh1@lenovo.com" <njosh1@lenovo.com>
References: <markpearson@lenovo.com>
 <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com>
 <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
 <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
 <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com>
 <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
 <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com>
 <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
 <lz2i0N6rCGcqra4IF0bl9Q0ke6btCg4-uW4fwI4PCnjsfLvhF2hm3SgqjCtUBybLzZTKDMmleu123UylZDfAjZ_jsayppN-X0PnSaaNwK6c=@protonmail.com>
 <CAJZ5v0gzXrft6x03tEtpn492StzSH=8jJbOmS6ncpVRRvscNKg@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <aa65eb2a-5b0a-26de-e667-d9c68f2341a5@gmail.com>
Date:   Thu, 17 Dec 2020 16:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gzXrft6x03tEtpn492StzSH=8jJbOmS6ncpVRRvscNKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 12/17/20 4:09 PM, Rafael J. Wysocki wrote:
> On Thu, Dec 17, 2020 at 4:02 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>>
>> 2020. december 17., csütörtök 14:36 keltezéssel, Rafael J. Wysocki <rafael@kernel.org> írta:
>>
>>> [...]
>>>>>> My thinking here that I shouldn't make assumptions for future platform
>>>>>> implementations - there may be valid cases in the future where being
>>>>>> able to return an error condition if there was an error would be useful.
>>>>>>
>>>>>> Just trying to keep this somewhat future proof. Returning an error
>>>>>> condition seemed a useful thing to have available.
>>>>>
>>>>> You can still return an error while returning a platform_profile_option value.
>>>>>
>>>>> Just add a special value representing an error to that set.
>>>>>
>>>> I'd like to understand what is better about that approach than having an
>>>> error and a returnable parameter?
>>>>
>>>> I'm probably missing something obvious but if I add an extra
>>>> platform_profile option (e.g PLATFORM_PROFILE_ERROR) to be used in an
>>>> error case (and return just an enum platform_profile_option) it seems I
>>>> lose the granularity of being able to return a specific error condition.
>>>> It doesn't feel like an improvement.
>>>
>>> And what's the user expected to do about the different error codes
>>> that can be returned?
>>
>> Even assuming the users of the API cannot or will not handle different errors
>> differently, who would benefit from getting rid of this information which may be
>> an aid in debugging for those who know what they're looking at?
>>
>> And if a new enum value is introduced to signal an error condition, how is that
>> going to be communicated to the users? A magic string like "error" or "-1"?
>> Or under a single errno like -EIO?
> 
> Yes.
> 
>> Personally, I believe neither of these two
>> solutions are better than returning the actual errno which is deemed most
>> appropriate by the platform profile handler. Or am I missing a third way?
> 
> Can we please defer this until we actually have a driver needing to
> return different error values from ->get_profile() (and I find it hard
> to believe that there will be any drivers like that)?

I can maybe give an example. On Microsoft Surface devices, the
performance mode / platform profile is set via a request to the embedded
controller and can be queried the same way. This request can fail (most
notably with ETIMEDOUT and EREMOTEIO). I think at least being able to
show users an error in this case would be helpful.

A driver for that is currently at [1], but I haven't adapted that yet to
the platform profile patchset.

On the other hand, I can also query and store the profile when loading
the driver and then update it when it's changed. That'd require that no
one else changes the profile, but I think we can safely assume that.

[1]: https://github.com/linux-surface/surface-aggregator-module/blob/master/module/src/clients/surface_perfmode.c,

Regards,
Max

> 
> Let's do the simpler thing until we have a real need to do the more
> complicated one.
> 
> Otherwise we're preparing for things that may never happen.
> 
