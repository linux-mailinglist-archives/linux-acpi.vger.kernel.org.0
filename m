Return-Path: <linux-acpi+bounces-15182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F83B07279
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D480D505C00
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CC2F2708;
	Wed, 16 Jul 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Kt2QHUvc";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Q69ur5cx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022B286890;
	Wed, 16 Jul 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660244; cv=fail; b=pOpBlNKtK/of3keCSQvi6Fot+9hCmL2YnQpKgXa4CpKzcSI8+xg8t/2vnTPz56qWvjzSDgaMppp04BY2WYelbshMi7u7nAvkMQZKcl5t5WTyfAJlpMDxRe/MXEDzQz41H7/qWrcbswizEzrUTr8PZuey9qZkt7HGRZrBqBLSiGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660244; c=relaxed/simple;
	bh=WFnwM8tmhZlumXFfT6yVquiVAhJ/no0P7JXuQTpnp0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QDjzuWb5wpbJlQFhIHMOJj8w9rD+VuxICW9F/qqKlSoePmw0BSxqwGBLmPfj+lgbYLP87YCP+v/GexIGeDTyjDOIOE1Jv7ZYN9pgjwaPiC8l/T3ib/luLRGYQFtY1Ahj5l6k2rTQbwklVoRO/dF/FGHUVUiZCqVL9t7MeFUBsjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Kt2QHUvc; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Q69ur5cx; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G4UV1f029353;
	Wed, 16 Jul 2025 05:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=xVoDdLLxNzBNJ5nU
	MQmrj9iUBNLUvYedjkGwY1qbohc=; b=Kt2QHUvcVeT4OoDCjTpWSeFQS21vPC85
	TL4gcTqTpFuh9MPckYr80c8p7O4UMVlQ9+NUXVZ5KVjIi5ij+KpLlK0ePCmrBcK2
	VGd+/+ibDdndV7YHr2BhaYdB2u/0hSAVqrCx25ZaQW88tcYqdSgHkOmd3kh+WXyq
	G4sB0mELfPiP0zZfHJ67XN3CGCg1bkWGGSLtsqvEy1zdEfrL9jvc8UEuDePq7ALL
	oj1Me4UxW7VHYKJjIy5E+Mha+uCNkIJ46icQiWa9tQELbGNYMnD6t6r6be5iScfs
	ghgG5H4vZqO74caMYdSKtREj7nsWlyau0qR7dALk0NJV24Sq6G37Aw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47un42df3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 05:03:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSVM47CLr+eIr0FnxWa3oOdF8efSGlxeGynPqfCzZRLe11g/cYk3dKdN8GRDD5YKStBWGckFxnQ4xF7uN9MX6MbZwUcgY3zf8YDTuhgKjOEl0Ig+Vm52AuFixDGyULEgvwsFVO3v1pS1iZJnRfYijqbw4AOWEMVEZdHTqdUUmms177I+y70T0dhuVtP4El3f0GPAW7o1JAC5dtMBcEjuzk9WPJ3qf2Z0sm4QZaqX3NGmdEXfk1hWalROZeBVWEGWWN0DCZiLRBU/o8HdaSusB/I3GD5dawj/tlHegT1KjortC5Js+/tPXdIxzOaHLe0hz1kw5jvikf4rAZlnBXQflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVoDdLLxNzBNJ5nUMQmrj9iUBNLUvYedjkGwY1qbohc=;
 b=YcDc5TBRa5xAMVyMLkkYcTGjYiC8DDXMXcUIPxvIxbkXgL4qwox+N+w1fg7r/vtoCEVe53xcCqA9iZqjJmLSgLo/r+Zbp/Se/MyxrsLZGzBw9piu+QWYx2dPdsBsmIXR8CVo8JbaL2UXQJXrmkEYy4HczJHO5q+vnxBS1fCdJInm2/DY2/zbvF1LkqJ2/xIDq/qkZkkWEll1o6vZ3Mh5BN1ihIyjEKEq5X/vWTICSPdQNMdjGmACf0icNcNDCeh8ELJOc7TM16rhzGz61BUmGxNnJtahs8n/J88SxtXDU37+ShUFwjAU77UgxW2ghvsac7FHMTDs4DvJOSJO4/n0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVoDdLLxNzBNJ5nUMQmrj9iUBNLUvYedjkGwY1qbohc=;
 b=Q69ur5cxCg8cRfmg9KqxF86SSt8CnQ197pVJsxUK1zObLHIk7G7NSAPzzFLwIZnW/If9a0d9O6J50vj8+w+yeFPVXygu7yXxWaRBIlrqQYMQ58GMdOM4t1xnOCrCJkvOe0KLk+IEqHCILmoGkQRsusyv1CzHgfFc5+gltuHRU1o=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by DS7PR19MB4552.namprd19.prod.outlook.com (2603:10b6:5:2c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 10:03:54 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d3) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 10:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Wed, 16 Jul 2025 10:03:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8F3DC406540;
	Wed, 16 Jul 2025 10:03:50 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 77A05820249;
	Wed, 16 Jul 2025 10:03:50 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linux.dev, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v2] ACPICA: Add SoundWire File Table (SWFT) signature
