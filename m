Return-Path: <linux-acpi+bounces-3353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80E85078F
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 02:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0541F218D6
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB515B3;
	Sun, 11 Feb 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEjjjDVX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3981627;
	Sun, 11 Feb 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707614157; cv=fail; b=qg78lZApFCXYuOI9ucvym5HbVwE/0zUKDdmtQekaKkiMq7pXOq/FGOnEF/MUm0OJrjXP3cHc1QkAcshrC+n2+ffx38lJEKAElUAofXdirqDu4mHniEM7Sjz78HIuN9+b8RkoUleB1E5tWfv3rJqwz1ewmNb77W3SxWaH2FZQROQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707614157; c=relaxed/simple;
	bh=63Y+yAUDpGq9Gq40qSwjFAneeIkECueZ6PLwAs3M5ZY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5jt4t7WJGsUJdFl78ZLp13fro1iVM5WPpTxRGH8F01e8zzoR2dIOKd5npVakWSDILAbhc4I38V4IfMve6yIBRIcg7mI0akju2we+ibRtZaGeGhipPVP2L7PkoEVgToFq2rsov8/QH9FmK5e58rTnAWsmpuH+1Cn+hlGZQa0c2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEjjjDVX; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707614155; x=1739150155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=63Y+yAUDpGq9Gq40qSwjFAneeIkECueZ6PLwAs3M5ZY=;
  b=EEjjjDVXCsEmMe5IMW0uTclj/GxwTAkDCgo5uBUSbG7WdEGJCZRwhZ6b
   sQkRMCGaJ+HkrYzbeRMQ+HB3QbTOCx1yMd8ZSKxV8dyi1css3S7I7dYFD
   YC7uoRDE3YMHAtdmybth+6akIUDF8qGEHCP+o/ro6QZ1MHAl4iTy1Xk9t
   Hoyvw8fVUstAr6IVMoObXxdnZhQhAB+P+pKA+d2aNJPs8qtIvZqBvncv9
   0Jaeg0Wz3yWecs4xOPb1clAoLUs3nLjDMnZPSwCOIDeZCuW1asigiEzBj
   lDBVDoDb5GBw+4swVkECyoEDPlkyo3KxmGzHFynDoQ3i+tMu5iQ2boHzH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1751789"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="1751789"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 17:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="2476665"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2024 17:15:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 10 Feb 2024 17:15:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 10 Feb 2024 17:15:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 10 Feb 2024 17:15:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYrF1DcFQaKBmaMtLbKBocW9ibFwz/L0dk/db1pbd+xMWxSuPlJOISJWpyXCkfudQOfm8WJlfagy48ZLP7PCmaJ8KgIthfaYugqf74lzSsWRRp9/vdu/sxv9ATYYnWwvZ7VSskIb9/A8lWwlxzVTGaG5LF179DYGWC/YyMxVPBTPeuDhJH2eFNVZGKxC5NK8NMkndrXXAfTmOwBxtrQucszQ23HrrlVCdN3hZGkjC5RcAu2SMl+vaLnNmsLvEDgM+hWpmqaAiq2A1qTvKPJrExFwi6sDnwr/3dykBe2rehDIMUOqNjOIO1NDPBhO44vun9N0ZTpejmYutnWZfkydaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c45G8e59/Nge0dnk7wWu7e62/fuDIqoQChg2BRRM7xU=;
 b=cmQAXLtYZZgIvjs8S+2WzUkI+Su3yZElmPQfipaunCGP5fjEZ6qsKmkhWGM2J87PLBBR/OdmTfos3pjgp/bK/L/guo9ePCqdrfOa8vypa84jVzQVR2ZJe1BVtNrhuNlymsFZYpdQak+QwVC+/Rqy/RcBALO8gv4BSDjtsrsvIbNgPusHlpnk272L5QH0eUElM6ImEAxNU4YuyEPQN0cZ1jl75sPGdH8wze8Av7Tw3imdeTkYOlQ/i7EKBVDnLIkGwKIu3ERQU418DPiBUjrQSmR+XbmtM6KHkklE4NsRcOcC3FtRxrhI/L1S45rXuv2TOZHhBZjL8wqEWcpydOE6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5417.namprd11.prod.outlook.com (2603:10b6:408:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Sun, 11 Feb
 2024 01:15:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sun, 11 Feb 2024
 01:15:50 +0000
Date: Sat, 10 Feb 2024 17:15:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>, <alexey.kardashevskiy@amd.com>,
	<Avadhut.Naik@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael.j.wysocki@intel.com>
Subject: RE: [PATCH v11 0/4] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error
 types
Message-ID: <65c81fc3d3b6c_d2d42946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aabd06-7230-49cf-f2e9-08dc2a9efc45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WtwPUsYAglSHtgGIB6Y4FjwM3UyIBBSg1xY7hv6An4P7tVqUEKupcE7kW5XTmvc0xQon7Hf9u986r2JenGXdk0rFvIY9jcSkwox/RoTTmDKLW6ekl3N4gLJb9S0TkYl/csEv77nhwuAC1wsUN1waWdeZUyzVpdGZnd077x0I+yocTnsG7+wMfzQHjxXJvlH5J4UUDiEt3AW94ETie28e38EZZag84whnlxg61D3HpwwZcHlKwHhlDUbhdSpyBAE2lVbbhSRUbxc9p3J5+GLBVfT96Dk3PZZKQ4aQ9NPHWSoCz5JOKK5wxtyeHbMLGrlQidoD/GHzDkYE/oXvJAzP5RnucgG9rlw7sU0LxMWpEKNs9S1SyfYtHAuTdIBZLFfdYq8NQq3bs6OTLzd45ebEU8WfiP1wkaWkI/ofl498qWwyXaPVc62pgj6nzYs93WWmTPfl/RelrfiV0KMdiHJRmh/UA+lr3Pe6yTVY7cBaBKquEkdxtqX2b37X+ElKocEbmStniCqidbM9sQ3gMpxFBqL3P3jg1TMzuK3DARBP9zn7Q49cQBI4pCRerkPx9Jb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(86362001)(82960400001)(38100700002)(41300700001)(2906002)(15650500001)(9686003)(6512007)(316002)(6666004)(478600001)(6486002)(26005)(83380400001)(6506007)(107886003)(8936002)(8676002)(66946007)(66476007)(5660300002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8W3aerQv55DJ/w3OhCHQJ22rKRRfPiiePFpKGVDu6vMemuacDsRjF+Sf/k9I?=
 =?us-ascii?Q?usD5rw2DqYHweXM/GSyRTdoiaQUBAcibBeCWcW4GBKadZuTswviUuc13jgGq?=
 =?us-ascii?Q?hqFXtGcMXIPICBSCpLnlcBKLkakhVszzPYXftonVjbOSGUi5AGtwUI6SY0u7?=
 =?us-ascii?Q?5T3H3uS0GKGnhqge/1lT/Z+dxbVo+XJkm1tRpGqZ22S22dYzFmdRSPc0hbKC?=
 =?us-ascii?Q?ChTY2A9oJ3NxLUpIVki1pA50k6dwL3olH5aJ8CUxnFyJQm4ASNL7EjpPoUuH?=
 =?us-ascii?Q?SS5/ff73ZJy15Pb3hlIlD+YTc8Ch74qgQunMHnZz562Zlcc1fMQWOP2SCFlU?=
 =?us-ascii?Q?N7uFG+fr9tLyBgiqKiFARdF50GMxp58N58cFl5greop/35fvM2I0lpDdbyef?=
 =?us-ascii?Q?RZdQoEq0yM3A3CiJOr1B3NhhaTc6E9Bf+HiyuDF+doR6kjkh33Ixpc9GADGT?=
 =?us-ascii?Q?S+wLK6UkdpTwWb4ABqy333ot5uPpOF2sElhNAWm4TweNUMCWZTW66Dh00RZ3?=
 =?us-ascii?Q?jNw2ASrwMZgt8rxYcvyKAAwLhNAL+bdgEI1ih8zRoItpFPUVwNCRVRa3XhHE?=
 =?us-ascii?Q?IWHa6JY68TS7oak+t51ZxfvY2ZEJdESAicQzhN7YSPSzB6V28BOnrW8zxXBI?=
 =?us-ascii?Q?5OkKX3nhFlMOPL87jwRgIiXN3V8k3dcarKwNiJxuZHBmEjAz2Y97I5Hlf4Fo?=
 =?us-ascii?Q?JDbt+8buhxOfIhLrKQIDb7iYFrGB5YaiucsyvicDbMT2plwu/k6IGAO6abeY?=
 =?us-ascii?Q?zqYofQI1b6KuDZYOeirtZ4M6KyhirMsboVNSUeM4Xv5BJJdHdyiLMkYq/fMd?=
 =?us-ascii?Q?7I+yHx15TCdcnFlagjt/TJF9PpEXk7K8p1GsvBlRjZm3ByWsHUHa6Brbdsfk?=
 =?us-ascii?Q?Tc24HVZLeGH9MrbQ/oMQ888KOX0xb8sAkRSkL1TRoan0tQ8H2bYjfEfJF+JQ?=
 =?us-ascii?Q?PRu7u4De2PLl6Mv/14mL3dkKLQd2yKAFNY2RkNSP+e/lUYLnWjAJ18WHe5Pd?=
 =?us-ascii?Q?PVrLNeyszfksNfdFLd9QW6hHuipOJLHBEouRkfV7F91Ushi/WZulyxOnPXuB?=
 =?us-ascii?Q?hn/WNsJU/vqwaFeHRzxfEBHxGfKBCOwIs4zlcuuz8dF8V0/3esRrnTMh9sDE?=
 =?us-ascii?Q?UqLx9EdvDvhKsk8xvLIeYryanduIETVQMxII+btoGW6BQo5SATLZOWakH5MQ?=
 =?us-ascii?Q?1IqNcMUKle1WqsUWpawzBDF1Be2v7C1OFtHhG9KTrVt8VniZvDlvFq3qFX6C?=
 =?us-ascii?Q?VCifi+h5/I+NdW+OaRR8Jm6TO0MmGwIHKdv8A47IlKxaBSJlFdxqrfc2ABzn?=
 =?us-ascii?Q?4cgsyUtAtgNM635ubdRaB/R6Y/nNjHkp3ZhDLVngDbdvxrDdnYC4CMArUld4?=
 =?us-ascii?Q?+CO88B+L+zoUoOzIVQq71kqWE7QhmVXCmlD4mbQRPVs2Le1Lpv3cWuj4xrDN?=
 =?us-ascii?Q?dIvQIzUiuTnbbUYLQqac7doHInBCwrlxmVktLkd7PNarJKUnlF6FeSDAD/0V?=
 =?us-ascii?Q?dkLUS8Q3opkDGnkFqFwRg3FhIRuodV/gGMAav+fz6h4Zlpg984qS4A7eAQvb?=
 =?us-ascii?Q?ezWKO/JSoe43s1pmY8oD/GyvoAbaDHWaJgZ5Wn9EwbOT7wSq58eZ5RqESUI4?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aabd06-7230-49cf-f2e9-08dc2a9efc45
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 01:15:50.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n69xRDGdH16lREwM0hzfbVloH0fdL8J3gW4Ea+Vng8PhD/LCk6saHhGjckLry5q+3kdnSQQE36uPQcJpHa8+xrKi7vpPd0LeDqh/xXGxO90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5417
X-OriginatorOrg: intel.com

[ Cc all the signers of 709f3cbd652e ("ACPI: APEI: EINJ: Refactor
available_error_type_show()") ]

Ben Cheatham wrote:
> v11 Changes:
> 	- Drop patch 2/6 (Add CXL protocol error defines) and put the
> 	  defines in patch 4/6 instead (Dan)
> 	- Add Dan's reviewed-by
> 
> v10 Changes:
> 	- Fixups in EINJ module initializtion (Dan)
> 	- Add include/linux/einj-cxl.h to MAINTAINERS under CXL subsystem
> 	  (Dan)
> 	- Replace usages of IS_ENABLED(CONFIG_CXL_EINJ) with new
> 	  einj_is_initialized() function in cxl/core/port.c (Dan)
> 	- Fix typo in EINJ documentation (Dan)
> 
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped downstream port. The value of the memory address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
> 
> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
> Instead, make the error types available under /sys/kernel/debug/cxl.
> This allows for validating the MMIO address for a CXL 1.1 error type
> while also not making the user responsible for finding it.
> 
> Ben Cheatham (4):
>   cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
>   EINJ: Migrate to a platform driver
>   cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions

I think the above that go across cxl and EINJ can just be prefixed:

    "cxl, EINJ:"

Also please rebase this on v6.8-rc3 to resolve a conflict with:

    709f3cbd652e ACPI: APEI: EINJ: Refactor available_error_type_show()

That should also allow you to fixup the missing ifdef CONFIG_CXL_EINJ
guard around the EINJ driver exports.

This needs at least one "non-Dan" reviewer for the ACPI side.

>   EINJ, Documentation: Update EINJ kernel doc
> 
>  Documentation/ABI/testing/debugfs-cxl         |  22 ++
>  .../firmware-guide/acpi/apei/einj.rst         |  19 ++
>  MAINTAINERS                                   |   1 +
>  drivers/acpi/apei/einj.c                      | 202 ++++++++++++++++--
>  drivers/cxl/Kconfig                           |  12 ++
>  drivers/cxl/core/port.c                       |  39 ++++
>  include/linux/einj-cxl.h                      |  45 ++++
>  7 files changed, 328 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/einj-cxl.h
> 
> -- 
> 2.34.1
> 



