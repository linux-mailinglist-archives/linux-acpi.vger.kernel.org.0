Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65FCFE0C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3Qlz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Apr 2019 12:41:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:28899 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3Qly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Apr 2019 12:41:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 09:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="153624424"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2019 09:41:53 -0700
Received: from brettjgr-mobl1.ger.corp.intel.com (unknown [10.254.180.216])
        by linux.intel.com (Postfix) with ESMTP id 6D07E5803DA;
        Tue, 30 Apr 2019 09:41:52 -0700 (PDT)
Subject: Re: [PATCH] ACPI / property: fix handling of data_nodes in
 acpi_get_next_subnode()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
 <20190430163041.GN9224@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ba56e822-92ee-7a75-5c62-45f3a572ccde@linux.intel.com>
Date:   Tue, 30 Apr 2019 11:41:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430163041.GN9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/30/19 11:30 AM, Andy Shevchenko wrote:
> On Tue, Apr 30, 2019 at 10:52:29AM -0500, Pierre-Louis Bossart wrote:
>> When the DSDT tables expose devices with subdevices and a set of
>> hierarchical _DSD properties, the data returned by
>> acpi_get_next_subnode() is incorrect, with the results suggesting a bad
>> pointer assignment. The parser works fine with device_nodes or
>> data_nodes, but not with a combination of the two.
>>
>> The problem is traced to an invalid pointer used when jumping from
>> handling device_nodes to data nodes. The existing code looks for data
>> nodes below the last subdevice found instead of the common root. Fix
>> by forcing the acpi_device pointer to be derived from the same fwnode
>> for the two types of subnodes.
>>
>> This same problem of handling device and data nodes was already fixed
>> in a similar way by 'commit bf4703fdd166 ("ACPI / property: fix data
>> node parsing in acpi_get_next_subnode()")' but broken later by 'commit
>> 34055190b19 ("ACPI / property: Add fwnode_get_next_child_node()")', so
>> this should probably go to linux-stable all the way to 4.12
> 
> Period is missed in above sentence.
> 
> I think it make sense to add Fixes: tag.

Thanks Andy for the review. I hesitated to add a fixes tag. The line 
about resetting the adev pointer was indeed removed in the latter 
commit, but there were a slew of other changes done later by Sakari on 
hierarchical _DSD so it's quite complicated to say when this was last 
fully functional.

> 
> Nevertheless,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you for fixing this interesting issue!
> 
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/acpi/property.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
>> index 5815356ea6ad..efc74f912f39 100644
>> --- a/drivers/acpi/property.c
>> +++ b/drivers/acpi/property.c
>> @@ -943,6 +943,16 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>>   		const struct acpi_data_node *data = to_acpi_data_node(fwnode);
>>   		struct acpi_data_node *dn;
>>   
>> +		/*
>> +		 * We can have a combination of device and data nodes,
>> +		 * e.g. with hierarchical _DSD properties. Make sure
>> +		 * the adev pointer is restored before going through
>> +		 * data nodes, otherwise we will be looking for
>> +		 * data_nodes below the last device found instead of
>> +		 * the common fwnode shared by device_nodes and
>> +		 * data_nodes
>> +		 */
>> +		adev = to_acpi_device_node(fwnode);
>>   		if (adev)
>>   			head = &adev->data.subnodes;
>>   		else if (data)
>> -- 
>> 2.17.1
>>
> 

