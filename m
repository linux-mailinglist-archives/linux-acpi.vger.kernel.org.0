Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9E737E6F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jun 2023 11:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFUIrB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Jun 2023 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjFUIrA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2023 04:47:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB295;
        Wed, 21 Jun 2023 01:46:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBtUO-0002iS-5L; Wed, 21 Jun 2023 10:46:56 +0200
Message-ID: <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
Date:   Wed, 21 Jun 2023 10:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
Content-Language: en-US, de-DE
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me>
 <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me>
 <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch>
 <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687337219;d7e708c2;
X-HE-SMSGID: 1qBtUO-0002iS-5L
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[added Jason (who authored the culprit) to the list of recipients; moved
net people and list to BCC, guess they are not much interested in this
anymore then]

On 21.06.23 08:07, Sami Korkalainen wrote:
> I bisected again. It seems I made some mistake last time, as I got a
> different result this time. Maybe, because these problematic kernels may
> boot fine sometimes, like I said before.
> 
> Anyway, first bad commit (makes much more sense this time): 
> e7b813b32a42a3a6281a4fd9ae7700a0257c1d50 efi: random: refresh
> non-volatile random seed when RNG is initialized
> 
> I confirmed that this is the code causing the issue by commenting it
> out (see the patch file). Without this code, the latest mainline boots fine.

Jason, in that case it seems this is something for you. For the initial
report, see here:

https://lore.kernel.org/all/GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me/

Quoting a part of it:

```
Linux 6.2 and newer are (mostly) unbootable on my old HP 6730b laptop,
the 6.1.30 works still fine.
The weirdest thing is that newer kernels (like 6.3.4 and 6.4-rc3) may
boot ok on the first try, but when rebooting, the very same version
doesn't boot.

Some times, when trying to boot, I get this message repeated forever:
ACPI Error: No handler or method for GPE [XX], disabling event
(20221020/evgpe-839)
On newer kernels, the date is 20230331 instead of 20221020. There is
also some other error, but I can't read it as it gets overwritten by the
other ACPI error, see image linked at the end.

And some times, the screen will just stay completely blank.

I tried booting with acpi=off, but it does not help.
```
Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot introduced e7b813b32a42a3a6281a4fd9ae7700a0257c1d50
