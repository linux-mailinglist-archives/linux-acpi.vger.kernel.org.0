Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE55A7F25
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiHaNoW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiHaNoP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 09:44:15 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1381D124A
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 06:44:10 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 15E13142D4;
        Wed, 31 Aug 2022 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661953448; bh=HKk3f41Y4Roi0bsePunhLGMmO/fsxwHf7+iaDMZOn9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AJqnFJTGuMORwL7QSR2UdIEOcz1gmarN/4YlI4ioBrp13WNqMobaDBn0hsrJRfAxX
         3OjCtrJtzHWbpOm5apKyNN5m2AQhrcVEpUjhqDvzDZo8RVPPEfo4rY0Ng7RCO/WD2g
         xdk0Kt3Twn9U3Uipi1aaxEDTzLBY8NwQipDkuVwmnkcEmNQNBSSE+MI+Ho/tatz499
         4CD9hlhhcLeR0YPXXvjl+j5NmmMmxqkVxsYPlSXh3AgZaOhpCRS7KJBsFDLySq96cH
         V09FvKwbVFEjIC0vARjcdJwkAJbe8eld4rfJ47x70qNOtt0F/5+qIlLgXVZaVol7oI
         N3TPyTy0Tg/UA==
Message-ID: <918639a6-3cb0-5b8d-73b2-7eed623002a0@vorpal.se>
Date:   Wed, 31 Aug 2022 15:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
 <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
 <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
 <ef3046e5-f402-3d33-8d94-4d9f87ceadd5@vorpal.se>
 <68b1c4fd-56a4-8de6-62ec-98bd6ef8b169@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <68b1c4fd-56a4-8de6-62ec-98bd6ef8b169@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


On 2022-08-29 20:58, Hans de Goede wrote:
> Hi,
> 
> On 8/29/22 20:30, Arvid Norlander wrote:
>> Hi,
>>
>> On 2022-08-29 16:12, Hans de Goede wrote:
>>> Hi,
>>>
>>
>> <snip>
>>
>>>
>>> Arvid, here is a git branch with my backlight-refactor for you
>>> to test:
>>>
>>> https://github.com/jwrdegoede/linux-sunxi/commits/backlight-refactor-for-arvid
>>>
>>> If you can give this a test spin (without any special kernel
>>> commandline options) then that would be great.
>>
>> I'll set up a PKGBUILD and get this built (I'm building on other computers).
>> It may take a couple of days before I get around to that however. I hope
>> this is okay with you.
> 
> Yes that is fine, thank you.

Just and update to let you know that your tree works, at least for suspend.

I'm not set up to test hibernation (using swap file on btrfs). Nor do I
know if it even works on this laptop. It has some sort of auto hibernate
feature in BIOS called Intel Rapid Start. It supposedly auto transitions to
hibernation after being asleep for a while. I have not looked into if this
is supported on Linux, and what setup would be required to support it in
that case.

> 
> Regards,
> 
> Hans
> 

Best regards,
Arvid Norlander
