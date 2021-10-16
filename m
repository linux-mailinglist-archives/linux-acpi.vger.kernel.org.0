Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092804301D6
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhJPKUb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Oct 2021 06:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244091AbhJPKUa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Oct 2021 06:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634379502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRKifhuZPEWMV9NZ2wr+qPq6taJBi8mO/4F/nJu9ENk=;
        b=Kkh/ARh4ZzzY0jfO/HfqlKEgh64pzOBYEwTQodBwTBrukREV9FZ1r51i+1OHjUtJzVEjHv
        eY7vdtDG00BmvAFqkyjZDzU88lcJavL0VRLpkTp7ZAaQFxt8KXa0zTS1TR+va8qPZ7G1tp
        NEEnvxWH3DONV69cC8mszAwxsX0fgd4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Kh7Np6_vO12Mt-nYMtshQw-1; Sat, 16 Oct 2021 06:18:20 -0400
X-MC-Unique: Kh7Np6_vO12Mt-nYMtshQw-1
Received: by mail-ed1-f72.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so10340341edv.10
        for <linux-acpi@vger.kernel.org>; Sat, 16 Oct 2021 03:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lRKifhuZPEWMV9NZ2wr+qPq6taJBi8mO/4F/nJu9ENk=;
        b=uK0cCDzpYMxy8j+VzNyl0JZixr5nRupQ+2UlWusufK1qyfOqNNNZEfRV+t21X1ZOKt
         cKM689GzcomvH9bED2s6K016O+pHgPafGoa6+vqYd2ndv/iiME43TbhUGu7sCEsjoMy1
         /st+1bCf97jCEHCNl+JGTLjcyCAFapAQWi4Co3cUmznKBsIF2eK4GhmFpPhiIKMHdWd6
         TecmRU3HlDgQwRyV7clNIzTpMxnkjx248NB9jf4tLrpJCEt3MkjVVW6yEYbqn4dQh1Tk
         eDPod9Yov4Wp1UEk4Jk5dIjqPm+PF74K4MqIfs21gfC+UlFDmNzPoAVO2fRwAERutkdF
         0IrA==
X-Gm-Message-State: AOAM530XhqHx3OL2rDJEQHN3hJaXAv35noU23WDRaoqElxE6vf1QK2bJ
        ho/2uVDEtbG9KKIGuWwjuuFa/bBuLWG/zfoC6HKGeLB3NtzaGAbBmpUQtqpKZExoyUQfs305b6W
        sEfMpwpwxxESM9SXAMIQlpg==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr26031887edb.281.1634379499474;
        Sat, 16 Oct 2021 03:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuJiWcON3M4nXKn747LTbTpMeMQmvBtJaORLUCaPCevFz0HcJ8P2t0t0MZp62LMyoxb4bUTQ==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr26031859edb.281.1634379499200;
        Sat, 16 Oct 2021 03:18:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m18sm3371750ejn.62.2021.10.16.03.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 03:18:18 -0700 (PDT)
Subject: Re: [PATCH 05/12] regulator: Introduce tps68470-regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
 <YWnPaI/ZECdfYre9@sirena.org.uk>
 <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
 <YWnZIZTPiuAIazV+@sirena.org.uk>
 <c595b143-d7ed-e76b-7734-e03d14e0f76e@redhat.com>
 <YWndpGgBtLEAEaNj@sirena.org.uk>
 <1805d16e-87ab-c291-6a73-adabf41344ca@redhat.com>
 <YWoAtCdikYfMpUnD@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <26a1b636-1b82-2ca6-4f78-b1d22fa556d6@redhat.com>
Date:   Sat, 16 Oct 2021 12:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWoAtCdikYfMpUnD@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mark,

On 10/16/21 12:29 AM, Mark Brown wrote:
> On Fri, Oct 15, 2021 at 10:14:30PM +0200, Hans de Goede wrote:
>> On 10/15/21 9:59 PM, Mark Brown wrote:

<snip>

>> During that discussion you said that instead we should sinmply
>> directly pass the regulator_init_data, rather then first
>> encoding this in device-properties in a swnode and then
>> decoding those again in the regulator core.
> 
>> And passing the regulator_init_data is exactly what we are doing
>> now; and now again this is not what we should be doing ?
> 
> No, it is not what the driver doing now.  The driver will *optionally*
> check for platform data, but if none is provided or if it doesn't
> configure some of the regulators then the driver will provide some hard
> coded regulator_init_data as a default.  These might be OK on the system
> you're looking at but will also be used on any other system that happens
> to instantiate the driver without platform data where there's no
> guarantee that the information provided will be safe.  These defaults
> that are being provided may use the same structure that gets used for
> platform data but they aren't really platform data.
> 
> Yes, someone could use this on a system that does things in the standard
> fashion where the platform data is getting passed in but if it's ever
> run on any other system then it's going to assume this default platform
> data with these constraints that have been embedded directly into the
> driver without anything to ensure that they make sense on that system.
> 
> Indeed, now I go back and dig out the rest of the series it seems that
> there's some drivers/platforms/x86 code added later which does in fact
> do the right thing for some but not all of the regulators, it supplies
> some platform data which overrides some but not all of this default
> regulator_init_data using platform_data having identified the system
> using DMI information (with configurations quite different to and much
> more restricted than the defaults provided, exactly why defaults are an
> issue).  I'm now even more confused about what the information that's
> there is doing in the driver.  Either it's all unneeded even for your
> system and should just be deleted, or if any of it is needed then it
> should be moved to being initialised in the same place everything else
> is so that it's only used on your system and not on any other system
> that happens to end up running the driver.
> 
> In any case given that your platform does actually have code for
> identifying it and supplying appropriate platform data the driver itself
> can be fixed by just deleting the else case of
> 
> 	if (pdata && pdata->reg_init_data[i])
> 		config.init_data = pdata->reg_init_data[i];
> 	else
> 		config.init_data = &tps68470_init[i];
> 
> and the data structure/macro it uses.  If no configuration is provided
> by the platform then none should be provided to the core, this in turn
> means that the regulator framework won't reconfigure the hardware if it
> doesn't know it's safe to do so.

Ah, ok. The default regulator_init_data in the tps68470_init[]
array was already there in the out of tree version of this driver
Daniel and I started with:

https://github.com/intel/linux-intel-lts/blob/4.14/base/drivers/regulator/tps68470-regulator.c

Now that you have pointed this out I would be more then happy to
delete it and I agree that providing this bogus data is not a
good idea.

<snip>

> The important thing is to get rid of the hard coded defaults for the
> regulator_init_data in the driver itself, if there is regulator_init_data
> in the driver itself then it should be guarded with a DMI or similar
> quirk.  Like I say above I think now I've gone back and dug through the
> rest of the series once the default init_data is gone it's probably OK.

Ok, for the next version of this patch-set I will:

1. Remove the default init_data
2. Change the toplevel comment to be all C++ style matching the SPDX line
3. Add a || COMPILE_TEST to the Kconfig so that this can be compile-tested
   without selecting the INTEL_SKL_INT3472 option

Thank you for taking the time to dive a bit deeper into the patch-set
and make it clear that your objection is the presence of the default
regulator_init_data; and sorry for loosing my cool a bit in my previous
email.

Regards,

Hans

