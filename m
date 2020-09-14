Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5326865A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgINHpK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 03:45:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53839 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbgINHpJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Sep 2020 03:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600069508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vx80H7te5gIB49yR3z5p+8Lj/f1I2wyUY1AR+ocRP2k=;
        b=ewBb2tcJoY6HIu8W1tMgxr3sVhk13xdTLJOSkneWSqlAUJl8+LA0W/Pk/GQsFvy6Ra0dnx
        2UhIyiXli/D1pv1JO6j2YbZ2s6sEiqlSfiPvf8Ea++zE6FE/iFDGN6B3FHBlxq+/a3u0bv
        sh4QiHjMnHwypmaVYk+18ZGBdpn9mGI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-8xlDVtOyMUa3_d6u6G3JMw-1; Mon, 14 Sep 2020 03:45:05 -0400
X-MC-Unique: 8xlDVtOyMUa3_d6u6G3JMw-1
Received: by mail-ej1-f70.google.com with SMTP id jz22so7733110ejb.4
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2020 00:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vx80H7te5gIB49yR3z5p+8Lj/f1I2wyUY1AR+ocRP2k=;
        b=iaVP9gksblPc6oPFsZ05DmQpkFSNj6FyB3B7dH9QsvfvkjkEasKJy3BoNvT3scoD4c
         qo5SQGxv44NxHTTPBGR4uZIaFaFMDm4P74e9zotWZZfLPCEspzkCgtLxFiOh+rOjC3v5
         chzIzSccaBLuCV1SXySeKKjpmqYtzUhzbTga5N8ixX7iq7AOkobhhEsnfcxAa6zSU0Wk
         QSwipcHg5ZbKurOQhQwuddZff/c/lJ3nMzoE8nUoUurk52LB5HDf1TvhdvHN8aFPxFu9
         22vrB8TBo3/buEHZtFL7I2jY9HfyBEnJ3KjNdrXXPXUY7CZvQ1eVhMR3/zFkNrNShipZ
         2BUg==
X-Gm-Message-State: AOAM533ctg7P4mV8+zICsOToVfeGbJPMxB5NMsRLfSYiOMfcjIb+oF7I
        p4F62h/rYRq4wNAolDuq8eCdl/g9Svb5jkkxctGej+xquW1HmQxQ/xa9MD6Kh4HQkpCLnPQpOg7
        Dek7CO99obo+0ctvwNlUx/A==
X-Received: by 2002:a17:906:5611:: with SMTP id f17mr14139617ejq.427.1600069503981;
        Mon, 14 Sep 2020 00:45:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGKcq8+llfZMODL92knPx6qXu/rkmoC6YLK9WMi9CO8WaTj5e/GBzZiGpN6aZ/Fw7oKeVmPw==
X-Received: by 2002:a17:906:5611:: with SMTP id f17mr14139602ejq.427.1600069503811;
        Mon, 14 Sep 2020 00:45:03 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id w10sm7128920ejv.44.2020.09.14.00.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 00:45:03 -0700 (PDT)
Subject: Re: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which
 modify the irqflags
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20200906122016.4628-1-hdegoede@redhat.com>
 <20200914061246.GO1665100@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <61dfb476-2d55-116c-21d6-bf5972929cd3@redhat.com>
Date:   Mon, 14 Sep 2020 09:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914061246.GO1665100@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/14/20 8:12 AM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Sun, Sep 06, 2020 at 02:20:15PM +0200, Hans de Goede wrote:
>> Hi Dmitry,
>>
>> This patch is a bit of a kludge, but the problem it fixes has been
>> encountered on 2 different models now, so it seems that we really
>> need a workaround for this.
>>
>> This patch applies on top of these 2 patches:
>>
>> "Input: soc_button_array - Add active_low setting to soc_button_info"
>> "Input: soc_button_array - Add support for INT33D3 tablet-mode switch devices"
>>
>> Which I have posted multiple times upstream already (they are from May!),
>> but these have not been getting any attention.
> 
> Sorry about that, I merged them just now.

No problem, and thank you.

>> The soc_button_array code really is x86 specific glue code to translate
>> various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
>> As such I wonder if it would not be better to move this driver to
>> drivers/platform/x86?
>>
>> I seem to be doing most if not all of the recent work on soc_button_array,
>> and soon I will be a co-maintainer of drivers/platform/x86. So having it
>> there and adding me in MAINTAINERS as maintaining it seems to be best?
>>
>> If you want I can do a patch moving soc_button_array to drivers/platform/x86
>> and then add the other 3 patches on top and then we can merge all of this
>> through drivers/platform/x86?
> 
> Sorry, misread this first time through, so already merged the 3 patches,
> but I to not mind at all moving the driver to platform tree. If you send
> me such a patch I will apply it.

Ok.

Andy are you ok with moving the driver to the pdx86 tree too?

Regards,

Hans

