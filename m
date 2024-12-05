Return-Path: <linux-acpi+bounces-9965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527069E5FEB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21507165308
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC71CD21C;
	Thu,  5 Dec 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jneyVZ5P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023133.outbound.protection.outlook.com [40.107.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD951CCB26;
	Thu,  5 Dec 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433554; cv=fail; b=pRG6Pwm3Igkje7DZwjEH1pZOcQ07jcqAEtnncZ3jbvdbCCvWdCKqp5TrTD9mMivOCuB5a98NR0LQct6lcm9R1zMJn4YGz4Ell+P4Px8rM2rqVhpgsFC6mxyaBDYT8TiioqIcNHFZsJcdMXNeDOHbMiO5h+V15uk7nDKEkfH9l+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433554; c=relaxed/simple;
	bh=eYb6BNbGVDjKyKbVR2zuXx7Au93uvU7fZ7K4fioag2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AiI5mvA4DV29Rc8d2PjmuZGnbYzAb75VMLxc+VQZFPvQb4OB5EQNngtwH2GpmLkfXWtfMkpu6tx/QC9oHw90iQT3DInhc08rAalacIJkdk9w1D6SK7VQTQLFvtBWTp7Y1hzzy6nTOG4kPlw9AArvz1Gek5UldaFoBgoRYiqDgQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jneyVZ5P; arc=fail smtp.client-ip=40.107.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyE28Wa6W0xWNgj+msOnqKvV5JOe6MysbeVhQLolFMqUYgaKbNQjPt9u6AOEnB1JZpMhGYzCHUFkAtihV8wLHhxpjO1/S3qZCBoAABO2vbPI1sIiJ2h/urfArIpz0d/rUY8QATrjg6AQZM8OjIvCR5eKCLbHobN8juPXwxy0wbSDNNQ4iFQ11pdda8+nuUkbu1jqpZZVqkdItcoswCJMWHWjo6Z/1ODWwmz1XXUsDQZo8D5aI7LmKu47HybkZR61+HHQkAWtEnPBleHiJVvinUSivk1+y8DZqd3B/UXKC9L94enzA6sOhKIa0C7d2gEn6DJ7oX3h5aO4xS9fuTAx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhvf2Dg0tPp7GDOQtlUeR4Tu1f4jCnswHeGRkongp4o=;
 b=VV+nN/CJacv/0s3cvvb83N6daiD3bj9m1Lq6iUYofilaAP43UMOeTlvUnniva82cYmf4+PQd/1L417/riv/xoreGKFkK3c4b8lP79+rYwTDzli7xk+SmSoZ9Ev5TFJZCEUljcibxOzDQj6ql617uWKFAsII2DEZfuFiueu/Y2ABtr6H6ggab9Ws79adJbmudQ+potDdjE/aYhSXoSG69upxDeMupdxI13BFBtJrB039QadTq8s83WrQSHkLuE7VBWiugntmveAM9gYYosmf/djeqWtn99KygKpjVULmGy79dj5+u3FaV0LQo7UKunKLfxcqwnUccZ0IqSfrnfGA8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvf2Dg0tPp7GDOQtlUeR4Tu1f4jCnswHeGRkongp4o=;
 b=jneyVZ5P/CLtaKC+GMDT1J7zt8gpbpwybFRpg26xTZg9h/fPXgiH2Vdm1Z4uxGqMtA1ziMllRtLNExIxDCIFjCgl+Ntd4lyoExZa+F0WZPkipYVtiTb/FJD+kqBmIMSBqsylD4AA+Ffwvw1KHa6t8h3UT2ZCvLqdTxXfjFZD730=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS0PR01MB8004.prod.exchangelabs.com (2603:10b6:8:145::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Thu, 5 Dec 2024 21:19:08 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:08 +0000
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
Subject: [PATCH v2 2/9] ACPICA: Add EINJv2 get error type action
Date: Thu,  5 Dec 2024 13:18:47 -0800
Message-Id: <20241205211854.43215-3-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS0PR01MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 310c8a74-0a47-4ac6-148f-08dd1572746f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KxGPT6i1gujMbkwAeLE5ghxt1r/rmscVND0cC2cuKlaYzsl3jReNuwW3v1Qm?=
 =?us-ascii?Q?JHblOeh0cCPhTIDf+c7TNqVrwbWvo++v/QGhN9O5kpBe5AWOn3iL7dx+iSxA?=
 =?us-ascii?Q?O6yp89ndv+ECfRuicSouoJJN5VGZ6pb50UkLGnrNuSe5VONDq6NejPWqusuI?=
 =?us-ascii?Q?puYAo4Sgldn9XZ+kKmzYtQDVJ2p2tmUl+/AiddWYlVhS3syQNr2JwyAYd/li?=
 =?us-ascii?Q?ZS0+v4EasiTb+kyhV4wKRgxruYpBaPKIg1sM3p7Hye7ZqSPvMbEqmDEnWYoh?=
 =?us-ascii?Q?Fe81h0mHHZuPwMI4bMHoF6iiI7ei2WNAEv7EVxOWytUS0ZQkzbf0w9YUD/03?=
 =?us-ascii?Q?DYolGmS91Xzk7+v7IQLCQWaFCWLi1npZ+tDObmw28hmQNBpkFQakLem7rsCM?=
 =?us-ascii?Q?OLQi7ICvN/+400Y61i+Psc5RfyZj/bNnZ/K/1wm6IYunwl1F88kv+BelcR84?=
 =?us-ascii?Q?QlQtnmpfYxeNvRQFZi+uQTNhffnB+fCVp6GWa3ENBw7YbDLmqCtxI5Jz9w6r?=
 =?us-ascii?Q?IeqFC5S6PQszKCq2iGm3NJKpDbstkHA1yLLt3izt5RYYryl9cfid/3EwEEiw?=
 =?us-ascii?Q?NuxMe/kehp9HvEHKsQ3/fDXkNnwegxBZaoA+ESNUmTaN9RNMTqPD7ahuaowH?=
 =?us-ascii?Q?zqvWeXxKeumLL1hwSut5obF5w6GdF8d+qW8IJ8iGrfd7QsRvEvFFb/2TlnCH?=
 =?us-ascii?Q?lyY+jDpTPSeGmrcegGcNA5i48LE2p4XtroZQ3PYXZhA7MhSTvYQQASlYA8V/?=
 =?us-ascii?Q?OzT1SBFt46iB+RF7LhZde7GotH7UqljzPO0I4hYSt9UaVhl3+q2RKciBsVGJ?=
 =?us-ascii?Q?JRs2+bayejHCBU7wEvPBYZwUafCUDZ+CV6ZrVVQNU3B+QTvCMO4bJ+yFpF8k?=
 =?us-ascii?Q?zR7RSHM60UAr9zb8nZYy7X20BAVued8f2IYgQEAm2RY4XDydgRwKvXRFNFuP?=
 =?us-ascii?Q?UjBmYNTsxZVJrB0nlPy4H3i49RzgMnGk525BEX/hmCroExH8CTTtIUCr+ZBi?=
 =?us-ascii?Q?2g6kj+Vk2nG6/StR2W60HfIwM0TILk6bgoEqoTWnbrG0Sb3ZIhdYM6vvYL6A?=
 =?us-ascii?Q?8z7i7xERLyYwooD1myuqCbvMXBCYXDjPxbJQnVIHHRzMsd5dUHOAOTLv26gf?=
 =?us-ascii?Q?Xsa+QNSkQOYluxk2ZLUb1K5cnJ7mBXmwmlahW1iGzc/ERPI1HaKnKTOtgoWw?=
 =?us-ascii?Q?fodnJk9iiUxCbU3TwVyNpGOqY+EzHLPIGlY8b2mHKEBI3vfXv8fbgd1S2tMM?=
 =?us-ascii?Q?N2tttO/xEs+l+87t3J3FmyEkekeFcged2Is+dwOimJ6385wwTou0QmaN3ylt?=
 =?us-ascii?Q?84AH6AgoMWcQtWyJ/UaOGzcr4QAVviUWo4rtomfPA9rCprusyMFvBlx0XOPv?=
 =?us-ascii?Q?AQePuxfVj7KTWyL56km6v85D5uDI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?giKDuIzGWPlQla410tyQ8yzR+5gZrsnpsqlz7AcF9mWkNUtYmDyBg5e7tDP+?=
 =?us-ascii?Q?nOfxQpIITOHNYnWY4Cn0y+IJ6CnNOF1naLwONq0tlxJyyOdC65hd095zjYZS?=
 =?us-ascii?Q?FmAvw1dbDhRMsC8jN6niOx+EPDvPPMpaM6GKJP+79LVvyoQd+8WDCtpvQI4U?=
 =?us-ascii?Q?0noZjUUoB08OX1urZoSQGjsZZT4Q44n5/owF62zem1etGWpw6OZ4D1T1aOqO?=
 =?us-ascii?Q?5rxu0PIEt2xfuctcXpLJzHdGzx/JZCeZzJeyBw3FixHQjMf52dYU8w0LXno0?=
 =?us-ascii?Q?8ZX1RJ9FfrjZDqDJHl1QvV7Sf2W1g2G7Qs74zyN7ehFlwjNK3d36CLEfamim?=
 =?us-ascii?Q?ZpD36zj4ufjMBcoAUwbXUQvO9a4ecuIfpsfFDyq7fn3NItAJvJ83wDsidDZH?=
 =?us-ascii?Q?FcXDl+OxceQgUYpurOgb9qNOgskp+Ulu0o/7xLT+WSE2qq2lVG48KA7or/Ds?=
 =?us-ascii?Q?iMgT2vkbc52T/8tV8AXwh5wvk8hk8qQuo1h4ZJN2AD+ojg+W7RXSSoTGyAT1?=
 =?us-ascii?Q?cwVBbX4TcqAUBlZvIbW8IY7ulsDHvutM3xcgZ7perqW25BsLzz4+udDzj0iq?=
 =?us-ascii?Q?wWy6DOLSq2mTJjN2aUulAwjfwuSTO4NULcc4SttuTwp8ot1aj9yZiLPrXus6?=
 =?us-ascii?Q?YM3yxmNz1t91XAZt6eCESiKDQxjMWyOwS+SuenRqG7QfJ2ro61wEYlqN3zm6?=
 =?us-ascii?Q?kTpPF5Iw4zoOE1Jgdr9M1iVZ1Xzgco28JmAKAzKj+kg2fKjc92Ypp9v7Q9hV?=
 =?us-ascii?Q?m7siptahE0d7LZtyJM0TwVAy3q5OIn6neZHr3BXbkbm5Ydu6j/EvUdeupP8e?=
 =?us-ascii?Q?4YmR8eBTPo2j34hHtppwDwkUsU2z13r52p4FwqLPp6R3HXXTejQyBsYdYBET?=
 =?us-ascii?Q?Fa+XNSmbqYIPfwSFC49gf8wyrThiHkt1meBv6sJ5/cHbWMWAXCsc312dN72H?=
 =?us-ascii?Q?7ZhkHzXoJzcFahZ0l4M1teHxPjcFG750Tq/KA77hjVPe+8tRnsGE+8FEU6bY?=
 =?us-ascii?Q?SGBnBIq/AJGLX9zNSqJYVK1kPArLKfWG2YbyfrzBSnsNGCiLrwcMJnffFkmD?=
 =?us-ascii?Q?9LAt+X755dbwuzBw+itA+pVP2ZdNewRMNNpr4g8922N/q+vX1sUx2mdpegQ8?=
 =?us-ascii?Q?BucTP+PtDHnfQtnZ9AJda2qDE5OA51M8CTDxYR+qlz5b6r1mHA9yA8e4CaJW?=
 =?us-ascii?Q?zgb9zWp6fZj01FzArmCTpVbVg+jqVGTIHRHi/lrnKXwcfPYFCGG70xGaZd41?=
 =?us-ascii?Q?2KQhn2KoiaRSrEECvqZFqkfoc5/agjH7Ehxvck/vZYbmviPzOEyZDFJZJ8Iu?=
 =?us-ascii?Q?udP1NxKe8yKs6LRZGbN8ih1hcDsQ0wonLYyn+3J1nbVlxNUk7aq1nefpfP3W?=
 =?us-ascii?Q?u6Wpy0x4zr8yTEstYVmAsd3GZm8xrXH2lStJVefzaDL+T5oJ0nNy3a7TGZ6M?=
 =?us-ascii?Q?UdhS6XVe8Cok62S/7riJWpyJgPexxCThp7UssT8ows7Aoneoq9A8aO+F1Mfm?=
 =?us-ascii?Q?Hm/j0u0k66PxPIB5TozW28oxXRT5ztW9tvaaJWRXMAQPzkk2HWAX/CxAYjHL?=
 =?us-ascii?Q?cJQeUgHb/hWPH7qB5osUUiGj4Rtpv5GNdgJo6TTNz3b3xE03madr74M5Jh5j?=
 =?us-ascii?Q?WyW5yxgTr8f+RuY6qAg4ChE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c8a74-0a47-4ac6-148f-08dd1572746f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:08.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/+4uxhVNlkBd9ZkUtXPArCU27GtrtmdlK4T3E/m2popRmZX+hfE36TlLLlMFtvJdDAu/0rjvc+u7Ff7ADMAR/TU8DYxrdYk0C6LC7ygB6Aiuv7b21HTcsuT7xBGOife
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8004

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521

This commit is not a direct merge, it will come from ACPICA
project, see pull request(3).

(3) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index c701c434976c..f52d5cafaf76 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1034,7 +1034,8 @@ enum acpi_einj_actions {
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


