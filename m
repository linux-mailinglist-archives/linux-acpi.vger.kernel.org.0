Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFB7715FD
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Aug 2023 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHFP6U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Aug 2023 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFP6U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Aug 2023 11:58:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBD1B3;
        Sun,  6 Aug 2023 08:58:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qSg92-0001dY-NT; Sun, 06 Aug 2023 17:58:16 +0200
Message-ID: <1315675b-295a-fd26-0e54-86cb6cdbbcf1@leemhuis.info>
Date:   Sun, 6 Aug 2023 17:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
Content-Language: en-US, de-DE
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <20230806151453.10690-1-hdegoede@redhat.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230806151453.10690-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691337499;c93a2866;
X-HE-SMSGID: 1qSg92-0001dY-NT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 06.08.23 17:14, Hans de Goede wrote:
> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
> quirks") is causing keyboard problems for quite a log of AMD based
> laptop users, leading to many bug reports.
> 
> Revert this change for now, until we can come up with
> a better fix for the PS/2 IRQ trigger-type/polarity problems
> on some x86 laptops.

Thx for this.

> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726

Not that it matters much, but there is at least one more:

https://lore.kernel.org/lkml/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/

> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I tend to think this is the right thing to do. But for completeness to
ensure everybody is aware of this: I'm pretty sure (Mario will know for
sure) this will cause a regression for a few users, because a9c4a912b7dc
was meant fixing a regression for them. Not sure how many users this
might affect, but I guess it are at least those linked to in a9c4a912b7dc:

https://bugzilla.kernel.org/show_bug.cgi?id=217336
https://bugzilla.kernel.org/show_bug.cgi?id=217406
https://bugzilla.kernel.org/show_bug.cgi?id=217394

I assume that could be avoided by adding quirk entries for their
machines. Some of the tickets have the data to do so.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
