Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095363AC740
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 11:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFRJUj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFRJUi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 05:20:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E5C061574
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 02:18:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id df12so5205305edb.2
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HRCq4fgN0aqqkE/8MiANC+rXlD39PnksNydgp1NHMj8=;
        b=aAUvntb9wvjm5kq0+mzAEZrxmcfn0Uq6awR26z3mwJ9WN1M1UjStHyT0vq8IcMR2EZ
         YxniL1472HHUuFHpCT4Db/CdB4znRz4U6otxHDqPVYY4PhZGWvbraoQiLsJuCHDa97IJ
         pAZAUDbKDzrRBTvSVZKktiKPq5qvcGKyS+O0va+boqerEOciWdv2r2f7C4hzYA84v6gY
         uSKEQ2lvdbsyFwYQAKuNzyCzIdc5SLkVvSfX/qfi2PpTE5ZwgTkkzNmyGR4CY5qpoAhU
         eza97I+5UquHK1GJTNy5RKMkp5vlkITwHBoqUozjghYNSwNUVDNig2XyJndsi03pl73M
         9Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HRCq4fgN0aqqkE/8MiANC+rXlD39PnksNydgp1NHMj8=;
        b=SE2cmJu//KXVki1IaTYC6bR8dZS4sCukeoRUae3Vk8LY6Q90pIJBg6q/1HkCf6KQPh
         pUGEN4gNX5zjywhasfv1BV28baapfLeF9f4f93POMjqXwC6cUblUZA2UhD07CepUdU4I
         ObI6LLS0Mxwq4D2574SHq0YpF2Dbh/SddLPav1SK/BYjtGeQMFfa/H3x6OV+xwka0IaY
         DxQXSRB8S6jx6HnTU4U00CFAtgmCbNfvZnJ0QuXg00yW3ls+XWvNfyh6xCnLF06jWE1C
         huY/LcC/C9fO6WJMGkI7WAOY6NlKFY3+gSuLcGL0lBNHS+A0Oc32EOp7bFqEbTlDc/AH
         Ohng==
X-Gm-Message-State: AOAM5339bePJI7laQFasZNx0qAkU8am3cvLCP1AbY32ihxFvgev9XvoR
        Nc5ghkCjG3MinvDoDaAGnLxfzw==
X-Google-Smtp-Source: ABdhPJwkM7MFKtctHz8EhEAN6FWomn+q375ZFzmKixM6u9jPqqm7bxiCxZcxkEywq+sBmzBudXNXiw==
X-Received: by 2002:a05:6402:2714:: with SMTP id y20mr3735609edd.41.1624007908152;
        Fri, 18 Jun 2021 02:18:28 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id u12sm788646eje.40.2021.06.18.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 02:18:27 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:18:08 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, sebastien.boeuf@intel.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v4 4/6] iommu/dma: Pass address limit rather than size to
 iommu_setup_dma_ops()
Message-ID: <YMxk0Na2yuRNwPT7@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-5-jean-philippe@linaro.org>
 <6d139529-9539-fbe4-8f85-da39461047ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d139529-9539-fbe4-8f85-da39461047ba@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 05:28:59PM +0200, Eric Auger wrote:
> Hi Jean,
> 
> On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index 4bf1dd3eb041..7bd1d2199141 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -50,7 +50,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >  
> >  	dev->dma_coherent = coherent;
> >  	if (iommu)
> > -		iommu_setup_dma_ops(dev, dma_base, size);
> > +		iommu_setup_dma_ops(dev, dma_base, size - dma_base - 1);
> I don't get  size - dma_base - 1?

Because it's wrong, should be dma_base + size - 1. Thanks for catching it!

Thanks,
Jean