Date: Wed, 16 Jul 2025 11:03:37 +0100
Message-Id: <20250716100337.652657-1-mstrozek@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS7PR19MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3f3533-aeea-4400-4511-08ddc4501184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNuTFROblZMaTg0U2J2c3ZGWlNJSDlVQ3Yxb3U3ZExXNU4vd1FUVXVUdDJC?=
 =?utf-8?B?SlhORlI1RDZ3RzBQS3l5Vm5JT1htWUNNZkw2L2lXWnhiclIvanR0dEE3YUNx?=
 =?utf-8?B?Y1dkeEVxTlhuYldqV2tab3FISmp4dFIxdXhLY2kzT2RQbXBtcDZwRWgxU1ZW?=
 =?utf-8?B?WVM0OWl0Q1V4NEdybUJVZFBZY1VncTVqRzNFUGZEaEpIa3BsTnRwcE5aUzho?=
 =?utf-8?B?WGN5cmdSUnFSL0V0eS9sZGR1eGp5WVdBNFFnWXlDUmlyVkxKUC93RUg1NUFy?=
 =?utf-8?B?TCtqMTR0NXV6RlJsOXpVYm1vRmRIcFo2eFNYWkZsYVFzMHY1bllDYXN6QlQ5?=
 =?utf-8?B?bmZBUmgwczRCVDN6M1lGMjZlTlN1eXVCS0g1OWU4amZRQWQ4WU9DcUNFUXJh?=
 =?utf-8?B?QUIzK1p1b1hXdE0zWmc1OUo2aG9xZ1p5V3BXays4UUlkcDBQY3RrdmxXTjIy?=
 =?utf-8?B?cnlhYjNsNWZvT29ndnplUVJOWGFLM0tPT0hzaCtVNEtMWXllRWFTbGF2enhJ?=
 =?utf-8?B?SFRpV25wSG1kck1pdXQ2UkNPWWlBNGFOU1ptdFl2OXcyU1orTHJyYVVQaWFv?=
 =?utf-8?B?SDRRcnI1Ly9IQ0x4TlBDK2JaUXNFbVAxTXN2b3ltQmVTcjVSYjh4RDVNeElJ?=
 =?utf-8?B?NlpYWUhmSEEyeFNxaTV6ODF0eFowTnNiRWZVc1ZjbW82ajY3emp0ZUtUeXhr?=
 =?utf-8?B?YS9NNkNjZGFLeGNMcHErZm12RUtmMHplR2xPWnFseVBzNHRLQTZuODJMTk5O?=
 =?utf-8?B?TllGNzBiNWUwZlJjb0xHVDRBR011RDVwQ096TlNSVnBpTjRiUi9MSWgvaVRW?=
 =?utf-8?B?N08zLzhqZURZc0dCS2lGRDFDVktuSEdpSHV6YTgwNHErMEZCdkZuWHFRTkhk?=
 =?utf-8?B?RVdJZHc5ZDErUXRjT1doVXcrSzltWVhwellsVmE1K29JVU0yeUgyUVB1Y3hM?=
 =?utf-8?B?RVdMenZBMU9TcHZNajYzNzF6R2FObFZjeC9neFdGR1lEL3hPT0xYNEFPMXNF?=
 =?utf-8?B?NWNlbWlVT3FCVDFSczQySmdrMlc2WWdFNlUxY21yRHhWSlprMHlPektybURO?=
 =?utf-8?B?Z1o3U0prVWYwT3NKa2xpdThlL0pGaGxhbXRjMHoycmpyb1MrNTEyVnIwSlV2?=
 =?utf-8?B?aUMyOVZEUnBsRi85SVkxcG80Tys4ZXhNamVONzRCaDlZVDJkamp5bThxNzNp?=
 =?utf-8?B?Y2IyTm1VeW1EOHMrYUxSWFZ1QWdnb0MxbGcxN3U0dmZDNk1YVEl2VzJyb1di?=
 =?utf-8?B?RnQzZVlyeG5DcGJHY1ZFc0l6STR6ck5yTmFxQUdQVXY4OVloeCtLbkxPK2pI?=
 =?utf-8?B?bkluV2JMMExnV1hMRnBnSlhqRnpYY091Mk5COCtyOUxjZnJYVDhhSWh2VlB6?=
 =?utf-8?B?RUwyQU9BV3haRDY2R0R1ank5RXVZVEpvUGZEdDk3R3hrWXNRbmNWOEZybUdh?=
 =?utf-8?B?QTAzdEFjeXZZMjJLUlFTVVNmZjloZGkycHlmZzVNUlVoTXBEVDVwL3NYNUV1?=
 =?utf-8?B?WVUycUc4QmRrZFd3YzdGMHJaRkovY3h1Z2RYNElzNlN3Y1phaTNpQ3kwR2Fa?=
 =?utf-8?B?VzZka1dYMkdMaSs3RzJUSlhmOE9obGNFaUdpTDlvQk4rWkhmeEJ6NGR2VTBh?=
 =?utf-8?B?OTJJV3dCUkk0QmtYUW1yK1l2Sm9yZmlGVVJoTG5PNG9Ra0dQdVZjelRXSHdy?=
 =?utf-8?B?bFM4NE5GTmlrSVJmNHRGS1E0SWdvUlpYd241REk0elYvTTE5T0tFemFiWkIy?=
 =?utf-8?B?c2hpR21adlMydlRWOFQzcFMybU5PVjVZeFBpSDJwa0lzbTM1RFc1dzBuMXRO?=
 =?utf-8?B?NHpoeHlySFl3REl0S0x2OTcvL09ndE5OMkk1S3pLYW43RkhHRit3b3dKdXBu?=
 =?utf-8?B?VEtQcGpJK0Jwd1NlbjFyNE1NblRlNzZQRUcrcTJnN3ljZmJMeDZwdjVMYUNm?=
 =?utf-8?B?TlhPRmxjaS82Zmc3VVo3NzVTMTlQaXFMLytLeCtOemhIRG1PaGhQQnkzTllC?=
 =?utf-8?B?UWVxblZINmltZmZhd2NseFN5Wi9YNGdjWFV2Umc1bFVnckxmdkttOXNSbThP?=
 =?utf-8?Q?tva9pQ?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:03:52.3507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3f3533-aeea-4400-4511-08ddc4501184
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4552
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwMCBTYWx0ZWRfXyr17odJ/eazj aoaE6Xdx2OgnV+MSfSrmwvNCAmn+PiT9Duia8kasFnsGaZ10ParMErbfnf+FQnm9Z1P7wVcNwCm zP9tRQIy7QmZXhuT5ecwGRmgzYzYUPEwWtjydIOVP0Fbdn+BNOp1XN18DRXASdHXcVyJzHDfhX4
 nNtfJrByregReOisq0tjLhs6IxtQpQJgWvSsGNqMl305MVoGUJpMO/CwdgHD8bD3ckVem1XoOuZ ZK0sm+v7QStDTDndCdbcRAdg6kS31osLdw/YVJSKHski+9hKdHxo6hFyOLaERCWiKXrEiopGmDq 5I4aY5QtLDf910Qr5lyNDA1rZudXKqdCQVnMqF+58ulMh9ie2TqOvPGQ5AwNd3gTt+vqyJz/+TK 0tjPgxiy
X-Proofpoint-ORIG-GUID: P88nUpc6pUPvFm3E894hAAMNXVvJ3Z2Z
X-Authority-Analysis: v=2.4 cv=F6tXdrhN c=1 sm=1 tr=0 ts=6877790f cx=c_pps a=kx+ZUFUek9wuA+Nh1xeDsQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=L35MEKfBLXpLSl1DdtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P88nUpc6pUPvFm3E894hAAMNXVvJ3Z2Z
X-Proofpoint-Spam-Reason: safe

The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
which provides code/data which may be required by an SDCA device,
utilizes SWFT to obtain that code/data. There is a single SWFT for the
system, and SWFT can contain multiple files (information about the file
as well as its binary contents). The SWFT has a standard ACPI Descriptor
Table Header, followed by SoundWire File definitions as described in
Discovery and Configuration (DisCo) Specification for SoundWire®

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
v2: Removed Change-Id line
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


