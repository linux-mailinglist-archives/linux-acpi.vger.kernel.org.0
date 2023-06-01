Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD271A2D5
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjFAPin (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjFAPim (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 11:38:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F0B3;
        Thu,  1 Jun 2023 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685633921; x=1717169921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VMuo1PYdlC01Ol52SDdS+N4L38pZkqCihHfa43yXEuQ=;
  b=F04J0FretUTb8lpteKmjtVi3BlXLyGde0LvFpZhyesKssKFYoz0CmXK3
   jkE07D+S8aZPCjgbTofWZpEyZSUhOt8tlgqqrTbJj6n3MfcA+Tn/PJvoZ
   nDoQ5kLox2c/6spHAFmToE+55C4IYlvSdopXauoDW4/mmYmUYErW6hRJE
   2H8teo7ua3/b+5x7fMdLomm+r1DHPV/un4h6dU+DNL8fuRg26VjWVSQ1A
   zrR7ayqu553aALd/Dk5MkENE/saRfMmqcERRJvucf8Fm3Ibu5vl6l/xG2
   Y1hNl7pUgUiXrucGzAgMvZfWhIPcfSFlb1Ktz5+naqqh281yYkunogKBD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335948218"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335948218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657838931"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657838931"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 08:38:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 08:38:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 08:38:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 08:38:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 08:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXon0mcT7iQx4nj96CxCst7WBkaQ/wNmFw7LE6PdjeWySmg0jmB4BNHwsJM+OcYKFkE458/NwJmKDvu03v+5SDy90KmBB2gk0xrObPooqGWizGAwfwy0JMtmgTk5+bZnQK+X97cH8Cu0ch4HwzwXVxKvRF3jjWN9wNpeYTZVt1qc5ZiIxwpyiAyNiS+ZJgH5Nngg6SjTXLkclkCCSUiluUcpIzzib17Fac2E2ZRpnS5acLawNQPzxwK4tTCTLK3Njg/EiOslwYxyzsil+rIJUjIzOn9UL7ww7IN1FQqBsa/j1d3LKxQpCs0hNz3IODFagSVJezw55K7sfYE6pwljeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM3TigIsT+ACR6AnRV0I4F9oZr31cePFAuLNkZHEPv0=;
 b=PQyEfrVl/M1FDlnT14iprEvYfen3rzEZRG6uPyMvCOv4zENCk70l2RDvIoevnGHcgdSsBzTq5U6qgAsl2IzG4XPQazz/CzZi0V/UhUNal6tBQVl90nb0KWjt1X3kex1IbU+W/u7/EvaxihLWh80Ey0PIfy5jRpqsGQPPdxDUyIkd6bRUSKnXDE0OTvBC56C6CW4JT6NalrftH8aGg+f8rjvbet5OVmdJ/FLjRKCfD4LaQsFLNLtqhPbbakv3IRbpN4JriiB6IScdfNjTnYj+dtE+wI+7IoYp5Ud8FgjuSl462Hpouy66Uy2tr4B7OG9Z4H/nHpncGbstmvMeW5XgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 15:38:24 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 15:38:23 +0000
Message-ID: <d3f337e3-4517-ca54-a178-e5ea519a384e@intel.com>
Date:   Thu, 1 Jun 2023 08:38:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v2 1/4] acpi: Move common tables helper functions to
 common lib
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
 <20230601155019.00000ed3@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230601155019.00000ed3@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9a8e4d-8b12-4463-a135-08db62b63bee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EN//3IuxE3lnhkHnnPwbpepCzaOJY2Gd6defyIBXM5vXJ8YrHP/yHZiKR4RbUgI2UGEUVpta9vagIgnZuDe2VemTIwOFRvTyRHkWXQLg6gEYT4Uueh3hrupfdEnS4ZqzFyXVfx99kzl3+ox0Cq/IoxZlSmB3QJ9PGFcHqrAZuHef0Wz2UVTuh6bTykcQuoq6mmbu7t7pBelqvk/qf6bKe2SAyyVc+6fZUbxluSimEIr/M+ZsVqhQ0EAMm72LijbO22h/I9o++DSoYRkgmZFeFKGPFZLNq2IEwQjvJCWfuEWPUm6Ma1oq3XfZUiBnCGzInLxsp6zi4OpWJtGfvyzv4/2tGzYiODnyQrbdZIHSkJsV5zk77timslo9jyiwfKYDMIDcNDIv7mD67zwt1wy8rBWHnFu4dGWkHBXjjKGKvlu7LEeNnvMgey0wTmCcBAokJnDEo/6C6r6xUV+MGkiBzZy9+sdUHRMnwJpJOPEN/3uhcPlUstEwLpvoanPWvOP1ZfpOcsKGq9by6/jYadUfP1kw+dJF5o3KPPgD7p7QjgwN+/sTyNVdauOWltNa+N/PMUlmq/CdJcTTYY2ajkm+E4igmbNmx+gpg9D890Hcz1/YlN52m+hY7b+0974H4BTkYa3/+S/+p+LraWMx0m6xgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(478600001)(41300700001)(6486002)(86362001)(31696002)(6916009)(6666004)(4326008)(316002)(66556008)(36756003)(66946007)(66476007)(44832011)(5660300002)(186003)(2906002)(53546011)(6506007)(31686004)(6512007)(26005)(83380400001)(8676002)(8936002)(82960400001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVqUkxoajhhM1gxTHBJTjFCOFVTdjkxOGxsNzJKZnJZV20zdXp1SUFraUky?=
 =?utf-8?B?Y0JmdzBRdDBCWWJReHpRSkx3WmdMUkZFTnBtUkREbUF0MWxEOTdjOXllWE9h?=
 =?utf-8?B?WnBpUG1PZGFxaEdjRzltaU9OTkR4aVNVUXJKWUdVYUpYdXR0dE1CNzZ6Nkhi?=
 =?utf-8?B?a1VlcDVRTzk1R1I0Z3N4d21kcTNNeG5CMkltVWNNK2ZYbGRZYmFLb2Q2SHJm?=
 =?utf-8?B?L01sUHdya3VxcFdHTmQ1VmFoTHhXc2lsQ0JVMEdhNGtzb29FbWhncHlyanNF?=
 =?utf-8?B?dnl6SmRHOEtoMVl4bEJKbTZ2TDJNT1FHZTB4N005NUhRbERhUnp3LzBYVXBE?=
 =?utf-8?B?a0JkU21hQlIyYmhoQmN2UWFMQ3JRQ0VWSzRuWXl6bnB4WXVXUUNiL0dhVnBw?=
 =?utf-8?B?TEE3TVg2cWVVQ1E0ak01L1BKWmRDSm83QURlUmNoOEVNZUNHQ0RxclpHMXpq?=
 =?utf-8?B?aE91RzR4NVRUOXVqLzYvYzVoeFZrTkQ3MnhCcXVicWNxQmM0bDFUU1hNRTc1?=
 =?utf-8?B?bkQ0cENhcU93SXlqdHJEL1dCUnorUVo2bTFxMktaS2daMGprWGxXZEZ3b21E?=
 =?utf-8?B?emMyM2ZHeW5sNDQ4enQzcU4xWnR4azRyOTlrVXBBeDl6NmFxU1Y0QWNGNkZt?=
 =?utf-8?B?ZXlPUzBjNTBhckdpbmN5NXBXQ1B3a0w2V2JramU2Y3U3S0VTZE5WU3Z6WUdh?=
 =?utf-8?B?NHNWRENKZnFLdGpaV2FReFptNng3VlhTN3hXR0VMTmxiUUFkZTFlOUFlaloy?=
 =?utf-8?B?Z3JZM3ByamJJajY2YVdsTXB1Mk94bWVsTkk0dGViay9lMmVGOHZlYU9yeExt?=
 =?utf-8?B?dmF2N3ArV1o0M2UyVDlpeHlGT0g5ZjVSZXJBRVZ5WU1zeWF3U2FYSmJxdUZW?=
 =?utf-8?B?MzVhU0NZYThFT1dKN21PZ0hWZHlTR2pCVEVSWnpKUTBsbUd3eElXblV4TWhR?=
 =?utf-8?B?M29PcWJGUmMzUGRydjBYM1hQVTdXeWRzUXhZcENBYUxudlEwSU9ucDlSeGNT?=
 =?utf-8?B?ajM2MGp3MG1ucUFQcEREUDRNajV4Y1pqQXhNdEs0MmMvekp2ajI2Q2xNTFlR?=
 =?utf-8?B?ZXFvTG8vU1A3QmVWOWVGaHpLeEczL1VsZUgzK2lIQ29nT3dzY1htYVZJbkFR?=
 =?utf-8?B?UEE3UHNzZE5GUHJVL3lILzlqQ2hWR1ZyWHpzVU01TnEva2VEdUhGZnkwdWt0?=
 =?utf-8?B?YmZpSjNMMFRNU0NKV2c3VjBVcE54dkF2UzJTejc4YWNRTkt1VVBySTJnUGtm?=
 =?utf-8?B?MFNoblZVY3ZrY0NTR205R2FBMUlkOHV2cDRYcHQyWnRiTHlOZHlwU0xuQUNa?=
 =?utf-8?B?eDJuVDdjUEtqam1IZ0QzYUFMYlZGdHBYR0tOSExWTmtxc1ZQZCtOVFF6VFRx?=
 =?utf-8?B?UzBmRmd3SHpMZGpsQnVCSmI1MWdPQXVzeTJkaDhzVjN3ZG5FU1pIRCt3S0Fx?=
 =?utf-8?B?R1NKUWdad2JjY2J0U3c2WitZckdzaW5jNElFUW81eE55ZnpxcEVmNEFzK2NL?=
 =?utf-8?B?citYUUV2K3FISzlzNlRLVnN5cVFoV2hKZVM2VS9VWm50bVFncFNzRkE4V0Iz?=
 =?utf-8?B?RXM4MitoSlRULzRETytrNjdZWUhuSUZ2c3h3aFlhejdWWStwS1BzSTJaTm05?=
 =?utf-8?B?TXlsY3E5K2NscG1PU1kzSE8vRW9MNzJxKzh6TmVycjdydzlCWGdadTJJZGd6?=
 =?utf-8?B?cmt5TW1FTk5oR21KM2pPMFBDSU11ZFFNdmlLR1Q0cUU0ZlVUbGJqT1JYZUJy?=
 =?utf-8?B?ZDgyU1o2RnJ1TVByQTJFRXJiT2MxbTluV1VJMlFWSFJnMjh3aHZIdVRsb1pZ?=
 =?utf-8?B?Y1A5Z3pJUkpCQSs4SDdEZ1N4ZmxJQlV0SkJ2Zm1kMHJjTkpNRkUrUVIxQm9m?=
 =?utf-8?B?V2pqMDlobU8yR25IeEVjcEw0OUhselZpcVVKYm9ZcEhLblptUk5iMDVuVXI0?=
 =?utf-8?B?K1JRMmQ4ME1yeGNQZTFtWW12S3ozK1VvdTVWUEZ6VFZiam9PS3NYSjc3bHNJ?=
 =?utf-8?B?KzhiVTVMbXdqUTEyUitrU21IZFREQ05mWitwTnZNOE03TEtUWGNZQzh1NmVw?=
 =?utf-8?B?YWxYL0ZZSm95dWFSOUZPQXppRTFTeVdtSW9tK0kzdWE3SjBYQ01Od01lRUE0?=
 =?utf-8?Q?b4/c78f5Un6b6szesZYpi7Xd/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9a8e4d-8b12-4463-a135-08db62b63bee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 15:38:23.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeXAg8YUtqGEISMTHiARvhzy/5vl7sZzVZw6TvODGCY207RWZa+OiTn//yza6HbVsvG4hfJHbzuOmY0fHnTk4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/1/23 07:50, Jonathan Cameron wrote:
> On Thu, 18 May 2023 11:33:02 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Some of the routines in ACPI tables.c can be shared with parsing CDAT.
>> However, CDAT is used by CXL and can exist on platforms that do not use
>> ACPI. Split out the common routine from ACPI to accomodate platforms that
>> do not support ACPI. The common routines can be built outside of ACPI if
>> ACPI_TABLES_LIB is selected.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Comment inline - otherwise looks fine to me.
>
> Jonathan
>
>> diff --git a/drivers/acpi/tables_lib.c b/drivers/acpi/tables_lib.c
>> new file mode 100644
>> index 000000000000..701001610fa9
>> --- /dev/null
>> +++ b/drivers/acpi/tables_lib.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  acpi_tables.c - ACPI Boot-Time Table Parsing
>> + *
>> + *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>> + */
>> +
>> +/* Uncomment next line to get verbose printout */
>> +/* #define DEBUG */
>> +#define pr_fmt(fmt) "ACPI: " fmt
>> +
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/smp.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +#include <linux/irq.h>
> Check these includes are all needed by this subset of the
> original file.
>
> Also could take opportunity to put what is left in
> alphabetical order or some other convention.


Sure I'll clean that up.

>
>
>> +#include <linux/errno.h>
>> +#include <linux/acpi.h>
>> +#include <linux/memblock.h>
>> +#include <linux/earlycpio.h>
>> +#include <linux/initrd.h>
>> +#include <linux/security.h>
>> +#include <linux/kmemleak.h>
> ...
>
