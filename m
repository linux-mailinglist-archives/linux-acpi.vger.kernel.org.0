Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385FA124CDF
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLRQNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Dec 2019 11:13:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46143 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLRQNc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Dec 2019 11:13:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so2868366wrl.13
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2019 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PXvdq6qWFeAmRkgUP6ivkMlcnTIDIWAWnzZnITD9gIQ=;
        b=TO3udsaM0wHSFHtqq3lx9Vpw/cuxpABpx0ZL6fQor8a23g56txPXE2jNc4FuScZ3Fi
         LXZKSp/98TUo9nRfA1Ld8V1forbku0Bk8tJ7SeCtxPlk3DYZ/BK9L2TwV3xh0U+J3QHt
         JSei+y68UXeLCYVSEiEOrmRm+hf9jKrLSy3waZ06SVfY3S32E4pocftRNi7yO6SsbTOE
         unPpzZIPwL0bn7imVjhmGKGqJ7kxahOEYFOwX2CzXvusbd5u0aHn0r4+JtE8EWQKZb4G
         tXYPPjKJCaNiGfLjAylBAAaSiaK44cjKb9WiZ+3GgVPYjq+oQZQM5pfgoyCaaxXTBT4G
         e4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PXvdq6qWFeAmRkgUP6ivkMlcnTIDIWAWnzZnITD9gIQ=;
        b=f7xXDiQau3YgisqIv1jjeE0xY8Q3NDirPsfszBZebrR2eL3in9kwtl4il4K1df6Vwk
         OXdGuXsY5wEBk/7IT8NmY2q4RC0vMSFKFWUqNOCEXX5pezSYAE4qD23htfNa3l5/EGeC
         skg5b8sXe/ZrFx2nzJTEo2qKu9bG7do/PUI9LOYNHEZggIRjLQqR0TkeKrzUrDRSVroo
         QrkfFNBkOJvq2zMisJ0vcoeo+dqeqhLncV5rYdw0Qv92g1WrPRnAyrfdbhEtYT2hy8nD
         8PTSEqm6E1i9lfAzPU0G8Mj8MVBsE+0l9J62h62E3myt74h0yrlCa1+fFaWM7ZT/jWvt
         KfEA==
X-Gm-Message-State: APjAAAUwiNDUaBUfzhe96jhtuvEkG8Sa0aLD06dZTs9EeOpEHfoJwo7O
        +1xxLybidvN9Zn7NqtFwcITNaA==
X-Google-Smtp-Source: APXvYqz3/O6xngUMvfQZDBfpU617F1qkmNRS56a4TzmWh1A2QPAdGPRnlUyBsXlERsvvTcYDCOXcBA==
X-Received: by 2002:adf:f244:: with SMTP id b4mr3692481wrp.88.1576685610515;
        Wed, 18 Dec 2019 08:13:30 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id b17sm3034639wrp.49.2019.12.18.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:13:29 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:13:23 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20191218161323.GI2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-14-jean-philippe@linaro.org>
 <551ce08c-4160-72c9-05b5-97799f6e5d25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551ce08c-4160-72c9-05b5-97799f6e5d25@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2019 at 11:17:55AM +0100, Auger Eric wrote:
> > +static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
> > +{
> > +	int ret;
> > +	int features;
> > +	int num_pasids;
> > +	struct pci_dev *pdev;
> > +
> > +	if (!dev_is_pci(master->dev))
> > +		return -ENODEV;
> > +
> > +	pdev = to_pci_dev(master->dev);
> > +
> > +	features = pci_pasid_features(pdev);
> > +	if (features < 0)
> > +		return -ENODEV;
> why -ENODEV?

Right that should return features. The below should return num_pasids.

> > +
> > +	num_pasids = pci_max_pasids(pdev);
> > +	if (num_pasids <= 0)
> > +		return -ENODEV;
> > +
> > +	ret = pci_enable_pasid(pdev, features);
> > +	if (!ret)
> > +		master->ssid_bits = min_t(u8, ilog2(num_pasids),
> > +					  master->smmu->ssid_bits);
> so here we are ;-)
> > +	return ret;
> > +}
> > +
> > +static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	if (!dev_is_pci(master->dev))
> > +		return;
> > +
> > +	pdev = to_pci_dev(master->dev);
> > +
> > +	if (!pdev->pasid_enabled)
> > +		return;
> > +
> > +	master->ssid_bits = 0;
> > +	pci_disable_pasid(pdev);
> > +}
> > +
> >  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >  {
> >  	unsigned long flags;
> > @@ -2851,13 +2894,16 @@ static int arm_smmu_add_device(struct device *dev)
> >  
> >  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> >  
> > +	/* Note that PASID must be enabled before, and disabled after ATS */
> > +	arm_smmu_enable_pasid(master);
> No error handling?

The device still works if PASID isn't supported or cannot be enabled, it
just won't have some capabilities (IOMMU_DEV_FEAT_AUX and
IOMMU_DEV_FEAT_SVA), so I don't think add_device should return an error.

But it's a good point, I think at least printing an error like
arm_smmu_enable_ats() does would be better.

Thanks,
Jean
