Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C134EF34
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhC3RSf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhC3RSQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 13:18:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F3C061574
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 10:18:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so8837585wmj.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wv5s2hFIUo2gKQ4gDxjTXneaufMswuUrX5PqppLDZlw=;
        b=seDS3AbA2YxPNbqBPGSiqi1kOqb8GqtxtF3q5yGUPHMl1LYormxa50YHLOoSgwqCDW
         5d6MoW+Pws1fvmGJqeXGtRh+udchEEFs0PXDaL+xsUI3W2PRpkxMMPcg3sr1EHiDYOJQ
         EA23RAX+U3yXZ65A3V6zan94Pho1p3fVlmwrVbF7LAQ9ua0EcVcxCTWE2Et65UYpX45O
         Zd5wznq/kir0bQmALsIbGIcMeJbRm9e0tWOY/vSjITj429wVOiULFcgCRU8G/r16D96I
         BjWkLOry9XIGmTIz4QIkexKAzhE7SrJloVxD7zET0HsPEGAw4JTdwMlyQpcZ0Jkkyr/z
         SH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wv5s2hFIUo2gKQ4gDxjTXneaufMswuUrX5PqppLDZlw=;
        b=cCDB3ntDMAa1sYbbKnAdMODA2eHtIatYgId1ZmmVygQuNdadODmXEagvaHbk2jl8yn
         9m347KyVSNvs8AGHptwZ2hEdTasK8ZgrNmUFk/IkdrrM+ORv2qNatfO05fFwYccRSVz2
         VnjQGfJ01ZtBA1DUWXyEoSuxJab+s78rx1W1kW9UevTFTVONOHX8M/1iY1xd2BYyprhi
         Y0fxgiS8wota+jEHVaQeWjmiqXYF8MDi3fbs1Ctncifz5GMgwzAl31KLVzj5E6geWcyg
         OXxR7e/QZP6tfEtVOLGbZghaHM4DPL+IosGfIcOta4wt3+mMVqsjO6oh4YY1PWmXVz6F
         /aWQ==
X-Gm-Message-State: AOAM530Y8cbcZZU6YjZlpVJqtUmAZbnK/5t9dQJrY0b1/ELLDkCGAmM3
        3VZFUfe2zCebNRVRM834vUnVdw==
X-Google-Smtp-Source: ABdhPJxWMhf+gc+wpTtm59XgeUZsbWjnVM7+DjvkPDd2IW2QmwXRwSkIh4AEvc7E/VkGQxzV/6eMNw==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr5130672wml.97.1617124694446;
        Tue, 30 Mar 2021 10:18:14 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a6sm6542927wmm.0.2021.03.30.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:18:13 -0700 (PDT)
Date:   Tue, 30 Mar 2021 19:17:55 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <YGNdQ863Mohizx7A@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Will, Joerg,

On Tue, Mar 02, 2021 at 10:26:36AM +0100, Jean-Philippe Brucker wrote:
> Add stall support to the SMMUv3 driver, along with a common I/O Page
> Fault handler.

I only have review/ack tags and one assert_lockdep to add to this series.
Should I send a v14 now or wait a little longer?  Just making sure we can
get at least patches 1-6 in v5.13.

Thanks,
Jean

