Return-Path: <linux-acpi+bounces-21381-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CtcAovcqGnGxwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21381-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:29:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A8209D08
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A65A3013460
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF315746F;
	Thu,  5 Mar 2026 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtDePDF7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079023E229;
	Thu,  5 Mar 2026 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674182; cv=fail; b=sPYSYyN4FZxGgL0UREzAWSuYHz5OWN9gEGj6JWuWKMU5JV5FQMJ80TUqf6rupTbJVp6dtIr1ke0H0BAogJmO/8mUDv/hxMINfZ/RCRluQ6icsF5sPCJHKXJboBzggJuLZX1R12QSY7GY/5F2lFif0BErw3Pif3hfIXCGFk3yGIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674182; c=relaxed/simple;
	bh=9sZhvOxRagi5X3qVWPuE7Z8xZy54MZPD1UDLnX7BkGE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=a90OepFfWpd6S7DxP/ZDkr2DJ/TYzWyzwrFD8o9gPNCfnCp4Oe+BSCDI1Jokg/epZck/6R/2nNsZBjq6W/mQ1aX4qpthfClrV3h+y2PBfu+uqVegOPPOeD5klk6l3KOSqrKyNrDfY1vlUmmVbYacR6UCBkMER91KvwK8AYZeZZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtDePDF7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772674180; x=1804210180;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9sZhvOxRagi5X3qVWPuE7Z8xZy54MZPD1UDLnX7BkGE=;
  b=MtDePDF7kkbimet/NYO9a1/leyJ7uFXxY5t1K7WNKbQYJVKcbKdV1nLW
   5EYppUMzayfgKCQNAn+eJyxkZH59voHq2e9ZldAbzj6MHlF2qEFWdn/uX
   rb900Wnh8Iv8FA22/xMu4xSpJUH4qFWQXoVkBbNIhaYmoZgC1rzebffLX
   jlFWuq7x9lndijv4u6+sdkGanpBQAjl55iqvgXxpEjtjQy0McWvXRgft5
   5bxO49hqPS1u/YH0/hyGVbuqyE+dWsPfq/YK5VWhklc9y94jXYyME9y3r
   NcNJvLv35GHz4R3OdM/WZf076x6noWOqQZUUYuEvp9aezyyH/TqPZsvIl
   Q==;
X-CSE-ConnectionGUID: /Zv/3uzdSPur6U7gJeMQOA==
X-CSE-MsgGUID: RE/JKBOOQFmwSjcRiwQ6hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73622797"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="73622797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:29:39 -0800
X-CSE-ConnectionGUID: dupRbk+1QLule26XNvQ8Vw==
X-CSE-MsgGUID: BuGCjrbCTJO3hbZd/Sc3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="223017125"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:29:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 17:29:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 17:29:37 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 17:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elkzVQaORadcc7MIzU7d/uEcgLaYiKHAMgXHDeP0aMJ/AMldZJjOJbZD74Z7qifzN1YfwoKoAa2I/S4bhS3BGDfUZFuo0qzl1tfcAi3xffPiB/OXm5G3KyrdJkYetNUmHzSllDf/8m/K+CjNuasQHUTRWHxE7JA+U/rE8V6Hn+xObUDGoOH53V3zr/JQI1n+ehmPZrHQRmLS0uFDSQM2Xb5Dgmznrv1Zg0dunTOoOsdSPPFFga+QDTM+92vPfG+aHF+Utbs4f3UjlpWfEfpzauXwsdOn8F6FJYmFPfchuOfDzigGhk5U9ZLxfU4YoAeMhmlI8fBqFI8WCtHyEoLILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlC8OVl3IjH/95QNOjcYN+EVP4YHO0YojVYZtGHXmF0=;
 b=N26Bn00dU2RSpumGCdTdoVp0n19Sd5DWy6dvrUhIKoTFPn9vZsKPbeWU0pV4X1LjwFYOrEvalC8jCI0urwOBlk6W+UabBGt2Eg/BwEVK4K88S24XUxmuht1l29QpAZjJSBFjM4DOS/ELeSv1pL2PAR9AXyVytu5y3VtN/sZaKEvjvlJTz1Ajvt4Uh/BSfOpxC+WPg8YVpPugmoCbqkQeivZaCe06266VhBDs+SflfBLplTWObq1/DVfO77iZAPmqup9OCQfc8CGla9RUD6HsBLv+QsdBrPsNJ82W6NW35a7xEeJZCHhlab5MvDd8OzclD6g3ZrE9tecL8zTagpXVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 01:29:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 01:29:34 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Mar 2026 17:29:32 -0800
