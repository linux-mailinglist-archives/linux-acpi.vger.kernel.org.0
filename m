Return-Path: <linux-acpi+bounces-4305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AE87A2C6
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 06:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAEDB20B94
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 05:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E112E6C;
	Wed, 13 Mar 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1mwjvxa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979E610A3B;
	Wed, 13 Mar 2024 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710308888; cv=fail; b=Ox7yUf6HqsuRRvM1Nqw4fmOQX/WZwaI81qEoLcrElTX8Wh8Pr8L0pfyot9OLpqnD7XDQwKWm4CJqFljnhQ/i0mE2Df8Ef6UWtCT5llQLDouhu1oVBAFB339KFX7LKHu1UxWWJvCuDXHrmfloE40v3OXnI0LS0IQ+DqrNzGlvF6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710308888; c=relaxed/simple;
	bh=n8tX5Prmg2SoCD0gm1NV+OvA0rvMZ6+9saO/33t46DU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCgFuJJbyi0fQbXqt/vidMv88d1caU+NHwqqGBZADEAiYUC6L1v42uHJV5iQBYs4NaapI8aDP+oVl8vzlpCicVmkQ8m+6UiEwwabNAygzGEbR4Uk5A24wS9qi6Uh0YZ+vJ5izbVSD3y9Kot4SGLtFCdDGevOOf/mihUPkekTVoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1mwjvxa; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710308887; x=1741844887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n8tX5Prmg2SoCD0gm1NV+OvA0rvMZ6+9saO/33t46DU=;
  b=B1mwjvxavvFZzk4OBeAi5Z16alaRXBsY2x+mpQKuhNFDwJSZuvYfkznJ
   ycGnH059ZHThPCfXI7hW/B8Z9r5csO7q6J6NhE8TC2O7RJeuZ9bwmvwgP
   0UPwEFrig5GFi68ZlF8/YWPbOSXCDdCsmlblohFvIV55oCKAbq703p5qu
   OPZ6w2tInfRAuVv1TziaibGYjpN/LUOR+nBQI4Ktq4pksgV3sIOp/qbCu
   UUYKRt3JwYMvOUv4q81q+XHjIZAIza4y6FMEzRUqq8AfyXnz+h33XfsmT
   8LDfuvkgV2B04YgESbRGPPkyfzNByL9jklwX6EHUqRE3yKbID4M8WzRJx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="7997244"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="7997244"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 22:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11690573"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 22:48:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 22:48:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 22:48:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 22:48:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 22:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8SWdPLMRRcplWNjANhoJT/zVnfwtFB7m9xxLfkwd1Fwx4TN1IzzqfwYjd7aQj25wp/xpRjnvFIkuKRYTeE5+QArUF7T3N2/XU7unN8oIRSA2Zo4YLm5x4Qku+81SbO62ku8bnqVFfSAlhgFHij5sRILdjGM8TVoIITO5lHwDdyvThUZA0sHf8TAnjillWVRZAzzCadI1c1LsyUcdMAB8Ts7F/4dsud3hHZAcFjbbU/6IEBnAbgop1MtyTuMgg8AkIPvuZ2PPp9XJv5B96XPSRt+xc4VpEdYaASysrNdATHKYsZD/pDfEf3k51ZMWpXIS3RQszbqVANnP6LkZSEHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olFCBrg9V+zHDHf6bXn4MtCXrfRapuMFx7YsTcoJU0c=;
 b=lUww8yas7td5PF1gtKs0TckVEInZt/rPgPG9YXlN/BD14Wv5gibJv8ui7LwG9OMNLOseVZ8zQQ9uL/5KEZTBxbLJ0Eo8GDFKhqsLQ3aV8ew5X8rCkuOdN3aNqpx2vRjm0xTr0zPhXgUKt3KwP8v/3VuZIfXUUpoxlihjAJsJLdZKV6zN/mg99gJrtCy1/EVPxgbqQIBdAEY/5H55WhbMvhKixP8qXVASqC+/EYmKJM1WsTOzJXEDmtp5F05CKF57AVWk62TBS9Zqq8VJ2bZLjO0+FhZXni6NQbQ3qCX0Y8RngdPrVsPFhbX0AD+n9ljBnoskb01vRNBUiRUsnNcD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6114.namprd11.prod.outlook.com (2603:10b6:930:2d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 05:47:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 05:47:56 +0000
Date: Tue, 12 Mar 2024 22:47:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v15 2/4] EINJ: Add CXL error type support
Message-ID: <65f13e08d7680_a9b4294ac@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
 <6f4d6962-3093-4f21-93b8-f2fa2bb2b465@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f4d6962-3093-4f21-93b8-f2fa2bb2b465@amd.com>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ae1a7c-c59e-4bfe-1048-08dc432121dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVbwg4m55JLc/In+gm0fsqzwEZqFRpaPrWImHU4260+HdoHWQ8q0T1tVTjLmYcFy+zJEO36ikIKzrH9A1L5GxRPuNm4si0x51YeXJFz97kcH+h3lgqQn/DbIIsS7cOhR4NOEY3aoERj7u8VYIIoj3Vpnh9rNeJcAEf/JAjmXxSYV8ZMYQsTwYUsMrldRkBNf6i3aKQIc+b+lKxwhzkQNdAnWhQHvixLAxboJmdYlFtMyCY1HNM2zqhQ3pIFya/T85L6FNtRMAMFVXMhv0BO86bpkOMk8yX3m18GiKjLbY8FkfzJ5ijXovs+VrOPx1y7ji/pmbG8mFjwMrOtzcviMPRH7BlEvDUa87zfysq6OoAGP9ajunbrK1iBKE/0jNZEgVfO3wu9fEUP47FbXP0hvewNyC2CzLtgpjovgODEPUFJUG9Nihd+RGUPosAqk9c0rG3Sc+hhDDtJ1mLQbDM9SKL2Ffet7cIa565u84w1fpOLEBoSOWzhlVBc7mWtYdBJe23ItpFApBuswMW1B8iGM/IclhTR5dX7V88KObkgv/s7c2D6j+f3sL5ZG0epkNi3z9FLscce73U4Y6Qwz3q8tkWYTf3nJEGiCMJPrAsA8CHnZLLrkWU7RdNgsWgOrTNcqjYQn13ALvalrIWPjDexd37H2gnhw/avlroCQUITJK+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6N9Yte+a6v/5r9pgqptEyFFCNK+3CP2uNrp7h0Ck5g/XNvAiPwtJ3Gn2ygZN?=
 =?us-ascii?Q?lPCOCOvzO/7DSL/+H61n4lZQg1M8IBJIEWnRMox+GxnsO2aSlFaznT/NYrXO?=
 =?us-ascii?Q?fsSI68ZJ0EVssWsK9mdYVVFwxiImibLSUW6/rxvV6VPj5256aa8hubclT8Bp?=
 =?us-ascii?Q?H7SLPgyLSwHaOsvy7t5M0j2KKcRWVO/+vGeoDQi/Mf6Q4gov0IdH4DPluYb/?=
 =?us-ascii?Q?E5zlkJME/G1EWNLnf2T1w94avr9bA0OmCeHnDT0hfHAYmDe45J2TJa/2D9O+?=
 =?us-ascii?Q?Fap8n4g46tStmN//j8DetRM3IibTmuaAiTkcpfW73O33S6KEiDkT4dk+hSx1?=
 =?us-ascii?Q?cAM8aEO137wkclxryZPHWfC3lvhHjK2JwG46mm1nlb2nsBsFJe/fZdudOhmx?=
 =?us-ascii?Q?I1eTHvJGtdvueQok0PmvGrjzyui83cuCj1bKoHP9F5EFyHz8QF/HuFmL+s7l?=
 =?us-ascii?Q?BEq8zQqMgK43PlNGdux8ySxaOj/dtYXwyutvIqwtv+ld6+z4yU/TCEPMCgbH?=
 =?us-ascii?Q?A4zk5oHFwPKbIl4o8woP5xuuaDKDy9Lm0VslZgGkxV4P0fGDA+xgYnoMG1V2?=
 =?us-ascii?Q?M5H/G7Xs9x4jTYTo5/b7d4n5pkVsGUbSxa3112+BtF4Epn/ipE28fdjxVBuS?=
 =?us-ascii?Q?7KhfrbWYaVsiYGYGlpJCI8Z+pS6RLHy4JO64N8w5ZR+mDoTHC7e65P46lXoW?=
 =?us-ascii?Q?O4JmytJdSLscSkGNia9yQL/HzQGpfaw2SN6qEFmhrunlc5m6VAQC1V47wFrF?=
 =?us-ascii?Q?WVdKZ27/RrYhHmiUO6Cb/uVrQUhVFum7J1uzctWxYNJVjdMYmpAwWi0F+n0P?=
 =?us-ascii?Q?KrxFLooj6raFmFgH7pYdsKCgaaBvgGU5BBF4O0f89zRchPspyksxVUJXs+mj?=
 =?us-ascii?Q?ynhr+vcm3JFTkcNvIsTD+v3fu/mzupJDWarPnE5jwniWjQNhSMej2sUwDAjj?=
 =?us-ascii?Q?4GhzQNfJoPglYozthwK/k/Ci34GmYtHVrbm3JVksqU50TjB2Zhiphr+NOUqF?=
 =?us-ascii?Q?eqTJVhR/vCzddBCZcg6foFlfD2fJ34gEJsAhqbOWrh2tyIvtOBRtVOp6fvfy?=
 =?us-ascii?Q?M2CZ6s6K41z30WvH65fIhIvQjb7xG1sEk+LOsp94fKDjH/uhWgUy53cODVqu?=
 =?us-ascii?Q?KHZYC4PDK/QsCwXdFD9c7FJTknr6d4NCqw+lLi91WSYZMwYkj3yM6GoslenB?=
 =?us-ascii?Q?LKrl5dtMEnO25jkWnVjI5OLrYmcSbnGHDiot29oXwv8BRkXKA8JvehlZDT8g?=
 =?us-ascii?Q?vukP2sJOI7QLGNTPrfPuerej3KBX5MDBRygjjCqTOEircgE1iqAcso0+3A7Z?=
 =?us-ascii?Q?hCT0f2YiWoUkWGqKnmKckXiM2hCfsgGdNs8kog+oobShyqe0zl88homvjBN+?=
 =?us-ascii?Q?EWUWmmN2OC3kvLEhh5m4EZXsmsRf+t/FQ8+icHCKlBJzSjVUUaj5DIWRUPe7?=
 =?us-ascii?Q?qG2sThWb3H/DlK1ebs4IQ4F2Y+ZXh8doDRs7F4NqoHEGZoTN2Oc3yHrwivhw?=
 =?us-ascii?Q?/KoJBVcwYZVY0j5YeU5E9mmItAjC5zCZ3DwgIWp5lbeUhtFhUhTmUQKaA2N5?=
 =?us-ascii?Q?Bg040wmV0a+IViX/UpKzX6PsxNPe08YjStT/f4xoU6FX409GmgskzNgVuviY?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ae1a7c-c59e-4bfe-1048-08dc432121dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 05:47:56.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQT7i3xFkIy7jbJ8f3bRWpl0ni5yYHtuwIP7l7nXS1Gx6JSa36VtiLdlUvi5bqeRjMqiizddRo36CO2+GdwE5h8ixerkzyzNSzSvTax+ytg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6114
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index f01afa2805be..3cfe7e7475f2 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -63,7 +63,8 @@ config ACPI_APEI_EINJ
>  config ACPI_APEI_EINJ_CXL
>         bool "CXL Error INJection Support"
>         default ACPI_APEI_EINJ
> -       depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
> +       depends on ACPI_APEI_EINJ
> +       depends on CXL_BUS && CXL_BUS <= ACPI_APEI_EINJ
>         help
>           Support for CXL protocol Error INJection through debugfs/cxl.
>           Availability and which errors are supported is dependent on
> 
> I could send out yet another version, but since this is a one line change I would appreciate
> it if whoever picks these patches up would just include this fix.

This second version looks better. Will fold.

