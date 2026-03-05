Return-Path: <linux-acpi+bounces-21428-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLEkKz6oqWlSBwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21428-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:58:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0CC21503D
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4F03099C33
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9E3D2FFC;
	Thu,  5 Mar 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnFFgEMD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF63D301F;
	Thu,  5 Mar 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725162; cv=fail; b=tFT0lnXDcXtkgdyqm2lVtdtjga2mxSebrfsJiED+Y6xPYJ+JMQOTIJ+1/xKEhJYdhxEGzrBfPs7v92GPfudJG273P/v3Sb9uqPZd8drkNvfSahc66iSCwEoLMr5+AZiO8q5Y8hag5+H9CIcEMw9KaQqNd0mUcb7JJhEXW3R3Y9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725162; c=relaxed/simple;
	bh=SgFi5C8MDtjFujK1u58DF7D/ExCDMsN03/cAN0Lo9no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZWO8uikxzWK53siHojN0f3wSurlGK24kLB9IQqnB9PkXiayZIFM/hfYkIgDqEHZ76/vsc6StsI2FbWZskcF7xblsMu17Yl8hm3MxFT6giPPTSvmtVedwAJIMwvFofs8Cvb8TSZYORkjoPKrMSCmHWfMIcfsI1WdwpuxABxaA5HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnFFgEMD; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=accWqWMuvyP+gmoQLdAGF/0oJZm44rPNujJl6DfrhoEAfNyDHeLCwgMDyK4RyVEgSd8dub9nQlEvATdoXRCCu/1TVvc9OBSAPlY57bMYFFrgnHanoixexkMQGPWvEqDVWu6nGYRYHZqN1U1ut94kmQXLcS/FoT/GsuUlK2XlkoLgeDVsMGoGYlh42MMbO9gqm/9pVTwI/W0j7Sv25XrG/0NLKm+2o3vETt7QJSPG7qqkDxd1+Q0cAU1c8bVaY+Y2kXD8C1RjS5RD/k847N5MwdACsmZB+qAPteq+qzI1xPjCMuBWuDRYoB9IXbhiZgaQZ8TcSzhM5S+6L1IhBh6QiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oub64Dc0Fw2sDEmN8wC6WvzBLJIkUOqS9u5Kfnh0Rdo=;
 b=k2iHquE++Z12/m/VRX28LHhw20UXlnAmv2sMUs+Jx9LLFCCFzVuYa3iRxlhe3GJG1aviW3ZJ9j8dqvXkUHJMM3gAXLB5tHeIHCmmwtopZA5u6Eyt/wf26EYfoBIiq6Qupk0LulSShTbXkENnVhmvBnXQF4kvTGAbxdLhJoSbEtzJxQqG8DIqkhjHyIxUTZqFy0g3rImdwg4brx57GK6MkW02QWl036hLY8DIpDDlmAlBRaDIYzc5h3vThtIpbWuAXG++gKTX0JQRv/HRm99DrsIOQ62dkHmIT/xiIEysPILagjXf22SSFAZvn1Dl4Jy7cPOaVrdxouoYn+OXrisLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oub64Dc0Fw2sDEmN8wC6WvzBLJIkUOqS9u5Kfnh0Rdo=;
 b=pnFFgEMDFGPMiGtUwFwUuHmyk+5q4iTVFqQ2VYBEeiZ2EXrDnBBcHttNRHYSp34eQPJavtBEKgttkIReOih3EtCc88l98efOD2SSBleERR1CPlXGrtfLrlMaf8iApgAZYXmb8NraL2qFymM9KuUkJsydLTLBKx3Qs9bFUg3/L76+cgCp9NwSKhdMKEATr3osy7ulbE4lie7xUo1noZmMf084pjjv/Sz0ghCiDUKG6quq7gwe5xegEHpY8ypZbNzKQ1PcTK7E2imd8NxQ0Psp1aPj8L5w4qYmnUWuYuHz3BRVYLvOjxYMP+N+bg9ExdM83Bn7qy2gmjbf4y4ktkuRgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:39:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 15:39:12 +0000
