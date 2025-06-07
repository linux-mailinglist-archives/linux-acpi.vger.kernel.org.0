Return-Path: <linux-acpi+bounces-14210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B1AD0B24
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 05:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C722C1895EB7
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693A258CC7;
	Sat,  7 Jun 2025 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9IIkm22"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F62B2D7;
	Sat,  7 Jun 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749267165; cv=fail; b=ov3o3BetrBLDAE6mbxJgHaiw7Uj92Tztbod5GoCOd6b04PR09kzQrG/pr46Mryh8fC/Uqj/cd9CvkhED/yg2tVjT/fwmsYe1ip0GhPqtO3PtRKTMfQ9mZKMkvwJ9evjlKgVF2mpo6ZCLn05tnn+0W300KsFBpjU9lJ/zela+Hdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749267165; c=relaxed/simple;
	bh=B+R6ezHaU0MRVEr2ew8wJbpf6XTIvIUf/BcDRqptaQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbBDQC9g4LibCvFbx8my3pISYqxc5UzG/T2O1iU6QtfXw7aRe5uYNI9zCtdB6cVWSB7SCHoL0uW8cFqYopXA3KFhUlizmmS2a1Fip9QdN5wpEhWZDRUNtdXLkn9JpK8YoUD/jrWYXWb7sT2Bw6+bcThXwokPt7+uC4QFgrs/XKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9IIkm22; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749267163; x=1780803163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B+R6ezHaU0MRVEr2ew8wJbpf6XTIvIUf/BcDRqptaQI=;
  b=n9IIkm22HbS7HfsbC2Zpji7s15ahbkUq5hjvJTPjypYeJlFSn94KqjKP
   Jr7OZmv62ZiqquU4Un5NY8SNjk5wFfZ2NgGiRxAxoBfplGlcteqI7Pczk
   5e331fTLI4HHhx4NVHijiHtF2KKte6W/AnSs0XEkxJ3SnHQEJdtB3T3Vm
   gazDHYplIOuI7sumvM4cm5RBvtxOCNHaJ5mYcw2FJOTLLnEmkOAggr4ES
   Ftkte80V9Og687muaISWVwQclO5R8Zgb77yc8b+ZJTtsBL6fpcUH/che+
   IVLmytwjWfRrVVYojEqVl5Ui6hBmEWkYxw8Tn/RD38XZtYoARzbFu1n+e
   Q==;
X-CSE-ConnectionGUID: tvknyzTPQkSg22Zg4kv6+A==
X-CSE-MsgGUID: f0HdhRD9TVSd0OslVCoGPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51561755"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51561755"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:43 -0700
X-CSE-ConnectionGUID: n+/X7wioRICGjvN24dHHIw==
X-CSE-MsgGUID: Cf2sx9K5TuKyLWAGmlqjPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="183183118"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 20:32:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 20:32:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.55) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 20:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okXJ7wF33y6EKzfJXp2/PkYEv8XTb6Efwg2n/8vGIl4CbgLgdWW0eYR2a7GvsnuRbODYPjtfmF4NrH5HP3GQdYetCNzYkLIyH52IQ97a5W1oWz2DoV3eCB3UtxFwZUKakWLh9iKhRLao+FesGtlujXpocaIJxCeiHq/DnDZq053fkmAmSNAy4QBXHGStZXqaCq3p/r93iU5K/bgMG4RgKpUb11VILYUMHKGntYzf7xhyFm/d/GY8L/fA6PH7c6B55CgAz47rSeuKlogyar+L8JWOdm12ExT3Ww790M5fddNUTqV5+/cr6M4nzNh/5QKll/LiZY4mI55eIyaw1IsKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jlsib3Snom6dJmi737EYkep05FFmFWsolZLru+lKJjM=;
 b=nTJY06Rvm8YvMjVtsxpAQNP3ysqOwisFgC3rt5eCi4Sn0vZQz77Q/60oC9wVwn/S79thZC8cxW6mkSe50LD6cOUiJMF/6UyVBMTYT3X4C8ED7zWH/5thdoEeDndCHvCQobn8GigPItw+cZ+Q0kSAriE4kWULG4KE+ZgZQ4VKvB0g9B1FBHZx+1pa+9x46DEGZs41w7ExW3FTnAcHgEd3T4jAyE4Tg6pfc8pyDDUAmQm0JTlEZtCsoL0ukfMvZO/jEGWupzHLNByn3fUYZsss/kMZUme9u+A2asT+IdY+QcMoRmVQhmiBJvRdrS0YMjdRavfCso3qMgiXTiH6UIhxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 7 Jun
 2025 03:32:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Sat, 7 Jun 2025
 03:32:33 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/3] driver core: faux: Suppress bind attributes
