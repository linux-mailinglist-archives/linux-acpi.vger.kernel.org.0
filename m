Return-Path: <linux-acpi+bounces-16518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698BAB4A2EE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C51BC0A46
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 07:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3365306D20;
	Tue,  9 Sep 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="M3eh14+H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63330505E;
	Tue,  9 Sep 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401503; cv=fail; b=TqoHBWQndv3QOAMG1rumXU+qlzW34gYqoVYbsxZ7ItRVdXuvE28jBqClI3M16P3rSq2JXLL/Io6RzqQLrRb70BX8KoepStrSMHBXka/ZkieO3XE4bx6N/nJUSgt3ItAPrmICXjibxoOvHGAHfyNNcVbljjndom0jq87NH13X8ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401503; c=relaxed/simple;
	bh=ucC20KFCq5i5sMww8PDOaV2CP7p4YWU1eF8ere50B9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6AmeKwJoaI/xOnDlzt7s9UEwLzt9sWs0hyT9H3jtOsYOv9wkE9SzlNMg636WXRBxRQaZZgEOieafIQZMv/A+5+KGdbnxBaUprrqrPHSECo6OfLpQRgs2HO5apcl0DOIZailKIzeplNct1p9fnM3MeHp88Vz6wf1s8mbvXSOveE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=M3eh14+H; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757401500; x=1788937500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ucC20KFCq5i5sMww8PDOaV2CP7p4YWU1eF8ere50B9w=;
  b=M3eh14+HyllFmVWP9GWSvOJD0yYqKNd6sgi6G86CVIRyGcjYXwuVtJ1c
   bxhp6P8rHtlyNN1SyvGWU3IDA0ZZ4h6yXe5S/XMwD/gFrAwtmaO1xFc4Y
   urneBw9rKBF/re7ko2WwUuYTk/+2zNnbX9ss9to607mDlW0WxrWE2Ghc7
   WdTOY9uWX9QWfP4m1h65bX8XAV7NIzd+TqeqotiLCCtPNKYTQezWMgouY
   1c/Q7vQYOOhzt00NCiYouBlaftCe32Zv3/1wlYTxleLWm9TFPiboyVv/3
   AhJsDqvOOf9Ilno46sySd1tNjpr2Ts8zCoxfGEhn76qceNIaOurhyugFo
   w==;
X-CSE-ConnectionGUID: 0Dcyh/hEQpC9AWQHh7lieQ==
X-CSE-MsgGUID: zBEJV7ErTYmQ6DEN7/Be0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="80187060"
X-IronPort-AV: E=Sophos;i="6.18,250,1751209200"; 
   d="scan'208";a="80187060"
