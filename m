Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C755BE257
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Sep 2022 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiITJsv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Sep 2022 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiITJsu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2022 05:48:50 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBD6E2DC;
        Tue, 20 Sep 2022 02:48:48 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 1F1B4147E0;
        Tue, 20 Sep 2022 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1663667325; bh=zEZHnbBa+6Fr7SMiR8nx4C8hqji8Co2Df87UPvBlwSc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sw3Z6fgmtEQ+7vTpY/8dA5kbeFYcRjnz6OfTOi7lphLtBcVIrhk+Hd9gLkMJWPuLa
         uSxSzB7AI3jhFBb1q+2MIV1Hn3tLJ8Zs4CelYcd+J6QmWbFIkjxCgEBq5tBxJXLU/d
         KyLMSfW7iwpcIjXkZnsoAe0gQNJyvyIDcnNOZNPfxY9yRuYDig6efG3+Am7QRbrMak
         sSvnEEyM8cwReR4/yToIcrRnjHrXKdXTpHGEgCcJLSDIanZQgJ/n1qbehUvqcMrtf0
         EUrKLjko4Gcxibi0/EzSLoKra8qA6FKPR7sD20Vx39W4tw9M6U8W89HiVEwZUyKR+a
         55/T0R8yd4LQg==
Message-ID: <484b5248-ebf2-74c9-0629-08daa538a5c0@vorpal.se>
Date:   Tue, 20 Sep 2022 11:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC 1/2] staging: quickstart: Add ACPI quickstart button
 (PNP0C32) driver
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220911194934.558019-1-lkml@vorpal.se>
 <20220911194934.558019-2-lkml@vorpal.se>
 <0e88f032-5f29-8842-401e-48a573319ecf@redhat.com>
Content-Language: en-US
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <0e88f032-5f29-8842-401e-48a573319ecf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-09-19 11:27, Hans de Goede wrote:
> Hi,
> 
> On 9/11/22 20:49, Arvid Norlander wrote:
>> This is loosly based on a previous staging driver that was removed. See
>> links below for more info on that driver. The original commit ID was
>> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
>>
>> However, here a completely different approach is taken to the user space
>> API (which should solve the issues the original driver had). Each PNP0C32
>> device is a button, and each such button gets a separate input device
>> associated with it (instead of a shared platform input device).
>>
>> The button ID (as read from ACPI method GHID) is provided via a sysfs file
>> "button_id".
>>
>> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
>> to true. This can be reset by a user space process.
>>
>> Link: https://marc.info/?l=linux-acpi&m=120550727131007
>> Link: https://lkml.org/lkml/2010/5/28/327
>> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
> 
> 2 high level remarks here:
> 
> 1. I believe we should strive for having all issues with this driver fixed
> before merging it, at which point it should not sit under drivers/staging
> but rather under drivers/platform/x86 (as an added bonus this can also make
> toshiba_apci's Kconfig bit select it automatically). So for the next version
> please move this to drivers/platform/x86

Makes sense, will do. However, there is nothing x86 specific in theory with
this driver. Would it not make more sense to put it under drivers/acpi?

> 
> 2. This is using struct acpi_driver, but as Rafael (ACPI maintainer) always
> said that is really only for very special cases. The ACPI subsystem should
> instantiate standard platform devices for each PNP0C32 device, you can
> check this under: /sys/bus/devices/platform.  And this driver should then
> be convered to a standard platform_driver binding to the platform devices
> instead of being a struct acpi_driver.

I had a look at this, and it seems like a much more complicated a approach,
for example, there is no dedicated .ops.notify, which means I need to use
acpi_install_notify_handler, and there is no devm_ version of that either.
A lot of other things seem to be ever so slightly more complicated as well. 

What is the motivation behind this being preferred? And are most of the
existing drivers using acpi_driver legacy (e.g. toshiba_acpi)?


> 
> Please address these 2 things as well as the remarks from Barnabás and
> then send out a version 2. Then I will do a more detailed review of
> version 2 once posted.
> 
> Regards,
> 
> Hans
> 
<snip>
