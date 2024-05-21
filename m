Return-Path: <linux-acpi+bounces-5922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FD8CB525
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA192822E7
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E414A60D;
	Tue, 21 May 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gXnj9HQD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA6149E1A;
	Tue, 21 May 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325862; cv=fail; b=quHub9Uo2hYYrdRrh6B+cd1HsGiFkm1h8WCh2UOML16taKZ2RxzzFEmbOfNe/WzjszAsco1HWT+br2/yvHKkHE3GSOlvhIEv9Pe1trZmdr0BtCtfwJLSJ6uamMxzBJXyeZCSCO18xtfJ29/XY/VaTsZOb44+XgkvBEbRJBXCRps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325862; c=relaxed/simple;
	bh=KdYbHmPQn0r5IN9g+9D4d/3Z4D3B2WoLS6s2/FqktYs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZSQIQFT5JJYEc5egSyob+Yk9czUybOn/0Ebyrb8r4NSBsh1khiYwDRnXf9m/zW2fNsENmgQoQTjnh5HVeF260jxQJ6CcyPzlof+DuvLPqPqTUzyTasJjeFaj4Ttb2j7fm6a2A8R1soTZ4Hg86fWECqopi/hvzU3JZ5iBzCJC/sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gXnj9HQD; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCAyIKefq6VBellcxFZQWTAZhEz1g9VGMHpaRSs3dod6V4vnYwen2NhLyC/jfAqJfGLi4V+5naXTiC/31ca0exNztfpLHD8MpYmof3UnafVhhdK4z894HWxxFvcpCHbe5kLlbkWRMJj6EE5oWQEUso5Xv5hD+DjtJwBmyy9QDhFfFckF3EtQ0TS6yMAr5glc7x7wEmjiiWYc7em+IDhqxzDqHK/5k/WpImjcNyQnDv1IB4H1YhkZjr6J7DZyg/eHmz/ekgRYxjn4X0xnUYp3PfYghAoREaB3R77cL+jvGM6CpcgHBQm482AKXcFZztItZ68aj+ki1kg35suHcs4pBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paywM29wLpewYuxgXs7op7rkpL3ktbDNrtpblXwJ0nc=;
 b=fvRpUpyplWaasrhTZ3d3s4DURn9SVX1EynRm5LCbQtNNft523QjgoVT4FIbGLBZcepx8LR0Pruf0rIHgZT0+6SxQhFEFFO9rQJokjoa4QPItJ4ULi4K06DmeUuq+mWrDsLfQgMHq1w+gKm+p5XCSDo12uR0/0WZESD1yTVNdg0RFD+KTrVpQP9ToiLm08uLSe1wWK2YRlfAqQxLTi6zzidhWJRsByeVxPFc7uxmhaxw4eiR4nIcVeSSZuzIVfClxD3A1j2P0RTNWIz+uGwDU47Jr8QiR6zC03P9MWZ9d8kVpvbsGd32A4Z0ReXCxh8Y+ixPvNeY9IlreIHYSXsvUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paywM29wLpewYuxgXs7op7rkpL3ktbDNrtpblXwJ0nc=;
 b=gXnj9HQDpbvmG5U9L1bBJcOvHiLgFp14psqu87TPir3rB2Mj1Y6n799VxMJium+qKD3uOpdJuCf1USDnUqLULgHyTmeMC5aJs/zU4gEfAx50ohx0jndATjxlzW3wzrqSRIyFdhGsAtW5+sh+n1tAnLwFo5v+l+QxdkypxgJLobU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:10:55 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:10:55 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH v2 1/8] ACPICA: Update values to hex to follow ACPI specs
