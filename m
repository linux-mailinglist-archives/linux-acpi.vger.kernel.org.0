Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEC13A8AE
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2020 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgANLwh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jan 2020 06:52:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43421 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANLwh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2020 06:52:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so11853933wre.10
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2020 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IzwdNUfwlcqLxXSve6wb9StsyrN71lEbIfR41dllFLE=;
        b=nHwWTsMXEiHgMlLp3rhEKjlY4oFiFN8uVx7EJmL5HpoMLn17G6GskriKC2J4FFqDUf
         D5PQSR5bGBe2KBkkR2zFboV/+9i2TmSPBkL7OTbNdNiHX7nk7ICkuK4+TDYSmsObTwlN
         OiLPLpXLq1/M83nG9MZ4HV3/E8nkRsHlO+3UGguEfdmsc46vGQLVsOn5TDTpRV54ob4n
         pfPb5QzbcX59Yso+X81V+w/rj0PdB4UueRJp1lnyRPXgrA9EDAaNr1NIgCRHQnNRf4Px
         4jf1EDSskOFU/ovVyTUDM3aMNE2/F5yIbTVFheDVn7pktx7l7R1XqxTCuWrnDyXVGPM4
         Ul9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IzwdNUfwlcqLxXSve6wb9StsyrN71lEbIfR41dllFLE=;
        b=QoZ6ErAw19SqwelJzWMT5AMhkEnHUcVPUkFeMiXmswe54EHRNTwUJq4Q44jJYHi4OB
         BS4t0k6U51VD/qSmdN2DhipALrn2TBbrwugl5B5//bCIOFdlGPvbs0pC1GLR3TgMM5Oi
         JUmJEbnBsCUqhtzcMRv5Cem47R8oL4HHR7/iN61bfneRxNYlbPhosFY1XyHoR6e7VKrp
         1Jxy23fs/GDuMOBXNmD+zcFm9tto/mOSlPemNxKTu4K3pDFyElZwaglseK+40BYrqTKC
         KiePxVre7ZavJRJfRs7KnY7LAUf+GSzzNS4/SfEnIW75rLVRt2rwswvRWOAY7s39MSXI
         iZAg==
X-Gm-Message-State: APjAAAVfhYMy67UBng6HizHnJaItM8MEeLenHHaM7mRnlfQCb/gUXVOz
        jPnh7pK36up65C3J3ErIOmIKv+DGhl4=
X-Google-Smtp-Source: APXvYqz9ANL4J4N9FkoeCEsa+reFmsBRsdemTWxAkjYGsn5VOn30+AuMczjNSCVZhAF6FpG81uDvcw==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr24916169wru.220.1579002755460;
        Tue, 14 Jan 2020 03:52:35 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v22sm18105022wml.11.2020.01.14.03.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 03:52:34 -0800 (PST)
Date:   Tue, 14 Jan 2020 12:52:30 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 06/13] iommu/arm-smmu-v3: Add context descriptor
 tables allocators
Message-ID: <20200114115230.GA1799@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-7-jean-philippe@linaro.org>
 <20200114110651.GA29222@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114110651.GA29222@willie-the-truck>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 14, 2020 at 11:06:52AM +0000, Will Deacon wrote:
> >  /* Context descriptor manipulation functions */
> > +static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
> > +					struct arm_smmu_cd_table *table,
> > +					size_t num_entries)
> > +{
> > +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> > +
> > +	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
> > +					 GFP_KERNEL);
> > +	if (!table->ptr) {
> > +		dev_warn(smmu->dev,
> > +			 "failed to allocate context descriptor table\n");
> > +		return -ENOMEM;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
> > +					struct arm_smmu_cd_table *table,
> > +					size_t num_entries)
> > +{
> > +	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> > +
> > +	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
> > +}
> 
> I think we'd be better off taking the 'arm_smmu_s1_cfg' as a parameter here
> instead of the table pointer and a num_entries value, since the code above
> implies that we support partial freeing of the context descriptors.
> 
> I can do that as a follow-up patch if you agree. Thoughts?

Do you mean only changing the arguments of arm_smmu_free_cd_leaf_table(),
or arm_smmu_alloc_cd_leaf_table() as well? For free() I agree, for alloc()
I'm not sure it would look better.

For my tests I have a debug patch that allocates PASIDs randomly which
quickly consumes DMA for leaf tables. So I do have to free the leaves
individually when they aren't used, but it will be easy for me to update.

Thanks,
Jean
