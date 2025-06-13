Return-Path: <linux-acpi+bounces-14361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3FAD93AE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4946A1894415
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6412135DE;
	Fri, 13 Jun 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8NyYXxs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976742E11B5;
	Fri, 13 Jun 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835235; cv=fail; b=R+QPOpefpk5jivpb+sdRu5mwDWbrY51VRvz8OQARw+AD60+ak1hehypP2+LntJIWU1XK4qJQcuOSVqr+pSMNfURuT1P5LSj5xuyAM5gd7KpZuEiLr5JnXzCR5BnsEXvk6FlJn0zOPADJb/eoGS944N7Kz94aQKfkZc1PpHyrQVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835235; c=relaxed/simple;
	bh=0RupnLxdmaclh+iVOmL0pOKRy8sQz2VFB2DFXJBG0mk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IB9ibH7+rh9fx0R9yK71Av16POraK9LSbG4I/UBI/9y6B45lnU6JI+h3YFgkbJtGzqbnB/X/y5cDG77QXrW/nIbYHZw3sWDh83+fNn87WmzMyAFKcsasIhSgv1Qi0AyDzYZW3PjKjy7ARzWNYGhIrzA5hTjtiC235LSI/K/2euA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8NyYXxs; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749835234; x=1781371234;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=0RupnLxdmaclh+iVOmL0pOKRy8sQz2VFB2DFXJBG0mk=;
  b=Z8NyYXxsaytWHxGQAOY2RjUjoU89S97T6SkzIGrpxTOyiFeISSpCUGKW
   LanlLQ4L1WwChRyuKw73XbhbySGOLEquZ+TEK80UDzqD/63xEHTCLflpf
   ZAii+1x2B+ycsAojvtnFZg0Sj+aFuOUSCwLje7DeQ3atYdPTbUdRRVh3B
   IRTY8AFYnwZfjTZxWy/rFSUAO4ZbXeyq513DkimkfijKiSpxhFcR0AF/D
   P6DofvKn8/76Kvgno97GJTcLKquzogHblrE2JZoxs/bEytUZ82JhzPLhY
   n4+8B5nRzhDBB/GJxYhu824icGoF2p2m0eWkkBe9EBVleG3V4rvG8XxsX
   w==;
