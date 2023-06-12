Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36272D128
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jun 2023 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjFLUxO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jun 2023 16:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbjFLUw7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2023 16:52:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375D1BD3;
        Mon, 12 Jun 2023 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686602940; x=1718138940;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vIrqWlQoJGsDXGS7C478QMFSlqx15x9vXrqSD2ngw78=;
  b=cY8/AovjhnmXaiO8Zxz5Ngq9jEGE6wkNV637X1Tg3FXVu3Csnja7HPiM
   ouUHyQnYZ1HwAlWZ5lSp/JFIR4LTa9FlaNmKUwNOeX0gmrXSwqsawvYL4
   RfRVOlScaEBotxQvXeLGnByrkvGQhe8AxaK0sSXZEOenE6toh0FmaGSIa
   MCrS8dIdlcFQ0ykoNpfyX1Cy57DXTBRBTa5AMhVNTSGRWyCH7u9ylAj7U
   GuMg5xm7FPN3XzydDsPkLkXpBrmmomHDBFbhKEXcojXpWLlqUayYDP4OW
   NS3Z1DtrX99jvtnAEKLZK5eGIP4UjIHjHPSfGkzwWoN2oC5dSb8Xd9qNi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="424038895"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="424038895"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041485335"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="1041485335"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2023 13:48:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 13:48:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 13:48:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 13:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnCNpQMdGR/5VihaznQbIAc603qy1cClAsABxgaZGySeK6k5WJcGq5nGS3fiiOXPaiSTkPpK8UHTtTJNMWke5UXJxW4Z6rf02U1ocVbryDbbnv2b0TpR1lYStpCjrrPFXjgC34m2v9QYVW12joJVN3b73lVFcavI6fPmZtPH51RUjyI+wyQCsz9SsjAVrqc7xDaCvZAcP8dkL6DWRVOw3uECBv8YUHuUD0jS/dut2aXnFC3jbQ8qfzcGBoU0+B78HZNBNz5Ig+IrRNTpDaGGnyBUkc2/Aw4UAU/d1c3fUn53LZsaeU/7LfRrMAT/8aNQHseZczC4WKpW8mXBjViuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKxyfA4KOhAoOzpRObw3EntyQxaJRet9vs1Pr0x2MHk=;
 b=Gxm64xEZHzj+6e1eIDtoAx0yKM3glvLS7W+SlJUdFSbX696a47IW9792FeBG88y3mYR2ve4nPxF6T3R+c609W0HuA2qTGvND8+j8L1iADkK3WByDB2lViUsubAvfE5xJuW/BUZtQnsGbLcBFm2VbWb86B2CpMmzhqshygrxEiJKy/XxQmQwEzDRTNWTQz1PSS08UOBNDeLkZGquA53nkCrk+k8FTZ6QOsJ0Cx+rfod+pChQtaXmH0XpxqRlYzkuwnjtRAlzHS95JYQVzek0KQhbNiSRbxk2WTjC8/5SARva/UCbww2EDw4u5umY4zGaNN/8kHFOJPXLD01wQnfbf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 20:48:00 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 20:48:00 +0000
