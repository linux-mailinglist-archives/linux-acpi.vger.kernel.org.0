Return-Path: <linux-acpi+bounces-16533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FBB4AC40
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144984E214D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962431A547;
	Tue,  9 Sep 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jBd6QdMR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A321A436;
	Tue,  9 Sep 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417831; cv=fail; b=HsLVudH9afPLTYrAU0SmBSKNLiDJR0Hwm4o0iOj6ZTpQQLNq/UMzNFoQfERnFSC0xtZ91seitBR8n7ldDZS/6UT6LvAvxzJHM0DKRVlYC3P8aG+iCvwEV+ON8bNYuUEVfPaEaVWE4dGNmxcq08rDIM3ZvCucVuEDhiyqJnVje6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417831; c=relaxed/simple;
	bh=3VW/ipcRCJUuxcXPUfm9Xfmc6Oi8IHGp1YeqjiOnFys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpF8eU1KyuxehhSJCiND011iUQ6y1vHCxG+sn8D7jwi5lWwT0FTA1Hs/6s1znx4iYvaUR47EC7nQsYhsBmq1ZaVP5HxG1epTwM+1kju+H2nZbaVV0RsRKJKQoRbkxuIN8rFJeE3mkOrVQtSE3BEYILUsqtzMDGt2tcpxfKPYS3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jBd6QdMR; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757417829; x=1788953829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3VW/ipcRCJUuxcXPUfm9Xfmc6Oi8IHGp1YeqjiOnFys=;
  b=jBd6QdMRu5q8drIRk6yGWZ3kfmNg2cIPDlMZDACve67eplu+hU2kbA43
   WUx7n2WhMRdM84krFtwCKjO+7sC6qrmX7R0fYD/ybNaGAragXBU7kxsjn
   CWRrV2tLEIScr3sOox0KQ5C57YpwELSnFtKaBkfy3K27t4xn39X0LgicO
   QElhjpfZ3446jDZvslQap4ev/BQqEJI8H7tuMjBgHyj2IQa2yxvoyuAKc
   CdH0pwZilxBlqzzO2qI7f96FGvVrZbR6oGsd6UqhP7Oi3GddjW5KjG/qa
   JpYxqkGo1vE+/r7noDvUQ9xNvKHcwa/67kWateKVgYa6RdDzWGOTHnQGu
   w==;
X-CSE-ConnectionGUID: M9takA6RQSizY74JXSFiQQ==
X-CSE-MsgGUID: Dz/6cwfLR1WGMT952CLX7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="167215059"
X-IronPort-AV: E=Sophos;i="6.18,251,1751209200"; 
   d="scan'208";a="167215059"
