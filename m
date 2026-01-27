Return-Path: <linux-acpi+bounces-20677-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULZuMOP1eGnYuAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20677-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:29:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3740F9872F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07B24300B3F0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289022E8E16;
	Tue, 27 Jan 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="csDf3s7Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z2+lb7WS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5F2E9759;
	Tue, 27 Jan 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534945; cv=fail; b=FxPtsYtjNwkvoB4Am44Uy5a2xT0bJtim2YGH6+fXe0y62qTcYiamxGe8AKcTDPhavslcgrhuxsgHzhW2gfCi/1JUYAvZGs710pH1L4PK7fDLg0ZD00grC+qL/JVs/oNONbXoECifdPDtoDOuCESZKGQy7cP6fvVyDXS/093sfjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534945; c=relaxed/simple;
	bh=3SxPNZ2IwI1WR0pVTUUPv7PIanvKW+9b0y+JPI2clbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=khx0UHIXxttiBKtD3+cuep0NcE/Ee9S0sRGvuFb2kg6UZSFrGvPGHmkOQIuVrLRH4t8C7BvUMu8Zu/GsXlCSNAG3/afL8p3JRmqJs6m8cVwpe8lNJvqFYgnyFuwlOWJ8qSFR8E/fLREe2ZUPi6QMLAseiZk97toFp2UJm9G/gOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=csDf3s7Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z2+lb7WS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RD8uFN4016066;
	Tue, 27 Jan 2026 17:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3SxPNZ2IwI1WR0pVTUUPv7PIanvKW+9b0y+JPI2clbA=; b=
	csDf3s7QGarmWsNaYbkJLDxC7uPObI97heDTR3k9QpMZaMUf6QfMynb8lX2j4Uel
	NVLlNuvXP/XyPt/Q9AgfUnJGL5iFZ1NRUrzSRQi2KKo/bwYEL7P7MDTaPiEP+N9x
	Bv03/aLkB+VZ4hmnlR7uOMzIX+QdYg/4yHf9fzK0IIt31N6ZiFctLHbXgx3/Ub/b
	X+hGBHLKPijgkxAxLwH0a5AieUXip+XzzKzdwxz/zIw5BWFFxXwMEa0AitnEBh7G
	ucIE8DLX6iLG2hcvPGPe40JiYneMoyrHOUSezUELsJMYaNpcj8DmLBz9Mr2jbKGK
	mV0PZlM2xb2MtRNikeu0sA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09gfx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:28:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RGctTH012554;
	Tue, 27 Jan 2026 17:28:55 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9rafm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBFE3VrrrhdaJ/i5ftzm9btyuiyfmuD//PpQY19FNXXmM6b3CduuN4wgMz52mC3yBU7ulyognKd1oDCj4EDNNSdJS0mTeAA3WifDrKdNuhNf1UKGZlqMcEuSNYnZLpOIaa+sGFgJLBeXPVGZ94Gdfyo9gJKWVwVlNmws0/EzYE4iM7Y+aRI5ZczbG2GgKUTt+NS9Pcr9mqcXRr2jwDcvWlg+Bka0oidm8Wh5emwa/jyij6qcpC6NtAe9o0hNVBiuNGsh0jAtexdPMPA1kyzcId5pBa/iTiEVpQKvqC1lX/zGuKb6fdZ96fIwOExJ6SmE2AUgzFQJgojXNDTFqaS/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SxPNZ2IwI1WR0pVTUUPv7PIanvKW+9b0y+JPI2clbA=;
 b=UTkpLg45MaAQete9VXhdGgxCsgCc1RJNNwBaLKsQ8YJzaBl8LvZZopGGQshyLKmfOHifKRmhqjPYnXyzGSt88LG6vSTQkQDh4kZP/Fj1Tt8yuRWKZHlVchlqrmVsEEfLLvQsF6vdYc4Caj2DK0XHoxY3P0I8SGYS7YpKGTBtr+MLRDKleaBZyd3P+rYIbnZxkeFXkoeraqnXO9RQMR+qtbBPqHkKd8YDAcbFN8BaS/mahUtpvvesOArYe8tKxJ2R2fiIceMWb2wzjPBrHKBjr8IR6aGyj7SwCUZUHn1hUcc6i6VwV+bSxLnM8LpSeLp2+JcCQsZNmFehj5/Vm6srvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SxPNZ2IwI1WR0pVTUUPv7PIanvKW+9b0y+JPI2clbA=;
 b=Z2+lb7WSzmhHf4Z4vthlhWubexUn0pw3hArGhcatzi5KcSUpdwh9RT7HH4Sgm9Jn495KiF/fc1azslQjjLYfOeSEigXbIPtw69JISXst4rk6U1kx1uFjye8ipn3M+mf2Roemp/HVE8iCWTims1A4gVv2+gbKVPQFpuwAbi2bkvA=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Tue, 27 Jan
 2026 17:28:53 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 17:28:53 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHci6Bw4Ah2IJD57EKH4IA39ueuwrVfuoOAgABMTgCAABU7gIAGMXWA
