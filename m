Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E455A431647
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhJRKlG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 06:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhJRKlG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 06:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634553534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJpjwYzBEePfLIvqc/wA36RQv/Hj/p+rbazzXrU5BSU=;
        b=HMPCIBB1uTbUspvgOgDxcibjAYVRjW0kKMixnCU8xA/izEy5ksgwTUQ+Z1eyZVJP7WLeOe
        1E/1RoFqz59+oCs9vwAPtydF8lVi7XQlbM34Szmh7KK+eKCVw2yUuZ/0czSV7Y1N15I7H1
        qrWuvZbdHda2+QlHl9bK/7VZ3sIArAU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-mYjNOaOJMg6mBpCVZ57HQw-1; Mon, 18 Oct 2021 06:38:53 -0400
X-MC-Unique: mYjNOaOJMg6mBpCVZ57HQw-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so13907531edj.15
        for <linux-acpi@vger.kernel.org>; Mon, 18 Oct 2021 03:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GJpjwYzBEePfLIvqc/wA36RQv/Hj/p+rbazzXrU5BSU=;
        b=OpFL1U6Ya+qySnjMcHoTIYXyhf04Z1PNKho6ReR3mNKavzNfdRkO04b47oxyD5ze+w
         hVHRkJns1fiwHGiMZ2vdPlS3OWucuJ77d/zCZqHTT6BdBn9YiNcLB4mITgsHGs/DkWrP
         WuBKNh/7ghWP2McTZ5jibAfUofbJSDwWgIC5Ocg3tp5ptroVWIEQI7+bvMoGoPPmOWJH
         QTrWymb0Cvp5hiKnqFRebO+WGyRlHbbODS8k74GZPNXdKeglr5RAlTdIrWZ8BtKHGXQG
         3UNhLz5SjVjZDv882wBHVuPRUosT0J+XF/FJ6j3oAeNjuBNeR7kOI26x5aNgQXuohoAs
         N7Lg==
X-Gm-Message-State: AOAM5325hD3FZ3YaRjwzyfUUX1aM2wVFejwbDDXzNYS3oYeftAeG+4XE
        rgYKLXoIUzW2nvvcD//iG7naUb/iciHCL6Ref0aj8J+5wFA7O6GlTom48h5/P7Ly4mdjewRunEd
        UbMDro1tXAn4NVzMd3hPDYg==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr28975209eje.112.1634553532171;
        Mon, 18 Oct 2021 03:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvmIzC9O5OnhTRWtlgSgEVOb1rej/eg3p3hqWp1+bsmCinM+Ngm6dO9xcehdy0EVTAOjpAcQ==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr28975190eje.112.1634553531989;
        Mon, 18 Oct 2021 03:38:51 -0700 (PDT)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id x16sm8909256ejj.8.2021.10.18.03.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:38:51 -0700 (PDT)
Message-ID: <3c9d4f9b-26c2-a135-eb2e-67963aa0bc0b@redhat.com>
Date:   Mon, 18 Oct 2021 12:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to intel_pmic_bytcrc
 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211017161523.43801-1-kitakar@gmail.com>
 <20211017161523.43801-2-kitakar@gmail.com>
 <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
 <CAHp75VcA+=OsmX7o2WTvYgf8TNpE64qEHq=MVm5vVP-4RBk+ng@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcA+=OsmX7o2WTvYgf8TNpE64qEHq=MVm5vVP-4RBk+ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/18/21 12:31, Andy Shevchenko wrote:
> On Mon, Oct 18, 2021 at 12:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 10/17/21 18:15, Tsuchiya Yuto wrote:
>>> On Microsoft Surface 3 (uses Intel's Atom Cherry Trail SoC), executing
> 
> ...
> 
>> As Andy said we could use a DMI quirk for this, but chances are that the Microsoft Surface
>> DSDT is not the only one with the wrong HRV value. So instead it might be better to
>> just test for the SoC type as the attached patch does.
>>
>> Tsuchiya, can you give the attached patch a try.
>>
>> Andy, what do you think, should we go with the attached patch or would you prefer using
>> a DMI quirk ?
> 
> TBH I have no strong opinion. Only one remark on your patch, I am not
> a fan of removing COMPILE_TEST but at the same time I'm not a fan of
> ifdeffery. All on all I think having COMPILE_TEST is preferable even
> if we have ifdeffery. Btw, IIRC similar code (i.e. BYT vs CHT by CPU
> ID) is being used elsewhere. Perhaps we might have some common
> (library) under arc/x86, PDx86 or so (headers?)?

We already have helpers for this defined in:

sound/soc/intel/common/soc-intel-quirks.h

We could move those to some header under include, maybe:

include/linux/platform_data/x86/atom.h

And add #ifdef-ery there so that things will also build on
non x86 ?

Then we could do a 2 patch series adding the
include/linux/platform_data/x86/atom.h
file + the drivers/mfd/intel_soc_pmic_core.c
change and Lee can merge both through the MFD tree.

And then we can do further clean-ups of e.g. sound/soc
on top (we can ask Lee to provide an immutable branch).

How does that sound ?

Regards,

Hans

