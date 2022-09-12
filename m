Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510B5B5483
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Sep 2022 08:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiILG3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiILG2T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 02:28:19 -0400
Received: from vorpal.se (unknown [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768912761;
        Sun, 11 Sep 2022 23:28:01 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 181C7147DF;
        Mon, 12 Sep 2022 06:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662964050; bh=zMqRzJKpslH43MlyJxHywqzkLBGdVVn6aZr3claNmcg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZpJcih+soMRnhedwLxircvIc7BjokJIfMAfO3ZWnzSzFt/loBZN4RiSUmWBUWXIx9
         d71GBwaA08vY6u79D3h9nDW7lgumAqzkT4ViTfI5IaiydI1wtrFrQYAUeATZyIh4Qy
         jIXtjhi4aSS5PiUMrcW12vbYUc3yec6iVDsGzndjKB49Tu5fikgIzaoz5G3oFA+3jc
         o5GFiD99DSezN83I60sgHLdc1XeqIkZdpKkNFNErxbc20g/zOymwz1wgk1v6WtgmFb
         8YUNXVtUoo+3oRg73es7A0qIu2ZxHaHUnU/IlWUfZeA177l0b+d3wIqm2WarBTLFyc
         A+nSsZI8gfIVg==
Message-ID: <4dadf043-5d52-20c3-207e-27aee1120b59@vorpal.se>
Date:   Mon, 12 Sep 2022 08:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RFC 0/2] Quickstart buttons driver and Toshiba Z830
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220911194934.558019-1-lkml@vorpal.se>
 <n4eOueQW9oL86xdHuyF_thrcz7rwRvVavkwXIM1_BfIZcDwQjWDSoPTDMppNhfHxhISs_hVTTbBOolGV2plbmfkWv6V61Uv_hR7l1dzwzYA=@protonmail.com>
Content-Language: en-US
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <n4eOueQW9oL86xdHuyF_thrcz7rwRvVavkwXIM1_BfIZcDwQjWDSoPTDMppNhfHxhISs_hVTTbBOolGV2plbmfkWv6V61Uv_hR7l1dzwzYA=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-09-12 00:58, Barnabás Pőcze wrote:
> 
> 2022. szeptember 11., vasárnap 21:49 keltezéssel, Arvid Norlander írta:
> 
>> [...]
>>
>> 1. Summary of standard
>> ======================
>>
>> Here is a brief high level summary of the standard for PNP0C32. See
>> https://archive.org/details/microsoft-acpi-dirapplaunch for the full
>> standard.
>>
>> PNP0C32 devices are "Direct Application Launch" buttons. The idea is that
>> they should work while the laptop is in various sleep modes (or even off).
>> The Z830 does not support waking from any sleep mode using these buttons,
>> it only supports them while it is awake.
>>
> 
> Hi
> 
> I might be way off here, but could it not be that one has to enable/allow
> the device to be able to wake the system up? Or did you test it on windows
> as well and it did not work there either?

Hi,

It does indeed not work under Windows either. In addition, the Toshiba ACPI
implementation is incomplete: the "required" _PRW method is missing. And
only about half of what would be needed to handle the wakeup button
identification is actually present in the DSDT as far as I can tell.

Furthermore, given what Toshiba uses the buttons for, waking from sleep
with them make little sense. One button is to toggle the touchpad on/off,
one is to select external display mode (mirrored, extended, ...) and one
is to toggle between normal and low power "eco mode" (it basically dims the
screen and limits the CPU speed under Windows).

I believe Toshiba for whatever reason simply decided to piggy back on this
standard for some strange reason for their buttons. This is odd as
toshiba_acpi already implements Fn key handling (which this laptop also
has). Who knows why they couldn't just hook up the physical buttons as
special keys. Because that is the only thing that sets these apart
physically: They are buttons, not keys.

Best regards,
Arvid Norlander

> 
> 
> Regards,
> Barnabás Pőcze
> 
>> Each PNP0C32 device represents a single button. Their meaning is completely
>> vendor defined. On Windows you can either:
>> * Make them launch an application when pressed (defined in the registry)
>> * Or an application can subscribe to specific Window messages to get
>> notified when they are pressed (this is how they are used by the Toshiba
>> software).
>> [...]
