Return-Path: <linux-acpi+bounces-12757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BFA7BFDB
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF331189F69B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291C1F461C;
	Fri,  4 Apr 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlCVto43"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A01F4186;
	Fri,  4 Apr 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777982; cv=fail; b=l3DpuRElxRW7i6OMlEtnYqn71eogQYhHF26lAFkD79WyCuiFMpicFnHZLsDzs6rTfOw+rXyePEI2m6INpTmfUqMrjO38bKJSRUyhiCMu0Ru5O7ULXxxBzn3gZBovY2ewWF7snr7zG6VweC4dfOvlSLhVBEcaO3DDvsD91RfaC5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777982; c=relaxed/simple;
	bh=IRsiv8Fu5LqhaPMutOEcEAEl70zPDV0K+RLwj7p91vg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sGVYmN0BzpbacsAy7ZY1FmGQ/BSdXe279alqJYBDR1KyX+2L319CPK3ajm9MSH2lXuiTwYYVSNSJ23bAd52v3hIrVfTbTu80nBc02dL0DRE/rzfpLh3Uao8rOxQqrpdKYs5lxbgkHdp/8FOfndCEmwY2jJu98wUPt45sf6anfQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlCVto43; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743777981; x=1775313981;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=IRsiv8Fu5LqhaPMutOEcEAEl70zPDV0K+RLwj7p91vg=;
  b=DlCVto43PaniQWSx6HiTSUKAx2bNyrRkfs6S/nUNg9o8FYkV9MugmHST
   5uI9G/LNbQfc4Tnpl8A/E0xz8u6Ad3T88QkGkJxgnI9b+yUmtqudSUFd5
   8WUUBDBsmvA24wFKthnuTPXYt8cVMm1csWkQkI4WrDmqbnws24PH0kvuy
   Y4ygAvOy2+6eEZdvUw6pKkBe7thhwImjN/vRL7XH3lWnzTUI5emWbc6I6
   fL4QzCdaNSYcTGdFYbX/APppVoi+pFDcqH3+3muG5g1eL8/sMGqITvlre
   +16I5kjM8soBs135JMCbD6WMsfJQRFJo21TU6CelvapBhiTN59yKiFiHI
   w==;
X-CSE-ConnectionGUID: rgLfPxvIQ8+KmRej+U+JYw==
X-CSE-MsgGUID: pKAXxgY0SD6VvOM7XKCwrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="44467417"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="44467417"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:46:20 -0700
X-CSE-ConnectionGUID: tVbsihvpQ9++Ez/snIsbjg==
X-CSE-MsgGUID: sn7/sSQ2SRuAocggqkBM8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132449304"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2025 07:46:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Apr 2025 07:46:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 07:46:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 07:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKSlPnQcINuaMMMslYHuCAiPp85xd5Sb+IyNfz3Jx3Lus8oUZMGk6ye3U7/smjHXzaykS+n3sNo+ngFZm4+FIwbOBJNIZB7SBZWlUWx4I04HpGbdRs07SgsaUDK5B04HBwPHVkcDxpo02ESbRiS080SvmbPKqDMUQwdvUgLWDQ+GDsClbwqfhFDS2m+nczjV8SnFeuL6rSRVaeyLuISO0MBKu4jdjlsvCN+x9Rqw5yl/M59qwXQQyqfZgNIH5ilCDs7jTw6IeZsGP5+vHdkeavDa/8nKEbbsYT1mSrDhOZIPFB++DcIK0Kqo8F6SnBpIxoOUbf3w1uFgAW+mwua/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbP4QKWK4VTkPwSugF2209ph0EVmzJxGljzTXgaFx2Y=;
 b=hc31UWTOaAsM5ThcyF8J8mKFOp/Fq7X5arTRW6ivbuTZgNmsPXukhgpYzbaCumQOrgtgO3cOmr0XMxFvM65NiRlcohxkO36EM64/IuPq3ujuEeOZa/ViY1uWB5baEozqhK+KyqpzEV8xLcCNH3+DzBR0AIFtHyvUuXg3+EAT1TAFjQ6RsfhmVez0fo62EYRJOQjbIzFCszfDYAWC2Qj6GgTf80Jw726NehFISsyFwm2unRMsNtSq3BGH0MIqc1ifxZSHC5lwtvVBBsFKuiGPOYB9Y2LiHLUxnjq4N6KmK0p6EmfbOlrC0PUvDqmDwS4wGzwHm/6gkmz6aUx4RHwF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 14:46:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Fri, 4 Apr 2025
 14:46:15 +0000
