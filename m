Return-Path: <linux-acpi+bounces-20786-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /+KKAZTifGkQPQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20786-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 17:55:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8FBCB3E
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B67A3048003
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DA3563D7;
	Fri, 30 Jan 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sc1xKgy7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FomPO3Kf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA3354AC3;
	Fri, 30 Jan 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792081; cv=fail; b=ixpJuEy9W4mB4BQpwuy0fufQg7VUo6nt0zYuww94AculNs+t8vFZkEF4MoEwulEq8OFbRmjaWKYlgtByoHTwIN2omwriNI9p6XGxWeLSJZ25lHbRNTSXgubmbnvjdJ1F4hHyvGk4K+GExo3foWicugwkrq3iapNnwZi8YFiItsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792081; c=relaxed/simple;
	bh=mMVT/ls4XiIhc7UcuHwsIgoIli2NhOfYuoXtRItuPE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTMlI4TMp3SNVL11REmDYHPB7cY7FDofU9nP+H9Xly3/nZqKMhJJYUqDAoUx/Zd3vH3K4gav4DYXp/XVY8gN+pWOehe+IFVEmGVHoN3Zo+ocxBvYcyigiRoWV9CJqeHcginE6yUFaVb9F6PgNGHob0fn7mXxXkoE/Lkw7QcazBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sc1xKgy7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FomPO3Kf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UChiLe2975071;
	Fri, 30 Jan 2026 16:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mMVT/ls4XiIhc7UcuHwsIgoIli2NhOfYuoXtRItuPE8=; b=
	Sc1xKgy74Ro/UDN2u6w9EIW11NN1ulxx2AM6kaYDEvWkJMHDtsv2pinwCNXP8vCm
	/zSmtSZ1rW5CVQzvAvMj1RiosLeipxufB051Csl8k5G0SgH/Y+8s8gZd2SvaNY6U
	wYHWd/vkdzyjh7RGroNkKOqfLmkchj50z4LHZkB5Nbuz3nHuWpYo4lvps7XHLAC4
	HcQ8+UiN9WreFukTL8Fli6BEpPJiHZj/4RHTHsMnepysv7sXiFUgmccfenyjIFeh
	YKuIkeqh19EP3IFBYEW3XewKmI4MN8slVpX2KFJvL9XFEpqD4eL8mUIsHAmQ1Mah
	PcFHGJVJJd0s2JXYTZ62Pg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t6d6c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 16:54:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60UFAHWB033649;
	Fri, 30 Jan 2026 16:54:31 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhdv809-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 16:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6rl/5BH6MPOjnLiQJQy3s4cAj9EcKXC1OOE0RnNAYzNJ5tfQVge3yaTT6RYehWDdfvNESh79WhmtM9DibKsf2AtMPpMrSrX1yD2YsycSV/X2BBkgcwk2XzZSVOqPkF/STusZDINheq38Pojjs+yDBO51Xx2zuYKPLorqNq99T8lz6OUHr0K+FT9vJrANomLd99bVCIidM2CISTstTu+FoeLTy/UWUV0T8H/4G0rczOCRJ6Ma3s+IqadLQWRURW8EvqHRHbFjomKz1ZdXW0hDqYM597TGvPC6jpMWVwNA+GWfGYB8oyEfBxh5gm3iTBggj8UKQUkJJkQEbF0C5tcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMVT/ls4XiIhc7UcuHwsIgoIli2NhOfYuoXtRItuPE8=;
 b=CZ1dyPsRWRQ20QkF4DwW/jvxyg8qbzDzaQlMdtq2rR8aKqbBc0QFs991npQQIeur2bwB5BY8oJZInbfkGABQ0XNIeq59eIK6/a8sBlG0SnUHkssfjtZazNA46aVox1CGxyGE5DmqQp8eR4sfH6SnsXUnzELPLIYNTtFLJg1oifioZ/BvSdouenyQFBtz/wz8boIS8qWtVe4vOh/P+ma6VXJXZOo1GD5J5JceAqVErtFBcWC4wwvG3jgZuyIp6jcsxvq2D/LmLU/0Kv08zkG5NtaB/OVHdfvu7Y/zd04ppbPXCtOSh6iO7EK0cW/isPrjZjMq5iJ+CHL7TzRT5tFonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMVT/ls4XiIhc7UcuHwsIgoIli2NhOfYuoXtRItuPE8=;
 b=FomPO3Kfa9WVal7xOxrIu+qwWj0L9D+5ux7QR15U/5VJ6MygfZywE0TtYXu8JIPuA/EELOszyxzRubC7hYjlmvkJIU0Q3ejaJUBk6xqTKQX+YUb+6ibxQ581BeGmgCKuP9srIvlVmvK/GvKbfOJsqCJh5vxJ1IL2AeHdfqOwTyU=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 16:54:27 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 16:54:27 +0000
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
Subject: Re: [PATCH v4 0/2] PCI: Init RCB from pci_configure_device and fix
 program_hpx_type2
