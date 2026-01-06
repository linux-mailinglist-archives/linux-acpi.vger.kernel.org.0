Return-Path: <linux-acpi+bounces-19971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C7CF7099
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 08:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5443302A976
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A342630AAA9;
	Tue,  6 Jan 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AuhR30M2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010016.outbound.protection.outlook.com [52.101.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A122CBF1;
	Tue,  6 Jan 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684603; cv=fail; b=SndOUos4typJ9Z1LQ5j7i3YhUeHkZ/sPwnGB7Z84yskbDTzFiqGV/afD+wU0Y2jbptw9gUCgTyPHqAsvnJJIuS/H/ieOBr5T6+LYGLPLwe3sEawfGgF5wqRbLBPQ5uPRWlz0sNWayJzD3f13WZBxcZVcZG4GI8BE6ty3wMmLj6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684603; c=relaxed/simple;
	bh=4JbzaDvM6CBOTWkE/Ft4k8mnLC0Hxed5TpquIpTHDdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D44uMgy3ABcEzmniZwvwKkmm7hqf0i8NI/5DXTD652PTv6RNfKYhDeo73zO0LpIK18ZdiJiN08ryIiwRlnsEH/QPoYn/OPdXHvs8YHG84PPQD2TQcQQBDvaWKrV0fRCT8P1Y0xDUD0GclZICJ1yfW1DmC5uqo/NvW9n3E/gnKjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AuhR30M2; arc=fail smtp.client-ip=52.101.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD8eEgEUwaNN9NxoCklBjCOql6YJRHpTgxJe2YeNZb5Vf9fO53Tmfy2IrJ+82jMMIgE1DX3GPdClsCtl8ANHdEuDgje+Bth8gNPcdx5Ns4qsQlmFYYF1WdJyfaC1LruFFDYX4v4PwvRVmM0RhDYPhibo2Qr8qCy07OkDHBDlaAbSHh9J5bNEVNlcZqMEOWEN7xSbsKbFSCbRMaJEJGg8DvNZ4kokJ1AZsCdepYiGKDoQE8gXgkQXgJK9jngRM+AlETEvvh6bFdWQ0OCFCCuuxtMWSIUEEZzyQHByVMF7IJ+K4SOsD0uKNpPUOzpjUnVLsY/V+CeCDvUDvIoV3etW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JbzaDvM6CBOTWkE/Ft4k8mnLC0Hxed5TpquIpTHDdM=;
 b=lrT8xghdEtDyXS/akUu5uJn4C95SW2SVirp4srf6cULGRMjIUCD36tMnn+OWOKxXAHOGQOhl+Dc3gKy13Wd7fFg2DAVP+oElvqtHvsKdTUcALm7Dee60il++5RLPb1gRPZ/mvgUuIkyQNqxVdgUY+GGxE+w9IYieS/dLtmcju1mJYS+K8XA2C7DlonQA7JxwGYgyqQxTpm11jK2epQKMtwQS3CJ2CMrqec3TFKbhO9rtqU5hNzDJ+2mnYN4w7YkMQp7jHRsQNznuYG4NwXmhJP2k6srLnFAxZSsk9bB2xXfSNcsdebBICCHnCPUyxx/4BenVtwvRz0NpuPhxIxFbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JbzaDvM6CBOTWkE/Ft4k8mnLC0Hxed5TpquIpTHDdM=;
 b=AuhR30M2oTs76lyPyP9npVWJUvFuKVO4d5KEg1wx3Pzk6wV+Xdgrq68tVfVd2HvhtdNVWlnuy7tUjouW5GeFFuFrAThtB/NOdYEicuNdX2JVBPZkdkRh/G+kw874/yJI1odgKMQBRu0FmRdfa+9gCmM3S+dN5VSB+cxa9dKTHvZAcHM36Er10i9IE5cDfjk0AZ6mf5oCxfZblUj40oU2rzvEEtGzXH7DqTHtEYbF33+QjpWCqLqgbN6pfKvdN0BXgwGtcuo/TFq2cErQs3zPQEfaFk3wTjmOfM4zEBSij39ZtGiyyGpPgQyusPzcj8u2JEiiUQ1ZShR1BpLAwVzpsg==
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com (2603:1096:604:3f2::7)
 by OS7PR01MB14985.jpnprd01.prod.outlook.com (2603:1096:604:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Tue, 6 Jan
 2026 07:29:59 +0000
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a]) by OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a%5]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 07:29:59 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Catalin
 Marinas <catalin.marinas@arm.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Koichi Okuno (Fujitsu)"
	<fj2767dz@fujitsu.com>
