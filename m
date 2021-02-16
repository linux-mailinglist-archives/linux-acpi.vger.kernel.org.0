Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05E831CE66
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 17:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBPQt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 11:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBPQtZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 11:49:25 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D51C061756
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2021 08:48:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lu16so2771973ejb.9
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2021 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ecI3AnraXxD8s3/KbtK83ACA5HZ+x4/w5NBzKVHXCM=;
        b=Wm4E81qbjZm4Ote4+krHtLMT/Sg47muTNtm9HAKUxuG6Ynbpz/zx9MMwTAxRVTsgVJ
         /dzzWYIWuocSvGpYzRWHIensXSKdcLuR4nL7RXCE+p8DgFHIcvSeX0wcN5u7/JmCK0qp
         acnyO5VrRzp2jteOXYfH01EwKQRMekKGfugDte/4je+KFj4VmoylnLVz45G4U+t/SrpB
         iZWqFLwHhLLKfGymiYFRCCxGZPBfX3wrdFNwaXAyieuKeokwaE98+EHOUIK5WC+f3xUs
         9De32myHYjeq1IRoGAK7DkzalOxPCkwfTVMLHCtzioAjkOxq3Tp1syboSAYFWZtlM49Y
         /hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ecI3AnraXxD8s3/KbtK83ACA5HZ+x4/w5NBzKVHXCM=;
        b=Uw0QBr6/c17wZ/HQcaoUKZSY6oAt+8XD8kNn3EEWjv7WjIkXGIPf3s7iyoJ82hj2Nq
         fB3oMZJNT1hdVGXUT1rYfM+Xe+RObp85FZ9+w9IS2tzULe0LhGkrEVUubGwHYtMoCgpg
         IBou4nZm3XQOUwWs6VHRdq80PHvKctC/NECuFE8jQNfr/gaSF1Jq2gbG+BwR4GhEwylp
         leuTsloSZsKnl+VXkIqlGS6fisnPoV862zSZN/PrEJi6Qw/VhTbVReI+cHgqZuhfxSnu
         BFcMJ4xG+O50cTWW7DeTf4G6eb7+TYrBCWsyU5y4xdCVftHgAGhIkJcBOxgCUnguu5ip
         d2Ew==
X-Gm-Message-State: AOAM532NKM6lyU/EjK47NNNFt7Ie8hUn0D38sP657mwfmU8aTJJw27Qj
        QPo7aQR+PkT2CG35tSbQKyHXPB3bbCRrnl31kLLo52LeQA8=
X-Google-Smtp-Source: ABdhPJw7/a6RtFAeh/ix7sMWO3UbzMvUPTqfzkV9KVjhDzFN7lG80bkPRoVGizFBbZxeH5ml2XKSfBwSVxENdDqxJEM=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr3112272ejr.264.1613494122365;
 Tue, 16 Feb 2021 08:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-10-ben.widawsky@intel.com> <20210216154857.0000261d@Huawei.com>
In-Reply-To: <20210216154857.0000261d@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 08:48:32 -0800
Message-ID: <CAPcyv4j+DZq7fkRTW+_O1-AtAQwOPD65A8M5AWg7XU9N+TksRA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] cxl/mem: Add payload dumping for debug
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 16, 2021 at 7:50 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Feb 2021 17:45:38 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > It's often useful in debug scenarios to see what the hardware has dumped
> > out. As it stands today, any device error will result in the payload not
> > being copied out, so there is no way to triage commands which weren't
> > expected to fail (and sometimes the payload may have that information).
> >
> > The functionality is protected by normal kernel security mechanisms as
> > well as a CONFIG option in the CXL driver.
> >
> > This was extracted from the original version of the CXL enabling patch
> > series.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> My gut feeling here is use a tracepoint rather than spamming the kernel
> log.  Alternatively just don't bother merging this patch - it's on the list
> now anyway so trivial for anyone doing such debug to pick it up.
>

I've long wanted to make dev_dbg() a way to declare trace-points. With
that, enabling it as a log message, or a trace-point is user policy.
The value of this is having it readily available, not digging up a
patch off the list for a debug session.
