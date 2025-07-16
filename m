Return-Path: <linux-acpi+bounces-15180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E492B07221
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2D03A3631
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F82EACF8;
	Wed, 16 Jul 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MPpyR3p9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="q2WrFQwW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60950225390;
	Wed, 16 Jul 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659197; cv=fail; b=G9geq3+G2Y9gVjnpdHpRmmZSK43ISIjK+8mv69aU+tUqlZFuy+RcgGDs16RmHOJVf6vIuNABPqiWC4iSLzNHyEJQueoR4oTpMyVMs/6XGZqBF+QklyhSrF59JNGkRN7XfihjLr7xVud6uBzvGYqu0k8sjr3X0QLEjohozLF3Mro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659197; c=relaxed/simple;
	bh=652WAVmUqgeP31HEJ/J2ru+1Pg3hl+g+sX0Zj34AdAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BU+MVdAqFxQVGnLGtEfZO5eMiBIBh0DtbeBYOZZsH4WkXZHNO7s9fsXGLCOud3PHiJflwidQrfEW2SlTsk4GslZAumjL+V8E/YQPM6H49LmS58mB3PHIs8n0ZfTE5Owo15F0YSxTkvTkGqAsKaHuAFy5OMJ4PbX0NODrwF9Oi2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MPpyR3p9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=q2WrFQwW; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7bMVD028258;
	Wed, 16 Jul 2025 04:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=FuHDLapv/bz4C+hh
	tIYIzdatdU9xisszNq7CaoNzUVk=; b=MPpyR3p9Ju+JzbM54E7w/3lwluu9T08R
	PNpieM+8JnUbHhq/30u1SPOVX2hKFaEf/ep8+dXY/oep7lm1QUdtSeMa2Mx97J8X
	LpWrr8kBWp7cd0TI5W/zFYiwJJ/sfVb+wWWoYt1MaOaR2bodEUdItOl0y+H2MyKr
	8CW9qhLUFrtaso8Z698nmXkpzuBO0vpo29EjCQuK+CSavGUvVmXdvaBpzXKThKoY
	Ql4eVOUGLEF+FiMmJG2RgzbPdq9gOSmKR33/DQ0V4L/yTNZ0j3clMh30tgHwgENL
	VL9ueaci+93S9naCQqmrieDCLm+6rc8dJb0bdlWJlw0vUm6rUh2vbQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 47x7uur5ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 04:46:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVj7RssX8CBgxONKcsO6vZ1I8PAm5iuQuTFyazwxS4Q+bI9nqmMQx6G9D933VYBOoksmmn3/nCjN7kjtIadS9TY5cY7cmjvHK7oT/ukmHda1vIbTv8tfE+bOLd0D8EHd7KU0EPKMC4OcZiaM7uePiB+qbHvw+tIde5+igK+JXT2fOSsF8yopiUY9xmdTXYZEkwXYMoele4fog/4XyVlaEucPb79QrA4JfKQALmqkxLv7qeN1EG+0QAM+pngaos/I07t/eR9EaKpFWUG6eTLxvuFcCnMpioWLKYRvMKns2vSobzEBB2OQp3zVgVPYqFG3zS32mcYir8JKntj9xsuEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuHDLapv/bz4C+hhtIYIzdatdU9xisszNq7CaoNzUVk=;
 b=vr6YAxXB1BIefiFB2K8PvSQcKPyvttbm/+eOyKMOWd4cAfOHMk+VxKC6hdU1596SqMLbRP122QztiIDrCbp34Y4GUGVHeocWCOD0OCBi3+3XonGwdD9d1kCUg80+baoNUlowUxVAsDZdUfRC+bNUtrt8UJ2kmruq99XuuXPuUl5AlBLYQyKCKKR0G0bvEwqji7RqShHkPlmRIwAJragKMWzWVojL/3CSsPyC9cTvrpoP9sA9Oeab1Lhmmww/mxbkgQuLy3/seon4kXH1DbazTzoLZ1lut7Y2/JmwqCDJNpnqfwC6Sr3CX3uwO5AGNnhLVbWqi5425dLwKblZmjIDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=intel.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuHDLapv/bz4C+hhtIYIzdatdU9xisszNq7CaoNzUVk=;
 b=q2WrFQwW1A6ONB+NzJsPaNDoyOPOlR4Yrv2H35RlyE++HJTkIyfzhBgLYiaZk4MuvyZRSQynv1jhSGZm80jKX4ctJA6GZqPuL1oSjedkhcpupJwWUQKRzBu10wcrj/DKS0gkYGStbRAslvg2/k9TISbzhBCi236w8HA0djULQXA=
