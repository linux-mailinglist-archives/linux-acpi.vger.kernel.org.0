Return-Path: <linux-acpi+bounces-169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34787AF650
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 85C39281625
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEEE4A52B
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:31:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A04A52D
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 22:14:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2493D0;
	Tue, 26 Sep 2023 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766482; x=1727302482;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=40ktvuTyli1b/XSnzu06m+oPFBOuzJNWaRiDGdKNZuA=;
  b=Bcqhh6Jn1qd2+NGMg+7n5dpyD9qYkYWAj8827xmdCOI0ZFPhirr5CtMz
   Owsg1eQYsuEoosSWaInZkLdXGkDPsPRxUYvDTAnlo2w2q8it8I9anhT4k
   jyr2tTUyG/gd91EFhXzj0HnC81DCTOsRpYIELGotXQC/2om2pCPt+yHto
   aSSerc53zOfACVcquL3zuxzLI4PbwnTMKRP7Tx5cBeeOcf7NsQbzlLfu5
   bmuwLfDdCi1NcQ97VdTjf7yapHDX1YQ2Rh2SbCr4iAlCre4joKYk0yMOf
   KjGs05OH3Vi1aIacAxafvM21O3jd70KYBvKIDsyrd5gYN+qsvdBtBnOBl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385526027"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385526027"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="305327"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:36:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:36:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:36:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFMPuNwnd/avMY3d9jXvQE9z/97WBO0ALRllCVOA/OPt2y3DAswXtkw8ZojvCYjJ28pQFjekh0/QD1j7X92hxvKBF079m3WzjhHFbdNOzBHWD5RryKinz0kLm45kAPF2jVJFOtPUBgtVU9+snfxtKldwTyBnTpPOVURg3crYOC3+nMopKgTBKUuQdZBmOiLHGg8lYY1la7SZCYAqwCeW0xPqf5LHla9Ka9uq+AbWXQrjlr4TZwog0txB9k5OVYlNQVq7OHvR0V8s3G/WZV45+8E1I8bM+kQStNcWtBE2EyN/pKD0c3en6v3sRxhwYndOihgVnAHTwFSaGoHZn9xQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSxS/2nVHaVfmeVXe6IzUeyNgfNX5GI4HbOY4vsGa2E=;
 b=EhD+8Z5u6WcTnxsbwIR2n1bPWS2ASO0QhCmFdVgBpMdyGadZlAIXYrAhoiLIz3OiC0uwS2eAhyln3PBMiZXX2/R3SNs/XpXhaKcFuaHl19y1G9PvIK15a1luu1UDi58OI1g8rMBKoBcjVIVOF+dbesPgXG1mNnYp3XOZqgA6GnguIQImIIID+H0zH8LaF3pfxO471yW/paRZoFyC6G++Vj4k3VtLLvCDHS0cBKyWSx3pZccXMbtG4fnJwOA46DXfxngQJ7GNQzxp/nUXYJ2P2g8UBhgao3FQPzgPEaKDsWr57oIfmRsfobqK4THKnb+pxEx3Y1AImOmf5zxcSEjoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:36:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 21:36:41 +0000
Date: Tue, 26 Sep 2023 14:36:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <rafael@kernel.org>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
	<yazen.ghannam@amd.com>
