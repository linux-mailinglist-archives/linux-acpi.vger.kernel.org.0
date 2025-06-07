Return-Path: <linux-acpi+bounces-14212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A8AD0B28
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA1F7A892C
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 03:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78027259C98;
	Sat,  7 Jun 2025 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftDfjNu3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666B1CEEBE;
	Sat,  7 Jun 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749267166; cv=fail; b=MqN+6l81S7mhCKOl2EOWRFl4mjt5xYNONmT3b0vbmoxgM1LKZGSX9c5u5f67aITmbeVPpOCThqj7FgaLj+yjFw8PRdkaDfYqw3cbDgnJaibwGT8dvJpQdg+XvUsB1hMzMLHSt+mjIKMiWBvpFNI2UJSf+GOvU9vdmEuwQcd6+WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749267166; c=relaxed/simple;
	bh=rVT7go0uEDeTGtdxoqqGjQobrra13mw6fztgAssgeH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVQIiCQoAR7iCkeLOMxK6T5PtLgii2NCfvpDUjlgVrSXcsa1nNwsbViGCziz3ccpAmcjjqgqaDhYCDViEOEMGIU8/OtYQh6WQEkbt1VQ5NFIqvRzwDlLicRzByVT2L3RflWySE/BtmPF6VXTEv1Azyof626MoBuoiE8zHZIYnOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftDfjNu3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749267165; x=1780803165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rVT7go0uEDeTGtdxoqqGjQobrra13mw6fztgAssgeH4=;
  b=ftDfjNu39mpm1/ozhM0ZXCPyRGDsc8uFQ2dFTTknIdcYGqn4jU4RNaaE
   v9L4C0RB51nszudSq/cUFs2k2AnpS6EUf9LQjj/HjtoH0clYq1FxNIy3b
   Hab+Fy7Igmr8X8e0jt9B5YYFoJRk5VI2wkns356BO6Dnyx72lYs4EYiS3
   mmi818Rzlc5EMWy31SntbrpO95SGPccnVQ/g64+EA2i4EfCIcyll3eKj3
   Q6uNd4a5qDDIICbjcvXF0OwP8U1tGZFTjbpUVHW2thcrQON+o5ztrhW2L
   aW0bgebyPsnIeuFnugN/5YwPQeEtS4ZVkp3vFgqJUG6Kp3cyV/IaWmCra
   g==;
X-CSE-ConnectionGUID: lZVljOU3RbWK3JZB42o2VA==
X-CSE-MsgGUID: w3QgVgX4RNGVhJhzxfA2jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51326391"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51326391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:43 -0700
X-CSE-ConnectionGUID: Kl4K/ToGRWaUi/tIOWOcGA==
X-CSE-MsgGUID: 36CLUEW+SdWhXJIYxd4SSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="176879237"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 20:32:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 20:32:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.55) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 20:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL3AD2EnbfzSc7UiaVtKGoW5zK4auFpdUH/Th7YCpwkcyBqX4s7ftOMysuY0ego0ka9N4RgAAx5VPKoW8gOXf+WMcLIPaW1DleHaZYOkVI9FbvaLAcc9PeyYT1XFvJ8/iezD2luz49iW1Vb5nQelDoOHHOWRMIbiJvCrWNALBnkmASpj4kxjJHcdAqExksYJv/IRdmVIF/FzfT4JRjDS5p3YKlF9TdvZ3Z8H7DIZrrkjySMMW9tasG1ysT94j99CuowRYi2IokTWeEUyLWyX4BwNYZ8sbM3uofxKV79JzdEvNfHW1cJ85r4OPEXZgp/Ct3qBB0VQ6l0eMUWMHTgypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D534Z68zDXlnxKPKCdTfpIboOta21WDL7Qa40ceevo=;
 b=ufMX6KXdNk1t2RANBH1WUP8Q4xF/41PuIOwLnX/h8lnBDatMyuieDqpLmIErfCjGZ312RFSegQBr6XB2eprqHDLk4SVYjVz6ol/jZIvOWWjOPJzPF/iz/Hgr+K3uewO/CdqaFG7077LkGrjHEJFgtyQ0dofsGtyl9qrnMe4DaUBkeqnB0OjtzV5E2oAto4v/VWiAGA3IVHjDrz6XV9QLaBXx26MFeFmWfeDVA/R4PraKYqc/tfmMLvnOx2PRj2/EBV0UpheldOngEj4S+dbsWgTE1ngpNi6emVuX+vPfkeXbjiLensS/tHNynzYtOKNDGx2+yZorQ25wKksPCtrwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 7 Jun
 2025 03:32:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Sat, 7 Jun 2025
 03:32:34 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/3] driver core: faux: Quiet probe failures
