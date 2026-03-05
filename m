Return-Path: <linux-acpi+bounces-21421-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD2EB9GgqWnGAwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21421-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:27:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2032147E8
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3095E3016ED4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637027A92E;
	Thu,  5 Mar 2026 15:24:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF243C276F;
	Thu,  5 Mar 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724282; cv=none; b=UhFABbojmdIjFw/FA9U9D652C38ad2TRq6+Wn9vSnJUEfMS527P6rx86t+QKKvsBF6hP3hx25AInsAsEvAmc6+AWaWjxrPZu0g1p3BAoEFuQPTGYUUW2xaLMdUtSa5xTH9Dw2dSchXTCB5stiiGG00Cw5wyR8BrPCxZUgwxAqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724282; c=relaxed/simple;
	bh=FgKMMvhMUx39Ae3ouh6gcxllAs/YZMwtXQ6m8jbzCnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knvKCkTK8CQC3qb/WCP0rC7rFV8vVop/MkjciaKcFW510VXzRU02zMlcRK7otYUsOinU9UiS+0uZPGWPbh4ESoV3ZfpQxOfMhPnwUEMaf86HMTwBwkNW0K2yt7KB2zkM8rIBFQGoqeo99Hx3dPnwBqCQX8jSseZ3L4Hy+DLbRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFE6339;
	Thu,  5 Mar 2026 07:24:30 -0800 (PST)
Received: from [10.57.48.84] (unknown [10.57.48.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10D663F73B;
	Thu,  5 Mar 2026 07:24:32 -0800 (PST)
Message-ID: <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
Date: Thu, 5 Mar 2026 15:24:30 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, joro@8bytes.org,
 bhelgaas@google.com, jgg@nvidia.com
Cc: rafael@kernel.org, lenb@kernel.org, praan@google.com, kees@kernel.org,
 baolu.lu@linux.intel.com, smostafa@google.com,
 Alexander.Grest@microsoft.com, kevin.tian@intel.com,
 miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7A2032147E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21421-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,linux-acpi@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On 2026-03-05 5:21 am, Nicolin Chen wrote:
> Currently, when GERROR_CMDQ_ERR occurs, the arm_smmu_cmdq_skip_err() won't
> do anything for the CMDQ_ERR_CERROR_ATC_INV_IDX.
> 
> When a device wasn't responsive to an ATC invalidation request, this often
> results in constant CMDQ errors:
>    unexpected global error reported (0x00000001), this could be serious
>    CMDQ error (cons 0x0302bb84): ATC invalidate timeout
>    unexpected global error reported (0x00000001), this could be serious
>    CMDQ error (cons 0x0302bb88): ATC invalidate timeout
>    unexpected global error reported (0x00000001), this could be serious
>    CMDQ error (cons 0x0302bb8c): ATC invalidate timeout
>    ...
> 
> An ATC invalidation timeout indicates that the device failed to respond to
> a protocol-critical coherency request, which means that device's internal
> ATS state is desynchronized from the SMMU.
> 
> Furthermore, ignoring the timeout leaves the system in an unsafe state, as
> the device cache may retain stale ATC entries for memory pages that the OS
> has already reclaimed and reassigned. This might lead to data corruption.
> 
> The only safe recovery action is to issue a PCI reset, which guarantees to
> flush all internal device caches and recover the device.
> 
> Read the ATC_INV command that led to the timeouts, and schedule a recovery
> worker to reset the device corresponding to the Stream ID. If reset fails,
> keep the device in the resetting/blocking domain to avoid data corruption.
> 
> Though it'd be ideal to block it immediately in the ISR, it cannot be done
> because an STE update would require another CFIG_STE command that couldn't
> finish in the context of an ISR handling a CMDQ error.

Why not? As soon as we've acked GERRORN.CMDQ_ERR, command consumption 
will resume and we're free to do whatever we fancy. Admittedly this 
probably represents more work than we *want* to be doing in the SMMU's 
IRQ handler (arguably even in a thread, since all the PCI housekeeping 
isn't really the SMMU driver's own problem), but I would say the 
workqueue is a definite design choice, not a functional requirement.

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   5 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 131 +++++++++++++++++++-
>   2 files changed, 132 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 3c6d65d36164f..8789cf8294504 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -803,6 +803,11 @@ struct arm_smmu_device {
>   
>   	struct rb_root			streams;
>   	struct mutex			streams_mutex;
> +
> +	struct {
> +		struct list_head	list;
> +		spinlock_t		lock; /* Lock the list */
> +	} atc_recovery;
>   };
>   
>   struct arm_smmu_stream {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f0783..de182c27c77c4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -106,6 +106,8 @@ static const char * const event_class_str[] = {
>   	[3] = "Reserved",
>   };
>   
> +static struct arm_smmu_master *
> +arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid);
>   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
> @@ -174,6 +176,13 @@ static void queue_inc_cons(struct arm_smmu_ll_queue *q)
>   	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
>   }
>   
> +static u32 queue_prev_cons(struct arm_smmu_ll_queue *q, u32 cons)
> +{
> +	u32 idx_wrp = (Q_WRP(q, cons) | Q_IDX(q, cons)) - 1;
> +
> +	return Q_OVF(cons) | Q_WRP(q, idx_wrp) | Q_IDX(q, idx_wrp);
> +}
> +
>   static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
>   {
>   	struct arm_smmu_ll_queue *llq = &q->llq;
> @@ -410,6 +419,97 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>   		u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);
>   }
>   
> +/* ATC recovery upon ATC invalidation timeout */
> +struct arm_smmu_atc_recovery_param {
> +	struct arm_smmu_device *smmu;
> +	struct pci_dev *pdev;
> +	u32 sid;
> +
> +	struct work_struct work;
> +	struct list_head node;
> +};
> +
> +static void arm_smmu_atc_recovery_worker(struct work_struct *work)
> +{
> +	struct arm_smmu_atc_recovery_param *param =
> +		container_of(work, struct arm_smmu_atc_recovery_param, work);
> +	struct pci_dev *pdev;
> +
> +	scoped_guard(mutex, &param->smmu->streams_mutex) {
> +		struct arm_smmu_master *master;
> +
> +		master = arm_smmu_find_master(param->smmu, param->sid);
> +		if (!master || WARN_ON(!dev_is_pci(master->dev)))
> +			goto free_param;
> +		pdev = to_pci_dev(master->dev);
> +		pci_dev_get(pdev);
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &param->smmu->atc_recovery.lock) {
> +		struct arm_smmu_atc_recovery_param *e;
> +
> +		list_for_each_entry(e, &param->smmu->atc_recovery.list, node) {
> +			/* Device is already being recovered */
> +			if (e->pdev == pdev)
> +				goto put_pdev;
> +		}
> +		param->pdev = pdev;
> +		list_add(&param->node, &param->smmu->atc_recovery.list);
> +	}
> +
> +	/*
> +	 * Stop DMA (PCI) and block ATS (IOMMU) immediately, to prevent memory
> +	 * corruption. This must take pci_dev_lock to prevent any racy unplug.
> +	 *
> +	 * If pci_dev_reset_iommu_prepare() fails, pci_reset_function will call
> +	 * it again internally.
> +	 */
> +	pci_dev_lock(pdev);
> +	pci_clear_master(pdev);
> +	if (pci_dev_reset_iommu_prepare(pdev))
> +		pci_err(pdev, "failed to block ATS!\n");
> +	pci_dev_unlock(pdev);
> +
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
> +	scoped_guard(spinlock_irqsave, &param->smmu->atc_recovery.lock)
> +		list_del(&param->node);
> +put_pdev:
> +	pci_dev_put(pdev);
> +free_param:
> +	kfree(param);
> +}

