Return-Path: <linux-acpi+bounces-9969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B29E5FF4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131BC2845C4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9E229B06;
	Thu,  5 Dec 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m+XXiVzE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020089.outbound.protection.outlook.com [52.101.61.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4C22147B;
	Thu,  5 Dec 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433561; cv=fail; b=nFXs/oslkz5FzFsHPKo4gz9Y/LhYCXzDfnZVFCnGQ066tQGDrm1UGMiCmFhyYfUSD1K90DYNChZxrbllalzfdy3F44PELZXg2RQWIzonOlGms+Sa9EzJwHuE/XVuP2zPEDskxbr9QMekJI3h6XRQ4znCP/tmcXvXD+w97nnpn9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433561; c=relaxed/simple;
	bh=zyvo+r3+D48XqAAqAt7stdhcoyPzT8vjQzEVtVo6To0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CiJMMx1BJm/WWLaP5cFdjILiZIlr+M5KvZyYDc9dNYOLgxRoxby2qdi8iqYzXSa/QmOixJSFdR95iVKMfEXMTU92j6fOvSMhKK244WBaYW1dFuaVFi/nfr1eTaLvQ+h9866CSKoby3sbfxboa2Ib1qg8+PjltdDqK6Ky8+8h+cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m+XXiVzE; arc=fail smtp.client-ip=52.101.61.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txIHbfkiIjK1uaAG0e1gBZoVL/wEJH0PiDAbUO3S5S103K5R026WoBYw/trs+W2lIUfsByAEh9lZSiQz5ETiKZI2HMFJpYBmelwrV6GkiBBG9bVrUaJzCr8VLMyQHMeAEFl3a6gIbmI1EQ3TfBm1TCyohE4LODHHRMiacswi/S1Cszo7XO7Jzvsw39lQBDGl1UgDNEklmTXtsdH0+g650BVUHkBgbclsAoQ4DGwmRtfp9fDvHQC4JtqYlmgw3wz7ZH9rsIfiaJ/RFCUN/ZicTQhNEMs8QuH7SFwkmuvX20R2vl/Bfj5qF+JxVPBZndHQ8vwzk72B4rW/STg1Jbcc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK1qPxfDNl1NBLDC1lt46wfRrCQnjkZyrVESfkfLdX0=;
 b=TlUGrskPKoHf3+D54KZZLCMnAeLzdTN6gGKXGAObHBOBeX90G8q2/Tvk1NRuaHn2+04/+didRCd9mt3NJsN7s0u+K2Ef/98UMkwk2WyZY2a6vG1yw0w+boS7YBYAjbrzEmMuKntd4JEPgpsbUQRnteg+PirUrLmERK7yAMwAsbP2mRd5mCOeejjdjThrF125KfnXqd4v5TYnNXpU2/DqY37LtwqIsDhNVO+3y/9yJX7zaROlBJbLKkKXVQ7HiDjtWPBXHtbIvIeuEv9K+VHtjssKxiBY5v43hHFg0bGwmkwa7vIIbFimFbDDxx/1mF3ywyUK4lEhbJHOtRjReXwmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK1qPxfDNl1NBLDC1lt46wfRrCQnjkZyrVESfkfLdX0=;
 b=m+XXiVzENaJm+1be0ZYFBfYmo4Ktj1nOWdYhiCeZUXZk5S6IEHrUWMEXAPzk+OO1mpeptKM6d8ikDMVo4Fg3s1tofeq03eMSYJJFPcYyJvUK9vYKkHzT0/JvoDNTnN4aZZTntsghaAGvVf28/906TLNe+ZTkcPWFkNjipvEdY5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB7759.prod.exchangelabs.com (2603:10b6:8:7e::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Thu, 5 Dec 2024 21:19:16 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:16 +0000
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
Subject: [PATCH v2 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Thu,  5 Dec 2024 13:18:52 -0800
Message-Id: <20241205211854.43215-8-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f78d18-86f1-4f2b-3436-08dd15727916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14UTbBBqcLNhzMnhnK9krvh+YVt0ti2Cxmb9RE75vnSYTmFhQp+/BZToryhw?=
 =?us-ascii?Q?6AghsOEHcmP/F0jVriqksLa8yaWQoIw6NjQ7s382QNh4RybVGMz3JHAnnGHv?=
 =?us-ascii?Q?0tVqiUod1dtQs7A8YcCQdVzOS0KZiJ9t9bNSc3uzhIUzHG+Q2S1R6VuLFTpL?=
 =?us-ascii?Q?/JrbQxSMAffT0SQtykih8ZjPlFjb5N2Y0SmZJgQICAl1GBbaSKMiYO1rJkqz?=
 =?us-ascii?Q?tIjVgFsZmiSLXNiyntTcnLmSRrAES5sOBqQdEdyvbDS+LRAGSHnM3xIK0vYs?=
 =?us-ascii?Q?9DpZpZcUXT2gKO2LygyqegZLC04+7k4voBW79r+3Nqey2v/TFG2idkmsHv0Y?=
 =?us-ascii?Q?Xd1/teLUa7qFgi4QqGnECZYO/E71y4ru7a3xKrQGaZMmrJfoosw7Gm35q5jC?=
 =?us-ascii?Q?wqmwMBwyoBfH2hGGNJ/d3QkP4m3z++zaKRSHFqEFDarSdIMY4NFKa+vnMkXl?=
 =?us-ascii?Q?Tus/0CMLzM9lgYyUAD7EwlMgCI6egu4QrJZw8h/QwItRe3uP93Go4vzRysU8?=
 =?us-ascii?Q?jVsBlzU1hqPRcRNinctH5oJvj97BwU10fWprnzIB81nAredZKg1wIqq4BsKW?=
 =?us-ascii?Q?cXT/G1TrcywoNilJb5yoUykv8MyAaZ+kJoSvhCR9iJUg5WTV3RcCpz3nG/8k?=
 =?us-ascii?Q?lGIkhilEJYeKhasl1O9jMTZBu1COHuGgsg6hdPLT8X19jiRuRJnIe97xRQsz?=
 =?us-ascii?Q?hOZuLP5TWjbYaKZ3vlg2eQSRxCBYWNsZljHtUHDdQRIhkf+glieE1CvcHOzO?=
 =?us-ascii?Q?TFUzzOirNP39vFLiSxMF+yeLpqefM1mC1WMiRZqKU5t8YiKrs8Jf/DG/IVyp?=
 =?us-ascii?Q?N4Bry1/iyMgRB7vwjGLoODt1uYUUhLSQPNYigOQKjBzOFrl7BtRGoK0sXLDk?=
 =?us-ascii?Q?BT+Fw3OsQaASzeVstyfxIy4h8k6PMwny1aATJF4/VogOo+KnKnnZPBDWjfJK?=
 =?us-ascii?Q?fDuC4CT0s0X9vZK8wpUs3LIavaGFD3j1WhsqXyp6XjqRORszYNtP5HAgByBi?=
 =?us-ascii?Q?SGQYuaq+YW4VK7+SRkSzqCmlwXHZ2aE3YMTZ7IC51AfEmtOAn3jfL3g41Dvz?=
 =?us-ascii?Q?kExdJ9X6H5lY+jcrT7ouMPgQvA8CgoAeGFP+50zXMXwoT+PRzmUXANjBYCmt?=
 =?us-ascii?Q?NXanrf4+icYMKGSd47DAaeITtMtZJzfllRbBD7YGwbAIdJkZmEsBIP0AHQxm?=
 =?us-ascii?Q?nzFPvSvwIKzOgVjhWS9bOK8UrtYFPXNArRzaZeQR2US9nhwDbi7+BXIuOUyE?=
 =?us-ascii?Q?e0eY1xk4N2dBKm7ksqO+/msSJJpBPs2nFGZM9A1hMpiToJE83y33cVf/Dq0v?=
 =?us-ascii?Q?Rfzj+rFbrYJd44YIoW5YIp6MLGk5qZdg96eGZQOvp9LcsLbD4QtTilq6m+I2?=
 =?us-ascii?Q?mQl4llzFvX5BEjLBMvAeluFvkesklfphs+5lee95BuDkfyONW6Fhu63hzsS5?=
 =?us-ascii?Q?10mUDDM6JWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCv7UElD65F9AJy+z8TNbe31UQBCE0AKZLIsJoAejGedVnm3q9SuxK0vsK3Q?=
 =?us-ascii?Q?L97ehGM5n8TbRE9Gz0UYBclVRrMUJw+zObrs30ba4c1JNq6YcKYHELMsn7vG?=
 =?us-ascii?Q?+Ng6HVM8koZwh32qYfV0vOpJ8R7ppJt1EhMhDgVImT+3ciIlxehwqXJn1qXw?=
 =?us-ascii?Q?PqgnoBITmO9W97rFN7bvc2V+Q2I4HE6P6VHwO653tFaQPWoGH/0y3QSAx9Vh?=
 =?us-ascii?Q?P8gRlxRBEYF2OSsDkUeRFvFYSU4u3lHq2bXIRXRu94JMEEfZwne1oMVIh4ji?=
 =?us-ascii?Q?qAOgRkOi+kGhMy3BRPLLKRxrPF33KjAK79S6b20ORPuJaO1wxnIIs+Gvn/D2?=
 =?us-ascii?Q?qo4MkEhi3K5dhzg7S1NsfY/KM/EYIz5DTzD6CEUXoFnDjO9hdqZ9zKX8Lpj3?=
 =?us-ascii?Q?EFWlhDTsnXE3LWPUiqzmRBfZS9UHVtLtamfzsTR23vsbm9xKjC5x+A3ZgNi4?=
 =?us-ascii?Q?uwW+Uc8HUBacejMCbJBdR1kWf2NZy4itKMULpK10m1hLKI5KJxzJn1ohitTC?=
 =?us-ascii?Q?Hvx4bxqhmy+k585Oy9AyCm95RjyW/50GlcNl8tWcNdJ9W/Uiiycz7uWrgpJY?=
 =?us-ascii?Q?w6hnr85PpcF2E3b4US14C7wPcAmI+YalxfPpbmK48iLJ76t+cVqUnEaL/Stn?=
 =?us-ascii?Q?USNcY8Ai68by4p8+vbd8cttGTh3QlLfOGjjmdBO08SAVwwFX1ognIUH/579W?=
 =?us-ascii?Q?x8XXpBiEd1F/Di6s6atiNiY/nwnOVzQOtlB87Jf7KRxZN3ZXxn7csWaXo43V?=
 =?us-ascii?Q?eiR7RMTI6K21lWodJQ0eatQgks7rMQStvc94EVCmcdVXgPHUk5DHCgFqPKHn?=
 =?us-ascii?Q?yYvUFCZNhLW8XiBxMKgnLu1PHCmPgu2zZS1hOgdN47KXc7pdqcLUy8xdc2cq?=
 =?us-ascii?Q?P69lOTSwEKo/updIGBkrXdDI3gqt2uMLakRjP35W/KzDcv3Qg2oqy0BW7enD?=
 =?us-ascii?Q?Ufh2Byoe9QHtmWkGDTHUqmb2Sgod5BvU0e3HVxX/xM/3ve4+zqsLkp7ocgXC?=
 =?us-ascii?Q?cwwzZRNNhytcIVqmmxc/ldbsZsqV/mumSSn43UA1Ik37hI+0bs7yGuoo56pn?=
 =?us-ascii?Q?ssRJtLoO5lFcd+q0BGpoAIp5uVyCLHsyq++l3jA4Zc6buQXTfb9qrM8FG9WC?=
 =?us-ascii?Q?c9VAMP8ZnGtroHNFaALQhjOU4V5Bak79M1iPTwpwPxszXsTRjqNbc/RNaZNq?=
 =?us-ascii?Q?RDUblLckKNmTjI+uN06VT6DPsIYHBMCCODHl+ULIYGkdaOn/8PJfOXQauQjd?=
 =?us-ascii?Q?w8GmASNW7kh4SNp3NrM7SZNR/dBZ8FT1HnJIzwBZj7Pcv0rO+YkQ7Jr5XttQ?=
 =?us-ascii?Q?7pwJvpuNlr5jUqxsvPCiYu2rtC/E0ZAYzXCmetq9dcXv4jnH717eG7C9vf+F?=
 =?us-ascii?Q?GBEWcHscqdia+mffBFPjLZUBRdxCl+5QLfEiDpU5Girp9SgM1nvSyJUGS5k1?=
 =?us-ascii?Q?knr4daaho6i7L70RNUp+SROHlJ33uscquSQ5rjWrZMDUa2y/X2DjdE14kch9?=
 =?us-ascii?Q?rmYA4LFrDvC/eoLGpnkp7mU9br+zlDIQnUG2n2QwN0Hyg1d4rE7gCI42WjF/?=
 =?us-ascii?Q?dLak84NrDkvJWi+IOATOH14gL6cycariLvrOlsKUCgxhWly+OnoIuS2VSG1A?=
 =?us-ascii?Q?50k/t8V8OGTNWOFGyNyqwU0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f78d18-86f1-4f2b-3436-08dd15727916
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:15.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGRHPBBujh8rItR5nw4nhOeXHYXtVudwt9mqebv8OT+b8gmCxJrfEqXa/ov+8kuEQ1VZ62G9r+Q4Of1/mash9mMM7mU8HBiGN9EO1I4YN0KpYTdaqQ5uEhM6Y3+tlpip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7759

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 039d36472342..1961f140ada8 100644
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
@@ -107,6 +108,9 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static struct debugfs_blob_wrapper einjv2_component_arr;
+static u64 component_count;
+static void *user_input;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -881,6 +885,19 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
+					einj_debug_dir,	&component_count);
+			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				rc = -ENOMEM;
+				goto err_release;
+			}
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = COMP_ARR_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
 	}
 
 	einj_buf = kzalloc(32, GFP_KERNEL);
@@ -936,6 +953,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(einj_debug_dir);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 	kfree(einj_buf);
+	kfree(user_input);
 }
 
 static struct platform_device *einj_dev;
-- 
2.34.1