Subject: RE: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Message-ID: <65134ee675c1c_bf9129451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 5402bc56-b49c-4708-6e29-08dbbed8ac15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skACMdrkVA937gAlsw6V49HB5H00zQLsk/AJAwihuuB+6m72wo3NLFjE/2hCpgbyzMeAM7bpVAK6I6zPcQAO77OOAgv0lD5aUXe/nC28tB1tP2tE5JBjt0zp0TAvsBYt5Js5l6AjtDbMqRz8EZTtQfcDgEsjJ6Z/byVo2r8C4LoTkHnXmwdzFImcbJ1jXhjJMyd/7vl+LcO6oTMIw+gqsn7VCoozlNDPDMJuPQ9bFG3OEPHoxq0RlzRU0BrE4r9rizDRY9dPjGsWfCVj2Y8PHvD0AYarFrMpzsYIzmKTo+O4ObAXmATvpaD7URc5rACW3wAqvepYCxhyFic1QOt+U1IwSr3J8axxN8PCCZQQzGsI0OiHxLDsmeaYM5MqWrNXwCyl/DkaeMZoAQk6S0pK9BYlOyK3Xk5w1qKR9JnvEh3ZiLyDV9UFVN013xIZ2MkszfJMcLl9TEmQpIze829KqCexipMClgFfaaYk5LU2tTtCPIKDDoY/YTUUhQJKcEHGuukl9hlvN5KneaptE2OBJuXyYd5nwwEzFT5A7amWQu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(9686003)(6512007)(316002)(66946007)(2906002)(66476007)(66556008)(41300700001)(4326008)(8676002)(8936002)(478600001)(6666004)(5660300002)(38100700002)(6506007)(83380400001)(966005)(26005)(66899024)(6486002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMqwmUgiRUB8KBUk/6kVDKE2elXP1iFm8QoFhECQH2Aj86sImw7rLytbuo2k?=
 =?us-ascii?Q?B8KGjLQ+zt15VfkKi2uHgJslWhBH3AZxoO7sjPXeuvQgxE6GaKGa+v1Dn34t?=
 =?us-ascii?Q?bNw00B7TFdvlxe1LVQfSc0SZfIrJzU/Ew+3oekf5jAE6wGCz62ecp8qMTdI5?=
 =?us-ascii?Q?G79Mxp0sRBa9ZLRcFuQAQe4b2rrTL6wj/iqPQMY82ptl9QAIYCyaH0phXS9f?=
 =?us-ascii?Q?jAXIm+pAFj+73QLM0WyUmdcnhGNo+Fy7GmsOJyKMJNTV8u8Cl4EZahwns8E+?=
 =?us-ascii?Q?cFyalCNTFb4ka5L3k11FTo61pwaLAtiPp4/1On9uypd31CZGDCNNYKm8Worq?=
 =?us-ascii?Q?CCcGtxoL9/elXnkfPI3TlLCAphIHyWKCq/vEj0qRCPpnMYfslJGFqV0HB7YS?=
 =?us-ascii?Q?tLS438lQ0H2lui6BQV8hrJTXexMO6Fk/xgyZ+oNdNOUojAWzojV1Ljsdx688?=
 =?us-ascii?Q?3CJJL54VuR6kdq+kRx6W8JOjK+5Y6gnZfnr2KQZaWElDDJLUy9wLeGWyblyg?=
 =?us-ascii?Q?Nnu8ecLLE+dpwwvkmzFv+WNhwhXLK/6WWidKGkzGd4cqUOnXcBvdK0IzsTo6?=
 =?us-ascii?Q?KMbF/bG4O+37X4K0Roc+sXAasGzA4zK6ClscSu+nvLZVCnWfafpxjKrSMMQM?=
 =?us-ascii?Q?w3OoDfrGPFdg0R+EuryTgANYcb0rcziYHdmFubXaLHrKVsUsq+GDv1DzZkz/?=
 =?us-ascii?Q?1LbuXhJWqT810O4VKYyHTpPkGrRDZjxQB7eu4CxHwfhoL1Tm4XNd7DSwVhMM?=
 =?us-ascii?Q?5JR0zsHV/9sFC5jnPsduBdG/PhV7FG34SWNT+xyw+6/v8arLxCUABzO0YC5n?=
 =?us-ascii?Q?65bO9rr5lOrLEFhH5+1mqhiAaQD4PRf75xTiSvHyYPTKBcPE4Ti7YOEnGTdi?=
 =?us-ascii?Q?Eo6gxRRSJH1K4DNUln+djKAziVv08w0nRUpHvUPmYqzpBCwCxLT/3Q9j72+x?=
 =?us-ascii?Q?R88h0H+0YbQzp8zLqtLsuUJjFBsBxlkHodIvfMMbmJxEMK8nRdoQA4IPAzr2?=
 =?us-ascii?Q?GRKQvPhe8PmaiLbKJiVXzYBS/JxneIEF3/cJrPP2yLAvYVVIT43JXfc8l/uq?=
 =?us-ascii?Q?VaR/GXsQeYxPV1XXGfcZe0Njwc+UEexmUmk7kwPKPv/d9yd2X9fiQxsAWthR?=
 =?us-ascii?Q?bMoELQwY2SvsjMHxBZnMtsa0WBq4DCvA92BMGGcVamdVxZO166ZwrYRKueVg?=
 =?us-ascii?Q?d44Xc8Qj8q8jfXIs5xwv+TZR9U8Dy3iaphaU5HEe1LunBGAbGlNQ5XbSM92r?=
 =?us-ascii?Q?195RW7w71+rao9C4cF8M/3i4zDaINzTWk+RMGzpgqssOZfwbj5vBOVspfrf6?=
 =?us-ascii?Q?czHeQnfKclck3LxOYm6kVwOLzmOey7TUSZ/ypmYNo5CNaf1FO3/Nq/7l12so?=
 =?us-ascii?Q?NQBQrNR5Mhlp0v9P9yypbO2SiQHAFmq3Y1DNy252kQ4Rw6nhOxGMT2lYW6FD?=
 =?us-ascii?Q?HTBm4K0OlgWgTkitu/bbXI3LEMmm/4Hzv9WgV300abuyF6xpi3GVX4CRmCvO?=
 =?us-ascii?Q?Nf/mjqUsG3CRf6eYQ9STU5OIv41YPAab4v3caTMGf+0NS6u0lZSNcjtjr4uH?=
 =?us-ascii?Q?t6BiO8WrWlHKLxmqoODrk0MtZiEkH6bXRlAZgudmhKFAIf3mf9bEYY0RZngq?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5402bc56-b49c-4708-6e29-08dbbed8ac15
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:36:41.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5coksY89N10zZmowd62bZVYmTCmJlTxIJ/Aq8/yy0igdMgSkIR2sRj26WIrdvsFLXKKkM3AFTxkD/t4D3MuCgrU7PBxmtERvHPAI826WZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ben Cheatham wrote:
> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
> downstream ports and not physical (normal/persistent) memory, these
> error types are not currently  allowed through the memory range
> validation done by the EINJ driver.
> 
> The MMIO address of a CXL 1.1 downstream port can be found in the
> cxl_rcrb_addr file in the corresponding dport directory under
> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
> procedure as a memory error type, but with param1 set to the
> downstream port MMIO address.
> 
> Example usage:
> $ cd /sys/kernel/debug/apei/einj
> $ cat available_error_type
>     0x00000008      Memory Correctable
>     0x00000010      Memory Uncorrectable non-fatal
>     0x00000020      Memory Uncorrectable fatal
>     0x00000040      PCI Express Correctable
>     0x00000080      PCI Express Uncorrectable non-fatal
>     0x00000100      PCI Express Uncorrectable fatal
>     0x00008000      CXL.mem Protocol Correctable
>     0x00020000      CXL.mem Protocol Uncorrectable fatal
> $ echo 0x8000 > error_type
> $ echo 0xfffffffffffff000 > param2
> $ echo 0x2 > flags
> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> 0xb2f00000
> $ echo 0xb2f00000 > param1
> $ echo 1 > error_inject

I have the same reaction to this as I did before:

http://lore.kernel.org/r/647817212bcf1_e067a2945@dwillia2-xfh.jf.intel.com.notmuch

Why is per-port error injection being driven from this legacy global
interface where userspace needs to take information from sysfs and walk
it over to this other interface? Especially since "rcrb" is an
implementation detail that will be invalidated with CXL VH topologies?

What I would like to see, since this is a new capability with no need to
be beholden to legacy is to disaggregate the interface to be per-port.

For example:

/sys/kernel/debug/cxl/$mem/{inject,clear}_poison is already established
for memory device poison injection. Why not add something like:

/sys/kernel/debug/cxl/$port/einj_{type,inject}

For triggering errors by the CXL subsystem device name, and unburden
userspace from needing to deal in magic numbers.

