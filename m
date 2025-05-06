Return-Path: <linux-acpi+bounces-13509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A1AAD040
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A435C16CA6A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743B2327A1;
	Tue,  6 May 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DOM5eKdO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98440221294;
	Tue,  6 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567513; cv=fail; b=eSrCD5wX3eULwms/EQzIqPjaUnDmIGnIw+da6TL73c0Cu2S4RH5MaSGwTRZpjxERpF1N6kaferkfFDITwIcy1j6Q2fD/2Vc3re/r2XteevZCAQTxAw9ESd1aTOxbVz3EiasFen7/MrAj8U4cFQl8FY6pCJ7ozXVsm13E+EZqBcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567513; c=relaxed/simple;
	bh=N82lQgw0OOtW3DNeHdfoRKpC2j5SqL3vrku7Px3ILqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hO4w9IcuQ7nqkSJGVlgCXHZ16V0WubeDX6XD89dflfEBqZTcj2vHJyZgNDy3YJTO71pKFb3EjerkDSkSociu9oLKz0eCDvSI7OQqUxgqnOwdx4KJhlzqUtsuR8bzLla8bv6Jc/TDcmqv2GiAhsGsxlbvWk/F+zfEZ3Ne2PfEimk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DOM5eKdO; arc=fail smtp.client-ip=40.107.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQATr6n/cqCMuDFN6clcmOQrHLrD66UiyZunL2pC+ww3QENcc8ZoyZUVi4ezWj7aKcZ7iPw+StTbydmRepUZVycmOVdEEupg2AGGUKYKDuJJ5AZ8zWyrT2c1BtLThgHKrIlTEVK4aY7J0uBPhbc3DviSC1zFzxs8e2UB4SxyGZoWqMTbN8lFECDRAYJEicnjL/MZX9FCvUS4h1xi9tAfFA9ZLalzmKTLpk8E10jqBDfVCIXvc3q7He8PTWIRY4vwoQT6VexHPt9XE80v3bOnegiAFA8xPsffOKHKCEhv0VKHwwfqMh7GvrRFMOEIQL+aC2oPjyo/awDyUlPgme5iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I6WwV15YtJvLaqmzSPZuA7F+ZEjQ4z8qExpNmVFSgQ=;
 b=fXwtwkAWia3BNbjvWRy/FjxwHM8euzfbDllLd/Okg1lLYYQaRmyiIzCJ2I4QlEYD7I9Z/g7dLEPP7tawwJXouBrdpjELgrvX0junLP7CsynGRRr59d/2zWXWWgCif2YZWASehcT/K7ZsAqIzTT8wOdSzxdEVsBLNA6xJAfH4PG2/I34gHizTVt00rnCcS39fguXA7/RIwxHVvWjxRhRPVIVl2HKba585+YHJsrhci0UbAPJWd6SXHQgaZDCspXse5s12VrtD88BKbQDtUKPWw96D/tyM9TjHK81GBOiRRIWg7DxoCZk8xkWvyF7jUAQkl+/fQEqHD5K9iqFhqt6Vww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I6WwV15YtJvLaqmzSPZuA7F+ZEjQ4z8qExpNmVFSgQ=;
 b=DOM5eKdOOiIXyD8gh/TnjwCzRjYzN62DBDv0eHpS2eKCZM5dLUwVtCE6iLsUxP9d/5a4XQzJIRW4stdtZNzmiv20/OVkM4Efq84TNpvfGPvexFZdDEI4//U8obcGntE0Xx0tF/U4QtCy3Vl+zYoklmuIX3zEdeIVAqVovDF1mrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8717.prod.exchangelabs.com (2603:10b6:8:214::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:28 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:28 +0000
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
Subject: [PATCH v7 1/9] ACPICA: Update values to hex to follow ACPI specs
Date: Tue,  6 May 2025 14:38:05 -0700
Message-ID: <20250506213814.2365788-2-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS1PR01MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: aba635a7-ea30-4912-c9ee-08dd8ce65690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PoEaZsTAMxMD1naTiI5SaptFxqxlx+A4itX6Eq8CvrnjPhMHMmenNgGOOBBk?=
 =?us-ascii?Q?R2VMkYWBXJHbINudGaa0b6OWIxUN3MZRYksfhI5kAQHgiimQdnOStoIaVPO4?=
 =?us-ascii?Q?GgpUpYm6H9QMLdNQxXfharNHpvNsvIES9sgpyKJDcr2e2xu6VSFg3lWL8ka0?=
 =?us-ascii?Q?HYkBIGnp1FdMt/AiCgiMEC/1Gfthe+MooBC7+Q7gFQqA7+VrAA1cD3C/X54I?=
 =?us-ascii?Q?ZGRgWtNPJg/unsbKjjYF1mwzLY+271CxrQK6mOpKxdIgtmKcZjUJMwB26PHC?=
 =?us-ascii?Q?80/MJq4HuGQ/avMYgAMO5M3qGHLK86ywildjOTgZCF+ncFv1Ep7RpeC0e5qR?=
 =?us-ascii?Q?s0z46YrJRQcADxJlf20uV2EqqvRqx7Bg9KSKztbHOVR0lWOn6fFLaIwn09SF?=
 =?us-ascii?Q?oBgXfEufFGNFqPBMXasbFSG+WhI6HcnmC8HpQ3wat/xAFilmv8s9x6mXb2S3?=
 =?us-ascii?Q?v4Hgzk0m9Ce7iUNNDCVLV5d3NN+JjAwA222vCIuRqKNBgnXnkXZxexMgIFl1?=
 =?us-ascii?Q?y9w3weQB2zhwZz6scRXRhGkCbx484QMWmA5vrZb42EWwQoNzeVrhvlDxOnci?=
 =?us-ascii?Q?seV3TnOwbsyx7H8gKHagsdTWqhZuZqerusBVxu53vRSWRnUC86mH402Rtryi?=
 =?us-ascii?Q?pGyDsYUYzmzYdujeoy8MFPDR3yx/IyLSTrjNCKWywTCICo0BlNYFgCEur4rg?=
 =?us-ascii?Q?Mesdms/wIkv5YCQVxJmamfNOCUSrLTpXTANOJ2raQb4AN6IqwIlRC6KzZ1gt?=
 =?us-ascii?Q?WAZe+sGXFuKCzXVbX84rut7XqReO/TWlM9w6g3Vv+ro1nakW8dKhrfH+SQjG?=
 =?us-ascii?Q?zd+TjMOfdi6dBjTaofsBKYtyxdphUzx3WOWtOyZ5F2Y0QvbbIILsUFvB9S/Q?=
 =?us-ascii?Q?tYp3iHFg/mFmB+/8jG8gyfGrv7qfKlFp3wO9NjEuwEmj24EiAupf/xyhSbEF?=
 =?us-ascii?Q?fFqGT7cir22YxOLMmTr7SnUQHAaeTk9J/L4fY2PYKYpZuR7m82YSkBQBWOnr?=
 =?us-ascii?Q?MzX85MlcAb7sqhDZpPsH0JPAODJOdnPoZSHiupgpOli+xjfGd76zn2f0kdWu?=
 =?us-ascii?Q?Y1XUi1omIvbb26t1Iln3DBA2krRUC1f547j9YaZEp16zrkQOFUQzOnOLJffu?=
 =?us-ascii?Q?qoAqUX3PnCr4jo+rBwLzwaWlv7/bP84DWIYq6I7wG3t2WRPJMAdffQwiTMhY?=
 =?us-ascii?Q?I5yCiZHXtuELlC0CPoZBqHALc0bZ08b8+hWTQ5r+atzGqI1XJC89GiSGaHPj?=
 =?us-ascii?Q?Wajo85ggrb8wo5hi7wjDlj0xEiZ/iC6wWD4m85OEZz9tB1pobKnr6jbKH4LJ?=
 =?us-ascii?Q?Dstn5krBSYPU7GPVohJMi6CYM/BD3OU2k+nVBdTZN4BKd1dKn61v8wTQcefS?=
 =?us-ascii?Q?e5KqCXC1Tl+lVCG3fv3on8M8W+dhkXsa3KcCbETIoY+H4n5o6bGj0KjabrE8?=
 =?us-ascii?Q?I2/OS9vqoUuCRHVmtgtvcbuJN53B23MO1GoR1MXUFUQI2H1mcaUZeVtT4jPg?=
 =?us-ascii?Q?q12ioROc1CyC6Ds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8J10jEJSaHSj28n/uLxzDKwrg0NZL8yFUUJuYvViFrzpGzQTQckIMwbpiatz?=
 =?us-ascii?Q?8dPmqXOKyO94u/21WZahnZjzCjB2ESfQJP1ipj8NQusTfNmKObIx0MxoUvTm?=
 =?us-ascii?Q?mSDlBsFcsr9CEbHndwykNoiB/85gtxlhPRmYei+ZYedL2fx1SvTn4FULiXZ+?=
 =?us-ascii?Q?zfBgwss/b2fKKON90j6B4HllBeB9IkXmexr40lg5ip24fZnIe9z0OFvYUAZU?=
 =?us-ascii?Q?B8Vdc9vWzEHc2dUEfwfhpcagp1zvZyF+hRWt8xir5E3pUOJ+LvlqsqhGVha9?=
 =?us-ascii?Q?DjGjuMavf/nU//Ch8Tr8UTKMHTNF4hwzANkOVx9kM68AULPoh9mP2f9Tjov0?=
 =?us-ascii?Q?AwRRYrjaMSR26naPFfUIOZwyyJZkv/31PT+SwwTzYzV7G9S/cTft/RFF1Awm?=
 =?us-ascii?Q?7V+kF5GnxY4z21KXOingytnKnZBsDu25xL1nR73c84tz3J7xCoJuabllLnF5?=
 =?us-ascii?Q?LmmhhQAwoKGVJZY4iwLd35LUQdiocYlR9nWeqqhIQQkoZSLrzPJnz6Tnjbi7?=
 =?us-ascii?Q?EFTa4ajCGndmH84K70TC3YvDPfdPszVCxtsdU0KtLdtIVfMhyMhUd5lZI5F3?=
 =?us-ascii?Q?MvR3yPLpPFjEDddL19wdxjZ+0TljCB16vCFMe/CFLorFxQu4R6LApPOJfjLe?=
 =?us-ascii?Q?8Qj3H4Pt1ZfdfihXjTFeaNoaja9cs59ybXkZi1cyoVLLj12psjF6rRJtzHmq?=
 =?us-ascii?Q?8CrLWG1LexrIS4qLBo7UANpwkp2vijOI1kg+cDFwLdLagBgIgN5Uy4Nhhj0D?=
 =?us-ascii?Q?ACl5fzIaJhtrfx5cyPoimFEMdgwv69MDYnRuxRsIw+LwRRhTiaVmq+na4Ttt?=
 =?us-ascii?Q?NX4QnlrrpKoZBgttHhLUCkGbJj1pG1vHjP6oWUuSMeSIh7WtALMbjMi90b2n?=
 =?us-ascii?Q?FLzH8Lt/AdEBKPr52916LR9vGVmsRmI4fNX2LpAGiJd9kiKHHj/baIMYcePq?=
 =?us-ascii?Q?HjGbwceVM0GLzrG4PrK2cAek1B1DqqfP9IYQo3o0AW8l6rOG9otgW9d0+gkP?=
 =?us-ascii?Q?d/SqG7O+5bEdjuauWD7ghV3iM7qVjmF8sWI4l0WwNbo/1Y7kWVKBxS7Vf8ro?=
 =?us-ascii?Q?XFD967olN1GSRbVITbR4KEFVDnSc6DCSoG61mvJb3Auib9sajpcHtlC5vM+B?=
 =?us-ascii?Q?OT5LQprMbo2lcXO702ZxVP1IPhz/2ZH9dnmf9HNWq3BWIjcj/zm0R1CwtjAL?=
 =?us-ascii?Q?kLMzeHfpjcxR5S4PlQYjthiqaFnqFtndYSd+vevRWuVegEVb2sPhPNCojxjE?=
 =?us-ascii?Q?ZOdPxUE9IYTKoXZIIkRIRNn6F9f05O5A38/VwXfK3FYdtsPOL2ar24RY0cKF?=
 =?us-ascii?Q?KTCtsriWRp3cJ6z238TuyNX4yN1LRHtNViO7u8rijZULZtgH75vdPjbpW8Xn?=
 =?us-ascii?Q?qywI/+ncHy2LCBuvBkzEetS5HcsLzOk45gK9ZfuWL5cLUd57JOYu++UclVxL?=
 =?us-ascii?Q?zP+J7dyEQVddlGYrA46rfy+wTXTn1o2Ervh1chpMtTHm7oiKggHiL2DUuDxp?=
 =?us-ascii?Q?3uE7Hx+PzdBIG6zksVxDNDstJmD6FMAv1pztpFId64MKVYmyMUt5p6CpU96E?=
 =?us-ascii?Q?D/Adj1S+J8vMgxt/6kD647QOLRMz4c+LEp50SY5NRaHhCPrCCQM9ry+aDzQ6?=
 =?us-ascii?Q?pu7x9uNSKOAs/D+LS+/8au0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba635a7-ea30-4912-c9ee-08dd8ce65690
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:28.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/2gmFkk8/lb2QNMaPL1kA3QuRmaI+ox6PyYbkUIjyUHT1QIX3kF/aJHG4SPYX7Yw3+kvUgqXiMjYIlJbTXshYUHOLeQVdmnYZV42zLK23ZJPltt1ljAqktu4ZxqcMlW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8717

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


