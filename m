Return-Path: <linux-acpi+bounces-19597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F8CC01FE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 23:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21B8301A199
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0120299928;
	Mon, 15 Dec 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT9VUgL/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD76270ED7;
	Mon, 15 Dec 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765838162; cv=fail; b=BE43WsYjqyCTlwNM86Fxjrxmca2s4Gidi37jY5I5pNEait6C2r9a/+T1vMUDO2PvkZ2tfu9udk/5mCYTDPUEfElGi+mT6kqEMjmUQWZohOL5Cszgp5UrwIQcjD2YWIKt02h5Md/vnu3yEMy2dClCniZ20vtSAj7KhMZL2Qo8n/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765838162; c=relaxed/simple;
	bh=sb8N97dHKRdqoIy/AqqZHZ79S2h/Bg/5sA+CcbHajXA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQDbsiLiBKCHMi7yKfmWANQrSI0Ho+1vgeCCm1UZaD4L0VVo0H9s9b+xnr86kZbM/fjdpeQTxno3kamjNmfFX7wCcDqjvz4LagG0JsddMOFCmu0f+rNbyHW4zv3P/kgcihTvKKio2woFY52790hL61lFP1WMurX9cghuGh2ma4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT9VUgL/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765838161; x=1797374161;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sb8N97dHKRdqoIy/AqqZHZ79S2h/Bg/5sA+CcbHajXA=;
  b=jT9VUgL/Xd24Zdvlzmo52bL2sGjJ6l80KX7OAfHrSP6Wa+Efb5LgOAHt
   YSv+iacOOtDR87VZZ5u7LKAwXyHxxhWekKiTer5ZkxBl1X1Tznh2/A1Kj
   sT1/Z6Gbtg3DTaVU94xHAINATySKnWvHPYdVWjnOtPm2DbVZE+kioV5TC
   vVwq1Zwj6zPw4ZFYPslkEb5dj2wP0khkM/p9yLKx58fEnRpE9A6/Cf8RY
   OsLS4mf7zI+BpoWnuEEsRTI+Rs6oLaSwHRtnnjMHe5j5ZfjUcqFzTPnpO
   Nx80Dm62VkP0pPtaAiAFwfyTHWn7k3djDzg5Lp+91Xk9+JngipbRkr6eh
   w==;
