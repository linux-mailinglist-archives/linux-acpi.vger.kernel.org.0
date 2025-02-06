Return-Path: <linux-acpi+bounces-10920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A268A2B4C7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 23:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88906168068
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9881922FF36;
	Thu,  6 Feb 2025 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="S6XDyxo/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021075.outbound.protection.outlook.com [52.101.62.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E922FF2B;
	Thu,  6 Feb 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879723; cv=fail; b=iFlKiJP8NsRmO8GmNTAqkhlLODhtqqpQ8FEbVWGnIJtHrMnKC8hIoNS1C6OXORh/LKMydWMpiW3qPeyWB2CQ5/VCRdz8mSNZFrqzcCamVh3ystdcPZmnuooAuFr1838DJMwARe/FsVV5ID2cxdqootViVBo1BypNEGlIcy2x6hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879723; c=relaxed/simple;
	bh=SduShIU+SBcNgT3CsJ6yKorVU5883+JpyqucsiGQ7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ecz55LYUnGex6bCpl/zDi/9/oAdHIaZ4poGo3vQVPBnEWMJg8OW3BxJ911QWnyEByjziE+swqvDdVUJEyaPgAjk82pkrNRmEgS50ljnPuQEdCiJU8nDAYvgBFoFzQmggIYTVMyCmOhzRWsB+abAqSZwBzeHidZouBukrQIsD7Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=S6XDyxo/; arc=fail smtp.client-ip=52.101.62.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EekPfTSdPzX/oBDuRfLFrOBIbL1NKbCZF9zCNf2y6xR57mf8ivxqcZBvf5hHapc0H7RySKjySPcIdakjibOpcWAzvILzw8ysYNK/gsGtHFJ3QrmVfrXfbVfstnN7hzRA7+qL2pBcdK8AEZND9/iF4MqD29cd7LDT1I95BGeWeRvSUjrrj+iJP+9TPMuMkVcnq9EiOLx2auiFxhj9YGV825DBSFnw32T3Jo/JnFO8sIGHbyRx778k1EXw8yOePMXOeD9dBWfb3Kv5B86sCHVClpNgOq5T83HtCNH6L0bwbyuN6mlwy+t08JrHf0b/ka5ieYFZ6d8uA8U8Sb3bBmup7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbe7cFwJNnJs9otUXUkwFO5iabaI/HbtmEoAJFJ6Ro8=;
 b=CEQaLYV3V7GIWcxz56dsLEJSw93oUhL8o0gy3sfruxqpVRyNo2bEsZx4BT9eaB7SrhYrUObN4HpY9Wg0qXowwT7Ii2tIfqxfr2w1xblDiPgPMK73O/TXPTpufnQ1dShI7fW+YkkCznUO1UcIRRDjnBD+zy0uOnU+TmnOsnNY7DnUpoK+V2mVoMrfmd/3MOEoOHQ3VJ7z1DcQwkPDHjWtaJG/fhGi5QhQsqvHNupdPE3rY6XA/Vfy/fj4M6nBRa4M5k3/qDHpo2zcsCoBncWpINKaPJpYUoiXvVuO8DKtP+xBo0dRhLEieqwuIHw+wzw7xL4Ehtpkkz1RBk3pVFq3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbe7cFwJNnJs9otUXUkwFO5iabaI/HbtmEoAJFJ6Ro8=;
 b=S6XDyxo/IfvLGcSWHMR7AqO0ZBlGz0qxdyJWa3vG5E1mW9zno4BKj2SJvWXRqRUIx11ptlmKVk/QL4ZvXb5/ba1ozv6t8PDxmBlAr4w5FazIrunG7JpwcbNDl1idDY4azKmwAk6hykrT0mDJMFbbs525v0NoLbn1A7koZyA3RtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ0PR01MB7510.prod.exchangelabs.com (2603:10b6:a03:3dc::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.8; Thu, 6 Feb 2025 22:08:39 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8422.008; Thu, 6 Feb 2025
 22:08:39 +0000
Date: Thu, 6 Feb 2025 14:08:35 -0800
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
	dan.j.williams@intel.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <Z6Uy4zTPU2YDHRgj@zaid-VirtualBox>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
 <20241205211854.43215-7-zaidal@os.amperecomputing.com>
 <20241224155113.00001d29@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224155113.00001d29@huawei.com>
X-ClientProxiedBy: MW4PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:303:b8::18) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ0PR01MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f17db77-987a-4866-c0e1-08dd46facf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4GjEKmgI29mwI54qmTy5IiJ/43URKcLFMG5tW/KUcbpmiNZ4nu8RM3jSe9PU?=
 =?us-ascii?Q?E+HVFxzAYethsafZyzmCV+Kedi+OP2FqoDMQr+fCRXz8Rrw3lzLiQj9Dc7s/?=
 =?us-ascii?Q?xFhXMUVDPOt+I3TtxW+4feFxgjX4NazL4c+PDz5pmvlkYNbtcSna8VlH/Wzq?=
 =?us-ascii?Q?5Ohf+nKIjG7giVvdko6TJsNnawajXnm0K06/AFSjk3AlpsOlGlthLkMc1T01?=
 =?us-ascii?Q?J0qB9XPPbgHvKYgF1pxXzmHwwcMxrHre7LJCmytzJPE2Q+P/9uBaKJ9PCC/Z?=
 =?us-ascii?Q?0qh+RL1wqsydWew3W6Grdf0pAOoYBN23zFDryL7myErq9l2DPeXykYGTQ6BR?=
 =?us-ascii?Q?TLHsBVyzBK9/8YGZZ0vGZgUSndXnl07A3xHZilwmLWpDL1hFAfo+uVXkUAeX?=
 =?us-ascii?Q?Y6O6GKf7+UhYbtRoXn7p0dkafQUYg/IfL1GgpARTmzKhe6fZ+tbxb6QAZ27+?=
 =?us-ascii?Q?G9qlBBHjNrgaWNvzJzq+J4f+wnklG0l+wDTN5A71z5txjZYgTiWtbbdn8OBN?=
 =?us-ascii?Q?aS2F6nCdeB8DUzP3N2FpEnEi6KaBaQVmwjAi+e+73A2dqECCKDXyPDGs5+q9?=
 =?us-ascii?Q?tCzNOvOnYOjAZcdfdGPh+6ndnR1x7ImxS3j6F1+pSotX14g3BOhb3ueBpMJv?=
 =?us-ascii?Q?FZqni6pb8WJjqnIzlQiEpWT5hXqiqY8ER92JiAKfZaasnDSi44J8EYog/jax?=
 =?us-ascii?Q?FWa9xBHyc81Ni3iN/gW6ujlr6w/ujd99TWrZYCJQz3uNyGxgF06N+eLcmb1t?=
 =?us-ascii?Q?WzNNFT9yrSSjpxcGylvKOx0AE4MY+h+wGM8EtOSi3LU493IgF0YImbLpdQRW?=
 =?us-ascii?Q?FPGyeC3qCge/owclXGEEmL1x7CBOZxSPUZdFrT0CaNrmLaRYlqbIhIetyzpl?=
 =?us-ascii?Q?QwzHIU1A6JCMxwU+Qr0Q3o/c0QU5khiw3DzgmfSVZWbTerOX/3kd2Ly1haqf?=
 =?us-ascii?Q?k99igTVtC8sAXiEpZdRQUTuxIl8hREFYjKMh6zLm1cwCNUpcrvIe5l2bAkWN?=
 =?us-ascii?Q?32W7Et9T1G0yvrbw7PwQLtMgbmVW1UdTO6z8oUT6aX6fowrfitIdsfNrQnYF?=
 =?us-ascii?Q?0HYXj+99EkBh6j42cnRyT4dOAYTEd0Sk2XFuY7AMM/QBQAJtxJndO4uKYsQT?=
 =?us-ascii?Q?zS0rAtyuOH0u2eqxxkH23ZQsmArbLF+MLonYQAmqiyD7+43mAJz9NzBGxxdz?=
 =?us-ascii?Q?ECkgygtnQd5vrjgsj4mPaT+jwrORIA2DXhyq2AkRADT7d5UjV77fxaBIfXsA?=
 =?us-ascii?Q?4An2IbEDXAN+AUN9LOSdhvxjrc+kllFD7jYaOGH9BfmZFlOlU4VwS1OX7s75?=
 =?us-ascii?Q?w4TZjW2oq6fZNIpK80QaNK7Eifc2WRFh73wTbJA525vSVIno/FL/WF3rYPRp?=
 =?us-ascii?Q?bClFAuBRu6OAWa78nXTnBEWt7FCkN/emfjeV5xdkA2F0B8+HULBFurj2gNdr?=
 =?us-ascii?Q?QbF0sILi72whuTFoW9iusaqFKe55NEzh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4N2QYsW7s0KL9vWDSPPShl67SxQOnwHektDusJwopUaWSB5H121sezuXLa5d?=
 =?us-ascii?Q?25zxM9tcpOTgA+PAb/l5G1zy+qhWo4l2l8nt2t/1sInyB/tQxVZGblNVGs8E?=
 =?us-ascii?Q?CcLHai8qMsFkZT/PnDORscDlCMhkeGeESyXIhOM5IDGc/tLDpTgFYHJcJuox?=
 =?us-ascii?Q?0ciZCbh6Z1udf3TNZSaOnfd2Af5Dj5f3saj2N3bUsf+zApuDBp00lAa23qMr?=
 =?us-ascii?Q?CVda/NosAVS2TZP2nngDQ6vvsASdYNxmZYxWQNBVGaWiW+PMwKuDp2yI5jLd?=
 =?us-ascii?Q?vEAp3mjT134xe9HAeqbn5Ng8qKee1HKj2I2P/s02F/CnogsfhSnPjuEaMaaa?=
 =?us-ascii?Q?8qElV/XyWJnKN6Jp/fJUyiN3fVoV7Pr0gFta5+AdTKr0iACpsH0Pl0wKEU95?=
 =?us-ascii?Q?Pr3hVtZakzxp/HoVG9124ZlZRNKLFbuXTt8fykjHVI8JhNcD15nkuUtdOqlw?=
 =?us-ascii?Q?dQv6CYVA2iH5ySrpICN9igNFzcT1JqlvCa6LPDggFuNJsGCGrvbkxmWE2P/4?=
 =?us-ascii?Q?OdXO3m0FghhaKMjIyDnpVMRIAL7Ky8MPCyx/z2JDtdlBsqi636NTTgNo3ArK?=
 =?us-ascii?Q?lHxm5OdBt1SwvJLef5QhOTGjpCerAhRDFNgVfEPlx9PsnyDAWyBQLX7luXvj?=
 =?us-ascii?Q?rVisCM/yMssMgUN9NTQCJ4fNhhyd9lD2umvIIhvRusq59lviGbDEaa/YTIvZ?=
 =?us-ascii?Q?/7ooXiYtR6NlI3hKInr+Fkno1t2n2TkMgUXdpywPyPJN/unkjV0s+GAARSVD?=
 =?us-ascii?Q?HmwmtqR092i7iMNN0WWxQwx6weQnaEGzmNg3WTJbQ9FGYOvzDMf8gM2lORFr?=
 =?us-ascii?Q?qW9JW1qbcVFc9DC4eLyCEVoXKOAIfeiraTZmQLle1qna2AeH5pQp7fXPVIbB?=
 =?us-ascii?Q?1vQIHsvEzTmkiPvBo8hm0IrA5lp4+PMHyom/QznALBaeoNTTXh+QCDOWtRJZ?=
 =?us-ascii?Q?Hk/Zh+Ci3rNdW9tiQwt5fTC3ee6Iq0ucxs1Z0F2qz1uvmD6zCuG9jxw9eHR+?=
 =?us-ascii?Q?Z82zvyn0ysxJ36rqqAQyVdMszyIBiOgHDYsU/MvKyU9IkoQCwkP3pCBQqg+Y?=
 =?us-ascii?Q?+Rm/+bv+nrDIj4kzX82pvjvgfbyyyPgG35zZxU1RGJUYNl8xsROW1M8fuftC?=
 =?us-ascii?Q?7DVufxyzXGsNYyGKlILpfuqYCD2GmvXcU7P7oStS0XE0+Rpvo7c4rnlrr06+?=
 =?us-ascii?Q?+G9UrpKobmy0DD3xr1w5IneRJuKtlv1PA34nUIKE957hPc2b5AEoaZ+s0anz?=
 =?us-ascii?Q?rWH92G3cJ2Cx42ZIBF9In94n5LT7msQ5ictylQ2xBzelKgF9AHv/eyFc7CPd?=
 =?us-ascii?Q?YpNlWpwdSwmlPQQ7FllwZMgJ2IjJAUfkxKZ7QIvSA1EqJml+w/ghVufd8vvw?=
 =?us-ascii?Q?us824uCFn0otxmGxtVQu1J2xj9FhR2gnZgSZmZRRS+8cTUhSPDG/kvvSqArk?=
 =?us-ascii?Q?7BPlqnoyK9vJkigIyBnntCV8vtBMYvWWG5KgwmNDTqRmDOHNzqGYYd/0cF1R?=
 =?us-ascii?Q?MGP4ZTbr1U4xgPdTBdHWx8L9zcK3Oe30nZg2tO8rv4qjcMWXMtU40yWpm75h?=
 =?us-ascii?Q?qts6QqGBnzllcOIhUpK2tSQwaqkEEfmGRyOh1CoGy2VjFYu1JOJp1oWuGOcq?=
 =?us-ascii?Q?jG8YeUrbjSMmZo+HwB5MY98=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f17db77-987a-4866-c0e1-08dd46facf36
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 22:08:39.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JjbnLgMbEU2R5J9JLzzua2f4zMfZFpl3HKCfptPmE07GseZxw1adHBtCG3rqziUpsEzRNyDphBghIpFCm8aD9vIABK6K/4uwvGD35Qp5XA4YcgIqHRONg7FTPxd6RcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7510