Message-ID: <c90132d1-e8f0-95c8-3b16-407ce9c505da@intel.com>
Date:   Mon, 12 Jun 2023 13:47:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 1/4] acpi: Move common tables helper functions to
 common lib
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, <lenb@kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
 <168565511236.1098279.11767193165079131197.stgit@djiang5-mobl3>
 <20230602133504.00001c69@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230602133504.00001c69@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e6fd80-56e8-4e54-3740-08db6b864eac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Csb0VwPP4dOB2FRBRMnQIDTiHgTYF6C9nwqbeZFAMok4ByNlTdYSi+PXqtsi1qcibSv2oEI2zKg+K3Qwtba5twlUl01fLEQAE1Ap4+Ar4XGaAjbhMnOfg7NKEZqLIMD7/WVEyzxY10u8CdtZb5ldOe2mDbR5bcNQ72Q0we+C7fava96OkmsWYMFhRGzFBVpINcif2g1oqbYB9wWPX74nZK9atruArh+0NasGISngJeCGJl6Tq27uQfaDqOlnrnQgd6/MnKE8up8ec10UNJTgzmOH5wuZHTEJ83E3plKrysm4FecxfM9bl0iuWZ9fxvnVhWHogTRGRTKmuf0DIRq0LNWgxcKPVvpbU4tJD8OMZglhPq44KoDxUbnjnfZxwVJZ5IUIwM0ADvXg4i7FMb+nQunOPQmdTiFonxm4PcFtlSodlgiZEQgtUBtDV6RE+1fwNwAzDjFnwhFnCXjhNBqNPi3Jk83LYnk2xCozuPLY31uyGTVSkuxNAss29L5lbfSo0bXLrGVeb8zR8RU6D14qF4YaacpR6mZaI6EMbgVHhIsBD8fzkHEYj2WmmYuWM9wjB0QeGCWE9eYZp5FCez2cMTHz634N4E4OURFyjMWqp7aADrsUR/2g1S4pM5VfLFiRbuxCvkV347/0UVPmz8KG7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(66946007)(6916009)(6506007)(26005)(6666004)(53546011)(966005)(6512007)(478600001)(2616005)(186003)(44832011)(86362001)(6486002)(2906002)(8936002)(8676002)(31696002)(5660300002)(36756003)(82960400001)(4326008)(41300700001)(38100700002)(316002)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZCQXB5SFZBL1ZZOXpwbXRFcDB1cXpvOWVUZWhYMDREU2c3NmkvTnpycHlE?=
 =?utf-8?B?MzNtWkZ0dlpVZ0hVNThCTndXS1VyRFcyUjM2c3ErSjdiRWhLM0ZJTHU5TDhh?=
 =?utf-8?B?bWt6QUExOWoybGhmNTFoYjF5UEo3czdWZTVvZEJTTy9UTjlxaEVUdmlmWmI1?=
 =?utf-8?B?UFpxck1OYXBmQ1llWWRYWFF2S0xiUldpdit4RkFSZUJlQnY1ZEtNRTNINUJY?=
 =?utf-8?B?K29pN0dIdVk2MW1aQkZ1TEhtZEVyeDFPTUtkSjU0VXRTK0tsczY4OFNwNExl?=
 =?utf-8?B?bEx1aEF4cHE4MVpiVDhzWEFTL2ZySXB2cTJyM25DK29BdUtRMTZNWkw2bjRW?=
 =?utf-8?B?ajdBcXp2MTJFSUZaWkw0dXFpWGR5VFBZUWtSczN0eFVUTCs0NGx1eXBIdDR0?=
 =?utf-8?B?UVF6SU5PNFhkdmVkSVh0WHJ2NklLd1JJQi8vOTRFa1NwR0orUmU0d0tmZWRI?=
 =?utf-8?B?bC9pcisvejVIVDBHdXJOUGNqZ04wYWNaUFAvcEROTFlyQkRMTnVJbnM0YVNY?=
 =?utf-8?B?R1c0ekNmMTNYanNLRVNuNmhNcDR6L2pWWUowbi9NbTFxaUNoWXpHSEJqTG8x?=
 =?utf-8?B?UDFHbUJBY2hFdFRObTNUOWszenNINW9zMWhhWGwrbFRSRDZJNlNxKzJTQzlL?=
 =?utf-8?B?amlON05Ddms3VlI1Z2pxZTJzZllLdnNFMFV0T09QYitsRnZWM0kyKytTUGRX?=
 =?utf-8?B?YzJQRStlOUp4VDdTeUV1UVRHL3UvWXpwaUVnN0ZLTU4rMVQxak1PdFFMNVFV?=
 =?utf-8?B?M0ZzcVBlM0RzbUxpQXpLTk5Nay9FT3FFbU1VK09HK281clF5SGRmMmFQQk9B?=
 =?utf-8?B?OEQ3MXBBeldXU2lSWU1wWEtQWCsxOHJ5T0xIQ3VyT0FLajlWUWJ4V0Jsb0Vl?=
 =?utf-8?B?STZGZmdQcHZvZllBbk9GakY5U0xyUVp6SXFDa1ZYUTV5V3hyQzF0aUdtRWx2?=
 =?utf-8?B?aldiZFd3NXJVQ3MyMXBIdkJEODlOcmxmdUE4cUp1Y2M1MXdzUW5hL0k0eC9P?=
 =?utf-8?B?TmI5N1dvQmJ0ZVFxWjU0bkVNWjh5eE9QK3hHMTBlMHhSdFlPU0tVM1RpVk9S?=
 =?utf-8?B?QUIyVDlnUzhUVUIzV1NLQTFNQURKTmM2bTl4bjRCNTIrZjFhYzRGWlUvaUJN?=
 =?utf-8?B?cy9oS2cxN0ZlSjF6RHJsTlRpeHFrM0Z3VXZpTlVmbjh3RG1UUFRnbmY4YTQz?=
 =?utf-8?B?S2xZMnQzUUxlZUFlckdOTzZtRUJLeU90MC8vdVlIS1BxaU5waExPbjgySlRw?=
 =?utf-8?B?dTVtemoxc1dDaGpIRDRON3lhSDdaUHVGVkZXUVN1RWx3aU5HeEQ5bTdPQS9v?=
 =?utf-8?B?MXhyMTBmck9aYmlaczEwZkJHMXdPdjBYcGdOV3Vka1pKZ2FnWlJZMm5WM05P?=
 =?utf-8?B?Z1BhbGE0UXhZUFEzUHVGQXd3YytCdC9KVVpXUys4a2IrTXhBVjJFVWgzREhN?=
 =?utf-8?B?NXlQaXNHRlZwTjk3QTgzVWYrWXd0VmQ1bWFhbkZPdUtYV2lVa0pudXJ3OXJx?=
 =?utf-8?B?ZGs5bmx0UEttelVNaWtoNCtoa3NlUlM0ckUvSWVwY0loejM2cDVnRjQ1MUFt?=
 =?utf-8?B?WWVQK0tRQjc1VzRKRWk4aXVOSjJSdkdURGxLRjFrK2ZDc05EdnFsajBwWm54?=
 =?utf-8?B?a2lNa042NDdDa0lwaDBKbStBbzEzMHBMdGMyblk4U21CVlNCY3U5ZkFJc2cx?=
 =?utf-8?B?TnlFSnY1OWhhdWhGK1Y2eWpJTmpVRWo4blAzWS8vWUVZOUtkSkhZc0g0VVhS?=
 =?utf-8?B?eFo2NmJlZFRlYkFnZFMrWHgranNHY0UzU0tMWC93Yld0SXdid1RaOUwwc2d0?=
 =?utf-8?B?dnVzTlBTaVd6M3ZDQXhpdVFrVEsrUGNybCszOG14akZYUm9NalFROTQ3N0hG?=
 =?utf-8?B?OFRQd3lRVzFNZktaZDMxRFRieXdUN21yQWplenBEZ0lpR3JKSjBudjcvTWEw?=
 =?utf-8?B?VkpOMGFFQSt0RktzZWZqMnVrSGlQcVl2S3pqbmRQK0pEaU5oZmMxUHpDTkE3?=
 =?utf-8?B?Y3Y3cjRUUk9NamprQm93VDRmMGlxTmp5bFVqcEpGVWgwK0FPdVF1M0JpdVE3?=
 =?utf-8?B?Y0NJQmlNR1VzOVY5dmtFY2hHb1VrZ1BVMlBCaXZaLzNhU01heVRUeWJZMC9D?=
 =?utf-8?Q?gsl3dbqri3m7DPEqva/ZZe/Yo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e6fd80-56e8-4e54-3740-08db6b864eac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:47:59.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIZxJUK1lwPPOGJER51ubvv9MOMkGflSHxrDnBYKhG43qg41t+HELgbWhN1d5LTxYMqviUzlI1jroh/iUch2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/2/23 05:35, Jonathan Cameron wrote:
