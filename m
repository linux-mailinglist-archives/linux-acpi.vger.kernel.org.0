Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8267813D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjAWQUQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjAWQUP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 11:20:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A5EAEB5A
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 08:20:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D04F143D;
        Mon, 23 Jan 2023 08:20:53 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605183F5A1;
        Mon, 23 Jan 2023 08:20:11 -0800 (PST)
Message-ID: <32be7ef3-61d7-3f25-7e98-1e8bfc557737@arm.com>
Date:   Mon, 23 Jan 2023 17:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bug report] arch_topology: Build cacheinfo from primary CPU
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-acpi@vger.kernel.org
References: <Y86iruJPuwNN7rZw@kili>
 <6fc14182-520b-d3ee-410c-8be3bc98a514@arm.com> <Y86rRxRCbel5xUE0@kadam>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Y86rRxRCbel5xUE0@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 1/23/23 16:44, Dan Carpenter wrote:
> On Mon, Jan 23, 2023 at 04:14:56PM +0100, Pierre Gondois wrote:
>> Hello Dan,
>> The 'levels' and 'split_levels' variables are initialized through their
>> addresses when necessary, so I believe the warning can be ignored.
> 
> I don't understand what "initialized through their addresses when
> necessary" means.  If you have CONFIG_ACPI_PPTT turned off as I do then
> acpi_get_cache_info() is a no-op so it's not initializing anything.

Ok yes indeed. I will send a fix shortly.
Sorry for the trouble,
Pierre

> 
>>
>> If you still want to have the variables initialized, please let me know and I
>> will send a patch,
> 
> I feel like I have this kind of discussion a lot.  I don't know why
> people don't want to initialize their variables to zero.
> 
> 1) It doesn't affect runtime on modern distros because they use the
>     CONFIG_ option to zero stack variables.
> 
> 2) If they don't then syzbot will detect it at runtime.  It will probably
>     take a year or two.  That will set off a bunch of emails.  Meanwhile
>     you will have joined an exciting new start up and won't be around.
>     No one else will remember how this code works.
> 
> regards,
> dan carpenter
> 
> 