Thread-Topic: [PATCH v4 0/2] PCI: Init RCB from pci_configure_device and fix
 program_hpx_type2
Thread-Index: AQHckUgoc0UYknejrECnrxNa1juXmbVpfb2AgAFx1QA=
Date: Fri, 30 Jan 2026 16:54:27 +0000
Message-ID: <2FB59D71-4EB9-4294-A35A-61FC9125D017@oracle.com>
References: <20260129185035.GA473061@bhelgaas>
In-Reply-To: <20260129185035.GA473061@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|MN2PR10MB4125:EE_
x-ms-office365-filtering-correlation-id: e3b0e9a3-6804-4e08-5fbc-08de60203ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDhzSGRyU1ZIUDJrRCtpdUZlRWI0dUhPRWFPWHRQR0lUMTdVa0tpYTlzcEdk?=
 =?utf-8?B?cXhTNm0xMWpoVDhadW5neUYyUEZZTTNUUUFsa2dwajBoWVhlOVpnM09RS1RI?=
 =?utf-8?B?UXgvdzZYa3pqU2cxZktPWmpHdDZZZU9YSnJuZjNzQlZ6U21vVjNhUnNwMlI1?=
 =?utf-8?B?bCszeDh4WTh6T3M5ZS93bnZrazRzSmFkK1pLV2pVQ2FrU2RObC9iWFFOdW8r?=
 =?utf-8?B?aEppNndYWDgyODl6RHQzVVlhaXlDYTN3Syt1OTdNMUw4WmFvQzJoZzhBeDVU?=
 =?utf-8?B?SS94bzlZOVUveG1UT2FWWmYwajZZNUlpMlVLNlovUTZoUkZHSDlhaEZxRzFH?=
 =?utf-8?B?RDFEblYrRzFFdnhyMkxsQm9pL2NiUUVGT2xrK2NDUzAwa3hQSFBrV1A3aUo4?=
 =?utf-8?B?STRPR0V0ZXppekJPOTZ3YUpQSVo1QVZOOVFxUzBhUjhhZ3NienpyM0lwM01u?=
 =?utf-8?B?eWJ5aTBGa0Zhc1JiaHN6UVY4WFVhMUViTHpLTmxyK0NFYjkyR1pEa0xBdmNu?=
 =?utf-8?B?eS9jaDZKZEx1Q1V5b3dxWXliMldVM0kwcUVPWmQzQTdEWjhUNms3bzByMk45?=
 =?utf-8?B?eHp5ME92a1lIR1Y4SGxOT3JabSs3K2ZDQ0xON1l6eDJWdjA3alRqdktWYTl6?=
 =?utf-8?B?aHJoVElPMG1QMnNNQ3BVVGZMTHdtUVNQbmVtSjkzWktFN0s0OEloMGtiVGo0?=
 =?utf-8?B?L210UCsrN1I4Q25HbWdDZEw3RXF3LzRLRmQyenU4M1BJYVA1L3dSZFY1NmlP?=
 =?utf-8?B?d3JYdXpBclQ1cWozMmNvZ2hXc21VL29GOTBSZG1TR0RTeE5KTFBLekNjb3N1?=
 =?utf-8?B?N3FIeWx3NU1TWWpRMGVHTXpJZTYxZEo5RFdYYktBL080cGxpNWxhRE5pNFlV?=
 =?utf-8?B?QllUYTlsR0tVdWtPS1Y4eDNXTHpYN3Rqd29wZ202MS9WS1JPUFZDRFV2NGZ6?=
 =?utf-8?B?b3NNcDI3S1ltV3VzTzd1ZUJSN2QvNWhaK0lDNlZoSmxESjR6YVNXRDlaR3hC?=
 =?utf-8?B?REV4c2hHcFdSckZlNVJHaXhLbldUdi9wTW9NZ3pURXJUdVRiczYyOTVzSFVm?=
 =?utf-8?B?bUFvYXFJMkRCbnI2NUE2aDZyS3BTRHZ6WU9Jc05Mb0lCallBT25pQ1pqckQ2?=
 =?utf-8?B?cDkreUorWmhydGF4K20rajQ3R0pGUGdnODhhU0x1U3hzR3VMTHVtbmtHR2Vy?=
 =?utf-8?B?aDlmQUp5ZUFlcFNwdk5VekY2Qmd4NjJ1b0VFZkhpWTQzODF4MDlBYmw5ZEM5?=
 =?utf-8?B?NnJEa3drVEFLMGhzaGZ0OE1Kd1Y1clJhajFiMFkxdlp2SHFVRDF2TS9JdlVS?=
 =?utf-8?B?czJjSm1SVDBLY3BGeUI5K1VoQXNjU2xMSWxuV1JuNTFGMDBOSjE4Rmx0MXc0?=
 =?utf-8?B?NmZIWnBDdzdjQW1rQWFuQzJPVkUya3lBeW9aUlVhWkY3YldMWWpKWHRMTlFG?=
 =?utf-8?B?a21HRm9OYWk4QTRNM1UvRUF5WFJMdDZFZFJ6MEE4eFdhUlYwUHdPMEJGTjE3?=
 =?utf-8?B?RXUvYmszZ0dmQkloOFVtVjJjM1RBMkFYT0lzb3dudjVIYU10RXdvOG1VVTJG?=
 =?utf-8?B?RTVRaStYVVIxN1NlaE0yL0FWdXgrdTlaNlNTMG9SY2w3MUZmS0J6Y1lYOStZ?=
 =?utf-8?B?QThrK0o2UGwvVkNPbmtDTE5TcnNiZ0lwSHRLbEpxYSt1NnNJSnlQRlRDNjk1?=
 =?utf-8?B?MDJWNDR5Y1luYjlTR3RJelFvdno0ejFCcFVXOFVGWnZVd1c1ZUZnVEpXdGhV?=
 =?utf-8?B?dWY2TFlZK3I3SkNkN3RadlhDWnhBMWNOdHAyRVBTNU1ISjliR3BxUDRjWFVu?=
 =?utf-8?B?eGFDbHliblMrcXg4MXBsV2RVV0VnbW90bDF6U2l1ODZ3c2pscFpJdThZV0lo?=
 =?utf-8?B?T1p4NGkyeS9FTkh3M3hLdVYyQ0ZQWmRnOUN0SERJVFVTZG5paTdSbGRSZDBt?=
 =?utf-8?B?Y3VWY0E1UWM4ZWQzcFh6eGcyZkhsdFRlU0tFbExFY3R6Yll5RTdXRjE5WEpM?=
 =?utf-8?B?TFhRSUJMYVhTQmR3SkdqUjlaYmJKa09henVRSDdjYTVCb05TblYyekd5c3Va?=
 =?utf-8?B?NWo3RjB6U0tMNEszOVRGOER0OVdOQ3RWZWhPVXZTamJMVFVwaTV5bUpvNDBF?=
 =?utf-8?B?S0tMMVg3V2Z4bW45VUJKdjd2dlorTTNNMDBXVXJaMEQxSjdFajlHa1VhR2Nz?=
 =?utf-8?Q?7ttkexUnhr4pxnIy04xaivo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2xPbjV6bXpYQ2NUUGVtT2tlMFRzVFR5aTd0ZFVJRUI4N3BNNUQ3aDRCcFdy?=
 =?utf-8?B?eDZhTUVHU1Q0Tjl3UzUzOVRhR2d5aG96KzY5MExZTXFPeEFYN01ENm1hVGtO?=
 =?utf-8?B?T1N1dU1zQ05HbVI2MThBTlBZMkZ3Z2ZVNThaUkYweitBMU5RQ3Z2SlN6NTBo?=
 =?utf-8?B?SzdlTUErZ1pPSkluVjc1U0ltM2JNcHR0R0VqQ3ZLaCtURks4cXd2TGRmbUp2?=
 =?utf-8?B?b0t1Z3cvVTlySVprT1BFbEFMZEFvTXJ0K0IxYkEwVkoyYjRCT1FvV25jYmcx?=
 =?utf-8?B?MktBS2o3ckxERTdseFBia0x2UlBCQmFCcEx6K09HTXZkU05Ya3pISzBqVmVx?=
 =?utf-8?B?aWNWVHpiay9OSVVidWJSMTc5czZYNVF5cURQUHpXdUFuZExabm90bEJJeDl6?=
 =?utf-8?B?ZXdaZUZFTVlGZENDWFdBc08wQ3Mzc3RpeWdzUDVzaVhHUy9tNm9hZjFsVGxk?=
 =?utf-8?B?YUM2RE5oR0Zmb3FSUjBMcW54dm9BbzBUU0NqeHUzdnJ0cTRnM1dtRmlmOWhT?=
 =?utf-8?B?RzJMTGlpNTNnUlR6b2Fjc0hOV2Z2WjFLbE1pdi8rVDFoa04vdjIwV1JQdHBL?=
 =?utf-8?B?SkNrTlJINWdmQ3ZHR0I1MTBUWWw3UytOQzlHcXJWWnc2VGhtZUV0OXh0WGJq?=
 =?utf-8?B?a0ZJZDNwbjBXY2Y3Mi9iZzIzc2RzQm8vaTIzMVpwWHg5dzNBajNMRVVDV0k4?=
 =?utf-8?B?WXFjTmlHZ1hFV0FRMVhXblh2YkRvLytUMFZtWDZZVkhubFpCeWsrRFExTjBS?=
 =?utf-8?B?bm81ajd3RjZuaU5EWm54ZTRrdjZPbytzaUxtVEdNYTdhV0dRQ1dHRHNBdDdT?=
 =?utf-8?B?TkhwSTB6YUlHa2lCNlRYeUQ2RjhoN1pPWkFPcnFMTlYzSWsvMkVRWWRRcWh6?=
 =?utf-8?B?L25PMlBwTk9SV0Y1S0RFSlRONmZqYUxMczZ6MUI5OVl6TUJ0VVNaRU1JNXZT?=
 =?utf-8?B?WERSTUhPUm5SZGV6bFJsejU5MW5zSmdsNWQxRkI1SGpIUXZuM1dWbHZGOU5M?=
 =?utf-8?B?NnFyUWZpK09UT25YSzNNNGE4b2xSWTg4eXRiSml4eU1sNENhbE9EUldFU0hp?=
 =?utf-8?B?bTVxWnV1QjY5aHkySFYvVUJpeVBTcjIyV0JMbWJYWFlwdlhkZURGODErRkh3?=
 =?utf-8?B?VDZxQmdmVklFMFA3am9wY3dDS2Y3UmptMXZ2OEhPSDNnSUxjWksvcHZ2Wm0w?=
 =?utf-8?B?UmhaSlQ0eDlqazhXVHA3Z2NzNUx0bzlsWU5GelFaMXRDY01iTXZPR3FEOUNx?=
 =?utf-8?B?SFJVNVNNR0lrblQxQ3IrYVJpYXRoWEpYRWNQSHZVblZDOFVYY2dJQ09vK0d6?=
 =?utf-8?B?aWJoeDdib3Q2UHFXUFZ0U3FZK1lXKzFkV3BrOWdteVVGd2VnMzBTMG1UbjYx?=
 =?utf-8?B?M01UZEo1SmlJcnlMN0IyU3ZUL05VYzZhTW16V2kwbXJHVG9Ka3VpTDl6WVJa?=
 =?utf-8?B?b0VPRldIN0lTK2VpZ3pKTGhBOXdIMUhZbVF4dE51alR6elRxZTlOMk8rTGEv?=
 =?utf-8?B?U2xJdGR2YVgycnFyTlROL0EvNmhDaW5zMkVndUs5TEg5TElYT0JyN244UVgz?=
 =?utf-8?B?cGd1TnVwYkNhUjBZSlVRdVVjNUZSTnNma0xnb0VyMUIxeUVBYllQS3JIeWty?=
 =?utf-8?B?TzAzTEJZV0FmU2hFb2pJd0YrZWtPMWcyWWV5Q2pucGZ4cmJhTmFRL0RxRjlq?=
 =?utf-8?B?empicm9CenZUVnE1RHIzKzg4bEQ5eExUbFV4NnZzR0VlK1ozbDdhRS9jeldZ?=
 =?utf-8?B?NjFIQ2tvMHlmK2piV3FLbDFNVy9BV1NmazR4eURDNk9Wb3J2ZGl6bWNhL25o?=
 =?utf-8?B?OGJRM3FkMWdxYnB3YnpubmlEdk5JbjVTbFBjYkMvZUlrM202Zkh5SmJrNFBx?=
 =?utf-8?B?R3FWN1J2cWxqTzJ2UXluc1B3dDAyS0xmMHhSNXorZW9FdFd0MDlhbjllV2p4?=
 =?utf-8?B?eXM5bXE1citXRGJjL2F3R0ZJQmZLR1g5OER3UjNNTlg4NFVCYzlqTy9Jbzlj?=
 =?utf-8?B?ZHRtSE1iV3lsUXhZaUE3NHNMMy9PUE8vYXNBcG1sakVNVTdTeDFiUVo2NDRY?=
 =?utf-8?B?Ny9EUHZKaDl1TjloN3JERFJpWTBZM2FYYno5WXdhT0VIMGdWRkNRMWJDTFp2?=
 =?utf-8?B?alpZTnNPb3U2eXByUUxIL1o1Z1E3NE9pc3lYcWo2cjBLeFhLNEhZMzU2cGtV?=
 =?utf-8?B?eGVQKzJ3MndpSzJTMVlScEVOeE0vaWFLQjFqeWZHdFNSaVdWNGdmY3RXS0d6?=
 =?utf-8?B?bXhzazIvYTJtOENCeEdOLytlL3NwSG9aa2E0TUk2cEdWRTdIUXN3cUw2UTVm?=
 =?utf-8?B?bmRyNnRSbzFGZW5lbDNQSkVyZUhuRGZpV0pYWDhybmlMTTB5TndjdU44Tmsv?=
 =?utf-8?Q?4PvwTx+UVFCKOMyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB1C77D3EB99CD4DA21782C3A98BB60D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fMeJj+LwJPLxJDKfGuufUhiTscyrl3/vsPv/X1C+x5aUXLcoEMP/8vXLMocbl5tqsGf2dlNba23F1gUUn3VE7JbEr+aXnajlnaSFxAzW451IrZY4Eli87bFwisHx8HBk0LpJAskNy7ci9Hl1D8tTXfsgRxkFW/kmhtFD6WHuxE62XrgxnTPX9Q3yMmCG1hez/v/BmkVDpAtxfDbWFqWZqck9G2AQXpd5klCHF2pc6sX68MtE2AKMT/zmzC7xdq8vvTqe44c0bHuU8D+S+CQpUkwFsahqlGlnlXKZLIxq1OlKP/Xtwz20l8tAmp3UNiaq39bKUftfpmxXcSPhgnY05OXaO5QbUBKh0BxJ0i3kAR0vw2jZDf8OTNyGZDefXcGGf8BVe77ULkIU2MCRLu6ZfMG+Py/AL49Ykw0J8VoXwiDLPYXYduYjO6t/Yp4/CM6D+wI1dLHDy1cC6Ik6ncZAcFTQ0gA9zWg+N/iUmoaWhOy7Xd91JjFiH16v6uOMVNkfaCbdfh2skXkeEyB6qXe66Hd4sxSdtJIg5GRuBAm0G3tiq6U/GZd/RFRf6ENDtRT9YjhqfBU+iJVtWjGkxY1UWwY13h0TooIM4EKxp/2HNmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b0e9a3-6804-4e08-5fbc-08de60203ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 16:54:27.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzSszc58tEvbaKe+L9gkTkblD0DDffkxUDznMBDRSjJ6UW3m/d9HBPfLkmgK+MK2Nmub/m7IHuhnHmXNNq6JfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601300139
