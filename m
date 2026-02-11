Return-Path: <linux-acpi+bounces-20944-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE9lGtrzjGmqvwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20944-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 22:25:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1053127BFB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 22:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64D33009F99
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 21:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56464354AFC;
	Wed, 11 Feb 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9D6tSQC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276794414;
	Wed, 11 Feb 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844984; cv=fail; b=ENjUZhX0mU4qCbL1CGTHhclP4N+vN8BLy0eagrrNJSEsm0CzaIWOSDYRSVc8rOKKVUiv7W0wEH8iqSDhf499GUjTQWN+0i79+5Omlsz2OaMf71rye4b6LRBUeNiXTOlfxnYzSYoLqo9EUuMa02ip36uyYdRn5bXrWhSjR8iSJyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844984; c=relaxed/simple;
	bh=i09ndUEtxNUzelI1RanZFulsOdIiKBYD0Q7jN1st6hA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VvAnRyq3ZxcOhnJCOX6A7L1vhrj02GiFZFP1kRRcaK1T84yvXeDRcPTCGOEf04s/kNPKbS5s+EzlJMu+G06OoZqTurCPUvedkgH/pTxjPjVGMPrpe0QbTtAv4v6yF6AorzZzBoHMEj6UTJQkeUjgXziDV0TrQESJ9GrJi1kkFKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9D6tSQC; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbYJlpxRQxU6bDEPejs3SXGTb9xcC0ZayHImRxMXsg1WfZcAmzDuMv4HoTX54bXLxOtcZ3TQ4wp4hkDeD5ulsL4j/9xQKVelAA8Y5efihOuTo4tqxU7eXqj4Ea1djGKhzwF65fG8PGtcP+wbyvdlQM5ErLfEkpoH0uy9aaezD7UFV6VLPKoxrFS9tbboTjJvO31GoFeeebLp0y6u7zhL8JVa/wP6OgnbmGaAkGXBd2C0XcYbIhTPGtyU6LfWyavivPPoTYAWR7lmsLOBgZBcD/kaX6BAQvKx5cJEv1RTjFcpQ8tfxcuDkdYCCOHg3IdzGXt4KClnvQwRD90c8yIz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ksMwQbKnK6qFmKMBCUX89oTElLRCpFKWWOldBfnNIQ=;
 b=H3McCYX3KTR+wb/lKdewUluIIRa3WV5YTjAR93euQrmSNyPg8sjF+VaFXiHfNRuek+RnwGL+8XscyTYiIKkc/CKHZ0thVDUzqBtaMQZkWb7gi2SdlnMzeT1dw4TkkWCXDyipT+fiqjRLuh/GkoqkJKdQ9O8GVa/yFmhrbMSAjq07nizDFkZmZu2/TCku47WrdT9BPPc//3WNhjYjWbEnsbYd3WIijBQgjdEd2UQ8k08nBEvEW/jkljxpnDj+UrSB3yiFg3IM4YSTAcYod4Zow3WNI9SiYPdY6jrvbLrCAPXzh61BxnagxWVbyb9aBlnlAxBr93+rie48nhP5zSHWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ksMwQbKnK6qFmKMBCUX89oTElLRCpFKWWOldBfnNIQ=;
 b=Y9D6tSQC5tKqxjUWhQkXHdo6ZJvgMF0D9/fMcbL8rCRx3NV62QLwyBL4/+RznU7G8LbvQuiliLjE+PKWFhRvHMKpWyFhwMnGK6KeabjMsZ9VWTI2r/34nJa8IRAcEiaXLtFqxTGabNVyAgMYlZKCievBWIz4G35i+2QUmFQnU9n5AP8DHgnpeVMt15MPybmWLdPupcstSRa/WQzD4a7iHVCxM/ZbyIzr5zu5nY6UoYfWPm3Y/RSZXsKjxUm2KywEHGbP6F0FI0VMjhM2Hi8OODPjGZ4PXmbpT9biwd6FYPuPuqZ0usTXja6DrnNqOtd+JOSnIQ7z62KJDqMBtLRZHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 21:22:59 +0000
