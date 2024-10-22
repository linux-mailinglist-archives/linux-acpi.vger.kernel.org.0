Return-Path: <linux-acpi+bounces-8911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90419AB8B4
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F401C22E99
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17831CDFC3;
	Tue, 22 Oct 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s1rLe8kh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABB1CDA31;
	Tue, 22 Oct 2024 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632886; cv=fail; b=hEc9cbrM9VU84qu6Cniux9KjyTAumVotYgJ0u0/VwAHtSRkr0XZl9lFt41S9uu9EdNipSIHL6bTdG9IaOkVWvVRAd90pi74PI1uOIXLxWQaO1++pwANVkyGWTI3M3iokgT+thQT03nxefO0+BVAtp98x86lxzfeM/6bQQ4nQ5bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632886; c=relaxed/simple;
	bh=P9k6UcwKmIuZQ/7IYvLoIObmIB9VggFGJOCYU2oGyfc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACT3Egzyc4kkTzG1XhUH+3zsDx/1WctyhxdiUIbvmwqZxY3VxsQcKugI7XUVQIdtMJ0Te3/x6ex/pZ8UX8erS7FvXnd3L8JUT88T9jkuExFmhrk1HQHgSMcPjemDNoaNz//EPu/5khDkzpgBeYp5JcLR2d7ebQcGfSok1tZnFb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s1rLe8kh; arc=fail smtp.client-ip=52.101.62.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZzRfrkHmwzejqYuzqTBdxpQOExN3HjLBv9zx9OO0xEy5SwV4k7o/7ayOHgi4CgAkzWQl5AOcQ7TenC9+ugrTnR5smI20mDw99VMo0X5+U/m6lfbpWXffl0vZqrkoAJG7xnsknauVVjdgTt/A8zWztpoDUe5oP3wgIECTATgWOwk/PwycsPIULG1Dy5DFUYtTTmYpSuGqZ9TRsYYpR7fM1sLfa5a3bibw0nZgqF/U4QbaaOkL8zmjkpNCHaTCs7uS8Nl/symlZwyPT5B/J1JDI9WAIp9foZsHUpfGM0bV/lwhJp9wdQdRlVkPaD/v3v93avhFDJuxCWx5p8YtvYFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS/rd6dnR1LqFsJ4MqHnLYRlcAqn5m7bXnQtwRvU4/8=;
 b=BEtyPgbAsijtqEkzQt1mLoTqUcj3lnwGIfbGQAtEaFs4h6dedYYgNaY9L03wLKt/w/xy0znLGX3BW4FUq/PyjfjyDp5ZUpejocyAzqK3WfFD3eXWz9PwsReUV9F0CWrP6TGbhINRrA6iqAP09Ic4jczLCh/RgyErfSVPl3uC93SDBDa6b0CALNmXkACItbNtMzhUBkojagkO3Um5aa5HV89KM8aHKDrLl56GK8PS+p3Gzv6ekayObWH2wSuH7mEEkBOPBY0Dpz8MoZCG5A/K7yP0ffsHxkfRHRE3lIS1gIBXEgXgF0slMBoHc4At3phFz7Q4ksIyTVK5MX+tba5RTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS/rd6dnR1LqFsJ4MqHnLYRlcAqn5m7bXnQtwRvU4/8=;
 b=s1rLe8khrZuKNBkVunJLPfoZmIUA62pfqqoprn+CflzM6dYcOL2ASlFB4DAQfIDtxzLuWe2cZ4gHHFIIqEJR1HQJ5Ui2RWqZ7cgT2siPKSvuW9LaR4bWBNIzbAW7Hh9AIux4sI5VOtDnYngn9GF89JiXa3/DCOMjYs/17yo36UY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS1PR01MB8991.prod.exchangelabs.com (2603:10b6:8:21b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 21:34:41 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 21:34:41 +0000
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
Subject: [PATCH 1/8] ACPICA: Update values to hex to follow ACPI specs
Date: Tue, 22 Oct 2024 14:34:22 -0700
Message-Id: <20241022213429.1561784-2-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68b53671-6fe8-4a54-1cf1-08dcf2e156a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rkv24dLh4DuNRziL2SJaLIrvZp0vuENhrBWv7zMgrFULqUXlKRBOgYeDjVgK?=
 =?us-ascii?Q?e/Jn6TSJsaykX17cAz+PafWn/UTO5k3s14PlX3krPbE1nGimRlS2JxneWzT6?=
 =?us-ascii?Q?a9YUAFkX/We9OqW2ovh9dUFMlbwRQt3hyOQGk/kk+cXwjrkNSg+k3anle0Pg?=
 =?us-ascii?Q?KraiA7gfvQbJj4aiuchXxV8nef28S/67gQYSxOGUUL/D37yUvXsMnWRfcQD3?=
 =?us-ascii?Q?UKUZXUBQUjIwmbbVNCb5pp0lBpYopdO9P6NkVHwVTKWjRZZMm8KkX0CfVswS?=
 =?us-ascii?Q?dcBgnu5f4OWoBKuwy7XcuhnJOkimw/HmM157hzr0aPeR7grpg5zAD6xMj02L?=
 =?us-ascii?Q?hQNO0W0T57lCCNzaTOcBtv6CS73NauTEz5epZ1BrMQZxYljt2ZUCtGSDPkfp?=
 =?us-ascii?Q?fH8u0/SP3L1rOLhh2SkfwTCW0Tl21fmGYztlp4EwD7RaGxlZlVib0foGTlkO?=
 =?us-ascii?Q?5x6eYGXXzzUjCgPAm1gqCd7tnrvQTTmVl4rzdbd6rkscbrf4/Gxq8Kta9pg/?=
 =?us-ascii?Q?qKVAzS2USbIFkMnbxT+KPo7ZvMLhoYjw/+nlSXA427ftPiZw3Mw1jyvlIpXO?=
 =?us-ascii?Q?yvWHLhCGjllunTIshC4WOX1uQfIcctMm9lq/92AaArs5qQmxJ7aByJNRmrRN?=
 =?us-ascii?Q?9cYLXyxX2S7Aqf5bvbGxODQNxIJid/1QORaO/WXl1jb/x5HrxjLWldV4pg22?=
 =?us-ascii?Q?vuM7BbtafMBlnmWOczTpuiMZDt6Fc83DkwO+3WmZlCdwvd6ffl6z3Tj9NMHi?=
 =?us-ascii?Q?F2jY4YvVyGADO9LWeYoQ+D7retgvS4KMfC2KN1NCMfDvMZ7/LJKhSr+1IqlD?=
 =?us-ascii?Q?pzqT5W8PnXsLIpUYH8D/SrOTpG2vaGPm2gO/D0zdN/CxkT9dDkf5NU4fMyaG?=
 =?us-ascii?Q?MyA95olK/Fbkbv8zhMQjn54DQKSutND7roqh1+GfpX/O3sZWCoO/OoITVxz0?=
 =?us-ascii?Q?zF1PcsMKBiD2Sy9C748TtfAhdEE50Mtgu1Djnf1UskuHAWyMj9KVy/8S5/9u?=
 =?us-ascii?Q?33dpKMz5OqpsApQUTPPtsonbBRzLR3atbCm9p86lyD7+Ya41RBSnstUY01xw?=
 =?us-ascii?Q?c3Vs9z9uLYXNhrxkkaO/X/VSKmoXKiiPTTi6X0+Emgs9B5y5RSguTqk8ZNMt?=
 =?us-ascii?Q?lNutmGetIqA0EJGSNOOcPOoYX9TGKuJdaQnCj4N5611vM/JeJxyBbAQBEG54?=
 =?us-ascii?Q?hJkGSNHa381ghmqEV1AaqQ7WXv+0Eh1XqUBW9ZE1ZyUM/WISISpF75z0mADg?=
 =?us-ascii?Q?M79m/Yex7g0vSwMkldYuKEV6PxwaMLbXP87V/9RI7BQ/D7yTj2uuRAKSpAB/?=
 =?us-ascii?Q?8NtyNfZuHU/+RRaFBWYdJJrKaKJoDIALk2zIaiWms7kkmD3JKRGbLcYYK9Mk?=
 =?us-ascii?Q?ULKoNw3SIYNEWj2xfEc30z/YJ8szSBrvuyv6bYIRQSN8vzRzIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPQqiBmOGViR6vZIoDJJQOER0DWjhl+1B06JYVoqdJqLM6unBWOVYlfddYrD?=
 =?us-ascii?Q?QnJI5RQBQ/+UIpZARDS5kokuBt7UybUZM4aisxdRNoz37MjNYueTOls0jOwd?=
 =?us-ascii?Q?Y+l9vfZIfAAItyTRl/71up0DV7tO2iw7Azbth88yRGVl9wk+MZxYWnmJsYmX?=
 =?us-ascii?Q?x9/7pZUwrc65o88UXuVnnGlT9ejDNVKyVqP36XdY+XvyFznz12lKvZwR/F+L?=
 =?us-ascii?Q?w+tzN6ppYWlYk2keFArWH59kNR4cLBwAQd1hYn628dL+Y12EvkqcfFJpm+zs?=
 =?us-ascii?Q?J0bRzAic5CvJ0JRVGdtqJNf8Eq5ky9cFBLGL9y/XN5rE8Q1Q2W4LGb6tTH11?=
 =?us-ascii?Q?WJc9xJWxBNv06kxcTD+Z6FhKfeXDSZuIerXwojh1yJsaZPAVNOXqMmM/DOVA?=
 =?us-ascii?Q?+mZOF0JZRxzfX8jkVOudQjvig0IBYeDepRGgvIk7o4Ll9pya3r8jcJtIUreJ?=
 =?us-ascii?Q?l7FrvflqgN5m1UuBcXxd7ELFU/EP4oZK4fmOhEFPr6EoBWCyT2z04w7MrE6u?=
 =?us-ascii?Q?wgQgffCqm6Lt2IX95xWQ7D5IvLGoU8WMBMjqC5jl9uufy2jFEgi+Uh3mgqhz?=
 =?us-ascii?Q?TW5v0wMh8cvK3e85+E/cx7EpJworvNS4RTsWFea2IsJxsRBa/DAWK+z33y0W?=
 =?us-ascii?Q?bi4SqUs3IuTklQOZxNYqC07ogF6FqJj5rgUpsbmZENwEoO4BD3aU/ozgNttS?=
 =?us-ascii?Q?Rcg+4SwjDr2L4HNZ3bPpUOIu2KZmLZ4QjH1dYGY/FwvJZXO7gB8A2IYds5/D?=
 =?us-ascii?Q?o404E2cfRLNqZ1QvLSqkxuf7NJDe1l5IkqYAyLo2an8L5PT/2tuD8M0lkipQ?=
 =?us-ascii?Q?UIi9Pp5atmhlDthKn7nF63TCeX5vBqS1orTGF2bFl1VE5qZhqByEr0qbJZka?=
 =?us-ascii?Q?zylstbISfcMljoXwMDBYzVd7CpxahDHxHmeUjmbMDryynHUfXbkGEVmJrzWL?=
 =?us-ascii?Q?lAft7pm1/mZa8RjyaFuUJNmWbKJatlYpc8bLS3nmO5WsSCLE16FrMoUvH2cF?=
 =?us-ascii?Q?9zExDKNSNTL0kzqDGyA71sd4qYkg44jMhuvlvx7i6frQfJXH55VWq1E4P8ik?=
 =?us-ascii?Q?2Fu3WO5DjonL1vOROJZkE31XKzv9H5Q7t/dgcHEkF9DVyONDVg8MpzwG7R8n?=
 =?us-ascii?Q?U/PuIIGy5bbz2DU/HkUyPmem7RLtXbRdFR4QwOIRVzRrMcPEfKKr1oMfm11E?=
 =?us-ascii?Q?iy+yEvjB6PbIHbBuJZcnRBKxTzWSzS9nP+PDcq1sNEKe4vYQbDdfS8AoGzHR?=
 =?us-ascii?Q?T/ptvPDWKem2OQFIdiExkTBSrPYYFLiU7UxJKTwb6HuNKdrVG8g52OdnoIOW?=
 =?us-ascii?Q?FGYvmX0MFXNHKdEpehsuyvmNs2ej6/8RIGHLkzGmAgScuyERgPGn4y1iSnLn?=
 =?us-ascii?Q?x6h3ELZVEiwyJo8WX61a/RMTgSmpeB901s6Ly+F8cpmJC/YvBsLb47pBp6vG?=
 =?us-ascii?Q?5b4GF8y5e46Bx4XZkcgr4ISsRFtSWZ/bbeL/7OKsZIeQf2ZBmKfcbECu36tk?=
 =?us-ascii?Q?TpxDn4vrltnce/JS50TRYaAdqASx8aG8Tz+VAtIWA2t1Mj9LOMjM366pnr3I?=
 =?us-ascii?Q?6N4ZeaW3t1mdE9oOsTOVRQcufkI2hepAcJ4dzRCsXwtSOSqUmiQaXJwca2bR?=
 =?us-ascii?Q?GbteRz2v3R8SczOgrZLekKQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b53671-6fe8-4a54-1cf1-08dcf2e156a7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:34:41.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Imjsqe3bph0eGWocqrF+ODKqvJMTnsiodcQHdfJm27QBrmIxCmwLYzapQNYmcid0ncg7RdzORax+CP/QiuT43JykNv/eKS7EmW8xM08c6dZOMv7JajoDmNQ2DepJKUWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8991

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project see pull request(2).

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
(2) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 199afc2cd122..ba177b79a2b8 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1022,18 +1022,18 @@ struct acpi_einj_entry {
 /* Values for Action field above */
 
 enum acpi_einj_actions {
-	ACPI_EINJ_BEGIN_OPERATION = 0,
-	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
-	ACPI_EINJ_SET_ERROR_TYPE = 2,
-	ACPI_EINJ_GET_ERROR_TYPE = 3,
-	ACPI_EINJ_END_OPERATION = 4,
-	ACPI_EINJ_EXECUTE_OPERATION = 5,
-	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
-	ACPI_EINJ_GET_COMMAND_STATUS = 7,
-	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
-	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
+	ACPI_EINJ_BEGIN_OPERATION =		0x0,
+	ACPI_EINJ_GET_TRIGGER_TABLE =		0x1,
+	ACPI_EINJ_SET_ERROR_TYPE =		0x2,
+	ACPI_EINJ_GET_ERROR_TYPE =		0x3,
+	ACPI_EINJ_END_OPERATION =		0x4,
+	ACPI_EINJ_EXECUTE_OPERATION =		0x5,
+	ACPI_EINJ_CHECK_BUSY_STATUS =		0x6,
+	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
+	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
+	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
+	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
 /* Values for Instruction field above */
-- 
2.34.1


