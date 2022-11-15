Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF1629C3D
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKOOkQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKOOkP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 09:40:15 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0265F19C13
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 06:40:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D9C19604F0;
        Tue, 15 Nov 2022 15:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668523211; bh=Ko/8e95KC5NH/XRnekzYf0JWq1cGM7Z03zFlOcP1C+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SBXZuZ1WqHfs/3kz8P4zSBP+S2MxLHovfZIqM+Ze9eYltRREMZWSzFwXorZOWQD2e
         lejIEn1tQDM9Z5V8YEqs1vWhSLLJq7U3+4sFGNjJp3vrMQ6znlK7ES9YeKBYhoes2f
         XhUSS1AlIM3A8olNm5iJxhmhG0VRQJh1BcGz9l2lXghrlDM9MmF4WBUzZ8iHLRkFmo
         7xZyF55RhXd6OUjBapFX0uWsIS0xYwvV/GCaPgpDYIW2RLzi9QajuWkzsAniJnRv1K
         mVwhvhDScFls+oDih89Hwi9ORg3pIwBVzKbyNHWh0wqIjynwR2KHSSvFxNKnn9icBd
         vKPqBAdhfH21w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fMHi0P1g0u9e; Tue, 15 Nov 2022 15:40:09 +0100 (CET)
Received: from [10.0.1.33] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 25341604F7;
        Tue, 15 Nov 2022 15:40:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668523209; bh=Ko/8e95KC5NH/XRnekzYf0JWq1cGM7Z03zFlOcP1C+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IIc0BZPtqwM7W/8pxpP6b4uelUEmw5jOZRw4B3X1ibHrfVVAiv+qdmAMAZzVYdZfP
         JtCPlxZpLzoE++qDZtVslE/Z06i3vTqwYWsurvc4Gx7gcOQKirXBGEKx08qlJHEiin
         TFBAlJtIKhsG53i5Ugav8EkA2+ZRoIwU2ZVpO4ZU31SS/rjQFizL6K9De/JiICtXZv
         YvMx/+rLSWYTTChH45YP2XbSknxK2450ypXDehwjcYRkEZu4MnLJzLDzdftSA7FruM
         opZ0XjSq/hivWvcbjq7rNEsfKoTLocWlAwgMJJ7M1jG+edzv5uFL1NY/9afdnipqcm
         Egv5+XNiEf4kw==
Message-ID: <1523587b-9c31-ebed-3f32-28235452d025@alu.unizg.hr>
Date:   Tue, 15 Nov 2022 15:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        devel@acpica.org
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
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAJZ5v0jfHtOXDFUFYj8EOGMT74iWfkQqEW3L2D2dZv6Y1jFSrw@mail.gmail.com>
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

On 28.10.2022. 20:25, Rafael J. Wysocki wrote:
> On Thu, Oct 27, 2022 at 8:20 PM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> Re-sending compressed attachments to fit into the size limit.
>>
>> On 27. 10. 2022. 20:03, Mirsad Goran Todorovac wrote:
>>> P.S.
>>>
>>> Forgot another useful thing you've mentioned: please find attached the
>>> dmesg output.
>>>
>>> Good luck!
> 
> I'm wondering if the problem is reproducible with this patch applied:
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/20221019073443.248215-1-chenzhongjin@huawei.com/

Dear Rafael,

Thousand apologies. Your email was still bold in my Thunderbird, which 
means that I failed to notice it and open it.

The patch applied successfully to commit c7ff29763989 and it is 
currently building and still has to undergo torture tests.

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