Received: from CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790]) by CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790%2]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 21:22:59 +0000
From: Sean V Kelley <skelley@nvidia.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pprakash@codeaurora.org,
	gautham.shenoy@amd.com,
	jamien@nvidia.com,
	mochs@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean V Kelley <skelley@nvidia.com>
Subject: [PATCH v2] ACPI: CPPC: Fix remaining for_each_possible_cpu() to use online CPUs
Date: Wed, 11 Feb 2026 21:22:54 +0000
Message-ID: <20260211212254.30190-1-skelley@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To CY1PR12MB9674.namprd12.prod.outlook.com
 (2603:10b6:930:106::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9674:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e766521-d647-4c30-450e-08de69b3bb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5Z2gpZMud6dWKSPMwfDLXjsAxpVWy8tzXm/YSI6tx4XVjVGlhVRO/cEZKk8?=
 =?us-ascii?Q?5ReXeIJ9LhYe0FeLS85x1RFIyi0KUntKFLL0MUkguwIgIAgOxtG0acRYlGm9?=
 =?us-ascii?Q?erI8zrtLCrn8a1h7NuGAlJR+hiZ1M/KQ77Qx7pxiA8Y8ZMuu2NVp/ewWKhyP?=
 =?us-ascii?Q?ZdAYfojHBbaGNwcolWMkkafyVjPo+F8IomptBXoeK1zX1TZUGJoySwEkEaeP?=
 =?us-ascii?Q?dXIbk24INjzDTJC5smLn0SK1gzGPeLhZYjCjVn6LnXmpYfCXTXQ8VkXnLfYW?=
 =?us-ascii?Q?0suFKAL7yU4A0lx+Onk7kRwe2kOJLZrirH5aU0ZVbelEgoP4SQ5X0oLzs61c?=
 =?us-ascii?Q?AhYLf7SzA+jjqkoLSJuGbINLP5C0AWrKEjJ98BkFBnY2tnccDrzKVW5TPSLi?=
 =?us-ascii?Q?ZqWtaJJjusb2pfYiPGEaqCSNpEsJLSUoErZmRN4kxoSzjuZc9IKgg8ytCE+p?=
 =?us-ascii?Q?uBgn+i6HT035YdNTzS/si27ECUydUkny2dCljySWTbYwSsZjbkFEKO50b3r6?=
 =?us-ascii?Q?AvjJLkog9SuW6yV1d1hA602w2XVq3dotauUSL7i5PeVTJ8IqHFdXkWuK5k/p?=
 =?us-ascii?Q?rJs6zZmJFxfaRJU2PW2+RzEtmISHHky2GweOcnl+V6OuxhehW6P18wJIJtkW?=
 =?us-ascii?Q?ADoolpI52dLUSQRu/xkc9P9TvfEXL/Hv62ZC5xXOxG7UszdaJSDXGcRd25IM?=
 =?us-ascii?Q?pUFhJq1/4OuLEr9PQm4HSZzAIyeQnN870pBaNsW8cJf+QjLFm/AU1w27Kw7A?=
 =?us-ascii?Q?qW85TpcFVuL8jZQWYJqiltQP783LBdbp1Sj0zPs+TUVRa2EE7aIuQ6njiFcq?=
 =?us-ascii?Q?hane5DtdqwhT8E9yh7ETrJ3PKmd4xLo3QGsUQFg+qODIzPhMeFvBrZM0ftSs?=
 =?us-ascii?Q?Jam+y3MCU9ZFfUdGBtQ+7dq9Kr0CqOU1FvIZqmNpsPiwkU07mYA3T4VI8vbj?=
 =?us-ascii?Q?Drq0H1vL0W1FrBVheDoedm7rJgNqusm9sw902SYGyRX5JDMVrygZRwrIe5UF?=
 =?us-ascii?Q?nbRD0vr51kUuag4IVjmbrzfhpM7WXkacO+mf5cXtqngd/yFuvM7srXlMFZqm?=
 =?us-ascii?Q?ozo3t6CiAVQmThM5N/Hy1zCMnex5aBBLNyPMvaBqvRKFTpyfIbhqkysaBEnV?=
 =?us-ascii?Q?L33vmY1JamYHXwsWlCigFbcbDuaLxvVz4cgU9YkBmTWwd+7rmtSMcF6qL2Z8?=
 =?us-ascii?Q?d9BPxuBDL/qdEtOwa8vGYuG+zLIpj1LO0e/CC/zfoHzoHzTOjVabwIanbyw3?=
 =?us-ascii?Q?dwHde8vB3SXNQf/xanD+BfHnw3rN3HXIziTf1Q+Q+BNzgnuKCgxlNsF9BGOe?=
 =?us-ascii?Q?dBEA1ms4GtlLNHDy5d0iHZO+zh9E01pCyftFbj7dKDF9jBMfh45IdFGtL3EN?=
 =?us-ascii?Q?fV8gejM7AHOw0lV+cYkr7S8X+vBOqvbTwSM2W/uz6QIKc21l+RzRNyDF97Vb?=
 =?us-ascii?Q?+mGnEIVh1Vyufekt+OkKHE1u2wP4fscwBg9Cs1b/TQYJvv0aI5dojLgNBlAw?=
 =?us-ascii?Q?kStGqCjmSTXSJqyJAusMs+87KY7W3Ed2kX1vjddofMfAHMLzyT+ho7rZGtUm?=
 =?us-ascii?Q?m6Oq03Qjd8zr92OpwUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7vwzRRVtt4Vo9vIEOTMJ/GfdHrRtwagzjbokogvTxRyxnDiD9uPIgojV5nV?=
 =?us-ascii?Q?ahx0rQ/vCUinE0cURIPE52Tgtb9R3y3fa2Czj87Szs5dJqnJ/k1lccg899Wo?=
 =?us-ascii?Q?EX/PrQWJ9wUf1oH0Yd9iOQvVVxQxB35P+fTPPWifwsIpgGcN6FuN6PmyawfZ?=
 =?us-ascii?Q?KaxpAX+jLolkWIATr6WAbyePGW1D5tDWYAbUqFd59IjNR8+m8jORzizy9YJ/?=
 =?us-ascii?Q?ds1O9eVQcaJVNptL21HioZzO+XQTBtd3j4CHpWfzSa9KmIgC7nv2lqcZ1WRF?=
 =?us-ascii?Q?a4hTVUA+3kAx+DOJ0C13mb+BfWMHcGc4dBeRuNDcqU91dbcyWfTwZpUg6t7U?=
 =?us-ascii?Q?fycI9kGaf1Tzr9LaBdB49AbhhR9k5PZiuCQlVqFCLzGFMtIGsNiAp5Nir7cf?=
 =?us-ascii?Q?glJ6mp0VmyNDXUrFVK+nRRq30Dtn6U/AD53eTzRCA5Wmftn4555pZoyANsu6?=
 =?us-ascii?Q?AWWCRczK08jIjZmDYegKLQaMel4F4jpz2NaDK+QgFEFuanj3FUi9ldOQDZLy?=
 =?us-ascii?Q?GK6UWWhIOfllF1PuzE6leCS+PEh4AqXGn1OV6+AyYPzAs4xyNYMJrDAwd2Kq?=
 =?us-ascii?Q?uOUVzmanshZqOgJZGozLABJgmtxC5CEC2ULoGIFxy5158+fib/kpAZtuk1Vy?=
 =?us-ascii?Q?uyqGYBufl+Ax9ufDDz3AovXWnSI8fpntTCJwBAA+PpXyAMNxIH3VezUTrhDr?=
 =?us-ascii?Q?GKu9N62Hus7wwkqln8BjqqVyol5g1HjZ/A7UzPpB66ZpNfTiCCXYn79z1E4i?=
 =?us-ascii?Q?VMPMH2AGB0pHRHD9qnH9iMrLvuS0s7CI7VDDafuUXLJAo+VFmhPlm8TEtzSM?=
 =?us-ascii?Q?Yz+FRSHMQhljNQ6vOLBR3dWuQn3YJ+3RwnUvAy2mx8Mh+5AHeddy4toWW1la?=
 =?us-ascii?Q?l6u74RGt96m6Oxlckm0E1ttuuvxB03mDXxC+S4e9VWkadm+r+RsF6yZDRpmk?=
 =?us-ascii?Q?bDByLf87ryjbjyV2eJ+nguGpSSeDKEs7X/TC2DN8/0Ghp3Z/Bl1as3FVLQPY?=
 =?us-ascii?Q?x2BQ3hCnXz3Olk0DS9UltiXQvr14KPLn/JWa9ghfXB1oGJlv166yF4iHALzg?=
 =?us-ascii?Q?JjABupg+hrTo8jJBY5j3olAb5j/XK5awk+/zAUWQgASkukDa8sgn38/UINul?=
 =?us-ascii?Q?fsT5EktM4UX2QVSzQPs645DQ+RWT/xvOdx717+lPO9m/ybfLpFeSYseCaGVe?=
 =?us-ascii?Q?gZ+67F1D9DZ8bWV/NZOznRhaFFY3c8qd3NQ9rHRpOJQFUDAjIJxmYnc91Ngt?=
 =?us-ascii?Q?z2/XKmxFag9bpGc2QsdXsfvLFYnhAmOMssuoPq2z8kJ3kE7dM2cRG13eZmGo?=
 =?us-ascii?Q?lzWZiekIksjujEIdeGvWH3sbVnu20irSWp2lpmfiGuBnse/igSPWjHJDnfTe?=
 =?us-ascii?Q?Y9oKejfIgC3No9QyhPlR5UJyEvBnkxoocZuCWZa38P/RxdgY1eotEkIJ7ims?=
 =?us-ascii?Q?XnY0U4hJBUtuq4x6BatnS9KEpiT11set7Tfo2lY+KGQRo1jdb+2lcZXc/k79?=
 =?us-ascii?Q?eFarLTwUmgurC/MX2a0I2cVCIsHog4rq3zuV4QolkDZIS/p9ZOLj2UDL1E3L?=
 =?us-ascii?Q?dErNFWu4gor/ZKx9mt5v7pbgM5UNZpH500xQ2gnAUC2zdrNV/fw7u6m4SP/B?=
 =?us-ascii?Q?bgB9wPrP4t1BYWul5CFa93PVGS/klUIgQML3O6Bi91ThLxzvoEHEQ4eZyE3W?=
 =?us-ascii?Q?lAHyDJlwJ0OKNM2KkDdlUS8wNwKjasLZIQ0ey/lzb+urNaYT+gSr3S7C/TEn?=
 =?us-ascii?Q?rUL4VGTroA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e766521-d647-4c30-450e-08de69b3bb53
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:22:59.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuksg5j+yGdnEEq3D5Geid6oONiukjjKsRkmd8CcmXUsXXyuyJacBrGxub/g7wPFu5i9b/VwfnlKF0I3TcPLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20944-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skelley@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C1053127BFB
X-Rspamd-Action: no action

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPUs via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However send_pcc_cmd() and acpi_get_psd_map() still iterate over all
possible CPUs. In acpi_get_psd_map(), encountering an offline CPU
returns -EFAULT, causing cppc_cpufreq initialization to fail.

This breaks systems booted with "nosmt" or "nosmt=force".

Fix by using for_each_online_cpu() in both functions.

Fixes: 80b8286aeec0 ("ACPI / CPPC: support for batching CPPC requests")
Signed-off-by: Sean V Kelley <skelley@nvidia.com>
---

Notes:
    v2: Also fix for_each_possible_cpu() in send_pcc_cmd() (Rafael)

 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a09bdabaa804..0e6ffb188fe7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 end:
 	if (cmd == CMD_WRITE) {
 		if (unlikely(ret)) {
-			for_each_possible_cpu(i) {
+			for_each_online_cpu(i) {
 				struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
 
 				if (!desc)
@@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
 		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
-	for_each_possible_cpu(i) {
+	for_each_online_cpu(i) {
 		if (i == cpu)
 			continue;
 
-- 
2.43.0


