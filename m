Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A7413A39
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhIUSoR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 14:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhIUSoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Sep 2021 14:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632249767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HouoNmzn27J/0fv070uPp9hTkvlffeabyb1Jv/MTjg=;
        b=JjmlqQbqRzRJd+uzB/aG3mNDyWXHUrqLPku+TJTC0oj4kyNVA65cyanSVzS6fMk/QmeMqW
        zMYdM/W+zfaGCY2IpCuC8hA6haTMRmfMgXF33fg6OLQRh8Qo8hIq1StgmxGMnTHUApZVHF
        FtWijFBb4iR2n5zPtCJnI4z3gYzg0bA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-oekfVPC6OrKXfY37nmmoqQ-1; Tue, 21 Sep 2021 14:42:46 -0400
X-MC-Unique: oekfVPC6OrKXfY37nmmoqQ-1
Received: by mail-ed1-f69.google.com with SMTP id h24-20020a50cdd8000000b003d8005fe2f8so43913edj.6
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 11:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8HouoNmzn27J/0fv070uPp9hTkvlffeabyb1Jv/MTjg=;
        b=wjpD/aw9za6EP/aDGxRgFeZyJuhehwyLo+aC712gzXi5EdF5nstSx5M/VQePdBZgos
         PN94u7QH2fs6PA/Xmyvf3Z3/fh42K7S13V6oAWlHnyRPPhuseA8WNjHN1N9TBT5Nf8kx
         bqQK4eokjqpuJbOyvydpOm/buSmyfGtjiKCVncezZKkvAeZ4I2l7yeCA22GiMwAKJ256
         fvxGTepeeu+E5hvgZvuMwd9nlqb00+2Sy1KysDy6C6njaVSL+rSSesNoCOIpXBDXW8mM
         hd5Fas4xmT7nD8dvlnMfu0FxUTHhlCpYSz+XaoJC5MxjuyR8bV92fwws5kMrI5UyEW2I
         lMdw==
X-Gm-Message-State: AOAM532SxpSlgSsMGQb/n5M/DwBPuJ/rsAuCX4gn2QGslyrjTyp9QqAf
        29sw4YEFGVfble7ctOWNo622iPFJsB9ev0QtntjD/Ye/gaYSUclSaSeF76dJ6EuX1YWih85zy1M
        cBAPNWe/WfCBTE178kxy2wFINnBldRUURMbX9i8zc3JyA8NXGVQaDhtG71C6BSe4sF9oGVE0Xgw
        ==
X-Received: by 2002:a17:906:68c2:: with SMTP id y2mr36544559ejr.18.1632249765190;
        Tue, 21 Sep 2021 11:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuBPMHmTMuwFTnF8rZ0qOoDFoKOkrKAfszAgiITljXWzifTWeCsz91t1XxQwM7dV6fAVOLXg==
X-Received: by 2002:a17:906:68c2:: with SMTP id y2mr36544529ejr.18.1632249764971;
        Tue, 21 Sep 2021 11:42:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w25sm8932092edi.22.2021.09.21.11.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:42:44 -0700 (PDT)
Subject: Re: [PATCH regression fix] gpiolib: acpi: Make set-debounce-timeout
 failures non fatal
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210816093856.12313-1-hdegoede@redhat.com>
 <CACRpkdZ8ngakZhbrJp=OjcayLJ4j7C9gqb72N18fHExtMT7gNg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <86fafc6f-113c-2ea9-579b-ea29343865da@redhat.com>
Date:   Tue, 21 Sep 2021 20:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ8ngakZhbrJp=OjcayLJ4j7C9gqb72N18fHExtMT7gNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/21/21 8:28 PM, Linus Walleij wrote:
> On Mon, Aug 16, 2021 at 11:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
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
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Bartosz will pick this up I think, I'm a bit off duty with GPIO right now.

Added Bartosz to the To: list, to make sure that he actually
sees this. I somehow did not add him in the To/Cc when sending out
the patch, sorry about that.

Regards,

Hans

