Return-Path: <linux-acpi+bounces-11914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128FA55B14
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F227AA906
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5F2803E6;
	Thu,  6 Mar 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JTgnYZp5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185127FE65;
	Thu,  6 Mar 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304931; cv=fail; b=jFmHE9AMjJjAu9lCcoTsT68NwEAeeBnINv61CwPl65N/PEBWFwMG/kTXe2zZpDBJSzSZ1d+MzJioA55uS8ZOkkkZQ2drR9S4Kj0N9h/O8WLPU+qf7x+1t3bJseXSwQ5nl/NLMQ0GodcZNG/melckVcT/W7/jv1Zf2Evhss4yON4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304931; c=relaxed/simple;
	bh=Ci1ocy/eGT4MLQV9LR2CVQ7jFKemqVtB+AsZkxXtWEs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tpszbpw0FffD800ny5ApQetmOdbIl9BTdth7kke7kQ9fiYv1sAC5Es98+YkdHuBH6R/SZ/ca+QOFLPzBa23zQwY9TZbBE8e7/gqYiDEuCR1urWGHLvAkdf4CdiMe4HryqwIG59v8ewxxo165Z+7G1wjKYgOTp3QpmJxVaRTWXFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JTgnYZp5; arc=fail smtp.client-ip=40.107.223.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma/dc48IfULt6onWMem3paUkyND9d2ecH5sSOsW4U7fBXE2c3RLYZv3bHccVcVBYX/HwNdy0BVpV2PUe+8mmDObkaylSDaIpVFtjhmiM8PgzX0K2XxGBoOCCNj5USpbfJBhUWxyZHKDEGWlXMJjGosAWhuK37e1HGZXbETBJuvSUgNFhC/lS2rAxHhbsmL2iaRTebEf341a+L0JnP/DpqyW6O0ZlGyqLDwrsLKO8vATXc/jIDMbrjS2KjziDoNnpqj3woY9qobPObQfVafD57zkXvaxlYVJKOTzuLdOit1TsdquL06iUXKny5abm30t8sUZPKSmSSGjXHZNp9uxyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxH+2b1UGrp2X8mlVbenHlkf6qZhNelwffEq3bpK/5w=;
 b=gdfEcG4SeZpcZGXzb4jh4HKOr7yWX4H1AgOM4LdbFLBxa8HoHWi2PyV7r0jUL1C0dOmgRyo7vitKLQBWxHgKy2jZ9Dy/lm3HkbRI51vxKCvdglnSAhLWQ/WSKFaePmT3f3+K/dWLXv871NGOCCw3KEs3Y3fWhcIk1obsXQBbIodNqWRNLxAeJTGFXIr2kjv0iQPZIDWuhur1dJqn4wCdrWHPWusC9T7mdTGfAfeHA0fIQ3bBOnanRWsosjSwRfO+4bS2LLSQYK9pOIgp+TKhA2VILJ9aGE9w+vBiu86ChMOzxLXRVbR9MEPECxhe1RrFMMZf0K8yvqJ31pVishXv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxH+2b1UGrp2X8mlVbenHlkf6qZhNelwffEq3bpK/5w=;
 b=JTgnYZp5igHHPoS08GtGlxYf+9w9nwUbOAStMlJcf8zKdusL/PyCUO20mmpZMfuR2wutpKw+nTnCfhUMKDShJopxmHcUbhOahu5g+1z6KLy1yvu4cMx3jfvIrY+OH8bscUVuufTE8TPJr+g75VSf9IUMLVSxfpBTIFQCGuPOxtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:47 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:47 +0000
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
Subject: [PATCH v4 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Thu,  6 Mar 2025 15:48:06 -0800
Message-Id: <20250306234810.75511-6-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7029fbd6-fc6d-45dc-4fcf-08dd5d096fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yftyk4fJJhNRMmPms18QTSE75238IHTi/9VadZ3//F3tidkHiRjPB/94c0H?=
 =?us-ascii?Q?wDOaaM0BeY0fQZWECdX22DXCV5r/PaTRXlJursFbBg6K+h4Gf0uH+HEp0C53?=
 =?us-ascii?Q?+K6S5yHT9QrUQKQBmjsC9Lk0oiYAzVtbqvnODpSAYzocGzrNmRhtwojGtGtN?=
 =?us-ascii?Q?uy2noCRLg6J7KR6OrUEDvSmkYevbuXoQPHaJaRTFZfq12sfgfyG6MyzDfY56?=
 =?us-ascii?Q?ONXsPqyx6wZu37UvLHXI8kxuwYuZPAz5MXdMQwcg8kRaXpTAYcpYmyH3dAjj?=
 =?us-ascii?Q?i8IoC3R3SQKYbnzON1R529ohSGqQ/FhtBzGjQcw/fhPAIcqggsppu0hK6+4C?=
 =?us-ascii?Q?4C4jLtokfvfv8klZB4gEvhF8Y9bt6Rn7FBcrSYi/9Kpb0+omljzyEpBw6tG0?=
 =?us-ascii?Q?XBObdK8UsKJUXWAVw3wd2CF8ARyIUlBSMFOYrP3eGk2UoFv/+GzvAi91IeCQ?=
 =?us-ascii?Q?S8VYt9dx5cYzPTADwuAtVD5HrMDLvFHN8FmLUyDbVwKG8w62Ho4l7ud5TUyV?=
 =?us-ascii?Q?7ZO6mCXr6K6160DzL0dcJBx+ivfMXXABkxVhtl/uwo//C3qScYekhnPg6ShG?=
 =?us-ascii?Q?d4wvTBSTGnSbasJrYuHwuHEQgtl1pNl9Y4Vw4u5lc8PYAueV2lqn5aV8FU24?=
 =?us-ascii?Q?aP6Vvw+ZQOykRQ8uELo68Ia+SkDJrytnA1A4f854sw16n4DVYt3IcNIbzkoX?=
 =?us-ascii?Q?zKZdnZcaxvHM5dYk09fj7osTwFxRNqTFEZ/k0hgegECAnw9JjgOrSYAME0rW?=
 =?us-ascii?Q?5/wFCZHEf7Ir3pvnJGBxS314myWTEKGsEody8T3GH/Ic0FgBDRh+cjF1dh+s?=
 =?us-ascii?Q?Tx3bMp5/nyEf+0Btael2NWjb1q2ybHwHy6Kw8LdPxTE/wlHRQVHH4hqi8SCy?=
 =?us-ascii?Q?2gHWteJIERYNSGvn3UPsIg3+xWig6inF/fF47I3ZVC14kYvJBlRLOTdWVggS?=
 =?us-ascii?Q?cyJjAy7mlKWeObXIZHbbLuq/Xi6JdtPpfHiKp1iTrOw1EQMYmS31bluMSTFI?=
 =?us-ascii?Q?Bj+ScM6fEeKRwSmoQLu0LVaC4mUf+w/X30C09Vr3qHMSeKNQqgvQWh1qZsq3?=
 =?us-ascii?Q?0700u3DSgRKG9gGXlMQxRtLzz32UMetQ6wPj4H1D1vXHFRw3+LKX8Pec1cOU?=
 =?us-ascii?Q?diqtqkZxBMYdmXcV71UJhhnpTL0dUPBi+hF3qKXRfTwqfSU3hfB94NzwNAqe?=
 =?us-ascii?Q?Mxd4jXYv7s5w6FVW+P3mXJyrx9tZ9Y0ubQ+tfLmLjkaRuLld820do9KOgXi6?=
 =?us-ascii?Q?59eW0Aw/KKoLxf0y+BnjdhjApWqznHxidP7fMeT5+UbNefXPeeTkk4YwTuOj?=
 =?us-ascii?Q?W7qwudALnLZBr0z9VgPpGo6/TmlL12G4ArDdFJVyqsUgGeJGrVwog46RCU1B?=
 =?us-ascii?Q?1W380QxZojXW0eFwX5K1oo/Paq5UxfvnMEgNVxOFsFjip2N119UWGYVGB8Ja?=
 =?us-ascii?Q?mubzg9Lj4q/yJVBgkOTUOQSdR2az5NYfh1+PmDufh83swLohg1Vp7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CufoKjXwWk8aYjFs9jp0CES4o1g1gYcrvpCa+ZEDw9IBzKr44nCbfZQCmcCs?=
 =?us-ascii?Q?vCbBmt+Yb7AEEOSk94BrXYUsld0RjOh0AkIIa5/eQ0ABA3QlzPoAJB/MxQ2e?=
 =?us-ascii?Q?NnEBBOiqCK4WTIV5iXDliNDYOvOvNJP52Wau98hbmcYXFEMv/RIj7IypUCj9?=
 =?us-ascii?Q?bsslUDWKrfH1UudmgviGRR4gHmzE2trRZ49aKMMELoJo7TnkveXpKXPkBBUp?=
 =?us-ascii?Q?ScUnmCAtJkMoPrrFdL9tqtzLU3DvDtNyF9teZjN3LnqW/QtHEe9jHV+fzsLa?=
 =?us-ascii?Q?G0LTmbDn2/2pBQrow/IvqhnMimK4D6S+hp1fsJHh1Ryho7r9KYh6tvXJ0hZ7?=
 =?us-ascii?Q?TiKDalnZsn1IUbH22bX+COMO2jCLrl6JgPgZLcPnlw6m0lhCQBWJjVfn4RE6?=
 =?us-ascii?Q?yZzWLNF74laXdUKWtoKRRdvAvy5dVb4+mWpWrNBfj8RRrkvTaZsDhHAiOQCV?=
 =?us-ascii?Q?dtt3p8JwZThl3LUvSrhIbkEu2iCCsR658nGoVEfoE/L5m1WzQfCHAcBG/+Zk?=
 =?us-ascii?Q?4YcergVgTIi7jMD1fTIn/lUrejDk7/ry4vydje0U+Pmd9MYCwU2u+6pAj09K?=
 =?us-ascii?Q?mhDo3wLQmsc4yB0EzOFYmZ4cEomeMxKx3zclXL22soJ3en7pZWcHikLIgV8N?=
 =?us-ascii?Q?1LwSpybVVYNBSTtI6hhBobeCcgONUAH2iiAbYUNiU0xc9d4LkCKCdwxLfvMW?=
 =?us-ascii?Q?D3kbXtUboDbJa+iLM9VnVllnMemEjRr03EJ+1rJW8qRksudd/gBMcwM9zXJc?=
 =?us-ascii?Q?TlT7a7G8a37IBTmrbEtVKXQiSigpdASbN03oIZUxvXpqFEKEyxrVUs21kU7X?=
 =?us-ascii?Q?9i25yE1zWQNn34YvS7wPEZSeH6sFjeDW2psDsZC1sA+BUHO5gzMEj7nyFcar?=
 =?us-ascii?Q?aTS7mKBYjcN3b10qWXOYbSJS0GpvUhYjOAhY9f+k6wOk9w2kTetohUvRIpW0?=
 =?us-ascii?Q?WsSWPFBir8TDC4mUiEKgEl8QkUq+Fe3yZ3VuDgpntW3C+OWuKyOp/anRa9aD?=
 =?us-ascii?Q?UjzheFl0gnKXToAQ7PIgvvjvxdeYkD0bC19VCHyJaYaRhtiGeE38IW/RHwb4?=
 =?us-ascii?Q?sbXcpogU+DD5LYAoEzpd/oE5wJQMqUhswE9cY/luMTK4CkWoPF8IGQ8Np8h+?=
 =?us-ascii?Q?VcY9Z1LjvV9vGl7kO1IrOm5h8aTSdEafB4/aUA23Fy4Bc7Ki2amd0K4ZrDZ6?=
 =?us-ascii?Q?+k6PXqWzAWl0U0AHaEHmd9cPWX4+WAsY6bscEbqqiUReawBmGl67jPqddSXe?=
 =?us-ascii?Q?WcVE91jGEdoLjNVDK9uyA9H4eL07eWHEqhZSrM8L7jLweJTFeFb4PHaAvk/p?=
 =?us-ascii?Q?+WOrBU2YfyZnBHgczyeq2l8v7+jN8qaKnKt0lCfsYlXW4dRFRfTuSRaOI8gJ?=
 =?us-ascii?Q?1W+dsHYuYmWcoeRBklmZvyT8cDpFSJI2OHKOL+ao8mauStvRcFa8YkSkNAqV?=
 =?us-ascii?Q?nFy5B4j9KWfQlaOjHeC7BgAh+YrQan2qPBQp34B5a7ql+Sm68+KNG0atC7I0?=
 =?us-ascii?Q?BFvZEOBG2r6M0xDE8zk1iEVjIBTAL6yOHQeWPj1YImgWbcKvrUkxD/ljo+yi?=
 =?us-ascii?Q?IMwYxpaUqsVOseyxOCR4ZMehkMLeFg0cOnbdb3t7561JOaGzCD6YIzMkd9jS?=
 =?us-ascii?Q?jKVODTZMugSFVt8U+/dZrxA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7029fbd6-fc6d-45dc-4fcf-08dd5d096fd5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:47.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGPRDBV/5rzRi2iTiXlO4BmcS38a6i9B5Z7HLu67TfUDQkvc0RGoSmxkx/0kaUMDGbQPNKrvi8+Pgr+S1WgRKgqowJMAD554SRMXuoV0BTFiKegrseHxmQHkb+ohy3Gq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 64 ++++++++++++++++++++++++-------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index cd2766c69d78..77c10a7a7a9f 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 
 int apei_osc_setup(void);
 
-int einj_get_available_error_type(u32 *type);
+int einj_get_available_error_type(u32 *type, int einj_action);
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4);
 int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 3f828f9265a8..aee9a7b17313 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
 static u32 available_error_type;
