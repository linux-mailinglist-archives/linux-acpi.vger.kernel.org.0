Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9021B525
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jul 2020 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJMfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jul 2020 08:35:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726828AbgGJMfj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2020 08:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594384537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RMR1q5ma/qlcL/rWzZWtUeYlByUhZI934Q15lRAwoA=;
        b=MxvpTzgEPwbZOKFSFEPVz9kY93yORk01Kt9nLPCBpFz8lR1CnKovUtLn4yitiUcwqY/GAm
        AGUbV/97nkLvTd6jdlUKcdXXgoXdci1U5uYg+o9wskaCPeZ4FQLSTKiIUQYQIDUjRuL6OI
        AHGupfrW4aC//9bYBfLSKJj5g3dtsbw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-mQYqg-jlND-3bUWSTEFx8g-1; Fri, 10 Jul 2020 08:35:34 -0400
X-MC-Unique: mQYqg-jlND-3bUWSTEFx8g-1
Received: by mail-ej1-f69.google.com with SMTP id cf15so6301154ejb.6
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2020 05:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RMR1q5ma/qlcL/rWzZWtUeYlByUhZI934Q15lRAwoA=;
        b=ld65DIEQ6PiWfbufJ/dwqn7Aak4K/FMtitGAwAJLY3Lmo3SxaPyq+i8iN92cwujM0n
         KiSUmRTSpMIIjnpYpT3AX6iyvL2JVPd+eQJ4Jl4rZNl5PJKv85NWFGSlQeAwu/Sbzp7Q
         PEcq7BpkCIFAYGuojxP4E+VPE1RdkG7FIL3Q2sADsToqZZHhBdMxCsZvy0h6LuW2D+9E
         m63Yo3fRUCVkmiN63ryKoKJCyRHMg7vBizHq4iiHnSTCeDbKILy5xvUc4j4szU4i4hwa
         9FBIITl/DpJCLNubdPR5A6BDiZmfd3OAXtISnYGUTy56EPF99LT4yQhFtSbxy7r9CSV8
         4+Jg==
X-Gm-Message-State: AOAM530G8LAK1LoErUd+Ox/Y77jroSNEmIv4mVy2rPXvF/y97TQAhwL9
        m10sTqJTkRNKSDTd/gB2eR2fKOghmI/8Y9TU8++naFkfpdbDCuZZA60m4o5dcY5fPPZelKcfUJc
        6CtcOMjsHfPNgrAZi6ZUang==
X-Received: by 2002:a17:906:824c:: with SMTP id f12mr59883847ejx.443.1594384532982;
        Fri, 10 Jul 2020 05:35:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJSdz5iXaT7LBc+SfW2UuC98xoejhyGgvRs6n/WSO6R6iCQrT1lQg+fIVEx6s1Ln1cXR3huA==
X-Received: by 2002:a17:906:824c:: with SMTP id f12mr59883830ejx.443.1594384532753;
        Fri, 10 Jul 2020 05:35:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v19sm4309167eda.70.2020.07.10.05.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 05:35:32 -0700 (PDT)
Subject: Re: [Bug 1854502] New: Noticeably Increased CPU temperature
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <bug-1854502-8448@https.bugzilla.redhat.com/>
 <9b3d85b5-b562-631f-adfd-6460bc6c4179@redhat.com>
 <CAJZ5v0gO7b8X6MMDO_UvGBc-PNH-o=U47+MuS1uk4E_tSF-Ogg@mail.gmail.com>
 <db2b75b7-afc9-7a44-762f-2a4ebd63b4ee@redhat.com>
Message-ID: <e330796c-fbad-c8d9-f334-c2e5bf156d3f@redhat.com>
Date:   Fri, 10 Jul 2020 14:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <db2b75b7-afc9-7a44-762f-2a4ebd63b4ee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/9/20 2:31 PM, Hans de Goede wrote:
> Hi,
> 
> On 7/7/20 5:43 PM, Rafael J. Wysocki wrote:
>> Hi Hans,
>>
>> On Tue, Jul 7, 2020 at 5:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> I got a copy of the below bugreport in my mailbox and I
>>> was wondering if this rings any bells.
>>>
>>> Are there any relevant power-management / scheduler
>>> changes in 5.7 (vs 5.6) which might be related?
>>
>> There were a few, but I'm not sure how they can cause thermal issues to happen.
>>
>>> And is there any quick way for the reporter to test this
>>> (by e.g. picking a different scheduler / cpufreq-governor).
>>
>> Well, as usual, I would recommend looking for possible configuration
>> differences between the good and bad cases, ie. different default
>> governors, different cpufreq/cpuidle drivers etc.
>>
>> Also, if the system is Intel-based, run turbostat to collect CPU PM
>> information for both the good and bad cases.
> 
> Ok I've asked the user to run some tests and provide powertop
> and turbostat outputs for both the cold and hot cases.
> 
> I will follow-up on this when I know more.

