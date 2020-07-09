Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446321A00D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGIMbk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 08:31:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgGIMbj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 08:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594297897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Vo20j4iMPqrhoCqwlLsKel/ltj0qPrKZtzlPUStUTw=;
        b=gkuhtYvCf19Txj/FFPYg6dCvnmN+gnupfHmnz4qldLqhk7ZB6mEWeLu8OuUqv1GR9VkYNV
        oxqkeGAnXq2kpR8uTwGEfuw+YAcqe2za+gOUoAouX6RgFKoR/Xusj1t/NHeA9f/vaht+4R
        EYxxyAT7PlRhXAwzqR/pTN4/HMATQhM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-isAUDcAbMtuGzhyq_djLYg-1; Thu, 09 Jul 2020 08:31:36 -0400
X-MC-Unique: isAUDcAbMtuGzhyq_djLYg-1
Received: by mail-wm1-f72.google.com with SMTP id q20so2012276wme.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2020 05:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Vo20j4iMPqrhoCqwlLsKel/ltj0qPrKZtzlPUStUTw=;
        b=mEdXtSW04I8PDqckQSLxYl+Bw7KqgbBG5wAnNiB/mv6nQON7EXvpvkDd8OvwW8S+PB
         sQEd81CRoN0NXgCvPJ5ehLfo69n7yJ7yCpK5J5lrVvfVVLpjdjhKENrJPB4hQgR+2QLN
         4DsIcII6RDMneDAWsU3gjyyiLWnWC+nT5KrVBZc7AYshlBDn6tWpcNVeFEbwGBJDGSp6
         guZbQrZZ/HOghvoo3l047I2esbAgjcIHgOztFFt6M/CwRd4LvuKL2/qFoQUfWP5GkYbS
         /Wh6bbzeHpTdz7SuQOBAFV9diwE0xbkdK3jEcMI4KzNjRId5Tt9sa1U4lVhTPdfSKc50
         ZNtg==
X-Gm-Message-State: AOAM531j/SqEsLU1A3u/2eZCW9szC1WQBy61vN55GtgJNxg5zho+HuUV
        nlrWQJ4vfzkDr6Qr6cwVI5dq38ilKWdbNkwlZ1EGypCFJT/DmbgseaSUDOvbDUpuom+fhWDhpfc
        Wv6KomzaUu+aflBNToI0Hew==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr68008322wrq.38.1594297895025;
        Thu, 09 Jul 2020 05:31:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhE3xnq9hkLPcgI4Y01gRttHJDRLv5NUTk2EJrnU3U0buw0nCVfRWQuBAQIn/0DuJG0skEOQ==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr68008299wrq.38.1594297894756;
        Thu, 09 Jul 2020 05:31:34 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id k126sm4748329wmf.3.2020.07.09.05.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 05:31:34 -0700 (PDT)
Subject: Re: [Bug 1854502] New: Noticeably Increased CPU temperature
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <bug-1854502-8448@https.bugzilla.redhat.com/>
 <9b3d85b5-b562-631f-adfd-6460bc6c4179@redhat.com>
 <CAJZ5v0gO7b8X6MMDO_UvGBc-PNH-o=U47+MuS1uk4E_tSF-Ogg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db2b75b7-afc9-7a44-762f-2a4ebd63b4ee@redhat.com>
Date:   Thu, 9 Jul 2020 14:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gO7b8X6MMDO_UvGBc-PNH-o=U47+MuS1uk4E_tSF-Ogg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/7/20 5:43 PM, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Tue, Jul 7, 2020 at 5:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> I got a copy of the below bugreport in my mailbox and I
>> was wondering if this rings any bells.
>>
>> Are there any relevant power-management / scheduler
>> changes in 5.7 (vs 5.6) which might be related?
> 
> There were a few, but I'm not sure how they can cause thermal issues to happen.
> 
>> And is there any quick way for the reporter to test this
>> (by e.g. picking a different scheduler / cpufreq-governor).
> 
> Well, as usual, I would recommend looking for possible configuration
> differences between the good and bad cases, ie. different default
> governors, different cpufreq/cpuidle drivers etc.
> 
> Also, if the system is Intel-based, run turbostat to collect CPU PM
> information for both the good and bad cases.

Ok I've asked the user to run some tests and provide powertop
and turbostat outputs for both the cold and hot cases.

I will follow-up on this when I know more.

Regards,

Hans


>> -------- Forwarded Message --------
>> Subject: [Bug 1854502] New: Noticeably Increased CPU temperature
>> Date: Tue, 07 Jul 2020 15:23:38 +0000
>> From: bugzilla@redhat.com
>> To: hdegoede@redhat.com
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1854502
>>
>>               Bug ID: 1854502
>>              Summary: Noticeably Increased CPU temperature
>>              Product: Fedora
>>              Version: 32
>>             Hardware: x86_64
>>                   OS: Linux
>>               Status: NEW
>>            Component: kernel
>>             Severity: medium
>>             Assignee: kernel-maint@redhat.com
>>             Reporter: aria.aghazade@gmail.com
>>           QA Contact: extras-qa@fedoraproject.org
>>                   CC: acaringi@redhat.com, airlied@redhat.com,
>>                       bskeggs@redhat.com, hdegoede@redhat.com,
>>                       ichavero@redhat.com, itamar@ispbrasil.com.br,
>>                       jarodwilson@gmail.com, jeremy@jcline.org,
>>                       jglisse@redhat.com, john.j5live@gmail.com,
>>                       jonathan@jonmasters.org, josef@toxicpanda.com,
>>                       kernel-maint@redhat.com, lgoncalv@redhat.com,
>>                       linville@redhat.com, masami256@gmail.com,
>>                       mchehab@infradead.org, mjg59@srcf.ucam.org,
>>                       steved@redhat.com
>>     Target Milestone: ---
>>       Classification: Fedora
>>
>>
>>
>> First things first, I'm running Fedora 32 with latest packages on intel 6700hq.
>> With latest kernel-5.7, cpu temperatures are noticeably higher.
>> Using kernel-5.6 my idle cpu temperature is around 35-40°C, but with kernel-5.7
>> its around 50-55. Htop and KDE System Monitor don't show anything using cpu and
>> idle cpu usage on both kernels is 0-2%.
>>
>> I first noticed this issue on kernel-5.7.6-201.fc32.x86_64, and it is also
>> there with kernel-5.7.7-200.fc32.x86_64.
>>
>> Booting with kernel-5.6.19-300.fc32.x86_64 fixes the issue.
>>
>>
>> Are you running any modules that not shipped with directly Fedora's kernel? No.
> 

