Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2E6C685A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Mar 2023 13:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCWMbn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Mar 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCWMbm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2023 08:31:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B416AD6
        for <linux-acpi@vger.kernel.org>; Thu, 23 Mar 2023 05:31:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pfK6T-0005ns-TJ; Thu, 23 Mar 2023 13:31:38 +0100
Message-ID: <47a90870-8a71-a28f-bd8a-032a69cda596@leemhuis.info>
Date:   Thu, 23 Mar 2023 13:31:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression] acpi: laptop panics early in boot
To:     Pierre Asselin <pa@panix.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=83=c2=b6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
 <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
 <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
 <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
 <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679574701;03bd1af3;
X-HE-SMSGID: 1pfK6T-0005ns-TJ
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07.03.23 20:31, Pierre Asselin wrote:
>> Maybe the following patch helps (on top of v6.3-rc1):
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 9531dd0fef50..a5a8f82981ce 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32
>> type, void *data)
>>  	if (!adev)
>>  		goto err;
>>
>> -	if (adev->dev.driver) {
>> +	if (device_is_bound(&adev->dev)) {
>>  		struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
>>
>>  		if (driver && driver->ops.notify &&
>>
> 
> It does indeed "fix" 6.3-rc1.  Modulo locking issues, which I am
> not qualified to evaluate.

Uwe, what happens to this regression fix? It looks like it didn't make
any progress towards mainline, but maybe I missed something in my brief
search on lore.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
