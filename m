Return-Path: <linux-acpi+bounces-12716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3FCA7B24A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD774177847
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF71F03F1;
	Thu,  3 Apr 2025 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IFP0MhxE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F241EF0A1;
	Thu,  3 Apr 2025 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722047; cv=fail; b=GdyDYIriLdEW+lmcaS9DNbcPWnvtAY1mnIgOeLHDHDOsPnq/I/OQ8qZKs/GGYwpGRNEYMihJ6dcdys6cjS6Ytvv22kuc2HBfzI8tA7nE73oVv/gSros8hmp1M8VAiV5DWc38J6H7l/K1co2kKFMbx/uYGz/ccpkY4Eg8/rZBV0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722047; c=relaxed/simple;
	bh=YBaXosnlYoxfqOdoTDewJ8lp/ZRQ5lfcJesq/VckaMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EB2igMmHBo64jFPLfOfp8hH0VAmitnc+7cItVQ3GUFyJz6IxNeuCzqxVPbLq8ODoMPqDHHckMDAL+ZxOI3oqrDzT5XsdWUaEWe63Gsa6f/EVgcz1QGFlDIYK79+Zq6do3A9CDBsYLDPLOIqJB4GrxXrHWP+8yc5xEf697dqqs0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IFP0MhxE; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7fUdAmCvifb5HVoqV8tFPem1Ocq0hELVmthlWMY7aAHbRNgTDNad+fZ1w5Tidflqq70UEhqnZ0O3HDdr1SCljASoGMAYu2U8fzqnJVbaAf9K0XvEQu4vTg3UTyALK0cRmMWA5f/puijScXk3UXnWd3CLf6H+YPzNXQmZCJiFVkyb/Rn6xkxwm1IuRR/rpiiQ9lvmYROfG4see74PftRGJ8o/CB7q41QCziWd9i+syi6zuxwqSgZhccxDIdYH1w6V854YQ/YP5am6aHzI8GtYrbP25QZMi0AbWu1r2ZZGSZU3+BZ9uaoVOtgArwiDI9Xsotd+edNKNNl1YgHHKgDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNfVLYnHUMgY755sV0Sp9+69FAaT8tvLDJ45aeDF0Gw=;
 b=Z/QqJexQcq0vItjNLeCo0Szq0IQBEQbHvwSkiGNo1vson/eBsAtlD2gRjktwvCfuL2dkQkctP5UBr6dmbEyCw/9vTUYmbKdjnKQb0cHCuOHv6bldxyEjK5q3sBeiEZJ+YfSXg/wbDKtazTJ13kyc//LQZ2d4KiDonFyNvbzscHiFv+zANeRjxzG93uSU+5n73dFNb29boc33DRV3lvpKcB5amgdiTprad3tqBRusHEzl45afH5mAVvmUpT3it/X43Kdwv+UWMSCr6O6GuhQfHW2QO+vcHDVeBxV76+BoXgqvlHG8wnQuF0NxJSPcKCWUadGZPhXaHjgsCu8uILXcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNfVLYnHUMgY755sV0Sp9+69FAaT8tvLDJ45aeDF0Gw=;
 b=IFP0MhxE/tTxMZpzwFQPXiDh1mHv+T5Pdq8/oc/G7nZN+SF9ABcVpc52mSI4UUQ6lJP3ERTqDHeCMlEW2AhhhGS6Uthq6ZnG/Dus2OGZZQCSjjGqwFz+q12LzKGGwL+yYsqWsg/qgyD7lT2vfvXimpCuO1pVXdJb9pJsoEjLgig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:14:01 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:14:01 +0000
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
Subject: [PATCH v5 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Thu,  3 Apr 2025 16:13:36 -0700
Message-ID: <20250403231339.23708-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e57ab6-b78a-44e0-024f-08dd73053804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MzI5eiHmUb67L3rtaBhuRFm6Nus12c6bSTKjyGgaZi6wx6zVu4x4IqlwYlk?=
 =?us-ascii?Q?ATgYzbl2mCjAtvvrm4gqW+MIxdAnpgWE7cF3nkheJkkiSveJMfrq6HcQSwpP?=
 =?us-ascii?Q?UFzo+mPh00l4lLPtKjj+Z+Pk0YNxfibYNIAb9Xil6CdBoxMhOwFzUu6og4hD?=
 =?us-ascii?Q?OorpUJkPq6zt9SIn0n0QVgyote282lLlKLVCj9RL6Yzf/geEIlPlNX/T37Zo?=
 =?us-ascii?Q?zPSunv0wmh0Vb5PB73BP/EOmK9Oe0gPFkEHnKjiI9bFu7cUPPBzXJWWzM99R?=
 =?us-ascii?Q?R0+RbrlJV+bK93v5UkPXIQL5Cd1E0vjqd0G0gAPm02K9HkDT7L7tEFd7fVgF?=
 =?us-ascii?Q?/iLlPO6GD0XR0LoFZ9jdQmhyA8oGM2Frf4XWWm2M/kcXnqFEuFHgpB1CrRdz?=
 =?us-ascii?Q?fJwbzBHs10i+ENbppa5wh8f+85tMt39+KCI6k0qI9uyd8kQ0VanNvaMPAcNZ?=
 =?us-ascii?Q?2nRziYNDoECto31gkidZcFvWPZKVoyJD+LozMRjeW4xJXJsH0O1qeMyvunuv?=
 =?us-ascii?Q?welBisp9KdPhIqtgEGfLEejh+70NBZd80mkn2jwZeImYffxAeq9qQkVGH/rG?=
 =?us-ascii?Q?h1f0nRNInbxQATX0RDW/H5Nef8udHdMziS5XJ1g2rzpxlZ+DycjlqovIWmoT?=
 =?us-ascii?Q?xPPR2qMTAUjXcwed0eg0iiOli7xWuXxFYTSwE7z0QqjVfVpncz07cBvjh96y?=
 =?us-ascii?Q?1EX9BTApmmwV+YzUqJ6ncwaPZpjpPrHEmoGpq3eIqh2Qmic+ta06x/GRLmJk?=
 =?us-ascii?Q?GEU1ERkObYkoWBOWBgsndGA9+fv+D9bkU5gEVlTgV4Y3ZqHOFtu4Iw0eZ7ym?=
 =?us-ascii?Q?kiUrbb3sTRVdro04gD6cINT/Ig2Ia0cl4XXo3GpNzOdf++PVdFakWkLZRTdl?=
 =?us-ascii?Q?vpCvNrSt3HEx+Xkhre2AscN6J74u54hofDJHGqIQhNqu8jy94fwxcVJ5jsJt?=
 =?us-ascii?Q?piYTjgcADdek4W6p4ceD/qy6JOkftdCpJiZG8pYwvy4g7UZCLzz9rp0tx4g6?=
 =?us-ascii?Q?1RONw0I2PGESWbOerrmLbW/TnXuGGuIlTyzDLy3GG1bJ97DjDq7A8P8gg0HV?=
 =?us-ascii?Q?RP6jFXUu+AwOVzRT7lEqzFChgMw++ayQfsOPz3sf48FTtqmeTXCx2aj+DELm?=
 =?us-ascii?Q?wTH848erwD4ei5epAr5g+i4oRuALZKWUspD5Y0sUbMtHx9Qwi0LpUT+NSiQp?=
 =?us-ascii?Q?8pwKqme71CpJVX//wCvSCZTSSTpd8NwQQ5firtQDXjWB1HDqayHNXaGCjMME?=
 =?us-ascii?Q?YXZzURDQtCfMq/oQeZUQ8FdZBsSOQ0sMCsspo6a/cTD82iFawKqGve0+igQp?=
 =?us-ascii?Q?ero2fy+1KFQP5bb4prG+hGVm4YBzQxJAHxfIWHbDMHKJioqyEOhaeocZ64iU?=
 =?us-ascii?Q?Ku6q5yOq0VUvtb67H9M1t9NMmep1ObdlHfR7Vf4cgFO0bCX4yK23gLEZzkEv?=
 =?us-ascii?Q?j1Y4WVoWMMMS1v7AmQcxkFWUIi/3wqgHEPeHPBVr4EQcIWpWIdyc3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?caCZfXspToDjT3otwfqqIDJKX5jkQPIYV1egExu78Tz9/KTHEV/PXrS5uJof?=
 =?us-ascii?Q?qz2s7SKeRxtRotKTvdxmAt+quztOdR5Ecnz5DkpWP8haau4YhpdRSZJ0SV2j?=
 =?us-ascii?Q?1k5xAWqA87muubCf/7i4ROoKw2Q2ViqRDYSM8o1b8iehYm78BTsfiSv/MwcG?=
 =?us-ascii?Q?EAZJ9LN4iEfzyrrA0HFQn8hPkDC241JXpmICpnCdi2n5hy5jCB37WR/QzCDt?=
 =?us-ascii?Q?T16aZo6ne4fBlPAnPRrrzNsnthO74l1tr4oAvTz71wNqGT3iaXjUVWdArN3L?=
 =?us-ascii?Q?9jl4oaEAsZ7qPfQtNQkxbbB7QZ4kdihDgnynBenwtZn4XZGUVZ2d/oHRIiM2?=
 =?us-ascii?Q?nVMJGh1vPDPVB2sz7pQfYXAqu32t5FSrTvEu99v+vB3p6zI6oV32xlVREl5Q?=
 =?us-ascii?Q?gkhUdb9V+KfRYt6qdIdd6YANZdjaAnyvtwXdIb9w/0/+G9j+tyfiJxagNvr9?=
 =?us-ascii?Q?qTi2YHNRphg1BLydt6bMw3wAqBL1cwPDXWB8+2y4lcBuMhPXnbp1N/wBERnJ?=
 =?us-ascii?Q?2j7d/igmpNg1IcYV9eMc8g2c16hZt2slMDKMFCzSPjUJoGsc1KTkMEfQbNwN?=
 =?us-ascii?Q?imdQdI0P/FfnqCs/YNKfrlefdeZgUMTA5Fif/hmA8qayPj/a4OSdYGJqhy+G?=
 =?us-ascii?Q?ia4WPMD6kLyfcqNhZbJloNv6Qe+7wjZzOTHgI0tUj8HVPwi7AIqtx3a3OPqX?=
 =?us-ascii?Q?b199N6PwPfxDUCUn2H0bsEgVk7C7AJwSuv5SYUXsbJDqIStX12ChP1pB87mz?=
 =?us-ascii?Q?MHGbqplXfgoLuQcgX2gMADXjpSNAuiPlj9P1P7UvODK9CxUku8KOs49izdt2?=
 =?us-ascii?Q?m4EtxS7FC4C57V3JaBGhL52RWcdOU82fYhantPss+Zc3MHhDLm6ndl4FNdcf?=
 =?us-ascii?Q?7VKWVYbWT3nZnIULe4hCGPTjF+Vfnd0jN07rqMHrNLabNwGmHYe4Wqb+FhNy?=
 =?us-ascii?Q?b71lpoHLUkQClqiqnbhF58tPoPo4lttnws2veMc3of52M26CDUh6uatu1hl4?=
 =?us-ascii?Q?uY1m8xUzOGa8RsZDwRg9xL8lX24TV4aQvx64FedOvKDjUkyImRPF6Ek8pXhx?=
 =?us-ascii?Q?1tjPOaRyOt5hP27akBZKGR1U19k6x0bjtjRn24ctxcnBkYiYs3F023MBykjp?=
 =?us-ascii?Q?EyY354swe3AJRFuHi2xMp87FixURfxE1ITh5eTpl1CwF9IHg5e4RpupTtcsR?=
 =?us-ascii?Q?B5UU2+3yWipVgD+PPXmiQt2M43G992Vw3jEzqkyGU2vGK66O3sESEYJvuOKP?=
 =?us-ascii?Q?UyES0Xu7vGgpNPZhoF3pOON7U43tRUN7hcgbTT+VLAhugtPlY5NjIebjKlpx?=
 =?us-ascii?Q?r88XDK45XbkmAFOPeWQmmSeV52wKSWSX2qXO65VWqD3Bujo4liwJlG3IhyC4?=
 =?us-ascii?Q?7ZOe28+AJoIfIyp7HqdZlKgrj7S5RtEayDDeINLw36m7/tC91uId/jebsi5J?=
 =?us-ascii?Q?VfP+TrHxAPO/8XFGVjLe77sUp8v+UuUFnHrkv5AZ9Nd/8mtqgb3W5TovSKcy?=
 =?us-ascii?Q?g/kKMQaYz3AsqXlo123KcbzHW+THZJweyeZPjreNGkKG1CyTUFJHoGtVDrkt?=
 =?us-ascii?Q?7ebawwb5TyG354EmXAEWf4gY5H4OSvVj3yoG7AGdXy/RgoUxFpC8AH41P3wg?=
 =?us-ascii?Q?WtQL9lSaX5fnGzANIkETCmA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e57ab6-b78a-44e0-024f-08dd73053804
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:14:00.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJX6IXB1c5ArJK3XXg7Lw394xIIXBodJ4RP4ZL2Gl7ZCmvVW/ZMbHgbL+ihEi4SH/Eu0J8h2TH3TUj+dugH4Ry/lQdeC+vQ/uZ9bhvf852P5jUS8DUeLPa19KknborA+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications(1) enables
EINJv2 by extending set_error_type_with_address struct.

(1) https://github.com/tianocore/edk2/issues/9449

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 0d99f9951c03..d1ddc82744c7 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -50,6 +50,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u32	acpi_id;
+		u32	device_id;
+		u32	pcie_sbdf;
+		u8	vendor_id[16];
+	} comp_id;
+	union {
+		u32	proc_synd;
+		u32	mem_synd;
+		u32	pcie_synd;
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_extension_struct {
+	u32 length;
+	u16 revision;
+	u16 component_arr_count;
+	struct syndrome_array component_arr[] __counted_by(component_arr_count);
+};
+
 struct set_error_type_with_address {
 	u32	type;
 	u32	vendor_extension;
@@ -58,6 +80,7 @@ struct set_error_type_with_address {
 	u64	memory_address;
 	u64	memory_address_range;
 	u32	pcie_sbdf;
+	struct	einjv2_extension_struct einjv2_struct;
 };
 enum {
 	SETWA_FLAGS_APICID = 1,
-- 
2.43.0


