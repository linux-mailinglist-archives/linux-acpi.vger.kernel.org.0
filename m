Return-Path: <linux-acpi+bounces-13510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681FAAD049
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C96B9A0E2A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDF23D29F;
	Tue,  6 May 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="S3Ge2vOr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3F23BD1F;
	Tue,  6 May 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567515; cv=fail; b=oS6mOyb14YfFDgM8wXIhgy6kwohoo796uC6KOBS3sZhg962ec+/cLeZxNMuoyn26CXJD1uQ/nvBBQHKl27bRdKwsBTuGzqZTw8t8qdX5gldmZ7luQy7vPa99X+tI2TJGDJ9Wwow9sjpRQLJNDVF97rVZckJdAad3mPDlo6fRVes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567515; c=relaxed/simple;
	bh=rLfjSCtgS+mI8IedzfcZcYNnB1saXqE72EPcM1SNaEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8lBrt9wYz6w9nHc9xXyk1o4He8tFCI2G3M6CgtydTGQhB6wzchGjUuzzDWbdMXxiI2gb3+RTD7kctcEb2k6kxRBRyFQtCD2aV/1L1ILepkCz64cQCHNsTl9Lh0yvkpQ6R/U3JZRACjCF5B+CgTncyTNBwnInHypT7jKTDm5Ka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=S3Ge2vOr; arc=fail smtp.client-ip=40.107.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrFazEjwpw7EVTcOjpveQjyGsXLdKh3MVdE+g0FQssvxFbteb/Qxa5/e0x8Ypy/hgdRhNInXltXy3Bv7bioXgx9WaV1UkBs9YKpoolRv0x7sPIfmtRRkncsiFz5ntzGWJJ8bvG0DetnQP6BXV4NJhbFysum80NjfnQ+nGQHqZJgjXK+w7TCceA5aaru6xs+X11nl1mQxoHStpmOaJ1r27DTN5KMSgsP8TSWWZw6XPpCO3O4HbLmHUEt4bxAatbJSBOSEWA3D1+XY0elyXwzFEwSUyp+/MDXkV3HLCp8NwuWV+HQUi/eV+6jU6eX6DsyM4q+E4gVRJvZz2U/pjEiQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVYmWsKR+bi8SXlglxzrFGZ0xl76OQEVKxg9417i0RU=;
 b=J2y/bDGxhQnykEW7zYU+G0N3DoXbXAuMNL0cdIqKBHDyrtBGidv8ZIDb+HrfhpVRVButUj7AyDPYnxGlw4ePQjXCgYBBN/CUzk5saUVaeykGjOTTK3kdHZTUwHGAicaVbleojAWt3EFxHcuAxzmriUSQHPX1WKbhhW9fctErqbnwh19RNTQj2W4PdDrmIvslkwFdmAq4DW3tllyFoPeKMz/Fd6UYah6MFVOvVLCsZQIHDblVkFXtlCh6g798emXLFI9K46AZAwHQhE02kSB0SNqV5MLD/dOZWCqmjmjPtRQHQUoINrSm3Esb5jzFgrXTlkqIzsLTfUfXs5QpgMSG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVYmWsKR+bi8SXlglxzrFGZ0xl76OQEVKxg9417i0RU=;
 b=S3Ge2vOrAY1yJNTQBes/ZAonSIvxFkpEjs3i+VBf6/O4puTBBCUfzwtKWX+0HXviWC3H/DW5NeRJ7fEHjS2LMMmhutI5567nVjznkaPrKeaWMOQCbDeOoapEFWZfGQ4JBnxEss7CDlKsdFdmHC38IKt5a+r9RvHXCnA7vkKxsbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8717.prod.exchangelabs.com (2603:10b6:8:214::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:29 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:29 +0000
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
Subject: [PATCH v7 2/9] ACPICA: Add EINJv2 get error type action
Date: Tue,  6 May 2025 14:38:06 -0700
Message-ID: <20250506213814.2365788-3-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0fb71e6-6ef1-453e-5bdf-08dd8ce65783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqrKmS/zK9D1Nktn5P1mT+99J22S4Ftii4psZGoo6RUj27bJpNSW1u83D7Cz?=
 =?us-ascii?Q?shMMxK9BT0xsb/NDYn30Qy+OWouarOpDK1gwt/8bhEgNoDY+TxP0G4B9UVuM?=
 =?us-ascii?Q?BsXTsNNWS+2JGeKTvKzFPgcmwya2FrVaC4q8Yl9Js3wsEgP1nbf1KEm3b5rY?=
 =?us-ascii?Q?rw16LEdQoWbZtr9S/jEZaZvuAYe0877LN3env3eMgHy3xRdLHMowGwPc/1e7?=
 =?us-ascii?Q?G41JS51lDLaMKeShpnrEw2RDrJqvfVpqWMJU5MdEng4rZO47tzl1uXWrUHe1?=
 =?us-ascii?Q?GgR/BymJuBhFqJKkn1Xrp+1IDo2Y01qha4ttSrmQdN3w5RBMNtlKKGJwN3sj?=
 =?us-ascii?Q?nZDD/0DxiLMxSNRGx5dmZLv+fbYGEpNytQrqMo9GG1hc9wMThECg257WM20h?=
 =?us-ascii?Q?HTp3h0UcFzOaWSCLsnzbuZVQe7/EOzzP6gcpN1GrgBBUTXydEPomINzEefrR?=
 =?us-ascii?Q?1+iz7mBGVap8lq7i3drt8gWrTlPlDr7+l2NbfKALNI3Cd7/0fDTvzYQDMe+y?=
 =?us-ascii?Q?JV+VLZTVl9YJ6N2DHqLBvyCAB+Gk724UJ28qw8vnF8ngmSGEjIgowAuW/Otw?=
 =?us-ascii?Q?UFUnrk1RmO5uBJc7U4v1dmcXi4isYKaZS/nXeCSxRK4wF+lbIy1tXMoJd6DT?=
 =?us-ascii?Q?trZaGV5OgAaQVsEWlBtERcQ4xIKKgQjejlvL1gcoyJrATDLtD8p0PNu3QJNx?=
 =?us-ascii?Q?+6oGwrJ6kIcVU40Dp2D/waLEmnGgkKiibUlUNU5fhx2MneQBqMfJUPD0WR7L?=
 =?us-ascii?Q?UTDPwCx7XSWO5wHlNpVyFki2ahlqtb7mYQbzAbjuSX2lboisRJajApjHBxo0?=
 =?us-ascii?Q?nKOewL8yMhHr10y0drtgSjm6YrbkHVvNVwK5ml/KM+8tHTMDPxdi9OYKl2E6?=
 =?us-ascii?Q?NykvT+2UsZ/MdBIqEUXIvK2qUdNB/A56zJdzSDJRmurtYcMvyZrZ9/s+TH/1?=
 =?us-ascii?Q?5nETw1BKc2nWCI8CP3GRn0ZKXLpJJuypGanvc1UWVRyR42QRcqkT04JqX9dQ?=
 =?us-ascii?Q?DZXcmO+Eb8Xlj0Qpyg6eJNGXEXLczU0ZA08x8r54JExDY28ARjOfjNflobVI?=
 =?us-ascii?Q?j/AOOXHuIppMI+M0WaqLmTqwsWGYgDNwAZOYa0aHBj0mod0WhjlT1fX9qETs?=
 =?us-ascii?Q?mgoCj2FujNRTgWCXjTmBJgJtw5NGhOga/+9KFL59lOgDt12QJrKxpfNzk7i+?=
 =?us-ascii?Q?JofVs/oahzBS07OeHBVKv1e9+TkzCQj16rdTob0boGAKyilAtEUpeU0m43sS?=
 =?us-ascii?Q?Be0xu7h8g74yO/7G+em5QocQKMIItLY3+8qrvEbtZ8nDjSzsoDHyXepBDJiB?=
 =?us-ascii?Q?T+opZ2sshedTvQxanvHRCBSQsfrZq7pG/Dzq0midA/aBwN5PwlimyiahfU0+?=
 =?us-ascii?Q?/qyIYAQJWPl5mQfJqp+Rx7erkWxqbWfZTMd6WDe0LQdBhMJKtRV0yb8TkJjJ?=
 =?us-ascii?Q?uAKHg/35Hck0pJ1DrNhHqDE1ccDJ7tUTIhbzn0kroeiGcplXZ0VEKvAlpETe?=
 =?us-ascii?Q?9FjyF0eZEP7LLs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GeDv5r9yxxXcZCyVEINdcR7XsucvHXIvUGi8d4pFV6DvCoLvYdxKHf+rO2L5?=
 =?us-ascii?Q?b/iUBRxIBfL4ye3Op2qDPY6+ODF/6byikp3wBvz2t/q6wXBvweIy0NsCSO3/?=
 =?us-ascii?Q?5R50n3Tof9kPab6LxWcECcgEl0EguDG4m93M6GBWN+AiCfSbLhjQH6z1u9SV?=
 =?us-ascii?Q?f0/fYAc0P2iqGwpKRhYsVF+z2IdcITi4GLhMycJv8bN1+J96WqiN6fM+F2xb?=
 =?us-ascii?Q?y5eN/foar0DTQoKXECVHx7tmgF+LToQWm8bjxqrPTnVnfz80KGR5z8AeIBq5?=
 =?us-ascii?Q?gNRwC0NrW/b/ZinauKVi+bukKFAZgHwZV075gB9aZVTXJ3x816pj1WEFHvij?=
 =?us-ascii?Q?cWOiBmqL/1RfW12oO8JTv8CY5/2wJh9W8DM3grmBhPMPlhzej4udDWQN9dQB?=
 =?us-ascii?Q?ghOtGsh9cSteZewOq57U7F/legH2R9BTkBg9eX5vITYeHoVupXOixQ1qnEpa?=
 =?us-ascii?Q?tGiO87RQ9DMkLn+4cOqzv7oSFOtRLuSU2TyF45/ngrWvSXWSheZVxIEjvj29?=
 =?us-ascii?Q?5fXFnwji/Can9nIW4n78f7F4kIojWEUujA3smqGrJq0i4DXyO3TxWNPHlSfK?=
 =?us-ascii?Q?H7dZwFC0mIQCT4nyJe9TwLzSd4m0F2TD07sdUDqDoW/rbDQKwwwb9Xd06wpA?=
 =?us-ascii?Q?eGhAjExlzADLiANZyAZeSJ0SKRrNdFryI3UGzf/B5HaJyAhybhPe2UnDSyf5?=
 =?us-ascii?Q?9NhZ+Evfa/x7yIjEJnk7swkct0wtN7AGfn2ifrvYqW3aa3CCLeD4hKTDNZH1?=
 =?us-ascii?Q?k5ZjHCEIvJ5TaFK4D2/1VKGIXVPbiiQ8ooecIm/ZlSdFrRSNkHh/ZhukGETL?=
 =?us-ascii?Q?hoKfoKYVtN7NVHdP6lySOYEs0eVl5UOxFNQ0XeKBAM2ayRyoRGi4kFRuUQdk?=
 =?us-ascii?Q?MCr8duYQupOkwsOFcrGs1gLuHJ4Znz5wjWeC0rK4FcUck1uGkMrDDet4IJfI?=
 =?us-ascii?Q?r0+AWDbZJjKn70GgBXvSCbGNvfZsLLbmuCHhvkFF8Z8u/1/zMIaXQuUb1RFn?=
 =?us-ascii?Q?JQNuKdwu4Z5fFwwLL3O7dSTvj1YhPMZy41+1AaAyHB6Yxvu3ilWtkaF+cbXI?=
 =?us-ascii?Q?djk4V5Hys3ao8aXfwijtLU4Zkhi8EUvOMAirWFLNi0bd6oCujD777uJ7r9CI?=
 =?us-ascii?Q?30cxnDu6P/L0atR45NEyllAzib1N+GxPjQagVrDKi4QDUoZalw2JQTdjb6fV?=
 =?us-ascii?Q?A+giscdO0K1SfpUHjNWKR9biysiPRR8Z8HubfkC+qIAdvgQ6kHpsy9AZbopS?=
 =?us-ascii?Q?6ibRFoQAPmMf/6OzoUVXfUWGcC79EaasuhYku+5Eh3dqMapset/qXnU62Kkj?=
 =?us-ascii?Q?mXMxwMxRNWiE3JwgZ0zU/JX3iUxEmtUTdW5D3kc6GiQNkejwbhXHFM4MFNHs?=
 =?us-ascii?Q?QEVTx81E7CU1i0tUPcWddqNsVW0F8jHzPoSpLqlt5dUdRw4ATx6emhetWv5R?=
 =?us-ascii?Q?mp1xphiXQt0CjOnshN+YUWV6Lj1oNQTgArrI+Ne/V9lRH7uKypf23NJXGwFc?=
 =?us-ascii?Q?k8Qtyui2FLq92iAS56YkSyaBlG+qjATD+Sf7NqupAMLa9lVJi8fpL/wtDZOG?=
 =?us-ascii?Q?jWenm0ExZelger8iDJBQBZmWlJg/1mN+F6InAX+2VirBN5Lzf5ip1KL1Q5Uf?=
 =?us-ascii?Q?bBQgspCZ6oEyldLXX8Ud1zk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fb71e6-6ef1-453e-5bdf-08dd8ce65783
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:29.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAy1z2T3/qHkVE8Vo1jog/36Mn5aD+W5cjB55C1yy4mMjsqZFm+ivTh/OJ9XztqFoxC9z88Mi0gGYk6KzzcoVrdoTdqjsbIn+Xvj7g1qqqYmoL3nq6QvWLm9Ytt5PNc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8717

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs[1][2].

Proposed ACPI spces for EINJv2:
Link: https://github.com/tianocore/edk2/issues/9449 [1]
Link: https://github.com/tianocore/edk2/issues/9017 [2]

This commit is not a direct merge, it will come from ACPICA
project, see pull request[3].

Link: https://github.com/acpica/acpica/pull/977 [3]

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
2.43.0


