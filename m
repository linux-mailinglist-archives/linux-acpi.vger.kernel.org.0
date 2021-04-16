Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3A361C98
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhDPI6p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Apr 2021 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhDPI6p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Apr 2021 04:58:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB84FC061574;
        Fri, 16 Apr 2021 01:58:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so10062425pjb.4;
        Fri, 16 Apr 2021 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyksKIc0n99yyssJwpLodM7su3j1qqWMI7llYytjMLA=;
        b=s4ZUhAbBBYMQyBJ8UDvVDeZfS5T6fksET6rRhsvhjsuO6o3xLhSRkRfgdwPf45TSVt
         pdUXmhclFsQj28vfKUwd48QFri5adJPKCM/nfO9UBrOWI4F/Rbm10wzm7n3V1jQnhXqp
         7WwWLaC7Ga0GS+2v4M1QX9EeiC0ItGg2HLBlwv1/esC4e3QCxDQmKWT0Fsr8nwa27f4T
         Fdb605eJp2cwUaWJU7eKDOfoPxGF+NwiucwhdBoANDEi36avGNTAmbkQDiHuSUwwkDHQ
         5T/0vwGnOVbEB9VT2Nh4p098lRh49sfXouYX1Mc1ey/gviRCYQeMRDhjMdYGGpGGYCPI
         2JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyksKIc0n99yyssJwpLodM7su3j1qqWMI7llYytjMLA=;
        b=XauXrSQwX5GrHNSqw0fmEwYF05GF/2mf5x7RlzYJIQfqX6vAbXl91PIbiX4Uny0KLN
         yeKALZlWr/mfqRz0e1zETEO2pU29HeYpl8G5qsfXZkUxUceSUTJtJs5+lpbXXQT8lcoZ
         aumsWql6lnOHnUKYNOOiljUH3J/YpxZJvsSvqwYpJ5k6saoHMD17g+YqAtV/gEoosyqo
         UVi4m0C4svQePlZ2UUYvSvIkWVrGiHiLfYI5LVCXTv0SpLZvCFn7wdfYbj5wEdLv8zSR
         7cM8JOjrebLBPYl9zm7RufLweTznoNqoHisR476ZtZGyGK5/oDQCLNJ4udsWE1wpAvw7
         mGBg==
X-Gm-Message-State: AOAM533qfl+TPicwmGur0SYyLkj+1MbyZiNLv3dxvvqlRM41ukfSzzLD
        znVp9OgVCUQX4Kib0OKN+tHyKwFNj+U/9+g+3Og=
X-Google-Smtp-Source: ABdhPJxWGtnFV5kGAdlHfZ+DRtP1VYBmnDUF/0bodAjP5X1S1rLrqE8Hol9qraBAphaCkhMo5/rJQ+zW78879flvW8Q=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr8351889plq.17.1618563500287; Fri, 16 Apr
 2021 01:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com> <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Apr 2021 11:58:04 +0300
Message-ID: <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     Dan Williams <dan.j.williams@intel.com>
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

On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Strictly speaking the comparison between guid_t and raw buffer
> > is not correct. Import GUID to variable of guid_t type and then
> > compare.
>
> Hmm, what about something like the following instead, because it adds
> safety. Any concerns about evaluating x twice in a macro should be
> alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> not an array.

ARRAY_SIZE doesn't check type.
I don't like hiding ugly casts like this.


-- 
With Best Regards,
Andy Shevchenko
