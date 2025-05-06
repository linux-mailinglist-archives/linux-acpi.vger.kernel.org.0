Return-Path: <linux-acpi+bounces-13511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579AFAAD04C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1259D3BC6EC
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F823E33D;
	Tue,  6 May 2025 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bBbtNLQ8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F511221730;
	Tue,  6 May 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567517; cv=fail; b=k5e0/DhTW/U7GToqCik29F+G2KybvImSMNB2ijGBse+b4W2yIHSbtpChlY6ZUJwkRLAwDLBRh/VOjSr9bmXNBpBZh5Ie9iw5KpdzVfEO4A6ecZ1lh9TT5eSgfBS7MFrPcuiq5ddJ72icu7kZ2IgPoyEy2K682wWqIAW1vhuv5kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567517; c=relaxed/simple;
	bh=qbj2ic9DFcR95UlSmV/SlbkwSozq4Aypl7Hj29ek1xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xd02PG3OcZTTkdwYqSWtxAixBVIhngxeQwwNpi4+C9wglQLP3DArf7AuD6pC/rczN/Ir48X+QFNPHs43PKRS7y7HgeIcZPICZIP086UGCW+R85H0YFnea3PIzLUmA8cCHpkklbuvy+F2jgXdl0KKibUVWqzTXCr9ytSaQKzDv10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bBbtNLQ8; arc=fail smtp.client-ip=40.107.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLiYlyt+7wfwtoxJ8W464yWDHUCzkXpW7UXDJ0otEmDZFw7uaQuRT+HhkO6uaIdh46z3RwtLHXOM1qLS2jzgzL+tqUkTQsa+w+RniwpJ0sAXknjF9EoyJ2U5Gdu3TH8qZdnxxlMIaySJV83PFygkc0vyOPytR5lpFtVlFNhUW6zQX3iirUSxeDPgkLUEXeaEShDP5k2d9kNHNX9cChgmzlIcbREkrfWm/NvAeigAnUPzwUht87InkNaEhul4HMwKCd/9UzYk+AuOX6lXRTMHVKVZvWwj++W2jPsOsf/69WiGJa6hx7fTDLaYUO4u4DAT7EBXT/b1OBEqsMO/HfTY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIAXxYe2m9bayZnYl/SBExfOG0ZvM3VquWhAHr7BmGI=;
 b=vCvpln1Em9ae/5VS5e3FVZs+wAFSAxvkNyPuxikFXoot5+yvYNrju9wFsdCC+tMDWwD7Lss4x/UeGGPyfJFWcciRrhA003vCXne1DQgq+PKLWIoK+0WEGzyPC9WgsnTGe5pTxiax1Aa55iK/Bfed+EXvZoHlHByph0z9Vk15dW5IVqRZDgbTQXPjNLEBsk80PHwkFqFeOMTyoIOkJRRBxhOC6H+ZDwGCz4oWOKy1ivOHwpT5YPowXMCJstUfxll5hU5QXPXwpQIWEdH2W4Pk/NpJqC6iZIF2mRUwPIaeKYW9c5AkFlx7ErU0geIeFXuvLMYJMC9LFpj4Pl+cY7af/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIAXxYe2m9bayZnYl/SBExfOG0ZvM3VquWhAHr7BmGI=;
 b=bBbtNLQ81veNwMZAhdvxBglRRz25LRtEE1hm4oAbMAos8eXbX2ykl2yjdP4X8T/8p2w9/M9lwo0o/n9wMuHTAknSiV8sxWs7GkcibFnChx066a7wZSFurk3WJ7/7ifuGDlUZaMUKDBtmmDdbUAjVMZHBA7Qgt1xnz0h+z3saTzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8717.prod.exchangelabs.com (2603:10b6:8:214::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:31 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:31 +0000
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
Subject: [PATCH v7 3/9] ACPI: APEI: EINJ: Fix kernel test sparse warnings
Date: Tue,  6 May 2025 14:38:07 -0700
Message-ID: <20250506213814.2365788-4-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4095904e-4846-42e1-d599-08dd8ce6587a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZDPQjAwPzpVYGMu5f6sYveQLDEmeUHlVFc5KWB4Ifto9cX7P0zp39GgEMQum?=
 =?us-ascii?Q?h9nT0k3U12edATD+XGkD1IS3nThTYh8lETEujBQH1Z/S9xk/xWq8VgltQcy5?=
 =?us-ascii?Q?dhUFf8xV5a/VJyxkWdBgk3P2RbcENI+GNvg0rIpbwykEpulfIBTaA204tVZu?=
 =?us-ascii?Q?tBYVcUwUKXsPsRk7LyCCMrMQXvjH01ASdfYwdR13gOk1BmyePQJFxnaSAI+J?=
 =?us-ascii?Q?D045TyP/I8TiBGN1wlo/2qCrt0IyoYCWVig+fCN9Jt43gA1HSR/4FXimdY7s?=
 =?us-ascii?Q?frMziAum+l56xBohmU945C9IDo7hVH+JDfUFzGjzYyKCC2dfCAbbWKG6q+IK?=
 =?us-ascii?Q?0HllSDjgWCaYHprtj5bgTAso4Jl75yUP97FNgDhISmwlcBm+0KtOBjGD0pPS?=
 =?us-ascii?Q?6EewNigJOwGjVitqkfh8RLvg8xhXovZNJ9x9V/Q+ahcUi8qX4tEbHh1i0+1O?=
 =?us-ascii?Q?uOg47feJQlG/lrOgXkW9cnMHSmwTwDveV6Nan7Bi7fJEQQSm1mvo07G0GJk2?=
 =?us-ascii?Q?gmZM8dfAfdORMYi73WYEf7hZyXfPeTcCx58NzQFbrhih5SOPtk254/bmg8RZ?=
 =?us-ascii?Q?NRuyeMEmqT+HrmtG85/UH4+oV2YKmBkJYxtAAzN3TgZVm87tGafsdZ18o7Dd?=
 =?us-ascii?Q?/PFmLtrCC/qNJ1tCzkLzr8YExj+KqcrVhIn3cI+VZHv2d+9p3PmR77byK2ql?=
 =?us-ascii?Q?tqu7SdP5aRWBL6AGG6+7gsAgO3q9oK7CQZorZZd9TublNXul9d/D8Y1LWzBo?=
 =?us-ascii?Q?TzgRdKUfYdvG1cewTJlbHmDdaJnkA2DSPFnhDoxlR7CWXn0cDtzDHAVC892s?=
 =?us-ascii?Q?OMSOLbZfkzMaOAAi1oJmlTgQnexf/91Z1GGpveihD1jTQ07R3tYhII2zdeER?=
 =?us-ascii?Q?sHMYUIUqQHJloa+GqkdMvKhP7gmCr5IBohJKnAUvi1QNoaSoQ1XE94FsDDQB?=
 =?us-ascii?Q?rLv0jCmnLKfbBpbserINhKTM/G593ELbz2wVfZCSoltRtGOAzdaZZVlXNVQw?=
 =?us-ascii?Q?EzIM4HTSMYipUMN3zYw4w60iVfIkHtdFAlURD9DV9pzSYei96s7r+lh2+XoF?=
 =?us-ascii?Q?xDhfaxhWTFb6qV+aZU3DaYrcBkK03G52vEimEkSMLoMaJQFj9m0AvDIE7mWx?=
 =?us-ascii?Q?XUn6EjUZ7xJOK8S/6ZCoIMyBm9JO9Bcl62svCdiHEFJ69Me2jdzP0TW3/eFq?=
 =?us-ascii?Q?igW3J+oXMhlKar5+aM3RKlU/OWNRcbJhye8eFKZ3ndnsrAQHpdPWLejqUlKT?=
 =?us-ascii?Q?PrpBiOXgCi5QxpB9LXtxV5Zwj04dzFpqE459rsnazsQUAJygLPWSw7eJnSI1?=
 =?us-ascii?Q?CcS4W+fOkAhGrBM5kWCL78EfM3TNlo5VbpljL8CG4NPsU+MKSovY2k3AE/KD?=
 =?us-ascii?Q?/ZxdqyE+PV34CrIKJ6m5DJtZmCSNEj3H1t+NPwoaDULnIb0ICPw8EoVWdGHJ?=
 =?us-ascii?Q?JIRpxoB1+yj/Wx2go8LN12um9x7qpOHElRE+xCon/HbFcruUMmYoZPkLLezU?=
 =?us-ascii?Q?P1XA90FbdNDs2P4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1reUOTvVNfUMLXnZY+ypNNE7i5CQ/tKpB186ecXR2X84JdNcciPB+go/tYSs?=
 =?us-ascii?Q?+1uGH1WMhcMQanUsNz4osmNIPGzKN/jC9ONDe3nGezviCAnwQ+YfFJKi5xYA?=
 =?us-ascii?Q?WXYkQDlsInvJfwNkSGDmQAsCOxoUlP1QVgUMn/8VnNSmMIult1++oOknRGST?=
 =?us-ascii?Q?bnHeo4+sPNm3eu7CYb0PFuYsxBCL3xNKORlnwITx24y2K/tOi3S8ztWyLQkG?=
 =?us-ascii?Q?g09zfFQpzjnTSzdBtpLw0hkYaT8HOgIzv2p3EpTQHxxp+5JVv68m8NjRnYsQ?=
 =?us-ascii?Q?U7JQtw2UwfVnz4d4F92DLB8WyT/qjwtnlOYn8di4jt5t7FtG1wb9qvkAwXvc?=
 =?us-ascii?Q?v8rStoutHn3/6VkcDNIZNtlfAv0IrYfA7DD/H58dc6I1FTX4fFOOMLfBfQeU?=
 =?us-ascii?Q?hI/nvMPsF5rYvfAizF22qO4OtVk9PeTHQ6T7ATo1VhnWeV1SnFl8uq4xtp2Y?=
 =?us-ascii?Q?Ual/KRdVyIRBCjwNS9npgIXixlerDkDaBl/zWhETXko/J6DHLaSgr+jQJVDC?=
 =?us-ascii?Q?creGUqcSpI5OeKDRzn0QLUDxQSYGqhhAU6P09AFAodwY9GEBQ+6prYoMFiYS?=
 =?us-ascii?Q?tgjD0WKqup5L+lYokULKLOKutwySai9TuOrXjdU86C9zyTa7LEPcIpQgTAPm?=
 =?us-ascii?Q?0rsQmBLXBkxipqBytoBpbHYgF+rghR2iSM2A5gm45EyJZyEF/94YImUWI04Z?=
 =?us-ascii?Q?/cFRJGXR7JpKDLpySJEbrB6w3Mr3me9lemajninaRHuuN+s/s4nHQjsZGjPp?=
 =?us-ascii?Q?bCgSB2d9ZF1xUwmeoK8JR2UUyXhc8yTQAGGphiPPZsiIQl1nzT17UIbnqAdY?=
 =?us-ascii?Q?KL0YpDE+hcQWVKRQS/rWn5mDLw9W80JTp8HyqySfFwd1wUyDJNG0qRv9xFHo?=
 =?us-ascii?Q?xF8z2zArDs4clawopVL+zy6eRpkhBmYbLzTXiJC+PzIxBjEDe7LGe12JmpdD?=
 =?us-ascii?Q?Flo+kMBGk53sWApb2JcdnS8JAdGpg2+YrOTu09lMBVh+XS8u7MZ5oKieEWj5?=
 =?us-ascii?Q?kHLC6TiAHTiF4mg+iu+NeZoaeSDgPLmgD1Q8gPXtpbWBRoS5OA925BfWaUCO?=
 =?us-ascii?Q?rGnoqL4tU1YIIKZclEF716lUReO3jRDl4V5IXEHK/HqrhGh1F4FtiRDs/fYY?=
 =?us-ascii?Q?3gr2IO2RZow67IBr8NK3Ggs++x4zpAFoQ3BYBrk0TQp2jKDSNu87fzhFOet3?=
 =?us-ascii?Q?n0QsRGLpJuHk/FswVVz1/GKrlXi5My7VwG3nJZa5JWWYCqIUIPcbn6AZAX+7?=
 =?us-ascii?Q?thgv+zAtG/zHeDgaU2MYWkpFrwIZYj/c5wL1gUOY7qZKEepWRGsP2wjMYHOx?=
 =?us-ascii?Q?IKuCjxeRmlKWy3YjsWDaC66HbHwSOcwGNT8eG8jqjkQjVcbFaKl5QweRdbYa?=
 =?us-ascii?Q?/UBCmOtacwC8O5mHtbPVLGSNLzRRHd0/0q6d6r8rlujEz2TZqeyPdzijNEoi?=
 =?us-ascii?Q?siHzxuCeQZomSEMBNzUJGhWlGVW+kPmZQzMguiTK9cX1kJzhnRWhDxXFCS/o?=
 =?us-ascii?Q?oZnjVCvlx7By/OXD520zWJwXJ4q5QWIedXmpDI8LUGjcnTvrqnKA3zGPMdYj?=
 =?us-ascii?Q?snOQAzxmTyc5fsc5sey286WD1NPbTg/K6+PX/0wnUeR001eDq7g84fZuQ1ZT?=
 =?us-ascii?Q?PDH0QLX8wNWLI/5/GFuiAJg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4095904e-4846-42e1-d599-08dd8ce6587a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:31.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLrV/O3kWCUciPjeDeMRK4ftD+cj9GUgmImVf2WRlqxbX7NjNQDocRRXd+b2dpkV52kIecCMgrLfS5ZGx/3oX/gG0GsGy6woUbbgpFni7g2dBOznbW/cP20gdICZV+94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8717

This patch fixes the kernel test robot warning reported here:
Link: https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 106 +++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01fa..47abd9317fef 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
  */
 bool einj_initialized __ro_after_init;
 
-static void *einj_param;
+static void __iomem *einj_param;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -214,24 +214,26 @@ static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
 	int	offset = v5param->vendor_extension;
-	struct	vendor_error_type_extension *v;
+	struct	vendor_error_type_extension v;
+	struct vendor_error_type_extension __iomem *p;
 	u32	sbdf;
 
 	if (!offset)
 		return;
-	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
-	if (!v)
+	p = acpi_os_map_iomem(paddr + offset, sizeof(*p));
+	if (!p)
 		return;
-	get_oem_vendor_struct(paddr, offset, v);
-	sbdf = v->pcie_sbdf;
+	memcpy_fromio(&v, p, sizeof(v));
+	get_oem_vendor_struct(paddr, offset, &v);
+	sbdf = v.pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
 		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
-		 v->vendor_id, v->device_id, v->rev_id);
-	acpi_os_unmap_iomem(v, sizeof(*v));
+		 v.vendor_id, v.device_id, v.rev_id);
+	acpi_os_unmap_iomem(p, sizeof(v));
 }
 
