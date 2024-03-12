Return-Path: <linux-acpi+bounces-4298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A60879D98
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE291F214DE
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6914372C;
	Tue, 12 Mar 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AV89oZLV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E313B2BF;
	Tue, 12 Mar 2024 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279722; cv=fail; b=KT4CZAXvdvfcSVkF06wnarS/Hm+z4OlQg5e1hoUy0gDmxGVBzWJi6FAiqDs/kPm2rHtD7G8ANP3DRdKpOwmPJYbgQxdWkgp/PDqLJflTlHckm+4rc8VV1iQX9Tr4w1TRv9Kz9T/yQVNy3wYpNiPX9SFP4zpFXkowjSDHTd6gq3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279722; c=relaxed/simple;
	bh=o0L1dEYUnm17sDwqpWqhi9ICtmyEGfzo+oo2bjzcgGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WAKDE44PdHDKEfr0Rk1yAE3sUxovy2fAf2hR+JWSyc0QiKIsPft6yPQvUQxrgCWZ8trOAuoGmgxYsbj4JZVa5pBbxz+vS1EpZXILdqbHLV8SIQEVE+Jmjd5dtvubzzIrje/sGDBZwVZytE/xsghWJkf8R+4wOFcRiAn9RzJFFTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AV89oZLV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710279721; x=1741815721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o0L1dEYUnm17sDwqpWqhi9ICtmyEGfzo+oo2bjzcgGA=;
  b=AV89oZLVuSggbVZS9787QyuWvfPY0GH0Laa/5BlC3OR3r1Vy25L1q9gM
   B8gRthV8qM2Och7kM9aUc1rGUWtiGbpXb+36nI7xIK4aHYoVatSKrDVSO
   T0WDxMls0TRrnjkYiElcDHcnuOESTMWFOpTNdYp+NKGzJ4OF9jx0M5wvy
   4+DssrDSSuPBVgk1ToXL72KxOtWVLQV8Fk3CAj0Fc7rCdt1hClxqsRXAd
   qQKnwO3+EjemqLcXV+KltsNKDhxmO3dSVEFTdgfyjYBWU4u9xVwvKVWEG
   RVUlJtfVHW4OSYj5096+uofEexguikQugC7jtjF0/Zx0OtSRtU/SFiPdo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8830876"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8830876"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12143468"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 14:42:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 14:42:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 14:41:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 14:41:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 14:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCBQri4AalCCO5y3b/x8c/zXJuFahgZvvD+ZBSAmayABONUiSQ7sjQmOXuxPxfjFaUdtmAvGfTZ2Nou4zi9YDzhAk31U0beDdjtOOkpfaPRv9qL++HbMZXqmc8Il2//bTMEj7UDL4FS6zwyO06CQDeV2cdFqC6yas+Hwwhqh7igJG+QWbFIDt74wF+8fw4RKzkHbpp7s0Jsg8ZdCxbuLXgcTHQqWyDCJn0AL01gA2mE09UAONFX82J7wgkmq5FOLTeps/mUiFw7IZg64pPZujudbm0EB9f77JTbaJdGO0P3SAWFq+QVmWJjmKgUpaYgPrZXc1rG2uFEuq56OU936Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA4KnZJsQLxUG9HfTUY9jDfN99b/v2Cemyg3mUmDGIo=;
 b=mO8M3jxh8IqDShgDx9xHgfBu9oFpGXhX+6JSfUiYXFM5E6M5YBhtKtr9qx5Enp02dgbqHRfld9OQYLv6P/mqqsN38vbIM5QGel8F8E1nYsL0sZJW9B3UE1qgRRc03fFFbfH2R3uWi6HaWQE8Pk7xqZOHOV6LW2sUy/IffAh/rXgOBsaI4D63v2AQb4WfY9hVwYi4Tx51qXcemCvBvUI35zZhXPgEC7Dz+1VoyNQ63cdOMnrrLyE67kg8zJPxAOcdgNgSkEIe2ftPkEdeBBJdCn1bL/RWq7UWUIOBT+GUx4A7L4jGqRn3guadiJrpOmS75Z8/l7dAQMjX8MiqXeojHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 21:41:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 21:41:57 +0000
Date: Tue, 12 Mar 2024 14:41:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rafael@kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 12/12] cxl/region: Deal with numa nodes not enumerated
 by SRAT
