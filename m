Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3287F2F74C2
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbhAOI4W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 03:56:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbhAOI4U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 03:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610700893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znxl+FRovgO8/86n29y7oXuD6db7aqsDOrd2YL92PYY=;
        b=hs0jgEjy/V527EHnRxuJGUdlMZTA0HzAjEe0TlOpfY30m//dAKm79qP6c4Sozh3/KlTNGO
        SChVk0nEqIq4j/zKsbe1cYatemV8eP8tQITSyhjtoTeEZjzOP4Z6KAuI83w7pAngzXs2nY
        fxoibdGQHtFoU84uDFBcBPn6wcNjcxM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-atwNnMBUPk6PPKRCSNWj6A-1; Fri, 15 Jan 2021 03:54:50 -0500
X-MC-Unique: atwNnMBUPk6PPKRCSNWj6A-1
Received: by mail-ed1-f69.google.com with SMTP id cm4so3556179edb.0
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 00:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znxl+FRovgO8/86n29y7oXuD6db7aqsDOrd2YL92PYY=;
        b=osFdrAbRVuIkOnsOOzwOqG3BsN7nWREF+uWHHJuDj9j95nh2G0Vn3NJfTqL8l9l+I8
         gSG0jAduZ4F/hGTvDsCybPAZOomCZRGc5t/9lkFUP1LmFUxgaZz3Twp7Amzx+BBD92BK
         vjiZCnhYsEVjHyEmxaHVvwlQIOwPbzcjw6ta5EO4ZqeYzOs8nPEj/AUxLAChFlJo/clD
         E/+ekdZ2hzf7NihZGCrxn32zl4mo2iGSLVQpd78ABegHb3JvNhYEjSu/VFTWxKpJR4nR
         88ofsFy2OO9Bq9IqKvsK54i91x6VQ5O80SVzpbgTU89+iuqJUzxs/CIaBkm1iTdEldQ3
         Norw==
X-Gm-Message-State: AOAM533f3PegKzv2oh0ko32W/jBdyo5WDeFL/NaaWm6w08wA1Pk/dP1T
        NL60N/s9WhGSs1fjjVZCbmVRfXFL/ShHGAfxECezC+qsxSgfx7GyrqNYX97nCjzyoldc/5Z6ST4
        K+EtPBVYVQO96YcodaBe1Ag==
X-Received: by 2002:a17:906:aac1:: with SMTP id kt1mr7728684ejb.329.1610700888668;
        Fri, 15 Jan 2021 00:54:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyF6di5ctyxBFaeY60v8hPaVVh40c2clE5gU3WoWExg9XiDhma561SpDAcJQKRsvd+SaD3u0g==
X-Received: by 2002:a17:906:aac1:: with SMTP id kt1mr7728676ejb.329.1610700888516;
        Fri, 15 Jan 2021 00:54:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id b14sm3263341edu.3.2021.01.15.00.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 00:54:48 -0800 (PST)
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com>
 <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce3ce3b6-c2d2-b0d0-56a6-941d3b607cb4@redhat.com>
Date:   Fri, 15 Jan 2021 09:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/15/21 1:49 AM, Pierre-Louis Bossart wrote:
> Thanks Hans for your reply, much appreciated.
> 
>> Pierre-Louis, can you see if the following hack helps? :
>>
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1939,7 +1939,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>>           /* Bail out if the number of recorded dependencies is not 0. */
>>           if (count > 0) {
>>               acpi_bus_scan_second_pass = true;
>> -            return AE_CTRL_DEPTH;
>>           }
>>       }
>>   @@ -1948,8 +1947,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>>           return AE_CTRL_DEPTH;
>>         acpi_scan_init_hotplug(device);
>> -    if (!check_dep)
>> -        acpi_scan_dep_init(device);
>> +    acpi_scan_dep_init(device);
>>     out:
>>       if (!*adev_p)
> 
> Yep, those 'hacks' solve the boot problem on my device. I tried multiple times and it's completely reproducible.

Ok, so this confirms my earlier findings (with my personal 5.10 + cherry pick tree)
that the problem is not doing 2 scan "rounds" and thus calling e.g.
acpi_bus_attach twice. But the problem is rather with deferring the device-creation
of some devices to the second step.

>> And can you collect an acpidump from the device and either send it to me and Rafael
>> offlist, or upload it somewhere and send us a link ?
> 
> will do

2 more questions, for me on the device where I can recreate this the problem only
happens intermittently. Since you did a successful bisect, I assume that when the
boot fails, it fails every boot, right?   Do you have any special kernel debugging
options enabled, e.g. CONFIG_PAGE_POISONING, which might explain why for you it is
100% reproducable while for me it is intermittent ?  

Also may I ask what the exact model is of the Zotac device you are seeing this on?
(the DMI strings are not helpful with this)

Regards,

Hans

