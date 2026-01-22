Return-Path: <linux-acpi+bounces-20534-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHCuEkwLcmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20534-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:34:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C668466121
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96EB78E2688
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6D43D517;
	Thu, 22 Jan 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lIZTuzB9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FTnkLhWZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034743637A;
	Thu, 22 Jan 2026 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080419; cv=fail; b=inSvzMPVjB6jFfYelKLexOd72EqEEuIc0SyLfQhvdIApzBsp8oc2Mfq2fRpunFwpdohKySfHYTjkNL3UEKdneN7l7jXdGGj0Tovw47uobf6Ms0tWizHNYTHKO8aEUryc15VkToSz/vii9yPUWRNV3cYZvLvRP7B8xh2Jtt/OtGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080419; c=relaxed/simple;
	bh=v/81TD+36YydshrbVJIejhY9sOnOsvKWccGCf12YBSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qAsUh24R1E2AqOcDnEw4npQ5A+D+8bvkaKLxCEmv7PsTuTBWL0HYQsiCX+HVgMF1kKBP9q4ksYBKSY4QeMj55/QkggT/FmHUq+FKhK8PgsM0zGNccvLL5YV1pPFubX+1OMk9rZddpZPlzIOJNz0EFyHxjo7OlTXI00KM4aDCyIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lIZTuzB9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FTnkLhWZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M2qFJa3033291;
	Thu, 22 Jan 2026 11:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v/81TD+36YydshrbVJIejhY9sOnOsvKWccGCf12YBSQ=; b=
	lIZTuzB9y+JTiueCf73Chn4mri5dM9Dviko64F1fi5tDXdQjlg9RkUBL6L1aytCh
	gsn1804jjPrhdsg+gPhwCX3HPNeVP7LLjpcfpSBV79IMoPnvb8vKpVyORjBdSEPQ
	EtKpvsyw54Ylce4mtcjDYrhUqIvrIZUwbtBmNX/6vM6lkGb48Zi/pzJkZ7y4y+j5
	WKSglFbA+fdtG6Dj6ETscB7Qq4Qyga9NpV17A/Wxn7o7anww67MfJONkZ1wFO3rM
	cFEFBCERWwhlhctgfvbVna4EVW7893Egx9pvTAC2SsXHgO+BNhWWr20NeMICD2+N
	MezPS7JTsZb674ASnvQg5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypyesp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 11:13:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MAhffi025036;
	Thu, 22 Jan 2026 11:13:27 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujcyrvyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 11:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVjaO7pI0IVjrwYN2mtRJSO2IMS0BEkFG1ToI8P2VqWd+ceY0A60150KddExXD8JZYTLCUMhYGC2/NX6C/sOGvZkz5/N0eABP33kFcyJ/KTmmM+OwB8Z7vyMcFiAwhMQYngtm7TtJG0O1wHwdCfrZN/XTUUdtJB37uUVWALR5oivM4eo1Ap2ilN/do1a/BeWV5XmM1rMni2n30EWkH7jkJPd7IiC5bTCdWiJ7G+OF6UJAZnum/hkh47g+vkXY4eN9hAus0C4u26xFWKunak5bcXo1OG4/QSsvt9MmC6pxdEsrZBIO68wJ7wYE5jR3QneffSopnLpf6EFhJyzD1Xisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/81TD+36YydshrbVJIejhY9sOnOsvKWccGCf12YBSQ=;
 b=waymvUbE+Ujk4CmEUBVxsFx1FmskztbdSL+Cto1QTlsRH3mOB7x6VqH0TObOvREE2mk8pe38fK93JXS1gzrtrmeAUyCwJ9pOpgPchnXlvZ9NmBLzt0tP3H7ktE4dtYEsiYjmj4N/TzoPEY/dsJlCD3gBlef017lGhVx94dJvUijJhqJ7zowHQszucZ+8Kao2UCgSQcXd0nJztqVTauGfQfDe7VYnsPxi5Nm5cYkLcEfeCT9O+TSLnnAvD8N/VYq/wpcKfZi76gbbfWKMv+3UdNY3hOWYNNtIS0u/kPJxvKyDDZeidCVQbjhEnz+WgDbPTD9htHPUpmRSMqmzEXmSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/81TD+36YydshrbVJIejhY9sOnOsvKWccGCf12YBSQ=;
 b=FTnkLhWZwabwbJE/5ORT0ka1aZcVlFT6YXdJG45SzjdZH8pkAUXWjyH9MtvHPexIJ2SE0/9qfNLJkS0ZYz4K1yDmsJZaaYzGoLUFPjaT/W4Vo4j4zZA9AzaMdGwYqgniwM4CWMuKit1xCgm7UEa+Y+Z2/KblLAjgGUbFDcyI7fI=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 11:12:57 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 11:12:57 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn
	<morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        Alex Williamson <alex@shazbot.org>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHcisoZzKcoj8C3rUu16aNbYxRdzrVdODgAgADIQYCAAAOKgIAABBqAgAACYQA=
