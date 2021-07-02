Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287AA3BA375
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhGBRHv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 13:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhGBRHv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 13:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625245518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wW1GauM/JrHrWr/XFMF2AIcHRui0vGuUibcEb2tpS90=;
        b=cEz9OKaZib0B2UgRlaYuNNBA8itcJvy1TI+Aa09Zqp2KFS4PgvH2dHfrku8sQXLo1sC7aD
        1n04LgO68x5BsCt+y0nW/R7Y0QvO5Ivs9MMGqBfekryVDUNy91e62yX8TqvUrok2orjXdk
        p6BvqYK793uZsk4OsYoc6L8LATOR3jA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-Gjm0GVRbO3m6cHLEx_ZLIw-1; Fri, 02 Jul 2021 13:05:12 -0400
X-MC-Unique: Gjm0GVRbO3m6cHLEx_ZLIw-1
Received: by mail-ej1-f71.google.com with SMTP id d21-20020a1709063455b02904c609ed19f1so3759538ejb.11
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jul 2021 10:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wW1GauM/JrHrWr/XFMF2AIcHRui0vGuUibcEb2tpS90=;
        b=E9nA2ooK4SbztPnKwmZbSrQ7/4XPOzI0Mp6FxRn3r1zITh3P5oCrz/VmOXpkkETsKZ
         hKep3n9IxSSOIT9v2XykF/2FDtLtZtbGDQFMsPBU1N1vCaPefbjOLmi0E0kR258Qbt3U
         9/p++IsmaRZfY5fmwRaTjHaOkRY8x1HQloEMpgOLgvNU4w+3bp4O5ppI+u9Rldp4uf00
         +VA0fkTrUr+60ujSnZWSnOiROEeU1PsRppl/UWNZLTkpymmAk1jHkBxXcf9didG3MM+H
         nh0+v5zDtg7wQ9hDifp/KKKfh77fH+4TO1gQZSo6Ditdvd9CSXOJpPFa6RuYief8VMGC
         Ckxw==
X-Gm-Message-State: AOAM533c7TLsnDD6Cf2I5naTF3I0f6ImpbZUl52Mif5VKd1FJT9fZpf5
        V3zoH8WqNfhUomx1Ebz667F0CERHAvnpYzKuS/XOJl9zGKtCDDrRclfOhqTi9tQBXbsJHCWOGqG
        a5/53zim8X+VcYfKsExx9sit0C0dNx6e6T+z4dfeAknsiuGtSznHW9AjQ2AWy6hu8/kyCfh836A
        ==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr588874edq.57.1625245510940;
        Fri, 02 Jul 2021 10:05:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyML5N0nyoUMF4yArbM4WqOpAALYdk6vhSOgN9Frvn9oOqlrdAh3mphE3hhbVucDcpGKGumYQ==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr588849edq.57.1625245510757;
        Fri, 02 Jul 2021 10:05:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h14sm1265182ejl.118.2021.07.02.10.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 10:05:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210702165052.81750-1-hdegoede@redhat.com>
 <CAHp75VfWN1wt4bA4hVefOGiHA44-h3qEMt_A0=96k2Wq4=_WVg@mail.gmail.com>
 <0e8c71a2-6b64-fec2-c307-a8a530bdead7@redhat.com>
 <CAHp75Ve9+r4LCuU2zf1jm7tGhOYeL+dRY=q6biW76QjwkWjn1w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f9ea4a98-491f-f246-4bcb-c25e8e9268e0@redhat.com>
Date:   Fri, 2 Jul 2021 19:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve9+r4LCuU2zf1jm7tGhOYeL+dRY=q6biW76QjwkWjn1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/2/21 7:00 PM, Andy Shevchenko wrote:
> On Fri, Jul 2, 2021 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 7/2/21 6:54 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 2, 2021 at 7:50 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> Thank you for the review.
>>
>> Is your Reviewed-by for just this patch, or for the series ?
> 
> I have not seen a cover letter (is there one?), so by default (i.e. if
> not told otherwise) it applies only to this patch.

Right, that is why I asked, I had not seen your 2/2 reply yet,
I guess I should have just waited a bit longer, sorry about the noise.

Regards,

Hans

