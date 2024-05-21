Return-Path: <linux-acpi+bounces-5915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D88CB1BC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBDBB21455
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD61DDEA;
	Tue, 21 May 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U68kJiIU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27961FBB;
	Tue, 21 May 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306871; cv=fail; b=SD4XmIivNl9QI6B5bAiCSue6TzjGRp5T8euoijjV3N5gMAtQl57ysmcjj41STvA0j0K2pr2xrFHTTk8ndN6WWfDimrDvKq0+apL8uafl022A2YUiTXnzf3jKkxs/zYKXFgdYZy+BPkVW2ap8xkVoTJCs71aS4qBkEtF+2WMJm6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306871; c=relaxed/simple;
	bh=HbQMgUard/KhLB5jgaYK1sm35wHW6sQeJPej07KhtP0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FkpKGK+TGZKE4LSv1orH/pRA29V4OBRlwdhMC6UpAMqWqxDn8ENhuY0Exp53EYfMrM05jPr8yZP0jol6FaPxkF3u3h3ebQQSs7tgo6p0MRO1xMH3RBrymytT/kdJ8BSgD4CSaqJsKFpIxeW0dux/30Faq7ne36lESBJqmyfjqPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U68kJiIU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716306870; x=1747842870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HbQMgUard/KhLB5jgaYK1sm35wHW6sQeJPej07KhtP0=;
  b=U68kJiIUPZIXeQERCSvljcJ4niIp44DqUIwDJAPFOny+sHZgJDqcfzrn
   aRH6Y+3gaE43qTdwGMAe3Y19jTBMw6aScJtUEwozJxg52peKiEq/gzn2+
   c5rm4OT6A9pSsiLFl+xwnW0rLHBRB/LVTQ2PXcj+AD6FI+pZ2d+ZlkKEc
   kADMS+8kVA/6hna9UkX57hMIZ27qttefaPo2mSZK52U6grdze7Ztk2Rgj
   qq1hIMtKJR+CvNxYfMB3+5JF2GVbFNRIpiKj/AXt/X2RwiAZXOvm1HH9T
   M50DXyEFxkmeuPInTiEfrbSNb6Ug9aR9rw8J/wBV/6Beg4jZPtfsDQEy3
   A==;
X-CSE-ConnectionGUID: 6V0eFYxoSFSmf5IEdGNiaQ==
X-CSE-MsgGUID: 2O6Yo0WiRTSQ11bKCb1Qsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12303059"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12303059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:54:29 -0700
X-CSE-ConnectionGUID: FPnlDdZrTg2vkaG+XyNUig==
X-CSE-MsgGUID: 5cULjJ3ZRfmj3tjpIUvpsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37797720"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 08:54:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:54:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 08:54:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 08:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cooJcF/nyksN3TJ7bfxbcyn64phqN6HSP1Eg8rXOXuBNHNgTlaQFrNqgbprw76jbhTqjz9nMxux4JCc/HoPrikK9q3Ya07GQmIOIbc9+8M4x4WHbYceJe36jag7+CHWfWcVs5dDL+IkQ+GpUDVzKqfZmKorfYYv5XFWu/CTwqGpUkKC3kd1HnCNvva8ASIZhqzvQC3Iq1W8FR5aeAQrmpV59b/Nv32UUrnoN9Zo+pQlNsTbzuYfw9t7giSfrmMqU6t13Y+qIUtWyk8YME2CYpmEA+vWOL6/aVTnU8GzEw/JaOPbmDMjC89Hj9CH6kHw2mB1o4PNyu/G2urGdvawbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fkm0npOLWSBxkClRV/1FCmO5CHZVozul1TfszSBbTs=;
 b=DY2uO6g3Ec+o8ke1XRXqL2+JMdxPX1DMBK+ylQU0HDb6uYXdRQuBxPctraEwoa2k4Imb2u3FFBoZ495ZTvptbIE0PC9ipbYjnUHhGPFkfEz+oSKTSlQJR4Iagw9+ZlGHhLzFro4Jdm6Vbgso9Aqm+PjYZiFMC8OMT1Kyaqq6UuPH0W8j578CkTlwPCMcLUi1rTEEYoO62ttohJF1yPA9G4a48jBWrfZNIe7c99S6rJjf4XFayZwZ2L36XMEpKt1PLBpwbDhNpFmId+sXIbN5KIk1yyONVtJik4buDKoMjRlZ/TGXQoxk1+nzD1E2JJNivnVMYYB5LZneaVD0EPgTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 15:54:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 15:54:17 +0000
