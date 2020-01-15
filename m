Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E7C13CC1F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAOSaD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 13:30:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55187 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOSaD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 13:30:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so1014138wmj.4
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vx9ZI/rGscUUGCBc0iWif4TA6oe6ecIt71Ef+bzf57U=;
        b=JEN7pX6UGwBqBgRVeU46B89XGheqHUrF69+1A6TQGYjtGYTBLYkKWY2orOVSw8hS/V
         yx7E/7T+8HwIqvdg6/rD8ch2BDnEbEBkwzGS0jNSiN7xOdZTWJCGNpH00b6FmjajImRM
         Y0Cq723LUX5rNaaq68rFRJpBzri8ZTJCpfZZXzuZlACIyqy276ntAuLB5rebtF6KpuK0
         VXsLW7MtFmYWfFQNZ8guFJVTMh0WdkoUrDalt/20pf7BJAKsa7gxBb/6aEtY5v52u+FS
         rJOoE27gKx2D97bW1kHpVoBosfK/GPlAyGR5lt0nUOtflXGNm7+DRO/mgm/UQ7iD4uHu
         TMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vx9ZI/rGscUUGCBc0iWif4TA6oe6ecIt71Ef+bzf57U=;
        b=QA8jEhhQYy6kW2JEKpnIKFJ9dfV6phkSGlP12u/2q/VikkT4roJocKqUAw4X59CFDl
         OmCZv1jv5ss2vjq0vxHwdeiQCugqZLFMKsssBN5JubtcGOakjjNy6dvufKBRFdnWSOEo
         Or41CYwbFU+eHGSTr5KnPv98FeCDsu7d23ikn/rbgVeXp0oWFkeMVCasXUvz/WkkRyFw
         49q9AWCyjbjx+6zUySjrc5ViXdJl5viPCrGrW1jaGD45tDbahvna1SSJxQ+UrEkMx00k
         G8yGmppoV9ompFbKjM0FkOMO6nH8VZLGvo+Cnl2i2+MMOdEbFHGyip/qhPj3c/bfNgQD
         IKTw==
X-Gm-Message-State: APjAAAXTRyVUXaOvDaJmPJ1oFXGTpA7uNNn6W5xuBlWTKc/NKTAeLM5Y
        NgtuATvbs+CefMC3AkhU/K2JfA==
X-Google-Smtp-Source: APXvYqy8nNtvTuOB8AddkrK/wK0uuvgD1wX9xlx2WFGLj57TQXbAf34VislU15LMhdhXKyk0wQaang==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr1338398wmj.4.1579113001084;
        Wed, 15 Jan 2020 10:30:01 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u8sm913472wmm.15.2020.01.15.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:30:00 -0800 (PST)
Date:   Wed, 15 Jan 2020 19:29:55 +0100
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
Subject: Re: [PATCH v5 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20200115182955.GA152753@myrica>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
 <20200115164255.GB30746@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115164255.GB30746@willie-the-truck>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2020 at 04:42:56PM +0000, Will Deacon wrote:
> On Wed, Jan 15, 2020 at 01:52:26PM +0100, Jean-Philippe Brucker wrote:
> > Since v4 [1] I addressed some of Will's comment.
> 
> Thanks! I've tentatively managed to queue all of this apart from the last
> patch, since that relies on some pasid symbols being exported from the PCI
> core when building the driver as a module with PCI_PASID=y.
> 
> Please can you look at the rest of things here?:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

Sorry for the delay, I had to rebase and rework the SVA patchset a little
in order to test. Your changes look good to me and run fine on the
hisilicon KunPeng920 (although I haven't tried building as a module yet,
I'll do that next).

Thanks,
Jean

> 
> > Still missing and will be submitted as follow-up patches:
> > * write STE.V with WRITE_ONCE() (patch 7)
> 
> I've hacked that one up myself.
> 
> > * batch submission of CD invalidation (patch 7)
> 
> That can be 5.7 material.
> 
> > * Remove WARN_ON_ONCE() in add_device() (patch 13)
> >   Pending Robin's input.
> 
> I've written that one too, but we'll see what Robin says. The question now
> is which commit do I tag in the branch above :)
> 
> Will
