Return-Path: <linux-acpi+bounces-15181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21164B0725A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 11:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B93188BAE8
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859A2F2356;
	Wed, 16 Jul 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OeIvOA+z";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cApO2Sil"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB82F1FED;
	Wed, 16 Jul 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659985; cv=fail; b=VOxYShERf7XDScrdQIolT5piU8WaIilb5k8MIz2VnW8fSvLDbY6shEifvx4gFTm+QIoy4/ewbuaddu+KoQoHC1wmBpfWfddkyir+RcINz+wA0B7AglvKeodJRXCHaqE+wVPkaKn01XagyxGJjBMvL4ee3OUK/HvJCx2GJsXHOak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659985; c=relaxed/simple;
	bh=TUTujC9YoXusuNOmys0dWw9YqkLtWr5LQM+AhZqqHTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buTklSEwKndhponC2Bss8wim9Oz5szbsSxBfO9MNT/elgzmK0aORcxgDs+fw1YJCG38SeyvLcdS87Dn/7jDxuhKPP8cq2Dgyus7vaY/4cRZjEgwqmuigtPB2aMvlNZo6EwxJFx73a2mL6WvnTw9+zBqEwzglezxA3uex5HLnRNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=OeIvOA+z; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cApO2Sil; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G4UV1M029353;
	Wed, 16 Jul 2025 04:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=TUTujC9YoXusuNOmys0dWw9YqkLtWr5LQM+AhZqqHTY=; b=
	OeIvOA+zullZbsIWA7S/2mJ/qGvYlvgeCzRPvpuQve07LeMiN2ZGHFpAsf8UF1Ue
	tDwuebclrSYLfblzEAeGvmO/i2m+e/XboXc9QoRC3UBmzdf/my5zRTWlhCP3eTB1
	ewv2kJ+4XzNGCImE2796eQKl1SJG4ynmkbUTBqUuo7rNsVHjOJWLHVt6NyIOUMdM
	UZqWCsTqyuZbgq/M8LNWe5CL5VezZdPAAo0b1vXc6HU2tZrUj+ms9PuHF/0eoa9e
	VtVuqie+6UXEGq+Urb7nv+ep9fHDLPYFaGILs5+RDCHBUQ6OOd6f+tuiQK4A7gsl
	odEKagl2B+gxxkEp/op4DA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47un42detv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 04:59:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrRN5ccTG2n0rlpAHzisl5Xy4L1yAKnbl2oPeh8dYh15VBCAq7FBNFjAki8r50uVk3OnkUfFFa2F5Qfmon6uddHtmSbuNZH/WbbQCyHU917zYdmhDhmkG34UfXYplzLFXfKlnlVQuJiM9ZWr42tRstTSVVH7JjZDW/Csmyk1MrV2H5rijCNsxmYL7Xv0xFH7J97yKygeLCRh/akdnvpWmjQPbpPFWFA0WGki1bjVSbsBTa3MdlT5V0OHb9RWdxNpvH9a/sCfPz7oYhCYGaotfajZ+5MPVsHCIZp/Io3DVkWdidNv3ETUBOYquYqGVBVmjq83871uwdDoliGNzjXiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUTujC9YoXusuNOmys0dWw9YqkLtWr5LQM+AhZqqHTY=;
 b=hStSqv93EMq/gNg5f1kuPkUM4csCDx9bcnb9GnJpiX1FBGo5cAc6ZxTtB53hs6dblWPavGnN8J3gmKjvRlDdg5Y794z9YgvwW+o7ORk5G89rlHKyubVdtv4hCITU60w57jG63Umq/IcMIoMZ2dPsPtV9Jdvv5Guy/9t6QRLh6Ub4BN9Z0AWDtL+fQMQfXQd8XekT3cQnxaJtqEh07YPoXckPavToqUie7k19eSm1JEwbPWYgGLdfPvsbUa9xbNjsVBy/k21r75A0br51NhyOMn+SB7Arr6DFbuk7F0hIEMdLCWEEPcjxF3mXCdFo6lnHUdApyVmUqPq90f23jtpOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=intel.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUTujC9YoXusuNOmys0dWw9YqkLtWr5LQM+AhZqqHTY=;
 b=cApO2Sil7Ca+Cc9ozD8WL0VvoyhCQ8fND18CzrQll2uKW68r2hUFfbNX7WR+2DuRT5Uh/15Z+j9X9+KR6VMkZGkSd90TKxMqT7p67gh/yfBcvCca5hO2iZcGpcrUb2wiBu/aYuQCK/J9huuMIlHdhOPmiW7qwDlTHypYqpe6he0=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by CH4PR19MB8586.namprd19.prod.outlook.com (2603:10b6:610:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:59:34 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::74) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Wed,
 16 Jul 2025 09:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 16 Jul 2025 09:59:32 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5C724406540;
	Wed, 16 Jul 2025 09:59:31 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 525B1820249;
	Wed, 16 Jul 2025 09:59:31 +0000 (UTC)
