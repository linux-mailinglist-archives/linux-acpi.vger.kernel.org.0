Return-Path: <linux-acpi+bounces-9972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF29E5FFB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0073F286D62
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E92309A1;
	Thu,  5 Dec 2024 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CpeGqdZt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020089.outbound.protection.outlook.com [52.101.61.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF822F396;
	Thu,  5 Dec 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433567; cv=fail; b=szDJFRjKDL/RBpvjTUA3U38tXXuI1AxfrL6NfSnBrqdhjhjwOBFDrYQcvbPN9X09+7BvY5pAlFug8GL+Y1Cb1HPt9S11rMrQ+RChNCALHx3W+GdNpduPNaYTwcZBmpWzWgUna9gOO/Ra1Tw6cOkmOwjQYTZTH5Q41ehDtLZXNm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433567; c=relaxed/simple;
	bh=mmzn35yj6XENSuxp//oSo65ebPMNziCMGYIxU9u/GyY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKnhp3CM7hO6wUiMyAbSaccM0AcYG77gJ8hKs4ik2UEsiXHCzWo0mc+VtP9YVA6ztu75b7qdwtI5MOldFSbtyRBQP3+MKrfFWU6QWCyJqlWMqCW3Mn6uK79S0O6o9sNwk5/JSkiR9D1sr7TEWTEXtX4rdrqiay4nHbeqe7Zr9K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CpeGqdZt; arc=fail smtp.client-ip=52.101.61.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOdsBj2/c2VMF4x5k33nH68R4+odrvBQDYoqgWLzsuLe2lyoOC4uZ7QwbCJcQvRGBAI1O2fSCIK5djs/ubmJXtBCtWXaVDJwgPRHN7qSMHCi/bxffcFk3kb3sfQN5vgR4ZFToO1cNQS36yxeEhizGjHu9N56mqT7yHiutu77NN9VlJcEW4UhwwkC/TO1yJKu6qrnbC3/pLV1JGw9bFZumWTFYLt1N+PF9XJAgXiRrB2j4C5J1CuV00W6PpgTTyotEpDg17F5T98VxY1n/RSdUg14IVDCuBNSCvtlapXgii8+BxBM25oABBJTbm+kqJTezAUhPGYZvlLxp4mcYxqw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weo1G+zndL4DT+tGQW7rBSvQpZxgQHl1efYc7x6hcY8=;
 b=T0SiecdvnSBhfd9IyPn+jlllvxOMnafJS9olqT3ZkJC5Af7zTrlXJm+Ay5eoCVvssFY+4xgOs+iYgNNiJG0l44VwVDy9J8i8o/irAPcm3AObZ1BOibYk1SwpCJBhMfsZEtKaAmQd9i0rS3h2BqJAx14JkuVo+0T2+V1JpdRSIbIHeKNS4Yz9s06fwO+qReHZCgHnyrSLlHYlrGL2bQ/KGM72lHKZ6VU0fnV4EnpxxeTLUlD3p4ah7r6x7tu63MdBfrxTEvNptYB+tfIKDPnWU6TYV1myn5OYo0pZf6Mr4jRsGPIW3GFrNa3YC+2rBZSv/gdjGBPy8i5xi9Cdy376YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weo1G+zndL4DT+tGQW7rBSvQpZxgQHl1efYc7x6hcY8=;
 b=CpeGqdZtSzJ8JBD5pqTrhngEOtCyNAGznJYpngiA2AdTkBy7WKL4r4ZGkovdZ9/tHHfMDYjp0EauARaejckjkYyH+4O1ChTt5ppdRMStFm0/B/qTUVT/sIWOrwVC919FdclAeXoZdVaZKOb3+OQN8OX6YKERpasqpfK8ZGfMF3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB7759.prod.exchangelabs.com (2603:10b6:8:7e::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.9; Thu, 5 Dec 2024 21:19:19 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:19 +0000
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
Subject: [PATCH v2 9/9] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Thu,  5 Dec 2024 13:18:54 -0800
Message-Id: <20241205211854.43215-10-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c0af457-df1d-4872-aeb0-08dd15727adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhSbyqmPrRyQ/OyusgW0WvZQbdN0IQlQA8C2dNGSA80kCUh26cdIhdVNIl/S?=
 =?us-ascii?Q?v/epyfn1ynVG0GN/9QnS1GhJoR1/25YvRPbZxoRsPq91it/L5A0GRxivV9gJ?=
 =?us-ascii?Q?DMK0cSmmz+iQ1kT6Lq+FNX26VrqcYXlvrMAbxM0SX2uttN7UGdsadzz0FuvA?=
 =?us-ascii?Q?KmJ0+DxXBnIPa01yyx72i5CNRYeuI6uQd4M/Oq8Ts/Qm1ADn7pVgSYcmHJAc?=
 =?us-ascii?Q?zwzYQJNwhxVp+pow+LdvBKXEx1SsDoJkRcwofBaX/ttLaxnHIg49rJ5cWZur?=
 =?us-ascii?Q?a1v2Qv3Bf8s/8SP/fEgAEpn7brB+zzHyEvREjzJh9/SBn+d8+QTLCcfmzPMr?=
 =?us-ascii?Q?JXNqlZRoe8lEz9Pxw6mnA3FZkBNzgxXPxVGEji9u99WRWor68hzM+K1fUOgU?=
 =?us-ascii?Q?azhXBsXXZxWWb6afvpQgR5P1CQGhSyUYYTB7529IexsSKaIYFgO9g0u5Z9l2?=
 =?us-ascii?Q?j8/oal6I1JRc6aMnI9sSTwExM53Pp7cYTBi0paEpdLR5HjDtTEDskJmfAzV6?=
 =?us-ascii?Q?WKKb/baPLdYdcw56d2Bisa2PauBcjh/oUmEf7grKXwoEq2v/DGtUUgl1wtlb?=
 =?us-ascii?Q?+Ji4JWW1EGdZuBBMkSPZ5KIP7Wyjf7ejP697wSBLKJU7+IggNjoIC8NA96mS?=
 =?us-ascii?Q?efj4aRVwWbw4jE26WIucAsB5icL5CJdRXDYMInNr5wQVxkaOqxkSSG0t1KEL?=
 =?us-ascii?Q?NZ/hxtMtCqsrLyYzLFVyKbBqdbOj7l7CV3YJ/odIeXy+kZLjTI5ZF1LE2j35?=
 =?us-ascii?Q?Oib6+pJQsQnHNXjLF8qnBXjsN2UQzljWDN6I0ha0BkWs01TjWGE6j9kNzHSC?=
 =?us-ascii?Q?J4nOFlMQKRN02bBgnq01jcTIO4skmc9925MbTb2M1cuAvSB2fUrfuHodJiW0?=
 =?us-ascii?Q?Um7QDb7CrFpZQQD5XSque83wKE/TBXyj5xgsyg7KRoklsx1kSBLGKc+or7Gy?=
 =?us-ascii?Q?rspm/V+j+QpcIijE3PnRmpZ3oSZI7DHd20nsElrmrxwVgz9i763anQRcbh4z?=
 =?us-ascii?Q?QjnT5+/KUcb51VWPFGTrSvhy0zUp91FaTkxHfEXZczXK+UAowUg1M3PNrFmU?=
 =?us-ascii?Q?UwOUuucknkqgEu5muvHP1dlFTlpFOrRl/elltERrhL4L/dB4+qo9iOWHzveI?=
 =?us-ascii?Q?dd9C8cGWGwS0+ibANEYmGrIpYBqbhX5jTBVydZtT+3Nr9ESKfu3fv50Fpz6N?=
 =?us-ascii?Q?UJLRHBHGK2fOSOKhw3bJ0Smfnea03apy20dAf8LJS3yRjAGLldmDFrG2nbgp?=
 =?us-ascii?Q?a+XkqnmyqZOSUd0BbojKA1cf08EudwXTVt8bTyrfM52IiNWg0+7kjJJKqlnQ?=
 =?us-ascii?Q?L/URqYmd57bXap+N4Bauksamo+Z+D8qU6G+LY5cUordlusB3LVtFOBkRysqW?=
 =?us-ascii?Q?JuvyluKZCr1fprZRu/0wpeWYD6I8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loi45oqvPHccguczQhr18iIyh8wYANwRZLP+ZthTwKZOEI5ato5PqKuTmlXh?=
 =?us-ascii?Q?8fRyi0A0bC2cT/TWCb3S/oYR6tHvFkKIWcVbIcYtlhm0KMzM5GSga3GX/C0b?=
 =?us-ascii?Q?pQqoejEu3el0uOOyhvqohBH8/er09rIcZuHa4xfqLJJRyGI78OJilF4TBILT?=
 =?us-ascii?Q?tctz5FHLIck3UXfuPsUeyxhprdpXemok5dtkxnZKCR4NhfHupiuKcYSu2Idl?=
 =?us-ascii?Q?t9EhyKroD1xwCIcubSAUH1H/PEzwcoTEBRfmH3y4ha64OO+F5OJHNrcYEdiC?=
 =?us-ascii?Q?cXTyW9MLsbSy6EMe6i8I7KAEigh247vR5ZHp7ehh0F/M6xyzdYL/TZ7NOnKR?=
 =?us-ascii?Q?uAwFKjdgVcoByzcA0uYCMyusHdLRe3iJtnvDzoH2UHlLPZ/pNursPET3Cn/A?=
 =?us-ascii?Q?QHCxvvMC7fJThzGjOw86xCxkk3l5vV+nBGgoFw2MyG9I12P8fWzV7Kksa4zU?=
 =?us-ascii?Q?ogSD8+WmJwDIIix8ORlPSeL773kbnxGOCKj42frwy7kCULmi2pC7GCjhYeP2?=
 =?us-ascii?Q?OPY52J6lN8St1sFAoamq44TZCNZbbEgikOFXR8Afe6FsIJQsuXQ0evIySBva?=
 =?us-ascii?Q?jum3sgpdfaB/FbzW+4ozmTzaMGV+ffswr5VpsazqXf7PiIXm1e7y5El6dwwP?=
 =?us-ascii?Q?RMHr8rsnlJ7e8btPEhu9n5ltrA5kIUpXhOJsA8h5OLzZ39+MVGonLU/bUpCr?=
 =?us-ascii?Q?jn68sfgIR/+hyVyE4WGnCYTCpUGh8rKj0V1stAkXDOAoBxUf1CQZ1b2qhT+1?=
 =?us-ascii?Q?PUDboYUqmH9PwSPHkKQD9WZaJ/CbIuyxwQcfu7f/ImTNpN8eHaY41Y3OfIDa?=
 =?us-ascii?Q?WTqihTZDFg+qz+MnR1DBs4c+UoPNi69XbbRwHsV244X3he2OkBKQz8LbcsDI?=
 =?us-ascii?Q?GSEhwDRb82RquUDlwX6D25azis88kaxy1hSpFyyOjqA3f5Bx/7Ye47/z1XHc?=
 =?us-ascii?Q?MGGegGncLfmMjuLSbHo3uzovTYbaODMw/biWyFDkCc0rxeUKNGelYAJ6/wWI?=
 =?us-ascii?Q?/LAS8kIi//8/GO5aNXMkNsRW0QhxzfJxlHlScrMeiJ28Sx6wtg5ZzXahRcA+?=
 =?us-ascii?Q?aqhEW3hHl1rvaIcpVHiNF7FWwK1Ej4+kfrjsmHFHmzWG5vZr8S1XYHg6eSpe?=
 =?us-ascii?Q?teIGLOXSNm9V3cu/1iYPYPnF1kjOJ06Hqsytkq74o3lkmK6HybtqVUgIkV4N?=
 =?us-ascii?Q?O3f7i/a35EfhipQz0px4Lc9IKMyLbnVlMMaf1RsCc6SzhNAi6xNcXrmFoGWS?=
 =?us-ascii?Q?pGpQOwX3QTqSxRT6txFgTvGUShSs5hPvfv7eK2pskKa91OBG2L4gbx+ucW/l?=
 =?us-ascii?Q?kTL0rQpqHK2yVoBdPigmBvEk7SjleBP6ft7puc6/zYbe0gxJ6EgI97czNYfW?=
 =?us-ascii?Q?MyB6FP2GWqjhEuEy+UglGwx+9vdGNYo4vHlRqy4Jv0g1xqVF7+KaJFHpLTY+?=
 =?us-ascii?Q?CkccsuYutOzQzO3LZkBPqrxydK65+oZv5NKNp6I730oINP1QJHpUJi2dCSvn?=
 =?us-ascii?Q?f5kgAM5aI9n7WtXpr3mt9HSz7nD/xNjeo4YZnWMw68dug7B9go7hYR74O3Ok?=
 =?us-ascii?Q?w4p0Av4xTQn3XdoBOdPq0uzoE1/xEw5Vhbg8G0f13op9HtD0+BdN2aAniPEZ?=
 =?us-ascii?Q?kGnhqMcj9aOPlHNec55fVx4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0af457-df1d-4872-aeb0-08dd15727adf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:18.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+Q18Ie2ulPMbuyj983yDATDMxX+nt2vz+P+MAYF+Jur8K3GEoT8A6ng6qzIax4p0o6Jva0MWmwHXbcScsemZUwFVmdsi7Q4XDOFZzt7AJRTSILsF5feH/BcPoVsV34Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7759

Add documentation for the updated ACPI specs for EINJv2(1)(2)

(1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2)https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..b1c0464f6002 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -59,6 +59,9 @@ The following files belong to it:
   0x00000200        Platform Correctable
   0x00000400        Platform Uncorrectable non-fatal
   0x00000800        Platform Uncorrectable fatal
+  V2_0x00000001     EINJV2 Processor Error
+  V2_0x00000002     EINJV2 Memory Error
+  V2_0x00000004     EINJV2 PCI Express Error
   ================  ===================================
 
   The format of the file contents are as above, except present are only
@@ -85,9 +88,11 @@ The following files belong to it:
     Bit 0
       Processor APIC field valid (see param3 below).
     Bit 1
-      Memory address and mask valid (param1 and param2).
+      Memory address and range valid (param1 and param2).
     Bit 2
       PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 3
+      EINJv2 extension structure is valid
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -110,6 +115,7 @@ The following files belong to it:
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
 - param4
+
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
 - notrigger
@@ -122,6 +128,18 @@ The following files belong to it:
   this actually works depends on what operations the BIOS actually
   includes in the trigger phase.
 
+- einjv2_component_count
+
+  The value from this file is used to set the "Component Array Count"
+  field of EINJv2 Extension Structure.
+
+- einjv2_component_array
+
+  The contents of this file are used to set the "Component Array" field
+  of the EINJv2 Extension Structure. The expected format is hex values
+  for component id and syndrome separated by space, and multiple
+  components are separated by new line.
+
 CXL error types are supported from ACPI 6.5 onwards (given a CXL port
 is present). The EINJ user interface for CXL error types is at
 <debugfs mount point>/cxl. The following files belong to it:
@@ -139,7 +157,6 @@ is present). The EINJ user interface for CXL error types is at
   under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
   must use this file.
 
-
 BIOS versions based on the ACPI 4.0 specification have limited options
 in controlling where the errors are injected. Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or boot
@@ -194,6 +211,26 @@ An error injection example::
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
+An EINJv2 error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type			# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  0x00000001	EINJV2 Processor Error
+  0x00000002	EINJV2 Memory Error
+
+  # echo 0x12345000 > param1			# Set memory address for injection
+  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
+  # comp_arr="0x1 0x2				# Fill in the component array
+    >0x1 0x4
+    >0x2 0x4"
+  # echo "$comp_arr" > einjv2_component_array
+  # echo 0x2 > error_type			# Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject			# Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.34.1


