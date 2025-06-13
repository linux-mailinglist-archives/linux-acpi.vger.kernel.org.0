Return-Path: <linux-acpi+bounces-14358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FFAD9300
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 18:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42F5189097E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80D20F09B;
	Fri, 13 Jun 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0f25BJ6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6620E717;
	Fri, 13 Jun 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833057; cv=fail; b=SS1kJ4RXgji+DrZvwq4mTHLyiLyQILOUd6eYmzavp7xLkoqLrAGu943QIh6gU0ZxtQBvVggNcYspjVvNhIvB434PevTq8xmGeqXEPIZScJNHh2D7JicSZnQmYv3YqBXGjkMZlOIg3Cy6abIxXttcoU+MmBDPT10nbWaPP2/M0ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833057; c=relaxed/simple;
	bh=DL+6Y9+hYsmJMIrbsW0mGGb3B5pHM2P5qCMDVjIdY10=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rDjDSq497sLYN30Ef5wzaSzFIdZvXpNl4eRHuqKDOj8MgupkPHMH5vpzlZvlf4aQuJT0Fmo18b4EoVHviV3vuPX6qJPFGICWeJH8rsjojQzyFlNRmtCO55ggwXu3N4RM9mW3hukm7y5YVxh2zVeBimZGX3HXbuWDzhlre/ZFH/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0f25BJ6; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749833055; x=1781369055;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=DL+6Y9+hYsmJMIrbsW0mGGb3B5pHM2P5qCMDVjIdY10=;
  b=N0f25BJ6dJsrBO+WR3caI7PMlxEVLbhlxq0E6zv644H/ZXPfi4T8qfiz
   Oal3h/NyldzOWD2S4o7rF19gE0FzmXtrD+fwiusffA4zTNkZbVNHyNMp4
   F7R1AL2C2Lxxy7hP6TEtcM/Zt22+6DGC12N2xAiYOzHPJpRn7n6v99obt
   slq+oDOCjx7hktj2ABtE/SDJEBjuOh6KYE2pxeR0II0/3SFR82ZnL6QYX
   ypPQTrw/TRtj99oNq2LxigpLmqr/wkEM1xbVUbnMBfN3TN6FhsORFH+wM
   rTZxBmznGATRahhEaQPXeUdIwnSY9RMZBU0he7WdvB+7UmksPpuQ/StVA
   w==;