Date: Tue, 21 May 2024 08:54:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <664cc3a76e7d_2c2629462@dwillia2-xfh.jf.intel.com.notmuch>
References: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
 <20240517174550.0000242a@Huawei.com>
 <6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240520125333.00007a47@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240520125333.00007a47@Huawei.com>
X-ClientProxiedBy: MW2PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:302:1::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: e183dcf7-46d4-44c8-828a-08dc79ae4501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZdbKhbFzthXJ7J0BbSYwmZ7gVViAvE4TJxk29+30718hJwb53trYl/8tlkrg?=
 =?us-ascii?Q?zP0amCKbo9t3XQxRhhgfaveYtCWQ2S5HDut/r36g5o8YI2bR7CW9zLtNtRJU?=
 =?us-ascii?Q?zU7S2wYnL8QVz2ZHzguADvAT9vLGrwl5vrvCIxyhBaKpq95Jb9XplwU0lpdA?=
 =?us-ascii?Q?EJ02moQ7eJNz17LYS8jTeDqzHaSyMSZg+mzJqKrLbuDnOQ2gp/qVENkS/Vcf?=
 =?us-ascii?Q?X9iDGXrAJD/mMSQeDVGQG3BfeHb+xrKvmqYcbgwUM2hJyFjdhfhJ6P36sdzm?=
 =?us-ascii?Q?HTLLf+HqSqB3LzJkpD1mx0B/svocnJpD29nVN7lwgH+sDf9fnh3wyNM9MEM0?=
 =?us-ascii?Q?RglJObaRfx4WOSj1EdwE9AtmWQN/Jknrt0Fmv5QcEyHtuS4kFnTjXcadxVKJ?=
 =?us-ascii?Q?1DfDp37jC2rS2h3DF1vrzQOdenBc+fkY0LCiH6rnXQVlk7BbXVSSRmWZ4kcp?=
 =?us-ascii?Q?qP5/5TVKUKejWQ/myCXYvpsAVCHxoVHGpAvjafiimG02E5W+fYjZdEYnGGkJ?=
 =?us-ascii?Q?HD9WtMYjQXgpjHODz0GIUNULuS9YeaChbfwDmQ28S0jcz+qT2UI6PJSgxdoj?=
 =?us-ascii?Q?URgo+Np+sg9inuUO65qen6A8v0Noioydll125HCeGSJhHyNSRYfxU1bB0ssN?=
 =?us-ascii?Q?u1F7/11YwcLoJqmBvNx6hhF3Dw0ksIoUY/uxPpjsMImASvmn829tJoOm01IY?=
 =?us-ascii?Q?G9JuhHZvdDPDg+ESj/GNrijq2PdkdvR/mOOZGV1cphVK3hmimpDXIsmjZ1dt?=
 =?us-ascii?Q?2c8GQWz//iAY2WFRgXOdb1RCEvCOwqQrxNAwmhhU6qgzlKVleb/fFDxSa25Y?=
 =?us-ascii?Q?hkRV8CSXIYzB3W670FKkQF+Ixty74QJ7XZ80xTmV6lqcQt24B2R/5y0yyUp0?=
 =?us-ascii?Q?1RUWp93cEJhKW3doiGNy1tJeh52e3eGHSQ/nV9w5/OfNuARb8f+P++IFwhat?=
 =?us-ascii?Q?pdO3NbbEPzJ9TBKzI9Gkvel+5XJ6T1FVepLkF6cWyVKBSAW/HluxYk9oJoNQ?=
 =?us-ascii?Q?m8bI9tnaBfGkWWH5A6/DpgYnUmYn9Cr3/1+d2XvI0VR2IudyzCLLVPRxAsMJ?=
 =?us-ascii?Q?XZBTHiWB0ofyibhROMAxbyKG+JQ28vCHgXsHWcegaf+LT6sNi3dIrkAX8+KS?=
 =?us-ascii?Q?HSoe2zJN2gZILe+9e9ihoNgPPEzi/clL0frv8qNU8IZotFXP5BO8xj0g0dS5?=
 =?us-ascii?Q?iKqQ+TL39rwzETZIYMINeINjbBQZZM/5wIuWno+fSNkHT/joEhPzGWQaUKc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RF3DlHNKh64ESDBELO0y0RM67FlkvGit7YlNPznJRXYiKGWE4KJybiUb8luN?=
 =?us-ascii?Q?DDzVKE71ZiVCYWP4ey34cXkhDQK+zKYYOUA/bVnu50pCtCMseoqy8Lo2/+p0?=
 =?us-ascii?Q?ghU/CFZSiXHWmGAJGbTT4arTkPOFwJ5jFVz/7mXq/eRegRN5MbWTRk3s+tsL?=
 =?us-ascii?Q?z+wX1gyVWfBRfLuHBS2GA0SSrXKJrRHVVi84Y3vzWECiRtt+QxYYZb3l+bgd?=
 =?us-ascii?Q?cxFP+O2fs7GqQphMlGdLICbaIQrc47jWPKS82mPNnqBaHzzbheFZwgVcCJrh?=
 =?us-ascii?Q?QkroS/EnuiG1UeVV21pffRuP8GypCu3tsUcM7Hlmcivq9G18bSYrn2FKwBZ8?=
 =?us-ascii?Q?fu+QSnM4VR3Ven6tziym3YhRQrtCBu7NojCsQdCAppMiDeyMBjPjySKuMsEr?=
 =?us-ascii?Q?GP1sRIO+52HT3kc7W+8HnPus7bexaHcEuSsUgPAaerjbs0u4s29cvX+KCV+O?=
 =?us-ascii?Q?sVrCNmBlMDNANJoKbX0o4Jo33lJ2oQeI/1oq+OO5RslljoQCiqHsK0cUf0kh?=
 =?us-ascii?Q?2IJF9tiOi8dpVSW90VNscnLGShnFOT5COZmXi1SB2Kcqg2x72EbLavC0E70z?=
 =?us-ascii?Q?+KjLtAjZpfw1V2hXKKcF7I1QD3mR14xbSjOvxdVIYpHlc6D6rwDPROMJIA4Q?=
 =?us-ascii?Q?vmU/KV17p1huX1BqtFKwflH7tXBxvQHE4SvUXnZTYfyZ+lEjGB4u15K6s4qW?=
 =?us-ascii?Q?2fVjRebsfAXA5s+1uX5P4znXI7qzACBnzpT2zfYykB0QfwNg+Hbkz/gI9dvA?=
 =?us-ascii?Q?asO+rTVt4gxxjpOb7Zii7mfFxh/zjA58pO3lbPuviLAlaccatobHt95exjcO?=
 =?us-ascii?Q?FluN3G1vX1dW60MnRMTYLK6kvm1Kk2AjeTpsZsFe4HTxCKGgoSo1mQ6quqLN?=
 =?us-ascii?Q?Cjy0YbKEFFk2UV5UyGWjjYL3yOLwchJgMFA6UaeroH2etE4tx/upb7yzcRVQ?=
 =?us-ascii?Q?P1YgvkcsrSwJxUYitbWduEDX3pOT6IY49WmBxJ8KoocZDdDi+PGOLUwSGBfZ?=
 =?us-ascii?Q?VFPf/Pd0RjXeZIVbd12diI3XztO49MFGMSGVPmZ0cEMzdvOin5ZixemxgYQ3?=
 =?us-ascii?Q?OAvv1blkaM7psL5ge9PlM2e17zd9unUdTTXLCqeobGFQeJ5lxNSXLSbrm/8N?=
 =?us-ascii?Q?eWMUo+sA1KEa2yQp2IoyR7zBamDeoboysCGNmPy7zpL52acIn0wb+Xk737VJ?=
 =?us-ascii?Q?ya2D6PAmu8FBHM8ZQYK5UBykr0fhAODdXjpE5gD96F5316788ge/nSobCHtw?=
 =?us-ascii?Q?kq93RuhrId/yP7QYXhmC2woDEaJ9qHOY6VQK5NXk48Q+rw/uifPvSoiyEkbB?=
 =?us-ascii?Q?EEt2kks9z+eYfiLyKI3xLy69fhPPgDm6Z6SfWkeW+0e3nv+I5+W6FRW9lwmn?=
 =?us-ascii?Q?hhtCSdynC0J4Wy65JggZBlIZe9dtQqxKMjsHWEO6hzywlePV3zbyViaOBY1k?=
 =?us-ascii?Q?KXs93iWJ9Uw5OIq0bzY0BLqvFaCV6YfZTQhq5kpw4MHYglAxUFuhmDBZDfnZ?=
 =?us-ascii?Q?spDSgEu8lxNTb2OF/rIWOLGAKI6pUBxaIvuzcb0HTNnzj/MZdxl/7ajMZiqd?=
 =?us-ascii?Q?7QPWU+ktwg9f1TaXszZfJmvVZ81DliDN2yARIa3YKklsPvs2IJp5g3ZbeGIH?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e183dcf7-46d4-44c8-828a-08dc79ae4501
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:54:17.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi0HZM51SaNWQ1JW5FdX8+82paV0YHismnEUNk2XYtz4re4Ozhg3IZD1kePjUEy1DsjodfohOOgDIjthx9caiqPMwxl6k58ObRlQ+hlDtXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 17 May 2024 13:20:06 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > I would prefer to just pile on more explicit clarifications to overcome that
> > instinct to map the word "Inclusive" to a multi-level cache attribute. Something
> > like "note, 'Inclusive Linear' address-mode not to be confused with
> > 'Inclusive/Exclusive' multi-level cache organization".
> 
> Hmm. I'll go with 'maybe'. When you have to add a bunch of distinctions of
> a term that is applying to a 'cache' to say that you don't mean the standard
> meaning for caches, it feels like a new term is a better path. 

