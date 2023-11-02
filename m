Return-Path: <linux-acpi+bounces-1168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D577DFC6D
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 23:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A81B20B00
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150E922337
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpC+93xl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5E1F94C;
	Thu,  2 Nov 2023 22:08:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7910138;
	Thu,  2 Nov 2023 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698962914; x=1730498914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=spr/dnc9IMXWJ89ESl/X7NBBEkWScvRWycn52DfKXqI=;
  b=CpC+93xlnMg9KqCELY6vZbnQq+hlg9fyADo9lwddh+hNVC47FyLK1GF+
   EkhXW7K30/kSKOUQMxU38S1c0xhgU4rJ5bTW/ZPaUZO9QQ//Qp+XSuJST
   cTKZIMQRdIWB76frQJigcTMf0SRRstA86nDdpBY7GdTpQXM2LSPlVzZkO
   cgQypdZpTEkYS3zVASj46oIxArBltTR8To03PzhJibkkFjZp549T2DZ2R
   S9Sm/AkVtlesbh/oQR0pUqDTMAq3FybrvdZAInthRoXK4sb/bGy4APHod
   9uz1sU7LnDqc63IaQvjf1Z1qAFZjc+3xZZcLu7Tj1UT5KDgLlUBnaSDpL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419935447"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="419935447"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="2696768"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 15:08:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 15:08:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 15:08:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 15:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqOwyRMEWeSZXXsxoc7VB/90TaK3z76uz46D7WrcWlhREDYDwAbuKhinehlY+e0W4dW3DYE5PLR3yF+ksQ52isVJK8xogsP3a21jRk4ESVuQ6ZMWvLPjkRS1En/Ri8aAyYf+VUpRlN6S/EARMc99VpRvVGySnqUSQ5W317MFBf9nk49REee4Vc++JB5GGymeL5B2vEa+vtV8xhZkqaJckZBGjeX0U/0NF7FwgK2x6sST5wOOXn7tJj8bYT6t3wG0BCz30InOB/AFZuZaiOIx6IlG9lXOxG8I/xAhh/byhFwqY22uoV8yRn4Aeo8cEyskpo0V+sUC9sOF/JyTW/rtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOhGaLgGjUOAJuY+IaMXeTRJdvhUVlWjVG4NeUgS1eY=;
 b=hg/1xio4q0rFxixpKOleIzgBsJvKrAAZXa+Tn2tJYknoovXZYbiQVjxAk2h7CwGl3o+1it4ht01+KHkHFaafbB+PUCrQMHwqCknX0ki2NJKBSRyHUtt9SBZ5lQJhnQ6J5fRB4Mty4povYrRvZ9AEGjUEzdpMcbMY9na48cLs6TcFDr2x7B9C3QS0v1W86eO92Ud8Q2DUHUuqRFheL5LL/A4fxzoeXsHUhope5RZsPpQxImmthYcZOPpIJyFy4wYSdq1KS/gYlRVWp/8pgFbMuLNx2ilVQp/dbL1GYNoDRNPIQx9Scw1c4KP36zqSMNd9WlRvgteDdMJFZjwV8kQuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 22:08:31 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%6]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 22:08:31 +0000
