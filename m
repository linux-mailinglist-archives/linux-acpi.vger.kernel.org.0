Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8770DFC4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjEWOzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 May 2023 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjEWOzB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 10:55:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573E119;
        Tue, 23 May 2023 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684853700; x=1716389700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+djZjrnaaodGA8K7EerijsizOBQ8aKqmPwdcpaUnND4=;
  b=YafyttT3MXmhg8p0T0r+c2NhEMS544QeGnjZ3W87WY9IoXiKjUrBbWOU
   2mituB56Ppwk1QGtKVgVfIbVdtl6llmrRsaVqohw+f/qJiupQfrO1cWvO
   FMAW1+ah5+3maM4si/i1d6WXFReWhaa4eD5395qVqPnyu28flVUh2nlx0
   r6V5v4HZcPlekl21qCW/jmJViTGADP/DZA/5IW1Pg7U+RhTgbnCUtmvmB
   d7rr9kNp6KvetGisBR2SQKNdDfEGeQ8bl4u2ODS9jafhjQwaM2NqV6dpW
   V0K4+FAHv6cj2I8L3T9Ay4xdo6qjqIcAoLDiKBoqTti6qGZaVeafibpEE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416723837"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="416723837"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="828137054"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="828137054"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 May 2023 07:54:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:54:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:54:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 07:54:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 07:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA0RS7mmedmeYCq9klif8CVOP6H0SZvnnbMf8nnV5D/CVV8C3iJ9NJI7h3O7zWDKB6w+V4HB2ArhWnZF625gqQsJEaSThFFppIv1Zx2dqdzzuHxRA32+pCs2Bqv2MgLHLoGoTc+yKC5SEfLcMYvTMZaJ1cWWz22vm/o/gmHzpDgdbb1dYvWC0tiyQIZg9xcHb51jNz8hD10vTyvh8eByI4f1/3Hp/6oNP886W0l5QP+jQtrgCIazw4ZFcmfnp9Zt0DTrkgMa/FAX+oMxXCkR8uaqHjPQ4tVfsIDCMKghNyeHO3rD92abZ/xAnUCVJAy+CXXzPk+pDdyGsnypOCXfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FS349pd72BGr9yGieFIW6S6fOUR5LqG4cLqqQJ7Br4=;
 b=XSDFYgNeYN7pG8J6bUV2a9sDUAUj/y0dYFWvVEULz4eQTDUNQZjLntANccV5uaxuQwEaax/EDe4zmaBL0uN3eggecYj1EaQFdsjS3jbcZLTEGRgFfYlmzDOWZi1MDq9wwF+yWm02M3eov35qF4gfVVrO1i6DDDTx3y8BT1785NuLhJ7ary4cMsRA2k49wsl5MdPcE7wJB38Kk1i2qMAXPrijFO4MAn0MbabA73N7fAQBhM5KVo0HgG5+5tZt5PDg7GtM/FNLfjVB9OevBDHxk+2NAqlMRypNP7vUI3nsj+8XrsHN3kv8XGxjlCzfGY8RGr1hp9/AciilUNVK7QYI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:54:54 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::b315:faf6:e706:ca61]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::b315:faf6:e706:ca61%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 14:54:54 +0000
