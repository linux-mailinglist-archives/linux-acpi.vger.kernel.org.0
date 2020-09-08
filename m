Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB57D2620F1
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 22:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIHUTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 16:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgIHUTb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2020 16:19:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA1C061573;
        Tue,  8 Sep 2020 13:19:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u21so264252eja.2;
        Tue, 08 Sep 2020 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjIPp6Eyls79nuZJqGgOMonyVj5blXaXyZkArJ7OmMI=;
        b=k3xGDY6xo2owK5AkMpWvsnO3hcN771NeaL5eGo5K7dFhQMEejE3AR31sOcgdJhXyjx
         6xPTDW6YsTt554gSRhqoP3vIQwQ6uwdL18IxQzFojUEAM0GDgsnptbxFBMmCHh2gA/SX
         jVMzW19yly/C5z/Hq5evRAumGSaxo7XWMqjume3rwOi2IPl3o9gureJ3GUV/WAgJt8Gx
         dD4EoY+ndMIbPVZUi2+BVaD0Nck3t6o71HG7hwVz9o41BMqZNV2Ax2qvgfnnd9Sc/Tpq
         y71e28R5lgY2yVzMN2Yz1O6MHwwodPOz2ryfVlc7YZr0iGFMD8YVml8qJyLLT4GVg7T4
         mb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjIPp6Eyls79nuZJqGgOMonyVj5blXaXyZkArJ7OmMI=;
        b=pqVwjO8SahmQel43K7W9s9W9ASqvB1dy1zBVG6a2ku2CEDXjkwucynJwm47wMmoqvI
         vOrk1Sd+kQt13ayUeSQujEhJ/OJJU3pDAV8TTMpGaHRgl5gEKt+NMEuYxjearxah685b
         /mItXgYmsu7iqkd7ZWZSBo2igZGNLNpA+cr+LhtMmpWMIaYxjQ1iWh3egXtv8uMXjbxN
         fO6jvxaA6bRarGMs0FEZiVa6GIAbGCNI6COXNz9nvUodSKZCBCgpOcLmfsR1D73J7BwW
         iLvoOEYldhIsNF5zMeaM2FKExGs+pWzz9j54aKLXuWo85HZUK8w3JRzlOQ+/A0P+ulth
         TViA==
X-Gm-Message-State: AOAM531W1RMRqcm+ezJ4zIFwm6QxAKu1BwS1k+Thq6d+YICoy2aDaq6j
        G8Iqu8Uoy8tkvCq+rWZekQBXV8xC0nU=
X-Google-Smtp-Source: ABdhPJz5hML8XQIhRFBwbylroe6NBneVR57ta9d1HSXVfjAYlds1OuSG3jAAuAzY5e4wjchfC3BR5A==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr233628ejc.100.1599596369435;
        Tue, 08 Sep 2020 13:19:29 -0700 (PDT)
Received: from [192.168.2.202] (p5487bef6.dip0.t-ipconnect.de. [84.135.190.246])
        by smtp.gmail.com with ESMTPSA id lg22sm199449ejb.48.2020.09.08.13.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 13:19:28 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] platform/x86: Add Driver to set up lid GPEs on MS Surface
 device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200908171934.1661509-1-luzmaximilian@gmail.com>
 <CAHp75VevrwKaba_FsZj-nPqJGR9fkmFPzvdCew0wCqF_L6QLbA@mail.gmail.com>
Message-ID: <d1d3b1bb-1d7b-ae8d-fbe4-23f995df47fb@gmail.com>
Date:   Tue, 8 Sep 2020 22:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VevrwKaba_FsZj-nPqJGR9fkmFPzvdCew0wCqF_L6QLbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/8/20 8:40 PM, Andy Shevchenko wrote:
> On Tue, Sep 8, 2020 at 8:20 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:

...

>> +       .gpe_number = 0x17,
>> +       .gpe_number = 0x4D,
>> +       .gpe_number = 0x4F,
>> +       .gpe_number = 0x57,
> 
>  From where these numbers come from? Can we get them from firmware (ACPI)?

Yes, they are obtained from ACPI/the DSDT. Specifically from the name of
the GPE handler notifying the lid device. See [1] for a repo full of
Surface ACPI dumps (source for this). I'll add a comment pointing this out
in v2.

[1]: https://github.com/linux-surface/acpidumps

...

>> +static int surface_gpe_probe(struct platform_device *pdev)
>> +{
>> +       const struct surface_lid_device *lid;
>> +       int status;
>> +
> 
>> +       lid = dev_get_platdata(&pdev->dev);
>> +       if (!lid)
>> +               return -ENODEV;
> 
> Can we use software nodes?

As far as I can tell this would work via fwnode_create_software_node /
fwnode_remove_software_node and device properties? I don't seem to find
much documentation on this (there doesn't seem to be an entry for
software nodes in the official docs?), but I think I should be able to
make this work.

>> +       status = acpi_mark_gpe_for_wake(NULL, lid->gpe_number);
>> +       if (status) {
>> +               dev_err(&pdev->dev, "failed to mark GPE for wake: %d\n", status);
>> +               return -EINVAL;
>> +       }
>> +
> 
>> +       status = acpi_enable_gpe(NULL, lid->gpe_number);
> 
> Did I miss anything or all calls of enable / disable GPE are using
> NULL as a first parameter? What the point in such case?

As far as I can tell, some of the more generic uses have a non-NULL
gpe_device parameter (acpi/device_pm.c, acpi/wakeup.c) and NULL just
means index-0/main device? Not an expert on that though, so probably
just ignore me here and let the ACPI guys answer this.

...

>> +MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurfacePro:*");
>> +MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurfacePro4:*");
> 
> Can simply
> 
> MODULE_ALIAS("dmi:*:svnMicrosoftCorporation:pnSurface*:*");
> 
> work?

Depends on your preference, really. That would also auto-load the module
on Surface Pro 3 and earlier devices (just won't do anything on those).
So it's a trade-off between unnecessary loading of the module and
maintainability/readability. Let me know what you prefer and I'll switch
to that.

Style and other issues are noted, I'll fix them for v2.

Regards,
Max
