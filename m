Return-Path: <linux-acpi+bounces-3991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DC986A829
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 07:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D384E1C23951
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38821353;
	Wed, 28 Feb 2024 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LK87ERrx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727401CD15;
	Wed, 28 Feb 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100053; cv=fail; b=qFg2FRQmtiX9++1nrGXUcuBO+WaLHI529YXHpLCekG+/os0NQjZdr+ij0dskudYDh64GIkWl9hG7Lun+M9VacU/wxNikafaQejXHxEo2S3FW2J/Y307INKqbvkHkgG8Nq3NLQtYCFaGxcP4lLsUl7jJE8pDQn/pWlYtvuNM2eLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100053; c=relaxed/simple;
	bh=CEsEl6430sJo0ElBlrqiVdYq5B08D01OjUxprf1LHMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GgX7Sbikq1+/LgxXOg3wAO1IMv4jGC4tenZ99Qe/LwcCKDRjfp77QiD4JGE52+YbdfPdvGpjH9U2heFv6sJsUA0dG3bSamw7yqxusUUUHp9nu811JRzzvXsJp1hQOqS9cW98AAhoeuXzTR+2PtvpwkRJ7pz/NuyynCc9+o8vGcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LK87ERrx; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709100051; x=1740636051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CEsEl6430sJo0ElBlrqiVdYq5B08D01OjUxprf1LHMM=;
  b=LK87ERrxLhAejTVLhFUO9Q7rASGvGqUrfZdwVPL7Zwm+SfNbaqtSDbvL
   sm7thSybumT6kRsA5Nqt5mjQXaRRXgz35YnCV/43ziZnuYWbj6VHFJxUs
   D5UNJBxSqRfzEVMMb2Rc4ZNcRdKcfbE+EJV8rbzkgWW60gUMuANttDi1r
   HEqlMw5suioaMRoQoYAklRfZ3hAHNne8fiDtbARt/lbxDbt6Q+Oo2CGcV
   s46jwgNvN9cESyB+W6rj5rtsUor65gny7YxhvPFt4cKHubNsxu0i8QU3T
   odqn6zkqmNmOiRctDUM5IUZdtynCXa7dsLFZQcGAwm/v59jfiX9dxmSFY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3326411"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3326411"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 22:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="11903097"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 22:00:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 22:00:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 22:00:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 22:00:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6xf+1SfUSoOFUeMhXDHwFkWSeuQf62Omv45fDureACCUG3Ddzye8woZvuIPprTlUC4skddFXUr0kjatYoUAx/rPbybul2T7tLSlNqyEvF42TUi7rFIwKJCX/t+nppgzWNeMYOLAXI5nn8qY8waQoxq1bGPDKfrd6V5041SzRcKeA3/Ok6u6JBcJmFKsI0dr4DlgGNYjmt1GHhBo0ulG5J39wmPK+pKAASf3l/7db8eKJmO1dbTGu5LfbCuDfNHPWkVNQGcc01ycR06htfrVxyqNhpGye2sun4Kc30ku0oivV868stnETRrvKxbflasp84h+CJDl5FIbl7IqtTi9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nCwwCUy93plbl8Z1aoGJCdD4QhoT1KSVl5oHTfJKG0=;
 b=Q9f9PUOZn/QVRowtpW8rGsQ9qT8dNXCXIKA8lL0HOY6Vj3mIn9JcpXaMbvEXYNjiJ+1zPiW11bhMblvQ6Kiaz8jBUUWYJYyf8dXWn/yFyEcXbAXuzEAA32VEJ0NGC4oxJaGhiVQ0WhaHTXtAYI9Zl6HcYO9lxGXyKKJN38jxN4X1esUFSvD1opM0S9iASQYubP2GdmV8OYrnMRZqaz4CF35ZiwX4MXl0wWcQro5BA9X/VYF+indVgp3VRS9wEYCUkGWcKyLbyuYMO6Dv2mGbYkUzfl4zwQnKwnwMGeHlejUtvPxs9QtmQpGm1j1SmztvZI5fjV8w2GfAMIIhGLKKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Wed, 28 Feb
 2024 06:00:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Wed, 28 Feb 2024
 06:00:31 +0000
