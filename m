Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9661F6641
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jun 2020 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgFKLHG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jun 2020 07:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgFKLHF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2020 07:07:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64734C08C5C1;
        Thu, 11 Jun 2020 04:07:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 870492A424F
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mario.Limonciello@dell.com
Cc:     rjw@rjwysocki.net, rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, lenb@kernel.org, kernel@collabora.com,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        ayman.bagabas@gmail.com, benjamin.tissoires@redhat.com,
        blaz@mxxn.io, dvhart@infradead.org, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, jeremy@system76.com, 2pi@mok.nu,
        mchehab+samsung@kernel.org, rajatja@google.com,
        srinivas.pandruvada@linux.intel.com,
        platform-driver-x86@vger.kernel.org
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
 <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
 <20200610214033.GB248110@dtor-ws>
 <adf9daaf08f1464684e48ec203194fe9@AUSX13MPC105.AMER.DELL.COM>
 <20200610224305.GC248110@dtor-ws>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1e32b7db-5457-e0cf-5e5e-36f21d5a91eb@collabora.com>
Date:   Thu, 11 Jun 2020 13:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610224305.GC248110@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/6/20 0:43, Dmitry Torokhov wrote:
> On Wed, Jun 10, 2020 at 09:52:12PM +0000, Mario.Limonciello@dell.com wrote:
>>> -----Original Message-----
>>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Sent: Wednesday, June 10, 2020 4:41 PM
>>> To: Limonciello, Mario
>>> Cc: enric.balletbo@collabora.com; rjw@rjwysocki.net; rafael@kernel.org;
>>> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; lenb@kernel.org;
>>> kernel@collabora.com; groeck@chromium.org; bleung@chromium.org;
>>> dtor@chromium.org; gwendal@chromium.org; vbendeb@chromium.org;
>>> andy@infradead.org; ayman.bagabas@gmail.com; benjamin.tissoires@redhat.com;
>>> blaz@mxxn.io; dvhart@infradead.org; gregkh@linuxfoundation.org;
>>> hdegoede@redhat.com; jeremy@system76.com; 2pi@mok.nu;
>>> mchehab+samsung@kernel.org; rajatja@google.com;
>>> srinivas.pandruvada@linux.intel.com; platform-driver-x86@vger.kernel.org
>>> Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
>>>
>>>
>>> [EXTERNAL EMAIL]
>>>
>>> On Wed, Jun 10, 2020 at 09:28:36PM +0000, Mario.Limonciello@dell.com wrote:
>>>>>
>>>>> To give you some references, if I'm not wrong, this prefix is used in
>>> all
>>>>> or
>>>>> almost all Intel Chromebook devices (auron, cyan, eve, fizz, hatch,
>>>>> octopus,
>>>>> poppy, strago ...) The ACPI source for this device can be found here
>>> [1],
>>>>> and,
>>>>> if not all, almost all Intel based Chromebooks are shipped with the
>>>>> firmware
>>>>> that supports this.
>>>>
>>>> You can potentially carry a small patch in your downstream kernel for the
>>>> legacy stuff until it reaches EOL.  At least for the new stuff you could
>>>> enact a process that properly reserves unique numbers and changes the
>>> driver
>>>> when the interface provided by the ACPI device has changed.
>>>
>>> If we use this prefix for hatch EOL is ~7 years from now.
>>>
>>
>> Isn't the whole point of the ACPI registry and choosing an ID?  You know internally
>> if you need to change the interface that a new ID is needed and a new driver will
>> be needed that comprehends that ID change.  So if you can't guarantee that 0001 is
>> the same driver interface in every firmware implementation google used then that is
>> where this falls apart.
>>

As far as I know GGL0001 has the same driver interface in every firmware
implementation Google used. But I'll ask to make sure.

>> I know there is a long support lifecycle but you're talking about rebasing
>> to new LTS kernels a handful of times between now and then.  If the interface really
>> is stable the patch should be small and it shouldn't be a large amount of technical
>> debt to carry downstream until EOL.
> 
> I think we are talking about different things actually. Let's forget
> about Chrome OS and downstream kernels. We have devices that have
> already been shipped and in hands of users. Some of them are old, some
> of them are new. We can't not enforce that firmware for these devices
> will be either released or updated. Therefore, if we want expose this
> device in mainline kernel, we need to have it handle "GGL0001" HID in
> addition to whatever proper HID we may select for it.
> 

FWIW, after investigate a bit more, although GGL is not in the ACPI ID list it
is in the PNP ID list [1]. So as far as I understand GGL0001 is valid ID. I know
that PNP ID is the legacy identifier but since this was here for long time and
will be here also for long time, I am wondering if we can take that as an
argument to have GGL0001 as a valid device to be exposed in the kernel.

Thanks,
 Enric

[1] https://uefi.org/pnp_id_list


> We internally can fix it (HID) for next generation of devices.
> 
> Thanks.
> 
