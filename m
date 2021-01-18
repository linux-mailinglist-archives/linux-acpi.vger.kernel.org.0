Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589D32FA4E3
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbhARPhJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 10:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406014AbhARPgB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 10:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610984074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2WOcH2sAlxSDYztdNWhAanF/6BOxfPY+GLFNO1HBj8=;
        b=R+0XOZ49eNmG4hA305bZooGeY5aAnPxr7oMaZiIg3rLvSYtxKgrRRtZjLmPmyfKdd+duqz
        VafcQnj8SuOTQY4APzymluYCZqEB1aExofGB5uRXMpS4XZDPaKNhxwE5uYibJ/gorkGBX5
        4WoHhABsuwN+bKqLWs9M9vhcfFnj++0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-Ch_ogaKWPQ-gq5rxuhNXqw-1; Mon, 18 Jan 2021 10:34:33 -0500
X-MC-Unique: Ch_ogaKWPQ-gq5rxuhNXqw-1
Received: by mail-ed1-f71.google.com with SMTP id n18so7992599eds.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 07:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2WOcH2sAlxSDYztdNWhAanF/6BOxfPY+GLFNO1HBj8=;
        b=K4KRPaPrmjZr2rOoOIU/SmwM+i20u4UPO4msvW9rJEH+bmwRuC9rBsUCjVDEcExYpf
         dObAPbi1BC3XEiZvvLUoBnIcLtQ1pZTsG/BrM/iBavxjGDb9OiQ6Go03Ia9dN0pcL+Te
         1Sqeg9kYo/eV5G5W+fRfzNPFigfnd9gl6xFIOZQdDmK1z/0qTeUTEU2ZC2PCmGWW2I3x
         OE/5NUUSroGiCMFzvmirZBxkiSsv8PN51doD/BnLVI1273y5VouA53nKvRIGHQuLgJR6
         b0D7vr99z3o2EWSojFY9JkOJ2cLPq9aNrTKFTfWwfJuclAO5kHEoqsQJZ/AQzBgxXwTh
         vAaw==
X-Gm-Message-State: AOAM532lB+Xq7FidZlh+T4Zg50Wruk2D6enekhZeSKuCZOX8wczAnNus
        mBohmZfaEvteNhoOZUkP7x9zOFUfst44Z+Sx/XcczHU4N7lE6jSEhR3YgHmTgP8UuN8FS4lgf4j
        16BfL9eL6QUApHgb0T33TCg==
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr57901edu.22.1610984071950;
        Mon, 18 Jan 2021 07:34:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw02JFryf0pfjcU+qzkH4HrcM27o9bACrUwT3ugAhYU+d1oXH6ExNbHb2GlKSoLveXqbvzWmg==
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr57891edu.22.1610984071847;
        Mon, 18 Jan 2021 07:34:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id b26sm9105099eds.48.2021.01.18.07.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:34:31 -0800 (PST)
Subject: Re: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in
 acpi_device_add()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <3494203.VBaj39JGmp@kreacher> <2999734.9HhbEeWEHR@kreacher>
 <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
 <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
 <20210118153218.GX4077@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <09c19a25-bf03-28f0-48d2-d5eea1a800cb@redhat.com>
Date:   Mon, 18 Jan 2021 16:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118153218.GX4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/18/21 4:32 PM, Andy Shevchenko wrote:
> On Mon, Jan 18, 2021 at 04:16:16PM +0100, Rafael J. Wysocki wrote:
>> On Sat, Jan 16, 2021 at 1:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 1/14/21 7:46 PM, Rafael J. Wysocki wrote:
> 
> ...
> 
>>> When I have cases like this, where 2 mallocs are necessary I typically do it like this:
>>>
>>>         const char *bus_id;
>>>
>>>         ...
>>>
>>>         } else {
>>>                 acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
>>>                                              GFP_KERNEL);
>>>                 bus_id = kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
>>>                 if (!acpi_device_bus_id || !bus_id) {
>>>                         kfree(acpi_device_bus_id);
> 
> 
>>>                         kfree(bus_id);
> 
> Just to be sure, shouldn't it be kfree_const() ?

Yes I beleive it should, my bad.

Regards,

Hans


> 
>>>                         result = -ENOMEM;
>>>                         goto err_unlock;
>>>                 }
>>>                 acpi_device_bus_id->bus_id = bus_id;
>>>                 list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>>>         }
>>>
>>>         ...
>>>
>>> So that there is only one if / 1 error-handling path for both mallocs.
>>> I personally find this a bit cleaner.
> 

