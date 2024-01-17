Return-Path: <linux-acpi+bounces-2908-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A267F82FDE3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 01:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F64B1F25E27
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 00:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED7D17E;
	Wed, 17 Jan 2024 00:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d79/+Ttk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C7125A2;
	Wed, 17 Jan 2024 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450006; cv=fail; b=D87Ssru/6ylp6gJjGHMLrYSNAATA/uQpLyNslI7+xj7dA8TOCIe0fa1oFtWi80rXvrEUWE5ySKn/HqhnVpoV4C3WqdUmobMF45xRuCZNudfCZdJYls6nAMieADAIc8hXBlyLm27PP3SITzQyyXZg2zww9k+9Dz1nPWg7D09E2KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450006; c=relaxed/simple;
	bh=mIDXREApnMXipfTavqD8zOnzM6e8JvHWfiCesVy1pTw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=bbtdPp87N9fDuKYLOy+pgsOxM/cI+DkMsx0/mIWyFqgjj3HZmgMXjGBrpWieX0tflAxe4xLoSWboalLcu62KqngAlM3Bni66PhtV1a5oE2/2FXLRXY0yvy/BjC2jQyBsG1Z2LPHgyKp8MgWPGF/HxwO5D4bMRgPbrwXSYrsEspc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d79/+Ttk; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705450004; x=1736986004;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mIDXREApnMXipfTavqD8zOnzM6e8JvHWfiCesVy1pTw=;
  b=d79/+Ttk55LcT+fjYDqGrsOGk4DfK686bu1TNDkxeeHF0Hr+GPGuOBA6
   iB7u8ahErwB56sRnvjv/XcTu2oA20yyw6Lr/YJQVlK8vJmfELp1lKKpiq
   BppI5XX5wIjpKM57zfLT3AWdj/Tvoy2JqUcCJZ8teMD1kA9QQ2n9zk/sw
   gtAiKspHGjkiBte30K04uZ9jEuyz+Oy6blldNyiDIwCJjDpkilMZSnTfj
   /86AhGrvH6TGNneu/FJl/ZNAivdBIMvZhn01Et6T37qL1i4JQM0GvCU/r
   cqfXDTCFq/RnejZWr4lUu5g5DlhlbCT5YIRn7dctgck0oESU77Tk6Pd8/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="403780780"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="403780780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 16:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="927667758"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="927667758"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 16:06:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 16:06:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 16:06:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 16:06:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7m8QJ0vce+3GieHmjDu2IHLLiBMxWlnNSxI9Nz2JUgco62tJ+74GhUuXowwZK3O4dbqaB34bsn73UTBWVUd588/8S2hOR6VC7eaPeu88VThgOocgYU4L6Mv6x9G49SXBGPU7w3urVKZXOdBf3ttf4qidtuckndZvzUj70UlsyXOLHlWp/Lm8+aQcp+JVXuxpzPn/DzLaapcSAyNJuTpz7JXZwxO4yfEDA2RuI7xMsIyWC9NRZ+ZCHqh2C+nZ3Hk4qk0HFhdHZAbtfGUFrblJQmHVRFempL806HNaVPf7mTqmWwhIm2tkDoio6qCtn7URV9KDDfbst+kPiszLgSkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQHtYAIbXRRMGk31Cs2lO2yUxPfD/vyL8fRI6o5GP3s=;
 b=MuOVwF57x8fFRDRyEdiyrOX9Imf2wCaGV2c99X9UBSMMuzwokdfkOoOJpAgXAWcarRmtcJvf+tdAUS0S2D6KZvLi3RsxxVppuvAwrTLugHDCDBUlLDUM/tg5NIJ1X7zv7mTMm+fCX2U9jh8VYimb7rA3hm6179bE0dxFf2udcgJiIBX4Ef9f/3bcC0artL4zokrybLuT5MwV1N3oT77Q+xEOopMbBRhcDaffwCKSiIhVSt7hwFlJY22vC/K39tooRqePyid42BIZF+50Zq1Ec2Lwy0ZtJQNKSsJy3STCdNODAO4c0KybLSeQ6tCKyLD2kQaCucwakpmS2QfpcaI1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 00:06:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 17 Jan 2024
 00:06:27 +0000
