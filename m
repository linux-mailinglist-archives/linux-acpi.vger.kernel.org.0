Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84362971E
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiKOLSQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 06:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiKOLRi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 06:17:38 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A456727CD1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 03:17:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E6BB9604F1;
        Tue, 15 Nov 2022 12:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668511046; bh=h3hy+6tg6TT/Zz13V3q7yRmUwdY8nS3qe0cl8HhX6pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FaztWP/PQ5zlP+891bfECIHcrLf23KbOrBpKH/ZSgjHK0Xmf0QdH9ZCn6fEZdpXUa
         dtiT1ITch2fxHFjGK4LPIh8BW4FgjwA5TCx3R/jsLeXCxLznz6GGKullWUBzJCgk1b
         8xgKYHuvB6w94VwOhXnVhl40s1Aol+GjGdaCkphg6zZezavcVlKjEKfvsWPTV+3JpA
         /zwC+OTv6ksq5f18QERwLjl5JqS1J5IsXpufxBTrD2FcgPAY+yWUCg2imfGxyHZA4j
         FHXb8eE1f+LZtNl1wmA/leRLm9rzyl9BKRn0U9qZtrcb4T8UmOaPCWfTOkK+/cujyi
         n4GrW7E/p27+w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0g9pTHMAaV_h; Tue, 15 Nov 2022 12:17:24 +0100 (CET)
Received: from [10.0.1.33] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id CEB24604F0;
        Tue, 15 Nov 2022 12:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668511044; bh=h3hy+6tg6TT/Zz13V3q7yRmUwdY8nS3qe0cl8HhX6pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jq+2iMtbmcz7A+W7qdUbWTqAAlMcBEY679+O1B0rfzviCD2s6Qupg5gA3MMtCS9G1
         cWK4kxMOWLGfpmoSWCxu9k9jOhMNysAWjbljjCQ81Lh86PJUbPjJecHghwU6MqC2xZ
         M/C/jIj1cgCe3BcRffqSlehc/8jLJZmkeX4S9kLb6wbbFa1CNtPxHpsm1MbDYvvKAp
         1Lqnv8lN38KywCh2B2Ysu/uq793bv5zCY4iK9CrK1FzPCQNRRaMM8BI0R9uDf4m1S3
         DR2vexNMd2x05sBI2b7Qla7vLatZ2UqGgIrR+ttg23w6zw2gBxm2XdRX4ocuuOQoZp
         bl7ondwVWeZ2w==
Message-ID: <ea0f43bc-c5ca-de6a-f9f2-9ce3730110a2@alu.unizg.hr>
Date:   Tue, 15 Nov 2022 12:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
 <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
 <bd1f0d2a-d456-92cc-ecca-23e480aea4b1@alu.unizg.hr>
 <e5d3d561bb3a9c68bc903cfc35c27629a4a9225c.camel@linux.intel.com>
 <d034dbbc-613c-1a5e-df64-d0251453c8eb@alu.unizg.hr>
 <6c2f47c8-d6b5-074a-4c8f-e9cd04f62ef4@alu.unizg.hr>
 <180b1a4fb9cf78c8905f275e0373e009224d4639.camel@linux.intel.com>
 <78e347e9-c8b1-f228-ca32-0ad6186a6285@alu.unizg.hr>
 <a4457f46-72c9-f9b0-b87a-cb3dd5cd066f@alu.unizg.hr>
 <CAJZ5v0jfHtOXDFUFYj8EOGMT74iWfkQqEW3L2D2dZv6Y1jFSrw@mail.gmail.com>
 <761ee287-99d7-9695-6e10-44a2080ae6d9@leemhuis.info>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <761ee287-99d7-9695-6e10-44a2080ae6d9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 15.11.2022. 11:36, Thorsten Leemhuis wrote:
> 
> 
> On 28.10.22 20:25, Rafael J. Wysocki wrote:
>> On Thu, Oct 27, 2022 at 8:20 PM Mirsad Goran Todorovac
>> <mirsad.todorovac@alu.unizg.hr> wrote:
>>>
>>> Re-sending compressed attachments to fit into the size limit.
>>>
>>> On 27. 10. 2022. 20:03, Mirsad Goran Todorovac wrote:
>>>> P.S.
>>>>
>>>> Forgot another useful thing you've mentioned: please find attached the
>>>> dmesg output.
>>>>
>>>> Good luck!
>>
>> I'm wondering if the problem is reproducible with this patch applied:
>>
>> https://patchwork.kernel.org/project/linux-acpi/patch/20221019073443.248215-1-chenzhongjin@huawei.com/
> 
> Mirsad, did you ever give that a try?
> 
> Side note: while looking into this, I noticed that Rafael proposed and
> merged a different fix:
> https://lore.kernel.org/all/2669303.mvXUDI8C0e@kreacher/
> https://patchwork.kernel.org/project/linux-acpi/patch/2669303.mvXUDI8C0e@kreacher/
> 
> Ciao, Thorsten

Hi, Thorsten,

Yes, I gave it considerable effort, however four of my kernels {4.14, 
4.9, 4.4 and 4.0} did not boot at all, now I have the problem that the 
menu config doesn't respect CONFIG_DEBUG_KMEMLEAK=y.

I am serious about this and I had some 80 builds in the last month.
Right now I have problems with my day job. :-/

Hope to catch up with you soon.

Cheers,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
