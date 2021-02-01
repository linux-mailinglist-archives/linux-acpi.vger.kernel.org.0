Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE730B27F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 23:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBAWDB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 17:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhBAWC6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 17:02:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325BC061786
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 14:02:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f14so2509075ejc.8
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=yRi8mguQqwGyP74Lz8HnidEorwfF7klt4qQMuE6uyPGrI0nnVf3UO1/tbJR+kWOOGR
         dWmIQcJgh8tUURN0ieUfGpl3soucjW0wrSDuKx6Y9XL66sU8opnIg7sxdwSNSWp0fLIr
         nQTxV7ahPPxceFtgJKNxCIJWgLTD7hfKHYxTCqUPpp1scoT0JWUDr3XWsuBhkaWsp2Ko
         ku9Jrb6DLqZ+8d/xmEcVgGxMbIkRA+sIynA/F4cTTRjVtBfrkLzvKwBPHtBFKCEVpHC4
         s94dtYIxVabjk/YTMSmQlvYnC5/uXpJNxnnYFAza3R9pXfMZNpwI9PbJpgEUEG7m6ZhM
         cCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=tB5/m6cADvdOlyN6vDjquRRXIJe3qP6UnocCz/8bvPrnPQyPXoow49jwgl9h58w9hk
         6894O+nkYbT4A0sSO76vGO4CgavgkajZy6l+LuyqkKU3kkU7Hbb6rz0fycEyryGpntPP
         ZROWDopcYzwhIEUAbN2Y5o4FW7h80lB3Pg4bEfQ2ORijpz5VPxiMLO2EerxoKkxa9uz6
         EOm946HLopY3yBz8qo03yx659Bv7TVydH+5thtaXeRrZN6vy2MNrfP8lY9KgmLwsSAW8
         bxlNjFIq0wCRZjvBtcpGKpMDS/YU7lDuAZPXanHU2qFYlsAaPErp10/JylfwBJ2UzrXA
         cckg==
X-Gm-Message-State: AOAM532lyvPIUNxXrzMeTlN7Met3LtEdfNJCcKYR4SExh4GLmOrDus4h
        3vKcgIh42tqd30s7FRFG9HCmek2WaClU03lYSXSpJA==
X-Google-Smtp-Source: ABdhPJwx5HQJkiYYzBPXX7BYLe1eriXrLIkYHDMYupmuWFH/I1Xqh4x+vyz3z88NdGsEK2HXTHd3EhXx58RQNYJdZQ8=
X-Received: by 2002:a17:906:af6b:: with SMTP id os11mr8117536ejb.472.1612216934397;
 Mon, 01 Feb 2021 14:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
In-Reply-To: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 14:02:11 -0800
Message-ID: <CAPcyv4jyojkRqkXPK=ZgMfUATVNUf71GZsgQuarygz4QEM1o-w@mail.gmail.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
To:     David Rientjes <rientjes@google.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 1:51 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
>
> > On 21-01-30 15:51:49, David Rientjes wrote:
> > > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > >
> > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > +{
> > > > + const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > +
> > > > + cxlm->mbox.payload_size =
> > > > +         1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > +
> > > > + /* 8.2.8.4.3 */
> > > > + if (cxlm->mbox.payload_size < 256) {
> > > > +         dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > +                 cxlm->mbox.payload_size);
> > > > +         return -ENXIO;
> > > > + }
> > >
> > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and
> > > return ENXIO if true?
> >
> > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > driver not allow it?
> >
>
> Because the spec disallows it :)

Unless it causes an operational failure in practice I'd go with the
Robustness Principle and be liberal in accepting hardware geometries.
