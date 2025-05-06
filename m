Return-Path: <linux-acpi+bounces-13516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A15AAD038
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D88188FC3A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF552417F9;
	Tue,  6 May 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mv4+Jfjj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022102.outbound.protection.outlook.com [40.93.200.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42E241CA3;
	Tue,  6 May 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567528; cv=fail; b=m3W2/e6zbkpvd0RHXN3lZMyzZVIYSv9TaBzmdtHYdMmu6GbyHo0yZxHNpSvPm3OkED3N9YsSCJwlTC46/JrbEXDSta4gSS0KM7BAfRiuX3GAiK+niljHTJbKBJ+G1ntR8anSG4IQY2GS0681Fh58yQCC4QVS1b+e+MkaN0rpH60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567528; c=relaxed/simple;
	bh=FGDh8bsn4AZGWoWzAI1M76JFVwRWkMOxMI32yCCySLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sb8Srh0AvuCpYMv51yIFgHH2x3wDqnQ1Ft9mfPaJlKKZzbF+bMcGfcI+1VIadeUrOlxqafvOls4bxx6pfKDMUy0yOTJcsWB+32blNlXgR5aplclJxIxzdIvZBChYT2QorNOowHGTRfhe2mgE9UT5B53cLh/dFCPY9A+bHCqXk3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mv4+Jfjj; arc=fail smtp.client-ip=40.93.200.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og2+8vulNN77ScFU7VXtBDh6MoxEWmYAsSSi5qGOUgKL2Pu7rDCEqS9lJclYQdRHAVRHNLVC3SP2WBCPRkdGvpm0je/SmFAM7ePitMyM9qDm36Q557DW2mRyCt6V2u6XXUVN/S1WsPucuCNWnGT/JeT9L2taPHiiNH9boU/qClZujt065tdwIzg5eTzVmxjAD2K3PK6SYkuC2r+3TBB28OkCFxVdQ+YZ65TY9TjfgLxUypF+3sdggdugNIZPuRuFD8X9IeJK8hKeXn6aSTGV2smJjuuwT31HnAOADLGbqPi/tR7NXd4d/ijmj4wN+Y+0mzKPU6GTp7h6sAX61sqlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svHrvkPfXsIxhumrrHOs7WdMUg4EAcb/nSWVF1pfuKw=;
 b=dwvKs0dt8/tjTL73/8q6lAHhtUnG5Spm7Yrbn5nWPs+McoIaIPQmaLo5rORR7K75nfNRiiOAVstfhydbYwWcHk9J/SloFoRyNlEsFxEYZbbd/YIvXSsHkrMYShhvk/hb0LteHMhXNOqpwfDSgTBXWFiTVCLaZbmU54AA+9FPNQzPxoVcCMHZC6SOA7Yp5rWzBnCDEGHLOuMxuKMViUIn/bYicqaTrK/ANGa7x5hEnZCC5zv2l2TbdV+pXGu4Iekd4dCKT+9bDmIFOcZ7mz8zAwIHZyUa+a/d7WRhlMiq2nZcrhhLUycsfg2zCt35pugqxxeZ/NcJ/b7KBfBaIaq48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svHrvkPfXsIxhumrrHOs7WdMUg4EAcb/nSWVF1pfuKw=;
 b=mv4+JfjjPyc94HH/5pqf9ODZOU3bG/wLwgSmVr2sj4IL6ypUqR0AArApzrrKIWRB4sfyhoq0kVPppTsqxbT222wwnhgwB6B6jDCxi5URRDgDkY6v4NVdhz00L0z8caxhOwr46G4sohhAZ1wG/OaeRdnk3gjsoL44vESu90RvW7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA6PR01MB8904.prod.exchangelabs.com (2603:10b6:806:430::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:39 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:39 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v7 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Tue,  6 May 2025 14:38:12 -0700
Message-ID: <20250506213814.2365788-9-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA6PR01MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6e7b79-e7a0-4e5b-4036-08dd8ce65d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1nsLqUynradOQvYhRh7dXtJDCA1iF6UZ6NFYP7QHQyaeAV1kAlezUzJpTgq?=
 =?us-ascii?Q?Xboefc/S7AfR/KMpcbtb8nO9DV72lN3AgYlWP2apyKBoShJkmNLGOdDVF6nt?=
 =?us-ascii?Q?osPooNDCICL4uiyA4ZZq+0QQvfSLlPBf49gqnse4+Q/DZXbMkDQQTiSy/FHF?=
 =?us-ascii?Q?L1bK3/FfLk0+si+Z1nmcUECs0gQxDl1CDjX7kxu86neEIxDtcjqYmq0g9RTY?=
 =?us-ascii?Q?Zk/is8GJMpyLJmKZdv+PsXBVYWGNqoXfom4MCs7FzcvQN7CtwjLzN7cWvBCv?=
 =?us-ascii?Q?NCYgYf72xqDCMJPT8blMRv06KQHfVNL/y/9OakFDmrsFm5nqA3ds06TausKp?=
 =?us-ascii?Q?qTviMGf5VXadAmp+XANUWyIhisbhl2AMYGGYrcJkZGWawHlOFasAsV+/XPWF?=
 =?us-ascii?Q?OdkfydPl9HsglaW9OblieEC9NywDkMuTCnqUqW7x6KU75roESqw/FTluDD4r?=
 =?us-ascii?Q?qK3PId+uYREu7OUSl5qXoh9KU0fdKCXFWv6807r7Q1VRiyk2q2OreWzEynT6?=
 =?us-ascii?Q?DhPyDQKzXqWcMTvleIAngonZDVbBuHFGh40JgBPS6kBSOqt4qV14n9nlhzrO?=
 =?us-ascii?Q?BbqEUG2iUWtx8u98OgaXI0D/FC2+imAeJUZMjr53hFBUkJzmQAOXM5zfiqQa?=
 =?us-ascii?Q?RhVl+R6uTq4yFET7+OAIwzgFZGSPnFXf3VNjS33oeOpR9riNhX6y2ppUPXty?=
 =?us-ascii?Q?G92hJXMtKafonk0pnKg3koRoEp41X1kdg7RWZCrgDKRl0wEXl1pFgkU/A3D0?=
 =?us-ascii?Q?is9Y11V6zartZezqb0CWCaN8a7eEDoaEgCZWvk6oT+ScDSK7GtZ+tylDWOSt?=
 =?us-ascii?Q?XHSc2dZxL9hG/k6kcCWB6Adg3u6WT68F5+jow2IlVxoWO1RrTV/i4/5c8I74?=
 =?us-ascii?Q?TNWItFXGsMjAVNNEyotScU84indHl0s7h1CddBdv25s/V+ltQ2Cua4u99Jkq?=
 =?us-ascii?Q?2wieYIRqKptiWEB0Vbs5CXy1As8OZnYH6EhuLeSwqXdZmjZOk8w22/dRPMCg?=
 =?us-ascii?Q?w0072BsVN7K/nmxFqN29h24gMGzbSuIYVneJgj8b5C3J2mEuZX3lVzERmgE4?=
 =?us-ascii?Q?K+J/O6fyoDqG1lR/TLoZPNmV+6dZNFWtbeZpR4hmzJw1Yneot4CQWxw7F/2t?=
 =?us-ascii?Q?I8uBkU+wazlDfZBZLeHoJ4G08rFmJyiufpOM2ozsoqD8ucG/OfZ3WKh+JoXb?=
 =?us-ascii?Q?9BKh1+p3GOZievUG0Qd6YGvskhJjVJd/2JKTQuQiiwaJeiVDQE49hygfC2uj?=
 =?us-ascii?Q?9aRk9Eik3dNWIhK5+3asAuj2yV0vAWIWRphZrD/zCviH16cYYT3boBB/GduT?=
 =?us-ascii?Q?jFV+P7P9q7HnKstF8l6UwbMEO00AA2FIZqjdlpkdAVJ9VKKHOJxwKuqWMXiO?=
 =?us-ascii?Q?WDFpE3jtGZsxeHsWO66lHpu2RoqKur49x4U4jwF9U1hfy4F7ojmRhskDOYyw?=
 =?us-ascii?Q?1hja0j6kz07YAvk9SrM4H6fUdHnMtuzSzj5mlaqUr0LXnCEln+2COL774JmV?=
 =?us-ascii?Q?PCdHSoCMGSOOxzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpFfKsKTF30WJyWxn99t1sy9/aIbLYsGieDDC1aAPgdT+xcsWPgK9JuZVEJB?=
 =?us-ascii?Q?MBkDTvHjcxmay7Ybfi6pQO4hO9L/c8uOoUMnpJXzaKAN9lGOjzkoDrJJW7se?=
 =?us-ascii?Q?SgWWZ4B34mx3PJI1CtfbdgmHrmG2A35bfg5pKYR5eor5HkFmSrSVs+gXdTqs?=
 =?us-ascii?Q?6w8NWu4Sl7L8nCXW89uspDXqAUEOGoFDy80Oo/EILzXkppgJbVVjRRydIQOj?=
 =?us-ascii?Q?rKEIzP0RPCjCuHRfImkzugS2IiMtxwgYl/jlJ2PCyFmDwdVjVp69BaNqRICk?=
 =?us-ascii?Q?gPGDbiVsTdVfB3/va2BM/Amf65vvAWr5/tCvJRl67iafw6wpmafPhTyvt2Zi?=
 =?us-ascii?Q?JJNRcFIXvaCt5x8VXKkI++g1L0zisKSrbt+tOeBd9Efsk/+a0Los9wgOkzT1?=
 =?us-ascii?Q?FrFCCLuL5FfWy6o170BWISOxogW0rtPUk9j5MMSxjhnC8jtDDgILXVDqiGaY?=
 =?us-ascii?Q?jdUmVwleK9BtYj9H5wsq4Z7rRJnYxbU/IAo507aiEdhSsBsa8y6MopUnEihh?=
 =?us-ascii?Q?XEyD5dDJiS0bthxZRKH73uTm8s+8lHKtYWyX9XYsxR3nH/QvccpCvLsfdByU?=
 =?us-ascii?Q?+jMmQzsQfQTWr7fpugVrs7mCpuU+ojh9mnv25Z2xVz2I/MKM30r0m/kMKiQY?=
 =?us-ascii?Q?VnAxAe5CZuHW3NlxulEDASgwGVAAy3OTP2p6z2kFBi4SNzUX0mah6TSw0Gws?=
 =?us-ascii?Q?i6iy1EvAf0jM2F43MyXgz3ljHbQisnmtrWYxcCjUF3FpEWMPhAFsJc5s3y8g?=
 =?us-ascii?Q?hN+26fYidg2nZCxp4e0Ouw3FUZoKEBcw6+LVKavoJT+dgaUpJTDpUE4Nrahd?=
 =?us-ascii?Q?STBL/UbNs3htx+/8jL4jYmnKrKiLN31W160ro7M7/lvMU9mnR8v1BwkvePpU?=
 =?us-ascii?Q?HXveyKRNxuZCJSHCdVTx6DnBlmHAlwyv8C4UWnPgxMoDODo2CJsH073Qvih7?=
 =?us-ascii?Q?qtxJKKUYOkZWE53tWvcK6e3hQfUkyGKmV6ZBEk0G7p9hbfimVDhz6y5r3orC?=
 =?us-ascii?Q?7AZfeDudl21vqi8Wy2K2yQ6+8Nolt8Ii2VFFlFkYwedF85zAYqwkzA4vtJjP?=
 =?us-ascii?Q?lxhExAHW7FhQW/zPVZke3keCZIjBUct8yevon2MedkTDfRKoaGp6bz5FbCmw?=
 =?us-ascii?Q?xgMRrlCDUzm3bn0IHGUTQ3AewLE+z2D/cZwxDVhW7Zdgt16B7AAQiPu5dfX/?=
 =?us-ascii?Q?yBYqe13mRjGjqvOMfNUFXh154lTkBeBT7up4JAdV/nptp+x1BdYLLVszGA30?=
 =?us-ascii?Q?3CUEr8G7lXfJmS53cKgOvnsdMs49RUZ+cnx3zuKkYvkFfc40ykMbgfFS6uFz?=
 =?us-ascii?Q?8p3IMF+VksUvtqzmHD26yBbOlkIhN20S/wwEFpRmIhHKyFgPsT4FySv7aWnz?=
 =?us-ascii?Q?BhLP3yBwuH7n+Nj/xwSH0i2KTLmTXAPSo29w7xIjWAC88UqXe5PBL9thhElW?=
 =?us-ascii?Q?qvkg/KCa4dmdfm6J+2DciRJFu+R/nmbv7sXlzhTqmA3PL2lTQyejlJnYE3Nf?=
 =?us-ascii?Q?DfAOo0FkOWQ59VZhchuHZyCKCQHc04LgU6d8CcK+jr4DCFCczU5DOQcsjxJz?=
 =?us-ascii?Q?VDXmBx8SGOj/ESAAd3ryCme1dCvTNrR4JQ7nsZauY7ZyaOmB6Jeksileph/3?=
 =?us-ascii?Q?RCgTIW8ZBW9Zq+PQSIL46mo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6e7b79-e7a0-4e5b-4036-08dd8ce65d4e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:39.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQbt/M2fSvO+14pXVi+WSJdunDcJImaZXJJe5gU/TxPaf9HnsNjbvSiz32ikPorru0FW4RMlHA9PjwXb4J7do60rf2x5c6x0Hmei6mWsSCdHOZGQQ+kQruqAJ7CRH0if
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8904

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
 drivers/acpi/apei/einj-core.c | 177 +++++++++++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 44f9166c3881..491d33529a3d 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -34,6 +34,7 @@
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
 #define COMP_ARR_SIZE		1024
+#define COMPONENT_LEN		16
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -87,6 +88,14 @@ enum {
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
+	EINJV2_VENDOR_ERROR = 0x80000000,
 };
 
 /*
@@ -110,6 +119,7 @@ static char vendor_dev[64];
 
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -180,6 +190,8 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
+static bool is_V2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -304,11 +316,31 @@ static void __iomem *einj_get_parameter_address(void)
 		struct set_error_type_with_address v5param;
 		struct set_error_type_with_address __iomem *p;
 
+		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
 		if (p) {
-			memcpy_fromio(&v5param, p, sizeof(v5param));
+			int offset, len;
+
+			memcpy_fromio(&v5param, p, v5param_size);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, &v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param.einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				nr_components = (len - offset) /
+						sizeof(v5param.einjv2_struct.component_arr[0]);
+				/*
+				 * The first call to acpi_os_map_iomem above does not include the
+				 * component array, instead it is used to read and calculate maximum
+				 * number of components supported by the system. Below, the mapping
+				 * is expanded to include the component array.
+				 */
+				acpi_os_unmap_iomem(p, v5param_size);
+				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
+				v5param_size = offset + struct_size(&v5param.einjv2_struct,
+					component_arr, nr_components);
+				p = acpi_os_map_iomem(pa_v5, v5param_size);
+			}
 			return p;
 		}
 	}
