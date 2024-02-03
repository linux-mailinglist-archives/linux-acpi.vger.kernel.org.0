Return-Path: <linux-acpi+bounces-3203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F5848006
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Feb 2024 04:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F4F1C211C2
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Feb 2024 03:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD40F9E5;
	Sat,  3 Feb 2024 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1w4Iwsl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8ADF9D7;
	Sat,  3 Feb 2024 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932737; cv=fail; b=O4iK5D4idx09Y6HV1Pi+XjLlKeeYe//3NtlZnF8+LkqAYVhpzlCHOENFXIJk6hX68/Jo/dWdzxzaOkP+pSkp05dJZdIGqp46hHF1phrAuG4XT/iy9g8bCWXace7l3ANEcVAm7P8dKMkuJf6oz+/zyQ63FjegQYxJZJRud2R31T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932737; c=relaxed/simple;
	bh=nP7rWBealZj3Z1Qxkv0iWxbb/xtv6hQaaE1MKJXx62A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pjin8QcGDOEBCEOtmRtH01m9MnrnR6AyTpqK+NzcERZbx7DQEiednBpDYxvaivIIhUk2YvSG8lLVEbpbjViG5xRohWxPxF6l/koJ5C4VkJm2eTgzhnVEqqPH8PcBhYcALmLL1eQywQqwVN6GDOVpwuL7dM3I/fElqQWH40n+OvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1w4Iwsl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706932736; x=1738468736;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nP7rWBealZj3Z1Qxkv0iWxbb/xtv6hQaaE1MKJXx62A=;
  b=C1w4IwslnRoPv1iIgCnmMrEVg52M2Ul4qj5wXgve4tF0e2guNiTqgEQb
   bifQhF285TAdF48KbyVekZ9N6vGJj9vzkPUbM6tEjRzDmoDt1vUMb9laA
   3/LmhzX/KynmXMCvUTBH+BZrOowqtx77VBPl+EtKomNw0oiLFlxy40VFt
   PnNUNMQPsRExgOMwJsbFugW1WRX/LOIcNSzaX+Te/mDPZSaf6DrE0rhKk
   MjT4qCanLP1+b6iaj3yyv57ugF0+HJmF/BvwJ2Oo7fDd8cBwJh9IhaEpT
   Ci06Fyh9B2bLlWotwtGCwasIFqnAUIEaU/mIcwj/NbEbun1tcRe/miL+F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="518380"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="518380"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 19:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="233942"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 19:58:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 19:58:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 19:58:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 19:58:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH/he5vwDWiGeeOxMcpA30XSaDv+5bNrkq3ZW7pieSOll1a3ufgknF6rP3+5viV8yd+NjsQ9W9AH39hidvTqgWNP62n24wYt0JotCj0WBraf+gQfSprq1bYJR8I0SMI/RfztNwFUO9J/oDw9zKyKjrqShATvDFkeBorpQe6EKRMBvg8OW92JTY3FcedJAPWSqb7jS9SN5ye7jOMNk+ZBmrKLAQsAPhtVd4lY5ZtN3Jlm5J37VSvKtJz0eL2YTqNMazuKKhIr6elMW4qxH/BKNh6JNacNubrbL0sycqn8/o54kS2adCNWcQ89Hh2tTUFq0GCVt6+4UGOjEZIGHse3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5w9SHyXnbIfqOEDyni5FfxlDtXudAG2MDM+xJUIqLs=;
 b=ByQzTa34dhPoz7cJTSc3kiwZY8LYoZGwvJ1sW1fGOWUioDai/IZrX6lWKzGoujNXA93xQU3Oo/UU19ptFwKO7ovGlJ7i3gnEegeYKntgLqrd0K1Uk47uxFCkGEz9i+R9OmJnTPd92nU58ns66sePOxG72JWcXO5CPXdJFCaezP5/0PQ0AOccYOPNa9T4eDvOnVYVDcBlXW/ZWe1/EkTyK26SrsPD2mZDYCb+/FmltD5VnueBPQj7PHFlG+3yBXbAsx3kyUHJFVXlBioXnZIzi3BYixRFz8iM6UW4pNWvnxgulfDyMd1bjvat4FfM+QPIaOWp5zBkZVqBw2sD4Kp7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 03:58:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 03:58:51 +0000
