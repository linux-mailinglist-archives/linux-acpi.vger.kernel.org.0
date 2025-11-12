Return-Path: <linux-acpi+bounces-18799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE5C511A9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 09:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8E84EEDE5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D882F5462;
	Wed, 12 Nov 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tMnnatql"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011039.outbound.protection.outlook.com [40.107.74.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434F2D5C7A;
	Wed, 12 Nov 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935904; cv=fail; b=EfIGZbIBrj4K7kodSX1RKI4NOB80ygDvxLs/Z1otYIDj9TebtAk6kJQ7BFIVi855vMnk73MA1S8Zie7wdOrbgWErTtwEPECXWfD4v5F51JtCQDsxT5ptMOVwJU1/x+ENMupzzx9gpcpadNaNnN35b6p2t3ucqRXDRTxzVACJfc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935904; c=relaxed/simple;
	bh=auGOFysnoyBGphE5Av33H7xC/+jQursG/QXF1hMfeDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANu1rEQOIyLS/UcCrrXrxn2ened8XvuGV3u1gzjex5F3Qe4JreshvNHk25/eUubbPPA1WBtQ6B3JLU+JGZt27KE83R95ipi3gcHhWKJmiLGeArg1Ja6x/3EtxkeP+Zn0BniazLbXtsqqhj8upk75AoLnTtlctDeRxp6bJbpyv6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tMnnatql; arc=fail smtp.client-ip=40.107.74.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnDP2j01Avl5LvoNSO/fvfOlv60Sih7CBGoR5nRi+WZZcNL5IZbU4fBNCx7uXt0l8Ush6e6ky6IoDnnOIVT7gr3mJLIBlHdyByZ7b2Fi5dokc4oNNXxf6DLRw9bF+/QiBdk/J68Mu/o+j+4jKsX2EI+WNSsbNlfzJ8/VsY1uafyxUKoWeKTsyJksG3Zt0e41N3QoSTFCfkdjlHMnfiwE4N/zJWFNs5x1A/J2m3tZR1jlcgzoVe897+w3/GyqGqMur5PY+st2uUFFZ7vLz4TlAdyvgGkn0yJSUTCQJsedUG+4mh8bmaxvJpks8AJAkCquMQ8veWFgc1hGWY5dprlsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auGOFysnoyBGphE5Av33H7xC/+jQursG/QXF1hMfeDo=;
 b=xu/uSpp7vy+PjStNSJLwwnUVBiZUPL6G+p9X2VaXRAoCPzo+u2HdaZSdsRZRn7PHetwUTRqWRW+KeeocmKBtrxslSyo+ketfdCJLwxUIQ48Wz0zBf6OoD1FDyPaLGgEFjPNeqxxUAPoPSfWqvJ9Cs9oZ/HczRcqdufnxOf2oeJ8lx/kC2K4dVZzXXwwavcFycaIKXlowdahx3K+Yq7am7wd4gJ6q4Hjyg8dYJ3LMNAC61ZzfJVQbqM7btL9mBh1OuBN+DWIDhx21P+W8PH6kNke/8t447hvonRPG/FoGJm3vKWcoVg6VY2e5szc3d1t5xgL0YHaxZBYWjtvPQxdgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auGOFysnoyBGphE5Av33H7xC/+jQursG/QXF1hMfeDo=;
 b=tMnnatqlqyWhZjn8a6U0J5PUyUzGtG9IBC4j/k2tXTcrFG6ZsLFHeG6qb5KIYpNJ0SsZPpVgX3tE2GX10X8K6r8J9o/HDZqCXjR6a0FSasXbkKzkR/Hbec72KVXMKiP9ylL78NuHQuD0oVGpCQFAz7OuIVokuSTBHXr7RFXK/CXlWci7S1M+3Ed4mcdNoFpAVXzbHqWY9I++UoRk6zZ1PF7+D6bGRRwMwRBPaALAO76FwUQz75xAfxncrhM0gkSo8sihgUBJUvG7GcFsRJKy1kLqiUAuINmyNRQzeLUA+tQxTlpqlKBVTV9jqo5rjqJYG/qEGIMQRpgUBe+l32JCtQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSCPR01MB16417.jpnprd01.prod.outlook.com (2603:1096:604:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:25:00 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:24:59 +0000
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
Subject: RE: [PATCH 17/33] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
Thread-Topic: [PATCH 17/33] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
Thread-Index: AQHcT+M5jBR1M7H8qUyVEgY3oSyj3rTuu8Mw
Date: Wed, 12 Nov 2025 08:24:59 +0000
Message-ID:
 <OSZPR01MB8798DBF1866E09D70F6DBB018BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-18-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-18-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=4cf86675-4b75-4c8d-b86d-395612615710;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T08:24:30Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSCPR01MB16417:EE_
x-ms-office365-filtering-correlation-id: 14922da4-0635-4d78-3ef2-08de21c4f875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?K3AzaEVhRlRjaU9QTElZTnV3bXdNMVBSUGEzM2xSWDBMVXl6L2JVb1VZ?=
 =?iso-2022-jp?B?eWRrRld5VmIvdEp5UmhTN0VvdjZqNkRhNllGdUJ1a1JneW1uK2xPZ1dF?=
 =?iso-2022-jp?B?Y2FNOXhtUTk2Rm51UXNpaTE0VlljcnRaQklyQmQ3emZSeWJ0OVpXZGlq?=
 =?iso-2022-jp?B?ZmVFUHRzNkxvUnlmLzRKdTVIMHNKemRjVmh1WDZ2VHc2bkNVblh1WHBx?=
 =?iso-2022-jp?B?ajg5OXdSWTQvUElBdlZiZ1d5Yjg0cWlqNnRXVEk3RUMwRi9ZcTd0WDBK?=
 =?iso-2022-jp?B?YzgyRW9sQXd5T0E1anpmTCtZcEMwUExoMFV6NS9HVnRLWEF0M0wwcDI0?=
 =?iso-2022-jp?B?WHdPSTMxTDdIVFI5TGVxTjNxZHNtQ1cvZ0pzUWdzZyszeGZRclE4MWdO?=
 =?iso-2022-jp?B?MS9TQ2xkSmx6TG5zQmcwbWl1Skk1VkttR1RweTRsWk9aZlBjUTMvOTRG?=
 =?iso-2022-jp?B?dDNjOGtIenhHYllzZDM4blB0ZndGTWI3Ui90VHEwK2JxeDdQbkxDcVk1?=
 =?iso-2022-jp?B?UmlRczAyVjdTTU1FZnU4WStYWDFSelBZQW1SZCtoVkJCaWNSaDMwbjE5?=
 =?iso-2022-jp?B?QndsUThobDExaXp4T0hNWE1EZzdtY3JyZFZuWDVkR0NUSGJxVWIybEMr?=
 =?iso-2022-jp?B?VnVFVjdSMkplTUs1MVlpRUw4UFhKVU9mSGpHblFrZFJOSHh5Rm9RaXJW?=
 =?iso-2022-jp?B?SGV6YmI4d2J5SFAxS09pRWxuYjNVUmRtRDRxdnFxOHZyUnZkTjhBa3l2?=
 =?iso-2022-jp?B?Nml6UGhSN3dneWIzdVJQQm9Gci83dy95d0h4dVRPMDk3ZzJOWkRmc2V6?=
 =?iso-2022-jp?B?aFVibnI5ZkZEc05jSmJFcDVZSGpRcllNSlpuMXI4WmllaWU4MHFIUStV?=
 =?iso-2022-jp?B?eDlsUTBXNGFjY0l4SXNDdm5Cd2hHNlBoRWJ5OThLUVo3d09SSDVyY215?=
 =?iso-2022-jp?B?b1QrcE5FLzh1eFlVd3JRSU02eWhabnpiTWhKbVVhZXF5K2thTERQWGRV?=
 =?iso-2022-jp?B?T0l5U2RmcGlQQVFWU0dlbHJBZmY3U21scVV0bzFJUktpZzJCZklTREJW?=
 =?iso-2022-jp?B?d3IrVFdNc3A1R05yY3ZQNGs2OUpJc25xOVJFVDlWOWNUcDMxcTRkTndE?=
 =?iso-2022-jp?B?OFNtWTBCMlFidDA0bE82UjVBTGNOb2FUemZoUFNFVWJPWS9IUUI4M0Z0?=
 =?iso-2022-jp?B?VjdnL2ZOd1RNalRXVHdoL3hYQkQ2RVBYaFVJVnhibytaakdUTEpqSDZ5?=
 =?iso-2022-jp?B?TWxZcGdmS2hNRDRqZG81bzJCQzZjbU43Y3NLV1dSMmFzYnM0bGkzVHZu?=
 =?iso-2022-jp?B?dmluSDY5UGxtQXFjb1BpNWtUU2NKaGNYMDZqUTQwc2NZam9XTXhxVHBN?=
 =?iso-2022-jp?B?cUVYY2haTlUrbXJVeGJQMGduMk0vRlJsaXNpekowa1FJeG5MN3gvbXpT?=
 =?iso-2022-jp?B?Z1g1Y1lUZlBsSndpemp6cmdEV0N0OVBJSWROZkpwQmUra1M0R0YzTXdq?=
 =?iso-2022-jp?B?a0xTZlFTeENhRW00RHFhRldTYVExVDR5emJ6dWpndXJqc3JiMXF2SnB3?=
 =?iso-2022-jp?B?anRKdHNRNkNNeWhnVml4YWV6aUU2S2NWckxpeXhvWFovS2x2NjZnYnRM?=
 =?iso-2022-jp?B?MWE5N3N2QVIvK0IrREdxUXFobGI1TVFNVWZXeTBqMU5hOE8rcGxOTjBs?=
 =?iso-2022-jp?B?UnpzWDhja0lHb0tBSkN4NkdKSzNaTG9ORXlsTUVLcVZpMTZkT0NTS2Zp?=
 =?iso-2022-jp?B?YkFJaVkzQW4wM2s5YUVVM0YyNm5KRWNoby9GQ2RKUVRGNWJpN0JaVkJ0?=
 =?iso-2022-jp?B?ZCtMbTNlampBMkVUc0N2YWIxa1J5OWtubTlzSnc5NjV1TllyZ1FBMXVz?=
 =?iso-2022-jp?B?dC9DSW0wYVNud1E1S3JhT2FscEk3QUtwc0VVZmVkblo5d3Z5UjhVRGM0?=
 =?iso-2022-jp?B?ZDFSaFB6dktjT0Z6bTVvTnNPMDQxaExDc3oyWmdOemZ1Q1JmelB3RFlM?=
 =?iso-2022-jp?B?VVRFUnJpV1MrekFtRjFBMzNiUG5jYnVRMGZ5U2ovTnFrYTlkMEp2Um9I?=
 =?iso-2022-jp?B?V1E0a2pyd0ErY0lpVkx5a0d0dDIrK2JaU1hVQkVUUkRscVFrZmNBaGZO?=
 =?iso-2022-jp?B?NmlZWGJvVWZISFF6bHhFQi9VdU9CMzVydEk3cThRT3o4M1VPZllaZXds?=
 =?iso-2022-jp?B?UWlENStCcmZ1RUZnL3pEQ2tyaFNYK1ZncUo5V0ptSDhlK1VSOWZXUzBi?=
 =?iso-2022-jp?B?WUswUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TVNHY0FnWnN5Y2pSSUhQTW1XT3JrWVhzRVJCd2ozeTBVU2lKdFZjY21k?=
 =?iso-2022-jp?B?MG96TFlnKzRVaEZsTWtSZ1AzdlppWFJJNWcweTVBRDA1ZUtxQlBMemQ5?=
 =?iso-2022-jp?B?YUVmMHZXdVIwZ2QzTkk4S2tpbzBva2FKazJMN3dVRFFUUWo2endWYTlj?=
 =?iso-2022-jp?B?U3lKRTVDV3k2SWNvT0pCT1V5a3Y5Qi9vajRjOG9zMWpyN21ZWUp5bDZI?=
 =?iso-2022-jp?B?YStwOEhkUDJPRkJYdmdySzhBL09qSU9vZ3ByN3hmSDJpME11WVZqZVlL?=
 =?iso-2022-jp?B?NXVFL1lJb2pIc09TcWhZWHhkU3Z3R3lMQjJpdkpINlJISSt1NlkyeFlC?=
 =?iso-2022-jp?B?eGJyVkFYVTJnN1Q5RmxIdjJBRzVMUDlFeVk2bU5na3IzeTc2bzZQcnhk?=
 =?iso-2022-jp?B?eTBQSDIxaHc5TmdwWjNlc3dhZVFwUjZHaFdWVWFabUVVcjRlNk5ib05t?=
 =?iso-2022-jp?B?N2hSTzhucTF0NFJWMytjVjJteHlCQVhmL2JaK2tmamVWMWplTlRXOG0y?=
 =?iso-2022-jp?B?a21OelNzM0lvdUhrbk5iY1lGY1M4QWpyZVdKbDFaU1Y4RGhOWWdCNm1q?=
 =?iso-2022-jp?B?L29nTXB3TTZ1Wi92Z3ZKaUN0MW5EeTZmUVdhdHUyY2Y4ekoyQ2o3QVlq?=
 =?iso-2022-jp?B?L0VQU3hvWjBwb2IxcHJXSVkzSEt6cHl2Vzc5RDFpbU1LTU0zQ0FtUTdR?=
 =?iso-2022-jp?B?anh5a1UrVHF2NVM3eDVpTWxURm1YeU12dk5uQytIV3RHT2JvVkNHaUdL?=
 =?iso-2022-jp?B?NnBFQlUyNFJHdk1oNlZDQ0hoNmFiUTZiWW0xOHE1SnlHR0lJSXFtSnRJ?=
 =?iso-2022-jp?B?N3pISVFJUEdNZEhDZmJTM002UFFFeEJCUjhMTHZUTXhQQ0daeUxXYVk0?=
 =?iso-2022-jp?B?QVdzMjczY0J0bEoyVzA2ZVBINVcxaEtOd2tXSFJkYWpLU1RpOTdPUkw1?=
 =?iso-2022-jp?B?azlDTlJ2SXZJNGZ2VTdZZzNldm15S09HNUlqK0FkakVjS0NZNVBoQnJR?=
 =?iso-2022-jp?B?UzQ4TWtSUHcvVkxQaU5CZlhVRTJhMWZIMERSbmY0bU9BdHBvQ0dzNDZu?=
 =?iso-2022-jp?B?aWplRktxTHJEWEQ3K2ZId29NYXYrSFlyNW1tZkdqNkZxTnNzajNEQ2V2?=
 =?iso-2022-jp?B?SnRtZnpkMXo1ZUFkL2swN3lqWmg1NnJiSU85ZkFmcnU4NDJmb1QrUy9W?=
 =?iso-2022-jp?B?MHBISmErQURJSGFWbkliWkdJclN0NjJ1YkJEQVBwbGFUdFRwdWNCaVN5?=
 =?iso-2022-jp?B?Z0dRZnFsWitHdm5hTEVYMjlPL2JQdFlWWitMVmE3Yk5ldVJMM3pjMWlH?=
 =?iso-2022-jp?B?TkJLZmo1aHJ4QkNKQmsyS2dMNkhKL1ZzZGlNSVNsOHdBOHJYTVlyUW5a?=
 =?iso-2022-jp?B?c1IyYzhtc2FLZUVNOWJRSWNyczkrV2R6bkRwM2NMZVJBU3FGZCtKckVz?=
 =?iso-2022-jp?B?TEtzaG5KUXdSNzdja1pyejZPZmJhVWsvc20rQzlSb3RFZ0VwRHFtVDBi?=
 =?iso-2022-jp?B?aXRRK3dEL0h1dHpRS3JJTDB6S0FNRGhoU3hTNy9xcGhwMy9pZzFYQkxi?=
 =?iso-2022-jp?B?bit0VTRkT2Y4ZTN2aUJLeUVoUFFSYy9EeG1Hb3dQd28rcktVazBWSU9a?=
 =?iso-2022-jp?B?V2RBZW0vUHlnWEVlVW5wa3FwNWh4WGNMRHVFNjM3a2ovSU1XTmh1dVN2?=
 =?iso-2022-jp?B?UmtzRThsS2ovajN1bVpYbndwSkV4Z2xnd2dLLzZBRmhIWHpvRmlGZFRI?=
 =?iso-2022-jp?B?TmQ2Yzl4RnU3RFBwbHU4NzY5ZkY2clNiM3hWMklsR251RFp3eExkTm1x?=
 =?iso-2022-jp?B?b1VTdjU1d1FCaXlDUHFpWXd2K3JEVExmOXBhMTBhSldPT0g3MkN2WUpi?=
 =?iso-2022-jp?B?MWxEM3dKU1RnTEZLenhlSlBEcVh2L3ZTOXUwTW1oYk5kem5oazVFNk1T?=
 =?iso-2022-jp?B?ZS8yVmJTbVo5SUxCeVJ2RmlMaXlvY0dZRk02MHhYdm5KYnZkUTUvYUxt?=
 =?iso-2022-jp?B?TUhneGEwLzFXdzhkN1R6S3NIdmdRYUc0M1Y4c1g3aUVId1d4U1J4U1Vo?=
 =?iso-2022-jp?B?UGJ1RUROVTRHaC9UNEdLUnFGMWlISnUrS1NGZW4yRnRqbFE2eDNWd2ZJ?=
 =?iso-2022-jp?B?OW90VDZ5Wlhsb3l5ckY1SEpoRUxQSlJWeWNJWVhmUXdPbHNyeHI3d1lh?=
 =?iso-2022-jp?B?bE1iOERPR2R0dEVmNFpOVlQ2bFlVeGtkME1vTkF3Z3pTNFhmakFzWE9s?=
 =?iso-2022-jp?B?dU45dUg0UEFpYndMY1RhTFhhSUJZYm1nN0x1dUhnaVZnM2VSejNVUC9P?=
 =?iso-2022-jp?B?N1pKU0VMbzNiQTRzc0ZUQjNxZGFGcy9wUUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14922da4-0635-4d78-3ef2-08de21c4f875
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:24:59.8284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaCtx4SUBnUukIo6GX5Kf+dpcOp5no7P9gWWoADKySmGhhW6yOQRFDTFvCBruf7LBIz38ANFL0ykWwljTP+UAEYuBKDb7uuyU/tsMQ7i++o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16417

> From: James Morse <james.morse@arm.com>
>=20
> To make a decision about whether to expose an mpam class as a resctrl
> resource we need to know its overall supported features and properties.
>=20
> Once we've probed all the resources, we can walk the tree and produce ove=
rall
> values by merging the bitmaps. This eliminates features that are only
> supported by some MSC that make up a component or class.
>=20
> If bitmap properties are mismatched within a component we cannot support
> the mismatched feature.
>=20
> Care has to be taken as vMSC may hold mismatched RIS.
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

