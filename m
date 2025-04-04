Return-Path: <linux-acpi+bounces-12759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498FA7C00F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C93B8F77
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D631F417E;
	Fri,  4 Apr 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi4NIto8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BACDF49;
	Fri,  4 Apr 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778552; cv=fail; b=A+38MyEnS/aJjdFa89rq+xYim9+heJhtg+EcOr0VLzfORy2Nuhp5QcMJBMz/ADwePSI9zVIhyg0TZKgwKDC/Fv41QnrHi8O+KoRdLES0OHHL30yjNgd6vCxhK/lwNGVojG7IZd1YeDkcwwCbVUFSzFfendMlqqqvwvOVnL6M1vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778552; c=relaxed/simple;
	bh=RMgt/mqKS4kaoOco8+FyNHu0udd9+n73+SZIGlXkGLM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Llwfn5hf2zHqiNlJ8EKOqTjRv/T8s8aqZ85ymwMtP9LpLJC4KI7modXUFDUuuDG9kZPbvuqptiAIyuPRrlWDOUc5eEtn+E5KcII7yyz1FTgpySPjxxeA6WAZKNqBNt9Mi4f58s7F0sBTsiV/Qo0OP+EcAp3xIyVJuJWTrjWWdDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi4NIto8; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743778550; x=1775314550;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=RMgt/mqKS4kaoOco8+FyNHu0udd9+n73+SZIGlXkGLM=;
  b=bi4NIto8L4fILfZPgtEfwjznNZ/YQf0qfKO7qT3aprn1uJAWNDYc7Z0x
   6kTZm+QURJojk7GnvwfsKMHLCuynhvuMIom2eALb77jcrJSTCA4dX0fh0
   0AxG3tSKkl1sVzWCu9iSDtLBYYt5BNhb1+XHrGb1uIDku5un/lfKt4U3x
   OidQLls2I7/aj6l/L1gi3WXkJe+7DNgYf+VR1HdaJ8rGUYaL7v6NaSdHn
   mJXmHjuIQc5e2zoxw6FUZDKMwSpFSnF2w+LC0Y5aJSmMMSa44uKDNDzU+
   6rl+boFe38Lc6WFm7HJ7Mg0t/8bP9nbRbR8BSY615iIvX8dh5kEIbYBNg
   g==;
