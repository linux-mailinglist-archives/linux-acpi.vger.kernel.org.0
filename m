Return-Path: <linux-acpi+bounces-18569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9FC386B5
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FD03B1AD2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFB2F548A;
	Wed,  5 Nov 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWvmlqm0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD322F3C09;
	Wed,  5 Nov 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386816; cv=fail; b=J3vqUm9/2uPInOdh2U2X5oiOqQhnmEz7HrVgoElKPncaAzQc3kfA9PLXn4/HHwahmj9uxWZKhHljZNzS2OCpp3KIUDBHwyrfXZbNwjSwLQUkHeySkj1kVoOvkYtCHs9Cz/RGolCVTSNiwDffToLqZ4hU+FKS8Rdvj+eOXwrUSJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386816; c=relaxed/simple;
	bh=5aWoz2EsWUVZeeywef4vtFkZNc+lVOEIv5J+aHJwUnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jXsb8N1QiyNXcqnWgyjcwvOmO9k+cvo8tn/83B2Qes+CR5JbBHTknFwRhSO/8dv6OMZpPtv4ALND6KKhq3EmJAnOZwKCUlyI0x3IcURepdPsAsvzC8bCNq/0wA0rMuhD52sf3/v5JYgM7d3+kq13+rj56LZs+jAQt3cEUZKQQ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWvmlqm0; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762386816; x=1793922816;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5aWoz2EsWUVZeeywef4vtFkZNc+lVOEIv5J+aHJwUnU=;
  b=IWvmlqm0yPb8nM+3qhWOAORsbbN0ZYBUtrFecXo4lirW+CGKKgFBrepi
   Wtnub5g4XUOk73fqtOV7U6ZnWtkAZjKQt3snr323XFgN4ChvwJ/qNEBB/
   62Lz76qBRKgAKdPupIMbHKxz6/ZzKEer0Q3UZntGSp1SO6z1W3uzjR5Ou
   NbOfXfzbWLxOTozDsr6l47/nuoro6M2hRTNplcJZaTQglOhiiSkSVmAoN
   hCXQT9GYmiUczSqfnaqBncgxE1ceizgjxofXX6HK/YaRAX9h/5pGtAxDs
   2K2XAtNPrGIMkZRqJ77iBta/0Je3KdsQR7rIrEOJIlC2xPZNcWlURw2j8
   Q==;
X-CSE-ConnectionGUID: G1GXdwyKT5ahSgt6rKgw1g==
X-CSE-MsgGUID: VKzDwwO2Ti664+jDq9i4/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68354754"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68354754"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:53:35 -0800
X-CSE-ConnectionGUID: glJdHPY8S6StfwWzjNycoQ==
X-CSE-MsgGUID: LPCLdlKRTruy8RwhwuSHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="187544801"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:53:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:53:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 15:53:34 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:53:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1tRG5/DhAnX3irX49Aq268L2W9Vg8hGJ3J9MOtIoVZI0NCfIDLHeLszHjqBw3XNXQ97ysi/APHifOrJCjpkfhKWBg/5uFIaErCSPXa7mdMGBIG4hmog/KD9DkS30O+TJUzxoG7lLxZdt7m1aerTM2E63Uum+Y18GseD+VP0IKZWXRda9+COGL9p/pOn/pIQDekD+ohtuxOf0o7Fbl8Ekubz7V+FVWBlrlZ8lGfWZqJyi/EAY/wB5nHChCDucgwxwV4IaeWcbVmiWlmfDYW6mpr77k8K/C0GMpKG6EDV6KY+okMNpJzp7K2+Lif3Rh5P0eRKD+k1BIO+X0zsgKDizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEIhfYVVHwmF9tmk/NxzwVwpgrGcSrW7KctnUsN9nqI=;
 b=a6F+FIrIJvlGms4zjNnTDszC3cEcJapM80nTBSyn+sTORHeCjpwRGDk40E+KYttXrZ8ALQgtF8rYFcNcw0nS1kFceJndxH74hPS7oH8Qzjv5ocazej5Ovfh7Qh3rcEdgRb/mrtVcbx++DYaa2FEAtKNCs8F02gW+mrSUrs1tQXng1k2US3bS22sg/TVtww3r6cmFs2hnyGcEVnXfribxSefUqnyJzXRUQEijGhnezifsc7pUPzUogcBIt/Xxsq5n17QUjLe+RG2IWYolicWIXuWh073w5sxYNmITkaEWoswUYqVRPj7cHIay30vLTXUP1KXHkzVufM3Q6WfhC5QD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 23:53:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 23:53:32 +0000
