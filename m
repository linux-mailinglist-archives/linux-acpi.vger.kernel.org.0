Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D01360E99
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhDOPQj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhDOPQD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 11:16:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ADDC061574
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 08:15:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so37385931ejy.7
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QxiyvjJPiB2Y4EOeSIHNj8hpwn+sjnpoz3M6C8GXS3M=;
        b=O0nkOIGnpFaRAssZYNEIk81uAcj99Wr6/y7tBtzmDgplIx/bG+w0m5HpylOM7zKfbN
         uHn3xqBih8pNE6ArUg4Om7atp077ctzsa6CyhHJyhQiKgVR1YIyCqNZ2zJawoqZQknLM
         0YNfVLQZibhE9gFjjIVn7ofmIVksXMbNlN1Fy59tLK9s0qzJvzEq1AnF21zJi/qW1RJq
         RggL57CInaeyYR+eDcRv42ciOo3LqmEDz9yohXCxuqgNXmaPFpDM2lIf8DrKkSrdEaSX
         z6gagP0hCqZ6QwMu8Jq0c5d5WVXasijwcqUBZl5c5Xo2PkimylvP68S576x+mLVNFtkT
         dPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxiyvjJPiB2Y4EOeSIHNj8hpwn+sjnpoz3M6C8GXS3M=;
        b=Jvxh66PRUILS8CxtdF61JPjyToQeMmm8zgQG2j8L8h4liHyG/HZjMVzeGJH4t72g9M
         y+KWmmdezSKvcHVtcSgeFF+l12vFBEb440o92yaWVAzIPLGbY90FDk8r0NrXdjAwlDLR
         H6AgURrG/jM0qQcKpdf7ng+VxSMxZ9jNlZ0cBZc3kacrXwIB14gfZahR/FJn04krpPwP
         2wC3rr00N1RJEPoU2QBfMde3ey3ZNqO2rGY2rc3fQ1gnZf9hbs2c1eTkhzqENpgbDQGM
         9TeZyznhS2ltJN0WSDEp5Dvc9qelcjBCl2HVWG37bmLHpokMkHH/Rj1A+RynsT8239fo
         rDRw==
X-Gm-Message-State: AOAM531eGFWk9Z/o/AE4NYAF7osC7mZhOooXsINnKPhXD5Nz/64ANNEp
        2Zom9U2LDXwUJrXydW3Io4ZWHA==
X-Google-Smtp-Source: ABdhPJyfZaSsTEBlsYQzvBqBRq9S0zR0zrehiJ7ShidHNrcB2Rr4w/1VJiSlSEIhmoaqHLlfzben7g==
X-Received: by 2002:a17:906:944c:: with SMTP id z12mr3857507ejx.398.1618499738021;
        Thu, 15 Apr 2021 08:15:38 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id bs10sm2854236edb.8.2021.04.15.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:15:37 -0700 (PDT)
Date:   Thu, 15 Apr 2021 17:15:18 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <YHhYhoDn3zQ9MaGB@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
 <20210318142709-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318142709-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 18, 2021 at 02:28:02PM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 16, 2021 at 08:16:54PM +0100, Jean-Philippe Brucker wrote:
> > With the VIOT support in place, x86 platforms can now use the
> > virtio-iommu.
> > 
> > The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> > themselves.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > ---
> >  drivers/iommu/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 2819b5c8ec30..ccca83ef2f06 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -400,8 +400,9 @@ config HYPERV_IOMMU
> >  config VIRTIO_IOMMU
> >  	tristate "Virtio IOMMU driver"
> >  	depends on VIRTIO
> > -	depends on ARM64
> > +	depends on (ARM64 || X86)
> >  	select IOMMU_API
> > +	select IOMMU_DMA if X86
> 
> Would it hurt to just select unconditionally? Seems a bit cleaner
> ...

Yes I think I'll do this for the moment

Thanks,
Jean

> 
> >  	select INTERVAL_TREE
> >  	select ACPI_VIOT if ACPI
> >  	help
> > -- 
> > 2.30.2
> 
