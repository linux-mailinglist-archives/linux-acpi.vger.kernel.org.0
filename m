Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFE2C0C29
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbgKWNtX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 08:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729975AbgKWNtX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 08:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606139361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvd0YCV1krMC+A9mVNTyoOM/MhMjOOo/RnLo1Hj5q+A=;
        b=KhJIdZTCIMY+Xe58DoWo8q2p73sRgY6HLpzkO4xG2tShaulT81qTY2GMJFhU4tC4U87MRx
        pYmcJ3HDwnvCgEyJ9udqOsgre/IY3vUwhhevDntduZh7Gb847CmS1iOhXPR2TVSXGGvasH
        5j17E9TfbRLFWzwYPYHefLKE1H4AjGc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-2QkSHe9VOUmrz9BEcMEPoA-1; Mon, 23 Nov 2020 08:49:19 -0500
X-MC-Unique: 2QkSHe9VOUmrz9BEcMEPoA-1
Received: by mail-ej1-f71.google.com with SMTP id dx19so5599312ejb.7
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2020 05:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xvd0YCV1krMC+A9mVNTyoOM/MhMjOOo/RnLo1Hj5q+A=;
        b=KWrlhTzQvDRsrXT2E/Rn7z77iSehM9rWnD7v1ewd42HyDhkKaJVfIzDY63JZ8h/hvV
         Sz3Xgi5U/xv8svGISmHe1NDO/gJJL77jv78/NfcYqXtpaJHXD194A0cWh0nKlOidssu1
         4DicGzkEwrFSzgKwiVimAUL4PKxjb4DslS81SxBFNUXnHmGbMSZ228v6jHjwtmrYJarX
         nhoDGL2DdF2EYFHAM5OXqO7qgCSoz06qNp52DVTSJoXparnAxHFYpr/AstZTbyb4y9kk
         ybl+/5iHulhQPTWEUsFD/SkYtszEL4X95pqM1a1LvzvWNOgvO8O0Y3AUWzNX+nfMpNr7
         tdpg==
X-Gm-Message-State: AOAM533FRC+BRRZ9YaKD4bnHe26gQGffBNp6O/vvERDBIOa0SxNn4+TQ
        QEl1ysz0uC5/5YZZ7OC23BH39SkcWTIwT921Q/zXWRjEwxJ7rRxluxF72cRej2/H+jYrxCCAf3u
        9xGMfdzNyjyUAvyifakCdAbd/7tFRKymyjH0W2bFkjcV0YEvtNdhSCk4YJo6m0QSdq3ip8q4JUA
        ==
X-Received: by 2002:aa7:ce8d:: with SMTP id y13mr35203619edv.65.1606139358209;
        Mon, 23 Nov 2020 05:49:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYUfSjDxlojUPRQsBUWIGs+5LkrO1MswX7QC/wsLnswRNoxLRI92XfKB33U+woj7xXvaiiYg==
X-Received: by 2002:aa7:ce8d:: with SMTP id y13mr35203597edv.65.1606139357962;
        Mon, 23 Nov 2020 05:49:17 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id l8sm4992877ejr.106.2020.11.23.05.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 05:49:17 -0800 (PST)
Subject: Re: [PATCH 5/7] ACPI: scan: Add support for deferring adding devices
 to the second scan phase based on the _DEP list
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201121203040.146252-1-hdegoede@redhat.com>
 <20201121203040.146252-6-hdegoede@redhat.com>
 <CAJZ5v0i+Oz4meRo+YQw_LRZXReo9APh4kpqAP4Nby8_HExrrJg@mail.gmail.com>
 <f43be417-8919-6b4b-f554-32d71d81f8c0@redhat.com>
 <CAJZ5v0irXOGXr0R5xKudAJpBa1iFis3MwsPmAXJAVPBEGDRn3g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0ebdf010-6b1d-879e-84b3-0c099ed8a6dd@redhat.com>
Date:   Mon, 23 Nov 2020 14:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0irXOGXr0R5xKudAJpBa1iFis3MwsPmAXJAVPBEGDRn3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/23/20 1:41 PM, Rafael J. Wysocki wrote:
> On Mon, Nov 23, 2020 at 2:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/23/20 1:17 PM, Rafael J. Wysocki wrote:
>>> On Sat, Nov 21, 2020 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> The current solution, of deferring adding of some devices because they
>>>> need access during the OpRegions of other devices while they are added,
>>>> is not very generic.
>>>>
>>>> And support for making the decision to defer adding a device based on
>>>> its _DEP list, instead of the device's HID being in a fixed list of HIDs
>>>> to defer, which should be a more generic way to deal with this.
>>>
>>> Thanks a lot for working on this!
>>
>> You're welcome.
>>
>>> I'll have a more thorough look at the series later this week, stay tuned.
>>
>> Ok.
>>
>>>> Since this is likely to cause issues on some hardware, this new method will
>>>> only be used if the new acpi.defer_scan_based_on_dep kernel commandline
>>>> option is set to 1.
>>>
>>> However, I already can say that I don't like the new command line option.
>>
>> You don't like the name, or you don't like having a commandline option for this?
> 
> The latter.

I already expected as much. Some initial thoughts on this. Note feel free to
respond later when you are reviewing the set:

I think that this is a bit adventurous. But this was a weekend project for
me and I only had time to test on the Acer Switch Sw3-016 so far, and that
worked well. So maybe it will work better then expected with some more testing.

If we want to do this be default from now on, then we need to take some
measures to avoid the acpi_ignore_dep_hids list added by one of the preparation
patches from growing endlessly. What would help here is extending the new 
acpi_info_matches_hids() helper to not only check the HIDs against
acpi_device_info.hardware_id but also the compatible_id_list and then replace
the System Power Management Controller HIDs in acpi_ignore_dep_hids list with
"PNP0D80" I believe that that should catch all PMC-s without needing to have
a HID per hardware/chipset generation.

Regards,

Hans

