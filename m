Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833025F611E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Oct 2022 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJFGlx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Oct 2022 02:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJFGlw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2022 02:41:52 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A933863;
        Wed,  5 Oct 2022 23:41:51 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae8a0.dynamic.kabel-deutschland.de [95.90.232.160])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1040A61EA192D;
        Thu,  6 Oct 2022 08:41:48 +0200 (CEST)
Message-ID: <604a0903-e849-6ffa-1972-91f809690a26@molgen.mpg.de>
Date:   Thu, 6 Oct 2022 08:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: New error in 5.15: ACPI BIOS Error (bug): Could not resolve
 symbol [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <520d0a5b-cbae-554c-4905-5a68cc5f5ca6@molgen.mpg.de>
 <09403867fc1f0f89b06b5dbdb269fccf8ba22f99.camel@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <09403867fc1f0f89b06b5dbdb269fccf8ba22f99.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Srinivas,


Thank you for your reply.

Am 27.09.22 um 05:13 schrieb srinivas pandruvada:

> On Thu, 2022-09-22 at 18:57 +0200, Paul Menzel wrote:

>> Moving from Linux 5.10.113 to 5.15.69 on
>>
>>       [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.22.0 07/13/2022
>>       […]
>>       [    1.521806] smpboot: CPU0: Intel(R) Core(TM) i7-7700 CPU @3.60GHz (family: 0x6, model: 0x9e, stepping: 0x9)
>>
>> Linux logs the errors below:
>
> These errors are coming from interpreter. Please try the latest
> upstream kernel, to see if there is some version incompatibility.

You are right, with commit 2bca25eaeba61 (Merge tag 'spi-v6.1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi) I am unable 
to reproduce it.

In 5.15.71 we have:

     [    1.357209] ACPI: Core revision 20210730

while in Linus’ current master (“6.1-rc0”) we have:

     [    1.377877] ACPI: Core revision 20220331


Kind regards,

Paul