X-Proofpoint-ORIG-GUID: g4PV2qeMUagR27oxZ9a_JKpY1VTVHQei
X-Proofpoint-GUID: g4PV2qeMUagR27oxZ9a_JKpY1VTVHQei
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=697ce248 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=IMGyO52yKoY3B8fNi9MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOCBTYWx0ZWRfXy2GcmLph/FEB
 PF3N5TeMOVwkNqliwbi6NRS2+TaDfcSm/kIz3CESArHTdYNrK+XK9wy69DLKFun/sb0BgTEUc93
 xPrdLckDJRc8YbPiOjlu0D+k6y6dlfqZFOtBdO2HtnMAPF8rZFXxszANOOO8CDw7Uc92Nwx3Klp
 JfarH2lF7D082vKBK0b1hN+RCE0pAJpT0VNDElm4I6jTEPmY0zRe2dF7B2+RugNcqkH4ijIYLk5
 wstrDLtMeeQRXA8I3n8atPE5Pdoxx4oNeX4da6JyS3NPTglM+ocu95RykuLY40zRC8Lh8nxxeXy
 /Pxw0rE/KTSykQ2tPPQgxV+y3CHuXuYkbM4lkAiP7lwMvb+NHVWD5Hgw2T2B9sTpisUVei1dmnA
 m8rsjxcMJVL7JpxcA9DIWsZ+1vNA/Fxz1TzE3u/MI5+7sxDmujZPf9u18o1k3mtA01uEwAFabvn
 huuEE/5Eb1Zi8WDrnhA==
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
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20786-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 84A8FBCB3E
X-Rspamd-Action: no action