CC: "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHccw/MoUAWv391kEu2DGiF5vAvULVER3OAgACMRdA=
Date: Tue, 6 Jan 2026 07:29:58 +0000
Message-ID:
 <OSCPR01MB16310961C8744194C94C51CAED587A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
References: <20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com>
 <176764598538.1443384.12447831892240359560.b4-ty@kernel.org>
In-Reply-To: <176764598538.1443384.12447831892240359560.b4-ty@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9N2JkMzdhZGYtMTYzZi00NGIxLWI1ZGMtNGVmZjQ4NThm?=
 =?utf-8?B?YzNlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI2LTAxLTA2VDA3OjIwOjQ2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB16310:EE_|OS7PR01MB14985:EE_
x-ms-office365-filtering-correlation-id: 8c14e6f9-4d1b-4c54-cd39-08de4cf565ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjNtK3phaUpiR3FpOWNraFJSZG9FSVplNm1mWUdyQlpzdFNvR1lIKzYrOGhZ?=
 =?utf-8?B?MTRzZ1EwSWVrNVV4M3EyUHVWV3RiZmp5QXEwU0hGMkNhWE5vRXZoUE4vWG0z?=
 =?utf-8?B?MjBKdjNDWGtEQm9rNnA3dkREMWQvYzZKR3hWTk1TRkUwVlJjckF0cGhibjNU?=
 =?utf-8?B?VGpKd3k5UEhVdUkwZFp2RHNnbTBRU0JLUDRTRTFST1dVYkcxQ2pVdTlBYnJD?=
 =?utf-8?B?N00yRU9zNmtoTkVteHVDTDVSSHk4c25zUTNjRTRhM2hvUHJXSHl2MTl5U3U5?=
 =?utf-8?B?eWYyZ2Npelkzeml0UDJlbkpjUjJxNjJqQmxVRFpOZXBsM050M1FvenNSSEpM?=
 =?utf-8?B?M0dNWTNtWVQ0RmNtdm9uZEZpYWVJWm9MWmoyYXdQWE54Y1R2RUIxN3VFQmVt?=
 =?utf-8?B?OCtDYWkzaDFUUE5RdWNCZC94bEZaRkI5d3RpZS9hcS9STytsNjJ1bkltM2Iw?=
 =?utf-8?B?SDdpdXJZQk8wZE5RTXJiTEc0L1JPNndXVUkvYm9FRTRseXJNVStSSWFLU2Fm?=
 =?utf-8?B?UVZBeE8yWkZFRTNEK3pNTGlucTRMcXkzVVlRS3djbzVhSzRDYy81c3lRQlJo?=
 =?utf-8?B?RnF5clBqVDFEU3FBeW9NeEI3ZzRUQXk5U1hFUGJqRTNXOFg3eTd5MHdyemo5?=
 =?utf-8?B?b1dmT2c3RHNNUEs0S0ZDWmtUQkVCem5rdjlDL01XaWVLazVWYWVya3hpelBi?=
 =?utf-8?B?OVZPSm9odHZBZE1ITTYwZzk2YzZkaWNERWVoUUJiQ2pEVnpYenFaUWc5TjY1?=
 =?utf-8?B?cGNud1g0ZlBEa3hPQk1PN01GODNycFkxTGp5RjdDN2xYY1U2SThlK0t4Z0Jv?=
 =?utf-8?B?QzNzL0xNT0YzRmZVUHNjSlhZL3d6VFovNklHcmxuQXM4QVorVjNZbWMzZ2tJ?=
 =?utf-8?B?d3A1QXE5d0tEaCtXN1FmZGMvbmdYeVRwNmVpQ3pGOWM4WXNUVStDMTJTaGph?=
 =?utf-8?B?TCtkdnE5WW1wUUdzSWpReUZMd3pzMFNRSHZUQVBVVzl2RlRXWElTNEs0dW5O?=
 =?utf-8?B?Z0tINXBUN2xhUzY5em5vbnoxdURUMXRYV2VmMHQ2dkp3RHlLdURsd3BPZmJP?=
 =?utf-8?B?Zm5aRmpIcTk2bDZLL1Z3dGVLbGRBYzZEem9lYkZmR0R3dHRBYS94a2taZmFM?=
 =?utf-8?B?U2VDc2owNWNJQm1JenVTWmNsenVRM1pOc0RtQk9yRUhJV3pHY3h5S25SbkNu?=
 =?utf-8?B?Q1hhVkw0Q2ovcFU2MG1vZDVuY1N3L0gwLzdCR2o0cGdGRmpnR0ozVWRsVE1J?=
 =?utf-8?B?Y25RY1k0VWJsZXJyZ3JIdENKT1Zkbjcyd0FZK0IvaFFCL3ZLWllsWEVUZktm?=
 =?utf-8?B?WENrRmpORVNvM0VZeDU4MmRJYTBtSjhZWVo4S25mMm4rMXcwUHM0TGFDdm1Z?=
 =?utf-8?B?ZmMyQTNqN24wODE5dnNUQThKOVQ2M3dVdnlWc3Bpenl2UDE3WUNsS2dpeDYw?=
 =?utf-8?B?dG5aZE9KRDI4WittdFBLSEVWdW9JYkNzSmhkdS92Y0NwTXNRbkpUUEdZUVJU?=
 =?utf-8?B?bi92UG4wZE83eFRsT0JtK2U3S1lBb2Fja2s5eFpOcndrRDMvNEpzeCtEM1A3?=
 =?utf-8?B?ay8wUy9zUjUvRzF2WWRCa1pieWdtV1E0RU9VTERkREZVcTYxRmt1dkllZEZu?=
 =?utf-8?B?WmNtenFLM3BtdUpZZ2NsdE41SDFrRmJRdW9iSUlyUVBkbkNZQ3lOd09GQVh3?=
 =?utf-8?B?WUs3QUZHMVNDdlNYaGl6STBvVG80V2lJU1ZBNCt6RjcwN01QUWdWRnRnMGpn?=
 =?utf-8?B?WmhSR1dFNDRFdFA4NFYyaytjSXhvWjZNaGFDck9nQUVVdTFsV2oycjhEd1JL?=
 =?utf-8?B?ejVDeHF2YUQ5Tmc2eWpUYm9kcSt4WnAxWjIvOFoxdDcrUDRJMjZYZnpQaDNC?=
 =?utf-8?B?TEt2M0Z1ME1nNFIybFo1cGFhRG5FRFc2eERuWkZtZ1lDVVZBVGJhdTVDNWdk?=
 =?utf-8?B?a1o1NjlVN2RKaDNROU1oVmU5cUoxQjhaT1JodE9SNGJuTnl3UzFhN05sS0Zx?=
 =?utf-8?B?aWFsL2MvanNCV1VRSzN5TnJHSkQ0VzhwZHNvT3IwWlI2bldDYjdXa0g3Vng3?=
 =?utf-8?Q?Pw9WhJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB16310.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUpZVzZQc20vN0ZVb0RwWTFKSjk0cGdKWHpOQ1UvVjJMS3R0ekVacHhNcVFz?=
 =?utf-8?B?TEV5VC9IcXZpWHB0Slc1MzQ5cEpnNVVNdnNscXVNSDgrMnliMW5KakdFTGxE?=
 =?utf-8?B?dHlJMzMrWWgyQ0JhbkplQjRuNkZqSStaRUZYK1pDK0RXWHh3bnRpaE1obW9y?=
 =?utf-8?B?YjZmUTBIbDU0YlhNRHk3REdkaERJeitSVXB6Rktpb2hSbmFpOEQ3QjY1SWc3?=
 =?utf-8?B?OVpCSE9mRE1Sd085R3NuREdvdEkxSnpweTJ3OW9ZanpLM1pCdUxuTlFXUUJi?=
 =?utf-8?B?THY4aU1LRmExa1BqcjBya1Qyd2JDa3JBZ1ZSMjBFZVNsS1pnbG1vNHh2d1My?=
 =?utf-8?B?ZXJEWXRqaldFNGMrN1hQVTI5Y1hlZUhQeWRGYWk2eUxWMDBkclFKOXdod3Fa?=
 =?utf-8?B?bkxEa0ZIWmpDcmVsY1M1anBFcFdCVktCV29LUjZFNVNuUUxWc3o2RmFEU0Ru?=
 =?utf-8?B?YTRDYjVwQU1SNllQZ2IxWlNIem41MEI4QVREbkowVU5aT0pPeDYvTmJzUDMz?=
 =?utf-8?B?MTd2S3hXci9rSnoxQnFDK21IWHpPL3JFZGlSZHNVdE9ocEpTWXY1Mjh2cmlk?=
 =?utf-8?B?RmJLR2g4cWFkTGlvZStzSll3cVEyTU53S3RBeXVncGRvS2dVZUFYYUJwaWZn?=
 =?utf-8?B?SG1YaEYvZ2RIbEFBVlNzVGVSd2hBM2tnc2F1UTRCbDMzRTV6OC94RUw4cHVj?=
 =?utf-8?B?TktveGp0SEZaaTVYU3FKcEdRQ3RWcEFaNzJ2OGhJbTZmYktQalhMR0U0bklD?=
 =?utf-8?B?MThiRWQ2WFJuNGJlWjRSTWNsbFVDd1Z0eTdsU2NuSlJYbXFiQ0JFTndjOFky?=
 =?utf-8?B?UWhoekdta2lxc1NFalJYVmt1bW1ic3laT3BIY3QrQWRxRC9wZlJiK0duUUtB?=
 =?utf-8?B?cFA0aUtqc01UUnVvNFpBQUxycmd6bUJWSmlwU09wbTRFQkQ1R1NwSTlJaVVQ?=
 =?utf-8?B?TElzRWduWVJPayt4TWt5U3VZRng0OTQ1U3FlZGxwc2xsdlNuU01pSERYK01s?=
 =?utf-8?B?MmlsWmdHZHVlM3Q4eVJRYk5mdlRnSnR2QzdSTUNwZGlDUEZNbDhVdTIxTThC?=
 =?utf-8?B?c2c4TjRIeTA4QmxyZ2s3TzkrQWVNUW93dXg4bmZscURJSFVCQjQ3TUJlamxj?=
 =?utf-8?B?d05xRzAvTlB0eHlwWkRpWG9LQnk3aXZOaTlXbXVHQk9WaWdGWkJQdzdGVjZR?=
 =?utf-8?B?TFdDdmEyVmRCdGlaU1hVaXZqMnhSZGhBbC9seGhQbTIrZlp5MmRJWTJYc3ZY?=
 =?utf-8?B?ZVpCQ01sVEdyZHR3RVhUZW9Makp4cWNWYWdWY3k0emd1ZkNEZEt2dUNXQ2Np?=
 =?utf-8?B?VDZvRlhIaUViaSt1clBSek5DMHVUaS8xTy9UdyttUmRmcGswNGJIWUUzL1ZC?=
 =?utf-8?B?ZG5CZUFCNnRHekt4ZDFML2d6QVNTZll4SVc5Q2xvRHRvM2lUb09Bb3Z2aXNI?=
 =?utf-8?B?UUJuRUJJSXV3bHdyR3haTXpoazB2WUhueW5ISGlxNUlVK1JiYjBqVzRHOFBp?=
 =?utf-8?B?NTgyN0VQYXI2MlRObHpxM0R0VjFhZG5YdVhrMytSMXVsTnc5U2FoNG12TWds?=
 =?utf-8?B?WTN1Rnp1RUQ3Uk82ZGFySnQvWXMvSkhLUjBucWlQMFZWdTFvTzhhK2NVdHVp?=
 =?utf-8?B?aXV3WE5pcmtVWkRSaTRXbGlKUTNKTE1VMys0Q2xrNzIrQ0NTYm5SdlBSQlZs?=
 =?utf-8?B?cUxWUHlzY2E1am14ZUZjSVF2TUxUVk5tblAwSnpPeFJ1RllPMXdxTGk3MitQ?=
 =?utf-8?B?eXJDSVVvdytWUlQrU1g5UlZlTFFjQzI5Mm9ITXdxYytmYy82VTVpOFlSc2No?=
 =?utf-8?B?SGJFWTlXZk14REo2MmlKZXJBeVhUOXpaVjNXNUV1d0xnUDVGK3F3bFJBZ0VB?=
 =?utf-8?B?STV2RVhjR1RBYkpIbURwUHhtdm5KZEh5cWJtVHFmWitocG4xOC9zb0g3ZkJN?=
 =?utf-8?B?YnY5aGFjVjJmUkloQ2hkYjFiYm9LMlhHdTBCSkVDQi9WVFF4NTA3OHpRSFVk?=
 =?utf-8?B?MXhuYURudWY2Z1Yxa2ZQWnVrN3hDQ3FJcHdaOEZFandjUmp5T05IVFpSSzNX?=
 =?utf-8?B?TlNvbUl4dVRXbm9PZnNZNkJUdWdvdm5iKzRzdGxKU1lxVThSUXZURUFEa0o1?=
 =?utf-8?B?QUJUTURGVDFkZkhzM1loL0xCSnczelpoaUxCSFo1NnRzYjJaWXVBbTByOGE2?=
 =?utf-8?B?cjRJTG0vaUNqRGQrYnZZTCtsNnRnQUQxR2Q5dE1pd01ObWRaeWV0UGcrc0g5?=
 =?utf-8?B?K1kwUytwRXZRRFpLei9qNE55S2NrSnNuTG9tSGpNSzZTWURsWVlGbDdadXhI?=
 =?utf-8?B?SU51WkkxdmxpMHUxYSs4V3VqNi9SNERNaGFzY0U3cVFaZGpmVk9tdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB16310.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c14e6f9-4d1b-4c54-cd39-08de4cf565ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 07:29:58.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMcIxgD0Z01dTKq3CzCKatDWOIvIAOxAu7ZzRWIJc6NjRCpshmimSnom+xVD+AIX2cJsuf1B7dh3LK6WlGPn1Pmk1GNrvjI0RT7xOmlxM58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14985