X-CSE-ConnectionGUID: cnWeiSV0Q7K5mMbqLnBvwQ==
X-CSE-MsgGUID: ughch0bJQ72w0FYX9+DiQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="85162304"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="85162304"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 14:36:00 -0800
X-CSE-ConnectionGUID: YU0sb5E0RKSOycSZx0KX2w==
X-CSE-MsgGUID: sC2mBJ6HREyIKLkq1hdaWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="202762684"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 14:36:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 14:35:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 14:35:59 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 14:35:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaGKPGSlICWOXFBd48GNVSlLuFNqUeqznPEWDjZcJJPCbBVWmaHQNlItykX2jXHq1+qLzXkurvbq9EOYSFOsKFgAlxZirWdF59A9aQU7U+Agp7RtFGWBIQmw9NPUS6zfILf1sKG+fdHcmZReWiGIIMpQD8D8t7DGUMKTkwShe2M7tjChiV+g4xXD6SAA0N+ZlEHya86bN/8KUTov/Ds5Wb8CL51/DUkd0YpyjeynIcfZU7f72ti9kuO73oqzPFY82nIvspizVLgHcLz3cwpSbu7FU7hc+0Z+gnt0jwHC/Gsbh2oW4OXayQralfmJEbWAn72xEeoJdYK8GJn6tuIQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcHGrrGt5iPjKMn4YcDTLm4X2cQDKzDRw5zi++N+Hfo=;
 b=YYniror5sCukYGkWAPXlqRa4QrSrSRdjhwLo9w12fPAgowkIYQR+dnfqw+c0Q19MJ/Z46eA6YHbGuypDhl1vhZ0oDmzmQUI+JZrr4sL2x8RCLouQXPT9nbjdmo53+0RcytiNcDhXyWzcfibTRgMyVh0tfef4qxKIHmSURu28tli4RBoZLye079pCf76uKu7y5d+mam0ml1cwiMm4WQszefwP6DFtBroKubHDdFk0DUMr7gjvlHtFFCohjE66bY+alHeuKSG1/AYxs99Bsv4NxWWeePcb4GTCUq/o3chrORhasq0IICLtgCp7T1fFk6UkliUklukwul5UQ2sgppZN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BL3PR11MB6459.namprd11.prod.outlook.com
 (2603:10b6:208:3be::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 22:35:56 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 22:35:56 +0000
Date: Mon, 15 Dec 2025 16:38:40 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3] ACPI: NFIT: core: Convert the driver to a platform one
Message-ID: <69408df0c974d_10c0751008f@iweiny-mobl.notmuch>
References: <5066996.31r3eYUQgx@rafael.j.wysocki>
 <693c9f628c7fc_c04a91001f@iweiny-mobl.notmuch>
 <12798648.O9o76ZdvQC@rafael.j.wysocki>
 <6221453.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6221453.lOV4Wx5bFT@rafael.j.wysocki>
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BL3PR11MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: ea330bc8-1aff-40a0-d0d3-08de3c2a500b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oIK9J8Tsa3u3dSnO1hunkzoKVf/SYa3apRRB1kdzFTIRpJLaHcQLVMPnGEja?=
 =?us-ascii?Q?HQJdQDI6w3pcrKTE4sVdDa7ibRvgs9VlpDQLagcjstFa07aCD5C/uMv0tm5F?=
 =?us-ascii?Q?iVe3c/NTr8cKAhCuBZZpnobi12DoeX1ZIfLqmdjVWI2E8H9Y6VOE8G/qGrtV?=
 =?us-ascii?Q?RM5rDZtpzwxTuL0mlpn5qVV12nJKzHct+fQWK4ucjI90OUEraDA9+vJgh4Ik?=
 =?us-ascii?Q?rX9pLcxQMLVb5+9o1gtGCsun0iF29ey6ehMyj+FbNAVjsps/z1WF/DjYZ3fH?=
 =?us-ascii?Q?5qIBplSMXsnRkMQG3H5znoBc+ik73WFCbcUYX3XN69KJOI+QvE2VPxEXajha?=
 =?us-ascii?Q?+FEjlffC8RV9tBSO7TmLqlZEzbOwiZrgF6zd6ieQ1Ru9jxGVAe48W6xhNdZJ?=
 =?us-ascii?Q?IF+umvjwa+5rlaL4L+UmUi4rCvxizeg5Lg6+wR8dAAAZVDGw4KbLX7R1Hbvx?=
 =?us-ascii?Q?8BNGQMpUOo0QgJt3SASim6+yfD1F1wW3yeM+Hk0l5S+aGTLgTFXJqL/P/wcK?=
 =?us-ascii?Q?ejwMsy8Hk/aWzj6FJ0PnWQ45QGbV5hWl9f1J0kL0GXZS1QdRMhsnXML/p2A+?=
 =?us-ascii?Q?/a1EKc7FlFbEwmESM/WMgNcnC9F3EmuNDYRrAE0BWVCfo0vPJ2I1oEW9CqG1?=
 =?us-ascii?Q?0PJVCpABnB3nklFXRjIqTfPpewOjAzSKuecNzrgtw6ErDGkukLvraDyxuxmZ?=
 =?us-ascii?Q?HiIC9zQu+SN/gPV8T763oZs31pdbGA3iTg7AxKwkaaCSE2K7fsjPOvd40Viu?=
 =?us-ascii?Q?GJSEta8YmpjHGJW9vPlkjD5xiH/Qp8xNJ+8JVqpmnwBz+fYJgZUkLoOxNNHI?=
 =?us-ascii?Q?K+W09R6prsQaCNIUk37ultFqmGKQ/VztQ0RJe55CWBEXfT/bM9BE7SsXuiDO?=
 =?us-ascii?Q?EXNhzy1gNnzcYfU7S0xZa8avKQj1jFbZy1KBQYwuTVH942vtRQlFMDrCsbuO?=
 =?us-ascii?Q?9XYcUfDYYkhpB5DUEKmcfWPHq4SxgO9sXogC/C2YCtFbPTXXdjtgY2ivTIyi?=
 =?us-ascii?Q?VHLzN/f7pPdUseonm3ib3UmpPKh2VayZNyTZUNvkfKgUuOf4zPa8t9v+9UUD?=
 =?us-ascii?Q?ZNHwUUzLA+966mwJlPp4pdfWn6H6YFyvLG5PELH2mJ8k3Uz2Wo4Q866VuAFI?=
 =?us-ascii?Q?6WgyN8ldrlz8k3ocVia4eAA+esabhvqQ1wwkMyela10epeQmbUqZ6tTuB1pJ?=
 =?us-ascii?Q?aaYP3Es7vdOSeWHGqvWVPHJiIbjjnwJ+WDrl8Go2M6Fl+QjOHOeH7C3ruPln?=
 =?us-ascii?Q?EynpxKxHMkZ7ZbXpgDIPaePpstPJkdcAZPF6iN26J65QjgcMkTRvk+Bkkcy+?=
 =?us-ascii?Q?A0BOcBBZzvI05Gc6ZfC5bK+vg7IFUoCH4e9MSHZTLm9qI9wf6g5ztB8KOAME?=
 =?us-ascii?Q?M4cvZUd6fmxeYOfDP3sPjdq1tkTsFcKC9qDzrXqycDvyByT6x1T4CBKX8drd?=
 =?us-ascii?Q?uDH6ADW45I0xkpdi3xjaY/d+23L+C3kG0pDmQAvRwYhYoXO8gg5qew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BrhBhDbHMqH/qWAcIcCjveUeMjdz8RAXVSOaKApSdj62Cid6ObEYZep2Z/fY?=
 =?us-ascii?Q?OBXwyuJ3om3CtuDCy4reSFtS7PmMI7vx4s5X1asefThq6r7VZzRRuOcut9WC?=
 =?us-ascii?Q?cHDHGuQ4w7raa3s7H/oJLb2HcAclTnUm0PkSyRd1gX6gYC86n1bfOlGCRWCX?=
 =?us-ascii?Q?+/F0SD6kzj0f987G55m/YD+/Ym5t5bssAux/phn3q4ZBNQ/689C5MzTyKsbJ?=
 =?us-ascii?Q?vh+MkhR1v07WgU+NnoU9MbxUIu0vC+cM7uuwKR7Aw3P36Am4G7lgs9RIcQPO?=
 =?us-ascii?Q?qjhFn+IoJhoFzafzVu8UZsRoIr1i3iy1GRBP6JClizl4/o9UMzB0Tz1z0581?=
 =?us-ascii?Q?9Qg61cb5CDlUNMd854iyxA8FWi8i4PctUthWxzPaTPm5ri4NAJJajLasI/JX?=
 =?us-ascii?Q?zEVBbgAsFZe9uHg5WrXx0OvBUnLrYRtx1nkuUHq001hUxSOx11Wkjgs0eXPL?=
 =?us-ascii?Q?QHA0RSfKfRp3Xu+hRAp+Vx0ImpwGp9zmo6+XiqNjDHn6Jzmab1SWVksveFVd?=
 =?us-ascii?Q?OKmlTIUrODee7T/0qwaP3dM3q4hAs5SXjZ873WcJMsHw05O1o0OXFoqbeh18?=
 =?us-ascii?Q?rVnQSfyQnVJo4O/4YpT10cLLLro7miNSZyNT6FphmYqGiUsFkbKHG404oRx9?=
 =?us-ascii?Q?yzZyaTwleFGPDS0JDX1ZdMx/MWzAMjgIEldp1luOMNdDKydPbfQra3aIOz8N?=
 =?us-ascii?Q?EzTxQQJfWpJib01Ugu1C+gkJnPAVkkIf1lNvWFdcGFSg8nqgVkXQ+1q54GJN?=
 =?us-ascii?Q?k5PI2WMSy60L6/YOklQsMiwG4LJoRnE8ktWlUWol1OZ9//vB9NrErH4jf+nZ?=
 =?us-ascii?Q?uXI+Jp2Et+9a/j0+FhX1cZZe8dZLzmDpbZVA3QDw8RZVbqeykDpQFbEVuibs?=
 =?us-ascii?Q?opgRrn10EQ1NyW9xqmKmuDp4LRvDpJLlL97b3IaxVgiYhhR0qSptHdlIEleO?=
 =?us-ascii?Q?7xWAP7R3AJjwPu5PmXrmu7Hxa+GeN3ellEayOlNAZct/qazOVVtOmrU1tFwh?=
 =?us-ascii?Q?aq4fvmtWuDs6Jt12xhk1mFIou8GXBgsfM3Nq+PK6gi0HMHF/a+Mr2Avc+Iao?=
 =?us-ascii?Q?HudwunXrhxwtxJBNi0aIqFiuz4eOi5TNelrs+hAN9yz7+JsWn0/30dytwOge?=
 =?us-ascii?Q?vSWEdW4i3yeH9aS7r8wc75haB/UzI5oHKK9xeSC6VTLVIHpq3qJPIEw/5vSN?=
 =?us-ascii?Q?KupE+tjXLjw6aBOShHN68j8h/fVCv33ej6XTJKAmSHdfUFCN4FXhRmPVdlXK?=
 =?us-ascii?Q?SarHiIlUTbzV8x9lLqL2UF2Oqd4xqsKUEBjIKil/MFuRGQnqlpiuOs5ScU78?=
 =?us-ascii?Q?gJ862bOlPHasla999JC+g70Kja7XOzLrhe5DKStVJ5i0zsj2+aVmSvqoWH26?=
 =?us-ascii?Q?hrwavgP7sOap9ZJsLhsCnRGKYMXunP5MgMR0eT/kZ6S/jekzjcgLOV/IJeqV?=
 =?us-ascii?Q?CB1C4kqsiSRgoDjMZ6lUcmqd189ZjBxpIvh209S3NS/q1gF91iZVw5JDdDZR?=
 =?us-ascii?Q?/Ed0sDRMrWPHJAdFoVg3GzecIh+mwwmlgHRJsz/Ci3qeNYu+0LB92ccUE5Cd?=
 =?us-ascii?Q?cBYyacoZhx6GpHH8KRSLMOM6b8dNJ9lI6W4xiI6h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea330bc8-1aff-40a0-d0d3-08de3c2a500b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 22:35:56.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F77scfQ924VMed1b3rcX283m9lXJG7OGpQGHC2yb061L7DgCSg4EEGMerohk1xuYTtYUwI6l0XdPyj9JVFi+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Sunday, December 14, 2025 3:25:04 PM CET Rafael J. Wysocki wrote:
