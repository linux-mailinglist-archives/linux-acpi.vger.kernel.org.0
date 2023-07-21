Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE975C777
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGUNSf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUNSe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 09:18:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238E10CB
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689945510; x=1721481510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0ObLUibMlFXCpjats4QRYvlcg4PraJOCdo+jYhs5Lw=;
  b=VXRAM9s7q0hDFusqWOHVR/+nJ4SMdTDPkQGZtMBIPYeIaQeSn/TZOy3b
   Pavt9G3/X4PHSCmFS7R2+L2r3M/Q6glkKEKBMS3kBWJmfbt/2I7mvGois
   3fXm9tuBhXWHPhf9KQttwOl5N6qbv/JpsOYepvLfwEAG37o2ytUdv/yY3
   iI/G89DVCzlHZULpCX6poEqacq6PS1RxzZIMmM87jLDdA6kb0KZvtlztR
   KH7X1uT36fsqlERF7We65l1VrFUaBtD2s5xl7SXxwmCaYIlvgA2g4RBQ/
   E8Q/QgbYE9MzpgBXjBPEkiHIWGI/P2A+cZrO9amX55ZrGXAxCd7TxNAAw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367058813"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367058813"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="848821366"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="848821366"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 06:18:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 06:18:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 06:18:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 06:18:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 06:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEGsssLBg3uD7WkrlNG0VJ2QY7dvXn2k4dvfxWfNaXLoBaegzKWPZ6ybcKu7lLLE3dcY4dNjr8RpCy/vgj7AhmYtRnCxeA7XIkjA+PU+OAFB8UvVYSPLrk+LE40KUOSs1PKYC+qhA4wvJzfirqiDyQb/eRk5l/BZAH1snhOptD1cwF+iXYLEfPRuy0ffh+SJPftLzJ/9wRQPHta1gVeLyBYcdoYoaYo7w9YlB40hTZP5ubSaRZD8s6pnVPQf0mNTpn80TW7KRmi9PUUQ2XxQx4NRo58XWo+1KoBRqImZonbbaEmTUAnnHXquoAEEKgh/Ko2aoG96yZS1o8ObXxAGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td0kkxnu6t+xJrJmCiOXDHnoNtLLj8yFx8miRor1cFE=;
 b=SqcqMTHN8eV+BpWg20rv8xsui6LhPLXDCzO6Rl5IRABPFRVPgshyupE0/P1eMIvYgSy/4dLHD2uKqQI3+yIArWRCd/CUDIBUjaKGcOQ1+GhvlpuTrJTL+O/hh0iKi9ypXCe+i+NqhS2BtU1c6tLnw96SVpM9fxCebM9a8hN9GcjF2f1Nw/Q5PWggIqYGNcIcFcWz/P+ry+Epxiz6Q7L6VxEPfh6EsPdwPJfWcUUkNJStQk+JlFfNrpY7N6WOsLvw7Eqdjwagy18zZnGEZwBsncfo1/zK/tmtMYrz0SUhFFkbQCjArZDIlaEO1PhpWdAP047fGS+bShUNQO39MnycdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 13:18:18 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Fri, 21 Jul 2023
 13:18:17 +0000
