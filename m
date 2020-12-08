Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E02D2D9A
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgLHOzD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 09:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgLHOzD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 09:55:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3892C0613D6;
        Tue,  8 Dec 2020 06:54:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c7so17858238edv.6;
        Tue, 08 Dec 2020 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JsWjwoYEgAbELe13CUoCOO68+RuWkKxn3fV23mNX3vU=;
        b=WzoFlR+1Wl6dnE5qW/Yq32zVEL3eblUGt6N9zW3IyPFozPs3eMxbyFvW9nuX2qbtDZ
         22NwV0MjDtw+2o0260aJpquknaxeSuX0dbIP3bTsPfZVuotOrTR8FQgEHZIo232Na9e3
         IeQt8sMpOQf7R4MX+tCNd2ydER/Vbj8zm6lC0pwi5Ik1UbdyY3y685xlWYYNKBG5EClc
         HAwII2t4O0eiUgKFxNV/N/t2yIVYhnc5bFbLx6RGyvTkbwjhAP/elaBGjlJL29Wrk3Tf
         g2FkTSqCZkf1D0UCVuOiwx6GY7eT84gcQ3Ic0ZzB7LXldsTHG8KxJ96o3OKMFtlrtLDR
         y9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JsWjwoYEgAbELe13CUoCOO68+RuWkKxn3fV23mNX3vU=;
        b=MiRAFNyNl1EdzKAIeUwp1+pzh7PtuEBOjzsFbAw/hW35AwOSvWqKQwBw+gOBa6DmK7
         LgFbYYJXyzBMLVGbUL331jtJXzmEBomzCoY9UJbjg//gPI0DYkIkJ3nhE++E98x+Gv97
         lzNeown28s7qrWjzYS8AWY80hkB4Y573rOKFg8zW8tEMhhA/5Om6lA7HnIVqsm1PkX6O
         g6XIHcjePknMT0vqd/a04fZsf+YGwDuIRWDZNdo5rwr1HO6FRKh0QaNMboXrfWL3uYXR
         CJmxRd4YBvk+t2qz8PFFztMR5HTkzy+ZKGtoH71NoCboOaObDgaU294pUPStUtR4gBk3
         Sj/A==
X-Gm-Message-State: AOAM530B07UbAl0ASKJmLBGJNk0/jwMRxegS3uf5NJ6bKXUSf9U1LuxH
        BDlTHjbiugt0IJrSHuQg/SRy8vKS4sY=
X-Google-Smtp-Source: ABdhPJxAxwIONKKlT41YQVw5zrtg7UmpONATTyuwBGEhqTDt71BnKRdiNWs5dzar2lnyLJm5hg5l/A==
X-Received: by 2002:aa7:d6d8:: with SMTP id x24mr25369803edr.105.1607439261216;
        Tue, 08 Dec 2020 06:54:21 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a486.dip0.t-ipconnect.de. [217.229.164.134])
        by smtp.gmail.com with ESMTPSA id be6sm17603929edb.29.2020.12.08.06.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:54:20 -0800 (PST)
Subject: Re: [PATCH v2 1/9] platform/surface: Add Surface Aggregator subsystem
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-2-luzmaximilian@gmail.com>
 <fd24d99a-e4f4-2030-e9bb-bcd549ce4bb9@redhat.com>
 <ac50a0c7-806e-d949-6440-620ec966099a@gmail.com>
 <9748d778-b5e9-c80c-5968-a77b3203d769@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <b77b74d2-b854-7e8f-fd8e-abee6cdd22ff@gmail.com>
Date:   Tue, 8 Dec 2020 15:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <9748d778-b5e9-c80c-5968-a77b3203d769@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 12/8/20 3:43 PM, Hans de Goede wrote:
> Hi,
> 
> On 12/8/20 3:37 PM, Maximilian Luz wrote:
> 
> <snip>
> 
>>>> +
>>>> +    obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
>>>> +                      SSAM_SSH_DSM_REVISION, func, NULL,
>>>> +                      ACPI_TYPE_INTEGER);
>>>> +    if (!obj)
>>>> +        return -EIO;
>>>> +
>>>> +    val = obj->integer.value;
>>>> +    ACPI_FREE(obj);
>>>> +
>>>> +    if (val > U32_MAX)
>>>> +        return -ERANGE;
>>>> +
>>>> +    *ret = val;
>>>> +    return 0;
>>>> +}
>>
>> [...]
>>
>>>> +/**
>>>> + * ssam_controller_start() - Start the receiver and transmitter threads of the
>>>> + * controller.
>>>> + * @ctrl: The controller.
>>>> + *
>>>> + * Note: When this function is called, the controller should be properly
>>>> + * hooked up to the serdev core via &struct serdev_device_ops. Please refer
>>>> + * to ssam_controller_init() for more details on controller initialization.
>>>> + *
>>>> + * This function must be called from an exclusive context with regards to the
>>>> + * state, if necessary, by locking the controller via ssam_controller_lock().
>>>
>>> Again you are being a bit hand-wavy (I assume you know what I mean by that)
>>> wrt the locking requirements. If possible I would prefer clearly spelled out
>>> locking requirements in the form of "this and that lock must be held when
>>> calling this function". Preferably backed-up by lockdep_assert-s asserting
>>> these conditions.
>>
>> The reason for this is that this function specifically is currently only
>> called during initialization, when the controller has not been published
>> yet, i.e. when we have an exclusive reference to the controller.
>>
>> I'll change this to fully enforce locking (with lockdep_assert).
>>
>>> And maybe if you are a bit stricter with always holding the lock when
>>> calling this, you can also drop the WRITE_ONCE and the comment about it
>>> (in all places where you do this).
>>
>> The WRITE_ONCE is only there to ensure that the basic test in
>> ssam_request_sync_submit() can be done. I always try to be explicit
>> about access that can happen without the respective locks being held.
> 
> Yes I saw the matching READ_ONCE later on (as the comment indicated
> I would), which made it more obvious to me why the WRITE_ONCE is here,'
> so maybe I should have gone back and updated this comment.

No worries, always good to have another look at these kinds of things.

> Anyways, keeping the WRITE_ONCE + READ_ONCE for this is fine.
> 
>> Unfortunately it's not feasible to hold the reader lock in
>> ssam_request_sync_submit() due to reentrancy. Specifically, as the lock,
>> if at all (i.e. if this is not a client driver bound to the controller),
>> must be held not only during submission but until the request has been
>> completed. Note that if we would hold the lock during submission, this
>> is just a smoke-test.
> 
> Ack.
> 
> <more snip>
> 
> Regards,
> 
> Hans
> 
