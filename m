Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7728076B1F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfGZOKC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jul 2019 10:10:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGZOKB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jul 2019 10:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0628B337;
        Fri, 26 Jul 2019 07:10:01 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22AFF3F71F;
        Fri, 26 Jul 2019 07:10:00 -0700 (PDT)
Subject: Re: [PATCH v4] ACPI / APEI: release resources if gen_pool_add fails
To:     =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
References: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com>
 <3c4ce1be-f873-8acd-0e9b-061f1c079717@arm.com>
 <794d2bd0-af4f-8935-296f-b4cedd542800@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4d523cd0-cb09-3706-b417-bc118e821908@arm.com>
Date:   Fri, 26 Jul 2019 15:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <794d2bd0-af4f-8935-296f-b4cedd542800@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Liguang,

On 26/07/2019 10:29, 乱石 wrote:
> 在 2019/7/25 20:46, James Morse 写道:
>> On 15/07/2019 07:58, luanshi wrote:
>>> To avoid memory leaks, destroy ghes_estatus_pool and release memory
>>> allocated via vmalloc() on errors in ghes_estatus_pool_init().
>>>
>>> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
>>> ---
>> Playing spot-the-difference with [v3], you've moved an empty line.
>>
>> Please include a change log in this space below the '---' tearoff. This helps reviewers
>> know what you changed between versions, and git knows not to add stuff in here to the log.
>>
>> This is still:
>> Reviewed-by: James Morse <james.morse@arm.com>
> 
> Thanks for your review. Because your reviewed-by was given ealier, and the code is
> reconstructed,
> 
> so I remove the reviewed-by. I will send v5 by your suggestions.

There is no need to post a new version just to pick up the tags.

Having a versioned changelog on your future work makes it easier for reviewers to know
what changed between versions.


Thanks,

James