Message-ID: <668566f3-c545-f10a-f2bd-37419f60b91c@intel.com>
Date:   Fri, 21 Jul 2023 15:18:11 +0200
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
 <95930a64-d7eb-7d88-d7ee-13a319674d77@intel.com>
 <ZLqAMf2eakwSfBgs@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZLqAMf2eakwSfBgs@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fea64a-9ed6-4827-cf08-08db89ecf20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lQXv15tu/XIy7KV9vbCM/lCCYXJ5U0R8l66EAMJil34oaVMW1TvwM6jGgxIiZgKRFjTPsV/Y2Q463LO7Vfbb4p7+4hsIh1kx1s33Up1smnLFr4viqptpvAzriJLuetLvxeyIXrgJgoPDUmcuPYdOCdaHnlR06IPyhT92fvNPlK9JamzvOYc+ccgjN+gniYmqNc+FUvxDfB87nPC3INGjuODd9YaPGCj96Md1MspwM4rZlCkm8Cugx7BZMvpIyoyhG9tLunkL/H/gfmfXcYi+LKogAiYxn8l6lMNzKNFhdaGKPrDl8FesCZQRYO86KXDWhrb7+EcptcVmHJtTq8fKujyWy2GLv24C2Hd1zz19i+GBiJ+vx2N/8lNXNTjanmVuYqdNurL8z2JBUQ3yOYoWcHB+IeijKoZg3jEVCKvOfrnbtRV1i2BxXNmftkeHTSh/4bQFIS2eAFJFYGPuP1q+I/g6DUfQhwFopY5z4MsLeep1/LNlMxd/m/rKY3f6dgj48JEZrjI6Ea/pTZcGu5mdjFYtE0bWC/GcjPx2JF6AkijnbE3Udk3OMnCzBwoHEMzHLl2Fiyd7totD5xSzJUDfqaQtl7h4ifppXvpk0qqKdwfMY8FnnD6B7YyZqBB1JnnXVQhj2+AYR+fQJIjPQwmJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66556008)(478600001)(6486002)(6666004)(36756003)(316002)(6512007)(5660300002)(2616005)(186003)(6506007)(2906002)(41300700001)(38100700002)(66476007)(66946007)(44832011)(8676002)(4326008)(6916009)(82960400001)(26005)(8936002)(31696002)(83380400001)(86362001)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNwdEtqOTUvOWg3UllEMzZ3bkUrZ2VkSCt2UU5HTzlzanEzUWlIMEsrbzQ3?=
 =?utf-8?B?NUZVWC9jNG5mS09DK0pYeFJ3d0U3ZWZDakgwS2dCTUFoZUtWMklWQnZHaks4?=
 =?utf-8?B?OXFHcmlwNFFlY01Mb1gxZSt4U1JLWUhvU2hyMEFLaHRzeEFhV0tJNzRBcTE3?=
 =?utf-8?B?dVlpSTVFdmd5Nzlwb2hrU25MbXBieG02cmFTSnhWVldUcGhvbEV4R0djeHln?=
 =?utf-8?B?R25MN1l6OERsTWgveGxLQnE2RGpyMTFvWk9TcmczczlaOG1MYnRhQWFWbWJG?=
 =?utf-8?B?VVFiRnl5TUViNkdCTFhON0Q3MENCUk9UZ3lrNloyMENDQktHTWFqbWNndUNZ?=
 =?utf-8?B?RVpKTmhNU2g5V2pGTE1SdmJxYktJdmF1cEFEWGNBdS9DMW1iUWVINEVLRUV2?=
 =?utf-8?B?WnhDMHpWZTI4NVN0WEFnNDgrOGJrYzJDMWtzSitzVkU0bWpqK1Q5Q2owdyt6?=
 =?utf-8?B?ZWhVZ3Q3M2Evd1ZPOWNBc041T1dPM0hYazQxK1ZHaVIzRi80bUVtVWVzZWp4?=
 =?utf-8?B?bjB3Wno1dW9oaytWdnhybjMxOUxYeFhKbHZUb3N5T3NQUXNEKzVnVTgwRVNi?=
 =?utf-8?B?aSsvcjh6aFZZcDF6clVnaTV2YVZNSnpYRURrTElTRU02V29Qdzd4c3hpQUlK?=
 =?utf-8?B?T3Fwb0F0eDV6RlRXMjhHcU9rckJmTFFML0p0OWh6M2hQSURLczRGOGxkTEhG?=
 =?utf-8?B?cXEyYldhaS9pUlYzRnBVdit6S25JQjBPVndFRURmSTB2eXNmSHVsOVpzYjdU?=
 =?utf-8?B?d2V5UUVWcksyUUZqSTlTZEliS09BOHZudkQzU2xrWXBwbVZmazBVSHNXejNK?=
 =?utf-8?B?T0swOEZGWTRRYU1UL2FyaDNwSFlQb1VKN1hDRU5ZNmtWc0ZUditMRytXUTRi?=
 =?utf-8?B?K2FRVkI4T2x2dGpQSmx0QTJaYUE3dkpLa2NGc2dRNXczU3JsV3BQcXJiODZJ?=
 =?utf-8?B?VW5iQkpUQ1dIM2d5V0NHTGhHYWlZNlFxZFdueWZCUlAxY1pCdzdzMTRoWUcy?=
 =?utf-8?B?QXF2WmFOTVhKYkc1VS8xVzh1eDZpeFE4eXMvVFBXcytVbURZd2tFck16bFZL?=
 =?utf-8?B?SVloZ0MrOFZndUIzWTJuR0xqYUdCbHZjUkhjbGNrU2ptMlF3ZkNQTlEydlZY?=
 =?utf-8?B?NXdrdFRoZGpuRHZhTlpWVVprNDBaOW1tUEFCc1FCN3YyZk11b25KY1BBWUc0?=
 =?utf-8?B?UXpDZGpnakVEZ2cxVmZCaExjUktGdlRLRzdQa0RsZWxaVzdFWlFXRnZJZy9j?=
 =?utf-8?B?YVlDUXNXRW9tTDNiN1lVVm9xenFVNERZR0VHcVFxUUdKa0FKRmVPQXJEem5B?=
 =?utf-8?B?ZUQvVER1RXgwcTNJbC9LMXFmMTE0NEh1ektZMjlLVThHOGdkd2c1R2VteVRn?=
 =?utf-8?B?eEhWeEd4TEE2THVJdUZpa2VLZmkrS0p4MnRBNmFVVFJnblRyaitTQUxPS2pS?=
 =?utf-8?B?enUyeVJtRUN2ck5yTTd4Mm5BaDAxT1JYdzJVbkJwa2UwdXFVK0NCMXZjVUhp?=
 =?utf-8?B?eUtiLzJJbjZ0ME4rSkJ1ZDhNT1pYRm83SStyZkJua2MxeTVnZkFoV2tKMk9x?=
 =?utf-8?B?R0dIbkorelRpR1c1Z3p4MTZkUmpxOGx5cHNIaWtpSEU5V1JMMi8wOHFYYm5w?=
 =?utf-8?B?NVQ4SUUrcHdqVXVrZXdWQ3pWR29iVXJTQXdpK09sQ29rMzZEM0I4R2lIc0wy?=
 =?utf-8?B?T0lQNmR5WFJiY3phc2tjMWkyWmswdnhWZDUxUHNpcEhxbFFaalF5UExNMEdC?=
 =?utf-8?B?UlBXS2h2d1hkSTlBemszczdrWGo4bmo3bkxSMmhad2MzRlMzbmZlMWJ4cWRx?=
 =?utf-8?B?SXEwVnpWNk5uUlVEbE9kYzhQaWFZbDFSMXJqK092a3o0RGFZL2l0RlpuS1pp?=
 =?utf-8?B?Wm52cVFxcFlXeFVoTCtyVWR1MEpKWktJc0tUejdQNVF6cVpoWkZJeVRkSjA3?=
 =?utf-8?B?Z3VNbDBhZ3RjNFFzVVRYUTk4ZXZGV0RTbUxlUkMwL1hieGJpRXVlQWNlVXRm?=
 =?utf-8?B?eHJyeHRNVlM5RGRVYThrQTVWai81OEpBbE1CV2N3SXg4bXRhWkFFa2wraCtt?=
 =?utf-8?B?amNYbERZemZWaFB0RGNCSDJyVk5relRpSlExSzZvTXR6R3RMNTBWYTM0OUtM?=
 =?utf-8?B?WXg4OGNrM2hpdmxTU1FWK1BvODlBWnpvVHBKRncxbzdvNUdXNkR1a0NjUHVl?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fea64a-9ed6-4827-cf08-08db89ecf20f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:18:17.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S14h6C34SjDRGnHvajvuaW8gLGpW4PgdqiuOzBJed/mRk3/+KW/iG4BtsyoPwizckbYlxRSQmrlasWgRItonrN8ZpiryOUTQZzB+wC9frpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2023-07-21 2:55 PM, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 02:44:42PM +0200, Cezary Rojewski wrote:
>> On 2023-07-21 12:48 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 21, 2023 at 11:47:20AM +0200, Cezary Rojewski wrote:

...

>>>> @@ -594,6 +594,9 @@ config ACPI_PRMT
>>>
>>>> +config ACPI_NHLT
>>>
>>> Wouldn't be better to squeeze it to the most ordered piece of the file, so
>>> the list of the table support code files will be kinda ordered?
>>
>> I may be wrong about this, but it seems that the driver/acpi/Kconfig file
>> does not list tables supported in any kind of ordered fashion. I'd refrain
>> from reordering the Kconfig in this very patch and rather have such job done
>> in a separate series instead.
> 
> Yes, but my point to make this job easier to whoever will do it.

Hmm.. I see that the most occurrences of word "Table" is around 
ACPI_SPCR_TABLE/_FPDT/LPIT area. Should I put it after ACPI_LPIT perhaps?

>>> Otherwise looks good to me, FWIW,
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