Date: Thu, 22 Jan 2026 11:12:57 +0000
Message-ID: <7D64C761-1928-44CA-9548-106F7DCA2DDE@oracle.com>
References: <20260122110415.GA1241583@bhelgaas>
In-Reply-To: <20260122110415.GA1241583@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|DS7PR10MB5070:EE_
x-ms-office365-filtering-correlation-id: a78c05d9-9f9a-4f29-4a31-08de59a73259
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1NKMDZKOTdEbE56T1l4Y2NsV1RwN0k3bDdFcGRmWVNMRDRSVGR5YUgrNC82?=
 =?utf-8?B?UVFtR1ZjdDF1V25aU1FmaHpTWkxOdlh2THhGaW4wYmJsMUFuYkJ2c2owQVZ1?=
 =?utf-8?B?d1dlaUI1NXMxS29SRSswTzg3TWIzTkQ2MmxzTGtuMFR0UmhBOGVtZndLYUVi?=
 =?utf-8?B?WTNDcUtpanZZSHF6cjkyMFNpcTNFZjNsdHdFTXNCcHh5UUs1cFF5SWJqRVBX?=
 =?utf-8?B?dXJjdWtXeXdLeFJ5SnFxSWluNWs0QVJ4ZldLTUJsR2U5MW9OK1A1dXFxS282?=
 =?utf-8?B?WVFvOHJQamp5MytyQjN2SGFTS3ZBOGR5MFF0WEU5enErZXdtTXhTRjVoMWRB?=
 =?utf-8?B?bkxSd3JDai8wU2IvUmswUGlNMU5mYlhFU3UrbEFpbFVvNmhOSFFHMmd5Sks2?=
 =?utf-8?B?QlVrV3dKb3ZXZmQ2NE5kaForM1FMSEVrS1U1YkpUWnQzelJNSnJlTUgxTjZ4?=
 =?utf-8?B?dTBLNVA2bWRadnpQdFdUaVgzTjA5cGRxcEl3T2R4WHExVFZDMktyQzZxV3pI?=
 =?utf-8?B?eU5FL2F5Q2doeHZqVnA2MUt2bWZQUjBGU3RzYVR6RVQ1ZXRUT0Q2dEpjd0xJ?=
 =?utf-8?B?dXJOTFZpMzhEUU9NYk4wbUxES0VCc2hJSG84dEJpMkcxNlVxL25BR1V2QW5M?=
 =?utf-8?B?SkxEQ0ZibGhtWkduRGttc1QrWmZWMlFYZGNEdVA4VTIvb2lwT1dNODdlL1h2?=
 =?utf-8?B?RW5qancwaXF5UGl6eVB5ZzNUVG83ekdzQWtreVdnL1pXYjIwa29yblduSUZN?=
 =?utf-8?B?d2ZZZTk0TGZJblBqL2M1LytwckxTUTg2K2QrRW5XQjJMRVJzNy9lOGVGcTZK?=
 =?utf-8?B?U21Qd2M5ZE5iTm40MWMzbzVmcDNwVHFoODM1dWk2K3dHeUU2SERwTjY4cWtO?=
 =?utf-8?B?Q2p4dHZ6elAzcHErcHhabDVPUEluMFNpd2ErZ0I3aGhFRFZwZGtqUWxhVEhn?=
 =?utf-8?B?VC9Mb3NTV0wrSXA1cVV3d29yamFJNTl6cnJUY1FNRllNa1JIRlhFQzZJSURh?=
 =?utf-8?B?QVg1STluak1IVEJETGRqNUoybXc1bC9UNGFKSlFGZlAxMGQyYzhaRHpKT3hz?=
 =?utf-8?B?Q0RycEVkL2NGNW55UUpCd2s1UUw5R0NjWUY4Wk83Zkg0RVdMRXZrVXk4Ylk1?=
 =?utf-8?B?ZFh4Qk5uaFhTeUVlZE1TK0JqL1NYVEZERDNQQmdmWUxMUWdNT1hsSXBaa3h2?=
 =?utf-8?B?Mmxpb2hHMHlsSW9ETHFJY0w5dnRhM2FvckdORGc5bEZZQ1B6WE1RSUp3OXVD?=
 =?utf-8?B?L1o2Y3dUTlpVSGJjdFM5dGs2MU8vbW9xbGVxQjVXZlJINm9RQUN4bjUrZW5l?=
 =?utf-8?B?ekxYZGpnTXJBZUlDd3N4dGpDQVJZeTIrUHo0Q3dQY1FiUjRHaWpob1dyKzR0?=
 =?utf-8?B?NkdCM0FxNkl6aXJIQ0ZKMXd4ZXVrWFEzbktNd0M2WTZZZnhHaFd4YXZZOHF3?=
 =?utf-8?B?TDl4RWladzhFWGR0QUFwbjhrN1NZMWM0SXJNZmdFYUJ0ZGl2TEdqNThXa3V2?=
 =?utf-8?B?QnJtMWxlNm81Tjl1V1MvWGZPWXlxaVpZUXlKd0pFUm1sbVR1eEFxMU04YUx4?=
 =?utf-8?B?U1dpT3NEbWt4LzB4UTZiUjBPb3ZtM1BtdWpZWVBZSUlrbDdOWnpOalkxUmFS?=
 =?utf-8?B?SjdyMGFRTHlxSWh0ckF4M25xWG9WTmtwR01zMmtrdFI4VVo5WW9zYUp5ZHBK?=
 =?utf-8?B?YytVenRHK1d3c0EwQlpCMkU3NEloT0JlRVZjRkVOZ1ViYVFmU0NDZ2hQVnZL?=
 =?utf-8?B?Qlc1bkc0d1l1R2xPblpYc2hkZ1V2M04yQXNzRElKQThvT0tESndMdUxuM3g5?=
 =?utf-8?B?emRxUUdMU1F0SkJNYmJZc3BDQzdTcUJMM1FxSUR3R3o5WTVSS0pwVEtsRHBm?=
 =?utf-8?B?MklxR2pFbTZWUmRqWmM0Q1gzWFlMdTFlQVZmMVJkcENvcC9ST0FhbDl5NTRB?=
 =?utf-8?B?d2c3OXR4U29hZ29rZTFoZFZ3YTlrSFFZSkJvZW9IdGRjcFFMYkZxWUF5QmhN?=
 =?utf-8?B?Q2w3SkJXQXhCZnJWbXJ4YytSaERpcEJqdFR0WUVLZ09WeXFlU0FGY0FXUXZa?=
 =?utf-8?B?R2k5YUJiUy8vcURSMjV1cWpNZzZVOUd6dnhFMDd6Y3ZvRmNUTTVtK1hWZ1VV?=
 =?utf-8?B?VkZmOHBaSjYvSGNIalUyamR6c0FBQU1jemV5WlBYc0FGQlpZc1M4QUN4ZTdw?=
 =?utf-8?Q?1Plf79OhJeSGfKTsWWdnw3o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnlhbjBUeGQyd2dBSVdYRFZDdGZkNWhvMUdEYmxrUmhOM21FNlNwWFBKL0hG?=
 =?utf-8?B?WWRWZVdSTGJZR0IwZ1lmRUg5MGRoMWJaQ2h0TG5YSlUyMHJHSlBhTDlmaTNJ?=
 =?utf-8?B?eDlySXJTdFFITTljaHB5YXN3cW1ROE5YcGVJaVZRaFZ3MStXb0NKUnhPeEpp?=
 =?utf-8?B?ZEhlZGJNNTZaS3g5UnZkeGdreFJIVWxUYUFDekR3bWtxc2tkcWVXcEVBWVBJ?=
 =?utf-8?B?c0JRL1dYMy8wdHd0Zms1eUdzMXUyVTZLVnBhYlpZczczZlBqYUZKblN0RWZD?=
 =?utf-8?B?WU9XL0lFL3h4Z2RHaGxSWDFPNU9obnhIMmp4akxtTlBhUXc4V2NsR3RVWkg1?=
 =?utf-8?B?ZnoxbDkvSGlhNFVGNXBVaXFIRkJCaHBhWlBGZDA3UEkrcFZJZHdETFl5NDBx?=
 =?utf-8?B?MmszaVlrZEYvMmVMQVd1M1VhRnJBNWVqOW13T0EyNmRIQk9zaGVvd0p4Ym5X?=
 =?utf-8?B?T3pGdm43MXNrUlNOdk5vcmx5akRnV09WR2JHTEtPTkE0NGx4M3FJR3QwTlVS?=
 =?utf-8?B?MGVud2hDeWRvbG9yczRjeko3YlBwdHRRaXU2TElRMjdOdmNBaUhXOUJCL0dD?=
 =?utf-8?B?R3JpcWVwcEUvZXFkNGhTaE9mY3l4VzZ2VjJWY0o3SmdDdFdUQWxOeDhwVk5P?=
 =?utf-8?B?VWZuamV3eEVteEdmM0xXcEZaNE9VR3JaOHpmWG1ZR1hkdlZ2czR1MzhwY2ZJ?=
 =?utf-8?B?OVdWclV0TVhhaThCWTQvNWFXcnBzUEl6UVB5ZkFwTHptNTA1YkxrYmwxUVNL?=
 =?utf-8?B?dHl0TkNqOG5Cc2JIODN3cXNMbzhjZkd1S3dXSFJ5Wlc5eENFelk3NEdlampw?=
 =?utf-8?B?Q0ZGcFF1d2g5djdJNzNHaXNZR3dHeElPTzVNUUIrQmorTlFZZnp4MGpOYldI?=
 =?utf-8?B?RWkwc1hrbU1Hc2pOYi9hUUo2a2szWWViUE1GTXhtRXN1c2E5eWhDM3dCUkti?=
 =?utf-8?B?UHM0dnVwU0d1MTZtT2ZCMmZqSU5OZlV2blRXcHBxMDJLS05xdXV1UFhnTEY5?=
 =?utf-8?B?N2FNbzZLcEZmV1haYUY0cGFZRUFGSFBuWXoweEl3Z3hVb21BM2pEQ0RpbnpU?=
 =?utf-8?B?STJSdnJWcnEyOHpwTmZzUzAvWSs2VkUvS0FIc3BkLzZjRVQ3cWtJQmpyVUJU?=
 =?utf-8?B?UFA5WXhGS3g1cG5RUnZNT2IweFdWNmgrL05ia0hDRVQ2SThadkZ1aVFYa29y?=
 =?utf-8?B?Wmd1LzNFeHoyWkdZREk3azBGNEZVbmNQeCtieS9VVWI0MGR1RGl3UWxWWkkz?=
 =?utf-8?B?cmFDUk9wOTFvY1BSU2dMVTZhV01IV1hNY0E4KzN1VDNacnp6OVUxdFdVVTJN?=
 =?utf-8?B?S05EVDFObGpzZ0JidzFUNEVxSkhTUjFXa2Myak5QemN4Zk1nY3p3bmNCTGNN?=
 =?utf-8?B?R01GbVJCam91SDlLdVF5VmY1N2sxbVp1L1p2WmI1bnhreXVtT3YrUVN2UXho?=
 =?utf-8?B?dWN0dm1vNEZaL2RKOEtTem5rbUhJeWl4NHUxbzY0NURwbmwxVkhzTFlhK1My?=
 =?utf-8?B?UHoxRkV2NnZlc3VTOUFaazdoSm1oNlg2ZGpDUSs3UUZwUG9yNGNYWkVJWTRC?=
 =?utf-8?B?djNYdjFkUnZnOXJ4MHF4L1c4c0FoZDhaN2VkSkowM0VyQkIra051ZUxjYUh4?=
 =?utf-8?B?YmZUZTZxdDVBZmd2dWw3ajJ0VlhGazE2QSszWTV3c1hkYnFxdVFXS3M3eWxL?=
 =?utf-8?B?cVVYUjVXU3ZFR09McjFDL05sOTFoZk0rZG96UW16MnNPMjgyTEtBSnlCNHNu?=
 =?utf-8?B?cVUzTE13ZmFXZXFLeGFsM0JOd2dPWHZzYUdhc2FmQS9LL2FqN2EzRFlvK0g3?=
 =?utf-8?B?Z0g1VDFXWG1nOWhweDQyNjAzZ2NSVGdpWWdyVlcrWWVBOUxTejVYeTN6Zldn?=
 =?utf-8?B?Yi9KSDl2M0Q0SHh6VXVjc3AxdlNTQUZiOTJYRmI3cVVDWTFnRmg1a0ZmL3I2?=
 =?utf-8?B?OE5hNFF0d1ZDbnN4NGE5ZTVkM3ZJS0NwNW5mRFE0VkU2QzBXUFpDUGRpWlpS?=
 =?utf-8?B?eFVVZzVOT1NGUGVlSi9XS0RIWjNJbnVJclZ0UGZDY21HaG9oSUxnZ3ZBbzZI?=
 =?utf-8?B?a2tYbTZZWmVkUkdJNzVJdDVWUmIvTkQyVysrdktMTElocTBvajY4Q0loY2RT?=
 =?utf-8?B?ZWhWRUh5YngzUGJKR1JhYVZsNzRESDc5ZmRhK2hwVUhWTmxtQXEzL3JrKzBM?=
 =?utf-8?B?a2NIRjdvKzk5WFRubC9ocTFiVFdCYWc5TU12bDF2NW9nazI5WkVkUytjOHph?=
 =?utf-8?B?VDZweGR3bFR1a1lRNllNZGJzekhmSG94ZkRIdWFZTG9LN2tyempGUlhtWGx2?=
 =?utf-8?B?bU4wcGRLaWxVVDFZR3JBMG04UWNqcmFDczZGZEFJUmd5ZkpjRTgreHRjT0p4?=
 =?utf-8?Q?aVJ3aOBOsx2RM/3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95F49CCEEE66E342AE59FA812DB46626@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HAVOLntcVYU1TCrxmzN3EHQIkrzpwldt9dp0Fl8C3+NBxi2GrMPvTn2MasSYpt47aqv/YbfCplTVdjhhcAggYNTBENPvFvInCjIGsIr09GQ+b7ofw3+wPB4vcnt6rKM2qrb0tpZ1QMY+fSe41I76UBk0KkKHDiUMCjOlv2ttw6331x4SPfjJy1/9xRP06GvvGxnwqsWqsZbHulSyJv1ej4VjDY5dpEXI6aX5+dttCjkBaQDeVP6DhZWRIIHKXVySX2xyUR+oK4hZ/O+PRk2d2ZHJZDb2misbb1SjmzgxmI92rBoo2u8l3FRXNDReU6Zj0h0ByM9xCuzoIemQCIMn4d2l6+s4fZ3kDwV8eExaLJzXvQGJmfWprw6jC9U5mZNyhOlXato+oT7cYOjTfBEQOKhx/6rk7DAwuyiOmS8xBpvWYgbfITYi00KU219ZUbHB9qsS40nEdxwPKDfm1pCu0M1DBaC0bOGDdpbTGnRkxVrhpKv1e5AgFQ0WJbBIHivPhx8KMrbMQsWx4nkvpXk/YvLmxhRxrBSHRN6g8/5iRaRxTjdu5hab/TZBmRPcgiM00ZmfCa2GeraLVMoqAU0pY/JphWd2i9+841JgJTU8NEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78c05d9-9f9a-4f29-4a31-08de59a73259
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:12:57.1759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReB5J7KWVBhy9ZBS1bny4JY5BimNWoqOfYoudLuQrTdeVm8rsmr+q8kt5RZs36NMEPmqCMHyO7v2oU/EK52dpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA4MSBTYWx0ZWRfX9qYcSkrOZaVB
 Em61itnl2S25D9t83vzVxAerolbMB2l7eGQrjJnJ1y1wk2sW4JKV6KkERpPUr9zbbmlBsH6WFv4
 g2//6xk1HanNLuqAd4LLxO7X4sBX2ApmgdfwiZ3aywJ1K3ZQd1Vnsch3CudWkTzZhkD2J46lofd
 EG9HdvkmNf9qkt1APmwrWx5T/i8o0LI3rXhvSotRfe87mi/uYHRKhzlv44s1M0ptjGoQx1Ydy/6
 aJnUXRld3rucexJHuMDf6+Lm5l35AmUJEoYdWtjZn+mqt3yTzfuUtGOXQU8rxXqcmGo80WeLZ99
 6Vnlw45Uu3XjzeaMi/1gd/2LU7nIKi8+uqkYIQbgn0rQGbaNJa02bm7Il+FLqz8B9ihhAenRNOp
 NABfB78TwN6XvoPyISwCC+o/kIoVUwaaFRRuvRl52PFM4N/wZ904hwDnUid2Z74fdd/LulAp2If
 shmy7OaFKUxrnncsXcJa3Lat+k7LTNPV54ziVoao=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=69720658 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Pyz7aAjdUDOgwJ5xZsgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: J6krHwjbVpMYM4UVvIG6kpEOaL4ZY9Wd