Received: from MN0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::28)
 by DS7PR19MB4407.namprd19.prod.outlook.com (2603:10b6:5:2c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.16; Wed, 16 Jul
 2025 09:46:25 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::f3) by MN0P221CA0017.outlook.office365.com
 (2603:10b6:208:52a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 16 Jul 2025 09:46:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7624B406540;
	Wed, 16 Jul 2025 09:46:23 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 62251820249;
	Wed, 16 Jul 2025 09:46:23 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linux.dev
Subject: [PATCH] ACPICA: Add SoundWire File Table (SWFT) signature
Date: Wed, 16 Jul 2025 10:46:14 +0100
Message-Id: <20250716094614.572352-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DS7PR19MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2e1af1-6427-4b4d-3a34-08ddc44da0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVYc0xkQUc0VXZKdDZHL1E0Nkh1ZTZ4cWJTT0UrZytNRVlPQXZMcmR2OVFx?=
 =?utf-8?B?YStaa2ljWElmYXBoUGhsbjFpK3RXVVJ4SGk0bGVxdkZmek1sOVdhT2FBVHNS?=
 =?utf-8?B?TktiNkJmMTdlTjM3bmdvWUprV3p2cFFZTUFhZFRpT3FDcS9IWWpjNFRZQWY2?=
 =?utf-8?B?QnlFTWtqZ1BCRmdoenY5NVVTaGg5b1AzTm82djR2MW1jaHZZMmdyMGlBUUtK?=
 =?utf-8?B?cTMwU3ltaCtLenVDR0JBb3gwaWlmdzRPU0pzMFpWekhuSGw4Nm1RVW9aYTM2?=
 =?utf-8?B?d2k2NURPajJVMTVKczNtRGlNSXl5Q255bWhIQ3VOMVovTDlUN3I1L0UxcDdC?=
 =?utf-8?B?MSthdmtMTTlYMW1WSGN4ejZYMFcrNGxwK2dIM2xCaGhsZEJVMExEVklJNDJR?=
 =?utf-8?B?TU4zeFVabm9ReTRCVDArbjRuS2ZYcjdGditNbXI1SHdvbDNzRk1nV2NydDhy?=
 =?utf-8?B?TWhVbjVGT0EwYThIUWFpMmRIcXFnOUQ0TkQxNys1eTZvY2hNN2ZGV1RDS3ly?=
 =?utf-8?B?cTJxcDVSZTBhVk5QaGQweVU0ZHl5aXB0SzJhenI0NXNiTEtWckZKVVArc1A3?=
 =?utf-8?B?VzVTRmJYb0w2VnN6QXJGbzVxeUFlQW5HN1BjMUx3cDgyUmFOcXBZL2dsVnZw?=
 =?utf-8?B?ZEU4WUNPTUZDOWxTMFE4QUM0OWhtdXIwcXdVQyt1VitxaGo0VE9RM0V4SEoz?=
 =?utf-8?B?dzhEY3lYbm11b1pQTVY4cWZLRmNtUFZRaStsOXBGYzU2N2tXVE5Jb2RVdnBv?=
 =?utf-8?B?UGI5aDVRRlROQ2VJdUorRE1ldFVCUUlTNzF3QVE3VVhpMmZ6N2U0c0NUWU9T?=
 =?utf-8?B?bDFDK3QvWkNDV3RxU1lUeGxhRllPQURWM2JFRnhvaGphR1U3R3h6ZGxGd1Z1?=
 =?utf-8?B?bEZaTGVtcU4wUEpNM29FUFVKUEdDbHlvWENzZDdzUGhQOU5UYzJQYUM0YXFm?=
 =?utf-8?B?SlNyeUFYeFZSQ041TFJ1NVlYSkZiM0xLVzVPSlRmc0xGbFJrK0s3Y3BPZmxI?=
 =?utf-8?B?c2VnYW01MHZHeG43aTg4ZzI2eEgxQm9TcmlCNlNJb25ES2loeEZSTEYybkNZ?=
 =?utf-8?B?ak5BQ0RHWVgxZEpNQWFQNnZ2SnY3bXNpRnVEY3p1ME1xUHIrNVlHa1ZtYkRj?=
 =?utf-8?B?ZXpHbkZ3TXNRcHZ1YzEvaEJKUmIxOVozYjFBaXhvV3BhTFhwcUhTc0xiR3dL?=
 =?utf-8?B?QXZ4NEN4c3lhSlBHZWNKaHlVSzdzSWpmeitvZUUxdVFrQkpJUkkrRzIrT0Zk?=
 =?utf-8?B?VW9Fck9WVDlmQ3ppdmFHTjNlenBQWGtrWUVGVjl5VTlrdmZ0Z1d5Q01zV1BF?=
 =?utf-8?B?WVBObFZ6bEZiY1pvM0FPZC9iSWdsczNrRzJMb0QxTkoxRlZzRllqM0JaS3ZP?=
 =?utf-8?B?cnNyaGRXYnpzVk0zNDRSUDhUS0EwUFVFZy83czRZdlBKTGJIdjNmMWxVL1ZE?=
 =?utf-8?B?dldYaFlhNjZveHpGMHpBS1RnZFhHcE9wZ2U4ejhuMmU1RmQ3M0poL1d3OGJZ?=
 =?utf-8?B?UW12TXY4TUUzeHQ1STJRSVFtT1VTb2dtZktBNGhXNjhXZzNsMTVadWh3c1Zo?=
 =?utf-8?B?b2d1M0lxSi9EbzU1VFZMbWlUSXVMN2tldWR0RWloY0dJQ0NxSzJqZGNFZDk3?=
 =?utf-8?B?bHlFM2hRR1dNVm9EcTlueEJ2dTFiM2EraTlUdXpRUjZkaTFRb2h4N08zU0Fr?=
 =?utf-8?B?RXZ5WjhDMmFWUkk0NDNnV2tkbk5DNEJpdnk3QXpFdWdSN3pxTTUrTHY3ell2?=
 =?utf-8?B?aURvSTlhZjZUU1lRS3BQNW9uR0gwTmdvbWRyNmowU3Q4RE1la3dtcmRkZVI0?=
 =?utf-8?B?eE85WWJrL0p4MjhwaS92QkxEZTZIWWhrMTQ2dC9CbkxWT2hCdDRTdVFIUDNv?=
 =?utf-8?B?WFZvRklCL1l2aVdIdVZRM3pBb3p3WFhlNit4bVMzZ2l2UXlMMWtuRXJ3NWkx?=
 =?utf-8?B?M3djMVdaZFY3Mkt5eERRS3hQWS9KSTQ0Zmh3Tnlkd2pPL3p1b0piYk5iWC84?=
 =?utf-8?B?VEdBKzZZdTZnVzhKRmlBcDNxdzU4NTg3UXNaazNkTmFOQ0J3QkNnYUNSSUtp?=
 =?utf-8?Q?8jLdr7?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:46:24.4784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2e1af1-6427-4b4d-3a34-08ddc44da0de
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4407
X-Proofpoint-ORIG-GUID: vuqoUwiK3kPlME_PLYYQoCy65YgiyWjF
X-Proofpoint-GUID: vuqoUwiK3kPlME_PLYYQoCy65YgiyWjF
X-Authority-Analysis: v=2.4 cv=IIwCChvG c=1 sm=1 tr=0 ts=687774f6 cx=c_pps a=UmjVza0x1M4UpXJilF6xSA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=L35MEKfBLXpLSl1DdtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA2NyBTYWx0ZWRfX8JR+cdW715oW 2lTUXIGh2Nnb8S1ZXNmshcie5N6ODu1QL6UwXlEQN4bFuBiBudUt8fVXvT/r7mejYqri6cmVthS Hsg2I4vrbhScOxikl1tudsj4AFRpXUJaYYFvPQPs4Dl1NWg3CcbBoIzCwcsRSeN7GilIRNdhIIK
 6Kzb2wAY3/vf6aldYmsBaaCUVlIIaGaEAIFp6TayZheYcLJXYTxUSyFGilivsIjb/4G+/iT/8xe HswuB0gJkt/FlonKmWoI7ml2syggkuDJHIb5UL5Ia3jlZOMMqD5URludY3snBmd0akTMyBLT7EU RF8EyHFFSLYs7sqnSGvJzWXVCPPba/SeI1QlHz1d2YxiAxpfqy3AdMnKOOkJ01o2yW9jtNHWnV4 fCDRhKVj
X-Proofpoint-Spam-Reason: safe

The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
which provides code/data which may be required by an SDCA device,
utilizes SWFT to obtain that code/data. There is a single SWFT for the
system, and SWFT can contain multiple files (information about the file
as well as its binary contents). The SWFT has a standard ACPI Descriptor
Table Header, followed by SoundWire File definitions as described in
Discovery and Configuration (DisCo) Specification for SoundWire®

Change-Id: I76429d14262fd44a5e21b24b18fbc5b5ffd24cbb
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 drivers/acpi/tables.c |  2 +-
 include/acpi/actbl2.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9e1b01c35070..beaef9a8fc02 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
 	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT };
+	ACPI_SIG_NBFT, ACPI_SIG_SWFT};
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e917a8f8bca..267ffabf3b7f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -54,6 +54,7 @@
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
+#define ACPI_SIG_SWFT           "SWFT"	/* SoundWire File Table */
 #define ACPI_SIG_TDEL           "TDEL"	/* TD Event Log Table */
 
 /*
@@ -3163,6 +3164,26 @@ enum acpi_svkl_format {
 	ACPI_SVKL_FORMAT_RESERVED = 1	/* 1 and greater are reserved */
 };
 
+/*******************************************************************************
+ * SWFT - SoundWire File Table
+ *
+ * Conforms to "Discovery and Configuration (DisCo) Specification for SoundWire"
+ * Version 2.1, 2 October 2023
+ *
+ ******************************************************************************/
+struct acpi_sw_file {
+	u16 vendor_id;
+	u32 file_id;
+	u16 file_version;
+	u32 file_length;
+	u8 data[];
+};
+
+struct acpi_table_swft {
+	struct acpi_table_header header;
+	struct acpi_sw_file files[];
+};
+
 /*******************************************************************************
  *
  * TDEL - TD-Event Log
-- 
2.39.5


