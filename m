Return-Path: <linux-acpi+bounces-13515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C6AAD037
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BAD188E57A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF0241C89;
	Tue,  6 May 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sd5bjcNr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022102.outbound.protection.outlook.com [40.93.200.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463D221730;
	Tue,  6 May 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567526; cv=fail; b=BVGQmhHFRVL76/2rCXEYvpzQBLJT8WISM1Yf8tmNFDu6oiIbJwynLEAR7AZjJ/WTFtaWGrx8oEQGfUqG4JbBsAGyan28dEufXC2lpBda8ZkJNh5ruqQdzdYlZbwIsF/I/WYX7qFRcYhv8ap1dfCLuZgKlNczMg6co65kjPZJGe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567526; c=relaxed/simple;
	bh=3FJ6kc86temlRwsfp0EMl5MezDpLJrD0/T7GBKFj5xA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fv9b6uCZ+3gubnmUbvSAK+aH+VMlCPNrKGzGdtgIwOOHIID8Cyi5fs+tJjRWkZHqoWqA1Cja6TpCBDwgfPJxZD3HGUmi3F1K6eCwT2elsYTRgMj1MGrZ2VbMSBuvdIYbT0ALDmWIgNA0jHHJR7Biwsa7l/cQJvKFNsgFuTUxAMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sd5bjcNr; arc=fail smtp.client-ip=40.93.200.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDLe6S07hInIgTQglf1eCBMW0k3w7XedIPsMcyoT4y+h0jTecZnLznpu4NlpKo5BP8zIbSZX+Smd0RT+8j5Stumxj4EzKhVxvhtQgf/e8FkHVYOGUM0UnhvjbRqpLum0uDltfrHUa84fXgHggMvonbfvNStPC5UDtsArg8qTr3vwiP2+gwp8KTtHvNP9OPT+Lgh4+gxEM2WPX52fwlwhaeCyQnWSSRXslg1OBL5LBoqy6P5JwANHSAK+HbU0T62ukcJC/sXu2cQ6k0BjSgIelRoNMqUsx/Nn4PSTyXe8iOujQbbE4HFhRWfUWvun4th2zLQJcDMn6Hg9KQrAHNpb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9M/7JcXadP6ZsesiKWkszLHTNgFbvFdUXucFU5jt3E=;
 b=aOSOEA4b8bS5mrADaJaGxxirLJXu88uGieCS+zm13vpArUbj+Ir+AhZCWgAchJpbyCbn0CfrrqER/TRHZ5nX33pUaJ6XuaZq7XdTrmUHA6l9ipkruRbmvKrW/h5sG0i/4tj/3+ydeGa0RgJiBPgC6fCAn0wLqhHMKhHOzKy+B8m9LqT4S4AkXNPKGo4FQCZ6xTNVCAxFE/KYXcHNNyHfBEvIMFSSS6ztQIIp74Y3LtkmM+Nb93ZTYE36MXWV4hYdJS8lDVn8ERe13y8P/HrvKEr+DUYPiL/STgv/Zy7/9+TikOYl373tLi0cXNr7qXI1wXMKpwizSDjUlf4582264Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9M/7JcXadP6ZsesiKWkszLHTNgFbvFdUXucFU5jt3E=;
 b=sd5bjcNr1SsdfDToFRprWcqnbcdU7+7LjUlaCv/HZWhTCLD9cEVFgU72D1Z14tY9OBkYI31pN7kfPqGpj5FjFqo+3u48bPlcXfDGmlV/IiHGy7Qd5Glr5J4NNvwUkTVyX3TeWcVI9pAQZh+Fic8mZRfMIKg8uCQ5+zPatorg1uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA6PR01MB8904.prod.exchangelabs.com (2603:10b6:806:430::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:37 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:37 +0000
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
Subject: [PATCH v7 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Tue,  6 May 2025 14:38:11 -0700
Message-ID: <20250506213814.2365788-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9beba40-268e-478c-6267-08dd8ce65c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+Htw3mNVUb+VrqwHDIcenGjzDj6iXJPcWszytlcsVJBkM1eWsJhPaLCH0Nk?=
 =?us-ascii?Q?TOF3xZA5t/QshBgU2CWambN5msB7VP7fR1e8rmk46ga4qC0DnKkJfgUdtFsi?=
 =?us-ascii?Q?a2PqrU5C/vQtn8JJIP4murx1aBuL4yiMTrAWiK8ogTtxd9VibpmXArMhrW+X?=
 =?us-ascii?Q?Dvx4wPlYViOmxa+4QGc+eyHIEFt13uIQLqTNyjn5VQ4YJIXtkdfzdCvE1MJ6?=
 =?us-ascii?Q?fP42RLKsHXw43mBUaRVmg6yQWvu0PNisBDUocYBrlSSpDG8flIkwGlz57mJh?=
 =?us-ascii?Q?oMtvOnGKMjJpvKLrZz7e2RDLGEjbL2lraFnk8169P6MqtPVB21mBlKt0Axj+?=
 =?us-ascii?Q?tHvyeI6CN0I3bWDSG3X6mLzL2e2+wdy+UJC0VLbxNkQaU61YGOz8Xo3tH8Ye?=
 =?us-ascii?Q?+j4gtTKIXnTQc9/VDHqlYwkj/NZ2ZKgrrQkIDhatRUJJYoVrPMWjJJUZ3DfK?=
 =?us-ascii?Q?GgTKHyV01KI1shHDDyoRX1mNgmDjEEG6rtRno64gvjIjWmg6jwUTGcWdQfEz?=
 =?us-ascii?Q?8pgFfWBsnTbbWMHxJFhaA4Bx27PWiSwY+PIEfNfahEvnCEDlpcmH+ZV3DQ3E?=
 =?us-ascii?Q?nVCTfnUXFJsba4SjyqPbFLlzlCSTAniPlf1wPXNNybvVB9LQkU8SaeNUNYvP?=
 =?us-ascii?Q?JgSVFCsUghqev196fvVSTs4cq8pn0e9smM8rgN7HU+625O7obnpoBMJMyO12?=
 =?us-ascii?Q?kF4ikOw2bC5ndrLi0XE4fYynIkZBpAO6G6tZeFADgt9a/wBVHmwy/inzRRcp?=
 =?us-ascii?Q?O7Mk1vx76E8sawghYox3eqHw5/B7SWtlCQLndCQ6Li8yRrkHgAiul8huMsmU?=
 =?us-ascii?Q?o+lMdiFAYFJVYUJh1qU1GtdfdEZgDuvmPRW4mowBl8OJUG+/7I1GZ6a6EyT/?=
 =?us-ascii?Q?3jiYL7vBBV24RH6OOQNcSWsRjZZUHbNIFWpgU7jZU7Br9jLHwBge9MNueyzK?=
 =?us-ascii?Q?zDayTyzfPY85j8MLRIZvfMoCrAfr6i/lu80Vh2AG7lYqeS12cjVV5/8P8cJf?=
 =?us-ascii?Q?TpPca2Kyy08bwGH7EOAQIY0lfdGkOQaRiMTpwdZemRrBsR6+gGN4gSr83wpO?=
 =?us-ascii?Q?MjBc6gwsP+7xxOCm0zlwQO0Qkg5WrV8eZRCCEirNYeqYFuiXKy7qlAwdFsFN?=
 =?us-ascii?Q?ejSHohgAkrLaCqsLLeHjzSnbCyAtt8pcayRLt434fA0n5QHzWUbsKZFH5KHO?=
 =?us-ascii?Q?n2iRvBj2MMqq/DoV31JFqhd/dr49g6gfHYQTVhNcjWMhx2nvqMKY+M+fyJIj?=
 =?us-ascii?Q?fRCKv2Rm5hopQ39Qb9mH7MmMDZTRMl5WjQ1xI9aJeTFK90EIprYUweNmZl6q?=
 =?us-ascii?Q?gDObJE1nI4h5ssgkWkqrkFUb6h8ADfgDB0SEsHDjm8g3CLkrsiXzRrbl2XaJ?=
 =?us-ascii?Q?ckqgqQUCSCp+O37NIr4i/jhmC8/b3z9pF7OIT/gXNH3Iv8RvqR4FdM0iKA67?=
 =?us-ascii?Q?+oO6v4TE5CsmNfGoAgCt4kyPaa0ILuuJhVk2VKKK6wRQ3GwemYyIJpfQ/vIT?=
 =?us-ascii?Q?iQIWTpxpxuuvzPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IBIQL2njeuA0iQWGIXc+rAWl6oUZwv0wkiL8UHyk23aI+z8W2InPUQHJbIQC?=
 =?us-ascii?Q?n/HBGJ0SH/oEBFKchgL3oCAuh3VHFO+/lAXFnkLamd0yN2q4XrSDYH0FLHX2?=
 =?us-ascii?Q?Yx7D0WD5kwd/7wmv6py2avlS71P+WdvltLi9wSuCrS0UKgDPTG4T9WqhZURH?=
 =?us-ascii?Q?NJ1VHTvfrXH8N1/7tNUKUyPZiAqz2UtIxjlC/fpT2eFzqyT9xdDb8PbqEiT2?=
 =?us-ascii?Q?/8JnnCaq2g7HkExj7TYLfAaD+CUO10vGka5ncd+dMZ2l5HISjNa2Idh66SJm?=
 =?us-ascii?Q?P2nvR3gj48nt0JP+Jq2VknbIPaAV+BxXPl0wXzQi0usnzpfM9vp7asPVEARa?=
 =?us-ascii?Q?gQSWPIBJFNH4DAOBNrhpkvK6rmF5kXeVXjxRkmsv1Aj1TmwKodKU3ginqDsh?=
 =?us-ascii?Q?LmZFfnGo/8H7jSsmjO7gizL37h/hyBBcpwlEeEpfRTuYwpWk8rlO5W1eGDZ+?=
 =?us-ascii?Q?hPkiTCHgM5T8PQJIf89ab3Pp3PJp/q6QHh4p6DikgkOMtQHg8QiWoIC2C+Aj?=
 =?us-ascii?Q?OXu1zV7h+PvhX00qCWs6hsgcL0iXKcYhOUcvTHLmIlGiAad5ctmfJZqH0kKx?=
 =?us-ascii?Q?mxFtfNr04UsYFvHWjQtyiRPttj0U7F1oDVaLdUcUfPoPlW7wOK5Rq8aYf6bx?=
 =?us-ascii?Q?SC1kEvtRUUixf40KhR4XD4qw5InnWtVNE/Ov9K1kNS2r1isuBK33qHVzZgKI?=
 =?us-ascii?Q?PwD8XY5hvBgFj5OQ4a96BVQoU4Bs247yxxQx2hJ759rQyBBtUz7esF5OQFVp?=
 =?us-ascii?Q?toNXgvBbmhu1KZFTj/z9+3rjipgQJv9ShXvAWbeJ4CBehWwKdYu48DM0feqk?=
 =?us-ascii?Q?Z2BIsNScbm65FeUrGUD5A4JVIvc0VaLmC3UIggO2TjxD+7dXODyG0bDhmOJb?=
 =?us-ascii?Q?/XXunoDdSSehm38f1XZyfGuIZlV/MXnxjyA8HZvJs0a9RU3P8IWDeu48ZJG+?=
 =?us-ascii?Q?n2G7LC8pFFOyBUVMxDckco7PtVyXhGl9n5ApEE3YaH1sM4e2MS7eAXVugre9?=
 =?us-ascii?Q?G/KbNOi3u5OOZgBKwxkBmGuB9VuhVwGCq8syv4/p/GcL3F6hkWp9pXnHFtzF?=
 =?us-ascii?Q?z5rspmgIzzaqVfii3kkRmcJFpw2SPbXLYlY5vL8NbxSpUqdda+legTZJHoUb?=
 =?us-ascii?Q?VNTyXpjgqfrpEe7CM7D7W7YAd6bhKd74sIzRjTHShbtAfSdEtZT+fVWrD5ft?=
 =?us-ascii?Q?r8wtptLvH1atqucJ/nVr7SrLO9qjqxfdP3iLRH8zIbeCnkievqe56h66Bb/+?=
 =?us-ascii?Q?Wr0fF9mLa6tFkVmHv1WlPxRrO9JhKbNavP3z5+aogLnjHwZnELe3xYZtDCIW?=
 =?us-ascii?Q?tnti9ToRq0FJnpwjGQddqjXasKfFGt6yqXlCL6JlZzfZMOer2RXXon9nsRIh?=
 =?us-ascii?Q?HKgv/5yhSzm73CvH7/APeD0kI9z8+cepUUEWriEMk3rDX6h7ahZL6+4kKUQ4?=
 =?us-ascii?Q?vks1pmANiSxqZNYx/FTKfxWuNs2BHzZ/cw3l8DBmtWBDH0pTWWnvPQhzqIQt?=
 =?us-ascii?Q?JUY5z24mQ4J83NNs2nD2kFz/JTGSMwpb19r6an8sGP+5X2xRF0Z2ixM8tGC8?=
 =?us-ascii?Q?7f8gcmCsz7H0wo8gxENNXx780VxQS9iRon4PbJ/74OlgIcCvgAkHwqiVwy4W?=
 =?us-ascii?Q?QXVsxzQLxD58Mc2I5clnlBg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9beba40-268e-478c-6267-08dd8ce65c69
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:37.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW/GHr4Golpdouh6Ut6ya5qJt0RwTfPwikVumctu8cfN7v30Xz7keXwoDhK7UUyJd+Zxwx5frw60eZFUu4fdizRjHfYTIl3GPJK2FTDNboZiVpwlPg0y5ATpZ0/1f2A2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8904

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 60e4f3dc7055..44f9166c3881 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define COMP_ARR_SIZE		1024
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -107,6 +108,8 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static struct debugfs_blob_wrapper einjv2_component_arr;
+static void *user_input;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -689,6 +692,7 @@ static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
 static char einj_buf[32];
+static bool EINJv2_enabled;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -718,7 +722,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-	if (available_error_type & ACPI65_EINJV2_SUPP) {
+	if ((available_error_type & ACPI65_EINJV2_SUPP) && EINJv2_enabled) {
 		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
 			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
 				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
@@ -901,8 +905,22 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				EINJv2_enabled = false;
+				pr_info("EINJv2 is disabled: not enough memory\n");
+				goto skip_EINJv2;
+			}
+			EINJv2_enabled = true;
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = COMP_ARR_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
 	}
 
+skip_EINJv2:
 	if (vendor_dev[0]) {
 		vendor_blob.data = vendor_dev;
 		vendor_blob.size = strlen(vendor_dev);
@@ -944,6 +962,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
+	kfree(user_input);
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
 	apei_resources_release(&einj_resources);
-- 
2.43.0


