Return-Path: <linux-acpi+bounces-21504-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC6qAEUuq2n6aQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21504-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:43:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990B2272BA
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405CC304EAA8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8D423A7A;
	Fri,  6 Mar 2026 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsFtPdMW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A72372698;
	Fri,  6 Mar 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825981; cv=fail; b=HD1UGjUmDLXUSd/VDJNzBn0DvvVK3HSTxb/VY0Q7cmPCGyxa9/tb+48txjRztM4qI5AZusaIu/MLlnPshBJEWW6ChGFPX9RmJJM0ccAOsHoF/OW/K3dLMt6Kx23g9BnFcOWA0Zm6/EIyNjljFgdNV54YeB8xvofW1ME8LVmgURI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825981; c=relaxed/simple;
	bh=cbvCX3MPBHXS0kYuRrmdLAmSbKQ7Kv+4+OInQWHqmas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG55nkWj0pJmyyqT+xwNDYh0X/0xsqeUS06ElbqFxcM9pkjWX8f16V/aKfKzsNkebwbQEllcpF5HWMcEPtmm93bq4MxPBKIVSAgWUUg5cNUYeP1IGZffgNJlBxlphfToW9AcHbrrkqi+otI5vfzofO7bUMwN6HLDHZZj+al7MYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsFtPdMW; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmlGxg8NDbNbKpoOisEOjPXtoZ50tqtqMOaAwPHUsBtvqgCVSXRy/5q+Mcgf+VBcI/L8LAWo8Ww7h1Tqo2Al4gUO60h8ddjzgzF7jf66fHL7y7YA2wWpV795ErGQgwvlBXoc/FLq2zuu5TGg57bMT8zjE2AilnlmHngDuYLs5cPf7dFNC12Rpcb3vO6sFOpyVLHR2bWxe+ayw2fskN5fltug6RjlQ0U05hK1NB3k/s6W59ky075GRyXs9ZMpHj86+hzkhGaQaaZAl4KrUnmPogbwmCrLJ6N8PxkjfrsCG76G4hUvjzcvYWdkpOPkuJpu2tP5c6A2tAj5yDQJ5BnnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6eXy/hndPDYnIzd3PKHnJ7e/M513SGL5N6TEtGXG/s=;
 b=HJhwoGNHjuAXnYKJMvE++9NoxuJQdr2E9WE6cE+uxiS5gdRZHN1rPXRv4vNLmRrAVQilU+VCYMXp0ZBGGLVubRekLzIbKPlcN0oXxXUySlNLEKlfAQIWHp+4oA6vCdioTlM+C4aPU61bpjswRGRhSTaE1OJE4PG8QY/k8EKvp+/AsSbQprs4WKQbvA1TPMw9L7AX+4l4tBBl5fexJYUzljcObRZjdPZ0PAf99z9eBrqUUg+z9tLKxF8RdL/v/oM8Atgi5wvrd60MYcV3j3t5u8byIYf0BFml4BzDJpVFNDQIwEDfBYzyoui+k2/zDvT5t9sgxuvJzReFpPE8qwkzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6eXy/hndPDYnIzd3PKHnJ7e/M513SGL5N6TEtGXG/s=;
 b=QsFtPdMW+zZG/hlF6nMxjMNiH90jOS5zdUS8anRC7U8fo8ItvnpO2i9jxk6jS2LNKGhzfR7If7Zf18g7jnAee1XhBzgDzatXRctqk+Kd1ioAZu0JgGEu6GTXen4UThhqiN48p8O85FjyEFyVa/wD+Sv21MLzm45yueNYPfcUYc3PAJ3EftdI5dcvvh0EJJOeT70o4FqsilqWcUsXlqgtVe2c+4I26Pl8IfZJhp1Lazb5Vj1wgPD+izL25pzQqo87YuPLSgVYjSSgx4+CAIuxeRFxUQrES3CvXtzYtAHA+x87G32kRqF2zYgmEd2TGNYdmg97BoKwkFiVFLH+1HtGOQ==
