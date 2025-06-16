Return-Path: <linux-acpi+bounces-14397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA800ADB8DD
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 20:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45822188E384
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BA288C36;
	Mon, 16 Jun 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="e8rmeJlB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2124.outbound.protection.outlook.com [40.107.95.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2A1A073F;
	Mon, 16 Jun 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098784; cv=fail; b=BMxFu9bxBIdmQNdEG5P2svcgGqxsJhXa7ZW7jTPpAtqDgIfEyBYwi65b12GUQFrUl8R4IDH0Rc0CN19NJCH1igxjW75CU88caiUx6NF61ZGTyhnKrg3us0jdyIHyPkRsFs8qbvPKYAwFf5ApuJYv+hgVA+avQw8nfRt3KaCH7yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098784; c=relaxed/simple;
	bh=faa+MxKV2g3bW58XEihYO0JKTWlg9sDl+zBI5I/27kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nR2hCRVryXSghY5T6+2n2Qk0XzSffobF1MD548/cttCx4QrXUBOmDXngBOTvFgoB/evocWn3NvhW0oiPWjmFZALlNMogBAAwHnskH43jhCfb0Lf9bUkL8HYVTYx9voqB3Z4HsBa2qj+7EsFxUNonFz8Hc82/LOT+NTfXGTHPu7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=e8rmeJlB; arc=fail smtp.client-ip=40.107.95.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh5hYaWCbzvH7PoSnR4KTqDromkMq7TYbSHDSHYNt/0XFhuFS9exQXOyhpme63AFKy1wyTYsTnTjKoSSrd+qwCSIogXi4YTA5Rvph3tO2lJB6xrciJqoMRJ14Dv9h4Ku0jW7wFV4i1SZezZ2L7zgZrIRpTQvrOufxOWm4DpBLBmuvlfsf0n0dnp3PeKGzigwNaLEbvS5pwdjvEULUvIYh0RYTCIePU+nKhvhh5lcfrIq8ttOzjmIaehqz6BbSV5XxaDMtc9ffpBBSc6aS2nJS4sHrwPFdHKLq/HZbJ0kXoEb+rb9diWykWiL1tofqVsxXnTz0uzGCww/EiQ57XFraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8muxOm06FLRme74Gh/UrkvyjZMXIuasqvA8iJxQW1Ws=;
 b=LToO8Rq1ZH/01ib5sdYu9Gweu/m2E4iqqvFayJfF5mWjfT7sqJy4kMDvKW6kiz8dJKBEv/L3CXBVjxqglL+H7RTFZ8yldWrhS9q59t34kt8vTtlYtzuURdRljenU26SxrsMFwwjR056VPWXu15CWjulxoNogUnBzCn9/LL0YahSmA1BcbnIZ765WbRFjOn2f7aBckS55EDArkLAdWtycu+s5l7OSrbqh5wsLAUBfGtSrefzbJnXZszZfH4i1G3Zjvh+FZfHrGln1VfCta6cxricongEwgJZQsthYbzRBVt+3EPETxeU+d2QvoOwd4JimYDEwwksmX+/zJMKzc/U77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8muxOm06FLRme74Gh/UrkvyjZMXIuasqvA8iJxQW1Ws=;
 b=e8rmeJlBfJibd1UslIbWInSRUF05xjFgvvD8jOmyZYc0GEX84nVH/26vU2KCGpO4+sEqaKDb2B4W87SD9Yuu/o4e7TOPSmbbP+8/iFpaGGSRBFLZMYB0Uuar9pq7r0GpigJ4f3wviv3aJTrCqEAlMLjR68ln03tiIF+iTdxPGYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BL1PR01MB7529.prod.exchangelabs.com (2603:10b6:208:384::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 18:32:56 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 18:32:56 +0000
Date: Mon, 16 Jun 2025 11:32:54 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, kees@kernel.org,
	gustavoars@kernel.org, Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com, jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com, dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk, alison.schofield@intel.com,
	dan.j.williams@intel.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 6/7] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <aFBjVi20EdBT0-Ar@zaid>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-7-zaidal@os.amperecomputing.com>
 <684c61f275a5d_224f6a29411@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684c61f275a5d_224f6a29411@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:303:b8::10) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BL1PR01MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: d00e6420-cb87-49a0-f37b-08ddad043687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qj6BAQYHXQUDqmJ6KmezjIl8x4NeQGT2F6RBocr1xu0PDL7O4J7TTcAA9qWe?=
 =?us-ascii?Q?NIGlDnMHOUfkIkCyGcuZJFwwg7rry+gkrLnFEMU43ubTHo9aFk1GNlhZnQza?=
 =?us-ascii?Q?hQU8jTwxOlI2d1Gqkcv6FjBAJ6skm2CKToNj1eplGdLYutiydeT2L5jW+0qs?=
 =?us-ascii?Q?bMGdLmLHfnPbbHQcMlEEYXsXWO9Lyr+KPYUx/3sy5usX5sbcPHT+ega4EKgP?=
 =?us-ascii?Q?CgjmqQ3T4UXbP/gp0nqykKGKa+VWO1Dd3zD/RxEj0gPX9XNAYwOvDNsmsXMK?=
 =?us-ascii?Q?nU11SBXh3WuNee2SYn3Yt23gwwPTKF7+SzXFmOgkz8Xo9ZboaS4qQuwZvU7L?=
 =?us-ascii?Q?iiC2SV2RypUDVLgu95VTe9LLqfvYbtgfbydVL/Li6uAn46+Hjn88PRGGM7vO?=
 =?us-ascii?Q?TSAHwqJn+t6GNlt/rWqE6ITBrNHmPKBl2lf6RPoQj0IY21Fib3maNCrqNsHp?=
 =?us-ascii?Q?40pau3/JKvLQjZo5b/UkK6WeyVxadYGAybKqtq+zJ85Yu+Z2Df/nO22PqT7k?=
 =?us-ascii?Q?S/Gzx6ls/DYtlVevBziDgLp62ad044bnnUjdZRJp4XWl9TIyPJ4MS+DEO+ZW?=
 =?us-ascii?Q?pnzikHVpM/cLbA4jXdzkFsujFRHiqLDTkjpExt4pmqhAUsHfSOUyw3nURvVx?=
 =?us-ascii?Q?0X1cmQZxnYiojxUiG8YmHz/AwlZIDGkip/2nYoDroZpf7Qbrv4xd/kPrHzts?=
 =?us-ascii?Q?A+ZhHeVTyMnNqJ38+UjNDBYOEy7SQAyBwpUL1uHCl3J2AcmlHY6i1J08stBl?=
 =?us-ascii?Q?DTBI24mwXYostPDqw9nrksYloANr1X7koyjAnxcNNqRc3Ae9V+cLEmBRskUr?=
 =?us-ascii?Q?U5BoKK3gzCtJ+wVKAJhsu12QErun6ZkZyBBwOJjedAYdt9Anfj3XMfiRdmj0?=
 =?us-ascii?Q?UhamqnQoPxkI5ot/oh8g5Y/QRFPz+ZTidbKFbS9c8vmohzF5PEn0j5z0qJwq?=
 =?us-ascii?Q?dYVWrqvcSlfYs0Q7QiUz0U7mecrXwyEAeZb6bCYj/qpi0wSJwQKng6HDxCEV?=
 =?us-ascii?Q?iAK+Vz2N8vI8URIy+WEDdesdby7Uo0J/JURTN3yajHq3xZ6ggv+Q4jsYwoJ3?=
 =?us-ascii?Q?+Hk57RLEDsp25bAA0d2q5vVkMLiZ0ARiupe+gEg/5TIqUy8N8uXe5OUtpruj?=
 =?us-ascii?Q?V2mmir1nBGvh7Gl0raHIc8h7QzORnnD7BsZvAzB29IwbCvUddyc7cVYN9S12?=
 =?us-ascii?Q?P/6DX6NSga0+OBG3hQULmXClsSSauTOocO4z4vRd/effRrwfVAOQYFX1KfDp?=
 =?us-ascii?Q?0UwV5FJ7cRAYBNLOnbOZ6Uk1BKh+fOE+55j+RtW169ozYoYEP0aFZ5YILaER?=
 =?us-ascii?Q?d8FQSP0sMloVjVaSzAWLzWZ00uf46J/mCA8yKBjwk30Tn/Pl8/8IwyQm2udV?=
 =?us-ascii?Q?3Xhr7xCiXjYHSmgvDY+HTge8PYkWM/VMIwwSDUZJHGo5lImOp/m+SY2lY3zi?=
 =?us-ascii?Q?7snfcyiENgS8kx2sK/YfiZxrbsvsbK/B2U819TmRCeWY2LqZlw5gCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coAPf05EXNLJj2j/p0CtnAOR7OHvZ/0b2evaD4Sza2dyr4plwh084udFmC6i?=
 =?us-ascii?Q?o/iuiGs5OcwUIkt2hbegvLcE3+KH5UC84z7OpTHr0KzkpmyVUhWgGSEgCy47?=
 =?us-ascii?Q?kEuVGvOfpyCfLuQc6oFCeauB42DFwtXuB3MFWzwhEagQZafNeusfUnCMW+Iy?=
 =?us-ascii?Q?A3ygm6fhF45hgW97Iju8ggUrONnYx0UWPeckSV+gYLb50HEmVvwE+G7ZiATa?=
 =?us-ascii?Q?8d/fQuSVI40iB2uwMQ39hapbCxyvRVVVkX5pJXcuj54H7Mx2DQkczHEZmiyL?=
 =?us-ascii?Q?7RN+9ES8uQCeUYLejltXEyict+6R0U7kQQH/m1cwulGnW/PSlCG1ldgbCXQK?=
 =?us-ascii?Q?IEo3UdurgbsEX+dO31W+qfkJLZ/h0IIwRaQJ1LcphDACHJ/UMN+IRksv0Sdo?=
 =?us-ascii?Q?tUq5hcit1Wpc1dAAYtWLP4qCUpWJEOArMAv68SDt5T+RmLkfyS6Vv8tFwkkf?=
 =?us-ascii?Q?dtVwDVKXCLAM9zfua43mspSgjckKx7x5cUOXSP/0uCZgCKKV/6mySGaDvkCF?=
 =?us-ascii?Q?20tiBJEUJYSt/qHQS/78zII2Kw2BAw/IjgTet4CmF4uBom7A26yNeHSVvu4o?=
 =?us-ascii?Q?OE//NUwcDx5NvpflpRSpcHk3c8VnVYAj6+MEDDYThZlVljaygrDUJhO+v0Na?=
 =?us-ascii?Q?a1s/VTAywzZqAf6D6/UjUWIkx5bKhrVy1WovfWQ1nfmMjKINPTExdeDKOzBO?=
 =?us-ascii?Q?4ayqTVy2PvJtChs+DjbQ8RFrZIhDZGYRKU/RMnGqCW1X64ccY1EYav/oZfXH?=
 =?us-ascii?Q?m72+p6MmE2VG6exLn4xnOKBOD8TuHD+Ashi+5JVKgZxMwxGlm4Ma8cdqXxIb?=
 =?us-ascii?Q?VwoO6o2pseXk7jwEAFjBjeghW1ZHq48PzCpbmzQ998wGq+kDeuLLozUn9PHF?=
 =?us-ascii?Q?3JjVrIUNrebdzQ839YXOwkC7nDZjYQUd/ZgYscXBf9b6QY1+4TtcU5aIAZY6?=
 =?us-ascii?Q?QFwEOp3tDqsZzlS8d0SiJBnTr7iVohUvWhf7yntUU8uLZkppuc8MiE3mpXvA?=
 =?us-ascii?Q?MRCkg+DVX2tpSdlLQ6it1FS6l0S2kdSbF2UA3yM3Dqfkbu9NVQEA7fGnb2JT?=
 =?us-ascii?Q?p7QGDs5P5Zg/H1dLT6eApHFPU/z5QGJqU6qwvVvUJF4nKBzanwj9BYmsYIzW?=
 =?us-ascii?Q?czD0DFQOO67KY/dj+92scfUnsK0vr9QVqLXQGYaW9pCEV+YhQ3nxW3WFnfrB?=
 =?us-ascii?Q?DQEGS66dKe+fJPUK2FCpSsxG2nJgXRzTAWeIi/UTtb9GOgS6SLAJbFhEnCuV?=
 =?us-ascii?Q?n9poVIcrreZdvRudzvZc8wkZosGRvU8SeMjW6FFIGXbV51n9GQ1VgGmyHE5x?=
 =?us-ascii?Q?CEKJtjFnZURNctx62Wg8jbPanIoRiAfWooClZkXO3J8JcEizNYofH8uIGE7j?=
 =?us-ascii?Q?LtEo2KVs2k76+OLnYFayZKUAItP3/mcyW9mrFAxofGVT9TowgVLZFvChPpoZ?=
 =?us-ascii?Q?HP3dlyLrYzvP5LwPgItcUb7CVJQq1sGC6H+s5Ijd7bKeR3L8L6N9NcYeYYWj?=
 =?us-ascii?Q?ZLzaVUmyJUkm/OxeWgLMuDNu2dVa8WgsuKSXCGlBMYA50tXeWIQFtr6QKzme?=
 =?us-ascii?Q?jn3G+6gCIi/JPTFDhHfrBaNB54ftrY/IBYFVcbOJ7YQDhXtPH8vLN+Igy5CO?=
 =?us-ascii?Q?Tb814EcQU6kt/xprBqczY5k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00e6420-cb87-49a0-f37b-08ddad043687
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:32:56.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R91zBURLOCcVxqVpn0OShXQhgTdPLizsN33wZ+j/NdT08KDyLC/fkbwtB7Qh6LFXiLk0jQvca/EDuqN6k61k0gJUJK3/Tx0Jc0AHsz6Bnm9kYwx9yXZeHWroma+3gppD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7529

