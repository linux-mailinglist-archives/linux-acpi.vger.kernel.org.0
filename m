Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9D75C3B5
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGUJwg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGUJwX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 05:52:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD549E6
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933059; x=1721469059;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jvKed4rNkMSw3Yco7invY4vz1jzgEx0HYOu5l9YNNV4=;
  b=TonkGhOvWoHlnQ9APE2fMkXOR2fnYUys5P77RQUHHa4HCkvjHfM9WnUX
   GJ5bcWDzgJ+/3g0ke2jCwuBCQBXso8inQ5vSA/X10Rt2JMBwPScb+wsMr
   NoO6QBB6S+AiGqNIJt0UbXkyYNXJh712+VVsGzMYu6OmnYqPieNdzA4r3
   fAx147x7Xkzi2kxISkiYkb0cvOnXr1nYp/X0cLiXUVYm8Y8iOkPOPM5or
   2Yq7Z8EgP/MGwVlGE9COJYjd+y5pk+N9ZJTCjWbhvo6TmEIO41wLBZpnD
   QoE+K31oPQXErWfNkxzXLwFOdN4BthDhwiw63ARHHRqYQkfgIjbLHKlZL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369658073"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="369658073"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="728048221"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="728048221"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2023 02:49:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 02:49:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 02:49:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 02:49:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 02:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO62IlB5mH+Twix74ttrbI+MRRKbGeUPPzF5mbOJm91a5VILlUktv51IKe5saOE6vU3ExqFO/oZERlO+mxGFjixQlm9EUO+8HIQEAW1VKPH3OSzmO6WvF5E4HeQTF/hYkjhmnktnQOZ8uX9MAFel39hb9TbNVE+glPP2XFOUYLsOBOq29d84bMH83eQqvzkLMd0JS5tQTJQIxCmFBZ/O/I1EQCAt9EzqPQ5irtj1mZsqPH0D73tgJSxr9t6Otvv6Nzvsq/jvE34D0A9JZhZNaQAim3ae6yMHq4KdSUPI6bg5T++B9deHgEuDfOne8fskx9Sqgy2fQZX3OeqptaxvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVzoursCIvA3dijNF6JFhnGY576vaQ7AyCkAKu1ZAG8=;
 b=mGpEXP3fTqhuxdN08jw5INLWIWE+P3mxVfpVAhX/T31R8zZetolHIzY4PZJn3R44wvCKmFyZ/GRHHPKy756F42HxAPHqr1FRKxwYN1JsWwE25He8Lzm7M0q9PSYRlbmS4+6O9TEn5SIssAY+NNdN6mzwAJOHsJlQEWX7yMqHo+HqOQKBIXMw7IJlFTo26fLrHK0akZv8OnHwpiNvKljw/FpBV6GsPi/oejgQC6O5TuNcWoPir9xo3AAmAZ9Im+Um00w2GGbNRGSSc0xLaS8U3Uv2X79Dp5wCJywNl031IeCdHOejf8BS5xyWkEO5VsLk9BnyZujVueWFSahQ4FyY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 09:49:23 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Fri, 21 Jul 2023
 09:49:23 +0000