Date: Fri, 6 Jun 2025 20:32:26 -0700
Message-ID: <20250607033228.1475625-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607033228.1475625-1-dan.j.williams@intel.com>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: c1473c59-e172-4287-493c-08dda573f02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GjAX15O4B378T6qWQTZJjUq8dkCKYisrYnO6buJ+TxcTJ3YhZk6DoGrA1V/5?=
 =?us-ascii?Q?w8WwEvOpPFryxXqM2qpjKwuiZ61HrKwMED1pQQqCJGyKVUUyFO2WaVcrlnau?=
 =?us-ascii?Q?yzDe5nR5qnA2J1zMHlSquiz95RssBopIOjlzHCLCUYc3DRv/NwCdwqSrTf97?=
 =?us-ascii?Q?KpOLU76qQRWkT5YhSCwP0GmuDHWr1d09ZQO0HEGSdPGgv9mA6UTajJ5/KuR+?=
 =?us-ascii?Q?NtTPjeOfKOSo9Y/ghCQz6NmiuM+nD50d4Q1rZJKbHffx8T6m2DpK1l+SDIdX?=
 =?us-ascii?Q?a/foIFCluOygjDSxoiF4xPduPnkCCHvFL1V7cJBNFbbZSdehivIiWFw6r0Sq?=
 =?us-ascii?Q?7pLZNm3YwMtcoNs59hWpia8AgnlrOCX3Viy5uUSCupbHnI4bYw3gefKmJ3Ct?=
 =?us-ascii?Q?jYDbzHM/YodV0ePG4kP99tLfaaGqCXitWcraapAMUWE4BG6D7ZAI/JvBXqtT?=
 =?us-ascii?Q?xI4yqSBEdUANA9g0bgiMgk9h7PbPLLDUiuqlRthHIopftJI87FZH/3yPWtOq?=
 =?us-ascii?Q?QxekZxpfyPUmAPbtNUStc4c1fpOK7rgCs2G2OWGlU9cxqbZppWu4aGGw2NG7?=
 =?us-ascii?Q?/OFiLjCGlNaawqHZLJDSGNhsNOm9l6Iy52mKchMsZuCap7najVNfSuW8VuhJ?=
 =?us-ascii?Q?TMUeW07MPl1aE3nbOqUQ4kvC007kpxHbIE6FZQ9Lto7PQDEgT4mhxXuo0bLm?=
 =?us-ascii?Q?halQHb+L4lbCy9RCLlpxCHfC4wdaB4BJpaA40fR6ugU//X5bzEc6VMrrFCNt?=
 =?us-ascii?Q?ng+1JNvD0QH4msF9P348x/kh0g1jLi19P/aw1hAxzcmdFzYgjsQIycm7AJFH?=
 =?us-ascii?Q?mV93MSkBlluIhbWdnMu0EPYibbxfQH/GE6CTftp68MPZ4Pvg19AMV0QYntbJ?=
 =?us-ascii?Q?je4wacNzTvaZWQ+8R6HgnKJtaOt9PGVUgdMAo95zqrnse4TfKcXl9uGd7JvJ?=
 =?us-ascii?Q?+tJKXKYZPrWnMLhPb3hBuTsV8R7YeGLbQGwSm4t3pshZxz+V/D6cogair+EC?=
 =?us-ascii?Q?cFlVpa42+XZYVULK9gJS7PBkNIDGVbi2Vn87yULm8vOtZGofmy0Y7KBZv8x7?=
 =?us-ascii?Q?LehR9mf4Tg/QV9ZcXRBCPS62jwH3kHWqDaWoPT6fbULhygJxxR+fG28vkEjP?=
 =?us-ascii?Q?E5OrK2NfToi9zyGE4iLBRGbEx/oC/kzlybsgqkpOASKgPN+RfxZYkdKM+90L?=
 =?us-ascii?Q?fUJgDUSv+q/TylogWGQlzdK+j4Hd4wGOWMa0BXOhM4VBOnGxzeCUYTMWKi+R?=
 =?us-ascii?Q?/r1/ej2C2lCTmmjs+7IPRDPDM2HWhhVjcTXjo1qvwNOwU/UHhLzF0WXN9gSZ?=
 =?us-ascii?Q?VOlth0Lut27NdexrHG5BWd2QRKkn/OMHvc5q1Ve6q7u1zgzJSZ0A4Qw4gKGk?=
 =?us-ascii?Q?rPDIUg0rQQ6rC02uYjAXetUFj4ezBRDU1BFJRCgReOL9E25km1pED9189CD8?=
 =?us-ascii?Q?kf/VDxtAtwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DiKRiiAOwrxbWqmBwhTvQbATuSiNMiuRXo3NoPXCytkkg58V37TLDvdi6bRf?=
 =?us-ascii?Q?MH+/n6w97KKrQ+2jOhr/TIJKkvfuSHoIw5NjSLGxFjzlsoUFLpaPTUhqc6g9?=
 =?us-ascii?Q?NBTVR92b+FkHabiZaK+qLphF1+0as/VQJ5Yb06ADD54FYZzkjDBLUHFzNUcG?=
 =?us-ascii?Q?Gasuo8VjPiTpk78bFrfP0OgzCD54rbTxesVSMi3FjvyGy2ASadM5JLBkZY4v?=
 =?us-ascii?Q?0WTHQ7C8OyoWSVIPeqWj0z1cfhuwhfE2v1agh7FWY16VfCbwwfMLAZrP/wb9?=
 =?us-ascii?Q?BgU3PX6ADsMvsTF8WyNDoFgIkfR1KqMHt/I1aAXGcpf1rnni2WarS64FBHpC?=
 =?us-ascii?Q?tWEeIVvNc91AXauf00jARwNt5SQSWE0zeSWd5qiqYxt2fqWzQtZ1DniHmv/9?=
 =?us-ascii?Q?0pnt3p05pVrfzPKv2g2BKW/YvMefXVHsZB4rX1WZHzFc4HP7BRdzWHtjZ0Kf?=
 =?us-ascii?Q?5tIC/rllkhsFRrmq+Ykk5imn049ui11QL6WD88RSStn2qINOeyiw5m7Wan8K?=
 =?us-ascii?Q?tn9/0gYOr/clxRIDdJM7B5mf23smEPPKjV5gA5CkWDs24BvQRFBMudID7nh/?=
 =?us-ascii?Q?mZIaSgokQt+qyy3itSvvMjALUVVxtZL1QWahHRhcKBR8me6jGjzNYG3DY9Js?=
 =?us-ascii?Q?TXL95GF8xhRZ9e5KA9xnlBJ7iZ9I3bs2YRTOC8l2YNtadvjQEVcGpVbosM5z?=
 =?us-ascii?Q?+iGRDwHe+pOLDp5HMZ6J1WMfYw1AMwjEQrCVU/clvGjcg479qg6PLWIkxkKA?=
 =?us-ascii?Q?h9XpKGyKUl+mJJgZ68ftybs5OH4R0AqxHeu2pxJgriVlp1nbab5HzJx9qjYr?=
 =?us-ascii?Q?AvFyNJAGni3MN3zRBtBGm/KmL3evVq9YTL1c+8B5gsAy1EwQ1rODx21RwmeP?=
 =?us-ascii?Q?s5RXfLMsRS9Jvr/v0wEwl1bZcZWA3IfHCF4wYHRoNjZQ8ZFjJXYFPKwYfjEr?=
 =?us-ascii?Q?iWw+f/unwcMTGexWeUIBisn1H77C8dr4l8opeGkU/NuDqe9j5eIVgIHpL0HU?=
 =?us-ascii?Q?m+08aGcKKNyuzUXtA+B6DQvaZ5EY5P05E8lJ/lSkgo/wzWTOMWkBj/8CjlVw?=
 =?us-ascii?Q?DGO8gQZEJxZ8SNEchDqrd8yM7MyAbMwWgqL04yJAPt89IOg/XkmIrosjGNhr?=
 =?us-ascii?Q?gvoDmnsbUveOxuUw/VAJ7/aHVWPo30swy6JooZZTGpQD66cJBvEp6OiWV2wp?=
 =?us-ascii?Q?3FJ3Q5GewBwvvWfg3ZniC6sr0bkvGUy6OBMFXqjyL5OEn+KN76eDMrz1xUdQ?=
 =?us-ascii?Q?eOs2TEc4DQAR8q65SbNf+ZLBTZTsS67qxrFKkMidr7edMyTiZiCNnEzOjmeg?=
 =?us-ascii?Q?4K9jyP0jkPdCzXIpqJCSgBpWovhpNQVNKedf1IoE3Xihhw0nn367rx+XfjpU?=
 =?us-ascii?Q?FQ0EugbaWryvGW1q4HFX1ALSKiJG2cRvbkkILzSnBWN9OZhkcYJYn3Hb+dk3?=
 =?us-ascii?Q?rur6UYzf1j5NcU54yR4GUoTkZJzvZR+lNdFqZ9JgwGiYfsLLbtwAYfow9PDQ?=
 =?us-ascii?Q?uT/z7Sv+CEFDl4U44AuskcdcwpaobEwKjqj1J+vSFVffM0ZlSJ1ccpt7sSXd?=
 =?us-ascii?Q?nwvgeKeTx+1YNGuw/b3R1JwHuSHWMReRRE0GLZ3Ty2hM6fak2TSP7GTViwIv?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1473c59-e172-4287-493c-08dda573f02d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 03:32:32.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n09NgbEbQGNPhBE5dys8qYx8NQC+YEsRcv+3lxWVS/wgWoVNGyXFv4eiuOklj+LTYujadhWgj9JWVKdiFPsz9GSbkpu737ypsdUI7Y8UZrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

faux_device_create() is almost a suitable candidate to replace
platform_driver_probe() if not for the fact that faux_device_create()
supports dynamic attach/detach of the driver.

Drop the bind attributes with the expectation that simple faux devices can
always assume that the device is permanently bound at create, and only
unbound at 'destroy'.

The acpi-einj driver depends on static bind.

Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/faux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 9054d346bd7f..934da77ca48b 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -86,6 +86,7 @@ static struct device_driver faux_driver = {
 	.name		= "faux_driver",
 	.bus		= &faux_bus_type,
 	.probe_type	= PROBE_FORCE_SYNCHRONOUS,
+	.suppress_bind_attrs = true,
 };
 
 static void faux_device_release(struct device *dev)
-- 
2.49.0


