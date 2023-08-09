Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2487755D9
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHIIsc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHIIs3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 04:48:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0882F0
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691570908; x=1723106908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1loUrN34U8SeN9M2dqF7wESWcVlQ0H/eB3dgrfHewvs=;
  b=EVtHFFTRwV5nAE05FwpYCsWWuKWYppYy9tzdgJYe230rmzn79wPLqleR
   Gpty4pMDopnt6fU0PKW3vhimEzzBbrNRiEzvFOXQp5TSdHktBZS3AaNa5
   upv5IMsMV3hsd+hDLteIg0s/nwqwcblUB8EAgUBHR0YmQvsHSK7RkfJX5
   dkxvoPZHa/G5aRVGZr6Wu4V3CBUEF3b1qt9cu5shT3ALnJzhCFNLaTxHg
   xcRfWE90fm/tkMliMPCDdlLwHXCyhnnZ+/SYQCV+vdEZc2eKv/zFng6Iz
   Qf2gz4Oq+PQ1Q/W0eF5s+wyOu7HrB4Gt3WYCnm3MvLSEnF7HQaJwPETKx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368523920"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="368523920"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 01:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725286418"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="725286418"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2023 01:48:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 01:48:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 01:48:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 01:48:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edVTXXah+hjhP8XhHSo4n45HCyWagAEJPSGJ1erFTzm4qnHuKY3n3TBJ6hG0mtjeqjfAfEji9lHsv4DSbuNdiu+QkbiMELjkrqcMG7JFTZtn6guxqcKncZa1xCQfrdVgh2SsrXPnMsAABG4piq7Oyb3NeCPUBKP5IKXuq8NbJl3Ehk2rZa03KrsgkpkdQP5ryqDJV01w2M26Uaa0RI/D3BHV4uoFFvXRYJ5FhfGdTx2ifOMdK8D57ZomAEYmn1OBzMdNPMlZrHSTa3PVkY0L7pMX7Y4z/PFCTbGGzgSis62XbBye6XZfbjeaDxgkZrxl5L+Dgc/EBMPXuG9VgGO8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U/ReE0tyP1bx+UOu+SBdUkxBDPwjrQmVyiw76K/p7s=;
 b=Zro3BkErszc5tKW938UppK+I14WZRkCt463gafuzNMNvNSZCcSe6fx7hiiJ0F/AzbgCCzTbMwPVp6+Q61jdElYIYi+/jEjJh455YDynnw2LY1rzcUPB2cLvzVTqdSvJ36hUutPsEE9x249xCWb8arJNkqRBrKX9wNg4dUqnEhseHqtnfXEXx1jp62CPVvVpFsIcDNqQiIAgziizYbW8VYzyHIyEA3sgykKn0rV6GqLiI6SH7buH3ESE6x6/+5ldFdxVByaHJnSIVMw8i9bsCDQTmXVGIJc99uV0YE/2y2PaRxRAJsTqgj8YwjcFpHwlTjDjAfW5nWXlo8LLR4FoxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.28; Wed, 9 Aug 2023 08:48:24 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::71cd:9328:e4d3:d104]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::71cd:9328:e4d3:d104%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 08:48:24 +0000
