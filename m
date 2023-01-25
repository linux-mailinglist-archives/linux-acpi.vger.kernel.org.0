Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64467B12B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjAYL2x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjAYL2V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628319EF8
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674646053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAXVbQ97ZxwjsentYq0CfzBjn+pygJ3o7IS0xpGSlI4=;
        b=TPWIdjmZ6ysEgvfgoJ6W2Tsa28s4fZyJbS6Z95MN/Cvxt9jzn04UAp71a1iEzipf22U8Gs
        GciVmvwo9n78AekXRKSD8B1p/sEs11KMaOOvQ4rAA2ocCpmGhB6IPAjcnYAXKxMdQhhKRj
        12Z01g1ToDbQpPihxyTHJvTiI920aPI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-gDaAXbViOy61QaqXi1lP7Q-1; Wed, 25 Jan 2023 06:27:32 -0500
X-MC-Unique: gDaAXbViOy61QaqXi1lP7Q-1
Received: by mail-ed1-f71.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso12828505edd.10
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAXVbQ97ZxwjsentYq0CfzBjn+pygJ3o7IS0xpGSlI4=;
        b=RyLy2e8oN9sw82i0AbR+gcjBl4PgzjlvpI/dA8lDAbuHzDoXEabizUYOdVzSIQ1nU5
         l/+LzuDWq0B21MQhV2qMLgLuotNc3YMXi2KD7+lR0+mBzlPGMrfpcSYiFmnAzETLNC56
         jNGtEGvT1Rn6dkg8BdA7b3+xpWblhXJKZOpaOzt4CsXtTQy/gDhJ8XL8IDEteMWfpDqJ
         IcH4igs1lh63tzIudaTiTOlxuhB+2EEoXZTUNqgEkeYuxtOV7aj+8PswxtkIyLI43vDE
         f3/d9LnPVdfr+JRHzLbLmAEhJm9SBnAMsdCy9p2L8V1abdmqyM30vkfkY2NZLyyrOuSw
         Z5Ww==
X-Gm-Message-State: AO0yUKW/znuvH3y4J/hmXd20S39NQtgnJIcvoVY9prY/4c8s1iKH+fD9
        Nd1CEAfMAIxBGOKyLjmvlDSryaE8pj/SbgbNe3uMijNZwfOBGgs/KhKmAw9RhQAsRcEoGZC9qr3
        kFYTsMX5dtIMWhFTWxr0Plw==
X-Received: by 2002:a17:907:1c12:b0:7fd:eb9e:6fd5 with SMTP id nc18-20020a1709071c1200b007fdeb9e6fd5mr5140844ejc.45.1674646049763;
        Wed, 25 Jan 2023 03:27:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+i/m/zbhzkMhjOpF3UYIL+peY5VlFUiGOTonIdZPJJVuHY5eVrK+0GVIb2M0z47QviYRtq1w==
X-Received: by 2002:a17:907:1c12:b0:7fd:eb9e:6fd5 with SMTP id nc18-20020a1709071c1200b007fdeb9e6fd5mr5140822ejc.45.1674646049519;
        Wed, 25 Jan 2023 03:27:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q4-20020a1709064c8400b007c0d4d3a0c1sm2214916eju.32.2023.01.25.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:27:28 -0800 (PST)
Message-ID: <40a048b6-bcd3-4b13-8e48-45cb44246b80@redhat.com>
Date:   Wed, 25 Jan 2023 12:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 1/1] pinctrl: amd: Fix handling of
 PIN_CONFIG_BIAS_PULL_UP/_DOWN settings
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230125103916.16772-1-hdegoede@redhat.com>
 <20230125103916.16772-2-hdegoede@redhat.com>
 <CAHp75VdKei2GtGuLZ4R=WxzciPFjVhDji+wO3xWU4Z893z0J8A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdKei2GtGuLZ4R=WxzciPFjVhDji+wO3xWU4Z893z0J8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/25/23 12:14, Andy Shevchenko wrote:
