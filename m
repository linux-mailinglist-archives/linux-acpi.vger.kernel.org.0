Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8790712301F
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLQPVb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 10:21:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33008 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfLQPVb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 10:21:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so11768089wrq.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2019 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/U6kIWQCRrt5t46RzQq83Cexhdp96mlj0bDDsvo61J0=;
        b=zYpxZTb+W4CafynX/GjHKf3cPY+ZcFMKhPepfPIsR2ENTx1vIn6Qcj+OWPPMn78rvn
         8ndC9NFyie5drvYpo3BgXxap1zVlvHUw7Tp3zeqOCom9nhTtk8XnZ9PVVeWp59fjML+q
         md0iB6uixCMDeJAQvm1Dy741/FBYwIxlVuhB4OvmccJdlNQ5C5VG1/1pEAyRS8Rui4Cz
         Q8V633DYjfwnqDBdCv2Jzz/Bum12yws5o8/xTlLHVliu03pI/CGDZc0wgx/5bhQYaVhX
         JKeGrk+H7oFKNRtKza+FurEMK4Rh4OJWVScTuxx5EVgA/01UT5CgEcldpppYf1h/nVID
         rKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/U6kIWQCRrt5t46RzQq83Cexhdp96mlj0bDDsvo61J0=;
        b=Bzxh8RGWERVN9W8SFf0dm4gUWb4v8y5VULJtKmqF3rP7kVR/8LulPaicC+9Ntgt/I4
         1E5UjrI1zmdzFt72LZ8illOm2Cug5B17WQoM/8Hn5mEczp+MGpSi5XrzA1vbE91XLYUC
         Hd6VwTdgoZN9ZdevZeK1RTfUVoaa7/i7bh+seUTw2KMdTOSEBu4qWtG/hmzll+Ef4WNB
         053jYEY4nDbG7+iGg3efGbezjlDTF/Zz35ifk5gRh4Om83R2QTw3RA82kqYGJO/Z1k/k
         yjkyV2hXhW7zHMbvPWhtyeVsyB09ZKB1zJOwwybrBolHg9bm0Vqm31pJlclcA0L6vzHQ
         nkiw==
X-Gm-Message-State: APjAAAWDNWkBdvDyORy9zZdHmOCXal2ykPYae+Z9LQ6502gphym1k79p
        plUaLJTUoTTpiDxqSBvASgHrVA==
X-Google-Smtp-Source: APXvYqxGZpcrEU2hF1yXvjy3TQGwn9Ed0+ek9wFSXQ/mi7LzOCYo9KI6i5ueC9DEOAbG9y2v+MiMeg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr35905632wrl.97.1576596087819;
        Tue, 17 Dec 2019 07:21:27 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id s16sm25985278wrn.78.2019.12.17.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:21:27 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:21:08 +0100
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
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
Message-ID: <20191217152108.GB2305883@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-4-jean-philippe@linaro.org>
 <e5b9a017-585a-5425-77bd-be40b86010e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b9a017-585a-5425-77bd-be40b86010e6@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Eric,

On Tue, Dec 17, 2019 at 12:05:18PM +0100, Auger Eric wrote:
> > +		fwspec = dev_iommu_fwspec_get(dev);
> > +		if (!err && fwspec)
> > +			of_property_read_u32(master_np, "pasid-num-bits",
> > +					     &fwspec->num_pasid_bits);
> > +	}
> This patch dedicates to platform devices however I fail to understand,
> at that stage, how/when do you retrieve/store the same max capability
> for PCI devices?

For PCI devices, the max capability is only described by the PCIe PASID
capability, not by firmware. Patch 13 deals with PCI by setting
masted->ssid_bits from the PASID capability directly, ignoring
fwspec->num_pasid_bits.

> Besides,
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