Right, but that's the crux I am talking about the address organization and not
the cache policy, and it seems all too easy fall into the trap of considering
this to be a caching-policy attribute.

> Possibly as I suggest later a hyphen might avoid misreads.
> inclusive-linear address mode.

Yeah, that is a good idea.

> > > Whilst the CXL side of things (and I assume your hardware migration engine)
> > > don't provide a way to recover this, it would be possible to build
> > > a system that otherwise looked like you describe that did provide access
> > > to the tag bits and so wouldn't present the aliasing problem.  
> > 
> > Aliasing problem? All direct-mapped caches have aliases, it just happens that
> > this address mode allows direct-addressability of at least one alias.
> 
> As I understand this the problem is you get address A in the error record,
> but that actually means any of A, A + N, A + 2N etc and the issue is you
> have no way of recovering which alias you have. 
> 
> Another implementation might have the same aliasing in the cache, but allow
> for establishing which one you have (the hardware inherently has to know that
> but I presume in this case doesn't provide a way to look it up - or if it
> does, then issue here is that the OS querying of the CXL device doesn't know
> about that interface?).  So I think the critical here is that information is
> not available, not that aliasing occurs.

The critical information is that the address range is extended by the cache
capacity compared to the typical case. Maybe "extended-linear" is the term I was
searching for last Friday when I could not think of a better bikeshed color?

