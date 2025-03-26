Return-Path: <linux-acpi+bounces-12483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D192A726F3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 00:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB73BB675
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185DE19B5B4;
	Wed, 26 Mar 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfmPGanJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DC5028C;
	Wed, 26 Mar 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743031185; cv=fail; b=mVnx5LUHy57UyLJ35sf6kPKfJcQnoPQzsdim9zjRfUQduwVkkWtzCLgY0K4vBSW0JNtz/YhQ4TcD4IErNjQLYBtMxwt0O/h8hkt7G9egKt5mcV0wSDAao2h6UonOt1rfO3pecXAHfUMwCdHs52nI+5aQ35tXJmQ06bqVI9D+i78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743031185; c=relaxed/simple;
	bh=kjkuJ+D1bXPtRLYrykCRZ8NJ01UPgYEho1DN/mOSy7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLROeqIYdV61PxcV2jOflRjpA7dymD7a3cYdyaH2QpLmUyg3zGJ8OJxcFvIVAspPOIqSnqo5C8zGttwAzQwT5prpV/UoRLi6bpPYHuSHsHQp8u0+GncqTw7BjDAlol8kuJOK3DbhsTRQQ0s8om4GsXgMmAkc6PtgCHjwymYStTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfmPGanJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743031183; x=1774567183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kjkuJ+D1bXPtRLYrykCRZ8NJ01UPgYEho1DN/mOSy7E=;
  b=WfmPGanJz1PD6f3M7MV0GZwzPDAnVwn6+4u9NC/PWA6WdUK1fHRskTrx
   YQY5ae+lndWlHpgXpMF2inawT/V9fhFqOJuC7zymPrv/wCp4VmHTqbfI4
   gjQkXHgztFgWoXwYhOYqPTgMLz1vwkshRh8vEkPzVice04pMqgozSHSQ0
   ZhQRWFuy5DWGvurX5OT9kFk4gujR37ihD9JWx6EzdV1H+CkCkKId33vak
   LY1LaUM3BDDIYnB2fI6HsNvet7DqwWHP8ufhopZ7ENKcK/GYLnf/2nadg
   bY6V2LlrY8mpNlOsvnR7g1dXyuMc3WK2xn+y6QYKYOkXk0QWWaoNRFRMw
   w==;
X-CSE-ConnectionGUID: Qic1RxKmR+OJfWzbuJSVRg==
X-CSE-MsgGUID: KzHmKI9NSX6EB1Z2yyL3AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44446442"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="44446442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 16:19:40 -0700
X-CSE-ConnectionGUID: FojzdFG0RYWOMGDiCNawvA==
X-CSE-MsgGUID: GkGWPyxnQr6Be4ae2F7Oaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125399896"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 16:19:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 16:19:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 16:19:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 16:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNrerqwS/78tUeLOoJK4sCLi/CyGZ+BFUbO1wjypta+Y2L+pCMiywB981aKZYWtHETa711FBPKNRmXV/PhSIVPgD8+XCPjFegEmVBOhWUuyf6xC2damh4cc1R4gWOWrvDcHG/pjyqyzVUM82+tRY+SbDozNxh+1rqfl/w4DJ9jznwyL+6GQkKy1YSUXpKyyeRwqAbSSm1lk5dkOmaHOc4/bx/PeKXQmqg8NTe4T80ZlXMCQ0gyk7gl8X+RiNSR5LMsTeuRFRTLISmgjlpRSb2aa3ugdcPlqDk1yHwg2tOEUPgXHUicjwJCZu41wZNrvyV997YlDzsAEBrqzwjaMcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjPg/uB9XlZhO8QzR0A07UI1Mm1ia5ZrYt2egLQNW3M=;
 b=HNLg3es6g9jxj+dlavxo8GtJ2oJksQcJuXZ5ETX5zp8iedJQXpJ+3eh7Yu6r/EVXoJzmi5E/LMmtf2E1WLhU9qd2uzyM6DxPKeZSFyVtUAnfsVOiqind/5sWJDAgF+gQB6iKk59CmynPOWL7tt2jXebaZLjoCa6SpFd9eZ4oGRrHwwbd3FeiRSr0CJ4kPVzKTp6Z2FbzoE37r0UMLr1Ordj3ejxw/g8hcSTURoIhGaedRQX5sDDLNfu5OBghhzRwTofhxSUgKJy4+U7YfRQeEuQVn51yuqFjW34bOUEB4HfQ4mBh0E3LqLJSbArj7H7HCxZvmoe2wepmUQp0i6ymVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 23:19:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 23:19:36 +0000
Date: Wed, 26 Mar 2025 19:19:29 -0400
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
Subject: Re: [RFC PATCH v3 0/2] ACPI: NUMA: debug invalid unused PXM value
 for CFMWs
