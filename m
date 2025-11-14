Return-Path: <linux-acpi+bounces-18885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB80C5B07C
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 03:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39493B3E71
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E620B81B;
	Fri, 14 Nov 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OGEqY1q/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011033.outbound.protection.outlook.com [52.101.125.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB023EA83;
	Fri, 14 Nov 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763088441; cv=fail; b=P5VpY0ewxaPx6a7iksn/99S+MkWsYdYWflBqP8dIDUQsF9dKYnkE+rBdQgilsciIsL9V8H0uQueBhhB7vw22yI70zSqoc+btr1/lk0j/GCIWGUHoG3UbdgTZwSu8xAXRGd2wf5IQtht0OHbqKLUPDccpbej8FdsJRloO9TMvYEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763088441; c=relaxed/simple;
	bh=0Ud5c07Vmk8Kfhhu5ifBLnmuqTNhkT8jxDhc0i0mRmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=no7X84gDOlA8saKkHhxwWHIaWiy1cik/PtctcMq3XPP7ciD+ehlUtD3uIbMZEKannChto1BCcb8YjwTgeW82WiSWddR5Cxou0UdbSxcu5s72p4fN4wqTMukmR8UDlOijOcmrcwHQSJvvgToBIL7ZMLPmy9bpwDhItuMmN6306uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OGEqY1q/; arc=fail smtp.client-ip=52.101.125.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K23BH9KIy+O/7ENkneHC9uP/5dQH70Do53Au/qLmcBs+ij5+qQRzdPdVwvXeS6OpPsBgzmwHaFbr2/wwiGgyhsNGEMsUTeAFN+KIy2ZZQur578FsGuZJSRm4x2mpRawtLxWvt5fJg0e26HiBqmK/gIT5wznGUvoh8xZUvGWS2tAgqfbk1d2zvwQyg1tciGfgp7rBU2X34NsGBTxljoocYJv47DkG0v5tocDLqLvMK3lfcUI/SMNp4TxLwVf/ptTllXTrIXjFVOYW07muklTRZEeywXt8BH6Jk4w3gCdoM5+ukN6OE0XCilgCx3ElHXIK/JfRj0oj9uA4mwTte/QCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ud5c07Vmk8Kfhhu5ifBLnmuqTNhkT8jxDhc0i0mRmI=;
 b=MJkJWT+9C36PHV+n+57k8pQz9jdVf1zc3qzLE+iIRxQY10IZSCf/gbgk/huaG5jTDtTDiOAlQg2zaEfuswut67gncPayNuuTffn0dq20uGghrUHQW5+1ax67FOkBw22hnPqrI/NLP4nExWuEmSc8/C4Fg4UFdoHzmdyaDK+OvqiaS+YoscL8vLSrRX7p7yLvDsbLhTP7C5nRZ4OPCCFwU5DOvOzORJScyAMO9m4CtbOnemR0aYGBL/xAvkoCEzrRrDR4yB/vMto62HPEEuy7/eXJ7lXbM3VMo4SuHwVUdE861hCK2Cyb1j+mNAFmAjZ8IEywmz3jCmlYTTQok7uQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ud5c07Vmk8Kfhhu5ifBLnmuqTNhkT8jxDhc0i0mRmI=;
 b=OGEqY1q/uz0WxzpfI0nAKL9vOB0o2ECbUMfqehY/E5X+pflMb5xwYqKtyumXH1HMUX5rV4o/q0KS24jQXMhdWmUE+y4w6cGRx5WTNVjPs82orIL++1/K1LM6ZsP/5qd9mRRKPiIS7xfJhjbpbpUbzGNfOG7+nnaylipCGE+/cb7oEHFpZOciCsgBUSO6qqkaFr+hYKC4zvy5j//TrG3fD4MhwVDyNmt3eGzs27+Ri0rPqSCPhUUFEAPV+nFn/YTCrB5LOO8cc0rQE67qDxq86kJa0H+4e8Gq0VemQBNAF3ppu/w0i6VMsh4D+BT1lPmOvXKYReVFobQzPn25Fzff/Q==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TY4PR01MB17406.jpnprd01.prod.outlook.com (2603:1096:405:354::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 02:47:17 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 02:47:17 +0000
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
Subject: RE: [PATCH 19/33] arm_mpam: Add a helper to touch an MSC from any CPU
Thread-Topic: [PATCH 19/33] arm_mpam: Add a helper to touch an MSC from any
 CPU
Thread-Index: AQHcT+M/+dOHQmJBcEOYo9jOcK1B37TxggQA
Date: Fri, 14 Nov 2025 02:47:16 +0000
Message-ID:
 <OSZPR01MB87986BFE3A1821795DB237538BCAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-20-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-20-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=2279d1b2-f8f0-4063-b9a0-10ae78f3bed9;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-14T02:46:37Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TY4PR01MB17406:EE_
x-ms-office365-filtering-correlation-id: f092f7f3-9421-4203-1e18-08de23281fc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Wi9oaHRKZkJ2S3kweGZEUkpJT0Fva3p0R2ViYkdJaHpjSUZMelp0OWw4?=
 =?iso-2022-jp?B?NGIvYklWT0dUbkw3UVoxN3lLNGpOTjBaSlNFVnUrU2RLWVowV3EyZ0hw?=
 =?iso-2022-jp?B?WDhjVWtNY3VEVVUxY2xsYWNHUE5lYjRHNVorQUpEbW9XUkF6OFVGTmla?=
 =?iso-2022-jp?B?Y1RKTlBFWkw5VVZlc0trNjlrOFZac3hubFR5em9QNmZoWlZ0ZVNGY253?=
 =?iso-2022-jp?B?VWNlak4yc1k2ck5oa1d4enBYajgyOVJBeURwaXlUYnkycndEZFhRMUh5?=
 =?iso-2022-jp?B?Qzk5THl6RUxsTUFQNHBnKzZMNCs5ZWk4cVR0ZDZMb0hjdlorZTdRNlFj?=
 =?iso-2022-jp?B?Qzc0MDF2WTFIeUdtV3BqT09TOHQySTIzZ1B3cll5Y2MxRUo0T1lra1Za?=
 =?iso-2022-jp?B?Q0N2V1hqTG93bHYwemRkU2JJN0dqcWYvZElHbzN4b0VVM0dUZXRqdmh3?=
 =?iso-2022-jp?B?UG52ZUdXZ0ZIWi9UZFJtbTlMZC81RHBVL3VoVUtKS3NLc3hhbVk4Mm5j?=
 =?iso-2022-jp?B?eWdJZUt0WmxaUTZVSmVxVS9oZ0krTVhpekRpVUNJWmdCYk9TbFNHaUJE?=
 =?iso-2022-jp?B?N3FqeFRTaWN4SEFyVHNyKzNrZ0tVZ0VnTElaS0IrbjJnZnYydm9XUEMy?=
 =?iso-2022-jp?B?K0RmM2RKUVV1UEVTeUFBUUp3L2RVbFBnZTJwZEE3ckI2U0lta2NHTm5L?=
 =?iso-2022-jp?B?OEdMVGZPaklDZ01rOS92KzJldmkraHljWHhpWHcrb0dVSzB1ZU1zYk1U?=
 =?iso-2022-jp?B?bC81eHo2RmdoNzgyT3R2RmhrRzVNVGpXWWNyZ2lYdjFhK2tsNXFIcGVD?=
 =?iso-2022-jp?B?b2NGaGlzVUNrb3JVVjJkbURUN0UybkM0Zkp2bDNhakE5Y2xHTjYvRHZz?=
 =?iso-2022-jp?B?QklsUjBYV3ZrZTJmb2NMWktQVTRycytMWnh6M0pneFJyVHlDdkJteG1q?=
 =?iso-2022-jp?B?ZldpQUxEeC9PZStIOG9oaWdzZFZwdlhjd3ByZjcrZWpMdjlRUFJHWGRI?=
 =?iso-2022-jp?B?LytEZjFVUzY0bVM4eFZLRVdkS2twTzJSRzhBVm9EQzZzYkVOcllpejNN?=
 =?iso-2022-jp?B?c29haGloYTkyakRVK2h0SDdvdFJZZjRoSFpYOUljSERmd3k0V1pmMnV0?=
 =?iso-2022-jp?B?WURPcU5HNTdzNmVrL2FmVUxqbWo2a2VkSFhCWlFNd1FhaHRQWld1Nk0v?=
 =?iso-2022-jp?B?OHBTVG9XWHJCd0hxQ2s0K2FHVFhWdkoxR3VraFNjMWNBT2VHTHJXTm82?=
 =?iso-2022-jp?B?TmF5bWFRN09zV0JIQTQ3eHo2dGV5am0vWlpMaEtmOVE4ZEhiWkRuak1j?=
 =?iso-2022-jp?B?Y2lyTk51WE51dFVxQU1veFBRekZIeGtvNWNVL2ZxK2NRWHR1L0x0ekdz?=
 =?iso-2022-jp?B?SW82bkhlL0drOEVGYUxrS1hOdHZPN0E2Y2dGT3h1V29mZHJuN1FmWEVH?=
 =?iso-2022-jp?B?OXMwL01yVUZXdjF2UmkzMlU1Qk9yTTBEemFIOUZIUVNSWUkvc2p5MWRQ?=
 =?iso-2022-jp?B?YjJxYVFzOVczbjZpWlo2Rm9IQllaWHNBOWhhYno3S3ZZd1ZxM3crdEsx?=
 =?iso-2022-jp?B?L2czL09Ob29zbHVVTThQVmUvNDFzS3dhSW9LUzVQY1VXVWJJV1VCT2sy?=
 =?iso-2022-jp?B?SUM3TDlFU1A2RlFibzAwMXRQTnM0cXBsRWU2LzdCazRRRGFLMDlZVHg0?=
 =?iso-2022-jp?B?MEgrUllJbmNQeTFRNE9yY01uMVBGTzZaZjZPZmdNYUdwcGN2Z2lJZTlk?=
 =?iso-2022-jp?B?bi9QakhuQ0pDbHlyZzMxa21pNVRjczYyVU51QkxrUkl5d1BNcmZHUGdn?=
 =?iso-2022-jp?B?YkF0ZEE0UzRjYzU4R0dybHZpSDJKR3BPb0dXNkIyYlZLcEt2b2lxUGs4?=
 =?iso-2022-jp?B?RjFDdDQwMHN6NWFxMWtCWEZUblJnaUMra21PTjRuMWwrb1AwTjhQeklq?=
 =?iso-2022-jp?B?a0w1QzhkWmdZZi9TSWpTQXdmQk1qQkxHOFhHWEw1WlRWNmVGUlc2UHQz?=
 =?iso-2022-jp?B?S3FsYTBHRHZ4TWUwdWtjamQ1SzJnVFZVa2NzamJFVmNmNCsvUGF4YXpa?=
 =?iso-2022-jp?B?L2FVbVIvVlRKcUFJWklkUU9EcjVURlVkNEt4Z0Jha2d1Z2Uva3ZXNkdU?=
 =?iso-2022-jp?B?SVhmczJYN0RHT3pqUkd5cTBwMjlDU1lqL3NMVzJRODVFWWE4VU5ZSlVh?=
 =?iso-2022-jp?B?M2h1UTd0dlFqcW5vNXd2SU0xbEpxd0htOW1kZXBlMHhzQk1SbEFzVzFZ?=
 =?iso-2022-jp?B?STlBZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZWs1UUc2SXlXazJscHB2QXZiYkNPeDU2N3pxOExMNjI3bERma1l3VTli?=
 =?iso-2022-jp?B?SldsL2tTUXhrd0x5bTcvSHNqaDBLQ3dLUE9qcW5DVERaZFNjcDRzSHMv?=
 =?iso-2022-jp?B?TkZpUDRXR0xpSnZIV3E0NjFQQ1htRSt3eG5sb1BaVlhEbTRLTkllMEhn?=
 =?iso-2022-jp?B?d1VpSUMyQTZMdVJoVDluU1RkYXVubnVVblRTTDR1R1h0TldhR3U2eTlW?=
 =?iso-2022-jp?B?L2g5c0diUDB1MTJVRVRXemlEaWxzMnB4cG1tY3Z5a2ovNE5KcWlsYk1G?=
 =?iso-2022-jp?B?S0RkSHVZN3FSUThDZnd5ZWU3UUpVQkMxWExWR3ZlbWdDNUJ6dS9vWVZF?=
 =?iso-2022-jp?B?TFdpRVpKNjRiaGhHcDFIMXNsOXJITFRtcndsTy9yajB0V01mVUhWYmlu?=
 =?iso-2022-jp?B?dFpqbTZyMUkzNlZGUHpwbXRjS1F1bXR6TDdub2hkOXdxNUdqNFlCUlJJ?=
 =?iso-2022-jp?B?bjNTVFRhcHZUTG9NT2YwLy9sSUFkaDJvcHk5T2YreW5tSjM2ak54SzFT?=
 =?iso-2022-jp?B?QTNPYSthRitIM3JKdWMzWTRrbFphcUdGN3RaNzZxVWdBL1Z5NGg5VDFP?=
 =?iso-2022-jp?B?Ui81N2FpVE42N1lEakt0TGc5YUtuUWRHdjd5SGNhR25BNUsrUmhUU1Nl?=
 =?iso-2022-jp?B?UTdRZ1h5aUJCbnpQcVdGQUhjSy9qd2RseTY0d2JsTUpLZ0x4TEJsanJE?=
 =?iso-2022-jp?B?NmNJNDJKdEdwOGR6VVFFQkx2eERubCtjMEIzMU81b1NUZ3kyM3hVL2VV?=
 =?iso-2022-jp?B?ZGljZ2hobHk1djRCUUV2cXVwalVaZHVJdTlTTlVhclhhQkoyZjNXZ05U?=
 =?iso-2022-jp?B?MFBFVURmb0FCSEdkOU43Tk8yUEJ2b0ZVdlBseFU0U05qcWJvRko4NXY4?=
 =?iso-2022-jp?B?bXhoMkw4eTJEQVR0UmpEcXRFbEFCSmY4bVQ2Tk54ZWg2YVo5TWRaZ3lt?=
 =?iso-2022-jp?B?S3RnYUF6T2ZCS3VlNEUwZlBsczA5QUdHaGZaYmZXU1oyUzlnU1lwSk5T?=
 =?iso-2022-jp?B?WFhaaFBCRFVDWGIyQUlOM2ZYZDJWeXo1K01XaTJRSXh1RWQ1Z1J4NEdq?=
 =?iso-2022-jp?B?NEprL1k4emVqS1VvdVB3ay9sMkZvT3JDK01CQm1sYXdmNUwwTkxtK1Ez?=
 =?iso-2022-jp?B?MHNMTHI4MmtMTUZZdGVHRVJKWmJ1a1Vzb3BRSExWOHcvajA0YmwxV1BM?=
 =?iso-2022-jp?B?MGF4YmlEOTViNzRxSmlWL2NHb1ZlVFpuTTlsRGhwZ0F1by9RMXljaE9w?=
 =?iso-2022-jp?B?RHFWalp1ZGpFZUl6cU5oMmZrcTFYaklTOUcvNlJrL0w2WXl4Uzg4ZmtV?=
 =?iso-2022-jp?B?a3haNGo4SkNDYXg2bEJ6bnpyYmRVYVlyMDVEbnlTK25pSUl2ZGdyQzVr?=
 =?iso-2022-jp?B?TWpFS0l5ZXAxQUtUem9rUW9zQ2EvZmxnRVR4ZFV4NXd0VXFLb3dNTFAz?=
 =?iso-2022-jp?B?WXg0YlBEZUxhUmJVcXA1QUh4WlFZK0ZZWVlLTUNVKzhRMzZiOE9nWVpz?=
 =?iso-2022-jp?B?OUs2eHVJUEtYZnhxSjB5NHljemNybnJ3ZHRtUUxjcE03cXNmM1pIUWlk?=
 =?iso-2022-jp?B?bXpZSWZQSTNCMjhlaEg0YzFpazNDaS94dXdsQnFXRnB3OXJISUZqNlY1?=
 =?iso-2022-jp?B?WW5aZjJWNnNMS1JTSjljQUltNVJWbjlwdnZ5cVdKeUdEMkM3QmRWbTFP?=
 =?iso-2022-jp?B?UnNsNG15K3ZrMWJ5TVg5M2J5eG5ZU0VLcEFSZ3lOVndobWk1RS81cUxS?=
 =?iso-2022-jp?B?VE9JWHU5VkljNkNiTWlxdzE3UkJxZG8ra3h5RkxVdXA4R1FDWC9vS05m?=
 =?iso-2022-jp?B?WFhkSFY1b3hSU2l0Q3dhMXhxNWxVVDNoTVRqalRMYnV6TDRzK0U2RkVq?=
 =?iso-2022-jp?B?K3ZLV3Y0WlZzdTY5Tlp6cHY2bkZJbFFSRlFYd0tHZi93WGJ5MTdHanlH?=
 =?iso-2022-jp?B?a1NGdTl1bkFoTHBuTHg4UXNaVmJDd0p2TGFtK0M3WGF4ZjRmam4rc3J5?=
 =?iso-2022-jp?B?cFFuMUZGb2xIL2REb2Jjait6KzQzVzRrOTBwdk5kMnJCMkdINXBZcW4v?=
 =?iso-2022-jp?B?ditzekREK2hscUlzckNBMDM2bmVaaUtPQU9tMWo1b05ET1BYa2RYVzVZ?=
 =?iso-2022-jp?B?NERYV1BtTVJjQW9CUm5nR3dldlZQeWtObDBmdGhiZWFJZUZHQ0U0MzAr?=
 =?iso-2022-jp?B?dTdNUGFLV3ZtNFZhbzRtMHR5WHZDaUFSeEVBcjdOWUFHS2QvbFYyTGtF?=
 =?iso-2022-jp?B?QmZFVmdORFpOeFdEMDhpand5cHJUM0tEbG5jdWRNcEtkMHJCNHovYldN?=
 =?iso-2022-jp?B?K2xBSzBHV0Znbmx1N2R5ZGJNZlpxV3FydHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f092f7f3-9421-4203-1e18-08de23281fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 02:47:17.1025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzPjfXp7yQ5uqh/O6B+Tqry87bJETQtUqOFE023O0CCP1No2Azo8azqDcpNikQ+YhauxVva35Bx4Glwj309NId+g7hh0Lrlc2HwvUXnpPJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17406

> From: James Morse <james.morse@arm.com>
>=20
> Resetting RIS entries from the cpuhp callback is easy as the callback occ=
urs on
> the correct CPU. This won't be true for any other caller that wants to re=
set or
> configure an MSC.
>=20
> Add a helper that schedules the provided function if necessary.
>=20
> Callers should take the cpuhp lock to prevent the cpuhp callbacks from
> changing the MSC state.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