The reason an "extended-linear" indicator is important is for the driver to
recognize that the CXL address range programmed into the decoders is only a
subset of the system-physical address ranges that may route traffic to CXL. So
when the memory-side-cache is in this "extended" mode there are more addresses
that may route to CXL.

Again, whether the address mode is extended-linear, or "non-extended"-linear the
math to find aliases is the same. Rather, Linux needs this indication to break
its assumptions around which system-physical-address ranges may decode to CXL,
and avoid misinterpretations of ACPI SRAT/HMAT and CEDT.CFMWS.

[..]
> > But it is relevant. If the near memory (cache memory) is 64GB and the far memory
> > (backing store) is 64GB then the SRAT range is 64GB (cache-excluded). With this
> > new mode the SRAT range is 128GB.
> 
> Sure, but this is a cache, not normal memory so in what people normally expect
> from a memory-side cache (write through / write back etc) there is no
> reason to ever include it in SRAT. Hence it's not 'excluded' it just has
> nothing to do with SRAT which is about memory, not caches. I'm not
> arguing it is irrelevant in your case (where it clearly is because it is part
> of the memory), but it is irrelevant in for example a write-through cache.
> Saying it was excluded is implying a lot more that 'not-included' would for
> example.

Ok, that's starting to get through, and it seems to support the proposal to call
this address-mode "extended-linear".