Date: Fri, 4 Apr 2025 09:46:36 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <robert.moore@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2
 support
Message-ID: <67eff0cc66351_9807c29476@iweiny-mobl.notmuch>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
 <20250403231339.23708-8-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403231339.23708-8-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:303:b5::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: d87eed71-3bb9-40ca-b3cd-08dd73877371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JaudcoN7bHfyDm1CjmUjHqiruTR7TWqNQUxYFr/P7ZJIps1sa8vwWAVx6nOW?=
 =?us-ascii?Q?YeAZIHRWQCHgA5a/H43aNHZUohbkUkCAShMX264e2fwvNU3dEWMI+kPPiADX?=
 =?us-ascii?Q?oCG17Yny+uHiiqafwiPXV0PJYTw4YBLjGU3bFjA7OQ+ES5sWQ0qM1NBhJTMB?=
 =?us-ascii?Q?89WBdYwW84jxY+1C2keppCF0NS5VP9VSdzZ5OaSwrlBb/2bGD+s61mpRsnac?=
 =?us-ascii?Q?CBaMRaR67vaS8RbxuUP4K11QnDadmt/d5SBbixAKr9z6+mVrR84urLrIRCBs?=
 =?us-ascii?Q?qdhfrgYuAZMSHSvnNeFuBbEYaz4b+Vvkfh+tKYst2EpBWvemSJkHfljp21BJ?=
 =?us-ascii?Q?ITJJplohT7RniYYO2GPrJMHFYGF4MSH+gJYV3k69PnRVmy+tZ/1IDtpfzq/s?=
 =?us-ascii?Q?9bYzWyFyRg1NUj7vIHbSakTg4uuY0M6Xf/QKoG2BmtD540FGHqS+dAyWFLdh?=
 =?us-ascii?Q?ZYcr8jkVL+38DUdXDT0O9XL/mcWRsP0uLDtj9CsKF2UujXtWHBOk4/j454Xt?=
 =?us-ascii?Q?MR/9chkgGrlaOpInWh76er15lQBI7NbNsUDCrRJpE8ahk9+nVkBtbKubJOgu?=
 =?us-ascii?Q?+bedrXMracBfM1XeFCCTi1XsjHjeFkZ70Hy1TtzKY8YjX7tiA5WIz3iA9bSP?=
 =?us-ascii?Q?XYZAJdtsvJfTMX0wW/y5wISult56AyG71d7LHpBDvB4xcS2BPU3GIGgdOu6t?=
 =?us-ascii?Q?iw1LKFiLvoeT2o9UN0B6LYwuhB+XDD0C6y5biXh94LVd/TU+GaDiV1qIy8mM?=
 =?us-ascii?Q?mW6KkYh2vzVkS7tVV6u6S8Wm0vG+6Xv6jY2aXmn6JmexEdo1zJagpZ4ScRIF?=
 =?us-ascii?Q?yvMQYOqvjcyICQbJkxVWpJNRRRWHSV7E6L8h4hh+zH1DZ2KxxdeibhOPGcRC?=
 =?us-ascii?Q?xoC6MsidAsmZAInBImP/Qe2hs8Ee5goVaRk46NOJWvmusuxP5RdMrdzLuMbl?=
 =?us-ascii?Q?7P1aL2LQKwlat3iwJP1d8EsNQOd0LxExSI728+MaRNetQ2oIYmy3qf0w2bzV?=
 =?us-ascii?Q?Hdsu1EDEDHLcNn5NvqtKRMNY+r2s81SKa24u5GNJQVhRNwu0FPsHxf3sit9j?=
 =?us-ascii?Q?WLwFTb0Rx/OZMEZvymJTKgq5mcE3Q1mAT0TYA9yBIFIhCkfinz2KF8Bih/8a?=
 =?us-ascii?Q?H7R/LDTEAUjtwUYDDeC2FZQu79IiKsClXgMF/Y24Z5QiiSSXW2Pkg4yimtk3?=
 =?us-ascii?Q?VnsNHlR+ENzM2QsqITTJr5K7f7cOF2k3LaIJjscqJkDPERfT/++tnGsaH/EG?=
 =?us-ascii?Q?GPIEKAVrkUC4HwIKgz3X23zcSq2MjLhBl38J3ujH4bhhjTnHPdI9l43kHB84?=
 =?us-ascii?Q?KKp3rINbBzft3y8vDCCHgDDyo25/qaPjB/xV5xuE5YHVQ626KPjVzfVwAUod?=
 =?us-ascii?Q?3RJJzsrQRl/x/9u9N5r11CNE/fql4tczhe/sm92BlfgXHs6F4zvuNVsaj/KX?=
 =?us-ascii?Q?NwAHrYUkbtLzfY457nil88Y8Vvmz3tYPXoug1EE1HUjJARHfSswEjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdabGqpZ5ktlfUR+rLTpPS2jyFG9EQKciBpwZ+nfS+lZlz39uUTztCjrmMpF?=
 =?us-ascii?Q?0OVgDY2eGYv29sSYq4Ge/W+9uuT3fS3/WcqhvWetQCivUtaLuDRg0wi2Fv1k?=
 =?us-ascii?Q?otTLyC7PPqHkdc6oogcTMF5kdT+ej/kVS0k6ZyEBphRzRL2nYi8tAjC/Wh0h?=
 =?us-ascii?Q?59oa6aQ0KgrNQ8icE5GerRLTVpuyF48q6MD9mtYXMHnb+pa5+xBM0sMKEX2n?=
 =?us-ascii?Q?SFOiLloXxpee7gst+rrrifiV+v72V01pZpb8pf6rJHlKKUUEjDuP0M4VUUf5?=
 =?us-ascii?Q?UgysqjqNxfmkffD8fZ8S3m5A6TrUT59JYX52/sudre4Ad9YWwe35euBmO55i?=
 =?us-ascii?Q?Pxt//UD/P0ImVXZb1JeOvX2j98cfS5yfjh2dGX5+cz8mECGUvWiCvvVr+XuG?=
 =?us-ascii?Q?u9DOJyh9jnno14Hkk88cpfVeh7rCnHxa87O2Vx1apoX6NOfdO7lEcMMuTRDk?=
 =?us-ascii?Q?Zy0pohk/yxE6GNDFlXg+ezYErMQmuwN/b49K6fvEFpqZH9S6pFeC2fwscflO?=
 =?us-ascii?Q?90jTTIZwWUScSBn3SYPxyhqdshUiarn3yd4TTfQVDVosdi9wczmjhVRLtcf8?=
 =?us-ascii?Q?IaQGt2U2xKgTUoyjZ4anFpMqhG+kLnneUSReQ2JzY19L1Wl4yL3srZfKRS7o?=
 =?us-ascii?Q?clXgmMnXTQ5Tu4Km72dnTLOWaYfh2qkUvcZPllSjWSbngWC1kxTIGfYgCWyi?=
 =?us-ascii?Q?kGrU8UxT1WONIVOvBkTHPUPNYBrGbnSPyodwKbV1pRUIBh1ufeg2So9ir4gO?=
 =?us-ascii?Q?aHR/SVI6MxruiGxgE/sDTfAaalbcNfrtIwAlTqLbIDj0dBsW+HhjkfYnBI7a?=
 =?us-ascii?Q?NSATCVlVPLu3J7ETSvO6GUiG9gp1cR7S0W4jISndfhpjmPv9hy9ztb084nhF?=
 =?us-ascii?Q?qggcSKttfz1EU8JkcJH8GiOnbJkGGC+xHU3EA4zcTFs2D/e5i4QY2NOs0fS+?=
 =?us-ascii?Q?+2kBl9j+4vCRz2UQcmBrQDYrcBWr1z2ym3lTvgzkbLM/5MkMjS2pFX0XBYlb?=
 =?us-ascii?Q?22KJddBUzeJFxkWVEuv4SxoK+I9iTGd1cGxH6XTgFDW8MdOXC0rI2j6CNmSk?=
 =?us-ascii?Q?4qc1x3nt1yjFEIymZwq6Q0VX2EHBqtJNE067J5HqPYLuRMBxkzQB7Cmn/e4a?=
 =?us-ascii?Q?jZlYCXPdlemqa5bNbZaX0M+IPu9xZsn3aSEGxXyYly15YbViR2WuHnIGWCkP?=
 =?us-ascii?Q?ABA30Rz3wCjXr5I20zLxyyZmQqzdDhF/nkF0v7doDP8owRWABgjlQcd9aKOZ?=
 =?us-ascii?Q?jd2yWTkNT1yAjIidav53Ys886isNeQqwh1YDO0bus7HYPILasGKL6Wr8vk96?=
 =?us-ascii?Q?CpdXSC+y3wcP7cAyqe45l/1LXQdEEAOifuu86gVhcvluQKvlhd7i8jdSktob?=
 =?us-ascii?Q?lpW61YxDIA3yEN4BU9ILMDc8MHl8YxsHgdN0+I5+A+SmpKALXOqBL1wKpaIm?=
 =?us-ascii?Q?+22M1IVXWFX0ONCOrSLCCI7BMljodllhm4EnBd4b4xeQoOB2iMwlujHwXKy/?=
 =?us-ascii?Q?NbjKdUzBTje7gmchGEePlOiERNleTP/+AbjL9pn9AGb1oBAcQNSpIJ1nofhz?=
 =?us-ascii?Q?QXssIguZXm0Ir1k66p71rujtQUVB07J5p4lyI8+iJRjULtR9ksHyUl8lxly6?=
 =?us-ascii?Q?yAVOs2RC70WTbqfdRRiM6s1G9XdECTqRJxg4FlBCA3Fu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d87eed71-3bb9-40ca-b3cd-08dd73877371
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 14:46:15.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqBLfE8Z3ROQztPobIc5zym+7zGW2VABCt6Csqd6LoUd0r4Ns13sXvy8BmvWvuK/pMOdqm05otfeWrlDYU4HQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> Create a debugfs blob file to be used for reading the user
> input for the component array. EINJv2 enables users to inject
> errors to multiple components/devices at the same time using
> component array.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

