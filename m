Return-Path: <linux-acpi+bounces-11781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CB0A4E238
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679543BFF2B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780F5263C8E;
	Tue,  4 Mar 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="rvud11AX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938631F3BAD
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099510; cv=fail; b=JfBK5WQfR5AwBPdcZAN05pEg7Jp23RB9+xI1qo0nAqdlqysomsWnuAdyqjoRRGrjTdqk3V20xXWjKYfLlx7a+W3po5fpzSXOot6dRHw4daw89o49V3E1Y3sV5jxZy+auYjzsWCyJXQ+/ns2XhGdMWSQpkeP/Q5FGCycE/xy65+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099510; c=relaxed/simple;
	bh=/yk+RZqi6H72uIcxM8osfibikSSOTRTnu5FWu0eaUq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1+kRmp2aKUlecRZk8LKiG61V+od7zE5xJ1Tn4gxSanKysnlDqP4SyGCvs9fISYNh1rz7bj2/FbODg85O8yMJJss+GNuRe3oFApY5z18/DN3K1njl6WpZ1Y5CsJbmhKkpdoWueMI3HWH+KlYlsJb4GLwUUZi4uj6HZwtpu+dfUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=rvud11AX; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524BWc3P022174;
	Tue, 4 Mar 2025 09:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=X
	yoz9/UdB9eOeryO38HZ69AEgzbfSTh8k7N6JUAjKn4=; b=rvud11AXzUwGK8ymZ
	Ul0Ykf+roz0gRtLGcjkLIw52bw2EZoGGoDg8bRlCkg80OX1N7yfJZMiPfDUiXKZd
	czhUL4lE1bh6hju+ksnjDV7axdsYwvR+8TFi0e96WJjtGOGeEU3DlASeZl4Bgc0Z
	Zu/BgjbQAj7r/urKq0BhF7AlP+lreIQMTrYPs31TT7tBaVY7CNx8CQ4NWJwRYmq4
	IAqQpHjiYXSHwozPl3qzju5PZYKNf9mNpVQaVvZdxRgE9kik+tcphw9CPTs8PKUl
	RWpO40qdVYYQIW/mwgP/qP7s7tbPzsy5n8/n25+FjWOBBgkHSuQHv9og+RDXg5CX
	2BUQg==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 453y4nw310-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:44:54 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524ENfvb016299;
	Tue, 4 Mar 2025 09:44:53 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4561akj2cj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 09:44:53 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2XOL4MzGFKYYl55L/DblQVS0IClI0kG/FCnftfJzVVldb0HEraXXURBQ1YKf1Yuv4gffSH3FLeQs0hxxQPbtSH9MUbOD4q+NDnw8mKBv0CsZxOnsvzLhDXB5bPtiUDsQIRT3q10iNvJuO6UYX33vVDBcW6W78z2+ZOl0mmrdLbSBOD7cl0pMAc5hFzvaqfViH4+seFBcTYBWEGNvGfllZ84xo7z43kgGonHDvdGfe4GDFtB4WkYNxjBVGzJbxaVeeZftWmVaydbs1+42+wTgZsfYg5rmF1FGdLYkERRqRuRNmbp61asS4vWXjMbbyHU0FSXeakNUHBE4AaIF9Wglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyoz9/UdB9eOeryO38HZ69AEgzbfSTh8k7N6JUAjKn4=;
 b=Li4Lp80Q55ZByhDNLAnVSqcthLHlc8cOz6z9dYaJ9julTFMPwLLuSq1J+xl0ypoHWnrMNra12Xjy6ET5D5PCsGDTTU3jElMYTpJyW+8dHzDU7p+aVrsgJJar2QP6vbq/V031k/0Y0dNlr82+9xpr6NPA1tz1++4zeBFiiSWgxoRlvk+vuUYmrWwnWpqTXXAUxCd0gxiC2fo8zhKiVW46WyCfqdmOkzD1a6CHudZUtVU+HXJZ4tO+QQMcLJy9rVKTYfz7MOwx37opR92rMCKzm3f/ZN0BlEd6oZcn2aJ9Rohia87rs8PprKNgx1h3I5dhI19kchUT0gOVxgzLIC9ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by PH7PR19MB5702.namprd19.prod.outlook.com (2603:10b6:510:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 14:44:49 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%5]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 14:44:49 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: Mario Limonciello <superm1@kernel.org>,
        "Limonciello, Mario"
	<mario.limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC: Richard.Gong <Richard.Gong@amd.com>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: button: Install notifier for system events as well
