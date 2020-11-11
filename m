Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA132AEEC3
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 11:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKKK3a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 05:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbgKKK3a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Nov 2020 05:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605090568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cWzQirp89MqvBGKD7feVetENzzO1kweGW8V2WA2ajE=;
        b=PA1cpF6WGoaXZa/nXxMGHrtxyfKu/0jxb3SvLTWdsqZmf/5DWS0Ls1BfmuFWt8Ywtyn/dh
        EuqerDkEGMQUmqOZPsQLMD9+AROOgCLt1yDAql6ZbiW957q5EMXOTB60C6lHr+zSrA4g7I
        1j+FvW73J+67WKRuiaY+UOooah8OVaI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-PGOXpQNSMIOC9Np3dJBGpg-1; Wed, 11 Nov 2020 05:29:26 -0500
X-MC-Unique: PGOXpQNSMIOC9Np3dJBGpg-1
Received: by mail-ed1-f72.google.com with SMTP id bc27so667677edb.18
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 02:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6cWzQirp89MqvBGKD7feVetENzzO1kweGW8V2WA2ajE=;
        b=mdGQ5AKa3qu//WW+82ra3B7Zta1h1p9sOzupzLi3jCJODttUYlBLvyo80SQfmKfICn
         mNfWo7VdzmNsFIZbllkS54vgMELi+SFxCk8oDgwavVQYF3sxb+aavEEelDqK2MVcEzrU
         JmMuXEYkMcN9WyQwgt/AfoCMLMfOwfHCYCvfMGxSIiWFVsmCgbga7uqx0hVueYFGCray
         J+egIgh1kag5iB1OdBCY5d4vP+t+CgXlfvYeVs/KYCdK0b8LEWv5g81KEczTmxdzLnn+
         f8rIinuGRoqSxCwnSVFejVDG/EK1BjRicJCoBws+5tmMlCASVj2P0pnWxBxrljwsdEju
         dnrQ==
X-Gm-Message-State: AOAM533JOOYOoovbP/DtY9L4JCvHB0b1NYEbUde2yAwpTbiLYYvPlIIs
        T15RykJvnDCLz5QiC4XFPY5WW8f95vXD/0jvtlfxkAyLimdVpr51bxV1FEHWIlqe3ZRx8dP8OuK
        NeExaji8x2QBSXw6w9dl9DQ==
X-Received: by 2002:a17:906:f186:: with SMTP id gs6mr25435907ejb.171.1605090565302;
        Wed, 11 Nov 2020 02:29:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjzxV9wekN4dOqJBwNAGPRIchMxZTQry8R7IcifjjunD6bcewyyPOkNdX01YrOA2ONYvFvxw==
X-Received: by 2002:a17:906:f186:: with SMTP id gs6mr25435891ejb.171.1605090565051;
        Wed, 11 Nov 2020 02:29:25 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id hp27sm670698ejc.2.2020.11.11.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 02:29:24 -0800 (PST)
Subject: Re: [External] Re: [PATCH 2/3] ACPI: platform-profile: Add platform
 profile support
To:     Mark Pearson <markpearson@lenovo.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-3-markpearson@lenovo.com>
 <2gY5rkKaKLKayk0DYW0lvZ_aIAs8vSf9FOy2obdGvph_7XcpyHlkafBTpW8RHKC5nEcEz_eY-s4pJtuR2ebltW2Fu10GRssTmMxKMuS4PU8=@protonmail.com>
 <72b0fb0a-8007-d795-8b1a-68fa58231c23@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f4994ff1-ec00-5abe-039a-c7e8524ea054@redhat.com>
Date:   Wed, 11 Nov 2020 11:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <72b0fb0a-8007-d795-8b1a-68fa58231c23@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/10/20 3:32 PM, Mark Pearson wrote:
> Thanks Barnabas
> 
> On 10/11/2020 05:15, Barnabás Pőcze wrote:
>> Hi
>>
>> I've added some questions and comments inline.
>>
>>
>>
>> 2020. november 10., kedd 4:31 keltezéssel, Mark Pearson írta:

<snip>

>>> +    "Low-power",
>>> +    "Cool",
>>> +    "Quiet",
>>> +    "Balance",
>>> +    "Performance",
>>> +    "Unknown"
>>
>> "unknown" is not documented, yet it may be returned to userspace.
> Ack - I'll look into if it's really needed, but it seemed sensible to have it whilst doing the implementation.


AFAIK with the currently agreed upon version of the API we do not need this,
please remove it. We can always add it later if necessary, but for now I would
like to avoid drivers being tempted to use this.

Regards,

Hans

