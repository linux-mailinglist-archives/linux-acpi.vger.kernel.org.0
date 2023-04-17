Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C16E4789
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Apr 2023 14:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjDQMWH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Apr 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjDQMVe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2023 08:21:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50032AD09
        for <linux-acpi@vger.kernel.org>; Mon, 17 Apr 2023 05:21:01 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1poNEV-0003Sc-Dr; Mon, 17 Apr 2023 13:41:19 +0200
Message-ID: <617301ed-b353-06e0-49a2-d4180832031d@leemhuis.info>
Date:   Mon, 17 Apr 2023 13:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Regression] acpi: laptop panics early in boot
Content-Language: en-US, de-DE
To:     linux-acpi@vger.kernel.org
Cc:     regressions@lists.linux.dev
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681734061;64856142;
X-HE-SMSGID: 1poNEV-0003Sc-Dr
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 06.03.23 22:45, Pierre Asselin wrote:
> 
> Laptop crashes when booting on AC power.
> 
> The laptop is on Gentoo; upgrading from 5.15.88 to 6.1.12, the kernel
> panics before reaching early userspace.  I find no other report like
> this on the Gentoo, arch, mint, or Ubuntu forums, on kernel.org, or out
> of duckduckgo.  This is a regression (because, you know, the kernel used
> to boot) but so far it's only me, and only on my 16-year old laptop.
> Also, I have a workaround.
> [...]
> #regzbot introduced d6fb6ee1820c

regzbot accidentally missed the fix for this, hence let me point to it
manually:

#regzbot fix: c56610a869bce03490
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
