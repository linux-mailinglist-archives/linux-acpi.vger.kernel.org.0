Return-Path: <linux-acpi+bounces-16424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BDB46209
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30AF7A4B9C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4AE30594D;
	Fri,  5 Sep 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fphx6olA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC638305943
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096244; cv=fail; b=G2JrR5pk+H+heeK2ftpmUWFoC/aRp6g04+MmSA9TWs1/pBpd5NQ0VvafqHzxDBkaPcFO6COhCJ1+jdha/PnI02JELMUX7jOGDLP3Mxg8GNbVVv9X/+W25SqPfh5Te61KIt3TsFVgFNSxu68Za0fs+xMp7qvhwSFJijHwTU4I+uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096244; c=relaxed/simple;
	bh=NTvbXk/fcQjb013V6oTib1DudN7TVqoYCHD80USa8cY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJdiAzKRf6ztFAdYzqLon97/Ec/S5YV+ZkCli5ynuYw8hpBlWft9xhpSY1RXY0nt181i9xS/rwb7P9JBF1gKnyt+FSEH6ULuT4wXwSEJJeYbJ6CWJXJhjMaSRoTtlM9ZgofThA7ZjycVk5OE2CL5m2YCgoQcRDjBjAhZq66zLxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fphx6olA; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757096243; x=1788632243;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=NTvbXk/fcQjb013V6oTib1DudN7TVqoYCHD80USa8cY=;
  b=Fphx6olArJmRJ2pAu4rkUo8lUOUPexGJRc3j3EYxLVzrvFVJp7vv+lD2
   a5KFVBf1OvS4xrviPjsM0ovNmeYAfIpgbC2NW784UdH+YR+qYVt4U80Ba
   tdMmJXocu9tuNb4VjqWDmFs2xaigDAJROO1x0oJ+mvGrGF+eCrXQTkqyO
   LxpaGc4O3bMNTVxS24QbDp6g9keRjl6vSWT/x12AnW6X+x5EcCYl5z3XW
   nOOmLUkONVjsa9v4zbcmsuMFviQhMVuagUa8zpjFgRknzKHt+y4QCoDPC
   wHqbDJNr4QYjEzGVS22C7Ns9nVPgCB8FciLto6EX1yK8mZXPa9nodFEXj
   A==;
