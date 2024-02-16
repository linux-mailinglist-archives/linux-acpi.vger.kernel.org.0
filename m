Return-Path: <linux-acpi+bounces-3574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86280857256
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9BF1C216D5
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D17263D;
	Fri, 16 Feb 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOlOn9mK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F738F;
	Fri, 16 Feb 2024 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042529; cv=fail; b=TsKdmFfW9jCT95HSp3WI+zUZV2UDNddPJNkpXrbaHoWq+dsvGUXNnst//eLtmThctWaxoJu1SxCr16kteqAvtB5gibxFve9sMYBtykTXoxV5q+slPuhzxQGRQt9wVbb8lpjlChnLQOmYEGkeXGsC3gK2MGRf7d6AZTwGA/TL3oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042529; c=relaxed/simple;
	bh=ng7J1V/9PRS6X838jKr83jaE56E6hU1hdO/raViqlB0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+g8TzPB05vx9AtzxAhx0sV9wczwBbx/+0ZejqLiyCCJRYa7rnKccl10YkfoA8aR6wh6BOrGcbP3XbFnxqaCCVJqVu+jAjtMGXXb3qsrBsq5ABOgdDqsjokq7qVx+v2wLkgELqqudb8qtK9aL9i5dIOpbvx2gM+arOJBgcZ60vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOlOn9mK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708042528; x=1739578528;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ng7J1V/9PRS6X838jKr83jaE56E6hU1hdO/raViqlB0=;
  b=dOlOn9mKKpQ9g8q0DRXtPRcmGTyFosXIOWleFmm6kmfqw4egkSw+l0ZM
   oTw3ElxnL3pZCjws17ufyltsTk3UhrBAHSmu3RFS0dW40PrBRD7iCl5eh
   K9xRrNemo9qweu2NE0s1cwSep7fEMaDwfdtZWgY3BNyuR7nXpilC76kT0
   JrFneg9Dvgwi68EISZLL0UTJH+6ujDG/E9q8EmVN5WnQSzyOxxwIc6yl7
   YVsgu704t/ft/KEtvzv457N41sm5gbHkis1TNyGAKziBkyxhx3SBVFsHq
   Tb31D/Ou1PbE3Xzi/Ex6zuYLVXfz9wTI/yogsm5kNYVjEH1/XLyJcSR1O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2281640"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2281640"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 16:15:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="3613510"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 16:15:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 16:15:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 16:15:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 16:15:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 16:15:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWQp8Vkc/rYGWx+uPMoycht0g1HbfP6QNtP+TDj9XjIYqmEOIQgm7YBLOIXQMPl8+YOpkeA653bP7p3NSM4VRjur+rnxKgOx51JcMADDeeAwIwVJQk7XHABhu3FX1y2ovAlag0z/AJIhIFgBIP3WZbyixAxphvIv+bpnNZeDwWZe8A2hL0mZVIhu1At8Vpl3wS7qLMvIC4IXpwz5Nu3Z4eIHyLAeskIuKNv28QBR+4Cg01x6R28aWTGO3xpyoJTQC9EI7OTxAWSehm7TK4fSYxS4JHDQzaON5MY9i54o0EgLUTYnsbZbPrNUBdL4Kf2t3LnJS9tN2nH3B0+wKJ+e8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6X+6FcQOAFwcVtoQaiOzPA1KNRxTdpYThJ2AydD/Wo=;
 b=T/oBf3k2X3x+ua5yZLKVoO8BcjLJxhAOQZyUarx48lwn93uhMzTBUqmeEJdgCuC1zrlXRhuIdLtvTG/GvfDuYQ/UF2WW42IZV72ubbbRbr6ledihkSkDslHWnUchq8M+t0mVVQcce1UXLh2G4sbs7s4lIGUbHuLPZptAL57I7ku7HIPiO26eFqPg+lIlMU3n5b7fX1ghrL2+OAZmF1a/C2aCAuLZ3daObPY0ybEGDbR2kr9z20Cdps9HiWk4rHBAnvlXJHZAvLf81RHmWph5tnN+Tl4o1ySfdB7MJ3M6Wgpfsr8A8lJFexe1FRGyu6AhUdfYrPGBkNfSNsCQpLGoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Fri, 16 Feb
 2024 00:15:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 00:15:22 +0000
