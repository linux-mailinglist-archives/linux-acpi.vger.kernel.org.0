Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27C815AD66
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 17:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBLQ3c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 11:29:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42653 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLQ3b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Feb 2020 11:29:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so2488422otd.9
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2020 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=647g8a8Lt3ytHPQLGC+Zkvcfptz2Smcfs4FoMFLjKRU=;
        b=fJBoaSI0tDyGiB+SX2LJTQPvgdQN85ITMAUE7AB+w3z3H6fCsgY2DX4U6x+xEkNyxy
         lgTCrIPKF0eXqy2YBT5fSM4l3H9+XIbZH8GEGfjuQKlPxZ5p8JXCZb8r+klFRI3t7Qf2
         ESoCpMXzUxLU55bKVBpYYh7c6he8IBVIu0qiUgLNeL4CY0S8tVpLquHkAQoVUTHBg9wW
         TGgtF4DpVnYQQ3Aio3SGwS4QcMwq4T/md1bG2ZKFBe4iNy9b1iV7B3DfkGQo/4jg40KV
         vK9oUrVWlKpOfIVGuwXEggTZJvRsIrOQ0wjVoIFsMT6hK608eokjdjGoBbuDF1flSnGK
         tA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=647g8a8Lt3ytHPQLGC+Zkvcfptz2Smcfs4FoMFLjKRU=;
        b=e51jpXKbAil7GADpKXKJ8F9HloaQCPCMQ/ZkP0/f3XPmjJX/Nd69dQBNOhR0JJ4/rq
         prdwauwgCqtZYmgu3QfeeDGxT2GSamAPKn99duDBuYVkuCSVHPozhqBHkui6xkTmjph/
         CI+6XGJixI+ZH+zWJVrUkGv5/UPOh+AMCwu23soJvbB9H/D5wfo1o9HJZKStVQFMmQzM
         zgs258SGm09QN6nIkjZeVoVpOLt+Sb/xna7TJ59yOe4eorbtPew3dA2zxxlFJx20Z5E3
         Kg75cyWwtPebhj2xLJQ1tHyhZwlp0DmAMJjHKkpYMj2BUvNsx755a6IQEgcIxNKdxNWf
         4eDw==
X-Gm-Message-State: APjAAAUEsFZ8waiQIxjDO+9yasCx44BUi7EgkiRP3MW18mdRF8pOm0bV
        BDr57N2TrTTQu1fOSuMasJP040wlOg1K/2IV4F8THoPapc8=
X-Google-Smtp-Source: APXvYqwmJT3w1mf5raAkgQf5NTWMOsCpSoJRY4gg8xdeBS+4tymIkSp4wQ2G+gjIfltmRN4Tv4ku+uJQNUoLQX0avwY=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr9463684otm.247.1581524971031;
 Wed, 12 Feb 2020 08:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20190805142706.22520-1-keith.busch@intel.com> <20190805142706.22520-4-keith.busch@intel.com>
 <CAJZ5v0hCkibcbiYdPmBXdnDHZbGP2q0uNRi01oU0NMz5o3WwGA@mail.gmail.com> <1922204.kTHyOg1r71@kreacher>
In-Reply-To: <1922204.kTHyOg1r71@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Feb 2020 08:29:20 -0800
Message-ID: <CAPcyv4iLyHLqRD4E9HHx+pcRVHkF8zYKjCBE9YDQOiZTQVyo0g@mail.gmail.com>
Subject: Re: [PATCH 3/3] acpi/hmat: Skip publishing target info for nodes with
 no online memory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 26, 2019 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, August 12, 2019 10:59:58 AM CEST Rafael J. Wysocki wrote:
> > On Mon, Aug 5, 2019 at 4:30 PM Keith Busch <keith.busch@intel.com> wrote:
> > >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > There are multiple scenarios where the HMAT may contain information
> > > about proximity domains that are not currently online. Rather than fail
> > > to report any HMAT data just elide those offline domains.
> > >
> > > If and when those domains are later onlined they can be added to the
> > > HMEM reporting at that point.
> > >
> > > This was found while testing EFI_MEMORY_SP support which reserves
> > > "specific purpose" memory from the general allocation pool. If that
> > > reservation results in an empty numa-node then the node is not marked
> > > online leading a spurious:
> > >
> > >     "acpi/hmat: Ignoring HMAT: Invalid table"
> > >
> > > ...result for HMAT parsing.
> > >
> > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Reviewed-by: Keith Busch <keith.busch@intel.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > When you send somebody else's patches, you should sign them off as a
> > rule, but since you sent this one with your own R-by, I converted that
> > to a S-o-b.
> >
>
> And all patches in the series have been applied.

I want to flag this patch (commit 5c7ed4385424 "HMAT: Skip publishing
target info for nodes with no online memory")
for -stable to cleanup a spurious WARN_ON:

WARNING: CPU: 7 PID: 1 at drivers/base/node.c:191 node_set_perf_attrs+0x90/0xa0
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.3.6-100.fc29.x86_64 #1
RIP: 0010:node_set_perf_attrs+0x90/0xa0
Call Trace:
 ? do_early_param+0x8e/0x8e
 hmat_init+0x2ff/0x443
 ? hmat_parse_subtable+0x55a/0x55a
 ? do_early_param+0x8e/0x8e
 do_one_initcall+0x46/0x1f4

Do you mind if I forward to stable@, or do you collect ACPI patches to
send to stable@?
