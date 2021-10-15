Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA742FB81
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbhJOTAx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbhJOTAx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2021 15:00:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B5C061762
        for <linux-acpi@vger.kernel.org>; Fri, 15 Oct 2021 11:58:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 187so9119001pfc.10
        for <linux-acpi@vger.kernel.org>; Fri, 15 Oct 2021 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUVVZl7HmzvGFZyvrbMF+fVZnC7oF0xiadCI0HLlydY=;
        b=R4/9M8hQjaGMCGtCsssHhqS/9BPEAuCt9ZCHOSil6tdQti+Vu5QhOMVwT/p1Fio+p5
         1OvAosxtBvGVYs/RUtmRnu6QLzSFX7jEy/dVaSCoEl4fvsEgNEo/J8G5c+lDJz1Id+R7
         MqAqKwsB1kAiNGiYaJAJf8qzt2Fw8fYc74swudRBbvsv/sED31DzzUUYXfi8/J+4jWVg
         ug0XcRmmb5nvlW533o3jRBb12xrmdgFOCs9JIYsMKJj3zBzhGYtZw/DeaQwJA4tCWPy3
         oUXiTzQAxB+e5uX9FzxLsLAms25ACLvdrVPMVPFt6blKBsbphU+9IGHP7SSZ4lmDaybA
         MxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUVVZl7HmzvGFZyvrbMF+fVZnC7oF0xiadCI0HLlydY=;
        b=RJ0XtwhYtj8xvdgP8pElC41uPgVlDYgLByFfcMAT7qaTX0oeHTMPgV4OGNdUMw/QOn
         xTtY32SYTR8H4xQ78BLwsI5u9u9auwQPMJW4PkgtkhHYQCGOo31KspQ0ET4hQCCQWtBH
         27UsOtNG+3bokpaw63SdHOozKssWge/b2c1f4DyJiVVlgcrG24tY+yWHvBTLOjFqNlT+
         ZNTZwOqDiyqWelEYKeqloLom3xFdQUqsI5UUYldyhi+YrIEge372/fYOsCc9y2snFAz+
         8WOsSJQcYioJ0oefVhWBXCJNnNdN6fcX6fdF0WPpHMi8lfQA3tErFXSpQNDa88vWtWGK
         GZEw==
X-Gm-Message-State: AOAM533Y05sMDfe3/0B5HYkljDT3/8oF2/A3uhBwDiVT175Ke3qg4TCR
        oXo/9uOagI9V8AaaX+2JRueHuRFpzqRhGUwc8L2Nzw==
X-Google-Smtp-Source: ABdhPJzJQXeWMsEtdpwGfdVFrMVDVzMCw04c5dQ2z4Lmid7fDU2qeRlxGgIOH6yOHvuPxSmsMiOFWMr1nUi325chN0I=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr5578333pgc.356.1634324325624;
 Fri, 15 Oct 2021 11:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211009015339.400383-1-alison.schofield@intel.com> <20211015175943.000070b8@Huawei.com>
In-Reply-To: <20211015175943.000070b8@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 11:58:36 -0700
Message-ID: <CAPcyv4hziy_+aHz7SSJ0441saDwfHeNyHsB1DMsPjPg7aFHzeg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 15, 2021 at 10:00 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 8 Oct 2021 18:53:39 -0700
> <alison.schofield@intel.com> wrote:
>
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no
> > requirement that the SRAT be comprehensive for CXL memory another
> > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > in the SRAT.
> >
> > Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> > Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> > NUMA node for each range that is not already assigned to a NUMA node.
> > Add a memblk attaching its host physical address range to the node.
> >
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable
> > hot-plug.
> >
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
>
> I'm not sure that a CFMWS entry should map to a single NUMA node...
>
> Each entry corresponds to a contiguous HPA range into which CXL devices
> below a set of ports (if interleaved) or one port should be mapped.
>
> That could be multiple devices, each with it's own performance characteristics,
> or potentially a mix of persistent and volatile memory on a system with limited
> qtg groups.
>
> Maybe it's the best we can do though given information available
> before any devices are present.
>

Regardless of the performance of the individual devices they can only
map to one of the available CFMWS entries. So the maximum number of
degrees of freedom is one node per CFMWS. Now if you have only one
entry to pick from, but have interleave sets with widely different
performance characteristics to online it becomes a policy decision
about whether to force map those interleave sets into the same node,
and that policy can be maintained outside the kernel.

The alternative is to rework NUMA nodes to be something that can be
declared dynamically as currently there are assumptions throughout the
kernel that num_possible_nodes() is statically determined early in
boot. I am not seeing strong evidence that complexity needs to be
tackled in the near term, and "NUMA-node per CFMWS" should (famous
last words) serve CXL needs for the foreseeable future.
