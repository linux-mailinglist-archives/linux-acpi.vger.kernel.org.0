Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8553E484E
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Aug 2021 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhHIPGj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Aug 2021 11:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234721AbhHIPGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Aug 2021 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628521578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1BLMAe5YsS6aV52djyyk9gFPnC1TzrPzUp84kLJoV0=;
        b=Wg8EDEK8UXB4fxQebAsDYncRFJ3qKb5DVkl1kmhbzg7T/eSIEamz1bm26Im6JXwe/UAk6X
        l84WHYw7dW0uNjE/MECa8MaAr3G/MD5ARGWLSJOo4NXpdQKCAjSaQU0PhK0nrjGxcn9aHu
        3vAe81ccvLccYQULLoErnNNNmltxksA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-6c5GmzsMP6-qK56oFnNK3A-1; Mon, 09 Aug 2021 11:06:16 -0400
X-MC-Unique: 6c5GmzsMP6-qK56oFnNK3A-1
Received: by mail-ej1-f70.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so4599429ejv.10
        for <linux-acpi@vger.kernel.org>; Mon, 09 Aug 2021 08:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1BLMAe5YsS6aV52djyyk9gFPnC1TzrPzUp84kLJoV0=;
        b=k+h00an5vtVA8XNVFY8oxA8eG6VMh0Xllgf7tgnirIR6ygGH5e4+n/R+cT71Mhdyme
         ADETz21Gh1a5ey9oWKIdgn6+X7yJefiNBXbKAW0RsNsbW+M/JMU+BipNU3jri+0sYQDs
         3prYnN2WSf8xv+LFqtqP5wwtj6ENsnZ/2pgYVazSAkQq/ohE8s9i8dP7HhATBTDONkx8
         KIDBO5WTEcuBXCSikIPRQuLxo7JBTZH9oUEtoOsOD5Z25KRZIZBUxP8KjYfM3xqdLNb/
         qP77+8dar0tRU/bDTr5qchS88p7+v3hRVjHcegWhC6tFBMkRFiwS6iqwC7ZzXKB8QMAs
         3fGQ==
X-Gm-Message-State: AOAM533RttzzJWmda8I6Evw3jjPjBtdRsb6aJBC1XlsleP/BLxPopbWy
        OpgmbKzGC+E1TFo27ue33mc3c+Fr+3e5mpy6J3UqQUtzxUpJ1wf7B+ZEu5dvRlZMXpLBLrFEsUB
        d6fT+vRTf9ccG6KIhdv6hgg==
X-Received: by 2002:a05:6402:74f:: with SMTP id p15mr29862207edy.195.1628521575646;
        Mon, 09 Aug 2021 08:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGmpo104C/++Uzh5sWBJQXUsPCqYIp8y6Z6w9HHNDWz0IZVjnC6MCm5jA2s+22Kof9tzWCMw==
X-Received: by 2002:a05:6402:74f:: with SMTP id p15mr29862184edy.195.1628521575511;
        Mon, 09 Aug 2021 08:06:15 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id j5sm8144667edv.10.2021.08.09.08.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 08:06:14 -0700 (PDT)
Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Stephen MacNeil <macneisj@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
 <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
 <BN9PR12MB505286920B83D4C71AC81E3CA0EE9@BN9PR12MB5052.namprd12.prod.outlook.com>
 <e11ce06f-8a5d-345a-5113-dd8802e9a0b9@amd.com>
 <eab56fac-175b-29b7-f66b-398b6477f390@redhat.com>
 <20210803002018.GH2563957@hr-amd>
 <BYAPR12MB3238DC9B9BBDF9B21C430646FBF09@BYAPR12MB3238.namprd12.prod.outlook.com>
 <f258d6c6-d022-4ab9-a4c9-d38122f3b8e4@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9a28cfd1-9756-0e87-68a6-b30e6e23beee@redhat.com>
Date:   Mon, 9 Aug 2021 17:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f258d6c6-d022-4ab9-a4c9-d38122f3b8e4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/9/21 4:39 PM, Limonciello, Mario wrote:
> This thread is a mix of top posting and bottom posting and confusing to follow.  Some inline comments below.
> 
> On 8/2/2021 21:42, Liang, Prike wrote:
>> [Public]
>>
>> In the AMD existing S0ix system seems needn't monitor SFH idle state, meanwhile SFH is powered by S5 rail and the rail keeps ON when SOC is in S3/S0i3 state. Regards to SFH stop working after S3 resume maybe caused by power rail and device context tear down during S3 suspend. In addition, we also need implement SFH suspend callback in amd-sfh-hid like as other vendor.
> 
> I think PM callbacks for SFH will resolve the issue at hand and are the most likely the correct solution in this instance.

Ack.

> 
>>> -----Original Message-----
>>> From: Huang, Ray <Ray.Huang@amd.com>
>>> Sent: Tuesday, August 3, 2021 8:20 AM
>>> To: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Shah, Nehal-
>>> bakulchandra <Nehal-bakulchandra.Shah@amd.com>; Stephen MacNeil
>>> <macneisj@gmail.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
>>> Rafael J . Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
>>> pm@vger.kernel.org>; linux-acpi <linux-acpi@vger.kernel.org>; Natikar,
>>> Basavaraj <Basavaraj.Natikar@amd.com>; S-k, Shyam-sundar <Shyam-
>>> sundar.S-k@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>>> Subject: Re: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
>>>
>>> + Prike
>>>
>>> On Mon, Aug 02, 2021 at 01:43:01PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 8/2/21 11:34 AM, Basavaraj Natikar wrote:
>>>>> On 8/1/2021 5:15 PM, Shah, Nehal-bakulchandra wrote:
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>> Adding few more folks
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>>> Sent: Sunday, August 1, 2021 3:17 PM
>>>>>> To: Stephen MacNeil <macneisj@gmail.com>; Limonciello, Mario
>>>>>> <Mario.Limonciello@amd.com>; Rafael J . Wysocki <rjw@rjwysocki.net>
>>>>>> Cc: Linux PM <linux-pm@vger.kernel.org>; linux-acpi
>>>>>> <linux-acpi@vger.kernel.org>
>>>>>> Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
>>>>>>
>>>>>> Hi Rafael, Mario,
>>>>>>
>>>>>> Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapad
>>> model) where Linux defaults to using S3/deep suspend instead of S0ix/s2idle.
>>>>>
>>>>> Hi Hans, Et al.
>>>>>
>>>>> Looks like the Lenovo platform Stephen MacNeil is using does not support
>>> the S2Idle as the FADT flags as not set (looking at the output of the script).
> 
> So Lenovo intends the platform to be S3 this means.

Ok.

>>>>
>>>> I believe it does, if it would not support s2idle at all, then this
>>>> would not be offered as an option in the "cat /sys/power/mem_sleep"
>>> output.
> 
> I don't believe this to be correct.  s2idle is always added.
> 
> You can look at the comments (and in the code) to see this:
> https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/kernel/power/suspend.c#L174

Ah, I was under the impression that s2idle would only be shown and be supported 
by the kernel when advertised as supported by the ACPI tables. So this is all just
my bad and in this case it indeed seems the intention of the vendor (Lenovo)
that the laptop will use S3 for suspend.

Sorry for the noise / confusion.

Regards,

Hans

