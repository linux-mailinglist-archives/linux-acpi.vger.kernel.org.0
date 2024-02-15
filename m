Return-Path: <linux-acpi+bounces-3513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B2855902
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 03:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549A11C21A5D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 02:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BC17C9;
	Thu, 15 Feb 2024 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPe99Axh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F71864;
	Thu, 15 Feb 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707965620; cv=fail; b=V9Rq+1FllsYqpESu8sf+sNbvOiyUEZnNdgXQnYB17+TYy9iKyhY2AjM9gGItMTAmOAvXoda2gumjv4+1NSG1oY6COlFonWd1gdvDhUyoMLESlRR77V0RqmyQATcAolljdYFRRR2a1yE9gUAr32iVMQTWiomC7Scc5gJjVo7bZOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707965620; c=relaxed/simple;
	bh=+A6NwESXRKlA9rXF15228utmlID2ufsdS35LKwqSxjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fNdSSVK9lAO9cLXACKyR+qnrExZ7ruEzkmJJrDGObVmfla9LsLBP7LuAWdnolH7MlO19vN6sc1T93gvXbLu4DfQFh8p1/c7EyWShRCK5nYPedDtu/kC1skRPeIQV3L3tX+XTAgRXEL0UuvHwg0MhyI8ICyyYUKvTF+qCo+3oORQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPe99Axh; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707965619; x=1739501619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+A6NwESXRKlA9rXF15228utmlID2ufsdS35LKwqSxjs=;
  b=WPe99Axh8VNU0NyenbrcvV6LggiuL6nQih9nNvtLqJ5Mep37JRmx8cjX
   7x/ggi0o4Zycvc7ZFS1to/DyEtB6m/Uue1sEN2u2+d74FFiZ1Dok+AK43
   Mc1KK/K+QRljWO5AfMsxuCGiLmx1/qyFTOz+0VrP+MxVqJlxSwfqszqpK
   H/59hw4L240UJ2Ps4npmIxDZ6F+dgVl985G/kIGLugs9jcKgpqf28RT2M
   HUk/f8Chsh0ysnaSu5b5akfxdC5rw2+F2THulV36j7VsuD4DDet9hiMvQ
   8zSWw9HDYRSIonF8fnGQiiHDhnLl0kM2lXJoLwSiEDU98n7vzT1sdm9wf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2166161"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2166161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 18:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8030558"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 18:53:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 18:53:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 18:53:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 18:53:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CymeZSw58h796pCkay41UF6Tgyrxasa4s69ppBsnU7Hf6j9MA4vb0pqrVV7BoXR+sosZJ13i6Ksw38bkFZnEveW6pz8c5uKSrZtkIWr8DICa1rZFzFLaKAixXC5dxKLITTDi3tNqQ8AL0Rn/cWUCSVY6kv73cQND7OZzw8iI139n0/KHYFFm7+DOtPLTG7BshAtBo67yxwP0st1xvWlQMYFqT9llT0SbHP0y1+DgUpPs0a7RBHSO0VqqYjNxzR8JpJkw0XS6x5mtzllUjb3DhGD/Vw+HJUcsWwkkaYkXaRlmTc73gj3GjmX2pnpqqaG/t9qeC9ctxlwHLHf2EQIKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cwK9hw0ZoYyrURop7TeiqLdafx2HMG/f4bv6OYvDks=;
 b=Aa/ZWy/4nJxF9aVkiE7sjnTOP9S3hMEAQNbNmfpoqQiYlfe4cIqb+XGDxJryqFCRf2DXEQxjfRTu/TxNXiJiyfqFLTHPyqGEekQQDRvS7qXvNmyzUif5Hd8EieOfxtW0GUFjhlYW/gyWInag82rZUG+O/86qoUpGwud79xaCMy+upowxK24lPZhJgEKek2Vzeh0vC/vDKpnhsWp+HzswH22t2FE7i1MN1AKul5iF2e3zJmXHJk1LknO6lbYEvM82RQ1WdNQtorK7bPM0pPOUvexT5U7MoMXVcxHhOSIP3SiK53/J4j8kHru+m8dzHnkDMnFtFwUYBD0pQ+LGqKfa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 02:53:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 02:53:35 +0000
