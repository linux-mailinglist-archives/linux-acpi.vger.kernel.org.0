Return-Path: <linux-acpi+bounces-5923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506B8CB528
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14FF282DBD
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40D214AD15;
	Tue, 21 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZKYUYZIw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782B14A617;
	Tue, 21 May 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325864; cv=fail; b=NNNeuyZV279tzutCE1i55M77+VHbv7Hlk2/8TIVKkHLaczMl1Dq3i+j1qw8KsPW2NiKkf0w74jg/7Uz7nn/6OUvuiU5ONXjbcW4iXBwYHB0Q5Fn+l11TiQP5cmRF7jY9MU2E40FCbhGw+Xze9ytKnCKGfEmDN5rijs1wEKSfZzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325864; c=relaxed/simple;
	bh=PBtmXRPcHhJ8QTun7ebiAxEzdc6Y44RSGtRrez5j5zU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UuMgePLvm43hpB7b8Wq+5CQxSx1uyhFT3iJ+tLCict5qO5W4IfFGMvFxdeplMkXI5j44NnoTgeBfcSOjSlKRnwaxfbffWYdjjGfvnaI+2Wtb9IKngXwJVDea7aAzZxpmxj+oPLmS4r7fyYNZWaetoJQ2pfziryU8LE9DjlGODhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZKYUYZIw; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCM31qBQfuSYvLyku1kiBZxKiWpZouvNsA/WL5430d2ogwN+mMWVhCK9B2OWVFJFrMniZKVI8KU87bMAHIxHyfchSkR+yEnqGL5+a70uKjMgahQzVYuRzzL5sWhFrB06Sp6KEkCzuGlpXB/7LQKkmn0K6wsHuKsi6ZGgo7etrPh22vPnCggXLSMmHHk4Gk8yXeu5CX0n5cPmb7ApJJPbkyhmdEsAIBYuRHkawqqqCzMIoMqjRExoZWkM0yuYNmCJYTnOeahrTXrgPAN8rySBCO1Y3ANyGrFCXaD8JPD9OIQ9p6gG8DrBgPbJqS8GC2UYcrnTODSqreJp/Les1yzk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4foFUEueSBABzFcfkV68h9/Shi4TGvG61dUWODqFAY=;
 b=lTrJ4BGsGXoRjuSonmTAZ+MESv1ph7bVGif/ckpYRir66ZKUHK2eWNNrSk2erwd7EZvU4Eo8cBd7FHjqBLY4qhl17CjhvLLjcecea+VF8uadukwg56TePrr7meTi3zQ9Vlgql9DWyX2MG2Vm76QJlNCivwyOajc/euu4ldrazkxjHVTxrKE2cARp0rIThIMV/dfeTJYD5D1OGysCGtoyAzZz+mmA0l8E92owVWb/fBKUe+tvKVmpJIfc5WTuiC0q6aQjLHcTKzBTUvq73wjE20vECPgc0iS2XozTkmAEb2pm29tZ09bcrP//Ooibp9YENhISsjlNi/m9qJqsddpnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4foFUEueSBABzFcfkV68h9/Shi4TGvG61dUWODqFAY=;
 b=ZKYUYZIwWD5Z+5uc7HQEfnqwmXZDh9dTkudEw5D/YK1fm2oXv7Qi42RNG0F1eap8ANmLO9Xs/1JZR2OBQ30XQ7RSU0MvxBheHB99YGgOxLijlw43GUHbx5WF0QxPW8sK+pYjwOT9MGiBR3tL84bdDTx5e0rEzjF9ECf/uLTG708=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:10:57 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:10:57 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH v2 2/8] ACPICA: Add EINJv2 get error type action
