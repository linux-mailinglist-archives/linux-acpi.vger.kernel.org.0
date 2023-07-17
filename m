Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A939756185
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGQLZ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGQLZ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 07:25:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BDE4F
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689593144; x=1721129144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nsNAGxTexPTecciss3sLYt7Z8CToLCia+mhJgt1DaU0=;
  b=jC5hGDmiUZxhGNjRDMlL7iQs27KCIrqViIlkSVC+SygYh8hTZEdUD4/C
   Gdp9lUkCNE8mSvrzk2dOIKYrx06FoKub7s5JYwaJ/1fQmyt0Xdgf0V7MV
   8ymBh+mk/oMNyOVrv1RtvPEZ8x7Fcm8HC73x8sV55cc1YL2IiEzFGifOK
   rIkOmXrq7adE7QN+N9sbLoanrJE6gcpP0BG1TBjosGF4ozkQY9OThDXiD
   4jZtoJek2bzcjpWDbheaCADBAM1KEsAoHDlk8vRiaYUb0HauCiFEX5S5f
   1Ric9hrfxvkBv81R5xtm/IMBxqYTXeWd/+GlhS4wze8gjoWtSPXUK2T57
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432073633"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432073633"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 04:25:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="726509911"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726509911"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 04:25:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 04:25:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 04:25:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 04:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAzx+k5cSspYkQdFe8z2wsTDS35dhhnjKKrFeWTgbNBoztvSWgvaEsRwakyP8eWjILO9l8Ik94tUYfvs8h6jdBVi5pvmU3oIAp+CaQDW53cSQjffJ5x2h/SCYA4hTKUjTJQOfusJ0d2l5bZfKI/afjq/eQH6tC+S6ic4tdpFf+gf+obi5jwqOmiZInjXxJ9n6YQV87C6Z94pcgIXi69359kn2iWmp9pH4BnKjilpbbH1IHx/z2J0x1awERS1fk+p8dFAyBlSK5LHGoh1ogmp6lurCHXiSCqj2eGYwupVOkhWVvMnD64UtsolfoymLLhgotVmS87AX6TQ3o5Rwtx+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iw+IfW436NxvbGNYltZgSMPQ26megb89PsrRw2TvVc=;
 b=Wg9VgTs90NaPbBRyw1saqRDN2UAUGnKMpjHiOELgshCXJL7sBYjfUfuU/O9Zwue/8OT/iw08tG3G3HnasWwqlBU8fXd7O23kU7y9XPJSmMdY418XtaKq89RVpNp05sXL6GaAkGky3gMVlpnhiVonl9UqiOaBGSPszEuw8lhtgd7vVRJ4x7egjW0a0uhgkYdGGleWbBh6g2tK2Cj61Q42gtJVzE94bR7y+XVPCZPFHxP/osNdrVslF2kufcwTUse+i/rxWyrXtghIkm7GvbetIa/tq9ZJb3BqsVyarVCPU/4DO8nQtl1YnHRJy+B8n5eLDrF9dUVF54vWb/so66MQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 11:25:40 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Mon, 17 Jul 2023
 11:25:40 +0000
