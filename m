Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0F1323F2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 11:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAGKm1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 05:42:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43237 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKm1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2020 05:42:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so39440114oth.10;
        Tue, 07 Jan 2020 02:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nd8jgbCvZkL/081SlQ6LZjHh33JnnHni+WG4RTXiTgw=;
        b=edlbGvO28MeGtUyxeKAMGb48F+V37DzH/JTE2+U4t1oQSehY+a7cNsI5+oarWXhCjg
         8QOYcc5vdVFSeUWvP+AzznVEwYUZdmmnWLKqxMj+6rfpvd2JSa9K0SzRMC+/zV0M9FsC
         LsGKa7iOI43UU6+30keebmE9faIdi6QtzTqQrvdjqfeQ7DjM3Yhy+NTJtXSJlpwkA/8T
         sisMPGV8Z2c7xqW7fRSXmbAYpJvZmbABCHWhYcpiLT3W3cicCuW2mrWdUV8u4mCngapf
         gndsfNhINV8N1BRK7iy5jhlC+lgaEyWea7IYQmEqXBU5uQVCRJaIu/oP0n17qmfdQcYM
         nFPg==
X-Gm-Message-State: APjAAAWJxFqeOAsd3uflXxjAXRoYQNa8xMnoE4M61qJ7cJCethCIEhPb
        M3UsQqnsloNsGbJo7LuhGkM8ut6SgoXHpPGRftI=
X-Google-Smtp-Source: APXvYqxhZ7xy5gDsh3CimaPszslaURcaXBI23q5xLEQB8oWuHipl9EqnxBuiyWQfiYgsVWI52Ni7PlFZ09sDvbDn9Lc=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr118557717otr.262.1578393746844;
 Tue, 07 Jan 2020 02:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20200106163735.1826-1-cai@lca.pw> <20200106223500.GG8314@dtor-ws>
In-Reply-To: <20200106223500.GG8314@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 11:42:15 +0100
Message-ID: <CAJZ5v0j5EtDfP4ydVP0jbYytwQ3De5zo+cUUONwYub2Wq2oyqw@mail.gmail.com>
Subject: Re: [PATCH -next] drivers/base/test: fix global-out-of-bounds error
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, Qian Cai <cai@lca.pw>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 6, 2020 at 11:35 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Mon, Jan 06, 2020 at 11:37:35AM -0500, Qian Cai wrote:
> > The commit c032ace71c29 ("software node: add basic tests for property
> > entries") introduced a global-out-of-bounds error because it forgot to
> > add a terminator of "nodes "for software_node_register_nodes() to
> > process.
> >
> >       # Subtest: property-entry
> >       1..7
> >       ok 1 - pe_test_uints
> >       ok 2 - pe_test_uint_arrays
> >       ok 3 - pe_test_strings
> >       ok 4 - pe_test_bool
> >       ok 5 - pe_test_move_inline_u8
> >       ok 6 - pe_test_move_inline_str
> >  ==================================================================
> >  BUG: KASAN: global-out-of-bounds in
> >  software_node_register_nodes+0x41/0x80
> >  Read of size 8 at addr ffffffff989ef250 by task kunit_try_catch/316
> >
> >  CPU: 17 PID: 316 Comm: kunit_try_catch Not tainted
> >  5.5.0-rc4-next-20200106+ #1
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
> >  03/09/2018
> >  Call Trace:
> >   dump_stack+0xa0/0xea
> >   print_address_description.constprop.5.cold.7+0x64/0x384
> >   __kasan_report.cold.8+0x7a/0xc0
> >   kasan_report+0x12/0x20
> >   __asan_load8+0x71/0xa0
> >   software_node_register_nodes+0x41/0x80
> >   pe_test_reference+0x1eb/0x1200
> >   kunit_try_run_case+0x6b/0xd1
> >   kunit_generic_run_threadfn_adapter+0x29/0x50
> >   kthread+0x1e6/0x210
> >   ret_from_fork+0x27/0x50
> >
> >  The buggy address belongs to the variable:
> >   nodes.21544+0x30/0x920
> >
> >  Memory state around the buggy address:
> >   ffffffff989ef100: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 00 00
> >   ffffffff989ef180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  >ffffffff989ef200: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
> >                                                   ^
> >   ffffffff989ef280: 00 06 fa fa fa fa fa fa 00 00 04 fa fa fa fa fa
> >   ffffffff989ef300: 00 00 fa fa fa fa fa fa 00 05 fa fa fa fa fa fa
> >  ==================================================================
> >  Disabling lock debugging due to kernel taint
> >       ok 7 - pe_test_reference
> >  ok 8 - property-entry
> >
> > Fixes: c032ace71c29 ("software node: add basic tests for property entries")
> > Signed-off-by: Qian Cai <cai@lca.pw>
>
> Thanks Qian.
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thanks!

> > ---
> >  drivers/base/test/property-entry-test.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
> > index da812834b631..abe03315180f 100644
> > --- a/drivers/base/test/property-entry-test.c
> > +++ b/drivers/base/test/property-entry-test.c
> > @@ -366,6 +366,7 @@ static void pe_test_reference(struct kunit *test)
> >       static const struct software_node nodes[] = {
> >               { .name = "1", },
> >               { .name = "2", },
> > +             { }
> >       };
> >
> >       static const struct software_node_ref_args refs[] = {
> > --
