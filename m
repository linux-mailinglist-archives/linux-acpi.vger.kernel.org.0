Return-Path: <linux-acpi+bounces-18768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA0C4C1FE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 08:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0DFB4E117E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BCB29DB6A;
	Tue, 11 Nov 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MjLGtuJR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011069.outbound.protection.outlook.com [52.101.125.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0353281341;
	Tue, 11 Nov 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846461; cv=fail; b=X6y672x0h9WszG2MP/tvQUgM1+lgKIybRS3SargmWTwfBu3r09axRjoMsIssyyRvhedsHmde7G88iBeiNe+YczO+VkaqeDiJLcREhbV7Sm29QurvrCNMGiS6XJIsnXqsbujpRONb19yKSwk9wwI4ZpPiMyM3dWHwxiZoYOQxkQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846461; c=relaxed/simple;
	bh=hu6p30CrlCWykOYmxAd3+P8ENDSq3WRtYgDWkyI0W0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K95nesdxf6UXAOTHFkZ73FEy/Pw5+HgcPVjg/L0Xldp/Mzo3Qi8Db8ptW/HTNvNSAvKfl5hp4bwB85Dl9fCsgT6wXv2IRMWQvIY8R1kXExn13cdjS5XAUEKwh7oCr9zS5vZWQidbKs2LCNdrj0NZpiKDiznnrX4GX1En0cW3OoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MjLGtuJR; arc=fail smtp.client-ip=52.101.125.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2mX3IKZRVxMu2ANKkCuXrahWGyAVaA7d76uFsApDwc2d5EuyzcWrs+zjPNlIw6J330xppKIejKeuviwe+03f9c/pAbHQVeK+bRue/+yIrQ/UjvqdSX8EfyjqUFgJpGCr7L7s3MZ3c4atI3IHZ8EckAaxBCJPDxb1EaDMUvovLSo7EDeBoXNFRwe2mKfrjLOGo3AfWDixn9aWmjinDd9YGY4MxuABDiaBEIRnbliClAfswxB8Q0A5did1+/7A9XBfaPVempaeV40p4JpTaSMFzLP3KoTNdGjEKxzOaBYQNZNvvbDZG+ODQY7duGBlRpDt6QvCwwEbWm2kvYnEgH9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/zLVraegXlXN7K7LRdRPiP04jffmgWmSkEpM/eR9Ng=;
 b=PdueissDzOEyUiyemr5fePGY264TunEOW5r7fzC9ZCbtCVWJZpxj05vKjdX20JlfWGJetIiq0ZzSaTTtYx5ZwHOPLtEaHITxlW8wYnclIJ8L7295ceI8OofdgkjbDp9uMt4pvFDnEtOC7VhTld/GkgS/2eMmZT8kaKqnuLbImLz3BsWGCTGTxFQaZSVQxS1XegNvS/qKgMGxtrhc6EF1DL2VUXlX66vTRqRVIntrj+WAcXYF3km/arrI3z5Xd/GDTB2vIOpm+gfe5E7mr/eY87YWprQAOVKApEkoSG3ND6ktd/Ra3XhvLEW214b0edIsbLGm/bHn6AMQTuItiLs5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/zLVraegXlXN7K7LRdRPiP04jffmgWmSkEpM/eR9Ng=;
 b=MjLGtuJRtkTdLdmYl6EX6C3bZMDxHZuPRcuR49nN2G5GBHFLzDTEvJZ1n6uNd9rzDG/RjYa1sDFhUvTb9hzaGG4Q8edGRqC1HbUbyXfXTAdXd+4G2hQQhx78FL9+5/Em+ejX2/BXPsfq3noHm/LeFjWwSXttZRTbSOTDW2AbqzQX3HCgYIi42fbctNKwYsGFw46WbfwbMp5pmmvpWDMpl91ABgii/cWm6eltjoZv6mvIXyOC5zMxGuCZ+2IBWYiv+lXw0oGnSbHVdLGjjRniSV4P5QjeOfeInaefVL5UAQNahho2i5jKPGElu6yLrSLEpNEWLq2OzjudAJd4JuIVbA==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSCPR01MB15629.jpnprd01.prod.outlook.com (2603:1096:604:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 07:34:17 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 07:34:17 +0000
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
Subject: RE: [PATCH 02/33] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
Thread-Topic: [PATCH 02/33] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
Thread-Index: AQHcT+MKCE5AB89ESUKlyeeUxIXqDLTtGgmQ
Date: Tue, 11 Nov 2025 07:34:17 +0000
Message-ID:
 <OSZPR01MB87987E02D1BC84112F4B2A0F8BCFA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-3-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-3-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=745fbd74-f156-44db-bbb0-36605846e6c1;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-11T07:29:24Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSCPR01MB15629:EE_
x-ms-office365-filtering-correlation-id: e66fbaf3-9805-46c5-dfbd-08de20f4b899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?d29sc2JFR1JvV29EZFJhV21Ra08rNnlkREt3VVVUaUtDVEtuckNXZEJG?=
 =?iso-2022-jp?B?bllINDYweGlyT1hkQzBzRFdOYmRWeXoxK0Z4dmZBUmFkN2x5QmR3dCtZ?=
 =?iso-2022-jp?B?V24wMzUzdDFlbmJjeWQxNlVyamVnZ3hXYm1rRVhmcmQ0UUxPWk1Ja25T?=
 =?iso-2022-jp?B?NmpFYStaRE5MV0wyczBkT1k2alN5Qk9FY3lIQ2xzNDg5Yjd3VWd4Wnlu?=
 =?iso-2022-jp?B?alNKZUM3bFdGSDlCa1g0a1JPQTEzMzhPRm5FQkdGckJCY3k5TUc3TGNI?=
 =?iso-2022-jp?B?MS8vMjE2Sk5CMHgxeFVHSVJva3VoUDJOQU1WTXVWNnNXeW9xYzFVaDJv?=
 =?iso-2022-jp?B?Y2dJU0VyaE9UMUZ3OFV0S2pSRjJyRkVjOG5IYUdSVmlZV2dRNGdjRjJa?=
 =?iso-2022-jp?B?U0lJYXlESXhJV2lTMEpFbVRmdUMwbkhGM1lmaCtKYU0rTi9LdVI1ZHpG?=
 =?iso-2022-jp?B?dVZtc3lIYzl2Y3VoMEFUNlJDZC9RZjBMdzRoR3FqRTRMRUovemkrSW5r?=
 =?iso-2022-jp?B?NExmcFFWZ2d4NzRhUDZWdXVVUW0zRGVIUmd4NkJZaXhzOWhac1ppMHRO?=
 =?iso-2022-jp?B?WCsyMGU5WGVTYkxmZkpQOGQ1ZXBiZ1p3em02RlFNWitaT0ZScG16WSt1?=
 =?iso-2022-jp?B?d3VjcVRSZU5GS0gyeGVoZGtpcTdPZmwzMWVpdjBUTzU5UUN5U1JQREUz?=
 =?iso-2022-jp?B?MmYraWlka083cHdhSmlBSHlDR29tM1NTOUw3d2JhV0lja1E1clY5THZF?=
 =?iso-2022-jp?B?a3pLaVBPRFFMNjZPdE5wV3pJa1NISHA0cVhES3dMd2FvVHhIN3JHQkRn?=
 =?iso-2022-jp?B?MmtqbHQrRVpobHdMRmRINVM4ZmR0cHJYNFI1Mkc3T1VuS2t2N1JjUGRu?=
 =?iso-2022-jp?B?THFQcGhpOXlxbWRzZlVhTFlCZGdXNFhxOFFVbGFhWmZRNXFFUHZOc0t4?=
 =?iso-2022-jp?B?bEVNUFZZQVZzcktVVkFQL0FreS93TWh5elE4Y0ltUkdXa2NkYkdxWDlL?=
 =?iso-2022-jp?B?dHEva25xbXFwcjk1NXlPbTBTVFVrZ0pOTkN0blhCdSthSlEzUFNhSXRv?=
 =?iso-2022-jp?B?RkwwWGdtbTFQVUFORXlzanlHcjFWTzdvZkttR1hYNGJWWkF1bGxIbkNy?=
 =?iso-2022-jp?B?bi9rcmJpalZORGJyanFDSnphdm5YdTUwdEs5RlpmeC9Bc0VCOG5qU09T?=
 =?iso-2022-jp?B?QTVOdGFiTURtb0tzajRFdkNLektqdjJLbk9scTlCSk1DWWVmMHo2TU8y?=
 =?iso-2022-jp?B?ODVNaHd6cjdKSjZrVG9mZnp0VUlxNFpaNm96MW9WdG94OEZTdGwwTVg1?=
 =?iso-2022-jp?B?VDBBL3R2ZEF5c3l3R3pUamlhSWtqaDdzdExJaUxMSFdPakF6VHNQc0Ft?=
 =?iso-2022-jp?B?U3p5S1ZBVlJaL01uTHVLdkpBc2d4bExuWnI4dyt5MDVuTE42eTBLTmRv?=
 =?iso-2022-jp?B?ZE01dUIyR2Z5TEcyUEE2Q2w1bldXTHJieGNyQmZVazFNdXdqYUNXRm1B?=
 =?iso-2022-jp?B?SWdUblNxWVN2aVJyNHlMOE9ERDc1VVYyVTNURUkzUVBSdTNyYUhENmQy?=
 =?iso-2022-jp?B?a2JKN3BXVHJzRlZQeWg1RDlwRHhhK2twbDZ1TUhzZjk5OUx5bEJ1aElz?=
 =?iso-2022-jp?B?ZkxSQzVKV2xhNGFXcFZWWndmSTNaRDhWM1pQVkRtQzEvWEQ5Z0tzMFhC?=
 =?iso-2022-jp?B?MDIvbnhUcXZhNkN4aXFzUzI3aU1BZm1QSEZYV3YxOElWYzVNS0FHRGFn?=
 =?iso-2022-jp?B?Titxd1FBRVd6eDdINFJsNWdKOTR2bjJqcUUvL0p3MC8yajRMUEYyN3E4?=
 =?iso-2022-jp?B?akpGc0dwTVNsaE1yQmMvblBkS3NYN3Y3U2lZUTA5MjJNMHZGcDVwVmdL?=
 =?iso-2022-jp?B?azZQYm9pc2QwQTQ5cS9oN1EwbVlPUTF6NW1RejJKcjZ1QnZRSjVQMk15?=
 =?iso-2022-jp?B?Z0hROUd3UDc0eWovd05VZ3paSTRweVdWaXVqQTBscW02QTYyWnR0aEVT?=
 =?iso-2022-jp?B?N2VqY3ZqRkh4ckwzQnhFS3pJUUlzanRka3c4L3ZVclhmU0Q2NFZlTHgy?=
 =?iso-2022-jp?B?a0szNGJSVi81TnNTVHVKNDVlbVFISXVpL0dDVXpWaGpVNmQyM1lVaUdU?=
 =?iso-2022-jp?B?NmhFNlFScll2cEhwNEtIbjlma0NjbXI2TU1RV09hWHQ5TzRVYlU5NGJN?=
 =?iso-2022-jp?B?czJLVk5sRWlaWjNBeEI3Smx3aXVGQ25tM3R4dWEzTkFlVm4rU2VRSlpU?=
 =?iso-2022-jp?B?TnJwQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UUdybUhsaGJqMmJrZjA2L1pJYi9YZDhGZHhsancwWXdlTHRrT3FrRmRB?=
 =?iso-2022-jp?B?aXFIdnEybnBINmZGQTNkc2cwdTlNOVpUM3NGcnlMbFFhamUyUGErcWRx?=
 =?iso-2022-jp?B?SDVLeFlGbmJKTjBsUk1iWEtrdEczOEQwNHlKUGF4OVhaYmRTNGNBUFNL?=
 =?iso-2022-jp?B?cGZPbHAwc1g2NlZxcGRCS2xkNzArbnZxYnR4Q3pEK3daMkZYdDIrMjVM?=
 =?iso-2022-jp?B?QWp6OE8zeVV4aHg4RWdxNGg4bTFNWlB4amJJbElxeFVtU1JoTVdoenB1?=
 =?iso-2022-jp?B?cms1dGFaVW51bEtRL1N0S0NGTmNQVjNyVThxUmxsbEhWRHhpSHp2ZTd5?=
 =?iso-2022-jp?B?ZXBuNkNEOGZWTXc1RHFMekl1TXNBR2FEQndGME8ra25pdldleC9DUTIw?=
 =?iso-2022-jp?B?eWJrRUtWaFlheklqTHk1UTlmWHArSGRFTFIxelB6SnNCa1JtaWNQNzhK?=
 =?iso-2022-jp?B?WWVBTmRseDRiNGFIbGNyVmlGT3R4eXNuK2swNmpnUER1cEVvWTBjVDQx?=
 =?iso-2022-jp?B?K0xBUm0yVWxhNzAyMHg0Ymlpd3BrQzJRWGNwVGg0dWJWMFBLYmZtR2h6?=
 =?iso-2022-jp?B?SVB5cDlobUFhS2p3YXAxTU9SWVYvKy8yekxOczNtSktVN0RDdkVZbnRm?=
 =?iso-2022-jp?B?YmRLeWk1amxlVHh3bjF4c0h5Wm1FZ1I5WjlNVkFPajNRT2gzeEdSQm5J?=
 =?iso-2022-jp?B?WVUzRmxjSjQ5WmpvNkdPcDFRQmpRSGF6dHd5a3V1a3JjckhCQzdhMVRM?=
 =?iso-2022-jp?B?a0hBNTZNWXhxdlkybGdReG1iTDNoZGEydkthZ3d0SkRUcUwxU0ZpaHBZ?=
 =?iso-2022-jp?B?REwzMStxSVpRV2p4S1FiSTkyaXFSbHpZQ21ZTVhDTnB1bTJkZ28vMXlk?=
 =?iso-2022-jp?B?WXNnYkYwSnpTaXkvZDh3L1YzamhPOHMreHlMaSt1WU42SzF0S0o5UHhy?=
 =?iso-2022-jp?B?T2hPM0tFV2tUa0ViQjlBYXViTUNDOXd1ZjJOUEZla29CcFRPU0xUc3hO?=
 =?iso-2022-jp?B?R2E5Z1k2VEVKTDBTYi9PTWd4c0dvMXFPSCtYYWp2dlYvbE9pWmRwWUM2?=
 =?iso-2022-jp?B?N0w3RE1TSWU1Vjg1dnBYU2RmSEZJcjhqb1VqSUlQQVBPdFU2RHU1TVRm?=
 =?iso-2022-jp?B?L3NWb0JINXhOS01UOTZOMVpaMXdobTkyVklNZlg1SlJ3bDIwS0dBZEp2?=
 =?iso-2022-jp?B?aFRYeWYwSkxnczB1NlBuRUVnT0hLQ1ZEQ2FNOEtrN0htQyt5emIrck5q?=
 =?iso-2022-jp?B?bEgxNjdnWUhONmhjK29RQnk4WVJhV1pTZ3NsWEZrK0xxUXBZeHNyRnpm?=
 =?iso-2022-jp?B?Um40ODRaWndiakQrMW9FUlBZYWFCaDhjSTFLdll6K01XZ2lmbmhVZFBZ?=
 =?iso-2022-jp?B?NUtVcjhyRUdGOWlwV05hVlZmTGJnN2JBdkFFbG43ZVZlT3o4LzlscE9j?=
 =?iso-2022-jp?B?OFVUMWEwOVUzb3BqaVhkR0YzQVZnMVZoVmFBQmlQT0VwWHk5T0J4ZzhP?=
 =?iso-2022-jp?B?YkhxLzU0ditVVGF0cE13VTRRK0JrdmtMUHJqa0hzckIyUmpJN1lZN2Y0?=
 =?iso-2022-jp?B?VHFXZjZDU3pJelhkdG5DaXQ2ZmdjUlZaNlpDWmlGQXhKVXNrOVdWZDVk?=
 =?iso-2022-jp?B?NEpqa1ZYNk9jS2cwaHlsc3Z1aGRFRmxmd0NBWEwyUEhNbXlVSlFxZThT?=
 =?iso-2022-jp?B?M1NRYlNheEdzK1MyOEZBTmNsY0Y2cGF5NWVTaDdKNXBzNFQycmRjYS8v?=
 =?iso-2022-jp?B?KzM3R01RSUczWTlJTEwvVi9qWGd2UE5JTk1Qeno1UExWUFZRZVI0QTlE?=
 =?iso-2022-jp?B?eWwvcGNmdGZyUnRFa3dTa3dNNFlSUVcrNWtXS0E3RjRIVUJqZTVjYzlz?=
 =?iso-2022-jp?B?SzVWclJOREwwTkFod1BRc1dUY1FHL0lNVDBOK2dnRUxCek5vMzFiRmRP?=
 =?iso-2022-jp?B?NkNnNHZvNFZINys3alpGZWFoNHAzb1JUcEpNVFhReGRTbnI1UDQvY0dn?=
 =?iso-2022-jp?B?SjRLbmEwQjJvZ0tsamk4UldsYWJBK215dThNQ013VUdhZFRwcjc5cWFB?=
 =?iso-2022-jp?B?Lzg5NGt2eklXV212MlR2eHlyekRkMkR0OC8yUFpiSGFFZCttQkVnWEI4?=
 =?iso-2022-jp?B?NTZ6dEZyUG5nT1ZSZVV5ZmpoRWdXYmYyV0tvQTlUM1NZY1JyWnJqNUs1?=
 =?iso-2022-jp?B?d2dUVkE5VW1XTkd5WnRKbXNWYXZ6N01sd1ZaYkk5YnNNellPelZBWmZU?=
 =?iso-2022-jp?B?WlFpWnVPM2k1dlVBZS8vbEhXcFQ4ZnZrSTJreFRkdHpwVE9sRGIyY212?=
 =?iso-2022-jp?B?MmdMVkpJRC80TXczd3hEdWV4MWFDRzV6c1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e66fbaf3-9805-46c5-dfbd-08de20f4b899
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 07:34:17.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9w5thAgOpuLkTlzNC2PYNjptqqEP0HeSbvnzG2PvQGKfB/vzFD4fOdCleb+XX3XZP6kqPzfpqFrCkO0AjPw3t0njRRKYUBNnzTzmLAMyJgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15629

Hello Ben,

> From: James Morse <james.morse@arm.com>
>=20
> In acpi_count_levels(), the initial value of *levels passed by the caller=
 is really
> an implementation detail of acpi_count_levels(), so it is unreasonable to
> expect the callers of this function to know what to pass in for this para=
meter.
> The only sensible initial value is 0, which is what the only upstream cal=
ler
> (acpi_get_cache_info()) passes.
>=20
> Use a local variable for the starting cache level in acpi_count_levels(),=
 and pass
> the result back to the caller via the function return value.
>=20
> Get rid of the levels parameter, which has no remaining purpose.
>=20
> Fix acpi_get_cache_info() to match.
>=20
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
"Reviewed-by" and "Tested-by" are mixed together.
It would be better to group them.
(Not just in this patch, but in other patches as well.)

Best regards,
Shaopeng TAN


> Changes since v3:
> s/starting_level/current_level/ (Jonathan)
> ---
>  drivers/acpi/pptt.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c index
> 69917cc6bd2f..1027ca3566b1 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -177,14 +177,14 @@ acpi_find_cache_level(struct acpi_table_header
> *table_hdr,  }
>=20
>  /**
> - * acpi_count_levels() - Given a PPTT table, and a CPU node, count the c=
ache
> - * levels and split cache levels (data/instruction).
> + * acpi_count_levels() - Given a PPTT table, and a CPU node, count the
> + * total number of levels and split cache levels (data/instruction).
>   * @table_hdr: Pointer to the head of the PPTT table
>   * @cpu_node: processor node we wish to count caches for
> - * @levels: Number of levels if success.
>   * @split_levels:	Number of split cache levels (data/instruction) if
>   *			success. Can by NULL.
>   *
> + * Return: number of levels.
>   * Given a processor node containing a processing unit, walk into it and=
 count
>   * how many levels exist solely for it, and then walk up each level unti=
l we hit
>   * the root node (ignore the package level because it may be possible to=
 have
> @@ -192,14 +192,18 @@ acpi_find_cache_level(struct acpi_table_header
> *table_hdr,
>   * split cache levels (data/instruction) that exist at each level on the=
 way
>   * up.
>   */
> -static void acpi_count_levels(struct acpi_table_header *table_hdr,
> -			      struct acpi_pptt_processor *cpu_node,
> -			      unsigned int *levels, unsigned int *split_levels)
> +static int acpi_count_levels(struct acpi_table_header *table_hdr,
> +			     struct acpi_pptt_processor *cpu_node,
> +			     unsigned int *split_levels)
>  {
> +	int current_level =3D 0;
> +
>  	do {
> -		acpi_find_cache_level(table_hdr, cpu_node, levels,
> split_levels, 0, 0);
> +		acpi_find_cache_level(table_hdr, cpu_node, &current_level,
> +split_levels, 0, 0);
>  		cpu_node =3D fetch_pptt_node(table_hdr, cpu_node->parent);
>  	} while (cpu_node);
> +
> +	return current_level;
>  }
>=20
>  /**
> @@ -645,7 +649,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned in=
t
> *levels,
>  	if (!cpu_node)
>  		return -ENOENT;
>=20
> -	acpi_count_levels(table, cpu_node, levels, split_levels);
> +	*levels =3D acpi_count_levels(table, cpu_node, split_levels);
>=20
>  	pr_debug("Cache Setup: last_level=3D%d split_levels=3D%d\n",
>  		 *levels, split_levels ? *split_levels : -1);
> --
> 2.43.0


