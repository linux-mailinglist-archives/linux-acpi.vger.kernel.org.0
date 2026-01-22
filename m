Return-Path: <linux-acpi+bounces-20532-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LTdAVMEcmmvZwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20532-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:04:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E465B16
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEEFC8A3D49
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367142B734;
	Thu, 22 Jan 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LO5mSuBZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H3hSyAPF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD0428856;
	Thu, 22 Jan 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079005; cv=fail; b=WlnfSwbw61LYr7IzoZlsqAhv7n9fVVpyEQJWQDYTTH2HEcy/snZlu/rkz8dOTZpcVAvrT4M+SV2B4ejosGpUgwvPtGnNfFAOQcsmpEpHdrRin1C59Vr1/vJiV0AMUo4d6CjOOSyBt1xlAb5Y/WYtyHu47rHYKP9u7Q55Q6enKjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079005; c=relaxed/simple;
	bh=IEL27J9edB7AfTBz+f0qhSmylG/g4okWhSKC/VCE8j8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AIqvCGyIcNMw9mQ0co+ywbtISt49UxLxfl310kHn9H6MhaUnaSll2D7Z/xyjBQJxHoZfaEAMqaZ9mZiFUVc2qUfcuofT9Sr4qWo04mkJCcXOpmXVUIqPGai5qB3oPSofRNnt+9us8jlGbeGNZIjp/5xyfipNXYFVlAA34s+M8AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LO5mSuBZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H3hSyAPF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M0Gbiw3029078;
	Thu, 22 Jan 2026 10:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IEL27J9edB7AfTBz+f0qhSmylG/g4okWhSKC/VCE8j8=; b=
	LO5mSuBZqx7wPfbKHAbR2UpCE7LzmSYQRfdSvZnLBI9lJ4BvuHQ6HYbgeN2ENt8I
	VgNsrJZSLuTgjRPZkvFBitMJrrMG/rN2u4WFQiOSgz9Ozyh7WxpOtscTcdsTJ3qS
	IXNq3A2zdlp0crObNW9zKkw5TjIwJ9LfTH6ulOltcUVS8YlwQkpPgmroQqNzu569
	gQAlMznOHEp2WNwakXcfQQ5XvLdd2yup6zVPGObKICKEUumG5VwMn6W/PRFQ2+f7
	Dw8MElCvNXz7Jcnz5LFFBkH/Rp7lZQgxq2mLM9Nw/6Cjp4Ov/x2NNgX2IhMiIl/r
	24v/Yhb/Vc9S9gKHXugiBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vygxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:49:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60M9n5JG032149;
	Thu, 22 Jan 2026 10:49:50 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgf07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzMl98JklqiMHQjTGJNZQ9Y0aF3gGsFiPJdIae1CjReSduULl5pkZlN0H+7pXkuBijGGYkoxraiz8E8hFI9b2RF/f2q+EqA+eU7o7XwvLWyWFcO3c5RpOjhkPsziTIshhVMx3mW+GnqemUmKNk+FWHLrzLqKLjUR1K8KwaVWRwMB+zbghvwqzXHWuUCHhAydOC3Bq+B1BeSYhKHDgQfr5eR5PwEmDeyuKBaCtDEcweoBN2ob6JNPKyF0OTpgIon2zjwYppSKAJWgMgp8vgpMi6nHqT9x/h4QVr67tbhD69PLA3Ldu9E8BQSKFxBntFF9R62eRuPcwpyBJpPuEDjs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEL27J9edB7AfTBz+f0qhSmylG/g4okWhSKC/VCE8j8=;
 b=rtD8Jv3fV6KXoHRbNljWgInwGYG8ZVtItfiwNXrlSE4bFpN1i+mpOiNZz/s/CWKWfsrQdxwSkAp1Joy4Hawn1FmXhRldZrQ9Vgzbo5MvftKyjPCY2V5ZyxD+TAAeh5Q1d0N3+XZcIHQzHUkz68W6RDrZfC41XEsWlBq5x2I+xjiYSGL4qOZg3RzvIRpY/wUaGbYE+mAPY3QKcRjt+f6mljefESiE2R8nQ7aiqE3oW1kvwiv8hJKejls/ah8INC6JTGzpeJRVG6/o/TxGE0UNTTLuYx8CYfWaSFoCdvCq90kdDh6XDtwq9rEZ/vf44g4RLS4verKqCwEFdtk6LQljoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEL27J9edB7AfTBz+f0qhSmylG/g4okWhSKC/VCE8j8=;
 b=H3hSyAPFceoJ8kj+81rZqFJFccEtvW6zB3n0ul4TyKj9UYqOUXCrbYuJJvhXGH24ECTJKEJJ2XVrW4ZZ1VBASash/lKlBhUzqeUP2a520Xd5nqgl1CfSF09si67qPQyN5jA2zReceudJTFiy/HjZ9UUDA2OGjzaMghQQSsFasmI=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:49:46 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 10:49:45 +0000
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
Thread-Index: AQHcisoZzKcoj8C3rUu16aNbYxRdzrVdODgAgADIQYCAAAOKgA==
Date: Thu, 22 Jan 2026 10:49:45 +0000
Message-ID: <81A9E056-115C-4631-92AD-BA148B143DE8@oracle.com>
References: <20260122103655.GA1239220@bhelgaas>
In-Reply-To: <20260122103655.GA1239220@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|PH0PR10MB5845:EE_
x-ms-office365-filtering-correlation-id: 23eeb811-f661-460f-e2c6-08de59a3f507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3U1MjJCS21JZ240Wk9LVlh6ZTRoL2JLV3M2QzkzNWFrd2taV3pQZGU0L0xt?=
 =?utf-8?B?eFJrNGY1VnFYUVd1T1NOZHlFcjBwS29mb2F2eERPNDNPRVN2VGtFcExEa2xx?=
 =?utf-8?B?OUNyeHZPcFZ2OG01b0hKQVJkVVMza2MxNFBUTnVlTXd2aFgzZ2lyY2tEREsx?=
 =?utf-8?B?RmxLWUloRFZJN3JmTE5BK3Nueit6WVQ3UkRsc0FvZUdBUWZXSkp1UG1GTWRx?=
 =?utf-8?B?SkZIUndQSlZteEszRG55T0dzL3pTNE9INk1lRklKRHUrbTQvYnBkaUV6RXZq?=
 =?utf-8?B?TWNGMHBqaHZrWnFYMUhOTnV0d0NFVm5sNWtZYlZYWXJQSStQeUhTV1JSWkI5?=
 =?utf-8?B?MHVhVk9hNXpaYWU3WHJXMmp5NWRkRFBQU0dWeS8rWWlZTXltbGRpWmVNTFYr?=
 =?utf-8?B?elJ1NlVWUzlGUjYzeEliWTFqRWNka282d2hyckEyNndpODMydjQzVERHQkwz?=
 =?utf-8?B?TE1YZXNwdFpDeWt4Y2R0MlJrN0c2bHhHQXZmNTJEbkkrWG9yTGw0RDBFbHhi?=
 =?utf-8?B?UDYrZUVSRm5pRjQyRExZYjhhSEhONHEzZ2ZOdlFIaEtsTC8zSmhnK0dZdk9Y?=
 =?utf-8?B?MWQyWDUrL2ZKRjREdFRTaHBPeGhTbHZrNEN2emZMd3pPcGIzNmJaaHRDS2NX?=
 =?utf-8?B?UC9RemtacmllU2ZURkprdVp3dnFhb2grRk51cGg3Z3pPejdtTHYyWlltdEda?=
 =?utf-8?B?aXZXcGdSenBscU0wcU9Db044cHc5MWZxYzdWTDJkQm9qK05EaFh5YmNMaktR?=
 =?utf-8?B?djRKUUZ0SXZScWdnUjdMdi91enpoMXl0SGVMTW16aDg3K0RiNzR5QVhDNmZC?=
 =?utf-8?B?bGd6blAyK1FXbmdpendHMjBrZUh5QmZYR0tlY3M0TzlHVm5TR2RNZExkdmRR?=
 =?utf-8?B?WWMyN053bjVFb3kvNk9adHBicXd6OUovWHQ0cG1IMUhXYW9FbEV0dlNRWWs5?=
 =?utf-8?B?QjF0R2JuV3prcG9XSFZjUDkrRm9xeFgwTlZXYVBpOE5nNjN1VTBLZDJ0Z1oz?=
 =?utf-8?B?VHkyZGpJaWVITzZZNWV2SXFvU0FiNC9Ja2MyUXNtN1hPNEhESmptcEM1WXpm?=
 =?utf-8?B?N3F4Zk1PS3V5c0hJUVJheWxEVHQ5R2VhSE4yWnBZRDd4d0ZGdGNFRUYyWjBT?=
 =?utf-8?B?V0cyQUtNd3NEUlVacFJUclJ5V08vQmw0L0QzMnMxRmNCTVdHR0RwZGZsN2VV?=
 =?utf-8?B?QkRCZGl6aEdrWmRWU2FING9DUXc2OHdGMHVkTXR5SERhU3gvZlFXSldZbm1s?=
 =?utf-8?B?REJqbmpEbVFEZ2JsTVQwUTYrbk9jRHhmdjJxQzJKT1JGcFZwMkp5M1hQb0xF?=
 =?utf-8?B?QlgyaDZPVThqVy9CRGdqcGxaaGo0OTJ2M05kNFF1MzdlMk0yS1VhR1lPa3do?=
 =?utf-8?B?REZJTmg3UUVqSjRKWU9nbmxTMHpEUVJ1RUV4di9nc1NEWjduWUJ4YnAxMC9t?=
 =?utf-8?B?S3Y5ZTEreDdYbkExaWNrcVpPUUlJbDRibmx6RjNHcDhmU05udWN4OXErcDEv?=
 =?utf-8?B?MjdrU1VIZVlWU0RuQXh5Ym1Ka0JsR1B2M2hwTXBZZEtFV0Q1azdoS2x2dFd2?=
 =?utf-8?B?eGJSK2lZVER4K2JUNEJsMUFwN1pVcXNJWDh0cFdvUmttVmJMSGcxVGo5bWFK?=
 =?utf-8?B?WEVLL3VXM3RLSWRCVHB0dTRRTm90NzRqTmt0TTdsT2Y5dmkxNGFHSGhFNElQ?=
 =?utf-8?B?eGp5QTFaOStRV3o0QUJpZjk2ZVRQY1pEeURmaGYvdmVpOXM0SmtsOVNCczFm?=
 =?utf-8?B?dUpXcDQ2N1RsZ3krcm83aWtseDNlSVJHdXJrR2JFaFVyeEU3MlZ5T2dUWEtk?=
 =?utf-8?B?RmhEUGVFakRoVVpkNnFxSFNIR1hJQm1pQXdUNXF4VjJscEUveTFSTmtHanVG?=
 =?utf-8?B?SU9KMFlmVWlHekwzaGxaNXMya0hVaEJIblBROWwwZlZwenROaDJqMllmQVlD?=
 =?utf-8?B?OUM1WlZlWG02WHVaakxIV3JlZklmalJxdG1YTisyWVFTZ0p1RkZhOXdRV0RH?=
 =?utf-8?B?MjZvTldBbkRzYWx4cllvVmdNSzBFZjVpTnJncTA3cnZkSktwZkNkTGoxTTJY?=
 =?utf-8?B?cnFVUm4yMEIwQkM4NkFBa3FkK1ptT0h0cGo1ajFzWk90K1YrR1VvalAvTHpr?=
 =?utf-8?B?SHovQlpDeWlScy8yd3pMRDFiMFIrLzlhUkViUllFdXEvaEpxQjZPVCtCeTJF?=
 =?utf-8?Q?XilxSgQGPPc9u4LEgYgGsZQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk9ncG9PSUtScE9Jd1BsNXBzZEo4UlhqSTBZMXNsMloxcWg4UUJLYmNWUi9W?=
 =?utf-8?B?OGxSanhjU2RmeUd1TURXSGFXZkdnRmFhVUJlWC9YMUJkbDBRV0NwSmovcFZX?=
 =?utf-8?B?UEwxakc2c2VhRzlEeE92bE52Rmk3M3ZTNUw4ZVkweHZvQU1teUZ2L1N2alI0?=
 =?utf-8?B?OFdrUWxvYW1VbTk0Rjd4ZXZCQUttVGpZa2J4Ny9ML1lzUkVHclRDbTUwTHBR?=
 =?utf-8?B?eVo4M2xGSWdDZHljV2pyQ0R1V3dOc3o4RHdmZFNqazNsbjJFcnpHS0NDbEZ2?=
 =?utf-8?B?L2ROUzJCbXRFUjBCeWRyam1kOTB0YmxVR0R4c2JYWXl3TFQyNkYxRWxZSENY?=
 =?utf-8?B?TnhNblF4UjVvejlzMHB3ZG9aVjU4bFp4bkxOcVdURzZxem9IbnJ5aWNJeThU?=
 =?utf-8?B?SnpiQ2xqSHFLZnpNSXJHblZSZjM3dnZtenZQTWdPVDkzM0pYNlh6RTFtTFQ1?=
 =?utf-8?B?aHR3ZHl5UFhxeFJBblB4d29FZjBPcWsyZ0ZsK1kzWnA4TDBVbkEwNnFXZ1Z0?=
 =?utf-8?B?bnhBL1dSdURXSlN2Z0VqMjJDcXhGdUdIZkowc3hTRmU4bGorbXVIdWdJdWNN?=
 =?utf-8?B?WFRrdVgwOXBPSkc1c3lIOXVQRlQwSEVaSXluRnlrRkJWMFpUL2JmcGVkeDA1?=
 =?utf-8?B?MjhnNXVJaTFNTmMxVUY1akkxODB6RERmSHJFUHRwR3RuOE1LZDRraXFuZ1Ny?=
 =?utf-8?B?R3gwTU9Nbm9RM1lHTkZWYVRmVzBjd2RXODIyZlhEbEZkbFIxR2xVOUs5RjFH?=
 =?utf-8?B?UFgya3JJeitvN0M4N0lROEtJay9zR1hTbXFZQ1I1KzMzNUFVTmhhK2lRUGpp?=
 =?utf-8?B?U0taKzByL2djakZralQ3TUNscVNUUnhTQkc5eDJDbkxnNjNzNjRTNS9SZHlT?=
 =?utf-8?B?Z0w1Z0JRb0hwamVaSGlpaEpXUnBkK0ZxUUxuMEZ0ZHlJZWRLY21Cc1FldnAy?=
 =?utf-8?B?bThsZ2dlOG9jQ0cralpZb1RhTXNLRVAwZTNXek13WDR4bGg5YzRKdFhWTEFz?=
 =?utf-8?B?c1VNdzJIb3ZMcDZNQ3B3VzlDS2s2N2xNSWtRV0JnV0sxU296aVNReFNWM0o1?=
 =?utf-8?B?cWR0YTJRRkJBNkZ0U3BVSzdDNUtYcXhIVzJEdHo0R0pZN3FmblVJNlJFa3Jo?=
 =?utf-8?B?VWlHZk1uVEx3ajNmY2hhT3UrQ2VOUTdsQW0vNEY2QW9sWjRtWGQvRHdVNStU?=
 =?utf-8?B?bk8zeGtGTkJnUHZlaDU2dFhxOUxOQTVhNGswakxLN0dFT1ptbHRmR0tUcXJO?=
 =?utf-8?B?QlhzVXN4K2wvdUxjckRTRE11SDQrNU1YWnJaK2JLZUp3VFc4bkgvVlpHUFRn?=
 =?utf-8?B?MWN6ZlVIalJacFJ6ZU1QZnRkMGtwb3pZN002bnhOSmNzVnhka0ZtOXZ0MGht?=
 =?utf-8?B?QTR5OE1nWHluQnlJSVhzeXNCalpiTWx1SU02cTgyRWFSNzNEOVZDRktOcDdU?=
 =?utf-8?B?QkRpaTQvamtrWENLOGt5L3M4eWJua0tIOXdwWDRhMVBBU3Q2THBuZmI4Z2tM?=
 =?utf-8?B?Z0g4bjRIUmpIZzhTUnlTc3IrNVpZQ0dXZzQ1TktqbUNRS3g4clhBV28zZjBo?=
 =?utf-8?B?VUZvUHpZSlR1NXQzdUxSazh2S1pCRi9TdjJPTE9pU3VVSEErNUpjbTlSNjNG?=
 =?utf-8?B?K2ZUV295aDFKekV4aHhBOUF0L1JwdEp4NFJqVnZJSG4wRVNjdnBXandBOWZT?=
 =?utf-8?B?ZGhDdjhoTW53YWlFNjVBWVNzVFM0L2RuemlUMkl6REJtSEtVWEF5akpEUnBP?=
 =?utf-8?B?dWxRUUhsT0YrRTRXLzc4Rm1GQ2pESHRhTm1BOEh2K3FRTG1LUXAxRUdXUWp2?=
 =?utf-8?B?Y2ZON1JHUzBsaGthY1hJWmE2bzhWQ2pIK2hsQlZmN3U0Y0pvZEVmaDA4VFpI?=
 =?utf-8?B?ekMramg0OE42M3pXRnVHMjBIekI3WUlaZXFMVzR3TnRvZmJTS0laZEQ3MitE?=
 =?utf-8?B?YTRnMy9UdWFvVk5wdmM1cm9LL1JZYW5Fb0RmcU1USzVmekEwVnkxa3lSTnhO?=
 =?utf-8?B?OWJQUWZiTER4M1lZSlp3Q0w4aUVtUG5PeHpqTjZnNEJBRWRmanZGS3U0czJ1?=
 =?utf-8?B?ZkVybjVaNHp2My9SRkl0alY1NlNwTG9raytnWms0WG1UNXRvWklKWWpRVWR3?=
 =?utf-8?B?ak9WY2tZUE5ZZVJ6SWxsQndaYUJSZ2tyS1hjT2Q3Y05VZm9SVVZRNDVpR2wx?=
 =?utf-8?B?aDQ2b0JkV2VGSk92a0RUUUJIaVh6NkpzcWlpSXh1bFhGYUFLVTA2V21RTTdE?=
 =?utf-8?B?N3l1K0dXT0JxMkJ1MnlyTkRZWkFRMndyNnN3dU9FQ0tOdFJUOXY1UXpIN1RH?=
 =?utf-8?B?UjFoK0hpVTdjNms2a0l1c2t2OWlteUNHM3M1amhINTJuSjN5Y2s3Vnh3eTJ4?=
 =?utf-8?Q?98D852wOZE0Ka5cQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF091472CA9E2408F81D5E2F0216528@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CUpA7CV1IJIVObyFRErsfKC93mXHpyG3jNUvG3U0PfNwyqxGgLQfvqPE8HGBujSScUIlzCj+GOd704oFLbu9SnJ+LYvXDg4AD0vsRzAYh0Ih/lbBM6Z+Er9jOg1AAZTAK4eHTs8/pKoQTpItk2NQnsmQHQT8Mux7KveYpD8H+/dufBiZfaCSHIlzIUwc4W7cL1a9GzzMVzqhxXPMB2b6FMLdCKSDB2VZimjVwnAftThjaAaIZpMdr4JLsPpCfxmcvDMiXYy9lv00LQzJwlv7b8xaXF1E0i+jcwg3eK6f+vRGeA5MZyBhi/Q3xMnaj9kvXxVWu+AuOoWlLPJSZ2z9QUyxg7uluDW2THSb9VJ4l/aLeQfuPCeKDcpy0JMJNCpkEZlpODFJ4xM1KkqTihj+hqzP45CB2vWd9UvtNF/MWV0eti47at9EjkIjvRMmqtayMKtKsfosfBhfVB2v8oqEdxyc4uFoN3FQWsKeinSJ36Pu0iI8/z9VN06yHeaQT1mD1a8pt9QgRXCNpXgKGUSd5KNRJA+heX4VMZstDynwA8QX+MxthtRFuSMaDTPiEylnLni48s0g4d7PCQB3vpABVKo+C3ILxOSpcTqq3plY2Jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23eeb811-f661-460f-e2c6-08de59a3f507
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 10:49:45.8569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tq3vdla8YaM/2dlh0d9x5tFq6TYcVsipqJ2cmvvYJ8kqDfy1IcslpCe6YAYV4zT3RTI77uc/2AFWFBPwv57pHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220077
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=697200cf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=I8pYJOo9gm2BWFxcbAgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644
X-Proofpoint-GUID: BCFsc3h0__tU76iUcv-1ad4t4ishd0qP
X-Proofpoint-ORIG-GUID: BCFsc3h0__tU76iUcv-1ad4t4ishd0qP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NyBTYWx0ZWRfX7aKTH7J79j04
 pkD2sVgVcW2qujWvx/nGE9D8Pwm0LYeARk1MRC3iHDxcR+1NsxlNKjbNP8Z4l2V00v75QH4WHu9
 26pF7nOZU/S/y124KTq943w4T5Or1lQt9fcdsA0g9t04g06xgQ5fZa2EJ0Pt9hj9kjCEPzwJSfJ
 ByqyWlTgXevZAW18qKe/YehLLzb3c85Pa0HhTmpMZ+wkCD9T7kGNRiU5OrVAGaYXfQne253yy8g
 QjHOiwgxAKg8ScbEQ/3cP/9cMkDz+P8H3x7Jt++KvO8I9C6PNxi68D3dzLkjL+DA4FMugRCpF4+
 pMJsrRfCf6EMcFnPp0Xfj9Qq8FMGDFjzvQtTFMtn3mhKjTDTW2Hsn2UbIcyco7WIDgniWOlMF1W
 TwphtVCRnlEQwVroMT9Dy0auFb8BcbOUZnwFWDaZwn0MLO3FqJZAKrJC1CkVXr+nCnIkOS/DH5I
 We0uiwK+6er17+G3/3DfLuY0hSsTHQkhBPRgB2po=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20532-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: 6D7E465B16