Ok, I've asked the user to gather the necessary info. He has collected
screenshots from both powertop and turbostat under both 5.6 (with the
CPU staying cool) and with 5.7 (where the CPU runs a bit hot) both with
the system fully idle.

The screenshots are attached to the bug as a tarbal:

https://bugzilla.redhat.com/show_bug.cgi?id=1854502

I've never looked at turbostat output before so I do not know what
I'm looking for there. But the powertop output does show a significant
difference.

On the powertop overview page we can see that 5.7 has slightly less
wakeup then 5.6 (probably just normal variation) but despite this,
the "idle stats" page shows that under 5.6 we get 90/91% C7 residency,
where as 5.7 only reaches 85%, that seems like a significant difference
to me. IOW the CPU is in a higher powerstae (consuming more power) for
15% of the time with 5.6, vs 10% with 5.7.

Note that this users system is somewhat customized, he is using
bumblebee with the nvidia binary driver to run games, while
using the i915 gfx for his normal desktop stuff. Doing his
tests no apps are running using the nvidia GPU and in both
cases the nvidia GPU is powered-down (according to the /proc/...
info).

He is also using TLP and some utility to undervolt the GPU. None
of this seems to explain the C7 residency difference though, so
despite his non-standard setup it would be good (IMHO) to still
see if we can try to root-cause that.

Regards,

Hans






>>> -------- Forwarded Message --------
>>> Subject: [Bug 1854502] New: Noticeably Increased CPU temperature
>>> Date: Tue, 07 Jul 2020 15:23:38 +0000
>>> From: bugzilla@redhat.com
>>> To: hdegoede@redhat.com
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1854502
>>>
>>>               Bug ID: 1854502
>>>              Summary: Noticeably Increased CPU temperature
>>>              Product: Fedora
>>>              Version: 32
>>>             Hardware: x86_64
>>>                   OS: Linux
>>>               Status: NEW
>>>            Component: kernel
>>>             Severity: medium
>>>             Assignee: kernel-maint@redhat.com
>>>             Reporter: aria.aghazade@gmail.com
>>>           QA Contact: extras-qa@fedoraproject.org
>>>                   CC: acaringi@redhat.com, airlied@redhat.com,
>>>                       bskeggs@redhat.com, hdegoede@redhat.com,
>>>                       ichavero@redhat.com, itamar@ispbrasil.com.br,
>>>                       jarodwilson@gmail.com, jeremy@jcline.org,
>>>                       jglisse@redhat.com, john.j5live@gmail.com,
>>>                       jonathan@jonmasters.org, josef@toxicpanda.com,
>>>                       kernel-maint@redhat.com, lgoncalv@redhat.com,
>>>                       linville@redhat.com, masami256@gmail.com,
>>>                       mchehab@infradead.org, mjg59@srcf.ucam.org,
>>>                       steved@redhat.com
>>>     Target Milestone: ---
>>>       Classification: Fedora
>>>
>>>
>>>
>>> First things first, I'm running Fedora 32 with latest packages on intel 6700hq.
>>> With latest kernel-5.7, cpu temperatures are noticeably higher.
>>> Using kernel-5.6 my idle cpu temperature is around 35-40°C, but with kernel-5.7
>>> its around 50-55. Htop and KDE System Monitor don't show anything using cpu and
>>> idle cpu usage on both kernels is 0-2%.
>>>
>>> I first noticed this issue on kernel-5.7.6-201.fc32.x86_64, and it is also
>>> there with kernel-5.7.7-200.fc32.x86_64.
>>>
>>> Booting with kernel-5.6.19-300.fc32.x86_64 fixes the issue.
>>>
>>>
>>> Are you running any modules that not shipped with directly Fedora's kernel? No.
>>

