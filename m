Return-Path: <linux-acpi+bounces-16520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B7B4A394
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109957B103C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FA307AFB;
	Tue,  9 Sep 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MmoxhgKb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B3307AC7;
	Tue,  9 Sep 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403129; cv=fail; b=C4XaT9gKghFUf70/tFP/2xz0de+xzZIY+5G5WOydCxe3qm4WMBcJuHeRGbEtG8VvgAXfuDTxkaQg6ZeUouR8sVKinYsHNhaQiqu5TTKskuaj0SV+CDIQdLKrKmo/YAkHaL2ZDV6mkQ85Q/rCKgb6MI58bPLPYLPkEoS2+SB0ODQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403129; c=relaxed/simple;
	bh=gBfzHng/mm0bxhk8/3zBHF8x4FCgVfmF4XzFhqZxKE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4z1sjbN6igA9klpDtJEdCcucVbNI7aCCkku6ZRnKUl2WUzfuZoqyeLGirZsdX3Qq8JvZpbeKAk28xTdvx38UUKXlxE1aRFOZX6Ah07V60M5gk3G3Uh0Lh1Hzh1gS146+DtlZJRQp/E3CgL/0/6FCKfUxsY0+5iBVQ0gRz3EY7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MmoxhgKb; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757403126; x=1788939126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gBfzHng/mm0bxhk8/3zBHF8x4FCgVfmF4XzFhqZxKE8=;
  b=MmoxhgKbWtOTHZlqMQ5PjtYLvKobo4fcA3DhM0pGJuGIANf+Km9J2ecX
   LnWebokbzjxgixtog3cuRYlGQjxeUIgOAt5dwVP6IHx10dl6lCkamO4bA
   yfP+f7/WRMUATOjeXmqhLQRa7OKSU1UQMOJEH3wSBch5gC7HhIlZZ980W
   4W3Pxxb9UlDhIr9rFR5lOVbI/sPgnQS4MQgiH/XlGPsEUoSdRAJ+zxvLc
   ZPmQ88PKmY0LPZPtZqHHVZA0NqPpL1oY9GO4yKMcuQssJOAmOwHVMoew9
   O1ucx4dtjzLgMh2QWZrDvn7WXtorSHwWVFGdaDV4k2P6seFIl1CjCBi9w
   g==;
X-CSE-ConnectionGUID: Lt+zq6cqREm4b7rKEw9NPQ==
X-CSE-MsgGUID: 84ocCI6ET5y2ZnZ0ESA4iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="168132212"
X-IronPort-AV: E=Sophos;i="6.18,250,1751209200"; 
   d="scan'208";a="168132212"
