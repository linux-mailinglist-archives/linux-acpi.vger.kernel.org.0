Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159106EFDFC
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Apr 2023 01:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjDZXYd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Apr 2023 19:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDZXYc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2023 19:24:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD73A87;
        Wed, 26 Apr 2023 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682551471; x=1714087471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4H9zDK6SHlCxdD/P33iRk6ZO9pdq3FKOGgHoVG/Cy5k=;
  b=A6x5RfxB3cfHEK5k5sepCKCcPCHL7zYKZcs3Dsup0ot3j9Btqw2IOseW
   S+QAnGd7l9y336IvnHs/0aZDhgvCp5Kdyj6NWh9es4pTxrxVQWhR+f3nX
   8nq2WMQauDiGxVXgQ10xW6HJ2Xk7zX+j70Y/we3cGW1UKCMuacLeRWYCX
   WyRu6X4xTsv1ZEsEfhPpdRpB+0GLZOKCtBSN3FiJ1ReRxoX3EBDv3nsA4
   5QOIWjtcQYeZfiJudapp+glf90vYdocnlQmg4tqAJ/fc60PRVGAvxqqnq
   fps+Xo4cJ3/xDVL2GuW4TAD8xBQnN+zeDniOx6cG3WPpYMGP1h/GOCaoL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="349210571"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="349210571"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 16:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="818288271"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="818288271"
Received: from saberggr-mobl1.amr.corp.intel.com (HELO [10.212.120.55]) ([10.212.120.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 16:24:30 -0700
Message-ID: <72d28547-941b-e7b8-470d-a352792ec90e@intel.com>
Date:   Wed, 26 Apr 2023 16:24:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/23] cxl: Add checksum verification to CDAT from CXL
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193567363.1178687.9185773070266307121.stgit@djiang5-mobl3>
 <6446fc40f038f_1b66294ca@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6446fc40f038f_1b66294ca@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/24/23 3:01 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> A CDAT table is available from a CXL device. The table is read by the
>> driver and cached in software. With the CXL subsystem needing to parse the
>> CDAT table, the checksum should be verified. Add checksum verification
>> after the CDAT table is read from device.
>>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v3:
>> - Just return the final sum. (Alison)
>> v2:
>> - Drop ACPI checksum export and just use local verification. (Dan)
>> ---
>>   drivers/cxl/core/pci.c |   16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 25b7e8125d5d..9c7e2f69d9ca 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
>>   	return 0;
>>   }
>>   
>> +static unsigned char cdat_checksum(void *buf, size_t size)
>> +{
>> +	unsigned char sum, *data = buf;
>> +	size_t i;
>> +
>> +	for (sum = 0, i = 0; i < size; i++)
>> +		sum += data[i];
>> +	return sum;
>> +}
>> +
>>   /**
>>    * read_cdat_data - Read the CDAT data on this port
>>    * @port: Port to read data from
>> @@ -573,6 +583,12 @@ void read_cdat_data(struct cxl_port *port)
>>   	}
>>   
>>   	port->cdat.table = cdat_table + sizeof(__le32);
>> +	if (cdat_checksum(port->cdat.table, cdat_length)) {
>> +		/* Don't leave table data allocated on error */
>> +		devm_kfree(dev, cdat_table);
>> +		dev_err(dev, "CDAT data checksum error\n");
>> +	}
>> +
>>   	port->cdat.length = cdat_length;
> 
> I think read_cdat_data() is confused about error cases. I note that
> /sys/firmware/acpi/tables does not emit the entry if the table has bad
> length or bad checksum. If you want to have a debug mode then maybe make
> it a compile time option, but I otherwise do not see the benefit of
> publishing known bad tables to userspace.

I'll have it return on errors.
