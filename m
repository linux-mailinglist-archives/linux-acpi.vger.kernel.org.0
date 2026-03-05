Return-Path: <linux-acpi+bounces-21455-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKhhCfzwqWlGIQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21455-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 22:09:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F82186AE
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A262330071C0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B934EEF0;
	Thu,  5 Mar 2026 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQP7CIlt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF934EEE8;
	Thu,  5 Mar 2026 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744811; cv=fail; b=g843KtPq0tv48JRHolhdl2eBAetTZAUeojPFh47i20gQeiQ3THqW1a0NeEDeELs8astzg6m0GiAxntjuBia/SQuldBPbAbYn8yWMdoYVHK/RHa/s72ML3UbfbVjQoSEq1C6nhLAA30u9d0+jzO5MzsJKQ4Tb55JeCZrQi4wjD8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744811; c=relaxed/simple;
	bh=EVIwxwXhlx7fwJKe+Mx0EGz+n8KWD5ARw8bY95C6AfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhYwKLrMc5GUdzwUHoq4AKTH72kYCE0AmTxO3ogEX1pakqnBQYx/IdC61XWYMOA8uIUMuqMyTen+E3htIuGSGa2n1Jk+KLTXT3aPlchKCUQE1WCkfe9nR1y8dDqysEyYtXBQT/UdR+1dJ5bxil765xe3PUf5+QGZ4dc4dtB7z9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQP7CIlt; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geM6CfonyePPkHgXejDbROHz1TMUOjecyxNg3Mir66/i67bNhkc+4NCiwDT3ZTe80j4NzCoEkNQ8rvcT3jJReW18v0Bemb0iM5CodusNvz5pL1iglSGDgDiVdLAHidWDE4T/bCUySAaDioShLIT9MgRxVXndrvlfb+Q+LlCDJp6Zx64aNkhpbx5UMJ7u0I+YOCMAQVM1iYLrWGPlw8nJdYB/d3Lqw7U3RNBArECYiJg1vk831i+1XBuzI8HfK5co0g6Y4gyyde1sqXkJQ343CcZhntFvLB5vsHTIxsWxfbceaGtAH9zgqSgdKmtoUc8Tz1aeI/Ol9wmqvQV3WMQCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EctW3jvFPsOk0/EIuOkO1Vp33FB79drmL8T3kLvsdo=;
 b=kU0JmV1R4r9N+anQeJsesP0FbrcOcRrPLy59jV31gM4d7HM/l+vNF/kQC293Y+aqSPhmcCW0WvQQIni7hA+jURqnDcVDp+RAQ01ijl8iLfunDJyp1+ZnA5dviUyMIjoa1mFClKomDteEYQhFwFsIKifWov4T//LWwggFEnpXOp05I0c6cYcmOYDftv2KYkZJ1ZN+wtNO1GtcEUYAXnxFPcmcme74U/qp4odTVFlh04u3y3ntVLRfGFbBX1nxigjDQ1OqqGT/tVbY/XjY7SWxCnIrk5ESObps4jkESIRxdaOh1XKJXwkdLR/Ar4XpAT8DwQGfLax2/Ld61BCPEbmeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EctW3jvFPsOk0/EIuOkO1Vp33FB79drmL8T3kLvsdo=;
 b=ZQP7CIltNjnXeu6DG15s/AUlh2NdAx4F5YAqIj7I3/6FheVwXXAXBFlK0BucVtT66AhjvgvpPCHvUFu7oQVOlkH5E295XrC+uAgJ3TGADJnvtW0y9G7XpW7sOdmuyRtPTVq5ffhdL1yX7buI5666lHsK4b1pkswuCm/QY7nzRv4tQXFBmKz7e2QWQk35MGtsZoLFG1wKFtkNe9d1GEJ+3uQZ+YfX9+A2XiG5IkL+pzudzOL2Zg0JC9rpSreJqf5yQZV5oUd7NUL95tNwMHNKbzOp03NrTvtMF+Mn4xdtPXTlGLw02jodQ5fVymEPEg2mOwaLrS0Xg+PCoVQufValiQ==
