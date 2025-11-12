Return-Path: <linux-acpi+bounces-18793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658EC50D7E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7C7189C961
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5972C15BB;
	Wed, 12 Nov 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Or44eHx1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010012.outbound.protection.outlook.com [52.101.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2F278E63;
	Wed, 12 Nov 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930952; cv=fail; b=jtwiWFVENejkR60G3K8e5GZuJZO33U9wVuizQ+57ANTREQKvMeCfbrPvJ2TV06nY6DH9rKvIHWtm6wPfa4eHRUmKmZeskPR1iPm9BAB2grvMlGzG9MfGWVObG+K78S216XsxBFcxDQnp9P0Nn7Io+CIAbMIkY+PZ+lkXI5qaPiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930952; c=relaxed/simple;
	bh=IaxjYiuRNObt3DqSVc+eaCWAFQtnaZRQUxAQuK/k2v0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFnSB7inp6iK/GtDRkAepMV0+VbzK0ScvvaTEZ45kNmEdBjX/dRgyjrsJiQZ9dTXGw9SqQYdzwQ9PI8Cp6H9oz6qVdth2VTR7I0l4HXhRZVsChfTgNn1BhrP+DyglxP/htev8iP2c4iJfgtDIt2vBnJ7i/4GwccWCMsOAkPfIZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Or44eHx1; arc=fail smtp.client-ip=52.101.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJY7gX07Gj/uRrfppMEbMwRFon0d9aOhioPiVW3ZMOSUT/B44EKwQLxav73a0pj34gpA1nQ4k83qPjggnTMDJZvcU1fqq+Zp98Ov5/jLk+MOE8lzxKnQx7EDcUgdYHdD+kYJwMoNU4Y7+fgIMWAb4KqQMNyQAs3+u40oXGGkNksFXDXgGPWvo+N3+/eq2Y8UMopPhznJdG83ATM0T5HhELjioO7w3Sc0HKxzxBCGnj29jepEp01SXJObtrwCzpnjzI4YZtTsQ097jUJePwdeCRmHmSN/P7PFrahQuY2CCAApKZ1BLpU3WxkvzJSC8BIgCB/9y9nW4BbIgBO/xVVAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaxjYiuRNObt3DqSVc+eaCWAFQtnaZRQUxAQuK/k2v0=;
 b=CJ1qN67IhT1pEJIAJD3MD61mtBrB5lDEY1q1hplG7BQo1hHc3CcIUWT+f6xnwt7ILacHO6giRJXb/n8+bP98tt6NS3YLv9LLmCihhMZRa0BIjFp4WIVT3KjoaAihlsZ59YDT/wc2sRlVe718WkNIAtLbZQfLoPgAwvGc81apnxmaE/eO2VnTf/89TIOj6rtG7rcYchhxfcIZkktLZgkBmV6BjueXY1hi73U3oLaxiQaL/u2sh4lMJw2TCETO/G3Y+U8pTLp9eLEEEb9PQXt1j0+6OCF4sLBBCJHqG8gTYE4SxwVoX7eeFtFuXX4bxz+IlzLA5U8JMY9/fu1GI3SdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaxjYiuRNObt3DqSVc+eaCWAFQtnaZRQUxAQuK/k2v0=;
 b=Or44eHx1KyQ3zis6kp3fKTQYqc3T1+PVKNNFnMLC9oGHKsDOWrBU/WqrpBl2ebeb4KIbAmMecKcSkMZVOqG+1BLKwn1YnkcdNXHOFvsAQYaNU7wiaTuyO/RPl0n+Im9GUrzIFatltKrOQhBSUB15a9oTHsFaiCYI8fEimlnN3/zvPhpC8waiH4Os7xJ8FSYbZCsRauiZMuG/N8ZkwUnCmkqeGnpb/IMt17DCaQo2MKRtm4n1yWjiEn9jqCX0SRRf7U43Mv4mUyNlyoi7CV9s64Oqw/HvWBDJYQD6tdiiggQ+wN0qWU/zegugWagTRCNlDT0Phbrv5TzCgt5lMdrcjQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYRPR01MB15054.jpnprd01.prod.outlook.com (2603:1096:405:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:02:27 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:02:26 +0000
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
Subject: RE: [PATCH 08/33] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
Thread-Topic: [PATCH 08/33] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
Thread-Index: AQHcT+Mcjr1pSL0fwkCaD7J8BHyNPbTupLVg
Date: Wed, 12 Nov 2025 07:02:26 +0000
Message-ID:
 <OSZPR01MB8798B72839CF6CBEFD3C24408BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-9-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-9-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=848f4e99-3403-46f1-ad5a-dfed9c5dce36;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T07:02:00Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYRPR01MB15054:EE_
x-ms-office365-filtering-correlation-id: 650d9c50-7cf9-4acf-be2b-08de21b96fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZEowK2IySnhjcW50ZndFaGFvMEcydUhGdFYyZHVDOUxhWE9YNTA3dHY4?=
 =?iso-2022-jp?B?RlpITTNBU2JyalRpZmhGVlpIaVJlckFSRjR5TW5jOHVGckdXNXVRQ3Jm?=
 =?iso-2022-jp?B?WXdhelNNWGZ6NGxTTksrRXBMRmNjMGh3SzBxc0ZXQlEyUUFZK2wzcWpI?=
 =?iso-2022-jp?B?VFR3QzRrOU04clF3M25JcXZ6RVhnU0hJVjZBUE1OMFhvbUZacDdldFdC?=
 =?iso-2022-jp?B?M29KQ2RNQmRyaFk4bWUzVG1SQi91TnBoV284QVdxMzBuVnlzdE1peVpV?=
 =?iso-2022-jp?B?MitrQkFZVS9mTmlLbHM3enFtaVEyNkEyL1BYWm5yeEd3cS9makkzWVV4?=
 =?iso-2022-jp?B?dWFUU0xaekc0VDNPblVYQmxxcVRyUmVmTGVWMlNvR3MwU1FyOTliUkp4?=
 =?iso-2022-jp?B?K1dtdXlpbW9Fc3hjTk1SN1N3TThleUlPQzd4anVxaW1aZlg3YkpmWVp0?=
 =?iso-2022-jp?B?bS9rL1oxd1lnbHd6UlJkYytLYitmZEozZSt3eVA0TzdQdi9OLzBLVzF6?=
 =?iso-2022-jp?B?ZmZwK0dPSnNrV0tZbDgyemZ3enlZbXFKRzhtRGx2WFFjWE9wT0lmS0J2?=
 =?iso-2022-jp?B?SkV6VC9nYitPakFPRTN6R3o3eE5hZzJKZEtZZGxlSFBYK1I3eERpbWE1?=
 =?iso-2022-jp?B?TEo0dUJrcDkwQW9OcDhWRXBUaGFVVUl5Vi8vUVlkbG13aE00WW95bWR5?=
 =?iso-2022-jp?B?T09rMzFuR0E1WGM5K3cwODJkSkk0d2UrdmhIbGpYOGFMakZYM3JJZkF4?=
 =?iso-2022-jp?B?NWVlRHNZWnNWQ0tSR3VxY3BsbjNFTnVOUklvNzZQOUNrbG82TG5nMmNv?=
 =?iso-2022-jp?B?MWtwSnhKcWxxL1c5a3M3RWgrZmRURFVqZzFkbWszRHdNUHV1QjV0enlj?=
 =?iso-2022-jp?B?SWpZUlFhcjFIazducERadDBUZ2JtQjEyL1NTekdHU251WjQ0aUdXdVhM?=
 =?iso-2022-jp?B?ZDR4dWlWU3lUL0IzV3Fic2ZmTmtaOWZBUENiT3J5LzdoZWY5aVRuWnYx?=
 =?iso-2022-jp?B?RWl4VVVSc1hmRUN3MXdUWnVqQktBQ0xpV3UzK00yR2VNUFlLSnVLR0tq?=
 =?iso-2022-jp?B?RTFnY3hIYkhJQ1dhRXdLSlppQmxBenlzdTRKUzJTeWhiOUR0ZGJjYmJ5?=
 =?iso-2022-jp?B?YlFqa0NSRlBVNC9rdjlyRnV6ZEE0MmJlZmIrTE45VXBvNForQTc1dnpG?=
 =?iso-2022-jp?B?elpHcGs5Z3JNZ1cxU0kvQ0dGNWVuZzcrOEVXcVNGOU42bGFtSHNTNVMz?=
 =?iso-2022-jp?B?SkNpSDJTK0xyT2J6M29aL1oyMHRMcGY5eTdNbUtHampWL1FDdExjb0k1?=
 =?iso-2022-jp?B?QjIwRWpLdVlEY3hxOTArdTNCeHUwb1pLSWNkUHBuUkhUdm5PUHhVWnlK?=
 =?iso-2022-jp?B?RUttMXNwUi9GTDloa2xhVEVKSWhTajU4MUNRR1RKMlBCRTZib2RPSlFL?=
 =?iso-2022-jp?B?aG82N1l5Tm04TWxtdUpIQTRxYzBXcEY2WGtrd215QWwzWnZPajJhUjhD?=
 =?iso-2022-jp?B?b1FuU0xEWGNTZnhDTGtScGZMU3NFWXgxclU2VU5mMDVPVW55ZFBwSkRL?=
 =?iso-2022-jp?B?WEJOZFJlTXkwZlNwekpET2xZaWRqOUZHRGc0YmRnV1hmcmpVUmlicU1Q?=
 =?iso-2022-jp?B?SG9FSmV5aGd1UXBkUHY0OGxKTjdOWnlYWnZNc3lzQ0JtQmFORnhHKzd4?=
 =?iso-2022-jp?B?dlpvYlJERG4vNCtRMlUzc0hlbVl3eVRtM0EzNlhkVk1aSFM4TWd2bDhL?=
 =?iso-2022-jp?B?alpRV2JPeG5GclE4bnJvVHdFWWVraGtnbUwvVDlNRWpsY1hkS3lpdURE?=
 =?iso-2022-jp?B?K1NXTTgzSHExa0p3Z2dwUzhqWmdodzY1OHduWGJSVHlacFk3dWhPSkls?=
 =?iso-2022-jp?B?bWVLRThjZTZFWmdMaTZSRXdnMWVHT0pFMUk5UTh4eGxLZkhSNFBoYmxp?=
 =?iso-2022-jp?B?U2JMQnJraUxEZUR6WmVhb1FlZUtIckhyY09SZTZJMDkrdXIrdUprbVd0?=
 =?iso-2022-jp?B?ZHBFVjJwN1JwVnE2cVVQeWkzWnF5STNISFBzR1FPcnNobTVuc3c0WHlE?=
 =?iso-2022-jp?B?dU5IQkZWZnBYQWovSzMyMXBTWmtRVEExMENwWlhpUjllNFR5NDQyVjI2?=
 =?iso-2022-jp?B?cVZFK0pqSlo2dmVMMGRoRE53K2lpcG5LN2I5UDE4amtHNnl0VGZQRFBx?=
 =?iso-2022-jp?B?YnJGV3VWRDYxY3lHenR4QkFxK3lFTm9tanp4cGV3QmkyRlpVL2dFMjZK?=
 =?iso-2022-jp?B?U05KQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bXlWR1Iwc1BaaUlsVG00YWpuKzF1NCtQNmNZdldPZjdHV0xBVU9yM2ox?=
 =?iso-2022-jp?B?VkR5bGxWR0xyUnUwYm42cTZRekhxWWtNaXIzU2pPOGNic2psbDF5dGlz?=
 =?iso-2022-jp?B?TWVrWUtUYTRic1ZiOVRwaGk3bm4rdmJweFZiUEZjazl3Um5zR1hiVTUv?=
 =?iso-2022-jp?B?MXRSVjFDTERqaVdJWTExWGxvWkVGcHBSaGFCZ0pzYTNUb2xxZ3pNWHJl?=
 =?iso-2022-jp?B?dkQ0Q3JWR3NZcHpXVzBEcUtZcUNGM2xMbXpwMTJJZ2JycjJGOTY4Rm1D?=
 =?iso-2022-jp?B?UTFuTGxDcE41VlJYZmtMa0xaZGhjRUo4OWFkUkcyUmhvcVl1RkJOa0hH?=
 =?iso-2022-jp?B?RWNjd01NdkxRdlhrZUE4amdwSnJBVFA3Z3k3eVNrQ3hxSk81eGw2eEVw?=
 =?iso-2022-jp?B?VFVBV0w5SmxZdlZYZ3ROM01xbjNKR3IwS0NXM0tKV2FmOXNyVzZua2h5?=
 =?iso-2022-jp?B?VTBBVXAyMzJmdmREZU5qci9HeHovN2YwbnBtbzN3Y1pYcTNLYUtNNW45?=
 =?iso-2022-jp?B?U3pHNktVK1RxVDd2VzhKcEJyeHZ2ME9HZXZSblJQZWVhSzYxWStqNGVY?=
 =?iso-2022-jp?B?aWpuUmFOdTd3VHFOSlpDRXJ6dWtQVnVHYmdWdkVCeWluUFNqUm1pbkt5?=
 =?iso-2022-jp?B?OEZVWGFmU214bm54M2paYzcrRUNDMWt1eDJFME9VekVpdFZwODZ0bzVk?=
 =?iso-2022-jp?B?bWJhdGs1RTA3cjhrS2xhTWQ3R0swOCtwdHdpWlNoSkN5dmtLQ0JSWXdl?=
 =?iso-2022-jp?B?WFdYK3A1TnBWU1ZEMVFKVUpjQ3J2cHBVeHNqcy9Jc3c3VkhWaWFVUFVW?=
 =?iso-2022-jp?B?RWxEN2JYalZtaFNHVTY5TzN6akdDNHB5bE5Fa3I1NklHOW5GMUgxNHZN?=
 =?iso-2022-jp?B?MEZ3OFZPd2lqeHpQejlFUVNsRFlhaEpMMFFReEZGeFVPV0UrcjBxdHVI?=
 =?iso-2022-jp?B?MTZzWlhhQkhxUUdvT0txQ0d2R2NTS0RrRG4zZmxsY1JPV1NTeEVGMzlj?=
 =?iso-2022-jp?B?c2RRbXJkNm8xKytRcEgwblZHRE1lcGh1TS9oMUtmcndWVFpMSjZQK0lJ?=
 =?iso-2022-jp?B?NmcxUm1qVXZaVWJHM0FYamV3cWxpV0ZPYyt1U2JXdnB0dWUxK29HYmp1?=
 =?iso-2022-jp?B?N2xCWWhhak10S1IwU09RTTZUNGNyMFRBZ3RFZk54UFNnUHo5QlluV3cy?=
 =?iso-2022-jp?B?SlAxK21UQkRZMVQ0bFU0VzFmSERBTDJicmVhZGxSYk4vYWl3RnljZWVv?=
 =?iso-2022-jp?B?b29WK3AremFNbThXQ2h2c0pVeUJtNGdhdU9DZ3dySm1ocjN6MUh6YnBW?=
 =?iso-2022-jp?B?K2x0YUJnMzRaa0dxZ3IyU3BTSUVHUy9kYW5IN1A1NnoyYUp5RGthOUpO?=
 =?iso-2022-jp?B?a29URXB2UTBrNDgzL0dKQTM2aUxJTVU4U1U1L1RoSWw1eDQwQWNRNFRC?=
 =?iso-2022-jp?B?elVTZFJJMVZ6eEdna1FBSGhmN2FxNUpOU2pqYjJSK2VOeFBhQTIrdnJS?=
 =?iso-2022-jp?B?MFJDaU1xY0ExeEl3Vkp1S29PWmcxem1yT2F2MHAwR3R2L1F4TWl1M2FH?=
 =?iso-2022-jp?B?OVRyaXRMRGdaTW91YmFjZTNWVnl6NVhOb05QaENpcElMT0tLdGdsQmRm?=
 =?iso-2022-jp?B?Y1lubzBKMU1FSkxMV29ZZmVxZVZhaWUwd1I3MllCQ2t3dUlSTEo5KzAx?=
 =?iso-2022-jp?B?OVJNNHVJMlU0cW9RVjltdTQxMTNwbmRsTTluNG1tYUo4T3p0UUV2bUp1?=
 =?iso-2022-jp?B?K2UwL0lCRXNUMndPdDlSWVFmM2U5Y3VrYTgxd01lOTZmOXdBMTVGMUJh?=
 =?iso-2022-jp?B?amlZWXV4eExzbXlzY3VDZ1hFMkRRaWdIZ2t3c1RkZVdLcXNPazFDL0ZV?=
 =?iso-2022-jp?B?Qy9GSlZuZVNPVUREakNLSWN4M3hYTVJNdjAxYzZLdFIwVXNGT1dTaEU5?=
 =?iso-2022-jp?B?bFNnWmJadzlWSWdBVGFNekVTY3NObzI1a3hqaGI2MlNWRi9vWk5MNmxl?=
 =?iso-2022-jp?B?OUd0anpYSmJvQXhUUzRYSk9kNzRBR2xRdVlwaE9SWEhCSUhvVllIdWlj?=
 =?iso-2022-jp?B?ZEpSWFhIbkFzMVZsVHpBZWxxQXZVejNkOWtnNlFBVVJsUi9iTU5yVWpk?=
 =?iso-2022-jp?B?cGxpUkEwQ0IxTFB4b2NQUm1yR1U2STEydGdxRlg3WE0zRHRnandLTEYx?=
 =?iso-2022-jp?B?T0MxRWl3Y1NZU3ZVNE15NExiYlpYZXFJZ3YwWWNpY3ZNUE5PVW1IRGxW?=
 =?iso-2022-jp?B?S2dKOUh1K1Y2aGpjZUo1Yjltd1NYRmxnK2tJb1I5MGNXZ0VOeGlLdHpm?=
 =?iso-2022-jp?B?eWZNZ2dqdURBMDVFTmY4U3Q5Njd4bmYyS1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d9c50-7cf9-4acf-be2b-08de21b96fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:02:26.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB2psu3/8IkNNOBuPsPt8EkM+p3yfGys9L09WBz/S2bPhH6On8qhr05BpS6LzNo2FBD0RExx1ohIIRjoHQ0c0gcWeAhyQ7SDI7BDehGxLmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15054

> Define a cleanup helper for use with __free to release the acpi table whe=
n the
> pointer goes out of scope. Also, introduce the helper
> acpi_get_table_ret() to simplify a commonly used pattern involving
> acpi_get_table().
>=20
> These are first used in a subsequent commit.
>=20
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

