Return-Path: <linux-acpi+bounces-18309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241BC18972
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786C33B3A69
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D527306B18;
	Wed, 29 Oct 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WVkT+neN";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ByihXoBx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856E2F692E;
	Wed, 29 Oct 2025 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721836; cv=fail; b=kMRuOVoOuoFTNK9KOPaVF/cgS4LK9TtYHUbi27gNN1bz5YZlvLLN9C1F9cZ6YjhjMl/wnUMKTSYrKhDrGKspkK/dHWuVmUyJSg3soKXLCMLG54VIhx/SXVGrUgW0WQrZIZyhzUdIDaN8eKQNYxKI2Y4IjLcppNTHYsRku/sRkNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721836; c=relaxed/simple;
	bh=yiuowjO5qm205v1ygTsJNnwjbomWBlJV/6SqSoRpZCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RT0lqrPoTjs5kOfTB455vK7xlVYQGf7VHyKbosrDMeeMBEnQM/LBY0QgwoAPitbLOCc6irBH6DBm8S0sFC6xlRWaaqmFWw4WEkVNuuHRzD07NmiqKHDHb4vW9pdeYGZu1BwPOp+jMHxVtJQw4GKl23r2p5XhkjqdimQsMTXzw9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WVkT+neN; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ByihXoBx; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761721835; x=1793257835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yiuowjO5qm205v1ygTsJNnwjbomWBlJV/6SqSoRpZCM=;
  b=WVkT+neNLNBHKJjXILbq89zqjPXzMxVopFLgtJMNihpX+afizcw14nCN
   CUcWhoRCgJtr5ackfnYnDTGKeju3T4MUnrAV3XmUqnMw4fqHWdQRglXwz
   aLcGXbNJ3RnN7JbFwhNJubxcOVipgBBWudT1JQ7TqAjKE6aQ50AR+tUqy
   T4qHSo1IfXdXRQjlmkwZG9XkVSdi6nnXYf6ehg+OQhHR9qVwZTW2O19O0
   bN1qSdnd113YfLALdkQKYf/7P8yhtqXfmEHDd3F5JxpJmufz9TqNZweVJ
   BHn9BkjM+zYvAYc/cZmob3EVoBZJvbvUDBoDubOQgeVBsxN+lfIPq0AEn
   w==;
X-CSE-ConnectionGUID: woQilOqcTxKsLT7Ooad+0Q==
X-CSE-MsgGUID: vUxv3QItRQKJVnQ9EVfWzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="171738959"
X-IronPort-AV: E=Sophos;i="6.19,263,1754924400"; 
   d="scan'208";a="171738959"
