Return-Path: <linux-acpi+bounces-9967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453129E5FEE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B41651A8
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C5F1CEE8C;
	Thu,  5 Dec 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EQQhEgfF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020128.outbound.protection.outlook.com [52.101.46.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFF1CDA1A;
	Thu,  5 Dec 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433556; cv=fail; b=HohyZSs69iCY1ReX0S8bKPQQyT/xeL/RbByNRDiWHxfaUk0khAjEC/SB5w4A8h1fMH7GdqWGyB0j+N2xdEfnlrSn/Q5OZJmDZ70DbfmR+/LOdGLYz/ipEj5/EbvsV32VJAvtHtZZLCW7LAujmsisrGDeV2f8GysaCeYeV0f43s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433556; c=relaxed/simple;
	bh=6AkT1rOWe10Psl5WnfvQe5azUxz5gOgOVcVD/Ax6CC0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eLUSRersCH1R81Yo9xLrYKH465LMOMjrLjtH73BKHUXKqoHiVWNS+SYTO4T9Lm9mA5yFUiod2AhdvILd68dYA0Kqs68URFeq61BGsQ+Fkp/UJShVIwa+iugLeJoAm3wUw283hA3h0eOb/QXdCf3qxTh2LmXvnSfnFJOSJ5b+JgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EQQhEgfF; arc=fail smtp.client-ip=52.101.46.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KutDhQ2Ketfz+oyVO9+62+NZX6yUxv5k3CcuvIn/We84dNRCCltKKUkoedQbBugZSpqGH8ZJBo/14Y6i/zDcWAK2H2SqxdLPdj7RJXiiZlBQt8BtbYeCWhKG4RAn8egfbk3iAuQU1cMBQZ4nNGB4brtj+vIV+NodusNx6T/tFepvI1hTKzX0E8fNxJzaVIBwc+Rj6zbiPehG3Dlbgkbk15AdcL539hW0Q6k+rMzQd3VhdcEejjZ4ahINfV/pPCFEVrpaGf8cE3mDguG5Cttvyz1q7x2wiR8eN6Vp0AQ87cro0XL/FbwKy6bYI9YEPa3Juv6RQQ9cNQQOyfw+wuo+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9bLQ+s2040HXPWHWkaJpuU/D6Ph+qMH9WVt6VC32hg=;
 b=gZB7dSTGNZURfy0H0LSxGs5Nb+HbwA5aU5s44mcC5dwo9VQMvN4WaRw8R0Y6bDD8y6hsktxIKonzcHgfjMK6YwhwvwVrUKY5z6hCyClPEjnHkjguhHIGIPa2KEYU4oxaOEsaT/rSOWp8POQ9KrE8rDFQ4/6+kKsbDu+qpMdoF6U7/lSqKLj+ItcJmgcUrJCBPwSaKQgQIMyEoUlxB9PamdQHbYB51WYm1uo8KUvWnoPIwPrpM1y/7Bu59l7LO9+Z0DZbqtq7StuIvziAVbbQPWdGDT1rzwjN+Eh/VqMKedaz2mLO/7WFMa7nLBomi1Wi+7I5IQua4yMSMIAgyU55GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9bLQ+s2040HXPWHWkaJpuU/D6Ph+qMH9WVt6VC32hg=;
 b=EQQhEgfFdwauUonY7Ec/lcEGRBcTpxRMiZSQn0q+Hh8Agjo+JQOeePW4lFNlqOJqRsCF3rFMP7EVFyjUisZh4k+lZDHPySCMOXsGe2/xl1mfAN4VEN22l+k8Qa3PHz0zLgEFWL0IhKervH9QwHGCYcOkaV8Pbxl7cd31MDLTCIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BY3PR01MB6625.prod.exchangelabs.com (2603:10b6:a03:36c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Thu, 5 Dec 2024 21:19:11 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:11 +0000
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
Subject: [PATCH v2 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Thu,  5 Dec 2024 13:18:49 -0800
Message-Id: <20241205211854.43215-5-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BY3PR01MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a4cdd2-d3cc-44ba-90b3-08dd15727634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0SFILjiTbnPlt9m9TsjFu0vtg27m1z5LrvGMablLl8RSTaDMFRMJvZ+Jhwp?=
 =?us-ascii?Q?BWaeADgoz7ui7khseI/lxGqfv/ZXkkJR+U2g5citrDYwlxEWGu5kSfSsuHJS?=
 =?us-ascii?Q?VAj0tPzP+3x/cEcx2jQi3/9QEpVKPiJxHN3MN21JhURoH1TGkc4QnkVTsK+a?=
 =?us-ascii?Q?NxDC6sy38the80UZWtRbwkFe1/U6EMZd3ZJmtogOyeV+VsEuY+Zd6PrPmmII?=
 =?us-ascii?Q?pAlI19TOmqpZACW4w9MBYcVttesaMWSKXgLIDeBaMg7UKK11b+THb5WadW4Q?=
 =?us-ascii?Q?6/jLa3sSPijMRYf17Pccep83fHRjLFCHyQeySLxEuKd8s4O+Ysv2Qxvxujwg?=
 =?us-ascii?Q?g1NIrz04DKgdOv/na6yhxIamJK+yffOwat6LOFFXjjCv2q1rml+/vldPpauA?=
 =?us-ascii?Q?fN1hwWlk5c+YWBmpS14+BXssYkMUurekW7JaADylEjldodGpQg8PMtMacmx0?=
 =?us-ascii?Q?+vDOcu04poNiILHtaj3X/GZzfHUbY0NWH94rBff9LQbHq7Ugs894I6CQd39h?=
 =?us-ascii?Q?RDC5W6LSr+GjdpLWwQjXP9AjlqaNiEDh7Zrb1KSqqPd+GpVZdqEimIZEMAkC?=
 =?us-ascii?Q?dncAhw6LYomSEB4r5isVYb7H4pTiDJlnDFXXSeo59swAhnhXHkWP9KwPdmAg?=
 =?us-ascii?Q?EK8OcyINUp6M/j//PB2kMFPzaGZcDjVs9vZNDr3sgrgMwHyPGqnEFCp2Je9J?=
 =?us-ascii?Q?r/s8kdHkkrB+qipu0BScOEmr8DtV91/h4/fgC6AF27tvOWj4fcC5ZtbJnT4c?=
 =?us-ascii?Q?3tEexVSVTcRxhDL6UNIjFZOhklAic0YxWLki64IqF9tJV9mEYnCnhFDX01sI?=
 =?us-ascii?Q?Ky5cACjqpJeYeSp3OqdczqBuYk+7eQm7jO9194Hj+Fbo6rIRvxiLlUQ6dsvg?=
 =?us-ascii?Q?GrLpx6DwPRtTBE+TLnfLuMbbTIbvr5ZtYaSHc9owOrIqy3MuXx3xaMInKGgX?=
 =?us-ascii?Q?UeK86ZddMxy6+VfkjbmeaaEegv9W3TlYuaL5h4znFPX5+CQ3MbtzkWnn9rIz?=
 =?us-ascii?Q?fjJG8yKtCJ0wtSGb1f7D/G/zvtOsANgnAeLynekOvCV1q5+Uuzr7NsaC0vCx?=
 =?us-ascii?Q?84gCD4HtVOrL1hfQZu2iAi29m/ozOxvdO4vZYSxjk30vNgAj+1zd18f7cqUi?=
 =?us-ascii?Q?Wx/4l7SdBdO76Ikyqaw5syckfLxi4roz5OsPHoYC0TW6bJmdq7mr7JmsfWhx?=
 =?us-ascii?Q?HSbMybt2O3+F8IT69Fj2/Qnv+nfZQeAGPQoho9Lap1f0cd8h8geO/0PQV0fs?=
 =?us-ascii?Q?5+3gQuy5u5TpOvg2e6Z2FeDBTuxwtUXXr95prgtx9u/duob/PulIpf0KCmfs?=
 =?us-ascii?Q?KABp3KTdSEkRY8au1KQcnlXJusjUJb+fEpB61AnvpBGHT2WsqmLPToRzqW1a?=
 =?us-ascii?Q?WLwwoZfjwRk52iX0UnLlJogHsRs1FB1JfotP4MGNrX0DesvBOPVEoDoE45TB?=
 =?us-ascii?Q?/B8w8BjeVds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqJeRQGYix41IVUP+A5rGXWMyJWEr9rLQsG6LOewnnIXBOLH4E5vJNN4vBS2?=
 =?us-ascii?Q?Cbai9r8hMsIaXAOj+sB+L4opWzYmD5M2609WZvADjmqv+yozF4U7t4y3R4ZZ?=
 =?us-ascii?Q?Bk5vPLz6TgnreZh/+uPDFTT1CkbCwOivW2bFakqAYAzm0AZLeN2bDcTvYae9?=
 =?us-ascii?Q?7sFaGkFamrTpnGheAbpSm9weK9lC3YLdWR13Xby6w8UuqKuiHY8MPZJ1R8yb?=
 =?us-ascii?Q?YIGHpOIcSgpToMiGKACVST5C5j3CijfdUbyvN37R5+J92FlayH7tEp1/7MGd?=
 =?us-ascii?Q?OOpOhiUFGKPIZh1wcB97bL+AEX2QpQgZwJBwXCaEq2U6aFsGzYJ2Q1zEMYIh?=
 =?us-ascii?Q?llpVFcv+Fz/+uuCWFqNK/Tf5UR4OK0muVPCEasJVnu6UO6bOwJcGaMGJmudh?=
 =?us-ascii?Q?g+x/q3tDRjO+Tn/3BEpgkU/sx2a3+nX799fCAiJp41KYzmBxBtOCpLwBuk31?=
 =?us-ascii?Q?kJg64iq9tZjzfZ/mS2PFf+hI8ZtWg97O9eXq0qLI6vN5UHpoi+TYqCJVnPxY?=
 =?us-ascii?Q?JITAg6TySsl9Ut+wD7AJ+nheYKe2JRkFW5+cPWXzDQLX8RGJDjTGhgQvmzMW?=
 =?us-ascii?Q?Z9ALegFMROHRfZR75msena33fZNIm4CzYm4wEs85i3KfYIaKsrKP+l8GTIJN?=
 =?us-ascii?Q?ZRG6o8WeH9ufh7J3l7eVajUSPHA48neLQ/jbQl6mQ3V8gRPCiIAkfBoFlscG?=
 =?us-ascii?Q?r7WV9iWsxjzuOyaC34/sHXsGDVdN7L1/aTMFIAmgt2vARtPkkyvd0oYPV85Q?=
 =?us-ascii?Q?epxrplgZQi36g+RJAQ6h3auXGgLnHFcA4Y6uNmAzqEg5h6TkcmEGysFuHXiv?=
 =?us-ascii?Q?Tibr5w3ivdP1aWNfvikne0NG51O2ERQNpdeINZHBdyrI/UNYyGIcUDP7ocnU?=
 =?us-ascii?Q?U+AlEb5Cu74BUgkcXK16I6dlEPLX3Hfa+E1wIFsw3+yjiL/0yWtT4s0U0trt?=
 =?us-ascii?Q?VZWlzSPHIgNTh2Y1f9ha1HRUpXi8+26xnNc7WuG6LqNb9Hyibx+GvB4BLpK1?=
 =?us-ascii?Q?FBI6Hm7jqcZGdFwgLo94QW9gcRqCuyO2ERYLvxJiC+eYkCojKdY7/RNnz7ON?=
 =?us-ascii?Q?IBJS8oq4L3aKrG6PtPenM5DpuJQ+d+SQJK+FX13llznQFSHsOZjKyBtsWGwT?=
 =?us-ascii?Q?O3mzRo4Rhakk+MqtnNznUywCcrYq8Qdtitp5NqNRtvWvkFZr5l1lO6Spyo+F?=
 =?us-ascii?Q?OTJc7KPXM8ZucOnS7eXMSOMnk4UUJqtZxWjcVBNF61HzySreU3lyWsNLga1p?=
 =?us-ascii?Q?c93Rbq300oGqwh/6JZX/SIvobVVNHSpavMgbLu9OgLs+Qi4S6USvwRm3pfSw?=
 =?us-ascii?Q?xPyEi2GK/G7NNixnZt6IC1XOEinTmagJJiUaaJhD5PTU97bKphfp4jeOIPhv?=
 =?us-ascii?Q?pAbZ65IJbMnOyi07t0YCcLDr4pzWdzq4UwbD77e/rNLFLKCn6J/oWroTnx/e?=
 =?us-ascii?Q?IdIJ9A4Dh4DIRHtMEcPDkQESEl1zgEA9P1MRK4cVLDdvX6fSz3humS7MtDCj?=
 =?us-ascii?Q?gctCdUG4wMS54TrAQXGpMpbyYbIqQD7zb0BxHuIua49kyYaIv3VpRSQqqZIy?=
 =?us-ascii?Q?SD1qDLE/b1RXjaQSCxFNQNyiMGn04k5Hld2hTWIWcFHWzaLc7dPimycubaNp?=
 =?us-ascii?Q?9sRFOBkJS9pIzDeqpkJ08Yo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a4cdd2-d3cc-44ba-90b3-08dd15727634
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:11.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLTcl7Sj/Ynol+QYyOkSygHArc5w2Mbs8z9vyRrR6mzkG1iVI7iZmvTpQAyzgilIU9H7No64wHkPWi0Yk7qfbYKBTdkE4hPefvUPrxWZoaVvvhHmXrmp3G60ygaSD9ky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6625

A single call to einj_get_available_error_type in init function is
sufficient to save the return value in a global variable to be used
later in various places in the code. This commit does not introduce
any functional changes, but only removing unnecessary redundant
function calls.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 74dfb3daba50..a6b648361d96 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -83,6 +83,8 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static u32 available_error_type;
+
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
  * EINJ table through an unpublished extension. Use with caution as
@@ -657,14 +659,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
-	int rc;
-	u32 error_type = 0;
 
-	rc = einj_get_available_error_type(&error_type);
-	if (rc)
-		return rc;
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
-		if (error_type & einj_error_type_string[pos].mask)
+		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
 
@@ -687,8 +684,7 @@ bool einj_is_cxl_error_type(u64 type)
 
 int einj_validate_error_type(u64 type)
 {
-	u32 tval, vendor, available_error_type = 0;
-	int rc;
+	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
 	if (type & GENMASK_ULL(63, 32))
@@ -704,13 +700,9 @@ int einj_validate_error_type(u64 type)
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
 		return -EINVAL;
-	if (!vendor) {
-		rc = einj_get_available_error_type(&available_error_type);
-		if (rc)
-			return rc;
+	if (!vendor)
 		if (!(type & available_error_type))
 			return -EINVAL;
-	}
 
 	return 0;
 }
@@ -786,6 +778,10 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
 
-- 
2.34.1


