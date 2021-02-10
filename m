Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF77316B22
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 17:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBJQZs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhBJQZo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 11:25:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFBDC0613D6
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2021 08:25:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c6so3743941ede.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2021 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aftf5Xb//YGUZGNHFmwuc6t/uQLSZi04UU6ddo7Uhyw=;
        b=ZWLScDV7QBzsS/QGzTZQMrOrh34mBJfOifvXt/Uvzqses/vJS1BkUzokbfAeZcJ3+c
         n7+oEb69S1KICanNvb7GTjAp4ly5B4JykAlCmYWiSwT9GzOjxbt0KNf2iMJTQtixuiQM
         tFDVmxy0NeJIkBF7xbVcEVXclEqCIV4On2+OPPHYNPTwYWtmNDIq7zAvafdl8Q6V/zR+
         NXHpxH3NA5RqfVb3VqfHYDWiVunAbfIbFiUJnHqlPDg74SpK9UVezPvJfVcvfAXcwLCR
         O0adF1gHdXkhrDmODyCsgqpVfLX+yeQEAuTX2QTc0vgqge6A7e3hJcywDqf7oec85JhR
         IXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aftf5Xb//YGUZGNHFmwuc6t/uQLSZi04UU6ddo7Uhyw=;
        b=C2Yv+6k8JEs3ptSb3xwGrhfKy7DJwCS0T5Xzj/uWpHAB8J617spTJ6mK8S/025U4BJ
         pHSafK08iE5+hKtwKBRvIToPi4qwkGfFvid3y/B3+qKTggHA7cmgA9vvgt7SzJh14z2K
         woAD0792cxZfut/aQeCRJddkNVsbwyLAeUe2AsCcVAdSEkqmO8Gk/o9dXvH9Wi7k/lFo
         Ni3VOH42CdYZNjFUquoa8hSfC7fh+5RSy17zQcjwxq80BEHABYN7FGKJrysrgcu9Bz/h
         dsKDi+sz8WrVgnM7aYkYg0eAS0pJtUO0cpXiaRrx3yitel6C7TYDGGhwMjMMCrLc9FBK
         vPLA==
X-Gm-Message-State: AOAM5304Ca838fWy0GiFsM4UFuyoMpQnApBYCdY+I2bNNmDpD4cplnAR
        U48Vb2Ye02RG+Vqu4XXodRDXtlnCXhcD6sUQzGdeVg==
X-Google-Smtp-Source: ABdhPJwxCGKo73fvYL2R/2ah+oI+yX6AjwBIj1RCyV21gzZjGKizGUE/8SqJF8mtAexGwA4+OaxDfKwHSE9ex1RxMME=
X-Received: by 2002:a05:6402:1152:: with SMTP id g18mr3965549edw.18.1612974301871;
 Wed, 10 Feb 2021 08:25:01 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
 <20210210112330.00003e74@Huawei.com>
In-Reply-To: <20210210112330.00003e74@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Feb 2021 08:24:51 -0800
Message-ID: <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 3:24 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 9 Feb 2021 19:55:05 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While the platform BIOS is able to describe the performance
> > characteristics of CXL memory that is present at boot, it is unable to
> > statically enumerate the performance of CXL memory hot inserted
> > post-boot. The OS can enumerate most of the characteristics from link
> > registers and CDAT, but the performance from the CPU to the host
> > bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> > ACPI mechanism for this purpose. Critically this is achieved with a
> > small tweak to how the existing Generic Initiator proximity domain is
> > utilized in the HMAT.
>
> Hi Dan,
>
> Agree there is a hole here, but I think the proposed solution has some
> issues for backwards compatibility.
>
> Just to clarify, I believe CDAT from root ports is sufficient for the
> other direction (GI on CXL, memory in host).  I wondered initially if
> this was a two way issue, but after a reread, I think that is fine
> with the root port providing CDAT or potentially treating the root
> port as a GI (though that runs into the same naming / representation issue
> as below and I think would need some clarifying text in UEFI GI description)
>
> http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
>
> For the case you are dealing with here potentially we 'could' add something
> to CDAT as alternative to changing SRAT, but it would be more complex
> so your approach here makes more sense to me.

CDAT seems the wrong mechanism because it identifies target
performance once you're at the front door of the device, not
performance relative to a given initiator.

>
> >
> > ---
> >
> > # Title: Introduce a Generic Target for CXL
> >
> > # Status: Draft
> >
> > # Document: ACPI Specification 6.4
> >
> > # License
> > SPDX-License Identifier: CC-BY-4.0
> >
> > # Submitter:
> > * Sponsor: Dan Williams, Intel
> > * Creators/Contributors:
> >     * Mahesh Natu, Intel
> >     * Chet Douglas, Intel
> >     * Deepak Shivakumar, Intel
> >
> > # Summary of the Change
> > Introduce a "Generic Target" concept to the SRAT to describe the root
> > performance parameters in the path to dynamically discovered (outside of
> > ACPI enumeration) CXL memory target endpoints.
> >
> > # Benefits of the Change
> > Consider the case of a system with a set of CXL host bridges (ACPI0016),
>
> Superficially feels like this new SRAT entry might reference the CXL 2.0 Root
> ports or the host bridge.
>
> > and no devices attached at initial system power-on. In this scenario
> > platform firmware is unable to perform the end-to-end enumeration
> > necessary to populate SRAT and HMAT for the endpoints that may be
> > hot-inserted behind those bridges post power-on. The address-range is
> > unknown so SRAT can not be pre-populated, the performance is unknown (no
> > CDAT nor interleave configuration) so HMAT can not be pre-populated.
> >
> > However, what is known to platform firmware that generates the SRAT and
> > HMAT is the performance characteristics of the path between CPU and
> > Generic Initiators to the CXL host bridge target. With either
> > CPU-to-Generic-Target, or Generic-Initiator-to-Generic-Target entries in
> > the HMAT the OS CXL subsystem can enumerate the remaining details (PCIE
> > link status, device CDAT, interleave configuration) to calculate the
> > bandwidth and latency of a dynamically discovered CXL memory target.
>
> I'm wondering if the term "generic target" is a good name.
> Would something like "generic target bridge" be clearer?
> The point being this isn't an actual target but a point along the way.
> Mind you this is close to bike shedding.
>
> As mentioned above, maybe "generic bridge" that can give us a node to hang
> data off for both, a) GI on CXL to host memory, and b) Initiator in host to CXL memory
> and hence give cleaner representation.

