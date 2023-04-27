Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA76F08CE
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Apr 2023 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjD0PzI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Apr 2023 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbjD0PzH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2023 11:55:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20B449D;
        Thu, 27 Apr 2023 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682610905; x=1714146905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mWrqCDSmF5hsa85Gs8efjRzJji6AekZQCAoSuxuOC2o=;
  b=VE4cSgRQPL+CqQYhBdhNEoYaTHiGS5cmmrGOeCvql3sLPFvvEVnQ24Y3
   ZCepNfOmH6IUBOvMA+8WwZhmO4BKtHBhH7yyAA7IA8Yr12A5ymRsjhGrm
   2Y+V93zKHw3KUsH36QCuAF2c7N4VkVB2Kkl8jlhNMTJe2LNb2+n0LYujE
   8NelVX3vtal/py42KDq3Erzyu/JRBC6NOYOZqyxeW8H1VbRfiBiXj8XN8
   PpBsMi9wc49mT6OePrIWyjIIM/+sN0uSZ9yF+LOx1MrW2WHxlrpHK/Rmc
   H294B8C8StkAvJ3kf0XbJvTDpjdH3G6CwJZKf6fh/r+ibHHu8u7rt68Jw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="433771891"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="433771891"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="697127570"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="697127570"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.123.129]) ([10.212.123.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:55:04 -0700
Message-ID: <1a267202-ce0c-2112-aecf-f74823ea9ae4@intel.com>
Date:   Thu, 27 Apr 2023 08:55:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 03/23] cxl: Add support for reading CXL switch CDAT
 table
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193567959.1178687.13133878561024203176.stgit@djiang5-mobl3>
 <6446fdfa69769_1b66294ef@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6446fdfa69769_1b66294ef@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/24/23 3:08 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Move read_cdat_data() from endpoint probe to general port probe to
>> allow reading of CDAT data for CXL switches as well as CXL device.
>> Add wrapper support for cxl_test to bypass the cdat reading.
>>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v4:
>> - Remove cxl_test wrapper. (Ira)
>> ---
>>   drivers/cxl/core/pci.c |   20 +++++++++++++++-----
>>   drivers/cxl/port.c     |    6 +++---
>>   2 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9c7e2f69d9ca..1c415b26e866 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -546,16 +546,26 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>>    */
>>   void read_cdat_data(struct cxl_port *port)
>>   {
>> -	struct pci_doe_mb *cdat_doe;
>> -	struct device *dev = &port->dev;
>>   	struct device *uport = port->uport;
>> -	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
>> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct device *dev = &port->dev;
>> +	struct cxl_dev_state *cxlds;
>> +	struct pci_doe_mb *cdat_doe;
>> +	struct cxl_memdev *cxlmd;
>> +	struct pci_dev *pdev;
>>   	size_t cdat_length;
>>   	void *cdat_table;
>>   	int rc;
>>   
>> +	if (is_cxl_memdev(uport)) {
>> +		cxlmd = to_cxl_memdev(uport);
>> +		cxlds = cxlmd->cxlds;
>> +		pdev = to_pci_dev(cxlds->dev);
> 
> Per this fix [1], there's no need to reference cxlds, the parent of the
> memory device is the device this wants, and needs to be careful that not
> all 'struct cxl_memdev' instances are hosted by pci devices.
> 
> [1]: http://lore.kernel.org/r/168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com

Ok will pull this fix patch in and rebase against that.
> 
> Otherwise, looks good to me.