Message-ID: <65f0cc232c07_a9b42945c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240308220055.2172956-1-dave.jiang@intel.com>
 <20240308220055.2172956-13-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308220055.2172956-13-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ecd3ad-7af1-4398-ebee-08dc42dd3df2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpyJPmoGitJR9J0QmNcufwFX6Ov012jAeRIGIL5obifQsc8HJiM1WDmZdS9xujvRb2ab/UufneGbRHyjwndNV+ha/HzRM0gJG3hMbKPszArfh+HM0plbnDlkgc+lxXRVER3hv6zB46LFJeMqLjJOVpR220PSMxH+oSrPQU8OlkRWpdYhsmVWd942G1yy1O5LGun+F0KgBn30UK9gt1tsEXTcLVs2cNLEwaFyqkxJZTm6l+xb9pSKXB6Au1Z4atf5NdUTTdAvRV6G+Ki1GcuIFpob0QzabsrHP+IRlrXcYieDQFGkjx/DVLB7c0f3+IvYHhkNG0ETH3u70dtsBeLYfaylU7b1XmgHScDZIlQXShCCsNdUpbifwQYnS0zH9y3KMaxd3wVy+dk/sCumLuFA3oG+1C283Qx5lyxJruEIoESVv+eO87ie+lQ79UKFoIKIbJBPKM4YElSGbrklgySuTPu2SExqn2oa0s6Q6xlAJOSs8TLYj36Qx4lvSGtEXDsvP+KSTTfs7qc30y3tAxxs0rJ8k0oxJ9Pb+2zLq58RBf2kLbPX8T6PWpaav1GrzgPv3GDpA13+ly6J0q2vrlOa22qVNrLuvHCKVRFLCChvWlxDjCTVxP+M5PN3mlfQu53t3569kcN3sCU+t0iJ+xlqnGQ2aoRUISPei4gjRQZAaNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUrHijSH/qt3o++3IALszYh1shJrevR1dmEz4JKGWiCSfs8DAnP2PkuxJ76h?=
 =?us-ascii?Q?eooYZCcm2/6bfRW7ACEo1OXab1JHm9Vg23uMkXtr9FqH/MhrjwlooXqR9Sgc?=
 =?us-ascii?Q?iDwAksJlOIMCoOLnD5SwtL24Ls3hVQHDTe8bQ3eUX7/G1eCbHb2LjH79Z5RQ?=
 =?us-ascii?Q?rZVeu+PYjYA+Ou6A8HpqFgE78Rnc0F/Pwr7WLqpXG8160/YNOubrdoVHOS8/?=
 =?us-ascii?Q?7mcF/DSRNxKdncnbfTsQpPm6w+gTsUy5AL0khg5qxgicYf4Ridv/atqhkTpV?=
 =?us-ascii?Q?GvF31AX6AvOu7nKtPL6Xk+imVjIMIMUrkNr2345HlMBhHuAQJz+wJagnTYf2?=
 =?us-ascii?Q?0MEWMk1+/w3BuauA/A5wZmiWng42Hn1ecOvXu8oxcjdx1sidg7yYTgFzvv7H?=
 =?us-ascii?Q?YXg1GU/1RZt7yQpYgLWl8BUsJ8sSz9DdWe5IJ7WzQZIpy+u+rbloeBwPbu/E?=
 =?us-ascii?Q?MkgMFegCP6EZ7mI0tW3y2/HI7Nb0cVFb8SquzNzLyf7wQ1nAClGLc0FnK5oL?=
 =?us-ascii?Q?f987kadBtW10ENILtcMyMmfzLZi9s1PXOmw4SOdrck0/DX9BU/UX9hTI0vpu?=
 =?us-ascii?Q?oJyH46SmPFXcx7GlFEG29UaO+VUdkNNS6soYwdQjS6H+uVT5QhNj7OMTtaQm?=
 =?us-ascii?Q?NIPO1JwYZB6GY4MEZDsOknmJh4OZ9ra6sPWDZTo3TxZ5fEebz4qg63njTSeA?=
 =?us-ascii?Q?Co4pGSPRAhXWnYyysot7W8Yw2mp+OGLlTfrDIvmTQsvlEOMSJSbOtrYB2LUG?=
 =?us-ascii?Q?IiUcsFM+wYldXg71Stukr139UcubGjv9vNvp4UcUTnyTWOuFNpeDSbY7Tpb9?=
 =?us-ascii?Q?eHZVW4WTMHL7cZ5LupzsPQfLOCiXC1o2qyJTzHmPnuS18B6+ZhrpDRZK+G4t?=
 =?us-ascii?Q?vGnugpeiiQ7eJVybSezY0NifJBKSeJwkuAIyKvb2lpcRrUL9+9scgNtJXpKL?=
 =?us-ascii?Q?zzvM+GSOUuezno1rqgvBP241B9oR2D9WQhzZISs8ZYVdPr8ddw1vLm9kFq57?=
 =?us-ascii?Q?+qqthpDaE0tBh+OoZ93QgRdM91cCBG7nKoTsT9cT3H9EAcY1I2rdXHQr7l00?=
 =?us-ascii?Q?Cripf0BZgcY2wEKJwdpIqgiQuTu6mN0i6DB6ku3es91HGvvnIV1pmYG3tGqR?=
 =?us-ascii?Q?Z5Sci7tC/xrAJs4DQ3X+gG6CfflckmJ+snAWh96SATTAjMqQcPSkktkgwqLh?=
 =?us-ascii?Q?jc808Znhulhlqixn3Off3uPC0jL/1u+qogBrssl6GF8O6Lv3naUkVyAAYhJ5?=
 =?us-ascii?Q?OfzhF5ody7vy2WCyrC+Hm8/Pj+YpVl5VlMKxLQF9u+zIOKsEA4R/1Pk5KFE7?=
 =?us-ascii?Q?yeQdm/nPXKQ9jpD58CHqW1Gg7REpZkJcBY/3qMhOa2VrTn7u5CF6OMuty9rc?=
 =?us-ascii?Q?f1aN2EVlxinApHu3lnMlkM7ax/u/wTALy1EdiOmADYzRKHUmKWo1DGGsYlxj?=
 =?us-ascii?Q?h0UpHa6wn/iYrIm4jCJ58l4N3evcVz60PT7F1VpTDl3ihvHGK2XS1w2MkU4I?=
 =?us-ascii?Q?SDkGYlA5zLqmmy8/LePwZ8kapelk2N7j9uMJu8gEnonMGOY79OrK4oxpNozi?=
 =?us-ascii?Q?vu4tOh8giP4aEyCjQLHhoL2qu21ccaUZ+O07riSUu3qt3UYgS36btzlr/WYo?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ecd3ad-7af1-4398-ebee-08dc42dd3df2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 21:41:57.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSXLZeAlbh9h0OotcoTlu7+nI0uCN+pQCj+thArj3fcILTAO4/ZNGydKDJw+TA/Jr/lgSL1AxPH1uqd4uK0wS/6cMk1XNsHRx2dqMu2rBpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> For the numa nodes that are not created by SRAT, no memory_target is
