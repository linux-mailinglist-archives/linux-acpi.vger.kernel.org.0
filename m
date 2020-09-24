Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C1277B07
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 23:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgIXV0c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 17:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIXV0c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 17:26:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA7C0613D3
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 14:26:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so819459ejk.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=in8Rg86VvfYuzQh6U7/hDwBGxF8v1AUSBmpO9E789oQ=;
        b=Prvekm5qZ88alNocW0qFgn9cNj4Z7QPimTG+psr7zIONUFcW/sHjWqo//GgbjmL/pf
         Qyi3kbx59KsXbxbt5zVjLpfbDD5wqchk4ncB4m9x1sIIdLR7f/KrMYOWvVfcwXkCNzE0
         mMBAE2hS6VPIeqVq5TwF/2xMYdk/evhZkCGinbxKW92OUZfrQKMIfnXtfyq1OMrF6fiI
         7hM62hDuLhBPU6MmQIBfypJfSQi8cEJujTeoPII/G5Q0qktgQrL9sWDMLtSQcH2vxa1e
         pAec2dHwsj0ZX6DcdP0RlhkEqNAcUa606Ui3etrBGY/9HZZN4lq2/eQdVX6P9Cnh39Wc
         BhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=in8Rg86VvfYuzQh6U7/hDwBGxF8v1AUSBmpO9E789oQ=;
        b=U45Eqf1It5e1dSFpMwTjCQuAiN9cK7W5Tp+OGVaJhXafQ0F7tse00geJUgNEctrdw9
         ir70NxqdR67QFAEA09LOKpY/YWMGWFkPU6deS53wKCzVh57p6qk0yjoHocH1a6p1oeKB
         NzEqujn2dS91URRz4nAfLBJXYv//QehrTq6Hi/7gZ04nWdRsB9FHLA+pE2lXYWIq1kfi
         5+kxStBrQtAsfj1S5HrSxTDa+fMpPtOOlfKTIedPSBj2+SdI6+wfPvnKT0elfPoankxK
         7P0slIop7oZ5qlJ0TC0rf6MpDFee1tTaX590knXWH2507Bpj5XzD+UcI+pWdzZA0oWf3
         9Hww==
X-Gm-Message-State: AOAM532Rj+oeOvMIy4WqXaRGd5w91hmxSjShT7QzYyQL7IkKlxulrsKS
        Db7CHGOxXAa9HQSMRb4fsnTuPlss9HexPEmbi9huIw==
X-Google-Smtp-Source: ABdhPJwo2nc1Tk13TPjt0rD146GmflS4xaeaqP6B2BkyjnC8iqLNN+AT1GEdOa+lozWWeYUYn6ojXC5A3ZlNsX+AQxo=
X-Received: by 2002:a17:907:4035:: with SMTP id nk5mr592391ejb.418.1600982790747;
 Thu, 24 Sep 2020 14:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159643100485.4062302.976628339798536960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a3ad70a2-77a8-d50e-f372-731a8e27c03b@redhat.com> <17686fcc-202e-0982-d0de-54d5349cfb5d@oracle.com>
 <9acc6148-72eb-7016-dba9-46fa87ded5a5@redhat.com> <CAPcyv4h5GGV3F-0rFY_pyv9Bj8LAkrwXruxGE=K2y9=dA8oDHw@mail.gmail.com>
 <d160c05b-9caa-1ffb-9c01-5bb261c744b5@redhat.com> <CAPcyv4jf9fK5oOcROMx=c-3q6aGFp89MNi-+GoZ-dy1gdNTrJw@mail.gmail.com>
 <28ad3045-9238-2a77-d74d-9660a36aa4da@redhat.com>
In-Reply-To: <28ad3045-9238-2a77-d74d-9660a36aa4da@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 24 Sep 2020 14:26:19 -0700
Message-ID: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To:     David Hildenbrand <david@redhat.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[..]
> > I'm not suggesting to busy the whole "virtio" range, just the portion
> > that's about to be passed to add_memory_driver_managed().
>
> I'm afraid I don't get your point. For virtio-mem:
>
> Before:
>
> 1. Create virtio0 container resource
>
> 2. (somewhen in the future) add_memory_driver_managed()
>  - Create resource (System RAM (virtio_mem)), marking it busy/driver
>    managed
>
> After:
>
> 1. Create virtio0 container resource
>
> 2. (somewhen in the future) Create resource (System RAM (virtio_mem)),
>    marking it busy/driver managed
> 3. add_memory_driver_managed()
>
> Not helpful or simpler IMHO.

The concern I'm trying to address is the theoretical race window and
layering violation in this sequence in the kmem driver:

1/ res = request_mem_region(...);
2/ res->flags = IORESOURCE_MEM;
3/ add_memory_driver_managed();

Between 2/ and 3/ something can race and think that it owns the
region. Do I think it will happen in practice, no, but it's still a
pattern that deserves come cleanup.
