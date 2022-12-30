Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDBA659722
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Dec 2022 11:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiL3KLv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Dec 2022 05:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3KLt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2022 05:11:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1518101D6;
        Fri, 30 Dec 2022 02:11:47 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBCMc-0003A1-Im; Fri, 30 Dec 2022 11:11:46 +0100
Message-ID: <702e11a8-f38b-8f99-8d8a-6342e90fddd7@leemhuis.info>
Date:   Fri, 30 Dec 2022 11:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6.2 regression fix] gpiolib: Fix using uninitialized
 lookup-flags on ACPI platforms #forregzbot
Content-Language: en-US, de-DE
To:     "regressions @ lists . linux . dev" <regressions@lists.linux.dev>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20221229164501.76044-1-hdegoede@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221229164501.76044-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672395108;95780a6b;
X-HE-SMSGID: 1pBCMc-0003A1-Im
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 29.12.22 17:45, Hans de Goede wrote:
> Commit 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups") refactors
> fwnode_get_named_gpiod() and gpiod_get_index() into a unified
> gpiod_find_and_request() helper.
> 
> The old functions both initialized their local lookupflags variable to
> GPIO_LOOKUP_FLAGS_DEFAULT, but the new code leaves it uninitialized.
> 
> This is a problem for at least ACPI platforms, where acpi_find_gpio()
> only does a bunch of *lookupflags |= GPIO_* statements and thus relies
> on the variable being initialized.
> 
> The variable not being initialized leads to:
> 
> 1. Potentially the wrong flags getting used
> 2. The check for conflicting lookup flags in gpiod_configure_flags():
>    "multiple pull-up, pull-down or pull-disable enabled, invalid config"
>    sometimes triggering, making the GPIO unavailable
> 
> Restore the initialization of lookupflags to GPIO_LOOKUP_FLAGS_DEFAULT
> to fix this.
> 
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note I'm not working and not reading work email until Monday January 9th.
> I hit this while doing some hobby stuff and I decided to send this out
> right away to avoid others potentially wasting time debugging this, but
> I will not see any replies until Monday January 9th.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 8eb1f71e7acc
#regzbot title gpiolib: potentially the wrong flags getting used
#regzbot fix: gpiolib: Fix using uninitialized lookup-flags on ACPI
platforms
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