"Target" in the sense of its role in the HMAT. This is conceptually
not limited to bridges. Imagine a CXL endpoint that the BIOS lets the
OS map into the memory address space, but describes the performance in
HMAT.

>
> >
> > # Impact of the Change
> > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > 5.2.16.6) already contains all the fields necessary to enumerate a
> > generic target proximity domain. All that is missing is the
> > interpretation of that proximity domain optionally as a target
> > identifier in the HMAT.
> >
> > Given that the OS still needs to dynamically enumerate and instantiate
> > the memory ranges behind the host bridge. The assumption is that
> > operating systems that do not support native CXL enumeration will ignore
> > this data in the HMAT, while CXL native enumeration aware environments
> > will use this fragment of the performance path to calculate the
> > performance characteristics.
>
> I don't think it is true that OS not supporting native CXL will ignore the
> data.

True, I should have chosen more careful words like s/ignore/not
regress upon seeing/

>
> Linux will create a small amount of infrastructure to reflect them (more or
> less the same as a memoryless node) and also they will appear in places
> like access0 as a possible initiator of transactions.  It's small stuff,
> but I'd rather the impact on legacy was zero.

I'm failing to see that small collision as fatal to the proposal. The
HMAT parsing had a significant bug for multiple kernel releases and no
one noticed. This quirk is minor in comparison.

>
> So my gut feeling here is we shouldn't reuse the generic initiator, but
> should invent something new.  Would look similar to GI, but with a different
> ID - to ensure legacy OS ignores it.

A new id introduces more problems than it solves. Set aside the ACPICA
thrash, it does not allow a clean identity mapping of a point in a
system topology being both initiator and target. The SRAT does not
need more data structures to convey this information. At most I would
advocate for an OSC bit for the OS to opt into allowing this new usage
in the HMAT, but that still feels like overkill absent a clear
regression in legacy environments. The fact that hardly anyone is
using HMAT (as indicated by the bug I mentioned) gives me confidence
that perfection is more "enemy of the good" than required here.

>
> Unfortunately we can't just add a flag because backwards compatibility
> with old OS would mean it was ignored.  Hence I think this needs to be
> a new type.
>
> If we define a new node type rather than extend GI, we need to be careful
> around the same issue with _PXM that we had when introducing Generic
> Initiators (not sure the protections on that made it back to stable)
> so might need to modify DSDT _PXM responses based on appropriate _OSC.
> May well be fine but I'm not convinced yet.  Perhaps we need to say
> that using _PXM to place anything in a node defined only via this new means
> is not valid.
>
> Jonathan
>
> >
> > # References
> > * Compute Express Link Specification v2.0,
> > <https://www.computeexpresslink.org/>
> >
> > # Detailed Description of the Change
> >
> > * Replace "Generic Initiator" with "Generic Initiator / Target" in all
> > locations except where an "initiator" or "target" is implied.
> > Specifically 5.2.27.3 "Memory Proximity Domain Attributes Structure"
> > need not replace occurrences of "generic initiator" in field: "Proximity
> > Domain for Attached Initiator". Additionally field: "Proximity Domain
> > for the Memory" must be renamed to "Proximity Domain for the Memory /
> > Generic Target" with a new description "Integer that represents the
> > memory / generic target proximity domain to which this memory belongs."
> >
> > * Revise "5.2.16.6 Generic Initiator Affinity Structure" to make it
> >   consistent with being referenced as either a target or initiator.
> >
> >         * Description: (replace all text)
> >
> >         > The Generic Initiator / Target Affinity Structure provides the
> >         > association between a Generic Initiator and a Memory Proximity
> >         > Domain, or another Generic Target Proximity Domain. The
> >         > distinction as to whether this structure represents an
> >         > Initiator, a Target, or both depends on how it is referenced
> >         > in the HMAT. See Section 5.2.27.3 for details.
> >
> >         > Support of Generic Initiator / Target Affinity Structures by
> >         > OSPM is optional, and the platform may query whether the OS
> >         > supports it via the _OSC method. See Section 6.2.11.2.
> >
> >         * Architectural transactions: (append after current text)
> >
> >         > If this proximity domain is referenced as a target then it
> >         > supports all the transaction types inferred above.
> >
> >         * Other updates are simple Initiator => Initiator / Target
> >           replacements.
>
>