Date: Thu, 5 Mar 2026 11:39:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260305153911.GT972761@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0636.namprd03.prod.outlook.com
 (2603:10b6:408:13b::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c0fa18-5aa9-4cc3-7ced-08de7acd5985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	J1gW9o738K5YUW5KZpMtbHQLnNuLDXb8/nBRH0dOHF8IleYQY9T1Div/Ll3ofGRPGRfC1tYmKTnO8GviTgykCr00z+9dt2vo361QTEegO7ylGoPnROjZ+1/KZcfrCpbWy63eiTRsAd56QpfZOaSipWyLH7Rx/Nh3rDR5B8ImUH+kGMtv26T3nwz8vSLp9kqdL3HGffaAiEjUH+vpsY9xuShsRfhcoY9Ot6XzYcUcZhOZN1I3M0t8sjYKs9G4u6MgtoWqNO+W8zdbLOAwgANF9FmcKqc6/J2IIvKJ4C3bTyeEobBYYZK3Ud6DIQoCdeQ4U6ANvOl0lgiQ3BWQonO5aLtpsjc+dHZ+UxZIf8ojiBzqaQByNcYsQZBKvI28MJxqRs+uBf2eWhVAGwOEom+m4V2tUzUiPnErwKwE3X8KxP3EcMovhE2l4ud49qm01+0IctHWqlsoF3A0Rep6k+6/BvnpBasPHOJ4Kubjrrb71N0iGLECq/gVa+amloEbMolymsFNgLPBjQUE4eD2Um/Rigm/Q6oxzt6MywKOjb9CbWaIJuzfbFvsRgsG8wuw6bpMJQHhvVAxJALErSgTSZz4DUSNJS8dvCQoXyElo1GFisKTShiyHs+rep7B0uasE9CDX/0rz0tJieW9b/i/c5hZ65gaKJq3W2FIi4VGbcTYTiO/W/DyYslipFVsR39TqLtps+QTJJCZPdug5ZuTeZCHHcpLkIC6waNVu8rY/6OWyDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9SWwyxVsCIZX3/do7mCwknk40e5qJUqx7WIFrvRHLHs30iT5Tl+cyeCm0OP?=
 =?us-ascii?Q?kJGVkvIp4m+M7KuyoOwyObbOMwK4zHOSrx2UkivtbbkvqylHh8fIWHvKsWnR?=
 =?us-ascii?Q?KXxdmJnKNQ/YEFU+wi27aQ00ch7ElT9jq+akw3yPWFqh9llcjaUZD8p5YB+4?=
 =?us-ascii?Q?JaKsOfeji+4iI10Fa5Aeum8i41SDaYc+2yvCIFuKA+wXPNl3Sg89IRnujQed?=
 =?us-ascii?Q?4uCOYzpP+YIWFl5cH3tRH7D8rjUYhb39tTT/26C2cgmU9fnRpiqYBfYVjTkr?=
 =?us-ascii?Q?nC1/5i9KX2YjgsCCiin9oW3IqcgvOwg7Dbjyhw8XN/1mH6jAJcE6h2v68aHS?=
 =?us-ascii?Q?vHPvoJg1WxKZstJwLKhBwAsOhH+D6spnEjZ04Lj9WghV3Uf3fzoHpvuxSzxc?=
 =?us-ascii?Q?1v+7YC4l4VxRt4l3E6gHuokwdkXBzpyQ1LS6l73y8tgrtyzY8Mzxy1tQZp5u?=
 =?us-ascii?Q?l1gwqm15KIWKNx7tZ5SkKYzM4FBf8m8Bo0uVU+KZSPQ2Pm7lNSwppqL40BOM?=
 =?us-ascii?Q?YNW+tlL+yQqK/fdz59H6gzcyqeoj+r7ImZk+v1Lof6j8unz1j9Y3C0iliG5r?=
 =?us-ascii?Q?/dJejWhXDEWS3tA6u//nkrClfD+qlCsC/TvUBioOWnW9ZwIoXlNeMcKKrgHu?=
 =?us-ascii?Q?0uFJeiUzS4vqA1L3/tc0tc1trksOMsiB8jQajyBQw1CP0NJPX0tU8lS2Z7gV?=
 =?us-ascii?Q?iorkChsNptKQkr9jsZZI+TxgATahUUska6hsAHBHC1HV6I3AaFYx3Vudtj1p?=
 =?us-ascii?Q?+LvyUjz+bc8dLyBt82hoyCBQ6mG8fjDwY/bRsNltWlmGwVzZBGRgJYCu/Eum?=
 =?us-ascii?Q?JPC5TO6lCyy2IL3UY5brJg9sZTxfvAO2fu360v7OviKnzoq/GVWM83GnIXqr?=
 =?us-ascii?Q?cwOlSV0HWxuhpDC3b2xXKVwaVD/6DrRMPGuJWpir7hNf63YFY5DZzux6qQjV?=
 =?us-ascii?Q?PMjADan7gCqSKRpAgGYb46BM91eVGLds9pMgq3fbEwuIDiQL9tgShBzr8d1S?=
 =?us-ascii?Q?kdXwF3O92CuhucYZJko6GtVh/lgTVMAP8cnELC2QKrrNMkqTy7zhBriGIhez?=
 =?us-ascii?Q?4AKiDlemy3zJ8Qj3JmNzXdGxr8OmwjHaziMKC5oXtBCU32XYW18YLGYznjR9?=
 =?us-ascii?Q?OFXKwvAYfyk75c8zdyXAkYUQgFRYaIdhRQF9pBIDVaLFqzC5xbHJa283bELY?=
 =?us-ascii?Q?0GyaZhSQu5zWTQUx7qKZZunm/VAzwrRxpFdSHqjICaHt/D53otLzHFECGr2x?=
 =?us-ascii?Q?YqieVTbFPca3LeVNe8eW/MIhtvcri/El7C8zVXv/StH0YAqyg3THDn7ZOySq?=
 =?us-ascii?Q?s/f4GkKnLM7lOKOlIM4PkJ8mYz8XGi+QmANg5O4OzB9VQeiirAnnyMvUB7qw?=
 =?us-ascii?Q?MDqSEhIfxxhqxJtHH07MXs3tkCYRQQh/PWS1OOZuP0DzSeI+hCSZutgl7n59?=
 =?us-ascii?Q?ABFCDAq9KZHleUTy9oAYL/I2Rz8Kroa27TcUbtz/QU/Ptq6DH++TsAhXe+1w?=
 =?us-ascii?Q?+wGuhXHWehgwsbDSpCnQzMCcV9aD1yvH8y/7ijX5Iq9tBT6t1fZBtgsjxlAk?=
 =?us-ascii?Q?NHMt2by8s5JXCzLkJsvQsJtO7WUKr4VDjxvFlYk6cuqD1gFCjtQ7ZYaUpal8?=
 =?us-ascii?Q?KaWvm5Qe6afTG+wPUwu6cyCTMv7Y9YXbbZBdzgqYIq+/DKMYE2WhS7l0udmK?=
 =?us-ascii?Q?/XSY0L8AbxpWigr8BHovjAf0kDc1TTMY6OzvEefSwqS2tmGWZ43J/hB47EW3?=
 =?us-ascii?Q?oCE6NoJTjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c0fa18-5aa9-4cc3-7ced-08de7acd5985
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:39:12.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ubwlTIWf0r95hltdFmKqqHeBWhTLWq+an922wPHgrPqY+Y3IkxKMFRvtP5XpQI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
X-Rspamd-Queue-Id: CE0CC21503D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21428-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:21:42PM -0800, Nicolin Chen wrote:
> +	/*
> +	 * ATC timeout indicates the device has stopped responding to coherence
> +	 * protocol requests. The only safe recovery is a reset to flush stale
> +	 * cached translations. Note that pci_reset_function() internally calls
> +	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
> +	 * if PCI-level reset fails.
> +	 */
> +	if (!pci_reset_function(pdev)) {
> +		/*
> +		 * If reset succeeds, set BME back. Otherwise, fence the system
> +		 * from a faulty device, in which case user will have to replug
> +		 * the device to invoke pci_set_master().
> +		 */
> +		pci_dev_lock(pdev);
> +		pci_set_master(pdev);
> +		pci_dev_unlock(pdev);
> +	}

I thought we talked about this, the iommu driver cannot just blindly
issue a reset like this, the reset has to come from the actual device
driver through the AERish mechanism. Otherwise the driver RAS is going
to explode.

The smmu driver should immediately block the STE (reject translated
requests) to protect the system before resuming whatever command
submissio n has encountered the error.

You could delegate the STE change to the interrupted command
submission to avoid doing it from a ISR, that makes alot of sense
because the submission thread is already operating a cmdq so it could
stick in a STE invalidation command, possibly even in place of the
failed ATC command.

I think I'd break this up into smaller steps, just focus on this STE
mechanism at start and have any future attach callback fix the STE.

Then we can talk about how to properly trigger the PCI RAS flow and so
on.

Jason

