Return-Path: <linux-acpi+bounces-13067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8BA8AAE4
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 00:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CB9189BF28
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B327274FCA;
	Tue, 15 Apr 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IFfN1/eZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2127.outbound.protection.outlook.com [40.107.220.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48F257443;
	Tue, 15 Apr 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754965; cv=fail; b=ILoKW3AjL8zsLy1MIO3CpCP6Ngw55SFKVsvcwHSribP1sworTxaxUmbYhPdcMUmtURH/0hyf+LG/F4IKL7oMfQQF6ymMGjFYWlevejE12kURsDod7Rk+LUIw1G2efs3qmF1I1E3Eq89uD7VE9pw68qtqHurxihIMMJVFWnfEYUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754965; c=relaxed/simple;
	bh=DZ/mK2TgsMnhVaf3IfMdsG15QYncuH9xZKnbAZjjeIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKiMeqdSCDsdaw2X4Yk6u7k6x3kUp5y6MFt/wZiYxE9onnS4AKyw+DnMyhBlad4q0NJr7nDhkxmKBs7e4S+/rFttrQQePicegaxMWyE2Y0eCl+VECqgP+Y0+p6sa0LkEgJTXCEGITajM439iGhYgcdorqMrqgNArRJ/f/cnYrzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IFfN1/eZ; arc=fail smtp.client-ip=40.107.220.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/94eW7lB/2zPd0f0CAFwZRaC5RV5GNR87eoVinbPX5SnaPWqq1sOFb6Rv0Uw7HNCH8GNvRtIf8NUWM0pDM7zGQnkxC148/v91G17g80O9TJ2xo/XRXdyE2cyTirbC6j9wUh4TI+Amxszbq9+oSUgebygdSB7XEGKquzPqGt5nbfHTwQBzrODkSdDVhPrXhAxKOrK0Kc3usuG6pAG+h3fQNj5oFsb8LS2sIb5y83x3ddw8WiBat5D2h/H4k/Pg6HXjZBrEbKByGDXacPrs8mT4UFEkOKM+q0uNQYUQ/dC3/yLxy17tzpaXZeOp6nSdKVS9EVJfw0bxiqoogllkt+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyls7HIHE+NMh5Fj0jGCfZ73i3VCLUrsdsZwmMvcgzE=;
 b=ODYUj+VY/qETwprV/Iw80Kivx6InG7H4loXOHOkU5eed/uymPrSSfDolTSqYhoB1cwmmBLy7S67yTiWvTHakULvHzQXY8S2787Sd8L29UQ219jiGX00JKeTHWTL8ZJDcSas7N0nG+kem8A95xXVeDFxja/+lcpnAw8YBY+UcxaKyZPjvCKWYeYuTgFDWvOtN7L8K+iYMDnebu2Rf9mwZfn9mDJzafJXZuMnlpRntq11rBcMhQ6F2xWAxSsUTLg/3JvVKLMhWPRMxYbI2nT28AjR+apL4fhFWzzkBZPAqszYOIO+VXX9UeJOdrpnLNZvPTtEdy4JM9GN+jtrz6xmqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyls7HIHE+NMh5Fj0jGCfZ73i3VCLUrsdsZwmMvcgzE=;
 b=IFfN1/eZ86HttoZUzMUB9ez46mQYEA6oj+02Q4mtTrXdTz/YiSc1n7NE3f1DC0LLBoLFgAm7pxgm7lZqGwXh/i+ZG9IXDnPd982p1QsJm+EC4n89zlBDKc8ifgukm4RK4m7XSohtMq1tdSEXiipn7M93RWockXxBsnK24jB+mFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MN0PR01MB7753.prod.exchangelabs.com (2603:10b6:208:37c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.30; Tue, 15 Apr 2025 22:09:19 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8632.038; Tue, 15 Apr 2025
 22:09:18 +0000
Date: Tue, 15 Apr 2025 15:09:15 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com, Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <Z_7ZC9w8Yu3Ybm-g@zaid-VirtualBox>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
 <20250403231339.23708-9-zaidal@os.amperecomputing.com>
 <67eff305b2094_9807c2941e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67eff305b2094_9807c2941e@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MN0PR01MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cdb51a-9dd0-48c8-1841-08dd7c6a2ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43LAI+tl1lcsNPYzRnbkVzrqxE/+K1M3MSxOerAFJwELk2Ldtzv3eeySF70q?=
 =?us-ascii?Q?G/LYcEimVkt5O7oYnhCeUF9LdACALavTS+5aaCW3BvRWL/+h//089MCWHYyf?=
 =?us-ascii?Q?3zM3t4eGFU5rwp9h9wl4qBdu9GmOB3lD2O4PMCYvkz4Al5XN4FmZq2xXBhf5?=
 =?us-ascii?Q?HbR8SHehxHIWW/i95rqx4Wej/UfRbhysogyNHB4IvbQTKaqKk+EophWcWQxD?=
 =?us-ascii?Q?ezIAmTYENNygRZQr6Z62QC3PBEl+JA2GaAZc13DMRgqLtwQcU3r59sauZKK8?=
 =?us-ascii?Q?AZUWSMFjvBlJ1gR5rQMvgTOc9zIBaXNZAIriAEhCCm5zhN5W8PbEzQDQBgAN?=
 =?us-ascii?Q?d1WEH5iPMET2q+I7cWlR3noqG2/DmvE/LQRuAPDGT10NBlyHhk7uhMdgH19J?=
 =?us-ascii?Q?1penKUhGkpAA0uSVbR37hMVevw69fBRUB2Iz0UHubPn96kjcyXrtOAtA5wie?=
 =?us-ascii?Q?uAZQKy4IEvOgRIYYN3douF54bBVFdPXzcer9oZeMWPcZvpJ7JIQbT8gXXf7w?=
 =?us-ascii?Q?ZrrDUpae/zg3Zx2wMSC/f44PSu1sHTdCDtVM3o1qXk1otQwYZrhtf5cBc43T?=
 =?us-ascii?Q?xzm69VVjDOmRySvQw34wExIXfFkFCVrN0iBotL2ZlbzrdMfr7ZYUki6mcvbB?=
 =?us-ascii?Q?WxT6qPLk6VOtO4/gsa3B7fHGuIoUx6b5zdyPTABprwAuNjD2JfA9WQBDeIaE?=
 =?us-ascii?Q?uw1QTnhfAS6MwIExL/KGmjoiZ5pBfnlR9HBevFi8SZnTmK68XKQsHZq/Q9ni?=
 =?us-ascii?Q?D75Gffc6kFkvA9wcsl7YvPn8CM2MAMybhIGQyqFtXtapeYaepxJ/UTCn9Wfr?=
 =?us-ascii?Q?7FbFbtMnqtaoZ5BY26njHMjhcIcf6D6rlwxjihF5Uuk8Mv//d7/P9QSKxSZF?=
 =?us-ascii?Q?4TN+ktrBHuHJBmdkwTcNF1BfezYkMkwlum1v7ZqF0S5PY3I5t2jnlzrq0Zyz?=
 =?us-ascii?Q?7wl/Lggq+1EYiUaqEJSohgWDZsb6nyI8VaVOpkxQtGTfYiva7B+g1MhrejgK?=
 =?us-ascii?Q?fpWhDT31kQYvMbWVX4DrFntkM+PiUvgjSXtu1zvhig3nsTHM7ToF8pOV02Ym?=
 =?us-ascii?Q?SY37oAfIDHeCEEcD7JsXtkKVQ6L5SjDMsF+vp4l05VqdcDmouaoC8mahSxiu?=
 =?us-ascii?Q?yIEQFqLNJkpMjp9VUA6Eid5gFb1mFPF/0uNx/KF99t+tm22s3magKur7yXj9?=
 =?us-ascii?Q?a7b5o/8L+4WiMwf4maTH6bNeZLigNz/DDO90UwueC01o0M5XVkENcklobBSc?=
 =?us-ascii?Q?PoEzaQkWhsA2fM1yHPt1ACEElgYdM83H1Nziy3r/UIFvzIpsneTqKu9+Xic7?=
 =?us-ascii?Q?8Sr8SmFe4JrmL3BON1IOqdRSO796sqS647TdD7VLAQti3LCfvmW43/EnEN1z?=
 =?us-ascii?Q?6Ocs4hOKfO89ScYveOQzGAlm903ukF6ev887kBr8B83yqNdXCMH0q26QkJoe?=
 =?us-ascii?Q?ORwhelp1xdwPCg1D4sw/EZy6R9E9XNE5APtQbzDo1ZH1nKTIScIk3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLKkyvT9ymzVQ0pZJ0GHW6pW/iC3U+cE5fwLS2jX1jOd3bu+Hs0vs7yADT2d?=
 =?us-ascii?Q?bOT+PasZYw52gSKLDbwS4ppcXW1o/3JgJ0okWVSNOcgcreKKcEQJXE5fMzMG?=
 =?us-ascii?Q?FNIR+GvjEaj6Xh2LI3VMaYpE4zG/MkyA4gAM2td4Fp8/LaAGHDN4ALOTcN3J?=
 =?us-ascii?Q?msfESMnlzVmNpoExs7dlWFKmuyfExWCGJuKIKxIeNYvQnFWfrgcK9+IANBbE?=
 =?us-ascii?Q?TIB7Mp9FoK7bCQBXAQ/ZSUuD8OO5VLlQuiDtUX9/7hottikSSOm1Cotfsbdr?=
 =?us-ascii?Q?pwPhtmstOsx6V/BnqaIjLX+tDRlYCsErLuswb9RElhHvMMyC/is7CbzgW86G?=
 =?us-ascii?Q?3viAl5uMPUqPGnUalntLgiR5/WcR+ERdjVYlJsENyPYCMOTWr3wkTVnnhAXn?=
 =?us-ascii?Q?l0YrpC3I2mCifAkvwViHIJIsfXbMwIcA/bknbhUNAgWd2VF3L6VECubcnzC3?=
 =?us-ascii?Q?wvant68Y+ied7y6xWDZAtUs+kh7X5OS0NdLee0PksoCMgew22G3cSZGx/2+N?=
 =?us-ascii?Q?x668QyE5Md1/AyFOvUbdLcd2WgMc5MJVQ86jgCJmDqQoPW6nmTi/cDYNzUfK?=
 =?us-ascii?Q?a1bADzrDSxxFhnFA2NwmtS7hDRSlrtC2Rg1/aQMSgml3cfrX7Luapc89sKMv?=
 =?us-ascii?Q?m0h45MB0ELTRtKaGyD9jLGz/uGLTxXIvSyN3EiNTPYPKOqxKC6/Dk6pJ+K9D?=
 =?us-ascii?Q?8i+SoShnYOYpElSihVc3BT1A8w2CLwn5VroWs4Q4MXXoWL2lPB0tJLJNYoEP?=
 =?us-ascii?Q?xfw/qFF1G5M7CC/iJO305D7F7gjeUk60SP7LDV2XXgpyE5Ow/GUA9kEiL6Ft?=
 =?us-ascii?Q?VGRU7ox3x6vd+yngeosO1FRwfOpbdDFk5orDikzC7wh7cwRVHEBZiSrMQbtp?=
 =?us-ascii?Q?2ozYRBqRFq9XlYrwLgZxq90nFwOCdzggsHxPQWc8Hq2fqaysHGGqknctvJwD?=
 =?us-ascii?Q?PG4JgoQgtMlcLLp3/R0NYX5BVbsI9s0GzNuV85+PLGa98UlAcMLQznxKy2Kj?=
 =?us-ascii?Q?v9Lih0JX6lJKnMmF8lmEXnkEoOYSszcqNiboI5vZ4ToXu2nMCByzHlYgDoZB?=
 =?us-ascii?Q?9bMqmYM7AH5UN+hXWO3PNlB2ygyiK5reqSVebcyT/CI22chATxHCO7JqF6cj?=
 =?us-ascii?Q?TfuUmpcUNeURrBh878skQKHJhQvD5vSh9kh59ukauEfc3Rd8zCsHjxzmkiSI?=
 =?us-ascii?Q?2zOK/EVhwaiXHxo/zgwlwD6l3id5uHMm67HNCfGEdrNlDTN1sSkfvz/cTTCc?=
 =?us-ascii?Q?R8DPyhLRAfQ7mRJMmLnjyo4RnoZfnZxpKI3w88u6C/qm+D7OtEvhMwGUP7Ww?=
 =?us-ascii?Q?X5jtax6w2V8ycMeMjfwt39lf2irf+s3WAHQJAH4I0zyltE58kuw1HjAP+KrZ?=
 =?us-ascii?Q?x6s64i1bvtXWXzECuS+FvtgIToXrd+H3cdKDzWv62v9QFwfsa+0bIKXOygCY?=
 =?us-ascii?Q?dG2Xa4jdi2rCmuEMPhAzOJYOgWOOYbTqyXHlWWiU4u85Q4aZNDqu0kbdUbRC?=
 =?us-ascii?Q?7YuTS/fbRU1O+5JI1jN2UGKiz6e3aULwFyZXwzHzbNAOJokPMtKztPxj1KaA?=
 =?us-ascii?Q?wnpDC9rbKkxw4CjZaM2tw4ESwIoKcptv3Da3M02nB2+qLoBv+Mju7XlJs7eX?=
 =?us-ascii?Q?b8/dXQHM3HMOB+SDTV56Hq8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cdb51a-9dd0-48c8-1841-08dd7c6a2ae1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 22:09:18.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF5H24fhXj+rEfVI09ELOuvk3ofqShL1nh9cgx26WUJPGA4C9oA1Vy8dWFD0D8EE1qfcBd5OZ8hGO+/B9U0A7iLn9qwFUZDyQg7b2k0JlZeui6svOKw/9/GT+nGpVOlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7753

On Fri, Apr 04, 2025 at 09:56:05AM -0500, Ira Weiny wrote:
> Zaid Alali wrote:
> > Enable the driver to inject EINJv2 type errors. The component
> > array values are parsed from user_input and expected to contain
> > hex values for component id and syndrome separated by space,
> > and multiple components are separated by new line as follows:
> > 
> > component_id1 component_syndrome1
> > component_id2 component_syndrome2
> >  :
> > component_id(n) component_syndrome(n)
> > 
> > for example:
> > 
> > $comp_arr="0x1 0x2
> > >0x1 0x4
> > >0x2 0x4"
> > $cd /sys/kernel/debug/apei/einj/
> > $echo "$comp_arr" > einjv2_component_array
> > 
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> > ---
> 
> [snip]
> 
> > @@ -483,10 +513,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
> > @@ -506,8 +536,50 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  			v5param->flags = flags;
> >  			v5param->memory_address = param1;
> >  			v5param->memory_address_range = param2;
> > -			v5param->apicid = param3;
> > -			v5param->pcie_sbdf = param4;
> > +
> > +			if (is_V2) {
> > +				int count = 0, bytes_read, pos = 0, nr_parsed = 0, str_len;
> > +				unsigned int comp, synd;
> > +				struct syndrome_array *component_arr;
> > +
> > +				component_arr = v5param->einjv2_struct.component_arr;
> > +				str_len = strlen(user_input);
> > +
> > +				while ((nr_parsed = sscanf(user_input + pos, "%x %x\n%n", &comp,
> > +					&synd, &bytes_read))) {
> > +					pos += bytes_read;
> > +
> > +					if (nr_parsed != 2)
> > +						goto err_out;
> > +					if (count >= nr_components)
> > +						goto err_out;
> 
> It is hard to tell but I think these err_out's skip the kfree?
> 
> Regardless it is better to use the cleanup functions[1] on that kmalloc and let
> the destructors clean up for you.
> 
> Ira
> 
> [1] include/linux/cleanup.h

Good catch! I will fix this in the next revision.

Zaid

> 
> > +
> > +					switch (type) {
> > +					case EINJV2_PROCESSOR_ERROR:
> > +						component_arr[count].comp_id.acpi_id = comp;
> > +						component_arr[count].comp_synd.proc_synd = synd;
> > +						break;
> > +					case EINJV2_MEMORY_ERROR:
> > +						component_arr[count].comp_id.device_id = comp;
> > +						component_arr[count].comp_synd.mem_synd = synd;
> > +						break;
> > +					case EINJV2_PCIE_ERROR:
> > +						component_arr[count].comp_id.pcie_sbdf = comp;
> > +						component_arr[count].comp_synd.pcie_synd = synd;
> > +						break;
> > +					}
> > +					count++;
> > +					if (pos >= str_len)
> > +						break;
> > +				}
> > +				v5param->einjv2_struct.component_arr_count = count;
> > +
> > +				/* clear buffer after user input for next injection */
> > +				memset(user_input, 0, COMP_ARR_SIZE);
> > +			} else {
> > +				v5param->apicid = param3;
> > +				v5param->pcie_sbdf = param4;
> > +			}
> >  		} else {
> >  			switch (type) {
> >  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> > @@ -531,7 +603,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  				break;
> >  			}
> >  		}
> > -		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> > +		memcpy_toio(einj_param, v5param, v5param_size);
> > +		kfree(v5param);
> >  	} else {
> >  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
> >  		if (rc)
> > @@ -583,6 +656,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
> >  
> >  	return rc;
> > +err_out:
> > +	memset(user_input, 0, COMP_ARR_SIZE);
> > +	return -EINVAL;
> >  }
> >  
> 
> [snip]

