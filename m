Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C14601C4
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Nov 2021 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356428AbhK0VyG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Nov 2021 16:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356329AbhK0VwF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Nov 2021 16:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638049730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uu+J1kDPMvGUawGEWap7ByipI059VOkuOzif5lRIAxg=;
        b=fNK8s2/4jE0ey/NanNW2F8Oigvq61b1MQmmw9sZB3FGIV1wuq5O8DZzeSU19kX00oq/fV1
        uL/lI8FgsoTf3JHzQgIB4COxkVda0hrc5nGM35/gH2IGwZwgsd3nzHa8doTREzbOQ1QdA3
        ij5JjBrB/neqzyDNQsVcq+C9byOFFCg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-M2tYKD-sM_OA12_EkPY5VQ-1; Sat, 27 Nov 2021 16:48:48 -0500
X-MC-Unique: M2tYKD-sM_OA12_EkPY5VQ-1
Received: by mail-ed1-f71.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so10592431ede.0
        for <linux-acpi@vger.kernel.org>; Sat, 27 Nov 2021 13:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uu+J1kDPMvGUawGEWap7ByipI059VOkuOzif5lRIAxg=;
        b=QI4ot2WpRzpIe6ZhLwr2BJuwIw9dwEDsa3ux/3MCxkIM86KvJEDrrxGFnOWLHcdmnu
         ZcL6Q03VHNhJ2TmaDzdSsdttZdKTQGD/fVlyCbI7ifHUzenX4xkINkNi5flRhZAnFM4H
         ta/tdQAcbBfsq+1eDsc6IRq7Ngrox7OxHeLhZFjn9TEajnqKUwRDFMYD3WP+KrmuqQ3n
         8KvBRt5qOZ8699YmOJLHXn4nuigVwZ/fimf0f3nWbm/QInLME/6pFPi9gDXrl5pUj+pb
         GQsLyUym59hacKb3NLXTKFTxlsoz+QWDyyddQJkPvK3vk2rQUflOT98b532sVEefjTxW
         skQg==
X-Gm-Message-State: AOAM532UbW2SpU4ni5h7CB4E3nUDrqOCrudmsFf/IZvKwY6X+hm8tcnN
        8j+RE1vCX2+C7IWYKdelLp0QaqbejJuaf9jjnjckbQqpvN5QCFueB05Aro/7433JyXcHsai+R5B
        ZtxXSC312F7QNJrbFXAXQiw==
X-Received: by 2002:a05:6402:26cd:: with SMTP id x13mr60752777edd.11.1638049727782;
        Sat, 27 Nov 2021 13:48:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzSAJgBf4XxzzRpWQJChzzirl+mApGOjBHaTFS+8BPMnQ5v+GJmVR8MeUYYVj15l0mAdsRPw==
X-Received: by 2002:a05:6402:26cd:: with SMTP id x13mr60752762edd.11.1638049727655;
        Sat, 27 Nov 2021 13:48:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u16sm5012584ejy.16.2021.11.27.13.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 13:48:47 -0800 (PST)
Message-ID: <18444f98-1b57-e850-6586-461bd71dd430@redhat.com>
Date:   Sat, 27 Nov 2021 22:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/3] pinctrl: cherryview: Don't use pin/offset 0 to
 mark an interrupt line as unused
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
References: <20211118105650.207638-1-hdegoede@redhat.com>
 <YZY4ZA80QpJQFqOj@smile.fi.intel.com> <YaEcq2N92rwbUsXx@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YaEcq2N92rwbUsXx@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/26/21 18:43, Andy Shevchenko wrote:
> On Thu, Nov 18, 2021 at 01:26:28PM +0200, Andy Shevchenko wrote:
>> On Thu, Nov 18, 2021 at 11:56:48AM +0100, Hans de Goede wrote:
>>> Offset/pin 0 is a perfectly valid offset, so stop using it to have
>>> the special meaning of interrupt line not used in the intr_lines.
>>>
>>> Instead introduce a new special INTR_LINE_UNUSED value which is never
>>> a valid offset and use that to indicate unused interrupt lines.
>>
>> ...
>>
>>> +#define INTR_LINE_UNUSED		U32_MAX
>>
>> Funny, I have had something similar in my local branch for a few years ;-)
>>
>> +#define CHV_INVALID_HWIRQ      ((unsigned int)INVALID_HWIRQ)
> 
> I will rename this when applying. I assume there is no objection on doing it.

Yes that is fine.

Regards,

Hans


