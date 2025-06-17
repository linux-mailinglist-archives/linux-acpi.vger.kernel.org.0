Return-Path: <linux-acpi+bounces-14421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18685ADDC50
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9202B7A8C3A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611C2E6D09;
	Tue, 17 Jun 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gqo5kySB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFB28C5C6;
	Tue, 17 Jun 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188649; cv=fail; b=osboRmNfHZFzRjOYxrIui3+qlMNzL4Ny168fGMrtFgcUNAl06FHVUl18V6C/WjoeYRR83agxpzj5so77VgYozmu1yMkBfyhgJIX6N3lUBqi61+Cztci5ztdOI3VJh/V0ajDgJvMykKwGLOdSn4IgSiBp1aRJs4TQJAnrhhm8ttU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188649; c=relaxed/simple;
	bh=+tIT3fa8hGmamhWjAI9cgXSICI58rOKuwHwpaaoGyX4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2/3+m1d754TxNa057X9hVMLJ9z5+lYfKh4KWhczkV/UoFGhDElA4QnIvB396kswk7ieQJsefXBztKPrwavCvg5BIEtvWdM36kiSIDx29c63SVajzhHvoaoxXsCRwkd45xFqCpdebZnUOu0A2wNb/9NYIp42FgeZzSzjYwJ3swk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gqo5kySB; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKHFzMSQw8rLJ6rpLUpDc1bVl3K56CmY080rPVi2QT28n1mMZhVXZC++XoX96srvRr1Okn9LDRtBEPbx5tCt1DDTmMC3xtysgsGgjkLck+/3kPB7CIFonyQN2cs9Pa5+U2GcJdA5h0asF5nmAOqIkO58JyXfZ0nf7wDZFOo4JSJ/9HNHxZTl4pRKdjQnf+1rtiq3c5ZrM6eZ//NwOOoxxAHb2bZ3JOp7bh/ZwmJXjFqXsb9eGpx4cYmKNgjTM01g97XpI++LV7P+sU5pzv0UmW7nhuz0SRTAOPuS5e+c/UbdVd7rXNgnAF0cfx5IJ/L+KaLlOev6TcSiK+dOij7HDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KIjzffFo+mNHHrxbJqooarOHKDjKetRVvlc6JX2u/M=;
 b=iO2sKRxcCDdME+XkI9GiU56FWQ97qVc7eduuvs2aTXIv4CHeZsPQRbhRfwFtZhoGz+tY+9jkebo+h4EYy55JL2u68XNNM1PYS+BATaysXRO/Tl6LNEGafeyMjKTlXXhz1LwbkOPDgpup7VUjDHg0LEeMHKEtYncDqv8dm73E/RUDuItPE+9/oryVjWtbIyJqGsfCqteL9algRlK9erWQeqpLzUkLRmdrAYl/jW8HoXAD+rHgXpzgSJknU2QNSy0Qgjuq6VIbDLL5SVj4c8MHEaXSbB8skhjhueMjUHIGnhZloXzsYuu8uXZR1SAROgqk02tb6KZzCZRJBxmEy1UmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KIjzffFo+mNHHrxbJqooarOHKDjKetRVvlc6JX2u/M=;
 b=gqo5kySB+J5WN6ughE1WwOVmxzHVklJs7rhAXDbUEd04vFxyi1QaeFiWah8sYazJ7EAzt+Kp0TXhOag4/JYHwd9klZGqsytImOd03tfZtFsdEemo7GEGdWJEjcDUJuB7LZQCP/tKrSuPsLafCM0nPdSpY6OidZ3Xb9VCqJTOc2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS2PR01MB9414.prod.exchangelabs.com (2603:10b6:8:2b0::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 19:30:45 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:30:45 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	ira.weiny@intel.com,
	Jonathan.Cameron@huawei.com,
	viro@zeniv.linux.org.uk,
	sudeep.holla@arm.com,
	dan.carpenter@linaro.org,
	jonathanh@nvidia.com,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	benjamin.cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v10 2/7] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Tue, 17 Jun 2025 12:30:21 -0700
