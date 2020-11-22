Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D02BC4BA
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Nov 2020 10:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKVJcT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Nov 2020 04:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727412AbgKVJcR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Nov 2020 04:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606037535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Y7q9k7HD5zOPOSswO36/j6lKCNPhQl+mLKkjPEYqto=;
        b=ggJNNHFnAc7DFeEkDxf6XxmLW83mumoRrKU3ZhLS/xpI4hRYwUTn0a72CCU1CuLjwWwU+e
        lqc3ERu4ZNU3beCfRBQ6/t8GG0hMyGnRV5e2SseJKuxPTylZOeZ81KjpOq3NY3kEPIkNz7
        w4xnxnT7OTQLpLAzE5T33ZhE0XLoEdI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-s27xbpk2OnO50TGzj3FRkg-1; Sun, 22 Nov 2020 04:32:13 -0500
X-MC-Unique: s27xbpk2OnO50TGzj3FRkg-1
Received: by mail-ej1-f70.google.com with SMTP id k2so3079732eji.21
        for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2020 01:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Y7q9k7HD5zOPOSswO36/j6lKCNPhQl+mLKkjPEYqto=;
        b=jKvoM3NZWvX1iecZzBs32h9AQ+f7taeKME+ulIUHOdZ3khGboW0Qg38dAx1dFnL0fc
         wzSL1n5f1/vzJfqZEvWqIWr/XVpUJ5NX/P6vxqrRVAn2pXMPYvTzMHqIJ9RLKndJ9ykZ
         ZqUwjvUne8AUJNMi8fcSGrN0MRplaeCmrmBGWMneMUwrvxuG5jybfKP0oaVvY/s91vGR
         k9927TIBumBVblvIciPAjLpIQKaFzUG0IcMurZ0/m0Z6qmwlGfoS0VfqZ832JnOP0vGC
         og2e/gYG0Z9/FbfOI+n/t1uE1rgcOhR7ov/s++n4MuF1bN7feBhiEIGRxWGoQRlfW1Zi
         g/1g==
X-Gm-Message-State: AOAM531XSf4oerOeHytz8PnZ8lxXBD9O3sr4Ya8P4CAUEzh8VilmUUWF
        CwMgmGzUyBKlCKIUDe55ZZp25OJ4sllcmJSpOoU9rx2eNaODJLTqK4HugiY4ypLj5xPhu1+vJhB
        xlo29ym6LHtqwMywWTEUg4Q==
X-Received: by 2002:a05:6402:b3b:: with SMTP id bo27mr41629828edb.376.1606037532047;
        Sun, 22 Nov 2020 01:32:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEvLOCCbG7eHL42EU8Bi65ubd6FTNy/yzZ+p0DfU6/bVD3GvNQ+FC3LPZuV5BWpCH1Wa/GhA==
X-Received: by 2002:a05:6402:b3b:: with SMTP id bo27mr41629814edb.376.1606037531812;
        Sun, 22 Nov 2020 01:32:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id c30sm3394001edd.68.2020.11.22.01.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 01:32:11 -0800 (PST)
Subject: Re: [PATCH v3] ACPI: platform-profile: Add platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
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
 <20201115004402.342838-1-markpearson@lenovo.com>
 <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
 <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
 <8c3pjwAeJVjl5ZLmnajCVHjcyBjoQeQTupHqZZostKJt3YZ0seAAvD-UIcBYFAFUNjsi0iWrEBNfX1l0tqN-4x07TGQbsiOMEqCpPAxgqJQ=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <41f3e41a-07be-3276-40fe-5675a19f36ae@redhat.com>
Date:   Sun, 22 Nov 2020 10:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8c3pjwAeJVjl5ZLmnajCVHjcyBjoQeQTupHqZZostKJt3YZ0seAAvD-UIcBYFAFUNjsi0iWrEBNfX1l0tqN-4x07TGQbsiOMEqCpPAxgqJQ=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/21/20 10:18 PM, Barnabás Pőcze wrote:
> 2020. november 21., szombat 15:27 keltezéssel, Hans de Goede írta:
> 
>> [...]
>>> I just realized that the sysfs attributes are only created if a profile provider
>>> is registered, and it is removed when the provide unregisters itself. I believe
>>> it would be easier for system daemons if those attributes existed from module load
>>> to module unload since they can just just open the file and watch it using poll,
>>> select, etc. If it goes away when the provider unregisters itself, then I believe
>>> a more complicated mechanism (like inotify) would need to be implemented in the
>>> daemons to be notified when a new provider is registered. Thus my suggestion
>>> for the next iteration is to create the sysfs attributes on module load,
>>> and delete them on unload.
>>>
>>> What do you think?
>>
>> Actually I asked Mark to move this to the register / unregister time since
>> having a non functioning files in sysfs is a bit weird.
>> [...]
> 
> Ahh, I didn't know that, sorry. If a non-functioning sysfs attribute is a problem,
> then there is another option: `platform_profile_choices` is always present;
> if no provider is registered, it's empty. If a provider is (un)registered,
> then `platform_profile_choices` is sysfs_notify()-ed. `platform_profile`
> only exists while a provider is registered, so it is created on provider
> registration and unregistered on provider unregistration.

TBH, I don't like this suggestion. I would like to either want both of
them be present and report "none" (and -ENODEV on write in case of platform_profile),
or neither of them be present.

Note I do agree with you that userspace probably needs a way to find out when a
provider shows up. Which means we should probably go with always having both of
them present. But it would also be good to get some input from Bastien here,
as he is working on a userspace daemon using this API.

Regards,

Hans

