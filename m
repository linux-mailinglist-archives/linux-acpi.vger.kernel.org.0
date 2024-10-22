Return-Path: <linux-acpi+bounces-8919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A909AB8C5
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D598DB23FFF
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDF1FF030;
	Tue, 22 Oct 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hmciz4bj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DD1FDFBD;
	Tue, 22 Oct 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632898; cv=fail; b=VVM4qGMDnqUa64dVu6lPOTXw8X8n4wcsLXRm/rb6SuiRRc/UgcAteQu3sTRUgmiBUsC3tq5vYSFNcV+ZxgDyowtb6n43g1YTXNMSvMbXxmT7TS+ArOTSYiyzG3/0tEfBarDjABJGJzTWER5ziWHLj2Rx8d12esr5Y10ksl/Qvgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632898; c=relaxed/simple;
	bh=RgTuf7Tl5pCEkoTFVkO5PS7PfcpZervL8uKzE2ztS5s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3pJJwaIYXJPwOLn0O/ILBi17ZQFzWlBDFFti+Okvrn8ljhMQOWAnujK28fLVA26/uyEeMLo/wskyUxuNK4X/tbY812NwyUH2VM8NwZcrt4w/7WzirkScQZ3/0Mcs0JI6Vbzf0wvEgYmgZrllhqkjn9jS+z8kbu5WpZR0bCwNVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hmciz4bj; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkxUkCoH7FjYZEuCSfLdlaiw9zAa8/juZlUHoVwyc5dTua11ba+LpK2v9G/glPF5egMQHf0R8/IxoMYFhbHDj2K4q1i1g2HZEs/zUfDNgUMYmcPKXcGJhYlTgbgdBRzGGBa8R7Xj8dQQLVhba+KxAzeUA3t+mOR5nUeHHhDDRUWFrYM3waJrd+xgSNG0N/neQ172ub29nJ1suCitBwpjPWsLucxvQpAOMxoMPBcVanqnZ8SX0KUVK9mgxmnUpgkKhJpWcnW9YbK+3YBZObeKjrYpQHqankkusQKbjwswIPmgmqGTGbO4Eet1jrqKat9oshj0pADuC7AZujztUE7s1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8SU1tGZDZpK2DWW3QVJUYW6fVUfhNKfppdBc0Q/KrY=;
 b=l1KITH5RiZSUTtjsTX8h04TmwmUMHxtf75IydSOwQxxOb2/iNiGaQ33brNkt7asKLWScJ6RUTIjLG6+/VroKaj/2Yc4oBkIGmV3DjPYBmIero9hlZWefVNZ8WHo8LYig1ucZG80HFsLvs5Qu/TF/LggzJh628PbBVBDjrCGS//35yiEJEO70Cqng+fA23BtxWs10ozfk3MP7nzEPDTzbTYNXUmK/pYcR6/dyU9Flyl/w07JVM8mJaf0B75zjpWI6eHCWnQkJzev+nC1U2q/q8NARgrrxaMfe0HSHtISz7tsUGYZc2ln8IWiXamYOwgc0/gIueW+mGws4LWLePkhrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8SU1tGZDZpK2DWW3QVJUYW6fVUfhNKfppdBc0Q/KrY=;
 b=hmciz4bjQSRlD8SnaWNk4O0DQzOWAD8Yg3Qlrinhn0gnlMTpqGjWqa9sv9QLKg/QuxN2CZmDcVdSWnMO5ECjAPFPa/YX+sYA/YOplox99NWqlyhDkGVhezevmV5exVXRFfMuCHYiEnm++iHvc+CEbPMZubAJ0FHhny9BSrgLRLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:50 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:50 +0000
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
Subject: [PATCH 7/8] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Tue, 22 Oct 2024 14:34:28 -0700
Message-Id: <20241022213429.1561784-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3e51744-ad9a-45f0-17db-08dcf2e15c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TxBaRggXdPNX78ihY1rEMgahAL8Hhv83gR36/kRZ/TeGo+3bRrt46ET4C/wk?=
 =?us-ascii?Q?Bvn41e9XnWJQpS4hBK8EBzlhAQ6BXwExZCelp9k7IVpJ4hQyZubPSDDP7oke?=
 =?us-ascii?Q?pb22XI1GTNsccHBho9m00xzVE2A7eNAAgq8zc/s7DhuNoWj3RDFfK+Ombkpe?=
 =?us-ascii?Q?ghpanwE40AalFN3MlnL4z/2zHtn/YdZspF6kEVAa3kmvNlp/IH1DdDyxgjyz?=
 =?us-ascii?Q?SoDMn+nYtWYJ91YeiJLOOmd/RoGtwen+3iTAosrw3ptAdmaCxqRLiKbusIrd?=
 =?us-ascii?Q?xAWF5gpjFf2OTXeLzvT3A+dHzwNAXEh/UqBXXVBykTUnQhq+EZ5Bp8ocGu1Z?=
 =?us-ascii?Q?lPY9adHlvFHCCUxJ+KVNPzrwiY/3bP6C/C/JnHbPkqI6pznw5S9SBXuNIu7g?=
 =?us-ascii?Q?AvX27STVQ9QIVf+ygaGi/ZdycpdQEoTqRWWhtl3EbLW2PB0KfZBmR4q3OL7+?=
 =?us-ascii?Q?FD0G3+dQC/lvtDa7Iz4HZjic6NzQJOOizHgN01fDKwGTyEcFpkg+9Qe0t8ft?=
 =?us-ascii?Q?eNhTEm2GvzdEOFf7JoGnRSu9IXe4BsOiH+gFM9XyVCXwpgWUwBTyqya3NjgK?=
 =?us-ascii?Q?rAEF15bbzVBnRZZXOi9LFnez4skFRX5sjyY1TV26qaOO/pf9wtK4RGXbRAZ+?=
 =?us-ascii?Q?BtYlh32+bEb8uWu6XiLfrtmcwROqZ97vLZe2wTtueHqVma2M3ELB7AjYwKGl?=
 =?us-ascii?Q?FC8D6Rm836eJQXtBW0ZM6ZCAVhpXeXgUJ6vlgwlRrwXutylhZkJvJcAFXZcx?=
 =?us-ascii?Q?q3CLjR9H68fgaJmah65AzmARstWsVrsa++3GxqKircYa9Grnr5Jx8HxcQMNT?=
 =?us-ascii?Q?Y4iotvg6ugkeqwTxalxHlNK2oBs+m5Y0aFH8wjvvPGOmvw8WUyxkGep+uqDc?=
 =?us-ascii?Q?TXFJOa7jC/UCS9yXOj9pWCTpvOcWxuQmCUC0Ld+busmYvS33keAfAkMblzEV?=
 =?us-ascii?Q?OXbq9ZucD23XJF8goUGFSWavjMjb1yHvq8mvOBLVyia3XTNKr0qIc1jOHaGE?=
 =?us-ascii?Q?ZXtqsAeTONSM5Did990ZyXS5iGdqzVApbRi1ZuXpIf6HGblAlczDla24el9i?=
 =?us-ascii?Q?Td6c0piod4DceMt9Y0l1A+R/PT6jd9FZvgeS4AcGD4/yc+htvm7RCCZvIfIR?=
 =?us-ascii?Q?LCSKh565uF6vn86Cpz0bXcJ39zFne8e7J6cRh9qrZD8gww3/fnG2a/VKufJm?=
 =?us-ascii?Q?mOnFbIbtXVIzB1MYAlDTAHI6oFZlitf2CHUUzhC27z11QLLu3rx9Ucn9NDw0?=
 =?us-ascii?Q?tGPwGdCxBxcxVoNeg57Jf/v0dnIPfL/3n1Mx5gtbgYJkVj2REXjaz57QeZWp?=
 =?us-ascii?Q?kQlPYsmfYE082yWaZWTTCWM3MVRhMvZPeWYLUZ3+YMGa4ntOrY+a+psVDEhp?=
 =?us-ascii?Q?qvBk8jz7M0IUSnKqF3U5VtHos7kz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Dn4CXDcs4dRc0k/29u62R3vx3GrgXBiEZP9vX4yxObYXoFCHEex24SYRhMe?=
 =?us-ascii?Q?WCiXKO/FMAR772kgVR+BViH7qsmG9VmLVYcwd9lSTmZ/CpatAtyHxoUEG2Dt?=
 =?us-ascii?Q?VGpZRcN4rlyOVibptKTct4iOGQSnd69bRtY7IXhocGWzu+gSIJBkkj6SLpp0?=
 =?us-ascii?Q?F8TQCvHBkWVWeFYXm6vAR1Xuv+9eOvytoDurTnyzmGiQiS48y79Sb44tydVW?=
 =?us-ascii?Q?kkuV8ccB33xcYek76KWBSV/Z7v9KsE8npNNJ/H3H1NTCpmKgydO1mN9mLDSn?=
 =?us-ascii?Q?MIG9pk+TObYfjx5hxAZJ5gpyrWV3myypMUkPdkZyCG+dmqaR9r2GDJlriAUR?=
 =?us-ascii?Q?omKDDLrRPt4SXRf+72VfB8rdJ504OJFOQB28CELBlYjJrFoSLDPPUHaXXN2u?=
 =?us-ascii?Q?FmT3M2d15FyBQtA19qXefmQp/3bxqv/1NigHTItFaQxatBsXIEaCFz2n6SAT?=
 =?us-ascii?Q?wt7DL7ZVOPfLhAxY0TssJw55DOotJXrY3Ug29kOo8MGQxyLZ33asEtX29sEk?=
 =?us-ascii?Q?nFsiQ7cSTC0pQn2QCnzWSVeYjKmGvWQ9Dgns3KO+dB/xbltv9ndBpPHdCkqb?=
 =?us-ascii?Q?TdROMgzcca+84zZE4PllLmv38zTzQzEjgVeQPVG5Gy8hWPOiP0Q/Ke5IXXmg?=
 =?us-ascii?Q?QTnUX+7tXDhIwUSlevqLtjQf0LZxBV/wI8ocoxwrc+WHqEszAezDkBJ2AniX?=
 =?us-ascii?Q?rjQHwgiPyGDvJDfkV6pPVv4SeMWsJVcfLMo1xR4pG8VuuHnNANHNhKJBBznW?=
 =?us-ascii?Q?ufi9+0Wdz09QhCUfsWvFmRKwfFJMWXB4Qei6S5zsXxbOxjKeFLT9Xh8eeEwo?=
 =?us-ascii?Q?N/dSSSz8oecjqrwdOaOtOUqiVommvvMt6PQLUIhLfNF9XIK4saqBWXgTPzQC?=
 =?us-ascii?Q?9UvvXVjHx9jF7KFtDJGXaxFyMDg6eHP+DkytkBAfh0zY/dXku5x1jLGBQr9v?=
 =?us-ascii?Q?vfQ8t5dhRaN4pXNPQf58ccJwQ15CubS5+tlsOJOkp3J+RqoeS5IeHbldDK2O?=
 =?us-ascii?Q?Cnv2TNxgWS8AIrtMS0K4jcymRE7WxZNcwA6EgqsipnGYvWS+15ghratwWIX6?=
 =?us-ascii?Q?yqJco10RyVc8YEJIwVGXkeEe09l0KUqFTX9qP2Q9vGDdfDWMfKmp3vTNKmg9?=
 =?us-ascii?Q?1CrQp6tby/2H43eCow+tpEawJwvstICuwWlD4UZV+1ftpOIp7mxH9zUES37c?=
 =?us-ascii?Q?O+0TILbJPuRXCKK+/L5edC75afdmcHT/sou6HkBtUtDthe7mvrrgbVx6/5KU?=
 =?us-ascii?Q?jQjf7QBtjZsSHek4s5rzxmcobZ+sKTooQ8mkY88E2/01m04XuNmH8hrWhswO?=
 =?us-ascii?Q?4ZpJKdJs9GbcHCQ8RAYWL0z7PFuxbaEm7yYsP/nnn2TnD/CweRX+/LRUKrAf?=
 =?us-ascii?Q?eZ082ECXJmaOaS7DpnVyFdjetZ1dnMWSqOX7kxoun0GuLXOBEeg3yeHnsOVp?=
 =?us-ascii?Q?A6/2BtH8VPq1wYzN8jKD4dLbVmEs4vHICml/ppdgDbeZ3ImnxwxxzNNiFIJh?=
 =?us-ascii?Q?ccj5r5P+yr4noNFUkE/BtNs47lbLGyETCXDyyb+BYxolHkiLPtrJTDPmQNq3?=
 =?us-ascii?Q?GZzQyAzU+LtAxyfwodA8tqW571Qs8JLOe19hnfwbmyUiX/TopiIxv7ivfz3v?=
 =?us-ascii?Q?oagdJUj9Wry6Wg65x/2WbDo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e51744-ad9a-45f0-17db-08dcf2e15c11
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:50.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJBm0NqCA7t6jHQvsOeg90/K7CEwe5M+SojY9tfShvLpjJ83991lVaRXKNrXtqo/KGseQ0YTgVJilTmeVufNqwt59Q8LPmiHnG69+z0vyrZio7VQZBOfwDQ3o9iiOW1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