X-CSE-ConnectionGUID: dFyTGwoHT3uF2zSt98pfsg==
X-CSE-MsgGUID: fn0/5n92SFiUPYq37OpaJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52202857"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52202857"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:44:13 -0700
X-CSE-ConnectionGUID: 7M9gR0PKT2SE+pELhbJIRA==
X-CSE-MsgGUID: z7pSOJMrT621TMHqxy7BDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147865085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:44:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 09:44:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 09:44:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 09:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKHA+Cw/1EWqu5HJw3SURYWIZcP2QFMQ+1pRhopi2cazWwfeQ26SG91sLwFoqTNDTcWDfxtaNcvEJaVSxbFlS/itjjWAtRP91MemRX3dKHWhToTpQOU8Kr1bZVE20zjBnpmIIy5w78jiWbJknQBAcEfARXN1q0T19I2qMDJh/K3N7t8fVeZzx0c8zx9IxnUJMnQ94K8rkjkTa1o4Nr5xTnNyUt3nTiBsoMNajRYQh1apcs/ZV3J/1wEMitA5g7CvLKTkljirkxilywXDE6lGJQ3cil0WimLQTEb0BwqsnuEyK10P7OWkTt8prV0jFoiV8jPZBcjK+oDSo/yCGXA6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C622WGpfvagfxOMCx2HWBdx5ro+XTDDmB8AOM6+lySU=;
 b=lgPkG1+ia3qPEzXIEEmxwCfEyb18DBXcZCM8GpOvzn99JifzfKUwsE3ptVdwHKIPmakRetsptxsKIuxk+8pxzoh3gW2LGQLsA/hEQ+y6P/vYo2euYz/dsj7ABbtvFMTzNWAbWvfpzwmKHDi5HGBl0dNOb9lcwam7OLUuO+hvgqr+QRTo7dE7XEJvM5dnTR6Fu16hsDGaamBOjoZesNrthw+d8AotnJ95T28iKbtZUjzc4LeFe8aq9k5X/6v0MlEcemz430Fjk1hL75wPGUUAI3je3/s6kP+mkYdp4E3GNQYaIxR3gK9aTsICDHD2L/R7JRKysjWiBBXkBYAXOo6peQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BN9PR11MB5275.namprd11.prod.outlook.com
 (2603:10b6:408:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 16:44:09 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 16:44:09 +0000
Date: Fri, 13 Jun 2025 11:45:16 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <sudeep.holla@arm.com>,
	<jonathanh@nvidia.com>, <u.kleine-koenig@baylibre.com>,
	<dan.carpenter@linaro.org>, <viro@zeniv.linux.org.uk>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<gregkh@linuxfoundation.org>, <peterz@infradead.org>, <dave.jiang@intel.com>,
	<Benjamin.Cheatham@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v9 2/7] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <684c559c99732_2230d929498@iweiny-mobl.notmuch>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-3-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-3-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BN9PR11MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 865d4d0d-8d7f-4f6e-dd17-08ddaa9984e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFGGU2QcW+07Cv8Jp7t4rifzRnueyE3EE/jFzShuy3w4FVj9km1QQGRgl7U+?=
 =?us-ascii?Q?NqrDcT6kmTP43NcsEP2AHpMVvLGYpB3n4syNdaIdPQNObqVkKh1VQ/r2CF9+?=
 =?us-ascii?Q?D1MtN7szb6fIARYCdpPSQ0hzEM/5QgrjZGl5aDdUr2GuZ9dBnTQStlCVGSol?=
 =?us-ascii?Q?qlfMk6nsUb0B1xm/uhGRACPjF0cAcrdgVgbdACkRZIdCbFSiOXA2bQb6ONGU?=
 =?us-ascii?Q?jAVmxqAoebY7u+NglFVmAHcxr2TVM27QZQAaY59/QCmrWi9yg6xrqQ4QWRA9?=
 =?us-ascii?Q?AnKQElvek+3BOTKkXoqWdpAONQ+pQnrgAkwpGb+gg9VUJRYWGTaec3OByJtI?=
 =?us-ascii?Q?TkeQN2QwRNGE6Auw52Fl9C6qNW3XWaBnX+YzWVLFlQIewIsNvHP3eXrvvaw/?=
 =?us-ascii?Q?kaYxKZLzPnu1fthp46Ay4rmn40pz8TcGb541m/Lyh645ImqaLaOLIiZz55Xs?=
 =?us-ascii?Q?/YchAz2RqN52n3mFAnRrIF/RLEHz2ZiKIClf+I3iBg+qwEfXo+Z3vDGEOT4s?=
 =?us-ascii?Q?ouRj1dfoaoTbrciyphS57ERjD5aJm4cv28H4qeI6EBerghqY4/hTEl9YC6a1?=
 =?us-ascii?Q?8yUFDGf7cARH8H6/3LAfyYDYWFOKJ5aAPH8sTl/rn0RFDnzYd/l05xSlN3eT?=
 =?us-ascii?Q?wOfDj4rcASdVT9CQ+BgcxtT8JmDGBkaDCaQRCoUbPekOjROVUFsBsPrQs+py?=
 =?us-ascii?Q?2p3rCPiRFWLnjw+g7tCnOPs8UWehcdJtMVSDA9ZFC+riA3b4TR1TCSSeUn7D?=
 =?us-ascii?Q?MXId5d02gabUEb73wtHhV44wJllemJzqXlQt7QN1yLOpYZkVMoYc63ZndwQw?=
 =?us-ascii?Q?HC6m4fCZaxApk2i2tiPHZR+RV9P4ArjthckpOv+JmmHqPE+k/Zsc2PNLaJ2L?=
 =?us-ascii?Q?9gFyWAMWnEn+WIWD5luf35G6VPhOLJEvMZ7Vj9fi+dyh/Yt37nb37/99USjw?=
 =?us-ascii?Q?NVr/a8pmxU8DS2zBEbkJ3WCljTW0Oy8sTAB/vzddduPggWmn+NVzW6SIUXaQ?=
 =?us-ascii?Q?2whP0m5K6LKj8GLf0LQodVJ6chOcZ8WpeE68hV8/DmzBgnJjVE9p40+nt8+p?=
 =?us-ascii?Q?sHRK9W+f4ZOsdNtlF1mK8JlRQebtb6H+485XcNulMh3NBoK2ir28XNf3jc1P?=
 =?us-ascii?Q?+4HqEjpA9j+qVWuWWC+t/rSF9aV+RS5bEdbFzz+3UL2/SF/5VwrI46GkwPI/?=
 =?us-ascii?Q?Aa7ikltg+po5nEzr6ugv9byOXCtXFIFUba5VtNTbtrfWb4R3I5KBRYOPU5y7?=
 =?us-ascii?Q?dNJfVI3SbmkDTziatWsEqWtb4DUSzDZ6GP8+/1GW1lns6wh7wLGiU6hJcfzD?=
 =?us-ascii?Q?SXOXDjOTGvGZhOkcAWCiGRdJ7mxk8IdLQd6S8mrkCdKD/LWF83qo8+wU9Dir?=
 =?us-ascii?Q?uDnTGA9AOkoDuNxNEZOrBIt9Lrxn5W2n1q1pjBpPrHCtbUO9DPOCkLzATtu7?=
 =?us-ascii?Q?DGlZVo6khgG5jkk3IFN2uE3p4wMBcW+6JrCuciE70HvKioodciBMKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0aP12d1Cls0Kl0hQrGeOOFJr0WmO1F6kGokQHEj9VvJBBN3QZrqTqUfRfmx1?=
 =?us-ascii?Q?LDxmIzn5NcKQKQLE3ovJJgSD0d5Ud1tQVa7OMP7iFIHSmphTGgqAZCtivrvR?=
 =?us-ascii?Q?0z/HcR+UUOiY3Y8Of0kN8ORB1ST6zf4EGNe25lyqwDRN7scig2lCoE7+z2r7?=
 =?us-ascii?Q?BLmOPQqLU1jZ4tHlyEbAvWd929aIgM8HaaSmV59xru89YXTXclef3c66EqhP?=
 =?us-ascii?Q?KLyMlPZpEkIXwJat+uMbBnvZpv2FrY3j6SIOsnReenjN79fe57zvN5P2rCBR?=
 =?us-ascii?Q?DH4xwhtvifZwiOw5PgLATl/dwGEkW+He184WislaR8wwmZIFpCvApscvBCnY?=
 =?us-ascii?Q?4LzxeFEdFR4OMsx/xFRyhKg50Javceiv5xKJDMrBu7bsqsiHWspdpBjGgIgM?=
 =?us-ascii?Q?ZGc4jwa5BPgrWxI3slQJ+64z8wug6ZYaWbXCd8VoZaMTUJiPCE3J+c9OdO7T?=
 =?us-ascii?Q?McRtu5Vl1lHLPiX5hsar7jZOQ2VDVspcsbb949UwztGRoTGUR/2Vt2wKHwVc?=
 =?us-ascii?Q?NSzQ+1JLfo5h6n5D2QJsy92W/l8R7xJbr5BpqAI34Jm1ut2cJZgacgMdslEP?=
 =?us-ascii?Q?3vfZ4T/nsd1ZS6Eqf3BU6fZwGs9l5cD2/nyX07wDhmU4Jv5/qPU7fsK/T1IM?=
 =?us-ascii?Q?NroqNQ7DkkEhaYOmsTRvuCDJpdaYSafthx/t4BzPQjgi7k5mVuImMzAhh6Xb?=
 =?us-ascii?Q?8wEScCX+11sBwA9W3BndcYmBt7T9wnG6UdVra5RLXoqE9jTCEpc52tB4pul8?=
 =?us-ascii?Q?QeSMKSRSexPxlSdWDdKn7R/7HqZjZtCBk0dco/Zrh2VrSlWeDmGO48dv77wW?=
 =?us-ascii?Q?bHszmubhTsSRHW4HZXMy5b42uYeZiXbuOR4Cg/+rdVOMmuy1mZk0axDfeLBB?=
 =?us-ascii?Q?R/lFzHr/6LIq/X6XdJYbpnFWKsI4DOui0ZOIeoPY3pnSxn1Cbw3jN0OrlIRs?=
 =?us-ascii?Q?70cvO1aSCj3qSshIhCK/xRcumBN6lpntFqrk959aJIFQE33LJrZwoVg/vn4k?=
 =?us-ascii?Q?83IKabTiuhCcCyo36Wm6YsnPxHZ0RHKFjpy9UHsfKHAN1S6S5EDhmMZORWL2?=
 =?us-ascii?Q?IO9xOoNlUztqRo+XT/E2dNUdeCYbDy3MU3hKSIqW/bFd45mKF+cvptIemJ76?=
 =?us-ascii?Q?NtqFEFlegIZBmfT5CtxmCpWewQGFlUZMRKM4ahVLgzmDGcj3yGWNaR9LiRLU?=
 =?us-ascii?Q?NhGqh60tp6nDGGbKh/MI2E0rPf3iREh0VlxokY2HMsJOKEANUpVG7VMyFlOB?=
 =?us-ascii?Q?DL+uhJJ/IHKSC78BgDF7d3Yz+BHBKWHIBdc/ZK+T63WuK6/jpxJT3yN7nZvr?=
 =?us-ascii?Q?GgYwwgTghWlv27h38PvILy0snOdlX9VgzGJlmj34vVhTwo0lYpeugAtkwX4n?=
 =?us-ascii?Q?pYXjNBXwf2+OVEOUpEXmtlUf6sUcf8YcStTfOfw51vMPy19AsjZ5C8gLy/fa?=
 =?us-ascii?Q?Otu82GwGX7RLnfTCbrCV2HBxO+s0ubT8j8yzPs6kQSMw1PvOALll1Mc4r52b?=
 =?us-ascii?Q?z2QjhukAahPw9z8rj1W5by/6CnymUHs8yIaVmdekIhswVdjq139kv4skGU5K?=
 =?us-ascii?Q?OP9ltPegRh9/Kl/hAUgaIuu5KAOnflDdqAAgEpzK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 865d4d0d-8d7f-4f6e-dd17-08ddaa9984e9
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 16:44:09.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUNdzUHJnHpIATTX15qyPNoqQuJL2OPU/Fb28yIFFoWEMdIq+1m5OP2Bp2Nesg8yQPEivkk4gLZTaFeFKe77BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

