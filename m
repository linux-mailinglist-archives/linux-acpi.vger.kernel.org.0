Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ECF362586
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 18:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhDPQQM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Apr 2021 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhDPQQK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Apr 2021 12:16:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBBAC061756
        for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2021 09:15:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mh2so21392456ejb.8
        for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2021 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dght6t2pyQRseqLb+lVrCX02nFkhCRTaAH41zfKcecM=;
        b=u7wanB8F6bCPCqjo1mmYJiBBZNtX2jw3FB+isUTy9l1h4n3idyqjUbdcD+V2z9q+46
         j6PszlzUe7vhdE0rcfHy3WAgCElEf4YEr0XyzZVKzldzCuEgMUN1D6O+sQenSJpg/2db
         g1AkNA5TJ4Tl9pIAMT6z8az648EMAHB1zhHxcSOQzuYwrmk7zatzsHPk7q27Gt1Jvi4P
         V1hkeiobgr/aGiYpf1kpo9tuSWeiwifYzUj8K+X1XS659n8mCKVuc14K0C5yESgO9fSE
         NDcINVSA2Hq//2HStl2+7sPJVy1sVaiA2kQzSEbkCbd7QQ4LFd62WC6+AmxQWBVCJno1
         sDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dght6t2pyQRseqLb+lVrCX02nFkhCRTaAH41zfKcecM=;
        b=efQVF0rtxbpMT7uDeDuyiR/+hv1hX2a55Q7tCyNlFdkpR9ZuQp3iMBFFHzSx8drgO1
         Kr/WljUOxD+5O2eqqOzFxQ47A6nKXH9T1YvNxCk2qoukdXnuNHfWnF3QJNSF4FKVHH2D
         2wnWsKyUtf+PLm+ruOkS+gleMnJg/wavtVy+QQYA1W3lRs/Sx1gf2GDfLgcuJJ0wWndJ
         68ekblZBIuz9flr/QCOKViTv4/pmXkdA1tIYffNfF2g4Hy110cMSRhqosv9bxjj5EpFM
         8BmfGOQ3LDwMpHfHP5k1sYkd/iUz9pqqwYYGEb/WYw/urakg5BUYFYitiIz6GjCdDdN6
         0zhQ==
X-Gm-Message-State: AOAM531WnyFntaNsykzqmO4EK09L/CDjMdZjJghfEH9tdxTN+8ZvnhYY
        KzBnFJeOCabgLY6bYsB2HDITsmKMGx8iTQ/uPwXBhA==
X-Google-Smtp-Source: ABdhPJwj2vAvYOe63/DPsEm6y2cjiOfb+/u6lZjT0ubYCymFcdqXfUxqTqmSJW45RL33s8fRQUkr+b4nOGvpv8WyzdI=
X-Received: by 2002:a17:907:20e9:: with SMTP id rh9mr9284048ejb.523.1618589744375;
 Fri, 16 Apr 2021 09:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
 <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com> <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
In-Reply-To: <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 09:15:34 -0700
Message-ID: <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 16, 2021 at 1:58 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Strictly speaking the comparison between guid_t and raw buffer
> > > is not correct. Import GUID to variable of guid_t type and then
> > > compare.
> >
> > Hmm, what about something like the following instead, because it adds
> > safety. Any concerns about evaluating x twice in a macro should be
> > alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> > not an array.
>
> ARRAY_SIZE doesn't check type.

See __must_be_array.

> I don't like hiding ugly casts like this.

See PTR_ERR, ERR_PTR, ERR_CAST.

There's nothing broken about the way the code currently stands, so I'd
rather try to find something to move the implementation forward than
sideways.