Thread-Topic: [PATCH] ACPI: button: Install notifier for system events as well
Thread-Index: AQHbjIMTqHL+THulIUiI+j5zWzEUM7NjDhQg
Date: Tue, 4 Mar 2025 14:44:48 +0000
Message-ID:
 <BY5PR19MB3922B4FC2D390A15CBE389C89AC82@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20250303212719.4153485-1-superm1@kernel.org>
In-Reply-To: <20250303212719.4153485-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=a17df8f4-4d44-4ea5-92d5-5e0907d49417;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-03-04T14:41:45Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|PH7PR19MB5702:EE_
x-ms-office365-filtering-correlation-id: 7ce1bb0d-c46e-43aa-a404-08dd5b2b1d53
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?aUxhcUlkSFo0Vmd1RExzZGt4N2poNC8yOG1QZmVpWHR0eDRQVmlETHd0cUtD?=
 =?utf-7?B?ckdTOHFMNlh1M1Z5ZGlwUHNXTVBWME1ZQ0hIVVhhSEh4a2JDVDJHQTBkZjQv?=
 =?utf-7?B?NWRmM0hSTDRsUlJ5OGgxaTJxb0lSSWpyN2ZmOUtBN0tDdGNkZE03NnFrMzJL?=
 =?utf-7?B?Q2p3MU9sekJKV01ZVlVhRjZFR3RwaWdwcFRjNnJaY2lPZXh1UjNKZEJWVVpv?=
 =?utf-7?B?U05NQ0JTZ2pmZm9rVzB3a1lHRFlFeXJqYVNEakdJWmN6cWFReHJHL2dyaG00?=
 =?utf-7?B?OWtpc0k4dURkTDJMREJmajE3V1NpWXRCWmIycVNrbG8zazkyKy1nMXVMTGMv?=
 =?utf-7?B?U2hEQmlTeUxzblpBVjd2eldHKy16M3lldm1yT3lOWXllSjFHSmZOTk1HUGxT?=
 =?utf-7?B?Z0dNWW0xQld4eGw5V3hRU0d3V2dVZ1ZrbTl2dmlvSW9WaGFwTWRYQk1nQVBJ?=
 =?utf-7?B?TUlwMlRtd3QrLXcxU1lISmVXeFlkY2ZaNXpNUUN5YTlNKy1ZNnAyc1BZSWU5?=
 =?utf-7?B?dGFTZnpyTU9sQXVTdVBHUy9ZWW5VRjJaOHlJdEFlWDhHUG9icjUwekJuVjNS?=
 =?utf-7?B?dVpRYzdDZnVjUmtrT1EzMjlIaGYxVmZIQlJjNk5GeGRoNGNyNElSOWRiTUYz?=
 =?utf-7?B?eXg3RTFNODh6RmE1YlFYNGVjRDlvNG13eVhVemdydE9Yek4rLTd2R0hXSUM=?=
 =?utf-7?B?Ky1ieFoyUkdDZnFTckt2SlYwa2lJb0lwSjdramx4MFJIa052Ky02bFpyNWNP?=
 =?utf-7?B?SnFGdVhVZGR6OFBqQjRjanh5Yjdzc0xmUmZaQm9pTnMvMVpydnVWKy1jSHVC?=
 =?utf-7?B?b2RBY1RtUGlVa29NV0lXdVBJSGEwaG4yQkE1VWVOdystSmpHZk9iV0ROMHc0?=
 =?utf-7?B?ZVZaQ0dBMzcvRDRqZ1R5T1BTdE16WVZyYkFxc3A2amdnNXlCZUI1MHlUYWx0?=
 =?utf-7?B?UTY4NzUxNHdCYmNzUkJzYWVsTzBMMFUzWTZuY2NXS25GSVNBcTVJN2pyMktj?=
 =?utf-7?B?QWo2SDRLT3BWVDR3dnM4ZFRKcTRKZ2ZxZERjOUlQRmpJRklpRHBzbGc1SjFi?=
 =?utf-7?B?UngyN3E3Z3hTYlVjNlkzZFpRRGJTQ3llSXlkT3JOSzd5aGJTQmVIN0RnMjZa?=
 =?utf-7?B?b0FZOWtvN3BHY2Z6a013dHhuVERvcHloU1N6dzR5dnBGa29UYUpYYlFvdFNH?=
 =?utf-7?B?bHN0R2NVY1dUV2duclBQSEZWaVFybVJOV096cGVpM1lITGtPMmdzMTRtMFJs?=
 =?utf-7?B?a2trYjhPbmR0b1ljZ2dzRDdPb3BXSjFnMjlMRDNHUjNFUTVPekJIRjJiUG9H?=
 =?utf-7?B?NzZWSk1yMTAvYjMvcjFMYThiRU5ZOFh0OVlJa0RwNHc5YTk5dERJUS9Tdzd1?=
 =?utf-7?B?V1IwRFBIRFFMaVYzc0lwbllxUHAyOXB1OEJKQmZGaUljV21teGprRkVlZFlG?=
 =?utf-7?B?NWZxekRTSmxHMXFzN00yMElYN1I2S2lLUXhMR1M3TU1scmxJTjZPZ0U3M2pI?=
 =?utf-7?B?a0pZTCstWkpjdXAwN0VNSkR0UXoxS0djKy1lZGdSKy00cE00RnhvKy1WbThZ?=
 =?utf-7?B?cnZ5a1VWWm5MeDVRdk8vbEl6QlFWeW5ZUHV0SDNRRGlBNGdoQXczVUtTd3k5?=
 =?utf-7?B?WjVPV1RtaTQrLXhFZDFsdW1ncVNDSVArLSstZVFzR1FYa21hUnEwazA0UkMy?=
 =?utf-7?B?bm5vcGg4NnZzT0xQYnJrRG1tc2dObEZHZFZLZFJRR1oxeGJQQkNyMGRuRmJu?=
 =?utf-7?B?M1ZFbExiMHVhdkpJWVZYSUlWN1IwcTNyeWJCaFExWFRUVjZtT2hVb2g3WTRI?=
 =?utf-7?B?OFMvMFhCWVFjU09BNnB3dHBXYlZ2c2xWcURXdkxISWUvN25qRjMwUmMyN0E=?=
 =?utf-7?B?Ky14SDcyRGlLeExuKy1Hd1VnWmE4R09oSnBsQzIzQWc2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?TnY5TUM4dG1XcGduaGdDalBzbHJoQ0NXaTRiSzlTek5SeDFwZzBnR0JmNUh5?=
 =?utf-7?B?VURQNU5Lb0RqL0VSci9XekRpdHA1RUtvZ1hUcW84aXJ3NEFqUm95YndKKy1O?=
 =?utf-7?B?aVFyeXJmZk9LYXdHcnhTcnBVaFMySkkvNGNDZlZ0TCstWDBIMkdMcnhqL3Bq?=
 =?utf-7?B?NHQ5dGI3MjdGKy14RjJUcGQyTkhWRllqZ0FBUVpJa0FkUXQ3cFFscXdBejBw?=
 =?utf-7?B?ckNFSFc3VGYweW9BMW9EYmVoUFRYaHNCSzJwRmhpc2l1RGhLVi82MnprYkJm?=
 =?utf-7?B?d3Jqa280empUT2lTSDY0eFBJcjZZdkwwbDl2VG5IS1NYV1g4NDVnT0N6c05a?=
 =?utf-7?B?VmdOWWJxWmZYelI5NzFWOWxiNnRONnhrYTJ1cVFQZ1dZUlpUeDNvOFN0R1Y1?=
 =?utf-7?B?cm44a3NrY21NaWFrYTdCMGIyZTVlMTVYWUVvY3BtdUFGS0laTlJOS1k2emZo?=
 =?utf-7?B?SmJFdjI0dWhQREYvaWk4cmoyWUpSZmxzSUFxNWpheG1wdlVUQWoyQ2JaeEtP?=
 =?utf-7?B?Ky1vRDNLa3dkQ1dvVHJhRTBIbjhVU1pZenJiUnJBN3piT2kvaWZPeUhBZTRH?=
 =?utf-7?B?Mm5QeGlPRmtWYVB1N09RTmRKUHJrd2hSMUZoaWFxR1dINW51WHo3azRPR1Vu?=
 =?utf-7?B?VUhCL3luWWRQN21oeUtWV1RNaDlYY0FoM1pySnZ2VGxEZ3hsaDVMeTRodUVF?=
 =?utf-7?B?RnFPaWhUQistVy9PNXo1WTRtaDM4TFIySVl0clE1aystVXAwQ29Ja250d2Y1?=
 =?utf-7?B?Y2pVKy1tTDBkMXZkanNzKy1vbFRWdm93WEJkU00yWGUzMVBJL3RoOExsRVFl?=
 =?utf-7?B?aHM4NGM0WERqbWZnSFdxYVYwRVhoc2E0cE9jZU5KNG43ZFcrLXZuSlBhdWo4?=
 =?utf-7?B?ZjJ3VystR1ZMT1drWXB4R0xrYXZtejNTWkRoV0E4MXdXblJXUlUrLVRoc0Jj?=
 =?utf-7?B?YVo4UkxRR2RlTXlTUHp3WUJoOXZzbGRrVWZidmo0S2dlaVN5dk9RQ3NTUW1t?=
 =?utf-7?B?dU1lTzhiaTdwVU9hY0R6cWJQdmZWaS9EVmhpWGhmM2R3dnhaNE5kbGN2S0c3?=
 =?utf-7?B?VlgyMy9RemY3YlJRQVMrLWVWNVVHcDB1WS9rcFUxbXN5ay9HMlFQYlNBTWVV?=
 =?utf-7?B?QndoQWRGbEJpS0lCSUN2YnpKKy12U1hGeUR6a1JmS21seVBQa3cyWG1JYmxr?=
 =?utf-7?B?SERncFNUT0d2eE9QVWh1d0hra0JUR0g0TmhBbzhha2tuQSstU2FZdDNya3Jj?=
 =?utf-7?B?N2NyM2dMSjRXN2hJYnBZcE9JOWdYYjJYM3o0c3NmUTBxaHJZazVJZ2xCc0li?=
 =?utf-7?B?Q2hTVFVnbUlLTW1aRVEyV3NWNUk0RHlUSzlYUFRkeUg0VEdCdjVwbmlQa2lD?=
 =?utf-7?B?QlROSGVDMjNIVmVPWGNEaCstL1UwQjNwRXRpd1FOakFpMGlsa3FvbXUwaFh6?=
 =?utf-7?B?alllSTBQaVVWNnF0VzNjYUJ3Z0NsNWpQNmRFaDNQUFV0bXE5d0pGb1VMNEJr?=
 =?utf-7?B?bGFZKy01T0Y2bjZpYUdLU1NhTURmaW12b0xFVEJpTDZHWk5ic0tBSkxlS0RI?=
 =?utf-7?B?aHlja2l0MU84WTh3WDhFdVJpQmRTM1JqaDNCUjhqV25acWZsVUxhU0JLUDJk?=
 =?utf-7?B?a2ZTZDFVRFhsYystSE1xR2daVHovekVma2I1cFJ2dmZFbGVFazN5QnBLcXY4?=
 =?utf-7?B?TFIrLXljY1BES1hCZWMyenJrQkpGUVFJbVltYUg1MUJETzRCRGlUc3FLbG13?=
 =?utf-7?B?WkN0SXhzODFoYkFKdGQyMWVXaE5kSUdFWGVFT0N3QU94T3lBKy0yRXRoTkJw?=
 =?utf-7?B?OWgwZXB3MkI3UUVXQ3RQZDRndDkvN2ZVZ2tSUnJ5MXpRTU8rLVhhOGorLUZ1?=
 =?utf-7?B?L3N4WGVLZVJvbG8vSjhtdm9kUy81N0t6eHZCaUlYYVBlZkZINTZlbjcvT1N6?=
 =?utf-7?B?MDRxbW9McDZKaFhPc2lQZkNRb2EyZlRqSTlyc2pyeCstbVBjOGYyeUZQOXZk?=
 =?utf-7?B?MEFta3ZCRHd3UFpRR0s0NE9oZGVNVzFrTW1vRFBwNXpnTWtQQ3ZSSUxhbWs5?=
 =?utf-7?B?dnI5c2FYVEczS0tIR2hpaUhJMG54WVRPN1pHNTJ1Z0hwU2JGazVXT01YNzdM?=
 =?utf-7?B?YkwxSWRmNTUvSUtrRThXTXhXWUdoTGRaRGxsb2UyQjBWbGFEelVxcUVBZk9w?=
 =?utf-7?B?dXE=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3922.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce1bb0d-c46e-43aa-a404-08dd5b2b1d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 14:44:48.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VA9Po7e9bknJqApKDzQnJH5Uag3tzJ+JWkhh8bTpy9uQVyNhPkL69DMhf6jKGxvh71K9PFnoc44DVo5H9D6CCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040120
