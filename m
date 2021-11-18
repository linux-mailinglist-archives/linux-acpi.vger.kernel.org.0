Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FE456492
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhKRU7x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 15:59:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhKRU7x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 15:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637269012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unQKitJKhE8CiwWk7oD7qjBW8RzHNdc0OJrMyXYxXfc=;
        b=c87HxOgMInEaMuXXmUcXMywzaNE33zfNL3xLw5ti6pNJMFFZWhlKCyvQZDYFwhzCqDeEMf
        VzT59pJIBT1M9Bs6hwazLieuO8Rd+e1+TYDEu/K2J9SfbFSp5AhtWGUoqPhHs31nMB7WVI
        2lDEXWq0iyjmvJLCudgZcclW6VxKQZI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-fqIiXuc8MuSaLTg_N6DEJQ-1; Thu, 18 Nov 2021 15:56:51 -0500
X-MC-Unique: fqIiXuc8MuSaLTg_N6DEJQ-1
Received: by mail-ed1-f71.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so6426120edx.4
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 12:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=unQKitJKhE8CiwWk7oD7qjBW8RzHNdc0OJrMyXYxXfc=;
        b=i6pbLXQhpJWw4mtZSYabkmeqXnrK/bRZPOZYIEouhX88Id/DGtakQ9Ofqkh/I2aVEG
         2y8mGkfK1Hj/tRvwN+2FQ9ej/cxH/fKsMuqQXnB25bjfj+dcTiGyJhc2cr6oSHnUtmb9
         LNo3jWwALhr5XMoxuJhyhoNzVVEqS2VJ1YFkP8ky27f+3a3SO07p72CXtsJ620v184rk
         hy3Od/nlU78QV9MS+HBMnsNyUBP/SUN2EOK1IQNtju/utypDTxifmKBXhE/BD9oxIIZT
         96+FO+HWGRnoKa4oAXzpDOkXiwi8gZ5mtwFDmQ0KKXwluGOov/x7vzp4lqFWb4Q7HuiO
         5w4w==
X-Gm-Message-State: AOAM533damWaOPURSQF610h32Dpy7qO6kC4vMXUhF+JBFfx46Ka18Om3
        M8ZKgDNSChYh1u/kMuXu4+xrbSiYtJ0OLpIIfwpLvvPkz+OvgaEcy19kPIt5nEQyfhpOc2DUw7Q
        q/sv0fvJpLh5jmHrynbkM9w==
X-Received: by 2002:a17:907:7da9:: with SMTP id oz41mr549036ejc.57.1637269007807;
        Thu, 18 Nov 2021 12:56:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa6DtEvWfkZlwTUJAFc0kRx/YnRxDlZ/alE2N8LFGxKcmMwP3FCWwBsY9SarA/6ytxRMme1w==
X-Received: by 2002:a17:907:7da9:: with SMTP id oz41mr549012ejc.57.1637269007662;
        Thu, 18 Nov 2021 12:56:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id di4sm373349ejc.11.2021.11.18.12.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 12:56:47 -0800 (PST)
Message-ID: <307175ba-e289-6b2f-bcf2-cd0c5cf70296@redhat.com>
Date:   Thu, 18 Nov 2021 21:56:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some
 unused objects during scan
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20211117220118.408953-1-hdegoede@redhat.com>
 <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
 <937cf1fd-0cb1-1a12-7745-8cc2a2e3405a@redhat.com>
 <4363288.LvFx2qVVIh@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4363288.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/18/21 15:51, Rafael J. Wysocki wrote:
> On Thursday, November 18, 2021 12:15:28 PM CET Hans de Goede wrote:
>> Hi,
>>
>> On 11/18/21 12:08, Rafael J. Wysocki wrote:
>>> On Wed, Nov 17, 2021 at 11:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
>>>> unused objects") adds a:
>>>>
>>>>         bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
>>>>
>>>> call to acpi_scan_init(). On some devices with buggy DSDTs calling
>>>> _PS3 for one device may result in it turning off another device.
>>>
>>> Well, I'm going to revert this commit.  I'm sending a pull request
>>> with the revert later today.
>>>
>>>> Specifically the DSDT of the GPD win and GPD pocket devices has a
>>>> "\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
>>>> which _PS3 method sets a GPIO causing the PCI wifi card to turn off.
>>>>
>>>> I've an earlier, in some ways simpler, fix for this here:
>>>> https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch
>>>>
>>>> But the sdhci-acpi.c MMC host code already has an older workaround
>>>> for it to not toggle power on this broken ACPI object; and this
>>>> simpler fix would require keeping that workaround. So then we would
>>>> have 2 workarounds for the same issue in the kernel.
>>>>
>>>> Thus instead I've come up with a slightly different approach which
>>>> IMHO has ended up pretty well.
>>>>
>>>> Patches 1-3 of this series are this different approach and assuming
>>>> they are considered ok must be merged into 5.16 to fix the regression
>>>> caused by commit c10383e8ddf4 on these devices.
>>>
>>> So I'll have a look at these and if they look good, we can do that
>>> instead of the problematic commit in 5.17.
>>
>> I'm a bit confused now, if the problematic commit is going to get
>> reversed then technically we don't need this series anymore ?
> 
> That's correct.
> 
>> Or are you planning on re-introducing it in some form for 5.17 ?
> 
> I have been considering this.
> 
>> With that said getting this series merged would still be good,
>> patch 1 + 2 make the existing always_present quirk code more generic
>> which might be useful later. And then patch 3 (which is small)
>> allows dropping some ugliness from the sdhci-acpi.c code since
>> the DSDT bug we are hitting will now be solved by the
>> new acpi-dev-status-override mechanism.
> 
> OK, so this would be applicable for 5.17, but a couple of changelogs
> need to be updated if I'm not mistaken.
> 
> Can you please do that and resend the series?

I will update some of the commit messages and send a v2 tomorrow.

Regards,

Hans

