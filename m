Return-Path: <linux-acpi+bounces-20554-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG0gEioucmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20554-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:03:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1C67A92
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E87A36AC3BA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337512F9C32;
	Thu, 22 Jan 2026 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oc8Ux2sd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="soMOLh1P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA830F555;
	Thu, 22 Jan 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088323; cv=fail; b=QIereokY2FMUo+0vN6NuekKbm8ZKwDBmA0JRo8haVomIKX2uWwe+eDN9mOQ8G2rr81E7zApsZRdQijpzCm2+jID3Nvw/KOl0eHYf5t4w3k8vilgs4Wy7ji0eysYATfBPK4pqHqxdCeQQX6JLxP7Ygp3Hl3Xev9WQrZyx2QfHRuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088323; c=relaxed/simple;
	bh=aa5PpWmYkLn6gfGfSWNvc/7p8xQEEUSQa/mjkKIOrZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbVM9oNPaL128NozKxiITH1vl8HjQTs/e9eHwE1W/7D5hnmrI3CvgEOwbh+w6FggysTbP5gppU+JfjakoILAxzF5cHWJlKl0Tyg64U+jgW6U12v8fv8pgtVhsuFmJNox/AK20MK+xYPH7RLF7hb0sjZgqJrXguFCm8X4kVNu0Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oc8Ux2sd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=soMOLh1P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MAm0Eh3420379;
	Thu, 22 Jan 2026 13:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aa5PpWmYkLn6gfGfSWNvc/7p8xQEEUSQa/mjkKIOrZo=; b=
	oc8Ux2sdqfCbOXI8YRps11T397Y1RZ8GABo7rL5riv7e9SBDFrGe7ueUMS/FJRAh
	mdbt7OyC3ezxgk4pSEbsECbIF37wGFkPh12AyqNopci3n5g9F7Xywzbv6oeghJdc
	K1CMUKBFJwRlD53MzQHUjABq5IlWzYu/MoquQqDNoxUC5Go9lBZDK4bwaEuMZItB
	9fpyHhCsfg7P2ZcRKEUeDMFnCWlkOloA6m/oyblMIkFv7l8OzgxIsv4SNVt9MJ5M
	+7DdwCM5xFKgKSIHNWs9CVeB3COd6hwX2xD2S1TCouC448uwNal7aMKkJt6eH8Ry
	P/pnXshz+r+JeSZcVnMAbQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9quuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:25:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MC6hkK038724;
	Thu, 22 Jan 2026 13:25:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcss0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0uu2Jb6JUsyWRmn0go6l+E88MN0zRfLEpQ2Gems0ONxEneA6VcBrgFdndzdb9bhPtUnZAryqwgyVym0MZuxxExNSLHSlkXX3ZN9HZBPYBl2SHK9haCqlt/BhTDsfOQVVg0q2xXLcSxYzaa0sxWm8q30Nw96MjSn+Ew5bEitZE1/XxSjbw4k88q+5+/ZOYJiz70P7iphsR4yklJ8BAazzv0xr/vdJDsxjTboDOjZiolCY+89XsM4OHvU8eubqJKF+YcbmROI7BaE4HBeXMzWv43gTRQ3I4TD58RvMB0cg6u13ifQjjJIczlTdCGq7hG9DeQkq/nUxT4IvocKD4/PtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa5PpWmYkLn6gfGfSWNvc/7p8xQEEUSQa/mjkKIOrZo=;
 b=u+0/TNSO1bayZEnYSiYDfzYU3nlGeXh1LPz4bJpbUkt79aEp7l6bJdOK0tfva+Fcb44veUWH75uDYVL3d5sCEq6bC57Xv1aobsjcRcKRjITaH7c4Ws6DFQ8HNG9tF52n3wrpXrwfyCnLOiS7d6liA/3PmQAHs5Fw0kMqigfGWFQw8XuZANWAqTZKLBYyW/3oR4cLrXK+B7+jc0ASdN5OzsnHGUeMpqw0b0cazGMWMD8M7I3aEhg87oaufiIzh5QpEiospfAEN3iFMl7/dPDeMHr44H91k0A56X1e9bPEoMOo+MoYUiZCbIAoLbCPcu/18yrhHklxZczZhdIev1Beew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa5PpWmYkLn6gfGfSWNvc/7p8xQEEUSQa/mjkKIOrZo=;
 b=soMOLh1PA7CLjZGYD33zEbw6fjBVudphrdoMkm1XekYdKOf76jjkcOb9LXOg5jouvdjqb8PHpZk2nWJtd5hUYthOfP6D24qFNySrMaMI6Qg7Fi/l6uMAmBTSM8MjvnIrcrX4Iia4hX5ooAIaK8f0I9XrbjO86uCehBPNFXIDcMA=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by DS0PR10MB7318.namprd10.prod.outlook.com (2603:10b6:8:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:25:02 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 13:25:02 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHcisoZzKcoj8C3rUu16aNbYxRdzrVdODgAgADIQYCAABBPgIAAHp4A
Date: Thu, 22 Jan 2026 13:25:02 +0000
Message-ID: <58E63B30-484E-4BE7-81E1-638B72F3C16C@oracle.com>
References: <20260122103655.GA1239220@bhelgaas>
 <82b50e37070e617786dccf84056183e70c7cb538.camel@linux.ibm.com>
In-Reply-To: <82b50e37070e617786dccf84056183e70c7cb538.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|DS0PR10MB7318:EE_
x-ms-office365-filtering-correlation-id: 4c86f4fd-5bc9-4d8b-a028-08de59b9a627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WitZcWhnN3Vzb3I1WEFGVW00Y2JiMDcwTE1tSFlURC9HS3ZRRWVnTDJqZGpG?=
 =?utf-8?B?YlI0Y0lYY255S1A4Y0ZqQ1ZsTXEzazRYZG5sMjR2WDdGOC81UVZRelJBNGhJ?=
 =?utf-8?B?NnpWc2hJNFBZWEJQWTdmbGxIbWMwWEJaY2R6SEhpR2hzZ1BKNTZIV21sdXBV?=
 =?utf-8?B?d1poYzlsVHJDREJaMzBwZ0lJNXR1UlZzWTFmWlBiNEppem5MSVhYNlpxM0xo?=
 =?utf-8?B?U3dhTEtZVUpHbXV2Z1g1dEJ5YkpZUXQ4anZ5VXMwejFqTi8yWVhFVHhPbFNu?=
 =?utf-8?B?L08wVS8wVjk4UFB2V3ROdFg0UVRGRjhSUmN0MWNEZ2VIUzFuT012ZHdYWHlx?=
 =?utf-8?B?clhzTTNWSUtzam9odzZPL010NVFtUHRPL1Q3bkc3bnZVSWdYWW5JeThaWm5q?=
 =?utf-8?B?S1U2TG5nTGt2LzloczdYcDNXWXBmR1Qzd2E1dUdNdS8zeVVtbExiNTNzbjRG?=
 =?utf-8?B?bVNmdW10NDFjVHZ2TXRQNUtiVnU1RDdWd3d4R1lnVFVmSUJ4OXRZdDNxYVYv?=
 =?utf-8?B?T0J1SHhqTW1oeFZIdVU4ZWVqZWxWYy8rbXJMRGxpVk9WazAzcFpkOEt6RkxO?=
 =?utf-8?B?UTFGaUZWM3FET2Q0VS9FME01YkhIWUN3NEw1SWE1OGdwMkR1NmRFblJvbDFU?=
 =?utf-8?B?eVhBSWdqK0lYWXkzNExqY2p4K3U4emdJM3JHNlN1OGZIbm9FSXo4cERSTFdk?=
 =?utf-8?B?VjdpUysyM1k4ZW9PNWJyRklHRkdsT2FyUU9oSHRJdWx4Tm1yZUZpOFlsbEdn?=
 =?utf-8?B?VlBGNGl3RjlQUnI1T2I5WjlSZ0R3VENxUTc3ZmxMMWw0b0RNb0wzTFhpRXNK?=
 =?utf-8?B?em1JSC9UVzlRS05kSW5ibEdvOExxUXVOQXU1SEVhbmdVZUJHWnM0cjVMM1hH?=
 =?utf-8?B?QmN4c1QvWm9ZaHpSdDBOUXU1N0k0ZWRJQ1RwQ2I1MXJ2RUUycGRmaC8yU3cv?=
 =?utf-8?B?allZQnh5Y2RNRGFTalk1K211OGRrRHRhcVA4aGZFbEdoa0pDcWRvUFNGU1lC?=
 =?utf-8?B?VW9BZnBQeVVaVnoyTlB5SHhVMGJqaWNXK3RrSFU3aXUxSkZUN0tBTzZHUk53?=
 =?utf-8?B?RUFPdUxRMDVKS3g0c1kveHRoQW12QXViL25xajAyWEpxMk9YY2d4VW5OTjBE?=
 =?utf-8?B?czN2RFpjOGpTZk1lamFXTFRuVVhOcjh6UW9ldThWZ3AwdklUMHJjR0syL25o?=
 =?utf-8?B?VFRwZmZoWi9wZFVKQ2ZJSGJ6SndpSmpRTHVEdGNGNGszWFlCOXBHc3gvcit6?=
 =?utf-8?B?cU1jSHM0aWwrTEtKOVVqUWF3aWNGTG5rQnVKRlJvQ2dnNHV3bkhVMFFqRU1u?=
 =?utf-8?B?TDREd1pZYzl6a0VYOW9rRGdSMXVwcnI1UnVjVzNoRXVteFpDbzRmVkpKeVpp?=
 =?utf-8?B?a0c1NktlYk5heHFocEJRVGtiUE9XMWFvcnVtZUFnQ2hBM3FXQnlTRzFwaDhN?=
 =?utf-8?B?UDRXclUyYXpkTS9kbFFPMWZBVm5NUnNtWEhKRzhheEoveVVka1BjZ1BSL0s5?=
 =?utf-8?B?UWxQOHRYMHhndk9EMDF5VkNCMkdIUi9VK3NyN3UvNDRJOXVwOTNIeXY1ekF3?=
 =?utf-8?B?VHo0eHY2SGxNcDFzT1J4U2J5VWVFWDVQS1FWd2FBTDhxYTRmb2hGRkpPRHBm?=
 =?utf-8?B?eFJUdENkTW9hUG85UERYcTBmeWNIQVdmMjkyYkxDK0s3MWx1T1NVZHFzNWhk?=
 =?utf-8?B?Nkd0WEVQcU9zUXFBWXQ3VCs5bUlXRDMzRkIzLzg3UzFXUnFVYU1OeUdlT2Yv?=
 =?utf-8?B?bG50Q0lpYlhscDRhVHN6akNQNE51SkZHOXlWdWJPeTlpL2FFSHZwYmVFTzA4?=
 =?utf-8?B?SzRPMHhtK3diU1RUaW5rdjk1ZkpDUlhmLy9aSzgzRWhFSUJFcHBPRmdETU1C?=
 =?utf-8?B?T0dTSGpQZ0EraU5LOUs4aU52d2VhbjR0em9WamI4MHB6emROdVFTOHZlN0sv?=
 =?utf-8?B?c1E2bzZiVDhabHpOMEZTaTdKSWJkbXRrdmpIcXM0WmpWRHVWb2tpeVE1dzBP?=
 =?utf-8?B?R0Q4MCtqYStCWElhM3VsVWdKcmx3SzU3cHNLUnNpMS96OUNVSHNST1UwNUgw?=
 =?utf-8?B?MnJ6dVdKOUpCVDdiVTU2akNHWGJ6emZVYmswcTdZUWlROW01S2ZUY3RDZnJT?=
 =?utf-8?B?c1g2aFE4S3JLZ0lKYk5qUFNhWmtpUWdNQW9BSGo1bk02MDBWNWM5cGlSUklT?=
 =?utf-8?Q?fk8R839Ymja6fk5NjKJJl9M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk1qZ1VpS0x0WHhiQS96Ylhzdk1hd1pSdTkyWTZwK3ZHdmJDbVllWWsweW1l?=
 =?utf-8?B?SGxsV3VseFFJZnp0YlNnTE8xVkxtdldEQkl5RzNFZ1d4NkI0SW5SejMxNXdn?=
 =?utf-8?B?R0dwbWpQa2ZGZFhETmRjU0k0d0Z4VmNZZHdCWnpHZWpZU3Zhek5CNzlIazhx?=
 =?utf-8?B?TkErS1lBbE1WdnNEN1ZDLzN3cytlNW1SYmFxODNJd0g3bXh2OVpEbEZTbnp1?=
 =?utf-8?B?dnNISVJ3ZVRabXpkUUkxbEM4dlA4SmxZZTV5eGlaRE9xZGNzNnZrYW9ndVNL?=
 =?utf-8?B?bHhIb1VrR1ltQ29VVjloMEtOTUtBMi9TR0NydDFJWXdudy9PRTRDQWdSbERv?=
 =?utf-8?B?cGpGWU1WS0FaY3RWa1VETzViSEZURXJqekx6Q094VTNzQWdzQy9EaS96NVpJ?=
 =?utf-8?B?TUhMaFl5bjZ6Y095NElHeW81ZUYvdjcyVzg5MnFuTWFJWmhnOTBMZUk4UWhN?=
 =?utf-8?B?UnNOYVNBUWRZQ2daS2NCbVV1TG9YVWdRa3R4em5HYUdrTkc0YjFtaXNkNzlh?=
 =?utf-8?B?MDZPRXBrRmo0bHRUTExEZlc3MkZhTVpucTZOaTJzdnViYmw1WWx3T2RBMFNu?=
 =?utf-8?B?ckF1Ny9UR05XM2JxRnhxTWNrQnlZMEI1STluU2tPRzFwRm1POHhiY2VxYWVa?=
 =?utf-8?B?M0VCdE9tbmhuTWljbmVaOWh0dWorNG12VEliczZlekFCSGNKcFo2WGJWY1BT?=
 =?utf-8?B?L1k5M3FENGdSY1V5bDVSbDF0RUQ2Smo3eWZhaXd6V2pTa1dDenhJR3VGTkph?=
 =?utf-8?B?VG1uZVlpZ0Vkb3ZadXdGd3A4ZE8wT2pySTF0djdaWEREekdTQ0QrZUJsZFFC?=
 =?utf-8?B?a1pJRTQ5NlZsQTZxY0M2UVBGQkxCRW9FZ0s4SDBOd2Z3Snh5TG9VMHJNZUpi?=
 =?utf-8?B?L3BMQmlXSlpDelVNb0VCNjBuTVlUVkpUa2UvaEJGeXBvQ1pTd04wd21nN2hW?=
 =?utf-8?B?NmxxbzVnQnJ2UG1VV1FaUTR0bmpkdGxiYmt3OUVVZ2FVamtCdUJvaHlpS0Vm?=
 =?utf-8?B?b1hDblVyTFVEVnZzK0l1WkRFdmxRajNQU1NFci82MVhJcXVnQjVNRjRYRHBw?=
 =?utf-8?B?b0wyY1dDNi8yY21BMW1kWmNEaDhzYlMvOXZzNzJiRk1WdTdoTExDWHE3Qm40?=
 =?utf-8?B?Z1JENmJZT3B6OTNqTmg4THcvNk5jbHVSK1RraHNCRER4RVFhR1V4WEFmRDVw?=
 =?utf-8?B?NW5pSGFYQUdoN0M3OVc2V2dRSkt6aHZnTGFrOC9GY0lmUlZhdlZhTWlxa2dR?=
 =?utf-8?B?QkZuc3JzdTdKMTFJeWFTK3JobkwvSHk4SE56ZkQwdXFiV21DNnpTNjdtcERp?=
 =?utf-8?B?d292NGR2QnhpYTcrYjRZTXZwM21LTmJsazV3Qzc3N2RrRlBpbHBYd1lDc1hq?=
 =?utf-8?B?RzJ5VzRaQjZYQmd0U2NPOUtibnFpN24zNWFBcmhxRmF3ZjlKMjdmV0RINVhV?=
 =?utf-8?B?Rkk4cExBNEZxQzRsV0k1d1BzdENSSTE2TDNVY3ZwUkR1cUFuV0V3UWkrREhx?=
 =?utf-8?B?Q0ZiSG1jUFVQdi8vdEJFYUFUOUhjZHl2b0ZDT0l0a3RrQWRRdUZZU21uZkwy?=
 =?utf-8?B?MEFhMisrTzBHR25keGlFU1B0VjQ4S01KWlZKOFFzSEtsZ1ZwSi9xVEZEWndP?=
 =?utf-8?B?aUtQc0NMWG5nQUhvVmQ1em9ZbGFjVUJyZXIrVXRhNTllWmZ6cjR4NVhGZU9H?=
 =?utf-8?B?emIyWVljRGV3WHVqZUt2ZVlTejU3YVlZS1NJU2g4c2tZNmd0L3NwSG0rSWdz?=
 =?utf-8?B?WHkyVjVURVFmMzdUL2IzSU55MTJrMmJCR0NrSnI1d203ejBmRU9wS2xTNlJ3?=
 =?utf-8?B?dXMxQVMzb3RqZUtMVy9WTkdPajBEcjZqRFp2YzhETVpVdVNNQ1NtZHg0MWI5?=
 =?utf-8?B?em9zNm83MlIvMG1zQTlxS3ViMGVUQm51UTRWZmFieWlJdGNJM0RJSDNHeDFa?=
 =?utf-8?B?SjNMOVNQLzVRYks2Uk01VlExWnBjV0YwUWxTS3djYyttem90SGJ0SEZpMGZq?=
 =?utf-8?B?WUVxZjhjRUpQK1VVay9OOXRwRHNUbHkzUXpMVmFNK25RZG5GajRmM2w3c3Nv?=
 =?utf-8?B?ZHJ0ZVQzNE52V2tnTElsb1JtZ1QwTDZzK3FRY0ZrZVB0WWlmZFdvREczamFh?=
 =?utf-8?B?cFNwbGxQWitxVmh3NWZobFhhQ05lVUJudW44MHc4d29yTFRCYkxBRDhTa2ZZ?=
 =?utf-8?B?RjJlcklBTVljQ09yakhQTXhlT2lnM2IvZFdKZmdxUW9ud29RaWJkZnNWWG9k?=
 =?utf-8?B?LzluVlpuV3F0ZXZmU0I3eHUzT0hJRnV4MmJLQzlHMDhwbUFSUm1wQ3dOamE3?=
 =?utf-8?B?QTFJQTlKalBLRkRaMzQyRkJReUhaSVR5R29wREk5L20wdUhsVkQ1TXRqYmI4?=
 =?utf-8?Q?YdE5wUOimB0mkRXQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1489F6670055F4E8D4631D79E77D4E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hpJDo5jNti0bQuxZqizrcI1IiNQsHO33hGBnjr8U8NZ5LRp6g+cnxyW6YfbCSfJyylVTlu8hzxisv1zAYdKq6YW/xnyWT/zHkE0TTeaIHS256hX5lgAy4wmp3DJgf+kNwU3ZVgvgqxs+//kt1nn1bCqe/nH/4TcACpBM8OoH+O+9iOkRUo9UoVsxsssD0Flhdd5JdKKaInquvEqS9pwJ0h/n/9FcUwh955P07vAeICqLItRQxPm/UG/vMa3Tg3CC1Pk+piVzUK00FF23pMzjEtVQ6jscSKi8Odi4DWxQk3K1GL01GzDYMa5b/GjrzmNviO8S9gzTqgvk7ti1hOf5hueiQh5Rh9JUiHIIHQ/PlLDOaFl4OSvMgmquF/Ryzs+VFPP1Tr/p/xIrmcct/sNk6g6JL4vffdaKkh8vPRVoAZWX99IaIcCHxzVvZT/JzS996flYWwHBP+zq42sXDT3J9HgO2rOjrIhOkyzTUKYNA1Rh0M3Y8rqj4pVxCpyFzPPDF+1HjtMQ6PdgK6kAruirbi89XOwCc0uSdfxLprQk3x6fXB69X4mXHTAn4/nd2kBCgeCRqL1YIZYaoJRoBgKw06dgrD9NrfU456cNDmLixLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c86f4fd-5bc9-4d8b-a028-08de59b9a627
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 13:25:02.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AUMwWZMzRU5GlP4XMibY+/BI/MIRVOPA3eezOrZZxmvzIZbKy6AZAzZk6FZz808sMoUpVLPYiCYb5y9ihzd3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220100
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=69722539 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=nJ-9WY7ULwIDtJcrXS0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O_qRtTGZoywkB9-QKrM-hzg9YIFCM0BA
X-Proofpoint-ORIG-GUID: O_qRtTGZoywkB9-QKrM-hzg9YIFCM0BA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEwMCBTYWx0ZWRfXwevb156nXTUI
 I7CUJj2SqC0UrFQKU5/53+OLdlOqCOit19NNUTS3uMq4lKUeaQZL0j9AbJ9+a26Sox3pUpN3bcO
 DoA45SCB7qFX4e7eo5LGeNpX1xZQvQF63vv9GyD9kGInYfB0uxmDGMwBlTIlInCqaQaVi1KPJLZ
 ij6sFJi5pMmpC3J+Y1wW5h6qHTxIQs/hHlorBnlShv/CwVJLxHJpnfLpqUBrjFGPyU74PjC6NlM
 +NbPby5z0rGqRBpV/AuAJZsakbn/rv+xpPMM6k9RPaTUfnKB7c46TxJ1TsSzeljy0RGNj0CN8J8
 QOuHIbuKjWpllWcgUPPIPXF2ic2MRG5L12ScWlApg/Q8YkATt5Db8UMOvse96205esNxP1kjMa6
 G6uzf2aVOUeBWUIr2GN2UEPSks2YKOrQO8B+QWe102ZY9VicrhNbozRZez52+DWt8J+YeRxOjmT
 vjoq9Qj+WExwhIniGMw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20554-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,shazbot.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A9C1C67A92
X-Rspamd-Action: no action

DQoNCj4gT24gMjIgSmFuIDIwMjYsIGF0IDEyOjM1LCBOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxl
QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI2LTAxLTIyIGF0IDA0OjM2
IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPj4gWytjYyBBbGV4LCBOaWtsYXNdDQo+PiAN
Cj4+IE9uIFdlZCwgSmFuIDIxLCAyMDI2IGF0IDA0OjQwOjEwUE0gLTA2MDAsIEJqb3JuIEhlbGdh
YXMgd3JvdGU6DQo+Pj4gT24gV2VkLCBKYW4gMjEsIDIwMjYgYXQgMTI6MzU6NDBQTSArMDEwMCwg
SMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4+PiBDb21taXQgZTQyMDEwZDgyMDdmICgiUENJOiBTZXQg
UmVhZCBDb21wbGV0aW9uIEJvdW5kYXJ5IHRvIDEyOCBpZmYNCj4+Pj4gUm9vdCBQb3J0IHN1cHBv
cnRzIGl0IChfSFBYKSIpIGZpeGVkIGEgYm9ndXMgX0hQWCB0eXBlIDIgcmVjb3JkLCB3aGljaA0K
Pj4+PiBpbnN0cnVjdGVkIHByb2dyYW1faHB4X3R5cGUyKCkgdG8gc2V0IHRoZSBSQ0IgaW4gYW4g
ZW5kcG9pbnQsDQo+Pj4+IGFsdGhvdWdoIGl0J3MgUkMgZGlkIG5vdCBoYXZlIHRoZSBSQ0IgYml0
IHNldC4NCj4+Pj4gDQo+Pj4+IGU0MjAxMGQ4MjA3ZiBmaXhlZCB0aGF0IGJ5IHF1YWxpZnlpbmcg
dGhlIHNldHRpbmcgb2YgdGhlIFJDQiBpbiB0aGUNCj4+Pj4gZW5kcG9pbnQgd2l0aCB0aGUgUkMg
c3VwcG9ydGluZyBhbiAxMjggYnl0ZSBSQ0IuDQo+Pj4+IA0KPj4+PiBJbiByZXRyb3NwZWN0LCB0
aGUgcHJvZ3JhbV9ocHhfdHlwZTIoKSBzaG91bGQgb25seSBtb2RpZnkgdGhlIEFFUg0KPj4+PiBi
aXRzLCBhbmQgc3RheSBhd2F5IGZyb20gZmlkZGxpbmcgd2l0aCB0aGUgTGluayBDb250cm9sIFJl
Z2lzdGVyLg0KPj4+PiANCj4+Pj4gSGVuY2UsIHdlIGV4cGxpY2l0bHkgcHJvZ3JhbSB0aGUgUkNC
IGZyb20gcGNpX2NvbmZpZ3VyZV9kZXZpY2UoKS4gUkNCDQo+Pj4+IGlzIFJPIGluIFJvb3QgUG9y
dHMsIGFuZCBpbiBWRnMsIHRoZSBiaXQgaXMgUnN2ZFAsIHNvIGZvciB0aGVzZSB0d28NCj4+Pj4g
Y2FzZXMgd2Ugc2tpcCBwcm9ncmFtbWluZyBpdC4gVGhlbiwgaWYgdGhlIFJvb3QgUG9ydCBoYXMg
UkNCIHNldCBhbmQNCj4+Pj4gaXQgaXMgbm90IHNldCBpbiB0aGUgRVAsIHdlIHNldCBpdC4NCj4+
Pj4gDQo+Pj4+IEZpeGVzOiBDb21taXQgZTQyMDEwZDgyMDdmICgiUENJOiBTZXQgUmVhZCBDb21w
bGV0aW9uIEJvdW5kYXJ5IHRvIDEyOCBpZmYgUm9vdCBQb3J0IHN1cHBvcnRzIGl0IChfSFBYKSIp
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5j
b20+DQo+Pj4+IA0KPj4+PiAtLS0NCj4+Pj4gDQo+Pj4+IE5vdGUsIHRoYXQgdGhlIGN1cnJlbnQg
ZHVwbGljYXRpb24gb2YgcGNpZV9yb290X3JjYl9zZXQoKSB3aWxsIGJlDQo+Pj4+IHJlbW92ZWQg
aW4gdGhlIG5leHQgY29tbWl0Lg0KPj4+PiAtLS0NCj4+Pj4gZHJpdmVycy9wY2kvcHJvYmUuYyB8
IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAxIGZpbGUgY2hh
bmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+Pj4+IGluZGV4IDQxMTgzYWVkOGY1
ZDkuLjM0N2FmMjk4NjgxMjQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMN
Cj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPj4+PiBAQCAtMjQxMCw2ICsyNDEwLDQx
IEBAIHN0YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfc2VycihzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0K
Pj4+PiB9DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4+ICtzdGF0aWMgYm9vbCBwY2llX3Jvb3RfcmNiX3Nl
dChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPj4+PiArew0KPj4+PiArIHN0cnVjdCBwY2lfZGV2ICpy
cCA9IHBjaWVfZmluZF9yb290X3BvcnQoZGV2KTsNCj4+Pj4gKyB1MTYgbG5rY3RsOw0KPj4+PiAr
DQo+Pj4+ICsgaWYgKCFycCkNCj4+Pj4gKyByZXR1cm4gZmFsc2U7DQo+Pj4+ICsNCj4+Pj4gKyBw
Y2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKHJwLCBQQ0lfRVhQX0xOS0NUTCwgJmxua2N0bCk7DQo+
Pj4+ICsNCj4+Pj4gKyByZXR1cm4gISEobG5rY3RsICYgUENJX0VYUF9MTktDVExfUkNCKTsNCj4+
Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9yY2Ioc3RydWN0
IHBjaV9kZXYgKmRldikNCj4+Pj4gK3sNCj4+Pj4gDQo+IC0tLSBzbmlwIC0tLQ0KPj4+IA0KPj4+
ICAgICAgICBwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsICZs
bmtjdGwpOw0KPj4+ICAgICAgICBpZiAocmNiKSB7DQo+Pj4gICAgICAgICAgICAgICAgaWYgKGxu
a2N0bCAmIFBDSV9FWFBfTE5LQ1RMX1JDQikNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybjsNCj4+PiANCj4+PiAgICAgICAgICAgICAgICBsbmtjdGwgfD0gUENJX0VYUF9MTktDVExf
UkNCOw0KPj4+ICAgICAgICB9IGVsc2Ugew0KPj4+ICAgICAgICAgICAgICAgIGlmICghKGxua2N0
bCAmIFBDSV9FWFBfTE5LQ1RMX1JDQikpDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm47DQo+Pj4gDQo+Pj4gICAgICAgICAgICAgICAgcGNpX2luZm8oRldfSU5GTyAiY2xlYXJpbmcg
UkNCIChSQ0Igbm90IHNldCBpbiBSb290IFBvcnQpXG4iKTsNCj4+PiAgICAgICAgICAgICAgICBs
bmtjdGwgJj0gflBDSV9FWFBfTE5LQ1RMX1JDQjsNCj4+IA0KPj4gT24gc2Vjb25kIHRob3VnaHQs
IEkgdGhpbmsgdGhpcyBpcyB0b28gYWdncmVzc2l2ZS4gIEkgdGhpbmsgVk0gZ3Vlc3RzDQo+PiB3
aWxsIG9mdGVuIHNlZSBlbmRwb2ludHMgYnV0IG5vdCB0aGUgUm9vdCBQb3J0LiAgSW4gdGhhdCBj
YXNlLA0KPj4gcGNpZV9yb290X3JjYl9zZXQoKSB3b3VsZCByZXR1cm4gZmFsc2UgYmVjYXVzZSBp
dCBjb3VsZG4ndCBmaW5kIHRoZQ0KPj4gUlAsIGJ1dCB0aGUgUlAgbWlnaHQgYWN0dWFsbHkgaGF2
ZSBSQ0Igc2V0LiAgVGhlbiB3ZSB3b3VsZCBjbGVhciB0aGUNCj4+IGVuZHBvaW50IFJDQiB1bm5l
Y2Vzc2FyaWx5LCB3aGljaCBzaG91bGQgYmUgc2FmZSBidXQgd291bGQgcmVkdWNlDQo+PiBwZXJm
b3JtYW5jZSBhbmQgd2lsbCByZXN1bHQgaW4gYW5ub3lpbmcgbWlzbGVhZGluZyB3YXJuaW5ncy4N
Cj4+IA0KPj4gQ291bGQgZWl0aGVyIGlnbm9yZSB0aGlzIGNhc2UgKGFzIGluIHlvdXIgb3JpZ2lu
YWwgcGF0Y2gpIG9yIGJyaW5nDQo+PiBwY2llX3Jvb3RfcmNiX3NldCgpIGlubGluZSBoZXJlIGFu
ZCByZXR1cm4gZWFybHkgaWYgd2UgY2FuJ3QgZmluZCB0aGUNCj4+IFJQLg0KPj4+IA0KPiANCj4g
VGhhbmtzIEJqb3JuIGZvciBsb29waW5nIG1lIGluLiBJZiBJJ20gcmVhZGluZyBsYXRlciBjb21t
ZW50cyBjb3JyZWN0bHkNCj4gd2UncmUgYWxyZWFkeSBpbiBhZ3JlZW1lbnQgdGhhdCBpZiB0aGUg
cm9vdCBwb3J0IGlzbid0IGZvdW5kIHRoZQ0KPiBmdW5jdGlvbiBzaG91bGQgYmFpbCBhbmQgbGVh
dmUgdGhlIHNldHRpbmcgYXMgaXMgd2hpY2ggc291bmRzIGdvb2QgdG8NCj4gbWUuIFN0aWxsLCBm
ZWVsIGZyZWUgdG8gZGlyZWN0bHkgYWRkIG1lIGluIFRvIG9uIHRoZSBuZXh0IHZlcnNpb24gYW5k
DQo+IEknbGwgYmUgaGFwcHkgdG8gdGVzdCBpdCBhbmQgdGFrZSBhIGxvb2sgYXQgdGhlIGNvZGUu
DQo+IA0KPiBOZXZlcnRoZWxlc3MgSSdkIGxpa2UgdG8gY29uZmlybSB0aGF0IHllcyBvbiBzMzkw
IHdlIGRlZmluaXRlbHkgaGF2ZQ0KPiB0aGUgY2FzZSB3aGVyZSBQRnMgYXJlIHBhc3NlZC10aHJv
dWdoIHRvIGd1ZXN0cyB3aXRob3V0IHRoZSBndWVzdA0KPiBoYXZpbmcgYWNjZXNzIHRvIC8gc2Vl
aW5nIHRoZSByb290IHBvcnQgYXMgYSBQQ0llIGRldmljZS4gVGhpcyBpcyB0cnVlDQo+IG9uIGJv
dGggb3VyIG1hY2hpbmUgaHlwZXJ2aXNvciBndWVzdHMgKExQQVJzKSBhbmQgaW4gS1ZNIGd1ZXN0
cy4gQW5kDQo+IHllcyBJIHRoaW5rIHRoaXMgd291bGQgcG90ZW50aWFsbHkgaW5jb3JyZWN0bHkg
Y2xlYXIgdGhlIFJDQiB3aGljaA0KPiBjb3VsZCBoYXZlIGJlZW4gc2V0IGJ5IGZpcm13YXJlIG9y
IHBsYXRmb3JtIFBDSSBjb2RlIGJhc2VkIG9uIGl0cw0KPiBrbm93bGVkZ2Ugb2YgdGhlIGFjdHVh
bCByb290IHBvcnQuIFRoYXQgc2FpZCBmcm9tIGEgcXVpY2sgbG9vayB3ZQ0KPiBjdXJyZW50bHkg
c2VlbSB0byBrZWVwIHRoZSBSQ0IgYXQgNjQgYnl0ZXMgaW4gZW5kcG9pbnRzLg0KDQpIaSBOaWts
YXMsDQoNClRoYW5rcyBmb3IgY2hpbWluZyBpbi4gSnVzdCBvdXQgYSB2MyBbMV0uDQoNCg0KVGh4
cywgSMOla29uDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyNjAx
MjIxMzA5NTcuNjg3NTctMS1oYWFrb24uYnVnZ2VAb3JhY2xlLmNvbS8NCg0KPiANCj4gVGhhbmtz
LA0KPiBOaWtsYXMNCg0KDQo=

