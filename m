Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013366EECCD
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Apr 2023 05:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbjDZDpG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Apr 2023 23:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbjDZDpE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2023 23:45:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4D10C2;
        Tue, 25 Apr 2023 20:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682480703; x=1714016703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S4jBN6KEs2XqwTNol3RFeRF6iIIisOujk/M1bmrsZGo=;
  b=d9k3VFOjIqFKA5rYp3ZoF8Ui2E06hP1jD66eKewW9FQekx6SReiayJ3Q
   JEx52SaOh2vuk+r8yRHxD8OkJ32Dsv6YgECnzFx0FmJAjjD+4XGAlFtFi
   P251jLuDukmKaQcAnGX12Enqj8ZAZo1b5cTE7PW36iUilaNw9AdkLShtE
   LQ7dx6fgpfZCrsTPpfH2rHcFZL538xH/G3o9TNMeaUj0d1DW+80lKoKxk
   KQhby91osJko+BznSNUNdX+5pOshrO23Q7fq5UIBsfdkFByWDML4TVMqu
   LWInbeqLsOXacxsFrdzbqas2rHoZ8YFmBzb8ck5fvVErwpC+WXmjEgQd5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="409949451"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="409949451"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 20:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="940031806"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="940031806"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2023 20:45:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 20:45:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 20:45:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 25 Apr 2023 20:45:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 25 Apr 2023 20:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT/a5futZp2jN1Uaz3CforNCGckfAxua6yzANUY7SAj6z2upQcRKxLUVQPp4WyVmuXIezI6cvqThV/f47VtezbvOLPs3ap2qvksrTcCfCC+EZsJ4GFGTHHSQs6i2otbwpX/WtlBRP5Vq7Uze2b7uTXz+40YPsdjIf29nGbNZvWfyCy4IXzcLwJxrRddX391xxotz+cSWbulT8tHMMLBYt15WgZs4rR58QQfgJL3SOQVIKS4bTEcP+aP6D42990hRGaH9jpnHWmg2FuVMPS3ZPo6WTc9CFgG5xdQj9tblwxiZ5k5VvMxU1+3JO2pF3zkwWeJUE7H1ZALYDYwfalFN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAcr0WEkuJyrGbJcBOO9PF9Xb9wn9rsAsiSXfwt8VSQ=;
 b=exreXsv2uWhJmXHkb95e/0T08bcy+xkK62ayPzx017lh745UhDi1Ve7oPkrOyQ0LJqw6p5DINIBRfpZ3VgRE+T06ydniYCZL1QzB0hDOw+J2/T4OchUAMnJNiAj/ADnq90Ak5ejXoIUHVWtgA2wPRgZiyzIIuV67q2cW6dCnxeuP+B2CvbmqZSS8OKwuINyp0lfzn5x0V0DGqliyqVtCAyd3+f20fkLdZfzqtGZQY3V65V2er+nnl0C9kTTZzI/eQ0GbSqBOchL03IeR2VgESqebNClRrS7JoMLX6HkfKIJciqP5F4CNndEn+/uBoQuWDHtXEzrpZXA6AS8ymc0exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 03:44:49 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::4814:d85f:2e45:1828]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::4814:d85f:2e45:1828%4]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 03:44:48 +0000
