Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354A93ED21C
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhHPKju (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 06:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233320AbhHPKju (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 06:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629110358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qwuNPiFF/4NFMx6YKJ58/aPUHgsIDQkHlBX3ksVhHQ=;
        b=IL9vJ7QU6xXEfAhztRzZabGHS7p4o5k2yxACstQBO3PyylQGTsNvHoQGzO8NqMrOM27pau
        UPcduYeWtiE+wjcFDDY5Hve3QroHDAg+IimNWcw84CepK55HYjifpzhO9DLdlH3q8d6tmo
        JuT/8QRRHzJ2waiBf7YE0/Cak19jRrg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-BlQRx8FaOaaBvwAR4N_Daw-1; Mon, 16 Aug 2021 06:39:17 -0400
X-MC-Unique: BlQRx8FaOaaBvwAR4N_Daw-1
Received: by mail-ed1-f71.google.com with SMTP id di3-20020a056402318300b003bebf0828a2so4577230edb.8
        for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2021 03:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qwuNPiFF/4NFMx6YKJ58/aPUHgsIDQkHlBX3ksVhHQ=;
        b=TEMHtJEbL4+oKLJB+7lj8L++qQQg9CbJGaVBuUlfL+kCNA2FnOzeG14Vs7/mORSlt6
         WiYJVZ5WPpMcWPQLBMonuvPG65GpJ3QjEy4kt+m5PJn1qo9rTZTDfYo7+sxzYLmRnG3i
         V/lKD37ZJfy/67OpkJMS99rc5OeCRenf1y4v5LHx1inhiVtnmloDDP2nRbcKyt5ae3VK
         JHuzHaY2920kIgS5OV0KgWukAcYbZ5ckv+IKczRs5zqNWVl97iKayrKUh1G4cFEdmFDA
         Jn1qZCcZphMLFcV79H1eyOR+jUjbBXBXiTW6eRONYvDNr6DQjfWnROv7Nbi4JR3/hC/P
         VQng==
X-Gm-Message-State: AOAM531HuKuaSBZM/oM7kATER6XFHXweVPFR3FdaPdLZcNmENpbgQQse
        MiHwSZeQVjYg9+jQzffP/d+QQvjiwoyZYlxkN2n/7FsteHXYd0qkokH80o3+8mN2Tn4wvDR4TcK
        /qoeceJKN1mE9b/H79Ntk9XXmfnjhX7agP7WVkpU8qiYl6WynhY6YekKa425YIoumwMuEY0MgYQ
        ==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr19284854edv.26.1629110356364;
        Mon, 16 Aug 2021 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu0LM0NFGE2QAohLi5ZfyDKYI4kLW/aNtpMUW47nn4yiRjcc4nRbepM1U/HZEpGHXxSGwvrA==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr19284829edv.26.1629110356122;
        Mon, 16 Aug 2021 03:39:16 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id c28sm3519263ejc.102.2021.08.16.03.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 03:39:15 -0700 (PDT)
Subject: Re: [PATCH regression fix] gpiolib: acpi: Make set-debounce-timeout
 failures non fatal
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20210816093856.12313-1-hdegoede@redhat.com>
 <YRo9A0sgfKbi94BK@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a776fdc8-782b-5452-d1e4-3792cecacdf7@redhat.com>
Date:   Mon, 16 Aug 2021 12:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRo9A0sgfKbi94BK@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/16/21 12:25 PM, Mika Westerberg wrote:
> On Mon, Aug 16, 2021 at 11:38:56AM +0200, Hans de Goede wrote:
>> Commit 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
>> made the gpiolib-acpi code call gpio_set_debounce_timeout() when requesting
>> GPIOs.
>>
>> This in itself is fine, but it also made gpio_set_debounce_timeout()
>> errors fatal, causing the requesting of the GPIO to fail. This is causing
>> regressions. E.g. on a HP ElitePad 1000 G2 various _AEI specified GPIO
>> ACPI event sources specify a debouncy timeout of 20 ms, but the
>> pinctrl-baytrail.c only supports certain fixed values, the closest
>> ones being 12 or 14 ms and pinctrl-baytrail.c responds with -EINVAL

Type 14 should be 24.

>> when specified a value which is not one of the fixed values.
>>
>> This is causing the acpi_request_own_gpiod() call to fail for 3
>> ACPI event sources on the HP ElitePad 1000 G2, which in turn is causing
>> e.g. the battery charging vs discharging status to never get updated,
>> even though a charger has been plugged-in or unplugged.
>>
>> Make gpio_set_debounce_timeout() errors non fatal, warning about the
>> failure instead, to fix this regression.
>>
>> Note we should probably also fix various pinctrl drivers to just
>> pick the first bigger discrete value rather then returning -EINVAL but
>> this will need to be done on a per driver basis, where as this fix
>> at least gets us back to where things were before and thus restores
>> functionality on devices where this was lost due to
>> gpio_set_debounce_timeout() errors.
>>
>> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, I'll send a v2 with the typo fixed and your Reviewed-by added.

Regards,

Hans

