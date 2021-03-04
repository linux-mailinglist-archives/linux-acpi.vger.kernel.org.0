Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A632D780
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCDQQU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 11:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhCDQQB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 11:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614874475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QN+BWmxy3MMJdO6JH+HtD7AB/9g6nYQG9UucpGiuY8=;
        b=UMyzDkfst3SJGcW9jwli/710rOkoe3kVqXMXGw0i9tXdb0krwJkm7vZNzv50jFbuHtjD+t
        Cr9bUMBCvyf8SReIlvhlPE2McXT4N8V6W32epfH+zZE+8uOnyb0djCeG78UjCXFX3UomoL
        szI6Ucu4d3AxqouaaotO289e4QvWyA4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-GPZ1-_TvM26GP5BHojQBTA-1; Thu, 04 Mar 2021 11:14:34 -0500
X-MC-Unique: GPZ1-_TvM26GP5BHojQBTA-1
Received: by mail-ed1-f69.google.com with SMTP id t27so12028234edi.2
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2021 08:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7QN+BWmxy3MMJdO6JH+HtD7AB/9g6nYQG9UucpGiuY8=;
        b=c8s8NZOB6XsJaXzM3NlhyueIz/t5MAfFfspu5IoY5kJ44shcCunE0/ywhXuFw3kNSH
         1g8YM2jkqwxfouXqchx6sViL3CZuLEXnpH5uu11SF58Gbtwm7A+Kymcjp9I8Rb4f2E61
         GelOKV1Bjsi1M1VK6ZaWPB+qzlcSDxnH8qlkSNbkTrlWU/wFXkFoRAYbwQdnfOLu6okD
         SGulnn0XojQ1GGhUlFuhyvHWscvOBVhfw+LzNsKLn8cJEzy6LjF21Zv1QBLc7qsM2ed6
         3KvKBZEojFXSVAHUd7NRhdqkjG6izaRmANAHIy/AIuVmUNOTVO0HH5zOZJdBnu8XuEKK
         ZA6Q==
X-Gm-Message-State: AOAM533setFGkl8LR9Xbj7EOtx7pRo7fDeAU+QcNq6ShgEndkyDiTIYg
        86NhQ6kwACzn2VgXEnds2IbqIFnX0FmAzggGyXjP3MVbCNkdoKHsRBShPk9FVltfZLiR1nQRq9a
        mfM2LLAQQS9aZQZSZfjfzIHLwT0xhp3r3B0gJsRNRLUc2Uqcitf4ZNvqsaYgqnsy6CL4dCsqOCw
        ==
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr5139030eds.34.1614874472576;
        Thu, 04 Mar 2021 08:14:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxURrnsT3m0hPK6QF4C3fSx9r24S6L5ou2YM+Mq8foOLbnkjWZQy/HFUhw19TGEY0sF5lxElQ==
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr5138976eds.34.1614874472117;
        Thu, 04 Mar 2021 08:14:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g20sm23928135ejz.54.2021.03.04.08.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 08:14:31 -0800 (PST)
Subject: Re: Meaning / use of acpi_driver.class and acpi_device_class() fields
 ?
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <15858590-7be3-67d0-ccca-a55f20a7873a@redhat.com>
 <CAJZ5v0guBZzV9198xfpmq9re9cSKDN7TjG1JUrD9KeTq5oDK_A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e2da141-c798-41d9-34c7-4ea570840210@redhat.com>
Date:   Thu, 4 Mar 2021 17:14:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0guBZzV9198xfpmq9re9cSKDN7TjG1JUrD9KeTq5oDK_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/4/21 4:53 PM, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Thu, Mar 4, 2021 at 4:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> While reviewing a new acpi-driver:
>> https://patchwork.kernel.org/project/platform-driver-x86/patch/CAFysUkSztjJpSjKA92a=3j3Nj7vfQy5TCsiJtNmfjegxLBvFSA@mail.gmail.com/
>>
>> I was wondering what the meaning / use of the acpi_driver.class and
>> acpi_device_class() fields is and if these should be set to anything
>> specific ?
> 
> The latter is passed to acpi_bus_generate_netlink_event() in multiple
> places and that's the only use of it I'm aware of.
> 
> The former - I can't recall ATM.
> 
>> I did a quick grep and most drivers seem to set this to a string describing
>> the driver / to the driver-name and they seem to set the 2 fields to the
>> exact same value. But some drivers also use different values for
>> acpi_driver.class and acpi_device_class() ?
> 
> I don't generally want acpi_driver to be used at all, if that's possible.

Good point, I would expect the acpi subsys code to also instantiate a platform_dev
for the HID which this driver binds to, so it should be able to just use that.

I'll ask the submitter of the patch to re-write the driver as a platform-driver.

Regards,

Hans

