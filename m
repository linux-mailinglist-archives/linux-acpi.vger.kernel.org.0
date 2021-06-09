Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5D3A107B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhFIJqG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhFIJqG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 05:46:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08614C061574
        for <linux-acpi@vger.kernel.org>; Wed,  9 Jun 2021 02:44:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y7so20086634wrh.7
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+lFdIy/Fj8w641ouj5kQ8wz/6ZZG0ZHAWeOT4yzbRc=;
        b=AT64ZswDoaXLxTV5klTqoMfaholatkhAgnHUHUWahtJmGmuFXvejIFYV2hDEh4Rk3O
         PDGIZWSNjngAhf2i1GUAhAuRbdZyt4r4L6BOpuInByx9+QeUJVeV0PHMpVrQd7krsSxF
         /tBikZ50LsePM25jiogN+MPuP137zS1/Bpq+O9862lzK7vprtdrHBr+1FbJaCQYp1zBw
         xiOZYCS9lSQUuALZaaPZwSyTm392hcZhtCagAm+d01KNzUVdfqo7smulok/Utmwxg2vt
         DTGcUvy0B+AAEAhMD5XTQvmSSbd/mI0FqHAy2In9nE5SA87kIDLgx8Q2hR5YA3dBRMXw
         8cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+lFdIy/Fj8w641ouj5kQ8wz/6ZZG0ZHAWeOT4yzbRc=;
        b=Dj2UFHYbJ6mjlo6m6HWee5puDO/EcUTRSfD7UsiNBIhuCor4Uq48ey3u9ODtheJglr
         CmvAVRx3UBgbqvmYg+esBXxqTg5OBGfLYCF4zUroqucqvt/VZMciVWanKiOpPYmDia5B
         U0TmUhmMwZEc3/9pduoDa4ZwNIwPoSU42fDaMWTJi3z6hbYszDQsj6GUejm2+ZzI3wkS
         oyFuDeFLoxRfo0K/6Arxv2eBlg06iMdvCnHfwHmCs20z+YVeD95MSzPv2xX2QmF5vKa6
         EDD6k2V0ewoaHEkGm2gzXU//3e1dRlfKFDZVA4GIqD9ZJPzJf7O7ptu7/SJqkYvNHnjS
         CqCA==
X-Gm-Message-State: AOAM531B93xzbheIxF+xTkO3CQ74q5WAhQCQu6XocyN/IFzZDFtxFDez
        lIZzEF3upOgvzRDHsSogsJgAaw==
X-Google-Smtp-Source: ABdhPJwO3THpKtkdcUWrskaIYkB0u8maKDhXBCguE9TgSQU4qzM70G7eqJmGWmGYL8J1rMvvo9H1PA==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr27346967wrw.228.1623231850644;
        Wed, 09 Jun 2021 02:44:10 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id m23sm6757801wml.27.2021.06.09.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:44:10 -0700 (PDT)
Date:   Wed, 9 Jun 2021 11:43:52 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, catalin.marinas@arm.com, kernel-team@android.com,
        robh+dt@kernel.org, linux-acpi@vger.kernel.org,
        sudeep.holla@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com,
        Jonathan.Cameron@huawei.com, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        rjw@rjwysocki.net, lenb@kernel.org
Subject: Re: [PATCH v15 0/3] iommu/arm-smmu-v3: Add stall support
Message-ID: <YMCNWOkJ/xi2Yv1U@myrica>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
 <162314710744.3707892.6632600736379822229.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162314710744.3707892.6632600736379822229.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 08, 2021 at 12:42:34PM +0100, Will Deacon wrote:
> On Wed, 26 May 2021 18:19:25 +0200, Jean-Philippe Brucker wrote:
> > Add stall support for SMMUv3, enabling I/O page faults and SVA for
> > compatible devices. No change since last version [1], but I'd still like
> > this to be considered for upstream, because there exists hardware and
> > applications.
> > 
> > Stall is implemented by the Kunpeng 920 processor for its compression
> > and crypto accelerators, with which I tested the SVA infrastructure.
> > Using the userspace accelerator API [2], a program can obtain a queue
> > from one of these devices and submit compression or encryption work
> > within the program's address space. UADK [3] provides a library to do
> > this, and there is an openssl plugin [4] to use it.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/3] dt-bindings: document stall property for IOMMU masters
>       https://git.kernel.org/will/c/ed1d08b9d0c9
> [2/3] ACPI/IORT: Enable stall support for platform devices
>       https://git.kernel.org/will/c/6522b1e0c78f
> [3/3] iommu/arm-smmu-v3: Add stall support for platform devices
>       https://git.kernel.org/will/c/395ad89d11fd
> 

Thanks!  That concludes most of the SVA work. For SMMUv3 we still need to
figure out DVM, there will be PRI at some point, and I'm sure some
bugfixes but I don't plan to send any other major feature support for the
next cycles.

Thanks,
Jean

