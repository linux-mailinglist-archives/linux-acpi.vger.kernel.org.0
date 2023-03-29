Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CC6CCEAB
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 02:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC2AVN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjC2AVN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 20:21:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDF268E;
        Tue, 28 Mar 2023 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680049271; x=1711585271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9YKNu7W/UHqdg6Y5uI2XxU2vD+PUSZsT2ZdyNMkHRXI=;
  b=T5lNCJxogK1Q05tt8tjEJFLRdxdA9IoRmC7a1Bj4QdLhGXQhVkGTa6bj
   VFjBO31WM9uMAGPVgsrJf0DVvIaBk0BPVEv1rsxE3UgADdMQrNgf/UnQY
   Lg/CkPWJZ2DqiQrqb50jzohqlTecjKr+dNeYgoxl5qDuClIUy6yu1vObq
   JfOlW3Oei9yL8TbFb5K2PabupRYBBUs/kAYTKRcFIm5on/ddBZ5QVkt5f
   htOGg+YpV/+k1CsnHfeR1LFUJEGrviKCdZn0F9ME9fC2zbtnlACehYnmM
   OTxfkeZbkI9qjHU6B9tLuX7O1pJAUstdl3X5gSTiawzU+GngYyqKLgZMO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405674388"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="405674388"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686622191"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="686622191"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.40.188]) ([10.212.40.188])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:21:10 -0700
Message-ID: <b28baa29-ed88-dcb2-68c6-df6cc8954795@intel.com>
Date:   Tue, 28 Mar 2023 17:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/21] cxl: Add checksum verification to CDAT from CXL
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995345388.2857312.2421270054519644444.stgit@djiang5-mobl3>
 <ZCOANlmHyhJ0hDGn@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZCOANlmHyhJ0hDGn@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/28/23 5:03 PM, Alison Schofield wrote:
> On Mon, Mar 27, 2023 at 02:44:13PM -0700, Dave Jiang wrote:
>> A CDAT table is available from a CXL device. The table is read by the
>> driver and cached in software. With the CXL subsystem needing to parse the
>> CDAT table, the checksum should be verified. Add checksum verification
>> after the CDAT table is read from device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v2:
>> - Drop ACPI checksum export and just use local verification. (Dan)
>> ---
>>   drivers/cxl/core/pci.c |   16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 25b7e8125d5d..e0d5e6525c0d 100644
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
>> +	return 0 - sum;
> 
> This return value isn't obvious to me. What's happening here?
> Thanks for explaining,

The expectation is that all the bytes add up to be equal 0 for the 
checksum verification. So if we get anything other than 0, the check 
would fail.

DJ

> 
> Alison
> 
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
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>
>>