SGkgV2lsbCwNCg0KPiA+IEFHREkgaGFzIHR3byB0eXBlcyBvZiBzaWduYWxpbmcgbW9kZXM6IFNE
RUkgYW5kIGludGVycnVwdC4NCj4gPiBDdXJyZW50bHksIHRoZSBBR0RJIGRyaXZlciBvbmx5IHN1
cHBvcnRzIFNERUkuDQo+ID4gVGhlcmVmb3JlLCBhZGQgc3VwcG9ydCBmb3IgaW50ZXJydXB0IHNp
Z25hbGluZyBtb2RlLg0KPiA+IFRoZSBpbnRlcnJ1cHQgdmVjdG9yIGlzIHJldHJpZXZlZCBmcm9t
IHRoZSBBR0RJIHRhYmxlLCBhbmQgY2FsbCBwYW5pYw0KPiA+IGZ1bmN0aW9uIHdoZW4gYW4gaW50
ZXJydXB0IG9jY3Vycy4NCj4gPg0KPiA+DQo+ID4gWy4uLl0NCj4gDQo+IEFwcGxpZWQgdG8gYXJt
NjQgKGZvci1uZXh0L2FjcGkpLCB0aGFua3MhDQo+IA0KPiBbMS8xXSBBQ1BJOiBBR0RJOiBBZGQg
aW50ZXJydXB0IHNpZ25hbGluZyBtb2RlIHN1cHBvcnQNCj4gICAgICAgaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9hcm02NC9jLzkyOTZkNGZkMTkwZg0KDQpUaGFuayB5b3UgZm9yIGFwcGx5aW5nIHRo
ZSBwYXRjaC4NCg0KSSBhcG9sb2dpemUsIGJ1dCB0aGVyZSB3YXMgYSBtaXN0YWtlIGluIHRoZSB2
NSBwYXRjaCBJIHN1Ym1pdHRlZC4NCkkgbWlzdGFrZW5seSBzZW50IGFuIG9sZGVyIHZlcnNpb24g
KHYxKSBpbnN0ZWFkIG9mIHRoZSBpbnRlbmRlZCB2NC4NCg0KQ291bGQgeW91IHBsZWFzZSByZXZl
cnQgY29tbWl0ICI5Mjk2ZDRmZDE5MGYgaW4gZm9yLW5leHQvYWNwaSIgPw0KSSB3aWxsIHByb3Bl
cmx5IHByZXBhcmUgYW5kIHJlc3VibWl0IHRoZSBjb3JyZWN0IHY2IHBhdGNoLCB3aGljaCBjb250
YWlucw0KdGhlIGludGVuZGVkIGNoYW5nZXMgZnJvbSB2NCwgYXMgc29vbiBhcyBwb3NzaWJsZS4N
Cg0KVGhhbmsgeW91IGZvciB5b3VyIHVuZGVyc3RhbmRpbmcgYW5kIGNvb3BlcmF0aW9uLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpLYXp1aGlybyBBYmUNCg0KPiANCj4gQ2hlZXJzLA0KPiAtLQ0KPiBXaWxs
DQo+IA0KPiBodHRwczovL2ZpeGVzLmFybTY0LmRldg0KPiBodHRwczovL25leHQuYXJtNjQuZGV2
DQo+IGh0dHBzOi8vd2lsbC5hcm02NC5kZXYNCg==

