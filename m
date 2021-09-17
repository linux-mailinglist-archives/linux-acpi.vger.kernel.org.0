Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76640FB66
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhIQPMT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 11:12:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:51672 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233325AbhIQPMT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 11:12:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="308360405"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="308360405"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="651906241"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 17 Sep 2021 08:10:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 17 Sep 2021 08:10:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 17 Sep 2021 08:10:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 17 Sep 2021 08:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbIiZuLEVzK/VsGOmfUWtHL9u2YgNqjFrBxi0Ie6QZrrLab0dyqFyzWovjsghNk8IclQmKztWaq0lajwn/7nyUUlX1QcimTGr21Es8DlfpgyX8p8XvCp4LBoWP8ePu5jYP+hCVRLmtbHgVSyFlAD80jPaELyMhNMjP4ixQd9oRt32KfSKajQptJIfVYC4aH6/vyx41gDp54L9s8rN1gkySv5hWSDQ9C1eVpFzYG0omn2ZsA40+D1cQ+DILtNpq+P/eUvO3CWw3VYFcaitPfq8P6jzkROHxXq70ufcca5JxEgsw+ds6AsjC8wKNBV1Tz1rgISbGMSCpNCG+h/fsGu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4GdV+WvjaqavqQbYf9n2Scl33cwkraK+Wb70jT9UaXg=;
 b=LQJamXpXolxy8NpA/NpmiHMrQ1tJRGC2/DC/BDvdd3ot6WOeVUzihiHsC6K9QikE65rpeX34Qaq5jctrG1+8UsC1VMTeQhA3/OlEPQW+uf1ydT8zRhd4xIpSVM5R3BMIV1QV8sRFgvkOHsrFz5Yt9ZCY7gr+n84sCqt5wV/qjBlp9YyStm3YSr4XO7nXY/XlzBZXm0y32CZ+Z3pOgSxohcKyGF9SlLCMoeg03ojyIe5ZVizjJcHQyyqdYA0DVafVEbWr6orGa0DOo1bhjlcZPJfeiu7iIQaJRSXVO3buJkIDmZ/dUZ4WksuDiJfHSDWGyfAXydtED79FxhVIVq3AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GdV+WvjaqavqQbYf9n2Scl33cwkraK+Wb70jT9UaXg=;
 b=vq1/IO5UqwE2z5XgznMFIRxn7YF8IyrjPD0r2yWYY9YZNBUMqRD95kzOlHMA873WOqcFds2ArKUdG0E1RHt22G3AFDB0MpCrZX5b04BioBmnXAZvUimeQlGUTP6P6Ota3IKmM1g8e1MxCxqKVmHhi6msRI3F6nHUmJularda7eA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM6PR11MB2969.namprd11.prod.outlook.com (2603:10b6:5:70::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Fri, 17 Sep 2021 15:10:52 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 15:10:52 +0000
Subject: Re: [PATCH v2 14/14] ACPI/PCC: Add myself as maintainer for PCC
 mailbox driver
To:     Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
 <20210917133357.1911092-15-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <811c1f11-8615-7984-7d23-8519a5a67f0c@intel.com>
Date:   Fri, 17 Sep 2021 17:10:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20210917133357.1911092-15-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6P192CA0030.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::43) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.175.245) by AM6P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 15:10:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9045f7fd-c8d8-4138-ce8a-08d979ed5723
X-MS-TrafficTypeDiagnostic: DM6PR11MB2969:
X-Microsoft-Antispam-PRVS: <DM6PR11MB29699AB40CD7B5AAEAF4D346CBDD9@DM6PR11MB2969.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvbARO/OJo/KjZILIIrFr6wyJI/JyXqzigALZxcrBJ07RMf/eY0we2R/1uDCM3L8M9ecgOjiZziaxtKvUXFqbxgFJ/ddk+R69dicBjnfNz8Bp94vmKQAerjO3oeBFWzStseC2cS8E/boRBl+rL06gsJcBZUKtYgYczOTJtU+elwVPx204QC4jGfDkrGNYblCB36W8pqwzzBTr+vL9SDjekh9rSdqgpyfyjffO87cNIhrrA9/hfgqyp8JSXeenbseKIdhk/8Gtvjrkj4v70SSt5knAQhPFwubi85nIdv1jxF0RPh6HWd9qhnpBzYs9iVIpwu6BZ0IqkI55GSz1JUGAEqa8j9a3LyUfbNeS6a6r9CSQ3+fd47fDsm0ynjP7S+PI+C8XOFvYfAaYIzTHUDyYhAqEJV2XqDoKl2JSEQoafUZh/JEP6+kXt4/m4CBs98CAIhaD/CPSBT31Bx6IjW+W/KWSZ997k/Ka0boWPjz4URXX0TN/DxjGrl/ibolA2NZyndPf2l3liBeUgUkab1knA3RdVWUVf1WH55meKJ5ItkmOfeT4UTMGq3X9swZQOd66gi6/FflMiMegGWkKJzVobz/esWK5dh8sfeddNH7rQyctyOvappCKLW8asRxKkrhpqoD9Eaw7aCRETbo9LvhnJlhClPnO0cwzbt6m7op9oIE3tamd7G9iZn07djK6MeHaJDlCbpWxm67ll6Zj7heXkK5EDX0yDh3vQ1ETO8ppD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(31686004)(83380400001)(956004)(36756003)(2616005)(478600001)(8936002)(8676002)(66476007)(66556008)(31696002)(15650500001)(6486002)(6666004)(2906002)(186003)(316002)(53546011)(36916002)(66946007)(38100700002)(4326008)(54906003)(16576012)(86362001)(26005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y045WmVnRG55b1JOYlB2dHNrUWtrRGpGY3RuVW5XaUpaRm1PZzgzbDFnTkJS?=
 =?utf-8?B?aXpDU0Vtb2prUlpRblFaL3NieGJPQ0Q3dnFzeUtFZGR3QXVkcUZMSjMrbnVC?=
 =?utf-8?B?OGtlVTBXTzVJL0tYMTVkTk92T09NQXkyVUFiakltVWY1KzRqdTVRNTdmcHRY?=
 =?utf-8?B?dDAyYkRBRUFEbGpUT2hqeUdUamxEK1NRUHlIN2JMS21IWUpBMGpvYytuWVlx?=
 =?utf-8?B?aThYL0oyN2p6VmNLUXVaN3dtSUdUVGdvZ0VRbDRVWmgvK3Q5STdmb0NUT1h1?=
 =?utf-8?B?d1BHMHQ2UDBiZFBGQVV5OGkwbVBVK2pCRkNLc0p2YWVFY3kzR3pHemdJTGlK?=
 =?utf-8?B?ME92bUF2RVp3dFZ3ZTZDcEtSeUR0QzdteVRkUkNiWUpnS2ZWZWF0eklld1oz?=
 =?utf-8?B?eW5oYy8ya0FpVGd1QjBXUTBHMEkxUmRLeWYyMUhOaHR1RnoraElZTmFmR0x1?=
 =?utf-8?B?aDJVT3RpRk1mYWgrN09nNXk1V3BHVEZldU1GZnd3RnN2a1lITS8rc0hZRGQw?=
 =?utf-8?B?K2k3RFo0UlZwM0R1d05vRzlHYzlkRTVPU2Fka0RhcC96T1R4VHVETHp3dldF?=
 =?utf-8?B?RkFMd2U1TDdRY0JpbURQSFlQaytSdkFMb2JTUlh5Uk4wMmhsV1VtUnVQbkU5?=
 =?utf-8?B?eXI2SkNhbit5bStpdmVwdkQ5b1lEZkxrdkxjRFlBaGE1and4UmhCTHU4b0Jo?=
 =?utf-8?B?cWY4VkpqSTNidDVZQUVoZFBTaDNDQkVzU081UitrMnVEdEpsVFRXcEVUL2J0?=
 =?utf-8?B?eWxDZVBNVkt2ZUN4UHRPcHFoSis4bGdBTE5ia2NYUFVGVlBqNnRlSmJyS2NF?=
 =?utf-8?B?clFRcXdYTFNzQjgrYzRjZUpjOEdYaWo3QmtaandSeVlLRFV6NUN3M3RVRDlp?=
 =?utf-8?B?Snc4ajI0NkQrQlRTSFdqaVJWa1A2Sjhsb2ZRN2xuajZyWk02QkFDOXJtSmVy?=
 =?utf-8?B?eEwvUEtlK05ueUlYd0ExSHJNMmg0MFFOcjdwM1YxK1c0YlZDUko2OHB2RmhF?=
 =?utf-8?B?dVI4ZS82WjJkYmZlN3c1bkkyR3ozTVpMbVJtMXdGS0JHc2dNMmlRa1VDZU40?=
 =?utf-8?B?d1pCenUyT2s1Z2s2S05ZTEUreEpCcmdMQjdoQ0dVTy92VFJ5b2ZnRVN2RG1W?=
 =?utf-8?B?cGx3SDBMeHF2MUJCNEV1UkNjbzVicWlLcTJaVDZrNGVVdUtqZzEvOGdCSHM2?=
 =?utf-8?B?dHc2dFBqUEZ1RnJVbVBVMGxRd2NoNUhwOVdqa1F3UTg4eU4xZ0w3ZmNxd0Yy?=
 =?utf-8?B?bjlYYVZwRlVEajhVWmh3UzRya0lGUXZnVTNZNVF0VVNUb3U3cVNLOHlQcTc5?=
 =?utf-8?B?MWFyVEZ6UjVKK0MzOWROQi9HcTFoaXdqTUwyRVJOanpLSTV0cTd1NlVSV09D?=
 =?utf-8?B?RVFXOVRlc3d5djN3VmNKVzR0RXVqcHNlVmV4cVN3SHZGeENCNzZMQ3VVVGx5?=
 =?utf-8?B?ZmFNZnlpaUJWYjVEZmlGL09CVTAvTGg4Z3ZCcWZLRmZVSkNFZ0lidm5oVDhE?=
 =?utf-8?B?VHZqNm5UcWdCQVQxZHRnZWtXQkp1TTlLaHJCUUYxQy9KV1UzeGlBZlBwZi9P?=
 =?utf-8?B?MVhLZnFLV0ovbm9qeVU2dVdHclQ4NXg2SUpJbXJ6M3RZQTBTSVA0ajRGVFJS?=
 =?utf-8?B?Zncvb2VkZmM5NDZIdmR0U0l6M2ZvY01ZZ3d0VStIOFdXVUZzVFpxQU9ldmlv?=
 =?utf-8?B?M0NSZFhVRlRNdDBYR1RjY0dXTGowa1VVTUhJZWMyQ3ZYcFdPUHpuKzc2TW9t?=
 =?utf-8?Q?VIXNMxXHIg3lDl3i+nhgWwsNzgWd0pfq0XapGGt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9045f7fd-c8d8-4138-ce8a-08d979ed5723
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 15:10:52.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu/G99Jxy5K3KxazvVylN7JswS8NdqHGH/FhWqJjaBx7Y9ogH5b2rWhgAWX2LgPg5QgJ/tjk/yptlDkeV138gRWIlou/pIo6nW8E3O0LMo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2969
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/17/2021 3:33 PM, Sudeep Holla wrote:
> Not much functionality is added since PCC driver was added 5 years ago.
> There is need to restructure the driver while adding support for PCC
> Extended subspaces type 3&4. There is more rework needed as more users
> adopt PCC on arm64 platforms. In order to ease the same, I would like
> to take responsibility to maintain this driver.
>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> Hi Rafael,
>
> As you mentioned offline that you haven't followed ACPI PCC changes
> much and don't have time to review this, I thought of adding myself
> as maintainer for the ACPI PCC part of the mailbox as I will be tracking
> and using PCCT. Let me know if you have any objections.

No objections.

Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..8d41dd710ae9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -401,6 +401,12 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
>   F:	drivers/platform/x86/i2c-multi-instantiate.c
>   
> +ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
> +M:	Sudeep Holla <sudeep.holla@arm.com>
> +L:	linux-acpi@vger.kernel.org
> +S:	Supported
> +F:	drivers/mailbox/pcc.c
> +
>   ACPI PMIC DRIVERS
>   M:	"Rafael J. Wysocki" <rafael@kernel.org>
>   M:	Len Brown <lenb@kernel.org>


