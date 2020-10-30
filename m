Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08D2A11B2
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Oct 2020 00:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgJ3XiZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJ3XiZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 19:38:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFBC0613D7
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2020 16:38:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bn26so10863273ejb.6
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2020 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaa2w71+rAnegpLmEA2VDedlv8/1hcf/ls0nVw+ay8M=;
        b=j7YlVXzIXvjGz1W6wEFr2IvRljmaLyvNl6Sitp/ndZBcdpRSezt+q9fRmxZn4pLzXE
         8eNWbtmKtKsGsAUsmqxtrEJlTHd/uU2OJpboirYrbrnJyLvtkL1Anj34NYeLjzwWz7tB
         6gWESVcqOBo75SYm9ApScZXlMZCvXsGgPNsvRpOrXYORV17Hxx89Yb/tPeU3AdG6kkLD
         8B3JuEHKxIL9CMAtWGbtBz/i0mmMyROApTdPYpZUD4S/j9joh9xZK+NVxnCpwTdht9PK
         g6flXD2dkWzOUEnLOFMTFCktAIpA5VWmEYswM+mXJNHhzUCL043PXLSUjuPKoh6l9XOK
         IMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaa2w71+rAnegpLmEA2VDedlv8/1hcf/ls0nVw+ay8M=;
        b=B2sKMhE0dBIUGK2GojLSKOBvyyKTQkY990Gt9dbLCMFDVJQj4nSZpJRUlfqY1VG0Zd
         45LEB7e867GOGHo+bO4FTl5MUpPxuLf/dR8RAmBAI9F7BtnH2vjRVu+ddTSksCbmIJKE
         iIUqe3kVoLjlFa90S/5lXprAPFyv8Y8Qt/+RbMpyPJTBMHPOXeP7B+FBbmwoQFo5Zcqk
         ilAkXNmb+tyC6THrvSQFrY/hx+qe3XfxvjeN/w4SvWenGMgAwjE8wlh9uLkmYaJwPKeI
         khemBxuboHbKmYmEtXB3NPKYtmaan09MJrM9cVZ6y989mlrx18riCFEOMu2f6LTr+8vN
         EhWw==
X-Gm-Message-State: AOAM532YHvJpgcBWPO+ZtEwWojKYM5yEUUNXZoXrBaXMrExW03IGoGGc
        v5I5iOTivY1AZkG1F+fVnQgCfDgqaOmvpxnKBAZ58Q==
X-Google-Smtp-Source: ABdhPJwtCc03Ww3ywaAqzoU92hBs1onakLTktmy+A5i4c4DmLDlGm2KKz1byL4yamBvY1Ggn2mnktBVK6SECvhrWldU=
X-Received: by 2002:a17:906:241b:: with SMTP id z27mr4382398eja.418.1604101101947;
 Fri, 30 Oct 2020 16:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com> <20201030205956.GO27442@casper.infradead.org>
In-Reply-To: <20201030205956.GO27442@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Oct 2020 16:38:06 -0700
Message-ID: <CAPcyv4iNeTGrLLN6XLOc+c9CRUODfw9bi0GpjpJuYywniP6dXg@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 2:00 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 30, 2020 at 01:37:18PM -0700, Dan Williams wrote:
> > On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
[..]
>
> i don't know what you're talking about but you must both work for
> hardware manufacturers!

If only there was some software project that could comprehend these
details and synthesize an interface for applications to use. Even
better if this project had mailing lists with experts that could parse
the acronym soup into code patches.