> > On Saturday, December 13, 2025 12:04:02 AM CET Ira Weiny wrote:
> > > Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > While binding drivers directly to struct acpi_device objects allows
> > > > basic functionality to be provided, at least in the majority of cases,
> > > > there are some problems with it, related to general consistency, sysfs
> > > > layout, power management operation ordering, and code cleanliness.
> > > > 
> > > > Overall, it is better to bind drivers to platform devices than to their
> > > > ACPI companions, so convert the ACPI NFIT core driver to a platform one.
> > > > 
> > > > While this is not expected to alter functionality, it changes sysfs
> > > > layout and so it will be visible to user space.
> > > 
> > > I'm not sure right off why but when I run the libndctl test with this patch I
> > > get the following panic.
> > > 
> > > [   17.483472] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > > [   17.484116] #PF: supervisor read access in kernel mode
> > > [   17.484593] #PF: error_code(0x0000) - not-present page
> > > [   17.485056] PGD 9def067 P4D 9def067 PUD 9df3067 PMD 0
> > > [   17.485516] Oops: Oops: 0000 [#1] SMP NOPTI
> > > [   17.485886] CPU: 2 UID: 0 PID: 1191 Comm: libndctl Tainted: G           O        6.18.0ira+ #34 PREEMPT(voluntary)
> > > [   17.486804] Tainted: [O]=OOT_MODULE
> > > [   17.487125] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-18.fc42 08/12/2025
> > > [   17.487749] RIP: 0010:acpi_nfit_ctl+0x40b/0xa00 [nfit]
> > > [   17.488222] Code: 48 48 c7 44 24 28 28 f1 8c a1 48 8b 83 c8 01 00 00 44 89 e7 48 89 44 24 50 e8 01 83 fd ff 48 c7 44 24 40 10 58 8c a1 48 89 c3 <49> 8b 47 08 48 c7 44 24 30 30 f1 8c a1 48 89 44 24 18 e9 24 fd
> > > ff
> > > [   17.491668] RSP: 0018:ffffc9000f11ba28 EFLAGS: 00010286
> > > [   17.492422] RAX: ffffffffa18679f0 RBX: ffffffffa18679f0 RCX: ffffc9000f11bb40
> > > [   17.492903] RDX: 000000000000041e RSI: ffffffffa18cf116 RDI: 0000000000000003
> > > [   17.493408] RBP: ffffc9000f11bb40 R08: 0000000000000008 R09: ffffc9000f11bafc
> > > [   17.493888] R10: ffffc9000f11bae0 R11: 0000000000004019 R12: 0000000000000003
> > > [   17.494396] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > [   17.494878] FS:  00007f432f5fd7c0(0000) GS:ffff8880f9fdd000(0000) knlGS:0000000000000000
> > > [   17.495436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   17.495826] CR2: 0000000000000008 CR3: 0000000009e0c005 CR4: 0000000000770ef0
> > > [   17.496324] PKRU: 55555554
> > > [   17.496516] Call Trace:
> > > [   17.496691]  <TASK>
> > > [   17.496844]  ? __kmalloc_noprof+0x410/0x650
> > > [   17.497138]  ? setup_result+0x1b/0xa0 [nfit_test]
> > > [   17.497474]  nfit_ctl_test+0x21a/0x780 [nfit_test]
> > > [   17.497803]  ? preempt_count_add+0x51/0xd0
> > > [   17.498086]  ? up_write+0x13/0x60
> > > [   17.498333]  ? up_write+0x35/0x60
> > > [   17.498565]  ? preempt_count_add+0x51/0xd0
> > > [   17.498846]  ? kernfs_next_descendant_post+0x1b/0xe0
> > > [   17.499196]  nfit_test_probe+0x350/0x4d0 [nfit_test]
> > > [   17.499535]  platform_probe+0x38/0x70
> > > [   17.499791]  really_probe+0xde/0x380
> > > [   17.500039]  ? _raw_spin_unlock_irq+0x18/0x40
> > > [   17.500354]  __driver_probe_device+0xc0/0x150
> > > [   17.500656]  driver_probe_device+0x1f/0xa0                                                                                                                                                                       [   17.500939]  ? __pfx___driver_attach+0x10/0x10
> > > [   17.501263]  __driver_attach+0xc7/0x200
> > > [   17.501529]  bus_for_each_dev+0x63/0xa0
> > > [   17.501794]  bus_add_driver+0x114/0x200
> > > [   17.502059]  driver_register+0x71/0xe0
> > > [   17.502480]  nfit_test_init+0x24e/0xff0 [nfit_test]
> > > [   17.502956]  ? __pfx_nfit_test_init+0x10/0x10 [nfit_test]
> > > [   17.503483]  do_one_initcall+0x42/0x210
> > > [   17.503891]  do_init_module+0x62/0x230
> > > [   17.504296]  init_module_from_file+0xb1/0xe0
> > > [   17.504732]  idempotent_init_module+0xed/0x2d0
> > > [   17.505184]  __x64_sys_finit_module+0x6d/0xe0
> > > [   17.505626]  do_syscall_64+0x62/0x390
> > > [   17.506016]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [   17.506563] RIP: 0033:0x7f432f8920cd
> > > [   17.506946] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 4d 0f 00 f7 d8 64 89 01
> > > 48
> > > [   17.508548] RSP: 002b:00007fff0a6ccd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > > [   17.509209] RAX: ffffffffffffffda RBX: 000000001f5def50 RCX: 00007f432f8920cd
> > > [   17.509831] RDX: 0000000000000000 RSI: 00007f432f9aa965 RDI: 0000000000000003                                                                                                                                    [   17.510472] RBP: 00007fff0a6cce50 R08: 0000000000000000 R09: 00007fff0a6cce00
> > > [   17.511091] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000020000
> > > [   17.511727] R13: 000000001f5deb60 R14: 00007f432f9aa965 R15: 0000000000000000
> > > [   17.512353]  </TASK>
> > > [   17.512638] Modules linked in: nfit_test(O+) device_dax(O) nd_pmem(O) dax_pmem(O) kmem nd_btt(O) nfit(O) dax_cxl cxl_pci nd_e820(O) cxl_mock_mem(O) cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cx
> > > l_mock(O) libnvdimm(O) nfit_test_iomap(O) cxl_core(O) fwctl
> > > [   17.514512] CR2: 0000000000000008
> > > [   17.514878] ---[ end trace 0000000000000000 ]---
> > > 
> > > 
> > > I'll try and find some time to dig into it but perhaps yall have a quick
> > > idea of what it could be?
> > > 
> > > Ira
> > > 
> > > > 
> > > > This change was mostly developed by Michal Wilczynski [1].
> > > > 
> > > > Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/nfit/core.c |   34 ++++++++++++++++++----------------
> > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > > 
> > > > --- a/drivers/acpi/nfit/core.c
> > > > +++ b/drivers/acpi/nfit/core.c
> > > > @@ -2,6 +2,7 @@
> > > >  /*
> > > >   * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
> > > >   */
> > > > +#include <linux/platform_device.h>
> > > >  #include <linux/list_sort.h>
> > > >  #include <linux/libnvdimm.h>
> > > >  #include <linux/module.h>
> > > > @@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(s
> > > >  			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
> > > >  		return NULL;
> > > >  
> > > > -	return to_acpi_device(acpi_desc->dev);
> > > > +	return ACPI_COMPANION(acpi_desc->dev);
> > > >  }
> > 
> > It's likely this change and it is not even necessary.
> > 
> > If possible, please check the v2 below.
> 
> Well, scratch this, it was a mistake.
> 
> The original patch was almost there AFAICS, but it overlooked the fact that
> nfit_ctl_test() could create an acpi_desc with dev pointing to an artificial
> struct acpi_device.
> 
> So to_acpi_dev() needs to check if the ACPI_COMPANION() is there and fall back
> to acpi_desc->dev if that is not the case.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v3] ACPI: NFIT: core: Convert the driver to a platform one
> 
> While binding drivers directly to struct acpi_device objects allows
> basic functionality to be provided, at least in the majority of cases,
> there are some problems with it, related to general consistency, sysfs
> layout, power management operation ordering, and code cleanliness.
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI NFIT core driver to a platform one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> This change was mostly developed by Michal Wilczynski [1].
> 
> Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!  This version passes the tests!

Acked-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>

[snip]