Received: from mail-japaneastazon11011000.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 20:36:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RH0+bNh3l52ViDprfdQzgFu4C+qC4M9U1DnQN6OdTvxeXiM0NvMkXFpUA1PFkK0OaHEXKY0lapeQSzcyeuFn02CjbrHRAQAt90nQ/a97lrAquuodPb22oNcDUc1ux5zAM1zjAn10Sr/XA42tGDoNDDs/O0TIlOLXoNbc91U+BpgMMhuSMVo3dE+J5j0PoreRsNRBBBRKOQrEFQwqlnpo4AlzlOARaLTscrlWnKug2sW1fupGAAvRQGg8PbnJGliDxp7G+kP96tbz8ZI3fgXDEI7Nds1RICT+UF1lsnGDqJr7qo4p7nk4AllaRTepKZTe/ZagYL8HIAAOjuY+xhZPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq0p6mxIWADkiCSXioIJ82TQ/FTnr9fZ/6Yih15al2g=;
 b=H5+a2dFrUBZWFMiR+3XW+Fk5DLdul169MoJX621fHLfOQWX7iWRyK8CKieYFH0ISxyTVbn1xTQTs/grye0l4CC9iLD/aaz5mBLYBjiZZ6V2RBsPetrZjzJ5XLEXDuj60xKeV7qwSQrl0VDgnby/eAe+8cxFZ6VO24QBuUvhNKGnJMAnBsRT7tq3p+CeTP5wUWJdhsXuxlZrdpJ5FRydkclWHfOEbZjUhTtCHEfJWCnEqLb4pDU5quE4CtNWhDoWk/U7r6dJsJ4evKE9e43I5qxVkqvzFoW8M1W8PpZsHkhhEtmK0ImJC78RapQBZPiRvpSe0xyXWmo0t0StVG4QN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB7267.jpnprd01.prod.outlook.com (2603:1096:400:f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:36:54 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 11:36:54 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, Rohit Mathew
	<rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
	<dakr@kernel.org>
Subject: RE: [PATCH 13/33] arm_mpam: Add MPAM MSC register layout definitions
Thread-Topic: [PATCH 13/33] arm_mpam: Add MPAM MSC register layout definitions
Thread-Index: AQHcE3n2/K4dEmk7nkus3Gj6lfv41LSK1HIQ
Date: Tue, 9 Sep 2025 11:36:54 +0000
Message-ID:
 <OSZPR01MB879842246E3C0640BF60276D8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-14-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-14-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d6f4ae50-ae71-4600-a4a7-29e33e1802e2;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-09T11:34:27Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB7267:EE_
x-ms-office365-filtering-correlation-id: bfc7950d-7570-4f9a-783d-08ddef952d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|1580799027|13003099007;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Wk16SG8wSFg5YzFsS3R1cDE1YlJWUDJKcmw3Z1pLOG1WSWlWMkxhcFBx?=
 =?iso-2022-jp?B?WmtCcjlIUXdaR0VwaTJXVnpTSHVqeUVHS1JqRlVLOXdpM2NCTWpRQ2JT?=
 =?iso-2022-jp?B?RXdmYjdDaEtrc3R0d0xva0tORENkQll5aHQrdTRNVzVMQXJxZkRUeTIz?=
 =?iso-2022-jp?B?dW5VblN2ZmlGNDNqRmdnbkJmdWIwZjg1bk1CNUxEWUVpYUgrMVh1VGhi?=
 =?iso-2022-jp?B?Ym5BblA0bnRLWlBua3A2aEJTKytSZGs5SXY3YVhBWW5QdXpoT01INjFx?=
 =?iso-2022-jp?B?ZDlFZUxLK3JyVjd0bkhFZTVoNG5ibmRzRTBFU1JkK1BMQWdXVENMa2JJ?=
 =?iso-2022-jp?B?Rzh5dDNqUlBBbVNIajJiZ1hwS1NxdjFmOTl1eHVxY3JjYlV0dzdkbVJP?=
 =?iso-2022-jp?B?UFBoWi95UWp5RU4va3RDZm02ZTlyQ3EvUi9Rd09UWDVZOHZCM3NJUld0?=
 =?iso-2022-jp?B?SDZ1dkpnYmlCNnEreSt0cjhiZXZFWk02cnJOOTd5bXdXRXhUVGc3SFk0?=
 =?iso-2022-jp?B?VE1HZUZuWjJ4U21sV0t5TU4wZHU5NktBNDNqS3JoNS84ZTVVS0dOSldG?=
 =?iso-2022-jp?B?ait5UXlMMSs0M3kvSGJvUExjbjRJbFNxTUJ5clpCejAwOSsrazNpbmtB?=
 =?iso-2022-jp?B?TDhyRXdRc0VseE5lY1E3emVLcm9HcjBRNkYvYll4cTJEdUZFOXpsSHFk?=
 =?iso-2022-jp?B?TkpacFltemUvZHNndWJUaWcrSVVrdjJYbEM1cVluWGNZWXl1WWJGOEho?=
 =?iso-2022-jp?B?OU9ac013OXVDNHlKN2tlU0lMMEtyZi91YnNsMnlka1VvOGRTNzM5c2Fn?=
 =?iso-2022-jp?B?NzFGVUkvWnZNem5XMExiZ0ZEaFJ6bTFCYjR6ZFFoOGRIaDE5RDhoK1ZF?=
 =?iso-2022-jp?B?YVVITEc1L09HMUF5bnlmTGIzZFFwUlJ0SUpJNjJoaWlocGV6dU1mZTlI?=
 =?iso-2022-jp?B?UGZiWjcwV3pBSjluZHlnd1laVUZvWFdjaDJXTXZyMnRDdHBMekJPLzgr?=
 =?iso-2022-jp?B?VExRSEtxMFczaWQwZ0VzWGhuNUV3U1NHc0xvL2FUdXRCZkk3WFpuWjlt?=
 =?iso-2022-jp?B?aUJIa0ZxWFFtOWdzNkI2U2NTWFFIZy9YcEZ2UGI1b0UrVkh0UGFtMGdv?=
 =?iso-2022-jp?B?REFXKzJUQStCUDU1akQ4MmZnMmJoRVFRY2grRzRqT1p0SW9zbFJjZy85?=
 =?iso-2022-jp?B?ZkN5WkdUM2cvUlJZRnBHUXVubnRMT05yZ1dPRUZVcUdsY3Y5ZUlCOW1x?=
 =?iso-2022-jp?B?Sytvc2pKUVJEMXVmdWJLS1BNSWJaaWVQZThCcy9BSWlxMWVuQXNDNjlX?=
 =?iso-2022-jp?B?aEs1eS9zN3ozVTNYbElmNzRIV3ZTVzUwekhIcldOZUdsY0FyWENwVDRN?=
 =?iso-2022-jp?B?VDVkTUhOSTRXN1dqV0QzR0szRWdiMHNFVkpqU0dvdlI2TUZMZU5uVjZw?=
 =?iso-2022-jp?B?NW9QNUk1UFpIRGxoS0xkT3hHN2xPaHRNSXZhY2pHTEUxNDgzUllKRVlv?=
 =?iso-2022-jp?B?VGpHRmFkbG9GZ3dvV0lMZ1NyT3NmTlFsK2NsbWJ1UUl0R2ZnZi8yL3Fj?=
 =?iso-2022-jp?B?ajFldjlxL3dFNENCSzdrU3RqTUlDbDYyMUJXcFRjZXdzUGhxNDdsQkJS?=
 =?iso-2022-jp?B?cklBZDRWTVVtbnA3eGtLU09XVDBnUWhOYnZmUFhCck5DNGU1U3N6WkxM?=
 =?iso-2022-jp?B?dVNIWUpLN2dYeWtYYnQ0UnhzVVRFSFd1SmFsaW4wYU43NTZVOTB6amtZ?=
 =?iso-2022-jp?B?akVFVnYzMTY5clBoL251OWZkWkJlR0lCNE41cktONnRDb3hGTFI4U0pN?=
 =?iso-2022-jp?B?N3dkTlB5eHBJc1VERHJBaGtJRGlKSlZ4RllWZ2tBVTR1ODNoTlJBWWdD?=
 =?iso-2022-jp?B?S3Jra28wY002cE5RQWYvK3JJeWN2cmdvVTBPZW9PN2dDZE1JSWlac0h2?=
 =?iso-2022-jp?B?YVY4eU1vUGl2eSttNVNTMHE3S0RlYndxajJXMy9mamtRRmh5LzVsMnJR?=
 =?iso-2022-jp?B?L3BybkUyaTluOXlFNlFPUFQ2cjV5ZnRlcHNJb25FYVBkZEdwS0UwOEw2?=
 =?iso-2022-jp?B?MDV5djFOSENSSmJLdEpjam9KeXNnTi9zbU1vbkF4ZnMvV21kbFNMODJN?=
 =?iso-2022-jp?B?dndiYWZXeW5vM1RCWGQ0Wms3eHNHaGNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(1580799027)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RktPK1g5Vkd2SnJLNzlnRlpVSmZKeEJxOWlCbTVLUGl3bmkrREU1bmdG?=
 =?iso-2022-jp?B?NWYvNnVlRmtlcnZzYkhXVmJJZnJtdnkxRTRCYVRVOVYwV1pTcDBoU3d4?=
 =?iso-2022-jp?B?UWpTaDlGSzlKaEpSZGFlNTFJSzF0SHJ1d3N3V2ZYQzgrRXd5OFRmUTNy?=
 =?iso-2022-jp?B?VldPU1RxZUhrT2NVOHYzc0h6TmFuNHFWd21CTGdWUDh6cTZtNXlZMVhr?=
 =?iso-2022-jp?B?eWtvbFJJcnF2TjNOa3oraUhmMnNYMlN5bnhTRFNDR0tPRGFjYWlpLzBz?=
 =?iso-2022-jp?B?Mi9yaFJXYnJLL0diZWx1ZDBQWldSam5pYmdUL0FUTksvRVdoK3JnblVa?=
 =?iso-2022-jp?B?ZU81dGtVTktyNnZDV2lzQ2Z1RktiYUE0R0dyVU9VckhGV2Z1ZytuMG5Q?=
 =?iso-2022-jp?B?dnlsNTZjRGo1VmhqZUZCU3AzT2J0dytwcU0yNEY1ZWdTclIwZjlkZGUr?=
 =?iso-2022-jp?B?OUpJVWkyQk9lM200VG85UVkraUpZdWVUNU1YZkg0MEJ6SkhtS0N3Qldv?=
 =?iso-2022-jp?B?TG5JbWJ6OHFXaFNmd0ZUOTBibU5SemZFdjZMOWpvSy9mTDBEaWxSVUoy?=
 =?iso-2022-jp?B?RERwNm9HSEtma0U1d1J4NjFaMlJyRDN1YU53dVZBbS80UGRsamVKdkFE?=
 =?iso-2022-jp?B?bVlIR1RDM1FZWXZqZ2V4WHlPcHZxalQxUVljNmU3blBmZWtXQ1c2TENX?=
 =?iso-2022-jp?B?VkoyTlVyTnRlSXllclFhT1VyV1MySEZ5RFo4ZFlGTjgrZ3p1RVBZand6?=
 =?iso-2022-jp?B?dUVaQXo5SEVRRDJYSGVQa2J0Q2NmT3NDY3FUbU55YmkwWFNSVzlYUmZY?=
 =?iso-2022-jp?B?SlB2YVZsN052L2l0T3JKT1Bvd3E5dTA4aHdUNWJ4cG1OdjcwYWhwNTQ3?=
 =?iso-2022-jp?B?RG9oSENod0k0anBGdkF1YmR0elJFZ2xIUkJZMzYrelJ5MHEvaG5Gc0U0?=
 =?iso-2022-jp?B?YzlieDBYeUE1bFdXeHNidnBoSHBKY3RqL241RGc5UEQxeHptQXExd2VU?=
 =?iso-2022-jp?B?ZE5IWS9rOVRzclNQcjMxZnBTQmhGTHNoVFM4NE5XaXpseU1pSWZBU2Fa?=
 =?iso-2022-jp?B?bjRsQ0lQQUZ3eFduWHFQd0N1aXlkVjdKWEQrLzZPb2VHclBZd21kRThl?=
 =?iso-2022-jp?B?bFlZWStMRzk4ZzhZUVFnVk9tK29jNnRhb1VKVDM1bERwSU5JdWkzeTVy?=
 =?iso-2022-jp?B?Z3pkcVE1U3o0L2ZyTjByME8vdXBoU05hdnkyWjFPcG9QZ1lYejdBQm9Z?=
 =?iso-2022-jp?B?WjBMeWNTRW90WEJyWGg4SnE2Zjc3MVE2OW9XbUE0QTJ2REpEQTZrUzk5?=
 =?iso-2022-jp?B?THBvTFRUY09iT1l1RnZveHJnSFp2N0p3VDBMVlNHUFVaZU5sRUhZTEJy?=
 =?iso-2022-jp?B?NmkxUkVicU1zM2tpQ1dsV2dEZFVJUFhoOVdDVDdEenV6NmQzZFBrTG1F?=
 =?iso-2022-jp?B?ays5bmpkeDROcVVZeS9QK2d1N1Y5amFjQWt0a0ZrMWVNTFJMWWtLajla?=
 =?iso-2022-jp?B?UDVKTU9xcC93MnNPclQwb0lYY2xwTURPNVFyb0t5VHpicGFwR2RwZ0d5?=
 =?iso-2022-jp?B?T09KN3l5bXpkQkhwemhvK2plQnNrQWRSSS9VZ0Y5emg4NXNwankxUW0v?=
 =?iso-2022-jp?B?NDhVeTdGT3J4YzU5SzdvYzJYaVFDWVVmd2xLd09YV2UwOWNNZ3BuUEJm?=
 =?iso-2022-jp?B?TGt4R3ZNc0IwMlpkNm4zOFB6bGIzaVNpUTJxY29Jb1h0MjJWQlNaanF2?=
 =?iso-2022-jp?B?OENVQnJCNkF3b0FBTkRmeFE1MEMwQmI1SERrd3JqazR4MldmYVlnMmta?=
 =?iso-2022-jp?B?RVZvLzY5ME40eFIvb0FyampaU2ZPQldYaGFvMlo5NGYxNmQxenY3YXI1?=
 =?iso-2022-jp?B?MnNSSEJpQTA4N0dDOWwrU1FrZllobWZicTcyRHlkK2ZFNGx4aW9VSXlo?=
 =?iso-2022-jp?B?am5pRUt0d05abzVYNjdLaFlSSDB5dHl2MWVhbGFlWTlpUkhCZ1JlblpZ?=
 =?iso-2022-jp?B?TmVLamxFcG1ra282SHFoT1Q1ek5KNHQ5elM4ZTB0ZnlYOUU2ZGEycFRi?=
 =?iso-2022-jp?B?dWsyTXhHV0UwaDdNUXRsQzliRmw5dlZHV294K0xObDc3Y0xwb0RMektX?=
 =?iso-2022-jp?B?bW90T0JzMmZuY3RwNkJ3MkVUTEhpUWQydmY3QjVaNFpnK3JzRWZUUFFU?=
 =?iso-2022-jp?B?T0UzNEs5SWl2c0Faa3Noa0crdmhHNG04aE9HVUZMTXpwaTVLVEU3eDIx?=
 =?iso-2022-jp?B?M1hOdjljMjkxSGNaTGVwTjdMa1YxYzJRanE4bmdYd3dZazJ5S1lvVUly?=
 =?iso-2022-jp?B?QjFkYkw5eWtxQnBrQ3ZjTzZnT2Z5ME5aL2c9PQ==?=
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
	H5Urm6qffBA6qLkyYac8Xu/YZ0NnhK+lT+12XASZSMJVmHuR+g5LiYQImLWdGgoWKHn2lFvaQMoB1QNCUUBuSg2OsdFbinSfRf5/XD3y1XeOa1+UOTgCaYZPCF5Pz6Yk6mCmnomLtYnWQp1y+XoGQtDlA9cGz5I7s1OQXCka6VjfAr4ZE55SodWpgYCWlCuU+/8kM09FVy0qMmwoNfhLWyJfqPFaDWEmCs1Y/qU99QiaemUGjMDGPblD+bQOFbH2yFJ8/bgTeskfyVx3zWr7lsdBG35zy7njeKloK1l/XrfW0TdGWbdHErmjboGCbL7TiyzZX2MdQHJWZ/DPR77QUmmd6JFvBcigVF7jvJ1HSDzkd7B1+0B/Lnd3mToxQTEQWP9Ns8tG4rzGzjBVlwIGqxdpo8UrPp6i0wMG9OqT1nwGhwC6rKkBLz4N2xCZfwkkyOrUDw7RUwxwHaeYjRRhZ8HNe+cQfPjvRTNqqDS/+EbJU+cewdtUDqMUcxNAX5QXDN25CIKdKzg6jAeCaPdH2XUtM3H38q45eeGhf1g2GbQxcR4FjTk+DVZMwMSUJ0ch+AQ0m534vRS/Zfb+z7G+dwvnxySG6PcBmR8tIkd0r9RCnhbNBZI+86fflBHn4yyb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc7950d-7570-4f9a-783d-08ddef952d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 11:36:54.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXb96lrhGBWsXMPAWFKQhtkSO73SWU2Vqkr2iWsptQ98ZtnkbwSAcCtWAyqVXgHeioSL1WL5xTZwTTFZxBbMfGssGu8IMXK4Tgg3UHxftUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7267

Hello James,

> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
>=20
> Add the definitions for these registers as offset within the page(s).
>=20
> Link: https://developer.arm.com/documentation/ihi0099/latest/
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Renamed MSMON_CFG_MBWU_CTL_TYPE_CSU as
> MSMON_CFG_CSU_CTL_TYPE_CSU
>  * Whitepsace churn.
>  * Cite a more recent document.
>  * Removed some stale feature, fixed some names etc.
> ---
>  drivers/resctrl/mpam_internal.h | 266
> ++++++++++++++++++++++++++++++++
>  1 file changed, 266 insertions(+)
>=20
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_inter=
nal.h
> index d49bb884b433..6e0982a1a9ac 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -150,4 +150,270 @@ extern struct list_head mpam_classes;  int
> mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>  				   cpumask_t *affinity);
>=20
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> + * Component Specification.
> + * https://developer.arm.com/documentation/ihi0099/latest/
> + */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages: */
> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR		0x0000  /* features id register */
> +#define MPAMF_MSMON_IDR		0x0080  /* performance monitoring
> features */
> +#define MPAMF_IMPL_IDR		0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR		0x0030  /* cache-portion
> partitioning */
> +#define MPAMF_CCAP_IDR		0x0038  /* cache-capacity
> partitioning */
> +#define MPAMF_MBW_IDR		0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR		0x0048  /* priority partitioning */
> +#define MPAMF_CSUMON_IDR	0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR	0x0090  /* mem-bw usage monitor
> */
> +#define MPAMF_PARTID_NRW_IDR	0x0050  /* partid-narrowing */
> +#define MPAMF_IIDR		0x0018  /* implementer id register */
> +#define MPAMF_AIDR		0x0020  /* architectural id register */
> +
> +/* Configuration and Status Register offsets in the memory mapped page *=
/
> +#define MPAMCFG_PART_SEL	0x0100  /* partid to configure: */
> +#define MPAMCFG_CPBM		0x1000  /* cache-portion config */
> +#define MPAMCFG_CMAX		0x0108  /* cache-capacity config */
> +#define MPAMCFG_CMIN		0x0110  /* cache-capacity config */
> +#define MPAMCFG_MBW_MIN		0x0200  /* min mem-bw config */
> +#define MPAMCFG_MBW_MAX		0x0208  /* max mem-bw
> config */
> +#define MPAMCFG_MBW_WINWD	0x0220  /* mem-bw accounting
> window config */
> +#define MPAMCFG_MBW_PBM		0x2000  /* mem-bw portion
> bitmap config */
> +#define MPAMCFG_PRI		0x0400  /* priority partitioning
> config */
> +#define MPAMCFG_MBW_PROP	0x0500  /* mem-bw stride config */
> +#define MPAMCFG_INTPARTID	0x0600  /* partid-narrowing config
> */
> +
> +#define MSMON_CFG_MON_SEL	0x0800  /* monitor selector */
> +#define MSMON_CFG_CSU_FLT	0x0810  /* cache-usage monitor
> filter */
> +#define MSMON_CFG_CSU_CTL	0x0818  /* cache-usage monitor
> config */
> +#define MSMON_CFG_MBWU_FLT	0x0820  /* mem-bw monitor filter */
> +#define MSMON_CFG_MBWU_CTL	0x0828  /* mem-bw monitor config
> */
> +#define MSMON_CSU		0x0840  /* current cache-usage */
> +#define MSMON_CSU_CAPTURE	0x0848  /* last cache-usage value
> captured */
> +#define MSMON_MBWU		0x0860  /* current mem-bw usage
> value */
> +#define MSMON_MBWU_CAPTURE	0x0868  /* last mem-bw value
> captured */
> +#define MSMON_MBWU_L		0x0880  /* current long mem-bw
> usage value */
> +#define MSMON_MBWU_CAPTURE_L	0x0890  /* last long mem-bw value
> captured */
> +#define MSMON_CAPT_EVNT		0x0808  /* signal a capture event */
> +#define MPAMF_ESR		0x00F8  /* error status register */
> +#define MPAMF_ECR		0x00F0  /* error control register */
> +
> +/* MPAMF_IDR - MPAM features ID register */
> +#define MPAMF_IDR_PARTID_MAX		GENMASK(15, 0)
> +#define MPAMF_IDR_PMG_MAX		GENMASK(23, 16)
> +#define MPAMF_IDR_HAS_CCAP_PART		BIT(24)
> +#define MPAMF_IDR_HAS_CPOR_PART		BIT(25)
> +#define MPAMF_IDR_HAS_MBW_PART		BIT(26)
> +#define MPAMF_IDR_HAS_PRI_PART		BIT(27)
> +#define MPAMF_IDR_EXT			BIT(28)
> +#define MPAMF_IDR_HAS_IMPL_IDR		BIT(29)
> +#define MPAMF_IDR_HAS_MSMON		BIT(30)
> +#define MPAMF_IDR_HAS_PARTID_NRW	BIT(31)
> +#define MPAMF_IDR_HAS_RIS		BIT(32)
> +#define MPAMF_IDR_HAS_EXTD_ESR		BIT(38)
> +#define MPAMF_IDR_HAS_ESR		BIT(39)
> +#define MPAMF_IDR_RIS_MAX		GENMASK(59, 56)
> +
> +/* MPAMF_MSMON_IDR - MPAM performance monitoring ID register */
> +#define MPAMF_MSMON_IDR_MSMON_CSU		BIT(16)
> +#define MPAMF_MSMON_IDR_MSMON_MBWU		BIT(17)
> +#define MPAMF_MSMON_IDR_HAS_LOCAL_CAPT_EVNT	BIT(31)
> +
> +/* MPAMF_CPOR_IDR - MPAM features cache portion partitioning ID register
> */
> +#define MPAMF_CPOR_IDR_CPBM_WD
> 	GENMASK(15, 0)
> +
> +/* MPAMF_CCAP_IDR - MPAM features cache capacity partitioning ID
> register */
> +#define MPAMF_CCAP_IDR_CMAX_WD
> 	GENMASK(5, 0)
> +#define MPAMF_CCAP_IDR_CASSOC_WD		GENMASK(12, 8)
> +#define MPAMF_CCAP_IDR_HAS_CASSOC		BIT(28)
> +#define MPAMF_CCAP_IDR_HAS_CMIN			BIT(29)
> +#define MPAMF_CCAP_IDR_NO_CMAX			BIT(30)
> +#define MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM		BIT(31)
> +
> +/* MPAMF_MBW_IDR - MPAM features memory bandwidth partitioning ID
> register */
> +#define MPAMF_MBW_IDR_BWA_WD		GENMASK(5, 0)
> +#define MPAMF_MBW_IDR_HAS_MIN		BIT(10)
> +#define MPAMF_MBW_IDR_HAS_MAX		BIT(11)
> +#define MPAMF_MBW_IDR_HAS_PBM		BIT(12)
> +#define MPAMF_MBW_IDR_HAS_PROP		BIT(13)
> +#define MPAMF_MBW_IDR_WINDWR		BIT(14)
> +#define MPAMF_MBW_IDR_BWPBM_WD		GENMASK(28, 16)
> +
> +/* MPAMF_PRI_IDR - MPAM features priority partitioning ID register */
> +#define MPAMF_PRI_IDR_HAS_INTPRI	BIT(0)
> +#define MPAMF_PRI_IDR_INTPRI_0_IS_LOW	BIT(1)
> +#define MPAMF_PRI_IDR_INTPRI_WD		GENMASK(9, 4)
> +#define MPAMF_PRI_IDR_HAS_DSPRI		BIT(16)
> +#define MPAMF_PRI_IDR_DSPRI_0_IS_LOW	BIT(17)
> +#define MPAMF_PRI_IDR_DSPRI_WD		GENMASK(25, 20)
> +
> +/* MPAMF_CSUMON_IDR - MPAM cache storage usage monitor ID register */
> +#define MPAMF_CSUMON_IDR_NUM_MON	GENMASK(15, 0)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_CAPT	BIT(24)
> +#define MPAMF_CSUMON_IDR_HAS_CEVNT_OFLW	BIT(25)
> +#define MPAMF_CSUMON_IDR_HAS_OFSR	BIT(26)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_LNKG	BIT(27)
> +#define MPAMF_CSUMON_IDR_HAS_XCL	BIT(29)
> +#define MPAMF_CSUMON_IDR_CSU_RO		BIT(30)
> +#define MPAMF_CSUMON_IDR_HAS_CAPTURE	BIT(31)
> +
> +/* MPAMF_MBWUMON_IDR - MPAM memory bandwidth usage monitor ID
> register */
> +#define MPAMF_MBWUMON_IDR_NUM_MON	GENMASK(15, 0)
> +#define MPAMF_MBWUMON_IDR_HAS_RWBW	BIT(28)
> +#define MPAMF_MBWUMON_IDR_LWD		BIT(29)
> +#define MPAMF_MBWUMON_IDR_HAS_LONG	BIT(30)
> +#define MPAMF_MBWUMON_IDR_HAS_CAPTURE	BIT(31)
> +
> +/* MPAMF_PARTID_NRW_IDR - MPAM PARTID narrowing ID register */
> +#define MPAMF_PARTID_NRW_IDR_INTPARTID_MAX      GENMASK(15,
> 0)
> +
> +/* MPAMF_IIDR - MPAM implementation ID register */
> +#define MPAMF_IIDR_PRODUCTID	GENMASK(31, 20)
> +#define MPAMF_IIDR_PRODUCTID_SHIFT	20
> +#define MPAMF_IIDR_VARIANT	GENMASK(19, 16)
> +#define MPAMF_IIDR_VARIANT_SHIFT	16
> +#define MPAMF_IIDR_REVISON	GENMASK(15, 12)
> +#define MPAMF_IIDR_REVISON_SHIFT	12
> +#define MPAMF_IIDR_IMPLEMENTER	GENMASK(11, 0)
> +#define MPAMF_IIDR_IMPLEMENTER_SHIFT	0
> +
> +/* MPAMF_AIDR - MPAM architecture ID register */
> +#define MPAMF_AIDR_ARCH_MAJOR_REV	GENMASK(7, 4)
> +#define MPAMF_AIDR_ARCH_MINOR_REV	GENMASK(3, 0)
> +
> +/* MPAMCFG_PART_SEL - MPAM partition configuration selection register */
> +#define MPAMCFG_PART_SEL_PARTID_SEL	GENMASK(15, 0)
> +#define MPAMCFG_PART_SEL_INTERNAL	BIT(16)
> +#define MPAMCFG_PART_SEL_RIS		GENMASK(27, 24)
> +
> +/* MPAMCFG_CMAX - MPAM cache capacity configuration register */
> +#define MPAMCFG_CMAX_SOFTLIM		BIT(31)
> +#define MPAMCFG_CMAX_CMAX		GENMASK(15, 0)
> +
> +/* MPAMCFG_CMIN - MPAM cache capacity configuration register */
> +#define MPAMCFG_CMIN_CMIN		GENMASK(15, 0)
> +
> +/*
> + * MPAMCFG_MBW_MIN - MPAM memory minimum bandwidth partitioning
> configuration
> + *                   register
> + */
> +#define MPAMCFG_MBW_MIN_MIN		GENMASK(15, 0)
> +
> +/*
> + * MPAMCFG_MBW_MAX - MPAM memory maximum bandwidth partitioning
> configuration
> + *                   register
> + */
> +#define MPAMCFG_MBW_MAX_MAX		GENMASK(15, 0)
> +#define MPAMCFG_MBW_MAX_HARDLIM		BIT(31)
> +
> +/*
> + * MPAMCFG_MBW_WINWD - MPAM memory bandwidth partitioning window
> width
> + *                     register
> + */
> +#define MPAMCFG_MBW_WINWD_US_FRAC	GENMASK(7, 0)
> +#define MPAMCFG_MBW_WINWD_US_INT	GENMASK(23, 8)
> +
> +/* MPAMCFG_PRI - MPAM priority partitioning configuration register */
> +#define MPAMCFG_PRI_INTPRI		GENMASK(15, 0)
> +#define MPAMCFG_PRI_DSPRI		GENMASK(31, 16)
> +
> +/*
> + * MPAMCFG_MBW_PROP - Memory bandwidth proportional stride
> partitioning
> + *                    configuration register
> + */
> +#define MPAMCFG_MBW_PROP_STRIDEM1	GENMASK(15, 0)
> +#define MPAMCFG_MBW_PROP_EN		BIT(31)
> +
> +/*
> + * MPAMCFG_INTPARTID - MPAM internal partition narrowing configuration
> +register  */
> +#define MPAMCFG_INTPARTID_INTPARTID	GENMASK(15, 0)
> +#define MPAMCFG_INTPARTID_INTERNAL	BIT(16)
> +
> +/* MSMON_CFG_MON_SEL - Memory system performance monitor selection
> register */
> +#define MSMON_CFG_MON_SEL_MON_SEL	GENMASK(15, 0)
> +#define MSMON_CFG_MON_SEL_RIS		GENMASK(27, 24)
> +
> +/* MPAMF_ESR - MPAM Error Status Register */
> +#define MPAMF_ESR_PARTID_MON	GENMASK(15, 0)
> +#define MPAMF_ESR_PMG		GENMASK(23, 16)
> +#define MPAMF_ESR_ERRCODE	GENMASK(27, 24)
> +#define MPAMF_ESR_OVRWR		BIT(31)
> +#define MPAMF_ESR_RIS		GENMASK(35, 32)
> +
> +/* MPAMF_ECR - MPAM Error Control Register */
> +#define MPAMF_ECR_INTEN		BIT(0)
> +
> +/* Error conditions in accessing memory mapped registers */
> +#define MPAM_ERRCODE_NONE			0
> +#define MPAM_ERRCODE_PARTID_SEL_RANGE		1
> +#define MPAM_ERRCODE_REQ_PARTID_RANGE		2
> +#define MPAM_ERRCODE_MSMONCFG_ID_RANGE		3
> +#define MPAM_ERRCODE_REQ_PMG_RANGE		4
> +#define MPAM_ERRCODE_MONITOR_RANGE		5
> +#define MPAM_ERRCODE_INTPARTID_RANGE		6
> +#define MPAM_ERRCODE_UNEXPECTED_INTERNAL	7
> +
> +/*
> + * MSMON_CFG_CSU_FLT - Memory system performance monitor configure
> cache storage
> + *                    usage monitor filter register
> + */
> +#define MSMON_CFG_CSU_FLT_PARTID	GENMASK(15, 0)
> +#define MSMON_CFG_CSU_FLT_PMG		GENMASK(23, 16)
> +
> +/*
> + * MSMON_CFG_CSU_CTL - Memory system performance monitor configure
> cache storage
> + *                    usage monitor control register
> + * MSMON_CFG_MBWU_CTL - Memory system performance monitor
> configure memory
> + *                     bandwidth usage monitor control register
> + */
> +#define MSMON_CFG_x_CTL_TYPE			GENMASK(7, 0)
> +#define MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L	BIT(15)
> +#define MSMON_CFG_x_CTL_MATCH_PARTID		BIT(16)
> +#define MSMON_CFG_x_CTL_MATCH_PMG		BIT(17)
> +#define MSMON_CFG_x_CTL_SCLEN			BIT(19)
> +#define MSMON_CFG_x_CTL_SUBTYPE
> 	GENMASK(22, 20)
> +#define MSMON_CFG_x_CTL_OFLOW_FRZ		BIT(24)
> +#define MSMON_CFG_x_CTL_OFLOW_INTR		BIT(25)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS		BIT(26)
> +#define MSMON_CFG_x_CTL_CAPT_RESET		BIT(27)
> +#define MSMON_CFG_x_CTL_CAPT_EVNT		GENMASK(30, 28)
> +#define MSMON_CFG_x_CTL_EN			BIT(31)
> +
> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU
> 	0x42
> +#define MSMON_CFG_CSU_CTL_TYPE_CSU			0