> On Wed, Jan 25, 2023 at 12:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> PIN_CONFIG_BIAS_PULL_UP is documented as follows:
>>
>> @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
>> impedance to VDD). If the argument is != 0 pull-up is enabled,
>> if it is 0, pull-up is total, i.e. the pin is connected to VDD.
>>
>> This patch fixes 2 issues with how the AMD pinctrl code was handling this:
>>
>> 1. amd_pinconf_set() was setting the PULL_UP_ENABLE bit as follows:
>>     pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
>>     pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
>>    When called from gpio_set_bias() for ACPI enumerated GPIOs arg == 1,
>>    so the pull-up enable bit would be cleared instead of being set.
>>    It seems unnecessary to say that this is BAD.
>>
>>    There is no real convention for the meaning of arg other then that
> 
> than
> 
>>    a value != 0 means the pull-up should be enabled (which was being
>>    violated here). Looking at other drivers the Intel pinctrl drivers
>>    all treat 1 (as used by gpio_set_bias()) as indictating that the
> 
> indicating
> 
>>    driver should pick the pull-up strength; and all other values are
>>    interpreted as the amount of ohm with which to pull-up, with non
>>    supported values being rejected with -EINVAL.
>>
>>    This patch changes the AMD pinctrl code to match this behavior so
>>    that the behavior of all x86 pinctrl drivers is consistent.
>>
>> 2. arg == 0 does not mean that the pull-up/-down is disabled as the
>>    old code was assuming. Rather it means that the "pull-up is total,
>>    i.e. the pin is connected to VDD". The correct way for
>>    amd_pinconf_get() to indicate that the pull-up/-down is not enabled
>>    is to return -EINVAL. I've checked a whole bunch of pinctrl drivers
>>    and they all behave this way. This patch brings the AMD pinctrl driver
>>    in line with this.
>>
>> Fixes: dbad75dd1f25 ("pinctrl: add AMD GPIO driver support.")
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=212379
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/pinctrl/pinctrl-amd.c | 37 +++++++++++++++++++++++++++--------
>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
>> index 9bc6e3922e78..88174195b5c8 100644
>> --- a/drivers/pinctrl/pinctrl-amd.c
>> +++ b/drivers/pinctrl/pinctrl-amd.c
>> @@ -744,11 +744,19 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
>>                 break;
>>
>>         case PIN_CONFIG_BIAS_PULL_DOWN:
>> -               arg = (pin_reg >> PULL_DOWN_ENABLE_OFF) & BIT(0);
>> +               if (!(pin_reg & BIT(PULL_DOWN_ENABLE_OFF)))
>> +                       return -EINVAL;
>> +               arg = 1;
>>                 break;
>>
>>         case PIN_CONFIG_BIAS_PULL_UP:
>> -               arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
>> +               if (!(pin_reg & BIT(PULL_UP_ENABLE_OFF)))
>> +                       return -EINVAL;
>> +
>> +               if (pin_reg & BIT(PULL_UP_SEL_OFF))
>> +                       arg = 8000;
>> +               else
>> +                       arg = 4000;
>>                 break;
> 
> Do I understand correctly that there is only one bias value possible
> for Pdown (4k?) and two for Pup (4k & 8k)?

Yes I believe so, it has been a while ago and I don't know
where I got the 8k and 4k values from anymore (oops) ...

> Also I have stumbled over _OFF. Does it actually mean "offset"? Can we
> rename to avoid (my) confusion with OFF as something being "off"?
> (Maybe a separate patch?)

Yes it means offset, I actually stumbled over this while re-reading
the patch myself too. So definitely something to fix.

> 
>>         case PIN_CONFIG_DRIVE_STRENGTH:
>> @@ -790,15 +798,28 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>>                         break;
>>
>>                 case PIN_CONFIG_BIAS_PULL_DOWN:
>> -                       pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
>> -                       pin_reg |= (arg & BIT(0)) << PULL_DOWN_ENABLE_OFF;
>> +                       pin_reg |= BIT(PULL_DOWN_ENABLE_OFF);
>>                         break;
>>
>>                 case PIN_CONFIG_BIAS_PULL_UP:
>> -                       pin_reg &= ~BIT(PULL_UP_SEL_OFF);
>> -                       pin_reg |= (arg & BIT(0)) << PULL_UP_SEL_OFF;
>> -                       pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
>> -                       pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
>> +                       /* Set default ohm value in case none is given */
>> +                       if (arg == 1)
>> +                               arg = 4000;
>> +
>> +                       switch (arg) {
>> +                       case 4000:
>> +                               pin_reg &= ~BIT(PULL_UP_SEL_OFF);
>> +                               pin_reg |= BIT(PULL_UP_ENABLE_OFF);
>> +                               break;
>> +                       case 8000:
>> +                               pin_reg |= BIT(PULL_UP_SEL_OFF);
>> +                               pin_reg |= BIT(PULL_UP_ENABLE_OFF);
>> +                               break;
>> +                       default:
>> +                               dev_err(&gpio_dev->pdev->dev,
>> +                                       "Invalid pull-up arg %u\n", arg);
>> +                               ret = -EINVAL;
>> +                       }
> 
> Can Pup and Pdown be enabled simultaneously?

I believe so, so I think that we also need to clear the other
enable bit (e.g. clear down when enabling up) when enabling
the pull up / down. I'll do this for v2 (after waiting for other
comments first).

>>                         break;
>>
>>                 case PIN_CONFIG_DRIVE_STRENGTH:
> 
> After your answers I might come with some comments, but FWIW the
> code-wise this seems correct approach.

Thank you for taking a look.

Regards,

Hans

