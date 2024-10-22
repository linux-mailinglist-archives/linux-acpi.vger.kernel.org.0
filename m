Return-Path: <linux-acpi+bounces-8916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B559AB8BE
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D76C1F24336
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5C1FB3E4;
	Tue, 22 Oct 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uni8z0HC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181A1F9EBF;
	Tue, 22 Oct 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632894; cv=fail; b=VoDRmBCb7io/dMcihIA9LwaJ6dZ2PzeYcrQuEqJozmTIA2DLMk6IqSNpVgwiPC/Opyq+stBoV+ha/u5pBgdJftSKxgEsvInaykKH6R3zw70Dd2WmLAHve4Fl+HJa7uNcqgvDQFD43nLoOvdziPsbHsdTshd/GgWzt9nPL0DqqJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632894; c=relaxed/simple;
	bh=inU4LKjxZ3bA+W+3VsFgqsEeAOCacrEw0PSnRO9AEbA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7T7JWNHPUZjJNVIYmdG6AbGxEREs5y1q2++U5CYz8Qu4xcHkCqinniqiN2rIOQLzwOglflE23XF70gAvTnIuI2LsQEByQPpeCFIKveCzzbnJ+o/ZN71EOuZs6cbLSXp1RrbAk9Lz9wKImPM+7IZU33Xgi+PKvR6cu7t4xBknjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uni8z0HC; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee8fzLoidaX8/S6znVjYMI9dt7L3gixkXhcfO9YBaZq0em9JHGPoPN6HPtsbLJNhuwD+wI+inuW2/ToBmw1qda4rEB9p9DaZwZNx/huVGF5IPc3ijE7QDpDS1moFi9lOqC9f9QWi+gU9IKPnZV8fEujy5oFFukNLd1t1UQ6Ui8QAhbC/HQRhIxCbWOKhvuUvt090g7Y7TdgMe63Lm53HXFASH+Cnvs0NLWP3ltipTSgtV0yQyKE0zEEexWb2TuSh+2mJZBOoD6C4u/EA02yuyrNu9sTE40O3AdI1WRw+cBvnWZNMIc4eCl4fsKA/WsGLiVAmq+nz2cr5rt3wO5qzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUrSB5OXVGInHjspH9AWJRqFUGr5GDfBfBHtLNol6nA=;
 b=KUz4rVsjJJsHj90LhCtJpqCMAi9kgbNsI+vmyS81wAr9Pw0IDf9O7yMQZcTttMdpdxR1mlYM29GFGLlAgLaSTa43uXakN/E7/kVQFjXo8bbUt3cp35TuIZakCCRMZK+SJWS9neKpCp/Qib8V3x4mWm3+zXuqbAOGYuxQ5h2QieQT+w3yhLwbEVHcfzhkbo5xzX7DWVrGrF/A6ebRg0o89lvoU1QXwCUjDstfumvnIM00sJblnSWGznNEcS9P4kHT+rMhTco0CEyDMhOQIs4QDeyUeMWJuYYnydoZzIBRqbL7tSc/kQBUCkPo3fudU2AOZE/Qtevcag1GqtI/J5M+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUrSB5OXVGInHjspH9AWJRqFUGr5GDfBfBHtLNol6nA=;
 b=uni8z0HC4fhjvzlMChFSIyr6Nq5iMLMTzDzCJEnAjhNNoOAYBeOEjGS8myD3OCsbFIyXNNj9uEFqYnv+QS5WC9PMqzouJXzKIcgurto6PJ9qCJmiu2x7r6yMsGJhMVZdSo5xU7uERAWNM3vbOko43zulBLz2HNW2CHIW3UA2pZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:47 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:47 +0000
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
Subject: [PATCH 5/8] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Tue, 22 Oct 2024 14:34:26 -0700
Message-Id: <20241022213429.1561784-6-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: d75ed08b-3682-4ea0-ccec-08dcf2e15a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3i6FxFFhrufUdSNPZcn8UlHOg52kymK213HVIskbolAaDY++/3kXDXwFmER?=
 =?us-ascii?Q?OMKtJhcHCOuhgHO7ybUl9n14KjNzu3tCbJU0tvsLTxpqvE7GbTI+po6R1B7g?=
 =?us-ascii?Q?z/w41Am8PAFlyyElVPlrsMvPS9Snoz0o7u0aLpPG1d92OcxGGKAaB9m6qndk?=
 =?us-ascii?Q?UtrztLELSLlUh7neLltgtycG9Q5vLW+/h696UIiMeTSqP5goF1WXCRc8XKdE?=
 =?us-ascii?Q?W6B9h2DKl4aK2N91JRPdMG6XKLILwfUzgCvibxmqAfYWbGe70tntk8XT88f/?=
 =?us-ascii?Q?xgTFkR6svj6wNWefxOmyg+SRfn4z9evJet9R6P/k4ozk6tODV8hhqGAGfqmO?=
 =?us-ascii?Q?ks/2h14K0VbQuC4PAkZwlL+1cLJFt7Uo1yktjz1lR/DQijQFVanEHLSlfu86?=
 =?us-ascii?Q?iTM7PSEvzM//iptxVHTUJEtzWDTG3WVCJ38zPuXW3NT8uoTIZzxSIidtLab/?=
 =?us-ascii?Q?NDRfWElDB/BSIYNGpxiF1y4/s9aHVr8HDrgNwgr+OrPCm0jfryk8DT889Hwn?=
 =?us-ascii?Q?ZlpOxjSGKyUmPmnf6hpYgt7rKlB7n/bQl2NFRLLib0vxnQWaseCsMBgY4hLr?=
 =?us-ascii?Q?CbgLz0xUYTgV7AnjEnTyO1vZ8ErQZnWpMbofCb60RHm1Z/Jar8QxmbviRvtW?=
 =?us-ascii?Q?Cuj2xapT5zQ+BBv8kGTxUgq1YVu9y1vlXj9gN2ToyLbCKBzBlDBEbyiFTrMK?=
 =?us-ascii?Q?F8q8THrtyq8+2R7Pq6ie9zfyMEZUS60sWLbF3WFG4wCAN8GUZuEd482ewhmJ?=
 =?us-ascii?Q?L+urMvlY1glX6C/UWlGdkdelNVjCz6egWfJvaBdVdMbqJsz2Bg9dnLn8kj2z?=
 =?us-ascii?Q?cp9ow5HFvFJULZkq4AIamWuk6SAKieBrsGqhybs1X2nfa+CWxu6PjfJdwgSY?=
 =?us-ascii?Q?t0k4Msz5R/YBuuyckou3dLUdekuxIFfBt87r7I2YwYB5D0XHKzv3H5lAiHat?=
 =?us-ascii?Q?mYoH9sU08AIQXsXSVpjOctuDX723BdsHiBWc0OX7VlLUyBI36555NlK7M9j0?=
 =?us-ascii?Q?BdfAJPRV6WmQqWgkA1QPcPLn6AS+P1My1ybMOIkbAoenew+LIK5+1wqJDHxb?=
 =?us-ascii?Q?o+DmM6CYj6/r9sAK5a/cSfplMmmGiKhN4OwT7iNonK7N+mJ3TIb+NZL57Xvm?=
 =?us-ascii?Q?0lX7owcn1Cj/v+WboqjWRMLgXh5EL9o/zAr7no2xUZMqHDHfpryKIyyepdEP?=
 =?us-ascii?Q?+fRaP1MNTxZE6VLZsEYJmO3oTY4QG8lPETJjXsaLrDNjjWpJq61/U7Sca66E?=
 =?us-ascii?Q?A0sNLtQoI4KL2yZbdJ9AO+dJtCMIJkoNekv2YbltnfwkUpaI60opR+A9FZSS?=
 =?us-ascii?Q?3Q60yxAdDfNbpIl6DpWl+bo1gXhe2rMDTt2x7MBfAA5S6Y1xwH8D3FpssEgb?=
 =?us-ascii?Q?pJ2NZykNQPvuqvOeXccGXkfEhT4M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgO2IN1bcxRb2D0PafVbYrv6zP6YAfsYB471njdN4huuljvOLxShINdACTT7?=
 =?us-ascii?Q?DpeoK2YN7KkRyRwfDbxLXoY4nvS+1N6fUZcbi2EeLBMsmfEGhqyaTjvjGTFz?=
 =?us-ascii?Q?RVrduUHkdapthmB234IrO0jb61W/fbxJcPoOngDOt3GLFY5c5Tw/jR5Wm1CH?=
 =?us-ascii?Q?8TGguwdNw+43L5BS4KVorCaz0uZ0apnUQseERxVQ4XNUT0Drp2l8F7aVUZ/Z?=
 =?us-ascii?Q?q4uO1tS+AEdI7kGdgjAXByGnIv+exawlFSQxA+IlgvQab2cEKQdRi0AX5z1a?=
 =?us-ascii?Q?Z3x/Y0aetqx/2W2qQYRPAZzdnYeZdv6qzdZMr2Z1vbbZEWgjsAVglhUQX0w3?=
 =?us-ascii?Q?9/alzJv+GIiNofvkM14jN2ybfg2tKRAtHSPt06F7WAT+P28lfuWGimwhMflo?=
 =?us-ascii?Q?gYetqXfxErt3B/TcbaJQhNsSQSRWt6pfsksR0ocmJtgQNW1kCAQcQ1vom99x?=
 =?us-ascii?Q?ieJiYILwaOf4ubglcu7ptn0QDUAM5xG/LKvoKgk/P77ezO1xU9KpTdNv9oYM?=
 =?us-ascii?Q?jGcZ6fvMOp5A4HmtevDUrtS20vm9R713ZTygMq+wt/KuX1BWa58WyVuYhif3?=
 =?us-ascii?Q?pAl0ONmxAaflZAyx7JDm6wQxKIe7MjrfbKolPWh3JAlb67bceRijxQRVytwR?=
 =?us-ascii?Q?KIXIf/LvF29k7ZtQSpRKCaLdccwR02Hpfnc9KX+Rcpdkv9/MLz5CGQp2FPLL?=
 =?us-ascii?Q?PChdTyjkFaGX8DyJ9C9aIp/AdeyIunPnVOCjP6NAS8g+iDbpJljmgAdhy8Ab?=
 =?us-ascii?Q?FWo0Z8G59kurc3Uqznl6tBn2ZKAx8FWGRqfLvZmORrfLP7OqSrlLb7UYhW4d?=
 =?us-ascii?Q?W5gHsSeluaGboyNPdGhImPSwkpJwfRnteXVESHyUn1zW2eFn46RKY+Qj/cd7?=
 =?us-ascii?Q?Z+Fpu3M9WLx6Fg9c04bqXJ3kgIEyv9u82rM2cX7rb/7CzCF29eaSoul9N4PN?=
 =?us-ascii?Q?HNoOO9scUHcmTIV4j9y+hGL+q6j1ZRw9g9wpzGinZHmd9NYkw4iUDvz70a7C?=
 =?us-ascii?Q?gkW/Gydon8rLwg81Hh3+kEgRoCrwSC5hNKqRRlkmQ8+XdNSDWCMV5KoEPtbC?=
 =?us-ascii?Q?6bYKDcrlvKj3reNYY/4Prpw5fUmnizUfpYVXoGGCLx+6h7cU2qFGj/I42qMn?=
 =?us-ascii?Q?5tzRVvQ2R18IcWc8b/1ZH2We3r4rTpMY4cV62sxZUFzPTUoqvCDOby3L8lfU?=
 =?us-ascii?Q?t9XfIG3be9JZfalYgYit5+5Njl7EaKNmgxpKTFzrqE4AdtV2kxIhCcngvQyG?=
 =?us-ascii?Q?nBEH4Ks1ZmHxXun1KM/U9iiCf1jczM+srJ06veA4Ov+MFQ58umfY+8GSDEZK?=
 =?us-ascii?Q?fmSI8M/34c26f0yJM3yAjj9xWOZe+QHy+hmb1ZLjh3bIp21vCoUjaLPM9n+5?=
 =?us-ascii?Q?Hd8t/Yf2pd80cAQQIoVqm6p+zTDsnS8bEbCcXWs5MsUCit7mi1ccYXVOevNk?=
 =?us-ascii?Q?6pz6T3gu4MA9H460BMYf99WbIZcoKDDJVZY0y5aVDuPtEazTsaqOWAYUW2XP?=
 =?us-ascii?Q?xWEfP97Lr/3xEvJy3bTmmi0Jv5GMctiyZJsSKKb5TC/4bYgUEErV27ySL4IJ?=
 =?us-ascii?Q?m9Bt4Q13P/Ffl8ElqV2mQsevx5J+gfQnmdWmObbTLH4iwPs8/e9GrVGM0CfW?=
 =?us-ascii?Q?Jur4wwTDYhU0CsBCUE9TCbE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75ed08b-3682-4ea0-ccec-08dcf2e15a38
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:47.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFuCPyy9Q4g14bOjJuUCJhigPbcrsMgo3R4XTZmAvg1vAVANS6yPNB4yq7YAVlRwzk9KhkDpUVE4xtmLq6S/uD0t8aRjR9uvbWzMU322gMbJJhE7cIXx4J/UcqLKnIx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications(1) enables
EINJv2 by extending set_error_type_with_address strcut.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 3621f071a735..31a13ad6c4e5 100644
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
+	struct syndrome_array component_arr[];
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
2.34.1