X-Proofpoint-ORIG-GUID: K5v7KpNc6GsP5y5g3gZA12oZ0qa3RoYN
X-Proofpoint-GUID: K5v7KpNc6GsP5y5g3gZA12oZ0qa3RoYN
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040120


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Mario Limonciello +ADw-superm1+AEA-kernel.org+AD4-
+AD4- Sent: Tuesday, March 4, 2025 5:27 AM
+AD4- To: Limonciello, Mario +ADw-mario.limonciello+AEA-amd.com+AD4AOw- raf=
ael+AEA-kernel.org
+AD4- Cc: Shen, Yijun +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4AOw- Richard.Gong
+AD4- +ADw-Richard.Gong+AEA-amd.com+AD4AOw- linux-acpi+AEA-vger.kernel.org
+AD4- Subject: +AFs-PATCH+AF0- ACPI: button: Install notifier for system ev=
ents as well
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- From: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4-
+AD4-
+AD4- On some systems when the system is put to sleep pressing the ACPI pow=
er
+AD4- button will cause the EC SCI to try to wake the system by a Notify(DE=
V, 0x2)
+AD4- with an intention to wake the system up from suspend.
+AD4-
+AD4- This behavior matches the ACPI specification in ACPI 6.4 section
+AD4- 4.8.3.1.1.2 which describes that the AML handler would generate a Not=
ify()
+AD4- with a code of 0x2 to indicate it was responsible for waking the syst=
em.
+AD4-
+AD4- This currently doesn't work because acpi+AF8-button+AF8-add() only co=
nfigured
+AD4- +AGA-ACPI+AF8-DEVICE+AF8-NOTIFY+AGA- which means that device handler =
notifications
+AD4- 0x80 through 0xFF are handled.
+AD4-
+AD4- To fix the wakeups on such systems, adjust the ACPI button handler to=
 use
