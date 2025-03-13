Return-Path: <linux-acpi+bounces-12223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A77A601D9
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5AC8804B8
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D31F03D1;
	Thu, 13 Mar 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="P7ISSvO6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2110.outbound.protection.outlook.com [40.107.100.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F5149C64;
	Thu, 13 Mar 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896376; cv=fail; b=evPk8STKOLjscGmcI7TKiNWGxc0ZMym5qMcie6EM7tgeoTWm/qH+FP9zF9mg0y3wqX8Dml2zGws/6pa6CHA9UqBWXcCJhSuZ8RZay69YivN7ZI6mWkGug5Zul+b5Eytz34VfAsmU9D2nnvLkSQWXid96hzMEx+IkjBahIJqEHhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896376; c=relaxed/simple;
	bh=cRREPYMd1m9oov4A8OGqtUf4IwBFm/AYaEz1PJDIsdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oTYkF/HuFcXntAeuzD9xlim7wj8siyBXZZjiJWM3Wpx1w1JbNCE9veL80/EAHmI3CB3LvCit34Wr9UqUco/8epNWp7F2OUOUU8cHlou3rEs57mBwDl8ObmOEtsV3A7cZcX6emRqtDSyMe73ISFRmL7Im4pm9TTVIrPe8b3XHSzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=P7ISSvO6; arc=fail smtp.client-ip=40.107.100.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdgHz/RwZ73TK3y6IxydIKGYOTbvvnXDj5NcoJoYBlIny4TLBv0LcRc0MlCTGtyfzQnp6GA2GTQwImobQJNbU5O7j6axzUmUKT9YTQyB9Lq4D2k6nxQ/wUGrTDCijyfCpMLsTl4RoDzfLpBSDGSIAqIE7QxOjbfHAHwgegTsvb64aoA8LKcD/73MFeHX460k3m/05RTO83gpLLVGS4iAZtM1j74AX1kQiduF9RiWlpO2mgcVpjoCUdz6Cgu3FiisaEG3xMi5pWquEysL3ErnhIgjWJPkeEfGjyRjLGgTiFUP+kMQ9iujkmfGY6NExVztd73OGhzC5/t//FFwCACRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGQgGTdq5sjS6Kb4woDgPtsP2HYnu3hqUv4OLgKSUWU=;
 b=tQAS+Hy7//Cky0inDDayPNxFc3wtDMcIrmBL4ryIE36/I+rsfDvQVEyB8acFTyyYlkkKhYBOW7dcY8D42H2FnNaI1A0sgZRIrk5hWWx7480qz+5Mm1VqOrt2Md+xJ0Ve+TVUFRIAmo/MACfocfoaqXmg00yUerCSqMDGFIbkNmZlSpJkTbHF76+fkEgE6APgK9VvYkXqNG2gIJ5wqvMoAKDauMYm6qI0bwi+6H9z1wC+ef+riGvbVhABAcj+/HttW36MxF7FR/Q4AbmeNHs9jO+Che9K4ZaYuJdDNyCRDVlyZW+fp4SwUWbEggYWn9WC0eSc9qoHPE9n0YwecI4TWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGQgGTdq5sjS6Kb4woDgPtsP2HYnu3hqUv4OLgKSUWU=;
 b=P7ISSvO651IDjWYydTJGEDpOjr2mOJ72aoZxrvw7L+2/zXlk9jZQlqsaMg0DnX9Finiw+hl1lJLXjWjcLOCQr4pRCow2HRqMTFAZhj6XiCcuh3wDaOHldtw5t/tpagNtIMwrCp5EIMVaqhGrof6UfMOBayohCZEv1EG4vmnfuL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BY3PR01MB6644.prod.exchangelabs.com (2603:10b6:a03:362::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 20:06:10 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:06:10 +0000
Date: Thu, 13 Mar 2025 13:06:07 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
	dan.j.williams@intel.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v4 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <Z9M6ryapTGlBWA3Q@zaid-VirtualBox>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
 <20250306234810.75511-7-zaidal@os.amperecomputing.com>
 <20250313094230.00004696@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313094230.00004696@huawei.com>
X-ClientProxiedBy: MW4PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:303:8c::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BY3PR01MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a19ab6-ce41-4104-d380-08dd626a7f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|13003099007|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBwwPHNt1D1c24u69hWMvGU7BuAJGncXXsnQWq6f5hlTpZJkylYzFGmndU8c?=
 =?us-ascii?Q?t9WRiz4xu3yvZIofPl3OuFX1+NFglSr/ImcDAuiQaPXTmQhKDZbnokD9sdhu?=
 =?us-ascii?Q?BGFdBl7EyiOx5PLd/PmAEiEaq4HrKnEpM5RDtv3/WX155Xma0BvIMx33HPBT?=
 =?us-ascii?Q?fmsbyZMeVYaAI2aenCqCZXfHacn3hYJ6+radyviOKhsuPcgqjAZCRsffMnT6?=
 =?us-ascii?Q?dMKYoKJxVR8B3cPZyrBQaXNA1qNE7CuybHgRzWGtn51IGsqDncN1SCfRFiIL?=
 =?us-ascii?Q?MlBJlpBU1H81rMBELIuq9JjMfrgq0YSYY95hOIl9+6Q/LEAPkUty+cZXyWAo?=
 =?us-ascii?Q?EXpzZS46t8rMKktXP4fihBeemkZ7E6nSiPSU3+miqt/6P8j8YtpXJdszFjYG?=
 =?us-ascii?Q?FSX44P1z+VabZRno9UZppKZEYdzpMT+0hAzmpAo8/drSJurFUgRzsLp7C+fr?=
 =?us-ascii?Q?VZNznCYe0/ilxvdc6Eu+d+a8mFYGHuRem0+eTyqP6z+StSWelcjQ5urkXL0f?=
 =?us-ascii?Q?Jt5X77ZwgE8TRhrapkTFJN9QhRJu6YEyQzLLLXcW9sY4HVVS4qqWGWp0ias1?=
 =?us-ascii?Q?QP10lr1Ol9w6UhqDIcOtoq4yh1uhVX7ilw4H2TkBTKggntUsq3FDRuL/LkEa?=
 =?us-ascii?Q?olXnhm4vyQjkC9soeHqhkSnfG6v6N2lSiUvrQRtLsmlNzwtyaCNK0PXstZjd?=
 =?us-ascii?Q?Jp1as7/uO2YQW6xb76DdB8JaUM6xvpypVTL6s0Msaea1sQmaUwGB6ak78lR3?=
 =?us-ascii?Q?Oxv16/DYQcRhKhhZsyS9/7LVp/xBKBRVK0c+qS7zHqjWtUONxfIud2WQT+n9?=
 =?us-ascii?Q?o2lzKnqVPtJo2AyCpLaA348NUsQ0HhYNPaYI0nfKXlhWdYiqtL4fiAx92zis?=
 =?us-ascii?Q?zEUT/SgayZgBDrIywW5L7hLTh95jYes5hMX25t6KidhvSjwCavxQs9a/L1Pn?=
 =?us-ascii?Q?M5r46LDiZc57WzP3CR9hmpSHvBPCHg2A0F5ITakIl/OUPav2tqUHQuRZYUbz?=
 =?us-ascii?Q?V43VZXMH9flVQ7wBvarNWAlkmi6ExT0iO0xEnvyH71XlNUMyoPeH66tNgM8h?=
 =?us-ascii?Q?z2Dg1ldaCqaREsVah9IfLfpUMsvE31fAA2IJyHCJTRMRimoF/Pht40Elq4Mr?=
 =?us-ascii?Q?ChpdqWhdSX+XaAWDOuw4X8/oqLVTQcF6cljVgC2nKzc29omlSNtRJMyoMWJ5?=
 =?us-ascii?Q?6S7j/t8yw8HnHjN4ZSwQaHgbNy8aV4gXt92m/tNKkmrQqqhqMZXIbmlBKAeh?=
 =?us-ascii?Q?EMLjTlz+Nb5A9dNmxinE3SABjH6ZMfC8WIFqU1XMLtV2+KBqLbtc4FC45Cy0?=
 =?us-ascii?Q?yoTWeMh5WIyCIM1I528eJFKkknHz91JH58FO3eQnSQ/VutGcKOz2prK8+Aw0?=
 =?us-ascii?Q?hR7uNJ/I50L2+fBlsRFVbdK4RRuS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(13003099007)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0d1V3fYHIyQVF0ehsxtmPgnWIeJglWoGPrnE5dPfo8tvKiqrifDBhrNbQcK?=
 =?us-ascii?Q?HYzYoCaGmrofMlKR93YN5eNEMit/Y1yrE8AHQEBI9dQ6YZx4DnFQrrS7veMv?=
 =?us-ascii?Q?b4Mw5Z6gNRC5mB32qyoFb2HnHTomz5iUYzSz9TCY5FgdPzQhJGa19g6QYy9I?=
 =?us-ascii?Q?x1yxoIM0fSyWQpQ/yynxlVu8dc6GkcqTNpbiffAb2A1Q8sate3QB7yyIBkLm?=
 =?us-ascii?Q?U4JH3ZisjjsYfULFc3xqZGyB8ofSRfWjp4I+V4qeVvVwrV/9u8Lcq5eCFV9i?=
 =?us-ascii?Q?hVCVJILQ2UKBtmtl7kcReJ1BNGRDg0e61WcdSFeFU/B/ma4wS81VyQwUYfQt?=
 =?us-ascii?Q?fTVPcQb+obkm7fI/mz1mUofwcO22qDP22ms128R3Msf2K07/O2xYGQh5G+pM?=
 =?us-ascii?Q?FMFixeAUhBw9lqV1t4HRgyTjHzsJkMEKwAcJpFe41wLe58Z0no8p1y1/iUHj?=
 =?us-ascii?Q?PI+j4qk0vWEzDMlyaDuhopfqovqihMBiRnK0j2XRfhd5pTCiA8TAi0YsTz8r?=
 =?us-ascii?Q?EhdrFHIzGOR1YBiMG0YVHqF8aV2ljKnVdTIScR1vryPCU81OZdRMQLId2Ue3?=
 =?us-ascii?Q?4vquclXgbLNMQ4W0M+WFENRVhE8zuoRAgyYQuoQAyO5JhBT7UpaozI6vMRaa?=
 =?us-ascii?Q?niMbY124gQXRhb/YPoZJCGo1hVID9JfcN1v1BLC+Fv7emhm2jVMAvK8UgYzB?=
 =?us-ascii?Q?fvGWCmSNjd+onYolMwt452XSWN0CqdnpnGQ5VCyV/pQeKgeV2pBd0DcbC1JE?=
 =?us-ascii?Q?LpKq8hsfhatKbfUsWcVoORavBmXfO58bPByIct4tYFCBO/d/2MEjyJ/mGpyc?=
 =?us-ascii?Q?y6Th4gRa/LEo8L5vNnXE929N6U+w6VotEuZYVGgb4Q5WXRBriH0HdstpChI5?=
 =?us-ascii?Q?F41l35zHFhAW5UXjcjyGaXVqFXWnu92nNPprWAusqlJjbjsqhcQj2hemcE1U?=
 =?us-ascii?Q?j94MD5MQqC3BtqzugKXx33Nc236OBD+OZkF54nvUhOS3xIAgORpwBqZQQQW1?=
 =?us-ascii?Q?dNym63ihptZMasNjJEvV7v2YzUXSB1PCdZudvNGHG2DEgpNQ633nMnMocejz?=
 =?us-ascii?Q?tSX1Tk/MsXUA5odnVo6EqtYS+wXVcHcGi5iGOQ4MaaWpjeMncE2W0JH9Mc+o?=
 =?us-ascii?Q?6xaVw/AcVg5DQ7HLzaQRaER5R9KGONsuOOA9dLmwU7h+PgUGbkD7aHHvbUGb?=
 =?us-ascii?Q?pVmj/5rjN+0oqfRCVtxTqXPQysQzCEAaZR5ZoeWWSbzIKEFA/B5qnEqjKoWl?=
 =?us-ascii?Q?aJ1Ho/G/gD7NCNNk20pmbi9Ghj1qj/6muY5xj+EIYGs45+Kdxpl6GnnJxywt?=
 =?us-ascii?Q?OshVZss2qBbZG9WH7B39rkpZMPMvZwkkOUPy1sfsxN4fiaZnJO/wlFHnTp0N?=
 =?us-ascii?Q?hWx6KdQlvtkPe6TUcLapzF1MY896t4VfoxEid76PqaXMCQi5Y+sNlJm1AiI+?=
 =?us-ascii?Q?fOIpbTK9T7i3Magd9sPZe2kaT2DQL+DePnF9DrpdaCI06jYCt67HZ2v+sYM2?=
 =?us-ascii?Q?gVgLCB+VPH+YJRqdXqvplb0Ax1TbWyCc4PZCnCmsZoateU/NR976BqNccGnW?=
 =?us-ascii?Q?PvFaburJLOCVN6ZyJfgWSHDmvdgZq/PNZunskwE9iXKQXb/1+xQtd02iclPp?=
 =?us-ascii?Q?MPjMuk61OcqLOnuQGOhF4N4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a19ab6-ce41-4104-d380-08dd626a7f85
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:06:10.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjT4EtgX9k0pS4MOM05oR649dyvSkunFftqgDDBsdXOdu0MkLlSad7eF2XEj7LKBftes4kWT0vuz2FeninuFC6zOZ9JmpeDtcGNMyMJGCkB+g2YmkLLMuIXaH0okGExv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6644

On Thu, Mar 13, 2025 at 09:42:30AM +0000, Jonathan Cameron wrote:
> On Thu,  6 Mar 2025 15:48:07 -0800
> Zaid Alali <zaidal@os.amperecomputing.com> wrote:
> 
> > Add einjv2 extension struct and EINJv2 error types to prepare
> > the driver for EINJv2 support. ACPI specifications(1) enables
> > EINJv2 by extending set_error_type_with_address struct.
> > 
> > (1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
> Still seems to be down.
> Also, we have tag for this.
> > 
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> 
> Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4615 # [1]
> 
> 
> One additional request inline.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index aee9a7b17313..32b8d102f399 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -50,6 +50,28 @@
> >   */
> >  static int acpi5;
> >  
> > +struct syndrome_array {
> > +	union {
> > +		u32	acpi_id;
> > +		u32	device_id;
> > +		u32	pcie_sbdf;
> > +		u8	vendor_id[16];
> > +	} comp_id;
> > +	union {
> > +		u32	proc_synd;
> > +		u32	mem_synd;
> > +		u32	pcie_synd;
> > +		u8	vendor_synd[16];
> > +	} comp_synd;
> > +};
> > +
> > +struct einjv2_extension_struct {
> > +	u32 length;
> > +	u16 revision;
> > +	u16 component_arr_count;
> > +	struct syndrome_array component_arr[];
> 
> __counted_by(component_arr_count);
> should be fine and marking these is always good to do in
> new code (and old code if you have time!)

I am not sure if __counted_by is appropriate here. Please note that component_arr_count
is set by the user and does NOT represent the size of the component_arr[].
> 
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

