Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43A15B389
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLWXm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 17:23:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45581 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWXm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Feb 2020 17:23:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3569616otp.12;
        Wed, 12 Feb 2020 14:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCkVC9NqRVI+yjNU/x8RfyABDYXvK7aIQSvHuq/V4LY=;
        b=LN9x4PDO+sbBYznxmJJpB//3PbHAMxr+Dp5f68RGgky0vQ9m+OnrSok2gkRLz8OYZP
         OcPZh4G/zHgHBOYk1Mf86x9y9w5ZgUjRYqsy8twmCZOMi/Jtn0ZWXPXfB7GcXzJd3+GX
         b3E8V51ecpAmwf6152/LMDkRMd1hgKXxNBSQQY9WpAaDKIdh2RqwChEPqENzhtGkcBzv
         yZoSa4mBK28ucbkIDR8CUIKWAStq6opTiDsuCgEfB0M6QQrRFBIoXTDiTi1kzAyaDi/T
         EAmGKIEs2/yye5o5RhC63z8N1hmBd+MmHRhatkX3AXSVkL2LfwRNy63730vSQKZsTz2d
         Xgug==
X-Gm-Message-State: APjAAAU3/cuf2rmayPiLu4fLNJCwltLLnieshHv3IBUVzjmjZFrPtgye
        yOmpUCf8lHSjkGk50CXUOBIw2YXeusO9eXhe+3+SGQ==
X-Google-Smtp-Source: APXvYqxfTT8qr8c4bypJ1HYQhwx61Zp/gO/g6UAOTefrhcOIgagR/0Bd4khYcmlsGTGodOF7H7aii0b1l6/sTkrq4f0=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr11303250otd.266.1581546221551;
 Wed, 12 Feb 2020 14:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20190805142706.22520-1-keith.busch@intel.com> <20190805142706.22520-4-keith.busch@intel.com>
 <CAJZ5v0hCkibcbiYdPmBXdnDHZbGP2q0uNRi01oU0NMz5o3WwGA@mail.gmail.com>
 <1922204.kTHyOg1r71@kreacher> <CAPcyv4iLyHLqRD4E9HHx+pcRVHkF8zYKjCBE9YDQOiZTQVyo0g@mail.gmail.com>
In-Reply-To: <CAPcyv4iLyHLqRD4E9HHx+pcRVHkF8zYKjCBE9YDQOiZTQVyo0g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 23:23:28 +0100
Message-ID: <CAJZ5v0gsgWOROhbXaknirQ_J+ed2R6-zpMXWAcb8mxQGi8Gx2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] acpi/hmat: Skip publishing target info for nodes with
 no online memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 5:29 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Aug 26, 2019 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Monday, August 12, 2019 10:59:58 AM CEST Rafael J. Wysocki wrote:
> > > On Mon, Aug 5, 2019 at 4:30 PM Keith Busch <keith.busch@intel.com> wrote:
> > > >
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > There are multiple scenarios where the HMAT may contain information
> > > > about proximity domains that are not currently online. Rather than fail
> > > > to report any HMAT data just elide those offline domains.
> > > >
> > > > If and when those domains are later onlined they can be added to the
> > > > HMEM reporting at that point.
> > > >
> > > > This was found while testing EFI_MEMORY_SP support which reserves
> > > > "specific purpose" memory from the general allocation pool. If that
> > > > reservation results in an empty numa-node then the node is not marked
> > > > online leading a spurious:
> > > >
> > > >     "acpi/hmat: Ignoring HMAT: Invalid table"
> > > >
> > > > ...result for HMAT parsing.
> > > >
> > > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Reviewed-by: Keith Busch <keith.busch@intel.com>
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > When you send somebody else's patches, you should sign them off as a
> > > rule, but since you sent this one with your own R-by, I converted that
> > > to a S-o-b.
> > >
> >
> > And all patches in the series have been applied.
>
> I want to flag this patch (commit 5c7ed4385424 "HMAT: Skip publishing
> target info for nodes with no online memory")
> for -stable to cleanup a spurious WARN_ON:
>
> WARNING: CPU: 7 PID: 1 at drivers/base/node.c:191 node_set_perf_attrs+0x90/0xa0
> CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.3.6-100.fc29.x86_64 #1
> RIP: 0010:node_set_perf_attrs+0x90/0xa0
> Call Trace:
>  ? do_early_param+0x8e/0x8e
>  hmat_init+0x2ff/0x443
>  ? hmat_parse_subtable+0x55a/0x55a
>  ? do_early_param+0x8e/0x8e
>  do_one_initcall+0x46/0x1f4
>
> Do you mind if I forward to stable@, or do you collect ACPI patches to
> send to stable@?

Please forward it, thanks!
