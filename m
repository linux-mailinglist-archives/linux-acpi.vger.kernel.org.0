Return-Path: <linux-acpi+bounces-21511-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLFjFYM3q2mkbAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21511-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:22:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FC227753
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D96A300B18F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE4450902;
	Fri,  6 Mar 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqT4UeHE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD031B830;
	Fri,  6 Mar 2026 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828543; cv=fail; b=lhkKrot6bU4jDtry0QKuLVpRQtrk/KJzrKWtTBcDeFeLTV8UMPhj8z0yHQcyegGkQwQNVSC/UBU/dhZfAJr0Q6FntiVC7QhYzI1lmeK7rX7ADLRZZTJkTu6BzRU1FKrihpO1+Tw41cMH8w7daos4s8P6X3dcibOO0wsNdr1qP40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828543; c=relaxed/simple;
	bh=VeFfXwb8T8R4F7TZYTs0/D+ioU1n6QDhzRq2dm5Zqfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n59cPGiGMD9wY5hHmz2gyBRJ8ffzPLzDe1OyPjKlkJWFkcU+HGLoCpuaNI75xmcPeKvrIVad95p3LjTq3W1gNAFWDgKkCoOgJ6/r7Dcb2bOvtsuzOeXpvzJD68NxsYswQg9hy/hQ2iiKRLROVTiL6HjowPDaFW49BWWYvpf7c20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqT4UeHE; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uif5egebiP066UmWe2BrEABFlNmsOyAoUPW5L3oi7qQDhbsaA/eGZP87kxhyMVs1XcDgqQx6vGqhyBYEnH+SG5fTp4+f5yu01P4ro+9ixBzlkH2C2hA2f3B4cU6aCoHw6+zleg/cdp4CAV1acprdwIqWgO2qctEotBK0Xl5kqR8uuYD+FLSFzM5ig7oERabxcBP7g+csGdBSfGz8iz746WWOkMVfapeAGUO+v6WVAYKsxLouDnQZEeiL4IKVT+MlrztT3jwrn9rV4Mt+EMqFyb/a64wOvX7lY+ljWX683QqMn1ctTPvny9rYvICQcvljgBM1mh+ubu7PXUbVy1jJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeFfXwb8T8R4F7TZYTs0/D+ioU1n6QDhzRq2dm5Zqfk=;
 b=mHTrG/oZ4UmZASo8VpyXTVomfCTVXADKs0/37SpwgobP/GviuGG3U3SVDrQ/CXutr2aa0d5kmcOG0BmEXjLwjiiNUre7Tf7fnRcB/Cj/gCtdPMmLfbQoNtqLQksDvm74owwY2+43XBniZZP6mG9MntknBzQ6MHfoLs9JRhGgL7lk5MIFfpOsfmL86ikOEMTC7KaUIVGpLoS+9h0jey2XFfzCjh5yuit/R5TTEBfcMiDMt8Op5n0kTv9cHISm91tKYH0/qdUuBCqADvW7XZ8Ug2WifKgZykf8nEgb3sNfWAQS7cp8L8pgE53kmrcPRNCjVRda8MAfJ7X+qI8qYV1p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeFfXwb8T8R4F7TZYTs0/D+ioU1n6QDhzRq2dm5Zqfk=;
 b=mqT4UeHEKT8lOWLXJnhbWcrjyFTZAq9sJGDBykm6hA81mew4/f0uKSE2pg0DF3k4rOlc1q02NY5fiAth03iTJuqbKf7bBexK2RgteUXmlY8kU//qZf9EPbTTKb7vk4WkggbnWVb9VtMHILCUWHVM6r6EloeForX8VX7Z5yAOkr37NN+ahJvkvWFdEaZLU4B3Z4+P/UEoEnuJEK5KDPw0gkYM3/XXcGKPLGNknj7ko+/LyzK9W9O6NId62v4NirMII85exX3xYPGFWwBGMHjBtgLmFIWXS2i1u1YG+JP/tYZA+D9Nq/a/+XYEmLFo9Iew4uBj0GgEtc7FQbGlWpsRpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 20:22:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 20:22:17 +0000