Enable the driver to inject EINJv2 type errors. The component
array values are parsed from user_input and expected to contain
hex values for component id and syndrome separated by space,
and multiple components are separated by new line as follows:

component_id1 component_syndrome1
component_id2 component_syndrome2
 :
component_id(n) component_syndrome(n)

for example:

$comp_arr="0x1 0x2
>0x1 0x4
>0x2 0x4"
$cd /sys/kernel/debug/apei/einj/
$echo "$comp_arr" > einjv2_component_array

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 76 +++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index bd46a611eef7..bc833f42dfc7 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -87,6 +87,13 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
+};
+
+enum {
+	EINJV2_PROCESSOR_ERROR = 0x1,
+	EINJV2_MEMORY_ERROR = 0x2,
+	EINJV2_PCIE_ERROR = 0x4,
 };
 
 /*
@@ -111,6 +118,7 @@ static char vendor_dev[64];
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static u64 component_count;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -287,8 +295,18 @@ static void *einj_get_parameter_address(void)
 
 		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
 		if (v5param) {
+			int offset, len;
+
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param->einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				nr_components = (len - offset) / 32;
+				acpi_os_unmap_iomem(v5param, sizeof(*v5param));
+				v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
+					(nr_components) * sizeof(struct syndrome_array)));
+			}
 			return v5param;
 		}
 	}
@@ -496,8 +514,49 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = flags;
 			v5param->memory_address = param1;
 			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+
+			if (flags & SETWA_FLAGS_EINJV2) {
+				int count = 0, bytes_read, pos = 0;
+				unsigned int comp, synd;
+				struct syndrome_array *component_arr;
+
+				if (component_count > nr_components)
+					goto err_out;
+
+				v5param->einjv2_struct.component_arr_count = component_count;
+				component_arr = v5param->einjv2_struct.component_arr;
+
+				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,
+							&bytes_read) == 2) {
+					pos += bytes_read;
+					if (count > component_count)
+						goto err_out;
+
+					switch (type) {
+					case EINJV2_PROCESSOR_ERROR:
+						component_arr[count].comp_id.acpi_id = comp;
+						component_arr[count].comp_synd.proc_synd = synd;
+						break;
+					case EINJV2_MEMORY_ERROR:
+						component_arr[count].comp_id.device_id = comp;
+						component_arr[count].comp_synd.mem_synd = synd;
+						break;
+					case EINJV2_PCIE_ERROR:
+						component_arr[count].comp_id.pcie_sbdf = comp;
+						component_arr[count].comp_synd.pcie_synd = synd;
+						break;
+					}
+					count++;
+				}
+				if (count != component_count - 1)
+					goto err_out;
+
+				/* clear buffer after user input for next injection */
+				memset(user_input, 0, COMP_ARR_SIZE);
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -570,6 +629,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -581,9 +643,14 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/*check if type is a valid EINJv2 error type*/
+	if (flags & SETWA_FLAGS_EINJV2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -913,7 +980,8 @@ static void __exit einj_remove(struct platform_device *pdev)
 			sizeof(struct set_error_type_with_address) :
 			sizeof(struct einj_parameter);
 
-		acpi_os_unmap_iomem(einj_param, size);
+		acpi_os_unmap_iomem(einj_param,
+				size + (nr_components * sizeof(struct syndrome_array)));
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.34.1


