Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88A1C8379
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGHe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 03:34:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36704 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgEGHe0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2020 03:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588836864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MeDJJkeZkfIUP2ENgGgo4J+mwsTymvC5FYKYaDXT88=;
        b=ZnelxlsOvhNgvnp/l8RT9iyse+LD6+Np+J3qOeAwyHSNp3FKiyOnfG2xvpHbqHRExDqdZL
        CLAad//rKrWoYSqwwIWuuAsN2/+NpiNpgI/IsFJa++O1N62iIS5Y6Rb0bx16YkOdY3kX7e
        DSzAF5W5apoLDJ2CpN7PLHxTeslbjS0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-yb_M_M3xPEa3J2yKHeiHig-1; Thu, 07 May 2020 03:34:22 -0400
X-MC-Unique: yb_M_M3xPEa3J2yKHeiHig-1
Received: by mail-wm1-f72.google.com with SMTP id j5so2829986wmi.4
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 00:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MeDJJkeZkfIUP2ENgGgo4J+mwsTymvC5FYKYaDXT88=;
        b=e6fWZFgm4jWiDkLSP87YJVS+r3PN7kk1/X+41HmJ9YQotjQ1pM0lL9N3ymHdNNwxHT
         Sdo9xf8kdAVjezCHMJRNlBAqociMhHgLuhVacQr71jc/wcTGR0GQixTTnFvVpkS3zlp5
         LXYZcHTZclhspgrNHRWVj2cZrq4KOq+p1bbbjcKnqs940R8bZ4O9a2hszX0IAI9kj5fT
         S0xtslYZ4zzU0ei8qb03xl0nVNboN7JlD1i36js8NWfFPL+SsULwQtN4yjhn2HR0AJN8
         YOmL12GjpBAo52L2taF3sJ6mCTdIJltKi7qFxTlVoPgYL0+FOfkXaw1khHjI7Low58sY
         0sMQ==
X-Gm-Message-State: AGi0PuajL266AC8FIz44Tj4eGZbvEHyH+++naTy8RmruCgDPQkdTBYUv
        I8sXva07S5l3iJjHYv2UeFa1IC281D0IIh2Spr5eplBhQ/PcYe63BFJuPU2zZwsLxxTFk9ut4wU
        BmjRv0f+iyrB5YX8jXxgQog==
X-Received: by 2002:adf:9447:: with SMTP id 65mr14166846wrq.331.1588836861076;
        Thu, 07 May 2020 00:34:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKutypP8jB8f00QrCvUC8XWvQORxO6DQimEGK8PGZjeWpU4RJslALk9u9373vjaG6fFEI4ASw==
X-Received: by 2002:adf:9447:: with SMTP id 65mr14166828wrq.331.1588836860870;
        Thu, 07 May 2020 00:34:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 17sm6437189wmo.2.2020.05.07.00.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 00:34:20 -0700 (PDT)
Subject: Re: 5.6 regression caused by "ACPICA: Dispatcher: always generate
 buffer objects for ASL create_field() operator"
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        Mattia Dongili <malattia@linux.it>,
        William Bader <williambader@hotmail.com>,
        Dominik Mierzejewski <dominik@greysector.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <49f20a91-9362-6249-d413-1461258d56a9@redhat.com>
 <11795a75-70de-5fcc-878f-14a0381947ea@gmail.com>
 <BYAPR11MB3096868FE8523B2F94A50F9DF0A70@BYAPR11MB3096.namprd11.prod.outlook.com>
 <7fb8757c-41e7-3be0-5552-80696559bdfe@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4443e82e-6c1f-696f-1f16-12b1c0c33b13@redhat.com>
Date:   Thu, 7 May 2020 09:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7fb8757c-41e7-3be0-5552-80696559bdfe@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/6/20 7:21 PM, Rafael J. Wysocki wrote:
> On 5/6/2020 12:11 AM, Kaneda, Erik wrote:
>>
>>> -----Original Message-----
>>> From: linux-acpi-owner@vger.kernel.org <linux-acpi-
>>> owner@vger.kernel.org> On Behalf Of Maximilian Luz
>>> Sent: Tuesday, May 5, 2020 6:50 AM
>>> To: Hans de Goede <hdegoede@redhat.com>; Wysocki, Rafael J
>>> <rafael.j.wysocki@intel.com>; Moore, Robert <robert.moore@intel.com>;
>>> Kaneda, Erik <erik.kaneda@intel.com>; Mattia Dongili <malattia@linux.it>;
>>> William Bader <williambader@hotmail.com>; Dominik Mierzejewski
>>> <dominik@greysector.net>
>>> Cc: linux-acpi <linux-acpi@vger.kernel.org>; Darren Hart
>>> <dvhart@infradead.org>; Andy Shevchenko <andy@infradead.org>;
>>> platform-driver-x86@vger.kernel.org
>>> Subject: Re: 5.6 regression caused by "ACPICA: Dispatcher: always generate
>>> buffer objects for ASL create_field() operator"
>>>
>>> On 5/5/20 2:55 PM, Hans de Goede wrote:
>>>> Hi All,
>>>>
>>>> Commit 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
>>>> objects for ASL create_field() operator") has dropped the automatic
>>>> conversion of small buffers into integers.
>>>>
>>>> But some drivers relied on this automatic conversion, these drivers
>>>> have checks like this:
>>>>
>>>>           if (object->type != ACPI_TYPE_INTEGER) {
>>>>                   pr_warn("Invalid acpi_object: expected 0x%x got 0x%x\n",
>>>>                                   ACPI_TYPE_INTEGER, object->type);
>>>>                   kfree(object);
>>>>                   return -EINVAL;
>>>>           }
>>>>
>>>> This specific bit comes from the sony-laptop (platform/x86) code, the
>>>> ACPICA change has broken this code, causing systems using this driver
>>>> to hang on resume from suspend.
>>>>
>>>> We have multiple bug-reports open for this already:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=207491
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1829096
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1830150
>>>>
>>>> Mattia Dongili, the sony-laptop driver has already submitted a fix for
>>>> this upstream, adjusting the sony-laptop driver to deal with the
>>>> returned object type now being a BUFFER.
>>>>
>>>> The goal of this email is to:
>>>>
>>>> 1. Make everyone involved aware of this breakage as we may see similar
>>>> breakage elsewhere.
>>>>
>>>> 2. Discuss if we should maybe revert the ACPICA change.
>>>>
>>>> If you are reading this then 1. has been accomplished :)
>>>>
>>>> Which leaves us with 2. I'm tending towards keeping the change, since
>>>> it seems the right thing to do and dealing with the fallout. But since
>>>> there is fallout we should also at least consider reverting the ACPICA
>>>> change.
>>>>
>>>> So ACPI maintainers what is you take on this ?
>> What a mess. Several thoughts...
>>
>> I think we should keep the internal AML interpreter behavior as is because it solves a problem.
> 
> I also would prefer to deal with the fallout rather than to revert the fix.
> 
> I think that the potential damage is limited and the affected driver code should be fixed anyway which may not happen if the change in question is reverted.

Ok, so it seems that we are all in agreement to NOT revert and to deal
with any (other) fallout instead.

Andy / Darren can you get the sony-laptop fix merged and on its way
to Linus as a fix please?

Regards,

Hans