Date: Tue, 27 Jan 2026 17:28:52 +0000
Message-ID: <C671D804-306E-41A2-98BA-04C48C86CAE7@oracle.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com>
 <20260122130957.68757-2-haakon.bugge@oracle.com>
 <a91e38085a9458455adccbaa18a0d80dd6797dcb.camel@linux.ibm.com>
 <7E4D523D-5105-4173-AC1A-8B7898DC48A8@oracle.com>
 <ae149906c5e27513235c7f347b8b1dfed82b8dd1.camel@linux.ibm.com>
In-Reply-To: <ae149906c5e27513235c7f347b8b1dfed82b8dd1.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|CO6PR10MB5570:EE_
x-ms-office365-filtering-correlation-id: 142d23f2-57bf-4c07-8c19-08de5dc98ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGdrWUc5dUJ1bzdEclBsaXVvaFZGOXI4eUc2cWs0SUkyMDRPYjR1T1NrNkc4?=
 =?utf-8?B?LzAxL1ZIb2p2UmkvRmg0NGIwMmRuaTd6UVB5TUY2UUdTQU8yRTQrRHo1MzF1?=
 =?utf-8?B?SWRqcXFaLzVlWnBWallRYlI0MjVwWml1Q21ydlhMNnp6cG5Pa0oxSFBmN0VR?=
 =?utf-8?B?eURDeGRQL2dadFJrNXN6VlZFQ1N2UTB0ZHd6NFVJMkk0OUtkVFJGQkMwcUc3?=
 =?utf-8?B?cWhqM0FoY01JWXlXdGszNFhiMWMvRjkwR3FDWXZUQ2pBWTZoU3JRYjBQWWJ4?=
 =?utf-8?B?TTRmQy9aOGhsNFppUlFYa3o4R1NkNUVQaVNTbEhsWTg5MzBlUlllMmhpOUNF?=
 =?utf-8?B?K2Y2TTVZL0wzNU9kWlR6eXVZUUpoakZmQkFhZm52azk2bWJsNjBRKzdrMVE3?=
 =?utf-8?B?bGJpTFA2ZnA2eCtaQmhQL1MwLzE2QURnOEVpc2NnM3NON2NyODNUbjZ4V1dy?=
 =?utf-8?B?NGUwT081ZmVYZnpETGJQa3FYdnZMMzZTWXZ4L0doTmw5L2VPbzhRVTZseEQ0?=
 =?utf-8?B?d0pyQ0E0dkRnOGdyOG9jNEE4WDVYczZRNDA3T3dOeE0xWlpPZnhKcExGUXhz?=
 =?utf-8?B?dGtlNVY3RndFWWg3dC8vdkZlM1hzdlRwOUt6bnBKZmhTbmRGQzlhWHQveXRO?=
 =?utf-8?B?enR4U0VOdWZIcS9BZHJQT0E1MHJTcVIrVEROd0RJRjZEejh3RVlGd0FmY1k0?=
 =?utf-8?B?dnpaN1BCWkxHTWV6dHFvNjJreEhKWVd5czNNK2VzSTFxN21maGhFa0x4Z1Qy?=
 =?utf-8?B?dnNSZTZ5RHBXU3UrakF2OXZVWFR2b3ArSmFnZU0zZzlPdnlHTDhPWmxZU3pX?=
 =?utf-8?B?T3dvVlZ6bWF4cHZCalIxQWxZbEJpY1pzN3FTQTJ0N2RMRFkrYXUwSHdSMDVI?=
 =?utf-8?B?d0VVSzYwUExzcDhPcDFTL1M5VytDZ3Y2Umt4b05sM2RNNk1EQXJIRmplc1Rx?=
 =?utf-8?B?OFR0WnJyMlAwZXh1M2FSVmlBS2dRMVQ5RytuV2k3WjVYZ1dwQ2NJS0crYWZJ?=
 =?utf-8?B?elJFbjV1RkZ4ZFUrVEY1VTdhRXN3VTFRZDFhUDdsK2VxcHg5OFRwajROdmxy?=
 =?utf-8?B?KzkzQ0JSSFpGU2Z5eWo5ZzdETGR0WHJyeEJiWUhqd3BCOVpqZ1ZzaW51R01n?=
 =?utf-8?B?ejA4Y25IWFE5Ukl6cm5EY3BLWGdZWC9VbzIzRDZhOXp1WnFyVXpoQnIwQ2M4?=
 =?utf-8?B?Qkw3aFBCYUlBTzdaSlZPUmg3WjJBc2F2YWdEbUJkZERxMHBtTGU5RkxOT3Ns?=
 =?utf-8?B?bHBMMTdjSFpqUzgxSUp2dEpSeFh2cmNkK2JaL0dWM0tMdms4cHgxaGJ1cG5s?=
 =?utf-8?B?K2xqRnhzYXFQVGxnK3VuUk1reUpFYTVzTzU3aDM5UHVrRlRQMnAzVHhwWmFC?=
 =?utf-8?B?YXZ1b1pJRXBHQTlOb2dUWVc3R3NyTGJaWmVpcUo2NnZvajR2M0REenZZUnVS?=
 =?utf-8?B?Vzg0SnZBRjIvUDhFY3locjQweHU3WGZ6TTFmTlhEdllkNHIxamlWYWtTMXVK?=
 =?utf-8?B?Q1lCREVXY0UzMlJDSU1ZUXordkRwczQyeGsvMVdVWmpOaWN0a29nNTRJRmxi?=
 =?utf-8?B?Q1FJUUZKM042eHNLTklRMWhTaHpMRlJGTk8wRmRHUGdmd3VPR0RQb3lQSkZJ?=
 =?utf-8?B?djJYVXYvQllobEFEUWsveG9kQW1wLy9pSGxOYTRIUzRJWnFrUWVqVkozQ0dz?=
 =?utf-8?B?bXUreFJTOGczckxwRVEvd0wrdjdwVlVSZUZrSDc1Ym00SXdvS2NSUzlHNEgz?=
 =?utf-8?B?RitrOHY4aFdNR3AvOEF4UkF3d0tEZHVDYVBiaTZaampIaVdrVGZJd21aRHdk?=
 =?utf-8?B?YmZzczNqZkszK3pqT0hwMkJtUDVHU1hHQ080NU9CRFZ6dU5ZbC9majdzUFVY?=
 =?utf-8?B?dURiUTFQdmtiZDNJdGJYVnVKU0tKV1hHSTZjRFhYN0tLUlp1cWphV1h4Tmhh?=
 =?utf-8?B?NzJYVlFpWU00bm1VandKeHJML3NZRlVFaWF0REo1eFFaM0N6RjBITjI0TTB5?=
 =?utf-8?B?OGxRdkl1SUpXcGt4ZXRLSVVKMkZLQjZNc0ZGQjhmZzAyVng0UVhUQWdPRDR4?=
 =?utf-8?B?SDRpVmhVMDBadVUzWHo1bHNwTVpyaTZqMStXQnp6Tk9Mbzl1Nm1sOUxXb1VY?=
 =?utf-8?B?SzdoMzhRVnl4Sk1SN3dNYWNBMmpzSExTQ0svNzE3akF3TUpoc1dCWlgvSFJG?=
 =?utf-8?Q?9VO2s4SZJGgPNscmg6wJIn4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUJCaE85THA0L01sTWxYbWwvditOZUJwVE5EdWFsS2c5OUIrN2VOdnFkNWwy?=
 =?utf-8?B?MnRNSjZqSkJ0YWNVQUNYVjZwbysvYUoxTFVFUWQ2djFJK1hYV0ozUk91Uzl4?=
 =?utf-8?B?WmMwU00xRENvNWFEWmM0cWYwajZaelArUDRqS1ZZUk9GYTBOd21VTU0zUURN?=
 =?utf-8?B?eWYwT1VPYi84MXhQUGJzODVWTWlCaWNJUndrMDhoZzgzNWFtNnYvV0g2TlFX?=
 =?utf-8?B?bmZLQkcramJmRFQxVVhTM2dWLytDd255aWxScnZmTjNQay85TmY1UkRJaFk0?=
 =?utf-8?B?aytLbzBtVy8wM1ZFQmg4OUtHUzZWK212ckNFbzU0MktaWnlFUkxxYk1yNXdu?=
 =?utf-8?B?R2lYZTBYTGVaeGxDZlpVbTh6amVwV3I5RXZJSGFJMDVET3Y4VGprbnYvT2x5?=
 =?utf-8?B?UmpDeC9OaDdHUnhhZnUrN2hwTTB1WDhvWmxDYnlnczJrWVY3QXJFaGtVV0Uy?=
 =?utf-8?B?a000K0YwamRqTCsyNlFCOWtRUHVWNk1mWld5Zk9ta29Fa2RMVHdnV21EUEpt?=
 =?utf-8?B?ZnQ0SFh0VmpLRm9keVQxU3VLUG5YNUErejhuNE51NXFvdW9YZDV2b0dGRjE4?=
 =?utf-8?B?UE9LWjdQeUJqbHVabldQb3pGNlRVUVJPZnFvVVVhd2ZaS3AwdWFmbWxZUUwv?=
 =?utf-8?B?bkFJOWUrTjZsNnpyaTQzTnRMNnc5SkN2ZE5yNnVOTVBXc2dwK3d4bC9YV3RB?=
 =?utf-8?B?dzlld3VzV0ZuaWYyWnFGRXRQM0FTOGJzRVpjTDlyQkNUeU5VMGVpODZMSmNY?=
 =?utf-8?B?SWRhSVdTQlFyVXMzcnBPdHlhR211bkM5RVdoMG9lZGEwcnlVbVFuRkdaU29T?=
 =?utf-8?B?Q01COHVtZ1JGeGh5M2pHUDRqTjJxb1BhazB2RUptMDBoVnJqL2dqZWN5djRC?=
 =?utf-8?B?YjF6YmRWbVlUNjlDcEM5NmR2UWhaeVFCWG1WVVhmL2pRM0gxRFRNcFdZNHUx?=
 =?utf-8?B?bWF4MVNRaXkyOFlKVUwxTUJXRXg5cVZTcG5Jb0V5WTFic05lUDZ1d2JvZ0Vx?=
 =?utf-8?B?MFEzSUZmRkFNQVFjWTdRWUNWN0MxUC9Ia1RndTlMSkh2b1RodW83dVFJV3h2?=
 =?utf-8?B?cUdrTjByL3NVR0pwZ3d5dktUalQxUVNlQU0rcFdIOHhLeXhpN05RSGJCeGpp?=
 =?utf-8?B?eXBQZDZQTEhTTjY2QlBJWnFRdXlKMElMUGtxbjBnTE9iWjdLWVcwNmJOUFFG?=
 =?utf-8?B?VSt0QmxEalhFd1hKWVowMXpUWWExK1lZYzlhMDhXakR6QmhVNmZBODBmRk5R?=
 =?utf-8?B?cEFtNVpwOTNlTHJ5SklOWHhSQnB5SkNwdlFPOFZPa0w4RVF6c0ZiTUw2di9j?=
 =?utf-8?B?bTVJRkhWV3FFQldmZENHQ2pKbFh1dUFxUnNQOUYxeDlmbDFaL2E0djBOdFZS?=
 =?utf-8?B?RkZDZFlycDZUbTlNLy91aDB1aDlESVJSMlVPb0xBeWlwdy9zQTE2ZjFISnBM?=
 =?utf-8?B?UTRhSlYzNlZDVElwd2RGNEVzT2RZYWtaM2pGOUhEUENiQ2tZSWIrV2o3ZGxt?=
 =?utf-8?B?NCtta2piSGdxdHNTVWVGeHg1c3dmWE5aNUFXQmhUelg2c3g5aVJSMWF3OGhO?=
 =?utf-8?B?cStQVlgrSStOYS9Ia0I5cVFQK0owQnlvc2svUll5TXpmSElDR1VTcU5kYnNq?=
 =?utf-8?B?VjYvYlA4NVY3QURtendzd1RVUFZXUE1ET3l4MGxqQTUvQUkwVkprS1hMdjh1?=
 =?utf-8?B?TEhFSmN4WjBoNWtrbklkeDFidTcyWExRRnduTXZXNURRR0tDTlhkU3pXQ1Jz?=
 =?utf-8?B?bGwxa2E3QUk4VmYzRE1Ka1pEOG80bGhra2pUSEZtTjZzeFJYc1pteHJGSmtL?=
 =?utf-8?B?c1phVDZWQ2NrbEpRMXhzRnNrR3pvNHIvb1RqQ0xBSmZIUm9UK2ExZVgxVGo0?=
 =?utf-8?B?RkdoL2Z3ZDNIb2hRaTJQU3p1QXJzb1d0MzJTVzJleHhxOXc0RFdoUklJdUZy?=
 =?utf-8?B?QzkrOEdPdHB3STdkamJjMzJPWk5DRzNhQk5lNTZ3VU9XTlpYbSs0bFR5K2NC?=
 =?utf-8?B?TnNNU3E3RVJMZTRNK1ZxSWRUS0Y4SGF4djBWK2dQZ0RmY3dVd1ZxL2pvWldp?=
 =?utf-8?B?MDhMTHFqeHJLdGd4U2xnNG8zSExhUDNyMS9EekEzaDY0M01aMHI1ZTJSalkw?=
 =?utf-8?B?RkpBandveWprdnh0YmlGaWwwa3dzRHJnNXdGbVYrU1FnUUZtK3hOV0hxdVFx?=
 =?utf-8?B?WU92UU85SDlhMEIzSjdSOHkyVXZGVUpSUGNkWDhVVGNUZ0VNOFYxSk5sTG04?=
 =?utf-8?B?NnRwN0dwdTcvVE1CdEV2ZnJiU3BEeERWODJWa0REV3A1QkxGamR4cnVxZERj?=
 =?utf-8?B?R2JaTnJCWXNkS3NPWm1DbUNSaURTSlFiTHlWeDBxNERXeDh6ckYrU0Q0ZkVz?=
 =?utf-8?Q?JOlEUoGvqB5fwvJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D8E53644667294CB30BFCDE8A00DFF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBpys8vmRLlqbhISZYvUhBTgJpzvnSuG4f4su70VuheYy/g8+KYT8F3cSXeIYYFDGLgFX0ELxBA6VESszu/dgzdNGvfcznJ+bvZHAF2DcCEknHwuw7i3G+4nmQU8FX57g5iy4+EVyMwswM2sY1N5tcEMRdscgb03pesPaofR3BKelacY09Lt6AshCUUw4J0VGPU0ZTmtBc5Q8NWZT2mUL2uSfZkqYUUn7JeobzUj934oBL9Uq6NfBmCyoy0knegqP6ge79hk5bxJIt9svqfQUgVH8Xz8h7E9RO9IC102ZpN1Qufk3IQK9IHkfHsEZ7Ti+IWVPxCAQlA+Be4gErm2T1ZGe6m6OoZZBBlYp3VjW6pB/C7bFuMBsrXH/ihnCMgHPNT3VlKS7CFy/TPIcMnua6HK8knmylg6AFii6P0mJYCsYpxfAdod1RYVJJNMVxcwrNef81qc83oCuMkhgzw+Dpn4xAmvfjSgZlj5urfL64k7RMOTtCuZRGZgs3tNRRQEUUT+efD8/idFM7w3qD56hYmCTiAgJ0tDUGekCtwwfexFRiNohXcnNRh0nqLqAZs3L+kLAFyC87rYDd6rG6tsmoiC1c145CcAjfAk0K17vnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142d23f2-57bf-4c07-8c19-08de5dc98ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 17:28:52.9403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZfyrytWW5R6U0Wllt4d7SKfSSO8/4Nv5coSiK2yPRb/KOLPs4mxxWJpd77ATIvLdZmPM+h8Uo9CtyExUUWbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270142
