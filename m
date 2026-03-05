Return-Path: <linux-acpi+bounces-21456-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIsAAajyqWnhIQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21456-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 22:16:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 550AA218744
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 22:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E128530226BE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91832306B05;
	Thu,  5 Mar 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnWIpnAd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A341917CD;
	Thu,  5 Mar 2026 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745380; cv=fail; b=k9lIGzagj6N0c7dNxm17MFtYg3iaFXpFQqh6JWwlBRRVcg9mnJGZ83kWpA7HTICQ8/Cbi2hSvSE991fP4UAl8gDpGmYD5VaBL/AL9hAxa6zfrerOIq0m4Bvp0hff7uN8DmWs8FXcZ43wzFUCvRASBPUR1MiFZtQi0NuMDXuq6NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745380; c=relaxed/simple;
	bh=jakYx5z5RhvlKgWSrNyDkW/wURRRVF5ua+7IT7t0Las=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7qbX5St7UoEOluwAsfBbvEhWb9X+gCyegro26Fjjovc+9CZDYWDtaChzEW8n1zIBwzC2YM0gQkNw8ZClyc8qY3Cl6UMPNrMLuHqlCv5sh6yo9o3rtL4cxEeNb4eULkHd7qV6Cll9yFhWmP4sYI2qVfVoIJBsZZG9GeF8V3Es/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnWIpnAd; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLiFm0o/2q81MJ63fL+UHasDlvwm09Ea279rr1Y8f5DrRE6xF4KMO4NiwBoKHujvv7j54k9Cp8TD7unp9X2WcewQDQStGLUj+loQk8ZXNNwbwkMQ/UmWMdAi1z5AdyLa1j7NbLmzeLqAnmPLO/niXzTfnyV04QjERZYjRDKyT6RN1q0DDe5QLtPWQwb8seSRbL+SZMTBImrDbBHppXUwkIvdpdQqL7EGcx1LA2Rf7D3s4dotxHjcKqi57lZ1rh8f4nYBAoUuJ7+Iz+xo3G/9mwaDFAAveGKpklra6WVCdPmo4MDnMzgvt2Ux4RY8RZMlXbSZMFTG/eoV9aoZVLQXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZgBIjejuNso6S3D2MmNptM2fbdvIALxSbMLUuOs0CI=;
 b=gv3EUZbqHVeJDrBHiEowgGziacnJk+71vdWZGR1BmJvpqKduaKcOegpDe4+XA1AgjnPpkzhsVZSWr699fyqQ28iDz0q4zeL7mU6L6Z3ReypJ/GEzMDCgFPpWBdGsxLQiXR9bGhRj0WaWOaVGXXjITAUudZkBfZAVBkyh4K9IAeXJSR9IY3NqFZhXXyBqcYvjnAtVv93SoFp9Am81QDGOPzdai/fZWfrD7sN+wLazR4x5PJcxbaLcAmU9cRmecoN9cXD0CtqD7f32hVb/hnp52k7+h9FN+mq30PRrByLihMk0cn5bzYKq21EYIl3QcdajAtRkmw7tBmTuYSk7GTwESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZgBIjejuNso6S3D2MmNptM2fbdvIALxSbMLUuOs0CI=;
 b=TnWIpnAdtY2UyIqNeUC2b25jtdMSYNqf733LXbk8TcmJC3S6OpdrXILV11MDRgMfLecgigdWpTW2AiyZaNkx7z/wYSNa/n/17GFt5aEs1awuww+Z2dAqmp3lvEj3RjMkG2D4ZwG1rY0WPlYAd2j2h9RcNREp5C9BLmc1qBq1SzKIuEDdz1R1jwuCbWg+xjWsb5SgRxwSOznhnRGi+gtq5JQevDy3WvFXDAw+CxaFzxSuJ8nJ4Ruuu6p7ykapPjk06Azbv6YoLPQxVS9SJIgI2tSU89RDyPJXyGmXyxpOXpGWSsifF3dPKLDKsrMNGjnxr70D2F1N/rUEER9G1uCPzg==
