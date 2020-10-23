Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C15297122
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750393AbgJWOQY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 10:16:24 -0400
Received: from smtp.radex.nl ([178.250.146.7]:59095 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750392AbgJWOQY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 10:16:24 -0400
Received: from [192.168.1.158] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id C172724065;
        Fri, 23 Oct 2020 16:16:21 +0200 (CEST)
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 1/2] device property: Keep secondary firmware node
 secondary by type
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
 <20201023123412.GA614478@kuha.fi.intel.com>
Message-ID: <cca210f1-503e-0f6c-b394-a86f9abf8c67@gmail.com>
Date:   Fri, 23 Oct 2020 16:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023123412.GA614478@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

Op 23-10-2020 om 14:34 schreef Heikki Krogerus:
> On Thu, Oct 22, 2020 at 09:40:59PM +0300, Andy Shevchenko wrote:
>> Behind primary and secondary we understand the type of the nodes
>> which might define their ordering. However, if primary node gone,
>> we can't maintain the ordering by definition of the linked list.
>> Thus, by ordering secondary node becomes first in the list.
>> But in this case the meaning of it is still secondary (or auxiliary).
>> The type of the node is maintained by the secondary pointer in it:
>>
>> 	secondary pointer		Meaning
>> 	NULL or valid			primary node
>> 	ERR_PTR(-ENODEV)		secondary node
>>
>> So, if by some reason we do the following sequence of calls
>>
>> 	set_primary_fwnode(dev, NULL);
>> 	set_primary_fwnode(dev, primary);
>>
>> we should preserve secondary node.
>>
>> This concept is supported by the description of set_primary_fwnode()
>> along with implementation of set_secondary_fwnode(). Hence, fix
>> the commit c15e1bdda436 to follow this as well.
>>
>> Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
>> Cc: Ferry Toth<fntoth@gmail.com>
>> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> FWIW:
>
> Reviewed-by: Heikki Krogerus<heikki.krogerus@linux.intel.com>
> Tested-by: Ferry Toth<fntoth@gmail.com>
>> ---
>>   drivers/base/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index c852f16c111b..41feab679fa1 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4278,7 +4278,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>>   	} else {
>>   		if (fwnode_is_primary(fn)) {
>>   			dev->fwnode = fn->secondary;
>> -			fn->secondary = NULL;
>> +			fn->secondary = ERR_PTR(-ENODEV);
>>   		} else {
>>   			dev->fwnode = NULL;
>>   		}
>> -- 
>> 2.28.0