[..]
> > It was an attempt to show precedent for why Linux needs to care about the memory
> > organization and how CFMWS does not achieve this description. That said, as this
> > is text that only appears in the justification for the ECN I do not mind
> > dropping it.
> 
> I think it risks confusion given it's not directly relevant to this.

...to be deleted for the next rev.

> > > > Address translation needs to consider that the decode for an error may
> > > > impact multiple components (FRUs fields replaceable units).
> > > > 
> > > > Now consider the implications of ["Flat Memory Mode" (Intel presentation
> > > > at Hot Chips
> > > > 2023)](https://cdrdv2-public.intel.com/787386/Hot%20Chips%20-%20Aug%2023%20-%20BHS%20and%20Granite%20Rapid%20-%20Xeon%20-%20Architecture%20-%20Public.pdf).  
> > > 
> > > Other than telling us someone put it on a slide, that slide provides
> > > very little useful info!  
> > 
> > Hence this write-up in the ECN, felt it was better than nothing to include a
> > picture for reference.
> 
> I think that left me more confused than anything ;)

...to be deleted for the next rev.

[..]
> > Sure, "Linear" implies direct-mapped since fully-set associative is a
> > non-linear arrangement.
> 
> Sure, but you haven't introduced linear yet so this reads as more general
> than intended.  I'd call out explicitly that if your new mode is set then
> direct-mapped must also be set.

Will do.

[..]
> > I still disagree with the implication that "inclusion" is a property of the
> > cache and not the address layout for this ECN.
> 
> It's an ECN about caches - the chance of misunderstanding is high.
> Maybe there isn't a better option, but it definitely makes me feel uncomfortable.
[..]
> Maybe hyphen will help? Inclusive-linear Address mode?
> to avoid reading this as separate adjectives as in that this is an
> 'inclusive' cache that has a 'linear address' mode?

Try this on for size:

* "When Address Mode is 1 'Extended-Linear' it indicates that the associated
   address range (SRAT.MemoryAffinityStructure.Length) is comprised of the
   backing store capacity extended by the cache capacity. It is arranged such
   that there are N directly addressable aliases of a given cacheline where N is
   the ratio of target memory proximity domain size and the memory side cache
   size. Where the N aliased addresses for a given cacheline all share the same
   result for the operation 'address modulo cache size'. This setting is only
   allowed when 'Cache Associativity' is 'Direct Map'."  

[..]