Message-ID: <5a81e0f1-4cdf-dae9-4b4d-f2a49f2a8ff5@intel.com>
Date:   Tue, 23 May 2023 07:54:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v2 3/4] acpi: fix misnamed define for CDAT DSMAS
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>, <Jonathan.Cameron@huawei.com>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443479457.2966470.18010229834586488037.stgit@djiang5-mobl3>
 <646bf98890561_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJZ5v0gaZK8vit53AuGEXhh5EkxOoB8xGO5vP8Gh9KC17j8mqw@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0gaZK8vit53AuGEXhh5EkxOoB8xGO5vP8Gh9KC17j8mqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 456aa81d-ccbc-4722-04d8-08db5b9daaf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW1LgEmnlpcXo+SV1NQfc+G4WNHapE+EgtptLIcb3N5tfsfpfHZZP5TyN2A4qvMxSAL6aRR7TlLC8gqErvJ5gvjjpLyPytQeQIrT/YyP2E6ZnNkgu4at4s02l3uStI9yCtHcUVbKnovUHy8l6b9pu/rjC7pnbi093SOjU5oFnSMFLXnshd6Os64KXX++IGhh85uB8J3o7NVPkXVxcveHSDkkhc2SYkQGsC2/Jcnwt/MN7CT70ScorxQtd4tnAxE5GtSRkFhZA8WD6eM/1BgCecmdyE6yC5UNdCELk6oWNK00ox1HD6SCclwPpSE4ilrVL5gORnj7JVEMBUjfhkQdIemVjIIM/6tAydF+ZXj4RDmCda6NKziVnc+5J3/CvXN160O8xFMCNfpiT3xSiMn7qNSO8kBNdacpsOHYMBJw7T2bdI0t/QAP0EiElmmsJ7mqvUIe6hIAxiwHSHVWtPK7Z6YYD6fn1bFi/fVIxUjD55XbP0ZolevsNiT1VfQ7ZVp7qctOuDu+bDt77GaO0RUe0OMq1fovAyU3AiDsjUfRBsFIj/1PGR9YBkq44qLj3gC+z+K0/188V2dOD7etCsyicWAtlc336YUyiPcgFO6p+X12dB9dwTfaNBjKudnAHhHW/CGvWtGu5gBdl5OMlqDQIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(966005)(8936002)(5660300002)(8676002)(83380400001)(2906002)(186003)(2616005)(82960400001)(36756003)(38100700002)(31696002)(86362001)(44832011)(6666004)(26005)(6512007)(6506007)(53546011)(316002)(66476007)(4326008)(6636002)(66556008)(478600001)(31686004)(110136005)(66946007)(6486002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJMNDM0V2pxaDRPLzRVbWxKRVRPRy9tQnVyR1VCeUJkRnBqakhUbWlseE94?=
 =?utf-8?B?aTEwVkRQSVM0VlFzUHpHOE0xOGkvOW9XWW1NeFA0a0cvS2UrQ0xLSXR2WEhk?=
 =?utf-8?B?TnlrampRcHZEYWpCem5nSHdibmFpcVZWbW5td05NUTFCM2hMMUVUaEdFUS9W?=
 =?utf-8?B?NmRWdkJDSFN3RHhaQUdrUkVrTGhIY1JjZkc4d1dkdzA5UkMyZFRHU1dlT2xT?=
 =?utf-8?B?MHJENHY0WE5zOGR5VFkxU3NYUDhZaDdhYWtzTTJORDUrdFBIQUE3MkpyNWVr?=
 =?utf-8?B?L0k0dUJqa3FJOU13SWFVVU1YUXNqWjBOUGwxOEJxRzEzemlYOG4vd1R5V2h5?=
 =?utf-8?B?WCs5Ny9pOFVRNDV4K3gva2FvNTk3UkdEMU9IcFdleUxEMkg5dE9tWEVZL2xq?=
 =?utf-8?B?UUg4bTJ5VVN0SmFzUmVKeTFkVjRzOWFURCtic2xodDVIVE5VVkdZQU9wREpP?=
 =?utf-8?B?NmgzaS9LUDNnM2VNUnRDOCs4N3JnNzlmVm9pM0tpVnUvamo0eVAwWXAxSTBZ?=
 =?utf-8?B?d1loU3RzWi80MzQvN2ZMWkZQM1puMy9yZ3RzREZUVVRNWUFIbjRkSGRDb2wx?=
 =?utf-8?B?TFI1WjRxbFhRTGtpcVdwbDB1ajJuVE04TkZ1MGp4RmpzdkFKbUNnRVEvZ00w?=
 =?utf-8?B?MzExbi8xYjkwNkRmdktaM0szRjc0eDNydnJOWjdmYmVDR1lVYy9EcEJwZXlk?=
 =?utf-8?B?MzBCeTF5c3oyZ1k3TWRvcm1rQUw5L0U0emI3bG4rVm9ZUVgvVGhjM0o0azdY?=
 =?utf-8?B?ZUE1ZHBZY3lUMVVLSjd0R0ZYVXhBWkJpdzJFb3VUd0dBVGZmN1NYNTFiZ25v?=
 =?utf-8?B?OC9YS3F5RzR2VGhMNTJ0cTZCQ2FBS3dQbHRpbDhQUUdKa0RQZDE5QVFUejRV?=
 =?utf-8?B?Y1lRaTRiWC9hMlEzQ3JlOHlxVjNydGhQamlmTDFTb0Z0b0F5ZW5UMDhWS29p?=
 =?utf-8?B?VUt0Z3pOQ1JDdHQ4TUlQOWRsMGlhTGRJenp2d0hlTFRXNFBZOXFlZXVQVkRM?=
 =?utf-8?B?SFBQek1ySmxSQlJqbE1vRVdoT3I3ZDAvbWhVcnVjYU9mV0h3MVVkQ0RKRlFF?=
 =?utf-8?B?TWdwSmpTUExYNUlTVm9VeTY3bnlvM01JKzBpRHJwd1JlVFJpeS9GcFNFWTkx?=
 =?utf-8?B?VmxNZ1cwNllWZlE1Skx2bnlneTRoWTU1ajUzQzB0MmJxbjNOd2ZFVVVKVDBD?=
 =?utf-8?B?K3R5S1RVRTc4aVRPMlpkYUxjRUJ3K3lBVUJhTk5TUnltV09HV0I1SmQyYzg3?=
 =?utf-8?B?UUN6elhSNG9vMnB0N0ZNc0xoSWRHU0trOGkyR2VCU0dnNmxSU1VYcWcyYUJG?=
 =?utf-8?B?V3ZFTEs4ZVk2Y3BrTjRrSkdURk8waWdlRC9NbGpydFdhTGN2TzBOSXZKVm82?=
 =?utf-8?B?dnNlejVQb01NK29Ea083czJ6Y0VNaXB6amJNcXpWdkh4OE1TamgzWU50cVZy?=
 =?utf-8?B?UE5la2VCVnd1N1ByMzZ1WnVnWDVKTTdFVjRONTB0dVdzNllFVGRhSWJhc0Rh?=
 =?utf-8?B?RVprWis3ZXFJSm00Um9Jeklid094dVdvM3kvWVl3MmtQQ3RDeitEQnpFRCsz?=
 =?utf-8?B?cUNxR3RiU1BYL3hBTkNiQWQ5NzBmUXR6U0pJWlpPNXNzMytjZDBrbi8raWdv?=
 =?utf-8?B?TGZVN3QzeWZPcVcyc1c3MmZFV3FZV25SVThhdHBIYk1Ra1U0WEQrOEJGR3g2?=
 =?utf-8?B?dzgxSzdHZE50WWpmcnNLMG5HSWliSXdmdzQwMUwzeTRIVi9ySTZYOXJ0QWcw?=
 =?utf-8?B?NWErREJYd1VRNElNVWpLcnNiUGpaYTVFandKcWRtYTlQWk4venVkNjJqemh2?=
 =?utf-8?B?bnFIUWZySmpoNlNMbm4zN3hPU3JmWStyci9Oa0JUNktBQVJ5TE1UbS9ZOVU4?=
 =?utf-8?B?NkVYYjRaR1RaZTJQN1ZRL25EREdRNmVBK1o3S3NoVzhaWDM5cEEzZ21Felo4?=
 =?utf-8?B?MnVVNTQvM2ZtVng2T21JOVJhUHRmTjQ2czZhNmkvdUlTZ3o3YU5RQ1ZiOEgz?=
 =?utf-8?B?QlhCM1QwbTFjS09iOGR4WFdqdXRwTWd4OE5nemc4eG5sUVlEVGJWRGpOSnRj?=
 =?utf-8?B?dHRWb3VrbkUxdFJJRlNHVlhGbGVxRUFCR0lHbi9DQkViQXhLWHRDL0lWY01F?=
 =?utf-8?Q?EJdkjpf/XOaAnEHKjVo5JDelH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 456aa81d-ccbc-4722-04d8-08db5b9daaf3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:54:54.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwiE9ksj0XcRAOYy6YNQPE6KAg33nXNATeDGhnKxtBnosvphF6/sLsRt1uKWOCwa2jspIKK+Fwa377696CJWnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 5/23/23 03:46, Rafael J. Wysocki wrote:
> On Tue, May 23, 2023 at 1:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
>> Dave Jiang wrote:
>>> ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
>>> ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.
>>>
>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> ---
>>> See https://github.com/acpica/acpica/pull/874
>>> Merged
>>> ---
>>>   include/acpi/actbl1.h |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>>> index 81b9e794424d..15df363b9144 100644
>>> --- a/include/acpi/actbl1.h
>>> +++ b/include/acpi/actbl1.h
>>> @@ -356,7 +356,7 @@ struct acpi_cdat_dsmas {
>>>
>>>   /* Flags for subtable above */
>>>
>>> -#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
>>> +#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
>> This needs to come in through an ACPICA update. If that is going to happen
>> this cycle, great, if not then I would handle it as a merge fixup after
>> the fact. I.e. just live with the misspelling to keep this patch set
>> ACPICA unencumbered, unless Rafael has different thoughts.
> You can also submit an upstream ACPICA pull request with this change
> and resend the patch with a Link tag pointing to that PR.  Then we'll
> decide how to handle it.

That's been done and merged. I'll include the Link tag in the next rev.