Date: Tue, 16 Jan 2024 16:06:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: RE: [PATCH v9 4/5] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65a71a00544b2_3b8e2945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-5-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240115172007.309547-5-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: eb01e4b3-d751-4f97-15da-08dc16f0264f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0DbkFJncWTx+ElK4TgoiBStrEF8cr4KXuDrDed4lYz+gEnuiDHbaoaH6lI3+hX2DJiUUS8t/Oi0sYPH2UOJQV3D1zhEc41q+GRvW9H1bzGQ8nu7syWH07VgH+s720eHU4eA657xohginNXW9wCxuqjFNjLWuGpjs6uqIkZIKpvhIwCng0T7oxtBsQWxBH3SNdRC0oFAtSqFRITx0N/ATRO3a2NvD8td1xrcPYfJOvbAJOFFVexH1dKHI7Ldlsexz6Nak+UxIvpUpU18+4qn+/0eVybrPHlj8RmtaLpFoakXaIVLneFUUQSTRvVKiaZhlg+Mf/ZQ+iel+yW9IawtySCTtg0BPhGFHRUPSVA3YaTv5pkljEbIh6WOvENIvdYKiz/yPWWM/krBpxRQY6mhQbVjC92KsnGI1iBLYiDERbtLo250sYmaw4ofr2jGw4InlDpY9hXrfrzyiPc+vVmtUDzHz2EWri03fBBqzRm4aZnEr5DJXcOIFbRk2xsW2omxTZcs/mcq3aO+NGqFXQulul6dwEtKxI9HupUduR8h4xovPaIyKxxBuZXqetitUr8f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(83380400001)(9686003)(316002)(6512007)(66556008)(66476007)(478600001)(6486002)(66946007)(6666004)(26005)(4326008)(8676002)(8936002)(82960400001)(41300700001)(2906002)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4mQDxW32dTxkBxa1C2nrM8zbTz5FOdhGrEkufDOqc97vPEHzbDW2+m2k45y?=
 =?us-ascii?Q?m2LSwg91hOPG7ID+Hr1B8r77OVLIKcUKFCm/L7CsMF1Kvq9Yn69IqJQd17Sm?=
 =?us-ascii?Q?RVJLFMxWO+Ok/GW4ZIOs3iT3O9RhL3q7ZLMgWKvJLVXj+h5buePBnWNAenal?=
 =?us-ascii?Q?ZANSF29Rri6iXda0z3kJZk7+09HhO0xsvJ9vRAST6Z7PtSYgkxnkhFCSiTkI?=
 =?us-ascii?Q?kdLZpoJOdVs5zureJ3oRKGphH+k1K27nzuJQ1wGLS7JeQP8TP6f1bBHZ85n4?=
 =?us-ascii?Q?ap3YTooRS3lp1a6Ha/NwXHE5hCHjmhByIFCZMz2RFMD2po8qXtHQS7JE0DHv?=
 =?us-ascii?Q?UQdUbe/PF27YNSkXmYT5EPHgAQdSUZ2vzUb6aSCGphu3O3ns0UmOLWlPv95e?=
 =?us-ascii?Q?f2MzAQ+HFD2feKv0anVTcSfPySb3PIuNqC3e6pZcLnq6VzjF9ylhEUtQF6mU?=
 =?us-ascii?Q?NZtuklNhD6S0bgtEqu8bnZTpRcGXLyhj3luLIUJ4p5ic3TF1gOrF7txoLhgP?=
 =?us-ascii?Q?otVXHG4mediHl3ZFe7MyeLU/5LZERiZnjZhOjjiUKBu2daezLb9fhQKpJCSr?=
 =?us-ascii?Q?4wmQQnHGhEaN/gjSZJdFkPUbVHvOCqmIR4mGFtswrFZ29BrqnzttuS0rqUar?=
 =?us-ascii?Q?x1hDzt35uKx085C/vQ2jm4ivsO4c9icQWywKf6jsiKVY6z3eO/HSaWo5oj5/?=
 =?us-ascii?Q?UgQhlGZ4FVa4O7lCfqo7lf5o3U07qUx7C2MIvEmAsrXWKIdlM515Ai5Ysjpn?=
 =?us-ascii?Q?pmg06+BWDzDZMNoZ7BYzlagpkQyhuEMTYGEad1Fjmk91qNu6xNaE60SAe3ac?=
 =?us-ascii?Q?jnrFkJyH2wsIG7KYQrjciZI63zfi+lIN7Qqt4TrC/QjWCjWC5Y9EqENudp5J?=
 =?us-ascii?Q?EPTq3ewKA8syLGyLYbx5NtmKL/euoRDEG/jNpsh+U2XjqaIC4L/k0x8ycgjR?=
 =?us-ascii?Q?Y9oTJdQrogALOl9JeFB+PNiUmeXXWbcAyBeAmox9MbOC8Gq3fBoEgZrMD7qj?=
 =?us-ascii?Q?0lT400kdoGN3evIFAwohzn0o95oZc+aTWMM+tiDCPFawAhM+MRj5F87sZmjF?=
 =?us-ascii?Q?51xwOd2iogwSHxtedK05hFYOuDL07bIcuP0kyqQlzg6hMWPzLStpFfgHQQZd?=
 =?us-ascii?Q?hNybjNeRzB8rTrZiKvzekqqDlwg4AFHIqhorLmP0kn7RudCFFC72/mA810qY?=
 =?us-ascii?Q?ssJ+AaZ1w0T/mE+Hilcxfy/VU6wkeRn/7hdAyy9ms2VkNwCMD1og5zJtv+/B?=
 =?us-ascii?Q?REC3N/DgweToEMKivF4F2KlO3ltuzWQoylkZmrIf8i6lq7CcA3yTF1wcYLpX?=
 =?us-ascii?Q?BAUebwrqSy4mRk/oYFgLQm+cF/EaM1EOjQ+ekydffgkFbgcFbOq4ghoElVi+?=
 =?us-ascii?Q?ET13BwhQsGIO97r2CThBDXUcHEYJFcBRkNRTEIzAGUtGw9iJKffZfr/JMh2A?=
 =?us-ascii?Q?WXqlcpxB1YRbfe6pabapBznPmWul4yfL0le+CcEvwCMDe/skBCqNKn9Bex2H?=
 =?us-ascii?Q?aw2xjKJBYUTM5zly/mPjn9zNNohyhLprrnpdTfH4fulYT+k+uRoyv9pjlg+z?=
 =?us-ascii?Q?8U8SdiiyxbLB/GY83aZkdgk4if7iHHTuTgGLYd0pt82AzpKC7mVKGavThVOF?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb01e4b3-d751-4f97-15da-08dc16f0264f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 00:06:27.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUOBz+2Yk9mE485EeDk2bCyC5zUGxPIm1vwuYNjSXcN2HSgTjSmWOI4EVlh16Z3ajzZgHgVhRKZgDBdHpANXMjnyA1Hlris2YnnD34jbBkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Implement CXL helper functions in the EINJ module for getting/injecting
