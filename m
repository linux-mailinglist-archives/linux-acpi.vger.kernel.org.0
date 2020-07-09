Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8121A46B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGIQKT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgGIQKS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 12:10:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B852C08C5CE
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2020 09:10:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n2so2280267edr.5
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2020 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXGyI1jQM4MyDlznYgbObqnrQ6fGYg1DRfNByglLv1o=;
        b=UjOsw/EYQjZBeUPhxTDnLwz5hcjG7XJKZAgCs2jnN8hFjADCB++r0ATOAqmENgW/VP
         hikL0VJL7vWu6z3P4UkTBqdu2KGKyfsHsPW/Bi3c+q1lNKQwFaQ3jtXQyW/uMEGDpkA/
         TqqxyTc44LHLjuIv9MUJBAD9nKjyvaMtoS5ILB0gpHpaESvb3166bLYfXcKF04TJDOs0
         pa1AMO6kHH27YF7o2AKynrWSx+i1ba/Z1ZCBZyA3sL/VFV7J9RZ/YtnFWWUqfQN8T7G1
         xdoFwAAA2eCajSA9FJRXSZ84ILtv1QbBjC3Pfdo/yF5RcJ+LZqB+kCzPE+zAD4yYJPWE
         AlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXGyI1jQM4MyDlznYgbObqnrQ6fGYg1DRfNByglLv1o=;
        b=gj5KeTLRy9uSIrlo0Ie1SHALbyfAhLh6MI0DabMSgRdFnCgZF4wNN2ymNs7s+H3v3U
         u1qvgybFi/PVAG+BgMxr4CpSPdl2jGtiaZzaNL2QHxIBrDh9NeFvJCmJ1LHcDYQ0jnR/
         Pv3BYMBGFYe6YuzR1VRZVMqTYN7Gs4WmAbrmKtRZKk2YvfnvAOUhnTwPfkPAw+00nD0+
         /uKfid+tKhhFqTmpLvY663GOq5CfccBcnT/UWbGTKg4MyUproNmdbDMHlqiPSXzqa1jG
         WHQhzAtBp68pwZV+icP9m6MUf/tD0hsB42VxIC8LOqRcwP5zWjeoUt9JpwomDCKMKNc6
         R0aQ==
X-Gm-Message-State: AOAM5322OFg5vCCo7DGtTOmonOo4KgPbSwfrDgVRKeDfDmPWMXXaFsNx
        BiztiusUfz82GOSxeV5H0DgLjoIuphQ/zOdBnG7FEw==
X-Google-Smtp-Source: ABdhPJys2PRuEgVWwVNfqL6iwk8phAva/9+kvQrbBEC8AGznqa+13FP1lQM5gT85aLrNX8emw/o4sdAG8MvO8CX0Aoc=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr75626053edo.102.1594311017269;
 Thu, 09 Jul 2020 09:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org> <20200709153854.GY23821@mellanox.com>
In-Reply-To: <20200709153854.GY23821@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jul 2020 09:10:06 -0700
Message-ID: <CAPcyv4hSPWEUih=we5QM_rdk7fLemi8phyk8_0tOd8ieL_=vPg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 9, 2020 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 09, 2020 at 04:00:51PM +0100, Christoph Hellwig wrote:
> > On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > > The runtime firmware activation capability of Intel NVDIMM devices
> > > requires memory transactions to be disabled for 100s of microseconds.
> > > This timeout is large enough to cause in-flight DMA to fail and other
> > > application detectable timeouts. Arrange for firmware activation to be
> > > executed while the system is "quiesced", all processes and device-DMA
> > > frozen.
> > >
> > > It is already required that invoking device ->freeze() callbacks is
> > > sufficient to cease DMA. A device that continues memory writes outside
> > > of user-direction violates expectations of the PM core to be to
> > > establish a coherent hibernation image.
> > >
> > > That said, RDMA devices are an example of a device that access memory
> > > outside of user process direction.
>
> Are you saying freeze doesn't work for some RDMA drivers? That would
> be a driver bug, I think.

Right, it's more my hunch than a known bug at this point, but in my
experience with testing server class hardware when I've reported a
power management bugs I've sometimes got the incredulous response "who
suspends / hibernates servers!?". I can drop that comment.

Are there protocol timeouts that might need to be adjusted for a 100s
of microseconds blip in memory controller response?

> The consequences of doing freeze are pretty serious, but it should
> still stop DMA.

Ok, and there is still the option to race the quiesce if the effects
of the freeze are worse than a potential timeout from the quiesce.