On Fri, Jun 13, 2025 at 12:37:54PM -0500, Ira Weiny wrote:
> Zaid Alali wrote:
> > Enable injection using EINJv2 mode of operation.
> > 
> > [Tony: Mostly Zaid's original code. I just changed how the error ID
> > and syndrome bits are implemented. Also swapped out some camelcase
> > variable names]
> > 
> > Co-developed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> > ---
> >  drivers/acpi/apei/einj-core.c | 56 ++++++++++++++++++++++++++++-------
> >  1 file changed, 45 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index 8d60e5f1785c..7741c2082f33 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -87,6 +87,7 @@ enum {
> >  	SETWA_FLAGS_APICID = 1,
> >  	SETWA_FLAGS_MEM = 2,
> >  	SETWA_FLAGS_PCIE_SBDF = 4,
> > +	SETWA_FLAGS_EINJV2 = 8,
> >  };
> >  
> >  /*
> > @@ -181,6 +182,7 @@ bool einj_initialized __ro_after_init;
> >  
> >  static void __iomem *einj_param;
> >  static u32 v5param_size;
> > +static bool is_v2;
> >  
> >  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
> >  {
> > @@ -507,12 +509,20 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> >  	return rc;
> >  }
> >  
> > +static bool is_end_of_list(u8 *val)
> > +{
> > +	for (int i = 0; i < COMPONENT_LEN; ++i) {
> 
> Back in patch 3/7 these are defined using a hard coded value.
> 
> I think it might be better to at least use COMPONENT_LEN for those
> definitions.

Thats a good idea! I will update this in the next revision.

> 
> I'm also wondering if it would be better to have some type safety here...
> but probably fine.
> 
> > +		if (val[i] != 0xFF)
> > +			return false;
> > +	}
> > +	return true;
> 
> I'm unclear of the way this list is terminated.  The cover letter does not
> mention it.  I read the documentation patch and it looks like you echo ''
> to the id to terminate.  How does that work here?
> 
> From the documentation patch.
> 
>   # echo '' > component_id2			# Mark id2 invalid to terminate list
> 
> 

As shown in ptach 7/7 "Writing just a newline to any of these files  sets
an invalid (all-ones) value."

> > +}
> >  static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  			       u64 param3, u64 param4)
> >  {
> >  	struct apei_exec_context ctx;
> >  	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
> > -	int rc;
> > +	int i, rc;
> >  
> >  	einj_exec_ctx_init(&ctx);
> >  
> > @@ -521,10 +531,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  		return rc;
> >  	apei_exec_ctx_set_input(&ctx, type);
> >  	if (acpi5) {
> > -		struct set_error_type_with_address *v5param, v5_struct;
> > +		struct set_error_type_with_address *v5param;
> >  
> > -		v5param = &v5_struct;
> > -		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
> > +		v5param = kmalloc(v5param_size, GFP_KERNEL);
> > +		memcpy_fromio(v5param, einj_param, v5param_size);
> >  		v5param->type = type;
> >  		if (type & ACPI5_VENDOR_BIT) {
> >  			switch (vendor_flags) {
> > @@ -544,8 +554,21 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  			v5param->flags = flags;
> >  			v5param->memory_address = param1;
> >  			v5param->memory_address_range = param2;
> > -			v5param->apicid = param3;
> > -			v5param->pcie_sbdf = param4;
> > +
> > +			if (is_v2) {
> > +				for (i = 0; i < max_nr_components; i++) {
> > +					if (is_end_of_list(syndrome_data[i].comp_id.acpi_id))
> > +						break;
> > +					v5param->einjv2_struct.component_arr[i].comp_id =
> > +						syndrome_data[i].comp_id;
> > +					v5param->einjv2_struct.component_arr[i].comp_synd =
> > +						syndrome_data[i].comp_synd;
> > +				}
> > +				v5param->einjv2_struct.component_arr_count = i;
> > +			} else {
> > +				v5param->apicid = param3;
> > +				v5param->pcie_sbdf = param4;
> > +			}
> >  		} else {
> >  			switch (type) {
> >  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> > @@ -569,7 +592,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  				break;
> >  			}
> >  		}
> > -		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> > +		memcpy_toio(einj_param, v5param, v5param_size);
> > +		kfree(v5param);
> >  	} else {
> >  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
> >  		if (rc)
> > @@ -631,10 +655,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> >  	u64 base_addr, size;
> >  
> >  	/* If user manually set "flags", make sure it is legal */
> > -	if (flags && (flags &
> > -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> > +	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
> > +		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
> >  		return -EINVAL;
> >  
> > +	/* check if type is a valid EINJv2 error type */
> > +	if (is_v2) {
> > +		if (!(type & available_error_type_v2))
> > +			return -EINVAL;
> > +	}
> >  	/*
> >  	 * We need extra sanity checks for memory errors.
> >  	 * Other types leap directly to injection.
> > @@ -743,7 +772,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
> >  		if (available_error_type & einj_error_type_string[pos].mask)
> >  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
> >  				   einj_error_type_string[pos].str);
> > -	if (available_error_type & ACPI65_EINJV2_SUPP) {
> > +	if ((available_error_type & ACPI65_EINJV2_SUPP) && einj_v2_enabled) {
> >  		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
> >  			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
> >  				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> > @@ -785,7 +814,7 @@ int einj_validate_error_type(u64 type)
> >  	if (tval & (tval - 1))
> >  		return -EINVAL;
> >  	if (!vendor)
> > -		if (!(type & available_error_type))
> > +		if (!(type & (available_error_type | available_error_type_v2)))
> >  			return -EINVAL;
> >  
> >  	return 0;
> > @@ -804,9 +833,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
> >  	if (strncmp(einj_buf, "V2_", 3) == 0) {
> >  		if (!sscanf(einj_buf, "V2_%llx", &val))
> >  			return -EINVAL;
> > +		is_v2 = true;
> >  	} else {
> >  		if (!sscanf(einj_buf, "%llx", &val))
> >  			return -EINVAL;
> > +		is_v2 = false;
> >  	}
> >  
> >  	rc = einj_validate_error_type(val);
> > @@ -828,6 +859,9 @@ static int error_inject_set(void *data, u64 val)
> >  	if (!error_type)
> >  		return -EINVAL;
> >  
> > +	if (is_v2)
> > +		error_flags |= SETWA_FLAGS_EINJV2;
> > +
> > +
> 
> Does this flag need to be cleared if a v1 error is being used?
> 
> Ira

The driver depends on "is_v2" to determine if the injection is v1 or v2, and the user 
is supposed to set the flags for v1 and v2, but I think clearing the flag here is a good idea so
the user does not have to worry about that. I can see why someone would assume not needing
to set the flags when they see "V2_" prefix for v2 error types.
I'll also update this.

Zaid

> 
> >  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
> >  		error_param3, error_param4);
> >  }
> > -- 
> > 2.43.0
> > 

