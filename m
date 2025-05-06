Return-Path: <linux-acpi+bounces-13513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79192AAD030
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C93B7B3F84
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2E23F43C;
	Tue,  6 May 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V0NVDurQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022121.outbound.protection.outlook.com [40.93.200.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88B23ED58;
	Tue,  6 May 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567520; cv=fail; b=mSIfNo1+KnMhpsv6tupkQOwnzA6SnmNf5RbyKFh+tiGtyni4lGOxJwnK3LXxIvv0K6z5RVjk4K4Oy/vpPcIb/oXGJW9LqDHTPhWxN4xR89n8FbRnFpUlpAcRXmlJ5kBp06fyxUa4XEB53lYPkUMI6T3FDSm0mvE3zEkiwj3Q0PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567520; c=relaxed/simple;
	bh=lY+RHFhlgBCOVWT4R/5hi/RN1INSM5BGBuzlNK0Qx1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dM1IH2ton86nDG5CXrJ9Z38WLcGtxeTrc2dRVbHXvgakngeRAWf7IT4kW8C2IVJmzeGy/NpWnst4xDpjN7vHIJ3tT+hoY7Xkwor4JUu3xQEbgX8BpQ4jMYK2jjzu3VJ6l0pznPFRzTkM5XyZXItUrpIzWiWQKTIqec6tqtvVy/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V0NVDurQ; arc=fail smtp.client-ip=40.93.200.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thtuodiAi6b3DD0Le6au9JtQLXVNE331UGmtqNUyPWQeXmq5pz1VGdITzzvmgZL74XxLLbI6OUO4qmmOuwc48ABEecAA934YDstAvI4p4S2briHjpQQ3Hdmb9hJHl4VoA/KhBK/oXudwZBw4fPR3im5PuKMhHbjUwsR9PGrXcQZSS9U7saBIVUvNd9S0mkoR1Wjc37WIoI7jnf+fR77ELuLeVHR/lxy8n1ndskddJiEQj4vIZU9bH63YvgNr+TI9lV5hkdCqi6kMnicVZSFixeWJBb1u1Dgt6z73VNpD53v4pKUPvOHPxXIZ4Hvu1etiFoH0UJenDb8nPr3nvi2DEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BquAVzk5n+UIKpX4MWOPjCBYEX9yuzjuEmrEWYq9jzA=;
 b=sjcQmTBlmpC3lgE0Si35t986o/4RhSWAzPhMr+HcT8To6zo0qKjCGsfU+H9ZB+suvEiHVxLh1B82ArMLA+Y8TshSRVPIgEBdHovwbJRRRPQLUtfVLOGPI0SACbgAnHVDkldMAcrFhgh3XO+amJO7dVW7hCwtyKYIhpao4PtwKZxCvD5WX3Dg0RzgeH4gnlL9TblH1+qsW5/M7VmRrCfvRtATyjRvx9eKfc8mIZbwhXIlYwgrk5hNgX4jnpo4JdVx7kfAPC/C6sorRTtqEveBOeX1GVPyUWGjkZsYwMGVpAOq7VAow3FdGBnGyrbsoNvnuty0e0B7e7qVu9xCcgr8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BquAVzk5n+UIKpX4MWOPjCBYEX9yuzjuEmrEWYq9jzA=;
 b=V0NVDurQ3a58uLjR9rq7yUdNT70jT6LlS0jxlkxUij+MbcehtZIO/0yi1MkW+T/L5UVUYrmaDLXDpCegGj8YpOyXMY4gtx3vk+GGSKGbSfkg0OvDctP3Zo17BmtQDwzOv03Kh/D+SjfRRaYB95Sk6o79PCtlrQE44CRUFbidS+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA6PR01MB8904.prod.exchangelabs.com (2603:10b6:806:430::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:34 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:34 +0000
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
Subject: [PATCH v7 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Tue,  6 May 2025 14:38:09 -0700
Message-ID: <20250506213814.2365788-6-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA6PR01MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 988a31e4-4699-4cf7-8660-08dd8ce65a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+qFNggpdfJ+SA42YW+Cq8DYx1DHUFLvrQAs1vEnAlnJqH4ypRRd9eoqiQbSQ?=
 =?us-ascii?Q?O4KTUsxicNlGKANz+D+UAJmzu2vGAk8DPHGLhuv4k3ILD4JLA3Jr07ROSRUm?=
 =?us-ascii?Q?hyyICZN68b0XcTmcnm6Q9Zva7McQlcnXHBfQ9vSMsUQ+/cJkBbSJsXmyyp+D?=
 =?us-ascii?Q?Sduft9EAIyT/Qzjt8j+BfDhz3GFQNu2/lqttRVjRTcEF4tRcf4zn9jfTofyR?=
 =?us-ascii?Q?q19NguB+oePoOQp68Gsft45udhsFKwRgzpByuMdTWy8WuqrZSOz+VkABxSei?=
 =?us-ascii?Q?Zn8lCqLDwoEhDV4j+JtGx8SsZwJDMslzERUq39Wr/bMHzfzBpmXJw8lyRLAK?=
 =?us-ascii?Q?ArL0Tyk6k11/mGPz+Fuic3rJ/qN46niwy7i3Om7R3jKVCoU773iBuTIq/PCg?=
 =?us-ascii?Q?ZmhHQB7xXCmP48gjrmcyHfwQ5dDYtVtdpapUzGNtxnwpappV8ByLYVz95bPw?=
 =?us-ascii?Q?15IKgGxBwo/4xiU7CCbHNW/vGsj565FZg+5GTFxbhoJq205CFr2eiWixTkQE?=
 =?us-ascii?Q?oTQCOG1yy8WYDEFa9x5TDsxxMCaMkej3f2XcMqadZdkQVRZIM7s/ypTMAul5?=
 =?us-ascii?Q?+kBo5TpOOYn3C+81EbhScuzbvbM+NKwbsu47eYC6Ysv4IKblzQW0C4RLvND0?=
 =?us-ascii?Q?f1g3zNVs70GQrNBVvAH8hezk19j0C9kVLjeCmniXCSzJ7mzzj5tHgaFiLbfX?=
 =?us-ascii?Q?vkcqaz3J85gwS+rlg1W2lW6nNKm1jr0BjaCKdoWhNDNxiqg8bsRdF+GVa4Lm?=
 =?us-ascii?Q?4gbuZ46dXOxVgMLJ29gLimZvTCHXdB5s1c9uYnFuoww0xVWWfxu4r+3WY6ZR?=
 =?us-ascii?Q?lnETGXXrZJl7auR4mqdpJEUIl9AuaWAvgSxB7Iv5PxjNWGVdYHkTTZcey6Wu?=
 =?us-ascii?Q?r864VMkWnFE58+6XRSiPgWqoS8KzDd8WX/yuSNjtuiFWhdiEcVNDHqLCga56?=
 =?us-ascii?Q?PvZlDFWUYpEqa7AjlaMrz40YlKnMrfHsrhFIkUn8b1I9SwFSsjMwfh7djSUI?=
 =?us-ascii?Q?fFTvxTUTLsJQ/8XL6v93RVgXLVyJRCvS98kEpqZHT616BtVl4yEKMUcySVUw?=
 =?us-ascii?Q?krQG2zqjxRan1iKI5Y811wAZWXHVlzXchRsrVoemp5poiO9OHDCfNQ75wSJd?=
 =?us-ascii?Q?RgQ/+4Ey6E9fPSzgSgKiCjRo6D5i3lXLa1Lbjysf2g2fYmb7QrwTDX1E/6tJ?=
 =?us-ascii?Q?DdOftiE5VXJkjnJCKKNu0jrUvekgIU6vzDaM1bI4k5QTmbGOIpwNPpwzOHyK?=
 =?us-ascii?Q?8J5+Wi1SqeF0Tvnw02Qdx4sMiMlJpA603HLchHkQpHLzMaRAUELN6e3EwoLx?=
 =?us-ascii?Q?HRDkjpUa3S42O4jFKiU6/ifF0eBXc8vdpcuQvq+V1BHFMwygPxQd1VfeM0WZ?=
 =?us-ascii?Q?GC7zJOyAcLZdrofe2vgxCpxRpYaTW+Guh+NtHI1P9zfVp2HQCnlTddXB9HyC?=
 =?us-ascii?Q?+gWtJPDSHDKLM8urWZAYJjhGBkIGY4TVFKKlkZLKtZ7k7ELNtErKO2WFBmpK?=
 =?us-ascii?Q?/yy4nAU7vo1qQVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5A2VTy95yVQFvN1r95ATlB7eYmdAYu+Oq8NPEPRDSwI/XyXv4qVSzYb/HE0?=
 =?us-ascii?Q?pbGH8Zf4KtpVQVZDcfRlFXJdiMxZ++O/sZOxmM1mqK9mC8S24YUzNYGYGZ5l?=
 =?us-ascii?Q?x2F1GYyfE6/6jSaWnEq6rBBRD56b4kB9mOKnwRUjqQ9G/D87ksfFEVLWZivF?=
 =?us-ascii?Q?l96UM5BEP4ycW4zplbbeYVW6+d6XqO84J/SvMDE1amXjhAfLf8EVX9/1B76o?=
 =?us-ascii?Q?RWCmiiBdocYV9iTM/iVCcjGgDoqh2t1JeaQEE9axpbwdA+U0Rt6hGcO/8ZE2?=
 =?us-ascii?Q?BjgLXiqwmXWNwq6taXKJqXS/vIu2Z8Do0eCmzSnZF3zcL6VSFdjCSxlM+6KA?=
 =?us-ascii?Q?WMifQSqq302o3VMiwlrkJYXWXGJxg7K0SpKQVgQTZd+tr93u1AoApJeqOHf4?=
 =?us-ascii?Q?qCz9Sy1ZeDGo7g/LcNHrHQPUydZKC/nlA+nTsD7dwsZ5o+wxpP2iActuBjG5?=
 =?us-ascii?Q?Gzllwu018qyvii6yl1B6ZyZCHqXCC4+oLPYtX/d5WZecDmUzJ+cSaYu9xXPE?=
 =?us-ascii?Q?84d1Tv+BtI+eTe0qsvv0ZQPrTCxChFhOOMbLTcOuVF8E3rAuqZN5K8rTJHUK?=
 =?us-ascii?Q?XtFwBL3lqCq59Rj2sgPXvuWpBI/ATHCo9irdEHqb4asoMfRb7kqX4V/NAXFZ?=
 =?us-ascii?Q?c8PglR5SehLucMq7HsRiNUf28Fbmq5hrO2CnZfRCgLdt5VSUvQpjmnER7gqu?=
 =?us-ascii?Q?AiHzMGk1Lrbws4V9N48v+Q52yRwrcTpfgTEdyE7ckQXzOi9x0xUdfBui3/1t?=
 =?us-ascii?Q?n/DAG1F7pTva0mSys/YivDdzgkuH6quTei8nRmUq/OXXU/sJOjriuCkMBIQe?=
 =?us-ascii?Q?73jWQmWiKSyv8FhVYmLb6WzsHiPc0bxooGm5G/05lBqmzRNkbdRpGp0eivX2?=
 =?us-ascii?Q?nE7BYQajy38HWGHDqdj1iFE9rsdJOhpW4Wx48etvdON7lHtcDQ4EcyPoYOMN?=
 =?us-ascii?Q?fu8K9Le4tl319YmvGKqQCeSOZZEkmjC149CAaNzH19qYXJK4XJAj8wHoNo7P?=
 =?us-ascii?Q?/CwLSlwp4X4u7lLINEDeY3Vgu0xF0mpz6I86G9l88ngRzGc1BVTaYSjX64M3?=
 =?us-ascii?Q?qo7wrraY442E5s5yFb4ltX+SogltsNG5JqMCD6sZ2aKS/k949ac1wAiScwMn?=
 =?us-ascii?Q?UPGPynhEamcGONO/hgdPR8bvzsAkvcIINu+gSgwq78NXta72ZRLckk0aE2Hl?=
 =?us-ascii?Q?5RDHd7AqYajSbiqblPTfLkoPB8/0dVcFE0GdFfDDRXFH8t7nbL70NL9pTXOg?=
 =?us-ascii?Q?OSIvf+WJdsQ6mU0WvpiVJONyK5CU5Bky2fgUM4525NZIEBCqUB+ClK+9evrr?=
 =?us-ascii?Q?iAB4tAx1tCDEmzd5ZDqqTQfc6KMOJigiV35of1A87IiHMkp5VS3ifOhQAM41?=
 =?us-ascii?Q?zA58H9VUj3saW/O/QMLIqlVBStlVdppnWu5w/Vi8LXIL1qQhIYyl6HAyPhpu?=
 =?us-ascii?Q?C9gFeWQEpOkAoVxOQ43RpJK4Kl8m4cX6V1pRh94GioZ1ISkZus26NljZTQlQ?=
 =?us-ascii?Q?I6x1luIbNawc7/VfwK81N2UxU+nIu98B9piwPEeCoenu2uQzXU6Dvom9YqIm?=
 =?us-ascii?Q?nRm4df9SbrNVi7KkkkJLGNNzCUT2ycogM+Ec2rrokvxYm+85qd2KC3+cYYPg?=
 =?us-ascii?Q?Nl19tUgw+dUfhMonrprsdrQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a31e4-4699-4cf7-8660-08dd8ce65a88
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:34.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjk5M9Pi3YNVZ5Ngeg/rfZABNbKomplw6C4KY88KfEfdz/iOwdQkLCfIxl+r2x0lomkkeWyzPfAT+A9uWIDi6/FHEjD0Bs9+iTVoef25PALSkSq0i9CqdyphRK5rKYkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8904

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index ada1d7026af5..ee26df0398fc 100644
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
@@ -783,7 +830,7 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_types(&available_error_type, &available_error_type_v2);
 	if (rc)
 		return rc;
 
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


