Return-Path: <linux-acpi+bounces-21360-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM33CUi+qGmXwwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21360-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 00:20:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8330A208EFE
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 00:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D728F301FF94
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 23:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC036495D;
	Wed,  4 Mar 2026 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL5g8+P+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C0192D97;
	Wed,  4 Mar 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666430; cv=fail; b=TbFn/QcSqpZ6Wfh+xcRgJ8ldPg8GfqXVxI/sikUPaPwyuWwRuz0V7s1wDWuatHJ6dHdnPZkGD1VASERIYKRPwCIx0QAfLZedLy1LPiAy+eAKo7VUutCaCqhA7fTm4SmKu8Cbdz6pz8xswnVFlJzRveyzSnW+CMf6Yd6jbsDqHSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666430; c=relaxed/simple;
	bh=0VGa7KHHRoBiSzssIi/HMKAw5K+AaJVpJgTfbawEuhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rI/SahQjCqKn8TpMGnofLr3bOwRvW4foTHGKLEHUmt9/8ShKbXTG++xalASYYfLV0aJn6yCXBiOjMinK97keRp1t8t72uwDL8FG344rBEODcxtioroXQL/HCqiFPx7+/yLdDkzDYK3DtRFyj/EKyqysWcpPLKO4ZCCs6XTjKI5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL5g8+P+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772666428; x=1804202428;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0VGa7KHHRoBiSzssIi/HMKAw5K+AaJVpJgTfbawEuhI=;
  b=gL5g8+P+scYiEw0MSQqtE8p05iFmlEg4duWmQRVpR9UXHxqrwApJXfq7
   3jIFLJQ4jdABDH7hYOsLl7zEp9FogXqT6Q+y3dYwBMIAmWw+ecdeQje2Y
   NUOTypTIsAa2c04lyrahfoNWW87ZcU/GxgmgYi9Y3Cvg+Z38BYpIJ0tPh
   JaRZG3RSwkivrMf9fLmRAEJmyUVza9hEoKUAOS4KU4RNKUgYtZmuwPUAR
   9Q44PR/oQYe6DJOfa6vV7UjppiVeeKLbKvr/52yCC98ntnIZoVpeKGzU2
   23sDz7tDn0u3l/c+vfLIwl0KOTa8V88WcJ/lM0Z/wFt0JO+xDMnc5d5L3
   Q==;