To: "Huang, Kai" <kai.huang@intel.com>, "gourry@gourry.net"
	<gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "Schofield, Alison"
	<alison.schofield@intel.com>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "wangyuquan1236@phytium.com.cn"
	<wangyuquan1236@phytium.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>
Message-ID: <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
In-Reply-To: <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: ea93b84b-beee-411c-ecce-08de7a56a821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: heK/iR4TtEbHtsoQoAnRY216MNN4XkbkNOouIFvLPfPHkPlxcSPjpKqp8bXPxgDuL2WWo0rc4XVGPtquHWMClGsrAufNLwOlH3H+G3SFTRUg3eHCZn1B5ROyQBGpeyLZOREnU1j5EZSgpeW6TMJYs7My//m2hpVLOjM42AxFM8+KuVAAxYy+p96g7s7XqgIb7JGshw3//Tlv7X07unsHRmopA+F7tTe46dNresCuzkMCiEGc4SBfljNskP8JzWZJVY03Or8duQlAM2LjlzdMwGqkKSA0r9dkl9ooeD1MXmBt/cbhDsRgznOs/MGY22ecfqz3n/PwSA47Xge6wU/SOFd/4CMLRCSl67krWvjzFukgIGAn7qNohiERYQDiZIPc1TqWi7GCvP7OFg7gci7pMlA3HKN/QI5h4Yq1BaS3qtS8223r/cT8a4lGcSbU8yYAY9WmHhwwtVVYsky1MPEuYSr8YUaK/K/OMZValPc4q2grF6qUsWtygXuyu3CNDJ6DtTQYSDoZLvj0P6FBdsplyU8c/ypKBNzEnBaGQvkuAg6CDjJnAvAjAZXZBM7JUOMLttZ1fxx/r0nfHT/LCwt/2N6x7MEhbLT20f6Dzi2D/BooND1wBUbKWa0tF8Sdlu6YaYzJlcBUy+Sw2uR/39H5tEl/trD+bz9Ihy0tw6cucGmx3t08PuUmu2c8WNJ6s0AgD7gaooGXnEc3Gs/TcsQAJIEJKhtC8a/cMy5djMjCmag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytQRzZlUWNuTTNDRzRSbEtLWjg2M2NjSVhIT0lQOG5aL3ZkbEMwdnNBMURw?=
 =?utf-8?B?bC8wN0lSd1FrQ2pnODQzSjNnaFBtKzNWWUxha1V5NTJrb3VFS2t0VFBIV2Iv?=
 =?utf-8?B?WGs1bElNSTJjNU1Fb3hwTm9mTmJZRG42RGQ2VEoxVEc5TjBWSHdqRmIrQVRF?=
 =?utf-8?B?SDBrZUtiM3M0a2dxbUMxODBGZWorcjl5a09WRXRPV3JjSG10ZUh6NlFQdkkx?=
 =?utf-8?B?OE9kSGw5ZW4zNVdTRVJmbG13bUJaV0FRWm04UUNiTWduWWNFTjRjNWt4ZWFq?=
 =?utf-8?B?dDhwQUQ3NzE4SkNkSHBDUS9SVmw1dGt1cUdLLzRNS2JqRm56S2tST2RRQVJD?=
 =?utf-8?B?Mi9iemNOU3VTcHRPVHBDQUc3cFZwK2Y4a2QyYk9FRStpSUV1ckN6SE1UZTBP?=
 =?utf-8?B?Nyt2SU80MDczUGE5em5MT0ZLaHk1T3N3TTNSaXF4Y1k4S05GazNPYjJoRTZx?=
 =?utf-8?B?NXc5VGIxb3R0emxmMmF1dFRCOEtYL29xN0FmQVgyUi9kRG9QVmR1aTd6LzlY?=
 =?utf-8?B?VVRrS3E2c2V5bUdISFUwOGF4T2kwOVIxNGRjRjYwdU93QVh5dTQ0OHBxVXhU?=
 =?utf-8?B?UGhaT21abnBKcUtFRDZJcU16K2E2U2wraENwTUJLdkY4NEoxbnZTdGRoNnl4?=
 =?utf-8?B?OFM2TG9uUFNFZ04wMjdnZmt2TVpjK0FYeUJFZXd1cGxMRXBWVGNTU1NZblYx?=
 =?utf-8?B?M1VwSW4wWEgyWVhaeXBUZGZ4dmJRZmdFYzVSczFkNXZWTkdpdWt4a0xoaU96?=
 =?utf-8?B?bW1nbjROY0F5cEhzRldVYllKeHpvVzFTM0J2UXFONHYyK1U0SkdqZUZ1NDBJ?=
 =?utf-8?B?ZDBRaTJCcno2RjJOQ3pBMWZucFFmbG1tTjdIODZFNnV5bEViSEV1U0xEMDgx?=
 =?utf-8?B?eFBMVFlRK1ROZUlZejI4WjZ6cWx2VWhuczM3bmJGcURCTWtwdnBnU1VZbWxD?=
 =?utf-8?B?U0ZDZi9jVDJRS0tmRzRNRDVabStUQnkxcHZzcGxsZjN2NUlrNUhQSDc0TnNZ?=
 =?utf-8?B?RFR4SEcrWEFJbzFBWmF6U3B1NndGT1V3UUtGbGFrV0lIRDJxemRKR2psVmw3?=
 =?utf-8?B?UGRKeUNiSDBDNE8zb1NNczRiTW5VYjIzSmVZRjRoS2xQVWt1UXVONFI2VUlz?=
 =?utf-8?B?Vzljd1BUQTlJZmkxU1AzTDNoa1YyVUZxUThaYVVuWCtENEgzQUh6bzR2WFZr?=
 =?utf-8?B?YWRkSFcrUFp4RGhUMkxDMlZKU0lWNldtbzBFK3Y3RGN2Nkp5YnhLZEYxazND?=
 =?utf-8?B?WHJJdGQrUGlQNFFqZmtuZWt3cW1qQkU1ZmI0bm9vQklNcmVyZHo5SWFCem9Q?=
 =?utf-8?B?SEdzMldYbFlYUFVnQ0w0aGRKOERkQmdTc0l6TzZid1MvUDJHYXZJY0dHZ0Uy?=
 =?utf-8?B?TjdqeVNUdkZYQzN1STk3dkt1c3YxMkpyZTI2WkVYLyt5d0xXUDd1RHlrajJs?=
 =?utf-8?B?V2xISkptS2pHSFNCdG1ORjVCemhTV1B0Ni9kL2Ywa2VpM28vY2F1bTBkNG1S?=
 =?utf-8?B?N0t5S1JWajk1SkNPdUhOa0M0ZXd2NE9GRmxBaGtWbkJocWdBMi9iaFFGVE9X?=
 =?utf-8?B?SkVValY5NlV6UzArVXRrenp4RkNTMm1NdW04cUlwY0pXRHU2SmdOQVU3OGhJ?=
 =?utf-8?B?eDlaTWN1SmZSR0NmMjFmWlRlZFhUTEVRNS9PVHlPeGtJa29BNGxLUHkxR3hF?=
 =?utf-8?B?L291dVhVWE9ZUmt2amNkeXllQlpFbmVDN04ybVE3MldYSkYrVWwyWVdNMzNv?=
 =?utf-8?B?aXRBd3Q1NG9yQ0YxVXdMOWpnZXpPd28xK1F2ektveGJ3SEpLZDFUaDNFTUVT?=
 =?utf-8?B?aFlBdUVFNzdWdllyeTg3c2FYSE50UEpWWVRjZkJSOFJpUHBZYU9nZVVNV0RB?=
 =?utf-8?B?Z3hYaFRiTGYxTVVCOVg0YzcvVk95djdaM3l6c1oreGl2b25LdFJVSmZHVU4z?=
 =?utf-8?B?bStiaWRIanhmblJtYW1hU0h0Y3J5aWQwd2JXVzVwaS94NE01RWxwRmRmaTAw?=
 =?utf-8?B?Q09QaFF4L2xVVDFwdVg0N0J0d0FLYnBLeUZnTkUwMlBpOGdpTjd3dTRFRGN4?=
 =?utf-8?B?M0pUV0YyWU8vM2twSWlWZGxwMXNkZEphQkd3NlMxK01RN1BHeVlIVkFwVUZu?=
 =?utf-8?B?RlhtNXl3cVo4MGVyZ2tYYjl1Zzl6bitpblhTeE5PQlg2QlJoS0hHWTBKVW5n?=
 =?utf-8?B?cFhJV1BMcHdYUGFDUEIxS2RhZzJ2RHNHM2IvaVN1dUxGemJta256UWljdlpU?=
 =?utf-8?B?VmlMMUF3NDBoUnh6MkZkZnRKMGd2R1Nxa1d0VkpScVE1NmRaMTUxdkkzbHFn?=
 =?utf-8?B?Qi9NQXJjODJWendRSVI4bVF2ekV6MkFUUFlXNE16dy83TUdlSzJkN0xHM0ZC?=
 =?utf-8?Q?nB0vl7xy3D5mw4X8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea93b84b-beee-411c-ecce-08de7a56a821
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 01:29:34.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bC7GhZZhYwdedqG3MSNRlnHFz+cAouj426BHzTBqqVuS9Jc7y+EurVBQUNgU6DBi/EZn+eG2y8BclnFNoWKTcQoZBrDgBIVwiUrhMsFM60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 912A8209D08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21381-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Huang, Kai wrote:
> On Wed, 2026-03-04 at 19:29 -0500, Gregory Price wrote:
> > On Thu, Mar 05, 2026 at 12:14:52AM +0000, Huang, Kai wrote:
> > > On Wed, 2026-03-04 at 18:56 -0500, Gregory Price wrote:
> > > >=20
> > > > This basically says if specifically CXL_ACPI is built out, the NUMA
> > > > structure is forever lost - even though it's accurately described b=
y
> > > > BIOS. =C2=A0
> > > >=20
> > >=20
> > > The normal NUMA info described in SRAT is still there.  It only avoid=
s
> > > detecting CFMWS, which doesn't provide any NUMA info actually -- that=
's why
> > > kernel assigns a 'faked' NUMA node for each of them.
> > >=20
> > > So we are not losing anything AFAICT.
> >=20
> > Well, I'm mostly confused why there are CEDT entries for hardware that
> > presumably isn't even there - unless this platform is reserving space
> > for future hotplug. =C2=A0
> >=20
>=20
> I think this should be the case.
>=20
> > Just want to make sure we're not adjusting for
> > strange firmware behavior.
>=20
> How to check whether it is "strange"?
>