Date: Fri, 6 Jun 2025 20:32:27 -0700
Message-ID: <20250607033228.1475625-3-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: fecdebf8-8894-4137-5be1-08dda573f0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+XCDDHbnf+ve6dwNs2o20R20t+cB0/PUziFEAHGicdvr36ugNC2Wm+duDO4J?=
 =?us-ascii?Q?K+1+PIt9RIiVJYs1H5bgbQck3FynavndaYsuh9heK/o+NvFJ8Faam2Aqhhud?=
 =?us-ascii?Q?RpZX6cd7+FsUmTs9dCUPPqjgYSpTo4tKULBtdP7u7hs99WaH3xNfP+pesOBW?=
 =?us-ascii?Q?y4Vb0DGNuw3I3tquTjUSKUsKby3EC6iQ2+37ABl/uigBXB41MlLMClD3erNx?=
 =?us-ascii?Q?LvogU7kHjWK7VI/JbqUSa7iQRLBwhK+2+0V3MpJ7WuKZ3rNt0yPwME4VmKEl?=
 =?us-ascii?Q?AGHlorPQVhF1doy6I58Fcpe6OtVoefsIz9T/SjH3xCGNeLpZSnvxlKe4N0m/?=
 =?us-ascii?Q?GadP3/F4XsceuJqP5Y/d3mDJasZHpZreDP57Y3Aq21TEYsg+QU4BWZ/kQwCa?=
 =?us-ascii?Q?v98cFwIK+pZhslqloW30wwPvqo2iGSfxKPtd5Jpxg+aaX2lkrinZ3huQhoL4?=
 =?us-ascii?Q?cICgIMuFu2uYEyukBMVyRGqlPF2UUqd/ICnOCg3WosgadFITjWhwVIUghOME?=
 =?us-ascii?Q?I5R/gw5jr61Nj5nW4hLNh/OkMSb3HJW56m+l8PlQwjg2PSD6eM9dYmulbPxh?=
 =?us-ascii?Q?ktNtMI+A7U6DFINz+IasTFB3nO0vl/I9ogqa98cDVosvaGchG8WdC0YKUUZh?=
 =?us-ascii?Q?AnIM/K66GgE1QSUoWDctW3b4+mtTKwoKF3+wjcrzasNpZhXK2i813Gc1iBa3?=
 =?us-ascii?Q?H71UtEkHZvUa5iB1UjPpmtlNUDP09wiF3Wbl1eLz+oX+LOBU7LsqaN+Aj1Kk?=
 =?us-ascii?Q?Uwi/YHW49qV/vWj9/ymzv06efAs6o6M5pDq5WLgmy1+YiU5uoIJuYE2Tm2L2?=
 =?us-ascii?Q?SY7GdKSEQ9l5gPBMWCHvWUrg7Co81ymwEZ+BIIsHG7d9cyYX1DFQwosPSEep?=
 =?us-ascii?Q?lXOCtI205yMjOPIBzUHy1Cq4ZMV+V3Nqx4WYoUQOUyPTOpwrRtQ16sBAfKRz?=
 =?us-ascii?Q?uZpWdBmvG3nVfFrTRTUu/nmErYNe69ckJgHcKJYDEMab2Bisoxb8swHZcpMO?=
 =?us-ascii?Q?/QmG0OmmomqoUhqsJb1gjSnQmSEGpWVE20t4XXJ7ZeGZ8uLXfEHgn0rYFWQg?=
 =?us-ascii?Q?l0AXPJMovs8yHJ0zENh1GNmkeon2njJLp+NiTFe/BX8WDLn9Rp7jM39F73LH?=
 =?us-ascii?Q?SyiNUASrKcfMnTWtovoBvwaFmJPQrVn5R8wSl2NqloAxmP7PtRcswYyapyvp?=
 =?us-ascii?Q?DhC8LdFxaVRjkEpfcT2Y5psFBwnG3EdLq0qFx8cLfISWRrREvT6GcC+zNEVx?=
 =?us-ascii?Q?dD06bDgBnmA1AaoZDC7JO6P09G0PF+CUDty6KppiqEHsR66fvnm5sfnmCC9S?=
 =?us-ascii?Q?XTy+JvWV8Eyeyqh6ZVnRj+LaRe6anrKgRuYDEByjqgUqiymkOaRucNHvWn1g?=
 =?us-ascii?Q?TQW5uX9I4iuKyVJ4VuQGVEAciCC0ow5E/IhPnBgmVora/n7X6ZiR3sGqd1vs?=
 =?us-ascii?Q?46HUTeNQoDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFZhZhy3LgB6HP4fHekSE2uzNmc5NsCmnQqKcaEjiAfautxKDRadnWNgFQWI?=
 =?us-ascii?Q?4kU0qZx0705XkckYmq8LsXAGhDOXfY4t5RCJLVN0u2nV1Re8Z/WaiS5H4oo7?=
 =?us-ascii?Q?WFjeoufrYUerfer36xrGjm0I175lZe9/Dsf5Lr5/e4mDxOdAsUzPKXACtxwz?=
 =?us-ascii?Q?fY4eeX2yd4XDoF7B5GVLfYCPfWTk5A7jwpPd9WxMovG15nt/AeqIzeJbT4z0?=
 =?us-ascii?Q?wYSxU/vhbxVgNCkUrudffNtApcnvbczDfLOU+d1MXokGN6zLHM14KqnA8+eP?=
 =?us-ascii?Q?orWZM9n3vY1y500ZO7BYw54MPRwKSDEaZbfZUYI0/Iz/7PC1UZB/8rWkO++G?=
 =?us-ascii?Q?gGHXpD9d+ZSLPz+orPqJ7KtjZ0FBBKVDqW7Eus0A+T08qf1GXW+4k2xjhFh1?=
 =?us-ascii?Q?tQCJGNrnxb/sx325cmO8drP+0204tpr/4PdcPXlpl87m+8upTxpqoUhzHYDL?=
 =?us-ascii?Q?9x58bJUxw1SazwV1FQe/FE1NvJvWe0/BVX3P+JdbNwyMXrF7BNJjVRkPME6k?=
 =?us-ascii?Q?UjbkUhqbv/lSaPoMR8aDS+leuUwThbM+eIYJ+Nl2mQMYFUj+JFD4alJSX/YM?=
 =?us-ascii?Q?7XRAcoOLZkkq4CejicpW+URK9ewiei1Inu49akom4R1sZwcHsGQxCoo4F1NN?=
 =?us-ascii?Q?3t/1V4P+HIP/sl4wXkwuWJJW6TyWfY18INlkjConQvtmlNPksCZ1w74rxwOW?=
 =?us-ascii?Q?s7bw9vYHnRkWwGUmEMYOt07qmJMD+e3+spkG7ORB2xXUxCmq3EY9Ol/D1FX7?=
 =?us-ascii?Q?MY6Gxn48tX2855ZTGg00xFpOhyjnpvvXwXlnvDwEYK1As5a7RB+lGenTb+WP?=
 =?us-ascii?Q?rUXI/DqPxuA01sNmTmiu/ypUv/0pUgEWlsYtlwNplNs9lNDaBDlwI9B+zeBm?=
 =?us-ascii?Q?3WJhlku7JAWcRzz5/9oeJJagRzpl6NErLPLkxQt//OkYOhukACIedQuIsGGE?=
 =?us-ascii?Q?+bRtlezStjsHWE3jY4Bm+ov4ohFyb+mjKPQWUjFyDsr4ImwXi1WpyRwA2HT8?=
 =?us-ascii?Q?6GF+1f8GjbU0HoiBeH8ak8e1Mkz9ZGS0xXwAbgIY/krgV2p0pa1Qgx6vXYYq?=
 =?us-ascii?Q?wV95HWMDAJPpk5nb5ZnEbXamUiZvYXYBB7sSZfdTJ2p1elKP4COHkHbd+smY?=
 =?us-ascii?Q?/vKwbf73cnwm7mzMn9jz+FboUZlwHFymgmnTifXtDMHuJnfK9wvSEIElzNac?=
 =?us-ascii?Q?vhLPATNvnad9SL7N0EX3tSiEEE40q0RdqDcRwVnF3paTVHMlXR/uLlKJLvUg?=
 =?us-ascii?Q?V2KTOXnib7y2SPcMAaNOGKXdZ/FNIaCYUEpdyjBv9nDAewBtuxBmRsReYz/T?=
 =?us-ascii?Q?+RSyrO3C69Q+LN4iToOCMdLxl6HNNvTZsmFSKpbRxlV009x8wQ18bs72C82Z?=
 =?us-ascii?Q?dnZm3bAfcqVkJYk/WokhT/F3Cyv0zwLvO5z4PfAnydTRLUnPJ5t56UxgrHP0?=
 =?us-ascii?Q?owMr1E8OcVjCTMQUgP3IpUOs35Ptan52h12LNT1jFdRI3WjxhWr7Zpw3BPYO?=
 =?us-ascii?Q?XaVRi1n8v+iUv25STu2Zx4DKNm30LjBKJnhMdXGmtC29JaRKCAR9bkrxVGPj?=
 =?us-ascii?Q?yH2F+/YUSD2dogvDSsb8az4X4vzbrUgIR6VxBEJ1O587mbHJOiRRlB68V0VT?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fecdebf8-8894-4137-5be1-08dda573f0dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 03:32:33.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGHY3hRCuGmwy7l45AinO0diTis3+loLF4whrRkWvcuytuZP5A1t9nX6qHje7ukSULObVafqDICkvoGKC3SJB8k2xGYb144ou1IKblIdSzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

The acpi-einj conversion to faux_device_create() leads to a noisy error
message when the error injection facility is disabled. Quiet the error as
CXL error injection via ACPI expects the module to stay loaded even if the
error injection facility is disabled.

This situation arose because CXL knows proper kernel named objects to
trigger errors against, but acpi-einj knows how to perform the error
injection. The injection mechanism is shared with non-CXL use cases. The
result is CXL now has a module dependency on einj-core.ko, and init/probe
failures are handled at runtime.

Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/faux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 934da77ca48b..f5fbda0a9a44 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -170,7 +170,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	 * successful is almost impossible to determine by the caller.
 	 */
 	if (!dev->driver) {
-		dev_err(dev, "probe did not succeed, tearing down the device\n");
+		dev_dbg(dev, "probe did not succeed, tearing down the device\n");
 		faux_device_destroy(faux_dev);
 		faux_dev = NULL;
 	}
-- 
2.49.0