+AD4- +AGA-ACPI+AF8-ALL+AF8-NOTIFY+AGA- which will handle all events 0x00 t=
hrough 0x7F.
+AD4-
+AD4- Reported-by: Yijun Shen +ADw-Yijun.Shen+AEA-dell.com+AD4-
+AD4- Tested-by: Richard Gong +ADw-Richard.Gong+AEA-amd.com+AD4-
+AD4- Link:
+AD4- https://urldefense.com/v3/+AF8AXw-https://uefi.org/htmlspecs/ACPI+AF8=
-Spec+AF8-6+AF8-4+AF8-html
+AD4- /04+AF8-ACPI+AF8-Hardware+AF8-Specification/ACPI+AF8-Hardware+AF8-Spe=
cification.html?highlig
+AD4- ht+AD0-0x2+ACo-control-method-power-button+AF8AXwA7-Iw+ACEAIQ-LpKI+AC=
E-m8bmT5JUyck9Q0BMUA-
+AD4- LmC5MXTEXFeJ1nmcNGIhJ4AWCQ7XMUR+AF8-UqxaxBor674mhMk53MkwkXqT1a
+AD4- cTF+ACQ- +AFs-uefi+AFs-.+AF0-org+AF0-
+AD4- Signed-off-by: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+A=
D4-

