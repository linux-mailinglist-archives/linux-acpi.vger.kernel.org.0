Return-Path: <linux-acpi+bounces-17387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43622BA83FC
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B7A188A759
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64923D7DD;
	Mon, 29 Sep 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q2+4rhez";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nSxetPwL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E82110E;
	Mon, 29 Sep 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131149; cv=fail; b=Y/nMvK+LQzOsdb0bM6jqdRA3gpcG8r+V2dz3UJPL5yRROPz0xOBf5XZLdrLKPi6OGQ5a+hd0x2+bcjkjhNr6uSWBt10hJFQ0o1BrE682Letz8LBINV5CpxusXKDvYxT49knHOn4sy0cIo2PXYxe/ee6yliDDazvQacd+pGdznNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131149; c=relaxed/simple;
	bh=KvrnTgPL70JqxKGdjgRQNX5sGwKWxl+uQqk020g4dQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D35x0a/xvYrrZHHXG2CjIYkNcWqFow4scmlEcdVf2JURraZMe7HhZarqy17+qenJr1tZKTXHwpjEcN8XcZGy9PYONXGseosQxK6n5fshYbXPExebqhifTzg6QRNAlcfSq+dN9PCCLbKuTBzRIt2DdOH8+5zF/ZqqXHM/O4KOis4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q2+4rhez; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nSxetPwL; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1759131147; x=1790667147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KvrnTgPL70JqxKGdjgRQNX5sGwKWxl+uQqk020g4dQE=;
  b=q2+4rhezHmIh79m3pK/md/f7v4Fya8fqatIcJ1+2tNwkgy/6sOqePYxb
   QHZfWaIJbpzyhwcwrE3m8FiOJOLx76k6sltOz21TnD5SBwoTmKmr224gX
   wEHPjXDAYrqnDJyjAgzZBCYT4FTKNjQL8uBdNjjOzBEOJOBUGsgjaTgZY
   L/J/WPu8ZzAAwPeSff/tLhPURGhuY5Ul+HkXhRyUr0x1fXftX1tVCbgoV
   8qtnMSQVWfE5L8lto0wFqK3fXjR6pjmh+iag6lmOW1FfPQgFfK04dKLQF
   SWNJtmUvpGKkfl5264ctih+YO7R/U/VsYxQXCxk/xwaw88E4vynESjhfx
   Q==;
X-CSE-ConnectionGUID: FsC2hcpeTA2xRWr5krgn1g==
X-CSE-MsgGUID: 3TU7ldiYTqqDOVpfyeUrRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="80142810"
X-IronPort-AV: E=Sophos;i="6.18,301,1751209200"; 
   d="scan'208";a="80142810"