Date: Fri, 6 Mar 2026 16:22:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260306202216.GO1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <60d77adc-d5a6-40e2-a497-a57004f23e7e@arm.com>
 <20260306140115.GH1651202@nvidia.com>
 <aas2kHcjJPYFbKSD@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aas2kHcjJPYFbKSD@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 2959da3c-aae8-46a0-66f6-08de7bbe0f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	HLkmSbLw8D6QH/YH05VsgQTFrBCWK+XakP5kfqms7AZ6900GQY2MboVaInsvT/YLRlBP0/Qb3gBJ0zSg3nDCAl1TWOCWKGmjN6U1AwcCR6zjFpMpIbVU6zYvWWKznLj6eORVJS9dYeR7C0cgLbeXaHee7NJXlwXiKnpRdee7Kcf8uE9q69K8wKkCn0qoZjelPB/HeAzg9Egu7pQO3pw+AzILHlvBdKAOM2LN8RaEP1MSwIJ0PN5zAR8vBrBBiVqaD69++fwvUP9CLxul4XNVD4EyXTyYMTGJSrWPqKa6NSOxIeUN726LNwpYLM1ZDOGRVCm9QTuvFNYYW9dBWkWIUlFBL3m43zfwxgV3Fn6I8pOi4nvVrT5lkxdWqhW8grXNWIyZy7zF9zIAbaiWfN2mtYb0R/LJQvhdONi0Voigyw+c1ZSkTlWKOaqC2HgfHNU9vKZceTGXtnRGJ7xZ3OcQZH4RucNG+2tp4JZlOuFbPIt2ZU9/3TGDS4H2yNXTDorU6lc9J5uxGBK2RBEs3aTh8437VHS5NPZ3P5l3R+qnY0s2wE4FkXDFn9k3eDwoeonYnlRGnXU7TXEghaWyvL0I/uCnvFg2DuSgny/1hc5ouPddAqkZJrfj8jubhYTqUFQbQwgOVpQVvgxXXlY75osZDnw8hyV0eKNXeoZBI94eVNZAotiD7xELSWwapGIB6CStAJ2irmIQ81dV75ql4rURNUucItP8uNEsUnDh7P9F1Kg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NR3rQmLd0Lw0cKT/SrZ2VkVe8g1jnFF6IfbruB7o4hRhQmHeulxS9wg4KqV8?=
 =?us-ascii?Q?8TKDntCeZSVq2Ur1fTl0YpsVYbGqgEWKxoXsIEbyhVZsHAa22t2ItXQqCY91?=
 =?us-ascii?Q?n6BHvvl1rSR321synR4DK9W08AvpJkKxWzAA1XmYBWYRWdTgczchKmcuyZrL?=
 =?us-ascii?Q?QSCZ5tUWPzC3rPr64SXX8WdhQuoV7tDs58eLR33bt0Rw4r1MH0CFCazqI8up?=
 =?us-ascii?Q?/UfqszQnSFVyncJ27Ai1AkJbj73gRDJrj+l21wuMGFj2l8uFawrhwnka87ZU?=
 =?us-ascii?Q?7pyoUObpSo2zr6zVnEsDJb6Nhb9kTdMzTBREgYT9PngS2SVIyvW/q+MkXdOS?=
 =?us-ascii?Q?abOkmFpf30NdaOnOmKoeE2CAV+K92/FOOSjPAraUnAtrxqSRd/hdK5mHUJOk?=
 =?us-ascii?Q?U8n+fwgzL3BDXOk1YGCfA7elbPCZd8nc75LjvIv69ta/MazFHfvN0YfRgEUk?=
 =?us-ascii?Q?QdlpqljuojtciQqaKVZ6wgqZal7Yyl1AIw7ttC1dgsQ0OY+r2IKUFHddMdAj?=
 =?us-ascii?Q?WzFkxU900b+lvJuRpegUyHTuSgicDLXEs1/SAHD+ItH4IstM413sonSmdBWu?=
 =?us-ascii?Q?huc62HLqs6aBnzCoKJHmU5YlpioydadLx0ztUSJ9/BW5wm/Elwhty4JEK8l/?=
 =?us-ascii?Q?I+dsIi/mIBiAQfXV2TKM+EBPDuwvYHOANilQ+6uz0INmiW1wHTsBlgatd1c7?=
 =?us-ascii?Q?Wu2zvbQMYDvQlTsFheavC81jhxVwuUOKBco4yU4nRhUeVJMFgOkfja3Wo9wy?=
 =?us-ascii?Q?kz4M6uJB2NMIDi38jnWptzgoy/fUxG19bcrzmq5bhxpkh3Twsbmze6eIMA/C?=
 =?us-ascii?Q?HiaEWxyzfjttqR92k7+9ux4Bd/ww/3TcoHsqNrXKtkE8NHpen+yIy7ehRN4G?=
 =?us-ascii?Q?DvOSdzd+t3lP8MRAjZab8RUc3IdINpQ578vPIpOUr57aQbnvxuU/5gbgbMXT?=
 =?us-ascii?Q?eWTItZ7UJFoF3gAyH3hiuyNZPGJQLn7np0XPzg+HPPxiVjInX7DtaC4Wbac3?=
 =?us-ascii?Q?lMj2r31IdTxPVWpUundNQWq34RSAApb0C3vi/ADMUXnt0Zxjyim5/yU8Hxb4?=
 =?us-ascii?Q?VHp3WPOMeH1hUllX8dghHSXnczCuCPTumfutAxVACMHgrBpy4sgVYcOu4cq+?=
 =?us-ascii?Q?QgCHbIK0XNewS1J2TditqZCJzzcHYKZh0hnZbcaLyZDtSWNbc5LoRHWSFOh5?=
 =?us-ascii?Q?z6NytBYCj7Bok6sCK9cBqivH50TpqJngCv+oDVhz66eSmcc51X9a8nq3Wvgn?=
 =?us-ascii?Q?CmBsJqHkuPYEn5EB5+zHV7TJwhPQycVHXpilRfup4qyb2hOTC4u4Np26IKAP?=
 =?us-ascii?Q?vBPldkgl1lR3oxjooKHWYtZU25kGyBVOAdulWpg39Un2F9SyP65GC3pRhIcV?=
 =?us-ascii?Q?vBeZTV02s+6MCtrm6yoZ57KKiry+Xg72rfgVyuvXVEv4FLIwxqncW8KjR3ze?=
 =?us-ascii?Q?SSxuU7DbUN5QRRsYN5DPyiRuGtD3yVjbUHPjXXg7I62yg3pr9OX7uwoWwOOg?=
 =?us-ascii?Q?JXgPRGoo5a50pURWNK0b1Y5SekfNy5zBP8iYLjL3xrLFeCfGhd3znc4ZLX+n?=
 =?us-ascii?Q?zPp5Pn96Vy5NPGO/by/yXflQxto2ZUFGaIuuzdl7tKoSfrBmsU/Gl2Z58BaY?=
 =?us-ascii?Q?/+nkiNMIN1wxvPC6nokP9qZOnqaFfge37+fS5kX2quGEnbCiUq9oePGxmHCU?=
 =?us-ascii?Q?qp+hNf9qwoDBEJkK26bcYQ5Ez/CTHm5Or6d0Q3RfWtVwfKzfS8MyI8rDY8Uz?=
 =?us-ascii?Q?kosVg9102Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2959da3c-aae8-46a0-66f6-08de7bbe0f88
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 20:22:16.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bLtwSXMwmK3IdisQ1ngw+a6rNXyZ+DIZ2FiBmjuKYPPspYWBMFSL7g1OIfHTo25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-Rspamd-Queue-Id: 171FC227753
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21511-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 12:18:24PM -0800, Nicolin Chen wrote:

> IIUIC, we would have two timeouts to identify the device(s), so we
> wouldn't need to give away the optimization of batching ATCI cmds?

Yes we should not harm success path performance to compensate for a
RAS error case.

> Will letting a faulty device time out once again give it a window
> to corrupt the memory?

No, you are doing this within the flush callback so everything relying
on that flush should remain held.

Jason