Received: from mail-japanwestazon11010008.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.8])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 16:30:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMd2H3PdXERYQDYE6hwpLHzD7W7O1rFeauNCfqv5dBdcK8z8Ivv1sWiaOoQQSQEyxuBbUcukSE6vvrthNtymPFvDeGgJs50TH9A0ujVwjaif2Tb/ur0qsuJEFNzi+kX8nSs+H8X0HwIf12n1gK+2kEaBbokxNvomS31/bWI+QLqeoU/6tjoPWgxcdp35Vk+BOziNRfnXlOx7h4G9n8W0ItDwgCJ21lRSe75A477mON6cmZWGzVhmg9XWhQWsSFXBd4e/5eYH3q3b8lB384ruqFRiaqO4R9W1/EPhv1eEsUbshk7wkaOLPJdAMNI3kOdiu3bwOICNssL3ET/t5ojd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA3pAWz6kaR7UqaQfjgOJuSUA4k9evQg+nZV99y+M2k=;
 b=VcgQfrETyA1yttjSZXbrdVYcU1ByTXbhUu33qGunduA4l3C41dq8f2Prp9EdRo16aV+0qz1vc6mZswWHHC25Tbu3eeHB2xrH0fu80784UP99AdMjBGaHUKQTZdSDRLdR++68Mgy8JlCxXruCCwShU+K+5tlNQwnRldy28Hsm5cgs81bXdoLhe7juaGi1MXUY4c0DAcyy0eAB3l/EpK4x9PD4aarswrOn0HF8UifiiJCKgXiqcmjTAcpidglbPMzDLta4r6P22CA9pa2OOfOUYMjH2dp/EE7bMkD0V0/8wjfMkq/kzKJ/17buHFLre2dT76hcpE2wxOIure3Y7HXNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSCPR01MB16166.jpnprd01.prod.outlook.com (2603:1096:604:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:30:44 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 07:30:44 +0000
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
	<dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Subject: RE: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
Thread-Topic: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
Thread-Index: AQHcE3pkkI69kPmfV0CsLeBrNWtIprSKi/Ew
Date: Tue, 9 Sep 2025 07:30:43 +0000
Message-ID:
 <OSZPR01MB87983DB7BF0AF0672A027D4E8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-47-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-47-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=26406b4b-819a-4c93-ab81-7f321d6f7a58;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-09T07:14:58Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSCPR01MB16166:EE_
x-ms-office365-filtering-correlation-id: d2615bb4-5c84-44d0-9ccf-08ddef72c970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?aEtHOVVOR01kVHVQaU5FaUxjWDBDOUVnTGNuZ0JKbk1keXpFTTdqaVBQ?=
 =?iso-2022-jp?B?UGZGZnJMc3prbVppTFpyc29kQ0thY3MvNmJjQjhlSml3KzFYK25YQkEy?=
 =?iso-2022-jp?B?MWdmTjhDWGFtSVlYbkNRYmVwTGtSNVlyNTRVOHBRcDFQVVNIa1E4OTc2?=
 =?iso-2022-jp?B?bXNlU0ErUm0vck4yeHlPZ1NxaFFQTmVnN0syRmhKdGI0TDhyTTY2U0RV?=
 =?iso-2022-jp?B?eGlBck1qR1BqaFNGY2xNNWRnVHlRNFM5d1NBdHIvb28wMnN4dmtMOWF1?=
 =?iso-2022-jp?B?NnRybUorcnR4S1VodFF6aS9OazBTVlk0ZlJRMmxpT1gwZXFqejVzZkc1?=
 =?iso-2022-jp?B?Q2liWDE2UnJqcDZTV04xN1R3UXpHckJpbU9JRjF0RGtIa1dqMEJwZ0Vj?=
 =?iso-2022-jp?B?NmFneEtmbVowQUU2K29ZbjRzZkhiV0tmQWp3bU9CM0FpVXFORXljVUR5?=
 =?iso-2022-jp?B?Q2JsZ29CakJaSWZMdFJIVU5NT2pIMHJUSk56eEJ1Vmw0SW0ySE96WHFM?=
 =?iso-2022-jp?B?Mmh6UUtRWitDSEVwMG5kTUtycndlVDEvSHNvUzZTeCtrNllQOGpRU1JF?=
 =?iso-2022-jp?B?dGphekJHeWxaYkxhOEQ4SXpKVGl2V2N3Wk9TYU1uK251bjZGQUFXRkJF?=
 =?iso-2022-jp?B?a3ZWSExFaEdTeUkxU2E2ZC9PUkpHdkU0WHlaMjJ2czg5ZS8wU2hUSzFr?=
 =?iso-2022-jp?B?QVdDWVUwcVc4OUcxWFpKVGJ2ZHFlU2s4SGJnaW5qcktCVi9EbUxheDhK?=
 =?iso-2022-jp?B?c2cvUVI1bkM3dHFFNDVEZW5wRWx1YUZhcThRaXAzWHZFWThmZGpPOUVh?=
 =?iso-2022-jp?B?MWdtVjBQMXFKY2ZpbWpTM2pPNkMrcXg0RHgxRlZTNzVjVUhpUGV2cDdZ?=
 =?iso-2022-jp?B?MU16WnNCaW5hdmo0bmR1QjVxaHVuZzFnbThGOUpXc21Id1FQVUFPclM5?=
 =?iso-2022-jp?B?c3c3VllHVkJGSDVsNytsazhJTU9Wa1I2YmZnemNNQkkxcHlCN05XQ0F6?=
 =?iso-2022-jp?B?OGFqWUMyMGlibHFHNDBVa0k3eFBCeHAwNXdna2l6UDZxYUZVZGlUTndC?=
 =?iso-2022-jp?B?U2oyYnFOM0Vpek51eU41K0lBWUJBRll0ZzgwZ1ZabS9QSDRPSXd2S3lB?=
 =?iso-2022-jp?B?TVR1Uzh6THhqVklJbzJvMkVhcTFPR2pSd1B2ck1RK2M3NnRpQmJmU3hx?=
 =?iso-2022-jp?B?S1NnK3FDNy9UczBqRFFKNlg0TWpCRWNYSDN6UHQ0NjhGVXV3L3F0cVJJ?=
 =?iso-2022-jp?B?ZndRYnNZQkRxTExqeFlPL3c1UFRyWUg0MnhNeFBLdWdaV0x4M1laM29M?=
 =?iso-2022-jp?B?d3NjekhYU2gyNzAzTExTU2I2VHBITGdiUWRzM0dXZlRVeVlyRWg3QnZY?=
 =?iso-2022-jp?B?YmZQaFdUcGllQm85bHp0aG1Dd25QZ2lna2RqbUIyNHdNVW1nZEltZGkz?=
 =?iso-2022-jp?B?dGRyYzUxTmUzWlVraHFDelIwZ3Zwb3JSTDBwUHMzV1dOM3VBc25nUVJh?=
 =?iso-2022-jp?B?Y2lXNXFOWm5ZWFE3UVE2aDJBRmNTUkROTDFMVlNDZnc2MCtSTGxHMk1Y?=
 =?iso-2022-jp?B?Qkhhb1NicE03QUZyUlFaZEZ0d2xxV3lZNGVrczM0QUJ3WEpVcVFYeGM1?=
 =?iso-2022-jp?B?eHllUTRIS3V3blNYOTk4ZFRjZkFySHIrbzk3QXJoNEc4VUxBdlhPT280?=
 =?iso-2022-jp?B?Wnd6dUZRYi8zc1k3NGU2bVhkUm5Db2lPS3Q0ZjZCVGZ0QmMxOGg4Yi9v?=
 =?iso-2022-jp?B?Z2Y0dUtsTU5MNXNkV1VyeG5iWlBpajdNbWdzaUhheDk2QkE2Y2NySWd1?=
 =?iso-2022-jp?B?R1hhUjhiR1hNZ2xKMUFKWHUzQ1BxZGZ1MDVWaktydG9kQ0RCY1FkQ2px?=
 =?iso-2022-jp?B?RmljdlVJSGxnY3VlSkR3TkFJVTFrcU1vU3B1eXZKL1RTSHdWbWxRQXRY?=
 =?iso-2022-jp?B?VlJKL08rMFpsYXdBV0taN2R1U3E0YWlIZk1LR2tNZ2NwUTlNUFdOZkV6?=
 =?iso-2022-jp?B?L0swYmU3S2Q5ZkFrYVNrMzhBR0FxbmFwdUlIQ1NVZk0xa29FL2YyK1JS?=
 =?iso-2022-jp?B?S1JjZiszMWNEQUY2RVplTmJmdXhzOGhBbSs4Yy9ncXUyaFlqRTZvdzBn?=
 =?iso-2022-jp?B?R3Q0Nmxyb1pZMGFSK25xazhidDhrSWJrSXBwODB6OGFPTngzWFI2M215?=
 =?iso-2022-jp?B?VUp3b2wyUko5S09xN3BYL1BZQmV3L1Ar?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZUV6L0xDWkxHNFVjZWFkZCtzK0F2dHpjSkQwK2U3dEVMSUZXMjVYTFl3?=
 =?iso-2022-jp?B?OTB5ZUZjOFlmdmxoV0E0UVRsOU5RUFN0V3lMSzFLKzdLK2k4UWlZZmJE?=
 =?iso-2022-jp?B?SVVxeEcrR1IrdEdFcGFKSnd4dSsyKzZMQmVXdXBPMEFNVjIvbE1qRFc5?=
 =?iso-2022-jp?B?dm1Jd0pZV2RHUzVoRWdiZ0phQjZqZk1Ma2I5LzU5L0Y4QzUrcjRCbldU?=
 =?iso-2022-jp?B?MUxESTFZUWR2UTJDU2NySlBxMmEyTFdwYUpQSnF0TnJmQUwrbFRHSzVH?=
 =?iso-2022-jp?B?UlE3Z3hjeVNuRzMxUWU5SWpmNkdzcitzR0FzTXR6d1llY1FVcGdIOEEr?=
 =?iso-2022-jp?B?TUljbTNOSlRRZlp4SmlZckNkeDVTQmtvaEpLSEVTOCtJVllXVFUzRGNR?=
 =?iso-2022-jp?B?NzZZeFIxTGU2c2VHQWpRYko4cWdZRkkrdk1ZMmVneXJRbkxlUVRFNzg0?=
 =?iso-2022-jp?B?VVlFdUpubk1DUzB6ZW5MSlhNcjRNQUdhanRkdWQzYmtlZkR1WE95ZjB3?=
 =?iso-2022-jp?B?ZnJiNVhPc0xsc05QNWJYNFdsR0dQbDhoZ05tYmpkWlA4MXZQdVVCMFFl?=
 =?iso-2022-jp?B?QjY1M3djTExoNzlHdVFnd3Q2VjVPNU5DcnBKREtpN0J4NUlOQnpIYjNn?=
 =?iso-2022-jp?B?bUkxQnkyS1VaZjArWlRoanU5ZURqS3d6UGNUYUNDdExKOWt3anBWMjE5?=
 =?iso-2022-jp?B?OHlqUUs5cFU1SVBqN2swY3VDc2lZSE1NNW5mQ2duTGxNVGVCbEZSd0Q2?=
 =?iso-2022-jp?B?SWQwaEZXRjh3QXRacVFrMWZJY0FhM0ptaTBURW1QRDh3V2RDQkJpMFNZ?=
 =?iso-2022-jp?B?WWpqOUxKUW5PS3J6Z2M0bEJNQ01rODhQd3R1Ym9LcEUyN3d0NE1VbGhm?=
 =?iso-2022-jp?B?QU5EVm4yazFqRXBXUEZvaXJNdVhzNmtiYjJEMjRNaDNpTjNGSm85TGxF?=
 =?iso-2022-jp?B?RFVMTStCQitkbzduVG9Vb3Y3SVdqZUZCMURRSmR2NGkrY2xDSFMyN0Jx?=
 =?iso-2022-jp?B?WVYxYXhEWFYvL2hOVStjMURHMm9DMEU3WmpqVnQyQ2huTS9heFdyN1dj?=
 =?iso-2022-jp?B?K1ZtZDdLZ1VRZjBhZTV0OCt1Qk9HZit1U2lpMDBseWFWUlhxNGdQNjN1?=
 =?iso-2022-jp?B?SXQrOEZUT3hpclR4Y2NKU2RsMEU0TUVsVUVucG9vMmJ6RWorOXFLMkM1?=
 =?iso-2022-jp?B?a09HTlZWZ1NPSi80UHRzTmlNbTMveG1vWkp4QzVGWFR2RkF6dXhvTUlQ?=
 =?iso-2022-jp?B?cTNkSUNsV25JaE1tWkVhOU9kbjUyMjhmeDBnSldXL2xJamJuY05FeEFH?=
 =?iso-2022-jp?B?SWtCV1ZLaFI1SjZHc2dhK0VoK0ZDZU5Td1cwSjhzaXdpRE5ERmhRVkhG?=
 =?iso-2022-jp?B?UVlJUDNSVm82Y0tMNGN4WVMzVkZYbUZJbHc1dlBBMGI2dGI1Y3QrUVhK?=
 =?iso-2022-jp?B?cllVLzE3MlEybFFGUktHOUZkcHF5M1Y1Tm9UTnp1cEs5VlA4dGZFK3pI?=
 =?iso-2022-jp?B?RDVIMXlTbmRRRW5nK2laais4cisyeHBxMkhId3JvbmZNWkROcTZnaXEv?=
 =?iso-2022-jp?B?TzhGQjMvdVVHem9GVUVHRmZIeVQwSExRMnBzbGhOclhVTDh2VldIZ0hj?=
 =?iso-2022-jp?B?TFo5cTB0WTBnNEdXY3B5N05XNFJ5Q1pFUVl6cG5MR1VQK2lHdm54R1h6?=
 =?iso-2022-jp?B?WWUzMW9TL0dnY052VjlZYjdVL1F2cXk3amgrOHdMZUo0S2F1aE53SFZY?=
 =?iso-2022-jp?B?SHdWbHVKOFNkZk11MWRZdTIzc0dnMTluUXc1Q3U3dGEvOS85c080Mml2?=
 =?iso-2022-jp?B?V2d0NHllMTJQdk91L25LNGF6Z3BoQzZNU2dMd3U5MnlBZzlHS0hNYjgr?=
 =?iso-2022-jp?B?dGNkeldRa0tjbTQ4L1dMUTlKbEc1NUlVZkFkYkFMbjY5MWFPbG50UlJJ?=
 =?iso-2022-jp?B?WXJWSHRPbnFYNmVEb25SUUZzaEh4NkZyZFVoRVpvSnlCT0F4TDdiNUNV?=
 =?iso-2022-jp?B?QmVxOERyUi83c0xxaVlhWFFmTy90L01OYXRZY0ltWEQzRXQxRFpMa0tM?=
 =?iso-2022-jp?B?ZndvSGVuTWxWYjBBQlFhSy9WbHlhY1ZBWmhPS0xGL2ZIZW1wNVlHcEkr?=
 =?iso-2022-jp?B?cm1veU51UXJLTFl6Y3k4dFZTM0Jqa1lwSVlZTlQwQjFraS9YYjluVVFx?=
 =?iso-2022-jp?B?SG4yak93S2NSZE5LVHBtZmhnWnJFMDY4aENPOTRQanpoRXpieVp5c05P?=
 =?iso-2022-jp?B?MXNzWEh3QW5yWjI1UVZOamhRa0gvTmI0QkNpWHk3Q0VycGtJVHlFSDg2?=
 =?iso-2022-jp?B?TVRWR2tOSVFrR3QzWTRyb2p3S3VpOXFQZnc9PQ==?=
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
	oTTt2Jr2lUgpc+d55AmOPP/JNNHrK2wyGGY9uxeZMX3Nt7po34x+JiWeXgSz+vyKqcEw1Xrgq/TOg1zHMwUiKQGuQLIiWty1Da5z73Ro7APscTQtAPlNvpbTKaIeuFt7DcyubgbIkqgj+Yyz8StdZbREMyWVgbm0R7puA9KgAo5LaKzFEZLDTIkrbLc6L5oQqyYnDa2VW+dBLMzStasjX+7SpsXbzBEXUeDzExqcJl8j7mPM/9dsiWuhB8n+Bm8B8wfZILTOHcU5pZJdXPC8FQOUV/nghNc4JveVTUoxaCGAThygU+g8agxkqc6LiIC/4c24f8RlxLMc11lVwVqGGuNnDHtxXhvImuQuGRpa9SrZd57IvkrGPELt1MG7OkWppiZUeARYRrrdZDLXkIeBhSDIPI0uCEkZ7qCtF2DME2DRJURNQBLImuo0tr9yfbXlpHkPh7Glg6S8pUNM3U/YOLklXZX1L3s3WmLkiG074QA305nfQRaZRk2BmEY5XPrA5c4gq3N73JKHfsCo2Jr0iKF1skHi7wOWdq2HI/TYNyF2amt5NdPYuYyeyJPx4rHBprP1ic1H3bKJowb7JbiwKHrBh8k4qpyZELUtLUjuRdM4+l0BikNqSXnAsArcTH/h
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2615bb4-5c84-44d0-9ccf-08ddef72c970
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 07:30:44.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Me7MBHzPBfqFp62eBn8llPsDviVQt6mBd0mjV84fnF6A2SIDe7sZJrGvEyP2GafQ1X+jwToFIZHvOceSWcIEi669QVhPP0pu3/ffZGqsYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16166

Hello James,

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
> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
> This is to allow hardware implementations where two controls are presente=
d as
> different RIS. Re-combining these RIS allows their feature bits to be or-=
ed. This
> structure is not visible outside mpam_devices.c
>=20
> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
> visible as each L2 cache may be composed of individual slices which need =
to
> be configured the same as the hardware is not able to distribute the
> configuration.
>=20
> Add support for creating and destroying these structures.
>=20
> A gfp is passed as the structures may need creating when a new RIS entry =
is
> discovered when probing the MSC.
>=20
> CC: Ben Horgan <ben.horgan@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * removed a pr_err() debug message that crept in.
> ---
>  drivers/resctrl/mpam_devices.c  | 488
> +++++++++++++++++++++++++++++++-
> drivers/resctrl/mpam_internal.h |  91 ++++++
>  include/linux/arm_mpam.h        |   8 +-
>  3 files changed, 574 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index 71a1fb1a9c75..5baf2a8786fb 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -20,7 +20,6 @@
>  #include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/srcu.h>
>  #include <linux/types.h>
>=20
>  #include <acpi/pcc.h>
> @@ -35,11 +34,483 @@
>  static DEFINE_MUTEX(mpam_list_lock);
>  static LIST_HEAD(mpam_all_msc);
>=20
> -static struct srcu_struct mpam_srcu;
> +struct srcu_struct mpam_srcu;
>=20
>  /* MPAM isn't available until all the MSC have been probed. */  static u=
32
> mpam_num_msc;
>=20
> +/*
> + * An MSC is a physical container for controls and monitors, each
> +identified by
> + * their RIS index. These share a base-address, interrupts and some
> +MMIO
> + * registers. A vMSC is a virtual container for RIS in an MSC that
> +control or
> + * monitor the same thing. Members of a vMSC are all RIS in the same
> +MSC, but
> + * not all RIS in an MSC share a vMSC.
> + * Components are a group of vMSC that control or monitor the same
> +thing but
> + * are from different MSC, so have different base-address, interrupts et=
c.
> + * Classes are the set components of the same type.
> + *
> + * The features of a vMSC is the union of the RIS it contains.
> + * The features of a Class and Component are the common subset of the
> +vMSC
> + * they contain.
> + *
> + * e.g. The system cache may have bandwidth controls on multiple
> +interfaces,
> + * for regulating traffic from devices independently of traffic from CPU=
s.
> + * If these are two RIS in one MSC, they will be treated as controlling
> + * different things, and will not share a vMSC/component/class.
> + *
> + * e.g. The L2 may have one MSC and two RIS, one for cache-controls
> +another
> + * for bandwidth. These two RIS are members of the same vMSC.
> + *
> + * e.g. The set of RIS that make up the L2 are grouped as a component.
> +These
> + * are sometimes termed slices. They should be configured the same, as
> +if there
> + * were only one.
> + *
> + * e.g. The SoC probably has more than one L2, each attached to a
> +distinct set
> + * of CPUs. All the L2 components are grouped as a class.
> + *
> + * When creating an MSC, struct mpam_msc is added to the all
> +mpam_all_msc list,
> + * then linked via struct mpam_ris to a vmsc, component and class.
> + * The same MSC may exist under different class->component->vmsc paths,
> +but the
> + * RIS index will be unique.
> + */
> +LIST_HEAD(mpam_classes);
> +
> +/* List of all objects that can be free()d after synchronise_srcu() */
> +static LLIST_HEAD(mpam_garbage);
> +
> +#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
> +
> +static struct mpam_vmsc *
> +mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc
> *msc,
> +gfp_t gfp) {
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	vmsc =3D kzalloc(sizeof(*vmsc), gfp);
> +	if (!comp)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(vmsc);
> +
> +	INIT_LIST_HEAD_RCU(&vmsc->ris);
> +	INIT_LIST_HEAD_RCU(&vmsc->comp_list);
> +	vmsc->comp =3D comp;
> +	vmsc->msc =3D msc;
> +
> +	list_add_rcu(&vmsc->comp_list, &comp->vmsc);
> +
> +	return vmsc;
> +}
> +
> +static struct mpam_vmsc *mpam_vmsc_get(struct mpam_component
> *comp,
> +				       struct mpam_msc *msc, bool alloc,
> +				       gfp_t gfp)
> +{
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		if (vmsc->msc->id =3D=3D msc->id)
> +			return vmsc;
> +	}
> +
> +	if (!alloc)
> +		return ERR_PTR(-ENOENT);

