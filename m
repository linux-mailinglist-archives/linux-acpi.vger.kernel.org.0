Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEB530A881
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBANTF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 08:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbhBANR5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 08:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612185390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V789mmFnjan6oLONdkqrHYRYSDll5I0KEccN8OhHrC8=;
        b=W08GpBQTpIWs2TxBxMEVj+4EDlQTuBBTga22AEy7SDUiZzq5URkG0xvJZtENDs2fxPpIVO
        88UISKuApt4CCFTyeoxoEbyVWayYHnEkGKt5jnqpwUIlOW96kDfC+G17OF/LLV7tPidEwE
        7lQe/l7kCARKjO+BOGExWyhB4gOKO3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-yqlUM8clMEiWAteaWVQLrg-1; Mon, 01 Feb 2021 08:16:26 -0500
X-MC-Unique: yqlUM8clMEiWAteaWVQLrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C4811935780;
        Mon,  1 Feb 2021 13:16:23 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA2B10016DB;
        Mon,  1 Feb 2021 13:16:18 +0000 (UTC)
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org,
        lenb@kernel.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, robh+dt@kernel.org,
        Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
        robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org,
        baolu.lu@linux.intel.com
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com> <YBfiIwdVP1dXg7Yt@myrica>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <47a65f65-26cb-de27-049a-48f2d083964a@redhat.com>
Date:   Mon, 1 Feb 2021 14:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <YBfiIwdVP1dXg7Yt@myrica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 2/1/21 12:12 PM, Jean-Philippe Brucker wrote:
> On Sun, Jan 31, 2021 at 07:29:09PM +0100, Auger Eric wrote:
>> Hi Jean,
>>
>> Some rather minor comments§questions below that may not justify a respin.
>>
>> On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
>>> -static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
>>> +bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
>>>  {
>>> -	return false;
>>> +	/* We're not keeping track of SIDs in fault events */
>> shall we? [*] below
> 
> That would require storing the incoming SID into the iommu_fault_event
> struct, and retrieve it in arm_smmu_page_response(). Easy enough, but I
> don't think it's needed for existing devices.
OK
> 
>>> +	if (master->num_streams != 1)
>>> +		return false;
> [...]
>>> +static int arm_smmu_page_response(struct device *dev,
>>> +				  struct iommu_fault_event *unused,
>>> +				  struct iommu_page_response *resp)
>>> +{
>>> +	struct arm_smmu_cmdq_ent cmd = {0};
>>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>>> +	int sid = master->streams[0].id;
>> [*]
>>> +
>>> +	if (master->stall_enabled) {
>>> +		cmd.opcode		= CMDQ_OP_RESUME;
>>> +		cmd.resume.sid		= sid;
>>> +		cmd.resume.stag		= resp->grpid;
>>> +		switch (resp->code) {
>>> +		case IOMMU_PAGE_RESP_INVALID:
>> add fallthrough?
> 
> I think fallthrough is mainly useful to tell reader and compiler that a
> break was omitted on purpose. When two cases are stuck together the intent
> to merge the flow is clear enough in my opinion. GCC's
> -Wimplicit-fallthrough doesn't warn in this case.
OK
> 
>>> +		case IOMMU_PAGE_RESP_FAILURE:
>>> +			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
>>> +			break;
> [...]
>>> +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>>> +{
>>> +	int ret;
>>> +	u32 reason;
>>> +	u32 perm = 0;
>>> +	struct arm_smmu_master *master;
>>> +	bool ssid_valid = evt[0] & EVTQ_0_SSV;
>>> +	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
>>> +	struct iommu_fault_event fault_evt = { };
>>> +	struct iommu_fault *flt = &fault_evt.fault;
>>> +
>>> +	/* Stage-2 is always pinned at the moment */
>>> +	if (evt[1] & EVTQ_1_S2)
>>> +		return -EFAULT;
>>> +
>>> +	master = arm_smmu_find_master(smmu, sid);
>>> +	if (!master)
>>> +		return -EINVAL;
>>> +
>>> +	if (evt[1] & EVTQ_1_RnW)
>>> +		perm |= IOMMU_FAULT_PERM_READ;
>>> +	else
>>> +		perm |= IOMMU_FAULT_PERM_WRITE;
>>> +
>>> +	if (evt[1] & EVTQ_1_InD)
>>> +		perm |= IOMMU_FAULT_PERM_EXEC;
>>> +
>>> +	if (evt[1] & EVTQ_1_PnU)
>>> +		perm |= IOMMU_FAULT_PERM_PRIV;
>>> +
>>> +	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
>>> +	case EVT_ID_TRANSLATION_FAULT:
>>> +	case EVT_ID_ADDR_SIZE_FAULT:
>>> +	case EVT_ID_ACCESS_FAULT:
>>> +		reason = IOMMU_FAULT_REASON_PTE_FETCH;
>> Doesn't it rather map to IOMMU_FAULT_REASON_ACCESS?
>> /* access flag check failed */"
> 
> Good point, I guess it didn't exist when I wrote this. And ADDR_SIZE_FAULT
> corresponds to IOMMU_FAULT_REASON_OOR_ADDRESS now, right?
yes it dies
> 
> By the way the wording on those two fault reasons, "access flag" and
> "stage", seems arch-specific - x86 names are "accessed flag" and "level".
> 
>>> +		break;
>>> +	case EVT_ID_PERMISSION_FAULT:
>>> +		reason = IOMMU_FAULT_REASON_PERMISSION;
>>> +		break;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	if (evt[1] & EVTQ_1_STALL) {
>>> +		flt->type = IOMMU_FAULT_PAGE_REQ;
>>> +		flt->prm = (struct iommu_fault_page_request) {
>>> +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
>>> +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
>>> +			.perm = perm,
>>> +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
>>> +		};
>>> +
>>> +		if (ssid_valid) {
>>> +			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
>>> +			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
>>> +		}
>>> +	} else {
>>> +		flt->type = IOMMU_FAULT_DMA_UNRECOV;
>>> +		flt->event = (struct iommu_fault_unrecoverable) {
>>> +			.reason = reason,
>>> +			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID |
>>> +				 IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID,
>> nit: shall IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID be set here? Supported
>> unrecoverable faults feature the IPA field which is UNKNOWN for S1
>> translations. fetch_addr rather was
>> corresponding to WALK_EABT.Fetch_addr to me.
> 
> Right I should drop the IPA part entirely, since we don't report S2 faults
> in this patch.
OK

But as I mentioned this can be fixed separately if you don't have other
comments on this version.

Thanks

Eric
> 
> Thanks,
> Jean
> 
>>> +			.perm = perm,
>>> +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
>>> +			.fetch_addr = FIELD_GET(EVTQ_3_IPA, evt[3]),
>>> +		};
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

