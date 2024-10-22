Return-Path: <linux-acpi+bounces-8913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE69AB8B8
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2E1C22EDD
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9821CF5E2;
	Tue, 22 Oct 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eJ1y3b/s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B694D1CF282;
	Tue, 22 Oct 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632890; cv=fail; b=DqhxjN+QJHleZij3dkhTfJUShhy0R7Ssvh3kDFvwgFBJUJZ0oia4pRPdZLgjOQCoCdWl2+4uceH88Rc1iW77+bPeIHPdo0YHnbQ9rGMbTiJJxdcaGsT+vZf9ZeODU5V4r0JlEBCPNiEPPZr3904DJdYsJrIxSP6xEutydHspaMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632890; c=relaxed/simple;
	bh=7Pui8Uh/AaA5ZbR3YtLSxow+P/kaJZT1Ife3NB17z5k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ol6lf9aGRSnGo7iVZqvpaaQnks73cBv18PGfctGQcvdlR2FBXIqHOQwNzZnEhaJxKn1XsqKNjqQ1gfoo6KPbl8KIoTAla18BiXyAJSdd/Zt0bGeLjgUw/QPQtx8wEDdvFr9jLNVsSA8xbZ4DWT86u1r6S9Hv8PAg5wgfKY91dXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eJ1y3b/s; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRuVbuYk8G2xJUwTjGhyb7d3+21ItAoV62HvRWHwWlYIw50UErlnE+Dj8gHCJ+M/pFFpIz1adiNhF5HhMmB2xS/0Nqo5HPEr67omB5VWIKnXIMcEuqvKW/tQkBFqnc3kldiugTRAVpAqoT16bFgjiPKTT1ZFhDsTNC8JvNa0Z2iX+OmdBLBBxID6Ah6y5qBmB5mmQ0MImzxEtxRTCrrVdj2+l3sZOYOYRfHFQchYGUDhTaa4VlizMjAnxjesAAsSH6AQNqIwd5v6vJe+DeLHAvRsOL+BO8M9iebUUuAWB1PDQkN1aEHcXTlVqPvfObficlXIjIHwMKa/9JVWBEcVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9aQVUejRa9bLVYZogPYcwPdi4eK8mzZi3jIiHStYGM=;
 b=OzGBmo+r5UYkfZK7VE56Btq5BnKuGkdVNBqvlecm2GupVmdC4javC9pN+lBViFA+XH+6bIcEZ5N09dtk+DEjJNiVnihA62t3GKmi5i491dEIO3IBDvx9cQioAqrSLGfmu47Vq5CJDZbUK/FmEiK/Uo1rvpP9o69ggfa7YYsVUHpSbB7zlp0C3JGnJAQQpOphIUqfuiUbnQVzDtxygSKGEMym5wIw9QHgrygfXOfthcorfS3j8dbb2WAjXaNt1H7y85gUREMo6ybn3RqjcP96IYQo0LvHiL0lYpdGjpQ6crQX7f7l/dgYNziRv3g5ccUO6vAK5Ni/HuNjd5LrB6yFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9aQVUejRa9bLVYZogPYcwPdi4eK8mzZi3jIiHStYGM=;
 b=eJ1y3b/sWZQTSQ342DFMA1Mldk87gXm1r/dmB+WE2zOJiWfogxwcbalIbfeSz3+YBW453z3szOAyHLuBgED1ER6FqyOWSrCLn0KOaAp8PTe57JsK1Tg4guoH+jC4ajvd4IB88E20o5u+Kmbq+hXoBhRmXksDZI5SrngbabKV8H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:44 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:44 +0000
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
Subject: [PATCH 3/8] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
Date: Tue, 22 Oct 2024 14:34:24 -0700
Message-Id: <20241022213429.1561784-4-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: e88190ee-61df-4bce-9ed1-08dcf2e15875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eBAQFSXuJtUpWDSUty6iq9ysrdRaJSYuP7GG0Uqap9n1phWCyP9gUQ71vTV?=
 =?us-ascii?Q?67ljo8keXf+uMJz0giqsG05XEoqQb7QnLp/5iCdLK1MYt6gXEYWi6tvO0Qga?=
 =?us-ascii?Q?YZgp9V2PlFVfB6p3jL8gBgafk69p5RZ9DJYL3QY+hle7kWYP97NO8qbMOVbo?=
 =?us-ascii?Q?USlyTS+wc7I4193nbIq0HQFUoC3V69VyDWujPZ033Jt8KRXYgL3aPJQVNccU?=
 =?us-ascii?Q?QieAa//kOyqCiVZ8WZ6HF0a248BXKwEtyqejRtdiQ3mW2S8GXmO3ghWW/Tl7?=
 =?us-ascii?Q?34BfuTFFreiKZjh7PJ+Cg23uTjJZSvwi4KIe4yoqF7IT4Xj0pQigf95eqxnU?=
 =?us-ascii?Q?y5DTKsuUJAu2uWU9GXVx7zL6gKueb2IOOcKnpykfy1dufIsuVO2epkLLFQUr?=
 =?us-ascii?Q?ujYR5ZJjVgWQNfhLDWpsIsTvK7G/4mR6ycEqRG3nAZzk+eLpzvSktyXJoQt4?=
 =?us-ascii?Q?xjcY3iulJL70BpHUXLKhL1xzxhT8JNkIeV5OT+U6q+JT4zYmZLzQ+GS8s8FX?=
 =?us-ascii?Q?0DJZXStgAtX24UuD7OIY9bDjaoeJTRK87O1t88i05btFYjaaTshuSJXTUmec?=
 =?us-ascii?Q?vi3W+7KsEVUR9LbtUpchOIiQ7TGjmH1q/qttOUw7TrrACFtsC/niHHtZiQMR?=
 =?us-ascii?Q?g0io2Umu4HSA4RPt1BkuKHNODpuTim9DWt5f4psw0p0D3e8hhP3qOwZFrJL5?=
 =?us-ascii?Q?V0qCK2R64tC7jHzzgZouLSoHfiSkwBcqZ/6pcCc50v7X0vAvWlLT2YSV9XKs?=
 =?us-ascii?Q?2QfVE+H5I/UqbrgfOkgtFiQCHTwpju7aTwbAf0OOfoIYp2EHcwifA/+iZ6Pl?=
 =?us-ascii?Q?QKH6MFuNcMdtORIRo+x76/sp/bLNLzrLdM9YcS2m2xBhHhEr5AaGsW5HmrYO?=
 =?us-ascii?Q?iwm2w7S4tRn6+0dQtWZEN/qOlHNNqRMp5wifXeOqKNXBTx51oMrOXOIZSSub?=
 =?us-ascii?Q?pjIiYi00fBUYNwIjM6sWIBB3I50YzxOAgKhpSnuCfmba8SO/vlRzYwxdB0A/?=
 =?us-ascii?Q?fwxqr9mkUc2q25jKEQ7mPrLiPa3EMGgsHa7KQilE1NFuz4qzzr3iDt0ibi4Z?=
 =?us-ascii?Q?y4zJRPOM2s8tMAqqheKp2B/EdlsTwdHQS1s6+YM8wTfOXfeFEjsUZHeV/hx6?=
 =?us-ascii?Q?kf4eKE4OskzYDyLgl0PJysut2bkaThA9h2RX224OCRJ/+BrQhrV7193hW4fc?=
 =?us-ascii?Q?UzOfnmHIHjmagXV3B+VC+LiM3AHNsQsgjv9igZ2g1X7rmKqDqySttUUA0NtP?=
 =?us-ascii?Q?F4zwJy82Fpd9QJehqHfzxiwwQIVYtMukdJ0qPE1L6G22gZcKv5TJAGF+1xwK?=
 =?us-ascii?Q?ZQILeM7rkN89KR0DiAN8LrTP1ED3/tnY3q5IOU+cxOYG/QZC5Y+Q8S5NapwC?=
 =?us-ascii?Q?WPfGlRvhcSfKJFtaybA2Shhl/HqJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0sRnUS1W83z3JCekZzB+Tmmhu9FinO/0gk2MhAABPeDOpKS+hpV83nJ1NsvR?=
 =?us-ascii?Q?9EbWfEvFYbEpfvY945WDmXxoD0YPgSiXA8ErcQ9HGNQdfiBG7f6IjTXqoS3j?=
 =?us-ascii?Q?2HPlrNcWy8JU8ZO/6fO9a49r77GbvRBIjQlIaQqusvJxaTVwYpMVzCwcx3IA?=
 =?us-ascii?Q?zPlfTTjQiodr8cUHV52TVWopy0cxrKo8GVaiUwJbsHYHmY+sHJlKICKMrQJw?=
 =?us-ascii?Q?PhJmG6juwvk8P29ytckBOjM1cxO0g66VfclBkylRInElJ78nZ0gM7OvHq3v+?=
 =?us-ascii?Q?6LDFFLzrjPthIJmm9SJqHVejZi7DqN2mkBVVljEMt/U5vIpuni2X0X1Jg5A1?=
 =?us-ascii?Q?HUVxOW4IkFu+gjRv9vVrVyBrqwzwDVFjdHhmy0/YQP44XRmlT7GqRhjYa0Il?=
 =?us-ascii?Q?B+IZrR/YOdEaBH0Yuhrr5wITq1ju7+mPA0hS9WMoN77W1DBwRRVwQqmLtZCL?=
 =?us-ascii?Q?53gP4OibxqyBwz0g+aG32K/SqehwjLHlhMULSA3xpArLpWsSJhpAHEbooF5X?=
 =?us-ascii?Q?zDBWbr6H5zISgFeTF/2NETxCkqSpEY4NEM9yH1gBdA9+U2tihe9qZPsb/7b1?=
 =?us-ascii?Q?CcknX1PZbrqTPkc6zM1S0HAF6AGmh8iF/lnrN7rASC/UYFtrIoJ3BYwsFq/+?=
 =?us-ascii?Q?jYaNlfd67BaRINLbmYuNfLKqn19tV9+wLauSYqqq8x31NX/VBl72w5VFEycL?=
 =?us-ascii?Q?OLAP+Dqh5L5W7+M5h4B6k9knLC79pnel6k/3T8RxemdgCGqxBQzeWRunti2o?=
 =?us-ascii?Q?IGdzx224XeCGzGt+fdWH53fCVdEIlZ/hW1Z9rtX3PwAkBDSSy+/2ZzNyv868?=
 =?us-ascii?Q?Oct4vy3osv8jKeO7nNvDTxDyMk0o7MezzLnQ1fUkSea58kOojLo5fFKvIOTX?=
 =?us-ascii?Q?nhSkjZwiGF1DSP+n81pZyq7ldgChrc8RB5NpN/Daj7rEM7X/AK9bQl49/W3d?=
 =?us-ascii?Q?jUMqXTQboxqaJeypBMs/mns23uP/lAzS64/GlU431Wh+Vav7K7F0guKpyQ8W?=
 =?us-ascii?Q?JU4CxYn154Sq6Z6g7k8LiAIw8dz+XJvcCfyG/xtg2jO2tAzbXOIUdJdtoIrD?=
 =?us-ascii?Q?LAM+YBphvReBKT08yZo/k1y5vwwgf5ewW0+bbK1lijywlk9pytmVAiQRI/WP?=
 =?us-ascii?Q?BH1QlUKdGXI5BkpBNiqv+qSy0u29CJluCn3xQLj1Ce2yEAMtfEd+AXlc+Fdg?=
 =?us-ascii?Q?vX6hUargZ3xij40CE8+BmOOZ5kENsL0NPRHJxoiiRPLhTwPhocO1RPWhEQ6I?=
 =?us-ascii?Q?Xpb6KxRyxGBNxGuPcdV4cdvK/jxKbf4pS3WSDk2EI6QGFi3Drwo0+Pei3vVn?=
 =?us-ascii?Q?qi8XhVO6Tu+WN8zOUpGUK1RkR4mbvnP5BfTOHULqjGO3tV0c3XUiCi8VHbG6?=
 =?us-ascii?Q?2s5Q+BKK2VtFteGJh1kAzeluoixQfkPwA6OJoMA+4cigbQp31QCz6j8eQeXP?=
 =?us-ascii?Q?qHJ1pa+0RL+wM+aNxIWnTm7ljkvNdV9eQgpfrcXAGbI/irEIHZWTOMiZxRq2?=
 =?us-ascii?Q?WTcLY14rug64wypJ0agcCX1ldTY00P8Bn3Rcz6EOekKbScqKs3RfIsoyT74J?=
 =?us-ascii?Q?CAWAfDpALwAfroeVKskvscs3BzhJs5qGeHiOt5h26BCPhmWw+LMqniVxH/PJ?=
 =?us-ascii?Q?ILT+5cQtZxsYr0eYlroXdt8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88190ee-61df-4bce-9ed1-08dcf2e15875
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:44.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LO40VHSarVUF57RWnZLUYnAGTgVxqz3YC242A/dLNXHVwmOqK/xuW9wARV3hWrDWPk+tLh/y16VDcTnxNdYkhCVdrkG9+O/sR0BGMgaLFMmKdy9xMGeTAwYwXqKziiU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

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
index 5c22720f43cc..78c5a20115eb 100644
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
@@ -648,14 +650,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 
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
 
@@ -678,8 +675,7 @@ bool einj_is_cxl_error_type(u64 type)
 
 int einj_validate_error_type(u64 type)
 {
-	u32 tval, vendor, available_error_type = 0;
-	int rc;
+	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
 	if (type & GENMASK_ULL(63, 32))
@@ -695,13 +691,9 @@ int einj_validate_error_type(u64 type)
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
@@ -777,6 +769,10 @@ static int __init einj_probe(struct platform_device *pdev)
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


