Return-Path: <linux-acpi+bounces-11910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3306A55B0C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49AF17686A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2A27D779;
	Thu,  6 Mar 2025 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AvjrA5o0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589E20011E;
	Thu,  6 Mar 2025 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304924; cv=fail; b=FB6zZs6xolqStAWaVYzt/cRgzyfon3q2qsjcmZBqxPdZEVKR7CAHy7gGa2s9EeTLzEj/wreoqUrEj9tZd7tvczv3Mo2EBF18/0768ZH7e650GAbG7yBiKnu73k9vl93izUaGx6hgiWKr1LX55/SVO6QrleHp0nWlM10LVHFcGLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304924; c=relaxed/simple;
	bh=ucY0Ju+xpNr/U4kg/gaL6BWoynWjZ2I9o52Oos/7m/8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZkvMgNoy+WSw7Op1jexlit2920t4TsJAypVNhsgB2l61JLKd5tlSkAbgtBEMMvIYyzCha2qQF5pfbybPFyWGeioMauLJWFBsN7FbMLMjMlkC+SbJxjZG1YtpjdLqrhZM9jS7/DpUrLcd9vFiVTX52iZfyWpPTd48wtMHlt7oRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AvjrA5o0; arc=fail smtp.client-ip=40.107.223.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wysLK+pTnwo6ygfkQmZfR4nbRFq6svf8eOAQhSA1D6OztO/BKWnTcUX0wVOxYXql0cM9M1VRQN6jhDnvd+v2SGz84R6IO2lFKvuszOsSmGTdRJ10JMK3UpaOEavLLTt8kgSCr7hM/dJOQSBNuO1pq0GyE3IQdjZ6M9dOze5CelpmDGN8YbNuhZz05yQsKvng9mMhxaqy2X41ApDjPrVomfPX5fBooLdE5fbnmXJY9YFuOeqOFUlxLlr5l3zoxRAL1S/V8cJ9Ddp/6U4Es/Tqq478An6eYu5DcqaAo0D83T4eQcq+4ECuwdhJrvj/8jvmnjYxmof83a1avBES+sYYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCuFo4f7qdUomRQ92oGUPLNqbhWCEnREm/RLCFQQzlM=;
 b=ucxpA/26ZPMi5tuFgzxqP6ZuTTWSk1RmDoc+bfFrLjb5fjdOLxGqs/nJORqXn/lrw7KI2DfCWg8zNlF96O6MTa9yTThaaAZgUPx5JNiavzBIIHyzOYZYD1vI8Q6zHN3pyz/ICqlVD8pnX9SmHOuwv8zQe8Ykqpiyw4WyRorJKwjqo82Xyd7decd+H6IdOIN/iMrlnwrBgzZXIHCxX0EGd+PI19LFl7WBZaM3Me7p63pC14NlwdvWfo73hMWpDA1fDSXoeRf/s5L9zQLYEqcu0cHSx/1nTlxW3g8mSL+ZE4NC2MNnrOZKoqH7A388fsW/7fbzdAYNUahsx3Voi/XVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCuFo4f7qdUomRQ92oGUPLNqbhWCEnREm/RLCFQQzlM=;
 b=AvjrA5o0y00XFwRTYk6JqEqUI8ZGresC602i0O7zhVjvtet+uD7XP026MgxtBfyAoq4UgJCAgW87DKN7TJWGI7v2udCZ6GY9rEZBSf+wf+DfwFJX31DVY/6Jgw+L6Ra8eoJNZ0dA9/WIFXsc6poG6R+TwNRx5nbhJYMoNDTShb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:38 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:38 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	dan.j.williams@intel.com,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk,
	arnd@arndb.de,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 1/9] ACPICA: Update values to hex to follow ACPI specs