Date: Tue, 21 May 2024 14:10:29 -0700
Message-Id: <20240521211036.227674-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW6PR01MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f185f3-a499-4057-d298-08dc79da8130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZcZDtA+LI2i4sicReQMHXSuyblrK7tKNLmeHoBCiXjhtQbXO1d8bg/VMW++A?=
 =?us-ascii?Q?8kYDCNl3syHqRlVdesq4DpSnW2pDmrfsK2fC6gEIxekqYrwvDxcdXd7tjn+g?=
 =?us-ascii?Q?64m8tLJpvgaq4AxqPbH8sg7XS0D8LctNt7GwpcsPnnIWV8yaWyF2+Cs72Z8X?=
 =?us-ascii?Q?PPmDa3ZmCgbk+MZ+rJkGBNbLPUXwbfipvZ8D0vLwE38x6sJQyVfa/JL9dJT4?=
 =?us-ascii?Q?rSC2VdxzPclgaRrMeLNe49TfH7m9Kw4MdkgNiPVW70CT7c0zyNKsI3nx37aa?=
 =?us-ascii?Q?AzZy7DPbwurfypCoj+yyqFAQ4fkNTRmZHlddZ9llakW9+KOU2RFlLqf6pDsG?=
 =?us-ascii?Q?KTledyxXpC8Y1c2y6Zj8M7OigqOwgFbBkYJbKRyN22b2iEE5UBQ9KyGMq8Nq?=
 =?us-ascii?Q?0ROQmbMali047r+3ioGUbg/+q+k3jD0bawHSb/Dpd/912SdpMxIWtUgtY6ku?=
 =?us-ascii?Q?CDFKoRV5JTOvlYM/T39MwIpxcygb5zYcn+uTJ3dS/9TVZ0JR70rzWRBBlRiV?=
 =?us-ascii?Q?DlfZQ1giN44epp8zor8GxyKvRE6/n7dUHtCajuGVhfhnAudDO+5Z/K4+r2kr?=
 =?us-ascii?Q?pRaRDvnwfzMFoew9H7Mo+Bt0GHjqZYD1mKnmV8lODP0VzCB/1WM2qJDGhSG8?=
 =?us-ascii?Q?z28S8AJ0PhPCDpbpyB9LVx3VDYepZ5EVfrJrY9l7IA4xaU5JTr3rEXkEsPoB?=
 =?us-ascii?Q?Xb1dnx2jODsIKFxjoUhCa7X/fMGEHU4JE8OJa/8wrARjoHUvFR7D/Z8MneqC?=
 =?us-ascii?Q?cT3Xk6d9xRI1ex1lFJWPQs1AbY//A9HsDxEW2t0aS477U/ytqhkBkLHOL5io?=
 =?us-ascii?Q?kkXmuJJTyf32ydDAcX8QwRHjUCN+1AWp8ejzjLHyr/GzXb5iPaJu5qQmsBfV?=
 =?us-ascii?Q?WJTrsqnS0xtNMCJOUlc9e7C47rSUsoWllopMVuCX70QFvv2Gvn9FYxLw/Ppi?=
 =?us-ascii?Q?jOnyHTGsC99N0mW+5e2gXkw9ZfBN+mnu80WRlxKNwOPqUK+Z9hzd/ykq6YVw?=
 =?us-ascii?Q?Ol7SG2QJlcFCwvoZ9leR+63sjScpi6qTiOhRPybKxknWdyRo81xoApGvCz8Q?=
 =?us-ascii?Q?d37osbHtsMrabPguayeJ3x1Q2BcWfmAT9zXzufzuPVK57OhCXi8w+N7OZ0gb?=
 =?us-ascii?Q?K+xzu5Ejj5BtdTQbXkykcFHVdGY7vnr2DZdkL43TA2KnP0tdwxf4cc0Yw09A?=
 =?us-ascii?Q?SFXqQBQGy0m9aeE7AFodVJcDjVi0QH/fSiJlNR+zKsrcEetRyWhtABWvcgi/?=
 =?us-ascii?Q?539oQYoAQcdMH9gqA3qmvFpW8M2MwA81hucGZaFcctJCuSjVB4IVw3kRmqdN?=
 =?us-ascii?Q?XWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4vmszBxHLzl4xs0c0Nb2/T8YdkJfl5vBrznPNhOsTyfJT964OoD+zAqCcjT?=
 =?us-ascii?Q?ct3sknTINLFwgeAl9Ss6U7QRhP+b5J4TmvO9EMxv+HeNeBBZjGYiQAKXB/3G?=
 =?us-ascii?Q?D5g+qd7eyrfK7W+sINVkEyQrB4BtV2VWVM4QuNySe58/WDw85PxAQjDcjGHS?=
 =?us-ascii?Q?IxcpLgOuiEf1umCf16uZt8XTVUtPwOkf9z4Yw7XXKnj4KENYALvXcW6kUyQp?=
 =?us-ascii?Q?SQM50OjH6hocdB04v75cpFbbD4KeIqcdtf2pUW3KiNzyrPD3IeJ53DDUhf68?=
 =?us-ascii?Q?r4eAR5lESGeZ5qW2kGQjt2qF/LH89rCUkkD4QMB3hQ+QT5iNAlxva73FX7LQ?=
 =?us-ascii?Q?8WxU072bScsEe/ejjVpBuq0ZU8VFt6xpP+wP4erTjGJKHVm3I5ThRfMjxcEd?=
 =?us-ascii?Q?svv+LmT9uaBzbvqbMKHTIcQF1x1a9HVQVetEivceC2ZwTLcj8kFCZKtEdPYR?=
 =?us-ascii?Q?9HUjOyZ/7ZAi9vaiMyqX4TOb9OGipqwuyVi1mGFWakJOZk6uLVH8UIaLIK20?=
 =?us-ascii?Q?LAAdZrryMw0KehowuGNMVAf+3Gt0b1t3gN6IqnnlpVtSsFGHmvD2xIh6oRcp?=
 =?us-ascii?Q?YPWkEdw818i9LuFVzkVOL5Qi7lqAY19k7czEAxqbez1Jf69JRJgHYbW2NrNq?=
 =?us-ascii?Q?A59Az0e6e3bh4Dp06P/eQe8i2Rd+wXxjkE7cm/1NCKtvXqsE+ffd1VIUcez0?=
 =?us-ascii?Q?Jb5EK31K55RkqSSGC7zT5UPPev78MTpgEv+Dzwz9KtucnZBGAk1DX7L1k93o?=
 =?us-ascii?Q?s5uvrcCdRqSh4ilUKZBl48gYOmN1iVb1f5wE17L8SM1IrxZJoRRVuxWuBUEB?=
 =?us-ascii?Q?LJyXgl3OHAjTm+JhPaW24lHeOqi5cQRQGzT4O4MYS5naAIndWvmbp5dy2ieS?=
 =?us-ascii?Q?GNGO9PwKbkIBbdjIcsMsIa/nuZv+dKjWhZqoXkErmzdrjKMCrPlaPo3E/SjC?=
 =?us-ascii?Q?VBQjW7BoObni9X+dDKIqu9Fn5Hg6htod5uOsZsygcvtiQoBRiF0jJSX2tQ06?=
 =?us-ascii?Q?/y/5SPu9jZK1WofLjViRFLd2BvnwKDDhdSBTC+77JimrwNGoJcOcmnrVVmZh?=
 =?us-ascii?Q?AloDEc7wZknyH8OOVK2j0XQWcxJWRTdv4me/JviSQUCXeVCr/ZyX9W1LnPBi?=
 =?us-ascii?Q?yQ1DBI7w2nePaExz/LSFHYcYWjS5fiGirRdMPjz1fvZiYbUbPCGCs0XjADXg?=
 =?us-ascii?Q?pmNLt+pKp+3P54e0Se7xWowiD6G2wyRHUmEhYmhEAqwG35wJa5ErTSZOkUQb?=
 =?us-ascii?Q?gh9IdgiMoIuAGS6dkYf8CB2wB5PyJz/xNOZ9ElXsuGVmZ/MCqMPfBHsiEeB1?=
 =?us-ascii?Q?9PO/rL4acBhg2Ia/Hq8kddzNgnuftEAxRV4Ryd3HDt+8H4q+z/KB6Vgdcx7A?=
 =?us-ascii?Q?WKUvL0BsvRIcwObYQxBooJcUlLVivyPBC5xl0kAhztR2cfeEk3Oi222dtsSu?=
 =?us-ascii?Q?LIS51f09N8beWi5V202863mewfVRHJINbCh+8vCgjIGfDl4mLhxSguget2W+?=
 =?us-ascii?Q?UP1fIJC50xlp9GC2tFBSfwOVLKTJeNQFvUnNsXE4vvLLf2owB1LR46Oyo/3l?=
 =?us-ascii?Q?LXrnljotR72X9RMtXR7S4XKOMCPoJx2fxnP+1J2gUVG4MP72qAvos5x4eqg8?=
 =?us-ascii?Q?Gap2rZF2mstGb/wjV8ZEmCo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f185f3-a499-4057-d298-08dc79da8130
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:10:55.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBdjdUf1j/balEDDIj6Ze1OdC+3zQAjIUjZ8iT+ynYpW+lqwWFhI9+rGaS+mZKUxKJiqWCnOjjMPFe9hvVdJsvp1NykfS41msP94MNPW+wpg7OeqkAJl56occlDTYhh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project(2).

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
(2) https://lore.kernel.org/acpica-devel/20240514184150.6285-1-zaidal@os.amperecomputing.com/

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 841ef9f22795..b321d481b09a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1017,18 +1017,18 @@ struct acpi_einj_entry {
 /* Values for Action field above */
 
 enum acpi_einj_actions {
-	ACPI_EINJ_BEGIN_OPERATION = 0,
-	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
-	ACPI_EINJ_SET_ERROR_TYPE = 2,
-	ACPI_EINJ_GET_ERROR_TYPE = 3,
-	ACPI_EINJ_END_OPERATION = 4,
-	ACPI_EINJ_EXECUTE_OPERATION = 5,
-	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
-	ACPI_EINJ_GET_COMMAND_STATUS = 7,
-	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
-	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
+	ACPI_EINJ_BEGIN_OPERATION =		0x0,
+	ACPI_EINJ_GET_TRIGGER_TABLE =		0x1,
+	ACPI_EINJ_SET_ERROR_TYPE =		0x2,
+	ACPI_EINJ_GET_ERROR_TYPE =		0x3,
+	ACPI_EINJ_END_OPERATION =		0x4,
+	ACPI_EINJ_EXECUTE_OPERATION =		0x5,
+	ACPI_EINJ_CHECK_BUSY_STATUS =		0x6,
+	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
+	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
+	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
+	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
 /* Values for Instruction field above */
-- 
2.34.1


