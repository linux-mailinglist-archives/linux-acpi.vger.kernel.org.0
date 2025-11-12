Return-Path: <linux-acpi+bounces-18795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E248CC50F3E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473A03B560D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9B2D6621;
	Wed, 12 Nov 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sGP7aTcA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010034.outbound.protection.outlook.com [52.101.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8602D29D6;
	Wed, 12 Nov 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932597; cv=fail; b=Dj/I5nH5yP0Y1GBQM68dfpZH/+2+BpXRENFUhwruo0GsUqq08hjkWNWCNvk3MMli8kZ3sEFXyESNby9jh1p7f8vVvQywE7KMMzhQJPzpxAQV8ggc/GxKZaDdY8w+bHQRKTderrXCaFuD+FTOaOQwt3cumEdKdkKhdd0ikFF+KNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932597; c=relaxed/simple;
	bh=FzerHsFUrXRPrGE8T3X28ndM5mrCqs2S2naLjKrXhuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I4IN7P5hLDBYUEMuP7EqXH0qVVncXysPl+B/EcQ9SrMJiP/KlgX6J66+moaAtnbBgldSlzUG/VK8ALCN6NrmyhMvp2R5RWv9ju0lFyBYsq5Aouwty/ZS1VY4yNSgCOPtG5ZS8c59k8yBkEvUJVDxl5qSPP1QbZKrDBvuEXv0mvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sGP7aTcA; arc=fail smtp.client-ip=52.101.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjqGap3nPkvD4HfQjlDOnHqDt1CjKk+5p+/oMLbUWNxUA0FVZ1blEllH6e3SQgRM1CRksLTnjLvXgEYnopVl3QprKam/MHlxXj6PI5E/H51mij825grJAhPQd79/peOdShTOHJkrIFrYeR3y0QpVJftWgteDfBwNyMDmsdasjmPu3mIIess1gj3uZ+cefcQN9quf6k+8MK7pXkttySsMg5zaplbe7jQnneah7hM/rAOtGiKwPdFfIEtV5ZzAY9/GchjONR7wgnkgr1v5bMvAUwTemSdJZ2cB6umS2wIgmxORzBIolkFYXyHIOB+BaZvNDv6zqeHFSlaYArLHXzbmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzerHsFUrXRPrGE8T3X28ndM5mrCqs2S2naLjKrXhuc=;
 b=nTHvGvquzQtGCpNp77nREmyZY6d+Rlz+WgvJ2zCjBarUkuSydKRH+GOGxV0KmhV44G07Wb8ey5dhe6fJhLZHWgGOPnvY1JUfCoDOd2/Tzr9pUA16scq/KSZGhZHcxTa8Enl/4++GN8cOG7AiduQoGpaoy1UYcG2OWsQ0sED0WgLeYwpjSUxX01Tb81/ruZg/YSdNNsTJRPNj30Vp1hcdvG8grS6QOs2hdGnFLxpYSKmWjeJcSkyKHWZJqo99PPsx/fJbOns+pDUO8gu97vude4TW3EXRqRG3h4wbGYDFKErHUNu5ByDgKDE9Dosago9psIygQxKrqOu/bDr7RFK6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzerHsFUrXRPrGE8T3X28ndM5mrCqs2S2naLjKrXhuc=;
 b=sGP7aTcA22ZElCcwPfwKVwpgVL5yjrru74dH/UFHOUGrJoOBjtZSVVzC58IHDeTluDr3rA6JIVgVcod2omKGUVCdQr1bLFA5RMMRkonsYBDDp/0zPfQ8EIbB2dRPqdgzn23yytBFxT2kPAkuk6C5U6Nop3yP1Kq4MRPJ1tI+ixo9P7jxLfmyUBDYGI4Y7Il5jZ1BTybTYZ7u0dT6GpkWWT+7LXaxScQxc8Zx6nTbCMgTIsM/awd5fxS8oIGObcoPb1p+5metizSqM2wrVjIpNhNFZE99dfNtjRX4Di2ZNZaTLPKOKjUBbXr67tIjFaGmD0Dnjx4ETCeVjfAcT6XZDw==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYVPR01MB11231.jpnprd01.prod.outlook.com (2603:1096:400:367::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:29:52 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:29:52 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Ben Horgan' <ben.horgan@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
CC: "amitsinght@marvell.com" <amitsinght@marvell.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dakr@kernel.org"
	<dakr@kernel.org>, "dave.martin@arm.com" <dave.martin@arm.com>,
	"david@redhat.com" <david@redhat.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gshan@redhat.com"
	<gshan@redhat.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	"jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"kobak@nvidia.com" <kobak@nvidia.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "peternewman@google.com" <peternewman@google.com>,
	"quic_jiles@quicinc.com" <quic_jiles@quicinc.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rohit.mathew@arm.com" <rohit.mathew@arm.com>, "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>, "sdonthineni@nvidia.com"
	<sdonthineni@nvidia.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"will@kernel.org" <will@kernel.org>, "xhao@linux.alibaba.com"
	<xhao@linux.alibaba.com>
Subject: RE: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
Thread-Topic: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
Thread-Index: AQHcT+MoDv4N99oeDkmRkmdNx9rFZrTuq0Fw
Date: Wed, 12 Nov 2025 07:29:52 +0000
Message-ID:
 <OSZPR01MB879881667D258F1C1F421A7D8BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-12-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-12-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=29119886-d389-47cc-9555-250387e8ad5b;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T07:25:26Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYVPR01MB11231:EE_
x-ms-office365-filtering-correlation-id: 0450eea9-db16-4f4f-7870-08de21bd4519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YU44RFE0NG80Z3k2Nkh5L3o3YXU3Rkxxb1VpSS96RDN0N3dtQjNkQ1dP?=
 =?iso-2022-jp?B?NTVWbHNXS0dhMHhqakJhTE43UWZnVzJzQlQvVFdUK29pN2hQejlRU3p4?=
 =?iso-2022-jp?B?b280K0NXV2trbmxXbHl6T1c2dlQ3R1RBbXU2VXFqZ3JYUUplR3R0MTRx?=
 =?iso-2022-jp?B?WVY4aGtUUkFQZGhVVm9hS3JqNzRzUnVIV3huU0lMbThFUVNTeW9mRUxx?=
 =?iso-2022-jp?B?MXRYdzRWNG05aVV4UDc0M3pacmRCWU91eVBUR1o4YmRMbis2cW1LbTFl?=
 =?iso-2022-jp?B?TUdFeUtQZVVadE9HYXEvTmlnOWpHTTdGR1l3cXVsUms1bXB0T0lGNW1l?=
 =?iso-2022-jp?B?dnRoQ0drdFlHa01BdVZUYlc4eExSSm55YVdpT2RkV01BMEllZE9tQjRz?=
 =?iso-2022-jp?B?Nm5rZ0p0Lzg0Zi9HYUZRSXNwdGpTamRpUlVjbjZHQW03OG9LdExyeHdH?=
 =?iso-2022-jp?B?SkxHTnVITFdaZGFIVGdncjcwUEpjcm1xUDVSMGlEcjhaVVlZTmE1ZGJ3?=
 =?iso-2022-jp?B?czR3bG1LRXhneHN2Z0c4TDhXdm02MUNIT08zTmdXWEtIUzN4YzdqVUpx?=
 =?iso-2022-jp?B?eHBtZC9IdkM2MGR3Q0J2ZEJWVzVkSmZqbUxwUjVLR2VOL3B4T21jYXpC?=
 =?iso-2022-jp?B?TUc4NHBYZGVQSE1LNys2M3VHdnVKSHlNNm9RWHZiOEFXMCtYbnA2S1c0?=
 =?iso-2022-jp?B?aGtYdnhTYXUwWldEZERYRFVFMmxEemxldFc0ZnVsaGFUdUZJT05ZNVRN?=
 =?iso-2022-jp?B?eVYwWjA2UG93bGhrU0JtZFRwYjFXWkpXVEhIQzEwN0dxTHJuVUhOVzBE?=
 =?iso-2022-jp?B?V0xkV29WaUZBYndkUWE3aC9Pa1B0citrSjZzMmoxZ0l2dWV5cmE3Mi91?=
 =?iso-2022-jp?B?R3I5TDJyTkpuM0VuM1lJK1NsODUxRy9Da3FjZzBQNTYvajNVb3lZcFE5?=
 =?iso-2022-jp?B?T1ZyNHN1RlRHNEFIamthSEUycjcvWnpJSWpicDlsY0wvR0wzZU52SEhB?=
 =?iso-2022-jp?B?TXFwV0hlR1I4VEk1VUdJTmswYnBOVElORVc4T1NGUHcxYU81ZTRjNlNk?=
 =?iso-2022-jp?B?QnR5OHZIQVJ6SjhHYzVMNU1rYVJJNWNjTFoxeUZRd2p5SVpYakVqUFQv?=
 =?iso-2022-jp?B?NW85NXVYNUd4Y3pYN0FRT3BnMGtjSTlIUERFT0pzZEJjbmtKYVA1NGZn?=
 =?iso-2022-jp?B?aVpVQjNGVGpoM2JDNzF0VHY5eDkrajJoTmxSWGxmUjBidTV2dmlTY3l3?=
 =?iso-2022-jp?B?NzB4T2JKSmYveXV0aDgwcTZjOHNqNzR4UTZrRndDM2lQMSs5emU2ZzN3?=
 =?iso-2022-jp?B?dTZ2WGFPWGNXUFdVL0pObE85NjhwRFNqT2NoUXRTYnMxUUkyOFlLMUFy?=
 =?iso-2022-jp?B?TS9rVXNQSUFRUG10VnVHRVladkVuMDM0NXJ4VGg5NE4rOWdtUnB5TzE3?=
 =?iso-2022-jp?B?YzltenJTenE0UjlmSExNelV1ZmxDQ2puNnBTeWZzVmVMb1J5Wkt4c2Y2?=
 =?iso-2022-jp?B?WjJPekhaTVJ0Y0txVnl1OHJ4NzY3RFplY0ZxSm1JVzVOVWkyWExHR200?=
 =?iso-2022-jp?B?Y2EyUXVqOE1XcU85bjBNMkltd29ZdFJuZmR2TUMweHVWVTFxM0Iwc3g4?=
 =?iso-2022-jp?B?cFEvVkxOSHY4YUNnNWQvc2xPZTBtTHZrZzcvQmdudlBBL1BPM3NuRkRE?=
 =?iso-2022-jp?B?V01vUXNCMTV2dlBUWjMvRytNWFlYcEtUUzRsNDNnQVNsN1BPamVMbE05?=
 =?iso-2022-jp?B?ZnZyMXFNaVp2djR0cjBvT1EzS1cxUnNHSFlhTGczWXh1TE1sWkE3K21I?=
 =?iso-2022-jp?B?YU9zR3NvRjB3NXVGQS9vVm85RStucU9raU5BbHZ5RzYvSExIUkN2TnBM?=
 =?iso-2022-jp?B?NisrSVphMTVnRURqRzQyeUc1eFc5VFFWVGtGamdySFVvSlJDdnZjb0pL?=
 =?iso-2022-jp?B?cHY0WVF5bzlaU2R1YU1vbDNDNWtUYlJtVFJrMlFrT3VFdFBTRCtPWkl6?=
 =?iso-2022-jp?B?SXQrZFFFQ2NSSkJDVmtQY3Y4L1pENzFpSVphc1ZrWGRyN0R3SFRmRnFj?=
 =?iso-2022-jp?B?dmQvWm1RZE5oVU14MkxNYnI1citDOXY1bi9JMUhhY3FNN0ltOXNkOW9N?=
 =?iso-2022-jp?B?WG5xVU9NYUw1cThMT05PeHZCSVQ3cUxFY2NKS2pMWlU0TVprNjdLN05W?=
 =?iso-2022-jp?B?UHVFVERHME45cGlJdU9NL1R3aE9hdjNIQnQweWpWcWR4alRkQ29vM0Vp?=
 =?iso-2022-jp?B?QzRyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bXBPc3pBQ2gvREljNytnRmRRZXArdG85aVA0UGJtVDNXUTUvNkVBZFVD?=
 =?iso-2022-jp?B?TkZveXdCTlkvWWwvREF1eU9WaW1MRmRyZVQ5SXlxSE5tcGYyS29hN3Nq?=
 =?iso-2022-jp?B?eldjYWEzcTREclMzMzdrbVVLaDVYRnZ5WHMwN1dGODRURXdhdmh0Qk1o?=
 =?iso-2022-jp?B?eE9BZTkwbDBmSXdsQk1WM3JaR0IvOGRiNlZXRlhGOC9CZWRIbmRxdk4v?=
 =?iso-2022-jp?B?L0w0K1U3bGx5OGRvZEtpSzA3S1NER0RQZHFmUENDcXlxM1Z2ZTJQOG9K?=
 =?iso-2022-jp?B?SWErNWRuS1hYanpVMkNUd0Z1VjdPd3VvV1dtRCtzUWl1WlNYNHo5M2ZS?=
 =?iso-2022-jp?B?VndFY2czUHZ0RUkvc0l1ZURTaEdPOGIwQVQyUVFwMWVmU0s4RGFxRkM0?=
 =?iso-2022-jp?B?eHA5YnlxTzdSTklMM0l4N2U2WmFuVTFvYWg5OWdEbmVhRy8za3g0NGw3?=
 =?iso-2022-jp?B?dk5Ud0w2MW1FMUZTS0QrWUd6dlN0N01QMkxGYnJkbGhsVnlWV3pjajJN?=
 =?iso-2022-jp?B?eFpZb3lrK2VLOXEvZHJXUWtmL291NDhLa2lNUzJlem9aSnpHd2F6cURk?=
 =?iso-2022-jp?B?VVNHd01DWXNJR1h5VFdPdEhOUjlseGNRc0NSa3EybFBiYzFOM3RwQzNJ?=
 =?iso-2022-jp?B?ZGdWNDZ0N2trYUhiekU3NWhoUHJmVE9KZ1Z6SzNrbU1WNWRrTUE5RmE5?=
 =?iso-2022-jp?B?OGtiMmxCWmFkY0xZNGgxcVlZdzVvUGRqMEZTM1ZuREd3dmtFOWx1NmY2?=
 =?iso-2022-jp?B?VzJmdnByL2xOcHJ3M0xoUmczcGlXMW55ZTBIMnZCNllsSVVNYzM1YTZP?=
 =?iso-2022-jp?B?M0E5SDUyamUrN0F2bXFQQ3lodlltQm8xbGtYSlZFZk5vVExsbEJzYkFv?=
 =?iso-2022-jp?B?eW5KcUoycC9lY0dsbytCOFEvRVI0MDMrRjBmTGQ0cWtsbU5XbkJqRk5D?=
 =?iso-2022-jp?B?VjBmdDJlSGt3VCtoejREZENDNWd1WlFTaGlxV2FPOW1MSVE1Q2JiVkJI?=
 =?iso-2022-jp?B?ZzBEZjg1Ky9aSTd5Q2FSWEVSSk1aQXpDeGZPVy9DRjNLNlh4c1lqR2Na?=
 =?iso-2022-jp?B?bE0vb3VlQ2hwRWp1aGtreDRQS2tudG1BMjBOc3M2V3liUWgyeWwwSjN6?=
 =?iso-2022-jp?B?RVJYc2NnVjNDWWZxbU1qWWxCTWxOUEFySHR3OHZLQ3ZBOTltYjAzZ0xX?=
 =?iso-2022-jp?B?b1lDamFmVFBkc00xc0d2M3VSaGMwc252UGhxcEtEOWdkdFNBamFjY1d0?=
 =?iso-2022-jp?B?RDNqQ3p2TGY1SksyQ1ZrdDBuY0FHaU1hc0RrMFFnek9JSERzQjdpT0tw?=
 =?iso-2022-jp?B?M2RoMjZHalNOa0R6VERjaFpsU2xrSGxFT1l2a1BDKy95am9kNzlZM2NJ?=
 =?iso-2022-jp?B?TmYzaHh6TDV4T0MzZ0t1TWVkTFJkV2p5elpTZFpRRU1VbldJRGM4c1hu?=
 =?iso-2022-jp?B?K0VtRm1HMnNMRXY5Ym5zN3pmS3RqZmYvQW95Wi9YMUx1dlBSb2lVM1d0?=
 =?iso-2022-jp?B?cFhZYnY3UjI4UTFNTGFHbDNtVHV0Zzd1NGdGQTk1NEwxTU42TDJEdHgz?=
 =?iso-2022-jp?B?K3BIb3VtWm5mTDQ2RVNKWEY1MXB4WVppQTBPZlJ0emIwdS9QWUxoT2Va?=
 =?iso-2022-jp?B?UTBBR3FLNjNwOXVOTHVQT0tpWldoZm9RR2Q1aUh6VVovS0dOd0x4UW15?=
 =?iso-2022-jp?B?NXd4WFZMS0xVSnJsRmFkWUpEcDRNbkZDZWtNelhvN1d4YjIwM0thZVZI?=
 =?iso-2022-jp?B?NjYvektrMUV3OWx0MHRUR1kzTmx3MHpZbmV1QTR2UjZkKzU3QXdIanhq?=
 =?iso-2022-jp?B?TkNjbi8rUkRkbEFRVWs3NWNtZ01HZzdIVEY5T1RJcE9jRlYzTnBLb2lK?=
 =?iso-2022-jp?B?VEpQQ2VTdHhTTm1ud2NHSlQwTXZtZjVhMGhvUlVSNVptbDBLZEQ1U0lJ?=
 =?iso-2022-jp?B?NkhBbGlDTHNCd2VxOFFERS9jNGpNQjVQNkZOMUNXNmRac3l6cTBNTmc0?=
 =?iso-2022-jp?B?WjBRSzVwd2RZc2xlaTVGcWx6VERmY1VEdkpIbmIyOXNNWitaeExUVThi?=
 =?iso-2022-jp?B?djdiR1ZKbUxOcU1OQ1hVYTh6MUlaNU9GRFRuMW14TVhYL0VtV0RwNjhU?=
 =?iso-2022-jp?B?N1FpbFJXa1hDZVRiaFEzOTFSUkMrT2N3UWFkT1FxbUNqQmJJZ2pxTVc0?=
 =?iso-2022-jp?B?aFlEZS9tRkMzZzNQZ0NSdDV6NFVjMkk3YnhmMW54ejZJMExYYWMyaVMw?=
 =?iso-2022-jp?B?QjFtVmZUWjMzam8zYXlsVm5YYitpYzNhS0dPNXlkeDN5NDdoTnR5RktH?=
 =?iso-2022-jp?B?RExzU2EvYkJTcysvQjA4czB3RnpHU0pWbUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0450eea9-db16-4f4f-7870-08de21bd4519
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:29:52.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DvjBm6YNFYQWklbqdgbSbHTUXtBTgp7NTba3m0n95CBwgdeeKIAPj/0dVSKYvwNlw7fIMCsyKVXYBu1qj/a1jc1H/gEqSk2WoYe50xaAf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11231

> From: James Morse <james.morse@arm.com>
>=20
> An MSC is a container of resources, each identified by their RIS index.
> Some RIS are described by firmware to provide their position in the syste=
m.
> Others are discovered when the driver probes the hardware.
>=20
> To configure a resource it needs to be found by its class, e.g. 'L2'.
> There are two kinds of grouping, a class is a set of components, which ar=
e
> visible to user-space as there are likely to be multiple instances of the=
 L2 cache.
> (e.g. one per cluster or package)
>=20
> Add support for creating and destroying structures to allow a hierarchy o=
f
> resources to be created.
>=20
> CC: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