Message-ID: <df2bd70b-c480-27fe-5806-8d96b0713358@intel.com>
Date:   Fri, 21 Jul 2023 11:49:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <robert.moore@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com>
 <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
 <ZLgDDB7vH/4FaI06@smile.fi.intel.com>
 <820d5447-a491-f052-a1f1-939fc9c283bf@intel.com>
 <CAJZ5v0gZLwJF78JZG4-ETEyr=_X41ude5ebuM+GE1xHhS_0PYA@mail.gmail.com>
 <CAJZ5v0goKBLxQO6hJq8Gpj-JEb9D1YuXHWyzwyr9YV4iEBteig@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAJZ5v0goKBLxQO6hJq8Gpj-JEb9D1YuXHWyzwyr9YV4iEBteig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|CH0PR11MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8090d6fa-8965-42f7-2b5e-08db89cfc321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSquXgP6YaYEXP3kCvOD2xiV45JaMKdiLTBUFBP4ZeFp0jn4D5+M2p4rW1HdLTxN2a0VF3MSgGXWPd6J+sQB6ShHGvjAUNi9OngJLALm0pOeogZoRFDn5CuQGH49p3bo9jzHKX+AgLByh9FXJhCxcbau5pDq42FpQmFiJSHuoJPm4GNTmdMPr9+jTIB4feJDDTGVCpnd9MOwenPW/ViLcaBxCPjvAu0tnz8SNEAjJfU+DE/iFjVTwCtObXwiipiTXqLjcm8I8V45AiBb/kbf2JLE8Je0XDoucVe8YpmskerT/MVYkYPeK1yDePXzn+i9kRd/2TxVQ+D236shOGYTvUSErWERfbSyFSjPEbV1tALZGEBHoaeQf4fBGGBAHcC3kUY7ZY45uLpNHvtfeJlCSpdVkvX1f8aXS2Sm9CEz0D+Sn5tsTI9hfBgH+fYYl32W/CrMzvE8pBFa8QOrNE38zzXw4o9a7rMM0MX5ZPV4ktY2ibXUbBnKWxFwiDVXIQ2u/tW18aDDLhjtBXpYKaJ5t2Qlj07KghY8TOj5lHeEFR4aAaE/MZsPHVn0Lm4uq/NInqEFtN9Uvv77IanhG3KvQjbo1OgW8+CL3tssJggoDfNTEiiksHIa2XnH2IO/qf5+036vhgCwOEjiG9bdjuOztw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(5660300002)(8936002)(31686004)(2616005)(41300700001)(26005)(83380400001)(53546011)(8676002)(6506007)(186003)(6916009)(4326008)(316002)(66476007)(66556008)(66946007)(31696002)(86362001)(6486002)(6512007)(6666004)(38100700002)(36756003)(82960400001)(44832011)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0lHd0NHeEQzNW1qclBiQkxYU25NTUVuYlkwT25NcHFBTTMyZ2FybEp1SjM5?=
 =?utf-8?B?S0pDa25rUms1R0NnOHlIbHpwSXRoLzFMYUFiK09wNjdIYnNST21sNUZNOVhV?=
 =?utf-8?B?QUs1VWtVcnVqZlZZWDB0ZnMyd2liYi9JM0xBYnF4aGdlbjlZTjFUVURCVm1P?=
 =?utf-8?B?MnNSTXZsM3g2eFVDWGlpRmVib2RPRjJZOHVlUzZjRGVucm5JR09lSDhZZDdr?=
 =?utf-8?B?dDEzRDZQY0lKTUpQdEFMUGhzUFNDcGhDL2RDZkJOWHZLQis2VWxhbDdicVNh?=
 =?utf-8?B?a2VUQlB5VUN1OEhpam1kdXg1RFNCbmFvZVR6WXQ0S1J0cDhmbEpGZW1LZmdH?=
 =?utf-8?B?czRVeHo3a0x2elBTT0FXZFd2SWFhVzAxSnlYN3BUaXB5aTB0SnU1TnFnWXdR?=
 =?utf-8?B?M25abjdlbVRrMm8wa0FDbmxYYTdXSzVabkVYSnpjM0x3cGRucWxSUGNTKzJn?=
 =?utf-8?B?andFV0pSNzBOSWxjaUZ0dFFvaThrTHVmalltSXZGN0FjM1VnM1hNVFFiM3RH?=
 =?utf-8?B?RlJ0WVZFaEYwNlRZTzdrSUVrLzg5WlVyT3BiY0xBejI5VEIwSkpOeVBnRFVz?=
 =?utf-8?B?aHZDWmlyL2NNSmpGbXJ1aHdVZWlHNUJndTdGOHBpQ1lDbjhQV2Zyc2t4SXRE?=
 =?utf-8?B?MHNFL1p4MHBGZlVYdWtpYkluKytOWmxPOEhMZEI2bWFWWGUydGNFbkZOTmFz?=
 =?utf-8?B?OFp6VWpyR0VTeFYrS2tQcWZvbjZTNXd4UmRZeG5TK3hyN2M3ZE9xbTVKaktv?=
 =?utf-8?B?OFFOeWJ0cUpEUVoxZldFYWdmdXEyRmxGd2U0bU40d296OXdsemt0c0t2RjRu?=
 =?utf-8?B?THZrRW5UNElUV3poVW83aW9kbklXM1BnTDZ2Y3ZZcTZUSkNCSEpYQmhwUXFP?=
 =?utf-8?B?YS9abUtSeVJkV2p3elFBd2kxdytaMW5FZ3BCQWdZYjRvYVp0enoydWFVS3po?=
 =?utf-8?B?Rk51bXE5cnJ0a2VnSGFtZi9oZmE4VW95YkpXTk9PRjFzWW9oUWRuQklwMk93?=
 =?utf-8?B?TGdLeEUrS0RWdXZ0RnoydGE0enhnSFRTcDUwZU0wRkVqdjVxa3RxM0dJMmY5?=
 =?utf-8?B?UWN6RHBjZUptNEtwc2NEMER1R2JtcGlyc3NTKzU0VjF5MXcrSDVxeTA0S3dr?=
 =?utf-8?B?eVdndHI5T09hckUzRy9Dd0dwVDJoUFM1TjhiMjJDM0F6QnFPMy93T3gwNlMw?=
 =?utf-8?B?cVo1dUxrRXhGL2Jpd3djVENFMGJuQ3R0VEh2djcvSHF1TWkvbHc4Wmt2Qmh1?=
 =?utf-8?B?RDFCMFNJZ1gzUXNwdVUxemREcnhvZklUeVErQlFMbFlva2RoblM1V1AvRnE0?=
 =?utf-8?B?SEllMkFrbTJpUFFMTGZ3K2V2dHFFOHdkTDJYdVpjRjBhVTFKNHRYOE9sMndr?=
 =?utf-8?B?MUFROEl5T2ZWSTk3a2xFajVGdnBCNDFLb0cxOFVXeGZKQVdWMU1FQkxQQWVj?=
 =?utf-8?B?Sm9xSE5Md1haNmk0WWNEalVLbUhsKzlySWhkYjVuM3RLRzc1b014cXQyQmp0?=
 =?utf-8?B?RllIWVhuZThFcUlHN3Fkd1VlYlZVOVpTVS9HNmFpd0tYbGFFaVhBNStwL2Fy?=
 =?utf-8?B?azdzZjhTSksxMy8rMnZIVUg1c2xmSGgyZHduODYvcXJMTW5tVkRiWG5kZnM2?=
 =?utf-8?B?QWpxckRzdU9BQUhSbGtyNnUyWEFIYTRoUGZtdTJaZUt5RzJCM1lLKzlhOXRN?=
 =?utf-8?B?bGhheWlCQzhhZStCVzluUGNzVm9aYzdwbG5nL2pBTmRsTWE1RmVjUFdodzVD?=
 =?utf-8?B?bndLT0szanJkS2lSbGhFcFBJYmlxdnFKRytick5XbVkvTFZ6L20zM05IVWZ4?=
 =?utf-8?B?M2JmcndyK3NTZTVjVHgrUkUzL3VSNDFqK3lTenVJZ1NFSVRoa3kyUEx3VEtS?=
 =?utf-8?B?Z25Ua1FSQXFVdk5ZS2c2alVBNnVDK3VkSllYYytwZ1BDbTg3Z2MrV2Evazg3?=
 =?utf-8?B?QS9ZVFNkVitIRHJFc2M2Uy9ldFBMbnc3YytseVM2S1h4Z1lzSTN6ZFFTOVAx?=
 =?utf-8?B?Y0xRbTQ3TEU3WnVPVVd3U1VBQnc2UTY4czY4NWE5bjBpd0lRQmtSR0hsbnRR?=
 =?utf-8?B?S1pmcXVKRnhCa0N4TmVJTzNoSU5SK2l0SC9mSjF5QW9hbEdNRStUNzltRVNh?=
 =?utf-8?B?c0hua0RkZ3VuTE1lQXBQQjBwNkx5bGFWNHREZkdHMmI0VGVuMXMxbzRaWWVj?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8090d6fa-8965-42f7-2b5e-08db89cfc321
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:49:23.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV1G308I1gliJiBsyAvLkV4lDPXZHSGUgBwx9wNZ3inzFZueyoYGIYGbh1AdZSKyGPH3NJLkFDmh8XskH9mEAZwxwhdfa9r8ij7f5uiXCY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-20 7:05 PM, Rafael J. Wysocki wrote:
> On Thu, Jul 20, 2023 at 7:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Jul 20, 2023 at 11:15 AM Cezary Rojewski
>> <cezary.rojewski@intel.com> wrote:

