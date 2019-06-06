Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4709E36FB8
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2019 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfFFJVn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jun 2019 05:21:43 -0400
Received: from foss.arm.com ([217.140.101.70]:43480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfFFJVn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jun 2019 05:21:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73209341;
        Thu,  6 Jun 2019 02:21:42 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494063F690;
        Thu,  6 Jun 2019 02:21:41 -0700 (PDT)
Subject: Re: [PATCH 01/13] acpi: utils: Cleanup acpi_dev_match_cb
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-2-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0iRfsLDezWAnr+PcOKOGYQuFFX3bTyhvxoqJ4mN6sGOYA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8490ee64-0d7b-dd9a-b269-129ed4611fc2@arm.com>
Date:   Thu, 6 Jun 2019 10:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iRfsLDezWAnr+PcOKOGYQuFFX3bTyhvxoqJ4mN6sGOYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 06/06/2019 10:14, Rafael J. Wysocki wrote:
> On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> acpi_dev_match_cb match function modifies the "data" argument
>> to pass on a result which could be easily deduced from the result
>> of the bus_find_device() call at the caller site. Clean this
>> up in preparation to convert the "match" argument for bus_find_device
>> to accept a "const" data pointer, similar to class_find_device. This
>> would allow consolidating the match routines for these two APIs.
> 
> This changelog can be improved IMO.

I agree. Will update it.

> 
> In fact, the final goal here is to pass (const void *) as the second
> argument to acpi_dev_match_cb() (which you could do right away in this
> patch if I'm not mistaken) which is because you want to modify the
> prototype of bus_find_device().
> 
> So why don't you write something like this in the changelog:
> 
> "The prototype of bus_find_device() will be unified with that of
> class_find_device() subsequently, but for this purpose the callback
> functions passed to it need to take (const void *) as the second
> argument.  Consequently, they cannot modify the memory pointed to by
> that argument which currently is not the case for acpi_dev_match_cb().
> However, acpi_dev_match_cb() really need not modify the "match" object
> passed to it, because acpi_dev_get_first_match_dev() which uses it via
> bus_find_device() can easily convert the result of bus_find_device()
> into the pointer to return.

Sure.

> For this reason, update acpi_dev_match_cb() to avoid the redundant
> memory updates and change the type of its second argument to (const
> void *)."

We can't do that quite yet, until we unify the prototype of the
bus_find_device().

>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/acpi/utils.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
>> index 7def63a..1391b63 100644
>> --- a/drivers/acpi/utils.c
>> +++ b/drivers/acpi/utils.c
>> @@ -725,8 +725,6 @@ bool acpi_dev_found(const char *hid)
>>   EXPORT_SYMBOL(acpi_dev_found);
>>
>>   struct acpi_dev_match_info {
>> -       const char *dev_name;
>> -       struct acpi_device *adev;
>>          struct acpi_device_id hid[2];
>>          const char *uid;
>>          s64 hrv;
>> @@ -746,9 +744,6 @@ static int acpi_dev_match_cb(struct device *dev, void *data)
> 
> And why not to change the type of the second arg to "const void *data" here?

Because, that would conflict with what bus_find_device() expects now. We make
the change only later. Since this change was a bit more intrusive than simply
changing the type of the parameter, I kept it as a preparatory patch.

Thanks for the review !

Suzuki