> allocated and is not managed by the HMAT_REPORTING code. Therefore
> hmat_callback() memory hotplug notifier will exit early on those NUMA
> nodes. The CXL memory hotplug notifier will need to call
> node_set_perf_attrs() directly in order to setup the access sysfs
> attributes.
> 
> In acpi_numa_init(), the last proximity domain (pxm) id created by SRAT is
> stored. Add a helper function acpi_node_backed_by_real_pxm() in order to
> check if a NUMA node id is defined by SRAT or created by CFMWS.
> 
> node_set_perf_attrs() symbol is exported to allow update of perf attribs
> for a node. The sysfs path of
> /sys/devices/system/node/nodeX/access0/initiators/* is created by
> node_set_perf_attrs() for the various attributes where nodeX is matched
> to the NUMA node of the CXL region.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v7:
> - Fix typo is commit log. (Jonathan)
> ---
>  drivers/acpi/numa/srat.c  | 11 +++++++++++
>  drivers/base/node.c       |  1 +
>  drivers/cxl/core/cdat.c   |  5 +++++
>  drivers/cxl/core/core.h   |  1 +
>  drivers/cxl/core/region.c |  7 ++++++-
>  include/linux/acpi.h      |  9 +++++++++
>  6 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 0214518fc582..e45e64993c50 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -29,6 +29,8 @@ static int node_to_pxm_map[MAX_NUMNODES]
>  unsigned char acpi_srat_revision __initdata;
>  static int acpi_numa __initdata;
>  
> +static int last_real_pxm;
> +
>  void __init disable_srat(void)
>  {
>  	acpi_numa = -1;
> @@ -536,6 +538,7 @@ int __init acpi_numa_init(void)
>  		if (node_to_pxm_map[i] > fake_pxm)
>  			fake_pxm = node_to_pxm_map[i];
>  	}
> +	last_real_pxm = fake_pxm;
>  	fake_pxm++;
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>  			      &fake_pxm);
> @@ -547,6 +550,14 @@ int __init acpi_numa_init(void)
>  	return 0;
>  }
>  
> +bool acpi_node_backed_by_real_pxm(int nid)
> +{
> +	int pxm = node_to_pxm(nid);
> +
> +	return pxm <= last_real_pxm;
> +}
> +EXPORT_SYMBOL_GPL(acpi_node_backed_by_real_pxm);

I quibble with this naming because it is not about "real" vs "fake" is
about HMAT decorated PXMs vs not, but I do not want to hold up v6.9
consideration for this quibble.

It can be addressed when / if cxl_need_node_perf_attrs_update() ever
interoperates with a non ACPI platform.