Received: from PH8PR02CA0037.namprd02.prod.outlook.com (2603:10b6:510:2da::35)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 19:39:36 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:2da:cafe::53) by PH8PR02CA0037.outlook.office365.com
 (2603:10b6:510:2da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 19:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Fri, 6 Mar 2026 19:39:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 11:39:12 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 11:39:12 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 11:39:11 -0800
Date: Fri, 6 Mar 2026 11:39:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<praan@google.com>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<smostafa@google.com>, <Alexander.Grest@microsoft.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aastXbRlJ+SNdush@Asurada-Nvidia>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
 <aaspAx9NiXmtRg11@Asurada-Nvidia>
 <20260306192211.GK1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306192211.GK1651202@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 8157cb26-a924-46bc-b69a-08de7bb818a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	91ie2tFjYUNTnyuwM9YRO9UogG+8HQarO00kO/bHjXYIU6/ZUXzGIRlztlb7S+oOkmi6OQIRcgYy9h3uu3i+RIyHHQG8EJEFP01AQi8CfM7kfNTZt3u5Gw/xgkUTJUY4rctfAC0sWYF50RWVaZupoXB6Z6sALguRasrUkhGSs7gsuIUEo+9ahiTo2JrHwjrpvanQLpJYlkzB8L+Y8VJ9WAWglNZxKB9iWRglR/yIP0HkmqHn96V6U0ssZv3BSn3iTrU1jeGNsjl0Duak6Gdv8cvATiakVEPTgy+hRg8WQjt0aKoVkekslQD1QSHGYbc8AjIeUbcKgkGjU1uiUKmWBQAzeuIbOxtW+qvfYav3x+Hc66fTIDWNSprnrz7YIXFSaaH+Kry/fjQXAcaYyqYVuji/pRy2F3Y2WyM7kEZh0I3CKy8C4/DZTSC9CaHO3VwziTLdmVc9MRURwqFW/M6uAEiXOw8gvk7akJ3gDd6VL+5Pk0rbU51klAVI4lH2mJEnM+1sFBKUhvH0ZSGWvgKuh0SqkfecU0PuACZVSm5zr1JjhwQj0rtQ7Cx989unZ7Df8ST+utMgu/lyihqXw4mUTr51hKm3pTXMchAVXT6JqVDfJp1CDVwlgemAQAo3nLqx+MyFSS1TcgVmfyj02cTBrhuM20gnVq5jUJH2rObLmjdsqP2dz8pmMM9+B5X9I5zf7/bEY0fi9FppyRZaEiGyEy98QrmwnxlDh7ArCxYar2qNDW9U2u4uo1ljgajI2QGzmWSowGxGmsZdRgWsI4kV+g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ebmwti4MccIF0avEtdMzqD7QNbeRQoXj+8JOSU/Wl9dnmioHh8BF/RxXhVxxadfbc0cYHrl5ovKtQ5W+8QBLk/tw9pjywnjbIfkR+K1wtyM0Xh+qvDpSfu/i9gy6WW4QvbFNNojmuf/aRW6Vimo5PpipvsoDAEF6HAoCRkIqblA2yYPha8OtThbx0PpxRtcYF3U84MNpqMLkvIzd90ypHyLtbIeuPYbs3cvbHQXVzyKA3usqDcpANTOaF9CgAWnDMSGQ1Oi/fT2chVDl4tpWfxaqZyewsz1aj8kHCLuYDN9+sbdfgq+YOrpmpmJ1S7dZ1z51Iu/3lsFgJyRhRmYKYOSHNAgjPQTLUtEoyd7sJRVNkf65euH7rmm6TrIueta0rjG+KbWN2yHlB5o2dHb+4YZ+qhVOORWC+vUJKp5qFa0D5R6i2Q26XC9zp8ze8Sz0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 19:39:34.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8157cb26-a924-46bc-b69a-08de7bb818a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
X-Rspamd-Queue-Id: 4990B2272BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21504-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.962];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:22:11PM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2026 at 11:20:35AM -0800, Nicolin Chen wrote:
> 
> > In general, the maximum users count of an INV_TYPE_ATS would be 1.
> > So, an unref() would be sufficient to mute it, though it'd require
> > the unref() API to support a mismatched users counter, because the
> > PCI reset in the WQ would block ATS, which would try to unref the
> > removed command once again.
> 
> INV_TYPE_ATS_DISABLED could be made to work too..

Overriding the type.. hmm, that's brilliant.

Rechecking the unref API, I realized that even the "users" in the
latest version isn't atomic anymore. I recall that we are fine to
do READ_ONCE/WRITE_ONCE on an int type because invalidation array
is serialized by the asid mutex, which wouldn't work either in an
ISR or just in the arm_smmu_master/domain_atc_inv()?

Thanks
Nicolin