> On Thu, 01 Jun 2023 14:31:52 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Some of the routines in ACPI driver/acpi/tables.c can be shared with
>> parsing CDAT. CDAT is a device-provided data structure that is formatted
>> similar to a platform provided ACPI table. CDAT is used by CXL and can
>> exist on platforms that do not use ACPI. Split out the common routine
>> from ACPI to accommodate platforms that do not support ACPI and move that
>> to /lib. The common routines can be built outside of ACPI if
>> FIRMWARE_TABLES is selected.
>>
>> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
>> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Minor comment to fix inline. With that tidied up
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
>> new file mode 100644
>> index 000000000000..ff8fa58d5818
>> --- /dev/null
>> +++ b/include/linux/fw_table.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + *  fw_tables.h - Parsing support for ACPI and ACPI-like tables provided by
>> + *                platform or device firmware
>> + *
>> + *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>> + *  Copyright (C) 2023 Intel Corp.
>> + */
>> +#ifndef _FW_TABLE_H_
>> +#define _FW_TABLE_H_
>> +
>> +union acpi_subtable_headers;
>> +
>> +typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
>> +				      const unsigned long end);
>> +
>> +typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
>> +					  void *arg, const unsigned long end);
>> +
>> +struct acpi_subtable_proc {
>> +	int id;
>> +	acpi_tbl_entry_handler handler;
>> +	acpi_tbl_entry_handler_arg handler_arg;
>> +	void *arg;
>> +	int count;
>> +};
>> +
>> +#include <linux/acpi.h>
>> +#include <acpi/acpi.h>
> Includes mid way down the files is not a common pattern and I can't see why
> it's particularly useful to do so here.
>
> + linux/acpi.h includes acpi/acpi.h and I can't see that changing any time
> soon...

Unfortunately because linux/acpi.h needs defines from this header file, 
and this header file needs ACPI table definitions from acpi/acpi.h, and 
acpi/acpi.h can't be included independently without linux/acpi.h, this 
seems to be the only way to get everything to build w/o complaints from 
the compiler. This header really just needs some ACPI table struct 
definitions but there's no easy way to just include those.  Also having 
the headers in the beginning causes compiler errors. It's ugly but seems 
to be the way things will build cleanly.


>> +
>> +union acpi_subtable_headers {
>> +	struct acpi_subtable_header common;
>> +	struct acpi_hmat_structure hmat;
>> +	struct acpi_prmt_module_header prmt;
>> +	struct acpi_cedt_header cedt;
>> +};
>> +
>> +int acpi_parse_entries_array(char *id, unsigned long table_size,
>> +			     struct acpi_table_header *table_header,
>> +			     struct acpi_subtable_proc *proc,
>> +			     int proc_num, unsigned int max_entries);
>> +
>> +#endif
>