Date: Tue, 21 May 2024 14:10:30 -0700
Message-Id: <20240521211036.227674-3-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW6PR01MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 338fd137-cca5-4803-a178-08dc79da820e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPtgsjfc+GXDtZIm2SwstA/ajYOXGesXjphwI6mcwUWkXeXQMlBW4zn2jZ6y?=
 =?us-ascii?Q?HUGKFCODQqZpPUoTgrHOuPiA9eYtyaw3tJi1xjbu2NWK5ISruD/I0hyJ2WsC?=
 =?us-ascii?Q?+dN0fz6gUq3p3K55urEvNayMxwFZ0W+PlrkBTR97GwSpMxtH430A339/hKnD?=
 =?us-ascii?Q?yaqFW8dV97KEZLcVNswrytVHMtHHSEOoIXjRKbmKKZ8oaNSve/ugWu253SXa?=
 =?us-ascii?Q?wWphZxji0bkXjVA0Wci/peJnFOQTDJ3dNV3lxrNEAH4Gyc35121NGDCm4aOC?=
 =?us-ascii?Q?poS4OeTJkZ0LSe0lPFSQQDdRIzaDM8WaQkpZsB982L5BYd79EfhDHm12v8Go?=
 =?us-ascii?Q?jsz96xMJKrDCC9nXHGPfaaE8DoF0fDIZDbdS5EJRmPE1qDOxKZY+uBfYpZeJ?=
 =?us-ascii?Q?0Od73CGXLsO0qYsK0RaEuZyEH3hyyRSH+oi3Kx86ZCAAP+IY67xAEeSnQCah?=
 =?us-ascii?Q?uUN2MkYayf28RrntTRkeayNSozuSiWVCXwfaQvvJJJK2Y9kZTyUU/iNk/p/3?=
 =?us-ascii?Q?cGOt4UgAk05J2buW4cWi6dehhxQREXiwUWgnaq6gZq/uKDCWY5MPv2oEAIR5?=
 =?us-ascii?Q?WczJH/g86QPrOemrbV8cEBElr4gCSuVyS8OX23DiND08JNSbz1kI12bAhlB2?=
 =?us-ascii?Q?m7q2lX0f4S/NwR1ROfnqCWA8+P2Q5N+5zv82jBHVFwek3kPf7xna/1ACmKQf?=
 =?us-ascii?Q?ks2yiqnoxYyonJG5qk1gsWnyhsBfjXFCka4Axrtnjv7K1ylD9aNvyZnFdkB2?=
 =?us-ascii?Q?aGgZP0hpNkVIJLUqAmLvGzUYBHVhMHcFfnxwVxIR7diDY0wUU2an6H25AY+O?=
 =?us-ascii?Q?fFa6IORD8d8soloM+MYib7ciJi2+ln8A7ij4BBxrj3TxBHwXm/xytsdARB6y?=
 =?us-ascii?Q?0ll/gj7cwCFGOj+HIUBo03PIPBfY1kQ/vLcbB/4kl+NEwOB8xN/Vuo+0lRb+?=
 =?us-ascii?Q?6bXzzWxCk0lmHHEmUxas9iRC2JcTT0xTgbXv8kMjlFKSq4/z+xitj2JQC8BX?=
 =?us-ascii?Q?zD9LcBfQgslYMRSLG9ad/EEOumCGWzOciBQ+t5/3ocAsuwDsdy7pzyllU3ev?=
 =?us-ascii?Q?ipPf2xLja412XOhk6mGZBVAxTVxR8BuRmgxUIIYdPpHx4rhjN6eLThobHBpP?=
 =?us-ascii?Q?b5cqrwTB4YY3wnGakXMDQCB/JCzuMs+dxHMUIfR+2qOyZpj1tPy4oC+XDgMM?=
 =?us-ascii?Q?KShIQNGN5t3vMQZqRrinSNCfbhSgm0Ju7sPH3gIbAqhwbGwcha9f48xO2IHv?=
 =?us-ascii?Q?ha6jHblPdNicjybBDv0cGCZjkwlhY/pKvmTRBnKxTyykCd6rZFteECrEABCz?=
 =?us-ascii?Q?wXghDS3o+2tdcp7YncUMnC4U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jg1TINbj36l2orD7NZsX21h5zpAxMxsrcDdvhAV4UgwKAINstyAzI0M1TV0R?=
 =?us-ascii?Q?W7oGjAcmezSAlC2NBFypAqIbJ0duR/hnG52ZitxWrfIokjcES4udOUlYSY0T?=
 =?us-ascii?Q?s0I+bF9i5HyT7FmJZEF1Aa2e1yOWo6iDHmTKMlS3CMtK+RuocNVN+8KvS7tK?=
 =?us-ascii?Q?r6fcgob+96VZ3hN5xqaohyVE//kB72tPhJ++wStdiuVJKaMdJVFcd2ItxwQj?=
 =?us-ascii?Q?e6p2Dx+uuVJz0FmEXn1PKNbnsJ4TOrHcyCOP9qzRcAIDf2dsguQXA7OtsE8j?=
 =?us-ascii?Q?9JeNj3ZaHMkDJmmLQYnaiBA04RrU2ZAVlqOg/Z9c0nLYaKVw17x1F37l6TFq?=
 =?us-ascii?Q?ASZf8WbG3jEKFAiQJ2L2Kx9Qv1InkVaLt9YLpAPUZCPxjVG0qOEXfxH6S9jP?=
 =?us-ascii?Q?DgdOyadNyrRouNHt1bWCLpq1tamH8tvZ1lvuhfza0ZMXfn/UIrF2j+OeFGMt?=
 =?us-ascii?Q?aKtgSkB2QvjE9pg3AsXljmxDYmEdIYVoyavdqXd/MACJfn2fBlP+prEhZm9s?=
 =?us-ascii?Q?a/p6UgRnGj8RQRUJMYho4iijGTJM9r/4OVqYaq9KC0dZX/lSbMAa4kfvUQD0?=
 =?us-ascii?Q?rPJkT4T/zSlrOg2FRqlgLYE+ZGz7GAxunOAGWLle/nHhTDYx46o9NIu1AVLr?=
 =?us-ascii?Q?8znWtjlScwSlVx85nXl8JCFT/1WT223rS3NfiMQHm4dk5mfl3VBfyh2TTvSS?=
 =?us-ascii?Q?7Scj3ftXdiypWIXO7ksJZVuqiM7z7olHJLpEOmzt8Gimdycwgd3q+kX3UIFR?=
 =?us-ascii?Q?+AEh6M4xhAgfqrfb8aUrE04JArs9TtxJekivhVx3BSQJQXj7Z9uX68i2cDnd?=
 =?us-ascii?Q?yyEezqC7TLJ9WQ2ltW8sW3YDj/OznvlWSeOoGlRDtpYknybYA0RLxedJZJXZ?=
 =?us-ascii?Q?69AW+8N6tgw7ZuhercJEEQqYKsodQg1MvoEKyGuKL+fqyt23ryDwR1odOAQS?=
 =?us-ascii?Q?btwoy47QJ9B+ssIJnmlGHV9vlUC0jOIrbKMf32DeMP6UZRARtWcuM43vnqjA?=
 =?us-ascii?Q?vI+qNTBd+Enet98ncr/IO0Ehzmz0WnebrvyteNbBNltOjyzfi3sL2rK/G6ay?=
 =?us-ascii?Q?MwS0iuxeL6aY33cYQHxTf0Ll5jm+zAW/RLZhHX5V75KMhOqOHSF9Wg67g+6m?=
 =?us-ascii?Q?ORSLz2WqbygfWBtDWSMBd2NLALurnPnJazfq3GBVcxaIMtMIH39sjIXjZjOy?=
 =?us-ascii?Q?6pf3zIhMIWYcuUuqKKLJaCzzI2uE5vr2aAQAVWakVpOYDKXsql9Ds8KB/i2e?=
 =?us-ascii?Q?+fkarztH2d1MqIoA2gIT9TfWE4lZ6mAWPf8Z26X8IYfepgJFXC8Oz3sWBBZo?=
 =?us-ascii?Q?kCa/fo6LW0J+wcWEbW06bAYrOswGnaH3amKcJ2uOWmBq+Glgx84pQCBQZJxN?=
 =?us-ascii?Q?KdzKb9TSHbNSGzDbR3QpTMfE9M34WwXKJT/pXPbuSSuAmFJV4MN2ggh+hxUN?=
 =?us-ascii?Q?QfjJ509zXneDPQ2UMzqtBXBuKfmdSFe5211qtxlqk/9EZYTOJkqfn7eCgoEE?=
 =?us-ascii?Q?R0N4WwV6J+wjnUusbBO4Aef8VbFDQ8hRbbOweFTL39u7gau28cHIXJXQkNyW?=
 =?us-ascii?Q?4MNXl5ZQWOptsOJpRW4AHxZMR93kqMRbw9GrbzcdGCKOwQJxg8MkMTQDcW+K?=
 =?us-ascii?Q?VKro4A9Mw6Hl3TH5FuvAwI8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338fd137-cca5-4803-a178-08dc79da820e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:10:57.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDWp05Nz6VXaYlgBRQ1KS1QW0oL9uTVNKJyVeM3weY52W0WPnM9+6ou2BKzLbeLeokdV/gJPWpnO7ezAHD+NEG8+BopWciJQQuW3nqwWAE0l55g16Y0oL9EANfNmQxVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

This commit adds EINJV2_GET_ERROR_TYPE as defined in the proposed
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1446

This commit is not a direct merge, it will come from ACPICA
project(3).

(3) https://lore.kernel.org/acpica-devel/20240514184150.6285-2-zaidal@os.amperecomputing.com/

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b321d481b09a..35a90a92276e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1027,7 +1027,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
-	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE =		0x11,
+	ACPI_EINJ_ACTION_RESERVED =		0x12,	/* 0x12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
-- 
2.34.1