Message-ID: <7c7b5573-0533-3129-510f-d46e8ff871c9@intel.com>
Date:   Mon, 17 Jul 2023 13:25:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] ACPI: NHLT: Add query functions
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <robert.moore@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-5-cezary.rojewski@intel.com>
 <ZK7LadhJSBjJUNqs@smile.fi.intel.com>
 <3544e8dd-874e-4b26-cb37-04aad2a8332a@intel.com>
 <ZLUOTiLGE4NFAdnD@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZLUOTiLGE4NFAdnD@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f27ff1-8d85-4a23-8d8e-08db86b88cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmgwQQDTDUQP36/X7eTzzKPdbMi7cu++ot2C4JJmw/I3rBJwpH7q1IlGatDMSKwDwG/zPwBi9NCDnpyLyua47cDlSTb/PkW/rEUW3R5AtaIvAajJrIzOWsqRDn4pXVWENuCPvW5MedpZoOylDGuNA3zXx9PeTq9WkIdG4zUEbqpeid+tB/F8z6rUI51edjG88mvV8E9Sp6qvX47HHBxubMKFWrJijWQi4j/ML6GbNxGBFMRsHmtXVz11/qTEOeHCGCk8CqBzvSf0w7ouObCiSoFoXBbovwPKjr86DrPblG6mavkZevWfXs+DcqozU1OgmHNmppF2kvVudqb3y4+1J4gWODAUtcnazAvRZl1jxjacglpfP9SxbXTtjpvIDTpLBnsFpOFvqNcGnPBnGX6+bzX9Vwbna/FrMIIg0T58eQWjPOzn/eeaO+5NM5x/CxJ5foT0mu/CrajqSGyw7TXE6yfVTMZ4+M1nle1dIYjR8RtrH3T13dBDDY9F6EWznC/hC7hH5iHmbRKLmtq4Te2QaA/qJGCBMYm+fNS1/nusyhZv8T7xZYRGid1lago1t2jDtkERkg36jF1sZXC7jKmFV7O2vqe11bxZ2QoKnEMX2saTTZVs5uH1ZQaq1D2C3Xk0fqi37SaF5VLyOhuG6vVQsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(82960400001)(38100700002)(6486002)(6666004)(41300700001)(478600001)(5660300002)(8936002)(8676002)(66556008)(66476007)(66946007)(6916009)(316002)(4326008)(2616005)(186003)(83380400001)(6512007)(53546011)(6506007)(26005)(31696002)(86362001)(36756003)(44832011)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JKSHB0d2lheVhYSE1oUXVvcTByaC9tTG9mUmROTGgwN1R6dEJTd2E2eGVq?=
 =?utf-8?B?UDFIZ0ZEanF6VmZiYm10L1hKbFRnaldXSnlJVk0rYVNFNXp5ODhmeG5LTmZS?=
 =?utf-8?B?cVNpWWlWSEpsNFMxTE96RUV5bVZyZmtUc3Y1QU9jS1k5MEU2bDhYZFA2ODVs?=
 =?utf-8?B?ZHhCL0M0MFJYa1R1cVR3MTd3MWlicFoyTHBFSzNjaXZNaGovZE9sVmNDRW5I?=
 =?utf-8?B?KzE5NG1DWWpNSURpY1Fjd2JtMHBtR1BoU2ErUmxzR01BY2l6b0tYOWlPWTFp?=
 =?utf-8?B?MEwxdGVaekNxT1ROMzJ3b000emI4QmNLWi9UUEtUaDduV1BaaTdtbUVUSmpv?=
 =?utf-8?B?RmxVVDJoNG9TNUJZZkwvTDdrdHM2ZC8wRGxCeHdockxEdnJSbWQ1cThYb0VC?=
 =?utf-8?B?ZTU2R2JUSlZQODNpWlpsK1lMampaNThDK2sxckdIaDBYNk91VnZOVG01Zkhv?=
 =?utf-8?B?WkdXZC9odk95cTJSMXExZ3VUclVyTFdCdFdiQ0swRzFsMEJES25LbCtOczA4?=
 =?utf-8?B?V25KYnRldFBabHhBTE1pSzE4OGNFY1pQQjdmTEdKZUxiWDZTNHhhRE5HVDJt?=
 =?utf-8?B?emI5Ylc0Ri91N1lJejBGZXVCTnV5MTd4QWQ1M0U1bnRlV0w5S3l5VEJaVTBq?=
 =?utf-8?B?cjhxT3lZOHNjNTVEdWE2Wm1CYmtuQ2hjekZkN1RLaHZkUGtOQmZnUE9xV2tS?=
 =?utf-8?B?aXROSVA3S0xkNldXcFlzamtIMjlqM3l5QkZrYTJ1Nk1ycWk3YWdacDhNeDhT?=
 =?utf-8?B?Z2ljV2dvMUdaZDBhSFF6WWh6UVR1K3VYUUUxQlBrUEd1ZzNvRVlwcWJYTC9u?=
 =?utf-8?B?TW1ac0h1eGpzVEJqcmpXaFZIWkwxazVSTGJlUTNwWnc3RkhaY1hIY0tCSDB1?=
 =?utf-8?B?WFV6bjZhYWxFK3VCZjVGUzRaYjlYNkJCWHVnTG0zOFZOTktoODFKYm45Sjhj?=
 =?utf-8?B?MllRb3I4Nm42U1VucDVQVEtZMnVyckl5bWJLMWN2SjFtY3Jjd25kZlovN0R2?=
 =?utf-8?B?Y0x5b2FYaDZnR1d2Z2VEcjR6Y2N3SGpKTjJwUHNpZUV1MGhSek9ybXoweXcw?=
 =?utf-8?B?dDB2b0U1SS9kK29xdXJzSmE4S1BLM0QwcDZrcUcwSzM2b2xHRjIwckorcm9J?=
 =?utf-8?B?QXk5SzZoNnY2cjhVQW95d1VGbUJvaTRaWXJLZHh6bmtoSWlRMDhsdExOakQv?=
 =?utf-8?B?c2swRU9NMVJBQmU3Y1JlM1JKKzlJejJzMy9aOHBpMkMyV1lPc3BqcVMxVGcz?=
 =?utf-8?B?Z3VETDFRQVBFd2g2c1BDaXlvYTQ2alU1dk5qSThVZmV3bTdMUExROXM2VTEv?=
 =?utf-8?B?cWpNZmdna3VnNG1kdE5DamliclZmZlp6Sk82Umt6M2o3eUtKMU9KaVU1aFpK?=
 =?utf-8?B?bTZlY3FsMEVnNmhkWGZSOXVSQ1dWOUhWTDRIb2VwUTRQTmNPRHdBeGp5SzZj?=
 =?utf-8?B?SEJCZmZQRzk0Mm93OCtwUmV2ZE5zdHVpUXNvcmgwamQycE5ORUVjcTRCNjVK?=
 =?utf-8?B?cnVBUVdyNWh5eXIwZkx0QUI2ME9zck5Cb3NOd0J2RTdoVEpta0ZuaFpKUW16?=
 =?utf-8?B?UmZiVmViQXp6RGwvWGZhanJmZEE0U3J2MHJpK1RINnBHcTFDbWtpYUFXQTBO?=
 =?utf-8?B?MmlQMlo5SVJOaUswck01ZmJuTGJIeG1VRm4xWGVtTFN3Wno1L3hoNlVuRDB0?=
 =?utf-8?B?SGhDR3B6eFhNRVpibnB2K3k2NVB4NSsybW0vY2Rpa2kzNlhwQjJrUW9ubmg2?=
 =?utf-8?B?bzZPKzRsYUxscFJFUzBmQVk1UVBJWVVYeXVHOUJPaHVmMkZnY2Uvbm5YQWtU?=
 =?utf-8?B?bFdiOXlPMW1NTm9YWEZVa1hWYWQvR3FhSE5oMC81TDF6M3BIR1oxTG9wc0xL?=
 =?utf-8?B?anlxT0paWWIvS1V1MmZaZkEyNXZhTGF4Rmw1QUVMM0NRRStVVThBMHJObkJB?=
 =?utf-8?B?UXJvd3p0M1RBaGpRc0pCZWJ1UDMyelRrdDZQcitRNEZMSmxEclJPdm1ZWStW?=
 =?utf-8?B?U09KczBYcFhMRHAwZTlIRHBndExNVm1WRDA3a1UvREpuTXFQdldaWkhhK3o0?=
 =?utf-8?B?VUVsMEdkQ29BMHFmdWFUeUdNV3h4T0RGQmZKeERmVXY1d0VpbDROVXkvTWlJ?=
 =?utf-8?B?emowdmN1SWRnZ0xoQjQzUG15SVFtU2VmZDdJZDBHc2NTZ3dOV1UxS2l0cVBZ?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f27ff1-8d85-4a23-8d8e-08db86b88cb1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:25:39.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvmF/D7PfCKWJ45y9X1c6hyAEMxmttwZILmrLsqIRyJ6HPpe8ZNmVZUqja9oFZQZzECeQKfo62tvEvlRhdz9Be5eYo2SOAxI7hG8TaAB4JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
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

