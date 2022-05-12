Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA63524F32
	for <lists+linux-acpi@lfdr.de>; Thu, 12 May 2022 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiELOBn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 May 2022 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354903AbiELOBm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2022 10:01:42 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A03517E6
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 07:01:38 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aeace.dynamic.kabel-deutschland.de [95.90.234.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2398361EA1923;
        Thu, 12 May 2022 16:01:37 +0200 (CEST)
Message-ID: <b94fadf6-a258-8ea4-7ba8-90eb862e2578@molgen.mpg.de>
Date:   Thu, 12 May 2022 16:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Dell XPS 13 9310: Power Resource [PIN] results in 260 ms delay
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Dell.Client.Kernel@dell.com, Stellan Pop <stelian@popies.net>
References: <c61aab3b-74c9-4d17-7896-fba1bfedb1ab@molgen.mpg.de>
In-Reply-To: <c61aab3b-74c9-4d17-7896-fba1bfedb1ab@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Cc: +Zhang, +Dell.Client.Kernel@dell.com (though I have never received 
a response from that Dell team]

Dear Linux folks,


Am 04.11.20 um 20:20 schrieb Paul Menzel:

> Booting Linux on the Intel Tiger Lake Dell XPS 13 9310, there is a 260 
> ms delay during startup.
> 
>      [    0.298217] ACPI: Power Resource [D3C] (on)
>      [    0.558918] ACPI: Power Resource [PIN] (off)
> 
> As it’s off, I assume, it’s some kind of timeout. I uploaded the logs 
> and the ACPI table dumps to the Linux bug tracker [1].
> 
> If you could suggest, how to debug this further, that’d be great.
> 
> I also suggest, that Linux prints a warning if certain parts take too 
> much time, so firmware developers or engineers are finding bugs in their 
> code early.

This is still an issue with Linux 5.17.3. Is there an easy way to debug 
this? The device is in production use by a user, so I cannot do a lot of 
reboot cycles.

I also thought, Intel’s QA lab has access to several Dell systems, and 
could maybe reproduce this.

It’d be great if you could comment in the Linux kernel bug tracker [1].


Kind regards,

Paul


> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=209931
