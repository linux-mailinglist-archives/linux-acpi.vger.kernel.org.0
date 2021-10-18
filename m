Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4FA431EC2
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJROFN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 10:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234969AbhJRODk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 10:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634565689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alu9+x3UukSgjt1oLDg8yRXsnhUeDxbETePjaj5q6hc=;
        b=amBFzB6iE50a9iYQvxiyNBvaKuUVp1S9gFEtOmJXd47C3TKvo0k/Yciamx5Ha7uV9/GZ9x
        mPE7/PQGBQAe3HcbYqrATROA2c/ix2t6QGhB7h5/Hp2qvT19m1qNHdiCz4n05OarMCip1r
        ojUjMFVyUYF4xMTS5xbuExESVSQ0o6o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-6iLB84JHPUyO2Gk0wM5AAw-1; Mon, 18 Oct 2021 10:01:28 -0400
X-MC-Unique: 6iLB84JHPUyO2Gk0wM5AAw-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso14455683edf.7
        for <linux-acpi@vger.kernel.org>; Mon, 18 Oct 2021 07:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=alu9+x3UukSgjt1oLDg8yRXsnhUeDxbETePjaj5q6hc=;
        b=2Owbu/aER7qSHDT1aDEjaX8OdGb1oiPhBzl3bfIuDJ5Lh0vd/7VftDbTwnpgJXfKxf
         7P1WB6RB9PV8FKuhqIZb6kJH2OyX5BQDjNFwkYYZcwyQmuQD8f9QSah/aQ3gzfg5M0/s
         e/7NBn9Clnld0imb6Tegava+JEn5B/DRNhogwLom0vtmMZwD9cUFEHBqG8uSyuXV0Vz6
         2uPFP6J5qem5SJC6Fq6ENheVDhOocFcbU3qNz6iilqio3GsbAxKfvwDZdp+QEvBEp+Mi
         IH0JhnRbBzFExWWqFq/p3JcNT3JEyzrkl1FY1AxlsAMIg1aIqzKHT9dDuWa2ah+8r479
         +/8g==
X-Gm-Message-State: AOAM533Y5r+Ui7OEPKX/ll6WVY7f+ntqT7w00Dc3DmSXj+P/YFXTdp78
        250Uk/t9sJKs1FVtTwyfqCyhj/Lw8BiaxCIStOADW63K4aITzke+0Lm42+JLfo39kGMdb2GTRxd
        KqlvSXzf6eeJuAj81lz1AKQ==
X-Received: by 2002:a17:906:16d0:: with SMTP id t16mr30142967ejd.199.1634565684861;
        Mon, 18 Oct 2021 07:01:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0pLdIdl2/mSdWIYw55gpZhSC1/jBwkJN0yv+ochanXR2UNh43fcyd5rcN6GDwg9bboL83ow==
X-Received: by 2002:a17:906:16d0:: with SMTP id t16mr30142841ejd.199.1634565683551;
        Mon, 18 Oct 2021 07:01:23 -0700 (PDT)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id q2sm9144921eje.118.2021.10.18.07.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:01:23 -0700 (PDT)
Message-ID: <97b8914e-e78d-8e3b-290a-6ad10170635b@redhat.com>
Date:   Mon, 18 Oct 2021 16:01:22 +0200
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
 <3c9d4f9b-26c2-a135-eb2e-67963aa0bc0b@redhat.com>
 <YW1QkidNKa79MCBb@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YW1QkidNKa79MCBb@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/18/21 12:46, Andy Shevchenko wrote:
> On Mon, Oct 18, 2021 at 12:38:51PM +0200, Hans de Goede wrote:
>> On 10/18/21 12:31, Andy Shevchenko wrote:
>>> On Mon, Oct 18, 2021 at 12:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>> Btw, IIRC similar code (i.e. BYT vs CHT by CPU
>>> ID) is being used elsewhere. Perhaps we might have some common
>>> (library) under arc/x86, PDx86 or so (headers?)?
>>
>> We already have helpers for this defined in:
>>
>> sound/soc/intel/common/soc-intel-quirks.h
>>
>> We could move those to some header under include, maybe:
>>
>> include/linux/platform_data/x86/atom.h
>>
>> And add #ifdef-ery there so that things will also build on
>> non x86 ?
>>
>> Then we could do a 2 patch series adding the
>> include/linux/platform_data/x86/atom.h
>> file + the drivers/mfd/intel_soc_pmic_core.c
>> change and Lee can merge both through the MFD tree.
>>
>> And then we can do further clean-ups of e.g. sound/soc
>> on top (we can ask Lee to provide an immutable branch).
>>
>> How does that sound ?
> 
> Sounds like a good plan to me!

So I've been thinking about this a bit more.

Since sound/soc/intel/common/soc-intel-quirks.h already
has stubs for non X86 too, I think it is best to just
move that to include/linux/platform_data/x86/soc.h .

Since the drivers/mfd/intel_soc_pmic_core.c thing is
a bugfix of sorts, it is probably best to open-code
the check there and then replace it with the helper
from include/linux/platform_data/x86/soc.h later.

I'll start prepping a patch series doing things
this way now.

Regards,

Hans

