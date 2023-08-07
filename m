Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF67719A0
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 07:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHGFwb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 01:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjHGFwb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 01:52:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D271703;
        Sun,  6 Aug 2023 22:52:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qStAJ-0004MR-4G; Mon, 07 Aug 2023 07:52:27 +0200
Message-ID: <9b53d6bb-5a74-0ba7-eda3-d7937686254b@leemhuis.info>
Date:   Mon, 7 Aug 2023 07:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
Content-Language: en-US, de-DE
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, August Wikerfors <git@augustwikerfors.se>
References: <20230806151453.10690-1-hdegoede@redhat.com>
 <130cb2e0-90b4-7d7b-1633-3469c859b30f@amd.com>
 <b37098da-4437-ef5b-53ae-a536f550df08@redhat.com>
 <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691387549;4ad4e187;
X-HE-SMSGID: 1qStAJ-0004MR-4G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07.08.23 06:38, Mario Limonciello wrote:
> On 8/6/23 13:20, Hans de Goede wrote:
>> On 8/6/23 19:13, Mario Limonciello wrote:
>>> On 8/6/23 10:14, Hans de Goede wrote:
>>>> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
>>>> quirks") is causing keyboard problems for quite a log of AMD based
>>>> laptop users, leading to many bug reports.
>>>>
>>>> Revert this change for now, until we can come up with
>>>> a better fix for the PS/2 IRQ trigger-type/polarity problems
>>>> on some x86 laptops.
>>>
>>> Reverting it is going to help a bunch of machines but cause
>>> regressions for others.  How do you prioritize which to fix when it
>>> comes to a regression?

It's up to Linus in the end, but to echo what Hans already said: I guess
Linus stance in this case would be along the lines of "let's get back to
a known state, even if we known that state has problems as well". And
that state is the mainline release 6.4 . Sure, Greg picked this up for
stable, but apart from that things boil down to "we tried something in
6.5-rc1, it did work well, so let's revert this until we work our a
proper solution that can be applied in a later cycle, no harm done".

> We haven't even given a try to fixing it; I think the revert is still
> hasty.

Some urgency is required, as (a) the patch made it into a stable release
(b) get closer to the end of the merge window and want to avoid last
minute changes.
> [...]
> Can we perhaps see if that works instead for some affected people?
> [...]

I'd say: it would be best to resolve this now with a revert, then we
might even reach the next stable-rc release (Greg unusually releases
those on Mon/Tue/Wed) and thus the next stable release. But let's please
definitely resolve this this week in mainline before -rc6.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