Date: Fri, 2 Feb 2024 19:58:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v10 2/5] ACPI: Add CXL protocol error defines
Message-ID: <65bdb9f8920f7_719322944@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
 <20240117194501.298233-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240117194501.298233-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 311a9c62-3ff4-47e8-4eb0-08dc246c6e8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O/c34BqD/e3bo8/DW5s47Fy/fGx2ikPtyLFnKM/qvoZEWzDuEbYawbYCd3BHhTlzI9bDKC8gBZKqkbU8Afaspxvfot+itbId6AuyXIvdSKhKz2h6TZIykpJ2pQvsE/xqeMNecotIIsDXZe1/9i75O2q7gFcp/O+VTB3t/OeOUtnO1HCSzj+rgWsHrjTani3VykCC2fLdJXNksZGMQSHQdGIw4LjU1b8WpTy/bodSY4tZVQPOdBlrv3VZDnb3cPDe9gUmiPZ/rQxaTB0kRDfHntlKVawf2IscsxWBwZRPhAG8QX+gMOyd8rIMyeyIHyKbth0A74R1H76B/M7h937brksYQ/1G+GYuGp860yL2HtUi19WbZBKdgxPcvWLayYk1EfGYDwkZ4nl8dM3gzDVr2X1Q7TzmL6crA3aWmPJEMm/TN66MG1xyM9H3sE0y5ZrSqJhLsBeDiQfs0NH91PcEQO6KV0zS4PQ3ocChsnD336vZLGblZ7BS6I1O/4b8UV8NOuFBciGpyUA7B6x19VGDToFNuGM/YqnbnrvZ6T+hkubfhtL9iITIfWLU6m66lRA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(9686003)(6486002)(478600001)(83380400001)(41300700001)(82960400001)(26005)(5660300002)(2906002)(66556008)(316002)(4326008)(66476007)(6506007)(66946007)(6666004)(38100700002)(8936002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tocEIXIJuQSXipVODGeQXCoD1Xr7umTe8qG2ceJuvrCnc0HiPyDfIx6/BPmP?=
 =?us-ascii?Q?RZeTelO91XxcHwX4UMwu0OLjUDkR7+t/VF9lQVrUj4yyeOcddMze4HeacMBB?=
 =?us-ascii?Q?rgPrfZbmn88LexX/JzVvb78bmix0VO1sU7VJE40gFTKnN5bBlWnX7IF3L4zo?=
 =?us-ascii?Q?TjtB0DCNXlINFqNdmHnvBbuR2zTlQ1hgDG7swYss6XVP5ZKWm6J5szUhR+t9?=
 =?us-ascii?Q?RaQ6iceUTtDwNDpxQBlADMW305xfwnmseDYq6nsz7sZbVBEZySeW03N80Hbb?=
 =?us-ascii?Q?rmYFOY7dW82ofpRRY3mUaKxHL46KLOgKDEGQKT8gOXC0uIQTe6tQgQWRLhQ9?=
 =?us-ascii?Q?rPqZCQhxF17IbXxtcTUSJtT0tcX88dUuJqsiuwNOQk8HzHdWAejq6Jo2wZiG?=
 =?us-ascii?Q?0KP95gN7OKQM7Gu7zttiV0HwqbM7dX45iApX2QWdnoq0JY0aOYA5Zc3UgZ9y?=
 =?us-ascii?Q?JMgxdfmJUex0VXQNAjuR5LBBuANkwKQ4TLbR9uces9RjAviVuE5e6PuqrGgd?=
 =?us-ascii?Q?VGc8J858hHKXxrx+6IGFyAR7IeUUGCCODUsw4ChmfMaPClztrCbK+mJgl0PX?=
 =?us-ascii?Q?F0FCQ7i0AszTKbnF6xnGqHVWBmHyhlfUJbU+quIQBrRsi4WyPQfEA2fyaJTU?=
 =?us-ascii?Q?4EbfiKJHhIGGs6KZa7Ya8LbpoMjFMR8VKxLGzbmjHo01MwArjjAbLG2DDpEg?=
 =?us-ascii?Q?+3A+n5zATKH21m5q6zpz2LNcYVec3JEjw7Oi842yAZKjxaKb9OqMgtiNe2MN?=
 =?us-ascii?Q?f3Hx2zUCgDz6NRYA4VP68vDeabmMBaWIzSnFNzxhjOvgtYpLStr1h5VtkaLj?=
 =?us-ascii?Q?gfp0Wy04acnfsfbUgfP7A3i9RePLNC8mgjdvECFiR2fW3srOZQardXFkvTrG?=
 =?us-ascii?Q?0GfQqVH1EAlfdcR1cCFjtf4Ez8kQ2BWuGjPC4fbp42olj4DKeS8IE4wbt1h+?=
 =?us-ascii?Q?aG3D4ms8JeILii05nFmbLXe7cC8Zo+w4reDjrZJ7Fa/UP5bkTVnPG9YfS1P7?=
 =?us-ascii?Q?t51mF4GWnd5Bo6gzcqVozXOjx5JWjcanqUG7XzYlw045+h5t08LL8X9prgIk?=
 =?us-ascii?Q?RhKAVZwjf1MkJzVaZh7Mr0vCLFLFlmh/c4Uo3u4mI0Ze6LkCA/40iy8bq1rX?=
 =?us-ascii?Q?/pUI2QzJ5mMPVWvxN+SztskEsnlfqD8g7oLcYVYQ4f2RV18k+BB0SUQCdfyR?=
 =?us-ascii?Q?UXNWmjdFA03gOV/rpTx0SxX3z/hYQVsINxwcUs1gu7fMJQHl2f5HTyOrFMev?=
 =?us-ascii?Q?0ucmVgOGE1yZ7wQ4HZJ7De8+kSTuIhDTwr3uHIOpHB4mEcl+O2Lci9Uxz+9D?=
 =?us-ascii?Q?wAMtlDGYryKsvNOqE/2gajUZ0FzbmFHV1aHBMlVkN1jtL/Srxeoth6ESa3Ko?=
 =?us-ascii?Q?zOHSdHdGf8YM8DWteLIA8TvZNvCMHsLU1K14lIIk5XXY923CZs5jzMGotSFx?=
 =?us-ascii?Q?JAVDb4HEunylRRAEyH5STlf/bWXM5SLfVp4Vc/Capz1jzv83b6xhzqDlZol1?=
 =?us-ascii?Q?tobwB4pMXTvKeAH7UEN7P2EW7kjFG5rOfiTW+h75uU5dn1jZkC0ZO3n/siB3?=
 =?us-ascii?Q?gb+2UEalC+tkmHAtir7C6Lg3PXfI6Tw4aNf51DW6JHyz51+54ncbIn7XzsAS?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a9c62-3ff4-47e8-4eb0-08dc246c6e8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 03:58:51.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl0y3TFDYAwb9oYzipOF3BL/kTeY4YyIJaJgPkqxXH4aQiJy+Td0ubxzfVwHpT3w/DqZfio+QoiKSeCTvEz8FSY1g4b0NeRccnt7awmt4NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Add CXL protocol error defines to include/actbl1.h.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
> 
> I made a pull request for this support in the ACPICA project which has

Hmm, it has been a few months with no movement and nothing in v6.8.

> been accepted (link below), so this patch is temporary and I expect it
> to be dropped once the kernel updates from ACPICA.

Ben, not sure what is happening with the ACPICA process right now, but
since the ACPI_EINJ driver is the only consumer of these defines I would
say that in the spirit of the policy in "include/linux/pci_ids.h":

"Do not add new entries to this file unless the definitions
 are shared between multiple drivers."

...go ahead and defines these locally in einj.c.

#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
#define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
#define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
#define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
#endif

Then you can delete them later if they ever get duplicated in actbl1.h.