-static void *einj_get_parameter_address(void)
+static void __iomem *einj_get_parameter_address(void)
 {
 	int i;
 	u64 pa_v4 = 0, pa_v5 = 0;
@@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
 		entry++;
 	}
 	if (pa_v5) {
-		struct set_error_type_with_address *v5param;
+		struct set_error_type_with_address v5param;
+		struct set_error_type_with_address __iomem *p;
 
-		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
-		if (v5param) {
+		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
+		if (p) {
+			memcpy_fromio(&v5param, p, sizeof(v5param));
 			acpi5 = 1;
-			check_vendor_extension(pa_v5, v5param);
-			return v5param;
+			check_vendor_extension(pa_v5, &v5param);
+			return p;
 		}
 	}
 	if (param_extension && pa_v4) {
-		struct einj_parameter *v4param;
+		struct einj_parameter v4param;
+		struct einj_parameter __iomem *p;
 
-		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
-		if (!v4param)
+		p = acpi_os_map_iomem(pa_v4, sizeof(*p));
+		if (!p)
 			return NULL;
-		if (v4param->reserved1 || v4param->reserved2) {
-			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
+		memcpy_fromio(&v4param, p, sizeof(v4param));
+		if (v4param.reserved1 || v4param.reserved2) {
+			acpi_os_unmap_iomem(p, sizeof(v4param));
 			return NULL;
 		}
-		return v4param;
+		return p;
 	}
 
 	return NULL;
@@ -317,7 +323,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -325,54 +331,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
+	struct acpi_einj_trigger __iomem *p;
 
-	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
+	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
-			    sizeof(*trigger_tab) - 1);
+			    sizeof(trigger_tab) - 1);
 		goto out;
 	}
