Return-Path: <linux-acpi+bounces-12484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E2A72707
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 00:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61453BB199
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3F1AF0B7;
	Wed, 26 Mar 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOCJzVGY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76312B94;
	Wed, 26 Mar 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032047; cv=fail; b=Nz56xebcKPxBGQTBBtjwS6SF/CZPVw/iARXH6EjAKnxwRrS+IV/awDrZzy6ME7V/Q0Xy0LnhVdLZ6IZA7xc8umbq+Ju4QlVwMJjS9N8BwgylXlfRcCUumXsy3YlDNdfYJFLWS1pgfK3IuMMpr1U2wsw2JDSSO/07fUk5TOgnkRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032047; c=relaxed/simple;
	bh=T5Nawrm8U9dhEhODbq46a9x4tEj5yooYzU6r+wS6vio=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ie5nO3XLCJQJsgoKZWYtLPmB+r6UmNCy11UML7v/jqNxT7MfPZBZldOycwu7//RsMAyJy/kjh5no9HX6DKJsAXioLyvYX+WOdhfGibnIYTZ6nhGIh/Mbr8NPeTFyVKUkOQW3YMzW5wyYnr3rdTh15/wXCLObqbkDtsVGmw8R/LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOCJzVGY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743032045; x=1774568045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T5Nawrm8U9dhEhODbq46a9x4tEj5yooYzU6r+wS6vio=;
  b=SOCJzVGYqRc/E1DSnVt1YVyhLS21ejuHQrzrL1Ta8UwwWFjz/RC+1nFE
   MI8SBqyv+jbqU61xzj0eKiEGL8ey3EG9SOvuVaSEpo9muZJCjoYfJzqt5
   Jg8yVD3q34u9a7OWuUKEomzUSEgd1wtHnQRHEzn/AP1Bl4HOSUn34W4bf
   OBSo1gfcQmwq4Ebm6unrHiD3e62TLMiWqlQJ9JNO8nD4ebuRl1ynLTjNX
   sfbT30uHQw5pc1Po1+PmQy43K/WH0Z7xgr19zGf7SGtVURhk9F5ZJwcLO
   EBC+MsWtrfKF42irjiv58AQiDTWfI8BLKAi33SjdC2MEqXuEzFfu7rC8P
   A==;
X-CSE-ConnectionGUID: zJBwL8MKSkGaEFLnTvcPsg==
X-CSE-MsgGUID: T6jLuQYkQACi4bL1RQMQ+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31948316"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="31948316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 16:34:04 -0700
X-CSE-ConnectionGUID: QXALjF1VSSC9Kx+cbITr9A==
X-CSE-MsgGUID: wtBizYgRSiem5ctn09tgrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125401706"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 16:34:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 16:34:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 16:34:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 16:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1Uk1guzocVyi5ZRoCF4yjCK0XlI7zzHT2WlKBt0VjL6lRaiHgfVYkFySafx2w4AZQXq3PYY6kne/3T6Fcz20IbBzniDJXymnQ6OcsNHaVs1yW3HxWXOYFPPQVigtHbk6K55hdan2fJGYnTnIG46tzG4D6ptgElwzGBi70bZyDar6nzUmAMbi+zaGvPx8DnFYnhEpCBghDBbjSt3XIvBUjIr90L+4qZjw9h1slmmg0/mynAN6rSGpSVkdDzX36gOfUEhHEAPTjkct14ms9FvWe1hKce0Ux75k4UBvt2sHApyC8BhwuudiVdPopViL+8bS0MmhJ8c4+VHSJbqSovY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn7Ae4EWOQF3L9ktbuJEK3/hnNK4OZDQYcSUA1ws6JE=;
 b=FYCPxPpocuikWllFtMTfq4bpoNwPvTPqGcauqpLLwQ6V94ZtE5EU0xu/4fvA2xEvSEJVo1cwH6KZe706F7w46sAYA57QJpSbTAoIYE/7YaYvfLJiTf7OqrxVrGeHHRdwKZiKek0i6VUGfRWjv+PjoF1aQhxhstr6cY2SBVvc0IXpT1WERBomAKfND+FrdI/AQxWwFFwycsv/KK8P8+9xcq0V8KEMfIzJlaoGT5ubMqSEsTwAIRdiHN1+sUWCSgLKs7Ygt3nFqP83+K3r+hrtLcVjuqC8+yebafnDPOVP2AmpHu5VRTwjhnK84pLK6Eq/JoA7ezXwDBCUa5IenjhcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 23:33:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 23:33:18 +0000