Received: from PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::10)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 21:16:12 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::5c) by PH7P223CA0017.outlook.office365.com
 (2603:10b6:510:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 5 Mar 2026 21:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 21:16:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 13:15:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 13:15:47 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 13:15:47 -0800
Date: Thu, 5 Mar 2026 13:15:45 -0800
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
Message-ID: <aanygWWZLA1htDdQ@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305153911.GT972761@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: deba455c-3340-4e3e-d991-08de7afc6d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	G0rmZfB1PqPQ/KQ9N3GtfSbrEXYtVh9+Rk0Nbq2sNThvgJ9J1zitBFpRrTixtap50BsVzWKqLXq4GpSm7gz9CCN74z4/wvptyr8NUL0fyaT7D+PUz83SUiW0/OCeAhX6xstl6TVI86P6svPxot5P45zIdq3/OMOJ3wgD54bMMOsw93EzU6xaVI00Jm1zkHzDWczv9/KBDtsZEB+Jm/yCdRPoE+zDIktkb6Yzaga3kRs+gBvKWSvrK/xJtGf5sDt9vYPcUh0lyt7qrEON36D18s/sJWUo3r09paTaR2ydiVS42+WgxuYK818rh6yziM8EbZcbwIN3gzStkwd4WtX7GruQRmV0uKNKzNsfiI9LTjmkqXOqAUCqnk4ytFsYiqmOCgaLk38R7PPxN1tgK/Ofra0q59BbZUZwggY7m++7RqrH6UncI0oFBg61mbFd/IFHWhpyqbWS/FAGqdlSOI8lPo5vwzW2xvOJpB+aenp07PRYTAJ95jsWY1uag6nGMdaY2jU+X1ButZTYioQlDjmXq9y9VlfO/Ef8fLxIVU+1YwDdcdn6iTCeF5eXBVW860gD4SL7H2UH9XU1K6qfz/IUp2+v6pUqR4RisLZyqQ5qebvRIaNWmSXvUV4BtPxL55T6rjcyfgGDhrdShwXsNC0E/PndeNe2EdLazR8+pYvgOJr4nPjd1JF8Zh+dL9dBHpvxdGNw0W3GwEewDrg/a9JF8L6NfKwN9c3x9ir2glIOy/IYEVXXvV+govQ6MpFAELyXL8RaokL7RWo2DZTeHqUGKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TJIbOdd8dBwd7i1Usf0069GlLdO+TaX7qOotaHQNSo3ZSUt8WX7WR+4/3A8hg2xww33HzkdgOwzBYBag855xk0H6Vf5637zaDCyZ/2/yRlZXtgxr+OBvWUXogEyzDasCGvmhamvdsTrVTmp53KkQpAH6aNCfTDZfyHGe6jjAhGxo0M7T+nF0ZWZXG0ju3Ah+fiOXsUBAZ2SW3RaAALQRkWqmtxsaJRig7uBsVFa2loTCPzuBpirbusAY2c5OnDc17uJ8+eIq4nNIsqNkdNXYfbE7PNIL9Zqy3PbBU83cZv6QAG7pdvIW7vjKvbW8xKjkqtI/oI+RrvmQTkkCQCgSuIvR3L/oFVdfwtogJOUtzt6p6V+lINq16srYwX+KVTbcQ5AWlz+6dI48I7vRcSKd947R3QIF05ABzpOzInQ/JYcejEEyrhPABzI8JN1kvHze
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 21:16:11.3852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deba455c-3340-4e3e-d991-08de7afc6d2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
X-Rspamd-Queue-Id: 550AA218744
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21456-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:39:11AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 09:21:42PM -0800, Nicolin Chen wrote:
> > +	/*
> > +	 * ATC timeout indicates the device has stopped responding to coherence
> > +	 * protocol requests. The only safe recovery is a reset to flush stale
> > +	 * cached translations. Note that pci_reset_function() internally calls
> > +	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
> > +	 * if PCI-level reset fails.
> > +	 */
> > +	if (!pci_reset_function(pdev)) {
> > +		/*
> > +		 * If reset succeeds, set BME back. Otherwise, fence the system
> > +		 * from a faulty device, in which case user will have to replug
> > +		 * the device to invoke pci_set_master().
> > +		 */
> > +		pci_dev_lock(pdev);
> > +		pci_set_master(pdev);
> > +		pci_dev_unlock(pdev);
> > +	}
> 
> I thought we talked about this, the iommu driver cannot just blindly
> issue a reset like this, the reset has to come from the actual device
> driver through the AERish mechanism. Otherwise the driver RAS is going
> to explode.
> 
> The smmu driver should immediately block the STE (reject translated
> requests) to protect the system before resuming whatever command
> submissio n has encountered the error.
> 
> You could delegate the STE change to the interrupted command
> submission to avoid doing it from a ISR, that makes alot of sense
> because the submission thread is already operating a cmdq so it could
> stick in a STE invalidation command, possibly even in place of the
> failed ATC command.

You mean in arm_smmu_cmdq_issue_cmdlist() that issued the timed
out ATC command?

So my test case was to trigger a device fault followed by an ATC
command. But, I found that the ATC command submission returned 0
while only the ISR received:
    CMDQ error (cons 0x03000003): ATC invalidate timeout
    arm_smmu_debugfs_atc_write: ATC_INV ret=0

It seems difficult to insert a CMDQ_OP_CFGI_STE in the submission
thread?

> I think I'd break this up into smaller steps, just focus on this STE
> mechanism at start and have any future attach callback fix the STE.
> 
> Then we can talk about how to properly trigger the PCI RAS flow and so
> on.

OK.

Thanks
Nicolin