The only thing SMMU-specific about this seems to be the use of 
arm_smmu_find_master() to resolve the device, which could just as well 
be done upon submission anyway - why isn't this a generic IOMMU/IOPF 
mechanism?

> +
> +static int arm_smmu_sched_atc_recovery(struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct arm_smmu_atc_recovery_param *param;
> +
> +	param = kzalloc_obj(*param, GFP_ATOMIC);
> +	if (!param)
> +		return -ENOMEM;
> +	param->smmu = smmu;
> +	param->sid = sid;
> +
> +	INIT_WORK(&param->work, arm_smmu_atc_recovery_worker);
> +	queue_work(system_unbound_wq, &param->work);

Might it make more sense to have a single work item associated with the 
list_head and use the latter as an actual queue, such that the work runs 
until the list is empty, then here at submisison time we do the 
list_add() and schedule_work()? That could perhaps even be a global 
queue, since ATS timeouts can hardly be expected to be a 
highly-contended high-perfoamnce concern.

Right now it seems the list is barely doing anything - a "deduplication" 
mechanism that only works if multiple resets for the same device happen 
to have their work scheduled concurrently seems pretty ineffective.

> +	return 0;
> +}
> +
>   void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>   			      struct arm_smmu_cmdq *cmdq)
>   {
> @@ -441,11 +541,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>   	case CMDQ_ERR_CERROR_ATC_INV_IDX:
>   		/*
>   		 * ATC Invalidation Completion timeout. CONS is still pointing
> -		 * at the CMD_SYNC. Attempt to complete other pending commands
> -		 * by repeating the CMD_SYNC, though we might well end up back
> -		 * here since the ATC invalidation may still be pending.
> +		 * at the CMD_SYNC. Rewind it to read the ATC_INV command.
>   		 */
> -		return;
> +		cons = queue_prev_cons(&q->llq, cons);
> +		fallthrough;
>   	case CMDQ_ERR_CERROR_ILL_IDX:
>   	default:
>   		break;
> @@ -456,6 +555,27 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>   	 * not to touch any of the shadow cmdq state.
>   	 */
>   	queue_read(cmd, Q_ENT(q, cons), q->ent_dwords);
> +
> +	if (idx == CMDQ_ERR_CERROR_ATC_INV_IDX) {
> +		/*
> +		 * Since commands can be issued in batch making it difficult to
> +		 * identify which CMDQ_OP_ATC_INV actually timed out, the driver
> +		 * must ensure only CMDQ_OP_ATC_INV commands for the same device
> +		 * can be batched.

But this *is* "the driver" - arm_smmu_atc_inv_domain() is literally 
further down this same C file, and does not do what this comment is 
saying it must do, so how are you expecting this to work correctly?

Thanks,
Robin.

> +		 */
> +		WARN_ON(FIELD_GET(CMDQ_0_OP, cmd[0]) != CMDQ_OP_ATC_INV);
> +
> +		/*
> +		 * If we failed to schedule a recovery worker, we would well end
> +		 * up back here since the ATC invalidation may still be pending.
> +		 * This gives us another chance to reschedule a recovery worker.
> +		 */
> +		arm_smmu_sched_atc_recovery(smmu,
> +					    FIELD_GET(CMDQ_ATC_0_SID, cmd[0]));
> +		return;
> +	}
> +
> +	/* idx == CMDQ_ERR_CERROR_ILL_IDX */
>   	dev_err(smmu->dev, "skipping command in error state:\n");
>   	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
>   		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
> @@ -3942,6 +4062,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>   {
>   	int ret;
>   
> +	INIT_LIST_HEAD(&smmu->atc_recovery.list);
> +	spin_lock_init(&smmu->atc_recovery.lock);
> +
>   	mutex_init(&smmu->streams_mutex);
>   	smmu->streams = RB_ROOT;
>   


