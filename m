Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA322B8373
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Nov 2020 18:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRR6Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 12:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKRR6Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 12:58:24 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CAAC061A48
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2020 09:58:23 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id y17so3983678ejh.11
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2020 09:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUfbbHmtoDuKn7TpUZ579udEm3PcirZfq0eQV5TKq9o=;
        b=tvpfEwP+ZZMkMQ93Mh1f6j5FKNXm5M2Ak6FsBNIIN8BiaV0BTYVl+2KI363P4pPGhk
         4XCHCy6c/5qihFsPbRNd1ryg08ayiY0WUlMRJ7tsItKKpdl+0gXny2bzA4Yc7BDDciiF
         lm0yCD7b8wCqJOooSmMwFcwAUUnlD0g20c5tSUb4HBEO3d+SZUI228DolNZjs7b8A2Gb
         2/lhmqWLg3vKRpt8+5DeljAmd22yWaWMCTaw2KqeGnVRMXy3rZs5tI/ni2Qe2EHepKE+
         o1al2whOOjuL2T1TY5X7PNOayGhFCs+jfIlZ3vTJ4lgvHtGKFbdbUxJeUDrWuKJFi6l/
         S4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUfbbHmtoDuKn7TpUZ579udEm3PcirZfq0eQV5TKq9o=;
        b=O6iCLcGPXsBTXlzHj+l10XlUJq3JMfBTuwsDpPRUkx0l4WUZa4UxDFBpGPbNLk1PvL
         AV08vDdHdDZOS6RKrlKJtIu6y28QjyESUj091Sgcpp4t4oOpqCreTXo0TiiP9IHrBWRn
         lmcY+1u83ZcuH+U9s6IKYsNXVa/m81/LstTLVW/Lj3TIOff4wtT1cR4mwzIc1zx0XR9g
         1bvPgAEajFs6xz3w7ybxdeuiHjxwmissf6LU6lfRF8200DguanEukTNNXMon/mV/5j0e
         IcCdS291yGr5OmLPmE5b66Mzd1AgGggfMg3NTg5dDTlAKzEP0Mu/O59ff79QP2ZW0U5E
         L/gQ==
X-Gm-Message-State: AOAM530kTyiFaSbyLxDhYR+wbK1UO6aZ9ikrdXQDV+xFeCWL4zyRF5cl
        bIx7xfIFOgbgFmwYcHWe+QwZg0qYY6aAGW6beZo7jA==
X-Google-Smtp-Source: ABdhPJzAo7X20AwJvG1rn3bcJsj4ua9pJG670rFxHdWk1YJl4d0tkmXpxpdfWZiNhtz2BTcFoV1XlqYQxL6b9QgLA2M=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr21620775ejb.264.1605722302429;
 Wed, 18 Nov 2020 09:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-3-ben.widawsky@intel.com> <20201116175909.00007e53@Huawei.com>
 <CAPcyv4h_kSYhcGAdZshFPFbGPgZKCvUh9q7M=jMMRaEauUPzaQ@mail.gmail.com> <CAJZ5v0ibEXVC5vsjCfougJqp_ZbENUKmbTkCjbxVTen-gsONXA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ibEXVC5vsjCfougJqp_ZbENUKmbTkCjbxVTen-gsONXA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 09:58:11 -0800
Message-ID: <CAPcyv4ixeG9Puoob5yKRe3UDgehzJKPA32aiurZi-55-G-U17A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] cxl/acpi: add OSC support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 18, 2020 at 4:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 17, 2020 at 12:26 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 10:00 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 10 Nov 2020 21:43:49 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > > From: Vishal Verma <vishal.l.verma@intel.com>
> > > >
> > > > Add support to advertise OS capabilities, and request OS control for CXL
> > > > features using the ACPI _OSC mechanism. Advertise support for all
> > > > possible CXL features, and attempt to request control too for all
> > > > possible features.
> > > >
> > > > Based on a patch by Sean Kelley.
> > > >
> > > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > I guess unsurprisingly a lot of this is cut and paste from PCIe
> > > so can we share some of the code?
> > >
> >
> > I do not see a refactoring effort for these bit being all that
> > fruitful.
>
> Well, that depends on how much code duplication could be avoided this way.
>
> > The backport pressure for this driver stack I expect will be
> > higher than most, so I'm sensitive to avoiding unnecessary core
> > entanglements.
>
> If two pieces of code are based on the same underlying common code, it
> is immediately clear to the reader how similar to each other they are.
> Otherwise, they need to be carefully compared with each other to find
> out what the differences are and whether or not they are arbitrary or
> vitally important.  That is essential both from the revirem
> perspective today and to anyone wanting to understand the given code
> in the future (possibly in order to modify it without breaking it).
> It outweighs the convenience by far IMV, with all due respect.
>
> Recall how much effort it took to combine x86 with x86_64 and why it
> turned out to be necessary to do that work, for one example.

I agree with above, but the degree of potential code sharing and
refactoring for CXL is nowhere near approaching the x86_64 situation.
There's also the counter example in ext3 and ext4 where a split is
maintained for good reason. All I'm saying is that let's judge patches
and not theory when it comes to refactoring CXL, my expectation is
that those opportunities will be few and far between. CXL is a
superset of PCIE functionality so it should not put much pressure on
common core PCIE code to change vs incremental CXL extensions.
