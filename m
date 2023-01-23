Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC6677F49
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjAWPQS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjAWPPw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:15:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 427AE29437
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:15:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4B7C14;
        Mon, 23 Jan 2023 07:15:37 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49C203F5A1;
        Mon, 23 Jan 2023 07:14:55 -0800 (PST)
Message-ID: <6fc14182-520b-d3ee-410c-8be3bc98a514@arm.com>
Date:   Mon, 23 Jan 2023 16:14:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bug report] arch_topology: Build cacheinfo from primary CPU
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-acpi@vger.kernel.org
References: <Y86iruJPuwNN7rZw@kili>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Y86iruJPuwNN7rZw@kili>
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

Hello Dan,
The 'levels' and 'split_levels' variables are initialized through their
addresses when necessary, so I believe the warning can be ignored.

If you still want to have the variables initialized, please let me know and I
will send a patch,

Regards,
Pierre

On 1/23/23 16:07, Dan Carpenter wrote:
> Hello Pierre Gondois,
> 
> The patch 5944ce092b97: "arch_topology: Build cacheinfo from primary
> CPU" from Jan 4, 2023, leads to the following Smatch static checker
> warning:
> 
> drivers/base/cacheinfo.c:440 fetch_cache_info()	error: uninitialized symbol 'levels'.
> drivers/base/cacheinfo.c:447 fetch_cache_info() error: uninitialized symbol 'split_levels'.
> 
> drivers/base/cacheinfo.c
>      424 int fetch_cache_info(unsigned int cpu)
>      425 {
>      426         struct cpu_cacheinfo *this_cpu_ci;
>      427         unsigned int levels, split_levels;
>      428         int ret;
>      429
>      430         if (acpi_disabled) {
>      431                 ret = init_of_cache_level(cpu);
>      432                 if (ret < 0)
>      433                         return ret;
>      434         } else {
>      435                 ret = acpi_get_cache_info(cpu, &levels, &split_levels);
>      436                 if (ret < 0)
>      437                         return ret;
> 
> Apparently, I must have CONFIG_ACPI_PPTT disabled.
> 
>      438
>      439                 this_cpu_ci = get_cpu_cacheinfo(cpu);
> --> 440                 this_cpu_ci->num_levels = levels;
>                                                    ^^^^^^
> Unititialized.
> 
>      441                 /*
>      442                  * This assumes that:
>      443                  * - there cannot be any split caches (data/instruction)
>      444                  *   above a unified cache
>      445                  * - data/instruction caches come by pair
>      446                  */
>      447                 this_cpu_ci->num_leaves = levels + split_levels;
>      448         }
>      449         if (!cache_leaves(cpu))
>      450                 return -ENOENT;
>      451
>      452         return allocate_cache_info(cpu);
>      453 }
> 
> regards,
> dan carpenter