Date: Wed, 26 Mar 2025 19:33:12 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>, <rppt@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <bfaccini@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rrichter@amd.com>,
	<haibo1.xu@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenbaozi@phytium.com.cn>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
Subject: Re: [RFC PATCH v3 1/2] mm: numa_memblks: introduce
 numa_add_reserved_memblk
Message-ID: <67e48eb87206f_13cb2944b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
 <20250321023602.2609614-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321023602.2609614-2-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: beb641b5-2ea9-4a97-e37b-08dd6cbe9680
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PS2twIknNzhVVnSLyQvrhiudiL1L67qjv/vEFte/z1sG2kmU76QwbjUEXL7n?=
 =?us-ascii?Q?zV57KWokgewewVjTSg/778xdZ14WqzG9893Q7idFPteq0B3rAhT7hSmEi9Li?=
 =?us-ascii?Q?pysoiHBF6MknJS8R0lXC8tUytufGs3FNqrbNJZ2epSZhc6ucj5sm8eocOzAY?=
 =?us-ascii?Q?AYrfKuj45mJY13eIAFENTKotpMVU9gImU/BWqcre9XvxiXoUTsqowjZFvEIN?=
 =?us-ascii?Q?Cn5TvgKl+8HJTqFBfQSvt9UkJ4kXNRMC9TflfRYa3/UahqEiObR+1DvkPAn9?=
 =?us-ascii?Q?CLFHPcuHUzJsjOQmKcEbeowHq86lBtAJGTT9hJMU1J9eFWDbVlG2iSHEiANM?=
 =?us-ascii?Q?ybOBZ/JW8d50GeH/10kDv+KNfhKJ71DvfoXYHkBGQp4Bu8YyUeTjGrgpRy+W?=
 =?us-ascii?Q?Ds7XRpOxxq+LaZphUym6HXqyis9zs+Fczr/rJKGHCMjuJbhor5kp4VxvqV23?=
 =?us-ascii?Q?VtrwQ4gBmNsnVDT2GhS6yxkMZ40ocqDTBpsOSxVC8f3o6dFg7zV4DynVhN9z?=
 =?us-ascii?Q?7CtVtC+ID7QOb+dTkIOLieYRWQ4woj98+sdSfNQOo1NFzwlm89LG6Bo04Ojh?=
 =?us-ascii?Q?fPFkYPu6RPAtPUK/cRlZmgynO8ykVsn+yJXRQUAq0KPdubkjMvgivV21z/Kl?=
 =?us-ascii?Q?uDyf4LtFzbLY/uTq5/knSNDeNPruekQ7w79WZTtXaa4Kqe8E9LK72zRNBxu/?=
 =?us-ascii?Q?Wxmk10Uh/KbIKvmatUC3dtrQ5Dbi11ZeaibXBYA/RD2XWoBF4sV+QhLrN5qR?=
 =?us-ascii?Q?r+a+Zkr1b221/0prgQXczO+wEjTUGth/m8L6aAN5JyyMyiRa8wpuHxaaZboN?=
 =?us-ascii?Q?D+Jx/WFxcEgzFzAbQZQQnLWCfBn1uQ/4irn4u78uwCyAVkkGtnmSVZQAO9x+?=
 =?us-ascii?Q?KsgOWDNXJOY8DdqwTdrFRc72NnM1HM8fyHOYCKhQWn8AcSLzFvrgHH+iTjQY?=
 =?us-ascii?Q?lz6PKZgb0ihnHIiU68OpnqaQKR4CoKTgtFFMpXmKfuXwe+Fp12j66tH1zD9f?=
 =?us-ascii?Q?Q5b/DVeTBJEY48yEgUH75CAzQLZ8Y6v7yTdFpu0i1NTAIdBe85Pa8qUfl26l?=
 =?us-ascii?Q?wJptIEsMclARqow5S6xnGO0BePFnIKm7akcHWwwmxXnvBZBH4vDqfobz0ENI?=
 =?us-ascii?Q?53AQyygtf49JkddLsxro/O2u7NUbD32qmlydnp6C1OnUHCKK3Chb03zMow4T?=
 =?us-ascii?Q?RPDG1Fdf9frjJEwXSymuePVEJmBsRp87aQQgCYmx6QtuTzDLkNocd0w+3AAC?=
 =?us-ascii?Q?iaALPuJH37m4a8XXjxa0yrgrMLZnGRcTpecCKMKUySuTP3fqRbwH19a1KwJM?=
 =?us-ascii?Q?ZlFiY3W1MroBZa8N5tUPbdgr+5lIRab7Z6IoUCp8NTaPLKxkPYVZlazPRG4w?=
 =?us-ascii?Q?0xTCM8MoBuePpufPfej5PhkcrIMmCSlYm5Dd31Pgrg2XNHVLZ1M96TP9Gqty?=
 =?us-ascii?Q?QV3n7I48bTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caR5/TilrDhHxeFg/bof3qPmJcunztwy2x9U7mEfV2HQyn9jgJAl2ccQ5q3M?=
 =?us-ascii?Q?fftQPWvDeyN81usw019eXXwIZCLf0+kTyld1VrrMmhl+0WRF+FyQgywYJOsq?=
 =?us-ascii?Q?l788NqlBKPCslSYwuCIycb2pSc9ahZFXIkRqmlVOkPb1lsUt3Iu4wBbPTw3S?=
 =?us-ascii?Q?+t1LTJsXGxd7Fni97venAbdwNka5djHFTkvRtBb3nscjDivaU2VrQGGecXAp?=
 =?us-ascii?Q?PycfBOOF9+VQCTn8qlGihaDxY6DC5thCgOmzu0maU/UjnLB989ef9/Bxf52q?=
 =?us-ascii?Q?wwVbongMCjOuabuQVHgLYLls3iF4UChfTMa9/D6Q85/QHGwO/37zzCjDYFoH?=
 =?us-ascii?Q?POCUm+VBysu4v9pmWwhnExg2/a6TEMhSZKbCGr2CBHp8U4ywA26InSiyq0Wj?=
 =?us-ascii?Q?RXmaavqbhKsgTOymVDN+1NScoiV9PiavgdA0hnk2pmnbcloquc9kYTMgt/KF?=
 =?us-ascii?Q?JKgB0exxzXJdPLxAfpuzuIfnqfPnfb2WYSesKDhbxSYO05Y8WUMwBeY+Qllx?=
 =?us-ascii?Q?eP60457qhvki1pwlsUKDD2N7tpMMVPoz5GT/f4fnWDnTDsWWIeNA/ZTKEEzL?=
 =?us-ascii?Q?fb1QdKFKu3J4xJtglfH/4H6PzIQtcdSrqEg3JZ/bt3TyQR0yKe3W2ogRW7Yx?=
 =?us-ascii?Q?UI3wCYLPz6gOCk6gKDG5eWSkrjWe85iC0P+HaNIx0OZO3Bsf9C7vOVcF7L+t?=
 =?us-ascii?Q?+HpzAAvzUWBMXI+p/vO9p6hOxzf4SH1b+wrqyOTFFG95P43Ap3uoQNd6JAtQ?=
 =?us-ascii?Q?wzjH5nvCao5T9GyZTLjkYaOPpaqi/94T74C9e5ldVpOMnknPnrleXrIJZfuS?=
 =?us-ascii?Q?5tuPwe7zNSJKSrEDh2bCmTIdxHXAqAa1w81HeIzh/1fASCm276SKGxZvRFFq?=
 =?us-ascii?Q?5iygYfMCTCsEfPTsr/X7gL5PtaFr4cTivAqxjRJT4Y5pOc33WxyCdFulmoAH?=
 =?us-ascii?Q?ezUzxYTkqhRzggDsjKHMbIheoGyBl8qVa77ZdOd10qpwGVh18tU9KYVTb7aS?=
 =?us-ascii?Q?V/hGU9fd1QpozZ5pGC/i19FIoZdPkOT2K2D1xanxKxTakx8oTEK+AXcrgYtd?=
 =?us-ascii?Q?h5Fcixd+USNGEeh0el4FxhJH58lBhMM+dzrS5vQgbwCx0nUr+M35WXssNt+z?=
 =?us-ascii?Q?IGb+wedTyZHKlOHPiXinfgSw6VdK9EeiPKReuqKDePUixFX1IbNHNh4F+kQW?=
 =?us-ascii?Q?oUu60/QFgnI/NtD0rmkmxA9cG0+CWfwLe8nzDLn4/05Bxr6/FhVK6H3MBHq7?=
 =?us-ascii?Q?c86jRC7VJqQkY0P5FtGhkQT5yfJ+79/0//bMei5xFzvqNpwzAD7PUPKXalCe?=
 =?us-ascii?Q?2t3OOlIVK/k6AwhoMa/PLPvTqHCTO9nhByALRRUJJ56LoYfoMSK5ZDsRW5si?=
 =?us-ascii?Q?/rV3/dpnQ8atzQMXWNGCXjy2TQCBlJIUtxEKHV2Do9AXujGX7gHgsnVrV2r1?=
 =?us-ascii?Q?5NNJEGBp3TNM2i1Iw33NdinoxLX4BC07WlTUUi6GXtHoc2IFzEgZv0sUurDO?=
 =?us-ascii?Q?sfaT+ShNidPHYvl4YhN+WYSBd5xE6avsyrJ0IfrXMA/8S4dzXzk8zNZ7U/if?=
 =?us-ascii?Q?RyDSMNvih5n0rE6SeIyUMeWeKF/ukx3DPym7h0VtayofVpPXXlJjKcWY8I0I?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: beb641b5-2ea9-4a97-e37b-08dd6cbe9680
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 23:33:18.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvEPDSUqUDg2yQvxawjIN/XUi4qqsbCNewJwKqHd2kalwfRSCcNGRx9GwHmfSrLby9cMvI08bYnfzxcZ+gdy6u7TkgyI9ZzdC49zONhldmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> With numa_add_reserved_memblk(), kernel could add numa_memblk into
> numa_reserved_meminfo directly.
> 
> In previous, such process relies on numa_add_memblk() adding to
> numa_meminfo list first and then uses numa_move_tail_memblk() to
> move one from numa_meminfo to numa_reserved_meminfo.