Received: from mail-japaneastazon11011055.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 16:03:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE8bluUsJoRAY9xj9Bb8WSJWJm4WZQ33gUgBka5qC2idmB9H62lfMb3AYesuAVObN/gkG7dkEUaxRoUamRWsZz+t+Dbv/udKL/lZHwx6kxqdUw/p7vpchhcfAf3Li5HqvKOYN+dn60mLehd3wWuWs3JhHI7INEI5Y0JmZNSGkZAgNxxfww8aA5VlAFKYDdilLPhDaMMbJditC1VSbzEhQjibfKvpA/qvzXiQ7ilGt+WP9VwlAx/Ucud2EYHc6XCtw5DpRcjFS84TyUyntKSUkjkRWUN90wWI2qK12WluzKMx9kyp7IWJ9PFQ4w6KvHDPomgiT7mWDjRK2py+knrrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzgssnqaPLfDulHQAYJQnpNbSEDsOXCXytHb4AQJmEo=;
 b=sDZeRiN/PUis4rtkKBmRRVD2o4tdbj086N92ossIbyaohAKlmDk4s5QgijJ9DamzJkhGa30GRfC5JIcbQG9pUE4riPyhY01FyYbqcC0jeJpsSecVk4aEIStl5KYELDJJA24wEMZSDo0zsuqrmsMnq+AjP948brEdtnVdpiRqM7NY7kbFOScs6tAYeA5vckyr8pikWbi9bphpRlOWzzpBDdFb6N2SeWj5kx66r9wy6b+xM5JaWV4uLv4K+0TOSn23i5Qi60P8aZgXppA6wMtHkew3sSbZAzqhEKQxmjQ6FYmTI8m1igyFB/8R8sImArIqCYVztPU+DgJzg8RJOm1z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSZPR01MB9456.jpnprd01.prod.outlook.com (2603:1096:604:1d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:03:35 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 07:03:35 +0000
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
Subject: RE: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Thread-Topic: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Thread-Index: AQHcE3pd4cKq+7AB5Umn0Le01U71qbSKh1lQ
Date: Tue, 9 Sep 2025 07:03:35 +0000
Message-ID:
 <OSZPR01MB87984A649F19363669F1D6688B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-45-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-45-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d8f5926b-4ee2-4903-8b70-a503693d4c1a;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-09T06:58:31Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSZPR01MB9456:EE_
x-ms-office365-filtering-correlation-id: 09b65516-373d-4495-6786-08ddef6efe91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MWt5aDFoWVJEdzUyY1ZPNndnMzBmbm9FbXIxTDBSS0lpb0J5U1diSVFZ?=
 =?iso-2022-jp?B?KzVCU1BSbGFiaDhEdWNXOTN6NVRnb3gybEF4ZkNGSVRsNWowY3FBTXpu?=
 =?iso-2022-jp?B?NE5vZ1ZUTnBrK1VzckhDd0gzK1JGTEpobVVkUkFxWWFYSDMrblV0bThY?=
 =?iso-2022-jp?B?MmROaDFYUWNrZm1KRzBxSW9ZNmsvK0VMWkR4c3REOG56Q3NpK0h2YlVw?=
 =?iso-2022-jp?B?RytjYWhWbVE1c1RyNjlNdS9lQTd2Umc5WUt3YWtQNG84eG83RmRVRndR?=
 =?iso-2022-jp?B?L1owaFJ6QTRLR2k5ZFlObnNlcmFUL083MGE0SERZd1FEMlNPMG0ydjRq?=
 =?iso-2022-jp?B?OTU3TjJWOFp6anN3ajMzU1g2anM4S3FwQllraEFzbmhoMmo3TGtSanFY?=
 =?iso-2022-jp?B?UW9VVlRUUkI4Tnp6K1RNVktDYXh1azlTRDUzWXA0bnhMSW9rTHUyT21w?=
 =?iso-2022-jp?B?UjJEa1N0RmJHeEtiYXhPbzUwcHNxMkw0K3JQTXU5OTFFalc3UEx5TWNW?=
 =?iso-2022-jp?B?NjRsZ2cvVkthWGFBWFRZTU8zaCszbDJCRkZ6Unk4UkNYRGhTa3cxd2Vy?=
 =?iso-2022-jp?B?aDg5Tnc1OEdDUlhYaGRHYXRmcGVnK2dmeTV6WE04c3J2ZWE3bEZobjQ0?=
 =?iso-2022-jp?B?UEwxYkNaSEdZTXIxaWZ6T0h3TTZyYU5STE5xNW50ZXpHUC9Lbzdwbjdh?=
 =?iso-2022-jp?B?dmUyTWlCUURvbDk1Ym5WeVpvU0NyWUI5T2VpRjdsaVRHdzV0L2dUelBh?=
 =?iso-2022-jp?B?WFNwY1VkbU5kbWlrNjczQlRQczhjVW9QVW1sdk9ONlo1RVFJcnp1MkJV?=
 =?iso-2022-jp?B?UWNiTnVvT0VuUDY0LytmYXFZVm5saUpYVzFCMDNNLzR0cEhNRE80NWZS?=
 =?iso-2022-jp?B?ZGlnZ0NIQm1qUlpKbDkxdE83N3pMQitZczZ2VWw3SFJibUJDaUx0NEgw?=
 =?iso-2022-jp?B?WDYrVkpxUE5sU0VVUGg3NUhxcWFCSVRUdk5FWHdhaE5xSGtZMEZHSk9j?=
 =?iso-2022-jp?B?K3hPWWRvQVl1ejlkeFh4NUd0ZWM3QytTM3lUVk5zbjJOblE4eUZ4VzQz?=
 =?iso-2022-jp?B?a2czQ1hNcjBrczhHRlNhZENmdG1OY0Zja1VpbWRtUlRneXlXZkNFVE43?=
 =?iso-2022-jp?B?VkFidnVXOXR1QURPWFk3ZVY4d3p5a2VaWFdTckhhQWl3RzFJMTV6Qzhi?=
 =?iso-2022-jp?B?cUJvVjkyNVplRnNuSjA1VWRabUhoMlVvRDNQZDhHYjZZUC9Jb1VPNHFP?=
 =?iso-2022-jp?B?UTNVSHNvSDBKdzU0bHFjTzJzZ2FhQ0pkRFVVd0VhNjd1SW9YZEVSN3ow?=
 =?iso-2022-jp?B?d1FabGxmV0x5T1l5L0tIblJpd2F2dWFQN0ZnUlZtY3huNitsSGlISi9l?=
 =?iso-2022-jp?B?TE1SOGxZa3dmd1g5SUtXOTFQdVpBaVJma3pnWldHakNpbFVMOHlQYmF1?=
 =?iso-2022-jp?B?OFJLVmhtVWpqSXpsTWxHSVFwd2s2QUZURDMzdWIydjFLTm5sUzliZWRY?=
 =?iso-2022-jp?B?b3ozNFdlaDdsOTFPb2hxakczTlRxeFBRY09Pak9aL2sxM1ZSeHNoWnBi?=
 =?iso-2022-jp?B?R3pXWUxJZk42LzBsQklaWE5kTXlFdzBBYXl1R3JISTFxRGRnYUFya25j?=
 =?iso-2022-jp?B?VnM5Y1RkM2ozYjZBWnNIcHlEc1o3TDRoZmsyRnBJNDFaR1dKWnQyT09o?=
 =?iso-2022-jp?B?MVFqZTdEZCtTS3YwNkxDblFTaS9NR01SZmY2VmdvVW9Sc2ZIaklxU2xT?=
 =?iso-2022-jp?B?TXNnYWs1a2NPdzN0RUhKbkJQMmJ0ZU9BTTdpTldkS3NPY3Nic3hHRzd0?=
 =?iso-2022-jp?B?Z05Bdkc5akZxMnltU3pxcXlNVHVndjJ0WlFRcTYycG91Q0llMXNwUXpJ?=
 =?iso-2022-jp?B?bXVSMFhJVERub0dBUWtmbG5JUXRMUzlZK2EycG1jdE91SW9pTWY2U2Zo?=
 =?iso-2022-jp?B?cklNNXhMNXhSYmhHRjhXK0w2bStoQXkxK1lwbndMOFk0NVVyZTRqQWtq?=
 =?iso-2022-jp?B?YnQ0cWhJQmhrQXgxaGowMDRYaTkyU0xseXQzR1R5MkZteS9LdHFkT0pF?=
 =?iso-2022-jp?B?NHRtTkNZblJETFFSakhRa25KUHdXeVpQbkc4Wk9YcjRjQzQ2d01xVHlX?=
 =?iso-2022-jp?B?bzRDUU9NNXNWTkVvRmFmaWJ5QWNzT1hsNyt2N3ZGNE1tTGlBeEpzeER0?=
 =?iso-2022-jp?B?T0hWdU9DM1BHcTNSd1haSDRKbnMxaDhY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?YTFEZ3A5WFJ6c2lpUlk5OTRhU2I1NzZXOTRUTlRQUHdVV0IxM2V5SnV2?=
 =?iso-2022-jp?B?WkdYSkViOEFjR29MeTY4eG9uZ0MwVkc2WExqRDd6c0hvNjRpVDl5R3pn?=
 =?iso-2022-jp?B?RVA4V2NDeDQzTVFpRGtucHZ0M2ZBL0FUOUQ4NFRQZnVhNUh5czNnZDZp?=
 =?iso-2022-jp?B?aW9TQjUwZUkwc1c4YWQ5b1ZVUUVXZW5jcGxtZ0ljTjF1RGZMc3pzbnN4?=
 =?iso-2022-jp?B?ajJDK2Q1Yk4yYm1wQnBkenY3R3lHM0Jpd2V0TUdGVU5lSTdFSVJlR0gy?=
 =?iso-2022-jp?B?Y3hXU2R4M3QvV0FWZVpzQ010RlZCQTlJYjU0emNsQ0xSL1JtbldKelpF?=
 =?iso-2022-jp?B?VWllYU5EcCtscCs4V0NtY29lY2pPY1UzNFBEOTJYdGFCK25kL2kveG9v?=
 =?iso-2022-jp?B?NlVtTFVKV0ZZdk1Cek1wa2wwR0h3VERtQXhKZnJCaUhXZ2R2d2xxN0Iw?=
 =?iso-2022-jp?B?T0tENGRWRlo5dVhPdGRkK2IrWnFpTnhBNEhGbUNKMytLQ1M0cXRESHI2?=
 =?iso-2022-jp?B?ZFRhS1JoS2svR1pqMlpFNTZxQkFIZHZYaEhwTkdybGtSZWxHbGVhU2Qw?=
 =?iso-2022-jp?B?bmdJSEJmNWp0cFlsZFFsTXB5R2VhTVNCTTk3QUVzNEd2VmJEcFI3M2FB?=
 =?iso-2022-jp?B?NXorY3gwdXpxMlZQSGNvdEVldS9TYTRic3B5L3lueEZLT0oxanVBdng2?=
 =?iso-2022-jp?B?eEU3VGxRSFR1WFoyNkwxa3JHUXNlZ0EyTTJzOUhORUVNWVJNM1dSQjlH?=
 =?iso-2022-jp?B?WXpmWDFRdHlnTzFoS0VFSFBSMTFqekJJOG9tZ2J4eUpNeHBGWjhNZXJF?=
 =?iso-2022-jp?B?dlVrVkdnUlhOT3k2dzJFcEtUSG1wOCt2N3JBZzN4TDB4TzA4QnVjcXNY?=
 =?iso-2022-jp?B?L1gwR1NXUUk1bk1aRDdCSVo3NmZlTklIbjl2VG1aUnZFYjY5UkpyNzVG?=
 =?iso-2022-jp?B?OGlqWUpyL2NhazA5VHAwVW9yN0VOWElRM2Mzejk1NXp3L0E4UGN2dVJo?=
 =?iso-2022-jp?B?WkhGSjJMZWtuSmhEQTJJN0sxcWxvYVJvREFDTDNpSU1sM2VJOTNQZUZ0?=
 =?iso-2022-jp?B?OXpNbjVKVGxaazVHcVR0YWY1ZlJyRy9Va2FTcVpRQ2RaVjhOb2pGZzk5?=
 =?iso-2022-jp?B?dkxpWU9reVNmNnlVNjRUVW5obkhzbkdKdEJCY21XYWNKcmdteXg1S05O?=
 =?iso-2022-jp?B?Uk44Um5SQWpqTmRXYTE2S1JObDhwUHdSa1liQUpyYmFyczRLaTBRdlJC?=
 =?iso-2022-jp?B?clBWRzhlUnI4aWdFUGRBUEQ5cVJsV0RnUWUwRG12VURUbWV2Vk9KNkxB?=
 =?iso-2022-jp?B?Ni9jR0FmSnk2bzU5VzRlZlVjVnNrUDBqa3NFYkl1eTZMdzZKNDZjN2tT?=
 =?iso-2022-jp?B?c0V5ZHR1ZW14cUs0eTg5UEF1UWU1TzJTV1V4YnhTU2dQNGVuYk1STDFO?=
 =?iso-2022-jp?B?dEZWVkVrZHczK1Nhck9YUEEvVURtL1ZhSVZjcm0xVG8rcVhOaGJOL2lj?=
 =?iso-2022-jp?B?ZS9XVnFRSFdJWmtTNFlLZUpSWmE4eFl4N2R1eDQwZEhrbUNjaWJySVo0?=
 =?iso-2022-jp?B?NEpYeVN1OVV6TnJEK004b3JxeG9Od214ODNmWjhqYmhBTkpKMXlKY0dT?=
 =?iso-2022-jp?B?ekxqc1NYemwzUkp6V3JBdG5XYThCaElkY3V0MUI4SlFPa2FWUlRlU0ZQ?=
 =?iso-2022-jp?B?SWNtcGZzV0EwTDlBaWRzcllFeGN6V2ZGTHpMUzAzM0pzNEtTVDJ5UklY?=
 =?iso-2022-jp?B?RDlJSEF6VXM3S250c1FjUzVlOERUVXpaTEZObS9rc1JoY0RIYkVydnpF?=
 =?iso-2022-jp?B?VFZkVUwrSVZoZFlubXhQMHJpejY1LzlIb3BvN3FObXVTUjE5ZUVRaC9o?=
 =?iso-2022-jp?B?b24rVWxXNk9qSzBwY29XNmNkdldkQ3hjeTk3K2IyYzlVdFVKVlgxbS9G?=
 =?iso-2022-jp?B?VGNZTzByOVA4QW5UUTdxMEQ0SnhqT1JHOW00cFJDZUp3a0NjNlZoM2Mr?=
 =?iso-2022-jp?B?YjhxdW9zTjZhd2xDTzFtV2I4dmpiaTF1cGVtdjArSjRjMFNPQkt2UWZK?=
 =?iso-2022-jp?B?NGdZQnVoRFRMa204MWRScUlySnhmTzg5QXgxZ0lsZ0lkVGFSckF0WnJl?=
 =?iso-2022-jp?B?S09WOC80TCtkd3g0M3VZYytwdnppRXpuOTN1aGtEUHVPMWx4aGVDb1lP?=
 =?iso-2022-jp?B?Tndhb01FR0o3dnNacEtYNVBRK0hBY1I0MUdnQkJQZ2VOQy92UTB5aTRo?=
 =?iso-2022-jp?B?bzFwZDVCWGV5Wm40eVF1ZFRjQWltQ201S1UwYjV3cGlVLzNyOVRKRFdB?=
 =?iso-2022-jp?B?ejVJUFdRSTJLR1VkVFdJcjcrSGZNTk1KSHc9PQ==?=
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
	+plW7n9uu2J3GE9VawhuSsg/xsD2nKgeCsu1yys7XCsmvH4haK310NBRIQzGR9l27zEcprf3Klb6Np46HK7ywRgdWfTKDZcH5Ii8o8B4lBo81Wdk6Vf/YobeKysnMCVU3eNV3N2t9zMPnHdovl5ICB1UH/XxpxmMiUg9OWEr/6HNOheEE2lbiCto7s1mv2ApHRLVHH3jkkY3EMqMiJpOrLp31znhgqXRXtS8szdAERxw/mhjQwhMvyRw/gfErC1m1DYdcG/UlWHx7SNuHmL8NwT05gQ2uBB8LPqLnyPYui1bvusvMCPOAu+3Cg26vtYlow8C+2QJjb54kNVPoOzQS9En8GhgSOuoOIWN5VGFoRf5e5r1xPI0SaS8vguEjbFoJGeNJH5i9PKukAK5bqL7rUgztirBZz0PIJwyZHNnolMY48rpQf3DoPjckJ1wAntwiK9oLWD6RXbHyI/lTaL8IBsTMzgSeeHgC+X0bXzGCJ02r1x+cEFsA7Yns9S1ESimBPAPgDwpqKN6nb4BRcbuOzbjRVvf+cVIsDr68NDGaaWvPpjPSWaM6922h03BC1GAiryBtPd9w+DIQ5z8wyQ9p0l9r2+GMb8ss/m6Rggbtl8GAj6Fhsy1jkM8o5DZp++o
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b65516-373d-4495-6786-08ddef6efe91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 07:03:35.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnP9VUhhoKkOJMwggBmjJffkzIfNCgYqR2BxwlTFpZnXdg+XUobVXOLvC0xwr/Ul7zrncu4AYcQ4YgZvD2P1hI0VurEYyltUfeLcYoD+CVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9456

Hello James,

> Probing MPAM is convoluted. MSCs that are integrated with a CPU may only =
be
> accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until the
> system-wide common values for num_partid and num_pmg have been
> discovered.
>=20
> Start with driver probe/remove and mapping the MSC.
>=20
> CC: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Check for status=3Dbroken DT devices.
>  * Moved all the files around.
>  * Made Kconfig symbols depend on EXPERT
> ---
>  arch/arm64/Kconfig              |   1 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   1 +
>  drivers/resctrl/Kconfig         |  11 ++
>  drivers/resctrl/Makefile        |   4 +
>  drivers/resctrl/mpam_devices.c  | 336
> ++++++++++++++++++++++++++++++++
> drivers/resctrl/mpam_internal.h |  62 ++++++
>  7 files changed, 417 insertions(+)
>  create mode 100644 drivers/resctrl/Kconfig  create mode 100644
> drivers/resctrl/Makefile  create mode 100644 drivers/resctrl/mpam_devices=
.c
> create mode 100644 drivers/resctrl/mpam_internal.h
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> e51ccf1da102..ea3c54e04275 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>=20
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ARM64_MPAM_DRIVER
>  	select ACPI_MPAM if ACPI
>  	help
>  	  Memory Partitioning and Monitoring is an optional extension diff
> --git a/drivers/Kconfig b/drivers/Kconfig index 4915a63866b0..3054b50a2f4=
c
> 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>=20
>  source "drivers/cdx/Kconfig"
>=20
> +source "drivers/resctrl/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile index
> b5749cf67044..f41cf4eddeba 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -194,5 +194,6 @@ obj-$(CONFIG_HTE)		+=3D hte/
>  obj-$(CONFIG_DRM_ACCEL)		+=3D accel/
>  obj-$(CONFIG_CDX_BUS)		+=3D cdx/
>  obj-$(CONFIG_DPLL)		+=3D dpll/
> +obj-y				+=3D resctrl/
>=20
>  obj-$(CONFIG_S390)		+=3D s390/
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig new file m=
ode
> 100644 index 000000000000..dff7b87280ab
> --- /dev/null
> +++ b/drivers/resctrl/Kconfig
> @@ -0,0 +1,11 @@
> +# Confusingly, this is everything but the CPU bits of MPAM. CPU here
> +means # CPU resources, not containers or cgroups etc.
> +config ARM64_MPAM_DRIVER
> +	bool "MPAM driver for System IP, e,g. caches and memory controllers"
> +	depends on ARM64_MPAM && EXPERT
> +
> +config ARM64_MPAM_DRIVER_DEBUG
> +	bool "Enable debug messages from the MPAM driver."
> +	depends on ARM64_MPAM_DRIVER
> +	help
> +	  Say yes here to enable debug messages from the MPAM driver.
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile new file=
 mode
> 100644 index 000000000000..92b48fa20108
> --- /dev/null
> +++ b/drivers/resctrl/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_ARM64_MPAM_DRIVER)			+=3D mpam.o
> +mpam-y						+=3D
> mpam_devices.o
> +
> +cflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+=3D -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> new file mode 100644 index 000000000000..a0d9a699a6e7
> --- /dev/null
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +
> +#include "mpam_internal.h"
> +
> +/*
> + * mpam_list_lock protects the SRCU lists when writing. Once the
> + * mpam_enabled key is enabled these lists are read-only,
> + * unless the error interrupt disables the driver.
> + */
> +static DEFINE_MUTEX(mpam_list_lock);
> +static LIST_HEAD(mpam_all_msc);
> +
> +static struct srcu_struct mpam_srcu;
> +
> +/* MPAM isn't available until all the MSC have been probed. */ static
> +u32 mpam_num_msc;
> +
> +static void mpam_discovery_complete(void) {
> +	pr_err("Discovered all MSC\n");
> +}
> +
> +static int mpam_dt_count_msc(void)
> +{
> +	int count =3D 0;
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "arm,mpam-msc") {
> +		if (of_device_is_available(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
> +static int mpam_dt_parse_resource(struct mpam_msc *msc, struct
> device_node *np,
> +				  u32 ris_idx)
> +{
> +	int err =3D 0;
> +	u32 level =3D 0;
> +	unsigned long cache_id;
> +	struct device_node *cache;
> +
> +	do {
> +		if (of_device_is_compatible(np, "arm,mpam-cache")) {
> +			cache =3D of_parse_phandle(np, "arm,mpam-device",
> 0);
> +			if (!cache) {
> +				pr_err("Failed to read phandle\n");
> +				break;
> +			}
> +		} else if (of_device_is_compatible(np->parent, "cache")) {
> +			cache =3D of_node_get(np->parent);
> +		} else {
> +			/* For now, only caches are supported */
> +			cache =3D NULL;
> +			break;
> +		}
> +
> +		err =3D of_property_read_u32(cache, "cache-level", &level);
> +		if (err) {
> +			pr_err("Failed to read cache-level\n");
> +			break;
> +		}
> +
> +		cache_id =3D cache_of_calculate_id(cache);
> +		if (cache_id =3D=3D ~0UL) {
> +			err =3D -ENOENT;
> +			break;
> +		}
> +
> +		err =3D mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE,
> level,
> +				      cache_id);
> +	} while (0);
> +	of_node_put(cache);
> +
> +	return err;
> +}
> +
> +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored)
> +{
> +	int err, num_ris =3D 0;
> +	const u32 *ris_idx_p;
> +	struct device_node *iter, *np;
> +
> +	np =3D msc->pdev->dev.of_node;
> +	for_each_child_of_node(np, iter) {
> +		ris_idx_p =3D of_get_property(iter, "reg", NULL);
> +		if (ris_idx_p) {
> +			num_ris++;
> +			err =3D mpam_dt_parse_resource(msc, iter, *ris_idx_p);
> +			if (err) {
> +				of_node_put(iter);
> +				return err;
> +			}
> +		}
> +	}
> +
> +	if (!num_ris)
> +		mpam_dt_parse_resource(msc, np, 0);
err =3D mpam_dt_parse_resource(msc, np, 0);

Best regards,
Shaopeng TAN

> +	return err;
> +}
> +
> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be
> +accessible
> + * from a (hopefully wider) set of CPUs. The common reason for this is
> +power
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND,
> +the
> + * the corresponding cache may also be powered off. By making accesses
> +from
> + * one of those CPUs, we ensure this isn't the case.
> + */
> +static int update_msc_accessibility(struct mpam_msc *msc) {
> +	struct device_node *parent;
> +	u32 affinity_id;
> +	int err;
> +
> +	if (!acpi_disabled) {
> +		err =3D device_property_read_u32(&msc->pdev->dev,
> "cpu_affinity",
> +					       &affinity_id);
> +		if (err)
> +			cpumask_copy(&msc->accessibility,
> cpu_possible_mask);
> +		else
> +			acpi_pptt_get_cpus_from_container(affinity_id,
> +
> &msc->accessibility);
> +
> +		return 0;
> +	}
> +
> +	/* This depends on the path to of_node */
> +	parent =3D of_get_parent(msc->pdev->dev.of_node);
> +	if (parent =3D=3D of_root) {
> +		cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +		err =3D 0;
> +	} else {
> +		err =3D -EINVAL;
> +		pr_err("Cannot determine accessibility of MSC: %s\n",
> +		       dev_name(&msc->pdev->dev));
> +	}
> +	of_node_put(parent);
> +
> +	return err;
> +}
> +
> +static int fw_num_msc;
> +
> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg) {
> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */ }
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev) {
> +	struct mpam_msc *msc =3D platform_get_drvdata(pdev);
> +
> +	if (!msc)
> +		return;
> +
> +	mutex_lock(&mpam_list_lock);
> +	mpam_num_msc--;
> +	platform_set_drvdata(pdev, NULL);
> +	list_del_rcu(&msc->glbl_list);
> +	synchronize_srcu(&mpam_srcu);
> +	devm_kfree(&pdev->dev, msc);
> +	mutex_unlock(&mpam_list_lock);
> +}
> +
> +static int mpam_msc_drv_probe(struct platform_device *pdev) {
> +	int err;
> +	struct mpam_msc *msc;
> +	struct resource *msc_res;
> +	void *plat_data =3D pdev->dev.platform_data;
> +
> +	mutex_lock(&mpam_list_lock);
> +	do {
> +		msc =3D devm_kzalloc(&pdev->dev, sizeof(*msc),
> GFP_KERNEL);
> +		if (!msc) {
> +			err =3D -ENOMEM;
> +			break;
> +		}
> +
> +		mutex_init(&msc->probe_lock);
> +		mutex_init(&msc->part_sel_lock);
> +		mutex_init(&msc->outer_mon_sel_lock);
> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +		msc->id =3D mpam_num_msc++;
> +		msc->pdev =3D pdev;
> +		INIT_LIST_HEAD_RCU(&msc->glbl_list);
> +		INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +		err =3D update_msc_accessibility(msc);
> +		if (err)
> +			break;
> +		if (cpumask_empty(&msc->accessibility)) {
> +			pr_err_once("msc:%u is not accessible from any
> CPU!",
> +				    msc->id);
> +			err =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
> +					     &msc->pcc_subspace_id))
> +			msc->iface =3D MPAM_IFACE_MMIO;
> +		else
> +			msc->iface =3D MPAM_IFACE_PCC;
> +
> +		if (msc->iface =3D=3D MPAM_IFACE_MMIO) {
> +			void __iomem *io;
> +
> +			io =3D devm_platform_get_and_ioremap_resource(pdev,
> 0,
> +
> &msc_res);
> +			if (IS_ERR(io)) {
> +				pr_err("Failed to map MSC base address\n");
> +				err =3D PTR_ERR(io);
> +				break;
> +			}
> +			msc->mapped_hwpage_sz =3D msc_res->end -
> msc_res->start;
> +			msc->mapped_hwpage =3D io;
> +		} else if (msc->iface =3D=3D MPAM_IFACE_PCC) {
> +			msc->pcc_cl.dev =3D &pdev->dev;
> +			msc->pcc_cl.rx_callback =3D mpam_pcc_rx_callback;
> +			msc->pcc_cl.tx_block =3D false;
> +			msc->pcc_cl.tx_tout =3D 1000; /* 1s */
> +			msc->pcc_cl.knows_txdone =3D false;
> +
> +			msc->pcc_chan =3D
> pcc_mbox_request_channel(&msc->pcc_cl,
> +
> msc->pcc_subspace_id);
> +			if (IS_ERR(msc->pcc_chan)) {
> +				pr_err("Failed to request MSC PCC
> channel\n");
> +				err =3D PTR_ERR(msc->pcc_chan);
> +				break;
> +			}
> +		}
> +
> +		list_add_rcu(&msc->glbl_list, &mpam_all_msc);
> +		platform_set_drvdata(pdev, msc);
> +	} while (0);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (!err) {
> +		/* Create RIS entries described by firmware */
> +		if (!acpi_disabled)
> +			err =3D acpi_mpam_parse_resources(msc, plat_data);
> +		else
> +			err =3D mpam_dt_parse_resources(msc, plat_data);
> +	}
> +
> +	if (!err && fw_num_msc =3D=3D mpam_num_msc)
> +		mpam_discovery_complete();
> +
> +	if (err && msc)
> +		mpam_msc_drv_remove(pdev);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id mpam_of_match[] =3D {
> +	{ .compatible =3D "arm,mpam-msc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpam_of_match);
> +
> +static struct platform_driver mpam_msc_driver =3D {
> +	.driver =3D {
> +		.name =3D "mpam_msc",
> +		.of_match_table =3D of_match_ptr(mpam_of_match),
> +	},
> +	.probe =3D mpam_msc_drv_probe,
> +	.remove =3D mpam_msc_drv_remove,
> +};
> +
> +/*
> + * MSC that are hidden under caches are not created as platform devices
> + * as there is no cache driver. Caches are also special-cased in
> + * update_msc_accessibility().
> + */
> +static void mpam_dt_create_foundling_msc(void)
> +{
> +	int err;
> +	struct device_node *cache;
> +
> +	for_each_compatible_node(cache, NULL, "cache") {
> +		err =3D of_platform_populate(cache, mpam_of_match, NULL,
> NULL);
> +		if (err)
> +			pr_err("Failed to create MSC devices under
> caches\n");
> +	}
> +}
> +
> +static int __init mpam_msc_driver_init(void) {
> +	if (!system_supports_mpam())
> +		return -EOPNOTSUPP;
> +
> +	init_srcu_struct(&mpam_srcu);
> +
> +	if (!acpi_disabled)
> +		fw_num_msc =3D acpi_mpam_count_msc();
> +	else
> +		fw_num_msc =3D mpam_dt_count_msc();
> +
> +	if (fw_num_msc <=3D 0) {
> +		pr_err("No MSC devices found in firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	if (acpi_disabled)
> +		mpam_dt_create_foundling_msc();
> +
> +	return platform_driver_register(&mpam_msc_driver);
> +}
> +subsys_initcall(mpam_msc_driver_init);
> diff --git a/drivers/resctrl/mpam_internal.h
> b/drivers/resctrl/mpam_internal.h new file mode 100644 index
> 000000000000..07e0f240eaca
> --- /dev/null
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2024 Arm Ltd.
> +
> +#ifndef MPAM_INTERNAL_H
> +#define MPAM_INTERNAL_H
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cpumask.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/resctrl.h>
> +#include <linux/sizes.h>
> +
> +struct mpam_msc {
> +	/* member of mpam_all_msc */
> +	struct list_head        glbl_list;
> +
> +	int			id;
> +	struct platform_device *pdev;
> +
> +	/* Not modified after mpam_is_enabled() becomes true */
> +	enum mpam_msc_iface	iface;
> +	u32			pcc_subspace_id;
> +	struct mbox_client	pcc_cl;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	u32			nrdy_usec;
> +	cpumask_t		accessibility;
> +
> +	/*
> +	 * probe_lock is only take during discovery. After discovery these
> +	 * properties become read-only and the lists are protected by SRCU.
> +	 */
> +	struct mutex		probe_lock;
> +	unsigned long		ris_idxs[128 / BITS_PER_LONG];
> +	u32			ris_max;
> +
> +	/* mpam_msc_ris of this component */
> +	struct list_head	ris;
> +
> +	/*
> +	 * part_sel_lock protects access to the MSC hardware registers that
> are
> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that
> vary
> +	 * by RIS).
> +	 * If needed, take msc->lock first.
> +	 */
> +	struct mutex		part_sel_lock;
> +
> +	/*
> +	 * mon_sel_lock protects access to the MSC hardware registers that
> are
> +	 * affeted by MPAMCFG_MON_SEL.
> +	 * If needed, take msc->lock first.
> +	 */
> +	struct mutex		outer_mon_sel_lock;
> +	raw_spinlock_t		inner_mon_sel_lock;
> +	unsigned long		inner_mon_sel_flags;
> +
> +	void __iomem		*mapped_hwpage;
> +	size_t			mapped_hwpage_sz;
> +};
> +
> +#endif /* MPAM_INTERNAL_H */
> --
> 2.20.1