On 2023-07-17 11:47 AM, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 10:29:17AM +0200, Cezary Rojewski wrote:
>> On 2023-07-12 5:48 PM, Andy Shevchenko wrote:
>>> On Wed, Jul 12, 2023 at 11:10:48AM +0200, Cezary Rojewski wrote:

...

>>>> +	return ep &&
>>>> +	       (link_type < 0 || ep->link_type == link_type) &&
>>>> +	       (dev_type < 0 || ep->device_type == dev_type) &&
>>>> +	       (dir < 0 || ep->direction == dir) &&
>>>> +	       (bus_id < 0 || ep->virtual_bus_id == bus_id);
>>>
>>> I think you can split these for better reading.
>>>
>>> 	if (!ep)
>>> 		return false;
>>>
>>> 	if (link_type >= 0 && ep->link_type != link_type)
>>> 		return false;
>>>
>>> 	if (dev_type >= 0 && ep->device_type != dev_type)
>>> 		return false;
>>>
>>> 	if (dir >= 0 && ep->direction != dir)
>>> 		return false;
>>>
>>> 	if (bus_id >= 0 && ep->virtual_bus_id != bus_id)
>>> 		return false;
>>>
>>> 	return true;
>>>
>>> Yes, much more lines, but readability is better in my opinion.
>>> I also believe that code generation on x86_64 will be the same.
>>
>> While I favor readability over less lines of code, I do not think splitting
>> the conditions makes it easier in this case. Perhaps reverse-christmas-tree?
>> Pivoted around '<'.
>>
>> 	return ep &&
>> 	       (link_type < 0 || ep->link_type == link_type) &&
>> 	       (dev_type < 0 || ep->device_type == dev_type) &&
>> 	       (bus_id < 0 || ep->virtual_bus_id == bus_id) &&
>> 	       (dir < 0 || ep->direction == dir);
> 
> This one definitely better.