+#define MSMON_CFG_CSU_CTL_TYPE_CSU			0x43?


Best regards,
Shaopeng TAN
> +/*
> + * MSMON_CFG_MBWU_FLT - Memory system performance monitor
> configure memory
> + *                     bandwidth usage monitor filter register
> + */
> +#define MSMON_CFG_MBWU_FLT_PARTID		GENMASK(15, 0)
> +#define MSMON_CFG_MBWU_FLT_PMG
> 	GENMASK(23, 16)
> +#define MSMON_CFG_MBWU_FLT_RWBW
> 	GENMASK(31, 30)
> +
> +/*
> + * MSMON_CSU - Memory system performance monitor cache storage usage
> monitor
> + *            register
> + * MSMON_CSU_CAPTURE -  Memory system performance monitor cache
> storage usage
> + *                     capture register
> + * MSMON_MBWU  - Memory system performance monitor memory
> bandwidth usage
> + *               monitor register
> + * MSMON_MBWU_CAPTURE - Memory system performance monitor
> memory bandwidth usage
> + *                     capture register
> + */
> +#define MSMON___VALUE		GENMASK(30, 0)
> +#define MSMON___NRDY		BIT(31)
> +#define MSMON___NRDY_L		BIT(63)
> +#define MSMON___L_VALUE		GENMASK(43, 0)
> +#define MSMON___LWD_VALUE	GENMASK(62, 0)
> +
> +/*
> + * MSMON_CAPT_EVNT - Memory system performance monitoring capture
> event
> + *                  generation register
> + */
> +#define MSMON_CAPT_EVNT_NOW	BIT(0)
> +
>  #endif /* MPAM_INTERNAL_H */
> --
> 2.20.1