> available CXL protocol error types and export them to sysfs under
> kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>  drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
>  drivers/cxl/core/port.c               |  39 +++++++
>  include/linux/einj-cxl.h              |  42 ++++++++
>  4 files changed, 237 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index fe61d372e3fa..bcd985cca66a 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -33,3 +33,25 @@ Description:
>  		device cannot clear poison from the address, -ENXIO is returned.
>  		The clear_poison attribute is only visible for devices
>  		supporting the capability.
> +
> +What:		/sys/kernel/debug/cxl/einj_types
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Prints the CXL protocol error types made available by
> +		the platform in the format "0x<error number>	<error type>".
> +		The <error number> can be written to einj_inject to inject
> +		<error type> into a chosen dport.
> +
> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Writing an integer to this file injects the corresponding
> +		CXL protocol error into $dport_dev ($dport_dev will be a device
> +		name from /sys/bus/pci/devices). The integer to type mapping for
> +		injection can be found by reading from einj_types. If the dport
> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> +		a CXL 2.0 error is injected.
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 10d51cd73fa4..c3ec03583946 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/einj-cxl.h>
>  #include <linux/platform_device.h>
>  #include <asm/unaligned.h>
>  
> @@ -37,6 +38,12 @@
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>  				ACPI_EINJ_MEMORY_FATAL)
> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_CACHE_FATAL | \
> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> +				ACPI_EINJ_CXL_MEM_FATAL)
>  
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> @@ -544,8 +551,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> +		goto inject;
> +	}
>  
>  	/*
>  	 * Disallow crazy address masks that give BIOS leeway to pick
> @@ -597,6 +607,9 @@ static const char * const einj_error_type_string[] = {
>  	"0x00000200\tPlatform Correctable\n",
>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>  	"0x00000800\tPlatform Uncorrectable fatal\n",
> +};
> +
> +static const char * const einj_cxl_error_type_string[] = {
>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> @@ -622,29 +635,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> -static int error_type_get(void *data, u64 *val)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  {
> -	*val = error_type;
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> +
> +		if (available_error_type & cxl_err)
> +			seq_puts(m, einj_cxl_error_type_string[pos]);
> +	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>  
> -static int error_type_set(void *data, u64 val)
> +static int validate_error_type(u64 type)
>  {
> +	u32 tval, vendor, available_error_type = 0;
>  	int rc;
> -	u32 available_error_type = 0;
> -	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> -	if (val & GENMASK_ULL(63, 32))
> +	if (type & GENMASK_ULL(63, 32))
>  		return -EINVAL;
>  
>  	/*
>  	 * Vendor defined types have 0x80000000 bit set, and
>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>  	 */
> -	vendor = val & ACPI5_VENDOR_BIT;
> -	tval = val & 0x7fffffff;
> +	vendor = type & ACPI5_VENDOR_BIT;
> +	tval = type & 0x7fffffff;
>  
>  	/* Only one error type can be specified */
>  	if (tval & (tval - 1))
> @@ -653,9 +681,105 @@ static int error_type_set(void *data, u64 val)
>  		rc = einj_get_available_error_type(&available_error_type);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (!(type & available_error_type))
>  			return -EINVAL;
>  	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> +{
> +	struct pci_bus *pbus;
> +	struct pci_host_bridge *bridge;
> +	u64 seg = 0, bus;
> +
> +	pbus = dport_dev->bus;
> +	bridge = pci_find_host_bridge(pbus);
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		seg = bridge->domain_nr << 24;
> +
> +	bus = pbus->number << 16;
> +	*sbdf = seg | bus | dport_dev->devfn;
> +
> +	return 0;
> +}
> +
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	param1 = (u64) rcrb;
> +	param2 = 0xfffffffffffff000;
> +	flags = 0x2;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
> +
> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
> +{
> +	u64 param1 = 0, param2 = 0, param4 = 0;
> +	u32 flags;
> +	int rc;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	/* Only CXL error types can be specified */
> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(type);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dport_get_sbdf(dport, &param4);
> +	if (rc)
> +		return rc;
> +
> +	flags = 0x4;
> +
> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> +
> +static int error_type_get(void *data, u64 *val)
> +{
> +	*val = error_type;
> +
> +	return 0;
> +}
> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	/* CXL error types have to be injected from cxl debugfs */
> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
> +		return -EINVAL;
> +
> +	rc = validate_error_type(val);
> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8c00fd6be730..a41618ce380b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -3,6 +3,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/memregion.h>
>  #include <linux/workqueue.h>
> +#include <linux/einj-cxl.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	return rc;
>  }
>  
> +DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
> +
> +static int cxl_einj_inject(void *data, u64 type)
> +{
> +	struct cxl_dport *dport = data;
> +
> +	if (dport->rch)
> +		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
> +
> +	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
> +
> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> +{
> +	struct dentry *dir;
> +
> +	/*
> +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> +	 */
> +	if (!IS_ENABLED(CONFIG_CXL_EINJ) ||
> +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
> +		return;

Perhaps this IS_ENABLED(CONFIG_CXL_EINJ) and the one below should be
replace with a helper that also queries einj_initialized? Such a helper
would naturally have a static inline stub that fails in the
CONFIG_CXL_EINJ=n case, and it otherwise behaves the same as the base
ACPI case where the debugfs files do not appear if init fails.

