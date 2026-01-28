Return-Path: <linux-acpi+bounces-20716-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ij8N5NDemn34wEAu9opvQ
	(envelope-from <linux-acpi+bounces-20716-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 18:12:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B5A69BD
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C59C6305BF51
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA574322B8C;
	Wed, 28 Jan 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jozK8YoD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Emo6Jb5s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E473164B6;
	Wed, 28 Jan 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620120; cv=fail; b=gcK2fNrFpZdQLoYxLvE/DAWp42N7/2RsJlE4XYKoAbzvR7TBjmAyGV45d0lcQhPMUW6jRodbIsw31aBjr19HdPd7/zhifbhw27ndhF5kAHjp32WdJJOCPoDGyB3epPyZ60/mVVD/knFvb47K8dTGC4fHijlwlCV4bryBweE51Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620120; c=relaxed/simple;
	bh=o9wuvclAZq7+r4gEbNtPbXLn1BJ6DMyHYdqP5B0Pahc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbQmUrYaakUJCNzHiirF0Dc+wtkWGEtaXNUPZiCr7RPOv6W9QOxoFus1/rMLiGHRN7vp8vMXxXwhzj2wkPK3m4YrqSXfImDpf61OZPQ94eiNovCAZmrRLJrPFbbFmQ5T1F/9cYLLIERe7WiE64LQ7ztx3YHjc24FqKrIUm2XcBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jozK8YoD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Emo6Jb5s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SGb8pp840930;
	Wed, 28 Jan 2026 17:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o9wuvclAZq7+r4gEbNtPbXLn1BJ6DMyHYdqP5B0Pahc=; b=
	jozK8YoD3ryHCmwvb2IrfIrApwcCLjo/56cSS++ZN+H5EyQfBoXAhV5KTvb8E8HE
	BKT3E599hY2mIlJe+7Ttfh8LoL5DrWjj6E9BALBAotbI+rusrTcU4qzlAskTkoQ6
	BRgP9fhUjLCN74Vdf+CpNKhnYtAhg5kFLcpQyXLlZDEn0vejPwtgZId6aSNapCCw
	+wXgvy/X27eSzKXoYEECx6iJteL2QoXw/BhO1iIjGRiCDUaHqG21ZfZZRD0y7svG
	LKhqXUbDI9fmPAhIovaAJsTVF7ioMsrNXfB1mU9le8waitfmO4FAostevEAl6jtw
	g2JdWszzDV4+Wp8nFAvxeA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by378hrrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 17:08:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SFVKXG012842;
	Wed, 28 Jan 2026 17:08:29 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhb748j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 17:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3DNoQwj9Ae4AGQdNkL5n8zl3mrvJgNiqk9CidKlsK5TaXFkVNVGrbRoEjqlMbGPAUkMlWoZTixE20y4oSBGJq3Z0DkHUgeZbhFo1t1MyK8dHRD4OVxenGeWGQRBzXl3A8zvnp3l3+MUxRtegz6daTGXVl87MQQjvfb/Dr2ufIcXHUJzex2RD8CACw4fMqpas3hF4+uKeSS8xXbvVLhfVNK6vzVIdIMUe/r+6h2JeyQsbunil3FWoMo/16GhtXBnFvcWDP8N5VgGJJZVj1bKhrUI3X0LMbSwjNM6Usb0TlSXX4GESluzg268i0HvrkntcHkd8hXTkTs6Bn60mYgGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9wuvclAZq7+r4gEbNtPbXLn1BJ6DMyHYdqP5B0Pahc=;
 b=wgfbYt4ToHKnucR5P+rCtHE/y7heFxWhsm3zhXYBdOB/ZNalWNQUxLBprIeHhfzvM+CiTpCJrsIqEweEfhP5l9bgzX+QCT3rMN4XUPVzaCF04sIIheh7QEYy/lXQ4kF+ADOGjAsssNJPje+vJFBfU5K5RTkK17LoBpflMSIvnQqu94CwGiZg6oG7gwZ6n3YxPlhVXyem++EhNkPPoPKGwMACfeQrnkS7MlwpG690waF0qUkvy+SjoHVbJFOz29v5fbSld6aOS3BPeIPycedR8dgHLbFW9LBAEmL7pjy6v/ei8/EExJs5vQ/bcwjlaU80ZzSo7j2NWZjpW6Sg9G72dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9wuvclAZq7+r4gEbNtPbXLn1BJ6DMyHYdqP5B0Pahc=;
 b=Emo6Jb5sEyMVCs8CZw3myMgYKBW+LnuKkNByI8W5C94K33r0kExsWtsJKHbhmLqHIWwuiXfoeXbBfUZuiz6eG4O3ndEImDp78NEiQDh/BjPmTM2G5zaGadAUeJsvNcj0ZdEpyB21bFzp5CeJ+KPmImt3MGo0U3stNpZIxbfAbBE=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by IA3PR10MB8089.namprd10.prod.outlook.com (2603:10b6:208:504::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 17:08:23 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:08:23 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle
	<schnelle@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Johannes
 Thumshirn <morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHci6Bw4Ah2IJD57EKH4IA39ueuwrVmnKiAgAE9dQA=
Date: Wed, 28 Jan 2026 17:08:23 +0000
Message-ID: <B6127BDA-03D1-4BFB-BA69-A91DC452BE9D@oracle.com>
References: <20260127221159.GA378928@bhelgaas>
In-Reply-To: <20260127221159.GA378928@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|IA3PR10MB8089:EE_
x-ms-office365-filtering-correlation-id: ccdb7b18-11c2-4dcd-dd9d-08de5e8fd839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVZ5N0pJZHZKY3JyNkJTeGdhamVzSUE2NSt6aVhPbWVWVGlPTHZrRGpvTHZQ?=
 =?utf-8?B?VTBHa0YvZFpsWGhVbkx5VXplNmE3YVA5SmlpazYreWRiZ0t1eEZOWnZnZk5K?=
 =?utf-8?B?NWRqajRJVjQzUGN5ODZEN2lPUnVrMEs2cFVnY3hLVitjSTZEbHFmOUJNU3lF?=
 =?utf-8?B?UDFiY21yNEJoK1hjWHc0OGFtcWdKTVo0cFBRV1V0aDloMDRja29rRjVJc1p3?=
 =?utf-8?B?Z0cxSEQ1NUVkd3ZDak8wRU5oNmhTcVFUdnk4QWI3WUp1T1RIYXljbG44d242?=
 =?utf-8?B?blFFUDkza0VBdFlzbUF4Vk90bytrRXZqRW5GaVVMZUpqVkJTWU53NGhTaVM5?=
 =?utf-8?B?ZldRcHhCSXBwMXF0eUhzZVhMV3dvRWpmRkNiaEJ1cXZGK0V5cURObWZZaXcx?=
 =?utf-8?B?d0dGRiszWm5ocDBQVTRiZ0lQTDZpOStqdFcxeG5vK0tGdHJaQ09kRUdRQ2NZ?=
 =?utf-8?B?WGJHUmFTYjVMM21RY3VUdndETzFxcHk5R2ZyTDlWeW9YZjBNU29POGRoamx2?=
 =?utf-8?B?TUhvc1FlUlZZY0FDSSsyRzF6L2NHOFBnblUzTlZ5TTFrNG1kdVpiYlNhU1Qz?=
 =?utf-8?B?MWhCSmM1NXk3TG1vMXRFZnRqTTRsbUNXMy9tTzRJSE1YandnUE1XaWhkSlBw?=
 =?utf-8?B?Sm5zZ2pxam8wQzY0YlZqalR5R1BRWmt1QVNKWXlIQjhHM2phNWJ4WVBtQ3RI?=
 =?utf-8?B?YlZuSFd6bFpweVA3eHVaVVh3Wmg5eGN0QmEzOE9BTURDNXZ5am43bVBpeFlj?=
 =?utf-8?B?d011bFVGRWhDYW5NbWduODRXMXlCYXFHakY4eUdmbjNXaVpoT3ZjbExyZlcr?=
 =?utf-8?B?YVlXL3VJYytUZ2JFN0NuWTdvNFVINFRiVGs2ZXFwcFlyRm5aUGovUXI4eU55?=
 =?utf-8?B?cTlMMmc1bytCZHFTSm1jSWR1UDRweVhHRjV5ejFEeHVCb1JLRzJjeVhsbnlk?=
 =?utf-8?B?dW9CaXZhVXYrZEVMV2M1d0xZR2g3QUprcmI2bHBDYkkzMUMrNmYxbEVHMTdm?=
 =?utf-8?B?cHFzK3ZERXR0SDN3K044L29FaHZuV0xzc0xySDBlMTR0NElDVU5DSHByTmR4?=
 =?utf-8?B?VWV5U2pNYWlNeTkveVUvMUtGR3lxMzg5VXQvejR5bmI2eTZTb0o3WnM4am1m?=
 =?utf-8?B?dHh6Um1Hb3IwMk1UNUFHamdPd1J6eE9sUjYvZGc1dGRGVTBFSTYwWmxraDVm?=
 =?utf-8?B?ODRSL0ZtQ2RtTXNFdDhjSDU0enkwMitkSHpNdG1jOXFGcDFoSHhuWDdxaVha?=
 =?utf-8?B?WWpQWEZxSW5scjNVSzgydHZqd1BBa1BmTUw2NERzcXQvRUI0WWR6SzVkYkly?=
 =?utf-8?B?THFsSGk3VFB5d3FtYjNpZHV2SGNKcWhVdkw1VmsvUHlRdDNuOGZrMDA3U3RN?=
 =?utf-8?B?SHV2d3N5bzRYYjRCZlRLQW9qNHZZc01xZ2VuNHFJK0dJVHQycjMxQWMrL2Uz?=
 =?utf-8?B?dkZydmZMNEtWV3FqYUpadG9nQm5zbXk1RWtzZld5K1M2aXZSZjFLc0dhSzJD?=
 =?utf-8?B?R045MlZvUmllVnhkL2RHT3BCQmY1VlVuVThleHVaeEZiYXFvTlpoblJKYzdj?=
 =?utf-8?B?dkViTk5iSGJmWmdkMVBtc0xsYVlpQVFoa2JnWXZtQWdXZ3lDNFJyY044Tk5q?=
 =?utf-8?B?ZlhpaFE3RVBjMkxhVmhNNTdqWUtWaEFtdllHRXNIN3FqV2NneW1TS3lyVGNR?=
 =?utf-8?B?N1hFUHZZZUVwamY0QzU0ZkwrZUg3dDd6bThGK0pTZHdQTEozVC9JZkhLd3RX?=
 =?utf-8?B?OGI0dlhPc1RnL3RIN0drQTdTNWU2bGFiK3JTemNhWjMrL1NET25Od0ExeG82?=
 =?utf-8?B?T1ppRldsQlJBVHk1dkk3bUExQklHMElHMnE2S2NaOTA4dFRkTnErT1EyY0ZQ?=
 =?utf-8?B?dVlSSUxsZ3JNZ0d1c3B2YUl0TjJTT2FTeDByVDdNUGdNREFNeCsyV2ZteFRq?=
 =?utf-8?B?SWpzWWhOQk9BdzFUelBxMWI3UTl6WS90R2MrdDh1eUp3Z3ZwenBQaWFocVVu?=
 =?utf-8?B?TGQydWJsTU9zNHVxTUlJK0x0RUsyK3k1eTlTTTdNQlR1RVQ4ZVJMSFcrSUVR?=
 =?utf-8?B?eTVHSmU1d2dPM2h4ZFphYlNhaGtDYVZzQlFreEFOOTNDYXBaeUx0czVOY3BI?=
 =?utf-8?B?VEJqZC9NaDBYbUx5VVNwb2RXVTNaNG9oYm5MQ1Z2T0VxUC95SXlDdzhqeWdz?=
 =?utf-8?Q?mKAdb/0Tff5x9X4J4z5IuXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajh3c2E2MzZ6ZnpPSTRHcC9EM0E4UXNOOVpWMW9OQm5kWVdHRHl0K2dxZU1y?=
 =?utf-8?B?a0lCYytyUnRVTWJydGMvVFBwN2RKOTlRdVJpYnRPTXBpdWd1Qkxmc1FMVk9L?=
 =?utf-8?B?N2lZTmhiRTdqMzJYNlhiSExtWFJSNHpGd0Q1Snk5M3pka29zdU9CeDcxZnVq?=
 =?utf-8?B?Q09hOTlZenhLc3M4NDgyczg2UkhrUkJsb1RUNFhoaTFFaTRVY29vNEt5Ry9j?=
 =?utf-8?B?SGE4Z2wzSXhOd2pqTUEwNWFaL1pMVGt3UjJ3b2ttc1NxT05xOVVwQkhKQXE5?=
 =?utf-8?B?UGxoN0E4aTBKaXFkUVowc21EVmdSRjgrYUlmM2o2MjZucDcxaldZL1VoSXdV?=
 =?utf-8?B?RmZYVHY2Kzl2NENPay9JcERIOUdmc0RPRy80eHpnczBsRU53UlpKZ1NaRWpn?=
 =?utf-8?B?UHNEN083QVlrT0lVTmhlVkdMTjRXN1FYWCtDdmhCcWYrOGlYTDJ3TzdyMUtU?=
 =?utf-8?B?TG1hYlFsWkpDU25LQUQ4amVaTE5iNUZQeTc1MjVBQld5cVRiYU1XL241aGZD?=
 =?utf-8?B?Nk1HL3UwaEoxbTdCT0k4VWhXTkZXMjAxVS91TjlVRGNvSzJ5Q0RCMTZXZWlJ?=
 =?utf-8?B?azJSM1RJUUZuMkpVQ1QzTTdUOFdxQmZNQ1NEbnpJZVhNcGZpeE9KU0VTdnh6?=
 =?utf-8?B?VThQVGFiMHFUSnNjV1YwUmY5N0lndE1oZW5ySk16ZThFSGtoOG9OQmJ5a0VX?=
 =?utf-8?B?V05MZFh5ME8zS3RsSGxNUHladTBJVXUwNHBZQ1ZpOXVDMmlHZ0VFb2tERlUw?=
 =?utf-8?B?eGo2Q3grUm9SbHNkc2UyYU5ndnFOVHljb0JHMXpJUVNGU3F4Q2F0U1dFVUZH?=
 =?utf-8?B?WTVkaEJxRkhGUkhFS25ScUR4UFZXUWh1d0kyN2ZZRUQ4NDlwV1hZdmh1L0w3?=
 =?utf-8?B?UFJiY21ndFFnVmVsOW9ESE1sUEVYVkY1RGNycFFkcGs5a2VsSGhkbmE4OS9m?=
 =?utf-8?B?a2VXZ2FpSXRBY1BzcmdiOUVWSElPSFJUR1lJYzVjeGd4WUJucWNWTE9NR2pS?=
 =?utf-8?B?ZU9SWXJXOXUybHhtZEJsTVIyNmlWbk82bFVnVjhlajU5a2FnM3ErOWNRUDFy?=
 =?utf-8?B?YVExM1BYQ0RHRVBzYjAzS0J1T25JeFl3TTE2RUFEcFNpQ0l5a2dIV0xrS2JV?=
 =?utf-8?B?S2I4Q0M5ZTdpM083QkhSZkpEZmV6REVwMnltakFZRHNRYXNjQk5VV3lMSmZL?=
 =?utf-8?B?bWlVSFIwd3E3bWZWbXA3YzlVSEJsbHU3WVBhek9MdzIwbU9OakFOUUZCbnQr?=
 =?utf-8?B?TmhYbTFxRWtIS0FnNy9jVWZ2ejdhcDVrQ2NYNFlveEZtWG9FSzVYVEFmYklP?=
 =?utf-8?B?U3Mrb2cxTVMwUnNMSkVYYVFIakp4Qmh5YW5JSHMvVHZEbU9ELzI0UVdHaHpk?=
 =?utf-8?B?SE9FaG9Cdk9KWTJlWE1PUmdQSjJTU0l3dENReWlaZW84eXZHTXRXMmZzTnAr?=
 =?utf-8?B?UWY2T1E1TzRTRXp6eUV2YjNBcDA4SElUZlpUOGw2VHdXVmFKbmNRVEJVUDIw?=
 =?utf-8?B?Qnh0Ylluc2lZeEkvTFF1OUZiR0hKdysyWFZ4Mlp3R0xXTDlHaGZmaDNQVEpl?=
 =?utf-8?B?T1ArcHBMaXRjRUwvQ29hNENRSkZVY2VPYWRDSXZodDA5Zy9kSXZxLzRVVFJw?=
 =?utf-8?B?MEdJOHhxc2hRdFlmeFhZdUlPcGM5QVU4M3YzOHBPUEtyQm1hTll5YzEzT2E5?=
 =?utf-8?B?eE5FV3FSY0E3RzNMQXVmbzB1UUtpSXI3OWFlY0FWT0drT0Y2L0hyUWYyUzI2?=
 =?utf-8?B?K2lZbU9ITDI2WlZDOGExUGFocklaUnhrdFBDaERKV1hwU1pFQWF4bUMrTnJs?=
 =?utf-8?B?Y0I3SFVzSDdKd2Y4WlRDLzJSSGsxblVucUphMVpHUHVpbUxTU1lwdnBaVlRz?=
 =?utf-8?B?dmZFR2JKQW5lWEROMVVTNGtzNVBpZ1M5SUhxcmJ2VFZBUVV6R2k3MnVRYUtW?=
 =?utf-8?B?UVdoTXZDdHp2TmJZbUkwcW45TUhNLzlkSDJxcDNEbW9vT1MxUG9YWHJkWDlj?=
 =?utf-8?B?ekUrdUdJbllFMjlBM1ZZaWx3UE1CRC9ZYlZNM0ZQY0hBQmRjUFVEUGRzM3Yz?=
 =?utf-8?B?bEwwU2U1TWZleW5RWXB1NmcyRlBIMmsrbDdVdTQ0UEhnK0tXenVsSjdaMmpo?=
 =?utf-8?B?REF4WHcySWMyejFZNWpCSXRzSmZBZHk0U09SczUvMk4zTTgxQ0xHVXpJL2Fr?=
 =?utf-8?B?cWtKWjJTRTJ6ZC9GRTd3OXFzcHYwREliQ1RGVnNwenpBL25IUVVrTDFEWVJj?=
 =?utf-8?B?bUVZTFVtM2o4Y3FyNkR5RkhjbGU0dHlXcEhqcWNtVVlNVzFwUDBlY0dJUXZo?=
 =?utf-8?B?bVJsdjM3QWFhL1J4N08xako2R2gvK0I1cGt3Uko1OUpUQys5TExxSGRLUWxG?=
 =?utf-8?Q?ZhFRkFvvK2pl/A2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFC455C186E38C4A90C249C74A27C04B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dnhuh53+1D1My5tFdrwj6G6rVJYolk45tduLqi2RRRT5w5nRlIo9u1jN2HDFa3+2i6rqslBmapqdOLBxiSmrFarY0YQ6uDf8BSr8gB4J6W8JWN7XUnmiC1CPkja1/IxurRRG8HojFClZoQQZ7NfLkvPlDYrxARFbqSK2p5pqYajNv6n5mxgJXuW8015/pc5VQm1bRaPp/vOHnBFbV1H2JOtPG3a/L8ALNlJKV7jZ3WBh6KiIrjKR4ezUNaA75tphswO+LH1DvqRCo8Wtb8r41Q83pBWMXhOPwloM9zlyxRCJk8oVAhDwlSA1NA/3AK9Aex82ImSJh5oy69/4TlUASFDg2XO2zfM46xTHa3BKGK6XLjt6eN4OScC6U2O37Mj/3PLAquE2tFDAIbn25UjdKWMqw2jyNxo7oRvXFix2r/VL6S0+toTsE/Og8a2S//+44+QXHYUiE0tfQO8qd/ZWmC+NeMLuNNbwU/IgZz5+jMlUChOwTpfQQmHVSpQ/3zLPJxSWfyK1yUEDAWNJFs9jFcJ2U8FaMCwmkVg7JiX5yevyMd7fiNZWnXdzKeIuoseT7BxCj+k/jqDxMs6maSNX3M24w5/OInr+da3TJoGnZhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdb7b18-11c2-4dcd-dd9d-08de5e8fd839
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:08:23.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znK51dKo3YcPzNj3/dLKFx88o3UnrufM+4Q91MEhhKLJaXoLwxqlqi3Qkd3R9JHjFky2jkK1hCeJBFnyRNbIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE0MSBTYWx0ZWRfX+eXKDDsNHxdy
 rMokqMg+wBbL7iH/Gl+twJuujiI5VvgCkDzATiaOvVD0XSpAfeF1oMG7SE3KZxPaIsgH+WUvlVK
 DFF/EEYJVverYF8Omf0WH1w+6Opc8DHH5GWy1exX7v9LoujIDiomarNjFKF/0dlB+K/8g4NdLh4
 JwSZwKM741K0yxeGRi45xOnLoIz82XA3vqiGnHf+uHjq6XRZE5yNlT2GwF5V+pEfl7tCu9KxEhk
 STGjKRbaEkNak8N2Dj3lxkIhjHhBMR4gpbshC9QCJh0fOq7iu1/UYPvOPS+nllWzrQYQV+ymQLE
 NNhWkh4oq3L4xChUf+eFWcg+tl2reYbF9FILXtmACWjU3BOOF5pF+dOWwDWDPZoVEk3/yE5fGsJ
 k797AIIldMjHnfW22674dFvr0NL5LoIMZxJB1zZeRoAJyj2HLWLqAPKktPeJ948xtMyFRUyNzr7
 vQCWNXpyJh+PAwHEO7A==
X-Authority-Analysis: v=2.4 cv=a/o9NESF c=1 sm=1 tr=0 ts=697a428d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=OhzAK0e9AmAy8mqhdh0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ghgJJpWQ-CtSaGrjjsxWjJZJsX9RnC-s
X-Proofpoint-ORIG-GUID: ghgJJpWQ-CtSaGrjjsxWjJZJsX9RnC-s
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20716-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 615B5A69BD
X-Rspamd-Action: no action

PiBPbiBUaHUsIEphbiAyMiwgMjAyNiBhdCAwMjowOTo1M1BNICswMTAwLCBIw6Vrb24gQnVnZ2Ug
d3JvdGU6DQo+PiBDb21taXQgZTQyMDEwZDgyMDdmICgiUENJOiBTZXQgUmVhZCBDb21wbGV0aW9u
IEJvdW5kYXJ5IHRvIDEyOCBpZmYNCj4+IFJvb3QgUG9ydCBzdXBwb3J0cyBpdCAoX0hQWCkiKSBm
aXhlZCBhIGJvZ3VzIF9IUFggdHlwZSAyIHJlY29yZCwgd2hpY2gNCj4+IGluc3RydWN0ZWQgcHJv
Z3JhbV9ocHhfdHlwZTIoKSB0byBzZXQgdGhlIFJDQiBpbiBhbiBlbmRwb2ludCwNCj4+IGFsdGhv
dWdoIGl0J3MgUkMgZGlkIG5vdCBoYXZlIHRoZSBSQ0IgYml0IHNldC4NCj4+IC4uLg0KPj4gDQo+
PiArCXBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NUTCwgJmxua2N0
bCk7DQo+PiArCWlmIChyY2IpIHsNCj4+ICsJCWlmIChsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9S
Q0IpDQo+PiArCQkJcmV0dXJuOw0KPj4gKw0KPj4gKwkJbG5rY3RsIHw9IFBDSV9FWFBfTE5LQ1RM
X1JDQjsNCj4+ICsJfSBlbHNlIHsNCj4+ICsJCWlmICghKGxua2N0bCAmIFBDSV9FWFBfTE5LQ1RM
X1JDQikpDQo+PiArCQkJcmV0dXJuOw0KPj4gKw0KPj4gKwkJcGNpX2luZm8oZGV2LCBGV19JTkZP
ICJjbGVhcmluZyBSQ0IgKFJDQiBub3Qgc2V0IGluIFJvb3QgUG9ydClcbiIpOw0KPiANCj4gSSBr
bm93IEkgc3VnZ2VzdGVkIGFsbCB0aGlzIGNvZGUgYW5kIHRoZSBtZXNzYWdlLCBidXQgSSdtIG5v
dCBzdXJlDQo+IGl0J3Mgd29ydGggaXQuICBJZiB0aGUgZGV2aWNlIGRvZXNuJ3Qgd29yaywNCg0K
SSBzZWUgeW91ciBwb2ludC4gSWYgdGhlIHNpdHVhdGlvbiBteSBjb21taXQgaXMgZml4aW5nIGhh
cyBiZWVuIHRoZXJlLCB0aGUgc3lzdGVtIHdvdWxkIGhhdmUgZmFpbGVkLCBhbmQgYSBmaXggdG8g
dGhlIGZpcm13YXJlIG11c3QgaGF2ZSBiZWVuIGFwcGxpZWQuIEhlbmNlLCBzbyBuZWVkIHRvIGZp
eCBpdCBpbiB0aGUgT1MuDQoNCj4gdGhhdCB3aWxsIGJlIG9idmlvdXMNCj4gYW55d2F5LCBzbyB0
aGlzIGFsbCBmZWVscyBvdmVyLWVuZ2luZWVyZWQuDQo+IA0KPj4gKwkJbG5rY3RsICY9IH5QQ0lf
RVhQX0xOS0NUTF9SQ0I7DQo+PiArCX0NCj4+ICsNCj4+ICsJcGNpZV9jYXBhYmlsaXR5X3dyaXRl
X3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NUTCwgbG5rY3RsKTsNCj4+ICt9DQo+IA0KPiBXaGF0IGRv
IHlvdSB0aGluayBhYm91dCB0aGlzPw0KPiANCj4gICAgUENJOiBJbml0aWFsaXplIFJDQiBmcm9t
IHBjaV9jb25maWd1cmVfZGV2aWNlKCkNCj4gDQo+ICAgIENvbW1pdCBlNDIwMTBkODIwN2YgKCJQ
Q0k6IFNldCBSZWFkIENvbXBsZXRpb24gQm91bmRhcnkgdG8gMTI4IGlmZiBSb290DQo+ICAgIFBv
cnQgc3VwcG9ydHMgaXQgKF9IUFgpIikgd29ya2VkIGFyb3VuZCBhIGJvZ3VzIF9IUFggdHlwZSAy
IHJlY29yZCwgd2hpY2gNCj4gICAgY2F1c2VkIHByb2dyYW1faHB4X3R5cGUyKCkgdG8gc2V0IHRo
ZSBSQ0IgaW4gYW4gZW5kcG9pbnQgZXZlbiB0aG91Z2ggdGhlDQo+ICAgIFJvb3QgUG9ydCBkaWQg
bm90IGhhdmUgdGhlIFJDQiBiaXQgc2V0Lg0KPiANCj4gICAgZTQyMDEwZDgyMDdmIGZpeGVkIHRo
YXQgYnkgc2V0dGluZyB0aGUgUkNCIGluIHRoZSBlbmRwb2ludCBvbmx5IHdoZW4gaXQgd2FzDQo+
ICAgIHNldCBpbiB0aGUgUm9vdCBQb3J0Lg0KPiANCj4gICAgSW4gcmV0cm9zcGVjdCwgcHJvZ3Jh
bV9ocHhfdHlwZTIoKSBpcyBpbnRlbmRlZCBmb3IgQUVSLXJlbGF0ZWQgc2V0dGluZ3MsDQo+ICAg
IGFuZCB0aGUgUkNCIHNob3VsZCBiZSBjb25maWd1cmVkIGVsc2V3aGVyZSBzbyBpdCBkb2Vzbid0
IGRlcGVuZCBvbiB0aGUNCj4gICAgcHJlc2VuY2Ugb3IgY29udGVudHMgb2YgYW4gX0hQWCByZWNv
cmQuDQo+IA0KPiAgICBFeHBsaWNpdGx5IHByb2dyYW0gdGhlIFJDQiBmcm9tIHBjaV9jb25maWd1
cmVfZGV2aWNlKCkgc28gaXQgbWF0Y2hlcyB0aGUNCj4gICAgUm9vdCBQb3J0J3MgUkNCLiAgVGhl
IFJvb3QgUG9ydCBtYXkgbm90IGJlIHZpc2libGUgdG8gdmlydHVhbGl6ZWQgZ3Vlc3RzOw0KPiAg
ICBpbiB0aGF0IGNhc2UsIGxlYXZlIFJDQiBhbG9uZS4NCj4gDQo+ICAgIEZpeGVzOiBlNDIwMTBk
ODIwN2YgKCJQQ0k6IFNldCBSZWFkIENvbXBsZXRpb24gQm91bmRhcnkgdG8gMTI4IGlmZiBSb290
IFBvcnQgc3VwcG9ydHMgaXQgKF9IUFgpIikNCg0KQ3Jpc3AgYW5kIGNsZWFyLiBGb3IgdGhpcyBh
bmQgdGhlIG90aGVyIGNvbW1pdCwgaXMgaXQgT0sgdGhhdCBJIGFkZCB5b3UgYXMgYSBjby1kZXZl
bG9wZXI/IEFrYToNCg0KQ28tZGV2ZWxvcGVkLWJ5OiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5v
cmc+DQpTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29t
Pg0KDQo/DQoNCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2
ZXJzL3BjaS9wcm9iZS5jDQo+IGluZGV4IDQxMTgzYWVkOGY1ZC4uODU3MWM3YzZlMWEwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3Byb2Jl
LmMNCj4gQEAgLTI0MTAsNiArMjQxMCwzNyBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3Nl
cnIoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gCX0NCj4gfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHBj
aV9jb25maWd1cmVfcmNiKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHBj
aV9kZXYgKnJwOw0KPiArCXUxNiBycF9sbmtjdGw7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFBlciBQ
Q0llIHI3LjAsIHNlYyA3LjUuMy43LCBSQ0IgaXMgb25seSBtZWFuaW5nZnVsIGluIFJvb3QgUG9y
dHMNCj4gKwkgKiAod2hlcmUgaXQgaXMgcmVhZC1vbmx5KSwgRW5kcG9pbnRzLCBhbmQgQnJpZGdl
cy4gIEl0IG1heSBvbmx5IGJlDQo+ICsJICogc2V0IGZvciBFbmRwb2ludHMgYW5kIEJyaWRnZXMg
aWYgaXQgaXMgc2V0IGluIHRoZSBSb290IFBvcnQuIEZvcg0KPiArCSAqIEVuZHBvaW50cywgaXQg
aXMgJ1JzdmRQJyBmb3IgVmlydHVhbCBGdW5jdGlvbnMuDQo+ICsJICovDQo+ICsJaWYgKCFwY2lf
aXNfcGNpZShkZXYpIHx8DQo+ICsJICAgIHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lfRVhQX1RZ
UEVfUk9PVF9QT1JUIHx8DQo+ICsJICAgIHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lfRVhQX1RZ
UEVfVVBTVFJFQU0gfHwNCj4gKwkgICAgcGNpX3BjaWVfdHlwZShkZXYpID09IFBDSV9FWFBfVFlQ
RV9ET1dOU1RSRUFNIHx8DQo+ICsJICAgIHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lfRVhQX1RZ
UEVfUkNfRUMgfHwNCj4gKwkgICAgZGV2LT5pc192aXJ0Zm4pDQo+ICsJCXJldHVybjsNCj4gKw0K
PiArCS8qIFJvb3QgUG9ydCBvZnRlbiBub3QgdmlzaWJsZSB0byB2aXJ0dWFsaXplZCBndWVzdHMg
Ki8NCj4gKwlycCA9IHBjaWVfZmluZF9yb290X3BvcnQoZGV2KTsNCj4gKwlpZiAoIXJwKQ0KPiAr
CQlyZXR1cm47DQo+ICsNCj4gKwlwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKHJwLCBQQ0lfRVhQ
X0xOS0NUTCwgJnJwX2xua2N0bCk7DQo+ICsJcGNpZV9jYXBhYmlsaXR5X2NsZWFyX2FuZF9zZXRf
d29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLA0KPiArCQkJCQkgICBQQ0lfRVhQX0xOS0NUTF9SQ0Is
DQo+ICsJCQkJCSAgIChycF9sbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0IpID8NCj4gKwkJCQkJ
ICAgUENJX0VYUF9MTktDVExfUkNCIDogMCk7DQoNCkxvb2tzIGdvb2QgdG8gbWUhIFRoaXMgd2ls
bCBlbmZvcmNlIHRoZSBsb2NrZWQgZmxhdm91ciBvZiBwY2llX2NhcGFiaWxpdHlfY2xlYXJfYW5k
X3NldF93b3JkKCkuIElzIHRoYXQgYW4gb3ZlcmtpbGw/DQoNCkFnYWluLCB0aGFuayBmb3IgdGhl
IGVmZm9ydCB5b3UgcHV0IGludG8gdGhpcywgLEJqb3JuIQ0KDQoNClRoeHMsIEjDpWtvbg0KDQoN
Cg0KPiArfQ0KPiArDQo+IHN0YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfZGV2aWNlKHN0cnVjdCBw
Y2lfZGV2ICpkZXYpDQo+IHsNCj4gCXBjaV9jb25maWd1cmVfbXBzKGRldik7DQo+IEBAIC0yNDE5
LDYgKzI0NTAsNyBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX2RldmljZShzdHJ1Y3QgcGNp
X2RldiAqZGV2KQ0KPiAJcGNpX2NvbmZpZ3VyZV9hc3BtX2wxc3MoZGV2KTsNCj4gCXBjaV9jb25m
aWd1cmVfZWV0bHBfcHJlZml4KGRldik7DQo+IAlwY2lfY29uZmlndXJlX3NlcnIoZGV2KTsNCj4g
KwlwY2lfY29uZmlndXJlX3JjYihkZXYpOw0KPiANCj4gCXBjaV9hY3BpX3Byb2dyYW1faHBfcGFy
YW1zKGRldik7DQo+IH0NCg==

