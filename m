Return-Path: <linux-acpi+bounces-21461-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFpsEjcTqmnFKgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21461-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:35:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7F21957F
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B56B313B76B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 23:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98E1459FA;
	Thu,  5 Mar 2026 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RtaQCxic"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DD36828E;
	Thu,  5 Mar 2026 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753445; cv=fail; b=trp9IisAojS7trkwt4/QUQK6cKT+FtssJgPw6gDfE/pTu5JLYcckZL/3EWX3OG2CT6WY2OWCO0prayQjAEA+rPEiNK7YfwUdm/pkgzAQ34vXX/qW5IZ9V8BAKsSkKh453QWvkU1LrBYHtv6xmc5P86va1rhbrITDFJutfV2n39o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753445; c=relaxed/simple;
	bh=7sRAZw4yPO3d/eL/eoJDca2sZxiGT3h5HcK5bxs/EEU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEZC53KKn93MIpnKV4jxasDZGHhgllYknMmLW5SEjEtgfdLDVSGpKDJMe+Ly8f9CEa7dQGaJ15Zi1DyWI/8HYgWV6E+CmH3SV6iBwFkj9zxyCiKKUe7sBRjXIAWBAXk8PGdWzpIAHspw4a4oGf6/Y2X1zvd7g+NCweDguXJUYxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RtaQCxic; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl/SsVE38CWCxSvgntKFuSx14kvjj2Kg81lv4kTzHYLArgEBN2+4Fqq79u/xbcslT227RNKAsNQk3vnwnOMZ7/EbsbH47WSiN3/NF4NcQWw0jKcEHehRCXblwjIbBG7IHsdpW4fRE2+eSnxmXyhzUuZWEP0Bwy8zhHMvNyneOwAVqHQdjVQlGmU9uaOnKpiG8bdGI6R+GdB902zeQds223hC8WEqUc4qWatq/6M5eqD2n3KyhTCVDC1BFdjF604Aj2q470EHP4eNMQo53zP4n5fyN6Li3y+P6HISz8m/cG17n0sYbZwTbu5NxqfQOiqPh8NcKqmdz5vRyy+cH4HMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgRkvFcTUczR4dqthQhvspi28MyIr9yzaXniJcBBx6Q=;
 b=w/KEsv+5Xa7FZigk6c6o+jUYHXNMRcdEj/jQ6zx+5D6821fbDrZTtMO64HotH+zFTIiP/n1LTyuhCaAJNflbnEXlCOczMRFIfe0KfbTl156Wq5PbS79vgkFdijAuFvATkgrZkjqxhvavREKtlMPCLGON7ko1iVxAl+y12K7vZHoexKq0Kx3V5nCggd+SUPn4s5wmq8EWOs+pTrGAm7aKHuhwlX0EAghxSVoozDCkxOtc4SK6y/cyYD4RPsWJTrYvVLPYCErL8LHupNHf4fqw+KpquV4hO+XZGcVN98Gc6kgZJHvxPJu5h7Z0SPunpFBZ3UgWoBn6lTmr9gdM0Vcbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgRkvFcTUczR4dqthQhvspi28MyIr9yzaXniJcBBx6Q=;
 b=RtaQCxicwwlxD5YJkXy6aauHz1+UbY14M0YQ8Z+cEnzj3j+MKZ/2Wn++tWqVahrWg+MrJ6L+MkjZ5La41eIdW9J0ME+XGwlhBoBJe0VAo6SbB+M3wGEhsRrgQDLutUVI7bgv2H1qCkQpfvOUtxpdPoB66TAYJq/bJXVP3gdN38tpV3Nnp5aMmiVYdr0HMDizI/QdZ/8Ohh/ej1GxDrgC86EcMRKfzNz9QegcrE0C/sUxAZgML6IUJM2BKVTC/eWSSUST7AlFYes0PSCj/rLZU1TniGkPkIVqv6MaaDXVg+jmxQ2KMyJevCBXvc1PWs0khGMqyBqR1kGhhpMdPU9avg==
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 23:30:36 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::3d) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Thu,
 5 Mar 2026 23:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 23:30:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 15:30:22 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 15:30:21 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 15:30:20 -0800