Verified the patch on the issued system, the issue is gone.

Tested-by: Yijun Shen +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4-

+AD4- ---
+AD4-  drivers/acpi/button.c +AHw- 12 +-+-+-+-+-+-+-+-+----
+AD4-  1 file changed, 9 insertions(+-), 3 deletions(-)
+AD4-
+AD4- diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c index
+AD4- 7773e6b860e73..61701c646e92f 100644
+AD4- --- a/drivers/acpi/button.c
+AD4- +-+-+- b/drivers/acpi/button.c
+AD4- +AEAAQA- -24,6 +-24,7 +AEAAQA-
+AD4-  +ACM-define ACPI+AF8-BUTTON+AF8-CLASS            +ACI-button+ACI-
+AD4-  +ACM-define ACPI+AF8-BUTTON+AF8-FILE+AF8-STATE               +ACI-st=
ate+ACI-
+AD4-  +ACM-define ACPI+AF8-BUTTON+AF8-TYPE+AF8-UNKNOWN     0x00
+AD4- +-+ACM-define ACPI+AF8-BUTTON+AF8-NOTIFY+AF8-WAKE              0x02
+AD4-  +ACM-define ACPI+AF8-BUTTON+AF8-NOTIFY+AF8-STATUS    0x80
+AD4-
+AD4-  +ACM-define ACPI+AF8-BUTTON+AF8-SUBCLASS+AF8-POWER   +ACI-power+ACI-
+AD4- +AEAAQA- -443,11 +-444,16 +AEAAQA- static void acpi+AF8-button+AF8-no=
tify(acpi+AF8-handle handle,
+AD4- u32 event, void +ACo-data)
+AD4-       struct input+AF8-dev +ACo-input+ADs-
+AD4-       int keycode+ADs-
+AD4-
+AD4- -     if (event +ACEAPQ- ACPI+AF8-BUTTON+AF8-NOTIFY+AF8-STATUS) +AHs-
+AD4- +-     switch (event) +AHs-
+AD4- +-     case ACPI+AF8-BUTTON+AF8-NOTIFY+AF8-STATUS:
+AD4- +-             break+ADs-
+AD4- +-     case ACPI+AF8-BUTTON+AF8-NOTIFY+AF8-WAKE:
+AD4- +-             break+ADs-
+AD4- +-     default:
+AD4-               acpi+AF8-handle+AF8-debug(device-+AD4-handle, +ACI-Unsu=
pported event
+AD4- +AFs-0x+ACU-x+AF0AXA-n+ACI-,
+AD4-                                 event)+ADs-
+AD4-               return+ADs-
+AD4- -     +AH0-
+AD4- +-     +AH0AOw-
+AD4-
+AD4-       acpi+AF8-pm+AF8-wakeup+AF8-event(+ACY-device-+AD4-dev)+ADs-
+AD4-
+AD4- +AEAAQA- -629,7 +-635,7 +AEAAQA- static int acpi+AF8-button+AF8-add(s=
truct acpi+AF8-device +ACo-device)
+AD4-               break+ADs-
+AD4-       default:
+AD4-               status +AD0- acpi+AF8-install+AF8-notify+AF8-handler(de=
vice-+AD4-handle,
+AD4- -                                                  ACPI+AF8-DEVICE+AF=
8-NOTIFY,
+AD4- handler,
+AD4- +-                                                  ACPI+AF8-ALL+AF8-=
NOTIFY, handler,
+AD4-                                                    device)+ADs-
+AD4-               break+ADs-
+AD4-       +AH0-
+AD4- --
+AD4- 2.43.0