X-Proofpoint-ORIG-GUID: uNvRrKS2xLIxz9edZNp1DlIdQVm3N51V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MiBTYWx0ZWRfX9npiJC85mQE4
 2Qj2U01vcOQVxTiwg2Wn5l18qthykNOB5xMdg4tBpSBRmv+oM7RxDRfN6bDBOWpazCNBr0p/703
 JEr2VJGP9m9ouaucN1SajpDI5PUoDvU1Bfu2UewpS3N1QTPM5K8bk8xBxuuKjcN2cVzIGJyegQs
 Il/H/vE47gqvdhsRWm/AYf0vW9eJz4DyXV4Wre1GVxGOq4BFeUGrSMegMkgdZncRlwVaTAMEF1R
 NOFximIfPVJz7+xMLxjieveRj5bAUE3q4t0zIlacHDHNykBGIWwKFEXJHPFD4ZujIPKHHr9CUKq
 cbu8bWRXcONkMQln7X0TBF1WsG5aFMw6Der3DgM5TKWpVt73oRheDmiOdXV3+0rPvuIRj3wPPT2
 JyxyyTk2RGN3qhQlhVSvYFfnE5tUSyVpA0nPvu+Zoqyg50j0knHYjHENMJAN3tS5sDHaLUfVa3g
 7L7S1+gChq9K6XQbMTQ==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=6978f5d8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=1wAtn3OnRACTvq1KUJgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uNvRrKS2xLIxz9edZNp1DlIdQVm3N51V
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20677-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3740F9872F
X-Rspamd-Action: no action