Message-ID: <b805f0caec2c9a5617252cf3b44eea3adef33c3b.camel@opensource.cirrus.com>
Subject: Re: [PATCH] ACPICA: Add SoundWire File Table (SWFT) signature
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linux.dev
Date: Wed, 16 Jul 2025 09:59:31 +0000
In-Reply-To: <20250716094614.572352-1-mstrozek@opensource.cirrus.com>
References: <20250716094614.572352-1-mstrozek@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH4PR19MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b23769a-7fb9-478f-db5e-08ddc44f76d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGZ4Mi81eXk3V3RIN0VmM3RsMVZqMklFM3YrVUZHdmFORzh5UUtmWUVoN2Zy?=
 =?utf-8?B?WllZQ0FiVGdhUWY1YnJJR1VNZjhRYzI5MENnREV4b2RjMlRrb1JCanNEdEE3?=
 =?utf-8?B?OTMzQkc1YkwrV3pHbi9icmpjMmxjWXZXc1FtR0RzejB4ZUlROS9EVzdyNTVo?=
 =?utf-8?B?eExFSWJPZ0YwNzlwTWJHUzRUdmJRSk1Cd0ZLbm5SSnVmSlRQTVBDZHB0bG9P?=
 =?utf-8?B?d05LWXhwVHdSNVNnM0dmZUs5TDk0cCttYWRkTkxtOXprOFJhcWtncjR1QVAy?=
 =?utf-8?B?VksraG5CbjVWbWUwSGpGSUNLZmtUdGRVT0V5OHFONHFMM0NtQlZndEFrRGU4?=
 =?utf-8?B?aDJWa3pGRXZFNUJSV3E5Zkg3QmJGVi8yNTNQTGNLd2d2UklaK1NEVTdFYUtn?=
 =?utf-8?B?d1JETTdHWDJxR2ZWNzA1elJIRWtJeDlqbWR6RkdmMzA4QVZEdElVTEdUMGtB?=
 =?utf-8?B?Z1ExaHlaQnNDRTBSRnc5VHlJTVRxeEFQQzFXckdzKzFGVEhqRDJzc2JwZVpR?=
 =?utf-8?B?WU0zOG5XQThkdm1vNDliWEJaYWk5MldhMDloWmtJY3dEQTFqbHMwbjZ1WWVq?=
 =?utf-8?B?NEhRTXk0d0crYnY0ZEdtU0Y4OEExNUp1aElLT3dUMTBuQU45TTR2RVUwbHoy?=
 =?utf-8?B?Vy9lRWdLK1YzMTN1TmYyczByOUxUSkVSZTV2bGpsb2NheHpwZkFTejByeTdh?=
 =?utf-8?B?Zkd3dFJ2a1QyK3NyWDFQOUJLZytBaHdhVG5NN1NweVREWVVJMTNtekZEUkcv?=
 =?utf-8?B?aW5PcmlWS0htL0IwR0lROERYUUpLaDBDOVRSeStLbTdmT1MyUDZwUEkrbzlI?=
 =?utf-8?B?QWUzMENDWEgrZlVmcXI3UVhTVjhYcDhXNkFIVkJBb3BaalkzK1REZ21ITktO?=
 =?utf-8?B?TitTQU02QjNLbTRxSVZmck5neTlTOTk3Z09GWGRzOVBSSHhSSmR1Uy95VDgx?=
 =?utf-8?B?U29RRnFMclErUEhObGpybXNyT1NHUk5WSXNjaDV2VEIzRXZaVCtCMFFWbXBr?=
 =?utf-8?B?MG1mOGJGSGloM2o5ZXdLdHRjQ3pCbnUyWjdDUjE2MnBTMHoxQzJQR2tZamVX?=
 =?utf-8?B?SDRMYTlhRHpVUm1aeUc2TkVrSDBWRlR6N0hlL0xqWFcxaG95RklqTmExQklY?=
 =?utf-8?B?Z2s4OWxoSmRTWk5Ic1pXUGxjVE9sYzBPcVJKZWpEU2N5QWsvdUt3OWpIS1h2?=
 =?utf-8?B?eXpHS3A3M3BvRUZsNStBQzhRQ1lCbVJRbzJqYWhvVXdvaGJWSmpPWUUvbU9o?=
 =?utf-8?B?QWxWUGY3NXVxZ2MvNXB6QkoxMVhKVXVYWEVpK2toQU41YkFyb3VESHBJbVJv?=
 =?utf-8?B?WGJNV1dIWFFWeUtKY3VCNGJ6eldGTzBjUjhYZEdGbU5vQXZTaGZScnNvc000?=
 =?utf-8?B?ZWZ6VHlEWmlZWlErTEtuY2IrS0g0dFRwN2lkd1V4TFcvZnd5eml5bEM0cWdE?=
 =?utf-8?B?MFhGak1MODNsTXZkMjUwa1JuSmRrZHlKR2djZ0RPVUxLc0JwcnZnRFFVdUd1?=
 =?utf-8?B?d3ZidkMyMWZTUlZOdENndEdGOVVYZTU5WC9FRVVjWU9kVUpOYVlDSCtPVkxV?=
 =?utf-8?B?Qm5HYmVJWjF5dXFvSFBsNFh1cGkxamJPYjJ3dU1VVzB4V3NYREc4dWlhbHBh?=
 =?utf-8?B?MHR5UkExUmk1UUk5WDdnZnY3azdiSHZ0UU1rSk9iZWJ3Z2lZSkltMjU4RXJ5?=
 =?utf-8?B?MDJ1Slkrd0llYzVTcGtqWUl6UDR6VHpsRE9FcE5zb1phS3BaZmgrVHQyb21N?=
 =?utf-8?B?K2JiWmM1YzhLaGd6WWdYOURIT3RzRmoycXd1amRRdU83N1g3by9palRXelBU?=
 =?utf-8?B?aEdsa3oyT2NTQnFOdFhxTFFIdW9SbndDcGpNQkphOHZQRmVOTjIwbFFZcU1B?=
 =?utf-8?B?N00zSE9QbmdydHRlTjF4T0RHay9pVURYQVlXalM0MlpXaEFpMnhzQWxZdlBB?=
 =?utf-8?B?ck8rSUMzOFZIR0oyVm5yRnJkL0E1enVIS1QvMUhUczRIK05UdHEraGRiRDBa?=
 =?utf-8?B?c1ZxRnRYQXlzUGxpQ05neHdSZlorc1daUkVmbXlIVXJXTml0TmlCVTNoMHlX?=
 =?utf-8?Q?LpRtSD?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:59:32.8616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b23769a-7fb9-478f-db5e-08ddc44f76d4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8586
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwMCBTYWx0ZWRfXy5vH89GpIqFG Kc3KFokSK3dLF3lG/z1EsjNHKBhYT1qvAHbeTgEHpbXUzgQIKqyy1gBDQJE2KG0rgjOJRfk/Fpb CS0t68WE9+qc+CL2wmqmrCjnsUJ8dNvCRHi6Ff8yaEFnmDl8bpbut4bCgwsE9TPlEPsre2VfLqe
 etT0uP5buu3i5+AU4ChvD0w+KdU5nYwussEWqhwnO3njdS44VACNQMhIjbUotaC746Y/K6R93LM T6h/UG2X5EIu6zCO84CyPtRcynUei5k7T1cGzXYDrsrBhILWPQ+D7YJmk2AvMgkiwv2nKzXl4DB LAIL18L8/hoshSpYDplAp2kjBwDej84xBn3c2ovPXBiF5AC7Yk7/k8jB3GgElslaAwFhVPI0Nt/ jZqY9UEm