Message-ID: <c987d5dc-ae21-8fdc-3037-ad05c44742dc@intel.com>
Date:   Wed, 9 Aug 2023 10:48:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/4] ACPI: NHLT: Device configuration access interface
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>
CC:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <robert.moore@intel.com>, <amadeuszx.slawinski@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
References: <20230721154813.310996-1-cezary.rojewski@intel.com>
 <20230721154813.310996-2-cezary.rojewski@intel.com>
 <ZNMdertpWWvoAJM3@surfacebook>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZNMdertpWWvoAJM3@surfacebook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|DM6PR11MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dd74e5-34d1-4a80-7407-08db98b5642e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bw4BaYDuNMESSYtr4MDseyDxe9cTmXDRZnl4Eo39/ldtha/4Ej91JlbWMaNwy66Nge3vGCEE+m5MYAj90WgBG47s/CIXtH9s8h+LydaoyR3N8/6ey3GyIsNZoqcz5v+egzQg7OcMRNKu+vrQNMuvniv+87pqflNGk5u3rx+fAHsMU9JSPYNzE3+tECYbcI3sAMEKm9b56wFrr3J1B0iKAtVtSGwPWOCnW13wX89Eosk5N/vsdiQQ980D7UwL77w3IFpVTmIxUv4soRZT44iBjdxPeUNGWiwXx8hOqTExwABmdwlVCZle2GF8yfqLwwmOJGNotIV8LEgo0LmWF++heOzxxy19p/P1dlkLukfydv2q7ZwQU+zD4t0sC7mxU+RYYzqvwB93aJWRNjvQo9ztGHM2w6mmTmkAHlvFRs+LyC6HWfXj2W8stRpXsqs+nQSUQCFC2/LGFRHCcdOVjvZSjsLRrRPTU/q5lS+YpgEBeNJWFHtEG+xD8Ur9dU7au0Nt3WAE7e7KNCY2emU8OjBFQs75sJYFiQfCbFUvnmAexfckZFnbYeywocaNfMr5i7uweFnhuvDRlciRrqCQ6R8wdlc2vTN69dT+X+I/C6cfvgp49kSBRdkx7OQBhndmJrfIF6zE5rTN6jBM0H0Ri54Xcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(1800799006)(186006)(451199021)(4326008)(86362001)(31696002)(66476007)(66556008)(31686004)(66899021)(6916009)(44832011)(8676002)(2906002)(5660300002)(38100700002)(36756003)(316002)(41300700001)(66946007)(8936002)(82960400001)(2616005)(6486002)(478600001)(83380400001)(53546011)(6666004)(26005)(6506007)(966005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJBRzMraHdVUzdya2xRdEMwaGNNMElId0ZGRHl4eWpxdTBXazVNU0s2cTJI?=
 =?utf-8?B?dDZvbDdHWkJiVmRHZXppeDAyV2hYTXArUnhkRmdGWVMrTWRQMkFubGY5YXhk?=
 =?utf-8?B?UzFVWlBQRXJEQ1hQWlJ3RmtkTFZzMXQzNXlmZVpKSUxZaWFWRUVBYTVDTFUx?=
 =?utf-8?B?ZXk3c0RhVzdwM3ZaSWtyK0VFSFVRMGVabmlPcERtVi93Mm1xbUdsc0pscjZI?=
 =?utf-8?B?MGZYSTBOOGlJSjlsamVUK0ZGSXJESm1aUWNMMGdsTWs3dGVoUHhYVmJyeUlC?=
 =?utf-8?B?NGZoODloSUVmRE5TOFcwem1nQnkxaW9HcEhRS3g1WU4ybjRiZzZ2ZGFINGNY?=
 =?utf-8?B?OW1oOExFUGxzdnZNVlZjWnVGb0xXMWJ3OE9tSWIrSG5TTGd6Q0lOcmVRRHFx?=
 =?utf-8?B?bEZRN0VPM3NxZHp4NlVnMGo3U1k2Wm1ZVWk2THlkaTV4UVhoZ0VWV0VFeXVE?=
 =?utf-8?B?RVJzOWxUQU5sYzJ5UHNzMS9ENmlrNTNhNkNWWXZvRlRHcEpFd1IrYnZXK0Fa?=
 =?utf-8?B?eGQ3bEdoUXZiQ1FWdVlUOVVYOWlidHdyWGNndVdIQ1c5VVIzRU9BNHI3bVpC?=
 =?utf-8?B?aTU2STlscVJ4d1FicThmRE1yMVZ5SHd4NkRWSzJNMi9NeTVCQkE2REx2aDVS?=
 =?utf-8?B?bzZYRjdyWFBIR3piWjJTT1hxTlBtcE94Sk13T0U4Tzg2dXZmZEV6a2IzSU12?=
 =?utf-8?B?TlRFdzUxRWs4MDA3eEc2UjUxZFVTMlo2ckMzMDBCZHFaY1dpTHdZNTByS201?=
 =?utf-8?B?Ui9Wa25rWUR5bVdUM09CTFhmQklPQTFaOVNjU0dsY0dlei9sS29Ibk1KdWg5?=
 =?utf-8?B?MW9kY24raHdsNndPK1VnZzJXZ0ZuV29KSkNTcFZqa0VEY3FlbHZHcFVleUd5?=
 =?utf-8?B?eVR6M3ByVW9ObUZrbVIvU0hqVHhHa1RUZFBCcFg4c0NrN2wxc0xYODJZb29Q?=
 =?utf-8?B?cjZ5Y3RYYlBCMmhQS0F5T2d0MGpvTlA5VGVkMXA2R2RJbzlHRlVkYnF0NWcz?=
 =?utf-8?B?cE1VR1BiRTRZVHdKbkpJVEtMbXhWK3FYanp1NTF0d3FUSVdSRDhyWmtMeGhF?=
 =?utf-8?B?NmROMmMvZ2x1cWk5c2lZTmx1OFR3SGphbUoraWNOZFdLQjcyUitQbGZRRmhI?=
 =?utf-8?B?TTg4VkNVck9jM1U3OFpRSnZYU0R3R1RzaDR6b3BQM2JXRDJkTTNseDZFQkZL?=
 =?utf-8?B?OHhiRGFjNDIvRk1qSVJPeHZvY0ptemUrT1VBczRrbWs3ZTI2ZVl3dThiUk9C?=
 =?utf-8?B?cUhNL2tOd3hGVHpDeHBEOFFNQ0NjRDdoNUt3Um03UGtjM1dNME1ZZHF2NWlv?=
 =?utf-8?B?Z1ovVkNEYyt0Y3EvSFZnRk1xbXJ0UXpCRWlLb21QMldkb081ckMvZHNQTnh4?=
 =?utf-8?B?V25IV2daVjdhdGdZTkFLTnNiNnprRnd3dXREZ3hZb1Z5SUR6aHJiUDNqNkVu?=
 =?utf-8?B?NDZmNVdtakhSWGNlREJ1MHNxcXppU2I5RVNtY0F2T25nQmZmRURVV1BLZ0hW?=
 =?utf-8?B?aER0SFRjOVM3SThwRVpPV0RVT3gxUlBQT0NiRUY0RnNrVzJpczlQT0NjQ1Y0?=
 =?utf-8?B?Z3VoUU0rUEFWV3o0RUpEVW85M3lNdFp2dm1JdzUrM3hidjhUdU9lK2FZd3lL?=
 =?utf-8?B?a3JSeEF6MmRTQUpZQlNld0FPTm5WaWhFNGFEZTM4M0dxUUs1YXpwaVhBcmlX?=
 =?utf-8?B?YktvcjJkWU9jYTdFZytpT3VqSXhiR3V5eHJoNS9FRzdYRWFjdGwya01SRXBK?=
 =?utf-8?B?Z2EvTENvcGlVUXh6MmVYV0NPeStQNGNrQ2xEcGVCVVlBeGF0NzBQbXA1Vmpn?=
 =?utf-8?B?ZVV5aFNtcFNpaTRnV1QvbUdsVEkxTnZkNTNsVkx4THFNZklaQ09SMW54Ykpm?=
 =?utf-8?B?UFpxaWRNZDZmcVBLMkVyY3NzdWVGK1VMa2IyV0cxNEZVY0s4STZQdUl6dS9i?=
 =?utf-8?B?VmhSSHh4VDJ2cC92bmFvSW4rUVRoVUVEamJOcEZqWXh6R0RqVnhsV0VtSnRQ?=
 =?utf-8?B?RFRNZ2RYOGZRNzNKRFQ3bkduZUNxYUNGMk01Vmc3Lzd3L3VQZ2pmcVJXYkJh?=
 =?utf-8?B?bU9EdDRkSmNpMUtwSnJPWUxrQlRwdGJpYzlVVG9kakxOMEtlbmdJeURhV2V6?=
 =?utf-8?B?N1E1WWc2NHVZekVaZ3IwS25FOWZqTTZ1RkpEZ2UxQ2I0ajMreEdtS0hKVTFD?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dd74e5-34d1-4a80-7407-08db98b5642e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 08:48:24.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vctN1StJzh/GGX4UiXFdZfhME6aYTkWy33YhkoqGxfXZkprgqVYzSHnHLkrlihR4X1nt92A6LPJAe8GhS/qm6EfNj/SEa51TGA36ZoDSAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-09 7:00 AM, andy.shevchenko@gmail.com wrote:
> Fri, Jul 21, 2023 at 05:48:10PM +0200, Cezary Rojewski kirjoitti:
>> Device configuration structures are plenty so declare a struct for each
>> known variant. As neither of them shall be accessed without verifying
>> the memory block first, introduce macros to make it easy to do so.
>>
>> Link: https://github.com/acpica/acpica/pull/881
> 
> Thinking of this over night (as I replied in the above)...
> 
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Sorry, but seems I have to retract my tag and even more, NAK to the ACPICA changes.
> 
> I have thought that this is something new to the header there, but it appears that
> it duplicates (in a wrong way in my opinion) existing data types.
> 
> Existing data types are crafted (as far as I get them) in a way to be able to be
> combined in the union. In the similar way how _CRS is parsed in DSDT (first that
> comes to my mind). Hence that "simplification" is quite wrong in a few ways:
> - it breaks ACPICA agreement on naming schema
> - it duplicates existing data
> - it made it even partially
> - it is fine and correct in ACPICA to have long dereferenced data, again see
>    for the union of acpi_object
> 
> I trully believe now that the above change in ACPICA must be reverted.
> 
> Again, sorry for this late bad news from my side. I have no clue why
> it was merged, perhaps lack of review? Or anything subtle I so miserably
> missed?

First, you took the review seriously and provided a ton of valid 
feedback. And your reviews and expertise helped me grow as a developer, 
so from my perspective no need to sorry about spotting bad things late.

Now, I admit, a bit surprised given the number of revisions and age of 
the initial patchset. The cover-letter, attached for each revision, made 
the intentions clear. Our goal is to help actual users of NHLT i.e.: 
audio teams. While part of ACPICA, NHLT-code is hidden within sound/ so 
no one asks questions. Leaving things at status quo does not improve the 
situation. Thus I believe simple "no" is not an option here. To make the 
code better overall, relevant pieces should be made part of drivers/acpi.

Original problems stem from the fact that audio teams were not looped in 
during initial integration of NHLT-code. Turned out that no users 
utilize it in its current form. The problems are subtle, but a 
discussion wouldn't hurt.

To avoid double posting, should we continue the discussion here or in 
the PR on github?


Kind regards,
Czarek