Message-ID: <828de4e9-3b8e-ef59-5e7f-6a12307a1127@intel.com>
Date:   Wed, 26 Apr 2023 11:44:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 05/23] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <168193569130.1178687.11664485128816659216.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|MN2PR11MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: d8367147-53b6-424f-d0bb-08db460894d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SC0kglx4LAO/dy7nY0kK0X+2zPGsGBufV8JOxmg5TFq30htCR7tvM67oBpM7XRSM99D6/y6Z5qYDWRtTzdX6E/Nni15TZEoSn8Gfr2YQVBDyRkt95vNTmJ3ihsgnoUte1GmmhabCGpq/mFsmhJFHN/XQe79UVxn8KR6GLxOKf7pyDup43pr9JT4dpDxDpzNeU6ixL6dBeVPT4DXkTXsmYPxGl52NwGq51SJOLqABczRlRmG16Ra+XEjE7BjOgPf4XVkm76w3g8EL7FsetHnLr3DsD9xQPfFms5u/XAX7pxAHH2xSIq1axW4uiNb8MkxJd5NqQbIr+JQgdzaDNkxmyngqwM4udpEVEWwkmuX8EYPviIsLP+mOUIsKh7D2/K5qVO//E1SEUdOcWokoCBWblJJHXy9ujImflU2+8Vl6FJ4NJZi6syUAbo1J0yBX4JpG2m1Rx1efK4Ksn4N+964dE2xAqmdF8j5Vw6/pZvj8ldFAj9+sWdQxBSaw48r4zH870hzC6P9LGxWyLf/TnVHPt7Jav7l1DwTUH3SOkpSIn7eOg2d+UQ+ggG8hvxY8ADv4UZUBUfwWXoSLzA9PbpyH18beGpA1x6kJZ/AJVuqrFUnX/ePZO67yOCrIcQl97/7e5l+s1eDtoztY4EmKIihyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(6862004)(37006003)(478600001)(5660300002)(8936002)(38100700002)(8676002)(2906002)(36756003)(86362001)(31696002)(66946007)(66556008)(66476007)(6636002)(316002)(4326008)(82960400001)(41300700001)(186003)(2616005)(31686004)(6512007)(6506007)(53546011)(26005)(6486002)(36916002)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNUNUxMQVY3VEh6dzlMc1RCdmpJNzdIQk5hZU5BNiszeGlCTUFBMjEwUDRV?=
 =?utf-8?B?OGVZcWJYcmNpcW1aQUdHYzJ1dFJibnpzL1FXQXFreERLSnk1MkEyNXBldm1Q?=
 =?utf-8?B?S3lUMWNCNFV5ZmdHYVNUcCttTWk5blNPejZmZGtrMHJuU25kWElTRXlsd2dF?=
 =?utf-8?B?elEzVjNFY3Y0cDZkdWhnN1BoZU9HOUZEc1BSL1FPRThpakFXa0E0VUpveWxr?=
 =?utf-8?B?cmgrZDluT3YvL3J1SGxiYitCQm01YmRlYmg0anJqQUhFT0podDVwRUFVeUhN?=
 =?utf-8?B?TDFmZXc4Z0JBR2Y1WWhUVDRoaFBaT0pIT2JqUVhSTmNsMTZVeTRGd3AyckZm?=
 =?utf-8?B?U1F1V2kvUk5tRDNpekRXVEVkdHRwTkRYVnRtV29QZ0QyamE5QldhK0pobWll?=
 =?utf-8?B?VCs5cVlRMDMrVmczbXZiSys5cG1iWEVsaDREclRHZEpGRHBmQnF6Qi9vb2JK?=
 =?utf-8?B?dyt2c3FVNkNXbVhnUmNwejlNSW5NbHJLSXkvZk9DQnc4RDdNVHVpMDIwbGg4?=
 =?utf-8?B?aGplUUVzOTIwWVNWeHBaMUt5Mkc5NkZ5MEloZGVCVm1CdVlZTXdhQnhWYkZE?=
 =?utf-8?B?K1FyTm0wbjl4aG9CcmtWN3ZvOTBCckZ2eXB1MlkzQjl2MGhVcXFyRmhBTGpO?=
 =?utf-8?B?djR1OVhQWXJVb3JTNkl4dnhzWkRTNDNhY2dGZkg0NXdEZHpIclNYc24wMXRF?=
 =?utf-8?B?dkdiQUExNENJdWhEVGx5SGF3K0EwVkdSU1d4T1dZZ21heWkzSnV5cGowWEpC?=
 =?utf-8?B?QVFLckg3bW1Oc3g5Q2lHUVgyT0p5bng2ZVRJTFZodXlZaVFMUE5oUGsvS3lr?=
 =?utf-8?B?aXBVK1dnVEV3UjMxODFQcWJBRFNhZWFyZ3kycW1FdkNPVy9BM2NQazdoVExa?=
 =?utf-8?B?WUZrNWliSjk5NXRHbW90Y1lVVXlLb05YNzVDUTQrdG9tYXR6dkRUWUZQNkw3?=
 =?utf-8?B?c0I3emxLYjZJZERwdGVtcnFxSW1TblFDdThPRjBiSG04UFhjcXA0bjA4ekNT?=
 =?utf-8?B?UzZIWk9ON0luWGN1c1E5MWYzeDczRkU5RUtWWks2aWQ0bUI1UFpYbDNCd1BW?=
 =?utf-8?B?MjhRSmJ3Y0VBRVZvWTBrR05FL0F2VS9PZFVMcjZNYjJvaTYzQ1pvZDJmQTdM?=
 =?utf-8?B?RFNkYUlHYWRKQVB6ODY3RVpLVWZDM1VKWkRUb3NlRjRZdTF5ZDEzWTNwUmFM?=
 =?utf-8?B?cTZqMHoxaEJQS3R5aXFHanNGV05kQXBEOUNiaWRlZXpiWjVwYXRPY2g1Qjcx?=
 =?utf-8?B?ZlFIMTVDdGZTeXpodzRHUXJxaWFuTldRVnFOYlUrOWRBZ0ljWHk5Z21QZ3VZ?=
 =?utf-8?B?NnZVc0w1LzJGYlBZMm4yTnFoNFhIVmIvSEkvMnlrQnc5MS9teUdGREtCQTJv?=
 =?utf-8?B?bjlNbTVGUUNGcjh4MGczUlpReTZudHBFaVN4dHEyaWtRTm5NckpNaUJFY2tL?=
 =?utf-8?B?VXZiajdpNGR1U09wT3JDMGNpYUpTOCs3c0xXV25lODkydEFaWkFHbFpobXBW?=
 =?utf-8?B?Zy9kRXBCZVhyakxGamFOcjY3MERETTRpNU1PQXppMjg4bnFVQko1alNldTYv?=
 =?utf-8?B?TEFSTThjMzJlT0JSblJ5S3QwMHgvT0RPT0ptMjJUemZTdmtha2lhMWo5Vnd3?=
 =?utf-8?B?WklPbFVEWkRLNzNjdnh4b1dyNnB5ektkWDlWMkZLSm05L2hwSkFXYksvc24w?=
 =?utf-8?B?a0QyT1pqMnRxMGRjT1ZYWDQ1Qzg5Z3pKczdDL3VaYnRDcitZditpTjhNcFNO?=
 =?utf-8?B?OFo0dy9Gb24yVFZNZEh2NWd6UVdNV2o1Yk1uaDFXUVU1WmN6Y1JZNVFkeERB?=
 =?utf-8?B?UnlBdTJhekFpWG5KelptY2ZUOTRNSVlwMXpPeXlvdEZ3RlJPYThUUlB4VW9n?=
 =?utf-8?B?Vzl0aUp2KzZzZTNMZjZmSGJKaHYzNWdubENPUVc5cDJVU1FYa3I4Y1ZQZVpy?=
 =?utf-8?B?Z29Bb0VPd0RvSlZxTHVqL2NDNThPWlE3STdxSUlFZk44bmpzaC9uTFJQSm5l?=
 =?utf-8?B?eUhZZ2txV2hNaHpMSDlpUEJYM0NiYmkza1VoK3BjK2Y4Q0FLcU8wK29oMTc3?=
 =?utf-8?B?U0FDajBzV2tpUDRqRjNCclM2VjFnV0NycmExMjRLVFpsSVNHT2dYNTlBbnBI?=
 =?utf-8?Q?MctGLhrZ7yLlHl0A0rEI5B/I1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8367147-53b6-424f-d0bb-08db460894d8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 03:44:47.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRoPLfaRxs9Cxfs/Dk3VonQhTpfhddMMyPmfOrQjCtxhWfV3FWZ5WYnxWnXdWAglX/s2/y2LKxYXSGrUpMxZ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/20/2023 4:21 AM, Dave Jiang wrote:
> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
> Structure (DSMAS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Add spec section number. (Alison)
> - Remove cast from void *. (Alison)
> - Refactor cxl_port_probe() block. (Alison)
> - Move CDAT parse to cxl_endpoint_port_probe()
> 
> v2:
> - Add DSMAS table size check. (Lukas)
> - Use local DSMAS header for LE handling.
> - Remove dsmas lock. (Jonathan)
> - Fix handle size (Jonathan)
> - Add LE to host conversion for DSMAS address and length.
> - Make dsmas_list local
> ---
>  drivers/cxl/core/cdat.c |   26 ++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    1 +
>  drivers/cxl/cxlpci.h    |   18 ++++++++++++++++++
>  drivers/cxl/port.c      |   22 ++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 210f4499bddb..6f20af83a3ed 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
>  	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>  }
>  EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
> +{
> +	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)header;
> +	struct list_head *dsmas_list = arg;
> +	struct dsmas_entry *dent;
> +
> +	if (dsmas->hdr.length != sizeof(*dsmas)) {
> +		pr_warn("Malformed DSMAS table length: (%lu:%u)\n",
> +			 (unsigned long)sizeof(*dsmas), dsmas->hdr.length);
> +		return -EINVAL;
> +	}
> +
> +	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
> +	if (!dent)
> +		return -ENOMEM;
> +
> +	dent->handle = dsmas->dsmad_handle;
> +	dent->dpa_range.start = le64_to_cpu(dsmas->dpa_base_address);
> +	dent->dpa_range.end = le64_to_cpu(dsmas->dpa_base_address) +
> +			      le64_to_cpu(dsmas->dpa_length) - 1;

Hi Dave,

I saw you didn't store flags field into dent, it is not needed or missed?

Thanks
Ming


