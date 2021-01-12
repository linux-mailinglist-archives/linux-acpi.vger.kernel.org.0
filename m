Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507752F2EB5
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 13:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbhALMJV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 07:09:21 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:52309 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729397AbhALMJV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 07:09:21 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id A1EE9580817;
        Tue, 12 Jan 2021 07:08:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Jan 2021 07:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=O
        BL61v2XfVh8uQoMWSj6E8vg41BekK27ZZGoQxu+gmc=; b=Phpm1HLBQq6x8ROOb
        klo/n1tZ7EOBaoJrgsDARSvsHzHgr660iOfFzFh7r2R218n27BTbooxrnB4F0MtC
        9b1UE34nPHt+t0letM3UB9fuhD9E2oXPOf3eTJaFZ1uauZVZDNh9xj8G39Sw8Z3s
        BTppXIb29AQSYXTdsOCa7NFK9HuB2pHb+6qZmCAKArTZ1PLcZNgoGWk1aDdU98I9
        lG0lI+tRmDeC5Lk6wM280YhaKRFm/NnGZEk02AHfZp2cVmcQQr1QqOkmCWSuhcym
        CpoK+5gtxrGBspdi5MLVBAHFgo9MKnKSRRUe9HC4icpM8tN0VJVpOi0pQzNHdBZ7
        esSXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=OBL61v2XfVh8uQoMWSj6E8vg41BekK27ZZGoQxu+g
        mc=; b=bhHGDV3VqlWRCCnF6Ac9ybSB3FUkAepzDOJLSU2HOJgzkYqUhAiZ9KAjd
        3sFTOoXKvmbC6wGuf56Qaj7o5mf49WmSSzse70hPhZWE8diN4E3h0h+1ivFm/a3w
        owLAmw0vWztB96bT4UK3IjbDfQef0HelvNRS218l+h58iCQf9vQrDoGDaOBmtIw4
        ftDG9Swxr1BQaGRGLgA7eAxMTRoo8AJnrUqDqjmezJYCxESNs4en8/tzHUFcTDBh
        V7jcIqkc+dHmIMooUKvDek3lLiHFHL1qD+NQzNHP95D4kSb+fcJ6aG5dANbrfJS9
        Kx1jW2t5dagbDed2OeXDR1szfQyiw==
X-ME-Sender: <xms:LZH9X007jVGeVrLKmwOtVUWr7FMDt1oFqhfq7qxMDO-wOzuAs4tpOA>
    <xme:LZH9X_GJW1WI8WjZcP1oNLCnRTt7lV8TVMWZIkFBO7Dt1MYldYNIjk9mtsYfX8gx_
    8o99R3ytiExxG6ZN4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepiefhgffhieekudegjeevgfffveegveegheffhfduieeiffffveff
    ueegveefgfefnecukfhppeeghedrfeefrdehtddrvdehgeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:LZH9X86ZdLU5bsHnjuIUpWQfaEIS7eRpcEdCvEQHBW-YXaeBbtx3NA>
    <xmx:LZH9X938n7fdwBSXcnRQ5XBqZrnxFGY8z6duYYeesMiIRQ6oiJ5nRg>
    <xmx:LZH9X3H8TOpHFYHZZnyru3iUaISr_oH9Sz8HUre0MZIjL9WwunY09Q>
    <xmx:LpH9X7g_WwWAzhcPyNKil8wXVyaIQj0OG5Qq5m3KFTDidYiQK69S4w>
Received: from [0.0.0.0] (li1000-254.members.linode.com [45.33.50.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 73A09240066;
        Tue, 12 Jan 2021 07:08:01 -0500 (EST)
Subject: Re: [pm:bleeding-edge 20/29] drivers/acpi/platform_profile.c:67:33:
 error: passing 'const struct platform_profile_handler to parameter of type
 'struct platform_profile_handler discards qualifiers
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
References: <202101081623.CGkLO3Kx-lkp@intel.com>
 <5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <106d7891-230f-18e1-1b0f-cb6a62cf0387@flygoat.com>
Date:   Tue, 12 Jan 2021 20:07:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

在 2021/1/12 下午6:42, Hans de Goede 写道:
> Hi,
>
> On 1/8/21 9:52 AM, kernel test robot wrote:
[...]
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
[...]
>>     2 errors generated.

Oops, thanks for the reminder, I should exclude 0day CI from mail filter.
It's wired that GCC didn't say anything about it.

> Ugh, so that means that the current version of the
> "ACPI: platform-profile: Pass profile pointer to driver callbacks"
> patch is no good. Since this is causing compile errors I assume
> that it will be dropped from the bleeding-edge branch.
> Is that right Rafael?

I'm not familiar with x86pdx and ACPI workflow.
Should I resend the patch or send a fixup patch?

>
> I believe that the best fix is to just drop the const everywhere,
> neither of the 2 planned uses has its platform_profile_handler defined
> as const:
>
> 1. In the thinkpad_acpi case it is not const, because of using set_bit
> calls to set the choices bits.
>
> 2. In the ideapad-laptop case it is not const because it will be
> embedded in the dynamically allocated drv_data struct.
>
> Jiaxun, can you do a new version where you drop the const (and
> explain why this is done in the commit message)  ?

Appreciate for your patient investigation!

>
> Regards,
>
> Hans
[...]

Thanks.

- Jiaxun

