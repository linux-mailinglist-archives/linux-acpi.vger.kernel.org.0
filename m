Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B413622E1D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Nov 2022 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKIOi5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Nov 2022 09:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKIOiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Nov 2022 09:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9830A
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668004677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h37vckJSOTPucFWWgAjxNgDt/nzp9uoOuKtaejw7UEo=;
        b=K7e7ofeqTzHv80Gl72pkI4+HvyT6BMi3WYhoqXz2N9cDJSEmOxTubNcpo10oZKwgVvoMvR
        z6PgY69/3iOGNow9Dk/pDttV3klKQC2ecDm2kbnbLVlj1UDejLQFU/wPjj/nk7EXNMZ+s4
        y9t9pq7xYFVXU2jtMkB7A0P9QnVPGgo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-oPgCtkFCNVKTbU0HKHkHmw-1; Wed, 09 Nov 2022 09:37:56 -0500
X-MC-Unique: oPgCtkFCNVKTbU0HKHkHmw-1
Received: by mail-ed1-f72.google.com with SMTP id q13-20020a056402518d00b00462b0599644so13111630edd.20
        for <linux-acpi@vger.kernel.org>; Wed, 09 Nov 2022 06:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h37vckJSOTPucFWWgAjxNgDt/nzp9uoOuKtaejw7UEo=;
        b=GYw3zDCsQQXvoeePNN/1Hss9evP8QkVqebrFfjFPvtPeW1sh39oei6b+4R940BVJgf
         ajCg6hKVCoM8++awSjG4yChnTisG5kYpJ1uUYnUZP0NU+UusoNHHQeWKj1of4KblTqn/
         8yr1GZoiJtOLypr3h4l9iEV0dPia0VP/fsHSWjHM9sAnH00aSLxiXmx4UlmLfWcc22nr
         84AOmroV5WO8EkUnREanCyIlsmwQATUcAOf++8VPl4GAYYyI8kWHi4bay5QXAp56Jlia
         BWoeiDzGnsUWWAJBBqGLh2RkabEGjRlPRpT17ARV217kUS8yPs20EHsr7i8T0RXOopzP
         bBWQ==
X-Gm-Message-State: ACrzQf0uyyMWZxD8t7N3gDYQlnPU8ZtKPVQP5/D25KGpO2a9yjUsI/Kt
        pQiufugoiJ/aQ17ZyH4PXOMIfxMXYYcGLF0TMyl9vgRqNbgIV+R25tZ6rGuH083bHoXsMgIssnl
        7v1/flfwNzpYW2T7htQonMw==
X-Received: by 2002:a17:906:341a:b0:7ae:3193:8cf3 with SMTP id c26-20020a170906341a00b007ae31938cf3mr911125ejb.416.1668004675124;
        Wed, 09 Nov 2022 06:37:55 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7LttHpJ0TC9EQe8YK4PDXVspJYa0wccEATzrTocijaxhFv+RtCQoAWOOuSmuqf1Y6gBNqw4Q==
X-Received: by 2002:a17:906:341a:b0:7ae:3193:8cf3 with SMTP id c26-20020a170906341a00b007ae31938cf3mr911123ejb.416.1668004674898;
        Wed, 09 Nov 2022 06:37:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7ca55000000b004616cce0a26sm7026439edt.24.2022.11.09.06.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:37:54 -0800 (PST)
Message-ID: <dd95fc25-6b46-b244-2ca6-954ba5ba129c@redhat.com>
Date:   Wed, 9 Nov 2022 15:37:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC 0/2] ACPI: video: prefer native over vendor
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20221105145258.12700-1-hdegoede@redhat.com>
 <c364cee1-4309-ebc2-9aa3-ff467fe0096f@redhat.com>
 <CAJZ5v0hJx4GX-0Ny17LgbBZGXRDG+bnfmhDQeKpBDusQ+j1g6A@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hJx4GX-0Ny17LgbBZGXRDG+bnfmhDQeKpBDusQ+j1g6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/9/22 14:51, Rafael J. Wysocki wrote:
> On Sat, Nov 5, 2022 at 4:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/5/22 15:52, Hans de Goede wrote:
>>> Hi Rafael, Matthew,
>>>
>>> Here is a second attempt at always registering only a single
>>> /sys/class/backlight device per panel.
>>>
>>> This first round of testing has shown that native works well even on
>>> systems so old that the don't have acpi_video backlight control support.
>>>
>>> This patch series makes native be preferred over vendor, which should
>>> avoid the problems seen with the 6.1 changes before the fixes.
>>>
>>> ATM there is one known model where this will cause a regression,
>>> the Sony Vaio PCG-FRV3 from 2003. I plan to add a DMI quirk for that
>>> in the next version of this series, but I'm waiting for some more
>>> testing (to check that the vendor interface does actually work) first.
>>>
>>> I will also do another blogpost, focussing on asking users to see
>>> if they have a laptop which provides a combination of vendor + native
>>> backlight interfaces, which may be impacted by this series. This is
>>> the main reason why this is a RFC for now.
>>
>> The blogpost requesting testing of laptops with a combination
>> of vendor + native backlight interfaces can be found here:
>>
>> https://hansdegoede.dreamwidth.org/27024.html
> 
> The patches in this series look reasonable to me,

Thanks.

> even though I'm not
> sure if the assumption that the Windows 8 hardware certification
> requirements were always followed is not overly optimistic.

After the second patch in the series the only remaining
prefer_native_over_acpi_video() and thus the only acpi_osi_is_win8()
call is guarded by a (video_caps & ACPI_VIDEO_BACKLIGHT) check as before:

        if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
             !(native_available && prefer_native_over_acpi_video()))
                return acpi_backlight_video;

So even if the assumption is wrong, there is no behavior change
other then the intended behavior change already caused by the second
patch.

The last part of __acpi_video_get_backlight_type() which contains
the basic (non special case) heuristics looks like this after
this series:

        /* Use ACPI video if available, except when native should be preferred. */
        if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
             !(native_available && prefer_native_over_acpi_video()))
                return acpi_backlight_video;

        /* Use native if available */
        if (native_available)
                return acpi_backlight_native;

        /* No ACPI video/native (old hw), use vendor specific fw methods. */
        return acpi_backlight_vendor;

Which is also a bit more KISS / easier to follow then before and
I hope that this will work well.

Regards,

Hans


