Return-Path: <linux-acpi+bounces-20559-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOgyNhJecmnbjAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20559-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:27:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3426B426
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ABF7301AC50
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4464EA395;
	Thu, 22 Jan 2026 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mN1zWbQQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W0vMJ1FC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A144EA36F;
	Thu, 22 Jan 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097228; cv=fail; b=awb/Hgg8NsDMGKEJ1ApEgV3W/+fHzaz4NG5ZysrKij5tEOMBRe1rwTBNo4KghhMNVae5jzUAecMOiuGSDwbbbVbwx1g+cw2jpygw0GH73bcdq03+wvQW6lhlMZ9RsI0DhX/2o3t5tvyUMDgMz9y+C4GFV+MsGuSPN00s4O2O9ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097228; c=relaxed/simple;
	bh=eIFR+kI15v3qDGoIJQBAi4M9sFk7XGAmLRH2yRCFyCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPkAQw5PevakpMJFXamfAdWKGgv7OhQQP+eBgaMnjHZ4yldkhMQlYjtjA7LpUs2o1rhJZLMT4+pLq4NRVRqx+hnh62kwskZgJ6JeAtT8PjGWvTHt7W7rSyqddAVmvmD2Bt5EcZ0Ugs5lNpFjr353oGvlD92j9WZXT+HjJG3l4Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mN1zWbQQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W0vMJ1FC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgY4x329851;
	Thu, 22 Jan 2026 15:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eIFR+kI15v3qDGoIJQBAi4M9sFk7XGAmLRH2yRCFyCA=; b=
	mN1zWbQQeaQgghW95K+92ayllYQIhJzLbqBqIQi6h/nrgb4aM+fT9bkKJd0Y3iNy
	4H9kzhhBhfOzQN1hYDXFzgtwlkglrovg7bKlyI0qDb2iFCKEPzCjxdjiiv5+w3ow
	1lRzdDSo5ZYDR1qZgRlTtRfCKEWx3noM88oNf5zChrh7x0uiGbRGQVnmt8TWIXfM
	cWAgGycpu+YlfAKFi+HthTFWVMScvnxSaGIg6TlIDWPK+HMyS0Lz3C1C8abxSN9s
	Ojfkl7DX3em6nR7pJHKuCy89BFtcfBtJlNXUUsmHFxtjUeE1HL/3U/U5N3qpr/6F
	DOjeslWpTPl6jLOP8l6i3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd4fqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 15:53:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEXDHg008414;
	Thu, 22 Jan 2026 15:53:34 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd1u24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 15:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts5uucvBksgBPewiEUyyivi3+xtwPVKvjAL+ZIeY8auF1ObbF4EwVSrTJU5unPSW5NihY6ii5BRyr0ee3tz3YJrAaLvQ/br/T/LtnWzEAJ518i50A5N6ctVpE2NmODxSB18q42SWxBDGTS7ZmbzQg22wYA8EqlFv4kVR4bSw51lxlM9PJveKh2HlQ/2fJceX0Z7Tg9eiWNERXo14zGUf5Hy6v39YPxq7MrjFCAZJH+rDRzJ1cOIIT/W9B3LzwzaP9kZrB26Qee9GkPwh9R+y6qwk+fghVgsa2ktZGaFqTVWVauBI7mVMmyLfO7hrMKyaTZrWS0Lxl0h7/4PmsXSrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIFR+kI15v3qDGoIJQBAi4M9sFk7XGAmLRH2yRCFyCA=;
 b=wKrM9+gKIN9rOAbX+K5U5inUJqNhl44h0Ulq0iYi00JhcVSiH0TfMCbg0qmZgsLWjsHe+aoGqkCcSLmmVavIHC3jxy2n59qjKgxqkH/MDWsy53G0z4rfyS03DezCAspUSPwcwg7UWjTAWFgV7o/t2qSK2e38ADrkIcQ2GjqxW8SjzMMPzqJk5el8kN6C6fQImuWsw9g+M64ZdM1NjlFf52GlChkNouPnjI9t4Rmiw/P0tc3afdt2bNx+Va6hXhGWO9rgZpCbl6UYuYd9x089cBAgWD04yWvW+A57i1oYX19AQFLwaISvovKXHZP3tfBHRcvYEufRRda7TJQE4TFkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIFR+kI15v3qDGoIJQBAi4M9sFk7XGAmLRH2yRCFyCA=;
 b=W0vMJ1FCosbqx5R9zniOt1CzYN+70vjt6bqsKs1K1lqadZaQ57+vNiuAEauDB1FMsanF+jl+M05YQmyBv3V+9XTljx/gI1mQtMJW0gXMeqDQ8ZoJf9tWu/Ptxw9uS0GIwcKvC/kUlmQCfh6UP86lkcS4DGXxT4sJWToe/srrai8=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SJ2PR10MB7557.namprd10.prod.outlook.com (2603:10b6:a03:538::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 15:53:02 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 15:53:01 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle
	<schnelle@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Johannes
 Thumshirn <morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHci6Bw4Ah2IJD57EKH4IA39ueuwrVeM58AgAAjc4A=
Date: Thu, 22 Jan 2026 15:53:01 +0000
Message-ID: <55D00714-7744-4288-8D01-456296020CC9@oracle.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com>
 <20260122130957.68757-2-haakon.bugge@oracle.com>
 <9979743a-e4e0-fdfc-460b-fcad92d54f94@linux.intel.com>
In-Reply-To: <9979743a-e4e0-fdfc-460b-fcad92d54f94@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SJ2PR10MB7557:EE_
x-ms-office365-filtering-correlation-id: b893ea3c-75dd-4a3d-3b8a-08de59ce52ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE1OT2lLZGpCK3ZGZ1ZJeUI2Vm5CZmtRaWZlWGFCNXRFeElhcVlobVhldkNY?=
 =?utf-8?B?bVpvUGNYVlpJOUxCNDZFKzdtR01mc2ljYUhhNG9Ha1o4Z2lITGRoOEJOU3F3?=
 =?utf-8?B?Q1hOQ1kwUDBlMFA5bEJ4RjJadXJOZnk1L3h6ZUFOdTlKb2Y2ZThuT2xacEZM?=
 =?utf-8?B?LzFXRzh0YUd4ZGN3a3BkYWZiaHlvbXlkMGhhUEo2Y3lzQlZ5YlJmU1FWTWVq?=
 =?utf-8?B?UFMrZGkyWWplbTJSQ3Z2Y3BHbjBxZkErejhMWXFDNis0NW92eVFsc0JnaVF3?=
 =?utf-8?B?ZzEzSXFxWkFiMzQ3TDNHMjdWQjhjZUNIMUtOeExhVnRUMTZmM25PY3c5VEdL?=
 =?utf-8?B?OUszSHczRjdpeHJQR2pSbVVhQ0ZmL1Z2L3pqN1B5cmpQcWZCQWl5ZHJBam5l?=
 =?utf-8?B?QjJTcmcxOFN3VURCOVJhQmREV2thWTVkeTlOMlA4c1VlR2tiakdGM21yUHh6?=
 =?utf-8?B?VE9FYjVtcFZJa0diZmFlcWFXSklLUmFnQm0xSzhaVjVmc1MzUFAzQjhtTFMw?=
 =?utf-8?B?MzBnNjBMOUxvQ09KbDhIZWVFemxyUHFBek1NcDVDMnA5eDhpbnVST0h5QkRI?=
 =?utf-8?B?RHlzVlFrbGE0dnF1SkZTVnBNM215alplTzBWWWZWNmlJY0VtWGlDVGJSV2pp?=
 =?utf-8?B?b3kyUEtXWGpoa0VCM3FDL1R6QTNrQ1ZDYldBazFYdXBpbDZCeWUxWjdkK3Rk?=
 =?utf-8?B?ZWFuL3NDdmhhcXdaUGFmRHIrbXIyTXhuZGY2RC8yS2RpT1ZnNElSNUkzSTlW?=
 =?utf-8?B?cEk1aDlkVENtWU5PYVhtcDc2YUFYR0ZBd2FaT3Q3MnpQVDJpNUxuYjd4L2VI?=
 =?utf-8?B?ZlpOaFA2NitDODREbUc5dW5VSi9jZVZtK1F0cTZpbE81NXNYTjAwOVVuS0wv?=
 =?utf-8?B?Z0F2TXdPaDJPWnk4Yk1JMnYvNEM0Q3VUeUYzUXdBazRKQVM5RFM2M0lMS2Za?=
 =?utf-8?B?NVJ3MkV2UXM1Vytjck80QUJsdys0VHd4alNGbmFJeUNOU0UwZitsNGQ5SEVG?=
 =?utf-8?B?OUVCS041aC95YnhscXJpT2kzNVAyMkJVTFFPRnoyREJTTU1KY0V4UnNhQis3?=
 =?utf-8?B?V3RNZFIzK05xUGtnR3NNV21GQnc0ZkFsU2pkY3U4ZUpna1dwVjV6bHYyRnFq?=
 =?utf-8?B?Lzc2ZUtRNHNNQjFFRXZrYXkxb3dtandwNEcxbTlJdE02dEtSWVQyYlhEUUR5?=
 =?utf-8?B?L0h1Z095RGFCR3llU3paS0lPK3dleTlFczZjQ2w4Uk11SVlNeW1CaE1neXY0?=
 =?utf-8?B?YXoxZFZrOU1UYXdidHJzZ0s5Zm5NV0doQVRqVFppOHFkWHVueFNqa1AvaUZq?=
 =?utf-8?B?WDVCMU5EMU1RMzc4WWNFS240enFBdHF1d2c5NlJBNVM0ODUwb0hISU1ZYmF3?=
 =?utf-8?B?dzFaZjQ5SURxQlVjeXR2YlBVenZaUDVxQm85VTg0NTg5S2R3NUhsaVZ3cStO?=
 =?utf-8?B?VFZ5Uy9KckZIOHdyajdDYmxTVUtJc2JOQUpjSmxwemdrZmc4L0hLbDk3MUlr?=
 =?utf-8?B?aFRGRVJFVC9uc0R1VWYxaGc2TWc0clFoMG83Vkd3bHp4VVVJNmNKZmFiMXN5?=
 =?utf-8?B?U2RzVkpnZUpESDJSSnB2aXBLV3U4K0RzaURybVdpSWF0ZmFJeWF0aFVMMVhI?=
 =?utf-8?B?aVZsMU04bGc2dVhTWEZQdU5vaDlCdTZiS21qdWM4c2dYUjZVVEpyUGZGZ1NV?=
 =?utf-8?B?ZUJUZk5ibTZ1YVNRT28rcktVdzNGN2dCUXhXejRBWm1QT0R1WUk3TWl1UUhD?=
 =?utf-8?B?YThHNnhGNysvaDZ1OE8yK2dLTE1KdHBuV0tzZGt1TXcyYk96UHVCeElFUXh5?=
 =?utf-8?B?UFFZMXVGM1VNYjVTMzd4SVNmemZQN0RabW44SGREZGR5eEpMYjV0RmR6NkZI?=
 =?utf-8?B?L3JoZVhuNk9vNEc5dWNCWHFmbkdyWFIyMzRNRlArQkczMiszMzFmdzRTR0FK?=
 =?utf-8?B?OHlvYXpQcitsQlJuTUcrcEUwL0dLOGxyU21iNXZ5VUJVdmVVOUNaVzhta0Vh?=
 =?utf-8?B?Vno1QkFEdjN2dExyaW5XK1pwdGRjbUZ1aEE3ay9WMjNBQmVTcDFzcGMvcEt5?=
 =?utf-8?B?TndQU1Rpbkk5eXpkQkVkZ3psRWFUWUNxOUlEdnJjclozWS95QmI5Z3pqQS9O?=
 =?utf-8?B?RnBKMFI4blJ2YTltbGVEaG5pck10Q29xRjBzR20zRG9CVjZUUlNDZ1BhNU9K?=
 =?utf-8?Q?UIIndsVfbmTWwGbo2rpEnPc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlZxdkNKREswMFFWeElka0QyT1ljdjNjM2FZeHVhRWs2WWIrb0Q4cVo1eVdp?=
 =?utf-8?B?b2Q0NWFtZWdqZWFsN09wRlhzMUt6Tkw2V3hxSGpZV3l6RnRBK3dDSzVZdUFa?=
 =?utf-8?B?aDZPRitMSEFRcTBmcmI2R2ZvKy9jWVJBN0d3UFN1TDRVdjUvTTVKRlhiWWdV?=
 =?utf-8?B?dnh6ZXFObUtyNm1XSUIrNlozeFNXN3VuQms3MmVtL3pOd2Z3SE1qSGt4dzJw?=
 =?utf-8?B?Ry82Z3RKejlmcGdmRzBtUTFJOGsvay9nMDJCMVVzRTdrenRHNzBJd3hQSkFx?=
 =?utf-8?B?SnZqS2J1UXNBQUFob3U0Sk14cGhqNXdoSVd6eElyMHVuUWl0a0RHZ0RqL0J5?=
 =?utf-8?B?UWdsNWl3N0d5VFZwTVpaTzNoQ3lFbnYxUEJBVEd1VDhYaCs5d3ZBbi9DczNY?=
 =?utf-8?B?ZkF6b0FMOHVUdGtrRjdBc2xmazJaRDFXN08zS2RmYXUrYUh1NG5BUGFpVWFD?=
 =?utf-8?B?U0o0VzFLUUIyeDlCeUJXTW5FZXpLdnpOVDRGRjQ1QlVHUmtZbVFDb0RNUDRn?=
 =?utf-8?B?anJqWEs3TDFpZzB6U244S2ExMWlmOENxVU00VkRadGxLVXlsNXJNNWhMK0RJ?=
 =?utf-8?B?bW1qZTNKa09UM21DMHphTllXNVJYSEUrTDFkVkVNZVhYcnNpeWUwcjFyeHdZ?=
 =?utf-8?B?aTk3MURqeFVKWEJaaXNMNDRFdDFDWmQ4RlNqOUtNVERKVnc4dnRTYXVVN0VN?=
 =?utf-8?B?dmF5OUVJQnh3TXJuTDFTNmxFRXhPMFZ1Sm1qUmpHYXoyaWx6WDhFZkJEcHhP?=
 =?utf-8?B?QVZJaXZZRlZ6QmovK2xHQnRnL0QrT1kwaTZWOE9NTzAydUg4MG14MEZhdnlX?=
 =?utf-8?B?anlNRi9qbm1QNnVKNXZOdW9TRGFKdForeTZYaGVQZithZ1dDRE9FVGRiNnhy?=
 =?utf-8?B?dHMxeVVRL01zbTdkS3FrbkJlVWhHQ0RRbGRyVjBqNVdLNG40NTNYTk1WRm9i?=
 =?utf-8?B?RXZFOEs3UjdFdlE3SlREY2xsZDI4ZllsMmE3ejJFVzdyWTBHSW1hd0R6ZmVB?=
 =?utf-8?B?UXd5dWxNQWpmVDBLUUtWMXpKdzlzQ3FHN3doWHV4SXp3ejFZZlBaRFF0UU4y?=
 =?utf-8?B?UUF5MWRJaUJVS3NvYmk0SkNDWmxva3RoeXZWTTBKM1FRNWx4OUhBSENPS092?=
 =?utf-8?B?U1pPa1l6TnZyZ0RvK1VKOXFSQmFON3JFbk45UW55aGhJcndPZEx3by9MOWZ3?=
 =?utf-8?B?eFFoVmVYTGk1OUdsL2hZTGdsQmsvOEFvdXlqakVHV2tkN0pxWXArVE5nalhV?=
 =?utf-8?B?STFtNTFNV0Rpc1N2TkZubGIveUhQbFZSblUrTlFHckxvNWZVZUdYMVdZSnB1?=
 =?utf-8?B?NFdaVDdtWEIzRERsY2hyOThLNHp6UkdISnZTTE55dHEweEFjS0xEblBIRjQ1?=
 =?utf-8?B?aVJHbFcwSGlKeXRKQU1FbWZyOHY5YXRMUGhvYnU2WUJyazlSTlFXTVBoUmE2?=
 =?utf-8?B?YTd1NFlXN1E3WW1XU1FqV2ZKN1QzMkhza3Byb0JrcTBybERqUmF6bERWU3JG?=
 =?utf-8?B?QTBnamcvNWVxdENuck1GdFduemhybG9JU0JoSGU3RnZEUmE0WFV1eUdsK29L?=
 =?utf-8?B?M0dneGJ5dStiT25uUEtDc25KZ0FhQkdqTmZnZlQvSzZGdkEwVVU5OThWQi80?=
 =?utf-8?B?c3l5M2NlbTNQSjhuSVdCaHZpMWQ1cGppOVRsVUM1ZXNuN2FocUN6Z09aWHpH?=
 =?utf-8?B?bUVad1ZSaXR3R1MwNjVEalRJWEd0WEFRTDVWTlpPcnJ6Q09ZUFpMclY1SGkw?=
 =?utf-8?B?ZHBMRGhkMyt4ek01STk4V29QVzNuTitYbFZ3Z20wRXlrcHJJbFlBVVB4UWdW?=
 =?utf-8?B?M0Q3cHV1UitxKy9PTk5OcEdhQlFhaUdWczZVZzEyT29jekxTZEhDYXBOYXNw?=
 =?utf-8?B?ODljWW42bFBWWHpHWkVMVDQ0NmhMUjNUMFRyVFNjaWcwUjVSM0I3VHdmanVi?=
 =?utf-8?B?M3hDYWF4WFlwS0RlK0hTU0R1NXNkY2doYlQzZ0wxVWQ3SlFGeWoxaWtNQitk?=
 =?utf-8?B?eHM1OXB6clVLem5RakZSd3pnbjdMK1Z6VkF1QXBRejZLYXpUYmNPNVhJN2xh?=
 =?utf-8?B?QUUyL3hQUUEyVXFGYWgzSkRBekdGQzFwS01CVkN1cmdiUnpUT1lFSC82SEFN?=
 =?utf-8?B?d2VqZWZUbXVSOTc2eDUxVFJyWTYxSE1sbGJTWkhjZkZieHI5RWFpejFsOG9q?=
 =?utf-8?B?cUFXVy9IRWNWM1lScWIrVi9JdE1CVFNac0N0VVJEWUtSZ1NDWHg2WTR1VE9y?=
 =?utf-8?B?Tm5pUEhaNyt4MDJ2c0U2QXpKdHdBekVYRXRhakFCM09qL042clNXczhZZU45?=
 =?utf-8?B?UTZ6dkRjbG9sMjR0OVVmdjNwbjFzeThoZXBsU1RaUW9uVlRMSThpQ1Z4S0Fr?=
 =?utf-8?Q?i4m2pX65LYIziee8z6uTKyJ3g6gIpSUKLvDL8sij+KeVE?=
x-ms-exchange-antispam-messagedata-1: ASYR8QZHFFSgEVEFy3I7eHokoUVCN+0w4eE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <775A0C64E6F2464C9316FD889331D0C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kX8WZH9e8SWzn5swQVPJBPGAg2ZOvr1A5SlLw5B6Goi0bOgSXNCwLhD6gk0T5s/QINAWhaBi9X2kT9CHcnKOl8yXji18Z3Y/4FKjikaPOOx16L3eHCSxpyqTN4/ymqZcNZf+Xn4x3kqQIJzHNG9yvpbSnXDnLdOCSVZE/6N40TdUyCsUEMaCfdPlQp7wnrHFB+fciKZMqUnrs3PD3ya411+o4caz+W8VzI2EcA0M2A+df7i+ZLTomIok/Qzx3Uj/nfzmfKw7/92SwsGDwPxzfupHzl3FkP0a2H+2gBhk5TVmj5m5YRAp7cofsEQjZqCBpTV0csg73cUURSMbcDuCiiG2i8aTUqKgSWDbLM+/O21scma/ws2LLdU0gPZVEqWlcwJEp8IuDRamKmQFnRSqdbPRFmpVhJsgbUtp9MtMXuGW6+wtbKVZwocQOTkXIiPeCICG7Evy0dxwqePpEQJasyT5BYOaM4ozfqJJUJO3gH7jt/cVWG+fe5ZmNGOeTaX8WIs7JBioxy2glBgB/2mlLxIMnAw2kBwqM5n2zGTCWjDk7MunuFcCfcmkjpKK2Ecmpwb0SUPJTpfqqxv4n8bEypjvhi/G/F88L0q6jSv9tg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b893ea3c-75dd-4a3d-3b8a-08de59ce52ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 15:53:01.9120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ctts/Q9o4zN3RvWHNs7wRBPNp6FFihB5UTugm06dGibfEgAEhtc0hAWZl4NNfZqF7R8HhddAYVCD0ztj95G2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220122
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=697247fe cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=njadWDDuWiJb05ZXB6YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ztNPeVqbvO4Y1IsuDPQtD_cpXV2TVquQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMSBTYWx0ZWRfXwEXJMg6D1Cuw
 EaBOGzqPyXhYJYMkcSxv3IQnNTYC95jkcnSHJq9dTs+iBwPOPQh9gDbWM8xguoE+RBoutfBbsx1
 3itIRKh+hCGqFvNLhhbGeDJnyD5XMUePpgEXoVJhmtKGTBrPe5Eq8SI67CAQwhM3ZSQ1O+7AG1L
 8yi511xKYCb3aQbZppZDaIaASZBjzP7oQ8R6ehLzj4cS1tmd+8C3MMBT6FPuENxz9CkJ6lsS8EN
 zbGuWdjbkrbjibQlky+WTR66I7TECiSW2/8L+XN42wY/vgm4rHCEts1W2ximhRwDGq63mjU3eGr
 pbqDt9mjRMQaGORi7JrUcJTW41m9Hcb/z7+KcwAGUCOmG3moJNCjr73wSjOVmp829ZhWN2GivEe
 RPb2xakCesvKxSGBlgVVOV7UL41/IV0V5q/ILHnb8x82JpHFwR2Zbh7n2/Z/JFxTj4VCrdbc/1L
 Y3QGr1tMKTMIJ9ue0lg==
X-Proofpoint-GUID: ztNPeVqbvO4Y1IsuDPQtD_cpXV2TVquQ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20559-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EA3426B426
X-Rspamd-Action: no action

DQoNCj4gT24gMjIgSmFuIDIwMjYsIGF0IDE0OjQ1LCBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2
aW5lbkBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMiBKYW4gMjAyNiwg
SMOla29uIEJ1Z2dlIHdyb3RlOg0KPiANCj4+IENvbW1pdCBlNDIwMTBkODIwN2YgKCJQQ0k6IFNl
dCBSZWFkIENvbXBsZXRpb24gQm91bmRhcnkgdG8gMTI4IGlmZg0KPj4gUm9vdCBQb3J0IHN1cHBv
cnRzIGl0IChfSFBYKSIpIGZpeGVkIGEgYm9ndXMgX0hQWCB0eXBlIDIgcmVjb3JkLCB3aGljaA0K
Pj4gaW5zdHJ1Y3RlZCBwcm9ncmFtX2hweF90eXBlMigpIHRvIHNldCB0aGUgUkNCIGluIGFuIGVu
ZHBvaW50LA0KPj4gYWx0aG91Z2ggaXQncyBSQyBkaWQgbm90IGhhdmUgdGhlIFJDQiBiaXQgc2V0
Lg0KPj4gDQo+PiBlNDIwMTBkODIwN2YgZml4ZWQgdGhhdCBieSBxdWFsaWZ5aW5nIHRoZSBzZXR0
aW5nIG9mIHRoZSBSQ0IgaW4gdGhlDQo+PiBlbmRwb2ludCB3aXRoIHRoZSBSQyBzdXBwb3J0aW5n
IGFuIDEyOCBieXRlIFJDQi4NCj4+IA0KPj4gSW4gcmV0cm9zcGVjdCwgdGhlIHByb2dyYW1faHB4
X3R5cGUyKCkgc2hvdWxkIG9ubHkgbW9kaWZ5IHRoZSBBRVINCj4+IGJpdHMsIGFuZCBzdGF5IGF3
YXkgZnJvbSBmaWRkbGluZyB3aXRoIHRoZSBMaW5rIENvbnRyb2wgUmVnaXN0ZXIuDQo+PiANCj4+
IEhlbmNlLCB3ZSBleHBsaWNpdGx5IHByb2dyYW0gdGhlIFJDQiBmcm9tIHBjaV9jb25maWd1cmVf
ZGV2aWNlKCkuDQo+PiANCj4+IEFjY29yZGluZyB0byBQQ0llIHI3LjAsIHNlYyA3LjUuMy43LCBS
Q0IgaXMgb25seSB2YWxpZCBmb3IgUm9vdCBQb3J0cw0KPj4gKHdoZXJlIGl0IGlzIFJlYWQtT25s
eSksIEJyaWRnZXMsIGFuZCBFbmRwb2ludHMuIFRoZSBiaXQgaXMgJ1JzdmRQJw0KPj4gZm9yIFZp
cnR1YWwgRnVuY3Rpb25zLiBIZW5jZSwgZm9yIG90aGVyIGNhc2VzIHRoYW4gQnJpZGdlcyBhbmQg
UGh5c2ljYWwNCj4+IEVuZHBvaW50cywgd2UgYmFpbCBvdXQgZWFybHkgZnJvbSBwY2lfY29uZmln
dXJlX3JjYigpLg0KPj4gDQo+PiBJZiB0aGUgUm9vdCBQb3J0J3MgUkNCIGNhbm5vdCBiZSBkZXRl
cm1pbmVkLCB3ZSBkbyBub3RoaW5nLg0KPj4gDQo+PiBJZiBSQ0IgaXMgc2V0IGluIHRoZSBSb290
IFBvcnQgYW5kIG5vdCBpbiB0aGUgZGV2aWNlLCB3ZSBzZXQgaXQuIElmIGl0DQo+PiBpcyBzZXQg
aW4gdGhlIGRldmljZSBidXQgbm90IGluIHRoZSBSb290IFBvcnQsIHdlIHByaW50IGFuIGluZm8N
Cj4+IG1lc3NhZ2UgYW5kIHJlc2V0IGl0Lg0KPj4gDQo+PiBGaXhlczogQ29tbWl0IGU0MjAxMGQ4
MjA3ZiAoIlBDSTogU2V0IFJlYWQgQ29tcGxldGlvbiBCb3VuZGFyeSB0byAxMjggaWZmIFJvb3Qg
UG9ydCBzdXBwb3J0cyBpdCAoX0hQWCkiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dl
IDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+IA0KPj4gLS0tDQo+PiANCj4+IE5vdGUsIHRo
YXQgdGhlIGN1cnJlbnQgZHVwbGljYXRpb24gb2YgcGNpZV9yb290X3JjYl9zZXQoKSB3aWxsIGJl
DQo+PiByZW1vdmVkIGluIHRoZSBuZXh0IGNvbW1pdC4NCj4+IA0KPj4gdjIgLT4gdjM6DQo+PiAg
ICogUXVhbGlmaWVkIHRoZSBkZXZpY2UgdHlwZXMgbW9yZSBzdHJpY3RseQ0KPj4gICAqIHMvcGNp
ZV9yb290X3JjYl9zZXQvcGNpZV9yZWFkX3Jvb3RfcmNiLyBhbmQgY2hhbmdlZCBzaWduYXR1cmUN
Cj4+ICAgKiBEbyBub3RoaW5nIGlmIHRoZSBSUCdzIFJDQiBjYW5ub3QgYmUgZGV0ZXJtaW5lZA0K
Pj4gICAqIFJlc2V0IHRoZSBkZXZpY2UncyBSQ0IgaWYgbm90IHNldCBpbiB0aGUgUlANCj4+IC0t
LQ0KPj4gZHJpdmVycy9wY2kvcHJvYmUuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykN
Cj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9w
cm9iZS5jDQo+PiBpbmRleCA0MTE4M2FlZDhmNWQ5Li43MTY1YWM0MDY1Yzk3IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9wY2kvcHJvYmUuYw0KPj4gKysrIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0K
Pj4gQEAgLTI0MTAsNiArMjQxMCw1OCBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3NlcnIo
c3RydWN0IHBjaV9kZXYgKmRldikNCj4+IH0NCj4+IH0NCj4+IA0KPj4gK3N0YXRpYyBib29sIHBj
aWVfcmVhZF9yb290X3JjYihzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29sICpyY2IpDQo+PiArew0K
Pj4gKyBzdHJ1Y3QgcGNpX2RldiAqcnAgPSBwY2llX2ZpbmRfcm9vdF9wb3J0KGRldik7DQo+PiAr
IHUxNiBsbmtjdGw7DQo+PiArDQo+PiArIGlmICghcnApDQo+PiArIHJldHVybiBmYWxzZTsNCj4+
ICsNCj4+ICsgcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChycCwgUENJX0VYUF9MTktDVEwsICZs
bmtjdGwpOw0KPj4gKw0KPj4gKyAqcmNiID0gISEobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNC
KTsNCj4+ICsgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHBjaV9j
b25maWd1cmVfcmNiKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiArew0KPj4gKyB1MTYgbG5rY3Rs
Ow0KPj4gKyBib29sIHJjYjsNCj4+ICsNCj4+ICsgLyoNCj4+ICsgICogUGVyIFBDSWUgcjcuMCwg
c2VjIDcuNS4zLjcsIFJDQiBpcyBvbmx5IG1lYW5pbmdmdWwgaW4gUm9vdA0KPj4gKyAgKiBQb3J0
cyAod2hlcmUgaXQgaXMgcmVhZC1vbmx5KSwgRW5kcG9pbnRzLCBhbmQgQnJpZGdlcy4gIEl0DQo+
PiArICAqIG1heSBvbmx5IGJlIHNldCBmb3IgRW5kcG9pbnRzIGFuZCBCcmlkZ2VzIGlmIGl0IGlz
IHNldCBpbg0KPj4gKyAgKiB0aGUgUm9vdCBQb3J0LiBGb3IgRW5kcG9pbnRzLCBpdCBpcyAnUnN2
ZFAnIGZvciBWaXJ0dWFsDQo+PiArICAqIEZ1bmN0aW9ucy4gSWYgdGhlIFJvb3QgUG9ydCdzIFJD
QiBjYW5ub3QgYmUgZGV0ZXJtaW5lZCwgd2UNCj4+ICsgICogYmFpbCBvdXQuDQo+PiArICAqLw0K
Pj4gKyBpZiAoIXBjaV9pc19wY2llKGRldikgfHwNCj4+ICsgICAgIHBjaV9wY2llX3R5cGUoZGV2
KSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQo+PiArICAgICBwY2lfcGNpZV90eXBlKGRl
dikgPT0gUENJX0VYUF9UWVBFX1VQU1RSRUFNIHx8DQo+PiArICAgICBwY2lfcGNpZV90eXBlKGRl
dikgPT0gUENJX0VYUF9UWVBFX0RPV05TVFJFQU0gfHwNCj4+ICsgICAgIHBjaV9wY2llX3R5cGUo
ZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUkNfRUMgfHwNCj4+ICsgICAgIGRldi0+aXNfdmlydGZuIHx8
ICFwY2llX3JlYWRfcm9vdF9yY2IoZGV2LCAmcmNiKSkNCj4+ICsgcmV0dXJuOw0KPj4gKw0KPj4g
KyBwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsICZsbmtjdGwp
Ow0KPj4gKyBpZiAocmNiKSB7DQo+PiArIGlmIChsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0Ip
DQo+PiArIHJldHVybjsNCj4+ICsNCj4+ICsgbG5rY3RsIHw9IFBDSV9FWFBfTE5LQ1RMX1JDQjsN
Cj4+ICsgfSBlbHNlIHsNCj4+ICsgaWYgKCEobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKSkN
Cj4+ICsgcmV0dXJuOw0KPj4gKw0KPj4gKyBwY2lfaW5mbyhkZXYsIEZXX0lORk8gImNsZWFyaW5n
IFJDQiAoUkNCIG5vdCBzZXQgaW4gUm9vdCBQb3J0KVxuIik7DQo+PiArIGxua2N0bCAmPSB+UENJ
X0VYUF9MTktDVExfUkNCOw0KPj4gKyB9DQo+PiArDQo+PiArIHBjaWVfY2FwYWJpbGl0eV93cml0
ZV93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsIGxua2N0bCk7DQo+IA0KPiBTbyB0aGlzIHNlcXVl
bmNlIGlzIGVmZmVjdGl2ZWx5IGltcGxlbWVudGluZyB0aGlzIHNpbXBsZSBzdGF0ZW1lbnQ6DQo+
IA0KPiBwY2llX2NhcGFiaWxpdHlfY2xlYXJfYW5kX3NldF93b3JkKGRldiwgUENJX0VYUF9MTktD
VEwsDQo+ICAgIFBDSV9FWFBfTE5LQ1RMX1JDQiwNCj4gICAgcmNiID8gUENJX0VYUF9MTktDVExf
UkNCIDogMCk7DQo+IA0KPiArIHRoZSBwcmludC4NCg0KV2VsbCwgbm90IGV4YWN0bHksIGFzIHRo
ZXJlIHdpbGwgYmUgbm8gd3JpdGVzIHVubGVzcyByZXF1aXJlZC4gVGhpcyB3YXMgZGlzY3Vzc2Vk
IGhlcmUgWzFdLg0KDQo+IElzIHRoZXJlIGEgZ29vZCByZWFzb24gd2h5IHlvdSB3YW50IHRvIGF2
b2lkIHRoZSB3cml0ZSBieSB1c2luZyBlYXJseSANCj4gcmV0dXJucz8NCg0KTm8gb3RoZXIgcmVh
c29ucyBidXQgcGVyZm9ybWFuY2UuDQoNCj4gSSBhbHNvIHdvbmRlciBpZiB0aG9zZSBjbGVhciAm
IHNldCAmIGNsZWFuX2FuZF9zZXQgaW50ZXJmYWNlcyBzaG91bGQgDQo+IGltcGxlbWVudCB0aGUg
d3JpdGUgYXZvaWRhbmNlIGlmIGl0J3MgYW4gdXNlZnVsIHRoaW5nIChjYWxsZXJzIHNob3VsZCBi
ZSANCj4gY2hlY2tlZCB0aGV5J3JlIG5vdCB1c2VkIGZvciBSVzFDIGJpdHMgaWYgdGhhdCdzIGlt
cGxlbWVudGVkIHRob3VnaCkuDQoNClRoYXQgbWF5IGJlIGEgZ29vZCBpZGVhLCBidXQgZm9yIHN1
cmUsIG91dHNpZGUgdGhlIHNjb3BlIG9mIHRoaXMgc2VyaWVzLg0KDQoNClRoeHMsIEjDpWtvbg0K
DQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpL0VDRTI5RTMyLTc5MjUtNDRD
My1CQUFBLUIxNjAwM0U5RTk5N0BvcmFjbGUuY29tLw0KDQoNCg==

