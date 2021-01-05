Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D122EA8B2
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbhAEK3p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 05:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728168AbhAEK3o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 05:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609842497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/PzuT8W4Gk8kdtnutOjrj+8T9fhgOEqAyz4kqoY0wI=;
        b=VHBd5fPMzqUv6SoTMBiEnRlJKpPyeG0FshTZa5jhKYZTdzKeblyQnxY76nsFZV03ewGCM3
        GIkCAHJTnm17uqqv2ZFf/kqiU1q5+RKi5sztZVWXRe21KOYhbnzytMbCkdP3aEGOyBnmdG
        1ztJrA0P3/eJyK8i2Kj4gl2wpJc2GWE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-HKlQMT4QOl2EPPvBZv3rWA-1; Tue, 05 Jan 2021 05:28:16 -0500
X-MC-Unique: HKlQMT4QOl2EPPvBZv3rWA-1
Received: by mail-ej1-f69.google.com with SMTP id k3so7821313ejr.16
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jan 2021 02:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M/PzuT8W4Gk8kdtnutOjrj+8T9fhgOEqAyz4kqoY0wI=;
        b=ZMPr3UUhOKMv15b9bd90cbCKEdmRi2JwKIuZwLCQdRo+Acby8xGhehZdTVqqSbc2wr
         9A4X69bixWGXLdnAUQ+0Bmu/5koZPkkP2tA2y2R/kcTkJgylKADq/pF6PxvbJYpl6dPZ
         IyOr0jk6g+qvVSJt8OOD5RlYeaiEU4O2/gVo3GEtyvGWsAMhQvWqp/D7shQ35SdSFwIk
         6RQ9W45zbjvcjDNeiXg6nCx6gwhDqdnT5gzqWUrNnJuP0JWhWmm9KB3bWU3KAc/cJlF6
         ScPQnR+A2Z/tdgzrkbmjYYjTvmYTEvumZQcY8ktLvLyqgktlVHlNEkolxYpO9exTjymy
         /PMA==
X-Gm-Message-State: AOAM533zsLV3rbkUj/qN5qM1g1LjNh8xQSWkqxo6t+aG/CYWxSs0BZAf
        +FvwWSuY8q3KPYMtmfN0037j1Y7kgP6hDa0RnM2SEEPv0wxPBX1fytP4WEoaWVgjH+3LwxLHE/Z
        m9dnCu/tqPVl/cAiRGzkixA==
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr31663029ejf.468.1609842494753;
        Tue, 05 Jan 2021 02:28:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVNx6QjYBlgEGbmPJZsFpcosRCwFj+dwg907DxGdL3NBnpYjCbNSdlKJycPZRmURvchwRyow==
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr31663019ejf.468.1609842494583;
        Tue, 05 Jan 2021 02:28:14 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id rk12sm24514865ejb.75.2021.01.05.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 02:28:13 -0800 (PST)
Subject: Re: [External] Re: [PATCH 0/2] IdeaPad platform profile support
To:     Mark Pearson <markpearson@lenovo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
 <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
 <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
 <2eefa5ec-4f09-eabd-2c20-f217fa084dfc@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8fd4abbd-41d4-9980-c7e5-e0f299bb96cf@redhat.com>
Date:   Tue, 5 Jan 2021 11:28:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2eefa5ec-4f09-eabd-2c20-f217fa084dfc@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/4/21 10:58 PM, Mark Pearson wrote:
> On 04/01/2021 15:58, Hans de Goede wrote:
>> Hi,
>>
>> On 1/4/21 9:33 PM, Rafael J. Wysocki wrote:
>>> On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com>
>>>  wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
>>>>> Tested on Lenovo Yoga-14SARE Chinese Edition.
>>>>>
> <snip>
>>
>>> Also, on a somewhat related note, I'm afraid that it may not be a 
>>> good idea to push this series for 5.11-rc in the face of recent 
>>> objections against new material going in after the merge window.
>>
>> That is fine with me, since this did not make rc1 (nor rc2) I'm not 
>> entirely comfortable with sending out a late pull-req for the pdx86 
>> side of this either, so lets postpone this to 5.12 (sorry Mark).
> It is what it is.
> 
>>
>> Rafael, once we have the discussion with the passing a pointer back 
>> to the drivers data thing resolved (and a patch merged for that if we
>> go that route) can you provide me with an immutable branch to merge
>> into pdx86/for-next so that I can then merge the pdx86 bits on top ?
>>
>> Note this does not need to be done right now around say rc4 would be
>>  fine, so that we have some time for the patches currently in 
>> bleeding-edge to settle a bit.
>>
> Just for my understanding of what happens next....please correct me if I
> have anything wrong:
> 
>  - platform_profile gets pulled from ACPI for 5.11
> 
>  - platform_profile gets updated to add this data/pointer implementation
> and goes into 5.12. Jiaxun, let me know if you're happy with following
> up on that based on Hans suggestions, If you are pushed for time let me
> know and I'll happily help out/implement/test as required. I sadly don't
> have any ideapads but very happy to support your efforts any way I can.
> 
>  - Can we get the x86 portion done at the same time or does that end up
> going to 5.13?

No, the plan is to get it all in 5.12. This is why I asked Rafael for
an immutable branch with the ACPI bits, then I can merge that branch
into pdx86/for-next and then apply the thinkpad and ideapad patches on
top, all for 5.12 .

Regards,

Hans