Date: Thu, 5 Mar 2026 15:30:19 -0800
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
Message-ID: <aaoSC74sKispAUtl@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
 <aanwTQtMMplXY3du@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aanwTQtMMplXY3du@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: b85521ca-8887-4536-5442-08de7b0f33df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	jNfywfOKXYiMs6pNl0HpLsjBX7hxZ8tgWJq9OQwXYWR3xOsGd7mjY5sy94kBNJu61rclFHX0SkcXOSB+lCkntaJlKDcNp/shAbgZxwD9NdPhaWtXT0hk/YVJQpNICak4yz/yxNiJDF7JqpY5WBIVABcUrJZFPXRkE/JXqgG1+glzEr4+4uG3EKj3VQpHIzOX1QgDNoSiyPpbtYAID7ULBm6aSMlxKbvh+ogtmX+DwzhsrQn1P+pqc5+Ami3AoF9plI7vjMCi4/TNh6RAjuUjoOzLICRFCirdKhu1hIjq5uncusHxG/OAfrYJz0/SEn69vNcmFaQAfdqHdfxbC6m6mzFv5tWEOS1JCCZeyFkgA3fK3t1ewuweisUu7fXWw5uoEQDNtENwUInVafu66BcSgOaT6oKYu4u7w/L/MyEkBrtp+DKJfX88whDCrsEK0+/ULmJP7jsgN4p9maa5ty8roz1rVpmTjRdw4bNV/FwZ18ZYa4+7BMRBitV0a0nmpVTtPDAkTg79i4VvOYxXmyF+1h+e98dS/yZ3ne3z0Fk1dS/FQpBs8cFRjGpD1gQUHFOgarSNKDxOUWXQrnQ83IUTk0RxUSu0xjU/fT2+yCQ1nAIG+am4if6kMMB0PKPqxUSwftpF/q31KZKdP1VOzi4SbaHxOafVk2PPLPrtSYVQ//yQUVEIP3+8ZaoNLry8dOP3JE8q9JMdFf5TavO0Evc5x6/gVrQEYZL3F4ayA6nI1H1bKD55OaQCpwVNo3BWPQJ1CByMq2tynSItljVQUHU0Jw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Uy6nVU6jKaNSeQd2Hcb3O3/wbAPYu9DNgcAF9k1RmnfXZRfcbhRb0/1e5CXFEm06bYV1+f2hdHtUJA9jRyOFg7g050fu3ofpDSblj9pi6p3wBLtpNkyqozEr06PdMhq1jrK4VgSnKA05otJj830O7LMvIm/u+MLfDLUVnU2NTFXVXCMmFpubaqiFRWxeo88eCesc+EMqcgQc3EXz67f7mWJLcIV7En9QF188PDSCwwljFTt9Zp4zfgwW6Eqspzs3RKI3MZqj/JwjsqkxFpOfY7K1+QHYFe3y9ghEaQkO6hksz8hjvVrhbZ9DTLxsgZr4WXAGgyWa5rmZD8GAhqmxS49EsFi3hR/xyQjUkc9337dh8N0FQXieE+H9OKIWKy7pDkZEl3T80U/j0PmJpjno3vPT+KsbINWcaaFx1kZZl4F+jl2Ju8X98Hu1YXfv5qir
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 23:30:35.7880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85521ca-8887-4536-5442-08de7b0f33df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
X-Rspamd-Queue-Id: A2F7F21957F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21461-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:06:24PM -0800, Nicolin Chen wrote:
> On Thu, Mar 05, 2026 at 03:24:30PM +0000, Robin Murphy wrote:
> > On 2026-03-05 5:21 am, Nicolin Chen wrote:
> > > Though it'd be ideal to block it immediately in the ISR, it cannot be done
> > > because an STE update would require another CFIG_STE command that couldn't
> > > finish in the context of an ISR handling a CMDQ error.
> > 
> > Why not? As soon as we've acked GERRORN.CMDQ_ERR, command consumption will
> > resume and we're free to do whatever we fancy. Admittedly this probably
> > represents more work than we *want* to be doing in the SMMU's IRQ handler
> > (arguably even in a thread, since all the PCI housekeeping isn't really the
> > SMMU driver's own problem), but I would say the workqueue is a definite
> > design choice, not a functional requirement.
> 
> Hmm, you are right, after writel(gerror, ARM_SMMU_GERRORN), it
> would be doable.
> 
> Though SID->pdev conversion requires streams_mutex, which can't
> happen in ISR?

I forgot that (if we don't mind the core-level domain attachment
and the driver-level ATS state being temporarily out of sync with
the physical STE) SID alone was enough for a surgical STE update
in the ISR to unset EATS.

Thanks
Nicolin

> > > +static void arm_smmu_atc_recovery_worker(struct work_struct *work)
> > > +{
> > > +	struct arm_smmu_atc_recovery_param *param =
> > > +		container_of(work, struct arm_smmu_atc_recovery_param, work);
> > > +	struct pci_dev *pdev;
> > > +
> > > +	scoped_guard(mutex, &param->smmu->streams_mutex) {
> > > +		struct arm_smmu_master *master;
> > > +
> > > +		master = arm_smmu_find_master(param->smmu, param->sid);
> > 
> > The only thing SMMU-specific about this seems to be the use of
> > arm_smmu_find_master() to resolve the device, which could just as well be
> > done upon submission anyway - why isn't this a generic IOMMU/IOPF mechanism?
> 
> You mean treating this as a page fault? That's an interesting idea.
> 
> So, the IOMMU-level fence could be done in arm_smmu_page_response().
> 
> > > +static int arm_smmu_sched_atc_recovery(struct arm_smmu_device *smmu, u32 sid)
> > > +{
> > > +	struct arm_smmu_atc_recovery_param *param;
> > > +
> > > +	param = kzalloc_obj(*param, GFP_ATOMIC);
> > > +	if (!param)
> > > +		return -ENOMEM;
> > > +	param->smmu = smmu;
> > > +	param->sid = sid;
> > > +
> > > +	INIT_WORK(&param->work, arm_smmu_atc_recovery_worker);
> > > +	queue_work(system_unbound_wq, &param->work);
> > 
> > Might it make more sense to have a single work item associated with the
> > list_head and use the latter as an actual queue, such that the work runs
> > until the list is empty, then here at submisison time we do the list_add()
> > and schedule_work()? That could perhaps even be a global queue, since ATS
> > timeouts can hardly be expected to be a highly-contended high-perfoamnce
> > concern.
> 
> That sounds like the IOPF implementation. Maybe inventing another
> IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
> make things cleaner.
> 
> > Right now it seems the list is barely doing anything - a "deduplication"
> > mechanism that only works if multiple resets for the same device happen to
> > have their work scheduled concurrently seems pretty ineffective.
> 
> From my testing results, it does effectively block duplications, so
> I think it's somehow meaningful.
> 
> If I wasn't wrong, the duplicated ATC timeout might come from this
> exact reset thread, as it did a CMDQ_OP_CFGI_STE while the CONS was
> still pointing to previous CMDQ_OP_ATC_INV.
> 
> IIUIC, the IOPF queue doesn't expect duplicated PRI events. So, it
> might invoke the handler twice if there is a duplication. The core
> handling list_add() might need a deduplication.
> 
> > > @@ -456,6 +555,27 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> > >   	 * not to touch any of the shadow cmdq state.
> > >   	 */
> > >   	queue_read(cmd, Q_ENT(q, cons), q->ent_dwords);
> > > +
> > > +	if (idx == CMDQ_ERR_CERROR_ATC_INV_IDX) {
> > > +		/*
> > > +		 * Since commands can be issued in batch making it difficult to
> > > +		 * identify which CMDQ_OP_ATC_INV actually timed out, the driver
> > > +		 * must ensure only CMDQ_OP_ATC_INV commands for the same device
> > > +		 * can be batched.
> > 
> > But this *is* "the driver" - arm_smmu_atc_inv_domain() is literally further
> > down this same C file, and does not do what this comment is saying it must
> > do, so how are you expecting this to work correctly?
> 
> Oh, that's a big miss..
> 
> I imaged these changes to be based on the arm_smmu_invs series,
> where it could break the ATC in the batching function. Here, it
> should have made some change to arm_smmu_atc_inv_domain().
> 
> Thanks
> Nicolin

