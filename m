Return-Path: <linux-acpi+bounces-16517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA179B4A2AD
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C004E6BE4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D13304BB5;
	Tue,  9 Sep 2025 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Nt808kn2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AB3043D9;
	Tue,  9 Sep 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400973; cv=fail; b=Qbif35jLW9vp7TFyfmkmusUtI9gcI0QVKCBbD0m6Zl+pg6WPXYqfjpnWMTGIWOkAL3IV4Ar1XdyaiDJ2bZT2sZBGrQw6rlbEtbdo3eAnfkkmQyPMRS78e+wkpYXWaFAHpnxHGrE68HWn2QwL8QWljP+QmsAg+xTXGEZCDI9Hw8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400973; c=relaxed/simple;
	bh=+tv+0GBp+JzKlGbhh9KWn310XPZzZuaCH+Cv0Yqv1+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qRcB2ClalclVx9RfU3Bz+yf64RxyZ0mSG5G6uXqegWN2M3bKJmXW/Ld9tWL7DM/o32HJr61AWMafyBYqBNx5rhOx9m/Y7ulwlz7BBexTxPfKZKUf+f7sOvPBWFHWe0p1cVbWIyUog7sUvxsN8Q0KxD8F0tYBfo789vLdBqNbk9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Nt808kn2; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757400970; x=1788936970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+tv+0GBp+JzKlGbhh9KWn310XPZzZuaCH+Cv0Yqv1+8=;
  b=Nt808kn2YcURQ/37uMi2TUFof4P0BG4x57UPB8TAPKvh71wfXv9L3pr+
   xZtggoVFw5ACGvaU9Mwzy219Il/V7lv8FsSzpZ7GkpvgWR1zasJKZEDg/
   qz3dFULUjVlm9f09/2nnvGeXFI76tzp0lnafle2vHSZ6M4CqW2FPbsjCs
   6c+Zfn9pMQQluEJn+nVsSnQXX1XUO2FuwI0wD5q7OA6bj6rY8tnvyTqqo
   Cnar6NWpOwCB4b2ftHz/1YQchZZT3sljeP14lk1K3xf0RSjLasZ7wtqtc
   b0ggWeWvg8KJ6fvsENBZsV60jzw4VqJS2ipLhHyduRSYq7wd9jY4xmgLl
   g==;
X-CSE-ConnectionGUID: T0vLY6T9R7iaeUIYW1cWLg==
X-CSE-MsgGUID: fiyKlmL9QTOyPBJHzSWCvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="78519305"
X-IronPort-AV: E=Sophos;i="6.18,250,1751209200"; 
   d="scan'208";a="78519305"