DQoNCj4gT24gMjkgSmFuIDIwMjYsIGF0IDE5OjUwLCBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKYW4gMjksIDIwMjYgYXQgMDY6NTI6MzFQ
TSArMDEwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4gVGhpcyBzZXJpZXMgYWRkIHRoZSBpbml0
aWFsaXphdGlvbiBvZiB0aGUgTGluayBDb250cm9sIHJlZ2lzdGVyJ3MgUkNCDQo+PiB0byBwY2lf
Y29uZmlndXJlX3JjYigpIGNhbGxlZCBmcm9tIHBjaV9jb25maWd1cmVfZGV2aWNlKCkgYW5kIGFs
c28NCj4+IGNsZWFucyB1cCB0aGUgaW5jb3JyZWN0IHByb2dyYW1faHB4X3R5cGUyKCk6DQo+PiAN
Cj4+IDEuIEl0IHNob3VsZCBvbmx5IGJlIGNhbGxlZCB3aGVuIHdlIG93biB0aGUgUENJZSBuYXRp
dmUgaG90cGx1ZyBhbmQNCj4+ICAgbm90IHRoZSBBRVIgb3duZXJzaGlwDQo+PiAyLiBJdCBzaG91
bGQgb25seSBtYW5pcHVsYXRlIHRoZSBBRVItYml0cw0KPj4gDQo+PiBJbiBhZGRpdGlvbiwgdGhl
IHNlY29uZCBjb21taXQgYWRkcyBhIHdhcm5pbmcgaWYgdGhlIF9IUFggdHlwZTINCj4+IHJlY29y
ZCBhdHRlbXB0cyB0byBtb2RpZnkgdGhlIExpbmsgQ29udHJvbCByZWdpc3Rlci4NCj4+IA0KPj4g
VGhlIHByb2dyYW1taW5nIG9mIHRoZSBkZXZpY2UncyBSQ0IgaXMgY29uc3RyYWluZWQgdG8gdGhl
IGRldmljZSB0eXBlcw0KPj4gd2hlcmUgaXQgaXMgYXBwbGljYWJsZSBhbmQgYWxzbyBza2lwcyBW
RnMuIElmIHRoZSBSb290IFBvcnQncyBSQ0INCj4+IGNhbm5vdCBiZSBkZXRlcm1pbmVkLCB3ZSBh
bHNvIHNraXAgdGhlIHByb2dyYW1taW5nIG9mIHRoZSBkZXZpY2Uncw0KPj4gUkNCLg0KPj4gDQo+
PiBUaGVuLCB3ZSBwcm9ncmFtIHRoZSBkZXZpY2UncyBSQ0IgYWNjb3JkaW5nIHRvIHRoZSBSb290
IFBvcnQncyBzZXR0aW5nLg0KPj4gDQo+PiBIw6Vrb24gQnVnZ2UgKDIpOg0KPj4gIFBDSTogSW5p
dGlhbGl6ZSBSQ0IgZnJvbSBwY2lfY29uZmlndXJlX2RldmljZSgpDQo+PiAgUENJL0FDUEk6IFJl
c3RyaWN0IHByb2dyYW1faHB4X3R5cGUyKCkgdG8gQUVSIGJpdHMNCj4+IA0KPj4gZHJpdmVycy9w
Y2kvcGNpLWFjcGkuYyB8IDY1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4gZHJpdmVycy9wY2kvcGNpLmggICAgICB8ICAzICsrDQo+PiBkcml2ZXJzL3BjaS9w
Y2llL2Flci5jIHwgIDMgLS0NCj4+IGRyaXZlcnMvcGNpL3Byb2JlLmMgICAgfCAzMyArKysrKysr
KysrKysrKysrKysrKysNCj4+IDQgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgNDEg
ZGVsZXRpb25zKC0pDQo+IA0KPiBBcHBsaWVkIHRvIHBjaS9lbnVtZXJhdGlvbiBmb3IgdjYuMjAu
DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0aWVuY2UgYW5kIHBlcnNpc3RlbmNlLCBJIHRoaW5r
IHRoaXMgYWxsIGxvb2tzIGdyZWF0IQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIga2luZCB3b3JkcyEg
SSBtdXN0IHNheSwgdGhhdCB5b3VyIHRob3JvdWdoIHJldmlld3MgYW5kIGV4Y2VsbGVudCBzdWdn
ZXN0aW9ucyBmb3IgaW1wcm92ZW1lbnRzIG1hZGUgaXQgZWFzeSBmb3IgbWU6LSkNCg0KDQpUaHhz
LCBIw6Vrb24NCg0KDQo=

