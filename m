Return-Path: <linux-acpi+bounces-20493-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPLiDUYscWl1fAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20493-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 20:43:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D32415C677
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 20:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A61936ABA7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C3D34679A;
	Wed, 21 Jan 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MolnMabM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AUXfhdt3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220543ACA62;
	Wed, 21 Jan 2026 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022838; cv=fail; b=dTtwUGM3jJBLslMfvOQD4tObPdCh4Gm0qHHX74sYCGD/M6p2qRAFtAKjNNyX7wmNFlgp8AzQ5zsQjFewI3bPaNiuphHO/AS0sYNKb9W1EKNwR72j6gBDA5Bu2q96pxJX9RqcJV4jVt0f93wUXHRLh9LywaPhpKDzEJXI44+XZMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022838; c=relaxed/simple;
	bh=Dql1C77QoPamo5p6fZYiz4LjNo6K8wZ9B1Yhihf6mII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtHgK45hA7LSk4UMlCJcJwH9R9Eb/5ir5TSGQzmfPPOhBItRdJasCvyK5ykpDd9d32AdPuSdhrjLm6h2QQv1GYpMp8g7ZyG3/Ef6T3tZvMqyVhDmn2siUfqFTCDdfxTL4czJmbMm5+VLgZzvotddH53BfIGm0sv45CerpKvsO20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MolnMabM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AUXfhdt3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LDugBb3029196;
	Wed, 21 Jan 2026 19:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Dql1C77QoPamo5p6fZYiz4LjNo6K8wZ9B1Yhihf6mII=; b=
	MolnMabMax5MPMgSodd6fUrDmP6k1nGr81Fxrnt1Q1pVzSAjO5lAhjZpt81W2v27
	6yOwcExkq387NqKYvdcA9RdAPMikW1swepbecUinP/rZkpSL40mX5ltcbm2YhQic
	SAgYOmMB+FECGaHcNU8Lln8mnbC2FwzVlm9wBIP9gSdhIyQyVVPgFx3QHOJnSXwj
	BfxG6CM1yDrJNdbVmpawLPiyEg8sXA96aORVKnjBUn/iPeEN9G7er9xvexKXecka
	hsa2+3BxMJuyytGUGdQvDgayUOe4VTROtxYF+tRd8DkDfnKVL2BS1bZjiV1YUbO5
	oVoAjymJXWItmzwTTGjkWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vxfxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 19:13:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60LIKjBU008362;
	Wed, 21 Jan 2026 19:13:51 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vbqagp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 19:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYkQ0Oj3h+iris8/uCvEVd1T4WEUfXT8BdxWOEhssX5nj74UJI8Yp+vp1zZgqDXMI52d7GAVOfmA4TTwDzlS3n2he8gHm1JF5phV4q3cZxvkVK5ErPPTnthodzNu+ph0styL47OmOk4YBBCfuv4ORyMk6SPn4B2gVcf6SJPLFSjSJo/xdLpW8YWbxQGn8AquBvii7Y4L/OgQXl4NiWcsypQOC/vkPKsTk103mrWYOkRUL/gU3suvqcFTtYdFcgzkf8Ey54VIfq9Hg72lWUnjf2rJqJhJPVu1Bi9Otdfw+I6UC5xLaBFAzorRg3q+aPgKH8buwTdDRIWf95NjCOSZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dql1C77QoPamo5p6fZYiz4LjNo6K8wZ9B1Yhihf6mII=;
 b=ROxUIcmKOob+QxQEwCDv+svFWOdtu89FXx0WuupuenN16FnnKleA+LqBn+rK7N0kfsM6mCQoP8s2E43jgfxpeOYEphi/RvxHoOWcGoQIu2rBPJzcsOTrFhmKYtuzheJzbRQiXL/4ymMJDkJ35125hIU+tF9cIlPHJ1cLKMgdQOMzQiYt7keGDP2vjhatc7TU76lU1oc3fwGUXvFxfqOMDT5r9yaQdaOZigP3FiVnP7L7mZtQEhtsgEx2YY6E2jpEtdpWf0BazZz/1plgru5ykl9+uBwkNMISw8epVIBCAhd5UnBbnG7cCiHjHDq5sZ0TMlzkR0DChcTGyvhgbSgmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dql1C77QoPamo5p6fZYiz4LjNo6K8wZ9B1Yhihf6mII=;
 b=AUXfhdt39i9iZZNzt566M11pLUXbs4SkrAsd62oxDIioYolIlRhfwv85+2X8v0wB2w4SGpagO106jJsGXW5UfrIRGl3RLLziz2mzPj8JVmbaTc0Tb2Lm8lzTdxxYCSr35clFZci1cC/cEVJnxULaQtdyyft3JPfuQJbdu1celdo=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by DS7PR10MB7130.namprd10.prod.outlook.com (2603:10b6:8:e2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 19:13:48 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 19:13:48 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn
	<morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Topic: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Thread-Index: AQHcisoZzKcoj8C3rUu16aNbYxRdzrVc5LiAgAAZywA=
Date: Wed, 21 Jan 2026 19:13:48 +0000
Message-ID: <ECE29E32-7925-44C3-BAAA-B16003E9E997@oracle.com>
References: <20260121113544.4163457-1-haakon.bugge@oracle.com>
 <20260121113544.4163457-2-haakon.bugge@oracle.com>
 <aXEPv8BChwIhlZPa@wunner.de>
In-Reply-To: <aXEPv8BChwIhlZPa@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|DS7PR10MB7130:EE_
x-ms-office365-filtering-correlation-id: acb52b74-0e34-4a6f-e6f2-08de592134c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWcwVnZnNW1aOFd0L3FJYmpxOCt5dmppNThuOElGQVozRFNUMnVSYjE3eFJm?=
 =?utf-8?B?T2pELzFRMnh3TU1nU0JXQjNnUkZicmhGZU9IVzZ1eURRRVZ2OFAvampHbGIw?=
 =?utf-8?B?SFdBUW1aUm03eEs3dy95R20rKyt4RzFDNi8xTUdKOUMxVTZDdXBoSS84K29S?=
 =?utf-8?B?NVAwemc5SjN4Y1ZkY0FWWjdKZmlXL3BZdC9tenhPdmhORms4a1NMQ3VGN1Bs?=
 =?utf-8?B?cXpjQlVMeG5tSTdiSDFOcjB2Z0NJZGVXSzdDL1JNT2t0dE5pZEdpRkRpN3Jz?=
 =?utf-8?B?aVRnMXpmcElHL21wdUVDbUVWQmtSa0tqWFVONDk4NTJ4Ukh6a2xEdDR4TkVS?=
 =?utf-8?B?MWVYYm8xNkN1eFZWdk44UkpFblJKNEU4WGxHSWhaRWY4TWhhZUpMNWtZNjV4?=
 =?utf-8?B?aVJrTUIwMTkxWUtKVGUxcUx0aEhtQmU2b2ZXU3A3emoyaWhyeGNmbU9KYWNY?=
 =?utf-8?B?RjBPODFuZmgvK051QmlSU0MzTUc2UFFLZkJma3Naa3VMZFIzRnBCM3paTXJn?=
 =?utf-8?B?Tm9jaFdlcTdMbmtCRGVLZ3ArREVIOEdDQUhnMUsreDc4ZUxVc3hjNWFOYk5z?=
 =?utf-8?B?dFFBSnRwbkVpd3YvMW5IYWhoZENraTUvTnB1YmIycTdoSnFYalY2Y1dCVGE3?=
 =?utf-8?B?WHBiUnovMlVOZEtvTkg5dzNKVER4eGJKUHJpQnMwdVZ6bHlEQktZdWJjZytl?=
 =?utf-8?B?NGllcVRBQ3BXVDF0T3VwYmNHQnJWZW9kdlEyOXJDMVhmZWl6Qmt0VUw0azd4?=
 =?utf-8?B?TXJJZFUzamhGclZLbDRXQzBvR2F4VmRIL1NLZ3g1ZWZXRHB5NnlGc3huaDhG?=
 =?utf-8?B?c3dTMGEyOXZxWWM4bGloU0JjMmtweEdLLytwQTZId3dsTnlWYlJJRTNNeUww?=
 =?utf-8?B?NkpvRm5qaGF4eXd0SVZJR01uRjNWdEZlcDlZZmp2WkNhV3NKVWZycWhKYzVp?=
 =?utf-8?B?S2VVQW9BZDBsT1RaVGRWU0UwbDZnc3JBVitHNEtKTjZlZzNUSHFKVXc5N1Vy?=
 =?utf-8?B?aDRIb2owa1FYSks5Um1FcEU4a0d1b3NlNk9ZeFVtcnlsQTVkeXRjNzhKSWZJ?=
 =?utf-8?B?M0JvaUplODNaalhDVnNXTUVTTVBua1J2UVduSk5jU3FDaEpKcGdlZTEzTGJo?=
 =?utf-8?B?VE5TNjIzdm1YUURPb3JnTlVuRzBHSWFuSGVzVXZjSW1EZTRiVGg1bVVWejIv?=
 =?utf-8?B?YXpmSXZlUTYzVkUwM2dLTE9iaUFXVnVIdGVpbVc3TDNPOElOZEJuRmZSY3RJ?=
 =?utf-8?B?VkcySWlKZThnZzhhZVNaYUxRMEhOdy9yU0ovMnMvRDRzNjcwbXFnV09Da1RN?=
 =?utf-8?B?TGtoRDF3MkV0TVdibndCT2JnMzE1ZklLeWZGMFhtTjBnd2k2dTFzRnVLYkZq?=
 =?utf-8?B?V0dTZmo2NE1IdDR2QjBLUkdRcTlmOWdvWUNqRU9CQjhsUWVIR3RZNklDVzlt?=
 =?utf-8?B?ZXlBV0pOVXBFYWw3RWdJU3VmTFlibzBxWWk2NUZ4YmxWZ01OV2psdFpORnVo?=
 =?utf-8?B?d3oyL2ZoWWxFaFBUMFBVSGpXWi9BYk5yeGtqNEhQcEpZWlVJRFptSFFPKzI4?=
 =?utf-8?B?V2lFR3JFbWtTalgyQzIzYjRmdk1zUFpGUklYTWpJc1llcmp6Z3JhbWorV0wv?=
 =?utf-8?B?Z2lwdVUvb2xGSkUxNUdHWml4L0JMRmVVUWJ0djFkeDBkckI5MEZhRk1KQjNF?=
 =?utf-8?B?QkQzdWNzVFZFbVE2M0FIUlNEYW1COWloc0RVV2NVRXc1STE1eGNvdVVVWUND?=
 =?utf-8?B?SVhIdHpVSUoxMXhYelcwRmExK0ViamVKSkJBbThJNXB5UG1kS25uSFJQMjVL?=
 =?utf-8?B?MXFwSlFEMFhEa3RwaTczWWdsVXV0YXI2TXRnOFZ3dUt0VkxWcHRERml2bVly?=
 =?utf-8?B?U0hseTk0WnlmckIxUW4ybC9RVk5BSWJvSHRRbmhPUXY2MXpDNlFrdjlmVUJ2?=
 =?utf-8?B?SmI3Mzk2U3pOeERHNm0vUDNsYVJ4Zm9DRVVJQks5dnVFOVpkeW5KNlNQbDU2?=
 =?utf-8?B?Z0NkTEw2S2lZbTd0SUJOV1U0a3dud296QS9XUllDck40aFZFb2JqOXRCbHUv?=
 =?utf-8?B?MGVhaEozVHFncjVPTkJBSTZPWjI0YTNZNHlqWXlHYzJuNXc2QllxNE1kdmhO?=
 =?utf-8?B?VlBJcU05L09LaWdVeWZYdWRGWHZxaG9tVjlxVWFnNWgzc1lwTExveGx1bHpU?=
 =?utf-8?Q?Wf93r2I012gy9C5ni1b9vqo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGUzS0ZwVXlQZCt5MnJwd0VheWc0OVIwdWlKT01BcFVwMXVLNFlYUzN6K1Jm?=
 =?utf-8?B?aDlkcXVlbUoyS2gvZkpnbWgvbElTU2ZtY0JQMGY5TmpNR1FWT2lEZlFIUkpm?=
 =?utf-8?B?YmplY0k2V2k4YjBKVGFvUm9kNmc5cXVycEluR2lUVzFXL1lzWVovOW1qTUtT?=
 =?utf-8?B?TE9VSlh1VmRrRkg1QzhVY3RVS1NNc0JPc0YvQy9hWGZFWUdXakJ1QTN4cjZw?=
 =?utf-8?B?dlZYSlpKeEF1T3VjaU1zMVMxd1RtSnV3TVh5QWVQRlV4RVNHRW5kTitmcFF2?=
 =?utf-8?B?UVI5R0Z3czQxYmdxV0VWZ2lNcVZReXgzNnN0b0dscEdVUWI1RU42b0pxRUZP?=
 =?utf-8?B?enJ3T3RHdzltS2ZOWVpYQUFYdU9vR3E2M3NSWVgweGd3ODRWMWxQTjhvRTEz?=
 =?utf-8?B?RGF3R2I2N1BJdE9MbHh3b21GYjlweVZIRDltNmNPTDZMTTdybm52eHN6ZGxx?=
 =?utf-8?B?MkczbGYzWmpnaFJsdngxUERkdUw3ZDdXNGN0QkU3T2dlbEVRbTBPTkNjVWFL?=
 =?utf-8?B?S1ZrakZyYnFGWUxjOGJ2MXU0SURhRyt4ZU1LdWdMaEZmRWJkN1ZGT2FXNWY2?=
 =?utf-8?B?cWFFU3c0K1dCNTRYUFVRVHVCdUVlYVhBdUdYT2lnMGxOUmxSWGdDZGtvMXQ4?=
 =?utf-8?B?TlU4MEZqcVhUay9oR095SWZadmhCcmhWRmhMbnpNMzFBU0dVaWpDZG0rWFZS?=
 =?utf-8?B?UmRzV1o0eGs5STZFdlp4dWFaVHJ5YVhNNTFSMGdQMUZTaWNtYmY0TzRRUVA3?=
 =?utf-8?B?M0MvK0pvQzVPQ3JxVDhBUzdQZVJSQXFqV3llcStNcVAwV295OUluUmxsTG0x?=
 =?utf-8?B?WlVWWFVTQmhabjZ1c3QyRWlQdWlCbnRaempkdStRZlE2TU02a3JPb1FadnRL?=
 =?utf-8?B?ZjRsYnJVSk5TUk8zSEU5ZFJaRlkxblpqOUE5MEtsY2pCdmVia3FHZWRBR2Vw?=
 =?utf-8?B?WFErMGdtM3p6MGJXZjZZbldldGVmaURQb2pmV2RRTURSdUMxdUdsSVdlcEZV?=
 =?utf-8?B?bnA2ZlQ2QW5rUlY2eGVnMDBFZkRGMy90dTFtQm1wY09KYkplZElJU3JIa0Y1?=
 =?utf-8?B?eGZ5MVIvZ2p6KzR5YWZWVzAzMGMvbVdjbU1LSGgzaEw2SmJUcllOUlg1a3My?=
 =?utf-8?B?SXlFTEJhbGpNWHJIZDgzQVEwMjU4S2lQRDNFY1RXY3g1aU1KTDRncWl0QmxU?=
 =?utf-8?B?Tjd3VFVNTFJVTmYyeGh0M3dsdkpVOG1mMnRWRFJOeGswL0hnUTUxeDExNmcz?=
 =?utf-8?B?RkFzTllDVGFPcGhqTmNnbHg2cUVpczQveis5RS9SOXVOQ0cwamJ2dG9tUVVT?=
 =?utf-8?B?aG9PZHVXUms3OEJHMTZ3cmkrL0tuVkpGb2hnZnlOUEVGcGQybGZuYXNHQ2Jp?=
 =?utf-8?B?R3dqUEFZdWZVMU0vQTRMZUNNUFdmUkNSUEZ1MnBia1p1OHo5UkJKRG5zZk5i?=
 =?utf-8?B?SGpxV29pbmtneWhNdDlTUEJsUDVpQ2lhNEhWK3Rlc0Z4Q0c0eG5vMzJEanJV?=
 =?utf-8?B?OG5yaDFHMmNYbXZDbGNsQzdibmROUHlqdW5jSDh1NUJFaXBnWUxkMWtzSzlZ?=
 =?utf-8?B?RjJ2emZXT25rUDNGckYzWXRhWVUxa3dUMXNMMWpFS0xjamJJeFZTa0MrcURx?=
 =?utf-8?B?KzZub0lraG1qL2NCTjZ0TDJNTnBjK1FrdlpnZW00cmxSVzl5SUFZOTNuVmUv?=
 =?utf-8?B?bFByWkc5TFVKdnZCRmxPalBraWV3cU1vS3JkYlpETlRjQzVqZUFIcnNzbi9V?=
 =?utf-8?B?RXN6TVZRYVRXajRWNU5uaFl4Zjk0cGF6YUZvM1lCb3FiVmJ4N0YwR0luV3Q5?=
 =?utf-8?B?VTdvVWIyRktGc0FtaU5XM0lCV21rZE4rNVJVbVIzZkllbEFWZTNOa3l0dDF5?=
 =?utf-8?B?aFFEM2VSMzJPZmFyZUZvQ3ZUcFpDRUovVFBuc3l0ZVFrMmNrTVNXTFFtUmQr?=
 =?utf-8?B?V2ZsVm5BcmJCUk1RcEJoSzBtamRacWxlK1gxc1BqSktvTlNCZHJydlNaeUNK?=
 =?utf-8?B?czJNanlDMEI4b1JFdTZHSjQ3bkJzblJGaWFVaVI4ckpFUVo2S0dxZTRpcjlL?=
 =?utf-8?B?WXNCT0pLMnpDVFRKSzFPejE3S1M5SENIOW53eElxcXZDNEhKNVQ3WUVKckVh?=
 =?utf-8?B?bnQrUkNQTVpWRkJLd1FVa0grT0ZicmluaXFxM05CK2NPM2FHU2tXUDdpcHcy?=
 =?utf-8?B?cUdGMEVrWGJFUFVpamsxbWZWR3h4amtPNDR5TGN3eG1kdFFBeG56VDZHdmJM?=
 =?utf-8?B?UFNEMVZ3TEVud2VOQ2hGRmFkV1NyTmNsSi9yZENmTG1NdGkycldtNnI1Rjhx?=
 =?utf-8?B?TCs2WlJ1ZzJlSWVZQWJoVGNVYlhpYUl3T3JCRHdvTytwSHVORW9MUC84TzYy?=
 =?utf-8?Q?EH0DFRB6rAxbEPqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BFEC8784B265A4AB538F9D7E9381BC5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gvFX4eqRC1YI/fzTPNmD5fWy1Q4ZD4JS4gZur+22A6XVrZRxNOzCnCMeZ4Q5YMjdlhSP62Q9reo9iUmSq+uSMJRvVdE31jKkri5Bo7Txb49uD4X8bR3kzAyvJ34z5V4+2L6yxSIvYc0ohtp9Catp0h74VozozOrZfBs9vq4COth4i7pAxOJlIoy5tz41NjJYgZl+X/w2kQvyNtAT5GV9eh6Wsstt5EHosrcbhQPRnk7E3i3s9Pz7qg9D6jP9U9avTepVHQ6KyoaeGVOXuKQUjSRYDpuE7ZB3brlTKoUwVHfX7a41Crc5cxUPyHFu7A9Mxz9Q4N8BiatRqqCL23CyOmSb9hjIeySQJd6oJResbmSxJ1rQGz0J29gwv/5XUy6oUCTuAvU0J2q7n9k8oaGPflEV03XnqGM2E/aCtEhW3B5OCi7JaERMdMnUzZ6vbkNRJMwrGEB5SypL5dy2g2POQ24zjhsXwmsil5A1nYfRV4UQSF7MtkwrdzgcYi7tPGcysiy8pDn+AJNhbnJZwEhgeNyLkEl3FR6u6BOg8FebaSXOfaGlbmYNeQ3r06E7IjSP0QcG1eOWhg/3GVbQF6IXZRPmLqVJwFS4K1HE6PeJiaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb52b74-0e34-4a6f-e6f2-08de592134c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 19:13:48.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8MNH7gYc/x8KVzfGhitvpJC2k7IuumYMmNrZ+3+VDgBoW3ELHklvyOw9jduDpYi2dfl4WCI5IdRDyy/Oyw1Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=705 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601210160
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69712570 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xaPNhQpROp4q_N-xRLkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: R-Y_R4iNAyiebPe6zMiuslEq4OHYclC1
X-Proofpoint-ORIG-GUID: R-Y_R4iNAyiebPe6zMiuslEq4OHYclC1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE2MCBTYWx0ZWRfX4dwlp4PwcivE
 k4LRtRvhIFbpT767pMKjHThEthWo6lF4nDbJeb2mi4/k7wq+GxDSDsYDQZNF1FPpeoJDvYs+bIP
 mYBVE7f+4e0THbnLw2kjZQzpezWkyM11MAsRiWGhvdf0tj9PqeWTDd6pvhGDLXXelX9DZFZieu/
 2ZbzYQEvuCYQWqSOGC/0B9WS48yatZySRXPHBrcnrTVqDGRh0BAUZnYSOYYU/rx0ZhnukeRO8OI
 rfrTPT/lYhqiJnsQJNXpRJrIwi+BWSQGNgTgV6+ZEYjosQ46C4WOwZ4+vY2qaaLy+RuLjDQly49
 2AkxqeqXJ0Qq9AjEQVUYxn/EYXW9mIaHHecHZ4njOf5Vufe/nFiYiuAADS/OuqZtRlEGgrL2UrI
 ZQjvlnn73hDK7h1GR70T/Z2F6GHOItiIFia24vo0/FoG8XAlRlynD6VO1nBjGT7b0JaxXrNBk3x
 pXJ8kXk+QLwspHgm8Mw==
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20493-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D32415C677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBXZWQsIEphbiAyMSwgMjAyNiBhdCAxMjozNTo0MFBNICswMTAwLCBIw6Vrb24gQnVnZ2Ug
d3JvdGU6DQo+ICsJaWYgKHBjaWVfY2FwX2hhc19sbmtjdGwoZGV2KSAmJg0KPiArCSAgICAocGNp
X3BjaWVfdHlwZShkZXYpICE9IFBDSV9FWFBfVFlQRV9ST09UX1BPUlQpICYmDQo+ICsJICAgICFk
ZXYtPmlzX3ZpcnRmbiAmJiBwY2llX3Jvb3RfcmNiX3NldChkZXYpKSB7DQo+ICsJCXUxNiBsbmtj
dGw7DQo+ICsNCj4gKwkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChkZXYsIFBDSV9FWFBfTE5L
Q1RMLCAmbG5rY3RsKTsNCj4gKwkJaWYgKGxua2N0bCAmIFBDSV9FWFBfTE5LQ1RMX1JDQikNCj4g
KwkJCXJldHVybjsNCj4gKw0KPiArCQlwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChkZXYsIFBD
SV9FWFBfTE5LQ1RMLCBsbmtjdGwgfCBQQ0lfRVhQX0xOS0NUTF9SQ0IpOw0KPiANCj4gWW91IG1h
eSB3YW50IHRvIHVzZSBwY2llX2NhcGFiaWxpdHlfc2V0X3dvcmQoKSBmb3IgYnJldml0eS4NCg0K
V2VsbCwgdGhhdCB3b3VsZCBpbmN1ciBhbiBhZGRpdGlvbmFsIHBjaWVfY2FwYWJpbGl0eV9yZWFk
X3dvcmQoKSwgc28gYmV0d2VlbiBicmV2aXR5IGFuZCBwZXJmb3JtYW5jZSwgSSBjaG9zZSBwZXJm
b3JtYW5jZS4gQW5vdGhlciwgcHJvYmFibHkgYmV0dGVyIHJlYXNvbiB0byB1c2UgcGNpZV9jYXBh
YmlsaXR5X3NldF93b3JkKCkgaXMgdGhhdCBpdCBjYWxscyAoZm9yIFBDSV9FWFBfTE5LQ1RMKSBw
Y2llX2NhcGFiaWxpdHlfY2xlYXJfYW5kX3NldF93b3JkX2xvY2tlZCgpLiBIb3dldmVyLCBJIGFz
c3VtZSB0aGF0IGR1cmluZyBkZXZpY2UgcHJvYmluZywgdGhlIGxvY2tpbmcgaXMgbm90IG5lZWRl
ZC4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K