It seems like it is always false here.
If necessary, why not do this at the beginning of the function?

> +	return mpam_vmsc_alloc(comp, msc, gfp); }
> +
> +static struct mpam_component *
> +mpam_component_alloc(struct mpam_class *class, int id, gfp_t gfp) {
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	comp =3D kzalloc(sizeof(*comp), gfp);
> +	if (!comp)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(comp);
> +
> +	comp->comp_id =3D id;
> +	INIT_LIST_HEAD_RCU(&comp->vmsc);
> +	/* affinity is updated when ris are added */
> +	INIT_LIST_HEAD_RCU(&comp->class_list);
> +	comp->class =3D class;
> +
> +	list_add_rcu(&comp->class_list, &class->components);
> +
> +	return comp;
> +}
> +
> +static struct mpam_component *
> +mpam_component_get(struct mpam_class *class, int id, bool alloc, gfp_t
> +gfp) {
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(comp, &class->components, class_list) {
> +		if (comp->comp_id =3D=3D id)
> +			return comp;
> +	}
> +
> +	if (!alloc)
> +		return ERR_PTR(-ENOENT);

Same here.

> +	return mpam_component_alloc(class, id, gfp); }
> +
> +static struct mpam_class *
> +mpam_class_alloc(u8 level_idx, enum mpam_class_types type, gfp_t gfp) {
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	class =3D kzalloc(sizeof(*class), gfp);
> +	if (!class)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(class);
> +
> +	INIT_LIST_HEAD_RCU(&class->components);
> +	/* affinity is updated when ris are added */
> +	class->level =3D level_idx;
> +	class->type =3D type;
> +	INIT_LIST_HEAD_RCU(&class->classes_list);
> +
> +	list_add_rcu(&class->classes_list, &mpam_classes);
> +
> +	return class;
> +}
> +
> +static struct mpam_class *
> +mpam_class_get(u8 level_idx, enum mpam_class_types type, bool alloc,
> +gfp_t gfp) {
> +	bool found =3D false;
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		if (class->type =3D=3D type && class->level =3D=3D level_idx) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (found)
> +		return class;
> +
> +	if (!alloc)
> +		return ERR_PTR(-ENOENT);

Same here.

Best regards,
Shaopeng TAN
> +	return mpam_class_alloc(level_idx, type, gfp); }
> +
> +#define add_to_garbage(x)				\
> +do {							\
> +	__typeof__(x) _x =3D x;				\
> +	(_x)->garbage.to_free =3D (_x);			\
> +	llist_add(&(_x)->garbage.llist, &mpam_garbage);	\
> +} while (0)
> +
> +static void mpam_class_destroy(struct mpam_class *class) {
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&class->classes_list);
> +	add_to_garbage(class);
> +}
> +
> +static void mpam_comp_destroy(struct mpam_component *comp) {
> +	struct mpam_class *class =3D comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&comp->class_list);
> +	add_to_garbage(comp);
> +
> +	if (list_empty(&class->components))
> +		mpam_class_destroy(class);
> +}
> +
> +static void mpam_vmsc_destroy(struct mpam_vmsc *vmsc) {
> +	struct mpam_component *comp =3D vmsc->comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&vmsc->comp_list);
> +	add_to_garbage(vmsc);
> +
> +	if (list_empty(&comp->vmsc))
> +		mpam_comp_destroy(comp);
> +}
> +
> +static void mpam_ris_destroy(struct mpam_msc_ris *ris) {
> +	struct mpam_vmsc *vmsc =3D ris->vmsc;
> +	struct mpam_msc *msc =3D vmsc->msc;
> +	struct platform_device *pdev =3D msc->pdev;
> +	struct mpam_component *comp =3D vmsc->comp;
> +	struct mpam_class *class =3D comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
> +	clear_bit(ris->ris_idx, msc->ris_idxs);
> +	list_del_rcu(&ris->vmsc_list);
> +	list_del_rcu(&ris->msc_list);
> +	add_to_garbage(ris);
> +	ris->garbage.pdev =3D pdev;
> +
> +	if (list_empty(&vmsc->ris))
> +		mpam_vmsc_destroy(vmsc);
> +}
> +
> +/*
> + * There are two ways of reaching a struct mpam_msc_ris. Via the
> + * class->component->vmsc->ris, or via the msc.
> + * When destroying the msc, the other side needs unlinking and cleaning =
up
> too.
> + */
> +static void mpam_msc_destroy(struct mpam_msc *msc) {
> +	struct platform_device *pdev =3D msc->pdev;
> +	struct mpam_msc_ris *ris, *tmp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&msc->glbl_list);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
> +		mpam_ris_destroy(ris);
> +
> +	add_to_garbage(msc);
> +	msc->garbage.pdev =3D pdev;
> +}
> +
> +static void mpam_free_garbage(void)
> +{
> +	struct mpam_garbage *iter, *tmp;
> +	struct llist_node *to_free =3D llist_del_all(&mpam_garbage);
> +
> +	if (!to_free)
> +		return;
> +
> +	synchronize_srcu(&mpam_srcu);
> +
> +	llist_for_each_entry_safe(iter, tmp, to_free, llist) {
> +		if (iter->pdev)
> +			devm_kfree(&iter->pdev->dev, iter->to_free);
> +		else
> +			kfree(iter->to_free);
> +	}
> +}
> +
> +/* Called recursively to walk the list of caches from a particular CPU
> +*/ static void __mpam_get_cpumask_from_cache_id(int cpu, struct
> device_node *cache_node,
> +					     unsigned long cache_id,
> +					     u32 cache_level,
> +					     cpumask_t *affinity)
> +{
> +	int err;
> +	u32 iter_level;
> +	unsigned long iter_cache_id;
> +	struct device_node *iter_node __free(device_node) =3D
> +of_find_next_cache_node(cache_node);
> +
> +	if (!iter_node)
> +		return;
> +
> +	err =3D of_property_read_u32(iter_node, "cache-level", &iter_level);
> +	if (err)
> +		return;
> +
> +	/*
> +	 * get_cpu_cacheinfo_id() isn't ready until sometime
> +	 * during device_initcall(). Use cache_of_calculate_id().
> +	 */
> +	iter_cache_id =3D cache_of_calculate_id(iter_node);
> +	if (cache_id =3D=3D ~0UL)
> +		return;
> +
> +	if (iter_level =3D=3D cache_level && iter_cache_id =3D=3D cache_id)
> +		cpumask_set_cpu(cpu, affinity);
> +
> +	__mpam_get_cpumask_from_cache_id(cpu, iter_node, cache_id,
> cache_level,
> +					 affinity);
> +}
> +
> +/*
> + * The cacheinfo structures are only populated when CPUs are online.
> + * This helper walks the device tree to include offline CPUs too.
> + */
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
> +				   cpumask_t *affinity)
> +{
> +	int cpu;
> +
> +	if (!acpi_disabled)
> +		return acpi_pptt_get_cpumask_from_cache_id(cache_id,
> affinity);
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device_node *cpu_node __free(device_node) =3D
> of_get_cpu_node(cpu, NULL);
> +		if (!cpu_node) {
> +			pr_err("Failed to find cpu%d device node\n", cpu);
> +			return -ENOENT;
> +		}
> +
> +		__mpam_get_cpumask_from_cache_id(cpu, cpu_node,
> cache_id,
> +						 cache_level, affinity);
> +			continue;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * cpumask_of_node() only knows about online CPUs. This can't tell us
> +whether
> + * a class is represented on all possible CPUs.
> + */
> +static void get_cpumask_from_node_id(u32 node_id, cpumask_t *affinity)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (node_id =3D=3D cpu_to_node(cpu))
> +			cpumask_set_cpu(cpu, affinity);
> +	}
> +}
> +
> +static int get_cpumask_from_cache(struct device_node *cache,
> +				  cpumask_t *affinity)
> +{
> +	int err;
> +	u32 cache_level;
> +	unsigned long cache_id;
> +
> +	err =3D of_property_read_u32(cache, "cache-level", &cache_level);
> +	if (err) {
> +		pr_err("Failed to read cache-level from cache node\n");
> +		return -ENOENT;
> +	}
> +
> +	cache_id =3D cache_of_calculate_id(cache);
> +	if (cache_id =3D=3D ~0UL) {
> +		pr_err("Failed to calculate cache-id from cache node\n");
> +		return -ENOENT;
> +	}
> +
> +	return mpam_get_cpumask_from_cache_id(cache_id, cache_level,
> +affinity); }
> +
> +static int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t
> *affinity,
> +				 enum mpam_class_types type,
> +				 struct mpam_class *class,
> +				 struct mpam_component *comp)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case MPAM_CLASS_CACHE:
> +		err =3D mpam_get_cpumask_from_cache_id(comp->comp_id,
> class->level,
> +						     affinity);
> +		if (err)
> +			return err;
> +
> +		if (cpumask_empty(affinity))
> +			pr_warn_once("%s no CPUs associated with cache
> node",
> +				     dev_name(&msc->pdev->dev));
> +
> +		break;
> +	case MPAM_CLASS_MEMORY:
> +		get_cpumask_from_node_id(comp->comp_id, affinity);
> +		/* affinity may be empty for CPU-less memory nodes */
> +		break;
> +	case MPAM_CLASS_UNKNOWN:
> +		return 0;
> +	}
> +
> +	cpumask_and(affinity, affinity, &msc->accessibility);
> +
> +	return 0;
> +}
> +
> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8
> class_id,
> +				  int component_id, gfp_t gfp)
> +{
> +	int err;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (test_and_set_bit(ris_idx, msc->ris_idxs))
> +		return -EBUSY;
> +
> +	ris =3D devm_kzalloc(&msc->pdev->dev, sizeof(*ris), gfp);
> +	if (!ris)
> +		return -ENOMEM;
> +	init_garbage(ris);
> +
> +	class =3D mpam_class_get(class_id, type, true, gfp);
> +	if (IS_ERR(class))
> +		return PTR_ERR(class);
> +
> +	comp =3D mpam_component_get(class, component_id, true, gfp);
> +	if (IS_ERR(comp)) {
> +		if (list_empty(&class->components))
> +			mpam_class_destroy(class);
> +		return PTR_ERR(comp);
> +	}
> +
> +	vmsc =3D mpam_vmsc_get(comp, msc, true, gfp);
> +	if (IS_ERR(vmsc)) {
> +		if (list_empty(&comp->vmsc))
> +			mpam_comp_destroy(comp);
> +		return PTR_ERR(vmsc);
> +	}
> +
> +	err =3D mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
> +	if (err) {
> +		if (list_empty(&vmsc->ris))
> +			mpam_vmsc_destroy(vmsc);
> +		return err;
> +	}
> +
> +	ris->ris_idx =3D ris_idx;
> +	INIT_LIST_HEAD_RCU(&ris->vmsc_list);
> +	ris->vmsc =3D vmsc;
> +
> +	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
> +	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
> +
> +	return 0;
> +}
> +
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int
> component_id) {
> +	int err;
> +
> +	mutex_lock(&mpam_list_lock);
> +	err =3D mpam_ris_create_locked(msc, ris_idx, type, class_id,
> +				     component_id, GFP_KERNEL);
> +	mutex_unlock(&mpam_list_lock);
> +	if (err)
> +		mpam_free_garbage();
> +
> +	return err;
> +}
> +
>  static void mpam_discovery_complete(void)  {
>  	pr_err("Discovered all MSC\n");
> @@ -179,7 +650,10 @@ static int update_msc_accessibility(struct mpam_msc
> *msc)
>  		cpumask_copy(&msc->accessibility, cpu_possible_mask);
>  		err =3D 0;
>  	} else {
> -		if (of_device_is_compatible(parent, "memory")) {
> +		if (of_device_is_compatible(parent, "cache")) {
> +			err =3D get_cpumask_from_cache(parent,
> +						     &msc->accessibility);
> +		} else if (of_device_is_compatible(parent, "memory")) {
>  			cpumask_copy(&msc->accessibility,
> cpu_possible_mask);
>  			err =3D 0;
>  		} else {
> @@ -209,11 +683,10 @@ static void mpam_msc_drv_remove(struct
> platform_device *pdev)
>=20
>  	mutex_lock(&mpam_list_lock);
>  	mpam_num_msc--;
> -	platform_set_drvdata(pdev, NULL);
> -	list_del_rcu(&msc->glbl_list);
> -	synchronize_srcu(&mpam_srcu);
> -	devm_kfree(&pdev->dev, msc);
> +	mpam_msc_destroy(msc);
>  	mutex_unlock(&mpam_list_lock);
> +
> +	mpam_free_garbage();
>  }
>=20
>  static int mpam_msc_drv_probe(struct platform_device *pdev) @@ -230,6
> +703,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>  			err =3D -ENOMEM;
>  			break;
>  		}
> +		init_garbage(msc);
>=20
>  		mutex_init(&msc->probe_lock);
>  		mutex_init(&msc->part_sel_lock);
> diff --git a/drivers/resctrl/mpam_internal.h
> b/drivers/resctrl/mpam_internal.h index 07e0f240eaca..d49bb884b433 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -7,10 +7,27 @@
>  #include <linux/arm_mpam.h>
>  #include <linux/cpumask.h>
>  #include <linux/io.h>
> +#include <linux/llist.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
>  #include <linux/resctrl.h>
>  #include <linux/sizes.h>
> +#include <linux/srcu.h>
> +
> +/*
> + * Structures protected by SRCU may not be freed for a surprising
> +amount of
> + * time (especially if perf is running). To ensure the MPAM error
> +interrupt can
> + * tear down all the structures, build a list of objects that can be
> +gargbage
> + * collected once synchronize_srcu() has returned.
> + * If pdev is non-NULL, use devm_kfree().
> + */
> +struct mpam_garbage {
> +	/* member of mpam_garbage */
> +	struct llist_node	llist;
> +
> +	void			*to_free;
> +	struct platform_device	*pdev;
> +};
>=20
>  struct mpam_msc {
>  	/* member of mpam_all_msc */
> @@ -57,6 +74,80 @@ struct mpam_msc {
>=20
>  	void __iomem		*mapped_hwpage;
>  	size_t			mapped_hwpage_sz;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_class {
> +	/* mpam_components in this class */
> +	struct list_head	components;
> +
> +	cpumask_t		affinity;
> +
> +	u8			level;
> +	enum mpam_class_types	type;
> +
> +	/* member of mpam_classes */
> +	struct list_head	classes_list;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_component {
> +	u32			comp_id;
> +
> +	/* mpam_vmsc in this component */
> +	struct list_head	vmsc;
> +
> +	cpumask_t		affinity;
> +
> +	/* member of mpam_class:components */
> +	struct list_head	class_list;
> +
> +	/* parent: */
> +	struct mpam_class	*class;
> +
> +	struct mpam_garbage	garbage;
>  };
>=20
> +struct mpam_vmsc {
> +	/* member of mpam_component:vmsc_list */
> +	struct list_head	comp_list;
> +
> +	/* mpam_msc_ris in this vmsc */
> +	struct list_head	ris;
> +
> +	/* All RIS in this vMSC are members of this MSC */
> +	struct mpam_msc		*msc;
> +
> +	/* parent: */
> +	struct mpam_component	*comp;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_msc_ris {
> +	u8			ris_idx;
> +
> +	cpumask_t		affinity;
> +
> +	/* member of mpam_vmsc:ris */
> +	struct list_head	vmsc_list;
> +
> +	/* member of mpam_msc:ris */
> +	struct list_head	msc_list;
> +
> +	/* parent: */
> +	struct mpam_vmsc	*vmsc;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +/* List of all classes - protected by srcu*/ extern struct srcu_struct
> +mpam_srcu; extern struct list_head mpam_classes;
> +
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
> +				   cpumask_t *affinity);
> +
>  #endif /* MPAM_INTERNAL_H */
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h index
> 0edefa6ba019..406a77be68cb 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -36,11 +36,7 @@ static inline int acpi_mpam_parse_resources(struct
> mpam_msc *msc,  static inline int acpi_mpam_count_msc(void) { return
> -EINVAL; }  #endif
>=20
> -static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> -				  enum mpam_class_types type, u8
> class_id,
> -				  int component_id)
> -{
> -	return -EINVAL;
> -}
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int
> component_id);
>=20
>  #endif /* __LINUX_ARM_MPAM_H */
> --
> 2.20.1


