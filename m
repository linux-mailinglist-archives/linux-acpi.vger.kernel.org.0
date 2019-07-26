Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66C76293
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 11:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfGZJ3P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jul 2019 05:29:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36383 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfGZJ3P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jul 2019 05:29:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TXq-oPa_1564133351;
Received: from 30.39.133.192(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TXq-oPa_1564133351)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jul 2019 17:29:12 +0800
Subject: Re: [PATCH v4] ACPI / APEI: release resources if gen_pool_add fails
To:     James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
References: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com>
 <3c4ce1be-f873-8acd-0e9b-061f1c079717@arm.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <794d2bd0-af4f-8935-296f-b4cedd542800@linux.alibaba.com>
Date:   Fri, 26 Jul 2019 17:29:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c4ce1be-f873-8acd-0e9b-061f1c079717@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James,

在 2019/7/25 20:46, James Morse 写道:
> Hi Liguang,
>
> On 15/07/2019 07:58, luanshi wrote:
>> To avoid memory leaks, destroy ghes_estatus_pool and release memory
>> allocated via vmalloc() on errors in ghes_estatus_pool_init().
>>
>> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
>> ---
> Playing spot-the-difference with [v3], you've moved an empty line.
>
> Please include a change log in this space below the '---' tearoff. This helps reviewers
> know what you changed between versions, and git knows not to add stuff in here to the log.
>
> This is still:
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks for your review. Because your reviewed-by was given ealier, and 
the code is reconstructed,

so I remove the reviewed-by. I will send v5 by your suggestions.

Thanks,

Liguang

>
>
> Thanks,
>
> James
>
> [v3]
> https://lore.kernel.org/linux-acpi/1561258201-26917-1-git-send-email-zhangliguang@linux.alibaba.com/
>
>
>>   drivers/acpi/apei/ghes.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
> [...]
