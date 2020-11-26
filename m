Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3F2C522B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 11:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgKZKga (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 05:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgKZKga (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Nov 2020 05:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606386989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPDoUGqQUZE3uOuQTeXyhdS26UrKjbT7KQQwgL6gki0=;
        b=D8L19WcXH3HPIEK0Eh+00l3UBi0o4Ts859JHvd9WQ1kUe5ie3wfnO/YCr+1OhppiJxYvKS
        IZ9G72q3edmV5WnUCi+FRc8tKte8n017tKNgIOvHwgauun34MmWeKDgrXOPG35FaQGyWuA
        sIYQNglCM5/dF4TgDbrKF1WZXw8XlWU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-8ltNPWckM36HvVUgxnsBSQ-1; Thu, 26 Nov 2020 05:36:27 -0500
X-MC-Unique: 8ltNPWckM36HvVUgxnsBSQ-1
Received: by mail-ed1-f71.google.com with SMTP id o11so871081edq.5
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2020 02:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPDoUGqQUZE3uOuQTeXyhdS26UrKjbT7KQQwgL6gki0=;
        b=rzZLeAL6LGgPO97KTSXRWM2eEWDReWEUgYusRBAxcCUGsvHo03/G5J83dxVrpNIfnd
         0zxYzMj0jLcFJWxCLK1WvbnzBdVrJzmtVjx1EWcDqaCUH9R8aXD3P4trW2dVX76R59j3
         tL9Vz8G3URtUD9nZkcC0GHLy9gTVet8xS8cHcI0TmubmRo04U98Cyh403vPGlBzkd3A/
         JprTZ9V9JGkojbrBZpE86Bv/IIpKWoOau3S6Q0fJBJS0ew/HGcX0+efl1i33aTSY2MFA
         X0CoMT8ZxIhGRCTFLzaqmz2B04qTPh2zmaDiG3SIJbHY0QOPR7xlJp//C/FSk71GSxON
         zJ8w==
X-Gm-Message-State: AOAM532b4cq06SaNA2XwkCM2cihyktCEyXQ3xnVW73G7g9jilfJwTQ42
        CkHuVPRBhVpzQrGJX5oNOnF+etFyg9Ate+DLG6/FTwi5tmEWDvN4HDaOoRgayvQ51YIhCEfZS2R
        wUR3c3Y6ku+83mTSVRghg3Q==
X-Received: by 2002:a17:906:5a8b:: with SMTP id l11mr1897274ejq.99.1606386985771;
        Thu, 26 Nov 2020 02:36:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbUOXuvfqs9aQrq6zgmCyzmAWsCx6BeBujPO7apZ2SMqzWEGeNdoESK3QIgFrbzXNgzFElVw==
X-Received: by 2002:a17:906:5a8b:: with SMTP id l11mr1897253ejq.99.1606386985575;
        Thu, 26 Nov 2020 02:36:25 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i9sm2752224ejf.41.2020.11.26.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 02:36:24 -0800 (PST)
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
To:     Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <markpearson@lenovo.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201115004402.342838-1-markpearson@lenovo.com>
 <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
 <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
 <27a41e3d678f9d7fc889a3a77df87f9ed408887d.camel@hadess.net>
 <92a564fa-686f-455d-a0cb-962d4d87a8c7@redhat.com>
 <4e82d54f-33c2-e880-c5f8-beb9d3460cdb@lenovo.com>
 <2207fea9195877a7ac6d6d203d9f81d07362a80f.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <64447d3f-c328-aef2-cd29-a9eed10ff27e@redhat.com>
Date:   Thu, 26 Nov 2020 11:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2207fea9195877a7ac6d6d203d9f81d07362a80f.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/25/20 11:32 PM, Bastien Nocera wrote:
> On Wed, 2020-11-25 at 14:41 -0500, Mark Pearson wrote:
>> On 25/11/2020 11:42, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11/24/20 4:30 PM, Bastien Nocera wrote:
>>>> On Sat, 2020-11-21 at 15:27 +0100, Hans de Goede wrote:
>>>>> Hi,
>>>>> On 11/20/20 8:50 PM, Barnabás Pőcze wrote:
>>>>>> Hi
>>>>>> 2020. november 15., vasárnap 1:44 keltezéssel, Mark Pearson
>>>>>> írta:
>>>>>>
>>>>> Bastien, what do you think about Barnabás' suggestion to always
>>>>> have the files present and use poll (POLL_PRI) on it to see
>>>>> when
>>>>> it changes, listing maybe "none" as available profiles when
>>>>> there
>>>>> is no provider?
>>>>
>>>> Whether the file exists or doesn't, we have ways to monitor it 
>>>> appearing or disappearing. I can monitor the directory with
>>>> inotify
>>>> to see the file appearing or disappearing, or I can monitor the
>>>> file with inotify to see whether it changes.
>>>
>>> Ok, do you have a preference either way? I personally think having
>>> the file only appear if its functional is a bit cleaner. So if it
>>> does not matter much for userspace either way then I suggest we go
>>> that route.
>>>
>> My (limited) vote is having the file appear when the profile is
>> loaded 
>> seems nicer (and to disappear if the profile is unloaded). No
>> profile, 
>> no interface just seems elegant.
>>
>> I pretty much have v4 of the patches ready to go (I wanted to rebase
>> on 
>> the update for the palm sensor and finished that today). I'm happy to
>> hold off on them until we're ready if that helps. Bastien - let me
>> know 
>> if it would be useful to have a version to test against to see what
>> will 
>> work best for you, or if you need something different. Definitely
>> want 
>> to make sure user space gets the best option as my understanding is 
>> changing this later becomes a pain :)
> 
> I don't have the hardware. I agree with you that "no profile = no file"
> seems cleaner, but whichever is easier for you.

Ok, lets go with that then (so same as in v3).

Mark, if you can submit v4 upstream that would be great.

Regards,

Hans

