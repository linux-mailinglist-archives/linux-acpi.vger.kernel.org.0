Return-Path: <linux-acpi+bounces-18891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCCAC5B544
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 05:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D126F4E44E4
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 04:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F3299AAA;
	Fri, 14 Nov 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VLXlHeAg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E6274B3C;
	Fri, 14 Nov 2025 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763095039; cv=fail; b=jBD7p1WNpa3R/TFNYsYPWNAHYz9pgqs1lfM6BDK//DfEANws8nMRKhTyrsCFM82bxv0RXvQXPZ1pJe3SEQ71beOEZhaLxYidHXLVPz4IymVx62Vowo82ic5J0GIuEz44Y3ySgBciAfK+HT8+8KfHwTHyQsiswS7TarfLNE0v4fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763095039; c=relaxed/simple;
	bh=I0DYUFS9bgx4S5FRG8Jc4KLZOadtORppRCS7r92n57c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvJPJdrUO6RY8KbMBJwT5pztBs4/mS0hYs2sFbN5rxk1FnqmWXKCDiJaEU9+/E3hfZu6wAI9Z5O8lippkn/hooFNvRwKCRkbqU6qLYPY81WyhUkcJjMF2rhC/Ept9hS/hIGb19C5N1HtQ03qKeIzrT3Tg77jHb+64pZFDgzmNBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VLXlHeAg; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7WXdZbDSq6bHfgkzmVwbKIyn/jQRRXkuqSwvbl1ef+r8A9DRqzBrRkGxRaSKzILg5RuSEeRGnL4eqLyawa+pCjoFnHAxVnBmWJ3JNR7znnzeD9uxQs6uDywcRCH1qB/3zelEL5S0Hj2YEMw3IXmkLpvrvi1F3Fxtg+J7upEFBp7RgexLCpv/kJNa/Gc6dBUJlbmKQpVF/W/S4KZ0kph9MW2pi2cHS1tYHBS/fD7vBxGZhKq6vbEvdgNgA2k8JQxOzcvRaa2nsntJ/1OLqJov6lKAYwPoHreAKNgzplrszPiHeXPtKhrDsXiDtakX/XoqtitUyT5s6mwTpRrEdSzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0DYUFS9bgx4S5FRG8Jc4KLZOadtORppRCS7r92n57c=;
 b=QVtZnIFpmDe28pBQDLh9mNPWRbZFRvCI+zP/dsdUU/gWESu0LuHu4+E+AE0wi9iebmpZCk+OWCo4/HUz99ce9zxBRFk7kQA1TBdyqxe91M/pxKS9Dddid3ZM3KEKmxJyWDxaJHrkES276ul4KavM1QXqt+rk8lhtOm8RUMtjdFcbZLNowoMdw2FKXyNhO0Cm9GMRzEZEQp8xMDFCSxN60BmeuByyW3Rr7LgyLk4vcOpZP8xJaVlYK0VoK39fYI0KjCebzqR3P8P2HsaZ8GEZ3aq73u/Woyl/o0jm09WtzBv2BFmeSZ5UppAcmX1BrAV0hux86FzKbs5tHetxBWXUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0DYUFS9bgx4S5FRG8Jc4KLZOadtORppRCS7r92n57c=;
 b=VLXlHeAgNzi43K5wtXe5ryavvb7uWS2NGvoqgd/exhY5qesX1TH4kDNQRYYt43NallXokgRb6wWtJF0HP5qthuzT0rq30DXxCUGcngcUFWpmdXYw+TKRF8c3Y0S0Fu/tDELKM3Lk65s3Fe8A4DrK++axWAoIXFBlF2bc+yz3v31PhKyP3/v6nc0XfW2pJj/8POb73MB3quTt99o3FzQz+pMQ0f2Nc+wzhEOtwBJJMFjqU8woSxqgGpyfvUDoCiWGtk3PFpgk4Sbe+PsEdiOWayZPhgHaTIGQIVZKOgDzeQEm2fLXTr4xOdvYkCnwnnXX4Y9JH90Ee5DF2wSCU3lk0A==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS3PR01MB6935.jpnprd01.prod.outlook.com (2603:1096:604:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 04:37:15 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 04:37:15 +0000
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
Subject: RE: [PATCH 22/33] arm_mpam: Use a static key to indicate when mpam is
 enabled
Thread-Topic: [PATCH 22/33] arm_mpam: Use a static key to indicate when mpam
 is enabled
Thread-Index: AQHcT+NJmPlATbo5E0ezPi0JCYGvarTxoKlg
Date: Fri, 14 Nov 2025 04:37:15 +0000
Message-ID:
 <OSZPR01MB879841CA355A781965B7FEFA8BCAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-23-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-23-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=90883146-95a7-4f0f-9ce7-9c57c135353b;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-14T04:36:18Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS3PR01MB6935:EE_
x-ms-office365-filtering-correlation-id: 2fd4c420-7721-44a4-9d0c-08de23377c7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?L29XVkR4OUxuWnhrZUdsVTVYTFNNa3NPcmZwTm1mdi9iWlVBVHhmd3RM?=
 =?iso-2022-jp?B?M2o5QzIrQXFySVRnWGVXVnBiU1VhUG1lUmdtOEw0Q2N1cWJHT2hsN1ZJ?=
 =?iso-2022-jp?B?cVhaYWc3Vkg5ZUVHbW5oSHBLNzgwSVZkSGpzTm5kaWR6ZHc2QzZGSVMw?=
 =?iso-2022-jp?B?b0hVRFhBRHJFVUNSVjI5ditvbUh5aHVaZ3VtTGwwcldJSjhmQi84NWVa?=
 =?iso-2022-jp?B?cDVKcHg5WlE0ZGJGTm14NktKdVZHMGUvekg5bURTRWlSRGQ2T0poUitu?=
 =?iso-2022-jp?B?VkNzSU13Qm5lWnN1Y0tBelVudHNsZ09FQWR5UmR1NHdHelVjZW4rVzlj?=
 =?iso-2022-jp?B?bXpncUEvU0Fwbm1zNHR0UE02T283VkNsaG5lYjRJcUZzVXplUXllZ0Z5?=
 =?iso-2022-jp?B?UXFCRHBGRFRMbng5eGRrbkF6dVpvdmQvUzV1TlZLS2NWRzBYaWx1bUR4?=
 =?iso-2022-jp?B?bnJ2Rk1oTEdDN1RUVk4yMU9lZVdoY3lzRlFZQitXVWhxM3VrRTRabFdi?=
 =?iso-2022-jp?B?dC9SaFc4VlVEN0hPVEpNZGFzOHRXY2ZueEtJUDVBdnVwMW5hQkxpaTVJ?=
 =?iso-2022-jp?B?b1BmQTBiY21SUStRMnc3YXhGRnhVdFVxUDZUeVk3d1Y5NUx3Zks3N1do?=
 =?iso-2022-jp?B?UWVsSnZtUTV2ZnZTTHRuV1A1dFlxOUxvN0E1NlNwYWIzaEVtMlQ4UmtT?=
 =?iso-2022-jp?B?NStJdSt3VlFjQnhaNXRyV3BrY0pxTTdUZXVTeHhxUzBmWDl1eWdRQmpS?=
 =?iso-2022-jp?B?dkxZNTlick1RbTMydFliYUlER1NvbW9FOGlCOFlnYUJWSUVwbmRnUldi?=
 =?iso-2022-jp?B?MWpjeUt6YVVRTSt5c1I0aFdCeVFTa3lKRkFrbEYxZVpMTyt0cUtpYW4r?=
 =?iso-2022-jp?B?bmlIZHEwWHhzMEpGaFVMMWJvVnFtazU2TmNOakk5c21UVFp2QmxRVUFI?=
 =?iso-2022-jp?B?MW1xRlk3OFdhY0VHMUdvRDVrYlBEczJqdG1mdUlMbXAzOUJKM3ZhVTQ3?=
 =?iso-2022-jp?B?UFpQRXc3eExnWnQ5MkxoVVN0ZTR4L3V3TXRoSmxoY1dTd1k0K0JnemlT?=
 =?iso-2022-jp?B?ZlpJWUY3cUFKRDZnNVpzU2FqYS9yZ2xZVXZoMVhlRkRFcDl2LzJUcHcx?=
 =?iso-2022-jp?B?eGRTamtPQVZvY1ViOEQvdE9ORmRrTUc4VVd6VzN2b0hpSlpwNlo1V3Js?=
 =?iso-2022-jp?B?aTVCVU5zMU5kUGRCQjdLSXh6VDBENjVQZXJySHBpd0FGUmpVc0tSQk51?=
 =?iso-2022-jp?B?NGR6dEZIL29VanB4N0Y2eHRJVDJFM0VZVjJBMmkvRHovZk9PemREMzdX?=
 =?iso-2022-jp?B?eDlmM1ZyU3BmbkVaK0xRYjJTdHNYSlpPN1E2NlRLWEtiUXhtVzVheDln?=
 =?iso-2022-jp?B?SEpXZEhLRkJieFAxQk1TeHVqUjcvTGh1MUhURFRiV2dwTU5CY1FuR3E5?=
 =?iso-2022-jp?B?M3NOUDdHZzkrRHl2R1pCTUgxWVdGYzBxRnl0UlQyaGJNL3dDY2pBOWgw?=
 =?iso-2022-jp?B?U0tEak4wNjdYdVVGVzl0YTVUTDBFamQvdnBQckp1a2krTStxQ0lyajNS?=
 =?iso-2022-jp?B?Y0RWOXN3QUpsSUdXMlFZZStIUVl5OG1uSkduM2pDWUVFbnJuNlM1OVV1?=
 =?iso-2022-jp?B?emZkSEZPZ3FJYW1pNnN3K1RGb0x0WEJUQUREQSswSklQa2lrY2NyMllH?=
 =?iso-2022-jp?B?THQvOVQyRDNRZUdrZkVmR0k1ZVpQWXVHTHhEazlxbTVhL1c1MUFmT2Zv?=
 =?iso-2022-jp?B?M2xCZkRROWk4cS91eUNhM2I0ZzIrSzdKNDBqS3hlZERnVzd4Q3QrQmly?=
 =?iso-2022-jp?B?SmVoRXo2VVRkMEg2ajJuM3l2M2ZudlRaOTVsQnlEUE5BbzZicDZ3RlI1?=
 =?iso-2022-jp?B?ZUhxMHNWQUZ3MXJrV1Fnek1YYjNuUWpjR2VaajBjUDM0Q1MrT3pnckI1?=
 =?iso-2022-jp?B?Q1dXRm04UG5vUWxCaEJQcUJiM2dkZnUzSEVjSlR6WEJVb0E2RGxCU3gz?=
 =?iso-2022-jp?B?aUY4SXBESjNJWlp5bXFuTnVMSTQzU21NcHV2enNEckJwL1ZMU2M5TXlu?=
 =?iso-2022-jp?B?SEk2YXVHWlZUa0JuQitiRm1ueWd4dlI0Q3NGVDlCZ25UQ1RIZ0NscUl2?=
 =?iso-2022-jp?B?Yk9uZEE3OHdCa1ppRjlMUGNJME5ZcS9ic3lKUG5kdWFraGE0VlRhSmd0?=
 =?iso-2022-jp?B?eDJnTWVvUHY5aDlBVGhWWXN4azQvSVpPempEa1pOL3ZVMG13bW02ZHhG?=
 =?iso-2022-jp?B?ZzZsUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VnRWbGV6WWNHN0RVNFBRaE9WYkZRK1lhcm9udEdZVFVjcmxQNmpVYVpl?=
 =?iso-2022-jp?B?RFlTT2NlMUxaRnhCWEwwTmRqTjY2SUtMNHhQWjRyYkFTZ0pUQVBBSmhy?=
 =?iso-2022-jp?B?NGZtQlZVSjB4SUxBVVJiTHA2VHA5SmZJVG1UUDkwZkJSaTcrZW9vbURr?=
 =?iso-2022-jp?B?MVhWUEsxb1pDQWVLYXU2RDVxVDRGQjVGU0ZYcXgvRXdUbnNWNjl2alMy?=
 =?iso-2022-jp?B?cVhnL0VUNkV0TlBtZnVnT05YdVF4SzgyUlZJNml4R2YrOVNzcUpMWmE5?=
 =?iso-2022-jp?B?NVljTEpQUUdEOEJ5NU5hWFpZMW1aL09MZkhxTkN6WGNNaDBHSWI1UTBS?=
 =?iso-2022-jp?B?YTNwMW01M0J1UHdNei9SeFBQVWF3cUt1dXpoazZwSkV4dkNNMXZ0Q3I0?=
 =?iso-2022-jp?B?VktuTDh4VUl1SjlUTjFiQ3ZLNkJ5RCtKM2R5NVJickk1cGNmdVdxWXNJ?=
 =?iso-2022-jp?B?Z21sWTFvODk3MXpBNWJMR254eDlCNFFEbjlvZXowcUEzZjVPelZjZzl3?=
 =?iso-2022-jp?B?TUtoeDBLS0xTamFsVFQ5ektRTDNvYkVtOFA0eXJhVW1kYjN5SjZ2UmFt?=
 =?iso-2022-jp?B?M0RDb3ptSFBMaWROK3gvazg0NWs2Z1lPZUlMc2ZOMTMxY1dTNjJuOGEw?=
 =?iso-2022-jp?B?U09FNWYzUlRwRXV4eFhsMlZCZHMrMWl2MWZENUZ4VE8xd29laWpkRGRD?=
 =?iso-2022-jp?B?SWVuY0xRZ0RqRXVXVkE2Qys0a2hRazRYbWp0R0dJaUJ3OTkyeGxvbkIy?=
 =?iso-2022-jp?B?T050K1pTdzIyaTZteFBPUjB4eGN4b1g0L0hFU1VEa05kNUVCTFZoMHJ1?=
 =?iso-2022-jp?B?NzcvR3VnT3dqeU9qeVkxNDloZm9wK1g2dUw2ZkRSK09Dc1JsaHIwQ0k3?=
 =?iso-2022-jp?B?a0pIdFhyM1A2U3pQRXZnbGdyVElXTEFaMVVkZWJFOHEvOWQyWkN5VEZj?=
 =?iso-2022-jp?B?SXU3YlhvUVN1TkdjT0I3bjJmZmdyUEovL2plMkFOZWtNcjNPRS9zdjFK?=
 =?iso-2022-jp?B?QjlTWDNUbnNkZWhOYjMwUDNNc2NyMll4U25ZN0hkOGFFajU2Ulp3c0xY?=
 =?iso-2022-jp?B?YVdXakpPUFNudm4zandEK3pLMUkxTWpxR2dGcHFiNVo0ajl6aFpxUzBi?=
 =?iso-2022-jp?B?OHFPRTVjQStsaEpZY0NyYm5Xbk9nRzFHM1FEMVF3bklxREFXUHltcElS?=
 =?iso-2022-jp?B?eDNNUHNaTDRoeHJNdVNLQ244NkgzcWx3YWR2YW04cE1GZnAvNUllTXZp?=
 =?iso-2022-jp?B?ZURpRnBaY0NkaEFCOE92V0NHZCtJUmI5RTNjU0JNeWxndlRmZ3daK0hU?=
 =?iso-2022-jp?B?bFdlbTRFZlpyRUhlQW14Z0N4eDFqNGNsWDh4OW5HSm9vSDUxai9FWkVZ?=
 =?iso-2022-jp?B?VU5scmZjbFhObzFzRll6RGZEbHR1QUR6bld4RTRCbWFWYUpUQ0ZBT1lj?=
 =?iso-2022-jp?B?KzNwczA3bmFyenNnZUl0Z1lHTS80MzJKTlMydm9mWWJhYUdEQnIrbHdw?=
 =?iso-2022-jp?B?azRvQlV3bi9CVlF3WFdJYlN2VDU3ZE5FNWFkcTJkakNDcFdYaGc1ZldV?=
 =?iso-2022-jp?B?Y1l1MWxlc1pueGJGK2c0eFRYcFdlZ1ltc1NIT3JQNyt5ZXpHRm5xMmt5?=
 =?iso-2022-jp?B?MEhReG81QkhnYTVtRk56MlIwOXJZSUZiNWhwZHJvMHNFa0thMmRTY1hI?=
 =?iso-2022-jp?B?V2NjcTBDVXlSR2V5NEVNdzNOY2Fqa0hrTGtsNURZOGJXMkRQeHRVU056?=
 =?iso-2022-jp?B?d1JwVVFlR0FaSmpEUVcvL3RyS3NhUXJGYzF0cXl3NkQxeUV3NUJ2VGJU?=
 =?iso-2022-jp?B?b00xTTVnM3h3S0paY0NBb2FMUE9RelhUaWFmL3ZWaHp2aW5JZGo3Q1FW?=
 =?iso-2022-jp?B?cDJxTTk0OTljdkV3azlBcVRKZE9oRUd3QVNnbGV4SDdRdHNSWEJXQ2Rn?=
 =?iso-2022-jp?B?SWdvdnVadHhQaVZxTm00MUhzN1N3OERkdWxhNEF2WW0rRi9uVWxTcVVE?=
 =?iso-2022-jp?B?M1UvZTBKRmpYZWRzbDkwZk1yalZzQ2dETmRiVHc2UWtReHlCdWxtZ2Zq?=
 =?iso-2022-jp?B?MGI5eXkwVE03VUs3cGEvMmUvclZFbzZYWVZqaHQyQ2pMYlIxSTBHcGEw?=
 =?iso-2022-jp?B?UU8vT0JGVk5STVhwUnNKU0k0aFphRzRQZmZpQUI3NDNYQXRiSzlGRlBX?=
 =?iso-2022-jp?B?Rk1zMjlQSjAyZm1NTEZLclFFVlpiakhBWVlMUHREMC9qUnEwblRKaEVz?=
 =?iso-2022-jp?B?aVZpZ1Jpc3ZMdkZOem9UblI1Z0twMytONmVsWExKeTVWMS9tS1hsUUdJ?=
 =?iso-2022-jp?B?NWY1T0dsRVp6UFEzNmZYcTM2K3VlL2xoYVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd4c420-7721-44a4-9d0c-08de23377c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 04:37:15.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xr8Aw20n3e0SQUCPy6nRzCtQUYfA1E93TO2cle2zEWIreXpwPHbt9yIhikg55i88D9AmsZmhlV9L56L1RoPWCq0GbB5XKWBbXhWc6kF5rXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6935

> From: James Morse <james.morse@arm.com>
>=20
> Once all the MSC have been probed, the system wide usable number of
> PARTID is known and the configuration arrays can be allocated.
>=20
> After this point, checking all the MSC have been probed is pointless, and=
 the
> cpuhp callbacks should restore the configuration, instead of just resetti=
ng the
> MSC.
>=20
> Add a static key to enable this behaviour. This will also allow MPAM to b=
e
> disabled in response to an error, and the architecture code to enable/dis=
able
> the context switch of the MPAM system registers.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>


