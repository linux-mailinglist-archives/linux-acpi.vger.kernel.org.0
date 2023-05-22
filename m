Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C470CD95
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjEVWNV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjEVWNT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 18:13:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB05D10D;
        Mon, 22 May 2023 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684793595; x=1716329595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HdFAw2zfZU1FhpWjiNhxd4KAjzCNpfCCd+uDxxwMup4=;
  b=TKunKTvJvaGCq+i9usL0Qn3gvN9O2X0P241K+hQZ1jRgHCGTWjX5FCYj
   +Y+2/LC3oS8BkRPGF63RHnxkcLuGhUriwHL96D4SjjAoYvjV1pU4Xg/Kw
   JuixXvfeH3DlqH1klqzVZEEXEcFjq2F/zpD5zqGIWgLRyXCF4UzxwFTWc
   e+1SUq/IXn3Vb3DpEPqGZnW2fq++L60WvmVp43Aa4ZyTpTPAHKcqEhjEj
   j2jw09+wnDLx/N7dJ5FHLxjd3uaeu7vfHmkiGrRIyCix7TizC17gSa2y2
   aK9yaqnT3HZ0qO1ZUD5dyVdKHKtdo9JBAGM3Otbs2vDCQaOEy09QDUZYt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356286322"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356286322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="847993219"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="847993219"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2023 15:13:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:13:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 15:13:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 15:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pkb5dBfIdMB+jMNLd5SEvbb+nqLc6TVHNiATjjG5EOlEbMRrac3RCgwyNSxH9x3hXV9oQIfY1yN+qDBTLCfJw2IJZ1l+MCHWm1uMDCOXdNzWb4B1w0YAI2dL7gbhmBhYxD2vic8pVFKei9eqn/RZ3GkvFOMlCyxI8fFYgJv5BvgPgwS9SzXh74SLLaTk8m7kmN8U8/oy93QPkWLKkt9i4JIIiZ60lZ8SaffcoPLOVTWbk3butwiSrMNvQJ8daeN8wPaj8pUydcqQ+9t7UDNbq57IBeX9fICPvCYdvQQ134TUG/7JDPPksvbEzf1837e26S8EiG1tYywXxxl+n8/mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rWQfBp0jgJvSlrWgT9/TdhDbJ9kAjD9bVm8b6IHvlk=;
 b=JvBvjG9XzPyoffHV/u1kZhdjczfpXdcYz7gbDZYEF64XPbBtBmu8pTy3mgLQF09BoJsV2JgnvxugrQcp1bqMKLVJgpBGhefqVh8+9uwboo/9vEyfQheSb7JkEb9yELWf2PyFmzHQXY7XeYke4A+lwhngj1GNZszVMUWNV8jfqjnDnFdb/pOV4upaYcyEng/hqRQsBWvh5JFQTHOXsLZyiFenpwSaiHngb37AGC11l1jvKoOjJrzx/W8ydiVNrGteUnAiO+GaflwjQRlvwWmtWC0HFejY1C40HDt9qUOK36beQ8VpVvhzUOtCo2IpqLbQvIlSx782xnXPcKqBzxSZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5427.namprd11.prod.outlook.com (2603:10b6:610:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:13:06 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::b315:faf6:e706:ca61]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::b315:faf6:e706:ca61%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:13:05 +0000
