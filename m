Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C812FD774
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 18:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbhATRrb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 12:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbhATRoS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 12:44:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B5C0613D3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2021 09:43:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d26so23898862wrb.12
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2021 09:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7aUUsfcYcxGvSNOE9xOymWakTzVUOFowM4WuU+q4Pg=;
        b=szM7sxtOZH9OiVHN21YHTUe8HZnkap3Ywb7gLquh94qffDgX1HUDgtDLdIT2UNAAB/
         eGVghpwYfIgYXpIRdlxgBKZnl/GUvG12CahWdRXPAu8cbafSWkHfRraIK8cA60s2s6HC
         qipvpOKXiaIgTiTIl7asNU7C0HCb57vaJUx4czGiOpLJmJYZ7g/2/nI7Q7eVFSaEtYiM
         qsFSBfRJ5LYpfvEk7Xn5eKa6w/j9L1fGvGSr30ZmpAqB01ds6MzM62SLmwjmT+D4tSaV
         Gjfr0iEpHI7h3F4C19eRcjONtPk2QloKq6hgMPYDpqeTsH43a/ITxJzC+XutKf9ybAxL
         aHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7aUUsfcYcxGvSNOE9xOymWakTzVUOFowM4WuU+q4Pg=;
        b=fCeMc2H/HjpK30nwf4Qhu7+1RVauxGtpXaSZJ7v9wWvr9q58ozCgNhWwqFtp/seoh6
         JdGBbQMbrwsoIcxqcpWZc+CJfkblPsPx8OjLv3aDPh/ML2Zt3fXkUopt568JkFyVaeNy
         /4uIB0N1K8UHbSWLUUxYSCucwg0NKatRYSDwNIKrNWlOnXfKjVrXJMHYBWcj9fwhSQ2O
         eqoahiC1CXu0UokJRnb0IyHRSLVIyMLvqnm9ZaVclssgckZfhUSWaHGEVyAKkwyLYE2Z
         lYHPjSMeNqNPU8D7BpuL9w1AqPMzM0g8DLw31mUBqlVvwC2yEsSLc3bw8vCK0eaZpwTh
         7RDw==
X-Gm-Message-State: AOAM532la8jamtY9H8oWFAWG8I7mo/QsMxmusfWm2m/q65QtjhYc/ZsW
        ACNX2m/rLwB7crhSG1BiEmI2VA==
X-Google-Smtp-Source: ABdhPJzpLHHpsQ2g2E4WmLP34m6i58NPSVmOpjvgaXI5blCKQKW8/fkrv6QK9zAcq3kydE0WVN37Ng==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr10486618wro.388.1611164589594;
        Wed, 20 Jan 2021 09:43:09 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j13sm5073106wmi.24.2021.01.20.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:43:08 -0800 (PST)
Date:   Wed, 20 Jan 2021 18:42:48 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Message-ID: <YAhrmLh5I/ysx/kb@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
 <20210119122759.000048f9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119122759.000048f9@Huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2021 at 12:27:59PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Jan 2021 15:52:13 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > The IOPF (I/O Page Fault) feature is now enabled independently from the
> > SVA feature, because some IOPF implementations are device-specific and
> > do not require IOMMU support for PCIe PRI or Arm SMMU stall.
> > 
> > Enable IOPF unconditionally when enabling SVA for now. In the future, if
> > a device driver implementing a uacce interface doesn't need IOPF
> > support, it will need to tell the uacce module, for example with a new
> > flag.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Hi Jean-Philippe,
> 
> A minor suggestion inline but I'm not that bothered so either way
> looks good to me.

No problem, I'll add the disable function

Thanks,
Jean
