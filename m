Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90535EA13
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 02:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhDNAnE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348830AbhDNAnC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 20:43:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51442C06175F
        for <linux-acpi@vger.kernel.org>; Tue, 13 Apr 2021 17:42:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bx20so20420598edb.12
        for <linux-acpi@vger.kernel.org>; Tue, 13 Apr 2021 17:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0/LF5DvnJRfIsal2eM96sTYXDhf7ujpklsSaSTIhCQ=;
        b=CNJ4765pxcQst3JPb+keJePZ0HFK55PaPj2fLwYDS8pSubS6w9mb52dlvO7uhUesC/
         0i2SgQASheLanq9zIYXbCdUex+W0wr2QB9JmhvaAFrcxgg0cz8g20yptXvt7TYuk1kiY
         aISidfsijHZe5TA7FbhIlEyU+D45ILGqxmoZmFfg/4EeJO6UWni+N2alXO/LLgkfPVzF
         sNvcIC7dG+/yneHoloul/QAv3McILDmeTVXxHI5XvETVQVOwdTP/CxkiNrXlvogmoFw3
         m4j/mQhik0wC3P0eW1XqpvX0PNTe1gLw1e2Izjrqv3zmJt8qccPVHI2s0yXFh3M4PyiB
         1ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0/LF5DvnJRfIsal2eM96sTYXDhf7ujpklsSaSTIhCQ=;
        b=RPsmnYYBqDpDCMkyZ4VxELoyn710Jd39LUeFAvqAeusXz+9Ckh0ZiLkBED24UzV9nT
         K03wSxkncfI52rRUmQRr9lCzwZkbbFcZ23NEMjHYwbWzbMJWKor1hHOW1jIvvvDYeU+l
         XukLq04AxaXd2VupGV+7VW9t/yvpIlgtvS+0vwTByn7a9WPK7u9/mn7hOOP37Dc6vQUS
         9XZc2euAWqBcRSfuzR/8UCDR2pR23KMx1NhBVIRkgYHw1HWZNdr9kmk3NcyNdoUx1yUv
         eaJoveVDiFlN+aB2wWUC7HZxJRpW+oHiGjXXKd94Wh0oix1gWkym+k1RvBDVt63ZAedh
         43Qg==
X-Gm-Message-State: AOAM532rZg/SRyauARxfO9npqgDFtIjJnFjXj9I3hyn1XRlcy+cJwF49
        HvkmrkKSNMv76Pd0IZAwwbvS9uDEQKE8PKTxQo4/Rw==
X-Google-Smtp-Source: ABdhPJyXxaS9ws5JexMsQ9jpzAyjNPpLzva4YKcYyK5ySXxW+uZ/4BpxgjZQotc3a2CNdcE9b5jHRf+QaYIK7FM1jAQ=
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr37499178edb.97.1618360960988;
 Tue, 13 Apr 2021 17:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728744762.2474040.11009693084215696415.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210406173845.00000bec@Huawei.com> <CAPcyv4h4z9Y_Zbzk_jiZXs6+gPAbdw0UJHW5NvTaM2ZcvJ6ftw@mail.gmail.com>
In-Reply-To: <CAPcyv4h4z9Y_Zbzk_jiZXs6+gPAbdw0UJHW5NvTaM2ZcvJ6ftw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Apr 2021 17:42:37 -0700
Message-ID: <CAPcyv4iueMDPxcEuLg=NKydkRL+xmEn-udHjKYB493iTQShaAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] cxl/mem: Move some definitions to mem.h
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 13, 2021 at 5:18 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 1 Apr 2021 07:30:47 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > In preparation for sharing cxl.h with other generic CXL consumers,
> > > move / consolidate some of the memory device specifics to mem.h.
> > >
> > > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Hi Dan,
> >
> > Would be good to see something in this patch description saying
> > why you chose to have mem.h rather than push the defines down
> > into mem.c (which from the current code + patch set looks like
> > the more logical thing to do).
>
> The main motivation was least privilege access to memory-device
> details, so they had to move out of cxl.h. As to why move them in to a
> new mem.h instead of piling more into mem.c that's just a personal
> organizational style choice to aid review. I tend to go to headers
> first and read data structure definitions before reading the
> implementation, and having that all in one place is cleaner than
> interspersed with implementation details in the C code. It's all still
> private to drivers/cxl/ so I don't see any "least privilege" concerns
> with moving it there.
>
> Does that satisfy your concern?
>
> If yes, I'll add the above to v3.

Oh, another thing it helps is the information content of diffstats to
distinguish definition changes from implementation development.