Date: Wed, 5 Nov 2025 15:53:30 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>, Andi Kleen
	<andi.kleen@intel.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Message-ID: <aQvjenMVnpOgne1t@agluck-desk3>
References: <20251103230547.8715-1-tony.luck@intel.com>
 <20251105211924.GA1264471@yaz-khff2.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105211924.GA1264471@yaz-khff2.amd.com>
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd48474-88ba-4422-c7b7-08de1cc68682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3CtEF+TfDg3w6KA5f2lSHEgREcwppPJIPRHsqH+Y7MKQ3dW+x3vwYy9qHkU+?=
 =?us-ascii?Q?exWvhJauspQIbnGLc2vCYQnycfoKrtDiUD/NiiWn9GMaKHn9y1iAz0AT4YJ8?=
 =?us-ascii?Q?jA+pmnus7f3Gt+ndyHMnDAUYmE5RtaHfpnZd0kZy1xTtXH0QkrvG6oZWJvjd?=
 =?us-ascii?Q?qm7HfLL5pSQ6AJCZTGVslDd2DT0G19Mzre/yGWraYEW1XR376D7n7jofFA7a?=
 =?us-ascii?Q?D6LPtDtLFvvwOX0nOHfHEQVDOi2Y5zV3+ApdK/B5tgHy4MzdKQsG7eeisgJy?=
 =?us-ascii?Q?Q8ktbLfyO0Us8w7B/k9vWJmLGx2FgwoQcKdR+iL4rAj4q7NtDZTiFoi0Kn4+?=
 =?us-ascii?Q?H3TzPa57XNBWpt2gQ9LvDcXKg91r/7qXCAYJhBSklpL6EfNdwLtVJqKf8+6t?=
 =?us-ascii?Q?N8BAHL3VSt9FtZ3Pl3JuOPn63KkEtYqDb1rOai41WTwAiirtccBPH6xPvCr5?=
 =?us-ascii?Q?Od7bMJ/uDlFU7URkV2f84B2SDTqD1Rk97QyROlLlbTlc1zk1w61GZaaNCBYR?=
 =?us-ascii?Q?L5jtrcYbHG/XcWzZO4gqxlRZbzsAlb3kHbVD9ZNWaZtrnDwfuBO5DTbuWICP?=
 =?us-ascii?Q?7LBbo3FGxTJ+8odGps92s/KonkNPauuKY5SUocmhn0YhEx0d4ZIPFc+IYSYt?=
 =?us-ascii?Q?vgJKVGV7q1xzl9XWt1LXNNcAdATwBuXjDCZ79b5VqMYUO7H5HlIVYA/HUARF?=
 =?us-ascii?Q?BptTABJjjcfxA6AfXv1GWQj0hNJB6xTRUCRagAoW3IOLKU3WjVnp/UrF2vC/?=
 =?us-ascii?Q?DmaBykDcPHG+U+KA1GV2TQh+m7kPVZiHWuwnVqQ8XgYsvffHGT7XcHUkCKVJ?=
 =?us-ascii?Q?VkZqZ4gzq6D/WeyUmiIZ+zOK1Ci1f4/uCH4YEsfQaxsSHfCV+mI0XHi3EmZe?=
 =?us-ascii?Q?LmLlUE3eeCZw5rVz1hpVaJwsp0O9AnN7Q2bGX0jryrGNFxNrXJiqnojcfQUE?=
 =?us-ascii?Q?O9GgZzFOKu//yD/+SbQ2rIcg+HLp/hKBSatzzM7q6cnK5nBDVEdDYjSu7neP?=
 =?us-ascii?Q?icBapGIPdrQN4Dc/UeZGePJRhkuEMO+vmcbYDpAy6xGN52WeGS+LTFXZslw4?=
 =?us-ascii?Q?MfkQDo54tAQ/2H7YwJRY+gj5pCCSm7YPKVrf/b7kCcYLJhDQCvvSAl7ZY9t5?=
 =?us-ascii?Q?7JDwBW0S8sOpCDPYp3NzSB+/e+SKpD5RMPtWUWYcmRnnXuWyiu6bQkpV6e+7?=
 =?us-ascii?Q?L7JhLHsDsbKUVgGIIdGCjUsGJ4x82njsbT5DDEOf6bydu2Njb3+ii3zJxk2i?=
 =?us-ascii?Q?oYIPY3IO+3HGaY8QIkzWAgq7Wz6rpA6SRMwWjla+SXGKSMcRXSmJw0JYiRWe?=
 =?us-ascii?Q?yYdo2wO0kI8fNaKJwrxqKDKRUItWZ4ky04J9IULNErgFvrx66DpNNutJIZVw?=
 =?us-ascii?Q?yZkMgGHKnFkAUP1FW6Mhar6lNJqCJOaKQvVpi4Ly60BbrBM9FVOchwiNjpLS?=
 =?us-ascii?Q?kT3GqmctWFpfrkj4kUmNxgxmfOkhNEVGM5IPZbWJvos5Mubj3nVRCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yb7G4zv6KNRCeMtJ/l0dKh8YHZnRh2mf13yLpEVBO/dMQ7RBxgDlckm41fa5?=
 =?us-ascii?Q?1GrqVcmX6Ypo9lpc2SqluA74mcY9pV/5DvPHnzpXb4bb6dwgvzxqbnFkXhcO?=
 =?us-ascii?Q?oR8I0BgaMyWWpJc+qSJO4UdXzRGXPhaJR+BJ3R0Z3q0Bc+EEY9lcqOHQpmSZ?=
 =?us-ascii?Q?xYGBCcgkWTrxOt4evwa2/vCgyexQWkUBW2XFIBspXODWD4DpN9PLcHIPxApR?=
 =?us-ascii?Q?b45i8P/0Si2kKVg//7AoH2vwFbxtME0m7kEfgnY24FNNQakCuaCnUWxqTY02?=
 =?us-ascii?Q?USGu7jJO9Bwv0V7nFEb/0cl6a9vQnCphNzy2XMfVusjAc+oxBnnVOFGsRqez?=
 =?us-ascii?Q?X9TwZFsPQAUeW/JICpiJa6bBfUsbNfbI7KRC+obuCDTYgKggceCjLl6R6jFH?=
 =?us-ascii?Q?WNdOy7l8VC+bc5JnrJKldZ5mwVz5u/ZM78TTILam1Lh8Nz4VdycRY6K67daw?=
 =?us-ascii?Q?5BYey2B4c+zh9VaPlB2kR7sdOkTuJyn8AS9rimcOB/v2CqQTFeTgFYe+GPF/?=
 =?us-ascii?Q?j7faOQi5tzTSx3FMXZvKT+3jcM7EKkslccmCN5QgLIF+lZy6UiCw5hhZaxig?=
 =?us-ascii?Q?LabVgzlV0v6e6gVaBHuLO5JDqcPaEoSPR9+ul5z24gNnsCAaCwd3+Y2oK3OE?=
 =?us-ascii?Q?4vFe2l3/A2KZXQZuGRm8Dhajn9f+KsllAAIuWr2D+EFWdu+Ixbgn2F9IvOId?=
 =?us-ascii?Q?6iu6NGTHEkmscOzwkvYDPzvQIuV9II3vhFYPC8ddmSvH9g4+cI+3gsvxVDCV?=
 =?us-ascii?Q?iVAR1X/tyz8otVwIQ/qfgV7cKDCzDTCil2pLpdXCmyXEexdnrjrhghbIHek+?=
 =?us-ascii?Q?l8KPsujEXcXF9A40kdHEAxTuLEReu26VeLB2ZODz0qx7mv4SiKUpnv4aoe/z?=
 =?us-ascii?Q?wbeV81DB5zyr/Xn8wBQgFk4gYKbXBJLebA0rBzqwUMaTl4jSZrf0u1hR0xyF?=
 =?us-ascii?Q?SVsFOr7a8XBjvKoiz27QKoTHOBge8Xk75hDniH5Je2ryJvedkhRhcuJ9SHxE?=
 =?us-ascii?Q?9z+sX9OfZTfo/4IjvsXLxkAEPBMkxxCGOjaGFqXst6iqOoCLdazHWZiZCFw7?=
 =?us-ascii?Q?4gi1OJ/ICPajtHiZJVDFsfhaoTt6EWqjvNOmp5bNujrnwCRVkVKw3NGGZegv?=
 =?us-ascii?Q?IY4xT3SbUmWw1KSxPs/2+OuApjUXP7LMHwGKRcYZyKGAAx2D6BJ6RPOM37Df?=
 =?us-ascii?Q?b9VlTla+Ky+kl0z7I4EG2Yv7IhstrG5BFjBJ1FuL9g/7MHPb3/P/GH1ybgoN?=
 =?us-ascii?Q?XtkZr0VRESaJMR2LE6repMBUBLSZFHDyNr2m86iCEQ3k1xF8WZGRh6/8dgwg?=
 =?us-ascii?Q?0jcE7A6F7wecrGTW0oXIIvnX6GJgADEClFIUAkmD3B1xcPn6/zhlFJBWExSb?=
 =?us-ascii?Q?d+LMYzOYoIi2KeDIYZjPWhkxI+TdLjk7+jtmvF7vGKseTazHg6JEXp7tD76D?=
 =?us-ascii?Q?Q4LYezvjWr2qQFZXMDMTlr66G5iFnLBlotMeYHAzzH/k/I48i5YMmXPH6w+i?=
 =?us-ascii?Q?c6AmLCvmBpAreIRMTPmsEljlSzW6ME3ugGjsW/y4JkHSw+IaAfXzCCS72ey/?=
 =?us-ascii?Q?Of0r+gDX/j3ZoUfTNTGbem594sUfDhMJzTxpwaPi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd48474-88ba-4422-c7b7-08de1cc68682
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 23:53:32.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w14Gxh6pP/czMAn1oAXSReF35c7HF5BezJBSBi5uFLaYQx2i+BP8WrNHRr1/bAzcqawc+GvIH7jAx72MnlEPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8396
X-OriginatorOrg: intel.com