+static u32 available_error_type_v2;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
 }
 
-static int __einj_get_available_error_type(u32 *type)
+static int __einj_get_available_error_type(u32 *type, int einj_action)
 {
 	struct apei_exec_context ctx;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
+	rc = apei_exec_run(&ctx, einj_action);
 	if (rc)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
@@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type, int einj_action)
 {
 	int rc;
 
 	mutex_lock(&einj_mutex);
-	rc = __einj_get_available_error_type(type);
+	rc = __einj_get_available_error_type(type, einj_action);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
@@ -646,6 +648,7 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static char einj_buf[32];
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -662,6 +665,12 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(31), "Vendor Defined Error Types" },
 };
 
+static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
+	{ BIT(0), "EINJV2 Processor Error" },
+	{ BIT(1), "EINJV2 Memory Error" },
+	{ BIT(2), "EINJV2 PCI Express Error" },
+};
+
 static int available_error_type_show(struct seq_file *m, void *v)
 {
 
@@ -669,17 +678,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+					   einjv2_error_type_string[pos].str);
+		}
+	}
 	return 0;
 }
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+static ssize_t error_type_get(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
 {
-	*val = error_type;
-
-	return 0;
+	return simple_read_from_buffer(buf, count, ppos, einj_buf, strlen(einj_buf));
 }
 
 bool einj_is_cxl_error_type(u64 type)
@@ -712,9 +726,23 @@ int einj_validate_error_type(u64 type)
 	return 0;
 }
 
-static int error_type_set(void *data, u64 val)
+static ssize_t error_type_set(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
 	int rc;
+	u64 val;
+
+	memset(einj_buf, 0, sizeof(einj_buf));
+	if (copy_from_user(einj_buf, buf, count))
+		return -EFAULT;
+
+	if (strncmp(einj_buf, "V2_", 3) == 0) {
+		if (!sscanf(einj_buf, "V2_%llx", &val))
+			return -EINVAL;
+	} else {
+		if (!sscanf(einj_buf, "%llx", &val))
+			return -EINVAL;
+	}
 
 	rc = einj_validate_error_type(val);
 	if (rc)
@@ -722,11 +750,13 @@ static int error_type_set(void *data, u64 val)
 
 	error_type = val;
 
-	return 0;
+	return count;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(error_type_fops, error_type_get, error_type_set,
-			 "0x%llx\n");
+static const struct file_operations error_type_fops = {
+	.read		= error_type_get,
+	.write		= error_type_set,
+};
 
 static int error_inject_set(void *data, u64 val)
 {
@@ -783,9 +813,15 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(&available_error_type_v2,
+						   ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 78da9ae543a2..e70a416ec925 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
 
-- 
2.46.0