X-Rspamd-Action: no action

DQoNCj4gT24gMjIgSmFuIDIwMjYsIGF0IDExOjM2LCBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gWytjYyBBbGV4LCBOaWtsYXNdDQo+IA0KPiBPbiBXZWQs
IEphbiAyMSwgMjAyNiBhdCAwNDo0MDoxMFBNIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
Pj4gT24gV2VkLCBKYW4gMjEsIDIwMjYgYXQgMTI6MzU6NDBQTSArMDEwMCwgSMOla29uIEJ1Z2dl
IHdyb3RlOg0KPj4+IENvbW1pdCBlNDIwMTBkODIwN2YgKCJQQ0k6IFNldCBSZWFkIENvbXBsZXRp
b24gQm91bmRhcnkgdG8gMTI4IGlmZg0KPj4+IFJvb3QgUG9ydCBzdXBwb3J0cyBpdCAoX0hQWCki
KSBmaXhlZCBhIGJvZ3VzIF9IUFggdHlwZSAyIHJlY29yZCwgd2hpY2gNCj4+PiBpbnN0cnVjdGVk
IHByb2dyYW1faHB4X3R5cGUyKCkgdG8gc2V0IHRoZSBSQ0IgaW4gYW4gZW5kcG9pbnQsDQo+Pj4g
YWx0aG91Z2ggaXQncyBSQyBkaWQgbm90IGhhdmUgdGhlIFJDQiBiaXQgc2V0Lg0KPj4+IA0KPj4+
IGU0MjAxMGQ4MjA3ZiBmaXhlZCB0aGF0IGJ5IHF1YWxpZnlpbmcgdGhlIHNldHRpbmcgb2YgdGhl
IFJDQiBpbiB0aGUNCj4+PiBlbmRwb2ludCB3aXRoIHRoZSBSQyBzdXBwb3J0aW5nIGFuIDEyOCBi
eXRlIFJDQi4NCj4+PiANCj4+PiBJbiByZXRyb3NwZWN0LCB0aGUgcHJvZ3JhbV9ocHhfdHlwZTIo
KSBzaG91bGQgb25seSBtb2RpZnkgdGhlIEFFUg0KPj4+IGJpdHMsIGFuZCBzdGF5IGF3YXkgZnJv
bSBmaWRkbGluZyB3aXRoIHRoZSBMaW5rIENvbnRyb2wgUmVnaXN0ZXIuDQo+Pj4gDQo+Pj4gSGVu
Y2UsIHdlIGV4cGxpY2l0bHkgcHJvZ3JhbSB0aGUgUkNCIGZyb20gcGNpX2NvbmZpZ3VyZV9kZXZp
Y2UoKS4gUkNCDQo+Pj4gaXMgUk8gaW4gUm9vdCBQb3J0cywgYW5kIGluIFZGcywgdGhlIGJpdCBp
cyBSc3ZkUCwgc28gZm9yIHRoZXNlIHR3bw0KPj4+IGNhc2VzIHdlIHNraXAgcHJvZ3JhbW1pbmcg
aXQuIFRoZW4sIGlmIHRoZSBSb290IFBvcnQgaGFzIFJDQiBzZXQgYW5kDQo+Pj4gaXQgaXMgbm90
IHNldCBpbiB0aGUgRVAsIHdlIHNldCBpdC4NCj4+PiANCj4+PiBGaXhlczogQ29tbWl0IGU0MjAx
MGQ4MjA3ZiAoIlBDSTogU2V0IFJlYWQgQ29tcGxldGlvbiBCb3VuZGFyeSB0byAxMjggaWZmIFJv
b3QgUG9ydCBzdXBwb3J0cyBpdCAoX0hQWCkiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBC
dWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4gDQo+Pj4gLS0tDQo+Pj4gDQo+Pj4g
Tm90ZSwgdGhhdCB0aGUgY3VycmVudCBkdXBsaWNhdGlvbiBvZiBwY2llX3Jvb3RfcmNiX3NldCgp
IHdpbGwgYmUNCj4+PiByZW1vdmVkIGluIHRoZSBuZXh0IGNvbW1pdC4NCj4+PiAtLS0NCj4+PiBk
cml2ZXJzL3BjaS9wcm9iZS5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykNCj4+PiANCj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMNCj4+PiBp
bmRleCA0MTE4M2FlZDhmNWQ5Li4zNDdhZjI5ODY4MTI0IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZl
cnMvcGNpL3Byb2JlLmMNCj4+PiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+Pj4gQEAgLTI0
MTAsNiArMjQxMCw0MSBAQCBzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3NlcnIoc3RydWN0IHBj
aV9kZXYgKmRldikNCj4+PiB9DQo+Pj4gfQ0KPj4+IA0KPj4+ICtzdGF0aWMgYm9vbCBwY2llX3Jv
b3RfcmNiX3NldChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPj4+ICt7DQo+Pj4gKyBzdHJ1Y3QgcGNp
X2RldiAqcnAgPSBwY2llX2ZpbmRfcm9vdF9wb3J0KGRldik7DQo+Pj4gKyB1MTYgbG5rY3RsOw0K
Pj4+ICsNCj4+PiArIGlmICghcnApDQo+Pj4gKyByZXR1cm4gZmFsc2U7DQo+Pj4gKw0KPj4+ICsg
cGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChycCwgUENJX0VYUF9MTktDVEwsICZsbmtjdGwpOw0K
Pj4+ICsNCj4+PiArIHJldHVybiAhIShsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0IpOw0KPj4+
ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgdm9pZCBwY2lfY29uZmlndXJlX3JjYihzdHJ1Y3QgcGNp
X2RldiAqZGV2KQ0KPj4+ICt7DQo+Pj4gKyAvKg0KPj4+ICsgICogT2J2aW91c2x5LCB3ZSBuZWVk
IGEgTGluayBDb250cm9sIHJlZ2lzdGVyLiBUaGUgUkNCIGlzIFJPDQo+Pj4gKyAgKiBpbiBSb290
IFBvcnRzLCBzbyBubyBuZWVkIHRvIGF0dGVtcHQgdG8gc2V0IGl0IGZvcg0KPj4+ICsgICogdGhl
bS4gRm9yIFZGcywgdGhlIFJDQiBpcyBSc3ZkUCwgc28sIG5vIG5lZWQgdG8gc2V0IGl0Lg0KPj4+
ICsgICogVGhlbiwgaWYgdGhlIFJvb3QgUG9ydCBoYXMgUkNCIHNldCwgdGhlbiB3ZSBzZXQgZm9y
IHRoZSBFUA0KPj4+ICsgICogdW5sZXNzIGFscmVhZHkgc2V0Lg0KPj4+ICsgICovDQo+Pj4gKyBp
ZiAocGNpZV9jYXBfaGFzX2xua2N0bChkZXYpICYmDQo+Pj4gKyAgICAgKHBjaV9wY2llX3R5cGUo
ZGV2KSAhPSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUKSAmJg0KPj4+ICsgICAgICFkZXYtPmlzX3Zp
cnRmbiAmJiBwY2llX3Jvb3RfcmNiX3NldChkZXYpKSB7DQo+Pj4gKyB1MTYgbG5rY3RsOw0KPj4+
ICsNCj4+PiArIHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NUTCwg
Jmxua2N0bCk7DQo+Pj4gKyBpZiAobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKQ0KPj4+ICsg
cmV0dXJuOw0KPj4+ICsNCj4+PiArIHBjaWVfY2FwYWJpbGl0eV93cml0ZV93b3JkKGRldiwgUENJ
X0VYUF9MTktDVEwsIGxua2N0bCB8IFBDSV9FWFBfTE5LQ1RMX1JDQik7DQo+Pj4gKyB9DQo+PiAN
Cj4+IFJDQiBpc24ndCBtZWFuaW5nZnVsIGZvciBzd2l0Y2hlcywgc28gd2UnbGwgcmVhZCB0aGVp
ciBMTktDVEwNCj4+IHVubmVjZXNzYXJpbHkuICBJIHByb3Bvc2Ugc29tZXRoaW5nIGxpa2UgdGhp
cywgd2hpY2ggYWxzbyBjbGVhcnMgUkNCDQo+PiBpZiBpdCdzIHNldCB3aGVuIGl0IHNob3VsZG4n
dCBiZSAoSSB0aGluayB0aGlzIHdvdWxkIGluZGljYXRlIGENCj4+IGZpcm13YXJlIGRlZmVjdCk6
DQo+PiANCj4+ICAgICAgICAvKg0KPj4gICAgICAgICAqIFBlciBQQ0llIHI3LjAsIHNlYyA3LjUu
My43LCBSQ0IgaXMgb25seSBtZWFuaW5nZnVsIGluIFJvb3QgUG9ydHMNCj4+ICAgICAgICAgKiAo
d2hlcmUgaXQgaXMgcmVhZC1vbmx5KSwgRW5kcG9pbnRzLCBhbmQgQnJpZGdlcy4gIEl0IG1heSBv
bmx5IGJlDQo+PiAgICAgICAgICogc2V0IGZvciBFbmRwb2ludHMgYW5kIEJyaWRnZXMgaWYgaXQg
aXMgc2V0IGluIHRoZSBSb290IFBvcnQuDQo+PiAgICAgICAgICovDQo+PiAgICAgICAgaWYgKCFw
Y2lfaXNfcGNpZShkZXYpIHx8DQo+PiAgICAgICAgICAgIHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQ
Q0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQo+PiAgICAgICAgICAgIHBjaV9wY2llX3R5cGUoZGV2
KSA9PSBQQ0lfRVhQX1RZUEVfVVBTVFJFQU0gfHwNCj4+ICAgICAgICAgICAgcGNpX3BjaWVfdHlw
ZShkZXYpID09IFBDSV9FWFBfVFlQRV9ET1dOU1RSRUFNIHx8DQo+PiAgICAgICAgICAgIGRldi0+
aXNfdmlydGZuKQ0KPj4gICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gDQo+PiAgICAgICAgcmNi
ID0gcGNpZV9yb290X3JjYl9zZXQoZGV2KTsNCj4+IA0KPj4gICAgICAgIHBjaWVfY2FwYWJpbGl0
eV9yZWFkX3dvcmQoZGV2LCBQQ0lfRVhQX0xOS0NUTCwgJmxua2N0bCk7DQo+PiAgICAgICAgaWYg
KHJjYikgew0KPj4gICAgICAgICAgICAgICAgaWYgKGxua2N0bCAmIFBDSV9FWFBfTE5LQ1RMX1JD
QikNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gDQo+PiAgICAgICAgICAg
ICAgICBsbmtjdGwgfD0gUENJX0VYUF9MTktDVExfUkNCOw0KPj4gICAgICAgIH0gZWxzZSB7DQo+
PiAgICAgICAgICAgICAgICBpZiAoIShsbmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0IpKQ0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+PiANCj4+ICAgICAgICAgICAgICAgIHBj
aV9pbmZvKEZXX0lORk8gImNsZWFyaW5nIFJDQiAoUkNCIG5vdCBzZXQgaW4gUm9vdCBQb3J0KVxu
Iik7DQo+PiAgICAgICAgICAgICAgICBsbmtjdGwgJj0gflBDSV9FWFBfTE5LQ1RMX1JDQjsNCj4g
DQo+IE9uIHNlY29uZCB0aG91Z2h0LCBJIHRoaW5rIHRoaXMgaXMgdG9vIGFnZ3Jlc3NpdmUuICBJ
IHRoaW5rIFZNIGd1ZXN0cw0KPiB3aWxsIG9mdGVuIHNlZSBlbmRwb2ludHMgYnV0IG5vdCB0aGUg
Um9vdCBQb3J0LiAgSW4gdGhhdCBjYXNlLA0KPiBwY2llX3Jvb3RfcmNiX3NldCgpIHdvdWxkIHJl
dHVybiBmYWxzZSBiZWNhdXNlIGl0IGNvdWxkbid0IGZpbmQgdGhlDQo+IFJQLCBidXQgdGhlIFJQ
IG1pZ2h0IGFjdHVhbGx5IGhhdmUgUkNCIHNldC4gIFRoZW4gd2Ugd291bGQgY2xlYXIgdGhlDQo+
IGVuZHBvaW50IFJDQiB1bm5lY2Vzc2FyaWx5LCB3aGljaCBzaG91bGQgYmUgc2FmZSBidXQgd291
bGQgcmVkdWNlDQo+IHBlcmZvcm1hbmNlIGFuZCB3aWxsIHJlc3VsdCBpbiBhbm5veWluZyBtaXNs
ZWFkaW5nIHdhcm5pbmdzLg0KDQpJZiB0aGUgVk0gaGFzIGEgUEYgaW4gcGFzcy10aHJvdWdoIGFu
ZCB0aGUgUlAgaXMgbm90IHRoZXJlLCB5b3UncmUgcmlnaHQuIElmIGl0IGlzIGEgVkYsIHdlIGRv
IG5vdCBwcm9ncmFtIGl0IGFueXdheS4NCg0KPiBDb3VsZCBlaXRoZXIgaWdub3JlIHRoaXMgY2Fz
ZSAoYXMgaW4geW91ciBvcmlnaW5hbCBwYXRjaCkgb3IgYnJpbmcNCj4gcGNpZV9yb290X3JjYl9z
ZXQoKSBpbmxpbmUgaGVyZSBhbmQgcmV0dXJuIGVhcmx5IGlmIHdlIGNhbid0IGZpbmQgdGhlDQo+
IFJQLg0KDQpJIHRoaW5rIHBjaWVfcm9vdF9yY2Jfc2V0KCkgc2hvdWxkIHJldHVybiB0cnVlIHdo
ZW4gaXQgd2FzIGFibGUgdG8gcmV0cmlldmUgdGhlIFJQJ3MgUkNCIHZhbHVlLCBhbmQgaWYgbm90
LCB3ZSBiYWlsIG91dC4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4+ICAgICAgICB9DQo+PiAN
Cj4+ICAgICAgICBwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RM
LCBsbmtjdGwpOw0KPj4gDQo+Pj4gK30NCj4+PiArDQo+Pj4gc3RhdGljIHZvaWQgcGNpX2NvbmZp
Z3VyZV9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+PiB7DQo+Pj4gcGNpX2NvbmZpZ3Vy
ZV9tcHMoZGV2KTsNCj4+PiBAQCAtMjQxOSw2ICsyNDU0LDcgQEAgc3RhdGljIHZvaWQgcGNpX2Nv
bmZpZ3VyZV9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+PiBwY2lfY29uZmlndXJlX2Fz
cG1fbDFzcyhkZXYpOw0KPj4+IHBjaV9jb25maWd1cmVfZWV0bHBfcHJlZml4KGRldik7DQo+Pj4g
cGNpX2NvbmZpZ3VyZV9zZXJyKGRldik7DQo+Pj4gKyBwY2lfY29uZmlndXJlX3JjYihkZXYpOw0K
Pj4+IA0KPj4+IHBjaV9hY3BpX3Byb2dyYW1faHBfcGFyYW1zKGRldik7DQo+Pj4gfQ0KPj4+IC0t
IA0KPj4+IDIuNDMuNQ0KDQoNCg==