-	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
-	if (!trigger_tab) {
+	p = ioremap_cache(trigger_paddr, sizeof(*p));
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_header;
 	}
-	rc = einj_check_trigger_header(trigger_tab);
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
+	rc = einj_check_trigger_header(&trigger_tab);
 	if (rc) {
 		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
 	/* No action structures in the TRIGGER_ERROR table, nothing to do */
-	if (!trigger_tab->entry_count)
+	if (!trigger_tab.entry_count)
 		goto out_rel_header;
 
 	rc = -EIO;
-	table_size = trigger_tab->table_size;
-	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			       table_size - sizeof(*trigger_tab),
+	table_size = trigger_tab.table_size;
+	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
+			       table_size - sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
-		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
 		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
-	iounmap(trigger_tab);
-	trigger_tab = ioremap_cache(trigger_paddr, table_size);
-	if (!trigger_tab) {
+	iounmap(p);
+	p = ioremap_cache(trigger_paddr, table_size);
+	if (!p) {
 		pr_err("Failed to map trigger table!\n");
 		goto out_rel_entry;
 	}
+	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
 	trigger_entry = (struct acpi_whea_header *)
-		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
+		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
 	apei_resources_init(&trigger_resources);
 	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
 			   ARRAY_SIZE(einj_ins_type),
-			   trigger_entry, trigger_tab->entry_count);
+			   trigger_entry, trigger_tab.entry_count);
 	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
 	if (rc)
 		goto out_fini;