X-CSE-ConnectionGUID: RfbbnXyRReKvku6vjy9+9Q==
X-CSE-MsgGUID: cV6ngY/1RDynId0Af1TRPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61314185"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="61314185"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:20:27 -0800
X-CSE-ConnectionGUID: 7Ky/XYqkSLimMBKftoVpfA==
X-CSE-MsgGUID: UD0kugXmRu6suhBeviX3NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215798051"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:20:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 15:20:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 15:20:27 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 15:20:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5WEA4lYYlvnywJlEAV4Ez7A5Rx4DfxpEBgTm7MF8qexXoX8ka1BkiEGViTqcTAsd60fRguemzaFmhNBL0EyhjekgmjcX+qatlK5XbyJ25wMlu5jCrrjRMW6XzlPtbSaA74nJmhRwk9OaxqBEXwtNN/wMrsWnXKDiAisnSEknk52wkdJtlKuRrpXG7TSPcnqObWNI5H8ki5JO/syulFAcSY2j5o47PeRhjLZdnfIyjAR1YNEhikCw0xu+6Pis1+YD2rURo8cYemW9RgMPaTzjauK6PK4e45OwYtk3hUEQxodI5PD5oaQEl8kQPmyN3UXZUiaNmjrA8RQpabbQ5PKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf24l80ix+Ma1e+m47+AiWEpJW5lQgwPZlLy2y0XNH0=;
 b=Tq0c2aGVaYaCOEggtXhJW7Nea2U/896p73+OohqK0ajY2vJEEwSS6Xr2ieAx5eIXbjKqaaxG2w+M+pNg6ExiNBVSa15p3VtUDcFJxUECqoemDu4UyFcHslUjizzyAXMULerDUyDLORn9RDMGpB5vH8wVnnlpRnSIY/qwHc3jTtVmGDfkEHC/fSN5OZsBetqQv0xPGa3HdwSydKy8/ezVvH7GpM6KQ3ZUsOTr6uBe9377/fm5wgTyOv6XpunSf5LtqirhRh92LAnD/0r1m8rRttqp9nx6TOwIMcu40eulR/YEwxVJSXTQyN9CpJsLaJi8zOZ54dgJqp6KbtJxyx0moQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ1PR11MB6226.namprd11.prod.outlook.com (2603:10b6:a03:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 23:20:21 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 23:20:21 +0000
Date: Wed, 4 Mar 2026 15:20:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: Kai Huang <kai.huang@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<dan.j.williams@intel.com>, <akpm@linux-foundation.org>,
	<nunodasneves@linux.microsoft.com>, <xueshuai@linux.alibaba.com>,
	<thorsten.blum@linux.dev>, <wangyuquan1236@phytium.com.cn>,
	<linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ1PR11MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcbd2bc-bf4e-4a0c-c2b1-08de7a449b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: ozbZ5+EdDTDUEyX1Zs8EAabZjsGTi3E994Jj+4E9B/3QFwa9yZhq0w9+xpQUaHyIY+Z1abIO2Mo7Ow+L7SCGJkLA9XUvX4n1vMd9+9IyaVPkUfJmGkv5aOOhJXMRyCViUj15T3/30YHoKcENxaq7lf3ABATyUexFeFBFEyqVqb6Q2YvLIvRh4rwgyei72vrh/KmkiVyBSstGtv+/AQYjitxWK7FYg1DntoBNAj8LWcjuhE8XlMbrAVsiJQHl+jJPlMj6Imu95Qfyt7ma5CWWHqYSk1wq3u7ZAHFopfN6GHR8F/neVnXGJLNIBYzj153nmLxC3wOqPqL4KnCJ26lHqfRqFjuRIKOBQe5lR+dyV9ME/E44FyG+fXcDXRc1qB4tbYmYfWlatvmPG241MkuHbeUXIT/hd174GzWRyT5hFcy7uvYrW24mVnVAxYauw7xip9UXGTaiq+wsjIur3CkKVqPwRPHtB0qx8kfwWspT4TffqrKsw5lkAES3pT1efHOE3YLsYS8RbzXnzWId6ibZ5x8S6HMReIfCBpCe1fgpkfCLjwObcUWWRpsAPB2AJ+DWqG60G4PNOXMJCV/Y7XWQxijkDyst21Dgc1MEvF/4cWrlVrxbciNzOEen3OsyrjnwVX6d9vdkj3M0cLJ+wrdqBOg+silQ+2+qZXl5PV9F5bNxrbfRQTvyIY5p2q043hVzgaIztey9q64v1dpgfp9010lxvv8Xi2jTWTE13BN83+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eiroqIeT2f1LO/JkC9oKz4ebCkq/ermnxiuJZfSLTCUDHICTmXhwepdez80O?=
 =?us-ascii?Q?0tIEbHxw1xRKg0ndwP5OqwKculGqaLey1TVlhVhrSCyXi8hKEcalaYCFisrI?=
 =?us-ascii?Q?UeI0gOV7GAb2b5O5XZHT/2PKP/p9iJRj+iTnLe/KiEWT3xmwVKtrkqbnPLop?=
 =?us-ascii?Q?d83X/ZTt6VDnse3C1abuj7kHf7smk7mXe/uhCzS4ejoEOpnVGXljezi0iRNa?=
 =?us-ascii?Q?e5bar8Ui62RWsdUJTzouc/+YQThxvMex2Bdmq104Ud1t2EXVlApnxJH1rCYx?=
 =?us-ascii?Q?KUOSXj0Nvu0q+rkVGnmlQs+1xz5PeV4qJnoAUl8NRrv4baHjY6z0rS6P0iOL?=
 =?us-ascii?Q?4PnIrEYSRwbRrnT9Npw0Y8R5k8BoZdUjQr3ymSzMXp58VIFmWAtVud/XVr7Y?=
 =?us-ascii?Q?qpG/LN3ZXp3UntsRrBHCjHzClFMUAoUkROmDI3vfoC6U3vk2nA/jovKUbCtp?=
 =?us-ascii?Q?sghTj754XX+jJV+/+/rVx6t2uFkgYfLADsWWQws3uLgv9UiguZd5vUqj35Ey?=
 =?us-ascii?Q?31j44j1AouaukgrmJ3/Cf3f3zn98qbrUPSoMif6NLB58zComUlXGjPUgLafr?=
 =?us-ascii?Q?b5B2egUjVC/nxUhsPyrg5wMcaiAU/qcWDQdlkHH12qrWfMpM6DEwHOqmTbi4?=
 =?us-ascii?Q?IKQvF9w9bb80Kq2D/sfXIk4hxIJ6Ya6KV94eKDC0DWCq5f7bKsbn0nRUl+Xe?=
 =?us-ascii?Q?K29WfW9yblkZufSYQozpyatZ+FqdZ69iYcYThWn8MP23HYPX1PdILJmxiV9g?=
 =?us-ascii?Q?ejajxmhCgP3cKsGMwhNbPWzI74uolpYYDGsd8FGKSDFF/gDVM2k3VyDgy6Db?=
 =?us-ascii?Q?g8psBixTQKNXEkKKeTGfYKbXZer/h75ZophFoo0dXRHiNubyEboV/fr2HQ03?=
 =?us-ascii?Q?fbA7OtnUfDpZfGk+AtHknZnvPH1iMmM00wjj8iy9L9mL/67xnx2M2BcQp07p?=
 =?us-ascii?Q?VB07afR2g9D22W1rx3AZDuJwyaEuo69xWAdDKQrW6uavI6K7B4kGthg7x6Hu?=
 =?us-ascii?Q?Qj9dumuv1+V+ojyGzFgZn2uEscjGdLBbB5WK69P7zHevLgKaWs1ZI6vMzV95?=
 =?us-ascii?Q?Dv9i9wLtQzMRpJ3BGnQQNqmf7EvnK8ST4zV5rbhkjDlRBu4IRo82MKx7Ps/+?=
 =?us-ascii?Q?2QSp+S7Sl68soWFhGTdjmvFRTjTLmSwxqRILo5dL6lRVSS2ryQ37rm+mQ9lP?=
 =?us-ascii?Q?Iy6O6a3TelEH8A7XW1hRI/AV8VzS//FiQxMMDTMMYropDga58uKqypk7phEY?=
 =?us-ascii?Q?bZjUiB5FwqcQJ1z6QDQn/ytWFX0Cm3vLS5odzjjHCrTwlS0qnuYz4xKMXywy?=
 =?us-ascii?Q?nMnQC9FQM9ARwv+eoumVS+V/dgSGLBFqjb3ggN39u9i1XSqPwwF9uHxZXzBX?=
 =?us-ascii?Q?UNGh+3FqttcfhInyJ+Q4BStQ0zQqd0ksG3OFEkYU6Vf1afxtcN6BmfM5NzTP?=
 =?us-ascii?Q?gyapyDtV7CBzjzbfeEd6dmLVAeSAoUWkI1ChQ1jqaZu9CjAuy8AFOfwZIchu?=
 =?us-ascii?Q?RaOpCW/vXqv1M1wFg4vteuTO/Nf9vVTW4N34lfbk6hpwupIUBsVvBZP+OES3?=
 =?us-ascii?Q?aeVX29PZkrbWzDoAM7mUgyfjHRJv8efPN8/wlBxqe+TqRlG3hEAb7Lc4JrMU?=
 =?us-ascii?Q?HLGUtuwu4vjggexnb7F2N9B4AlF1s8U1n+c6l7xgcuHKUvSXsrE6Xas8IWhx?=
 =?us-ascii?Q?1Lvk1RP/kpl4xkb0tWoF0FNUk87j1v8ZeWOjCLPGk+snIoRnPvtH6tTcV8eh?=
 =?us-ascii?Q?4jVXMhUAWYRCEEeP/SpYvAnC1q0jbE4=3D?=
X-Exchange-RoutingPolicyChecked: xGgIc7ZjlT/qPEM+WJ2/cPjb1q3r8U5B7Fv2/p+qO6feIFByx/swviIjr7A/3nQh0oARDvMWIGd5BGAR1HM0npKqxAeMnVVZgs0VWqXGFFfLpPzvckgT29sk36horpx+Vx3dqy8SPaBVLduH6674QrEFDS3NzsUXySAdJwtnWgXT78NCtjMgrBivVaukvvdmbVZeH5RmiJ6fcQhz882paPONGCTGHOlM7SFZCYyBg7lz4cqKCbOkErlNcUoRIDTUWlF1Eiul5Vv5vJfhNTu4f0KZ/ZAUNkXV6/hhStUdzrCxsYE0lCYlhBIA0P3vEgBAzmRU/k4OBWCmbfr1CNmJqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcbd2bc-bf4e-4a0c-c2b1-08de7a449b2b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 23:20:21.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02LyUneF6ukns6oU4RbEqQZlItrpv5HovuulD7anlN+C40uj5tp1pu3ckATcLc2fLb13ayqiqvd2Bu71cKkHVnyb46Lt47fqW9OOzgztcRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6226
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8330A208EFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21360-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,aschofie-mobl2.lan:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:33:26PM -0500, Gregory Price wrote:
> On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
> > Increasing the 'nr_node_ids' has side effects.  For instance, it is
> > widely used by the kernel for "highest possible NUMA node" based memory
> > allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> > related system calls such as 'get_mempolicy' which requires 'maxnode'
> > not being smaller than the 'nr_node_ids'.
> > 

> 
> Is this a Linux issue or a Firmware issue?

IIUC BIOS creates the CEDT based on the hardware it 'sees' as present.

This patch is describing the case (weird as it seems to me) where we
then boot a system with ACPI and NUMA enabled but CXL_ACPI disabled.

So, I don't think we can blame BIOS.

> 
> Is GNR exporting more CFMWS than it should?
Not sure of any limits on flavors of CFMWS's a BIOS can offer.
If BIOS can carve out a window, it can create a CFMWS.
Not clear how that matters to the issue.

> 
> Is your SRAT missing entries for CFMWS that are otherwise present?
> 
> Are the CFMWS empty? (is that even valid)

Why this line of questioning ;)  I see the problem as a bit simpler.
We have other code that tells us if the CFMWS's are valid, etc, but
the point here is, we are not going to use these CFMWS's so stop
the parse as early as possible, like right here as Kai has done.

> 
> > E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> > reduced with this change (when CXL_ACPI is off):
> > 
> > 	w/ this change		w/o
> > 
> > Slab	900488 kB		923660 kB
> > 
> 
> This is a good effect, but I still question the premise.
> 
> We don't usually want #ifdef's inside of .c files if we can avoid it.

I thought similar, but for early init and static helpers, this 
#if IS_ENABLE(..) wrapper is common.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> ~Gregory