Received: from mail-japanwestazon11011045.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.45])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:09:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV+tN7mgLhgq0NWaIBOqNyPoCJXcOR2RFY6xJ89s7OXgd6BIraRLebq+wtuuX5LRJEydTi0AVQ2ymJDSV5eMx6L+Ld5OeL8JyG07wUQH3ze8W4JYIHLvdtN5Rq3XI4eRFuemuGVP1eKsDs5oG8czpRVfrGyWG/IQgACij9u+yujpeexwQ/Vc6+WpfYrNRpyep9nJH5NAdNozkry5qxZDhL7belq4FcR6F5G4OigG8cGH1sWbZ8TQI2K26w8yt6pXNjR9NuUMQyLNZ3I3suiXnU5lV66vRgE15r2U109CJmcZmLV3RaeQrcjQESyhhDjhQRoXD8FI+qc54t6YlpG5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiuowjO5qm205v1ygTsJNnwjbomWBlJV/6SqSoRpZCM=;
 b=C6eD19CDEqeXEliAqfS1q04LAI/evuWie5YwiputNQeExhCpMvXUoIK3xG6d+Y3A2BPDV/HCUYy5+2h1F/e6+JLeB08fUldCLgOHNlbpmyfqn/XqQJ4VItzspdzMUjLANl5gxC6l7lp4DlcenkxK7fY9dXhwSHch/brXYZ6d73yJCy+gx9zKZgOQauh18IjU3LpuGoxr0o2F5BsPfZbXDO75jnUPksV+s7lhYsE9z/sq6GedULSf4SZnwa3k17hOx2BaXw7GQDeCRtEDqZVP5c0akO/lqjoLAxW/na42cNFRvAc8lc1qCPEmDDbbCE1YOW7cMxgxlfcEwDq0KEwwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiuowjO5qm205v1ygTsJNnwjbomWBlJV/6SqSoRpZCM=;
 b=ByihXoBxBDWq4D5eYxMx1kCHrsAqASp9gStz/rBW70MyrEuxaWjO+ZIWMbMiIpyjpPNfeLg87Zoyu7YR2B5vAk0mi0RQuLPVtc46tTX94dEcuoTEScADqROqP/4PZc6l9Kr1JmDdW1eGUo/FTaxmMdWe3CS2MBEhSZlDO+7j8d3Iq5W3QPyIw6ZE4mgMJyOwcWRU1CZkxUezT4nzs4D5pIz6nGwPSGmaH1V1lt/BnBlIASg086PmXbkf54IsBkQKpsy9QiN0sJuyJ8C7JTLg1pc5DfbQ1llUultQ91soz4jZIfm3mna4H3+5xfR7wbcMltvuQeSjns7G/CcxDiQh2A==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB7361.jpnprd01.prod.outlook.com (2603:1096:400:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:09:07 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:09:07 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, "peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>, "amitsinght@marvell.com"
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Dave Martin
	<dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, Rohit Mathew
	<rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, Dave Martin
	<Dave.Martin@arm.com>, Ben Horgan <ben.horgan@arm.com>
Subject: RE: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
Thread-Topic: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
Thread-Index: AQHcP5gc9dQ0/jFTe065wirKGjIQ9LTYxmgw
Date: Wed, 29 Oct 2025 07:09:07 +0000
Message-ID:
 <OSZPR01MB879846D16BB360C90B5A2FA38BFAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-21-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-21-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=196cc6bd-77d1-4899-b70e-3a6d0b00949e;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-29T07:08:16Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB7361:EE_
x-ms-office365-filtering-correlation-id: 6cb535fd-34d0-498d-e2a6-08de16ba0d19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?cHBZM3E3UGs4TjdySW9qK1dkSTQxR3R1YVBkbGpMNUR1c2RMemR6Qm5i?=
 =?iso-2022-jp?B?S3Yvb1laNC96dmpxRHNtclNqaHZHdDF1ei94M1BVNGIxV2gyem4vaEky?=
 =?iso-2022-jp?B?azBGVDBpN0FyWFpYSURSYzBTVEkvNGlmc0hIR0lpOSt2bkRiQ0dseXIx?=
 =?iso-2022-jp?B?eXpyZ1lnUVc3RFFUdlVoeXZlY0EzdUcrVG8vZ2REeTkxQ3d2TSt4dE01?=
 =?iso-2022-jp?B?QVhrekFhTUN3N1czMW9RUUx5bW44TVBKN1l3bW5uMVpWR2l2dEMwK2VS?=
 =?iso-2022-jp?B?OXZuK3JQMGMrZ1Vrd1N2SnFwY0JiUU81L3pDRk5jbzc5d2locmo4U3Ba?=
 =?iso-2022-jp?B?bDNacEhTeG9DK21UMEV6L3FHQWg5K29WNDFDVnJiQXVXMW0zUXNJZVZY?=
 =?iso-2022-jp?B?dWRZN080dUYraWpqSk5BS1pCeXNXYncrOUVzVjdrSTRWSDRFekFzQ01P?=
 =?iso-2022-jp?B?YXFndmNmS0laTEpnOU90N2ZodS9tdmxpc2Z4TmNlNjl3dTR1SmErL2hm?=
 =?iso-2022-jp?B?OHgvcHB1VnY2QXdiK2lydUJFYS92SmYxVGFrUkZCc3R4MmNiWEpiYUZP?=
 =?iso-2022-jp?B?cXhtMi9NWi91ZEVjb2N1bVFwejJWdEcrVVFVL2pERTJ0Qk1Nb1YvT1Fy?=
 =?iso-2022-jp?B?ZHMyOHg2L2E5UGRKT2l4TjU3MzIvbTdEdERKcTkvcWVVMEFwTHQwOEVE?=
 =?iso-2022-jp?B?TVQ3ejJqdkE2MGE5a01GRy9BOW94MXN6cFU1SmIyelUvTGFXS0FYcWc0?=
 =?iso-2022-jp?B?MHgvYm5xTFFrUTMvN0JuYUhqZ0UxbjRpQ1Q2dkxFZ3l6VU9ETGU1Mm5C?=
 =?iso-2022-jp?B?YU9Jc0N2bTIwTUwxcFBVWWJ6Qk42NnppMGtQVk9GNElDS2tPWGpsZDl6?=
 =?iso-2022-jp?B?a1o1TUl4a21YTENWNjBPd1NKUGMwM3d5MkRoNnRpYmRRNkcza3Rid2ky?=
 =?iso-2022-jp?B?M0FIbEh6YmxOUUJZVXdEanI5aXVXeEJXNGJvT3o4amdsT3RNbTVuTDZV?=
 =?iso-2022-jp?B?Z21ic0NPNkQ2V1VwS1AwT0dmbEo3R01SaWcxVW4vY05DbFg4dUc1aktj?=
 =?iso-2022-jp?B?eVlKMnpycmNnMGc1c0hKT09PNERYVEN3SHRSWmtJNElNbFpMQllVQkhH?=
 =?iso-2022-jp?B?aGdBRC9iaHZmM2lkMU1udXhjNTlsQVptd1F3NHVoSnA2RjhlZkdyZmhW?=
 =?iso-2022-jp?B?UDVmd1J5QWcrTWlLZEIrcUdyb01WMm9YWXpXSm13SklRZmtMQ0tuRVcv?=
 =?iso-2022-jp?B?MXJWMGMrSkFEMFliVldPZU1Bd2NCTERrT1NxckRmOXJ1TEtxbUxtdXMv?=
 =?iso-2022-jp?B?WXM5eElPR2hIZkNYc1RnYmUxVDdobVpqeVg0bEY0MG85OFJRODFHMDZz?=
 =?iso-2022-jp?B?YnJoOFN0TjhLdS9ELzNudi82Zm9iSnpHVjEzamlxMVRRR2VIT1FMVkVX?=
 =?iso-2022-jp?B?dDhyaWJzd2tSeXJSWFk2N3IxQjFOT3pVN3RSZGpDajU0eEhnWTlBaG90?=
 =?iso-2022-jp?B?ZGhYVDh6RnhtN3ByTWhCMmNzKzVvMkEzT2RnQkg4c3pld2ppMjZ1ek1s?=
 =?iso-2022-jp?B?T0toRW1XUFFpZmdCak1OY2FScTh0QmI1dG5DZWlBZDNTbnRWMy9qeCtY?=
 =?iso-2022-jp?B?RkpBb3ZCNEs1Wmw1cHdjcW0yMWFZTmJRbUtCbitZTENrbTVxdm8ycU5H?=
 =?iso-2022-jp?B?RmJDcitVaHZVSWttVjBEUHZ3WWU0ZkdGT0hXbmxFSnNCUjY0cnFram52?=
 =?iso-2022-jp?B?V0E5L1FJMFd2QXFJeHFLMFUvTldmL05Cc1F5Qmh2L3AwQUo5R0prWnUw?=
 =?iso-2022-jp?B?YVBkMy9zVDdEQjlvTjJkTmI3WG9XQTVybkpMT0pDSTVQdHdXckJFLzJ1?=
 =?iso-2022-jp?B?aWJEZGhlTWJDL2hCcU1udHA1VXQwa0hDN2dRajdOaFJUUWVuZ0VydWlK?=
 =?iso-2022-jp?B?SGNzWTd3RGFZYW16Ungzc3ZtWVU2d3g1R3FwcFJ5czVCSkRIZVh4UFI5?=
 =?iso-2022-jp?B?SWRWdXppTGplZkFsWE1XOEdqVUxTUlJWMWlPamQ5SXVFZDBFNWU5RW85?=
 =?iso-2022-jp?B?RldEK2tlaGdNdE9uWFlIdGlHM0R1NDJlblIzOU5iQjRJbk1hQUJxVm03?=
 =?iso-2022-jp?B?RXpXRkFNc1NzTEUvQUxCNFZaRkZzNEFwcXIvVmlzc3hhRnVMV2llQUM5?=
 =?iso-2022-jp?B?MSsyTnV3cUF1ZXRvbDNzSy9FVmxtRzREWHkyS0x4c1FVQ0M3b2J2ZGRC?=
 =?iso-2022-jp?B?QkYydz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?OXlSK2tvU3A0SnlRU0ptQkVhN1piZktqNVdnT1dTVlZMODRMQStCSCtV?=
 =?iso-2022-jp?B?Szk1WjF6cDc2NGJqSXRMVkUwMTF1RjZzeVhHbENIVVlSdzdKeFBxUUFx?=
 =?iso-2022-jp?B?L1JKek1JTFpGc2ROdTh4SHM0SzJOR2xrbnNuZTM0VXRPazgvOUJwbk5u?=
 =?iso-2022-jp?B?UWZmWTBIaDJmV24raElHakc2N1pQZ1IvK01ZZm5MOWhQcFZpT0lVajBZ?=
 =?iso-2022-jp?B?dEp2MjA4U0VLUGVTdFVHampZVDF4S3pSY0FpbllxWi9EWGJoRm0zRG50?=
 =?iso-2022-jp?B?SFJlQUdXNmhrdVA4ZDF3WnBML2J4TWpLQjkrQkx3RVFTcTZqZHo4TTlK?=
 =?iso-2022-jp?B?c3d4blRWVHppelo5UEo2M0hicWZxUWJFeDNkYWwrZE1TbUQvYWUyMlpZ?=
 =?iso-2022-jp?B?bEM3cmtiRHQyUnIyYXhWcWNhU3hab3RXVTNadHdiQUVxN0RpQjQ0aG9h?=
 =?iso-2022-jp?B?QzJyenl1ZDZzQ3B3UTYxdUZ1SnJ6MUp4QmhEWjl4clo3cmhVV24ySVZt?=
 =?iso-2022-jp?B?MGthbVhtelY3U1dKYVYwMEhFSE02MnBNLys2dGdBbkFIMFh1SVVtVGtm?=
 =?iso-2022-jp?B?dFlsVGFlbTFVSHdtZHVrZUJ6ZWNLSDF2SlRVT2pQbVVrbkM2czE1QUdw?=
 =?iso-2022-jp?B?aVhhM2dzSWkvN2ZHaWNwd1h5YWNkU2NaaTMrVjl3dHNpMkFlT0NaRnl3?=
 =?iso-2022-jp?B?ekE4NEY2OE1uKzV1b01STmpueHdaU2hFeHNUYm14YW9RQWdxR0FqSzNv?=
 =?iso-2022-jp?B?MkZscmhOeVlJWlBoUnRzd2xkQlFGVTJTWVVoS2dNd1hxdHhFQnFwcmR1?=
 =?iso-2022-jp?B?SDBLdXNIK1l1VHErbnJiZU9DbTBscjVrOWRPaysrVEVLNWNOVXROc0xO?=
 =?iso-2022-jp?B?OURNODlCZ2RDYUxYMzE2TXVmQ3RLVHU4OFFka0xocjgzdnFNZHQyaTdX?=
 =?iso-2022-jp?B?M2dsY2MyWUFkZ2JXbGk5Nzk4MkI5M1FVamxpdDRyL2tKS3IySTYwMlRv?=
 =?iso-2022-jp?B?NmREY1djNFMzQkZ5aHU3NVhlajh2YnNlWTJHa0htU0hvZ1R3VEVwdHls?=
 =?iso-2022-jp?B?YTBhY3Y3ZUNPbU1QbTd1NWl0dzc2MGI1TmltOXVyWXEwTnZrNUZnN1Y1?=
 =?iso-2022-jp?B?V1oybWtGVHNXaEN5bjlLY3hXT2ZLWk1FZEQ5d3pCbUFlV2hIT095emR5?=
 =?iso-2022-jp?B?cFpNa3FGZEw4WEZ6Z254YTVvM2tPUjN3MCszQ2hoR0pMU2lHVjdOVXJ3?=
 =?iso-2022-jp?B?RmpoRmxvamFseWR2Mm9LVlV1K3VMVm0vK0I0RkdaR2wvUDY0UHhOZThq?=
 =?iso-2022-jp?B?QlIrSHlibEFXbDRML1hVN0dBcktacjJLRlZENDdWeTRvV2tnWU14R1Uw?=
 =?iso-2022-jp?B?alhYN1JkS3ZSNGJqMitYT3FKb2U4L09kQzk3TzhTTXZQYlBYVy9JYVZ5?=
 =?iso-2022-jp?B?K2MvUjczNk5ndVVreDJaaXdPY201TDZ6bW1KcXhhVjhNR2F2MFlNRUZM?=
 =?iso-2022-jp?B?YjFrc0tYUnorZjNqWitWVW5HWStMRXU1RkUybU1TSkVCNlVpTlBNajhD?=
 =?iso-2022-jp?B?QkRLTmhyVm5LL2d4NXJTd0ZLL3VRSG5GMVNSRVM4RWFNMStFaDJtTXhV?=
 =?iso-2022-jp?B?MmgxbFVBM2JkY1RTbjY1OFFFRWpjaVE2TUoyWUJJdTEvdU50bkhlQzF1?=
 =?iso-2022-jp?B?amFycHcxNTBYU0Z0eUMwZ0dVa3JzK1RTdkJZai9KUG9NSElndkx5VWMv?=
 =?iso-2022-jp?B?Zm5wcWZjQ3lYWkpDY1JOOXJSdkQ2MC84YklXdmFaK3Rvb1hMOC9CNGp5?=
 =?iso-2022-jp?B?bzdzdmpKOTQ1TE1Ib0NsWUNhcWVOcE15bnN2Sk4wdm1YK2RYQWU5N2NI?=
 =?iso-2022-jp?B?S0ZtdDdYWklvMTE0T0hwSXcwdmliQkx2YW1QekE0TzFwaXRybm1wMDhD?=
 =?iso-2022-jp?B?NTg5V1EyTHRaUGhnOHl5M282UkJ1T3l4eWJMbU1OQ3h6UXg2dk5FUEQ5?=
 =?iso-2022-jp?B?VjBWc25EYlowT1J0MkNid3FQMHNSeGVsaWtrODFwQ0RWZ2s2cHd6UXlx?=
 =?iso-2022-jp?B?VHhrUDVGRVFiTEw1L2tQQy9MSmZiZEx2bHpjMGhQZUEyaSt2MXByeTVk?=
 =?iso-2022-jp?B?eFdIckVhVXBJcTk1QlJuNzJsdXJrdWNCb255WldiZEt0UDBkQ1kwYnBG?=
 =?iso-2022-jp?B?OVhsMThyRlFEZHdxZFNZdUNqYjc0RXBYRnRTR2gwQTdPUGRtQ2hiUUhx?=
 =?iso-2022-jp?B?VzJhbC9qWnhlb3F6YmxOZ1doa1ZscHJubHRrLzcvTWpkRGtuRGx4dy9H?=
 =?iso-2022-jp?B?L2V5c1dVOC9aNXdVK3dnZ1VzbDNlSDJIbWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zEzwQGfw5zRdvfIZlQ+jVb8xh8Nbptn5BwOV9KaeFk5jALVaPng4xDGjYwoT8fkDm4P/2uFPBi0X536v5Ek5ugfBz15rdCJ9U8szR/WkLgbZPSNMUgw21pEpVvjabzsxzDEFg5Zo6Nxf9aUkwKPUkzBRl12dKmrbh5K/MLPOMAoaB2Vfik78stJvAiaAEX53FnvZTrzbDksp+MmwxR9HAIHgs9dCYIIbBM4OkPrsASNPpJG4w1r+FZ3wtYmFhJcWRGm1hp/NuIaiKBlgqh94mzIF3m1M37mdbqRanpsvW4CTDhrcvaiI6rLhXgT5QgWdQxPk13whKVof0MSqmNFX2gpJvH8HPpFb0e8zXM+OnNAXTjt7/O9rmHvECPPEf7SCKO4rniQMmET5ex8Zer9tdX9UAH3dWwZS/0XQkrCjU4D6iTeuc9cRR4GlrYtC0mVXxRu5+pzPbUEcQMgKXDtef6wN1UvRhXO0kLOFjArFxTo0QVC0HHtRPiLL4AWL+BHbGX7S9z/VGF7IbZEr7DI8Wwuxsa2Cf9c6xV5msCj94sxGkMbg8Cmie18D5ZqweE8/KJTxSkg8gjhoZAQRxGhLtJuyRHX+d7pETh5GnfcqPY9B6iW/1FDb69n4otnoLUN2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb535fd-34d0-498d-e2a6-08de16ba0d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:09:07.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZW5sq5EsRGD+3LABKpHHmtS493OKt3vxZLg18JBXaMa/IdETYhNtTvozHlSCLW2R9N+hrGtNMS4w76pMX4QLPeAZ8lIeL9sXJFlOdUeSCbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7361


> When CPUs come online the MSC's original configuration should be restored=
.
>=20
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate a
> configuration array for each component, and reprogram each RIS configurat=
ion
> from this.
>=20
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