Message-ID: <20250617193026.637510-3-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
References: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS2PR01MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8808d9-5ad3-48e7-ab52-08ddadd5745d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?veouu7BjmjmRW0QhiiHe8rDPmiWRSZHea8wFXNC4FJs2yezM7+/qJa9qMkEM?=
 =?us-ascii?Q?MCgb8yqr+bsoPxs4ZinExL9Zv1T8t1UQkSHYYpiDjixbAfK7Q+5GHSTGLqvt?=
 =?us-ascii?Q?urFFzoz24WOylQCj/94HSiFFb/hCp0xGVwYEdg+xZM1pEBZ46VbDSF0sZnmI?=
 =?us-ascii?Q?3jABi9y5oxVznroDEmLMz+rJuzjGkd+0X1BieZw/HC/Nm43OJKqN6ET99/mr?=
 =?us-ascii?Q?EuB1uA7Ra52kheP7UsC4CuYFeEzWWyaqJ++MqHk0DDrbs3tc3Chi0ix0FWkm?=
 =?us-ascii?Q?lwYQWWmUbOVSlR2ol73Mm+rX/JmGZbtmvZ3mjShqdPQ5JdEHFIO80NBSmIBc?=
 =?us-ascii?Q?B1Hu8LrkTbTfMKQnvY7FQpHlaT7fuKiPM2qCHqLkJoii9kGAtmheuJfJjrGx?=
 =?us-ascii?Q?I/T+WcYcJtll6CY0rJUrvMYsikflUAVm6gxdWxYuZ8dCmQT+MoAY0yG0dQAp?=
 =?us-ascii?Q?pTIzAQwZ8gDnwpVzFXn6pfWVCHeEuiLL0yhSXJX/S+sI3kBJpbEJgKWgmmAy?=
 =?us-ascii?Q?H7wholLNThbQEF/Pykn/AtMk2XBfiRCF1Ob+JFkxQg2X09PBe3YlrxgEwmSn?=
 =?us-ascii?Q?1GE7n12WPHFJcj8CSHPNAEmywFY7pE7K8jGd727LdqILZOnmMFM8SjYUceTs?=
 =?us-ascii?Q?vFQz/Nc7swzD1UDNzjCg7er8eoPp5GHdbezLWophVLZd9EAWerBOooQccFZo?=
 =?us-ascii?Q?4mPkmCeTSWsgUoIvxkZDrkmvukTmsZ2tvKd37fm3Du46by5s4nPRCpE3+NO4?=
 =?us-ascii?Q?VKECO1QfWyP0IhVh11yFWnhBw0U6iVIad269tWTnj5clhBI7twOO4tWIJBr2?=
 =?us-ascii?Q?0Zl+em4120q6AvBhB922V8UWML5R0nhPePlQZQXruczHsyOpwMOJx1vtqLLF?=
 =?us-ascii?Q?Y30PVPouxtRzSMxnB4NlUfYpslYvJrp2/4jip6QOud/QThfmV1m8wj4t7yyT?=
 =?us-ascii?Q?QvF7+JjBE5MK75y9rb3nlKS19tQsj14BEqsmY6vUWSkrQRyJhWxl2Ac2oQhN?=
 =?us-ascii?Q?OAYHUy7rEM2/sAoiX/nB9uZq/TKtZBxugzlM0v72YJVc3ChA5Q7si9fMFTUJ?=
 =?us-ascii?Q?pGniUQOR6r+UWQ7mGjIH2YZt3PFysz54RrpyRWEhbSA85bAJWNzxTcPfPgq6?=
 =?us-ascii?Q?wHmg1rP+DzcvvLOwK+vZiLyCgwSJzByCS7QFCQ6gpUb1i37iNG52Nwdqh+W4?=
 =?us-ascii?Q?/ojfy2HTK5ak28NNSlackyYLmFCHrEf+Wf/tqR0qSIn9kiKs+dQrtdRTxFmd?=
 =?us-ascii?Q?cPNe+dGb9Vl2SrThBX6AJzzPpNBXyhurEHJbpK40BbzZO4GVFbCYXtdjdPrQ?=
 =?us-ascii?Q?c+73PAswaTH2qLJdkLhfYOrgNVmuolYNpSIgHEuh2f/iIMdr9Oph8WuCeRhx?=
 =?us-ascii?Q?itQwVx9SgOtNuzlLdR2blbxsUSbZLucjjeJ+JQR6ZrYCtAzV6O22d3Ir/PxM?=
 =?us-ascii?Q?Oc/cBV0inmwW9QKT/iFMh9ymXdNN7iEAyDp9Jbl7j1S3vTZqoN0MJgiT9ygn?=
 =?us-ascii?Q?j3cNrvougbI286E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUT27MvOzdiUxCHlxu792QEQdX7+tRDbDHWuMc/fn/mKFmHib/NykgJLT++t?=
 =?us-ascii?Q?sZSN8cn1h9sYVzHc/6T4ETzyepiiQXntl0v75beb6aOrjFm7UDQH1ZIsoOjl?=
 =?us-ascii?Q?M38V08PR5SC/e6kAse4iLzlkN6p8ZCuGiY4t51HENh+qOzSR2bPCPIgZBfX3?=
 =?us-ascii?Q?xDzAP2nueNYRmZSIGRZgqggZf8CS0p9ZTSDkG0lDTnykcGtV/2WUVKP/YDj8?=
 =?us-ascii?Q?xsu0jcuoqI4rFKvIUPyrp2hHwbk4Ud4CPVNqs6d7W3eufnFd1wui7Po8FN6U?=
 =?us-ascii?Q?06wtDu0gXwCcTxj/u/n4jUtK3z7jMo7WRZOtP5ORkrLkurAvxdhe58nfEgtS?=
 =?us-ascii?Q?jEtt58LSfEvkZ017sP/SbKDEX08gq5QPR+wF1oPRpggi+qG2tDgpCfkmCXYY?=
 =?us-ascii?Q?bBkWjorwD1+z8BexgPNDvWRvrtD/aLhXCiuioYMjN1s3I/Q59IuZfM0TKnVp?=
 =?us-ascii?Q?TgC9M0oW9UwSbvAljsUl/ABtpcrLFizRP1jqoldmAQWamslXQez3gxyvWu0f?=
 =?us-ascii?Q?tbPcCOP/pvd7xqdzAtFUwlQUBGA3hoWwb9zxK25Lt8mUgDv6gfqiB2wSUGhl?=
 =?us-ascii?Q?RhkYQQCKJqNgSOusm4aUBk9jnIwiv9xK7GvHgvt0po9ffITt+Ss2ACID9vu0?=
 =?us-ascii?Q?5VloHiPt+68lDx10cP7HDC4GtJSzK/sTkoYw/ZJdzvW8b9BnaGQMQ8aFd7ub?=
 =?us-ascii?Q?txSfvzfIYuNL2jU1g3Q7GxYHJXHW3VP3tjXTR9SShLkgQut/uuF3s0DvkL/j?=
 =?us-ascii?Q?0cKyuj1zlxx8hvo598dS+HdE95xqlzR0Md+d8SoBpzif0ZkDgwhSatCngz4u?=
 =?us-ascii?Q?kppW3jTuOv0ZRBsHX4Y/2/hhyKtDrPOulEkgW3yiUGdnWtqKYCwMzJ8+O6P5?=
 =?us-ascii?Q?c/nenIouEYDSOEAsRYeZMuzKm5+GtjEKnlmPIfuweilsIyTXXu96f5EdWtXq?=
 =?us-ascii?Q?O8776+K6kcm5xBdmpGVt1ivKPJCaJee6ToqPuYnNX/dbO0+8LZuvvlUssS4Y?=
 =?us-ascii?Q?SuCQFxdejzwVBmMiMcy1pdb2f9RkpCf5VYAnUuM0X4e5A7/vDe0ulDvhL6sF?=
 =?us-ascii?Q?au8i9WswhPCOVj1AZDJ6Ncg6crysKgj1EMbcksLZb3wTWS2iGzAwFuFR59WZ?=
 =?us-ascii?Q?euZx8Csx7tnXrESNRNvswe9norivEDh1TwrrUCZNGBD+sFzv+TIyu1TQ4J5E?=
 =?us-ascii?Q?9pZ6rlqwSAQ+9yzj2+NLgxhsqZPhZY8ZVNE9KebCZbK0NIVSjeyPY/4psJvl?=
 =?us-ascii?Q?uiZZPapCLHowi08TerDceACnO4QtyzvuUhvX3p4qP817wl8lUb+HpvYnOLZC?=
 =?us-ascii?Q?GKrxhM9Lfku8kC74NcwFOqq791IY3LxefLjD4yvZZHNI4EyOCVDh5ZXS8LLh?=
 =?us-ascii?Q?wy4V8Xh/kfxeYQkIprWBbYvK7osvmevtCfDwFJPe8CQ8ieMI0rnzEmJds81E?=
 =?us-ascii?Q?ef99sFhkslfMFnw8y5w4Yt/tvSwsc5nLTypzf3RCD5BKbVuGVo6X9aqsJ7dG?=
 =?us-ascii?Q?VX8FSdtCSw7rxFrZtv29nDws7DJqLK7TkPtOxIezfCyuhrzhuJG1x62K+NRq?=
 =?us-ascii?Q?Ns6mC/EftGXiuUgmPbdNFDORYnUuoCn1O0RpmEikwb+q8veylyXfKk74s69m?=
 =?us-ascii?Q?S5vHmPyta+hgg5tAgphs6TQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8808d9-5ad3-48e7-ab52-08ddadd5745d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:30:45.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEZ7+HZ7N5yhHfg8tvDhwhHOfKUtZgphkDoL+US9S4FjsBOlu9qR2gmznEQiShqb8KVuiLo4a084sWlAvXR67TMATEfESGb1wmzLiowEl8owIW+czQ4VLH8RHGvzMY8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9414

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 75 +++++++++++++++++++++++++------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 63 insertions(+), 16 deletions(-)

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
index e4fb4405deae..a1ff42c226fb 100644
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
@@ -174,17 +176,34 @@ static int __einj_get_available_error_type(u32 *type)
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
 }
 
+static int einj_get_available_error_types(u32 *type1, u32 *type2)
+{
+	int rc;
+
+	rc = einj_get_available_error_type(type1, ACPI_EINJ_GET_ERROR_TYPE);
+	if (rc)
+		return rc;
+	if (*type1 & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(type2,
+						   ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static int einj_timedout(u64 *t)
 {
 	if ((s64)*t < SLEEP_UNIT_MIN) {
@@ -646,6 +665,7 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static char einj_buf[32];
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -662,6 +682,12 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
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
 
@@ -669,17 +695,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
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
@@ -712,9 +743,23 @@ int einj_validate_error_type(u64 type)
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
@@ -722,11 +767,13 @@ static int error_type_set(void *data, u64 val)
 
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
@@ -778,7 +825,7 @@ static int __init einj_probe(struct faux_device *fdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_types(&available_error_type, &available_error_type_v2);
 	if (rc)
 		goto err_put_table;
 
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
2.43.0