@@ -486,6 +518,104 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	return rc;
 }
 
+static int parse_hex_to_u8(char *str, u8 *arr)
+{
+	char *ptr, val[32];
+	int pad, str_len;
+
+
+	if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
+		str += 2;
+
+	str_len = strlen(str);
+	if (str_len > 32)
+		return -EINVAL;
+
+	memcpy(val, str, str_len);
+
+	ptr = val;
+	while (*ptr != '\0') {
+		if (!isxdigit(*ptr))
+			return -EINVAL;
+		ptr++;
+	}
+
+	pad = 32 - str_len;
+
+	memmove(val + pad, val, str_len);
+	memset(val, '0', pad);
+
+	for (int i = 0; i < COMPONENT_LEN; ++i) {
+		char byte_str[3] = {val[i * 2], val[i * 2 + 1], '\0'};
+		/* write bytes in little endian format to follow ACPI specs */
+		arr[COMPONENT_LEN - i - 1] = (u8)strtoul(byte_str, NULL, 16);
+	}
+
+	return 0;
+}
+
+static int read_component_array(struct set_error_type_with_address *v5param)
+{
+	int count = 0, str_len;
+	u8 comp_arr[COMPONENT_LEN], synd_arr[COMPONENT_LEN];
+	struct syndrome_array *component_arr;
+	char *tok, *comp_str, *synd_str, *user;
+
+	component_arr = v5param->einjv2_struct.component_arr;
+	str_len = strlen(user_input);
+	user = user_input;
+	user[str_len - 1] = '\0';
+	while ((tok = strsep(&user, "\n")) != NULL) {
+		if (count >= nr_components)
+			return -EINVAL;
+
+		comp_str = strsep(&tok, " \t");
+		synd_str = strsep(&tok, " \t");
+
+		if (!comp_str || !synd_str)
+			return -EINVAL;
+
+		if (parse_hex_to_u8(comp_str, comp_arr))
+			return -EINVAL;
+		if (parse_hex_to_u8(synd_str, synd_arr))
+			return -EINVAL;
+
+		switch (v5param->type) {
+		case EINJV2_PROCESSOR_ERROR:
+			for (int i = 0; i < COMPONENT_LEN; ++i) {
+				component_arr[count].comp_id.acpi_id[i] = comp_arr[i];
+				component_arr[count].comp_synd.proc_synd[i] = synd_arr[i];
+			}
+			break;
+		case EINJV2_MEMORY_ERROR:
+			for (int i = 0; i < COMPONENT_LEN; ++i) {
+				component_arr[count].comp_id.device_id[i] = comp_arr[i];
+				component_arr[count].comp_synd.mem_synd[i] = synd_arr[i];
+			}
+			break;
+		case EINJV2_PCIE_ERROR:
+			for (int i = 0; i < COMPONENT_LEN; ++i) {
+				component_arr[count].comp_id.pcie_sbdf[i] = comp_arr[i];
+				component_arr[count].comp_synd.pcie_synd[i] = synd_arr[i];
+			}
+			break;
+		case EINJV2_VENDOR_ERROR:
+			for (int i = 0; i < COMPONENT_LEN; ++i) {
+				component_arr[count].comp_id.vendor_id[i] = comp_arr[i];
+				component_arr[count].comp_synd.vendor_synd[i] = synd_arr[i];
+			}
+			break;
+		}
+		count++;
+
+	}
+	v5param->einjv2_struct.component_arr_count = count;
+
+	/* clear buffer after user input for next injection */
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return 0;
+}
+
 static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			       u64 param3, u64 param4)
 {
@@ -500,10 +630,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param, v5_struct;
+		struct set_error_type_with_address *v5param;
 
-		v5param = &v5_struct;
-		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
+		v5param = kmalloc(v5param_size, GFP_KERNEL);
+		memcpy_fromio(v5param, einj_param, v5param_size);
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -523,8 +653,19 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = flags;
 			v5param->memory_address = param1;
 			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+
+			if (is_V2) {
+				rc = read_component_array(v5param);
+				if (rc) {
+					kfree(v5param);
+					goto err_out;
+				}
+				/* clear buffer after user input for next injection */
+				memset(user_input, 0, COMP_ARR_SIZE);
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -548,7 +689,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
@@ -600,6 +742,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -610,10 +755,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
-	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
+		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/* check if type is a valid EINJv2 error type */
+	if (is_V2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -764,7 +914,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -783,9 +933,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	if (strncmp(einj_buf, "V2_", 3) == 0) {
 		if (!sscanf(einj_buf, "V2_%llx", &val))
 			return -EINVAL;
+		is_V2 = true;
 	} else {
 		if (!sscanf(einj_buf, "%llx", &val))
 			return -EINVAL;
+		is_V2 = false;
 	}
 
 	rc = einj_validate_error_type(val);
@@ -807,6 +959,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_V2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
@@ -955,7 +1110,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
+			v5param_size :
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
-- 
2.43.0