I would explicitly state the motivation and the use case for the patch.

---
acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
with the expectation that numa_cleanup_meminfo moves them to
numa_reserved_meminfo. There is no need for that indirection when it is
known in advance that these unpopulated ranges are meant for
numa_reserved_meminfo in suppot of future hotplug / CXL provisioning.
---

> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  include/linux/numa_memblks.h |  1 +
>  mm/numa_memblks.c            | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
> index dd85613cdd86..991076cba7c5 100644
> --- a/include/linux/numa_memblks.h
> +++ b/include/linux/numa_memblks.h
> @@ -22,6 +22,7 @@ struct numa_meminfo {
>  };
>  
>  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end);
>  void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
>  
>  int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index ff4054f4334d..e70c76cc46dd 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -200,6 +200,22 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
>  	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
>  }
>  
> +/**
> + * numa_add_reserved_memblk - Add one numa_memblk to numa_reserved_meminfo
> + * @nid: NUMA node ID of the new memblk
> + * @start: Start address of the new memblk
> + * @end: End address of the new memblk
> + *
> + * Add a new memblk to the numa_reserved_meminfo.

I would say a bit more here about when to use this function. Something
like:

"numa_cleanup_meminfo() reconciles all numa_memblk instances against
memblock_type information and moves any that intersect reserved ranges
to numa_reserved_meminfo. However, when that information is known ahead
of time add the numa_memblk to numa_reserved_meminfo directly."

With those 2 suggestions you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