Message-ID: <8511f702-53f3-4493-a1fe-1463e969b4b0@intel.com>
Date: Thu, 2 Nov 2023 15:08:28 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] lib/fw_table: Remove acpi_parse_entries_array() export
To: Dan Williams <dan.j.williams@intel.com>, <linux-acpi@vger.kernel.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, <linux-cxl@vger.kernel.org>
References: <169896282222.70775.940454758280866379.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169896282222.70775.940454758280866379.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b7c484-2f7b-42cc-f798-08dbdbf03f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFfAAUDIeDJ2P9Uvqt847V4sf+9EUd455kUojyYSioW/DKXvADFrmJEOSNCw2dmJI8PRC+Kpizk8lMDI7Qkq7YIy4eeblowiHm19+QMWvwgnmmKUC7F5wfZIkEQnReX1qWt8Agsa4iMfcNO6q0cTIv8vMxrerVYF4AVa9LFDNYu7wAk+d/PqGSJbx1YwznxFErhD1WBe68E214QNx2/xh05VXUv5XgBW1Ov/k5frwiXOTdqbE2fC9AB/yecPKZR867xy07f7MdhMVHluiwIuJMe7UwXmA8ShjJVynYV6WFX5LMVlDTyGNegSGzoLFbN9spW/7S88WY+iyb6fjYeCRQQRDHWkZuPbZc0L2uhZV4edljA/Sekjp8dieotA6bO5qwIk/HhYcwQUsAkuz6zjS3GEdiYlQX5NZEYwvn8xyNd4tCDOjEWKrKilZfOGU8StdtbPiHRAkiK/7NdeYmQR7Cm9D0u9IU1e6v8UuFAm9yoneMsPXy+MNciScyM4I9OUo6FHJmSER1QGZxTKWaxp+5wF5GvZCtHTzI8wt/DuIV7uRZZKygAjRKdXP3ne9xbKheYNkY9qpeKy5bgPfqW/pCKkNEiP4j4uh7UkJ778Ef9UNiz01VwzCs9oEzs8+y0J7oTGfrmmiJPy0bbtGZebrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(966005)(26005)(38100700002)(5660300002)(66476007)(66556008)(316002)(8936002)(8676002)(4326008)(53546011)(6666004)(41300700001)(6486002)(2906002)(2616005)(44832011)(478600001)(6512007)(6506007)(66946007)(86362001)(31696002)(82960400001)(36756003)(83380400001)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhreHBEYlFKUk9SNktqWDNFMHdlNHZBR2hVSHBWdEJwZVJBY1hZZW5FWDd6?=
 =?utf-8?B?clMyOG5SeExQTytsdkR4MmxIeEVzN05LY3h2ZTYrc1NXQzhiRTNYMEJ1VDJz?=
 =?utf-8?B?Z0h2akdxU04vNnBMRnpLVERTZFQ1bnJncEhCdy9XZEY1cUVVTlRTTjJvL1ZN?=
 =?utf-8?B?K1l3Mm1MOEc0SW5hbjRpUTFnMVBnMk9OTW1KSVp1UWNRMmF3ZWo0ckk3RHha?=
 =?utf-8?B?WHQzLzJzUEFWaUVyYmREc1FVUVBtdmFnMGZ4QTF2a1F1ZVVYZGFncUJaQ2VR?=
 =?utf-8?B?K09ST2lVc3A1aTlkbTZBYzJZVDlkMDZydkRKdDArMEJHaXJYT010Z1Jmd2xk?=
 =?utf-8?B?MjUvN1J4R3VVK29PNnAzSEdkWFBQNkZkUGNKOUhsT1lYYWhIRTljOEFLQ1hS?=
 =?utf-8?B?ZTdMUDRXY0E1Y21DZTk1UmJGNW91eWFtNlBmZEp0V1lJaGZRUktNc29FbGls?=
 =?utf-8?B?Yk9oVmllOStPTFh1dmtCb0ljMVQ3OG0zaGtLdUJNTERVZ1dMelZKV0gzdXBs?=
 =?utf-8?B?MUFCSE00eG16bGVlNHVCRWpQZ2x2eFdoeU5WTUNLSWI4Y2JWNElBSmIxS1lO?=
 =?utf-8?B?NWY4QlBZWCtNL2t4enlNNFU0c2xLQTBXbGkwWlcxalMyWE80WnJqaGsxR2x5?=
 =?utf-8?B?SE95c1BENklHY3FCNklFSkhaVzJnNEhpMzEwd2VyN1lEck8xUmZVYkgxYjhH?=
 =?utf-8?B?V2VIaEZHOWNDZTZLc3UyYzBNUkp6Z29xczM4OU9BbTl4Qm5ldVh1ckVKMThX?=
 =?utf-8?B?TE01N1hjaHliQWF6V3d0OXFGS0NTMFpNOXVseTR4M0xwYnNtTjFTdHVSNFhn?=
 =?utf-8?B?SmRJTFErVFk2MGYvUEt2YTU3ZWVwUmJZdTZTQXk2WHloL21IVThTN1BJWCsx?=
 =?utf-8?B?UGduYVFLY0ZETzR4ck9wNXVRWWx1Yk5GUkFWTkFZQWs2aDdkeUpsRVJ4TkZu?=
 =?utf-8?B?dzduL2pjdjVBb3J1VnhWVnBOaTVFb1BxbDNHRlljZHhRRVpBenAzdUF3dVVz?=
 =?utf-8?B?NzNaa0QwVE10Nm5UMWE2THgvMlJkbkVlb0ptSWpvQWZWSTdqai9uMGsyTmZN?=
 =?utf-8?B?VzFTNVFURTV5c1pKN0hqZkl5TG8vazV2a2Y5S25WdUhVN3dJK1JnVkFYQWpT?=
 =?utf-8?B?NCtWcDV2b0F1aGhwMnByMFkvVVVvU3VFeXlQR1FhaDBIYnpXVmVoc0dvMTZS?=
 =?utf-8?B?bzl1TFR3OU9TYU9XbXJsNmk4bTZndWhwd2tPc3NzdWZBMkZvL0dTK3FvUGRr?=
 =?utf-8?B?Z0Vaa1locktibnJmdThnOU4zTlpXS1laMkREcm14Y2l4Nk1Db2JkQ0RQZzVR?=
 =?utf-8?B?eFNmK0dTcnlnWWRQQ1N2WEV1L0RrTzR1TjBFZk9wenFzaS9FQmVlTk01UEQ2?=
 =?utf-8?B?S1I2dTd4MDd0T1gxdE52RC9hT2ZoVktYRTFGM01veG5VT1J1YjdTbE5adjkv?=
 =?utf-8?B?TGRpcFJTektoYWJoUWNGcjRLSnZVd0JocVFvZEViZDdXcmZESlpBMFJxZ05C?=
 =?utf-8?B?Y2NITHlpbGcwWXJHckRwTWgrZFVPTXRLUmF4MVVES0dDblBPV2paRWJHYUhT?=
 =?utf-8?B?NXRyWmhNRDd3WHpHaVNVYzBlV3dlOGpIQ2poNW5kYml4eitvWHBxR3JHbHVt?=
 =?utf-8?B?cEZFTXRiMDJXd3BlNWNMUk9BL0c4am55ekc2a1Z0d1BFRUFGajltUmFXK2FK?=
 =?utf-8?B?VzFiSGpRdG5jVXhLUWFWU1k2RzMrVWZyWmxKNmdUVGNLeS9UZ0ZiNTNRb3A4?=
 =?utf-8?B?VkFLWTl5bXYxSUlGbStEMlJwbTRDYlN2dWkzcDkzK25wczJrTCtYTWcwS0R4?=
 =?utf-8?B?aHRFbDJyeXRXRkVJTmpuUFk2YlE3VmpWMDFDOHRCZHJTeDN2WFhWTFEvUkk1?=
 =?utf-8?B?Szl5VXFERCtMWXFYZmFBaStQSk9jTkhHRjRFZ1gzbHpkTUFlRGZBcWkrOS8w?=
 =?utf-8?B?OEw2WWtESnlBeEhTSTRheHB4NHhXaEJJamdDb2JsUEx3bzg1UnYvWFQvSHZl?=
 =?utf-8?B?b0hOUWxSSHJ4N0V1Rkx1Sm9HLzlkQmFic2ZFNWhLMjlhSmlqSDdENTgrS0VP?=
 =?utf-8?B?UjljeXpJTjExSTlSVVUxSjU0ZGM4OEFVSXh3MVNqQitrcWhnRG1MVzV4aTN0?=
 =?utf-8?Q?SFMHI++FfhPMfqyKzjb7i07Os?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b7c484-2f7b-42cc-f798-08dbdbf03f7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 22:08:30.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FduKx6cLsL8tYDspXUGusg57iqxqp/LbM5VDKkjNZVxGsKTKfsWY8IqCNQcn+icNA7wp4cJ0Z5PWInYSrR19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com



On 11/2/23 15:07, Dan Williams wrote:
> Stephen reports that the ACPI helper library rework,
> CONFIG_FIRMWARE_TABLE, introduces a new compiler warning:
> 
>     WARNING: modpost: vmlinux: acpi_parse_entries_array: EXPORT_SYMBOL used
>     for init symbol. Remove __init or EXPORT_SYMBOL.
> 
> Delete this export as it turns out it is unneeded, and future work wraps
> this in another exported helper. Note that in general
> EXPORT_SYMBOL_ACPI_LIB() is needed for exporting symbols that are marked
> __init_or_acpilib, but in this case no export is required.
> 
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: http://lore.kernel.org/r/20231030160523.670a7569@canb.auug.org.au
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  lib/fw_table.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index e84bd0866e10..b51f30a28e47 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -186,4 +186,3 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  
>  	return errs ? -EINVAL : count;
>  }
> -EXPORT_SYMBOL_GPL(acpi_parse_entries_array);
> 