X-Proofpoint-ORIG-GUID: 919KVFQirt1J07TKkwTKiPF4viLCsgkf
X-Authority-Analysis: v=2.4 cv=F6tXdrhN c=1 sm=1 tr=0 ts=6877780b cx=c_pps a=skVBa3wrE/bKtdGVm523gw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=nJBZgc41CmtpPgmkB3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 919KVFQirt1J07TKkwTKiPF4viLCsgkf
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu =C5=9Bro, 16.07.2025 o=C2=A0godzinie 10=E2=88=B646=E2=80=89+010=
0, u=C5=BCytkownik Maciej
Strozek napisa=C5=82:
> The File Download (FDL) process of SoundWire Class Audio (SDCA)
> driver,
> which provides code/data which may be required by an SDCA device,
> utilizes SWFT to obtain that code/data. There is a single SWFT for
> the
> system, and SWFT can contain multiple files (information about the
> file
> as well as its binary contents). The SWFT has a standard ACPI
> Descriptor
> Table Header, followed by SoundWire File definitions as described in
> Discovery and Configuration (DisCo) Specification for SoundWire=C2=AE
>=20
> Change-Id: I76429d14262fd44a5e21b24b18fbc5b5ffd24cbb
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
Apologies, left the change-id in, going to send v2 with it removed
--=20
Regards,
Maciej