Message-ID: <19907ea8-85bf-6e31-0798-ef8a1e4b842a@intel.com>
Date:   Mon, 22 May 2023 15:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v2 1/4] acpi: Move common tables helper functions to
 common lib
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>, <Jonathan.Cameron@huawei.com>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
 <646bdf21b9329_33fb329410@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <646bdf21b9329_33fb329410@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1a012e-ef99-48bb-0fc6-08db5b11b6fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfbm+/UbvQrUrsKRMK6Ij7zk9lA5uTM/8G2uob1fhVlrZOmedwDmNpiiCkrMSx3IydW8cApdXzga/5n3a83u/Oq9nAPIST0iY1GcoqezckjqCiNsme/P43eAnZ0F08S3Zj6v2ZpjxDj+kED4mBQNo2pdBrlz/KCTokbyktRr2ILtmZyRkolfHpqD0DwdWpW0DgNSty2uU1FRylB6fsWgr+QsvG1evzSpNm7yCxPDzXDGMycjZDbkWsWappNSrxBbEG8prsx08yB7skzlkoxR6tbvotItPNQTcRRSfJ4ffWeeODVHyFaPJn4+Ex12Qaets1pDLh0kPJexhfV8Uz8RzBrGC194Nqz+l4UyMDS/uN7CgPBQ+SO2uiiKQBIVGxlh/Z16fTCbWb8qqvTwewohhrwZP9z+9xyL7acJY7pUttv9nrROgAbP2oUIYkXrtIoVJvglFNgHLa0LjfapokjypQhnXYUId7KTayGKkENN+i1SYEUq2iAbJfeKwGSBJ+Pqtx6YqUEo+w0zxwMihaR6KNl7jvu8O9vv0UAYS8j4S2ZTHfVPxQ/Q2sbE6fY7X41q36VT9HIBQNOTyTzL/oBN/QxfNUv6dkx9jjVAnDe0zTgWKKghQZ+XqduH0sBTn2omxD1VHHXEXtpwM3k9PchuIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(38100700002)(8936002)(8676002)(5660300002)(82960400001)(53546011)(6512007)(6506007)(26005)(186003)(2906002)(2616005)(36756003)(83380400001)(31696002)(44832011)(86362001)(316002)(31686004)(6666004)(66556008)(66476007)(4326008)(66946007)(478600001)(41300700001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG95NzFHQkRKR09HaVJ1bFFYMHNlQUwra1BQVUh5VnpwNUxrbW9HRUxUcHJv?=
 =?utf-8?B?MlVjd1pyYTE3Y1FRS0x1M3RYRENqenBHQ2wrUTBFRExqS0w1YmxlR2JYMlhw?=
 =?utf-8?B?ME51NUNsUERIT3A3Z2x4K05JVi81bDlSWU1neXdQd0JNd1dBd3V3bnVHejVx?=
 =?utf-8?B?L0c3dDJXUEF2bStLV2ZjbFNGTmMzRExITjVSVmpzQU1VbmF3QkNJUkRvemV1?=
 =?utf-8?B?QjF1ZktyQ2ZiSndIUGJ6V25hTWtJZDZESCttSmxqdWlHajRvNjZxSzZ4MmJj?=
 =?utf-8?B?QW93Um9udDFVUDRBUmtqUXZ2RnVFRi9CeHhoSjZkTVpEQm5wc0gvclF0MEQ3?=
 =?utf-8?B?QnIveHpRak9IeDlNbGZyakNXcVNsT1dLWVowbVV5WFZlMGRBQlNya0k0VFNU?=
 =?utf-8?B?R0YzUDhsNEswaFRBODdua1RFcll4Q3c1VSsrRWU2ODFlakQyUUFNNDRwYVBC?=
 =?utf-8?B?TDV0Z1lXa0hlQWFrb2IrZkp0R3ZPd1JxQ3BXMUJzTURxblJQWURZY1orRURn?=
 =?utf-8?B?MGZBUi9pVnF3cHlZQXpWLzJtbi9tcEJaQVpBRTExaWtoanF6OGlBd0RZOHk3?=
 =?utf-8?B?L0Q4ZHRVNHJxUC9UQ2YvSVZXNG9DK3ZyZ0pzQlZZdThqWlBONVRVcjNMSlho?=
 =?utf-8?B?MlM5Q2RKWkxWSDBMUmMwWGpmZ29iVmZ4cFRyd1UwMFYvd2VmVjlGWVVmeGtx?=
 =?utf-8?B?QWYveFN5TmZJWHNCeHpwcThUdVNyeEx4ZnM0OS9DQ2J0OCtwTFlnS3lVSDVo?=
 =?utf-8?B?SWFwaVJIckxKZ1ROeUhDMkNUcGY4NFI0Q2VHUWoxYjV1NWtlWEk4QnpxVlcv?=
 =?utf-8?B?aWlzdDNNdWlMb29TZHVrbWV0ZXlDWUFrM1E2NEpHZFE2cFVWWVJjbVRkbW1L?=
 =?utf-8?B?MU4zYXFjOGdlZk84TVdlMldvTVdnWFlqL3dLNEs3ODFOSEVzWFpWM1pjWTAv?=
 =?utf-8?B?dGhsZktlcFJjZFpkaHE0M09sYzltMWtjbVR2dFpBaFJGKzJGQWpUMUFkSTJU?=
 =?utf-8?B?ZExSc1RDeW5aU0o3TVBvOVVwR1FZRWJqNzRLaks4bGtSQU1XazEyMVhiTWU0?=
 =?utf-8?B?SWNDV2FFd3d6RjVGWmV3emI1c1JQTjZtWW1Qc3FyN1hCalZHbkltREtINit4?=
 =?utf-8?B?U05iODQrT2g0UVorLzMwZXoxd3pYSlVSS3lBUEVYNUtxaFdiVXp2WVBkL3Zv?=
 =?utf-8?B?eE5RbjZodkR3OFA2YlBDNE1WOG9wdEJBb2ZGK3JWV0U1amo4Vm9manNIWEk4?=
 =?utf-8?B?WWJtd1VFbS9XcUpEZ2x1VUx6TDM0MUI0cHpaLzZHaEFQQXBKYWR2SG9SNWhq?=
 =?utf-8?B?YU9hTWhqanI3RWUrUFVwOHYwSzVTWEFsNVc1bTF6R1JVMWd0eVI1TVZIaVpP?=
 =?utf-8?B?b3lTMkI5clRaTW1YQ1B3SWdFODE1UVpJRUdLWUxkVjduVlpGYk5rSmJSQ1Av?=
 =?utf-8?B?SGNNTDJPeW92U0F1aDBSeDB5cmNnMXlGZFZrTGJjbGpzMFBLQUp6OWtQOE5P?=
 =?utf-8?B?K2YyMFA3NzJyRTB5aVk3TDBudEJNc3kwa2l5NzFZeHJubUdjdW1qL0JwbzA5?=
 =?utf-8?B?MmhFcjBqL3lxTGRJMFk4Tzh1UW8rWVpmNkw0ZzJ2bkhwaDhTMnl3ekNBNXVp?=
 =?utf-8?B?YzBFQy8rQUR1NHVEdmxSckEvR3VWL1N2Z29HQTUwV0tzb0s5QUdnQ2RONnFB?=
 =?utf-8?B?Y0ZyUkY5am1zblBOdEROU1I4K1BsWEMydGl2cU1LWkdrbnFOK0ZFS0JnbWtY?=
 =?utf-8?B?R2VHRE85cVpsbG5iOU1paGd2WnFzY01vVEhxV3phTm1JQjNIUFhHRHhoekNQ?=
 =?utf-8?B?eHN3K2FmdE5DR0N5VVpOai9TRjArU2luam5OR1FENW8yaGE5NFN1R1J3T3RV?=
 =?utf-8?B?NWVYRnJSeTQ5VEVJamtxbmRzT2VVd2l5TyszSy9JTXJYY3V5dEsyK2Vibk1H?=
 =?utf-8?B?K1I3eXFtWXRxYnlXbXJqOXp4U1VFT253YUJpVzZYejdzakk2eXJ1bC9pNlhF?=
 =?utf-8?B?TUFIWVpDa0F0ZmU4R3NCQ3hadFA4a0w2blF4dkpPbHg2eFJMMk1VZXZvYTA2?=
 =?utf-8?B?L0lPcjFPZlFtS1FCNjVnUThoQ0JuTDVqbkZXSEl5RlZmdzNqeE1QNEIxaTJJ?=
 =?utf-8?Q?QflkwWwLkFwnDdYiW+HOMOfIo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1a012e-ef99-48bb-0fc6-08db5b11b6fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:13:05.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddGf5VGka4yEUSN6E5khZzYj1aGsZjohdzcEAX3fFQGBY5X19O3rGj/aJzxMUwL6jRVq2qvWk6PDAaWLVBVINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5427
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


On 5/22/23 14:31, Dan Williams wrote:
> Dave Jiang wrote:
>> Some of the routines in ACPI tables.c can be shared with parsing CDAT.
> s,ACPI tables.c,driver/acpi/tables.c,
>
>> However, CDAT is used by CXL and can exist on platforms that do not use
>> ACPI.
> Clarify that CDAT is not an ACPI table:
>
> CDAT is a device-provided data structure that is formatted similar to a
> platform-provided ACPI table.
>
>> Split out the common routine from ACPI to accomodate platforms that
>> do not support ACPI. The common routines can be built outside of ACPI if
>> ACPI_TABLES_LIB is selected.
> Might be just me but I get confused where this is indicating "ACPI" the
> platform vs "CONFIG_ACPI" the code. How about just:
>
> Refactor the table parsing routines in driver/acpi/tables.c into helpers
> that can be shared with the CXL driver even in the CONFIG_ACPI=n case.
>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/Makefile          |    2
>>   drivers/acpi/Kconfig      |    4 +
>>   drivers/acpi/Makefile     |    3 +
>>   drivers/acpi/tables.c     |  173 ----------------------------------------
>>   drivers/acpi/tables_lib.c |  194 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h      |   63 +++++++++------
>>   6 files changed, 241 insertions(+), 198 deletions(-)
>>   create mode 100644 drivers/acpi/tables_lib.c
> Conversion looks ok to me. Even though the cover letter said "Hi Rafael,
> Please consider these for 6.5 merge window" my expectation is to take
> these through CXL with ACPI acks.

I thought you wanted Rafael to take the ACPI patches. But going to the 
CXL tree works.

>
> One question below:
>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 20b118dca999..1824797f7dfe 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -31,7 +31,7 @@ obj-y				+= idle/
>>   # IPMI must come before ACPI in order to provide IPMI opregion support
>>   obj-y				+= char/ipmi/
>>   
>> -obj-$(CONFIG_ACPI)		+= acpi/
>> +obj-y				+= acpi/
>>   
>>   # PnP must come after ACPI since it will eventually need to check if acpi
>>   # was used and do nothing if so
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index ccbeab9500ec..ce74a20dc42f 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -6,12 +6,16 @@
>>   config ARCH_SUPPORTS_ACPI
>>   	bool
>>   
>> +config ACPI_TABLES_LIB
>> +	bool
>> +
>>   menuconfig ACPI
>>   	bool "ACPI (Advanced Configuration and Power Interface) Support"
>>   	depends on ARCH_SUPPORTS_ACPI
>>   	select PNP
>>   	select NLS
>>   	select CRC32
>> +	select ACPI_TABLES_LIB
>>   	default y if X86
>>   	help
>>   	  Advanced Configuration and Power Interface (ACPI) support for
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index feb36c0b9446..4558e2876823 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -13,6 +13,9 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
>>   
>>   endif
>>   
>> +obj-$(CONFIG_ACPI_TABLES_LIB)	+= acpi_tables_lib.o
>> +acpi_tables_lib-y := tables_lib.o
> Why is a separate object name needed?

Not all code in tables.c will be shared. There are ACPI table parsing 
specific code in tables.c that CXL does not care about. Or do you mean 
just do

obj-$(CONFIG_ACPI_TABLES_LIB) += tables_lib.o

?