Received: from mail-japaneastazon11011046.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.46])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 15:54:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX0GaJ9GzrzlOZYMcD06MaMi7E4FUhdgoFNCNPm2UsDjrTpRabWX0OKwrTUtCS0uG7iNgoXuf05YMRNUjcjb9KTMLGtAimYM7qL+JtwNPBj+FMP/tO0E1ZvYSugP9qQfRQcNLOrPT4eV/dBKDBwSS+ZxjHIRbcLfqlNPZ3GK8orTBoI92jBmiUS36a4uWQ6Xex24KpvNfWItz2/UQPa6pYgVv4xf0n6zSGKsjvXXcWvTyC0VwBmsKMiMn2TUf0O8X0OEL4g2HzqqS5pS1TnfICmbQyYTkog7D2I/6s6a41M5HK/C5HqYSeMpf6drV60LyGCfExsV3E8M9mvWfW3v/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZrBs9RtCzcGaPHL03U3xkHy0i2nN2XJBRmhHzjjJDo=;
 b=UMpb1V3S09LhzovrnyCldnnCE4wdP0+bZTxiiTk8oM7V2on6SijvIykHHqeJ04I5a6J5UDZIjHYG0APcnotl9yoINum3F972PyZntU9rPa3V3dJ5UbIBJJGdD8Z76hbnFlUe5VJ/ZEbbhC11scQ6TNzWfHvDhHUghMvJTHOMzkDz/n3BVON+QOSYb6YnywMfRposfNeMVxwxR2sbXXqUTaSqzDaxCeOvIG7hbjbOVYj5RlSv5DviukRaju8L6++OfO1Pqp8cp1Tcs3Lpe4TIJxc2FPmLnu31ixhaaLJ2wDCppfoKipIdrN/wDYxAdi390tSEQa9pcmUTVWD+W/msJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSCPR01MB14386.jpnprd01.prod.outlook.com (2603:1096:604:3a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:54:46 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:54:45 +0000
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
Subject: RE: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
Thread-Topic: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
Thread-Index: AQHcE3pghisqR0KTUkOuh2WgP5xZ4rSKhCvA
Date: Tue, 9 Sep 2025 06:54:45 +0000
Message-ID:
 <OSZPR01MB8798DAAAD9424C2C8706A8088B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-43-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-43-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=0817251b-b75d-4349-9fc7-a9ac86a4f977;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-09T06:47:08Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSCPR01MB14386:EE_
x-ms-office365-filtering-correlation-id: 4f842060-f515-472f-2a5b-08ddef6dc2fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OHJORnVYL0dzUk8wdDFkUFVEVEl1U2JCVUZ5MUhxWVFPbjZMRDROd294?=
 =?iso-2022-jp?B?Q2ZFbTBEUTlNRFRsME9UdVFtanZuRXFyS014R2FNVVJVYkQyN0pZVzlq?=
 =?iso-2022-jp?B?SVIzOURPNis3d2U5VUczaGRKQU5KRkQ1aDhkdmJZd3BGZ3p6akp4aW83?=
 =?iso-2022-jp?B?ZlQ3alR4a0lvenNhOWhVdVZPdU5qd3JZZVR6cVFnRzdKYlAxOXZreHQ5?=
 =?iso-2022-jp?B?ekpPUGZpQzZlTlJsck9EY0dTMXU0L3hPK2tGa3VmZ0QvaUIvdUJ5aVds?=
 =?iso-2022-jp?B?M2p6SzZrK2JYditab1dlV2xlWHdEWmlZd2JvUFRZczlLa1FFUHQ4d0l2?=
 =?iso-2022-jp?B?K1M0aHBQWHJodHlGcUF5YjlENDdTczErTm1DaXhUdXcyR09OSHN3UVpN?=
 =?iso-2022-jp?B?TWwwbXFjUHZrMjF4eGQ2czV4SzBjekNrVlNhTGNWOGVqZ1hQeFVoMnA2?=
 =?iso-2022-jp?B?VlZVOTRaV2ZCOWZheFcvTjFld29zWFpnWlRaNVhsRjIySVQ0WHNGWUlt?=
 =?iso-2022-jp?B?a1Y4U3VtT0duWXBhS1BUQ2t1b0pZMUlKY2N4amp6TmQrWGlINjZkT2Q5?=
 =?iso-2022-jp?B?d1dKMVloM2UvSUFOS0wzOGpXRDdaTUErUmRtRS9xMk9Ed3dMQmYzN3B4?=
 =?iso-2022-jp?B?cUFIYkZTSmlpT2tKcjQxWG1mTlh4cFJ6QVprQmVmdTExUFFwK2ZxQkVq?=
 =?iso-2022-jp?B?NGcrbm1GOXlLNHVCTWN3MXVRSGZBRW5TYnhNZUpqTDNMSTRSbERnbGN5?=
 =?iso-2022-jp?B?aUxWMlFoQ0d3bXdUekF3Mmd2MzZrbEZZNDA0NUlnaVJPWVpoZEhmOTlC?=
 =?iso-2022-jp?B?dFVFODFwazUxQWxNbExzaWtKY0RENTVIZjFDSFZXcUhlSzBwV1JkOW1l?=
 =?iso-2022-jp?B?M2JVVm53NlgwbnB0Tm1jS09QbVJsUDQvbVZoOWs4djY3V1JjRU54cXZj?=
 =?iso-2022-jp?B?dW5RR2RtWVRsbEMvNHhqeEwzSEQ0MmF1NGlxL0lENVpIYU5WWU9WVkho?=
 =?iso-2022-jp?B?RkJabWszdk53by9teFFsZTZYclVIUEw1NU9BWkZLZTdXU3EyTjVZakRN?=
 =?iso-2022-jp?B?NkN4UFhlR3gxYXpUd0ZibWliOE9KRVVQZ2JFSElDWEN3K0ltOU82SjVL?=
 =?iso-2022-jp?B?alI5SmRqbnF4Z3hsZldZREhLbGlZTG0zWnJDcERLMzZBQjNvVGJMZW5u?=
 =?iso-2022-jp?B?RDI0VTVIK1kxRy92OW16NCtlc0hLWjI2NjljUHY0RGZOT1ZWRXhjWWlF?=
 =?iso-2022-jp?B?QTV6bktxaVEvVXU3QmdTMkQvMTlaTDZWdFZqd1JmUlhvNFNQZVJzVkRN?=
 =?iso-2022-jp?B?bUJEREp2VHF5S3JBOXNlSzFqYTc1eXJ5NHNJYi9QeTE2MjRmU25Bb2tz?=
 =?iso-2022-jp?B?dDA0ZktGM3VINmhlenVaRnNkaWpWMU4rTFFUWDRPUENKNzcrSTB5Y1RZ?=
 =?iso-2022-jp?B?emplcDVxdHBubjdoVEU3TUFXTWJ1eC9jdWcweXNlRmZuMCtpSk0xa2sz?=
 =?iso-2022-jp?B?eVJEM0U2bzIxSjVmRnVCZDYrM0xjd0E5Kzd1Z0czOU9NVnNHeWtwY0E2?=
 =?iso-2022-jp?B?Q0JqdW1sN2l6elNIRXcraTEvdEYxemt1RmNCTFdOOHlmSHdJLzA1T0Vx?=
 =?iso-2022-jp?B?aDAxbkdKQ1Y2eGJkWGsrSXV0TS9GT1pheWU3bXo4YnErZ2pGZ1FDQy91?=
 =?iso-2022-jp?B?by9hK3B3Sjh1WEcyOG9BeUFucUhUdVhJRll2dVQ3aVYrVDFtaWpyQnp4?=
 =?iso-2022-jp?B?aTh6VzEzbGxEbTYvYjZiY1A4eTh0anNNTC9xVC9RUkV1WnRuV3F4MnJZ?=
 =?iso-2022-jp?B?TFhJVTIwSkh5bkgxdXg0U3RZMlNWSUpZS29PM0pjempZZnBsd28zdDZ6?=
 =?iso-2022-jp?B?elFxZ2g1NHlEcHVxOSszZENzbzh2Y1lYQlVmL1ZkTXo5aVJkMDk1ek5T?=
 =?iso-2022-jp?B?cEVZMlJYTERCc0lTdkVZcDhYWlBCTjJHa1ZQd3ZFbnpQM25NNjM4bWtj?=
 =?iso-2022-jp?B?amxGV3VmL2ZwVWQxalNubnJkMFNGaUtFUmE0YWVzUVcwWXcrUDUxUXV0?=
 =?iso-2022-jp?B?SlUrZXo4MTY1a0pRRW9zSkNnaEY4T0JMdXBINmFicU9IOE5zVWhBbG95?=
 =?iso-2022-jp?B?VmdHZnhpbFd5dW9yeWtxL09tSDNIUk83TkpQbmg3dWN3bE5uYlNZOWQx?=
 =?iso-2022-jp?B?aWJkUkVzU1EzTzRET0RLZzluL0hSWFlJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?OFVNU1czYzBLQlFvUGpGZXBqM21sanV6cFNVemp5SDYrU3JJeC8vcWVR?=
 =?iso-2022-jp?B?REFIdHhHb29wV2RtNWdUbC9nN2g0MitIWGRDNEM0WG1oNUt2b3cva3Q1?=
 =?iso-2022-jp?B?RkYyMzFveHppYVArTXpmdnhtcTdFSjNSRlNIbjBWeFc1VmVVdFEzRlN1?=
 =?iso-2022-jp?B?WExOQWQ2MWNWRDJZZWRJNVhlUk1nUnNpODhJa0FBdTRoY3VMZlQrVXFV?=
 =?iso-2022-jp?B?SWw5aUZGWTVHQm0rblVOYllmQWF3djdtY09ZcEZLN2V2VWdoem4rQ1Zs?=
 =?iso-2022-jp?B?Tnd6dmo5eGR4ZndUVWRCODBLUER2d1E0cFEvUzhjbWtVL3RCY3ZaM2tD?=
 =?iso-2022-jp?B?UkVMaUNGMXFWcmxHSDR5aVVWb1cxUnU2dnBBK3c4RkdQek0xRmR5Snk4?=
 =?iso-2022-jp?B?ZEFJb2JvWlV6UUQ0U28vUU9WTFpWVzZSdjlGRmRxYlRRQlc2TVBQV2tr?=
 =?iso-2022-jp?B?bTl3REJGMzVDZTFLajhhUVpZWnRKN2s3TGw3NHhLMEk5RVFkWGtKWXJy?=
 =?iso-2022-jp?B?OTVZS2EvK2tnNWZYblZBM212enpTdjJhZXhDbXpieXQ3aHBJSXorTDJz?=
 =?iso-2022-jp?B?bW5WNDMxbFFnOU5qaHROd0pueFhoTUhTdHNTT255aUlWWmRjRTFxdnpW?=
 =?iso-2022-jp?B?U2dmWEFuUFNHMDI5U0RMbWx6NDNMc0Qxa0lXTnk0aS9SM0pGclNnand0?=
 =?iso-2022-jp?B?Y09hZzZSSFdsamJWUzJOb1IxZ0tkVUU1Y2NjL0NPekJmRmNSSmM3TFJO?=
 =?iso-2022-jp?B?UDZLeXlQWDdHYVBpUzJnc1lEYmp1VXFiNWdrcXplaThmY2lRb2l3cXFr?=
 =?iso-2022-jp?B?TU5XbUN3QUhEOTRCZHNDQjVLS3BFcVB6TGVncEVqSjZlT0svRm1BQW5t?=
 =?iso-2022-jp?B?R0ZyNW9HNE8zU0tOSGczZG1Mb1B5anFWMUtOZjcrMU1DQ0xZRjkxYnZN?=
 =?iso-2022-jp?B?ZlNiT2Q0cjZKL0dRaS9aY1h2LzNzdWVxZUkwbkZsRmNUU0g3UGt0UkJS?=
 =?iso-2022-jp?B?VkVmV2tOMnpMeFNqbmxUUHVpMGlEV1c0bi9ya3FLcVpWOHdpRVRPV25K?=
 =?iso-2022-jp?B?R1huSXl1T2NiQTFVWlBhMytyVWJ4Wjlub3F0Q3VUTGJ6ZzArWm45TGJi?=
 =?iso-2022-jp?B?elhwQlpoUHdlVXFFYUl6OWVwa2ZPSmF3aVhIamhRbkNGTmlYMGEzLzNX?=
 =?iso-2022-jp?B?TVBPNGZVdHI5WEZNQ3lsTXZsdG94YXo2Z1V5ZjRsUTFUTUtDMnRoN2pT?=
 =?iso-2022-jp?B?dktnc0pFU1VmYmpiYVkxVVVEczBvK0wyQVJxMCs3cFk2RnBpWFJ6ZThW?=
 =?iso-2022-jp?B?ZHFOOHgvSTRRRElRVGlUT29xUVV0UWFSWW5sUWtkMXM4T3NibzBlL0Vo?=
 =?iso-2022-jp?B?QlpEYkU3OFlobER4bTIrV29GVzR2RktsdFdYNHNUTkozZHRtV2pwNW9u?=
 =?iso-2022-jp?B?V203TEsrT1VabmhmRmhmY2N0NjBZTmUrcEZ3ZEFxNmladm91VHNwNlk2?=
 =?iso-2022-jp?B?M280VkVYOFhXcVRFc2h1TzFwT01VelZ0bHQ4ZU1VbUdtNjNYY2wrWGlq?=
 =?iso-2022-jp?B?RTR6bm5oUmF5b2dRTTlEY1YvSkhYTFZhOGFvREFWaWNDT0VKaUxJV1Bu?=
 =?iso-2022-jp?B?SEsvT2EyVFNNUHRnZk5BTFhXaE03d0xVM3g4NXJWZVhwNUx2dlJaTG13?=
 =?iso-2022-jp?B?cnk2d2k0d1lOT3hSeWRuekVPcDNteTJhd1QzKzI4UUpPRGZvaUQyWnlh?=
 =?iso-2022-jp?B?cWJsQ3FHOERidUF6ZGpLMVVqUHc1L2FqUldMblVWYzBma3JaZG1UcWYw?=
 =?iso-2022-jp?B?TEJyQVB4QTkzcnhJUXgrQnkxTzE0eXl3VDVHK21qN3ZwS2xPSnMrTGpr?=
 =?iso-2022-jp?B?MkEzRDFnaGdRSFcxeHVxbHZvYXFMaHU1MC9vclBsbGZoOVpkQStsSXg1?=
 =?iso-2022-jp?B?WklzVXJjZ2FCbU9DQ0lHU1ZQTEZvb2VBZy9Kc0VBd2tZYnA0Rjd6aXJj?=
 =?iso-2022-jp?B?UlN4KzlQQzdSUi8vTVQxcmErNjZqUUlwQWNaYmVkVmdyZTI1RHZDNEs0?=
 =?iso-2022-jp?B?dXltQlN2RXdJWFdFc3UrTHEzYldTczVWTlgvMUZaWXdYK0ZJMEkvZERx?=
 =?iso-2022-jp?B?eWpkTno5MTVKaThxaGxZWERKbUQwVHpXeDJjM2RZV015WkhIb2hkeGFI?=
 =?iso-2022-jp?B?MmxCOEtlTHJvbEpyMWs2WnZkbGF3bW5rOEFNZTh0UElnVUJ3YlZKbEcy?=
 =?iso-2022-jp?B?V1Vkc2htUE5WbGhpdVFBalltbXE2VStCWTY2ZVQ3WitXdTZvY2svV3Ns?=
 =?iso-2022-jp?B?bGc5a2R1Tjh0K1pCM2JBRmdSWko3eHpMQnc9PQ==?=
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
	K1D6qjxIeILKJte/CLzBFoncA7zW8tLf948NIg4Xq2SAy2m0s3JhfGhNd816mKS26iok2+FEf9leh8xEaKr7WoVzr0hFiVrrlD21gtpAjSWmbTYcQyuArMiwFnVmUDL4lQy5CJgm3kxfCZD4F0OXKb21a5PnOXvc+wQj6W0diKazi6eavChc26r9Eun64rp5dpsF06ydd/6aunTaQgH0WzrXq0J6DiU7gZLBgXwAnz782fGDhtZ4y20IMopy968B65TJ8zSB0iTD/Q5BBMB1BfSAUVjUJoTvRcldr6LaGuMjgALG8UAp2tN0uJtEsbzIPLPgE9FiDxDfNQgW0GQE5ZRYQ019mqYecxfhwmRRfA0UX2Rk8PkXebMzyEpRcIQlEwRCHWP5qmct087hhd7J4FEL64PO+K3YkbUDBTCWdvt53zi5FxHrcUw3vvyFh16CsOgtHXySjN0+jxlsoG14A7AXTuieHyJxuYy34Iw4Imhricr+oy3GcDw3iNiJ5jWd+mqRKXskSj5d9mA+H/XcivbxZI1RIHvKpzX6OjTCstJoIIra4cVvDSa4tcJegdkm7cFLpq8pW2E/6AZ3MR/9IVCRRvvCLbAXi+m/52mfoimYNwbYtU60NxFu9YUMy7YI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f842060-f515-472f-2a5b-08ddef6dc2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 06:54:45.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tun9OKfByGL4wrpzgJLGqlMpEEmVo/Wb/GC9WHrUqEXKRNm1PAWsMnnJMx3Ch7+fgml5g/kr50pJW7SHTtw97UwjrjWmlnTHv3tFgL4XCJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14386

Hello James,

> Add code to parse the arm64 specific MPAM table, looking up the cache lev=
el
> from the PPTT and feeding the end result into the MPAM driver.
>=20
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=3Den
> Signed-off-by: James Morse <james.morse@arm.com>
>=20
> ---
> Changes since RFC:
>  * Used DEFINE_RES_IRQ_NAMED() and friends macros.
>  * Additional error handling.
>  * Check for zero sized MSC.
>  * Allow table revisions greater than 1. (no spec for revision 0!)
>  * Use cleanup helpers to retrive ACPI tables, which allows some function=
s
>    to be folded together.
> ---
>  arch/arm64/Kconfig          |   1 +
>  drivers/acpi/arm64/Kconfig  |   3 +
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/mpam.c   | 331
> ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c       |   2 +-
>  include/linux/arm_mpam.h    |  46 +++++
>  6 files changed, 383 insertions(+), 1 deletion(-)  create mode 100644
> drivers/acpi/arm64/mpam.c  create mode 100644
> include/linux/arm_mpam.h
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> 658e47fc0c5a..e51ccf1da102 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>=20
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ACPI_MPAM if ACPI
>  	help
>  	  Memory Partitioning and Monitoring is an optional extension
>  	  that allows the CPUs to mark load and store transactions with diff
> --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig index
> b3ed6212244c..f2fd79f22e7d 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,6 @@ config ACPI_AGDI
>=20
>  config ACPI_APMT
>  	bool
> +
> +config ACPI_MPAM
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile in=
dex
> 05ecde9eaabe..9390b57cb564 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+=3D apmt.o
>  obj-$(CONFIG_ACPI_FFH)		+=3D ffh.o
>  obj-$(CONFIG_ACPI_GTDT) 	+=3D gtdt.o
>  obj-$(CONFIG_ACPI_IORT) 	+=3D iort.o
> +obj-$(CONFIG_ACPI_MPAM) 	+=3D mpam.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE) +=3D cpuidle.o
>  obj-$(CONFIG_ARM_AMBA)		+=3D amba.o
>  obj-y				+=3D dma.o init.o
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c new
> file mode 100644 index 000000000000..e55fc2729ac5
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +/* Parse the MPAM ACPI table feeding the discovered nodes into the
> +driver */
> +
> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/bits.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +/*
> + * Flags for acpi_table_mpam_msc.*_interrupt_flags.
> + * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IRQ_MODE_MASK                    BIT(0)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK
> GENMASK(2, 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER
> BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
> +
> +static bool frob_irq(struct platform_device *pdev, int intid, u32 flags,
> +		     int *irq, u32 processor_container_uid) {
> +	int sense;
> +
> +	if (!intid)
> +		return false;
> +
> +	if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=3D
> +	    ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
> +		return false;
> +
> +	sense =3D FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);
> +
> +	/*
> +	 * If the GSI is in the GIC's PPI range, try and create a partitioned
> +	 * percpu interrupt.
> +	 */
> +	if (16 <=3D intid && intid < 32 && processor_container_uid !=3D ~0) {
> +		pr_err_once("Partitioned interrupts not supported\n");
> +		return false;
> +	}
> +
> +	*irq =3D acpi_register_gsi(&pdev->dev, intid, sense,
> ACPI_ACTIVE_HIGH);
> +	if (*irq <=3D 0) {
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
> +			    intid);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx) {
> +	u32 flags, aff;
> +	int irq;
> +
> +	flags =3D tbl_msc->overflow_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags &
> ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff =3D tbl_msc->overflow_interrupt_affinity;
> +	else
> +		aff =3D ~0;
> +	if (frob_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] =3D DEFINE_RES_IRQ_NAMED(irq,
> "overflow");
> +
> +	flags =3D tbl_msc->error_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags &
> ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff =3D tbl_msc->error_interrupt_affinity;
> +	else
> +		aff =3D ~0;
> +	if (frob_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] =3D DEFINE_RES_IRQ_NAMED(irq, "error"); }
> +
> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res) {
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id =3D res->locator.cache_locator.cache_reference;
> +		level =3D find_acpi_cache_level_from_id(cache_id);
> +		if (level <=3D 0) {
> +			pr_err_once("Bad level (%u) for cache with id %u\n",
> level, cache_id);
> +			return -EINVAL;
> +		}
> +		return mpam_ris_create(msc, res->ris_index,
> MPAM_CLASS_CACHE,
> +				       level, cache_id);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
> +		nid =3D
> pxm_to_node(res->locator.memory_locator.proximity_domain);
> +		if (nid =3D=3D NUMA_NO_NODE)
> +			nid =3D 0;
> +		return mpam_ris_create(msc, res->ris_index,
> MPAM_CLASS_MEMORY,
> +				       255, nid);
> +	default:
> +		/* These get discovered later and treated as unknown */
> +		return 0;
> +	}
> +}
> +
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc) {
> +	int i, err;
> +	struct acpi_mpam_resource_node *resources;
> +
> +	resources =3D (struct acpi_mpam_resource_node *)(tbl_msc + 1);
> +	for (i =3D 0; i < tbl_msc->num_resource_nodes; i++) {
> +		err =3D acpi_mpam_parse_resource(msc, &resources[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node
> *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	bool acpi_id_valid =3D false;
> +	struct acpi_device *buddy;
> +	char hid[16], uid[16];
> +	int err;
> +
> +	memset(&hid, 0, sizeof(hid));
> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
> +	       sizeof(tbl_msc->hardware_id_linked_device));
> +
> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
> +		*acpi_id =3D tbl_msc->instance_id_linked_device;
> +		acpi_id_valid =3D true;
> +	}
> +
> +	err =3D snprintf(uid, sizeof(uid), "%u",
> +		       tbl_msc->instance_id_linked_device);
> +	if (err >=3D sizeof(uid))
> +		return acpi_id_valid;
> +
> +	buddy =3D acpi_dev_get_first_match_dev(hid, uid, -1);
> +	if (buddy)
> +		device_link_add(&pdev->dev, &buddy->dev,
> DL_FLAG_STATELESS);
> +
> +	return acpi_id_valid;
> +}
> +
> +static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
> +				 enum mpam_msc_iface *iface)
> +{
> +	switch (tbl_msc->interface_type) {
> +	case 0:
> +		*iface =3D MPAM_IFACE_MMIO;
> +		return 0;
> +	case 0xa:
> +		*iface =3D MPAM_IFACE_PCC;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int __init acpi_mpam_parse(void) {
> +        struct acpi_table_header *table __free(acpi_table) =3D
> acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset =3D (char *)(table + 1);
> +	struct property_entry props[4]; /* needs a sentinel */
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int next_res, next_prop, err =3D 0;
> +	struct acpi_device *companion;
> +	struct platform_device *pdev;
> +	enum mpam_msc_iface iface;
> +	struct resource res[3];
> +	char uid[16];
> +	u32 acpi_id;
> +
> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
> +		return 0;
> +
> +	if (IS_ERR(table))
> +		return 0;
This is redundant, it's the same as the previous line.

Best regards,
Shaopeng TAN
> +	if (table->revision < 1)
> +		return 0;
> +
> +	table_end =3D (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		tbl_msc =3D (struct acpi_mpam_msc_node *)table_offset;
> +		table_offset +=3D tbl_msc->length;
> +
> +		/*
> +		 * If any of the reserved fields are set, make no attempt to
> +		 * parse the msc structure. This will prevent the driver from
> +		 * probing all the MSC, meaning it can't discover the system
> +		 * wide supported partid and pmg ranges. This avoids
> whatever
> +		 * this MSC is truncating the partids and creating a screaming
> +		 * error interrupt.
> +		 */
> +		if (tbl_msc->reserved || tbl_msc->reserved1 ||
> tbl_msc->reserved2)
> +			continue;
> +
> +		if (!tbl_msc->mmio_size)
> +			continue;
> +
> +		if (decode_interface_type(tbl_msc, &iface))
> +			continue;
> +
> +		next_res =3D 0;
> +		next_prop =3D 0;
> +		memset(res, 0, sizeof(res));
> +		memset(props, 0, sizeof(props));
> +
> +		pdev =3D platform_device_alloc("mpam_msc",
> tbl_msc->identifier);
> +		if (!pdev) {
> +			err =3D -ENOMEM;
> +			break;
> +		}
> +
> +		if (tbl_msc->length < sizeof(*tbl_msc)) {
> +			err =3D -EINVAL;
> +			break;
> +		}
> +
> +		/* Some power management is described in the namespace:
> */
> +		err =3D snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
> +		if (err > 0 && err < sizeof(uid)) {
> +			companion =3D
> acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
> +			if (companion)
> +				ACPI_COMPANION_SET(&pdev->dev,
> companion);
> +		}
> +
> +		if (iface =3D=3D MPAM_IFACE_MMIO) {
> +			res[next_res++] =3D
> DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
> +
> tbl_msc->mmio_size,
> +
> "MPAM:MSC");
> +		} else if (iface =3D=3D MPAM_IFACE_PCC) {
> +			props[next_prop++] =3D
> PROPERTY_ENTRY_U32("pcc-channel",
> +
> 	tbl_msc->base_address);
> +			next_prop++;
> +		}
> +
> +		acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
> +		err =3D platform_device_add_resources(pdev, res, next_res);
> +		if (err)
> +			break;
> +
> +		props[next_prop++] =3D
> PROPERTY_ENTRY_U32("arm,not-ready-us",
> +
> 	tbl_msc->max_nrdy_usec);
> +
> +		/*
> +		 * The MSC's CPU affinity is described via its linked power
> +		 * management device, but only if it points at a Processor or
> +		 * Processor Container.
> +		 */
> +		if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id)) {
> +			props[next_prop++] =3D
> PROPERTY_ENTRY_U32("cpu_affinity",
> +								acpi_id);
> +		}
> +
> +		err =3D device_create_managed_software_node(&pdev->dev,
> props,
> +							  NULL);
> +		if (err)
> +			break;
> +
> +		/* Come back later if you want the RIS too */
> +		err =3D platform_device_add_data(pdev, tbl_msc,
> tbl_msc->length);
> +		if (err)
> +			break;
> +
> +		err =3D platform_device_add(pdev);
> +		if (err)
> +			break;
> +	}
> +
> +	if (err)
> +		platform_device_put(pdev);
> +
> +	return err;
> +}
> +
> +int acpi_mpam_count_msc(void)
> +{
> +        struct acpi_table_header *table __free(acpi_table) =3D
> acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset =3D (char *)(table + 1);
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int count =3D 0;
> +
> +	if (IS_ERR(table))
> +		return 0;
> +
> +	if (table->revision < 1)
> +		return 0;
> +
> +	tbl_msc =3D (struct acpi_mpam_msc_node *)table_offset;
> +	table_end =3D (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		if (!tbl_msc->mmio_size)
> +			continue;
> +
> +		if (tbl_msc->length < sizeof(*tbl_msc))
> +			return -EINVAL;
> +
> +		count++;
> +
> +		table_offset +=3D tbl_msc->length;
> +		tbl_msc =3D (struct acpi_mpam_msc_node *)table_offset;
> +	}
> +
> +	return count;
> +}
> +
> +/*
> + * Call after ACPI devices have been created, which happens behind
> +acpi_scan_init()
> + * called from subsys_initcall(). PCC requires the mailbox driver,
> +which is
> + * initialised from postcore_initcall().
> + */
> +subsys_initcall_sync(acpi_mpam_parse);
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> fa9bb8c8ce95..835e3795ede3 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE]
> __nonstring_array __initconst
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>  	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -	ACPI_SIG_NBFT };
> +	ACPI_SIG_NBFT, ACPI_SIG_MPAM };
>=20
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>=20
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h new file
> mode 100644 index 000000000000..0edefa6ba019
> --- /dev/null
> +++ b/include/linux/arm_mpam.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Arm Ltd. */
> +
> +#ifndef __LINUX_ARM_MPAM_H
> +#define __LINUX_ARM_MPAM_H
> +
> +#include <linux/acpi.h>
> +#include <linux/types.h>
> +
> +struct mpam_msc;
> +
> +enum mpam_msc_iface {
> +	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
> +	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
> +};
> +
> +enum mpam_class_types {
> +	MPAM_CLASS_CACHE,       /* Well known caches, e.g. L2 */
> +	MPAM_CLASS_MEMORY,      /* Main memory */
> +	MPAM_CLASS_UNKNOWN,     /* Everything else, e.g. SMMU */
> +};
> +
> +#ifdef CONFIG_ACPI_MPAM
> +/* Parse the ACPI description of resources entries for this MSC. */ int
> +acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc);
> +
> +int acpi_mpam_count_msc(void);
> +#else
> +static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +					    struct acpi_mpam_msc_node
> *tbl_msc) {
> +	return -EINVAL;
> +}
> +
> +static inline int acpi_mpam_count_msc(void) { return -EINVAL; } #endif
> +
> +static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8
> class_id,
> +				  int component_id)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif /* __LINUX_ARM_MPAM_H */
> --
> 2.20.1


