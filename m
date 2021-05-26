Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4C39145F
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhEZKG6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhEZKG5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 06:06:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EDC061574
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 03:05:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t15so634703edr.11
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wN1QhgZSLh/Q1cWPqcMwfOkLFO+D9Okqk24H5LLAjws=;
        b=nPXeq6WiNxgg6lSxeUnm2xUIASnDhmktguH8A6hssAjEktOyNSvFrXb7nk9Jwtb+NO
         yFRlCwYbpgu1I3XfvONpplYhusGl1LZzYH8skxO3FMlur4Ub99+Y+fFTNkOsTrN5w38z
         OVf9eYTP/FPPU3gd8SPWnmbwhEmLy2lOF0pC3GW4VrVUrahiv7yYM6zET6w7Z3my6L0S
         cHNhcGsinerK+PASVPV7OHMOudUBIlgvybDpP7ziWJzNizZCFYD1ZSZ3if2EX1bSR+BK
         ZxzluxhQR+3Vc6n46FiKg0ibO/Yga0tgQunYLwLIIwStAZJn5nD7INiwGK+RxyPP0Qb4
         pUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wN1QhgZSLh/Q1cWPqcMwfOkLFO+D9Okqk24H5LLAjws=;
        b=Ibruxtwk+n61/xpQlUiYDu6B/8uLC0z+uRiL2v8WBrERR1u7gG47kSgqNqBWmEjWAp
         qtNYVLcS5PWcd9tsoSHuxtQNGudFK5rebIuJF+SbocN3iPRQRYFdgt8ARL+X/5Ir23r5
         jkpgua0wYOc7mQg5oRxLYyUJJ8OstAQfmEX+YV1w1f6ypc5EbtWLlvPRqRKI9g+2yrPN
         GprdtnyWRJxguElxqqTNLznhYBJTzPToALwC99cQT7NuYLKz7f3Fopmp4be1x3JNsiEZ
         bAi1ofy9r/mBOnFHamMRuQuReWp9uIihTYVhtGmRjZjuiBK9HK92ua+hO0XckzR8FIKr
         hqcQ==
X-Gm-Message-State: AOAM531NYOXoOBAOtBTuGO+/Cr/LQHqjcK3ZAhc+vqPayYyaBCDd04+6
        Ah59TNtJ1q+NrCUNSEgWRSfGTg==
X-Google-Smtp-Source: ABdhPJwLqgT0dI13/qQ6yT3UWt2a30pzQv780qX8pFwjZ6m2oIQpbMs47aFTz509ycnSHGVFoSWOMw==
X-Received: by 2002:a50:bf0f:: with SMTP id f15mr34885274edk.205.1622023525169;
        Wed, 26 May 2021 03:05:25 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
        by smtp.gmail.com with ESMTPSA id k22sm10054730ejz.108.2021.05.26.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:05:24 -0700 (PDT)
Date:   Wed, 26 May 2021 12:05:06 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Auger <eric.auger@redhat.com>, sebastien.boeuf@intel.com,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YK4dUpIS5LJmAU2s@myrica>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-3-jean-philippe@linaro.org>
 <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 21, 2021 at 06:42:09PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Some of the IOMMU setup code in IORT is fairly generic and can be reused
> > by VIOT. Extract it from IORT.
> 
> Except that iort_iommu_configure_id() is not really generic AFAICS.

I'll clarify the commit message: the parts of iort_iommu_configure_id()
that set up the IOMMU infrastructure can be extracted and reused by VIOT.
The rest of the function, that iterates over the IORT subtables, is
specific to the driver.

Thanks,
Jean