X-CSE-ConnectionGUID: zvi5kzZxR2aHlwXTHYAXYQ==
X-CSE-MsgGUID: BtrCHl2tQdmcEx21gkH0Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="49078715"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="49078715"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:55:49 -0700
X-CSE-ConnectionGUID: LZnvLaapRWqB5zOx8aDtQA==
X-CSE-MsgGUID: yf8UYVPEQdajRFwdTgfzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="158317484"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:55:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 07:55:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 07:55:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 07:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9rj7B3YRA77hz86qidjekmOTo75JgxwpmDWbVeap9u/8Xq9dYmjetAjASGuCJhfYaAHqtqvifcqCayboJxcFkB+ricCfytaiLh1a+F+EMPObJI2N7OwUc+TH5Od8pxLBPFG4pxGVr5e7XFg/iUqMpfKYZWcbkESJnWOs0gPwRhgX16AUiZWCgOUc9XhKAEzTvo+A+GLTuShKFurf31H4C35Z1KqO98m58zYm04gh3jLGYyBIrlNsuL05WanB3okfNIIo0oIrF+g26LDfsW8D45WRNBc4Sbh2kch28Lrz06N48vTpLdargOM5qRVfLRHIf6QVBhhU9g66YYsUct3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mktu9yze2kpsGPPbVYgS+9f9x2PyIdDoLHi7y5uM72c=;
 b=dh7fIgvoGrbyk58z5kVJULvJLCLsLmcqBgfQIqO+95kMMTVvBPXoyhlc5i+Drt53EkCDJ2JO8SUJTg4/QnIWaIZKiSi+6uDn4ky4k4Lam/Y4u2PQdzqZWqU70ZsD8mPREypUUuDQgF8MLgLK7nlM6uDYMdQ1xRXWw2pfLd0T6VdAMCvJBHUzOuCKw+ap73IKkwOmn+gNtWVGa2UI+oKfnQw/dtGMYnkR61t0y7aC+BQaxY8nyhS4GJLxeFL2bNTYxVgj/soMiohkUuyxm0tMSx+dhZdcijFWFshROYsUuse+MwYRL32nJJ42Wls0j71KJTK1ydNwp54aVfr2QEBWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4519.namprd11.prod.outlook.com (2603:10b6:208:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 14:55:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Fri, 4 Apr 2025
 14:55:44 +0000
Date: Fri, 4 Apr 2025 09:56:05 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <robert.moore@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <67eff305b2094_9807c2941e@iweiny-mobl.notmuch>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
 <20250403231339.23708-9-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403231339.23708-9-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: 88559257-f483-4fde-9c4e-08dd7388c6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HKZQ0BDQ1xiIuvE5Q/bUgGG/WNXuWZlCV7Y+1Cb8H1YTD3KWJMPedjKbJ7eQ?=
 =?us-ascii?Q?WuNUwAPNJ675stykNj35J04uWRN85ys3Ef5/V9h+Ff4exYokiBOjnb2s+25B?=
 =?us-ascii?Q?u0DqmtoWzTisiSe6uCS0ijT4N7fBs3FQW2rhL8fh/fEUAWSroZmmcbKrtTVk?=
 =?us-ascii?Q?AJb8U2Z3py0HTfi0/GAcIDpXRasbCOOu+/vXtcBRbMT8AM+FKhb/7+lKz6kY?=
 =?us-ascii?Q?cM2BBdrrLm+rDoE/aIr8pKuS0juH2ucJSJ2KPVKFURas9K5urXl53O0/+7B7?=
 =?us-ascii?Q?17rZr0In9gRqIPUvfbnKudA06VDNlKXHqcCW+lO8h9HhXMaajQ1D+wn183RA?=
 =?us-ascii?Q?aCnZX2mhcVzdN5J/0SF5F+JB+g9LUwSRUScdp3xNTFMM65T+DGI1grixWBQ+?=
 =?us-ascii?Q?g/eZY4N0B8htoALeXyxdT7rkmR0TkfC6ic04HoEzUzo0KmlsyrDQpTQzcF7F?=
 =?us-ascii?Q?5JucSHZqzhXVLrk2ZJPb4s8cbccQhy4QINhDRL5wA8jtf6LgS2aoLqpAyHxj?=
 =?us-ascii?Q?4vHafgEPcbiPXzaq/8fRk1+S9gxExaFN61Kg8BMrg+kuWK8qsMxR7u0sY+GN?=
 =?us-ascii?Q?++OYTYjOhGzUDB4/xn9F4MIJOA27ID7rEZPhAYubuwKbo3gMJLQPMpdfHLBB?=
 =?us-ascii?Q?ESRGe0IafatVOp2I+1f5PuAdCDUoOuwNeGY6HjkUuvIujLoKzPf2XwdyMxsw?=
 =?us-ascii?Q?niUj2jgf+HSBx/lZ/1sRRjjqKENDMmDS9+3PZ4wij2iC5pb40Nkv0w+QKMKD?=
 =?us-ascii?Q?VnTP28lZLwy7xeETaNTzAdd/fQigkdwLiS7Q0fLW9qQvOPMhXnoWnxH4YzTb?=
 =?us-ascii?Q?w2GZVv1U0MhRGa88L6vJe+XbKsHpPdaZkzKT0eARg/aHyIfVCOlkHyUbY+I6?=
 =?us-ascii?Q?KA+3J/1Gzs4DsERDe1eMr7F0J4YNUWPJtcfruQFK5o0iidfTfc5CxgcGe1NR?=
 =?us-ascii?Q?X4KnwIObuNWfQn272ZPHuZ4bJn0agSIwEdNBeKxU7mNr+mOjGt/iP1C8ynI6?=
 =?us-ascii?Q?sZTZFYpctPGtU3sQrxhYeA76l9ndoApOUX4UB15ka8PUmc6EPtKPOkbEMegY?=
 =?us-ascii?Q?0gePdOnSKOsTvhs1aewPyuFpd/fMDF5htbWtmNeWyCQb93h3WOImiSq9YCaJ?=
 =?us-ascii?Q?VCOQkzXPeD2d0M24qqkBVm7+vsE+IGwboqjj5gU+90Tec4OrZX+iZNnZakSL?=
 =?us-ascii?Q?RtZ64lQa0TEJu97TBqeQK29hV53YWC7tPdqD8DOPTYVD2VL10oQSrJu3bKLX?=
 =?us-ascii?Q?+mLBPUJrrHtz/X8NRMu0EPPjkSZlvZj2Btn5062XVtrGPnSHwQ2K0nZclvpW?=
 =?us-ascii?Q?UrZD1CfIzv/LeSnOJP0iNqCvwTzzbVRrH0P294vST0u9ZAu2/NdlZ+EV3R0V?=
 =?us-ascii?Q?ZflbIzAsFTCCnwB8giQ0LFGQARL0rMPx1iM60EVNdEuHhug8Kmssf6xXiqft?=
 =?us-ascii?Q?JNNuzdi1gZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJtKp9gHhAWCNDZmhr75c6KUVhunF1BW3alyepMSgKO9xmurjGoHSYmKNxrY?=
 =?us-ascii?Q?rPi5cZnK8telQLokISV3Pi3T+SLRIGXpOATOz8/cVvASLJjkR2xpf1FyGMb4?=
 =?us-ascii?Q?56/NidyRh1ZYtvWpgdIbqFmOQecNO+qZz/nf7eQjjjgkWAzzJa9e6zDg7Evj?=
 =?us-ascii?Q?C+s4A2CVyUD8PZN4TsNzWByJXZSduEcd1jvUJrY6/VwB7XIEWxL/GpZAt+I7?=
 =?us-ascii?Q?cfhKq3LQvqVCg06uQFD9BWdERT+tTpt6rTSKypldghNRUo1M5370tNupObbZ?=
 =?us-ascii?Q?Zv7XyagyPoio0IBltZKx3uAyGrY4fMFzbC4cnA0as/ht/+/MJ05g32AMK4H3?=
 =?us-ascii?Q?cNlcf+AnWJlPwcuHeLJ6LaIUT179tTkWtG7XVikEsAbD6OmUmiYijdgT5o8x?=
 =?us-ascii?Q?uyls2eJEfZwlZC6IdwCMpuB2pIoQYGuSN0nUGjkWrl2peeuwFr6RghxqOD3N?=
 =?us-ascii?Q?lfpJQkAaRN40siCxMnKuwGx5mPKY/zOjTiWal2B950eSjvTUuH1N52iT83HE?=
 =?us-ascii?Q?QgweGJL/sHk6WoMrKats1YeevZVp7SKAmdzHT/EaEBbOAyjjgu3adcdMEf+V?=
 =?us-ascii?Q?1Mwne8wtG+YByY3vuVKLWfIJBoXbbdCT50HryqZhcA8M+RR71EJwDK+feso9?=
 =?us-ascii?Q?OtTlwSc+ZhIzdZrw3IT1sDCgwl/aon+GbhkogEw6r6yhvc91sI9GX2BIG1I6?=
 =?us-ascii?Q?CY1O1j1/d/3bxCRzGKIWuhyIqKmVZ36fxqEwIQ9XRPTmtYRe2Qe30fSsGWs/?=
 =?us-ascii?Q?GAyWA6/1kaahATcTMbiYzE9CTBplaJXKH5/nGrhbMjpmRDlb1t7rJ1065jBu?=
 =?us-ascii?Q?g1BAjXmFDZWpb1fMGVb5ini5uKgVicY8g3xKaZhUiH5+8GoI/VO5wUQex614?=
 =?us-ascii?Q?YiuZFq0vFslZvf8yXwQ2c4iT5+o+GKYi3gzyBqoZcnWDEKh6GE6+LIOkpLLa?=
 =?us-ascii?Q?WHGd4dq0vDfv89WCq7T0aJSm6xxGOHLePzwtWxSHR/Hr2dn/n02+MYfU0PZW?=
 =?us-ascii?Q?eJqdvs3Npx5ed0O2IcszAwn0ph7daiasPXeXtA2FQy23jgGIrWk3wDGYm/CM?=
 =?us-ascii?Q?55sc42m8r4p1acoV8/NiyrfOYdRNYFnfdDb0/IO//WCx73JC/a8rJJrDDR8M?=
 =?us-ascii?Q?leMMkMTqDEyIVXljCfsG8AgN8OHAS9acUMzvea8z9awjfFVkgLsIQ30aQhHB?=
 =?us-ascii?Q?KH+HKlJVNGjnfPjLT0rVtc9a19TnGxn6B/WaF+FNU77ffdqE46oDSVrjqWAF?=
 =?us-ascii?Q?tTd3bsVohFW/Y8lLHyTFQeMLtuXxjxwwgrEgCaBjJ+ZKBxlOr7EhI6dEusJ+?=
 =?us-ascii?Q?xm2Qrn/OP9HLM0kRcz9QZ7qPemB9/daE2pBspEgBfGJWSlkyuPsKHgVTeJBB?=
 =?us-ascii?Q?lgIWPfCn/G0u1RkfJvGMKVthWDRegwh29g1AqOLK9LoV415QEKO7vB4JteHL?=
 =?us-ascii?Q?Okb7QizAbUZn6m9yC2ujyVkOz2YnG+SWmWRSi76Lvlgdfwz5JIV0vOp2dYTU?=
 =?us-ascii?Q?XH9atzCCDiT8Cl9fgC72SPMvPf6TMxNdzDuY9L5/zeG1Q9cyN07FYIy04ved?=
 =?us-ascii?Q?j7wRDnYxzplJ/qkba68LkzRDbM1UNRBQW1OPaynpQMK9mEExNwxK6Epl6W1+?=
 =?us-ascii?Q?gSvcYBKFkNwxhLfbbP/RBj1Lx9B4432SVVZya5mT6OI3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88559257-f483-4fde-9c4e-08dd7388c6b5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 14:55:44.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjhFIe+O5dScme9lSEcE+PrtOjX8GuQ2t9sQhyAhlapmfXOZXUu8X68vIdBANcIz2Bv/dC/B2bbe4LTs+RDJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4519
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> Enable the driver to inject EINJv2 type errors. The component
> array values are parsed from user_input and expected to contain
> hex values for component id and syndrome separated by space,
> and multiple components are separated by new line as follows:
> 
> component_id1 component_syndrome1
> component_id2 component_syndrome2
>  :
> component_id(n) component_syndrome(n)
> 
> for example:
> 
> $comp_arr="0x1 0x2
> >0x1 0x4
> >0x2 0x4"
> $cd /sys/kernel/debug/apei/einj/
> $echo "$comp_arr" > einjv2_component_array
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---

[snip]

> @@ -483,10 +513,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  		return rc;
>  	apei_exec_ctx_set_input(&ctx, type);
>  	if (acpi5) {
> -		struct set_error_type_with_address *v5param, v5_struct;
> +		struct set_error_type_with_address *v5param;
>  
> -		v5param = &v5_struct;
> -		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
> +		v5param = kmalloc(v5param_size, GFP_KERNEL);
> +		memcpy_fromio(v5param, einj_param, v5param_size);
>  		v5param->type = type;
>  		if (type & ACPI5_VENDOR_BIT) {
>  			switch (vendor_flags) {
> @@ -506,8 +536,50 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = flags;
>  			v5param->memory_address = param1;
>  			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +
> +			if (is_V2) {
> +				int count = 0, bytes_read, pos = 0, nr_parsed = 0, str_len;
> +				unsigned int comp, synd;
> +				struct syndrome_array *component_arr;
> +
> +				component_arr = v5param->einjv2_struct.component_arr;
> +				str_len = strlen(user_input);
> +
> +				while ((nr_parsed = sscanf(user_input + pos, "%x %x\n%n", &comp,
> +					&synd, &bytes_read))) {
> +					pos += bytes_read;
> +
> +					if (nr_parsed != 2)
> +						goto err_out;
> +					if (count >= nr_components)
> +						goto err_out;

It is hard to tell but I think these err_out's skip the kfree?

Regardless it is better to use the cleanup functions[1] on that kmalloc and let
the destructors clean up for you.

Ira

[1] include/linux/cleanup.h

> +
> +					switch (type) {
> +					case EINJV2_PROCESSOR_ERROR:
> +						component_arr[count].comp_id.acpi_id = comp;
> +						component_arr[count].comp_synd.proc_synd = synd;
> +						break;
> +					case EINJV2_MEMORY_ERROR:
> +						component_arr[count].comp_id.device_id = comp;
> +						component_arr[count].comp_synd.mem_synd = synd;
> +						break;
> +					case EINJV2_PCIE_ERROR:
> +						component_arr[count].comp_id.pcie_sbdf = comp;
> +						component_arr[count].comp_synd.pcie_synd = synd;
> +						break;
> +					}
> +					count++;
> +					if (pos >= str_len)
> +						break;
> +				}
> +				v5param->einjv2_struct.component_arr_count = count;
> +
> +				/* clear buffer after user input for next injection */
> +				memset(user_input, 0, COMP_ARR_SIZE);
> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -531,7 +603,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  				break;
>  			}
>  		}
> -		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> +		memcpy_toio(einj_param, v5param, v5param_size);
> +		kfree(v5param);
>  	} else {
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
> @@ -583,6 +656,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
>  
>  	return rc;
> +err_out:
> +	memset(user_input, 0, COMP_ARR_SIZE);
> +	return -EINVAL;
>  }
>  

[snip]