X-Proofpoint-GUID: J6krHwjbVpMYM4UVvIG6kpEOaL4ZY9Wd
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20534-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,shazbot.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C668466121
X-Rspamd-Action: no action

DQoNCj4gT24gMjIgSmFuIDIwMjYsIGF0IDEyOjA0LCBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKYW4gMjIsIDIwMjYgYXQgMTA6NDk6NDVB
TSArMDAwMCwgSGFha29uIEJ1Z2dlIHdyb3RlOg0KPj4+IE9uIDIyIEphbiAyMDI2LCBhdCAxMToz
NiwgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToNCj4+PiBPbiBXZWQs
IEphbiAyMSwgMjAyNiBhdCAwNDo0MDoxMFBNIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
Pj4+PiBPbiBXZWQsIEphbiAyMSwgMjAyNiBhdCAxMjozNTo0MFBNICswMTAwLCBIw6Vrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+PiBDb21taXQgZTQyMDEwZDgyMDdmICgiUENJOiBTZXQgUmVhZCBDb21w
bGV0aW9uIEJvdW5kYXJ5IHRvIDEyOCBpZmYNCj4+Pj4+IFJvb3QgUG9ydCBzdXBwb3J0cyBpdCAo
X0hQWCkiKSBmaXhlZCBhIGJvZ3VzIF9IUFggdHlwZSAyIHJlY29yZCwgd2hpY2gNCj4+Pj4+IGlu
c3RydWN0ZWQgcHJvZ3JhbV9ocHhfdHlwZTIoKSB0byBzZXQgdGhlIFJDQiBpbiBhbiBlbmRwb2lu
dCwNCj4+Pj4+IGFsdGhvdWdoIGl0J3MgUkMgZGlkIG5vdCBoYXZlIHRoZSBSQ0IgYml0IHNldC4N
Cj4+Pj4+IA0KPj4+Pj4gZTQyMDEwZDgyMDdmIGZpeGVkIHRoYXQgYnkgcXVhbGlmeWluZyB0aGUg
c2V0dGluZyBvZiB0aGUgUkNCIGluIHRoZQ0KPj4+Pj4gZW5kcG9pbnQgd2l0aCB0aGUgUkMgc3Vw
cG9ydGluZyBhbiAxMjggYnl0ZSBSQ0IuDQo+Pj4+PiANCj4+Pj4+IEluIHJldHJvc3BlY3QsIHRo
ZSBwcm9ncmFtX2hweF90eXBlMigpIHNob3VsZCBvbmx5IG1vZGlmeSB0aGUgQUVSDQo+Pj4+PiBi
aXRzLCBhbmQgc3RheSBhd2F5IGZyb20gZmlkZGxpbmcgd2l0aCB0aGUgTGluayBDb250cm9sIFJl
Z2lzdGVyLg0KPj4+Pj4gDQo+Pj4+PiBIZW5jZSwgd2UgZXhwbGljaXRseSBwcm9ncmFtIHRoZSBS
Q0IgZnJvbSBwY2lfY29uZmlndXJlX2RldmljZSgpLiBSQ0INCj4+Pj4+IGlzIFJPIGluIFJvb3Qg
UG9ydHMsIGFuZCBpbiBWRnMsIHRoZSBiaXQgaXMgUnN2ZFAsIHNvIGZvciB0aGVzZSB0d28NCj4+
Pj4+IGNhc2VzIHdlIHNraXAgcHJvZ3JhbW1pbmcgaXQuIFRoZW4sIGlmIHRoZSBSb290IFBvcnQg
aGFzIFJDQiBzZXQgYW5kDQo+Pj4+PiBpdCBpcyBub3Qgc2V0IGluIHRoZSBFUCwgd2Ugc2V0IGl0
Lg0KPj4+Pj4gDQo+Pj4+PiBGaXhlczogQ29tbWl0IGU0MjAxMGQ4MjA3ZiAoIlBDSTogU2V0IFJl
YWQgQ29tcGxldGlvbiBCb3VuZGFyeSB0byAxMjggaWZmIFJvb3QgUG9ydCBzdXBwb3J0cyBpdCAo
X0hQWCkiKQ0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VA
b3JhY2xlLmNvbT4NCj4+Pj4+IA0KPj4+Pj4gLS0tDQo+Pj4+PiANCj4+Pj4+IE5vdGUsIHRoYXQg
dGhlIGN1cnJlbnQgZHVwbGljYXRpb24gb2YgcGNpZV9yb290X3JjYl9zZXQoKSB3aWxsIGJlDQo+
Pj4+PiByZW1vdmVkIGluIHRoZSBuZXh0IGNvbW1pdC4NCj4+Pj4+IC0tLQ0KPj4+Pj4gZHJpdmVy
cy9wY2kvcHJvYmUuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykNCj4+Pj4+IA0KPj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+Pj4+
PiBpbmRleCA0MTE4M2FlZDhmNWQ5Li4zNDdhZjI5ODY4MTI0IDEwMDY0NA0KPj4+Pj4gLS0tIGEv
ZHJpdmVycy9wY2kvcHJvYmUuYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPj4+
Pj4gQEAgLTI0MTAsNiArMjQxMCw0MSBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3NlcnIo
c3RydWN0IHBjaV9kZXYgKmRldikNCj4+Pj4+IH0NCj4+Pj4+IH0NCj4+Pj4+IA0KPj4+Pj4gK3N0
YXRpYyBib29sIHBjaWVfcm9vdF9yY2Jfc2V0KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+Pj4+PiAr
ew0KPj4+Pj4gKyBzdHJ1Y3QgcGNpX2RldiAqcnAgPSBwY2llX2ZpbmRfcm9vdF9wb3J0KGRldik7
DQo+Pj4+PiArIHUxNiBsbmtjdGw7DQo+Pj4+PiArDQo+Pj4+PiArIGlmICghcnApDQo+Pj4+PiAr
IHJldHVybiBmYWxzZTsNCj4+Pj4+ICsNCj4+Pj4+ICsgcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29y
ZChycCwgUENJX0VYUF9MTktDVEwsICZsbmtjdGwpOw0KPj4+Pj4gKw0KPj4+Pj4gKyByZXR1cm4g
ISEobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKTsNCj4+Pj4+ICt9DQo+Pj4+PiArDQo+Pj4+
PiArc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9yY2Ioc3RydWN0IHBjaV9kZXYgKmRldikNCj4+
Pj4+ICt7DQo+Pj4+PiArIC8qDQo+Pj4+PiArICAqIE9idmlvdXNseSwgd2UgbmVlZCBhIExpbmsg
Q29udHJvbCByZWdpc3Rlci4gVGhlIFJDQiBpcyBSTw0KPj4+Pj4gKyAgKiBpbiBSb290IFBvcnRz
LCBzbyBubyBuZWVkIHRvIGF0dGVtcHQgdG8gc2V0IGl0IGZvcg0KPj4+Pj4gKyAgKiB0aGVtLiBG
b3IgVkZzLCB0aGUgUkNCIGlzIFJzdmRQLCBzbywgbm8gbmVlZCB0byBzZXQgaXQuDQo+Pj4+PiAr
ICAqIFRoZW4sIGlmIHRoZSBSb290IFBvcnQgaGFzIFJDQiBzZXQsIHRoZW4gd2Ugc2V0IGZvciB0
aGUgRVANCj4+Pj4+ICsgICogdW5sZXNzIGFscmVhZHkgc2V0Lg0KPj4+Pj4gKyAgKi8NCj4+Pj4+
ICsgaWYgKHBjaWVfY2FwX2hhc19sbmtjdGwoZGV2KSAmJg0KPj4+Pj4gKyAgICAgKHBjaV9wY2ll
X3R5cGUoZGV2KSAhPSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUKSAmJg0KPj4+Pj4gKyAgICAgIWRl
di0+aXNfdmlydGZuICYmIHBjaWVfcm9vdF9yY2Jfc2V0KGRldikpIHsNCj4+Pj4+ICsgdTE2IGxu
a2N0bDsNCj4+Pj4+ICsNCj4+Pj4+ICsgcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChkZXYsIFBD
SV9FWFBfTE5LQ1RMLCAmbG5rY3RsKTsNCj4+Pj4+ICsgaWYgKGxua2N0bCAmIFBDSV9FWFBfTE5L
Q1RMX1JDQikNCj4+Pj4+ICsgcmV0dXJuOw0KPj4+Pj4gKw0KPj4+Pj4gKyBwY2llX2NhcGFiaWxp
dHlfd3JpdGVfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCBsbmtjdGwgfCBQQ0lfRVhQX0xOS0NU
TF9SQ0IpOw0KPj4+Pj4gKyB9DQo+Pj4+IA0KPj4+PiBSQ0IgaXNuJ3QgbWVhbmluZ2Z1bCBmb3Ig
c3dpdGNoZXMsIHNvIHdlJ2xsIHJlYWQgdGhlaXIgTE5LQ1RMDQo+Pj4+IHVubmVjZXNzYXJpbHku
ICBJIHByb3Bvc2Ugc29tZXRoaW5nIGxpa2UgdGhpcywgd2hpY2ggYWxzbyBjbGVhcnMgUkNCDQo+
Pj4+IGlmIGl0J3Mgc2V0IHdoZW4gaXQgc2hvdWxkbid0IGJlIChJIHRoaW5rIHRoaXMgd291bGQg
aW5kaWNhdGUgYQ0KPj4+PiBmaXJtd2FyZSBkZWZlY3QpOg0KPj4+PiANCj4+Pj4gICAgICAgLyoN
Cj4+Pj4gICAgICAgICogUGVyIFBDSWUgcjcuMCwgc2VjIDcuNS4zLjcsIFJDQiBpcyBvbmx5IG1l
YW5pbmdmdWwgaW4gUm9vdCBQb3J0cw0KPj4+PiAgICAgICAgKiAod2hlcmUgaXQgaXMgcmVhZC1v
bmx5KSwgRW5kcG9pbnRzLCBhbmQgQnJpZGdlcy4gIEl0IG1heSBvbmx5IGJlDQo+Pj4+ICAgICAg
ICAqIHNldCBmb3IgRW5kcG9pbnRzIGFuZCBCcmlkZ2VzIGlmIGl0IGlzIHNldCBpbiB0aGUgUm9v
dCBQb3J0Lg0KPj4+PiAgICAgICAgKi8NCj4+Pj4gICAgICAgaWYgKCFwY2lfaXNfcGNpZShkZXYp
IHx8DQo+Pj4+ICAgICAgICAgICBwY2lfcGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX1JP
T1RfUE9SVCB8fA0KPj4+PiAgICAgICAgICAgcGNpX3BjaWVfdHlwZShkZXYpID09IFBDSV9FWFBf
VFlQRV9VUFNUUkVBTSB8fA0KPj4+PiAgICAgICAgICAgcGNpX3BjaWVfdHlwZShkZXYpID09IFBD
SV9FWFBfVFlQRV9ET1dOU1RSRUFNIHx8DQo+Pj4+ICAgICAgICAgICBkZXYtPmlzX3ZpcnRmbikN
Cj4+Pj4gICAgICAgICAgICAgICByZXR1cm47DQo+Pj4+IA0KPj4+PiAgICAgICByY2IgPSBwY2ll
X3Jvb3RfcmNiX3NldChkZXYpOw0KPj4+PiANCj4+Pj4gICAgICAgcGNpZV9jYXBhYmlsaXR5X3Jl
YWRfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCAmbG5rY3RsKTsNCj4+Pj4gICAgICAgaWYgKHJj
Yikgew0KPj4+PiAgICAgICAgICAgICAgIGlmIChsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0Ip
DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+Pj4+IA0KPj4+PiAgICAgICAg
ICAgICAgIGxua2N0bCB8PSBQQ0lfRVhQX0xOS0NUTF9SQ0I7DQo+Pj4+ICAgICAgIH0gZWxzZSB7
DQo+Pj4+ICAgICAgICAgICAgICAgaWYgKCEobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKSkN
Cj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4+Pj4gDQo+Pj4+ICAgICAgICAg
ICAgICAgcGNpX2luZm8oRldfSU5GTyAiY2xlYXJpbmcgUkNCIChSQ0Igbm90IHNldCBpbiBSb290
IFBvcnQpXG4iKTsNCj4+Pj4gICAgICAgICAgICAgICBsbmtjdGwgJj0gflBDSV9FWFBfTE5LQ1RM
X1JDQjsNCj4+PiANCj4+PiBPbiBzZWNvbmQgdGhvdWdodCwgSSB0aGluayB0aGlzIGlzIHRvbyBh
Z2dyZXNzaXZlLiAgSSB0aGluayBWTQ0KPj4+IGd1ZXN0cyB3aWxsIG9mdGVuIHNlZSBlbmRwb2lu
dHMgYnV0IG5vdCB0aGUgUm9vdCBQb3J0LiAgSW4gdGhhdA0KPj4+IGNhc2UsIHBjaWVfcm9vdF9y
Y2Jfc2V0KCkgd291bGQgcmV0dXJuIGZhbHNlIGJlY2F1c2UgaXQgY291bGRuJ3QNCj4+PiBmaW5k
IHRoZSBSUCwgYnV0IHRoZSBSUCBtaWdodCBhY3R1YWxseSBoYXZlIFJDQiBzZXQuICBUaGVuIHdl
DQo+Pj4gd291bGQgY2xlYXIgdGhlIGVuZHBvaW50IFJDQiB1bm5lY2Vzc2FyaWx5LCB3aGljaCBz
aG91bGQgYmUgc2FmZQ0KPj4+IGJ1dCB3b3VsZCByZWR1Y2UgcGVyZm9ybWFuY2UgYW5kIHdpbGwg
cmVzdWx0IGluIGFubm95aW5nDQo+Pj4gbWlzbGVhZGluZyB3YXJuaW5ncy4NCj4+IA0KPj4gSWYg
dGhlIFZNIGhhcyBhIFBGIGluIHBhc3MtdGhyb3VnaCBhbmQgdGhlIFJQIGlzIG5vdCB0aGVyZSwg
eW91J3JlDQo+PiByaWdodC4gSWYgaXQgaXMgYSBWRiwgd2UgZG8gbm90IHByb2dyYW0gaXQgYW55
d2F5Lg0KPj4gDQo+Pj4gQ291bGQgZWl0aGVyIGlnbm9yZSB0aGlzIGNhc2UgKGFzIGluIHlvdXIg
b3JpZ2luYWwgcGF0Y2gpIG9yIGJyaW5nDQo+Pj4gcGNpZV9yb290X3JjYl9zZXQoKSBpbmxpbmUg
aGVyZSBhbmQgcmV0dXJuIGVhcmx5IGlmIHdlIGNhbid0IGZpbmQNCj4+PiB0aGUgUlAuDQo+PiAN
Cj4+IEkgdGhpbmsgcGNpZV9yb290X3JjYl9zZXQoKSBzaG91bGQgcmV0dXJuIHRydWUgd2hlbiBp
dCB3YXMgYWJsZSB0bw0KPj4gcmV0cmlldmUgdGhlIFJQJ3MgUkNCIHZhbHVlLCBhbmQgaWYgbm90
LCB3ZSBiYWlsIG91dC4NCj4gDQo+IEN1cnJlbnRseSBpdCByZXR1cm5zOg0KPiANCj4gIC0gdHJ1
ZSBpZiB3ZSBmb3VuZCB0aGUgUlAgYW5kIGl0IGhhZCBSQ0Igc2V0DQo+IA0KPiAgLSBmYWxzZSBp
ZiAoYSkgd2UgY291bGRuJ3QgZmluZCB0aGUgUlAgb3IgKGIpIHdlIGZvdW5kIHRoZSBSUCBhbmQg
aXQNCj4gICAgaGFkIFJDQiBjbGVhcmVkDQo+IA0KPiBJIGRvbid0IHRoaW5rIGl0J3Mgd29ydGgg
Y29tcGxpY2F0aW5nIHRoZSBzaWduYXR1cmUgdG8gbWFrZSAoYSkgYW5kDQo+IChiKSBkaXN0aW5n
dWlzaGFibGUuDQoNCkNhc2UgKGIpIHdpbGwgbm90IHRydXN0ZnVsbHkgZGV0ZWN0IHRoZSBjYXNl
IHdoZXJlIHRoZSBFUCdzIFJDQiBpcyBzZXQgYW5kIHRoZSBSUCBpcyAoYi4xKSBub3QgZm91bmQg
b3IgKGIuMikgUlAgaXMgZm91bmQgYnV0IGl0J3MgUkNCIGlzIG5vdCBzZXQuIEluIGNhc2UgKGIu
MiksIHdlIF9zaGFsbF8gcmVzZXQgdGhlIEVQJ3MgUkNCLCBJSVVDLg0KDQoNClRoeHMsIEjDpWtv
bg0KDQoNCg0KPiANCj4gSW5saW5pbmcgcGNpZV9yb290X3JjYl9zZXQoKSB3b3VsZCBhbHNvIHJl
bW92ZSBhbnkgYW1iaWd1aXR5IGFib3V0DQo+IHdoZXRoZXIgcGNpZV9yb290X3JjYl9zZXQoKSBh
Y3R1YWxseSAqc2V0cyogUkNCIG9yIGp1c3QgdGVzdHMgaXQuICBJDQo+IHRoaW5rIGFueSByZWFk
YWJpbGl0eSBhZHZhbnRhZ2Ugb2YgdXNpbmcgYSBzZXBhcmF0ZSBmdW5jdGlvbiBpcw0KPiBtaW5p
bWFsLg0KPiANCj4+Pj4gICAgICAgfQ0KPj4+PiANCj4+Pj4gICAgICAgcGNpZV9jYXBhYmlsaXR5
X3dyaXRlX3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NUTCwgbG5rY3RsKTsNCj4+Pj4gDQo+Pj4+PiAr
fQ0KPj4+Pj4gKw0KPj4+Pj4gc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9kZXZpY2Uoc3RydWN0
IHBjaV9kZXYgKmRldikNCj4+Pj4+IHsNCj4+Pj4+IHBjaV9jb25maWd1cmVfbXBzKGRldik7DQo+
Pj4+PiBAQCAtMjQxOSw2ICsyNDU0LDcgQEAgc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9kZXZp
Y2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+Pj4+IHBjaV9jb25maWd1cmVfYXNwbV9sMXNzKGRl
dik7DQo+Pj4+PiBwY2lfY29uZmlndXJlX2VldGxwX3ByZWZpeChkZXYpOw0KPj4+Pj4gcGNpX2Nv
bmZpZ3VyZV9zZXJyKGRldik7DQo+Pj4+PiArIHBjaV9jb25maWd1cmVfcmNiKGRldik7DQo+Pj4+
PiANCj4+Pj4+IHBjaV9hY3BpX3Byb2dyYW1faHBfcGFyYW1zKGRldik7DQo+Pj4+PiB9DQo+Pj4+
PiAtLSANCj4+Pj4+IDIuNDMuNQ0KPj4gDQo+PiANCg0K

