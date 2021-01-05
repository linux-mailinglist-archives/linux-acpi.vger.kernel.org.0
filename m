Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1132EA567
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 07:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAEGZr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 01:25:47 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35589 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbhAEGZr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 01:25:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BD60E580553;
        Tue,  5 Jan 2021 01:25:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 05 Jan 2021 01:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=N
        Cgc2BalphfKGG4aBWNk6OJ60l8uwTPLt9jJB7A+fGA=; b=Q/gF8uvV4VZc8JoUt
        cFJ0GaKDLYljr8ck2GQn/nhm4p8pqFDmg/Fi8CsLIXBrdlh9UJbf9sFLple7NXMr
        Mx62xHNThAhc8R/K/+OQb1BstP2xtWIO2ABD/HxdD7T9qZl1T/hdOCdkGZ8eyRoD
        fs3Ti/6tlVTSIB1KO+obek4GHKmAIXUvlV2OWq6vqX1rvZeGA18KBsQa6BqlNOg+
        A/WMlggIF+6KAm3V5fOiS0nJeUB96hNywlGVV/Kryo4WGpn4sZVj/hA2R00wps7Z
        waNsYAXlr0GjfgL2W4Vf8GaB+YlJa7C4w61O5pRT3V321kGVY2GH5sy3tJQO/+3M
        4GKig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=NCgc2BalphfKGG4aBWNk6OJ60l8uwTPLt9jJB7A+f
        GA=; b=haODKpgwAAa7cHDzJpzevRBZCg7AQsCvuoPBWOe06zQQo8EyaSO9itwdF
        2wdZ6m8QQkqRjW46YRiv5QEgpZa5pONecb05N4yP4BvNE7fg+O3alNIdhZhhvZFM
        UON5ZA88AfJoFi9GCl7CC+1ioZX+/ecVYdEKFnhgCEtd5GSfvzsH8g0ppXw96oPu
        +mZ7jbjb0uzrfru1NnaokU45YVQB2XbHs6KStHBFwP+hYIJot305lYVdDOTqCisI
        DuWrlLF6u3efP9N3OCbPvBxjFa0Zw34L5Wn97rWXmL7UOhwEKAKDjH2P4mI1S7XC
        2a/SQqHboMlROrhrmh7sMt8V3evUA==
X-ME-Sender: <xms:OQb0Xynbht16e_1MlDOBf7TQ6AQ_NSgSXCRSI978nnCCLU9huw7YzA>
    <xme:OQb0X51CFFuNCRZC2X4ec-_nMVC33oEykiwxyYtTEbpiu9f5QxLCJ1fCaAVt0Qhfb
    iPYmNoaE9PVZO3UX-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvledvvdeukeekjeffudehtdefudfgkedujeevfeevjeelvddt
    ueeivdegueetieenucffohhmrghinheplhgvnhhovhhordgtohhmrdgtnhenucfkphepge
    ehrdeffedrhedtrddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:OQb0XwrDlYHD14FEZUlVboSYMS2OjY0uDOnrjGAB39IdNazmYVUCzA>
    <xmx:OQb0X2lzGnhqRksXxWVHfnmZfIz9V6imCr7njakC_pEUX7jCec734A>
    <xmx:OQb0Xw0-A5YAohb36pd27KvePlh1YYLzx5Popc8flQP5VExRZPs98A>
    <xmx:Owb0X6pc9abW9tQBuonzhUYMCoRRPhzsSwKtMUDzH1JyORvr5I130A>
Received: from [0.0.0.0] (li1000-254.members.linode.com [45.33.50.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F7B61080057;
        Tue,  5 Jan 2021 01:24:53 -0500 (EST)
Subject: Re: [External] Re: [PATCH 0/2] IdeaPad platform profile support
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
 <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
 <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
 <2eefa5ec-4f09-eabd-2c20-f217fa084dfc@lenovo.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <75952842-3ee3-82a2-7809-66e2d5263c73@flygoat.com>
Date:   Tue, 5 Jan 2021 14:24:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2eefa5ec-4f09-eabd-2c20-f217fa084dfc@lenovo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

在 2021/1/5 上午5:58, Mark Pearson 写道:
> On 04/01/2021 15:58, Hans de Goede wrote:
>> Hi,
>>
>> On 1/4/21 9:33 PM, Rafael J. Wysocki wrote:
>>> On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com>
>>>   wrote:
>>>> Hi,
>>>>
>>>> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
>>>>> Tested on Lenovo Yoga-14SARE Chinese Edition.
>>>>>
[...]
> Just for my understanding of what happens next....please correct me if I
> have anything wrong:
>
>   - platform_profile gets pulled from ACPI for 5.11
>
>   - platform_profile gets updated to add this data/pointer implementation
> and goes into 5.12.
Hi all,

Another approach could be just let all the patch go through pdx86 tree 
and with
pointer part acked by Rafael as it's unlikely to have merge conflicts.

> Jiaxun, let me know if you're happy with following
> up on that based on Hans suggestions, If you are pushed for time let me
> know and I'll happily help out/implement/test as required. I sadly don't
> have any ideapads but very happy to support your efforts any way I can.


I'm happy with Hans suggestion, will send v2 for it later.

I've been ask Lenovo engineers about DYTC and other ideapad ACPI
stuff on Lenovo China forum[1], but moderator here told me Lenovo won't
invest any Linux effort on their consumer product line :-(

Is it possible to publish a DYTC specification or documents to help us 
further
understand these mechanisms?

I'm tired of reading disassembly AML and code to figure out these internals.

>
>   - Can we get the x86 portion done at the same time or does that end up
> going to 5.13? I had been looking at the ideapad_laptop.c patch and have
> some concerns there as Jiaxun's patch is essentially a duplicate of what
> I implemented in thinkpad_acpi.c which doesn't seem to be ideal
> (especially as there is a V6 version of DYTC coming out this year). I
> haven't had time to look at code to consider better alternatives though...

It may be worthy to share these code but I'm comfort to have this 
duplication as I'm
unsure about the future of DYTC. Will DYTC for thinkpads always coherent 
with DYTC
for ideapads?

Thanks.

[1]: https://club.lenovo.com.cn/thread-5980431-1-1.html

- Jiaxun

>
> Mark