On Wed, Nov 05, 2025 at 04:19:24PM -0500, Yazen Ghannam wrote:
> On Mon, Nov 03, 2025 at 03:05:47PM -0800, Tony Luck wrote:
> > N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
> > other architectures, so it would be wise to get confirmation on whether this
> > assumption applies to all, or is Intel (or X86) specific.
> 
> I think that is how the ACPI spec describes it.
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html?highlight=hest#error-source-discovery
> 
> The HEST and other tables are fixed at init time. There's an ACPI notify
> event for if/when a device method needs to be re-evaluted, but I don't
> think anything in APEI expects that.

Yazen,

Thanks for looking.

James Morse pointed me to the fact that HAVE_ACPI_APEI_NMI
is only selected by arch/x86/Kconfig. So scope is limited
to x86.

That "18.3 Error Source Discovery" section of the ACPI spec feels
pretty vague. The "During initialization, OSPM examines the tables"
bit is comforting, but I was worried that although the tables are
static (so the generic ACPI address from the NMI error source
shouldn't change) there is an extra level of indirection where
that points to a location that holds the address of the error
status block. Some might not consider that as part of the "tables".

Further pondering has me 99% convinced that there would be no
reason for firmware to update that pointer (though it has led
me to wonder why that indirection exists).

Rafael: I think this patch is good to go.

-Tony

