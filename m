Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9870E360C1E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhDOOrn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhDOOrm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 10:47:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBAAC061574
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 07:47:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h10so28369157edt.13
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n4QXf+cOw2jRuJk6NYVPzxIPebbr2HANj3LDOYShp5I=;
        b=Jd109QuvoPbeOBhKixUtBt5/Xnwa4xQuAOpVjrA87QwRWKtQDFDLIibyYB0+5GQIEJ
         aHUKSd66q6DYdd5JpKX4S150mKovE2TxkNTVe3vl2MLvTAzMdKOrCTHKx25rOnCWhR/F
         OO4Cr2eqsGRjUtNMQeJd1kDyoNYi5qwmQzWyAgVUOQnLYaqJf3mXGFsDGn57h5DDvtGD
         KhoiVuXcprEmmgcifdilXVTen5ekgIhIs4/XfFslUGr+rZWJmekmcoEtSDRWtOdWei9G
         1YVduS3e4+0pra7kKAPLQTYuiyZs1aOvYfMfhDDV7Bo6XiJq/rMj/UIUDB3UkQewSxvl
         gPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n4QXf+cOw2jRuJk6NYVPzxIPebbr2HANj3LDOYShp5I=;
        b=QggTZUQw4uDrnCKIs0NjWi8EBltTrllcSSxVQwmZsKmH5WX2iYWViLPuCBFywDelOq
         GKZjLN+ST6/vMTmc13jZ6SQEk22rEh8t34v0BvEqdUsoD7LW05/GhmV0MsicMYIOUKzN
         AsEnHCL9B3COjDhUzizPt94JUua8H/+kp0glaqgSudGfigchi6k2mC30eO91ng/cc2eJ
         uAbV3Q251yIPN0XJCz3ZX5kb8Cb7MQvyu7gyWobFcO3IjsESD2n6T7yWPdFcwIhGaOFH
         07TwDMN5psqTaRoltFre9XOqsxCXwdThSP36v9Rs8bTUhGYEKKqaxbp631OFtKC4EkGt
         nVbg==
X-Gm-Message-State: AOAM531RPiUvohkGbfa2gYKY0aqz1fBPJb2DTMoyqeePljZvepVpT9gS
        AAlK2yAVAuD4k8abpdQubQ3qkA==
X-Google-Smtp-Source: ABdhPJz2+0NTKepbuICEjxCSs4LahmAuUZrrzKCZRlpZy/ROS/vkdkyyfjikrFbRCEfvo5bTe/kvaA==
X-Received: by 2002:a05:6402:614:: with SMTP id n20mr4606117edv.58.1618498038320;
        Thu, 15 Apr 2021 07:47:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id f10sm2627950edd.29.2021.04.15.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:47:17 -0700 (PDT)
Date:   Thu, 15 Apr 2021 16:46:58 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
Message-ID: <YHhR4nSKYogouGMJ@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
 <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 11:44:26AM +0100, Auger Eric wrote:
> add some kernel-doc comments matching the explanation in the commit message?

Yes, I'll add some comments. I got rid of the other issues you pointed out
while reworking the driver, should be more straightforward now

Thanks,
Jean

