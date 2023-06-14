Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754172F86E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jun 2023 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbjFNIyB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jun 2023 04:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbjFNIx5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2023 04:53:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8F2688;
        Wed, 14 Jun 2023 01:53:37 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9MFz-0003eN-0R; Wed, 14 Jun 2023 10:53:35 +0200
Message-ID: <9d0ebb3a-3385-bfc3-13ce-41d54aaec4b4@leemhuis.info>
Date:   Wed, 14 Jun 2023 10:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Content-Language: en-US, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>, Acid Bong <acidbong@tilde.cafe>
Cc:     bagasdotme@gmail.com, linux-acpi@vger.kernel.org,
        rafael@kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
References: <20230609165505.GA1251392@bhelgaas>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230609165505.GA1251392@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686732817;fcb67973;
X-HE-SMSGID: 1q9MFz-0003eN-0R
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09.06.23 18:55, Bjorn Helgaas wrote:
> On Fri, Jun 09, 2023 at 02:09:17PM +0300, Acid Bong wrote:
>> Hi there, hello.
>>
>> About a week ago I returned to using Gajim, which, as I remember from
>> earlier, also seemed to be responsible for these hangings, and they got
>> more frequent (I haven't updated any software for the last 2 months). I
>> decided to move to the kernel version 6.1.1, which I earlier marked as
>> "good", and my laptop hung last evening during the shutdown. As always,
>> nothing in the logs.
>>
>> I tried to compile some versions from 5.15.y branch, but either I had a
>> bad luck, or the commits weren't properly compatible with GCC 12 yet,
>> but they (.48 and .78) emitted warnings, so I never used them (or I
>> broke the repo, who knows).
>>
>> Due to the fact that software does have impact on this behaviour, and
>> due to my health issues and potential conscription (cuz our army doesn't
>> care about health), which will cut me from my laptop for a long-long
>> time, I give up on bisecting. I'll just update all my software (there's
>> also a GCC upgrade in the repos) and hope for the best.
>>
>> Sorry for inconvenience and have a great day. Thank you very much.
> 
> No inconvenience on our side; your help is invaluable, especially for
> intermittent problems like this one.  They are really hard to find and
> debug, and I'm sorry that we didn't get this one resolved.

+1

Then let me remove this from the regression tracking, too.

#regzbot inconclusive: ignored, reporter for various real life reasons
unfortunately will be unable to bisect/debug
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
