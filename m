Return-Path: <linux-acpi+bounces-5928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE728CB535
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B443E1F2270B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871114A09E;
	Tue, 21 May 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="h9Zd1dG2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1C14D707;
	Tue, 21 May 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325874; cv=fail; b=fstbFM27cj2tgHe++60ADoZJK2vpH3aSw+NrEqXg/SEchtreDwxpn5P+PvvkEQOykVHt5RbTCP+HIhYMEECiFJWartmwaLssjFQjxgUl3kMlr0LS6P3aQcLXXTMIPP8zjY9VLYVLqaIHzmHRe3aPrCb5nLCAB2Jh4+7RIwGsSWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325874; c=relaxed/simple;
	bh=X90Dls9d/qSnBn6kxi3Pa4EPRPQv7KQu8SBBUU1H8v8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScaqxfP96K041tgJaKs9c7pMSUYKaUkhi2J4kPAQlwUtI1GwwTTT+EJR81Im2uLXvSuDStj5/t1juS/VVDdCmBvRLcC1dPkbZ1qrCUanzMXeoVU6WaQWJqBOT36vEUFHlYW85re1EjoFSz0kXOIjCzaJ75mYsUc/e+b0A552xFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=h9Zd1dG2; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP+BfhyyNGpshb5z33HMBUIaoEG4I7Tp2G7bJDmODkzGGo62/O3Wq4Wz1ImhXg4B7XgdP1V6hgv0Ysy8418dhvW7pU6S2W2jOinsqviqPmoEJBCHo/iEXAfYD1VParDqNe9SUaM8oUtBOdJji+08fMuWVdCxk/8EJk3BK37IXDkC0TgpFYoC/Z5xIkBYjDxqsG1UnlUHtM1inFQ+q9mZej8LTZxosweyFWU8bJcy/Un4SdK4fg3OcOVEIuez8ZayR76Xp8wAYAfSY9RB40sCn95bVz8TMk7D+5q49KlPtaWy4IOlVnzgf32cAfXXYBluo0wqK0o/kSmKYqy1rvvQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SPdbPUe9w64Es2ez5yiZmgOAj6YhjODK0L+oylcb6U=;
 b=CotOUbfceUJCCeELZnBqY6Ky8jdJL6PXR4Fyeq56JxxXs0VMT0g/J+TAEqpjNmGkm24VV5cL7Di09zmlnu+tbOjFCXjX64yi2c/lFzpArS7z6B/krzQSE2BAOP4B3IAJ3bYwNlZ4RWpK8b0PJvd4WdkhZtqwtn22yGN04OqFJ0ZwwyCl0SJPBktJKQ/0jAIULMEFgJ807u2g0D5HlNtXs0JpPNKtDgc1DFRBLq/BST277hIk8ObP2OrazLkraGj1EJGNIgRrF3ionYsQT5p3RPPVrovv9TBshqv1Tahunyax46k7Jef5QKe8yAcp83Xb3PMe4peSm5cYLK+2j+6Xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SPdbPUe9w64Es2ez5yiZmgOAj6YhjODK0L+oylcb6U=;
 b=h9Zd1dG2oGESzYvLIKFIswyRBR2eDKT1ami3c0J+FYqk/cbiwbqzb36y4E4AZRKyBM3+kTtxkjG7LwGyexzhTSAIRkkRC6EE35z2A65W48bccyoC8Ojgf6R4smWkJvNtvObyzmBkaCwlOq1ENCYATmYRPLqE1PVLAYTxc250NCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:11:05 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:11:05 +0000
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
Subject: [RFC PATCH v2 7/8] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Tue, 21 May 2024 14:10:35 -0700
Message-Id: <20240521211036.227674-8-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: f66b2658-166f-48ce-7e86-08dc79da868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jT59qP/57p4KcK88dcs8MuWkRFcMcvkZiX8DBfB+rUkYOjFfc9INcp85Dd5/?=
 =?us-ascii?Q?isA3hKPyd74hjgYr5V/WYoWM4rx0yQF79sWjfaCImxxwQARwRlHTBKwcOxp7?=
 =?us-ascii?Q?4L5nTkEHj1lj1IRJL7yaNRM6Ihr8KzRnYgNk6qPaU5iCqt0LFdDB4WxZcVzi?=
 =?us-ascii?Q?mHMrqGLQlP8Ea49rnqmZAUjdb4/P6i+v+2qRYTaFd0PmBGZbBYEk7q4FzJCn?=
 =?us-ascii?Q?7imM+pVHWrxlLhMwLSlyXlCvwoFxAh/9jn3wrxBKG4YnGgjFWV0GXmnlz+M0?=
 =?us-ascii?Q?/YqxSM3HstQHA9AV4SsQtNER3og+ECecuShN87lTTrEWcn6SY2kEcTVYf23a?=
 =?us-ascii?Q?Jr9PfECEflrk8qWjA+yTW2kj51dHeebkJx9hni1bPVZUs9p7/v4C1rxqXZub?=
 =?us-ascii?Q?g6w2uFYQ1mo/QlZQeCux4e9knJqUAGmEF9z69vYSlGMtCHlLOSxDZjUbCBKs?=
 =?us-ascii?Q?hKp37oFFRvB7wNQZbO4MRGSzPxFaW+7byK1x0wDw1n+1BfxzQ/EZBviI97Lx?=
 =?us-ascii?Q?A0Ux0OCpRqacLiLo4mY389uuqTwIA03IWo+QqjuORq5JQpQ+pSA2KpVvIzj2?=
 =?us-ascii?Q?tEuha3se4XxRT/Tfc/6m9otujS8z3sByR+DbZ+TTTl9KaWObj0/W5UkX2q0Z?=
 =?us-ascii?Q?ySat6hHlIUTeD8tmTsHrewt+hmfE4VW+IY8uUPAG+QDie9qU+DHFYLvKiiNg?=
 =?us-ascii?Q?ZnvO1KJ1jWMzoUE2JcenAFvfWtmwD20PzIYgjD9JMd/TKp0sdt7x3SgxA02/?=
 =?us-ascii?Q?5lWMLvvpNqz1+3QR7EWU0980FpHdKrDIchxGvUbfIFeWx2uspNjpO4ntDgbW?=
 =?us-ascii?Q?kHTIFFeL5kmlfzEBkM2N6xFS+kyYWH0ZIXUBOGOWNeEzAc0Qee4/Pj+WlHqi?=
 =?us-ascii?Q?NixfpZnlXbyt2LGYbuqffLE3Jo90nAkX1VmnVbbuZqcVwYadX8F/9ebn6WHP?=
 =?us-ascii?Q?+SmT9ctTWhHtkXZEMlYuUnCSanhVJqw+8fg3vFSr97koUqrMt5lsSZam3ctn?=
 =?us-ascii?Q?NB41KKDtzcQvsd1OYzYIevknuy1VL7yQTtdgA1jDNV8gsBmPS4MGtrj9Bzgm?=
 =?us-ascii?Q?xD7S0eLtI7hkDQs2TNB+GvBZLJCvNL/57lzxb73KvMLYo70Hvz86BmG56UhY?=
 =?us-ascii?Q?+jtciiMBMtti8N+ajpkB6ufwjfkKerdSsCw1OVy3JRdZ32icf4vQ7ISz6Edb?=
 =?us-ascii?Q?mCx2zeTQfbFYlgiYKsmF6FcPfcJgpJWO36wca+Xrg4Mm9xXXWQaBZ5/BxQul?=
 =?us-ascii?Q?NIhcQDD35ZvB0tJiSIUx5Pea3qHb8uXH8cMLk/oevPZSb44rn32N2YnROD5W?=
 =?us-ascii?Q?thtTsMag91L7a1CRMjiKL0MtJdoptgOUdC7ZVPawo8Py71O4xoebLbddb+h5?=
 =?us-ascii?Q?2b9jie0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxqUZgS3VcDgUyYvswWqFMJfRJrDusR9+LS7bk7LF03RhjAgeNDGm4KUj/EE?=
 =?us-ascii?Q?RTWaXLgoMMsoEjJG35KfQPV8A5DNSoNMpunP/9WzDYIRs8aAsG5TbqACaPZG?=
 =?us-ascii?Q?8Mz7z0yvfrl4g/uiTJ5b4tupzWEKfQPfXNueofqbnmDv1Yx0WiCiuU3PE+zi?=
 =?us-ascii?Q?RUKndh4MJR4sTzbOYDeetxZeZbxBEVwK6bpBm8CeTzORrOLrwGchROzHaVjK?=
 =?us-ascii?Q?xv0/8NkImmegrc+Dzv6+glo1lOLxyNCac+614ebpkK3huwDsugl959g+oV7K?=
 =?us-ascii?Q?U96aAJLQeQYVqfHO/ul8IEErRBjGLfQNCsdoXIxrqhqeGxN2/7aIyXhkaZuV?=
 =?us-ascii?Q?aR9dqZ5Y0n0tnxS1bKKZttzjKUTYkSKGP8F+3SIcN/DIFRUHf44Kf/gTyjLx?=
 =?us-ascii?Q?3eNKy1SzFTINVG2EDsNrqvix0qXlfx0tK0Qo6VszCudcBh7l0ZTfV29av2pt?=
 =?us-ascii?Q?VZ/DSNenZeWSNIlKyKaLDGqr83Afut5cF9UbpPZmmtWFHLQjQBuhrjM/ph4J?=
 =?us-ascii?Q?aILec45gOLkvtlJtMub9LSXLXcF7jpjv4ZLy8rx1dWL4HcYgA9w5zRCT+x6R?=
 =?us-ascii?Q?OofaxQ7IbABzia5JhQsxGOo1jqSvXxNy/nJmR0oZ+5clmLs9qhCO2YBl6rBk?=
 =?us-ascii?Q?skpCsInNIMXDmukWoK4A7H6pNCO/jgew0qRl4lVj6FpW7F7TXXlNMAqYMHLS?=
 =?us-ascii?Q?u6BL4GYbXaLuHZNUGGRBA9yB2YrmbR2LbNXISIMWNHJL9shhqiAa3GzOyNtb?=
 =?us-ascii?Q?7yAZNWV+gaNM/h1ZLdQn9XwP229P/d7ozr/U8lY3b47Wc7xfUMyfVLz9KFEx?=
 =?us-ascii?Q?z0Eygg9N/tftLUIqPz9N/Fhrv/vq/XboNq1YLQUgNoNxM2U3NYgrbS9TGKLM?=
 =?us-ascii?Q?4j8vclUiqZIGQaj0qAJ25QYBxQ3wSQgWtG1xYv5vM4al71YOcey7mdkRDqLV?=
 =?us-ascii?Q?fLR1Cgct+SizV64qQglSQzFjV2eOzhp2Os6N00LayQbpGkTqgqoWSxLb+j6Z?=
 =?us-ascii?Q?45JwMYiG7EJABit1KoyakE5ydZZ6WlkEpJV6NQqKhB6UIDD2zqcr+wC5QYQo?=
 =?us-ascii?Q?zHay4uJ/ciYwmOxScDXL8gK6Hn3KTbRBvlDt9FE4Rv2/3ELwNxqJYQR6Qkco?=
 =?us-ascii?Q?A/jZvVLyHxFTidBD7i0nNWWOBntaX01ol1uFyVAG6KuB+WV/QWeGi1x8ZqdK?=
 =?us-ascii?Q?EZZruV9rqRAjChHTyJHhibPLTQKZITQAvYu/89w4FlY72IckyZGQKWI9krGR?=
 =?us-ascii?Q?Zxu8kTTvDM1W1Oi9gRC1dj+apLbbzolHVmnEyENLjBIuT8QA0JnoOcCiyDvg?=
 =?us-ascii?Q?5e/wWau3mf+1OcAUbFXZh6VeHQl2qOe8Ka6oglh57YSHmwNU4qVGmBYyfDmM?=
 =?us-ascii?Q?SaTaBJf61hryahMQNl9XgujMsBXZ0qa9NcVW4hNb02MhYVl8VEfYYJOm8JyN?=
 =?us-ascii?Q?Sc3Cr7o4udlm+4mkSZ/AJwuhU+TNXYKMmF1R2YsxogaBGYyG9AhzCKR06gg6?=
 =?us-ascii?Q?PlwCXdJ4j6HmhDiUtuJ4iEwAQ5fBz8A1VBbLxbKQMOCsMaAMFGOVuXZ5S/u6?=
 =?us-ascii?Q?sV6UvWIEabYnmx7F50oIZxgKAuhHxP/GOCEQI7JyhN4bsG7FfwZ6RIGaX571?=
 =?us-ascii?Q?IrLJQjT28epzFeFj4AAisBI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66b2658-166f-48ce-7e86-08dc79da868c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:11:04.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htvPcXSRZX+icyLlzfE5o1BE0z4B/f7s6kLrsyjxZZQiyHzi0056yCRGCkXFJlJxpnltpuq4NKps0N++p6FvEEW3Htqn6fDGnnVj6lVA0zThwsyLOYaH0mnGFHJAGgxj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