[snip]

> @@ -890,6 +893,17 @@ static int __init einj_probe(struct platform_device *pdev)
>  				   &error_param4);
>  		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
>  				   einj_debug_dir, &notrigger);
> +		if (available_error_type & ACPI65_EINJV2_SUPP) {
> +			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
> +			if (!user_input) {
> +				rc = -ENOMEM;
> +				goto err_alloc;
> +			}
> +			einjv2_component_arr.data = user_input;
> +			einjv2_component_arr.size = COMP_ARR_SIZE;
> +			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
> +					einj_debug_dir, &einjv2_component_arr);
> +		}
>  	}
>  
>  	if (vendor_dev[0]) {
> @@ -909,6 +923,8 @@ static int __init einj_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_alloc:
> +	apei_exec_post_unmap_gars(&ctx);

The addition of an unmap call without a corresponding map call threw me.
I see that this is needed in this flow.

Why not attempt the kzalloc() right off in the function?  This avoids the extra
goto and all the unwind path.

Like:

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..2993e0eb4f81 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -771,6 +771,10 @@ static int __init einj_probe(struct platform_device *pdev)
                return -EINVAL;
        }
 
+       user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+       if (!user_input)
+               return -ENOMEM;
+
        rc = einj_check_table(einj_tab);
        if (rc) {
                pr_warn(FW_BUG "Invalid EINJ table.\n");


Or, perhaps better, just disable einjv2 if the alloc fails and not fail the probe?

Ira

[snip]

