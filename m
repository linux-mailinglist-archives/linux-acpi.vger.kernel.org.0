Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D72360E7D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhDOPQH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhDOPO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 11:14:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D45C061574
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 08:14:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so37430990ejk.2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqtDHjyGp8glZULp1bf2Fq7JNPjH6B0xPTqIRRY0Vf8=;
        b=Su9JjJ2DVw939t0pkGaDodcmBB0LfGVIA7EqtWYA+JDZL6IUJt9WzpYd+TVbmfGDve
         Xkc9Qc/sx3wCD57Q8wezmrLxxOmL+TuVAH5BzBdSAOAeC1i+T5aZpMHxTD2QThxvDVtN
         FAXHpjYdJCn861GPL+yEilgLS3Jpz2bN2Uk/ZDt2SYqWMxe9ar88zoEGdxu1bhEKppM9
         8bqqS4l6VToBIZ1oCDVBICa4D4T/EfL52whwC2FwHEqT4YXTGol3Qdeegdf4qo7UdEF3
         qdcRJRUXT9fzTVuPEiT10aLKkglzTkWbDr3WULjFvShmtcHyMv6QCIok0VlZ+ZjXgidt
         gsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqtDHjyGp8glZULp1bf2Fq7JNPjH6B0xPTqIRRY0Vf8=;
        b=eFXFEDz9j4HtQkTa0g1zRzHjm7FKQH3vBXbj+ScQ/u8zohZNLJqcYWf2JBtfkplo5x
         42G2l9p02bNHBI03WKjeIMoNFtb4IItQCK4nBAVaLn6gkgf7jx1B4ccBely9gaDN1wrD
         roYckl4l16bfcPnXsZrW6yFwzQJ3p77XAyvIK3/Pm4O74vHyVbldVJJD2cTkeCmWyDP+
         z5WWPF61RE+5TFQrm/g0imv+adtWmtVuEzJjtAZb6wGe7zZd+rGBvqif0fBp8yP9DqkG
         IuyGlEwEJLhpaBvqaYhP+neK615lzd64TZ5pYFXpMSygPmhi062HpPx8WpgG5B9LrGm4
         QgyA==
X-Gm-Message-State: AOAM531xFK+i++Cm38idtAd4MhgSMfqGuSTfSFAovEEc50oGOSuZMyg1
        WJP6UFqZmbGVTCJ1HONZQ7mnog==
X-Google-Smtp-Source: ABdhPJzHQ/B5VFA6RKe5yV0g+kYRtxE0OHiWFPsrsA4mNSUD1awk9FIgvIDi9Gm/28MC3cEU5uG19A==
X-Received: by 2002:a17:906:6dd9:: with SMTP id j25mr3863285ejt.507.1618499673911;
        Thu, 15 Apr 2021 08:14:33 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m5sm2783111edi.52.2021.04.15.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:14:33 -0700 (PDT)
Date:   Thu, 15 Apr 2021 17:14:13 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <YHhYRQlDdCLfmDnf@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
 <2d57860b-8a1c-f345-1105-62680c003fb5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d57860b-8a1c-f345-1105-62680c003fb5@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 18, 2021 at 11:43:38AM +0000, Robin Murphy wrote:
> On 2021-03-16 19:16, Jean-Philippe Brucker wrote:
> > With the VIOT support in place, x86 platforms can now use the
> > virtio-iommu.
> > 
> > The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> > themselves.
> 
> Actually, now that both AMD and Intel are converted over, maybe it's finally
> time to punt that to x86 arch code to match arm64?

x86 also has CONFIG_HYPERV_IOMMU that doesn't use IOMMU_DMA, and might not
want to pull in dma-iommu.o + iova.o (don't know if they care about guest
size). There also is the old gart driver, but that doesn't select
IOMMU_SUPPORT. 

Thanks,
Jean