Received: from BYAPR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:e0::48)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 21:06:43 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::27) by BYAPR05CA0107.outlook.office365.com
 (2603:10b6:a03:e0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Thu,
 5 Mar 2026 21:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 21:06:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 13:06:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 13:06:24 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 13:06:22 -0800
Date: Thu, 5 Mar 2026 13:06:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>, <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<kees@kernel.org>, <baolu.lu@linux.intel.com>, <smostafa@google.com>,
	<Alexander.Grest@microsoft.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aanwTQtMMplXY3du@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 3249b412-e9f9-42e5-b1ab-08de7afb1992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	XRO11fukPD1iR7ofjLJmhx2e8R9JHGNVYuXPICMRXUFhcrHeLXuCA7rNaTX49LIp2nGCEEimlrJp1oRyIUaGHYF55SXtnFVkZzFlL2Hgg4eBNQTvBhUeAMMElWio610B/onFXzrtd+90zyjOxCFvY8xVEE2LYDDrq2mEXMuJXhYRq853TNJozeDXsXC2xbQYjiGT/6Fbe7amWxlJcoQ5FnI6uzoZpWDhuBri5T5SmOB2rn4G6b1hILMJJJ87RIISQ41dDVcEXjIq21vyOCCg9dJlc6GD9hBHeQXo6enRidNFJ+affICOFIff10SwiANzLbGz8f4i9ZhOEyZvL9YcrSew+06PC9vCq+T9j66y81luUPY6nC+q7yZWdvIB8hs3LWgNMNMyMeZGb2sQlk5Td1DE/w9d2i/fYsNhbGapPOfZ4SKcW+lMvxP971VRzLVsxjvwUrfzZWeL7/uDcecQ9QuYpBfjEtnFA1OxRY52H9TBxdXcMKrzMjX5dLpmSxa+3Q7dxEKKp0kzQ/JssN8JJxHFGLlHu40SAZk9DDFaHeOOqaXAi8N2C/Eewm1LImxFhK/7+fFUqoyKORBl7/sECfMVv63n2MBeSRSaKQF687TiYsYm7iBH93AU1O3H9HPX4KrgddJs/NY8K2tp3pQp1GGjgysq0LKFDBMKrLI+Or+0B4Hz0aydqtaRb9QLqJgLj5ghCAbXnHvCg7gnAmkRFji1Z1TrlqBcFuskdL4es5BM2yljLWkYdZBzu/QP8jGsbC/y74ILuYKcYX35yJw1AQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UK4muLFlfujQWqLkNF1/Gyc+tL6pRRhKhhlb6/W9JzaTtW7WrIYl+/hTFvk4X+5PVzxaWIN0YgOIyLgKJ4NsXq4FbI8sXupn/0aj3cS0/KMcHzdRJLhN6F/XFNg2n2UsGN4vTyqdj0UBh7v4oNaBH5HO1qw5TqQZiCxIA7hC99II4g8QvvxdMWvvbkPlJtp0Va+IaSXOpCrkcFfbhZU80In9fMJ3n1ibOxtjd4bfkMMjghortMiAR+0W94gA0ch+HzUrOySb8rq8ueRca1w+axogwoQHIj70iCXjMWVytmhbXIQ3a6Wu9D/X/H0WAVIfbMeHiLPpLV4QoYqQ7tECWAVdo1wmmDMIWtObMlWk/wdC0SjsStPPA9nM967NpoMrSWvqSALwH8aTHJnBeYNJxy3vy8SEtaE9U+SIHKbUHocAwnBjDBQfcVgTm3wiKXg6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 21:06:41.7282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3249b412-e9f9-42e5-b1ab-08de7afb1992
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
X-Rspamd-Queue-Id: 792F82186AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21455-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 03:24:30PM +0000, Robin Murphy wrote:
> On 2026-03-05 5:21 am, Nicolin Chen wrote:
> > Though it'd be ideal to block it immediately in the ISR, it cannot be done
> > because an STE update would require another CFIG_STE command that couldn't
> > finish in the context of an ISR handling a CMDQ error.
> 
> Why not? As soon as we've acked GERRORN.CMDQ_ERR, command consumption will
> resume and we're free to do whatever we fancy. Admittedly this probably
> represents more work than we *want* to be doing in the SMMU's IRQ handler
> (arguably even in a thread, since all the PCI housekeeping isn't really the
> SMMU driver's own problem), but I would say the workqueue is a definite
> design choice, not a functional requirement.

Hmm, you are right, after writel(gerror, ARM_SMMU_GERRORN), it
would be doable.

Though SID->pdev conversion requires streams_mutex, which can't
happen in ISR?

> > +static void arm_smmu_atc_recovery_worker(struct work_struct *work)
> > +{
> > +	struct arm_smmu_atc_recovery_param *param =
> > +		container_of(work, struct arm_smmu_atc_recovery_param, work);
> > +	struct pci_dev *pdev;
> > +
> > +	scoped_guard(mutex, &param->smmu->streams_mutex) {
> > +		struct arm_smmu_master *master;
> > +
> > +		master = arm_smmu_find_master(param->smmu, param->sid);
> 
> The only thing SMMU-specific about this seems to be the use of
> arm_smmu_find_master() to resolve the device, which could just as well be
> done upon submission anyway - why isn't this a generic IOMMU/IOPF mechanism?

You mean treating this as a page fault? That's an interesting idea.

So, the IOMMU-level fence could be done in arm_smmu_page_response().

> > +static int arm_smmu_sched_atc_recovery(struct arm_smmu_device *smmu, u32 sid)
> > +{
> > +	struct arm_smmu_atc_recovery_param *param;
> > +
> > +	param = kzalloc_obj(*param, GFP_ATOMIC);
> > +	if (!param)
> > +		return -ENOMEM;
> > +	param->smmu = smmu;
> > +	param->sid = sid;
> > +
> > +	INIT_WORK(&param->work, arm_smmu_atc_recovery_worker);
> > +	queue_work(system_unbound_wq, &param->work);
> 
> Might it make more sense to have a single work item associated with the
> list_head and use the latter as an actual queue, such that the work runs
> until the list is empty, then here at submisison time we do the list_add()
> and schedule_work()? That could perhaps even be a global queue, since ATS
> timeouts can hardly be expected to be a highly-contended high-perfoamnce
> concern.

That sounds like the IOPF implementation. Maybe inventing another
IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
make things cleaner.

> Right now it seems the list is barely doing anything - a "deduplication"
> mechanism that only works if multiple resets for the same device happen to
> have their work scheduled concurrently seems pretty ineffective.

From my testing results, it does effectively block duplications, so
I think it's somehow meaningful.

If I wasn't wrong, the duplicated ATC timeout might come from this
exact reset thread, as it did a CMDQ_OP_CFGI_STE while the CONS was
still pointing to previous CMDQ_OP_ATC_INV.

IIUIC, the IOPF queue doesn't expect duplicated PRI events. So, it
might invoke the handler twice if there is a duplication. The core
handling list_add() might need a deduplication.

> > @@ -456,6 +555,27 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> >   	 * not to touch any of the shadow cmdq state.
> >   	 */
> >   	queue_read(cmd, Q_ENT(q, cons), q->ent_dwords);
> > +
> > +	if (idx == CMDQ_ERR_CERROR_ATC_INV_IDX) {
> > +		/*
> > +		 * Since commands can be issued in batch making it difficult to
> > +		 * identify which CMDQ_OP_ATC_INV actually timed out, the driver
> > +		 * must ensure only CMDQ_OP_ATC_INV commands for the same device
> > +		 * can be batched.
> 
> But this *is* "the driver" - arm_smmu_atc_inv_domain() is literally further
> down this same C file, and does not do what this comment is saying it must
> do, so how are you expecting this to work correctly?

Oh, that's a big miss..

I imaged these changes to be based on the arm_smmu_invs series,
where it could break the ATC in the batching function. Here, it
should have made some change to arm_smmu_atc_inv_domain().

Thanks
Nicolin