X-CSE-ConnectionGUID: pEF0hPhKQiufmMDzgCU5Kg==
X-CSE-MsgGUID: rASPe7cLS7KcpmNIz1mr1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="69711859"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="69711859"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:17:23 -0700
X-CSE-ConnectionGUID: nIqsc1jlQzS1vRM5ocEe+Q==
X-CSE-MsgGUID: dtUMDcPIQxWEfTZoa6R/yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172108153"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:17:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 11:17:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 11:17:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 11:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIrAxS3vQcoghS5z5xnDVe7o8yFB7sqVHr/c13A/AMRZappR77fjbhUOjzusI0Dk3JS60pc8tGoT6wCiPXDRJZWpJz8j+Zoa6XSFJTfUQ5shSPoKmazNYNMCZmOYni9xG9hdFe+c8JnJV/0aq0H+Bh/IsBAYvSxpEgERmkfRdVvgG3Ux1TkYVCYAu+j1OjrDeDIQLghIm3zNszONKwDGyJ+2f33w+7lqjttk3RP30nCyuCPQnLU5bTey7THwXp+hISVKEytEM+w5cGWWaSTCVY2wL1bG9wDFSSR17MYyW6+DD6296bU+PxYKJ33ikGOFyNf5azBaIidgQbGtpDrPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSNBUepBV0NLBKXO4hD/x/32Bg9vZ1O7IaiMn1spFXQ=;
 b=YWyMirutfo773XhmrEKX5MUyD3K1ikviCIwH86o2wswej2c7fgy8lV+PDcw68qwGZcZkWVjmIMai1Rv5AhZrWlHWNtlJqykA4ORtLa/qcoTNC04/8TNsek89AOuO5w69ShsTfslLG915FE36f7IkYX+q+SR1O0YTh1lNFyykhovK+FAfKJ/suJQuPJ4a/wfouBnBkf+H2f6kb/Qu6R/UJelI0uepKPIwef7cSKJJXrSJtqcMpU+4vstAzxEGZnrdvNGXxhpbDlMekcZ64RIMYwkPIWyTyWvI7/WANgkFSLbolRdvrSOUSK9ZgQdrnxYc09FkZmAHo6KC1zmC92BHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB8157.namprd11.prod.outlook.com (2603:10b6:8:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 18:17:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 18:17:13 +0000
Date: Fri, 5 Sep 2025 11:17:11 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <surenb@google.com>, "Anderson, Russ"
	<russ.anderson@hpe.com>, <rppt@kernel.org>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <mhocko@suse.com>, <lorenzo.stoakes@oracle.com>,
	<linmiaohe@huawei.com>, <jiaqiyan@google.com>, <jane.chu@oracle.com>,
	<david@redhat.com>, <bp@alien8.de>, "Meyer, Kyle" <kyle.meyer@hpe.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>, <vbabka@suse.cz>,
	<linux-acpi@vger.kernel.org>, Shawn Fan <shawn.fan@intel.com>
Subject: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Message-ID: <aLspJ5Tpqp4qRDk2@agluck-desk3>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|DM4PR11MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: f857284c-3a0f-49bc-aed5-08ddeca86fda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2shxHcus+Ri0CSP4XvBpkv6LEHC7RScKndBStrtC0NBgMIDP9lV8rH1VQc1w?=
 =?us-ascii?Q?6JO3Xq7JujX7j1AKncEQQPH4BCB1yNyOrZTO+l/Tm96lEqeublXqiRYhsV1x?=
 =?us-ascii?Q?s+fTgS20x9sEvI1Kee9kXp/CUqHrxz9YNi4vzdlRg69QVNXYfIkFTwa+VGQ7?=
 =?us-ascii?Q?scEfNoTUX/6zDQ+Caz34ekk2KwlHun1vN3iFjZBJY2GsEl9hW+9+mnrvs5Xi?=
 =?us-ascii?Q?9PyUjcUdhFR6WEIk6fvcQCmO3o8g2GDDxemtmsngOaidT82xVGWmFyrr6FOG?=
 =?us-ascii?Q?RRaSZ4M7Go3yVLZo47yIoBl5OF1M4dFojT16RcKAOUrCT6fMlFaUs+kMh84P?=
 =?us-ascii?Q?Xi73f4RxUPpOaKWuaCGtWMRrWrFgvFRZaoBFse3SlMMcYfQrFKWIlsIY8OgC?=
 =?us-ascii?Q?9Il+CqSspiRuB0CIkAoK8AxOYMk+tRFouqQVdGVnOru4D89qfFOyzaJmaIjl?=
 =?us-ascii?Q?1928UaWE9dfmF5uuUdlZ9VfxMFaTu958+q6YuIDR1R4KmPDS5f3iVC2QfUsj?=
 =?us-ascii?Q?oU3nEDI778pnPBPmEhA7VyAwz6amWw0Q4nIJ4nbLugXg5Uyb35MoRLE1sK3M?=
 =?us-ascii?Q?vhWoJ9dPvRILkj3T9AYKkpeMjK0rpkrLek7eIUuEQyNsTWAfyGvHZX4xVWj8?=
 =?us-ascii?Q?FqtjG8YpOfYo1iZrTC9mMiUew8Hcb9p4bOe5224MWf8t9p5kaMevbWY8PNEF?=
 =?us-ascii?Q?GYx5mSFKMK3YafEBDTlo1gMzxVYYvb0RgH/s9oq9j8P9LC3fD076oh1Y70S+?=
 =?us-ascii?Q?QWwBfC80HB8BgbMhjCQdgdaybMMl8+C0AgydbAcC+wTvUny1G2TxHIc1BWhJ?=
 =?us-ascii?Q?Kl5ifYIC6Kl89rrdh86psX0jUZWLz+o9hEuygsOnJ2ynL6DkbdgC2na5XXx7?=
 =?us-ascii?Q?SufGk+C92GyC1G3JEqMN0O5K6+4Hv3p78L46RtpCCci0s9MsCktz2VO/NeNQ?=
 =?us-ascii?Q?kN9wJal0A0B0Xlk+H37zDUPcUFVFYiBrh/ot5JTBdIZs4jW0F9DFmhIGhdw7?=
 =?us-ascii?Q?hUeI5hC1AGsdkNHB7LKhKQdk7FATXndxhlhuYXYVEtBBHREK/EcjRvP8Lbwe?=
 =?us-ascii?Q?Hf6pVL1sGlfOzGm61CLGZycHLm6nI84lV8z8YJ9QNymM43JbUGgjI5N+w3rc?=
 =?us-ascii?Q?oiuzyXarwj7em9eTfq4z2pFfHbt5FjKOAZe6VYapio4n1/IFvxSzbt/S5fov?=
 =?us-ascii?Q?XgTL6OpOg8n9ocG0HNLxzeorPG0v9sOErSMktTP3LdNTSywlzJSkGmDcTv8H?=
 =?us-ascii?Q?SIoOZvhQHSIHS53e3gdlo5hCqFpnEJyqK+5d3+mCHFPx4YSLnaRAQIF2DWwU?=
 =?us-ascii?Q?l4yv5DQIkJ1iG0HVqXK5NFvquIpZuruaDXOuC0LdiLdm4qx+yatOSkoSHEEL?=
 =?us-ascii?Q?XAuICAnYo8b69O1/mqm4kTAyEu7jyLxBCP/MxAIhLkmFIvNZMuNY7r/NdvAT?=
 =?us-ascii?Q?yw/kXXUSKuwmmAADZsWEtPEHqFYHpaMvXg8Dfvk45MMm9xL7A/FppA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?McL+STpmZRyErmcPq7+8qV28vwpd2Xrdv6GGAC1kIB9bIgrUD6rEuuMCftHr?=
 =?us-ascii?Q?r6t7pAvxkOCCxpnhJz8qLtUlR96Yyj/zeflbD3A5jUdEDBgy5OsyF2cf4Vrc?=
 =?us-ascii?Q?RBm3XgkwiYtGQD6YkHtMM40FF5/M86UtC7Eh1E6pyYa6qnezJIU1EAZFESz6?=
 =?us-ascii?Q?Mwnf+dS3ySHd+GaymflucxCHlPf2xCqAX4KaGJgE08stWIr71qhAYllILOGk?=
 =?us-ascii?Q?bQXyVW0873JlAIN/ZVeC9+uj6puEeidzEsQKjIPnWWmFQsa4YahJpJ+rcNny?=
 =?us-ascii?Q?MLScD8TBIejlnpMiqYG829EUE5vZb0gp7I8IfId/Wbm7W9KwaPaGG8gNbEpl?=
 =?us-ascii?Q?K28BaJZ2Jaa5L1rJxOujE+XSv7le7PMSh+0OmqKf+wzq+CfET8Fb38WFxruG?=
 =?us-ascii?Q?Un/t93I9yDf7kU6nLnqYYmBcGFxu7Q4APy+clR4tHjgIJ6+Nfsj3UUD0dIVw?=
 =?us-ascii?Q?Mk86sDcqWIFYhW9ivyYOxnKI0ht7bVWomMu4nFfcjWzeDraVQVxToJNk9Qr0?=
 =?us-ascii?Q?Gz4UKyuetdxa5kfYEOFVQRnMZ2QHTlXrVBSPZmkic/DW53aIFMU3OlJPpAKp?=
 =?us-ascii?Q?8dikZflAwXeB6ElUHwRLipgif1h0U/j7njCAJKb5AHYpd+9Dt0jICWDcQiI2?=
 =?us-ascii?Q?DtU8N9q1Y2MAG58h2q3yec59NREZCJeqUq8KAypjRvWbOgCKHXjAhRDpfuK3?=
 =?us-ascii?Q?YGv5P/GWbIWm6QeUpU2Y/XYMkamu+BA63+d2lRR+1TMYiFscvLJwuW9pKRMB?=
 =?us-ascii?Q?mO5tYcivvBYSUocx/lV7k9nt5szbdCG6q2Vfb+LjnfgDKwXdI/QxMoOn0glx?=
 =?us-ascii?Q?T4VWlx1g9SxR/amShE++mYdQdiykwPnj8LUB4+b/xZnUvrcxETkddgne98GP?=
 =?us-ascii?Q?+mfDmvHl5kGsrwRlXvxXxOyqzm+4AmxNYRCFFW41nsLZ350kDsLgjSdDmzYe?=
 =?us-ascii?Q?pipX6kRm43hyxKS26QDIWoyRRdfx6qwEXG+9Rv3IqdOoLQDsZ3zLQw09U+uX?=
 =?us-ascii?Q?3Ob/7vJS9JRU+22LyzE9eaLoN0bTWEgtBbFo30pnRvzOt/9stiD3aNWsaEgq?=
 =?us-ascii?Q?oT0aEvpCQYhfGDP+3EI/dwDSLtgvKfjbowZHL0WgcnZ7d1k6nvVruqKpkXAY?=
 =?us-ascii?Q?Jbkmnm2LaO96sVEZm3Vudp/tZuKpBqF6TH3nTEUvrHR7ChD4nLtyYpP1QuVZ?=
 =?us-ascii?Q?zgWNv6kK6dzxs+pB3mPNXuXb0Dl/JZqKgm5bAjoP33rQ4WtZAK5hy4+bMiWK?=
 =?us-ascii?Q?nb/qa8tkizX6MZdVXA6pI9zYZ0D83s5qp7VG6yMUS0M/rpRUcV1Agbnfxu0g?=
 =?us-ascii?Q?6ChU9Zb0jWtfkjnvpW+yx8tg0PSy7PYLqutUDtIISxtumSlYhQFxw6sBPH6v?=
 =?us-ascii?Q?GGPYnwBxoFEHG0xYxQcBJHa4YmUlANYuYcwXoMRpMywTJfB13WtHW9iaOgj+?=
 =?us-ascii?Q?oH5ail9QYqcuJTl3jZHcuu1eY8eOmn8j6qftvBK/mgjEhof5MwDmLWlBf3kp?=
 =?us-ascii?Q?LOV/KM7bYQUIziRTJyAkdBjLlNtiY8JTLszrWDiOnLa9VUbAFdbQCVng5wRb?=
 =?us-ascii?Q?fucII7agOZSZvU8dzu1oCAArrrY1uWU3OYr5utVs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f857284c-3a0f-49bc-aed5-08ddeca86fda
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:17:13.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SaDaHQiqzNN59RlmTS30f5UyVB+S5VriB8jGzC4Pk+YhzxJAOLjy8pE573z7z8OwpJwKpyYb1nKh111z0ynrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8157
X-OriginatorOrg: intel.com

BIOS can supply a GHES error record that reports that the corrected
error threshold has been exceeded. Linux will attempt to soft offline
the page in response.

But "exceeded threshold" has many interpretations. Some BIOS versions
accumulate error counts per-rank, and then report threshold exceeded
when the number of errors crosses a threshold for the rank. Taking
a page offline in this case is unlikely to solve any problems. But
losing a 4KB page will have little impact on the overall system.

On the other hand, taking a huge page offline will have significant
impact (and still not solve any problems).

Check if the GHES record refers to a huge page. Skip the offline
process if the page is huge.

Reported-by: Shawn Fan <shawn.fan@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Change since v2:

Me: Add sanity check on the address (pfn) that BIOS provided. It might
be in some reserved area that doesn't have a "struct page" which would
likely result in an OOPs if fed to pfn_folio().

The original code relied on sanity check of the pfn received from the
BIOS when this eventually feeds into memory_failure(). That used to
result in:
	pr_err("%#lx: memory outside kernel control\n", pfn);
which won't happen with this change, since memory_failure is not
called. Was that a useful message? A Google search mostly shows
references to the code. There are few instances of people reporting
they saw this message.


 drivers/acpi/apei/ghes.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..c2fc1196438c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -540,8 +540,17 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
-	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
-		flags = MF_SOFT_OFFLINE;
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
+		unsigned long pfn = PHYS_PFN(mem_err->physical_addr);
+
+		if (pfn_valid(pfn)) {
+			struct folio *folio = pfn_folio(pfn);
+
+			/* Only try to offline non-huge pages */
+			if (!folio_test_hugetlb(folio))
+				flags = MF_SOFT_OFFLINE;
+		}
+	}
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
 		flags = sync ? MF_ACTION_REQUIRED : 0;
 
-- 
2.51.0


