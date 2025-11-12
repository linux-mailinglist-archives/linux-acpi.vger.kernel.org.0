Return-Path: <linux-acpi+bounces-18787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A2C509F8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 06:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A38D1349A64
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 05:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99F21C194;
	Wed, 12 Nov 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eURhOrui"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011053.outbound.protection.outlook.com [52.101.125.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D001C3F36;
	Wed, 12 Nov 2025 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925636; cv=fail; b=m7jvzCTbXkTz8fL2mFkGp6JUht2If4Rn+O5ZGEsORE7cqZf/L2/8XJXb1wYpk7p6o6ou96n+uUtF1PDrUfNF0MXrfk6095ol8dbBwH0wktCB3T3Mq220mgnK8XUFFwtlEGPPjr5CExrS2a58IoVzgwONpt0HbVx9eEwiVThYYww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925636; c=relaxed/simple;
	bh=+F1GWHSymF9oL2VdI/hMQbc9TAr8YFl1mv/Xnu9Dl2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s8meumdHgx4RrhvzoUn872M+soEye32nk0vjC5G/WiS/vW2ul9ANs8BH8A+ZEA55aF1pCnFXrZvuftzFUv2Cu/FD241ga1y82ti6SUT7Eb6F725oNoM1BR/cTHmaFhh8IvoDOyYmzOa8VuD3SOY9qMA94tmmd5p6WPmJodRVfiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eURhOrui; arc=fail smtp.client-ip=52.101.125.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4eQPkXZKwc1mWFtsIqsR2fVakn6oZ2wbINNm8qMJC2kuIB6oEKrmXIdXULnLTs3PU69wGWZKZsktCD87Ho7jtKeKDbPJNGNCqyNGqSFwQwSRHPvcZQKx4+e8dn47bpeVWCsdi+wR6B12ilrL4sKanYA9/ATQwXMOKHsXld/E/LsTbyQfmFULhgb6JeHggjwsNDGPsrNFVr5zDYNoXv8E8FKX6TnvZUF6HJG0VkqrzzrSkCjBug+1SFV28IuZL9y28c8WQJ8yYcKSMP3/YA5hIYzPgRcueryfrAZRTB38wEaAh2UFxkQYlVTMRLUIPDiHKohGTgj5SWCqZJrXSSj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F1GWHSymF9oL2VdI/hMQbc9TAr8YFl1mv/Xnu9Dl2U=;
 b=bCyhqKYiJvdvr7kbxZ8eJLz1SU2VgN8mrXC7G7+v2SxQk/gEreXJwNjaCNZzqYwS9u/GeKqrcXl3/oDXC9Y8Pa4YhVBTzbS6j9J0ZaR4FqRSrcsX4gVvLJ9LyJrX8lJfZfes70FMgfUHkgWy1KSSuzCQY1ZmnFklR/rlLrY0XKiHudrV64RoDkfrSmxuLXdERL35kBxo/zz64fUYko5bUsGWxhKyloTRFC0Gcf8Z0/i3vAVBu2G7dXuFsI/jqKVF/ViQ0w9GHkY3Cv8rHR4C+nkLgl4bO7IJKDw22Omti69RgRYFo2CB7DNPzHWS5qS3FyZwCn4DiIYIM+96pjfl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F1GWHSymF9oL2VdI/hMQbc9TAr8YFl1mv/Xnu9Dl2U=;
 b=eURhOrui2C0dlTa2Qn1afvY5jwCp4MsX3SmfX71R8zhkdxjXhLZBlRVy+wQeeqXeCzCg7NJkq/kBy7ju9PPE8uLNuzA3RSkpJeO1CaiHllGXsLfEqknGlevIKdEZULEmMCpT0QkmeRmxB+3KzfLbctdPd/rGSgDFVj+n8ydKIS83drkaJ9zVkjv/vz1Xhq1Bs7eXC0oNswSgUS04+ho7486kQ5gpBx7b9e0zlja1clDomYUv8GqsJ9BO2o+7o5t4Q3SL340E1IJY+7pc3t0mqnTfJVxKbXNUnQoYVwQhF2J0jXtz+tnAPhxSGV+IgR/zRF1aCmV8U11N8uGU9CypPA==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSZPR01MB8799.jpnprd01.prod.outlook.com (2603:1096:604:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:33:52 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 05:33:52 +0000
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
Subject: RE: [PATCH 26/33] arm_mpam: Add mpam_msmon_read() to read monitor
 value
Thread-Topic: [PATCH 26/33] arm_mpam: Add mpam_msmon_read() to read monitor
 value
Thread-Index: AQHcT+NVTdMv8w6Fwke7d6sF3Uk7Y7Tui8Pw
Date: Wed, 12 Nov 2025 05:33:51 +0000
Message-ID:
 <OSZPR01MB87989B45DC4B155FD665F3CE8BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-27-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-27-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=8e3b03d6-6bd3-461b-9ff1-63da6b455b98;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T05:32:43Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSZPR01MB8799:EE_
x-ms-office365-filtering-correlation-id: 461d06f1-9447-4cf6-34cf-08de21ad105f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YWwyM3dLY2xtcXVvdEpETGJ0dEdpTjJNWGZueVR2eFRqWFZMU2JndmNE?=
 =?iso-2022-jp?B?dGd1ZjR1c2dVU3E2VDdlUFVobHBybTc5RXdlS0kxOGZiT3FLUktFdkNQ?=
 =?iso-2022-jp?B?KzYxV0hHOENkY2YyQ2FOYUxTdmd6OWVrU3BiMnUzVmwrTDE2bjVzendQ?=
 =?iso-2022-jp?B?QzBON2xMS05qaSs5ckNqWTcxM1grZWp4UHVENEltODZnQWVBaUdMY2FY?=
 =?iso-2022-jp?B?RTVxZTZsei8vNS9KVDg2R0xMWjdhM0pNZUovUVUyNllNQ1JXaCtUK2gy?=
 =?iso-2022-jp?B?QzgyNkxsZjNuc0loSWZMUUpmWkNDVzAzVDAzY2FqV3BkeExPWi9RZ0hi?=
 =?iso-2022-jp?B?Mldhc3c5OXIzZ0M4UTROWG9RMlVHeHJaSkpwRTdOYzRPc1AzWDhZSU96?=
 =?iso-2022-jp?B?Z28xU2w1RVhtSmxSMmtKaHVtMWVlR2Q1djZLbWVuQ2I5dWJCQklFNnRR?=
 =?iso-2022-jp?B?TXhpcEVINUxtUUthb0NuWnN4NU9MTTk2OW9jbHBxUGozZzBuOUQvU2o4?=
 =?iso-2022-jp?B?cDVCK0dkZUQyUDJTUTZzVWc1QmxrdHJrNlpTUXM1VkVJV012Vkk5SG0v?=
 =?iso-2022-jp?B?YlZ3VnhBV1lRL0sweStYZSt2a1NuVHZ6MEVOS0JQVFJ4b0dwNzVkR1U1?=
 =?iso-2022-jp?B?QlFZQ3V1VGppekRudVBwUjZrNFBtVDFOY0NHZGtaSzJiclB5NTh5K0xx?=
 =?iso-2022-jp?B?b0lmTHJ1S1poYnRBcVBmYmVReEMycjl1MVVvejlkYlpjbHdPK1FRRndP?=
 =?iso-2022-jp?B?TGF1OUZpVkdGL2Z3a1pmWUZNRC9BTDVJOWZUcVg1bFNNMmRoRFFMZldI?=
 =?iso-2022-jp?B?eERLVEVzM2RoS0pxeVRNZmVBalh3NmFHUThnS1UvbHNuUllXSDA5N2JJ?=
 =?iso-2022-jp?B?YjJuSEZidXFacm85bnJ4M3BOU2kzV2VXeEFyM05Kd0FMTExwZGs4Rk11?=
 =?iso-2022-jp?B?RUFlWmZ4dGlOTG9JWE9ncHVCKytMS0wrbXh0QldMSHo4dVVQdngxck1o?=
 =?iso-2022-jp?B?UUh4cXRDbGo1M1gyYVprczNIRGZDemd0eGhOelUxMDIzdU5DMHZmL1dT?=
 =?iso-2022-jp?B?aEhJN1VoNTluVHlSN0h5QTZhQjc2a294eXlacWlCSEc1VzRjSjVDeGxB?=
 =?iso-2022-jp?B?cFZWQ0xsZFQ1aFZ6R3NNemtNN0xsSDMrdUppOWRVcXJzNlNEYXVKL0ky?=
 =?iso-2022-jp?B?c2RiMzUzVy9MNUZnaFh4ME5Dd2VtK0VMUDFDNlNHZnR2ZThYdWUrbFo2?=
 =?iso-2022-jp?B?d0ZQRytqa0RselZSYzJWOVlSOCtNVjJxaFdCeVBpMUV1Vlc3UmNuelM1?=
 =?iso-2022-jp?B?STFBUlFRVGRCdDhCSHk4cHJrYTNVcE1mb1A3dVFjMzF3Ky9GaG5qOCtl?=
 =?iso-2022-jp?B?eThSck45OHRoanZmUGt5MThMUlYrVzNUQjFGM1krVStGclF2VTZLREpD?=
 =?iso-2022-jp?B?QU13RDBjcm5uOFNWQjlLZjIyZFJFZ1JRZUZ0MFBCZ0t1MEpuV2p4a3NN?=
 =?iso-2022-jp?B?SmozMkVCNmNZK3ZPOE1pZGNOL0NiM0NYSW85R3Z0SGZuNEF2UzFDdDhp?=
 =?iso-2022-jp?B?T2pyaU4yVjhPZzRKUkJSODNyeUxweTBUT3B4dkNDUjZoSVpqdERVdEFu?=
 =?iso-2022-jp?B?cXNTVGhjd3ZiWjRySjRySjVmYk9pYlRFK2d5L1NEclJDY1B3V2FBSitu?=
 =?iso-2022-jp?B?c3Z1Q0VIUkdKUVZXQ3M1U2hESm9UMEMyWWVUdnYxbWFKQU9uemV3di9J?=
 =?iso-2022-jp?B?a2VZK1FabEUwM2NkK2g2bysyU040d1BnanFpbEtRRFJiSDZNdHZDM3M5?=
 =?iso-2022-jp?B?d2pidndSZGM3L0lESW9xSkR0eW15M2ROeU1mN0taa3BXYjNVa0t3Ti9U?=
 =?iso-2022-jp?B?bllMdzJJRDlBRVFDdFpjQkRhcTRSbTFyRUJXQmM1S3hNODYrSm1FOXN2?=
 =?iso-2022-jp?B?MFZzaUNuZzE4aUM0R2hRRW16eWJCK0Rqc1ZObUkySU01QWxHVTV6MlZj?=
 =?iso-2022-jp?B?K0daYW11WnhIajYrS0ZIdFI3Nis3YXBKdFNuaDZacVhuNnhpN0IvUFdC?=
 =?iso-2022-jp?B?czhPSjAzZzMvd1psVkdBdkM1RUNsNGg5WnE3b29rakNQNFhoWS9hY0Fn?=
 =?iso-2022-jp?B?TE41ZjRKQ0cvaTZaUHkybmJtK2t5QXpoNFA5VTVxVW5IdkdTcnhMK3Fv?=
 =?iso-2022-jp?B?RWUwcllNVUZ4VkRZZWl5VUYyYThwYnZPY1ZTWFREWktPenBpTWZJNE53?=
 =?iso-2022-jp?B?T3lrQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?QU9BdVErZnk4L3IybW5WUWIzRk1LZmRlcmNOaDF5L2xiSUlNeDZXdEwv?=
 =?iso-2022-jp?B?NU5CYjRyM0dVTlFhVUxESzFBdmlBblVjME1LRFo4NnpGcGVNczlXdVBW?=
 =?iso-2022-jp?B?eE9yQWkxc1UvclNDSjRjTllNMThUSFcrZFJBZ1J6UkZXUU1JeTc4K2l5?=
 =?iso-2022-jp?B?NTM1WEVjOGJDRnpKSDFvQVduMyt1NFhhV0NTUjAzUHBraldrMXQ2bVpH?=
 =?iso-2022-jp?B?Znh5bUY0WXgxUjRUSnFuWHdpd0pCby96clp1V0dBTDhvRWc0UmZ5QWRB?=
 =?iso-2022-jp?B?VEFDVWM2T3g3Z0xLZHRvWURHRlVuNFYwaFZHVnFxWVVUUld1cGhOVktH?=
 =?iso-2022-jp?B?ZnM5VEY4VXhIcDBPTjRBTEdvUER2VzdnYktJb2hpTmlEaEt4KzBOY0c5?=
 =?iso-2022-jp?B?Z0loa0pwaC9DM3ZkOUtvbG84dXJTZHNRNDBzNkpMVHJqTFA3R2cvRWl4?=
 =?iso-2022-jp?B?TnMvOTlpRnhHQXAwdmdBMFFDM2g3US9KZDhxOVVUT1JtU0pQcC9wdVpD?=
 =?iso-2022-jp?B?U2cwclNMT0xTbVliN0wxQjAyQTJWYSsyc2ZhNlVobnBYZ1RneDZ2YS93?=
 =?iso-2022-jp?B?Tnp0UGRReDl3UnoyNllKdk1HVWJGbjcwYksyYzJIdmltbUVFcnRkR2VS?=
 =?iso-2022-jp?B?OFdYNXphdDF4QStCZnVpbFNPWkhnK3FSdzdqVGdiZldvVkRrMVBkdk9n?=
 =?iso-2022-jp?B?bU44UlI4M21xT0NEdDM3MDlqNjJZWXJhM2NSWXIwZSthd3I1UU92MmtI?=
 =?iso-2022-jp?B?eWgzNEQ2SkoxbmRjVkNiMmw3U1JDSzUzcUh4dm9uSXRSeis4M0pGTDZs?=
 =?iso-2022-jp?B?VXhmMnJxZW1ZVUU2VkZ6TVdrT1F2ZkhncldLQ04zKzdvSXdLYndleEVP?=
 =?iso-2022-jp?B?b09CVVBrWnZSU3ErYVJEeGw0c1RvamZyUzg2QTBOaWJwQTA4ZEo1YkVC?=
 =?iso-2022-jp?B?SmNIcnlVNU9abUwzcmMyRlI5VmEveENaUXdoMkZ1cTNrRG1HWVRWN21R?=
 =?iso-2022-jp?B?NWNhUTZIQ1FFU3VnZUZRQ3BkVm5TbmN6Ym1hSU12Z1k0TGlRUGo2RDU4?=
 =?iso-2022-jp?B?a0tNK2xZdmwvNDhJd3ZsRnp6YjFmS05BNFhzMk0xMFJhTmJodTgyc2V1?=
 =?iso-2022-jp?B?UE5uUGcyRjBiM0pxSjBhODMvb2dwemFkTUhMS0N6MXBPUUgza3YxZXk2?=
 =?iso-2022-jp?B?eEFBSFljZnM5MVppMlZ5WTl6ZzIzV1gycVVsOEppWmVpdTNXNXpvTGR1?=
 =?iso-2022-jp?B?MWNiSXA3cmJzMEZibkxuM1ZJUTFCMkFoMEU3OEorR1pCWTMyS040aEJx?=
 =?iso-2022-jp?B?NWp2VUduL3B6S3pIakszVVFJa0xGR05xdHA4aTBsZC9aM0oxZUxBRlg4?=
 =?iso-2022-jp?B?SGJGMGo3bGVPeWJnRC9MalZGZFpZeXpwaWh6TlRnaGU1YWRNWXZkSXRt?=
 =?iso-2022-jp?B?OUUzWWZtWTB5NjJEYmFJalJtYzdLenA4QnNLU3lmRGdrc1JCbTRUcFlm?=
 =?iso-2022-jp?B?Mm45VitXTVduVHBUZzJkUzNmU3JNQTdlRUxsZGdITll1UEdncjAvQ3pQ?=
 =?iso-2022-jp?B?L3p1dkNVejZzalE3WDd3Z1AxcFFNMENWbmlmVTlRdlRuM3QyNHZpbDdo?=
 =?iso-2022-jp?B?NW1UZ0ZVTDJaYW0yVHBNcnZxUnkycFFQcnUzc2dvS3dhQTltaXdnNWx6?=
 =?iso-2022-jp?B?cldwSDhLU2RrZWlPUGNMTjliRElPUk9XS245ZWhrSTNLYlZlNFZiNnR6?=
 =?iso-2022-jp?B?OVg3QUM1VTRiQldoK1NvbFQzcG1RdFhaZ3JvRERhdTNFaTF0MWlZYmVi?=
 =?iso-2022-jp?B?ZFVudit5YnozaTNiTlNvODRndVVPUTdCV3NIOTZsQU0rdDVUb294SjRm?=
 =?iso-2022-jp?B?bEJJYyszclFzdkQ0Y0hSU2s2TDlCUm9vaG1pdUZITU5lYWhUZ1UzZWV0?=
 =?iso-2022-jp?B?OUMya1hPUm15YXlDUzZLZ2pURG9aNEVzelZqWDRwQXcrc1pqdmdGaVFx?=
 =?iso-2022-jp?B?L1U5eE9KY0I0TE1EQnRJNzRPcTlaWjkyaGc1WHpVUE5zN1llTDh1UGZl?=
 =?iso-2022-jp?B?M0Jld1FZbTdhNEZIM1l6cXJ4aEhUbmtEMkRVamQrVmVwdkE1T2FCaUxG?=
 =?iso-2022-jp?B?bHN3ZlFMV1dYQVRvcXhGMC9TZnVqeExGU2JkNUN5eHRjL25JaEhTM1hN?=
 =?iso-2022-jp?B?ZVpHenk5eTlLbFhwOGk1SWJkT09uRUpmT0VsczVnVitzMlgrWUkxYXFH?=
 =?iso-2022-jp?B?bDJkT2VWVVkyYkhwSzhuRCtwYXh3WSt1MUs4NEtTdGtzdEFJVW9rK2ow?=
 =?iso-2022-jp?B?RHZKQWVBa09xd1Q0dTFBcUVtYWdZT0x4UHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d06f1-9447-4cf6-34cf-08de21ad105f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 05:33:52.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKd7dodq0l6BlnC2UPBhx4deBB7ZZEn8J7ISPbmOVISWPahodGVp2NIEsoJywKcN2b5M2G0L6M42WW7ouemttNsNSc0WRZEYWi9l02HaM4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8799


> From: James Morse <james.morse@arm.com>
>=20
> Reading a monitor involves configuring what you want to monitor, and read=
ing
> the value. Components made up of multiple MSC may need values from each
> MSC. MSCs may take time to configure, returning 'not ready'.
> The maximum 'not ready' time should have been provided by firmware.
>=20
> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns not r=
eady,
> then wait the full timeout value before trying again.
>=20
> CC: Shanker Donthineni <sdonthineni@nvidia.com>
> Cc: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

