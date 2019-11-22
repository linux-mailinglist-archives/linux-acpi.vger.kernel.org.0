Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B61074E7
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKVPcJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 10:32:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51410 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVPcJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 10:32:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so7624000wme.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o0Nf3geLcg9Iv2VN5DaVX7zHaQKSf02VaMj3Oj40g7s=;
        b=cmkuqhGjOwfdSwkZ3ss+85BQf54k5DwK5drxsgJ59aUf6B/dAvLhdQ3svBWsyNuhOR
         t2lOL5vWRytQrNu3oBk9S+q/yVsjrSNyFPIvcSDyEH0XASpUvwUBRwMKkEC1LAZxJK8Z
         /jLp+8jON45HOASnNIf9x/9YrfeFqw4v+CfizFYbWJl38eWeYg4fKmj/JSRzGxPqARQI
         C3t1Tm6A/E8EBhc2zA6gmdoNjPZ6fky+ZGuvqVqW6QoSuHMZ5BwEcLEnmAIVWkFHxzhj
         L8t4ZzVHn/mU77X5BkPc7byb8I4PVtKasmkxJwwzQs+FjoJ6wEfFg584rN3oNW7pyahH
         8igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o0Nf3geLcg9Iv2VN5DaVX7zHaQKSf02VaMj3Oj40g7s=;
        b=TfaGUqbaRd8u64edHtY4yRcrXs6Rg1GFognSK5zw3y/85nBsICUoz5hpv9ufsuu0U6
         xNTFMSN3VISYMX7zOoo4UYwwh4NCiMKHLGsoz4ZQQq8KoY/FXIZI1Zl+Hf8iGytXA4nc
         RD/4w8b9Sg/veKiFdddxtX7ujfRXvJjF/Y0r0JM6SyGRWILq29ppsGWkaNQk198fSF3Z
         /br2JwyZY4Jf7RydmF83z4tOx9wIux6uyftvMxsrJse1u13ofcSQZ1KFMl/nkBMLm++e
         0vydZBje8cj7TKaGOBTWnoA1L7fXvgZEqRVRZc8d9lsgyJH9ZrNWw9gHVLdYwERLrM/B
         Jm0Q==
X-Gm-Message-State: APjAAAWkflf05A644n8n/pc2AZRLSjg2gnHmWCj0IicIwBMXbKjIKch5
        w1w2jI1//W/NEDgGbqw4Yeb3ew==
X-Google-Smtp-Source: APXvYqxY6pHuhUWCVcZneY2M7eICkz+5eYgu7XtNfAm4R2SBBRGwg3zyF3DJRrQll9z97xbxElVU6Q==
X-Received: by 2002:a1c:6485:: with SMTP id y127mr3164184wmb.19.1574436726287;
        Fri, 22 Nov 2019 07:32:06 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o7sm6578349wrv.63.2019.11.22.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 07:32:05 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:32:03 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20191122153203.GB810215@lophozonia>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
 <20191108152508.4039168-7-jean-philippe@linaro.org>
 <20191111155007.00002021@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111155007.00002021@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 11, 2019 at 03:50:07PM +0000, Jonathan Cameron wrote:
> > +		cfg->l1ptr = dmam_alloc_coherent(smmu->dev, size,
> > +						 &cfg->l1ptr_dma,
> > +						 GFP_KERNEL | __GFP_ZERO);
> 
> As before.  Fairly sure __GFP_ZERO doesn't give you anything extra.

Indeed

> > +		if (!cfg->l1ptr) {
> > +			dev_warn(smmu->dev, "failed to allocate L1 context table\n");
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
> > +				   cfg->num_tables, GFP_KERNEL);
> > +	if (!cfg->tables) {
> > +		ret = -ENOMEM;
> > +		goto err_free_l1;
> > +	}
> > +
> > +	/* With two levels, leaf tables are allocated lazily */
> This comment is a kind of odd one.  It is actually talking about what
> 'doesn't' happen here I think..
> 
> Perhaps /*
>          * Only allocate a leaf table for linear case.
>          * With two levels, the leaf tables are allocated lazily.
> 	 */

Yes, that's clearer

> > +	if (!cfg->l1ptr) {
> > +		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
> > +						   max_contexts);
> > +		if (ret)
> > +			goto err_free_tables;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_tables:
> > +	devm_kfree(smmu->dev, cfg->tables);
> > +err_free_l1:
> > +	if (cfg->l1ptr)
> > +		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
> 
> This cleanup only occurs if we have had an error.
> Is there potential for this to rerun at some point later?  If so we should
> be careful to also reset relevant pointers - e.g. cfg->l1ptr = NULL as
> they are used to control the flow above.

Yes we should definitely clear l1ptr. The domain may be managed by a
device driver, and if attach_dev() fails they will call domain_free(),
which checks this pointer. Plus nothing prevents them from calling
attach_dev() again with the same domain.

> If there is no chance of a rerun why bother cleaning them up at all?  Something
> has gone horribly wrong so let the eventual smmu cleanup deal with them.

The domain is much shorter-lived than the SMMU device, so we need this
cleanup.

> > +	return ret;
> >  }
> >  
> >  static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
> >  {
> > +	int i;
> >  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> >  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> > +	size_t num_leaf_entries = 1 << cfg->s1cdmax;
> > +	struct arm_smmu_cd_table *table = cfg->tables;
> >  
> > -	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
> > +	if (cfg->l1ptr) {
> > +		size_t size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
> > +
> > +		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
> 
> 		As above, if we can call this in a fashion that makes sense
> 		other than in eventual smmu tear down, then we need to be
> 		careful to reset the pointers.   If not, then why are we clearing
> 		managed resourced by hand anyway?

Yes, we call this on the error cleanup path (not only domain_free()), so
it needs to leave the domain in a usable state.

Thanks,
Jean
