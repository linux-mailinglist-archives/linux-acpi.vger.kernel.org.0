Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690CE75C703
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGUMox (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGUMow (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 08:44:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F62D56
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689943491; x=1721479491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tJ/EX3W+iqDBBRbFZY81mPEAsjnL6oO8pFMIrQtN/0E=;
  b=PV8DrsCmjiDf/EI8nGx6gBHHroQlhjwyOMGcrrfwX/O+3O7j0uXqj3+B
   ZpocS7wCbGOCMvv/jmn83GkFWRgd7PgW3/WWax5Z+9z1kUzDwHGaMST2M
   9zWj+YBQaBa1DIs3wek9+kxwuLZm1hmwCN24PO52sFVwQReYsx31dfXhS
   3nbPxlNMC6TzdH/cQnNnGU2V3lRMIrnZqY1AvuNDPXVU27w/3e4F7Dqd5
   +raaY4SbynZ7NrKk66R6dzJk2FB6KX/neUTEm/5qSYUP4PrQpKruPN1KL
   9RJJUzqi0uPbKT8SI3DrGVNMqIvLS3CuZyAUFPiOySH3/J5L4SFcGUHoe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453390729"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453390729"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814932142"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="814932142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2023 05:44:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 05:44:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 05:44:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 05:44:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 05:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcB++2yxeKJfEJMvkq0cJ/nOq0qWGkiksyIjlgxEa1/FmnCkwzR0aYecNCzMIpAvDitWmKPgfMs+//klFFBlP9vpX4zXvzR/T7W5X33aZiu6pueOvcuHeqczCplt6WxiZYrFWUqgWPNS2cTH216GE4OQ8d/7opwticSklcpiriLkU0v+smGK3F+Zy5GffRrqWyaVyd+o2ygmvlO+vCqMiDmYoyz+alMm6pixqcEEYz/b/oszAgbh+z159tiNEgaqsUIXwf41PsuBitpOuhpt+KbLp1PZe/XQeY+hdioBcvgkaoKgGeDyouYc3OxYa5z4FuuIu105tZ6pC2Lfrkf85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vrqFc48mLQ6j1OR6/0JnDO554EOX4lZ2x6aY/iRD2U=;
 b=QYbi5hYYYIr4iIiKCu+VRVTJcqR2HUzI4zRbPV0ggAlUqP9evcPgNYXI+LZJiXma3C8N8/SpmwrlwaTezhj2V3aU88XUzskNfvyZuv3F/WjKabgOTjFEa28du/Q+BzSkAIwP28pL7HFw5J3PZRKazmC+9NH4rHwKovs3OIIVWi5Rk8c/oPxJr9PGLfh/8jYXbVflfYop4bSfsXSYAlr6TcnRNZykk4bXg9YA8AopDlWawpnkCM4P2KAZcrBiu08ATOWwxuzH3CLUswUcD2HA7nOjQw/h2IWhISnLDvFq/u7CVAh8Z/EaWyP2QEcwp1r+1ZNKY22DOHKHexK4u0zYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 12:44:48 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Fri, 21 Jul 2023
 12:44:48 +0000
Message-ID: <95930a64-d7eb-7d88-d7ee-13a319674d77@intel.com>
Date:   Fri, 21 Jul 2023 14:44:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/4] ACPI: NHLT: Introduce acpi_gbl_nhlt
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <rafael@kernel.org>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>,
        <amadeuszx.slawinski@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
References: <20230721094722.300586-1-cezary.rojewski@intel.com>
 <20230721094722.300586-3-cezary.rojewski@intel.com>
 <ZLpigtZ0ptwhhWEi@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZLpigtZ0ptwhhWEi@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::6) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SA0PR11MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4411a75b-399b-4d5a-4d78-08db89e844b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOgYfbCNqUUGAqvDadodqyg2nLaG0uVc4UkvDCbVuJtNW14jml2mrW0KNwqsxAhBS+TSMSH1dQkAg4+SlnfHafONTE/nZRE6qfhvlH1+bOWhIldcZbGGi8lzR44g55V+4oDSYs0qy5bfe7/OpXSNJ3JBdgNGLXJJZj+O+g0OVd4nThsLFnNiIAuaeBAAjPCULRPu0OS9v1Z6N9HnrWuUoOtEuwFgjqcRzYKqjAGaXrMkBYuyiXJsHn441JTD39dsIr8QTl1QleOakGuGEYVcOMd0BC9V/VGH+bqIPxxcP6TUm9oQTiC1mePd2uOfY3EER7Sh367zsNTLNOECV0hKflJ6h/wojtjZ2HfGaTHaIfYnle5aXolGtrJI6jfsoVV6L0JEPgQln3lzKdihp7zV6bDz+dwostzHMtxyznZPQ8mkz+UqvPQof40tarpDvZagHPjDhXO2my0iHBbGHZZ1vywcHnmjblTgOHhTDh+Q9DxHzNp5XjzaynV8FVa1we+MKM5XOJFiYRJi88zjk6iYtDzPfTXOzHJHCRG7x8NokMsD/v1IcKC0jVxDU5Szx2L2c/omEe4bwbPooLtkFmkxPL/VlqECrw+HhZnPtzYKh2yTmW6JGwoUorHsnKZxk686Gs9jgSZr0Uv9ZvHBXi3i5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(38100700002)(6506007)(53546011)(186003)(26005)(8676002)(8936002)(41300700001)(5660300002)(44832011)(31696002)(86362001)(4744005)(36756003)(2906002)(478600001)(316002)(6916009)(4326008)(66946007)(66476007)(66556008)(82960400001)(6486002)(6512007)(6666004)(31686004)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmQxMjNrUDlLT2RKTk84Qng2dHc2QUdPVU1SQUgrd1BJM0l6THZSNTdzbzVF?=
 =?utf-8?B?SnlkdWV2WFVJbFlwYlhTQWE2RCttTGR0eVlBYzdJN241a1BQaG9LOC9kRlhJ?=
 =?utf-8?B?NEF5M3BJMUxoelBkSFA1a3ZQUnRlQ1lSdnRMeGh6TzZuVTJWMkFQdWVWMlY1?=
 =?utf-8?B?MlJHUUJncDNuVlRTWi9od2RDU0tITFdoanNJZkNEczlJcDR3T2RTNWtGL3h1?=
 =?utf-8?B?TXVJeG1tSUpaTkp2ajVKTzQ0Q2VidkMxVTZTaFVLK0h1bzN1NlRaL0RDZEp4?=
 =?utf-8?B?bmZIbnk1ekNhcmhmcTludk9vVy90VDlOdFh2bWNPNlNwaUVrNEpESGVoaUY0?=
 =?utf-8?B?Qkw0dG1XOXBEMWtydmZmdm1hdGZudzlSVmFYeTBzaXprSXQ1SXFRcnJBajJR?=
 =?utf-8?B?OVN0SHV6RGhPYWQxU0FFRUFLL3BIN0YvTStzeXY5QSswekFxN05neUNUb2VU?=
 =?utf-8?B?ME9QY0t3M1NJRUpaVGZ2MlhVenByVlFjT3FNbFgvc2RuRzRMZ0syT0MzN2pT?=
 =?utf-8?B?eDlJNGtjbkxrU3lMdElLRGhiRytFNWh0N1FIYk9JYTlXcG45cHk5ZVgwblFa?=
 =?utf-8?B?OTNvUlo4UU1FNzFDbFVQWWIwalpPbFhRd1JleGx3SjZxSUdPdm9ETmxCaVhB?=
 =?utf-8?B?UUhNTzV2b2tPOFRNbTlHb2ZySWJnbmxENlcrTjhwQnJtQTBGS25mMEpwTkNw?=
 =?utf-8?B?bjVLRStPM2p0RnFMRkVSL1NkNXppZS9QUUwwRktRd1dKMFhWV3lNYjQwb0pl?=
 =?utf-8?B?c0g0ZUpjMnFtTFR4NFZmMkh2OThUYWtuZEVPSmNVYlg3bjBkSVNEN050R0NK?=
 =?utf-8?B?NlgrQW9tZXVyeXBYeVllUDVraGgzTEtoSjF6Nys4M1VSNVFvYWhCcGZRSjFK?=
 =?utf-8?B?dHFjQnhNd0UyYmxzK1hVQ0cxVjJzbUtqaWlodG9SYmdzTnBvdmhSaWZGWXBn?=
 =?utf-8?B?YlJ3NDhmY0xNakxra1Y1TlB5WWNrTFZLdUxsdVFZZ3dQMm5OVGNsQXFRcm43?=
 =?utf-8?B?NWxJY0ZrUmMvNUhnQlo3RmE3STNsbG1UNnRtSGRteS9nNi9teW5aRjVoVXdh?=
 =?utf-8?B?NDhxZjZVeGJlZXNyQ211OStrR3lUTE9SQWtiUEJrS0s5USsvWDRKY2I0dUxI?=
 =?utf-8?B?RTIzcFA3TUJPZXA4UTE0Rlp2Rlc4YlE0bFBTMUZvYmJGM3BrTHAxb1UxcnFm?=
 =?utf-8?B?c0tMTU0xWFlCNS80UEhicGMvcFZwa216MjEvQkhZRmpRYmNkUUN2dUR2NnEy?=
 =?utf-8?B?OE9EaldSUUYyU3NOakZ0Wm9NcEtOMHNGU285amJrT3FRZUk2QTRrbXFUYnZP?=
 =?utf-8?B?d0tTT1BNTEw4VDYyUG8wOXRPb25FNmZSNE0zc21xZk5vYkhVRUErTUlteE0z?=
 =?utf-8?B?dVRsOStZMjdQaGR5L2hqdkxJWUR5RVpBcDZCdFp5TTFobEY4NC8vOEpkN0JJ?=
 =?utf-8?B?aDVNZWZHVmUrNFh5TEVQbW1xMklqUXlqRVlrT3BtaCtVbkJDbDlNclRpK0Y4?=
 =?utf-8?B?R3NkZ2l3bVpMZkM4UnVZQnRMRGJtc0RXMG9RdGJpbXJiWDhLUmJzcHJVT1p1?=
 =?utf-8?B?eHVnZ1FTcVQvRGVoVGNSM1FzaFEvWnNTc2JxdVo3MDRuNmg5cXVlUjBNdkFq?=
 =?utf-8?B?WjQzeS9MUk11M1hqbnBLSnNaV3ZSckJoQnpuVlZEWVFMUTRab2gyTGZGaGw4?=
 =?utf-8?B?MWdWVWN6TWpEYmtBTERkTzM5UDZwSjBZb2Q4QjIrR1lSRjZiRXpyYmJnQi94?=
 =?utf-8?B?NlNuRHp3enhFWlhTdGlNQWtQR3NpMWhydzRYRlJzMmJuY2FLWDZkVDNGdmpM?=
 =?utf-8?B?N21rMzFmVjB3K1VQWWxKRlFwZ1NsYzRwUlVyY1k5RTlZajFPb1oxSlVTcDRM?=
 =?utf-8?B?Y09hUGFQbXM2WGxuRWRBSDNVcjlwZS9yQUtpTUJ4R3NXL2xXOTdnZUFra3dD?=
 =?utf-8?B?UHlLdC9ub25LTk9kRW13YWFadjdZUkNvNlNqK0hKd0NVVmdJNzhZUUxRVGo1?=
 =?utf-8?B?STBxamJtMldXcEtFMytyditvczQ3Ny81SllZK3ZvUmIvYjRTMzJhS3huVnB3?=
 =?utf-8?B?YkpnM0lkUTAvL2IxdW1DYThpcDBFeVFIa0lFcDNkcUw2TjBtZjYzYWNuWXg5?=
 =?utf-8?B?Y25PRitFNE1KYVNLMWRtWWQxdHFWVzdPMG03SDExWEpYb3dvcmdIbmZjc2dP?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4411a75b-399b-4d5a-4d78-08db89e844b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 12:44:48.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3yEqmZS2EncpNkuqUccbNs/P9wBolaOhfEBZTClPJEeKmBjLWR4wD7sXQ+S+P4rpK4Sf7b6E6M1USVFURymkluWLzXIyYdQFp0gTal2taw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-21 12:48 PM, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 11:47:20AM +0200, Cezary Rojewski wrote:
>> While there is no strict limit to amount of NHLT tables present, usually
>> just the first one is utilized. To simplify implementation of sound
>> drivers, provide publicly accessible pointer. Accessing it after calling
>> acpi_nhlt_get_gbl_table() yields the first NHLT table met during the
>> scan.

...

>> @@ -594,6 +594,9 @@ config ACPI_PRMT
> 
>> +config ACPI_NHLT
> 
> Wouldn't be better to squeeze it to the most ordered piece of the file, so
> the list of the table support code files will be kinda ordered?

I may be wrong about this, but it seems that the driver/acpi/Kconfig 
file does not list tables supported in any kind of ordered fashion. I'd 
refrain from reordering the Kconfig in this very patch and rather have 
such job done in a separate series instead.

> Otherwise looks good to me, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