Date: Thu,  6 Mar 2025 15:48:02 -0800
Message-Id: <20250306234810.75511-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: adb553b9-b7de-40de-e61c-08dd5d096ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMuLglIURWIQDO+yTv8t/ybXRX6WDc5CrED9+TmpWsyv0x5WNk80f7L9BzKJ?=
 =?us-ascii?Q?HNe6FDWgkgZhsYVAsgxG3ghc4oKQMCngtj/Rgrio2QkqeFQdCnF3CNn7++zp?=
 =?us-ascii?Q?HHI1F7PZALa/eC3MIEZv6LCXYK6meyPASQ+gVAtN8PD5fZfoVZQbWMz47Oc1?=
 =?us-ascii?Q?8Ee0MdrroQWAuSR78nA3OjxuP1DzbSydAUFFxEDOnVI8VBEbEB3sTvcFnFjL?=
 =?us-ascii?Q?WZ4OVFM2/uHJMmhXD083g/SuqvVBdMqCF5iLQ/fENsSWlcJaAlm9KWW4/zPB?=
 =?us-ascii?Q?PV1rLXDgi81DqL4W14IsvYpKG0Bue3C3Es8uggR9sEPSPu2smnY8v11w3myt?=
 =?us-ascii?Q?B/23n9WrqZiFK4SnDzwM4+IQlSqNP2e++ouJDbQ/Yov6Kr1TSJS1blIh4gZm?=
 =?us-ascii?Q?2dWqES824QY3S1djmX6ycdsPLJs4Ako4G1/GM6mfq++uuhMHNyfApkIh6vAo?=
 =?us-ascii?Q?hs+e1dcXwduxBjyDqfKMpmv7Hy5Ot28rcoTV8eZvNg75DymhlAWdc3W8eVER?=
 =?us-ascii?Q?czqc3fXL3ZeEw5YhVwS8H209ZVKjHPBCrPJ6LfHnKvfqLRIY4GyPbA2Hxjpg?=
 =?us-ascii?Q?cvVEkdwFNbn4p/kXhcwBnbrznC3eCmyX4vp5FId2ytKQRChE5gqJ+P8+QaSl?=
 =?us-ascii?Q?PGgSHIG2NfqpT/tk8G+cx6hAN4L/RpWazXJS3liafMLHGbD3J5BdRGqsgAi6?=
 =?us-ascii?Q?jQUNYX/lJfcDBULU06xekP70Z/GlFvW9g/FT3DSuBBkojb9MNtA2cZE0t5fP?=
 =?us-ascii?Q?LkGZlWmtoSuDp/hPByZK/Aa3FSEHdl/DliJbrnq+xL6A35k2mIRvLzJg6xuF?=
 =?us-ascii?Q?LCDuL1PU6kiazxmoUjbanP4XAeaD+qiVC7eOPl6NLJxgpiBTIrXoIeZM2Cbb?=
 =?us-ascii?Q?U9qZJEVl6L5otaZUI1USq8ksW52rKlAJ18NheBZ7vGjjggL9JaB1Mt1o2TBH?=
 =?us-ascii?Q?zKnMdwT7eF37vVJHO9R2gg7spkqL3WSWJTqoLGtCNH8qzLNNQAkl0vX0/KaI?=
 =?us-ascii?Q?o0jr2/X4bN+2Af/s8yN6qa7FLBeBPHcX5N4YEPHkmE+EMBjTlPZ/mpDascy3?=
 =?us-ascii?Q?VnIJbIW44YLvxR68VMx5mtHBoiTAElaSTJ/FlerpyilmhTksSp2UltZr3d/i?=
 =?us-ascii?Q?MjLdxuTfkCYAsZrcsTYGGkZaCftCArrsfnY+Db1AzVdkEkiwuhpMMBWQ8RaN?=
 =?us-ascii?Q?hgBSm3Yj0YLJwHkaDbX00h8esW4N4MaooqG0lscmCuXDu80VCvPH1rom48fr?=
 =?us-ascii?Q?Aov3jXn4B3Wvzq7bXXU4i/mwEZKMtjSZJp+RXv69Kh1sB+S0BdAp6xr4Nm05?=
 =?us-ascii?Q?lf/aN6at38lnv7tp9IUVxc3F3mvXZ5HXTB+g+JSmh49st2S/s+qb5M7WAF4q?=
 =?us-ascii?Q?wHtAZNc0DhZnCqH1IZ+NPbGyNsRHDuWem5YCJTuY4qYxcuXygpx6N8d3F+G+?=
 =?us-ascii?Q?8zGFzfo8z3wUCwUSsLi/rmRwpL+sek6XGv+SytMy8Ej9a6FbMOPwKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YM/C8k45UtEVv3AKLhghXWn+Bsz2vqRwewkNPkqt0qOPNo4uMIUKBW2FVc/l?=
 =?us-ascii?Q?KOva+o8c6bRYJuOY74X3XSCKzB3Sf1//82LiIvofA9x3aQs0VravlolBll9D?=
 =?us-ascii?Q?avr2OqL0QO6OAOq3VD67hLzVdGrd2GRE8jt3hIuDFgpya6sCCQ3adu91l5XD?=
 =?us-ascii?Q?2vyV879WquP4NSY8kp2nqaGZAqFH9AMuzFrvHBFcMlsPK4Hy7jHOkMxVy+rq?=
 =?us-ascii?Q?FkWH7AQ94q3zarjaPfWVydtd+SMdBvSVEPI3ulDuRsTUAPwdyhWN8oFpIeHR?=
 =?us-ascii?Q?C6i4y3I+Vu4HlgP8nn3D2Hsperw2QTWYtRDZU1S/JM5Bmezo2yIEyolbI+K6?=
 =?us-ascii?Q?NrLI9UUaQYn1zp8E6R8C7dQtoOJEKkngZ12+eq/wHKgeRUBF2pF6siyCaDnv?=
 =?us-ascii?Q?Tp5oq4zXSBLhtIm9sLV4fTQRehUjJHnXEeoLGYXrDMu3I1n9rgNaqmMt9y8U?=
 =?us-ascii?Q?2hcNBYA2/pLBG3q9YBMG+2nQHvdcAjYzHRyM/8BI7MJZ87a519gwG7bb72HQ?=
 =?us-ascii?Q?kWFjgffIIOBzwXoqoZuMMqCf/aZEGLeQ+9TZXAIcIa+zyneQ6dQZ9vIc+eMV?=
 =?us-ascii?Q?HihGPrj6wTyg35p7Iql355al32OI0TA27pdpPp8l/GkLQ3r2YiIm+gG1EVNg?=
 =?us-ascii?Q?B0UCQijFkGPFsIhEHf3Pd928AfMJLb6cbCYDmM7fnXqtQ8DHi4sCmyT7IX2j?=
 =?us-ascii?Q?rVcKPnAh19YvTBXTwYcVJ5lmegNiO3jK7khfGvd/XunLB3RZ2RzZqunZ18c5?=
 =?us-ascii?Q?CkQiyhuSQt1+lneA7gsIRbFab75CfFqtYgEC8+LEoUBsDY3BWpH6fS0ELS+y?=
 =?us-ascii?Q?LbMzxT6i1f11JaiiquvbT7QS3EoxlUXXnkYZ+MNwhsrnI2v3Bjm/cxA4pQgi?=
 =?us-ascii?Q?El4yFgZ9fGYzmY54j22UEZzvUNGOxktobfg9i21KlzkOVFgl41uyw2Ls1NTq?=
 =?us-ascii?Q?ZLEqofyPAhR5jxLWjdmCmm6qpQKlmubKh1q/nHc/+nwqW1ONzZlW4X4Q2XLI?=
 =?us-ascii?Q?Fbg+of9pVcJm66+F4A0NHORrUDk2mNpSWD+EMtavgfqMQJy7Wi+bAyev6LZw?=
 =?us-ascii?Q?I8YeOJZpNWL6PVl0EZ46HE32wGxaHJju6dqffb42k+CyyCcHvSEqdL+gvlhF?=
 =?us-ascii?Q?MmoxB/a0KqmJsJmagH2v+zikp0zybujAiojvXZMvTE3DYYGkYaoJLl3LW9mj?=
 =?us-ascii?Q?qWVUQrRFpEaFvgQNddDAjb9XVD70jnEJMB+ltBvd5qpNMU8sZFDy3hlCd0gk?=
 =?us-ascii?Q?QGhOljo+btECsvUS93uxo6MkaWAF7VHG4sAeTptmuB3EwiBBr/Ep242WfLtf?=
 =?us-ascii?Q?lwX70cj77T9VrWCJjY0hrHTYfAY/4uARp13tCJ7k2uqUqSx6dZW1pd46VZaj?=
 =?us-ascii?Q?mGZjwXrjN7j1mG54w8nZhjoPGi5SDm6QuVPboFBRKvqRZfZdwi3hWIilI7Mb?=
 =?us-ascii?Q?akWwy/I0YSxlnf1wlTauXcyRqDq/VXZcjIbGNEuP4w/GFfLJYiptrpgr0Oa/?=
 =?us-ascii?Q?l3TUboqrKBNux+eOAdpMWxI4aboJixZIZUwyhL4jbe0UtQ4uMRzrYprVmUMi?=
 =?us-ascii?Q?vllf+Abob2O7KHaM+v1x5hEpl6m9Mjl5QyH1t7nXptoJWmd8iBV+lgP9gbg+?=
 =?us-ascii?Q?7o0M+mIiB4p3KFD9x2+CHDg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb553b9-b7de-40de-e61c-08dd5d096ae9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:38.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUk8AIbkSsOLG879Be7vrM2HPgQFu/hK1Xs5+2Pzpyw76CFYBn18ah9rtZ+c9BbBemZ72LZhueKaqiuAjiiQnDnAC/wP1g6R15kU5FUFKXayTNDllEhI60haeqgnw0aE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project see pull request(2).

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
(2) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..c701c434976c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1024,18 +1024,18 @@ struct acpi_einj_entry {
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
2.46.0