...

>>>>> This approach generates a problem with undefined symbol "acpi_gbl_NHLT" when
>>>>> ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is disabled,
>>>>> symbol is never defined.
>>>>>
>>>>> Proposed solution - modify drivers/acpi/tables.c with:
>>>>>
>>>>> +#include <acpi/nhlt.h>
>>>>> +
>>>>> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> 
> No capitals in variable names, please.

acpi_gbl_NHLT follows the path set by acpi_gbl_DSDT, _FADT and others. 
Why would NHLT be an exception? Is this because it's not defined under 
ACPICA?

Uncapitalizing nonetheless in v3.

>>>>> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
>>>>>
>>>>> as tables.c is always built the symbol is always there.
>>>>> The only other option I see is:
>>>>>
>>>>> -obj-$(CONFIG_ACPI_NHLT)     += nhlt.o
>>>>> +obj-y                               += nhlt.o
>>>>>
>>>>> and modifying nhlt.c so it's essentially split in half with:
>>>>> #if IS_ENABLED(CONFIG_ACPI_NHLT)
>>>>>
>>>>> but such solutions stinks. I prefer the first approach.
>>>>> What to you find guys?
>>>>
>>>> I leave this to Rafael as it's his territory.
>>>
>>> Rafael, which option do you prefer?
>>>
>>> Regardless of IKP and my CI returning success on compilation tests,
>>> clearly there is a problem when CONFIG_ACPI_NHLT.
>>
>> Putting the definition of acpi_gbl_NHLT into tables.c would be fine
>> with me, but in any case, because it is an exported symbol, it needs a
>> description in a kerneldoc comment.
> 
> That said, you can also do something like this in a header file:
> 
> #ifdef CONFIG_ACPI_NHLT
> extern struct acpi_table_nhlt *acpi_gbl_nhlt;
> #else
> #define acpi_gbl_nhlt    NULL
> #endif
> 
> and require the acpi_gbl_nhlt users to include it.

Simplest solutions usually work the best. Surprised I haven't thought 
about it earlier!
