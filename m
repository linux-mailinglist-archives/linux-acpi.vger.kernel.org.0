Return-Path: <linux-acpi+bounces-20586-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMKfFyuyc2liyAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20586-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 18:38:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C97918B
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 18:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473A5303605C
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C07527F16C;
	Fri, 23 Jan 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UlvdS/nM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HnXebNHV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAE2638BC;
	Fri, 23 Jan 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189928; cv=fail; b=Lu3xYreKJgkHrp9i4cTaY62Tz5VF5cTGQ0e1uHrGi9J7yllPdWUHe4wdVAgVuw4lrw57tSPH/nyifuqlGAFhgmP4fYsZwbWo3TjVAQSjTCvbEGbcIWQ84hudWjieSNULPWRGXsHGue+/Zxak/A+rV7BXxvTlGT/fjMhMG0IZSI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189928; c=relaxed/simple;
	bh=uRghxiuiKIw5ITM5v+iB2zvDYAGJCLOytje0ciy3Yxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mgsiiawvt6K9DgqS+j1HN5RZ9T4Ed1Z0WL86Mczj27oeWrLqY04tqo10ERDs9MduDqdzA3XXOZzkfRzOIBxfa8zrx800/iG4HCP1mHojbx6w6DVNYVPLw34YawaI/U+UaCvDX8UOsQS37FEk/c35rGNkxDyFz6IKUnGYZujSlm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UlvdS/nM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HnXebNHV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NEQHI52405273;
	Fri, 23 Jan 2026 17:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uRghxiuiKIw5ITM5v+iB2zvDYAGJCLOytje0ciy3Yxw=; b=
	UlvdS/nMsGZ0+gJ5WpRbTK6SBsKGCugbwbEs7q/WAvlAUnijsFSJNIoIMyvUKUm+
	ifjDbG2SWSEeCPeDcKEbGqBM6NZqVhZbSwHhFbUW7BjPJko2mfqKXQ7L4XLZxL3Z
	HSrKbrNjztw9HTt4aTyMTyj7HTTBfrjmXSt01p8jkes9LYep+vJDrI4hBLPsd9dp
	qaymkZZIksXnCrRS8cC73A+MxdKVqDuxRkk3Mm2MtkhNy+Z7dQCzBj9QJJqJNUAm
	UL+ATzc+cF9Zlwf5vhgDZeAfWX8M+c6mV0jI/YXUWGTQ4VWFVwtEzuhaY5L/DBl4
	0nkMZj+3hrAj8FNthpb7vA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qjy6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:38:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGrvNG033144;
	Fri, 23 Jan 2026 17:38:38 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4buyvf4mc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le/2ZpEW9HV/koy35un/ZGklGmZ1jW6ID6sCK+4hijd+8/P4E2LZ+URXW87ClZWkMVBJMf+HlTSOxp3Hu8NooQR8eOF2rHCPBsVw58Rvg0mN5W9EpaX5M+bFa20aVgDYpt8OmL+yy9k55el8zkIFE4nQ/8waQ4QB3Hhzo4ibkeiIQyndlVLpWfxzpYRs9jVJEtbTvElSNL1903UbDC65+sidrKY30n4NcRxfCxoIyhTzkjLBOovOa4VjeEgnnI3MR/3w8tzmWA3NE7FW5werp5k+5DQyhI3/Kb5aQ1QcdSX8uN4dBMomKoa3Q96C/tnPJPbz2rn+FgBht3NawUd1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRghxiuiKIw5ITM5v+iB2zvDYAGJCLOytje0ciy3Yxw=;
 b=c+dY/5+vxmzH5AcjQ4n/XUY+bEu/DeWzFH4gxI3eBU5AjDhtP0l3TUo1wUeh6/mJIENqy22n/Ff35V95rpx+o9e/KM5jCuREOwoyaoKDYijmL6SG8RNSAXTv1543odE2Kw+agOsYVaQgVP4NkOBYAXjl/0HeUJtoWxyMKJVkTLTbkjU/Ac/XRrJnOe4nL9Isg+foFVs0BWLV/OdfRxB7La76do53lPENuHjR5IQcBEEuE5KZZfmT7AzTLQAifm0oHHuV3PBy0uOyFdw/W5uLknWA1ya3IoYfEkVJ5w3G1znUfc0UG9AHqZhijJEiMFlT/NG4CJ3ruEzAWkC4vF9AhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRghxiuiKIw5ITM5v+iB2zvDYAGJCLOytje0ciy3Yxw=;
 b=HnXebNHVwdCASt8SwdEYQIk1eEjg0Jv5jEb50Fvs7AKUKz/zBL1IwEZ4hxoMb1iVy02GlH+EsqQzQDJGHEX4q0pxkjDr+4xRi1TPKYYxzlPcyeOD3WSKnknPBSEIBiifjdJ9qY7ENgcEJvcYHLqtGD2+x4rSdI9eLAieX+APALE=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by IA4PR10MB8349.namprd10.prod.outlook.com (2603:10b6:208:567::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:38:19 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:38:19 +0000
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
Thread-Index: AQHci6Bw4Ah2IJD57EKH4IA39ueuwrVfuoOAgABMTgA=
Date: Fri, 23 Jan 2026 17:38:19 +0000
Message-ID: <7E4D523D-5105-4173-AC1A-8B7898DC48A8@oracle.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com>
 <20260122130957.68757-2-haakon.bugge@oracle.com>
 <a91e38085a9458455adccbaa18a0d80dd6797dcb.camel@linux.ibm.com>
In-Reply-To: <a91e38085a9458455adccbaa18a0d80dd6797dcb.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|IA4PR10MB8349:EE_
x-ms-office365-filtering-correlation-id: 4001ea85-0b36-4c99-fc7e-08de5aa632b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFdFWU9Kb0wyOEsyODVwTm5ZZGFuRVNQVlRzVndUaEtaeXVBSGtaSzlXY05t?=
 =?utf-8?B?YmdaVmFlYTZyMnV1U1E5ZXNEVlRBYzIrcXBjNW93ZE1NRDYzckZNU1NCQW8z?=
 =?utf-8?B?SFBKRmRPaForSHJxbzB6VnZ4RFNKeHZUUlpEbjZtYTJSRlNIODhUU3hWNVVP?=
 =?utf-8?B?RlJOT2xLQXA0Q09CVXhQWVUxVzNHZURHZ0tQdVRTcWtRRzh5WkdlT294UjNl?=
 =?utf-8?B?b1ovUXlJNHVrWkpHWjgrZStzcHRsRmpsN0themFaN1JNbkJBWGI0U3VEcDA4?=
 =?utf-8?B?UXJxbUlaNUd4dG1FaVNQaEZDMkREODZINnMwc081dC9xaFNkclB2WHFoZnlN?=
 =?utf-8?B?a0g4bFVjNWpVZFZaKzZtelBiS2FPNzVmOWlPVkExRlhwb2g3dTBEK0ZYVytq?=
 =?utf-8?B?VkYwTlZUV0NrRVZOYVB0cjJ6eHU0ZE5tcCtNOXdUMXU5ZjRueXFuZUZFN1oz?=
 =?utf-8?B?K2orNHFLQXFVQVV4cWlVajl2bXhua1NoSUlZdUFqTE9PZTl5WWN5RXZ6VC81?=
 =?utf-8?B?bFRrNEFLVko3UFZYdTNUdWZqUUF2VkV2bG9PZHhBM1d2Z0g1K1pIZHA2ZXNO?=
 =?utf-8?B?VmxBQkZOMmo1ZWRiVzc4ZDVhVkE1VHNZaitiQXhCZlRKUVlWN2krQjZ0Uk5U?=
 =?utf-8?B?ZnJvY2w1VDhoRjhpZEdoTWp4RTJ2RFNmM29pamN6M3k1QytQd1NIekVpOFcx?=
 =?utf-8?B?VTBreWUrc3dkV0N0OUlhZHBEN1JFbWlBTVVVZjFja2pFSDJPN293Q0tsYTVF?=
 =?utf-8?B?a21VU2IwMStkUHNkM2VqeGRvT0IwSmJiSDV5TS9CcnRoUDFPd2Z5T0JFUUhi?=
 =?utf-8?B?dGI4bXZsQU12UXY1ZkRhVWZ3WGE4UVR5dEhDLzJ6amkrNE4rd0J3alZ4ZTBh?=
 =?utf-8?B?Vm9Gd2hxQ0x3VUJuLzhEYklEQitaY0VpcXRjWE5iWXFkQWp1VlpLRUpKbU44?=
 =?utf-8?B?ckR6RDBCZU5YU09uYXBjNm91c0RraFlQUVZUb09uUis4LzVFVTBVemFBMG1Z?=
 =?utf-8?B?NHFJaU90RDlSWXpuZ25RTlpLRTYyRzgybFp6T2FXdHZhRkJTdnNBS2lETG5H?=
 =?utf-8?B?ZlJTYy95cmJOaXN3U2xXbDdWdUp3U1RuZ3p6TVpKRi96TGcxY040ZVBYdWth?=
 =?utf-8?B?UXUybmdSK1BFRXFlQXl4RkJ6ekRWVWhoNUl0QTN4OHVQaiswdmlKem5UTll4?=
 =?utf-8?B?Y0pmKzZERkhCZ2ZzRC9OWUcvQ0V5WGNFdWpUNXV0T3JJOG9UN3pnWHF3M0JH?=
 =?utf-8?B?NnVYYVVJSXhuNDgxR003WUU3Q0ROdlYxdXZDVVhiME5mWVluajI0dzFLV2s2?=
 =?utf-8?B?SEpKZmJhcmkvN2FIRjFBUnFHYW1HZGVFcGVOMlgrK3Y4L3lyeENMdGs4Rkli?=
 =?utf-8?B?NWdRQkwrakhsRmRRVTdnRGUwSDhlOUlCTVc0UkMzckV0VXlTVG1BTUVUSHJM?=
 =?utf-8?B?MVVmL04rUE5SNmRNZlhBQ2w5OW9WOFlnZkMzaHFHK0luUkRuZW5iNE5PaU03?=
 =?utf-8?B?RXcxdk9nMUFKVFdEUjFBVTZUSTE3UWViWjBPemRkazh2UWdiSnFmc0Q1d2JZ?=
 =?utf-8?B?RGJJakkzSjE4L2FPc3BCeXVzOVFFVFJsNW5Gc2hvdkw2RkYrdVpCV2p2ZUt2?=
 =?utf-8?B?SGphMmtabmp0NS95dmNqUzY2M0JCT0FnUGRaNC9GUG41VGNTcXdYeVozTFBX?=
 =?utf-8?B?SXNoUEpGZjcydlFhTEl4SWxMWGkraEorc1hKdjRZTHcycGJiczk4Z3dmYmFG?=
 =?utf-8?B?QnpnYUtacFE5WEdXWkx2dGFXTkhpaHlyTDcvWVA1NmU3R0VnQ0E4MUViMGh4?=
 =?utf-8?B?UThEaXVjM2cwV2paMGx2V2Mvb1YwNGJqL3JUYnpwNGlLeTN3cmN3MDVOWTlY?=
 =?utf-8?B?dHhQNGdWUFpYcktwMVNkOS93SlJTVDdydmdTMWtGcGo5MDIzeUNRQkl3YnJU?=
 =?utf-8?B?Y0tPTi9ST0cxYjNzMytTV1lOcmFpSFkwT215Vy9WdnI2dE9VcWRKMlo4WGlN?=
 =?utf-8?B?SExJeUZURW0zN2hPTWkrOTJMem80cjJFV1ltNEovQTNwL3NuVVlxeTRDLzE0?=
 =?utf-8?B?ME1IVnhndzM5VzhKWDNLNXB0ZnVOTTZ1RVFNazU5c3hxeXpic3dHL0FJRk9v?=
 =?utf-8?B?M0hUN0ZwVWdiY0l1R0F6MzFZcHpQL1JBOGs3TVNWNnNnc0J2QXY3ek85WitC?=
 =?utf-8?Q?FSMH9ptjn8Iwz8xTfV5DKB8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVo1T1QyVVRFbjBrTUNIRmJZQXZwdFZ2NWR1MlFDV2pwTVljVU9ZbVQ2L1ho?=
 =?utf-8?B?MEt2a1B2N3ZFTDZtVUtiMGd1MFBQMm9YMVlVeXQ2RzFHbjVEM0crNTRMUjdW?=
 =?utf-8?B?SWRKc25hUlYxczdiTEVsZ0srQ3dHVjdiUkRpeDc1b3hiYlREdklLbllhcy81?=
 =?utf-8?B?dklZUzFYYitlMk53ZllibjgrR1gvTkE4bnNidlFGc01uTWZ0cWJ4YjZEbjN1?=
 =?utf-8?B?RlFPWUZuUEswMHhSTW84UVA3ZTRQQTFaa3VUQmhCUUFDWWszNjJFZWc4YTdY?=
 =?utf-8?B?TEcrY00waVBSZXdCbEVxRzBFckdKRERxeXRoMEo5UmRiWnNGcCtvUHcrU3dF?=
 =?utf-8?B?WlJPUExMczlQa0JYWHdKcjdSUXJOamhvbGt4MXFtdWlYVzRWeFRWVDVRbDd6?=
 =?utf-8?B?QmJZMG9vUmFOcEsyYVA1dUJ1N0xIY1Y2bHA2SEl5VVlaT1dJdGcvTlR2VHBC?=
 =?utf-8?B?UkFXVDIvemt4NHR1UXVoVUV5OGI1NmtSYmdYMEdzN3dnMnZUWHFMYk1CdnQ2?=
 =?utf-8?B?eFp2aVJObzQ3UGhGRXJQaXJ2Z1Q4UkZhc2FBUXZJelc0TnY3UkZ2dTRiaWtK?=
 =?utf-8?B?enZ3QWVjK0N6aktmMHQ1MFZydTRXVERQWTZReTJpODVHYXFDMlF3TmhYUXVW?=
 =?utf-8?B?a2h4blUvTU5rU1hNR0hoR1R2WXQxcXZYV0xWeXNlOUx1OUNEVjI3Kzl4b3B2?=
 =?utf-8?B?SEtIK1FSWitCZzBuS2xCSGtJd1JVdDhJcEhvOXE3ZmZwakZWcERiR21GVTN0?=
 =?utf-8?B?Nll5YVZYbW9wdUFEZ3RmLy9oVnNiN1BmK25uYmt5WUhqN0JVdlIrYkNyWDdJ?=
 =?utf-8?B?aFFzb3o5UUdabHlrR1I2alh6SzlhUFF3VHVhQXpUZFlUcDBReUlIQ1ZEeS8w?=
 =?utf-8?B?WlJob2tVV1dJcW5WSjIxcjI0VW0yd3I4aTJ6YXppeGpLWlRnWkRCRDMwc2lq?=
 =?utf-8?B?cmNqRFN2d3JZWS9ONFRCMzk5ak9oTUIzdkJHY2J5aUVERlJWNExGSGtCVzZ0?=
 =?utf-8?B?aUw2eDljNzdRWlZPZ21YbzF1TzRoWVBSb2hRRzB4Y0pFSTVNdjZzNDZsajNm?=
 =?utf-8?B?cGRQYnA5cnRZazJBTmNYNm5oYUVJWDNpWGFTREpRZVlJTzRva0YrVzZrbDk5?=
 =?utf-8?B?c3pWTDZJaXBuL21Ua2Z2QWxMNElvMGI5ZmFwSUNScEFtZFFFeFhEUlhsU0Q2?=
 =?utf-8?B?eGltZUxQdnRURnFEZkxnMGc1U3NidUIvZ3NZQ2t6TlBNMHhxZkVxVnNxazR1?=
 =?utf-8?B?d1RVV2ZQd1VFQkt0RDdtWHdmcGE1eTZoa09LNTVHZDgva1NYY0RkMlV6Y1p1?=
 =?utf-8?B?UHo5UC85UGhNNVJZeEpSZWdYVjJFSTczTkl5eEZhUXp1THJVaEpZSXVHemdT?=
 =?utf-8?B?SmZURzRlZlRnZUxhZTFYNzIyVVdoZWVVMURHMVVpZ3dycnFtL3dHR0VpSXQ1?=
 =?utf-8?B?WU5wSStJKytyQXFaSW1qNWc1U2p6QU9PTXBVSlhQN2lZemNPT2JIYTNIblZx?=
 =?utf-8?B?ajB1NkhoREFmL1FpYTRDRFRNYS8zbG1neERHbzkyRFUwWHh0WS9XcEQ1aG1z?=
 =?utf-8?B?dGVvd2pmTUsrRFJiMkNhaC9ScnlsemZlN05pd09URUlmU0NtMzNNT3NhSGJQ?=
 =?utf-8?B?MUs5RXhMbm9tVHJaQy9qV1FVYVdKVS9PZWJWUytudHlWaG9pSS9rYmJZU1FD?=
 =?utf-8?B?Z2ZOOWpramFQSGxDNGtGTk96OVp5b2RXS1RqTmdmNURNS0lhaW5TNksveG1j?=
 =?utf-8?B?MXp3R3VrQlE5NVFmbktnUnViREtuK0dER25mRDY5U2NBZXlzdG9jUlpuSzQ3?=
 =?utf-8?B?M3VJUWZrdGYxRUlwRDZaWUtuekphY0NmQVBRbWcxS201KzM1ZllzL0NLT2xt?=
 =?utf-8?B?aWpRYnBJSXJYcWlidmNLMlN2NmhRdlhySldrdmlTVHdiRUZoSnhRWHFXWWg4?=
 =?utf-8?B?VGJ3ai9VMjE2QzUrc1prYVdNa1UwZ3pyUkFGZnVyWUNaQUYzV0pyNFFyNGYr?=
 =?utf-8?B?WnFFMjg0QzFQUWdxb2dDSTFaV0xRWVNSTWI0ejVhQTFBaFJlNkUxZk1ZWXZs?=
 =?utf-8?B?emF0TDhmV2dmTkVyUXlFNXhVRE45b3NwWE8xZDQvN1FPWDJJbGNXa3B6OS80?=
 =?utf-8?B?Ti9rcVdNYkVrM3luR3NhbTFqeU55QWRmb25OcE9SYk91VTFlZjBPRDJmWFYx?=
 =?utf-8?B?Q0JIZk9SU2hTV1ZZb21SYkpucGtsTjREMzMybHdXQm43WXZaajhIN3JKR3Fv?=
 =?utf-8?B?NHVVdXZkeklQejR3ektmL0lNWjU2VDJNTDFWMExqbHJFeDhUOUwwSjhPY0Yv?=
 =?utf-8?B?K0dHZnpVV3d2WEFCWjZVclVwQ2d6OEN2cnBaaUUzajU2QmhXeVd5dS8wejlC?=
 =?utf-8?Q?lbHamdGfbQjqSSVM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <983699756A1E1445AE9A6FAAC0D4B889@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MMPk99os2UD5OUN4OeVH9Tf37RBbt/oQdNvpwQ9/2RkxRTpI7OqjT91g/TVRfb8fX6b4suivdeYXY4lERqmlmW0Qr1584UYLaX7/VImabvKd3o48pUuaSmdjPp8XC7LfKfvIPU0IfT+3+8EJb3bF+Bre9OzJBx2nJgJrMEFzXnAI9zQzp5hkRGF4GwU5PI9YHX0tHjaGlmhgRe6buYCtzYiNryOjILOf6IW9U+hbj5oMFBzRqD4WUvKDf/ZL98NDtb3gHeyNVTvuV8Fe1hiU0fAFbKgma5Y1LzQ/z/9n7WT8+E24d8IIFlwo5q2ld1mDvuw0yVklw62AMtf14J7RqXqlss7ifjbr5YjXXEN4QceQ6M7k2WGnQw2ysIPUwXA6l4OW9cg7sMMVLds6MNzxvk7fEpuFWdlLn/k4/gHt4LE0R0/vCawKBPpJn/0Go6ynWle2ljSfLRfkii0RBfwJCZflQRBXl5l3pe9C9D2QRscueRfu0gaL+AmKesIJH4Uip/jskEhlozispjdIUVOZitadZcJd3HRXYb1F4+ZkwwItxu5V35CLc3daaylBPJk9upBXmeD8dWtfY86HWmLTv0NAy6kKc7KjM2XfIktwFlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4001ea85-0b36-4c99-fc7e-08de5aa632b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 17:38:19.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh/FW8Iet8Q+ctp68ta953iNSPY1pkx3Oena27wx6ReggoNL0cnmnaTnpdBOMqLDvS1qnCXQI/MU474lvvfBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230133
X-Proofpoint-GUID: fOjQ3ABR8zxZfgAWWgP-kzxlsf5GBu_o
X-Proofpoint-ORIG-GUID: fOjQ3ABR8zxZfgAWWgP-kzxlsf5GBu_o
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=6973b21f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=R9oui51qhxgMLEqxFzcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMyBTYWx0ZWRfXzlw/ItqQFFxS
 f4g7Phlz1uJl/3DyO1NZXWWJmr5OGo7sobNT8IToifbO5NxL/yIIbpCH42a05TPm/6nsLzEQP44
 jeoy+Nxd/3RsxWFVm+qGAty/R16gb8jMwXbfPDYgPK99pY8CRPsnec1hy4HDFnIg16/JK8OuClx
 MlSe/lpMFlZjUxICSH0AzL/XGjodF89pUO7Wiln0dcGj++4MWWC4fbiluNowt3oMrsdMWtlC8vu
 avjDopuGc6adaN9qhCMeoe7KPHqByk3V2ahb8KgPv4rkJI/BMrFwXub33zDTTNdJbMLOhAbKYh3
 Kfzzdj+TM27Ov38W0VtufGVtx54RrHRNFjhlC55RtrcAjTcEb7HQ0logOH63oM0oXLg/+oo09Hq
 pHtB3fYBECFu/gog1fjsNvbtczONTJlNJbQFt2h21xPKh1d98gj5een3xUyZmSaVIACSCQqrNCG
 82U6WlwMRQDC6Q3SIGQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20586-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AC6C97918B
X-Rspamd-Action: no action

Pj4gT24gVGh1LCAyMDI2LTAxLTIyIGF0IDE0OjA5ICswMTAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6
DQo+PiBDb21taXQgZTQyMDEwZDgyMDdmICgiUENJOiBTZXQgUmVhZCBDb21wbGV0aW9uIEJvdW5k
YXJ5IHRvIDEyOCBpZmYNCj4+IFJvb3QgUG9ydCBzdXBwb3J0cyBpdCAoX0hQWCkiKSBmaXhlZCBh
IGJvZ3VzIF9IUFggdHlwZSAyIHJlY29yZCwgd2hpY2gNCj4+IGluc3RydWN0ZWQgcHJvZ3JhbV9o
cHhfdHlwZTIoKSB0byBzZXQgdGhlIFJDQiBpbiBhbiBlbmRwb2ludCwNCj4+IGFsdGhvdWdoIGl0
J3MgUkMgZGlkIG5vdCBoYXZlIHRoZSBSQ0IgYml0IHNldC4NCj4+IA0KPj4gLS0tIHNuaXAgLS0t
DQo+PiANCj4+ICtzdGF0aWMgYm9vbCBwY2llX3JlYWRfcm9vdF9yY2Ioc3RydWN0IHBjaV9kZXYg
KmRldiwgYm9vbCAqcmNiKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHBjaV9kZXYgKnJwID0gcGNpZV9m
aW5kX3Jvb3RfcG9ydChkZXYpOw0KPj4gKwl1MTYgbG5rY3RsOw0KPj4gKw0KPj4gKwlpZiAoIXJw
KQ0KPj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4gKw0KPj4gKwlwY2llX2NhcGFiaWxpdHlfcmVhZF93
b3JkKHJwLCBQQ0lfRVhQX0xOS0NUTCwgJmxua2N0bCk7DQo+PiArDQo+PiArCSpyY2IgPSAhIShs
bmtjdGwgJiBQQ0lfRVhQX0xOS0NUTF9SQ0IpOw0KPj4gKwlyZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+
IA0KPiBJbiBwcmluY2lwbGUgdGhpcyBpcyBvbmUgb2YgdGhlc2UgdGhpbmdzIHdoZXJlIHBsYXRm
b3JtcyBsaWtlIHMzOTANCj4gd2hlcmUgdGhlIHJvb3QgcG9ydCBpcyBoaWRkZW4gKG9ubHkgczM5
MD8pIG1pZ2h0IHdhbnQgYSBob29rIHRvIHVzZQ0KPiBmaXJtd2FyZSBzdXBwbGllZCBpbmZvcm1h
dGlvbiB0byBkZXRlcm1pbmUgaWYgdGhlIGhpZGRlbiByb290IHBvcnQNCj4gc3VwcG9ydHMgdGhl
IHNldHRpbmcuIEkgd29uZGVyIGlmIHRoaXMgd291bGQgbWFrZSBzZW5zZSBhcyBhIF9fd2Vhaw0K
PiBwY2liaW9zX3JlYWRfcmNiX3N1cHBvcnRlZCgpIGZ1bmN0aW9uLiBOb3Qgc2F5aW5nIHdlIG5l
ZWQgdGhpcyBub3csDQo+IGp1c3QgdGhpbmtpbmcgb3V0IGxvdWQuDQoNClRoYXQgbWF5IGJlIGEg
Z29vZCBpZGVhLiBCdXQgSSBhbSBub3QgcXVpdGUgc3VyZSBob3cgd2UgY2FuIGZpbmQgdGhlIFJv
b3QgUG9ydCBmcm9tIGFuICJvcnBoYW4iIGJyaWRnZSBvciBlbmRwb2ludCB0aHJvdWdoIHRoZSBw
Y2lfYmlvc19yZWFkIHNldCBvZiBpbnRlcmZhY2VzLg0KDQo+PiArDQo+PiArc3RhdGljIHZvaWQg
cGNpX2NvbmZpZ3VyZV9yY2Ioc3RydWN0IHBjaV9kZXYgKmRldikNCj4+ICt7DQo+PiArCXUxNiBs
bmtjdGw7DQo+PiArCWJvb2wgcmNiOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBQZXIgUENJZSBy
Ny4wLCBzZWMgNy41LjMuNywgUkNCIGlzIG9ubHkgbWVhbmluZ2Z1bCBpbiBSb290DQo+PiArCSAq
IFBvcnRzICh3aGVyZSBpdCBpcyByZWFkLW9ubHkpLCBFbmRwb2ludHMsIGFuZCBCcmlkZ2VzLiAg
SXQNCj4+ICsJICogbWF5IG9ubHkgYmUgc2V0IGZvciBFbmRwb2ludHMgYW5kIEJyaWRnZXMgaWYg
aXQgaXMgc2V0IGluDQo+PiArCSAqIHRoZSBSb290IFBvcnQuIEZvciBFbmRwb2ludHMsIGl0IGlz
ICdSc3ZkUCcgZm9yIFZpcnR1YWwNCj4+ICsJICogRnVuY3Rpb25zLiBJZiB0aGUgUm9vdCBQb3J0
J3MgUkNCIGNhbm5vdCBiZSBkZXRlcm1pbmVkLCB3ZQ0KPj4gKwkgKiBiYWlsIG91dC4NCj4+ICsJ
ICovDQo+PiArCWlmICghcGNpX2lzX3BjaWUoZGV2KSB8fA0KPj4gKwkgICAgcGNpX3BjaWVfdHlw
ZShkZXYpID09IFBDSV9FWFBfVFlQRV9ST09UX1BPUlQgfHwNCj4+ICsJICAgIHBjaV9wY2llX3R5
cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfVVBTVFJFQU0gfHwNCj4+ICsJICAgIHBjaV9wY2llX3R5
cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfRE9XTlNUUkVBTSB8fA0KPj4gKwkgICAgcGNpX3BjaWVf
dHlwZShkZXYpID09IFBDSV9FWFBfVFlQRV9SQ19FQyB8fA0KPj4gKwkgICAgZGV2LT5pc192aXJ0
Zm4gfHwgIXBjaWVfcmVhZF9yb290X3JjYihkZXYsICZyY2IpKQ0KPj4gKwkJcmV0dXJuOw0KPiAN
Cj4gVGhpcyBzb2x2ZXMgdGhlIGNvbmNlcm4gQmpvcm4gaGFkIGZvciBoaWRkZW4gcm9vdCBwb3J0
cyBpbiBWTXMgYW5kIEkNCj4gY29uZmlybWVkIHRoYXQgdGhlIGNoZWNrIGNvcnJlY3RseSBiYWls
cyBvbiBzMzkwIGV2ZW4gZm9yIFBGcy4gVGhhbmtzIQ0KDQpUaGFua3MgZm9yIGNvbmZpcm1pbmch
DQoNCj4+ICsNCj4+ICsJcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChkZXYsIFBDSV9FWFBfTE5L
Q1RMLCAmbG5rY3RsKTsNCj4+ICsJaWYgKHJjYikgew0KPj4gKwkJaWYgKGxua2N0bCAmIFBDSV9F
WFBfTE5LQ1RMX1JDQikNCj4+ICsJCQlyZXR1cm47DQo+PiArDQo+PiArCQlsbmtjdGwgfD0gUENJ
X0VYUF9MTktDVExfUkNCOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJaWYgKCEobG5rY3RsICYgUENJ
X0VYUF9MTktDVExfUkNCKSkNCj4+ICsJCQlyZXR1cm47DQo+PiArDQo+PiArCQlwY2lfaW5mbyhk
ZXYsIEZXX0lORk8gImNsZWFyaW5nIFJDQiAoUkNCIG5vdCBzZXQgaW4gUm9vdCBQb3J0KVxuIik7
DQo+IA0KPiBUaGUgRldfSU5GTyBpbiBoZXJlIHNlZW1zIHRvIGJlIGEgcmVtbmFudCBmcm9tIEFD
UEkgY29kZS4gQXMgZmFyIGFzIEkNCj4ga25vdyB0aGlzIGlzbid0IHVzdWFsbHkgdXNlZCBpbiBj
b3JlIFBDSSBjb2RlIGFuZCBzZWVtcyBjb25jZXB0dWFsbHkNCj4gbWlzbGVhZGluZyB0byBtZSBz
aW5jZSB0aGlzIGRvZXNuJ3QgY29tZSBvdXQgb2YgQUNQSSBvciBvdGhlciBmaXJtd2FyZQ0KPiBj
b2RlLg0KDQpJIGh1bWJseSBkaXNhZ3JlZS4gQXMgcGVyIFBDSWUgcjcuMCwgc2VjIDcuNS4zLjc6
ICJEZWZhdWx0IHZhbHVlIG9mIHRoaXMgYml0IGlzIDBiIi4gU28sIGlmIHdlIGZpbmQgaXQgc2V0
LCBhbmQgaXQgaXMgbm90IHNldCBpbiB0aGUgUm9vdCBQb3J0LCB0byBtZSwgaXQgbXVzdCBiZSBh
IGZpcm13YXJlIGJ1Zy4gQW5kIHRoYXQgaXMgZXhhY3RseSB3aGF0IEZXX0lORk8gaXMgaW50ZW5k
ZWQgZm9yOiAiSW50cm9kdWNlIEZXX0JVRywgRldfV0FSTiBhbmQgRldfSU5GTyB0byBjb25zaXN0
ZW5seSB0ZWxsIHVzZXJzIGFib3V0IEJJT1MgYnVncyIgKGNvbW1pdCBhMGFkMDVjNzVhYTMpLg0K
DQo+PiArCQlsbmtjdGwgJj0gflBDSV9FWFBfTE5LQ1RMX1JDQjsNCj4+ICsJfQ0KPj4gKw0KPj4g
KwlwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCBsbmtjdGwp
Ow0KPiANCj4gSSBkbyBzZWUgSWxwbydzIHBvaW50IGFib3V0IHBjaWVfY2FwYWJpbGl0eV9jbGVh
cl9hbmRfc2V0X3dvcmQoKSBhbmQNCj4gYWdyZWUgdGhhdCBpdCB3b3VsZCBsb29rIGNsZWFuZXIu
IEZvciBnb29kIG1lYXN1cmUgSSB0ZXN0ZWQgd2l0aCB0aGF0DQo+IHZhcmlhbnQgdG9vIGFuZCBk
byBwcmVmZXIgaXQsIGVzcGVjaWFsbHkgc2luY2UgaXQgYWxzbyBnZXRzIHJpZCBvZiB0aGUNCj4g
bG5rY3RsIHZhcmlhYmxlLiBPbiB0aGVyIG90aGVyIGhhbmQgdGhlIG1lc3NhZ2UgbWlnaHQgaGVs
cCBpZGVudGlmeQ0KPiB3ZWlyZCBmaXJtd2FyZSBiZWhhdmlvci4gU28gbm8gc3Ryb25nIHByZWZl
cmVuY2UgZnJvbSBteSBzaWRlLg0KDQpPSy4NCg0KPj4gK30NCj4+ICsNCj4+IHN0YXRpYyB2b2lk
IHBjaV9jb25maWd1cmVfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiB7DQo+PiAJcGNp
X2NvbmZpZ3VyZV9tcHMoZGV2KTsNCj4+IEBAIC0yNDE5LDYgKzI0NzEsNyBAQCBzdGF0aWMgdm9p
ZCBwY2lfY29uZmlndXJlX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPj4gCXBjaV9jb25m
aWd1cmVfYXNwbV9sMXNzKGRldik7DQo+PiAJcGNpX2NvbmZpZ3VyZV9lZXRscF9wcmVmaXgoZGV2
KTsNCj4+IAlwY2lfY29uZmlndXJlX3NlcnIoZGV2KTsNCj4+ICsJcGNpX2NvbmZpZ3VyZV9yY2Io
ZGV2KTsNCj4+IA0KPj4gCXBjaV9hY3BpX3Byb2dyYW1faHBfcGFyYW1zKGRldik7DQo+PiB9DQo+
IA0KPiBJIHRlc3RlZCB0aGF0IHRoaXMgcGF0Y2ggc2VyaWVzIGRvZXMgbm90IGNyZWF0ZSBwcm9i
bGVtcyBvbiBzMzkwIGFuZA0KPiB3b3VsZCBsZWF2ZSB0aGUgUkNCIHNldHRpbmcgYXMgaXMgaWYg
b3VyIGZpcm13YXJlIHNldCBpdC4gU2luY2UgdGhlDQo+IHNlY29uZCBwYXRjaCBkb2Vzbid0IHRv
dWNoIGNvZGUgdGhhdCBpcyBidWlsZCBvbiBzMzkwIEkgdGhpbmsgdGhlDQo+IFRlc3RlZC1ieSBv
bmx5IG1ha2VzIHNlbnNlIGZvciB0aGlzIG9uZS4NCj4gDQo+IFNvIGZlZWwgZnJlZSB0byBhZGQg
bXk6DQo+IA0KPiBUZXN0ZWQtYnk6IE5pa2xhcyBTY2huZWxsZSA8c2NobmVsbGVAbGludXguaWJt
LmNvbT4NCg0KVGhhbmtzIGEgbG90IGZvciB0aGUgdGVzdGluZyENCg0KPiBGdXJ0aGVybW9yZSB3
aXRoIGVpdGhlciB0aGUgRldfSU5GTyBkcm9wcGVkIG9yIElscG8ncyBzdWdnZXN0aW9uDQo+IGlu
Y29ycG9yYXRlZCBmZWVsIGZyZWUgdG8gYWxzbyBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogTmlr
bGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0uY29tPg0KDQpUaGFua3MgZm9yIHRoZSBj
b25kaXRpb25hbCByLWIuIEknbGwgbGlrZSBCam9ybiB0byBjaGltZSBpbiBoZXJlLCBhcyBoZSBp
bnRyb2R1Y2VkIEZXX0lORk8gYW5kIGRpZCBub3Qgb2JqZWN0IHRvIHRoZSBleGlzdGluZyAobm9u
IElscG8gdmFyaWFudCkuDQoNCg0KVGh4cywgSMOla29uDQoNCg==

