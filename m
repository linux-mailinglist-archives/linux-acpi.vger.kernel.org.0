Return-Path: <linux-acpi+bounces-13192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3574A975FB
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7983BE0A2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13624291140;
	Tue, 22 Apr 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LLGrpxPZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022103.outbound.protection.outlook.com [40.93.200.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBA1DFE26;
	Tue, 22 Apr 2025 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351380; cv=fail; b=ucvEfnGwOhuAcyf9PtmEo4R4O/vpEpwANYCVMmhMLiUj+Nw+nBIoGGXiux/EQnu2pRk48Ol4M4qOzad/TdXEhIYH7SfVlwVrI6/il+d91P8ufUuwUSDtzugfF3u8OYI8Y3OrfvMGyHe2ECkSgYaVRhTjGoJu2IfA/lpbPkBae6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351380; c=relaxed/simple;
	bh=QcsC4omIMq3mURUL22YLpRcrQM9QydrMgjOuYqiZWww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtSopSH1aFg+c4qx9QrGzhUVBeeOZxLMNr0K1Unm+A2IiJfGMGqAMEo/sxKG0OgwG8SioIj7m6finpoHhQFS7U8bLF27s6aSDy6KWVfO35sUaR+cLYmZeBwqwvMDmK3wHgDQq0k94aTEgoYNMAU/qXB0U4RzrvKBpCk+jEmL3sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LLGrpxPZ; arc=fail smtp.client-ip=40.93.200.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxmiDHv7lRoK2ANXwQBKWe5sNBkFGyuoT2yGHdxD9tF550y8iof91lk9u1oL0HiycI4sSVFGNMB9zbA0LMces3hr/ZNRoBLdgpUoGho92yhM7eodkxyQ0etEcF5TMezK6EeV2f1JlLV2xiPTF6crs4I5MMk2BSdvkNF3ToAZvGH2PZOY0youuZTp1wK+MRPJVMc+IvirDKn/3BHl4q532uuyDZko2tramhgGfN2Y+wteK6gs82wdiNVykwD93HXJMu9ln5/uURBJ4U0DZ+TUFcvih5NsGPmHyYH3P4V+IJsDyBRaN7lH1zwOhUXgP1uw4nbX7kasD7xxYHlZBkwqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOo2sHw69wrsqNXSYn8paO6XcVmwtdiA/QgWjFgLqOQ=;
 b=uiLCdCdLy/1KcqWyjR6GDik7Y+jEGrC9ydruGJQIecpcgueLUCZh2qbXm69SJQ1j4kQ4owpfeLWHaZwLDyjxyHPfzwkoAQYmWiWmfY4U0wGtcpvW6/0N9D+4+FGQUW0MpKmYmLr5w2W4jy72Y+qmP4mEBV0TQabMsUOcWUiBlu/UkJUfSfBL34ZqsWmzDJUk/1F++L1oCK5DWvQzXNKkirujl9S1IGXY/O2VzCOfAG25S1jgU8BkM/P3FoXOOrrztJgME2Wwod31PWv8yuWaAO6gg1xSrPR1ZpFVaqfBTeL4hvhA1Q6OKfGKQHyE1HITUq94YScKvJvurdGh0TBRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOo2sHw69wrsqNXSYn8paO6XcVmwtdiA/QgWjFgLqOQ=;
 b=LLGrpxPZOjPR9XTKHruCQt+wXxxJH8qgN/WDgLus+6Ctkn7VilbpoKnWM0pETzFEug1LvkLtcParQRJw5LlkFPQDCDvyqGuH6TTC6+i6pTOcIsR9z+9xfG4ALqIeOaQ7g/aGY3cqMRx1X5vJjolFMY4/gk+JDzgPnvBvHTJXf/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SJ0PR01MB6109.prod.exchangelabs.com (2603:10b6:a03:2a1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 19:49:34 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 19:49:34 +0000
Date: Tue, 22 Apr 2025 12:49:29 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v6 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <aAfyyS9qUgzsQeLY@zaid-VirtualBox>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
 <20250417220019.27898-9-zaidal@os.amperecomputing.com>
 <aAKvs2cDLu_mVGdr@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAKvs2cDLu_mVGdr@agluck-desk3>
X-ClientProxiedBy: MW4PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:303:84::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SJ0PR01MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e51893-5291-423e-1c97-08dd81d6ce30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Csha+6Xz9H/Umh5BBMGEzDkgi2L7PushdhIkWoVldJ/Yb6VwpJxhwEhHH7J9?=
 =?us-ascii?Q?Slx8ZeBSjwbCt+jeD0LLbOVEo7ml9BAJtNIKNqwYLLaMzcdblw8dzmtFo81B?=
 =?us-ascii?Q?6NPy1tZ1G9Apm+e1wu6QaGjz4GgRKj85cWgcmgdm/u32DnrtarFOVj9Xavhd?=
 =?us-ascii?Q?P4cNyHwME5oqTKZv/4xjkAUcU3hsokd3Aem6Lp+eDTWyKw3Cfc0RRBhJFTaX?=
 =?us-ascii?Q?A2oRTpyHESRrueQw35+jKjLeScyL4fon7r7XBvSXljxHJTK/fzOI/9n8mFbs?=
 =?us-ascii?Q?s/ncEPtnwOekGIKypQ9cdyfXkNnnemfeAjMO5SXZ8XGcDksXeCwj7PHgKFHZ?=
 =?us-ascii?Q?03kiJBUCDSnxT356ldnmH+ohzfaIGLkfAAfBjQlGqye+b7KUVcACtCRBv7i0?=
 =?us-ascii?Q?L2QsWTYUJomuYwnlZ/zA4CsL3set4qzQbeQzTY+Wtu+WqPIU3m86WytF+0hM?=
 =?us-ascii?Q?KHbuPOL1QtxsGDwRSgUQsbYeRRTyuXh0hy756Ub3J2MKBjEbSEGPXXF0r4Co?=
 =?us-ascii?Q?/HEtXLq/LeJr5C5mshAgUUfElFhJbb/HTS6/jZasnvYt1xrffNsRXZNGes7f?=
 =?us-ascii?Q?ZnqIdlffkZvsZz0H/8niPkb2OKY18OP5VSr4g2f+/xYfhNWkGdEfXnRjGK4/?=
 =?us-ascii?Q?MBiDNyKWo5DPDq8Ml2Pm7bjMudDYXiK6p3tQXzDLJ+BZQSUQfS3usKylKVuc?=
 =?us-ascii?Q?w3WH6DT0VXbNiuqKJvum/5UeSuf7Q2rGFCLlRuY/T7tatwxE/JK7gwFRXQqG?=
 =?us-ascii?Q?3tFqux5nQ5ALpRy74fILB5jG98hu36tkBTEG4JUSsnX8CUbBFdgHmtITH3lE?=
 =?us-ascii?Q?aris13tvW9xwmP0NhsG0MYqa25TsJQH1Vn234wwb4w4vDuw+ejy4PURGKyBf?=
 =?us-ascii?Q?Hw2ToklRnuDZ9vwiBSJSjc+oQGhR6znSrA8JVkhbylb3VMEtbd5GIDYot6E9?=
 =?us-ascii?Q?W87SpRt8EZt0FZeee6QDtxOsxmYp2zoiDKeVXkIEuvo9Dct+5/u4wUlt8k5X?=
 =?us-ascii?Q?R2GDbonuqKuhhiLdTw4ts7GppQpnMp0hyd1v/Ta8dkvfytoKth507tsIhhsa?=
 =?us-ascii?Q?P/iVTewg1KlPrw1mZkXoDcM9OSo4wCiwtY/kf4kAuoTUOPJ7ft1uNdUrYY3P?=
 =?us-ascii?Q?jY2DJBNqZsCzDs663Mu0OB25M+NUmr/QCIz8afcTdbtp8bgvtO20dv5WGzTY?=
 =?us-ascii?Q?4Gnc7mA7A5fYxknGxfWzTLdzGX60HqA0i5JCyy35cNvSSjgGbDmxNWGd3BwQ?=
 =?us-ascii?Q?OCHKvihA6E5+fsMx6+bQvKn4UhfXqbV88Xs74tLxuLTSGVXiZEFyZd7kPk1d?=
 =?us-ascii?Q?Fx1X8zKBGMR8YxVLJdHu5jVmx/mm2jLdgM8nJ7Jdo8t3GJTKVyXbELClQ0LY?=
 =?us-ascii?Q?cOXPn97TOVh1XiRUTDDB+iLNJnmMPo+nSRD0RFzJbY4PI8/ncMCDZbQZt6+l?=
 =?us-ascii?Q?+uyK1SnfDfmkGqu5pGaBv6w+bM34STfz8iod16WAQUb2D9ulKpWQoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/woajNHnK6eF0ap3OoMKL2f0RscPU79ppkEotwezli1VzTvHg2oEBxTUn+j?=
 =?us-ascii?Q?SfOwwZeuuZytl5NQYx5u9z8vXFGOLzt3DuA+9uhmDcKi2ohy2Do08MCszegY?=
 =?us-ascii?Q?OdNkCEi7jp8PpjDCRHyb340gFhlW+rujFkUCT4W0PMUggmE5UqsUSCqGtSq3?=
 =?us-ascii?Q?QXG30lApC08J46IbozKiVPW3yAtrluJ6lOp3RbIVPRQhbq5133C25VmLNMyU?=
 =?us-ascii?Q?LBuo5X+DolnrmctQ8t63qXg/RBOPN8blrPPwrSbGyEmDSfeglbNzOd8l38NM?=
 =?us-ascii?Q?QAvblCoWdTav6y1wLgh5Xi4mFDIIi7WHDtVlmxyOssBrGziF4K9nKka4pp5V?=
 =?us-ascii?Q?NdelF9Wk8NoXLPVygQCDuAxk/IIzoWJ/sTNXi2gZ8fExxHSqkr8zyd/e7PZc?=
 =?us-ascii?Q?ZRvI+gBjRiQZ+wTZT47k8KzRRyEKjLnkTdrFacyksIsTFgd+piFRt7493N8O?=
 =?us-ascii?Q?EPuN1Rr/bzqBP6rPPr88SlubcWrK6TKPSnHka+FQHoM71G248FAezdbX7jS8?=
 =?us-ascii?Q?RJ8cykiF0KyTYBK7DfmgvEqyS4Z2rG5dEejSClXtN1TtsThnydVQ8pOUeM3l?=
 =?us-ascii?Q?PRO/Zhd+W0G0Sfnhz2RygVPh+e3HTw7MQa/KqQpPBRytSJ8nq7e3TZyL3nr3?=
 =?us-ascii?Q?D0W5njjcJCUPMH5fsA+4/VIq6CmAIIiWWwRCRwlRx7RmrEiYVzw9RnyTcl29?=
 =?us-ascii?Q?ndtDC2nbcyC+h2W9TgKMfFx3I1izsvpRBPIEqA8WGiRXE4M0vD4OsdB4FSTS?=
 =?us-ascii?Q?DgKtfBc4HzPb6JXyxpRjUAHJp0Yddp12B5fkQTIMvYI5vKWY1tZ829vry3pf?=
 =?us-ascii?Q?/ka8wrVmUA8adjD9CO8zR+dF5E/uzaHyWVx/hlFWFbFFJo4X6wpJH/kWb3Ni?=
 =?us-ascii?Q?qZu9iQE/iUJxdzzUzFePAVxWEG84YJdlTpUZFV8QU8SoZ+wqaqZt3y9WdY+g?=
 =?us-ascii?Q?uiD0naW6ut1IELrxsMQvPbe9BE7qlZjQ9DxENW4wsZGsZu8XJ+5szn2rWqSz?=
 =?us-ascii?Q?tKUAnvOq6oIOzRxaOq50LoSdYDoDufrXnybsrZ/bji4oRCuLN6hsvIOLVAhE?=
 =?us-ascii?Q?wWXbZPEc0DHl4E3CjOB4nef3GOelk0WkxJDwKKUs55b7qJseSMQTr0Ks4cFS?=
 =?us-ascii?Q?hm8KdrUw6Lzzt2gKAcoNvSvMDIEz1lNklfHs5MGiaMJB6lQA0nKI/VjcKc3O?=
 =?us-ascii?Q?LxVTgF9U+qtPQME/qR722aynj9NGwVj0trL5+S5mpRBkOtb2zKzWRM44Zs86?=
 =?us-ascii?Q?j2Tf89nnbKa5oM/v/zk1W0jPaLocV3qFa1gk1ieUvSbtBueK5s/vZuTZyB3R?=
 =?us-ascii?Q?3GiED1v0qAztsEzkuYePfl7j7MzvDaFY+GLKscUC+q5s3aMkcD7O4O2INBWC?=
 =?us-ascii?Q?sqdLOXb9oI9HbX4GxZXiDWIzA34wp5bPY0jEhvElS5w6D3sDtBPLwfnj1If3?=
 =?us-ascii?Q?xGlrF4Zg02u6v4BrBDtZW3PJN4m/C/FGwF+m9r1FqeleRyJ1+pDlyX9Y2N7G?=
 =?us-ascii?Q?VhBt5NjkQI17aRhAPsS7bwktY3Pi7HxJCp/rDXA12uLfvsrAIrWbX8RGcvHc?=
 =?us-ascii?Q?pzFsYIqCbLiJkGES11cm4AJTYI1MiB34hShepK5GIWJ/xFG4w6sVsirKHelv?=
 =?us-ascii?Q?EHnXK30O721YRX6ZvD8W5gg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e51893-5291-423e-1c97-08dd81d6ce30
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 19:49:34.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKgpyl0zFIWXkX48miBj9e9S4hWZ6idbGYTNo4aeSzIAvg12BA7qvtZa3VLMlAuvL7knJHZ2UlwiETlJ0feO25oV/sWCHru/BLfElGt20LMJbU/00fLnALZsKbwt6t7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6109

On Fri, Apr 18, 2025 at 01:01:55PM -0700, Luck, Tony wrote:
> On Thu, Apr 17, 2025 at 03:00:18PM -0700, Zaid Alali wrote:
> > +			if (is_V2) {
> > +				int count = 0, bytes_read, pos = 0, nr_parsed = 0, str_len;
> > +				unsigned int comp, synd;
> 
> I've been staring at the ACPI spec to try and figure out how many bits
> are needed for comp and sync. The example in section 18.6.7 "Error
> Injection Version 2 Operation" has this in step 6:
> 
> Component Syndrome Array [0] = { 00000000000000000000000000000004 , 000000000000000000000000A5A5A5A5 }
> 
> Which really looks like 128-bit values!
> 
> So are "unsigned int" adequate? Even "u64" looks like it would fall short.

Hi Tony,

Hi Tony,

Thats a great point! I beleive I need to change "struct syndrom_array" to make all union members have
a 128-bit size

struct syndrome_array {
        union {
                u32     acpi_id;      ====> all should be 128-bit long
                u32     device_id;
                u32     pcie_sbdf;
                u8      vendor_id[16];
        } comp_id;
        union {
                u32     proc_synd;
                u32     mem_synd;
                u32     pcie_synd;
                u8      vendor_synd[16];
        } comp_synd;
};


> 
> > +				struct syndrome_array *component_arr;
> > +
> > +				component_arr = v5param->einjv2_struct.component_arr;
> > +				str_len = strlen(user_input);
> > +
> > +				while ((nr_parsed = sscanf(user_input + pos, "%x %x\n%n", &comp,
> 
> Parsing user input with sscanf() is a bit fragile.  Take a look at
> rdtgroup_schemata_write() which uses:
> 
> 	while ((tok = strsep(&buf, "\n")) != NULL) {
> 
> to split input into lines, and then strim() and strsep() to break
> up items within a line.
> 
> > +					&synd, &bytes_read))) {
> > +					pos += bytes_read;
> > +
> > +					if (nr_parsed != 2) {
> > +						kfree(v5param);
> > +						goto err_out;
> > +					}
> > +					if (count >= nr_components) {
> > +						kfree(v5param);
> > +						goto err_out;
> > +					}
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

I also need to include another case here for EINJv2_VENDOR_ERROR
I will fix this in the next revision.

-Zaid

> > +					}
> > +					count++;
> > +					if (pos >= str_len)
> > +						break;
> > +				}

