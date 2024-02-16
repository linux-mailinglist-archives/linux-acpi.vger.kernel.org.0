Return-Path: <linux-acpi+bounces-3573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3A85724A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 01:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CFC280FBD
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9C170;
	Fri, 16 Feb 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujwct0PB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817D28E8;
	Fri, 16 Feb 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042293; cv=fail; b=KLH2Uv2qeVWYe7RSUaM3M0CLdU+d0l0peWy6bE+ExnyTkR3Z8Rwbm2XeoODEmzaZjfzwbBc9DzX4QN4Xu7GAm5SuYBWKNMrXYH/UMqvBCHugPjw36PQuKVdTsz6IRCbS0NxpA5Dj5k1If4qdBDa/AUbzm74HMTu5osT3hdrjsII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042293; c=relaxed/simple;
	bh=4g5v0USCYEcJlM7H0Qkjrr3bcULwj1+lHMtV+MYAFdQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I9YPTr7eh+f9xqR66rVdURZWc61J88eGl2v3hPgcqUH/xnBHABxMs73zulq+D3z92UsiPzqbRc2bwCwAoXB3wFwdq76fOj2FjJvuyFR9NniQxXd4cWZy5S5F6GkCRAJQ6TUJw4ZWoCz77VpjoGqY7l5y/ddMbdZexOs41tdib1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujwct0PB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708042292; x=1739578292;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4g5v0USCYEcJlM7H0Qkjrr3bcULwj1+lHMtV+MYAFdQ=;
  b=Ujwct0PBy9NvcqCFucJ753slPJz5ytfqAXZVKHsvlqDqlrDNR399SPz+
   82xsLli9E92g4jpRQcWlvOrkekG/S0jovUHB9WIzr8cyykzYzN7JGlhd9
   xkPe+lS27AOoIauE+AKANweOEZxbb4HY2r15EyxjInnoUEvGif4E3dgXE
   oxcJa9RixI7mFfYYnSMlACnEUSWIuyLj2LGJnCXO8KAO77szNs7F5xK8G
   Rmjn8z4aoNxUcws89wlMXdfWGhVr+tODXcVjIPnn9YYz8LKYn2TBemkUU
   AuYJVsfaA67DsdwFvyIBhV1t4Qcb0HurTvWHLD14I3rIccgpa9aKJ/MnD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2035161"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2035161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 16:11:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="3982324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 16:11:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 16:11:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 16:11:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 16:11:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 16:11:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgE0p4TQx92zjwJTNPuXVdHJQJMd69hhGSP7exot9C7AO9Z31It22HvFPq2PSzP8ViOe56oZ+jteSbE9yvpSzl8YLR99wJfgX3PH9n27ds9UXIUESoTqk2XuWD7jh9GgU6oHckAgT5yeTnoWRcbN49vjpvEpxE0M+gJH966AcL8xnGmLRfnzLorhZxbUWw/huJnl6U5TVmVAapdx1oyYiV+rywej1ePqrq7Z0YLQOQ+wYEJoiZUSzJhqq75qSqe4DhGtIbsJJ7Wyy+TGI8uOjBIG/WYh0U+9jVQa4hEY2/u0uG7TTokhNW5jobiSxFRSJZ1UfBtH25OfgIMa4fX6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhkp2MsN8cf4xk/dkXo7Sy1AYF+TdnmK8Znysz6T12I=;
 b=hnki33OpibpaCRd3TZ9gJSi6ELl1FmEfkKPwenvxUUTcejhbxHgMZj5QVipyhBlQBpaMePtVLD9tgJfenlf+6XoUPh5mUp+HAvD7rKyX332DIm/X6l99m+uydP5vhvPkpdOojadU3YRBCZN7LuK83AhgHWvq2mTi5exRuKoH84jvP157ovo2DxFvev6JBREhXBU0WXt1xJmHhxKidcNFSzTtNlu4/Ley0W3gTMqtHXmQ940pKA/W37raczkXrRNE1jiZd82bojjNaaJfSfvfmQNQTcqSKuqFX7ed8BPli5z/s/tfpX17+ZmFQqpIUahPY8cppPaEwNjzz+h7sZpYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7326.namprd11.prod.outlook.com (2603:10b6:8:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Fri, 16 Feb
 2024 00:11:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 00:11:28 +0000
Date: Thu, 15 Feb 2024 16:11:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stogolabs.net"
	<dave@stogolabs.net>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Message-ID: <65cea82deb145_5c762946a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <Zc1kwWupeN9WagFj@agluck-desk3>
 <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <SJ1PR11MB60832AFF7D2F9FBD2670CBBEFC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083F423C85A96FB89F0F4F5FC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083F423C85A96FB89F0F4F5FC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4465c7a5-28ab-4565-afc4-08dc2e83d21d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5yu60i8SC7gkt6w48f51cKnV+CIiBKSRvO39kTMATjPLjzpDjMtfDI96adrpG25pnZp40HqcbVuXNiRjwCo3fZxOjYNq7Mm60ELZRXShiUa0tAfjSTb8ou0eALWh4+/8MZiJ7GobZo97QuhFgarILgzftz6V5aDDux6fTaK2rGTxsKH8tH8oRL7zg4yedK/7Cu9kuBkvEoVxPlxQRkwrCHYDYX+BWsF5cIlCmNyNUg4f0GdE22lretkU0zt32kmi34MoJD+erArUyK81iSdBq0/Lt01OEIivqcrpynqAYCzp8Id2Ud5Wbtx3mRWTQmS/q9oGkHtJBLSYCEu5hAtJFa0L9wG1e9ReO+6iafdttNhJ/9TURF+6SgCC67brlyCB4fVaXJipmODj19VRcWmJ7nWuhzFIMXGXJeqB2dd8K2kq4icIYUhDQWr/wFWJTg/UovKLngqw9g6pt+a7zTKoN1XRg0soHaZpMTN98MDhSBNTZr7fOjPMxIOrHChltTkARdEPZc3IQJmYvDLQhWDqoNokfE+QBUCAMkiUOu3G0ZAl6gfqqARn4UTvOUQ0AwP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8936002)(2906002)(4744005)(5660300002)(8676002)(38100700002)(83380400001)(26005)(82960400001)(86362001)(6506007)(110136005)(316002)(66946007)(66476007)(54906003)(66556008)(9686003)(478600001)(6512007)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nw+eq42zouLH5nuFehaLw6QY/uxsWsznDYBeRnkg5DGSVmNSRhniuvi7MRFO?=
 =?us-ascii?Q?8tPYxuiqSyAwMa4dv0/TqYNQfT0FX202IeYW3fiSXrU6dBKBUwK7bhG/Fv7b?=
 =?us-ascii?Q?hPW0joFOvda7wQv1soqPbNN2SkWHpyqazzeQ+W1PrWnFAJLilZKuIcsfeOZc?=
 =?us-ascii?Q?XiDHQGtvz2HSfYSEtl49GzJAjqfBn2I2nW0Wi2fIzXjdNc2ENTEuCtEQHx5g?=
 =?us-ascii?Q?bfY98s0l84Asg7RuunQDCA6w2XEonWTAAaJt91gGS+Vhoyi/G2BqMt0lX7yT?=
 =?us-ascii?Q?a8nfXE3DrG6c3NqCe5muk/YHdqZQGmz4DitYB8jznGNEYUw7aSQlDHdepUnc?=
 =?us-ascii?Q?r2FtoGKEhc9WPTK+S1Vfo0SjK62QwOsiwp4BBDWftU1E6rjrysJBURYuFH7A?=
 =?us-ascii?Q?mnN3T+nxX2EM8vzSBaixCoRv7onv3/0qIxZ0uvd+xf1N7K/U08xHPUDcuW4G?=
 =?us-ascii?Q?yxOJlpIyxosqc0B7kkF/fe1zeEhq5p+2W1Z5gVf+sR+bMMpovBcppSe6mDVs?=
 =?us-ascii?Q?RGD7g2vvP22EwEi8YlCIVCg9yIoF3P7FhRsGxj/mAoLmaCwkgbeX6SXI3t4u?=
 =?us-ascii?Q?qcKkoAjVOA0IB2c7S1e2qYrcIVqBQH/7PSxDUo/ku1AWxtb05RhW+ZgMwF14?=
 =?us-ascii?Q?MCpQO91cEJ039Hv/XD+DQI0jUmfsmB0/EOv3eQmCkCn0Yt/YGlTcUfLbIQq3?=
 =?us-ascii?Q?VEUCQLrctbl5aHYR/mf+B07Ph+GQ76gOqRiHLubsn2sf8lM8CD2vpWowkva+?=
 =?us-ascii?Q?WY2KVgkhlDZ5yZfsRDj3Z/1DDq1CgVivcFSZFdhp7iravSsQv+mWWqsRKxAm?=
 =?us-ascii?Q?Etkv8NzGFoTdW73ABHvMofdu0kWx5y2yu7tBwiymV/S/NCqCqrf1/sFUNsBr?=
 =?us-ascii?Q?h/0TaS/myFAQVw0Isc+ySteeUIvcW3WHPI6DocKkmDodT0hojnk9yuJpI5Uf?=
 =?us-ascii?Q?AzV0NJi7I3duwZ+QPVhQkrCkh+mhlIbb+Ik0zM5NNhjJWoHfZ1MJauKONZSx?=
 =?us-ascii?Q?SQiGBnMn3+GnYoXNGjhdvPsYvrGGo9dVMnf9DLvaCi247zmWYGX3qOcBOMU8?=
 =?us-ascii?Q?Iam31l6Jn3v8EINR3fDu6WTHhdXpdBXhXFP8Lbinxb3kQ0vqmQfY2j8LvawZ?=
 =?us-ascii?Q?Jqcs6NnubN+mnToBljp8kRvIJxEPohVtRz6DtddLWEAvWch6z+TVhqXdP+mS?=
 =?us-ascii?Q?/l5U97e+v0gDYvaWz/63xJYIVZ6IxnXOYvLuzYwCRUOCNEk9BUNMB128KR6s?=
 =?us-ascii?Q?KOtq1h8dBCeSWpi0CotuoSgtMZvPl1Q6tY+cgCx54Yf5zp9fTZL8oitrIOi0?=
 =?us-ascii?Q?5CdQTRY3gnnldD6lfRehwxvKDIRbnDAiLd4kSu+LxVB1sA/proq7ptR7DVH2?=
 =?us-ascii?Q?QTyRsryudwnpXCA5okB2ic51nPOFg3Ek0nds64JYQaYw632xUbClyHMKAQHv?=
 =?us-ascii?Q?07TuDh03iw7c2gf7NXyw8/mZ83NUfLjIbCwceA3gjQLGtbaRP46wTnRlh2Rw?=
 =?us-ascii?Q?FXo9Z0FI4VDPZ4N9CMU0nxpyCvBW13k3fIS/yH40jkNpPhqSCVfPqXaWTMZj?=
 =?us-ascii?Q?E9+fEs8ywlPFOGiUOzkg0ZW8Jj0vnPB4er9Wt/IaLfWqzSaIaZzJMf5+PIps?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4465c7a5-28ab-4565-afc4-08dc2e83d21d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:11:28.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHdnFnpXEFJoHptUhd4/S5WNhwKtu6NTGIVY9QQjXg6mGCnEP7rZlyUL8UHTqK4SeG6YwxKDhANUfK3mHfs0PsxchxIonZdLtdJmPjtAc9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7326
X-OriginatorOrg: intel.com

Luck, Tony wrote:
> > But perhaps there will be a pr_warn() or pr_err() during boot. One of these will likely trip:
> 
> >	pr_warn("EINJ table not found.\n");
> >	pr_err("Failed to get EINJ table: %s\n", acpi_format_exception(status));
> >	pr_warn(FW_BUG "Invalid EINJ table.\n");
> >	pr_err("Error collecting EINJ resources.\n");
> 
> Just tried on my system. The winner (for me) is:
> 
> [   27.989081] EINJ: EINJ table not found.
> 
> If you decide that it is OK to auto-load, I think that needs severity downgraded to pr_info().
> 
> Users ask questions when they see warnings.

Sounds good, I missed this before sending my last reply.