Enable the driver to inject EINJv2 type errors. The component
array values are parsed from user_input and expected to contain
hex values for component id and syndrome separated by space,
and multiple components are separated by new line as follows:

component_id1 component_syndrome1
component_id2 component_syndrome2
 :
component_id(n) component_syndrome(n)

for example:

$comp_arr="0x1 0x2
>0x1 0x4
>0x2 0x4"
$cd /sys/kernel/debug/apei/einj/
$echo "$comp_arr" > einjv2_component_array

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 81 ++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2e30ebed079b..2e5c00b34a4b 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -87,6 +87,13 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
+};
+
+enum {
+	EINJV2_PROCESSOR_ERROR = 0x1,
+	EINJV2_MEMORY_ERROR = 0x2,
+	EINJV2_PCIE_ERROR = 0x4,
 };
 
 /*
@@ -111,6 +118,7 @@ static char vendor_dev[64];
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static u64 component_count;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -287,8 +295,18 @@ static void *einj_get_parameter_address(void)
 
 		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
 		if (v5param) {
+			int offset, len;
+
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param->einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				nr_components = (len - offset) / 32;
+				acpi_os_unmap_iomem(v5param, sizeof(*v5param));
+				v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
+					(nr_components) * sizeof(struct syndrome_array)));
+			}
 			return v5param;
 		}
 	}
@@ -494,10 +512,52 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = vendor_flags;
 		} else if (flags) {
 			v5param->flags = flags;
-			v5param->memory_address = param1;
-			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+			if (flags & SETWA_FLAGS_MEM) {
+				v5param->memory_address = param1;
+				v5param->memory_address_range = param2;
+			}
+			if (flags & SETWA_FLAGS_EINJV2) {
+				int count = 0, bytes_read, pos = 0;
+				unsigned int comp, synd;
+				struct syndrome_array *component_arr;
+
+				if (component_count > nr_components)
+					goto err_out;
+
+				v5param->einjv2_struct.component_arr_count = component_count;
+				component_arr = v5param->einjv2_struct.component_arr;
+
+				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,
+							&bytes_read) == 2) {
+					count++;
+					pos += bytes_read;
+					if (count > component_count)
+						goto err_out;
+
+					switch (type) {
+					case EINJV2_PROCESSOR_ERROR:
+						component_arr[count-1].comp_id.acpi_id = comp;
+						component_arr[count-1].comp_synd.proc_synd = synd;
+						break;
+					case EINJV2_MEMORY_ERROR:
+						component_arr[count-1].comp_id.device_id = comp;
+						component_arr[count-1].comp_synd.mem_synd = synd;
+						break;
+					case EINJV2_PCIE_ERROR:
+						component_arr[count-1].comp_id.pcie_sbdf = comp;
+						component_arr[count-1].comp_synd.pcie_synd = synd;
+						break;
+					}
+				}
+				if (count != component_count)
+					goto err_out;
+
+				/* clear buffer after user input for next injection */
+				memset(user_input, 0, COMP_ARR_SIZE);
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -570,6 +630,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -581,9 +644,14 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/*check if type is a valid EINJv2 error type*/
+	if (flags & SETWA_FLAGS_EINJV2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -915,7 +983,8 @@ static void __exit einj_remove(struct platform_device *pdev)
 			sizeof(struct set_error_type_with_address) :
 			sizeof(struct einj_parameter);
 
-		acpi_os_unmap_iomem(einj_param, size);
+		acpi_os_unmap_iomem(einj_param,
+				size + (nr_components * sizeof(struct syndrome_array)));
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.34.1