@@ -390,7 +399,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-			trigger_tab, param1, param2);
+			&trigger_tab, param1, param2);
 		if (trigger_param_region) {
 			rc = apei_resources_add(&addr_resources,
 				trigger_param_region->address,
@@ -419,13 +428,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 out_fini:
 	apei_resources_fini(&trigger_resources);
 out_rel_entry:
-	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
-			   table_size - sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr + sizeof(trigger_tab),
+			   table_size - sizeof(trigger_tab));
 out_rel_header:
-	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
+	release_mem_region(trigger_paddr, sizeof(trigger_tab));
 out:
-	if (trigger_tab)
-		iounmap(trigger_tab);
+	if (p)
+		iounmap(p);
 
 	return rc;
 }
@@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param = einj_param;
+		struct set_error_type_with_address *v5param, v5_struct;
 
+		v5param = &v5_struct;
+		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -490,15 +501,18 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
+		memcpy_toio(einj_param, v5param, sizeof(*v5param));
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
 		if (einj_param) {
-			struct einj_parameter *v4param = einj_param;
+			struct einj_parameter v4param;
 
-			v4param->param1 = param1;
-			v4param->param2 = param2;
+			memcpy_fromio(&v4param, einj_param, sizeof(v4param));
+			v4param.param1 = param1;
+			v4param.param2 = param2;
+			memcpy_toio(einj_param, &v4param, sizeof(v4param));
 		}
 	}
 	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);
-- 
2.43.0