On Tue, Dec 24, 2024 at 03:51:13PM +0000, Jonathan Cameron wrote:
> On Thu,  5 Dec 2024 13:18:51 -0800
> Zaid Alali <zaidal@os.amperecomputing.com> wrote:
> 
> > Add einjv2 extension struct and EINJv2 error types to prepare
> > the driver for EINJv2 support. ACPI specifications(1) enables
> 
> Reference got lost? 
>
I will fix this.
 
> > EINJv2 by extending set_error_type_with_address struct.
> > 
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> > ---
> >  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index 2c57e25252ac..039d36472342 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> 
> > +struct einjv2_extension_struct {
> > +	u32 length;
> > +	u16 revision;
> > +	u16 component_arr_count;
> > +	struct syndrome_array component_arr[];
> 
> __counted_by marking seems appropriate here.

I understand __counted_by may seem appropriate here, however, component_arr_count
is a value set be the user and does not represent syndrome_array size.
The size of syndrome_array will be calculated in Patch 8/9.

> 
> > +};
> > +
> >  struct set_error_type_with_address {
> >  	u32	type;
> >  	u32	vendor_extension;
> > @@ -58,6 +80,7 @@ struct set_error_type_with_address {
> >  	u64	memory_address;
> >  	u64	memory_address_range;
> >  	u32	pcie_sbdf;
> > +	struct	einjv2_extension_struct einjv2_struct;
> >  };
> >  enum {
> >  	SETWA_FLAGS_APICID = 1,
> 