Ack.

>> In general I'd like to distinguish between conditions that one _has to_ read
>> and understand and those which reader _may_ pass by. Here, we are checking
>> description of an endpoint for equality. Nothing more, nothing less.
> 
> ...
> 
>>>> +struct acpi_nhlt_endpoint *
>>>> +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
>>>> +			int link_type, int dev_type, int dir, int bus_id)
>>>> +{
>>>> +	struct acpi_nhlt_endpoint *ep;
>>>
>>>> +	if (!tb)
>>>> +		return ERR_PTR(-EINVAL);
>>>
>>> Just wondering how often we will have a caller that supplies NULL for tb.
>>
>> Depends on kernel's philosophy on public API. In general, public API should
>> defend themselves from harmful and illegal callers. However, in low level
>> areas 'illegal' is sometimes mistaken with illogical. In such cases double
>> safety can be dropped.
> 
> What do you put under "public"? ABI? Or just internally available API?
> If the latter, we don't do defensive programming there, we usually just
> add NULL(invalid data)-awareness to the free()-like functions.

Thanks for explaining!

>> Or, perhaps you were discussing return value here and ERR_PTR(-EINVAL) could
>> be replaced by something else or even NULL.
> 
> I prefer to get rid of those.

Agreed.

>>>> +	for_each_nhlt_endpoint(tb, ep)
>>>> +		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
>>>> +			return ep;
>>>> +	return NULL;
>>>> +}
> 
> ...
> 
>>>> +		if (wav->channel_count == ch &&
>>>> +		    wav->valid_bits_per_sample == vbps &&
>>>> +		    wav->bits_per_sample == bps &&
>>>> +		    wav->samples_per_sec == rate)
>>>
>>> Also can be split, but this one readable in the original form.
>>
>> As order does not really matter here, perhaps reverse-christmas-tree to
>> improve readability?
>>
>> 		if (wav->valid_bits_per_sample == vpbs &&
>> 		    wav->samples_per_sec == rate &&
>> 		    wav->bits_per_sample == bps &&
>> 		    wav->channel_count == ch)
> 
> OK!

Ack.

>>>> +			return fmt;
> 
> ...
> 
>>>> +	default:
>>>
>>>> +		pr_warn("undefined mic array type: %#x\n", devcfg->array_type);
>>>
>>> Is this function can ever be called without backing device? If not,
>>> I would supply (ACPI?) device pointer and use dev_warn() instead.
>>>
>>> But I'm not sure about this. Up to you, folks.
>>
>> Given what's our there in the market I wouldn't say it's impossible to
>> encounter such scenario. Could you elaborate on what you meant by "supply
>> device pointer"?
> 
> In the caller (assuming it has ACPI device):
> 
> 	ret = acpi_nhlt_endpoint_dmic_count(adev, ep);
> 	if (ret < 0)
> 		...
> 

Thanks for explaining. I'm going to kindly disagree here - dev pointer 
would be here only to print the warning. NHLT is also independent of any 
device - even if its present in the system, one may not have a single 
device that utilizes it. Worth mentioning is fact that all other 
functions do not accept such argument. Doing so here alone would break 
API consistency.

>>>> +		return max_ch;
>>>> +	}
> 
