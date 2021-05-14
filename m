Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF6380FDA
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhENSig (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 14:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhENSig (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 May 2021 14:38:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2165C061574
        for <linux-acpi@vger.kernel.org>; Fri, 14 May 2021 11:37:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a25so11603483edr.12
        for <linux-acpi@vger.kernel.org>; Fri, 14 May 2021 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02LxdjsgVQUzSiAH2KRvI2SnT3V/EPoHS2xbtXtqU2g=;
        b=Nq4AIGmDxvCN38wn3yZRBD67IcSVsSt7TWWB1P+liR27OwjbgoNhOrIPmOghWAyPIW
         QpL9JNaYyc7DE/Xjw/pKb6909dUYUvrjXLGLc4kEBQPdoihaaZbpxBLEZcfKmQZtIivA
         DrU0GVGlHtS/byT8pa8wmHMFRuwCWEOWGfHtB2u0vmBB2jwa8f/jzshVRNYD6PJPoISC
         zvgx38/qoY6SVync+Te4uR2jYgeF3CnSLLpq1nN+CYyXQeb6BQiJOs+085Ks9pUa3qFJ
         qVxyxFm3jX1IXk2JcCS7CsInTPVgN4CnRD2z2rQPhdToCCxYQ8qD+FvUnp9WOgYrDpOf
         mnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02LxdjsgVQUzSiAH2KRvI2SnT3V/EPoHS2xbtXtqU2g=;
        b=OdKI5v8Nc9j5NqIwuhHXc1UJpNmMOriuEmcqLXsn4BACiRkTRDUFVNHks6FyZuvW6f
         f6HrZJo3o7lzw1xTVFjdkEWThRC7TJXDPFrNJJyyqIKhIFoXpBiqwTxSIFU00HlA5vvi
         41/HnYljfHrc4vFaLfWrgtKt7z842ZHQ0nRM1YEXJzetyCBPCppq252RbHEk7H33PGxu
         s4iFzHewiI1PleLwmNILGdizoaXc1PXn3PPdJfCrfR5L+hmUIWqS5BCuqu828i5SQgXe
         PJnM9uUZ1EerQaV6mFb9Un8glvH7uhVFAQQc8+uJSoIxhYkpah8njUpAZdTQGM+NZt8Q
         cgzg==
X-Gm-Message-State: AOAM533bp48QBqdQGY9UpOaH6Lo1acpXm+Spz6mEFJRoI9maL0KqF0oz
        1nHMllCCHPVeoA2CDmSY33v3h89mUqtP7dOcCs+Pwg==
X-Google-Smtp-Source: ABdhPJz8vCIzsAYA1fh7/O9J0MXCNdSlpbUWm6Al/0crTgIeWRfdboiI2YKdirtbIUuWaRdWfeKglSMA8J5lJq0OmmA=
X-Received: by 2002:a05:6402:13c3:: with SMTP id a3mr21131702edx.18.1621017443439;
 Fri, 14 May 2021 11:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com> <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com>
In-Reply-To: <20210514094755.00002081@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 May 2021 11:37:12 -0700
Message-ID: <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 14, 2021 at 1:50 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > If it simplifies the kernel implementation to assume single
> > kernel-initiator then I think that's more than enough reason to block
> > out userspace, and/or provide userspace a method to get into the
> > kernel's queue for service.
>
> This last suggestion makes sense to me. Let's provide a 'right' way
> to access the DOE from user space. I like the idea if it being possible
> to run CXL compliance tests from userspace whilst the driver is loaded.

Ah, and I like your observation that once the kernel provides a
"right" way to access DOE then userspace direct-access of DOE is
indeed a "you get to keep the pieces" event like any other unwanted
userspace config-write.

> Bjorn, given this would be a generic PCI thing, any preference for what
> this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
> to those for the BAR based CXL mailboxes?

(warning, anti-ioctl bias incoming...)

Hmm, DOE has an enumeration capability, could the DOE driver use a
scheme to have a sysfs bin_attr per discovered object type? This would
make it simliar to the pci-vpd sysfs interface.

Then the kernel could cache objects like CDAT that don't change
outside of some invalidation event.