Date: Wed, 14 Feb 2024 18:53:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Tony Luck <tony.luck@intel.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <bp@alien8.de>,
	<dave@stogolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Message-ID: <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <Zc1kwWupeN9WagFj@agluck-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zc1kwWupeN9WagFj@agluck-desk3>
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: cb16487a-de8a-4e94-5542-08dc2dd14d83
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUs6Nq4dEAvHcZgRrUhCT/bA9NjFQ5uYFzEZh7snsicWRP2xXHklS49eWtxVZS2gH8oMVo7cBEM1PeNrndFwfRCXeQfs4v331iaejr293MtLtsxVQ7LFeaCUvqIdJztI2anXyDiswBmfLlON26DlNCAK7GMASZqmzujkvLJNxoBG3yzaBybhHhR1q6q086WXL6XK6Sxqr7DIpOsVBRI1JA4e4it9yxcg/d0Mub985rZ3tip6yxp6l9XIAdlqyeT4wgJ2F9mK74zscolA+Vm5kD66aqybJD9KM/mo3qplQEod3ZRJntRNiQT5lUcJmbOVt7LON6rr1SsYv9Qh0HhSnZfBkNHNDXwXXcusIOvNR4gBo3pubwtCcyHn1pehaHsHBrfamGHLWQinX55uq8afEzS5J5wLmXd6OnZaXrkHK7kfsJRL7ZpdmIO1IHx7x9fwgWMj1mlr0F2/Qy92u4Sjm76hNRLh7OjWnx0JOpXkSEGlt8bIRY9A+9qCUR5cK9UEH6np52gXy55Xua8GYuIZ1/lRQqSYFJ2P2OjWdOkYpTTRoU+WF/nl9BkkJvF5GHZ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(5660300002)(15650500001)(26005)(41300700001)(4326008)(6512007)(66946007)(6506007)(8676002)(66476007)(6486002)(66556008)(83380400001)(8936002)(478600001)(9686003)(316002)(110136005)(6666004)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22EIbNCALGrii+wSq1lTH2Br8oRJtH5K7QHWrWcyeNyLdCAvA5v+wtRYOKLY?=
 =?us-ascii?Q?ypdh97E2fPF0yuVbHg0aZ0/TMDF2BU8iGTu7pWWctQLn0jlOAO7isMjEMMst?=
 =?us-ascii?Q?v+YtS3/Vr4LNrxYwA/AzWjUJrZkLuZm2PFn4d0ObMNu/HPst3IFq9YoR/3cy?=
 =?us-ascii?Q?2QK4hMTuPNaT3R0ZVNOU/FWcloKzqo3X0dxz62U1sx4Cve20BKAJqAyHXCPg?=
 =?us-ascii?Q?seK/7eao6rx8wYJkwer0ODg4cvqIS+bhh9GdcGnVAIsSZhihzBq7di4UmWi3?=
 =?us-ascii?Q?m95FttIQ/NRYR4uC4FuIMN5YjKjAlnj9168SixiE9o/XYHHa0LokFinhsrag?=
 =?us-ascii?Q?lI6NnDgqp4PCNsQi0HpW1WTPjFE8jWzHa5Eqv+3JWPaZqmpXKybgq82Ilwz8?=
 =?us-ascii?Q?NvXl6MbXgTVpwol3QXCK4G0EtmqLp9GAfC9itHAvzfZtW2lbsx2BiGdgJXGd?=
 =?us-ascii?Q?AkbyawAOolzbQ/9ZNE3fA0A+YieQGPlw7UglR3aQpvyIXMYmmL4y/ZpnBQYe?=
 =?us-ascii?Q?445u3xfzOoQ5/DxAdAiNbl8jAs2pM2eAwuNz+ZhGps2sKuzBXwtbjYlmZp9f?=
 =?us-ascii?Q?tVN4iVK7nteSIC77pLHLCg5lYqgJ0AhucjosSS1gNo+/kKxXBYp1szBKs1cV?=
 =?us-ascii?Q?4qWPHeQ1JuPRUDhKnPrrmCa4PilrvuH5lyoAwi2JRYj/8lwmaUQWYt325j5U?=
 =?us-ascii?Q?RYFrGoGpppkx58k/P8GlGAf/SwlWk7jO7vnxQ6LPqxprV+UE0aBit379i3+6?=
 =?us-ascii?Q?CdfNOXlu9aq8YRc3PO+MQuVbSG1ljlcV3fx6Qh7PXsjIvoHAy692aALgLHRe?=
 =?us-ascii?Q?j5FV9ngnfj2aAGOy7fgqvhW621BAPlZr1XW4wgvKmMZSCnM0CyMousvyZ+HF?=
 =?us-ascii?Q?su+62DgbUnwghE6dc3Gr7qnJtpKTSen06RPjc67EAcGc2EHfYLnCGyeM/4wt?=
 =?us-ascii?Q?nAtTT4m363S2xSSmLFSf/mmN9Ebp/5+dBdZkOWt4fIK5PkmebV2cZp4IYcgX?=
 =?us-ascii?Q?i8zzrIimKisIx5wGRyqHT0eGhiNk/L0Bgt0S21ogOKkFvIzZs++Ns5czX0di?=
 =?us-ascii?Q?gJVLEANW6Wmflwxyv3nKsw/dy/P7REmmOaEdNPf/bSllH90tBr/v7iVI1pEH?=
 =?us-ascii?Q?witY/9hwN4jFlVIbZeqJcplAJY9CtwukyZD3Z5/OcVg0NJc5iGg9Cd2M7NRV?=
 =?us-ascii?Q?IO0ExqVfmYUQiY/NFIImLTsUwMJGGbkrnT0Kk0T/n9XVZ3MnPF2QiVOcj642?=
 =?us-ascii?Q?Kf+X2kllb67+6x51eHcdYMEi+ifO7am27KXNW15ZESPMnLfx4qEBObOzaSou?=
 =?us-ascii?Q?GaUszFdNCwcHwJQnV0SI5VCJbLYWfITcD4PtBTHdBNG8B9s7zhZknNOCD8sJ?=
 =?us-ascii?Q?Ggbhe3zZuePnXonAGiyvqBZMY2XHIJsETU4ku2+mBQqFpCSgxwhShG3PNs9W?=
 =?us-ascii?Q?mfssX4XK2FFY/W3nRFDYuoELHg//zNWZbMEMCbcivMY3CpSihIFA2VD+ofHi?=
 =?us-ascii?Q?DmL/cm9g6MjdWs/27SJDYVSx376mfkJGSViK9woNodUj7OVxgU6SSQR9dkkp?=
 =?us-ascii?Q?ViRBbAsZaTXH3wijY9DtsXKbrepuxe0NwW0HDZBtRQSr0jeT6J9Uf6gdKjgu?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb16487a-de8a-4e94-5542-08dc2dd14d83
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 02:53:35.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU7p2d9Y8KLYm8XvhiPtHMJwA6sqwxrswqr0XfZFwk4ev3n3LBBMNISbgYwrnEQnZPPYyLzzi+lwkAXWelQLEBOtTFHmWtz3eGxa7Coq3M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-OriginatorOrg: intel.com