X-CSE-ConnectionGUID: hooua/zGQh22LBGuU/ZY1w==
X-CSE-MsgGUID: DI8EXgzYSVeMh1+vXWH/6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="39668880"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="39668880"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:20:32 -0700
X-CSE-ConnectionGUID: F/M+H99aSUCBNGctgNOGpw==
X-CSE-MsgGUID: ngkT/lbUS+2oc3dZqTuzEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="151694187"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:20:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:20:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 10:20:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufzsNwx54E2B6m9wgvs+upbSjvIE5v1FarctY70ERRPax8xJluAc9Ob+t+nKGOdVNTpGMjr5sEtqSI2DnwkC0TsAVtWvrit3e1YIdCq/W6Rvd81nxEGnMVXZijLR6ujiDSbjSYRHPj9HG7CY47FWAhYm/3xWxdeXlovlqhtXQdpwsLHh2URo5I2lX6DBfDWP7rSXGjo7BhDDlzcz+13WlG8PeRZaWaf5+zU+tzlFJBsztZOeAf+33EqoIxW02kguDPbVw4gYYEE8PbQXgaFDSvuI/yVhyTcdOjYuRy0Wvl4bvx9FMWjZKDciXpmcPcs6qJgXv8gTGY/VPf91JXOI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb8cwxCGQGye2WOHrFIl9ptwHC4LgA6FzyWaQKPbC0E=;
 b=Hb68ewsMBhkNEOJu/UWlvVzbn30eeZojQQHd2YCTPNDPbcZKe5Lqf/IOcPzqPIC6XEl0yu6Vo3cI0T23zXlMlDKdcFaS52UxKhq8W1y2HRnvn9sa7oln4LtXiDmO1AR/FKG689xCxk9PSIxvTKDJNfD43OAbCYXtba99TYuDGuP8jbrrL85N+ziBlfwDadrJsY+VlqhyU6AgCGkV/wsGJt4otcNFDQ22ik2qWPHpuuU7t4fikhqoQMxMB2e0HQdMEu/bRWlcqxvaCd5ttX+ZbJzmsRMc1z4nhwbEAzoRT4iqsfwZltzM89hxuGIF3U2U9qyXE7L8EeOFdxhvNLPqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW4PR11MB7007.namprd11.prod.outlook.com
 (2603:10b6:303:22c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Fri, 13 Jun
 2025 17:20:28 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 17:20:28 +0000
Date: Fri, 13 Jun 2025 12:21:36 -0500
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
Subject: Re: [PATCH v9 5/7] ACPI: APEI: EINJ: Create debugfs files to enter
 device id and syndrome
Message-ID: <684c5e20b406a_224b7e2947b@iweiny-mobl.notmuch>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-6-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-6-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW4PR11MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 297b1fe0-8c8a-490a-08b2-08ddaa9e9768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1mGFwhl5tGV6Mvp69xzC8iS5ASKiXu6d4LdIQQBrrbIJRYuz5TO/m5tobcXm?=
 =?us-ascii?Q?B0ws6O7B5UpPebY+J1A290eeYpzDvFrQVQPsDmbLAcZG38r9Ex6q9t3bcpxj?=
 =?us-ascii?Q?TjyTrzg7UmKgAZbQ87LRQANvpWfWdoL+or8XJljPa2+12UovevSwU9MSn6n0?=
 =?us-ascii?Q?46PpljIC47sYhDqXuAo440i+mL/zkvYdB866GlQqL/DAi9Bo61bmw1uGsbOZ?=
 =?us-ascii?Q?IRWnoRsJ0roFAZVqMYhqR9lAfzG0qD0RI0XV0jDdkiB8Bo2dt9qhq96njqdx?=
 =?us-ascii?Q?4aVZjXLeeISkXsuf/OJxjp0TqDMJh8YqtLFUeRX30u3tU5O0VNuJBtDWqgAP?=
 =?us-ascii?Q?EpQfJksV5lTdL18RX0FAv+BZXr3ZiQN4S4LXzweBA46EjyBeKM8Z3lwDPBwh?=
 =?us-ascii?Q?+J/YXm+W3wFz8zNsHXjRUU+/oEHi0hVjXLUshP/BbL2wSTmXXUM/HCELyLed?=
 =?us-ascii?Q?Qnzzak7gGi9GuRMfFb3mDNzNcaDCKBHTNG3afJdUWOcdKpkL5oh4vZdSSHkd?=
 =?us-ascii?Q?XoIxzipMCunYuIIJQ2kmLalnErILq+KL09lytAx0tDFuEXixBCucciTUXtuJ?=
 =?us-ascii?Q?vFpV73dG8Wu+dWmoAngRAID+onXfet0X8BYFn48gvys56Mf70XQI2M3SP5PW?=
 =?us-ascii?Q?OZ2rMfltV9jjr7/LabOtoYKvJmqeTUZcEg+YcV7R5i0onBCcVfzcWON+gZ30?=
 =?us-ascii?Q?n8jZsSLiYmrRBPMnrMzH7PmjpeHTvQPFvSOvTcCvfDIrjRs/tn6re/trEXgx?=
 =?us-ascii?Q?o8ml7FQRtIblvrTXNQcmpuYCZOiOjLpAZlyDW3BQ126pcBfEy/FUFeNhYUZZ?=
 =?us-ascii?Q?7suTtH/j2bB2oh+opuHm3xrARB0R4ofzb3cHkd9HdycsztWlHYhxWjyhdYwW?=
 =?us-ascii?Q?avHK6cfuJNLG7Fs1/MXkmOSySQwQfeF8mBptpHyigtfy2byoxQ9wF1pjpl1M?=
 =?us-ascii?Q?s55hXJtJu4HBo4DXqCyevnNHtucuwxQTuKaUzZFiYZC9Z2BzxJHxTUhcMipE?=
 =?us-ascii?Q?G3DOiAR0/jX6GWRCRzrSPa7LtQM2/HoudeCjIIYA3yJujj72zo25NM7w7/RN?=
 =?us-ascii?Q?G8efkpZF3862NtYvKpce1GR41hWyvXSzSjz6pU8YcIb9mDTTKXtUZeATXcdA?=
 =?us-ascii?Q?/ljxCx7s0InV9RFD5GYGcLiIEq3mb7uDaSKR8znpEeaeGP+W/eflq63TXEj5?=
 =?us-ascii?Q?QNhQgPY80IckXWh+IrIZn8PxBNZhcxegsfgBTP5aTs+AgbTmQKGiuQMImR7L?=
 =?us-ascii?Q?1m78GUWwjvxV49Omaqb99yQ+IkfXt6DG1b+QkVsv30PsW3UdRSKfnQlVkI2C?=
 =?us-ascii?Q?RlHUvMux3grjEfnmRwxlx+R7TbLjk20b7f0thsc4EJf1zFyrmIdHcCf1rJHo?=
 =?us-ascii?Q?NLGr2niQo6iCWfJ1hxsIldqQ0IEVORqw5yJdeZvNkG9kdp1EsHh5tF4YoAWA?=
 =?us-ascii?Q?sVbAvOtdo4mUpOkGf7NYabJOYWAyV70cXyP/CTztSNb6MyfeHGtRmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0xkqZbeiKPFEp8Cu+tzg0QFO4gJIO6U6SJPtNa6SqO4vAQQso4zY7AScUzWJ?=
 =?us-ascii?Q?MNr/7f4vCvhMYUS4xzk4zCHwSXFiee5RYbTSOQyicbRf66ehOBfb3ET0wGZ2?=
 =?us-ascii?Q?na1qXz2HTvdY7yw9jlbSqRR+U5meUi7mE2L2VKvYa1llvO2bwSxa9dbbe73Z?=
 =?us-ascii?Q?miZLutPzPOBadINAh15RDKVLGOdJChLf/bJq5CMmCAbX4rroraRLRixBcs88?=
 =?us-ascii?Q?je/12shWaTR7M1iML4gwMu7aYHAD0fCjSmACxEP4dyS5uXrypXN9AkxofCUP?=
 =?us-ascii?Q?wSNJV1yNu2VWtrsEZl+ofwsnLf2Y0PplkhFWnFSY/UHPFYAscrthT30Ssvgu?=
 =?us-ascii?Q?P9FBcschbKdJPe3ZUJNEkp9I1zgyxZKLOzlC5LSDK0/A5R7ceaDsFkhbS1yM?=
 =?us-ascii?Q?TuxfoutVuHr7pKpJ9dvyThUGx4AE3lNOA695QYR9OjsilYvv4UE459e5dnMi?=
 =?us-ascii?Q?85Ccy9t42S6XSfcbLJuXNEyhMcyN2eSzIm5XmkGi3swo8qEk+CV1RmdjqaLK?=
 =?us-ascii?Q?kU9795pemZi1EG+n5kcVdfvZYogGjyibXGf1X9osi+HRLgqOIVVvFcOdXBRH?=
 =?us-ascii?Q?KLGr0LF7pdeSrE/E/ed4wzSTxpIzW+4C1wyN+fggwNS0WCmYS2gy89Akf5+3?=
 =?us-ascii?Q?NrKg2JjtYZQZCHvUaN5wG1sAkspkyuTKLbNXkHXyEeEgIT7NcK3YBZTGmc86?=
 =?us-ascii?Q?zhf8sWND5ulbxz4R9edr1Rg4F12rVIEEbGsPBC3jyNHrCwqLHQpemqydTg80?=
 =?us-ascii?Q?AjJzL0fYJgse3qUbBdkcbAZNNRS1lhTO038BQUSvJEfhlfUO8KKVFi+R7v2H?=
 =?us-ascii?Q?DHOg1gbqYxuNlf+jpQr8lfx35/c103YDoplLu5CocY/1tbj4S6bvyJTvcBaQ?=
 =?us-ascii?Q?dQy/7sK8e6DrvLh6XKYuL9LMdES5XQ0ZaPoe4+zMuOtd2+0H/jrhKsiaDyDL?=
 =?us-ascii?Q?xgojEeY+v3VQhMD+WJb5++nTVjyVX/rwjUkEQOa+YtVrRdQVv6njlrkpjnqj?=
 =?us-ascii?Q?vPf1aCP94hUOJc4iZRPWh+1TTEgg220JIrLaN7/BVeMK69hgyBWGmUeEAmkt?=
 =?us-ascii?Q?ZtAk7GEdAPSEcSmhbxFVW4iInWjKEHeFs3UK7hBk7ueiboRb1ynGpaohC0wk?=
 =?us-ascii?Q?tVXsABl19e1Tnp3IS+KxfGsVGT26cjwl6TuObNTXdYNmOqoZRDJCnDgy8DqN?=
 =?us-ascii?Q?XaV/IU63blxEmr/1W4J66FQ33bBjZfaIWgkkOXuLRk0hzFZxcujnGSIJjcBY?=
 =?us-ascii?Q?Mlz8zWcLkgnVmdeibOmLTs3JIXWUA+OE6Svz7MIMZ90ABLfRHBsWV3mxdqwM?=
 =?us-ascii?Q?N/EVFeuKy0+lwDH4lIdJuXGkadOL+ObLuUaiybsMI2Ky1jFIND23bHF2omaC?=
 =?us-ascii?Q?JcpgSer+cgk1e7CdHIpGRkT5HfOYWU/iIM/Ha542iwbVOXmJ+NZeTLU8rxws?=
 =?us-ascii?Q?oAi1/Ea+cDanSYzaniF6LBakRs3BXUiSPC2ASxMwTOBKPQPSJfISAwP1AGB4?=
 =?us-ascii?Q?bc6fJCV4Vzf4scznki+y7HHt/uiSyMYBkyZhkKrmqmT0rnW+i/bUo+FHycWe?=
 =?us-ascii?Q?NkyZzw/AIbHS2xubMSdnF/4DF7FiuVT9in4NSVI3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 297b1fe0-8c8a-490a-08b2-08ddaa9e9768
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:20:27.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VX6v5wDFcEnvLDp/jqKLG6AHuKHqNeiPBp1JyDS0ECq90Oi+GZSCwGaOsuK5fs6CG3y7RjKlybC5+J/zlE+8eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> EINJv2 allows users to inject multiple errors at the same time by
> specifying the device id and syndrome bits for each error in a flex
> array.
> 
> Create files in the einj debugfs directory to enter data for each
> device id and syndrome value. Note that the specification says these
> are 128-bit little-endian values. Linux doesn't have a handy helper
> to manage objects of this type.

I do wonder if it would be better to make 128 bit versions in debugfs.
Because the next person to need them is unlikely to know they exist
here...

That said this looks fine for now.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