Date: Thu, 15 Feb 2024 16:15:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v12 2/3] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65cea917f29b9_5c7629473@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
 <65cd76286de08_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <e1c652aa-830f-48c8-85ed-b00a7c153efe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e1c652aa-830f-48c8-85ed-b00a7c153efe@amd.com>
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 38374236-0de3-495d-5a65-08dc2e845dca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GwJupLkZAg+xEKrpkC1QtZQySE3qNC2bi89jZUR6+1aBlunH9Du3z+PECNcVV9ZfcpsSzOB2hIfartvwv+2u+IGBWSa+Ize6CgNKBVeW4IAWeUjxEkVTR1DY22Ad2xUCRQqEArrZRiWXCxlQEQaD++r+bho04Dl0V6rjRv1JL7zGuvQ1bgQ7mUMV7Eksp2R+h+AmrIW5j9c1lL4oJoxIhCotU25NIDt3RzTH0BxM465s6+llCaDQGmBcjHSk5mXlQNu5q0p4EWxg6htZGq1KYbaKUbze5s6c7W4uVKkBSwYCKAVlCVOPU05FK/iE9BvTFoZX48UlEBvTUVOYvl29JNqg+iHDirEigGmwZt9SExv64o4JVQ/1bkUYqpHSDojyOAqoDl3M50QOA5iXYGrZNJdJG+hrLp9NMflrfxWw797bUIP/kh3rhagf2c4C8YwyN62rUcl6MoNbjfw8E2MPuLcVb9gM41x7ZnEIwxgvmOPMk/F8n8FzZAk+flMJcp0GvIZNgJPRRuWLb4b3C23xtVX5kbHLdH9jVZi0JIy8sylwcKFupAskvAjI18BXvT6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(26005)(9686003)(41300700001)(6486002)(478600001)(6506007)(86362001)(66476007)(66556008)(316002)(6512007)(66946007)(8936002)(82960400001)(8676002)(5660300002)(4326008)(110136005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+PyeAayEmiVHoOemhOSpiE9hEd3l7NLPvKm9Cg/E87VAHcs4s1O9Sz6zE/QI?=
 =?us-ascii?Q?MBWvb4vcuIqvnBzjirw327yBG6GoCAJKAdaPt866aLXuCiEiLGCXwNd/7f+I?=
 =?us-ascii?Q?qMYx6XtdS6UkIuWCOxAYCI/13NWgU5LQBumE2X3KD6awXrGYunU+16BCe7db?=
 =?us-ascii?Q?P0RtXqljTRxe3DdaWCLSTPQdGjVh6/2Fn0pToTnVIND/CyWXdEgV06LHaYwy?=
 =?us-ascii?Q?1XH8c/mOd1cABuWEJb9gHjhx2cC3LjpqcumAgZYNsxgDoKTvL2qhJDG7b9+V?=
 =?us-ascii?Q?1xnUTuXNAkRKdNgI4Dc+aONG7ANF2l+xO23/ghqLbuYPu1iDwZ7mlxX1kF31?=
 =?us-ascii?Q?If2305eqnkio3nqZSv35mJgTTvsFItpRyKcdvxovmhGKqD2FGWgfa/35MalM?=
 =?us-ascii?Q?ONn/iaK8sgJKMsV8kVsjU1ilRdYgMpmScR9e0TnLstYQDn5SMJgw/hZxQiW/?=
 =?us-ascii?Q?8CnYlL8yOBXEdmLKOb1qLgyjSgcmhelCJZ3xxUJPtuvd/CGnXnBlVz1xGJPw?=
 =?us-ascii?Q?bShBe3jNISJo7SC+4FLn+3GSjI+xZD9KvSEfmNWcyJ3HJQ/mOFB05zzUfoO9?=
 =?us-ascii?Q?X2avCGQI1GEFvomOTLU/0shwtxInCWRMgshgA8j46N9VUsRarHjTbEr/pV3a?=
 =?us-ascii?Q?uJt3qBOsaDWGQ55I5nA2LTUmGSRH+N5LpSVVKoBdfx9RbNLgF2pZHhi26EMC?=
 =?us-ascii?Q?e3m2soFzOehA4eU9L+u0wZO56Q9CrDgr1ZukDRlqLW3fMv09828UrGS8KSHL?=
 =?us-ascii?Q?8UMcDJOx8iGFYFCY2pgP2iMEuN4/1P9fP3RZyGaDCflvhO15Xgh4oNE17YHo?=
 =?us-ascii?Q?As05BgpxcUfSLTUoid9EkkH8M3BO6OkeogmGy2PPXc9W7+Y9N7nqNdf+Sd56?=
 =?us-ascii?Q?zhuxLoQm8hpQXqKwuGlv4TWu6uZlL36lkBjuaPq4VIfpRml8T5gm20KebsEa?=
 =?us-ascii?Q?fafI9HhDEG+R8NTuE7qjs/TFs4yu70S8HIiNidpFIS3f6Dhz4fL1WvEM1IRn?=
 =?us-ascii?Q?ArL37ICk5yalRvLkAxIuIJMNh6Shr2JpV2JAl1IobBliD0IE0nURV+NNzFt7?=
 =?us-ascii?Q?WI3NXS09DyrnJYa/cOoLJv8HVrlzY8gyRnawGCY9s33XYVhJYlfS+NrxkQZb?=
 =?us-ascii?Q?HHGpdmgmhlujlkOGFa1Azr1DSKoqSMXeMhWgARcIKeZH8h34OFY/P+8GiSae?=
 =?us-ascii?Q?eR31Cdmc9ZqvQYPjDTdhMn2oaDn2yC4VXJMBiGyYo6S1adU05yyHvpvYoEui?=
 =?us-ascii?Q?z6vQMbH2OO5iAeuTK86YaleXFga7W3QSTh4yGSfSYNpz+Xc/dBy/JPYbrXK8?=
 =?us-ascii?Q?Jg0ffOb600zD/msPwxy3poR+2/jPs5sjWEDy2OVXAARtu+GGaEt4jOn/DmGD?=
 =?us-ascii?Q?x2D7Qv4B39Mr75KGfEpde0kyDiTyvXTtfL3bgTQZilb1s0vky1/bRyA2VJTx?=
 =?us-ascii?Q?OWE4ysB7MaVbyoEctPjMyzHsf6Z8ff5N3GB9HGLBYxo9ObG/LExuipo+DZ3/?=
 =?us-ascii?Q?iwyy/g48KrVBtIRwbsnO2MHvDtBYf25msO1x8/t66GnZaChH5wT5TwZHl7R3?=
 =?us-ascii?Q?EDa5zklo/nxLaPqzQpA2rmPuqphLCVEZYosrddAfixI7wTwnJHmP3TACwacb?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38374236-0de3-495d-5a65-08dc2e845dca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:15:22.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+w0EuylCUWoQ9j1PyWkTVeaAonO3guePJ/h+nkIp6VQhhwsJF4N5b85Q7HltneMZ/byoXlIgJimWsOoaGjS2P7zfF96WdTreJfMZ+9JohE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
[..]
> >> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> >> new file mode 100644
> >> index 000000000000..92c0e2e37ad9
> >> --- /dev/null
> >> +++ b/include/linux/einj-cxl.h
> >> @@ -0,0 +1,40 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + * CXL protocol Error INJection support.
> >> + *
> >> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> >> + * All Rights Reserved.
> >> + *
> >> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> >> + */
> >> +#ifndef CXL_EINJ_H
> >> +#define CXL_EINJ_H
> >> +
> >> +#include <linux/pci.h>
> >> +
> >> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> > 
> > Per above this needs to be IS_ENABLED(CONFIG_CXL_EINJ), otherwise what's
> > the point of the config symbol?
> > 
> 
[..]
> I think the solution here is to move the einj_cxl functions into a new
> file, gate that file by CONFIG_CXL_EINJ (or change the name to
> CONFIG_EINJ_CXL to match einj-cxl.h), and add declarations of the
> functions in the EINJ module used by said functions to
> drivers/acpi/apei/apei-internal.h. I'm not sure of another approach at
> this point, but if you have suggestions I'd be very happy to hear
> them!

Yes, this is the way.