Tony Luck wrote:
> On Wed, Feb 14, 2024 at 02:07:06PM -0600, Ben Cheatham wrote:
> > v12 Changes:
> > 	- Rebase onto v6.8-rc4
> > 	- Squash Kconfig patch into patch 2/3 (Jonathan)
> > 	- Change CONFIG_CXL_EINJ from "depends on ACPI_APEI_EINJ >= CXL_BUS"
> > 	  to "depends on ACPI_APEI_EINJ = CXL_BUS"
> > 	- Drop "ACPI, APEI" part of commit message title and use just EINJ
> > 	instead (Dan)
> > 	- Add protocol error types to "einj_types" documentation (Jonathan)
> > 	- Change 0xffff... constants to use GENMASK()
> > 	- Drop param* variables and use constants instead in cxl error
> > 	  inject functions (Jonathan)
> > 	- Add is_cxl_error_type() helper function in einj.c (Jonathan)
> > 	- Remove a stray function declaration in einj-cxl.h (Jonathan)
> > 	- Comment #else/#endifs with corresponding #if/#ifdef in
> > 	einj-cxl.h (Jonathan)
> > 
> > v11 Changes:
> > 	- Drop patch 2/6 (Add CXL protocol error defines) and put the
> > 	  defines in patch 4/6 instead (Dan)
> > 	- Add Dan's reviewed-by
> > 
> > The new CXL error types will use the Memory Address field in the
> > SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> > compliant memory-mapped downstream port. The value of the memory address
> > will be in the port's MMIO range, and it will not represent physical
> > (normal or persistent) memory.
> > 
> > Add the functionality for injecting CXL 1.1 errors to the EINJ module,
> > but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
> > Instead, make the error types available under /sys/kernel/debug/cxl.
> > This allows for validating the MMIO address for a CXL 1.1 error type
> > while also not making the user responsible for finding it.
> 
> I tried this series on an Intel Icelake (which as far as I know
> doesn't support CXL).

Thanks Tony!

> Couple of oddities:
> 
> 1) I built as a module (CONFIG_ACPI_APEI_EINJ=m) like I normally do.
>    But this was autoloaded and EINJ initialized during boot:
> 
> [   33.909111] EINJ: Error INJection is initialized.

In the current code it should only load if cxl_core.ko is also loaded.

Can you share the output of lsmod to maybe see which module loaded that
dependency?

> I'm wondering if that might be a problem for anyone that likes to
> leave the einj module not loaded until they have some need to
> inject errors.

That is a behavior change of this approach. Is it a problem?

If it is I would say that we need to break out a new cxl_einj.ko module
that when it loads walks the CXL topology and creates the debugfs files.
Otherwise my assumption is that CONFIG_CXL_EINJ=y means that cxl_core.ko
loads einj.ko unconditionally.

I would save that work for a clear description of why einj.ko should not
be resident.

> 2) Even though my system doesn't have any CXL support, I found this:
> 
> # cat /sys/kernel/debug/cxl/einj_types
> 0x00001000      CXL.cache Protocol Correctable
> 
> What does this mean?

Strange, does:

/sys/kernel/debug/einj/available_error_type

...show the same even before these patches? I.e. maybe this pre-CXL BIOS was
using the 0x1000 encoding when it should not?

> Using ras-tools I injected some DDR memory errors. So legacy
> functionality still works OK.
> 
> -Tony