So these are fine. These are CXL hotplug windows and the expectation is
that they *might* be populated in the future. SRAT can not make claims
about future CXL hotplug (see NOTE). So the expecation for CXL hotplug
is reserve some numa nodes that Linux can determine the affinity of
dynamically with HMAT Generic Port and device CDAT information.

NOTE: SRAT *does* make claims about the affinity of future *ACPI*
Hotplug, but in that case the platform statically knows something about
the configuration of memory that can possibly be plugged in the future.

> > You are taking something away by nature of compiling something out by
> > default that was previously not compiled out by default.
>=20
> Yeah, and it is due to "there's a cost" if we don't compile out by defaul=
t.
>=20
> Hope that justifies?

I think it makes sense that if you disable CXL hotplug by setting
CONFIG_CXL_ACPI=3Dn then no need to reserve numa ids. However, just do
something like this rather than add ifdefs to the code:

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index aa87ee1583a4..62d4a8df0b8c 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -654,8 +654,11 @@ int __init acpi_numa_init(void)
 	}
 	last_real_pxm =3D fake_pxm;
 	fake_pxm++;
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
-			      &fake_pxm);
+
+	/* No need to expand numa nodes if CXL is disabled */
+	if (IS_ENABLED(CONFIG_CXL_ACPI))
+		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
+				      &fake_pxm);
=20
 	if (cnt < 0)
 		return cnt;

The call to acpi_table_parse_cedt() will get skipped and the code for
acpi_parse_cfmws() will get automatically compiled out of the file.

At the same time I doubt this patch provides end users much value in
practice as most distro kernels have CONFIG_CXL_ACPI, and the few end
users that have CXL are not going blink at the overhead to support the
full feature set.

Can you not just disable CXL support in the BIOS for your system and
avoid complicating this code path for a small win?=