Message-ID: <67e48b81493c2_13cb2943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ea8533-e13a-4de8-e343-08dd6cbcac8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8TfRGShH1KJCA8LiDZtj5KuMfJ9v9bshBhmWsjsRiPkVFaFewoSFvHla/uR0?=
 =?us-ascii?Q?OjEUYNdmIJa+1kdAAKvK5nAH9Bryyu3+tWaCw1APFlYwsmJI1PTT/T7F0HkI?=
 =?us-ascii?Q?fVU2H9h1cMh4IvP5bdtqcoTJR9BYcoaiianCYSKVLYB5fpghjdMcO5Yjm9QL?=
 =?us-ascii?Q?9wG0CzIXBLb+KLqsgqcA6ifxSdo+pRSvHjeGgwd8zra4/nq1pLRoElUtO8l3?=
 =?us-ascii?Q?6gKweODWaQ0QzWMSO94/W9azm4Rk44Br7RNBnP4G5ksBDhcNzmrwnaE/n4Ak?=
 =?us-ascii?Q?Uy8lEO7W4d5ZqkRVI6ufNtOjvchmSgqzC1KsYi4pKCXurtr9ZXdWgh4lg43c?=
 =?us-ascii?Q?iotIBbb3GoUt+im6wBJIg0Sggx0PbrzvUB3mA/xSkfShXf8gINEtaUesbSn0?=
 =?us-ascii?Q?K952UedsaDlKn/o0zGFDVV7m4+yC4hIhF0C2z+oFalwkFUW59mLuYeY7+T9k?=
 =?us-ascii?Q?8cJCqEwz4zv+62OzZDLmh28Cnem2CApoecsFjN8Q5eSdH6da2cJOZoWYEe2s?=
 =?us-ascii?Q?uCL9HSmw8sSoHjUwm3Wh8J4IwYrhWz5p9AKYzUdSXys0Xos3DizRnE8ExwE2?=
 =?us-ascii?Q?snRjE6gHYpAElLSgCHxgdzHm+WO9fapJ1DDuMXiljooftWXMYU5T/kL9THD/?=
 =?us-ascii?Q?B+KvLU+rLj5+4ZuPArC/ZKW6sKUngcy8JPo3CWskLTH984ghW08u3NvSbwRd?=
 =?us-ascii?Q?VHPxC8tc8erJK04BFdD9/+YzbT+eP9OhdfUwMF1xz2OH4NazSFhKozSn7EiN?=
 =?us-ascii?Q?PmRsp2V6GLvxGOIhziyi58u5+mYaSJIJkwW5FopmgM/quyRYTSdZR7dHeNeO?=
 =?us-ascii?Q?IFEirdzjEIejyT+UqlK43jCPl+6hSYw04yB2uzPKSJ1QnHzSMEGvteUSRoUc?=
 =?us-ascii?Q?KsEMR3PoD9DSv7TO8yPM0P9zuSvb9aUwUeDHxOz3ofFvm+Uumf5DZQZKBjqk?=
 =?us-ascii?Q?KsCCFOVIqxjjTXU8THf74cjA6xWCKXlkc+8ViTxwnrzJKu/63OQkaadpkMSD?=
 =?us-ascii?Q?WWJrUjA1lktW7ePmQU/WwQaJJgEKRSDth24vjI2pb0g1O3os2SMLRJdI8a4G?=
 =?us-ascii?Q?TzZqKWj5PXijvzbkTT8rJlJw+hFiitxjcTx75K3ft31CCcxXb4vZvvGqT/YV?=
 =?us-ascii?Q?FAZvUlb8oxX/JHhL+djrxHVjdZiQoNrLdztGe1fcSn2kNd5GGMoLpaTP05o3?=
 =?us-ascii?Q?z1za7V7ASxqshENaQqTILs3UsFZ0SoU0ulj3jLXae6bP+W8voLQYNKDoBlAB?=
 =?us-ascii?Q?ewnvxT2Y8ttU0q0pSA3IkWCQ2ERU54+x4+rJqyK1v9ssX0d/ASKpRq7El2v/?=
 =?us-ascii?Q?tyMFc7/Dlk7h49bIy+oQYWZs1k4W+7WRHKXwih5bBSZVW5ctnspQqcoVlaWc?=
 =?us-ascii?Q?nNBp0Dsi9O98Yjwf0/0zgdi/ZCMm9CRD3R/hEv327wzgn8se/X1azKce+8x4?=
 =?us-ascii?Q?i1vKysoce8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUDNpe/MxbzcfTyXX1zjmShqsKsJUYqfhRlNsjj4eedbCDF4yeb9toN1lOji?=
 =?us-ascii?Q?BXegm/xPV5Tps51c8ykExMtwAsPHihO5LeqRgyCBxeurkQH0EZ786IZ6mG+o?=
 =?us-ascii?Q?OR6F8eSzoDIe+o+2eN8AreVM6P7icGhKp9aN6/y7MZvz5UNSb/LELv4onmc+?=
 =?us-ascii?Q?5+WbCXmTCgNY8yFMEQJ90A8+AtVe6Oa3K77D9Cb877uu0CtcPOUgZbB/Pvd9?=
 =?us-ascii?Q?YHiUuDgX4wKpmloIia3GHD3F5Iy/LZcB7VX+qeHhHzwsAgu4tlRyrGit+i//?=
 =?us-ascii?Q?v6p+IPnSNeWvDlpUbkrB4HSTesd4A3xoNXlLHcsiHlH8FhqXwuAxgra5fzjT?=
 =?us-ascii?Q?NcE+I/Stv0OsL5r0OAOA4ReLozUArDnkvgPXxTf/OkunIQ4Uv/jzaE+rhPY3?=
 =?us-ascii?Q?9Og8/QOpdfl9z+OcxcCbjTD6oRdOXGzNzcAuWlhM91ukGVLiHQGwH6WTSGd4?=
 =?us-ascii?Q?AG9JcCqJ0q1HxmsrRr88TbUOoSQaS9I0QGriU63gSXZtTPmA8wfqkZRfm1IZ?=
 =?us-ascii?Q?SPte/FtWwGcujQ+67zM1J+rMjLX53K4Is/Q9EZkot9BDOUvFJ+dRJS6vlrCF?=
 =?us-ascii?Q?uN6LsuAIW4Hf2f7GUPbql4zyayyVp3ymq/U+wG8zTmzRPgodVYRx70A58PA6?=
 =?us-ascii?Q?TnHGA0uTPwtMf7nI2cKfVGdJV8ioBQdXdxgaZXaKfzsMXVj75oH4loobdsgi?=
 =?us-ascii?Q?sLFaUFvIwBTTM74JmojOLvxKQJm5z0aLlYM++h22TfPhlqocim7H8H46pYTu?=
 =?us-ascii?Q?5bqes1RAYQxTg38wFnEralgUXqoik3lRMjeOMzWrPGeqFfr69ttuZyruIo6n?=
 =?us-ascii?Q?OlidTz+GjCSLRx+VVT3Wff9UgUqMHhrQHKus8ebmDBmvN+IoZ+lDK31BEzcE?=
 =?us-ascii?Q?eIznOC4SL2FhgEl2OaZm++2G0t/YUyw42xorr8lsEBCv64I7ZT6Q3zEs3VyB?=
 =?us-ascii?Q?kQPCfCGpBgJUlSEUPE7vqgUaYe8a1DSX95fagKwsnAZGtBBhQjcgqrhDo7sU?=
 =?us-ascii?Q?TSmWhYZBer9lcmE9as4PPkK/7SpT4yuUmzpep0KjYkolFp4LZ4FivE4AXNYA?=
 =?us-ascii?Q?LIFX6qkdp3p/ApNI9ke1QC2YImg+4qsnJ8TcugHnD8jSfsyTAy60gCfn+I9C?=
 =?us-ascii?Q?iKrO6CXEKF+8JdqxHyJRZncVA6eZA/GdrxARln9U2tRMwbE6ERo+RdrKm9O0?=
 =?us-ascii?Q?1Xao0ryvzW68DqZWV9og1YmyN/0/lQ02ZGcnsMbRih1Yq007ys6ORFzaqQRC?=
 =?us-ascii?Q?vk4VTcVxqzjOYCjhJtxbbOd9NL6nBxuz6BEyEan46r1lbewdM/BWQOTIE2yp?=
 =?us-ascii?Q?bSkPvFddpI8UGHDi51aos7VTLHZlD9pZbhFeHKAzuNAQdPoBukY5yKEzn7Ri?=
 =?us-ascii?Q?XN7HoJhV4r/dfi6wrSEw6uDamUSKeVClojsn5xy66oXw7kf4Tu80HnpWjYts?=
 =?us-ascii?Q?cfWAb+5uiV7hkB9kqizkyBQvHxFJjjlS8dJcxFa26/bMiTDO69Gexhdk5P10?=
 =?us-ascii?Q?vhf+Uu85bKZpfCO3jEgFeAEun896yC7Bxvaj6VBrjsFDXf/0TEsqbdpj61r/?=
 =?us-ascii?Q?2QSL4IGD890djxWkpHMKtFWPX+8HcGT7tDod+W4uPmTY0+nOqbtx6lmh/93w?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ea8533-e13a-4de8-e343-08dd6cbcac8f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 23:19:36.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXMD7k3U3X9WD1JCxb35/7KOifdahSM9V8DIrIx91x4E5a4JF6QrAIfzz8K6vnDxk3469UmNaYw+Mt/1gVrQVm7L/+pvRf9n2K39fNiXZbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> Changes in v3:
> - Introduce numa_add_reserved_memblk()
> - Use more explicit way to make sure CFMWs fake node >= 1 
> - Replace numa_add_memblk() with numa_add_reserved_memblk() in acpi_parse_cfmws()
> 
> Problem
> -------
> The absence of SRAT

Can you say more about CXL ACPI platforms that do not have an SRAT? That
seems like the first problem, and this information helps determine
whether this is a fix that needs backporting, or just a cleaner way to
handle this quirk.

> would cause the fake_pxm to be -1 and increment

Not an issue in your patch but it strikes me that "fake_pxm" is
misnamed. There is nothing "fake" about it. It is simply the first
synthesized CXL proximity domain for future CXL region provisioning.

I would not mind a separate patch renaming "fake_pxm" to "cxl_pxm", just
to not confuse future readers with the simulated nodes produced by
mm/numa_emulation.c.