Date: Tue, 27 Feb 2024 22:00:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Message-ID: <65decbfc57824_3651e2946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
 <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7f68ba-f7f4-4894-ef91-08dc38229229
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AX1zSxay20+o9jOQdSMlFOAi3eA2lwcGeQWAflk1Ukhzs+DrKvHse+oZcLcgpvhUQRx+Wunz+wmkLx6vY17UvZcf8Ctk5QXfqHlyH9sUHtyq3/9HtkcCQjxPKHNLRNac8V7Tkz2NejAZ12czE7+rS2o2hLp2wkG880LUV30AXuu3p74phiXWwNgV6iguSBeUju/RuhISCkWfK7yBHmQ1zAUQuFysch/nwAICz0f3BHOTpiG9Muka7xs7l/M2li1R9Y7wJimORSXJ9iroXBfgaY4fMxc7WUjrFYYhVPTCibyx/+IU3VJ/Xv4R702t3thVcd0d2w1C++Q2zhoFP2ut2HhXed0TYitLWPTVF2Ocxz8JCJSqX2cKlopvImcR75sdwWPf2oHj7S56eVPpvQpyot9djfbBoIqTJsKGT5sNwaUpQ/JkQuLLV6fNf88FjJRARO06iToliIrbXtRqbArvVFF4q2jSJ6OFjKTnRYigHQodYDXplF+IwvIVsmmx9Z4WftKM76MmzqcHuhe82Jp4lg8Ly8xfzS4FEDvV8eUOAVd8PLwz6Mojb8xIQUo4awNzpG90Jx43AMiN1IXXOFK0htXhCgThN47URjc9WTzbCFKaBNFyjs5HjsErXzS5WYP9ebhFSPpFa3RwfVgyoOZ0Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WqVTgKy8KhkqHmcg6KjabAw8WzTYVAwGmFDIv9q1HAyppkcOpaulhv+gPydz?=
 =?us-ascii?Q?5uDTrDFRNXbV7HxlmjNcWkoJmn4u/xUAxMmopIWm60wKiBDvZKOKITSwV4HC?=
 =?us-ascii?Q?cLqlFqkjfMsvS5l+ntapBWink+F41hZWKZFD8nwtGznXLRq5Lo01kSAEeYMv?=
 =?us-ascii?Q?5CljMJ8BGkyPt81Iw/ZUGRIPsxmKF95GUdRsHluxwbhUdCuOXQV05W0waN0L?=
 =?us-ascii?Q?Y3aWrtdrL7Lp56AODGPeEQFR/EpFrOnVCIt6o6FBa44FK3qurdL38xztoJ7W?=
 =?us-ascii?Q?ifkoqQKmdpqFRY5fWsCh99h07cw/SeKuzgxkmbqlE+JLFeJSCE2/cLLfrGa6?=
 =?us-ascii?Q?X9hysES1ElupVmPf1JN0YZFxS7VKYZA8hDJPuDwf6jE7UHj4D+dGpQkKnrsk?=
 =?us-ascii?Q?9qPUHBt8E8oZJy1asu6IZ+1gOLYavV8JWnXqZeBiuNIrVETkhlXM3rSdSyZE?=
 =?us-ascii?Q?CBaRa6BzYoiX29A+M4GvVhVr6TJT5ZtNkgNuhD49YKOT1SWLfmQSscxMHfLL?=
 =?us-ascii?Q?sJiFmrdnIf9pbE/s45oKqwdpApAagNJ49HP8mn0isJn0+xNBz9qwS2eCjszx?=
 =?us-ascii?Q?F7VEK4V9CTFfBXYPayjzV/X4mdeUWNQNyb9Bk4XF8tmcHzqyYj+ZZCIRImMN?=
 =?us-ascii?Q?0niYc6rS+Lx5dlqZSGnfncO6omyEEwJ+lLeUxkC9WtPek2kNoyMunnvEHUch?=
 =?us-ascii?Q?r1avxhiN5/JllvyOZzSAY3pyxf9fsQ5rfZ74yAf9sn7PO/d/GRauskpaksLF?=
 =?us-ascii?Q?Khbh7efe6aJtc5hyFmjCTLObVgtOBZ2v51NJogl+RAnO70DANvPXQ/xtGYZg?=
 =?us-ascii?Q?MMuHz7v1c9Hh0h6oqwC2EBVnuAv9BOa2CaT7RDF6ccr6oDmQOFOJ1sj+Wgyl?=
 =?us-ascii?Q?wnIIp4EtaegVWRRgz+fJikbZ6TkecAeWhTX9J+2H+5RyOR7O6ta0LtVfcnfm?=
 =?us-ascii?Q?/gvwP6XKBlLziqIDJdp31tqmvPmBU6JRE1kgKbT9tuWXWP1ad2mr6ID0ovLF?=
 =?us-ascii?Q?PHJ2coYuHmhBRGEJGav0P/zsfnrHax+ASh/C5RQZ7ZpetvJsuioJ6dvKGsDQ?=
 =?us-ascii?Q?UT0EgH/m06/1qgr13T1Ih2wWgZqvIuqTCnbg74toPrKFD4nDz7pjVUV6Uh1d?=
 =?us-ascii?Q?pwfwEkbfG66stOnIS7YAn/kEEcgMv2ic8ocjc37EzxfxAIS4VZ3I2hfhIVpN?=
 =?us-ascii?Q?wYlLMeSdBEtefgdKo4aGSJv5RADqmkDereq4KzbusQBw6iILfCPUvjnoxtKo?=
 =?us-ascii?Q?13A4I9CnPRssqUpeitjjkZ61ayZeSRPYMELNzOMtR/tZWpzwHJbeI0R3YNyR?=
 =?us-ascii?Q?XNMhRNqvJbEj9DcHQOOYaj+JOFRZwNigNWB7HGIFyknkXnTWcGQWS8tTYj9W?=
 =?us-ascii?Q?Bdcbquk7mf9UgN2zOEYsYHFN8fdUTxwPAQFH6cINE7AA3z86iHGwcOhNnmSM?=
 =?us-ascii?Q?9h5js6D3tnL4mEoZT1Y2MYbLpO6dN/7XW1+1HOGr9PsVIHH1CP19Tw9u+8Jr?=
 =?us-ascii?Q?nzsOzpS8VFR7YOlFop7JUfKHpu5q1KpQ7yty7iwa9wD+A0ZQWGx23tftg9uF?=
 =?us-ascii?Q?Al5qZmM+NzPRwJw5l6QbNXf17E4dLLUoX+dpbaCG8l5A/WTh8Cr4i5U0iKRs?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7f68ba-f7f4-4894-ef91-08dc38229229
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 06:00:31.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su5Th4nBVSh7oBhKd4k0G1YqJQZWoWDoYrUhcPbS/JgciryUuhBKLBuJOtrUGoTUQY/msnsyZtMbeoAlcVNp2gXpkDBEsap982xGbU/SSnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> This patch had an outdated commit message, so here's the patch with an updated description.
> 
> I also realized that I was wrong about letting CXL 2.0+ error types (discussed a revision
> or two ago) and I wasn't actually letting them through. I've went ahead and added
> the ability to inject CXL 2.0+ error through the legacy interface. This pretty
> much amounts to returning an error for CXL 1.0/1.1 injection types in einj_error_inject()
> and instead routing them through a new einj_cxl_rch_error_inject() function called
> in einj-cxl.c
> 
> If this change is too big I can send in another revision, I just wanted to avoid
> spamming the list(s).
> 
> From eea1cf991dc2a551f6db2e3bb9510ed43c86762d Mon Sep 17 00:00:00 2001
> From: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Date: Fri, 16 Feb 2024 11:12:51 -0600
> Subject: [PATCH v14 2/4] EINJ: Add CXL error type support
> 
> Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
> einj-cxl.c implements the necessary handling for CXL protocol error
> injection and exposes an API for the CXL core to use said functionality,
> while also allowing the EINJ module to be built without CXL support.
> Because CXL error types targeting CXL 1.0/1.1 ports require special
> handling, only allow them to be injected through the new cxl debugfs
> interface (next commit) and return an error when attempting to inject
> through the legacy interface.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  MAINTAINERS                               |   1 +
>  drivers/acpi/apei/Kconfig                 |  12 +++
>  drivers/acpi/apei/Makefile                |   2 +
>  drivers/acpi/apei/apei-internal.h         |  18 ++++
>  drivers/acpi/apei/{einj.c => einj-core.c} |  85 +++++++++++----
>  drivers/acpi/apei/einj-cxl.c              | 121 ++++++++++++++++++++++
>  include/linux/einj-cxl.h                  |  40 +++++++
>  7 files changed, 257 insertions(+), 22 deletions(-)
>  rename drivers/acpi/apei/{einj.c => einj-core.c} (94%)
>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..90cf8403dd17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> +F:	include/linux/cxl-einj.h
>  F:	include/linux/cxl-event.h
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..f01afa2805be 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>  	  mainly used for debugging and testing the other parts of
>  	  APEI and some other RAS features.
>  
> +config ACPI_APEI_EINJ_CXL
> +	bool "CXL Error INJection Support"
> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
> +	help
> +	  Support for CXL protocol Error INJection through debugfs/cxl.
> +	  Availability and which errors are supported is dependent on
> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
> +	  EINJ documentation for more information.
> +
> +	  If unsure say 'n'
> +
>  config ACPI_APEI_ERST_DEBUG
>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>  	depends on ACPI_APEI
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 4dfac2128737..2c474e6477e1 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -2,6 +2,8 @@
>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
> +einj-y				:= einj-core.o
> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>  
>  apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 67c2c3b959e1..cd2766c69d78 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  }
>  
>  int apei_osc_setup(void);
> +
> +int einj_get_available_error_type(u32 *type);
> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> +		      u64 param4);
> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> +			      u64 param3, u64 param4);
> +bool einj_is_cxl_error_type(u64 type);
> +int einj_validate_error_type(u64 type);
> +
> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
> similarity index 94%
> rename from drivers/acpi/apei/einj.c
> rename to drivers/acpi/apei/einj-core.c
> index 937c69844dac..437c13949be7 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -37,6 +37,12 @@
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
> @@ -141,7 +147,7 @@ static DEFINE_MUTEX(einj_mutex);
>  /*
>   * Exported APIs use this flag to exit early if einj_probe() failed.
>   */
> -static bool einj_initialized __ro_after_init;
> +bool einj_initialized __ro_after_init;
>  
>  static void *einj_param;
>  
> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -static int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type)
>  {
>  	int rc;
>  
> @@ -536,8 +542,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  }
>  
>  /* Inject the specified hardware error */
> -static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> -			     u64 param3, u64 param4)
> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> +		      u64 param4)
>  {
>  	int rc;
>  	u64 base_addr, size;
> @@ -560,8 +566,18 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (type & ACPI5_VENDOR_BIT) {
>  		if (vendor_flags != SETWA_FLAGS_MEM)
>  			goto inject;
> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>  		goto inject;
> +	}
> +
> +	/*
> +	 * Injections targeting a CXL 1.0/1.1 port have to be injected
> +	 * from the CXL debugfs interface so that we can guarantee a
> +	 * correct MMIO address.
> +	 */

Given that the CXL debugfs is not present in this file I would update
this comment to give a hints using local references. Something like:

	/*
	 * Injections targeting a CXL 1.0/1.1 port have to be injected
	 * via the einj_cxl_rch_error_inject() path as that does proper
	 * input validation that passed address is an RCRB base address.
	 */

...that said, how does this work for the CXL 2.0 path? Does not
einj_cxl_inject_error() need to use __einj_error_inject() rather than
einj_error_inject() to get by this check?


