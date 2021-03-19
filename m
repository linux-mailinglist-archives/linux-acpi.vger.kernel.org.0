Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F46341B45
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCSLRW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCSLRS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 07:17:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7CC06174A
        for <linux-acpi@vger.kernel.org>; Fri, 19 Mar 2021 04:17:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k128so2842369wmk.4
        for <linux-acpi@vger.kernel.org>; Fri, 19 Mar 2021 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mx7hOvK9DmxtVp0XCqxXwSfExji8hoKAX6DT7SegFEg=;
        b=jJ0K/jZBT/cLnix4dUAFoQ5NqKJm19Z3dDPbvVYPgIjVDKIp6tq9wV0xqKWc5DnPk9
         oGXVwuJT9K+8SBF4LEYevlQc0R8eKQEj/qVhG62ksgkvAW1Hn7ohliLrRDizbBoHFdk3
         sFwRSO74J/RJS6FpRAY0fPTWtjZAPUECav7QNi7zopW3KB0EgkBNmyishFxBh/6d4DNA
         B1l/lwTrn3ixcO9QS9I3YY06h1kPvnwxSE6bmpSX+ygVSOv8hhQASOcUCp1IgneuvMwL
         05+BlYbt0r7xp0QOjDhXV7vQIvGHj+xf9lvx9T0RPS+yOqxPFwkmECFFHd38JgUj/wMT
         HX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mx7hOvK9DmxtVp0XCqxXwSfExji8hoKAX6DT7SegFEg=;
        b=GnaH7WR3PF/3cPiwypU0wSeXsc7Fmx4Q5HX3Br0savqDPg8pIVCGbZjueh+Z2/Aj3M
         HfaazpxpBT0YAdjAgFl9DGjxQm3alrNheFWJxbXyQNSvv8HWKL6u6GCIu5Gx3YaR3wIs
         FXcOS7QtynrBRYKHjHj5bSDQ/qqO/BH8jRNkYrGAPzHHeeKpG3VwQTiRdF5hgWKL0pn2
         vHvzgfV08VURqyVBXhEyaFEEZwRLsQaxRyodhTgcVGlS/fJ/FvygJvuMkcH/ngcG277q
         MJQ2QjEadxYgZY9NL/ebr5SkMeUj+Tip4WlMObfab92IHOJv47grciDAx9uXZoDkkzsO
         ZVJg==
X-Gm-Message-State: AOAM533vUcyRlZOFNlUQdXDmCI2hodAhx/64Kypv4CijlguGGO+7MEUF
        is/l9UkdiVJaCrilLIVss8uGoQ==
X-Google-Smtp-Source: ABdhPJwZHSZ+MF8YNIRa9f/aPijW7SL31SlXsxAA7OsMVyF95Vb6dnP9JfuD+MP7PdUh869HTeSAbw==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr3276508wmf.106.1616152636322;
        Fri, 19 Mar 2021 04:17:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id z2sm7256330wrv.47.2021.03.19.04.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:17:15 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:16:57 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 0/3] Add support for ACPI VIOT
Message-ID: <YFSIKeihQAc8KPmG@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <e7291605-88ca-6e55-11ec-574b2f94cefa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7291605-88ca-6e55-11ec-574b2f94cefa@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Eric,

On Fri, Mar 19, 2021 at 11:58:49AM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 3/16/21 8:16 PM, Jean-Philippe Brucker wrote:
> > Add a driver for the ACPI VIOT table, which enables virtio-iommu on
> > non-devicetree platforms, including x86. This series depends on the
> > ACPICA changes of patch 1, which will be included in next release [1]
> > and pulled into Linux.
> > 
> > The Virtual I/O Translation table (VIOT) describes the topology of
> > para-virtual I/O translation devices and the endpoints they manage.
> > It was recently approved for inclusion into the ACPI standard [2].
> > A provisional version of the specification can be found at [3].
> > 
> > After discussing non-devicetree support for virtio-iommu at length
> > [4][5][6] we concluded that it should use this new ACPI table. And for
> > platforms that don't implement either devicetree or ACPI, a structure
> > that uses roughly the same format [6] can be built into the device.
> > 
> > [1] https://github.com/acpica/acpica/pull/666
> > [2] https://lore.kernel.org/linux-iommu/20210218233943.GH702808@redhat.com/
> > [3] https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > [4] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> > [5] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> > [6] https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/
> 
> Do you have a qemu branch to share for us to start exercising different
> kinds of topology?

Yes: https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
Thanks for the reviews, I'll rework this in a week or so

Jean