DQoNCj4gT24gMjMgSmFuIDIwMjYsIGF0IDE5OjU0LCBOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxl
QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI2LTAxLTIzIGF0IDE3OjM4
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+Pj4+IE9uIFRodSwgMjAyNi0wMS0yMiBhdCAx
NDowOSArMDEwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4+PiBDb21taXQgZTQyMDEwZDgyMDdm
ICgiUENJOiBTZXQgUmVhZCBDb21wbGV0aW9uIEJvdW5kYXJ5IHRvIDEyOCBpZmYNCj4+Pj4gUm9v
dCBQb3J0IHN1cHBvcnRzIGl0IChfSFBYKSIpIGZpeGVkIGEgYm9ndXMgX0hQWCB0eXBlIDIgcmVj
b3JkLCB3aGljaA0KPj4+PiBpbnN0cnVjdGVkIHByb2dyYW1faHB4X3R5cGUyKCkgdG8gc2V0IHRo
ZSBSQ0IgaW4gYW4gZW5kcG9pbnQsDQo+Pj4+IGFsdGhvdWdoIGl0J3MgUkMgZGlkIG5vdCBoYXZl
IHRoZSBSQ0IgYml0IHNldC4NCj4+Pj4gDQo+Pj4+IC0tLSBzbmlwIC0tLQ0KPj4+PiANCj4+Pj4g
K3N0YXRpYyBib29sIHBjaWVfcmVhZF9yb290X3JjYihzdHJ1Y3QgcGNpX2RldiAqZGV2LCBib29s
ICpyY2IpDQo+Pj4+ICt7DQo+Pj4+ICsgc3RydWN0IHBjaV9kZXYgKnJwID0gcGNpZV9maW5kX3Jv
b3RfcG9ydChkZXYpOw0KPj4+PiArIHUxNiBsbmtjdGw7DQo+Pj4+ICsNCj4+Pj4gKyBpZiAoIXJw
KQ0KPj4+PiArIHJldHVybiBmYWxzZTsNCj4+Pj4gKw0KPj4+PiArIHBjaWVfY2FwYWJpbGl0eV9y
ZWFkX3dvcmQocnAsIFBDSV9FWFBfTE5LQ1RMLCAmbG5rY3RsKTsNCj4+Pj4gKw0KPj4+PiArICpy
Y2IgPSAhIShsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0IpOw0KPj4+PiArIHJldHVybiB0cnVl
Ow0KPj4+PiArfQ0KPj4+IA0KPj4+IEluIHByaW5jaXBsZSB0aGlzIGlzIG9uZSBvZiB0aGVzZSB0
aGluZ3Mgd2hlcmUgcGxhdGZvcm1zIGxpa2UgczM5MA0KPj4+IHdoZXJlIHRoZSByb290IHBvcnQg
aXMgaGlkZGVuIChvbmx5IHMzOTA/KSBtaWdodCB3YW50IGEgaG9vayB0byB1c2UNCj4+PiBmaXJt
d2FyZSBzdXBwbGllZCBpbmZvcm1hdGlvbiB0byBkZXRlcm1pbmUgaWYgdGhlIGhpZGRlbiByb290
IHBvcnQNCj4+PiBzdXBwb3J0cyB0aGUgc2V0dGluZy4gSSB3b25kZXIgaWYgdGhpcyB3b3VsZCBt
YWtlIHNlbnNlIGFzIGEgX193ZWFrDQo+Pj4gcGNpYmlvc19yZWFkX3JjYl9zdXBwb3J0ZWQoKSBm
dW5jdGlvbi4gTm90IHNheWluZyB3ZSBuZWVkIHRoaXMgbm93LA0KPj4+IGp1c3QgdGhpbmtpbmcg
b3V0IGxvdWQuDQo+PiANCj4+IFRoYXQgbWF5IGJlIGEgZ29vZCBpZGVhLiBCdXQgSSBhbSBub3Qg
cXVpdGUgc3VyZSBob3cgd2UgY2FuIGZpbmQgdGhlIFJvb3QgUG9ydCBmcm9tIGFuICJvcnBoYW4i
IGJyaWRnZSBvciBlbmRwb2ludCB0aHJvdWdoIHRoZSBwY2lfYmlvc19yZWFkIHNldCBvZiBpbnRl
cmZhY2VzLg0KPiANCj4gSSBvbmx5IG1lYW50IHRvIGhhdmUgaXQgYXMgYSBmdW5jdGlvbiBpbiBh
IHNpbWlsYXIgbWFubmVyIHRvIGUuZy4NCj4gcGNpYmlvc19lbmFibGVfZGV2aWNlKCkgdGhhdCB3
ZSBjb3VsZCBvdmVycmlkZS4gQnV0IEkgZG9uJ3QgdGhpbmsgdGhhdA0KPiBuZWVkcyBvciBldmVu
IHNob3VsZCBiZSBwYXJ0IG9mIHRoaXMgcGF0Y2ggYXMgdGhlcmUgd291bGRuJ3QgYmUgYSB1c2Vy
DQo+IG9mIHRoZSBvdmVycmlkZSB5ZXQuDQoNClVuZGVyc3Rvb2QuDQoNCltzbmlwXQ0KDQo+Pj4g
VGhlIEZXX0lORk8gaW4gaGVyZSBzZWVtcyB0byBiZSBhIHJlbW5hbnQgZnJvbSBBQ1BJIGNvZGUu
IEFzIGZhciBhcyBJDQo+Pj4ga25vdyB0aGlzIGlzbid0IHVzdWFsbHkgdXNlZCBpbiBjb3JlIFBD
SSBjb2RlIGFuZCBzZWVtcyBjb25jZXB0dWFsbHkNCj4+PiBtaXNsZWFkaW5nIHRvIG1lIHNpbmNl
IHRoaXMgZG9lc24ndCBjb21lIG91dCBvZiBBQ1BJIG9yIG90aGVyIGZpcm13YXJlDQo+Pj4gY29k
ZS4NCj4+IA0KPj4gSSBodW1ibHkgZGlzYWdyZWUuIEFzIHBlciBQQ0llIHI3LjAsIHNlYyA3LjUu
My43OiAiRGVmYXVsdCB2YWx1ZSBvZiB0aGlzIGJpdCBpcyAwYiIuIFNvLCBpZiB3ZSBmaW5kIGl0
IHNldCwgYW5kIGl0IGlzIG5vdCBzZXQgaW4gdGhlIFJvb3QgUG9ydCwgdG8gbWUsIGl0IG11c3Qg
YmUgYSBmaXJtd2FyZSBidWcuIEFuZCB0aGF0IGlzIGV4YWN0bHkgd2hhdCBGV19JTkZPIGlzIGlu
dGVuZGVkIGZvcjogIkludHJvZHVjZSBGV19CVUcsIEZXX1dBUk4gYW5kIEZXX0lORk8gdG8gY29u
c2lzdGVubHkgdGVsbCB1c2VycyBhYm91dCBCSU9TIGJ1Z3MiIChjb21taXQgYTBhZDA1Yzc1YWEz
KS4NCj4gDQo+IEFoIHRoYW5rcyBmb3IgdGhlIHBvaW50ZXIsIEkgd2Fzbid0IGF3YXJlIG9mIHRo
aXMgZXhwbGljaXQgImZvcg0KPiByZXBvcnRpbmcgRlcgaXNzdWVzIiB1c2UuIFJlYWRpbmcgY29t
bWl0IGEwYWQwNWM3NWFhMyAoIkludHJvZHVjZQ0KPiBGV19CVUcsIEZXX1dBUk4gYW5kIEZXX0lO
Rk8gdG8gY29uc2lzdGVubHkgdGVsbCB1c2VycyBhYm91dCBCSU9TIGJ1Z3MiKQ0KPiBub3cgSSBh
Z3JlZSB0aGlzIG1ha2VzIHNlbnNlIGFmdGVyIGFsbC4NCg0KSSBtdXN0IGFkbWl0LCBJIHdhc24n
dCBlaXRoZXIsIGJlZm9yZSBJIHJlYWQgdGhhdCBjb21taXQgOi0pDQoNCj4+IA0KPj4+PiArIGxu
a2N0bCAmPSB+UENJX0VYUF9MTktDVExfUkNCOw0KPj4+PiArIH0NCj4+Pj4gKw0KPj4+PiArIHBj
aWVfY2FwYWJpbGl0eV93cml0ZV93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsIGxua2N0bCk7DQo+
Pj4gDQo+IC0tLSBzbmlwIC0tLQ0KPj4+IA0KPj4+IEkgdGVzdGVkIHRoYXQgdGhpcyBwYXRjaCBz
ZXJpZXMgZG9lcyBub3QgY3JlYXRlIHByb2JsZW1zIG9uIHMzOTAgYW5kDQo+Pj4gd291bGQgbGVh
dmUgdGhlIFJDQiBzZXR0aW5nIGFzIGlzIGlmIG91ciBmaXJtd2FyZSBzZXQgaXQuIFNpbmNlIHRo
ZQ0KPj4+IHNlY29uZCBwYXRjaCBkb2Vzbid0IHRvdWNoIGNvZGUgdGhhdCBpcyBidWlsZCBvbiBz
MzkwIEkgdGhpbmsgdGhlDQo+Pj4gVGVzdGVkLWJ5IG9ubHkgbWFrZXMgc2Vuc2UgZm9yIHRoaXMg
b25lLg0KPj4+IA0KPj4+IFNvIGZlZWwgZnJlZSB0byBhZGQgbXk6DQo+Pj4gDQo+Pj4gVGVzdGVk
LWJ5OiBOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+DQo+PiANCj4+IFRo
YW5rcyBhIGxvdCBmb3IgdGhlIHRlc3RpbmchDQo+PiANCj4+PiBGdXJ0aGVybW9yZSB3aXRoIGVp
dGhlciB0aGUgRldfSU5GTyBkcm9wcGVkIG9yIElscG8ncyBzdWdnZXN0aW9uDQo+Pj4gaW5jb3Jw
b3JhdGVkIGZlZWwgZnJlZSB0byBhbHNvIGFkZDoNCj4+PiANCj4+PiBSZXZpZXdlZC1ieTogTmlr
bGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0uY29tPg0KPj4gDQo+PiBUaGFua3MgZm9y
IHRoZSBjb25kaXRpb25hbCByLWIuIEknbGwgbGlrZSBCam9ybiB0byBjaGltZSBpbiBoZXJlLCBh
cyBoZSBpbnRyb2R1Y2VkIEZXX0lORk8gYW5kIGRpZCBub3Qgb2JqZWN0IHRvIHRoZSBleGlzdGlu
ZyAobm9uIElscG8gdmFyaWFudCkuDQo+IA0KPiBBcyBzdGF0ZWQgYWJvdmUgd2l0aCB0aGUgYWRk
aXRpb25hbCBleHBsYW5hdGlvbiB0aGlzIG1ha2VzIHNlbnNlIHRvIG1lDQo+IG5vdyBzbyBubyBu
ZWVkIGZvciB0aGUgY29uZGl0aW9uYWwgYW55bW9yZSBlaXRoZXIgOykNCg0KVGhhbmtzIGZvciBi
b3RoIHlvdXIgdC1iIGFuZCByLWIgb24gdGhpcyBjb21taXQhDQoNCg0KVGh4cywgSMOla29uDQoN
Cg==

