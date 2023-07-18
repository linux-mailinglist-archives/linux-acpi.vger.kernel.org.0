Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69F757A30
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jul 2023 13:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGRLMl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jul 2023 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGRLMj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2023 07:12:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33019A8
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jul 2023 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689678738; x=1721214738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dwW8xToCw9q+if+ME7QPdoIMrbu3p1e/T1zNhEvvtog=;
  b=Ezx5Z/zZd4rN1CG/pFMDM8hvNe8Apnyo/YUtNJs8uAyPtYwO8s6z3cs5
   D4BYGuk6UDE5g/eqkoHc3mUiocHMCU+2EqHwzlZ4VjOtfAgYVRmmTX1t0
   lrNXRvgKRbLv3XW3odws+Q1DBhjyiDI7saf+2B+ksdmccrpYrVdIaxEKu
   SJhSEs9RMhwtUVSxbyap3IWipxZUYdWEhJtRAwVhe2mRwoQQoIzx2T37N
   QYjWP72JtL1qZ7hszQGmSgM7OTnxqSaFPm1HhopirZcEAeKF6DucbGyEG
   xd5P6I2o7eBHq5/zW0WCLokQXeRhqUdppuGNLplrDNJ+1Iii1aVl5kMcH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366218051"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366218051"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 04:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793591923"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="793591923"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 04:11:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 04:11:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 04:11:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 04:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3GlpoUUIJ5Hn93IdqBgF+Hi75RYqzHXRPiA4wytVCMuxFYgqDpbOP4OWAyqIn5MT+mlqyCWR6+epC/vBo9Gk1nQIGGs05DCRJiYrc4CyIOVT9vNfXkmHT6LlgObeZoT0+SOpGcRCe+lDZ0z/Skg/TOuJO+FI11fIU67FCmiRlcaWIprzMb6NtxmaOSpRcb/97V5+SoZJiimZaJ3/jUn3te8gCMjaAF5HjZKg+U61WPrlQ9JomdFYQpG1gB2YxpQt+UjcPAYLwaDcfXa2Wi1hYiJo4WVH40ju9g5/gNqDtCRHlletTu/pECwL5OIGKm50Zxhc60hRYNmsEsv+OkZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22LvSmnm2UpIenmKIF6IGcpx594Cf+IJw/FFQ61O98o=;
 b=NSbS9i/I4yidji4o9CAinKNBDujditRDU/YurGlQCunKhsey85GzSBI4obc1fYFsI8FbiiGaGfzc5V8srzdDeKBmYZZPHEtiNQEmNnjs8RQRR6AMDoeJETVe4Rf5z98omxejZZkpLzc8qV59p3FwA1TrIBGez3HLXpEFreLA3YysfEgDwniwG5OHfS6brMdaJ80EeffHW+f/EQ/YMj7B49kCS9ITCc0Nbd6D2Yrc7LzMY8mpVn1OlkuUZl44Y6646neQQoUtwaw4U5MhadTvbKZChKPy4qxJCD8QpQoM2S+bAwJ8wcVpPyX8XZex+UM9vGCiFqH7vIbm9tptZxlaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DS7PR11MB6101.namprd11.prod.outlook.com (2603:10b6:8:86::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 11:11:09 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 11:11:09 +0000
Message-ID: <395ada91-9560-c001-c1e1-4b441ac9b7cc@intel.com>
Date:   Tue, 18 Jul 2023 13:11:03 +0200
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
X-ClientProxiedBy: BE1P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::8) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|DS7PR11MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9c5b6a-d0b4-4487-a7d9-08db877faffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qp1i8BCzMwzn4iCYj1f8xVznuzMUCnGQTqvDJG555JjIhIX5/3y41ktYfCwpNFqbWks/OkI6kRPE23mtF5l7AghawmUXzWSpLldF+0brQjR5M15qd2LXRNeBygRivL4So3NAOy00HZQIiDoLxszI7sCSXxpjhokpKH7c/HHYoS+rNap7EdUTWuRwGg9UtEtbUo5OVT29GSQi4Wh5URAFT1VI7T2OZ2mEpTGcaEzAs03tuqHlVk5JK/bBfSMf3hC/g9GXswE0SY/bEZ4y80asfDYewFl8C5XR2w/BsPm9bvrcIYMNPDbqn44xsNsFRuGvFW0o+w26MB8oCW+9Adhs6EysZUL8QixbGmkFL/MKDlLtU4ZmiVunqFdQVvrI9uQyCyN3mGOSaf2BxcOtkcw2cI1VrIFATTCthHp8NypkqftIda33vdtZiqbpB8lbEODQKI4r4rvjb2BUGgT8usRP24arSV+WSoY8InDTXB35WFTSCN+MiQq0B8tgx3H350EG57YSU5nJL9WFgoSfutd4hmrSXeXygGVC6Y5qF5szLVwnAYFrtlAB/4QfxBIUuAUKUJYhPU6Csh1wElAkF5vF/fwKt/L0J7HVucdieVdwBhK9w/UGSOyEBDoTYVACqyK+C9lygNUbjy+oQ4K9BPHcFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(31686004)(86362001)(31696002)(2906002)(36756003)(44832011)(2616005)(6512007)(6506007)(186003)(26005)(53546011)(38100700002)(82960400001)(6486002)(6666004)(66946007)(4326008)(66476007)(66556008)(6916009)(5660300002)(316002)(478600001)(8676002)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxUcnhuZFN1MzNPenBoaGU5RlNuQnpIcFRmOVNzQ1FqSG9TWnBJUUh4MnB4?=
 =?utf-8?B?MU1ZUWRDODdMeWdaQUdLU08wRkwvQVZNWldrbVkveFhBaGVnN3ZkVW52Qis2?=
 =?utf-8?B?aHdsN0pWVEhGbjJZWlZDV2diRVJQRmVBSGpyZ253eGVnVGdBWkI3MG9TTVBO?=
 =?utf-8?B?em1YVlVQdGI0OTdnNnd0SWRmZVJmdjBCNEo5TFhIWngxbFZ4bFJMeTl4T2lU?=
 =?utf-8?B?SkVhb0IyWjdpcVpLNmJ3OXBNNkhkdm9pZXJuRnJ4SXYyRkpyUTBVQkxkVTJY?=
 =?utf-8?B?UzhpMENNOWIxMGRjeDg1d2N0cEVyUERKSjh0U25GMks4OEc4MmJBb21zcWZl?=
 =?utf-8?B?dFYvK0pIVEZDUG5BQmV4ZzNmNVBKR0NLdXRJdUxXYnFEeDdZMmRyYm1BUm4r?=
 =?utf-8?B?OCtFNGdlVkdrQ0xudGxoTDVHQVJjTmYwb0kzbE9LNVJIcVRMemR2bkZjN1cv?=
 =?utf-8?B?NS9JZnA5QkV6dHdEaVc1VDloYzFtcnpFOU5lZjc1d25wK1FSSkI1WW1jNVZF?=
 =?utf-8?B?SDNZc2dNcXRzdWwzYk4yZ1lwazA3NW4vTUxLWTNhQzF2bHlkOW1KNHo2b1F6?=
 =?utf-8?B?ZDhsazJ6WkVITk1Id3ZkanlUUU5jNkM4QTFoYml2NS9hcE1RWVZzL3ZiaU41?=
 =?utf-8?B?Vmw4TlZxK1EvcUd5OFJ6TEpPR2E2c0ROeXFCNWoxSUdvUkhZeU5wUWNObzJs?=
 =?utf-8?B?NXNqdVZqbXAvdk9BeHlKMDNrZmp5NW9hT0Y4Uk9TaUIraFVPMEJRZUtwVnUy?=
 =?utf-8?B?WmIzSnF1ZzgvS1hJUTJiSlFESDRZZk1TVU5GNDV6V2VJRzE3T2Rac0U3K0ta?=
 =?utf-8?B?bDhwdGpYYVFuNlREVWVHcE1rRzhhaTBJUWR6U1RpamlJTE9COHhJWFc5Zndx?=
 =?utf-8?B?SHljSUpsQUsxdjl0V1hWS2xzWXJpZnlHTktYWWxFMk5VVmQ1VkdnNnhNT3Ex?=
 =?utf-8?B?OXdMM3I5KzR2R1A2TjlPS3FyYVlOV0NmN3d3MHB3cE1rVHJuK0RJVkZMYUVz?=
 =?utf-8?B?RENRdkVCLzRCSThORGo0cFhpZUJGOVpoTGpsRlMyQXRnOW8rUmNrSStaUmZB?=
 =?utf-8?B?MXBwWE9CM2ZBQzByVHV4N1c4VFpNUnpNRFZ5dHpLT1NERFFRUzBDL3JhT3Ns?=
 =?utf-8?B?RlMrdnVLaTNuQUczcms5Tm5wQkxUMkhhRGE2akRGdTltbVA0bjBZeW9MZVBV?=
 =?utf-8?B?ZmNlcmpKdmNmQWNwSnZ0eG93Snc0R3FMczNVYjRTQ3NmdklZMUs2RjFmSEd2?=
 =?utf-8?B?K3EwNkh1MldYRnZPbXB6Sy90RGwxbDJiWjR1WndOWXByUUNOR2NTVWE1c0dN?=
 =?utf-8?B?dGJjWnRzQWpieWRQSkJTc0RTUVdzTDhGa04vbjhBZW1PVXRrMlRxUTU3RUVv?=
 =?utf-8?B?K3lvTGF2R1ptbFQ3Z3JSWW54N2N6cFhzTXlYUTZ2aUJCeW9ZOFp6KzIrUFlY?=
 =?utf-8?B?WUs5QTMzc3p0bHNZOGpKajhSVERlN2E4YU9BMzQzWFRXWjV0a2xld1F2S21V?=
 =?utf-8?B?dDQ3NFJLdFZpTENZR1F1TldFQVB2Y0p3aDJOVHVhYjI5aWdvSkJpKy9CRVkr?=
 =?utf-8?B?QWdOYU9HQ1QzT3pPalZ0RDB6UFFIQmUxajdPVXd4Mkg5Q0pMZFA2U1hwM3Ez?=
 =?utf-8?B?UzlaY2QycFdqdDRiUlFJVHpJNVFTQkdtV3MxZTFwSEZxWkR5Uk1JdHJRYmNt?=
 =?utf-8?B?UVJtQSsvMXBXSjhiUGNwTTE0MUw3K214N1NQNzQxQlRRQTVWdUdIUFBCS05l?=
 =?utf-8?B?SUpFVVhYUTJLSVNnQis1MEFCRktyQXhqdUJSOHY2bVpqSmZFVW1ZMkd4bHpw?=
 =?utf-8?B?d2xVbnkrV21zMmduaDdSRmtxN25ueEczL1ZVSC9kYXdpS0ZaU2wxWTlSdHhm?=
 =?utf-8?B?Wk1FSUpMVnk3c3BCVk9oYUdFOWJ2NUk4cXVUNkluTU1JOE5vT2dpSzIxVmt0?=
 =?utf-8?B?RHhzeTJVSXVkRXdUWDViN0YxM05BRmJkc012cjRER1Y1K2ZpUVhIVzdmSnRo?=
 =?utf-8?B?TFVFUHZPRTJEdE5yN1dYTEVtamsvNFR6YXdPNDJYUVNBVnVwbXRBK0xaajg4?=
 =?utf-8?B?YjB3T2lOOEl0RWd1L1ZFZ3N4WmR0SnpOS29xUVBZVU9YM3FqdzZ2TGtZeVpr?=
 =?utf-8?B?QjE4VjRRTURtMmtmUG5ReGZHc0lUODkrUHQwU3NtVU1qN3BucDNSRzIvWHJZ?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9c5b6a-d0b4-4487-a7d9-08db877faffe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 11:11:08.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woS+iwn24K/JjxAis6nIXM3sH3TnaDaOmE5zDanctY4qyqG+o/PV/mJ+PXuMtUw7KRQiaG3t9qG8dqv4rav+/SZTrVskkGYFcoFGWHYxRv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
> 
>> Or, perhaps you were discussing return value here and ERR_PTR(-EINVAL) could
>> be replaced by something else or even NULL.
> 
> I prefer to get rid of those.

Decided to do some manual tests on more exotic setups that are not part 
of our daily CI/CD routine and, completely getting rid of those ifs 
causes problems. Those setups are part of the market, expose DSP 
capabilities but have invalid BIOS configurations.

Rather than just bringing back the if-statement, different solution came 
to my mind:

static struct acpi_table_nhlt empty_nhlt = {
	.header = {
		.signature = ACPI_SIG_NHLT,
	},
};

struct acpi_table_nhlt *acpi_gbl_NHLT;
EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);

acpi_status acpi_nhlt_get_gbl_table(void)
{
	acpi_status status;

	status = acpi_get_table(ACPI_SIG_NHLT, 0, (struct acpi_table_header 
**)(&acpi_gbl_NHLT));
	if (!acpi_gbl_NHLT)
		acpi_gbl_NHLT = &empty_nhlt;
	return status;
}
EXPORT_SYMBOL_GPL(acpi_nhlt_get_gbl_table);


What do you think?
