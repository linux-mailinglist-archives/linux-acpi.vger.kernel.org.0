Return-Path: <linux-acpi+bounces-13100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2ACA92D05
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF60C171F77
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824F21325C;
	Thu, 17 Apr 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="feLPAK6A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023137.outbound.protection.outlook.com [52.101.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546E1FBEB1;
	Thu, 17 Apr 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927236; cv=fail; b=m/8WjOS3epnrcuv38R0JGps+9SSwD3IgkSmvpX29ewiUPKhNbfFK3ba+gTcKKqHm5AgiVzIujcvtRA1FH/+KCXVJCr4rMUAKwxT8RsOcqKM4YwZa2Pts8e9856RarO49afK0JauKApTY+v6mVM/2v/aOOdQ8G2MfLewLZ1X1cLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927236; c=relaxed/simple;
	bh=N82lQgw0OOtW3DNeHdfoRKpC2j5SqL3vrku7Px3ILqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDDHaERDjJsjUu3vzslB/pDAkmQrDmXj9y0Ld7pl/59nO4We1kYmjZ64440MK0yR1ErDNTqWglLPpK0riI1AAqRI5OlRiOPPqWZXmRdzcqOoG4IU/Q4JimHup6iU93GKXuZGaJZ7yMddkWWWb97ri7+YxUUt58cDos5RPrkmGxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=feLPAK6A; arc=fail smtp.client-ip=52.101.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STesipW0BfH2HXfbthXquNzMtVNHNDVigU2inmokaUTOOoGscb6gSSIujBNHSH/xIGuk4FwotPJAH/d3oMEgPlaU+pbhLwOspqdZkPGeLdXr2J21E3qunZ6t3ZD7A+1mOYEbjagWP/sVC+QL++g80DYojbwn9hzVEorFIltWiOppd/vsnI7ooRsn6fwLtlIyW8wEZ+0Z2GczELo19z1otUMx9HY+efOZcYQopGZdmXAthH7CqgPzI3A+gMF7Dm7GlCc+DBhz3g9mACeIcdEA1ZC6cbhTK5VTEinn9ZYr8DlzmL/W4Br/CxxOAlE1orCd0es9OcmqeByg96xwv+BKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I6WwV15YtJvLaqmzSPZuA7F+ZEjQ4z8qExpNmVFSgQ=;
 b=fOsRzgEzgSFnzG91kD0f9cZzSrbG2zEYjg1wJUarOqRUjCY/yQWrtqv6yymdSig5ALZ/bOYYnC6rPUfyTidxs1aRuzCsKq4WJFHm15pWs/412CKhqnZRzDqsJHVvRQcBiHxb2MdO4zV0Jvs/44JBKYla5Kgt4zRviQgYpDvRe69hkDAdC5vjs4Y+xRhJWZtuNiagZyrf0SPT8ppbgYRSMbKvKvO7qh1obfgkCrj9Y9L7UzgLSS+YnIH1E/zM4+O2vzJMTILiIxaTR1GTV4pWJFGvY2uzqQLjnvZJrAiBLZdvAcVfXpeHMtw3YaoaKOImUH2EoqehnSQ2zfsIMLCTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I6WwV15YtJvLaqmzSPZuA7F+ZEjQ4z8qExpNmVFSgQ=;
 b=feLPAK6AQWWURnnwI7i04quO3O9bqn5Xdyw2OSAPU9OmSfVUeBZpOfaNT+OiY/K6uXn97iOuV8Vg6nuOSgXwVQRU2q8A+ITdZz12/C8twJLuJJP9VC6WQsaOzWZZw/yqFjQPX6q4D7OIkTN6VtcWnMmDm79jutHwGwvR1BCeRHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV2PR01MB7597.prod.exchangelabs.com (2603:10b6:408:17e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.36; Thu, 17 Apr 2025 22:00:31 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:31 +0000
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
Subject: [PATCH v6 1/9] ACPICA: Update values to hex to follow ACPI specs
Date: Thu, 17 Apr 2025 15:00:11 -0700
Message-ID: <20250417220019.27898-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|LV2PR01MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: e0578967-d5d4-4405-d1a9-08dd7dfb4586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LjVwtXqK4I+OzFZNx9gL9NHvtLAo55v6dbWWJrB4r1RzRuiRlXcuPqzro8H?=
 =?us-ascii?Q?4eiTG06kfTBJCv7Wi7Q1f4r9ZkxhrrPeGemHuynSqJO/Zvbt+zbw8vZ69+W9?=
 =?us-ascii?Q?bgqw77wftptdDSXlQ9j6ngw6NFQpCwoGYb5zvmzdWLirIuOdZqlzs5fkLZPB?=
 =?us-ascii?Q?UibAHhgei7mmAgc1iHGkKG2g2busR/hJ1gr1GxaFldajaRZ9ec03OUrx+5vk?=
 =?us-ascii?Q?APQ/8g6c4S5gHSLys8FSIazw0hjevcXwspnjF3/+dug5pv7r0pmWxucKZPdS?=
 =?us-ascii?Q?4mfPNjsYADR3m0E/viMzemKdXz8lvKfjyDDlbj8PWINYTTWLPi4TWaRJqQNL?=
 =?us-ascii?Q?n7DWiwcJYPN5ihCRCNFdTAgipAo823I5nwZMqJ2+Mc7G+U7iGmyNL9YTZOTy?=
 =?us-ascii?Q?87camLYfwwCQe1n9E8uoTsW7gFI5TCuX4P1iLPbXyN5W+Ymvq08Emuj2j1kE?=
 =?us-ascii?Q?Zik2AWOG4Brv4qvrtLzWK2g9viqL9ZFr1qa8qd9UT9zNLl1ycHgTmH13dsVv?=
 =?us-ascii?Q?9cosnaJh9hBfuew7kuA8Ypjc5ZSm3dJbqPp2zZ7j6gRSkQ5BtGtxRVYJWAN5?=
 =?us-ascii?Q?w9gL7/rePJ1pskawOZiOseaDQhQGgegbwONvyK0Y+4rxVUOqT5C+7Q7cP6XY?=
 =?us-ascii?Q?SF7BRmjGu7qzd4uVl5BfccZDGv18VCNG9uEwW45ro2jjWJyGPdeSMMxSznR+?=
 =?us-ascii?Q?xtNRNrJqVJOMxORqi/4C4OvoXW0GP8D1mw1VX+Z91KABUtD1dXHy+0Vx9Wqq?=
 =?us-ascii?Q?2cwO9eMxTPXZwujsPXhdK9e6skTtcrocAvfFG6mpCpdHmFU0s1EFH3FdnYnn?=
 =?us-ascii?Q?hQgBgFvaCQlPWNIQ1ybwByQeUNCzyl76aU0vgMfD3F9/oSYlDU4uiQFHsPF8?=
 =?us-ascii?Q?CmEZhZC/s0PxUgWrUlnae3FqAq2+pwBfKavWJAIDtHKcUzDZ91EvvjSshy75?=
 =?us-ascii?Q?ah17HpKf1Cpfld+taZhzkrazmQ/sG6VegvKowT9ZpGH7D2w8eExvfOUbYPI1?=
 =?us-ascii?Q?3b7Mre7AhO7sCQ6+6ggpg/SUck6VePnOMSCgp5DpNqxauBL0ceHOFul7Bc57?=
 =?us-ascii?Q?AmbQVwz6oE4fyjdDs0kuyxnSAqLxh/QbrWv+35FRj07eGW/OVPlT9qkplmen?=
 =?us-ascii?Q?HEIWsh1SMfQXojFPzgzsKPxwTy93lkWHz24skRFFEuziypnJygvNtZ2UtuKh?=
 =?us-ascii?Q?j4HS6wfNigh4FEuLRLXc37T7gPwJL62hE57c/SDMnBI3kS3JVziCX/2yEuSH?=
 =?us-ascii?Q?KSpUwsBI9oiCAjzEdeh2ovzQHllZxZF3zJiouqhrNy3NgM9+8jFu30e039SD?=
 =?us-ascii?Q?7s4DU6kol8UIM+6ygxo08oqZxDMsWMJ8JZ9oqTbK4B3RDnkx1QVK2Pj9u7pT?=
 =?us-ascii?Q?pXP0rZwuaJInjlhBZ4qihgr8HvKtjUg46V4dmD6v8zKiXawOYyZPP77QmG3b?=
 =?us-ascii?Q?oQCnxWFLVXdzlR9C7oF/GlwnUcab/dCOWM1MkYFwgPHXgRt+v1GA1nsDxhWY?=
 =?us-ascii?Q?f+STOx+h54CYT1w4bMnmwh4ERNPW4E7GxwuL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JIEc1ldEPDsXTPm6ERRdY5B4T7ODsIzG+E0WVtMzgyeMVcKjJ2vk5ynlg1Tm?=
 =?us-ascii?Q?nYbep/cndEj/ky4k6dcp2BUIGnYVryC3fB6FQ8E2rMUDCSw5gGTI7gK9tvi6?=
 =?us-ascii?Q?Pp2BKX4A5TZCt6Hkkx3r5ks46UpvIPDmvf7ihGl2crrjh+PUZJ0pawXAB9Iu?=
 =?us-ascii?Q?GajBvIupbhDmRPz+h0GoZy7vkcgmprqQxRgir/ytOSdfmJXCkcXQ538votnI?=
 =?us-ascii?Q?rTeIPSTgu+aV0VECA0kREaoDBw2lNHodMY7d4amgNY6yW85GLMzLaYcvJ8eg?=
 =?us-ascii?Q?0rBITcOBTJctPECwLdXvGto99Owdt2MS1Nll1lHP0XyKe8VyWitTMV1AhCn4?=
 =?us-ascii?Q?38bskQOfwtmPn57ego20k7SvPHS8DQE+3aRdlqXQ8lw3GbiYI4UU2Z56sSi2?=
 =?us-ascii?Q?pObXPLsQrx+sk6W6CNyFMeo9MJo7JRjXMZ/DcydVTBYZZRe3jNVm4zbDm4H3?=
 =?us-ascii?Q?jzInWBSCGNxt6Cset5I6cm7AvOjVwiiDds5bvNZJ8RjX2ZRBKdjoPv7JDb4z?=
 =?us-ascii?Q?Z1R7Bq82WkhYhTEZ7MRqI3ueq2KNMntvNRKLa+MENt5/yJMyZw7o7yIFk9k6?=
 =?us-ascii?Q?N0YXcysmeXOOC1rrOU+ZfOxP7OwfIct808ZLpbF6vXgogDnCZdYUqD47x+mW?=
 =?us-ascii?Q?AgWUINjmx8+Df3rCnlzn0USIMI4nKqLKzgJUWoxlMIXxNAKxJHayzlIax10s?=
 =?us-ascii?Q?bx58j20eojzOSI6NyYTtObn3D6yKHcE/CdiMoPiUUlyDynWxvTdJz+LjEqKe?=
 =?us-ascii?Q?C/r4fcwcxdHsggU6MQW61q7wZtLmHg7OKFnpAUpRlb+VmknaiQuuJm7JFsSV?=
 =?us-ascii?Q?CJfJRKJZ+TSNF3OsYk0tyzWMh0v8FOFe3Hk/DDjFsv5U6fcNje0DORT6P7ld?=
 =?us-ascii?Q?WU7gbLxzBhWw3eBAAcrtGgdAc3f9sVfMwg/Y4GJ7R1Aaei4dioBQzhtwBved?=
 =?us-ascii?Q?Gl4TCXzw3Vz3fuR+K50H8QpOp8O4wDuoSaYihoNrQWjMU5Wj88eOkXt4zYe5?=
 =?us-ascii?Q?CrYExGtqjD+m1StN+Z9J7BWed6op1kBiTimQ1c2SGzO8K5I383nuTntWifN+?=
 =?us-ascii?Q?bNBuV9+KYH2EwxgpQVHNSwnr9z5X/HuB783208p4rHwstABb5OftloD5xEEP?=
 =?us-ascii?Q?rygYDz9o6em4lJLR69k9KaTiXZgvikBfeK1kmYbvgjA0N44Jv73c8BnlHD2J?=
 =?us-ascii?Q?pB53Rjj8q4XFVr1s8yuGMWUAQqMJBLLNZioJ7JRndRrr9HWKjpl2pj0XyiZF?=
 =?us-ascii?Q?uF4gGyMshEWJCvzuqhx8BLZxKlEnf0Men/SAN0+eLbIqdt8u1mj0miDfVG2J?=
 =?us-ascii?Q?85Ok7rQhQPP5CUf6iCvpa+nkf1hIV7JmHgl+xToFKGfApKO4GPUhxrIqS0Dm?=
 =?us-ascii?Q?cf/D9aFAcEy5Qe7RXrW502sa2nKpc1aaAAV/SpPZ/HvoBpCxOkkBMgvrYFgO?=
 =?us-ascii?Q?nAKk9TRTIhv74npRwfzq6eUpoCcGy5UoVF7xraCmDRe2hSq84YLC3JYEM3Xn?=
 =?us-ascii?Q?T4VrYaONGnoQRGJVCHSNZdD+HLVeAA04pP48LZkXxbTPRLtfoKKmtoZ1Amu5?=
 =?us-ascii?Q?FGS7oe4kCMXH7utDd7WjSy+CS8LuOidCmzpoCJnEbP6sg2J8bJacYFXXRFQZ?=
 =?us-ascii?Q?yIXPB280z3gbp5rQB97xKwc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0578967-d5d4-4405-d1a9-08dd7dfb4586
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:31.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YydhuWhGISuZ815yikD9KK5cX6N2cPLUsesU9PII8ILdJHhhxRkWldAf4+Gx/V33qHpphZe3j3xo0ycy1I77uf9Nng4IREI4y0bUNYDIDtfeQEzk+xVoAXVE/TA12NE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7597

ACPI specs[1] define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project see pull request[2].

Link: https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html [1]
Link: https://github.com/acpica/acpica/pull/977 [2]

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
2.43.0


