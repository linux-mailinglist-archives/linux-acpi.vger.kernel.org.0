Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7F1074EF
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVPdG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 10:33:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44272 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVPdG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 10:33:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so9059754wrn.11
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LQ0qY4Da80FqTT8SCe/q1MMW5kmKX6FKTTmrD9FMwQA=;
        b=AgTSYuNm6XEfw9a1bin5Mb4/xCbTQ+NinMuVrvghSeEv3dFsAecF1XJPbn2iv1M6hY
         p0cpqzbGPXGEzyjwmISfMojE0LxhDCyXfa7O2GrFOBPRPXKuA+np+l5lv+sd9iltRTGl
         40ixAedr0XBP0RObe/d0u6Kl85Lo7q6+M9uiiTyuCvGh/7qkjHt2Zq4kMpQER1oGToOy
         rUOFCo4z9GDEZTsAvXfugh8vyqyedf0J0SPQLCi87POM0biTYvmX+sFQlV/zavO9a9u0
         P8VMOSvA9vHtkz3cLbYbYkxR93aPdU1+xJbHJ1IsxNrJ+8+Zdneft3cnMtP6yGDS/0pX
         XQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQ0qY4Da80FqTT8SCe/q1MMW5kmKX6FKTTmrD9FMwQA=;
        b=HMfeEKeWFnsPRuNyzxwA+IVg69wHBTHhoY0RhaL4GHVXvBezwx0+4CMnPHXs8XJSQu
         sECpyQ1VqLZ0UoJPe+MHAZ8AvWv4DXzPj747elL4d5sDz92AXpjdrOwXUBPw1Mo0BeuL
         UmjLCeSyHZyYjamuubjbGEund8v89vq1TyoyTFPbdGTKJxVx6/isz1uIQxt3j+0DGQX7
         6CEUoJYIlLm1HiyI6940OBuK0E2XHcyWyd0K6vuYyHR3qV2nI+SnF3KaRZHmaEUcFKHj
         HO/Ov4lPgkqIADh8HiiK068LUwucNCtOZozj/1YOHeXXeHYpwRMyMFc+Il4O63lyPiW/
         gLCA==
X-Gm-Message-State: APjAAAVWoeF6HW+LX+HkoCNd4VcskEkURrdda0Mu3yd9pqAj/A+nxbUN
        fPqQ7X3JI0UESxDA2VYoaDmA6g==
X-Google-Smtp-Source: APXvYqzX6JrW+q24Zk8k1hZ/pOgzDIL1U2YSPMN1DIk72zz9G9tgaPGNFMdZipoYaSd2Rw5YaSO23g==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr17340480wro.325.1574436784658;
        Fri, 22 Nov 2019 07:33:04 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id y6sm8172846wrw.6.2019.11.22.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 07:33:03 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:33:01 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com
Subject: Re: [PATCH v2 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20191122153301.GC810215@lophozonia>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
 <20191108152508.4039168-9-jean-philippe@linaro.org>
 <20191111160529.00006dcd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111160529.00006dcd@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jonathan,

On Mon, Nov 11, 2019 at 04:05:29PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Nov 2019 16:25:08 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Enable PASID for PCI devices that support it. Since the SSID tables are
> > allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> > arm_smmu_dev_feature_enable() would be too late, since by that time the
> > main DMA domain has already been attached. Do it in add_device() instead.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Seems straightforward.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks for working on this stuff.  I hope we an move to get the rest of the
> SVA elements lined up behind it so everything moves quickly in the next
> cycle (or two).

Thanks a lot for the thorough review. I'm aiming for v5.6 for the PASID
series, and then realistically v5.7 for the rest of SVA, but I'll try to
send it sooner.

Thanks,
Jean