Received: from mail-japaneastazon11011025.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.25])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:32:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjJ18F1ZP+1OY6UTnptDS09XPi4412rJb5de6okmpW+np9i3jOHaHvKsbMhfQvuTTKwAQ9JRP7yZTkrICuDKbG3OiDwgmZEEGtJolfrmdMiPIc68jrJBTMf8sG2Cjv/rb8cmqkCrP8kvzPLgrByY4cRliwR0Ekq538jjgDeEzp1nuXLFxkrp5xx5Mdn0v8e1Penw+ZZ0tk3RlS5aSEVvMWSSQlptm9Jz7UTx+yXtHnGIBzji8Co8PnpS+s8h5t8Uixtq/fpvcWICYZwxw3GYtu8OjTeu5Zbaj10ZX91dqNb4N7297CDyVbHScGIYb+BrJVkLx31b/qANuEF2YjvCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvrnTgPL70JqxKGdjgRQNX5sGwKWxl+uQqk020g4dQE=;
 b=YEqtOLW8EIltPy/36qBugo7pFOntj+kPGTP+wTRF81tBgpgJyDAnIkQdC2ghKnSREExavbgxsk0CNWj6AfYmzU9Mb2rs4uEBGsXAsK+sKEexPIRLu/BSu3YgEUWtEnaeGvxDNNsn8xqoDeZ64qK3FGcMlCFIEIfznvhPsS6hwiudvCosknm/NBza/E+TJY1W4oMq2ELK5E7d9PVg3Ph10f2vGCc2/KoTgOjT91UYjMwSbZ2dr1UPwX86TM955PhjVgRkuVU94l3dtPdDpXELwUBJeiUjlmgkSERL0TuNxdhTAxWELSuleud3Y3td0/Es07H9PPFKp37gDR66ZAUmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvrnTgPL70JqxKGdjgRQNX5sGwKWxl+uQqk020g4dQE=;
 b=nSxetPwLUKrWEj39KoRASWUTxReHDf/QU0J7xRHFaNOv0SXCXrJ+Q+q4IPHMaQO08tUP0X/wjH3dmFwEd+nGCuhlYmT+2XNovDYZ0ixjMPVPWQIXhDczqzsjzUAlf9zwrTby7h1nbqjHDl4DCB/3seq+e4RlAF6BiyIDsd0DF6Nn/YpKx6m2uUJttmP2mFEpVb8P53Dq3cYkNhaqInVMYzgf6yyJOcm3UxOiAmv2Kv3f2ZxOA3dXelj6wZ093e9q1kO7M4lhLPi1TcGaBwswGKOJE89q8mtItYCDpgPnq3DjIBqWepgc5OMA70nETJdren89DCpJugJNun/uCWsQBQ==
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by TYWPR01MB9695.jpnprd01.prod.outlook.com (2603:1096:400:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 07:32:12 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9160.011; Mon, 29 Sep 2025
 07:32:12 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Hanjun Guo' <guohanjun@huawei.com>, 'Ilkka Koskinen'
	<ilkka@os.amperecomputing.com>, 'Sudeep Holla' <sudeep.holla@arm.com>
CC: 'Lorenzo Pieralisi' <lpieralisi@kernel.org>, "'Rafael J. Wysocki'"
	<rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcHh171tqf09K4SkK1ciG0VLTs/LSJqfEAgAPpfaCADGlN8IAMe3yAgANvbvA=
Date: Mon, 29 Sep 2025 07:32:12 +0000
Message-ID:
 <TY3PR01MB9983E784E31A612B9BA23255D51BA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
 <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
 <TY3PR01MB99836C3D57503E70C8B8C9E9D509A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <TY3PR01MB9983025D434CAA2CDF83656BD511A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <3bbdc50e-a55c-96ed-a8db-6bbce1760ee4@huawei.com>
In-Reply-To: <3bbdc50e-a55c-96ed-a8db-6bbce1760ee4@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OTY0MDc2ZjctZmJjNi00NmUwLWJlNjItZDcyMmY3MThj?=
 =?utf-8?B?NDg1O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA5LTI5VDA3OjIzOjM2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|TYWPR01MB9695:EE_
x-ms-office365-filtering-correlation-id: 25a078fc-fb95-4a03-a30f-08ddff2a4e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejFJRTFxQVlEbDRWQlJNOUsyZEhsYlZHQ3o3aG9OQS9OR1FyY1FzOGFWVTFQ?=
 =?utf-8?B?VnU3a2RoY3NPZ2VLb1d3OFNSb0wzYlRhRlRLcTc1YzJGYzljVU45NlNmSnRY?=
 =?utf-8?B?QzJ3YlRMNGhKdWl6RU92V211VEwwY0E3MVNlaVdzS1JhaWxLemJoUC9YZllF?=
 =?utf-8?B?cTdtanR0OGZ4OTE1YUxPVHpub2QwTXcyVUZOdDkzd29Iakx6OHh5N05nTzY5?=
 =?utf-8?B?dnNyVTRPbUUvOVdaaUJoOHZPd2Vsenk1ZEExVHFzckdHdWJOL0Z5ekZMcFJr?=
 =?utf-8?B?ZmFVTUMrVlBLd05YdHl2TWp1MUhBVnZYQkJ5a204c0tkcDNnVXlCQmxUTkJV?=
 =?utf-8?B?V3lRMkIvNjJtS2RFRXN0SkRvMW5GaHdGS0hyM2ttSm41SFk4WW9LK0lFV3Rn?=
 =?utf-8?B?QXlKbjJuU3RWRlk5Qlp2RCtpQit5eXBJaXUwZjVvaWsvLzl4cTB2UUVKaGUr?=
 =?utf-8?B?MVpIVlpyRUtOeHl1ZmFZWUtuVy90Z1ZKVEwySkJoZ2dQUi8vcWdqb25jSXFF?=
 =?utf-8?B?WXRZTmhmbXA5MVYxSXBtVExZUmpXNkRCejk5TVplQlVUSEhxcldGamhWdHNS?=
 =?utf-8?B?S3pPUlk2MTAxbGpkWXk1eERHVlZiWk1wWmpIWk1SenJIazk4NVlLTnd1TS80?=
 =?utf-8?B?ZXBSRXhFQXc4c3Y5bXlSWU42M29XVWxYMzdoRDcweVdSOU9nNjBhQ3BSV1dK?=
 =?utf-8?B?UEtKQjJkSmxjcGdNOCtQZGZSUXVzVVNyd0djY1ZxTjdlcVZDeFlaK1Q3U1ZU?=
 =?utf-8?B?cG4zUUVsNGNoVmZGU3IyOE8wY1pobE80MUdmMzZlcmxCSjI3MWM2bmk0Ulhq?=
 =?utf-8?B?aU5KOXF2ZjdQNWFQU0o3ckZ2ZWM2RVpxOTVSdWFOa2R5RVVuV2tKbGU1aTUv?=
 =?utf-8?B?QWxBaWV6b2N3N1RWNEh3bmdNdm5LT1l1OGduT3ZlakJRNzBnZ3FlbUFuSkN4?=
 =?utf-8?B?dlE4UEZTY2IvK1c4ZFhrUFBKQ3l4S2VNMEEzSTRPbnJOdjJLaTgrNGRDemQr?=
 =?utf-8?B?a3FVQmFML3B2T28rN04xRmhyQlJqaXVGRnYzT2gzb3Jwc3ZocU5BM3h3MFRN?=
 =?utf-8?B?N09ZVWZORm5MWFRuZkdIRWFUS2ZNYWtxZExwSU5HVklYd01vVjhSLzcxWmVP?=
 =?utf-8?B?NWd4RG40cmdiN2dsS2dLODlCMTF6MDk0aVZuRm5sQkVzdWJjZEhmdmtRS296?=
 =?utf-8?B?bmx6RGpIOVVtNzl1L3lwV1Zab3JObTZ1RGVvbEl1UTNYQ21oaGU5L0x2NEIy?=
 =?utf-8?B?MWdZeXhPbHZjZVJRQXhTNHVaMmN2ZXFOaDU3ZE1hQkZMTDNHNUdEU2NHeGVm?=
 =?utf-8?B?aUY4VXJGcUlrbTA1YWdNK3JXampHd2lmSDVzTjlRYXRqQUxUdHZyY2pIejdE?=
 =?utf-8?B?cHdjT2RGTWQ5R1pDaGpVTGlubWdndStZM3RJV1ZWenJ3MmRrdjNsb0lJWmZY?=
 =?utf-8?B?TExyVTVaemVCSnVJdVNnSFV3MzhCM2tDd29kd2J6MGtlaStTZmgyQU1jZFEy?=
 =?utf-8?B?M0l0TXJCOEtmN2VOUDlwWFlPd2wycFVMajJGc3Nlclk5VHpzYUtzNkRRditj?=
 =?utf-8?B?bzE3d3c0UG4yK2c1TmZtdXZxUHRobXhQTWtmM2M1UFpjb045OU85V2VmbjRv?=
 =?utf-8?B?Yzk3dlJ6OWVTbG5VOWcxYUlyVElIeFF6RHVHUzRJbWdnalZoZVR3Z3pWdXVu?=
 =?utf-8?B?T0FIUGxHM3RoTjlaZEZOM3VMWEZhcHJHaE04WjVCb09obUdLbTFrdUVZSThr?=
 =?utf-8?B?UWhMRFgvcll0ZnpVVWFvR0x6azFBeDFFYVc4YnJGM0JIREhuR1pvV25FUlRq?=
 =?utf-8?B?Y0tndExVaGhMdGxqejNJL2xNd09PSEFiZVYyUHBWSExIbThJbGgvNWFmaEJZ?=
 =?utf-8?B?di9BRGZCT0Z0c1dYOWtYM0RiMFRvY0h0a0J3WGhlTEY4T2IyZVdPbWhBSks0?=
 =?utf-8?B?TE5YdldOZ21zUGsrbCsxN28rQ3pxRzBnRXg0U094aXd5ZFJScE0zYXFHWUx5?=
 =?utf-8?B?djltRnZKK3BoemRQSCtOYUNuQVAzU1FTSU9CeGpjN0lxNktEZXpJMXdtdlds?=
 =?utf-8?B?L2hRSHpYTnRaaGJsdWZQc2p2bytQUjhBSVF3eEo4L1VxMUdpZ2dRaE1yQUho?=
 =?utf-8?Q?TqwQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVNzUUdCYUE0VE9qcWJyRXVWanh0a2RpdlB4d2JBWkRuTWJpZnVJTTRqZ3Rn?=
 =?utf-8?B?L3ozUXNKOVIwWmsvZDVIcjJNWjM5aEtzV3ZHdTMwZUx3aDRUMUN4cVlYMFBt?=
 =?utf-8?B?SmVRQ2FhZkptQStXQWovQjQvbHlkRnpXbjd0WW5KVmRxYzRxeXYwQWhzSjNN?=
 =?utf-8?B?c1cxeTBadGIzTTkzNTdnSGx5bXE0Rkp3b0oySGRtOVFZeWdvRTY4dDlYYzV6?=
 =?utf-8?B?V25NazR1MlV3MnN2eE9BY3FHNDJudlVTZ0k0Ymp1RDJpdHgzblBUVUEzVkUz?=
 =?utf-8?B?WllIYjQ5UU1yRE0wUUtSWFVsdm4rZkdKbHM2YU9qN0NkNnZMb05tdVAvVnZy?=
 =?utf-8?B?bWpzVy91ODIvdGJTVWJ4V3hzYjdmZjBhQ2JReURuOUV2a1BQeUNudVBHZHVG?=
 =?utf-8?B?T20zc09Rbzg2Q2hwUXFBV1dHdWYwQ1VvdXVydnp3ajhwZy9OdCtOZU95emxh?=
 =?utf-8?B?R3lydmxlRjhiT3dGeHZhSmtMdU9OckwrWUgxR3VLMDJMRnAyYzNVMlNkL045?=
 =?utf-8?B?U2U0dkZTVWxWRmJHTzRPRjJWcnBpa2FsR2lIbFpLM3N1SUVTRHZBMkNNa1N5?=
 =?utf-8?B?U0dReFpxQTNocVBJZWNwK1hFTDdNRXpWc3ViYXRUQmkvQzlDM292bDh0RkNw?=
 =?utf-8?B?ck1qbm1KWm8vSTg3aUFHd0xnMnlIMkgybGI4OVJST04weTFuWURhS0xLZTcw?=
 =?utf-8?B?REF0c21wK3FmcHVldWpSalcyVW43RHZMOExMeERpTy9ralRWMVNiRThZSU5B?=
 =?utf-8?B?Qjgrd1cxelF6cjQ3b2J3alk1VzBIa2pTb3R3bXhpS3Z1NC9wdUQ1SkxZUGhr?=
 =?utf-8?B?R29Fa1NiNDNhaVBYWVR0akFHalJ4d1lJVzJRWG0vL25wVHN5L2lRRS9QQkZL?=
 =?utf-8?B?K1h5ZzR0N0V3RlFEZThCbFljU1RBZWR4eHUzdzVhMVVxaXpWVXhhMG5hYUYz?=
 =?utf-8?B?YnptRURtRnZ5OEp4Zm5BOGtPZ1lmOEE5L2VXaS9paXhwU3pkL3lyY3Vaa0xy?=
 =?utf-8?B?bWZ3UVhiNW1lRHpBYjVJMG9FaURuU1M2RlNWaVY1RzNIbUJuY3k4Nzk2ZGxo?=
 =?utf-8?B?bHlPczJFbkFXSWpCeDhGOFZYTUtUNFhhZ1pmZjJaM2RQRHNadExkZCtjRTBL?=
 =?utf-8?B?Ty85WVJoK2diNmhTdmdwRVVISG16QzIvTXNPb0FQcTNIQmd4WE5Vem54S2Nq?=
 =?utf-8?B?cmRXa2hDZW9vVGc5QVlGQS96aXlOWU1rWEp5Wmg1NmdPZkFmL2JnaHA1K2V6?=
 =?utf-8?B?UXRmWVdHU25Ia2JldjVERk5Cb1RYMG9MNkpyMkIzNVdSOGFzZFV6VWRQdFJx?=
 =?utf-8?B?dFdxY3RyTnJwQVhScVdiZE1Wc3lxcHNvRXdaZElxTFV1ditFOHVhM3Iya2xm?=
 =?utf-8?B?TW14QXg4SXhVWTQyK24wanhCaDB2K3I3WjV3V1A1d0NEaXdNNXo3aUczeGhC?=
 =?utf-8?B?djhsNys0WmNIenczTUZEK0h5ZTZ3Wnd1Yk1Pb1VycUluTDdnTUphdHpvMm5I?=
 =?utf-8?B?enZzeVBkdUtlVms5WWFwR2FQeEw0bkQ4TFpBN2psMUJqbmVQTkMxWWpENTJW?=
 =?utf-8?B?UHZoM2NYM3ZpQ3ZHaFJXejExTHFZejhBSy9EK2c3a3FBdW1HWkJGeUxFeDBi?=
 =?utf-8?B?Z2xhaEIzQ2tUcW0veWcxemdlbm1ldkpkOHVXWS9CelZWcXl3ZHY5bXdHTUNu?=
 =?utf-8?B?UEJ3VFZhWXhiRXAvYzA1cnNGalJPQUVINVhYaHdmQk55TDJPbkRIbVNkczhQ?=
 =?utf-8?B?VW5iUExNK2hMREQvM3N4K2U5dDA4cEtpRzI0U0NidzlKWTRCZm56Mno1RUND?=
 =?utf-8?B?RDE2OUNZeW9FdjZuS3kvc3dRbGNtRExnaFgyeHBJbW0yUE1EcDVSTVR4bElB?=
 =?utf-8?B?OUdtVHNqWEowS2hQNE5xSzhOVnFVREx0bFQwZFVFc1p2ZzNFOEt1MllDeWhY?=
 =?utf-8?B?R3IxK3Z6UlZOaUVCcXhnUE1LTG1ZYmdmQzJnSWI2ZHkzOXR2QmN2bVJkeGVv?=
 =?utf-8?B?d0cvMUVsWmRFSlNmMGFRS2NLWUpIT2RyMEEyWkw5eWpwUjlUU3VsS3ZGUnVn?=
 =?utf-8?B?c01ncXdyanU2ajJIcjJvTGZqeXA0MnoyVzdhZytDdjRFNHJNZHJDRlIzTGxO?=
 =?utf-8?B?OWh0cXdZNzNBT1NWTWNRRU03dkNTS0JFOWFBeXF3R25EVzdLZHNtMCt4Nlk0?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qi6uDByQ2Rt5RmfDul+wb2w2mYqP5Sl02QdpPB4WXNVRxS6EwRq/u1KqRhy9hJzRR6Xxh4jwu6R/QuIw0yaUJ8Jtiu5R5CJcbJQel7R8oXR5nqTZtxNBti9FjdO+aSoknJ2p75tOVed7D5IDIVvkfJfVbHDlP51sgXzTGFOBMHvj2Gf9d+usoMJN7+gMffSYZk5kD2jYkL7cmKfk9vNE1ogcpju/UcNsknuvHglydtFJ8X/+g6QXuaOSaSlZnvnWbcmiIyYWliGerFIChsWZxtS9TqzacjpfB/ez2u1nGUyqPYL3YCuS77oDX2Qusu6mcpkmIjdAhANXfjG25f3Wu950FUETV5WJH98Izai0Qp7ik6i5RTdVj9J2LRMwr9r3kUXLUFL/n7AbedLDt90TfInkCyvX7MKBNxGO6VPrpsbSv/6oE/gte0bC136eSf7gxyVQKsvW5Kt7QqbunI0neiRePx3NSeU5h0pvjVLCXJz38ZdYiGP820vsv51rvjR4/F6Ng9HHiHnvQRQ/KFgcfwWMSddu+L0UNAUoDPjib6j+/r6YPPkXvc8Tc7EGn3maA6A+v6sqW19rdq8kjUBrFOqYXH0cniav/gv27ypa6O5PqtQixKfUZicj898SdpcL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a078fc-fb95-4a03-a30f-08ddff2a4e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 07:32:12.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: och8bvonpT5Pwt/E56bcLaaLqKpeKFXUV0u+xEEEyQw+y4Xq2CLWqk1R9C89QlNhwrANZDFruXkres0f4HDzaShFi4itkLa3ZPq042hYdAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9695

SGkgSGFuanVuLA0KDQo+ID4gSGkgSGFuanVuICYgU3VkZWVwDQo+ID4NCj4gPj4gSGkgSWxra2EN
Cj4gPj4NCj4gPj4+IEhpIEthenVoaXJvLA0KPiA+Pj4NCj4gPj4+IE9uIEZyaSwgNSBTZXAgMjAy
NSwgS2F6dWhpcm8gQWJlIHdyb3RlOg0KPiA+Pj4+IEFHREkgaGFzIHR3byB0eXBlcyBvZiBzaWdu
YWxpbmcgbW9kZXM6IFNERUkgYW5kIGludGVycnVwdC4NCj4gPj4+PiBDdXJyZW50bHksIHRoZSBB
R0RJIGRyaXZlciBvbmx5IHN1cHBvcnRzIFNERUkuDQo+ID4+Pj4gVGhlcmVmb3JlLCBhZGQgc3Vw
cG9ydCBmb3IgaW50ZXJydXB0IHNpZ25hbGluZyBtb2RlIFRoZSBpbnRlcnJ1cHQNCj4gPj4+PiB2
ZWN0b3IgaXMgcmV0cmlldmVkIGZyb20gdGhlIEFHREkgdGFibGUsIGFuZCBjYWxsIHBhbmljIGZ1
bmN0aW9uDQo+ID4+Pj4gd2hlbiBhbiBpbnRlcnJ1cHQgb2NjdXJzLg0KPiA+Pj4+DQo+ID4+Pj4g
U2lnbmVkLW9mZi1ieTogS2F6dWhpcm8gQWJlIDxmajEwNzhpaUBhYS5qcC5mdWppdHN1LmNvbT4N
Cj4gPj4+DQo+ID4+Pg0KPiA+Pj4gTG9va3MgZ29vZCB0byBtZS4NCj4gPj4+DQo+ID4+PiBSZXZp
ZXdlZC1ieTogSWxra2EgS29za2luZW4gPGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+
ID4+Pg0KPiA+Pg0KPiA+PiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KPiA+Pg0KPiA+PiBCZXN0
IFJlZ2FyZHMsDQo+ID4+IEthenVoaXJvIEFiZQ0KPiA+Pg0KPiA+Pj4NCj4gPj4+IEhhbmp1biAm
IFN1ZGVlcCwgd2hhdCdzIHlvdXIgdGhvdWdodCBvbiBlbmFibGluZyB0aGUgdXNlIG9mIHJlZ3Vs
YXINCj4gPj4+IGludGVycnVwdHMgaGVyZT8gSSBkbyBhZ3JlZSB0aGUgc3BlYyB0YWxrcyBhYm91
dCBub24tbWFza2FibGUgb25lcw0KPiA+Pj4gYW5kIHRvIG15IHVuZGVyc3RhbmRpbmcgdGhhdCdz
IHdoYXQgdGhlIGlkZWEgd2FzIGluZGVlZC4NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSB0aG91
Z2h0cyBvbiB0aGlzIG1hdHRlcj8NCj4gDQo+IEZvciB0aGUgcmVhbCB1c2UgY2FzZSwgaWYgdGhl
IHN5c3RlbSBpcyBpbiBmYWlsdXJlIHN0YXRlLCBmb3IgZXhhbXBsZSwgdGhlIHN5c3RlbSBpcw0K
PiBwYW5pYywgdGhlIENQVSB3aWxsIG5vdCBoYW5kbGUgcmVndWxhciBpbnRlcnJ1cHRzLCBzbyB3
aGF0J3MgdGhlIHVzZSBjYXNlIGRvIHlvdQ0KPiBoYXZlIHRvIHVzZSByZWd1bGFyIGludGVycnVw
dD8NCg0KVGhpcyBkcml2ZXIgaXMgZGVzaWduZWQgdG8gb3BlcmF0ZSB3aXRoIE5NSSBlbmFibGVk
Lg0KDQpIb3dldmVyLCBvbiBjdXJyZW50IEFSTTY0IHBsYXRmb3JtcywgTk1JIGZ1bmN0aW9uYWxp
dHkgbWF5IG5vdCBiZSBhY3RpdmUgdW5sZXNzDQoicHNldWRvIE5NSSIgaXMgZXhwbGljaXRseSBz
cGVjaWZpZWQgdmlhIGEga2VybmVsIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXIuDQpJbiBzdWNoIHNj
ZW5hcmlvcywgd2UndmUgaW5jbHVkZWQgcmVndWxhciBpbnRlcnJ1cHQgaGFuZGxpbmcgYXMgYSBs
YXN0IHJlc29ydCwNCmFudGljaXBhdGluZyByYXJlIGNhc2VzIHdoZXJlIHNvbWUgY29yZXMgbWln
aHQgc3RpbGwgYmUgYWJsZSB0byByZWNlaXZlIHJlZ3VsYXINCmludGVycnVwdHMgZXZlbiBpZiBv
dGhlciBjb3JlcyBhcmUgdW5yZXNwb25zaXZlLg0KDQpUbyByZWl0ZXJhdGUsIHRoZSB1bmRlcmx5
aW5nIGFzc3VtcHRpb24gaXMgdGhhdCBOTUkobm93IHBzZXVkbyBOTUkpIGlzIGVuYWJsZWQgZm9y
IHVzZS4NCg0KDQpCZXN0IFJlZ2FyZHMsDQpLYXp1aGlybyBBYmUNCg0KPiANCj4gVGhhbmtzDQo+
IEhhbmp1bg0K

