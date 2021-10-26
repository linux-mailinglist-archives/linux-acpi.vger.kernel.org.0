Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3743B314
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhJZNUS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 09:20:18 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34357 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbhJZNUS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 09:20:18 -0400
Received: by mail-ot1-f50.google.com with SMTP id z5-20020a9d4685000000b005537cbe6e5aso13003611ote.1;
        Tue, 26 Oct 2021 06:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHiif1LYFriOrfjzB++yGvt2qD9O9dbYoMEfXYp+7sA=;
        b=oJwmMoc91/cIpwnKjTtnY2pkxuSQDPN/ZqWNNsYwHu1IVIXnAZgCF70/hkd2dAXRmz
         M9JSRAaPcnOsrnfTfn7jDyjCAaLLzwIZThvD0GqH10y2DRNgZETWq8jAesAjSh+qE0wS
         Uumk+FhM+bws/VLUstBZ4A9PzT3DDZVmFtosQcyvzrv7pRWhzcQVke9vt+CMXSxZG5Fx
         usnhhWxBY6usuBXf8ZriMMhVRxf6hZr/gAhc0vOeIK2xDY2YhAxmA2Bo75zw4YsOLgui
         NHFgjl6iJPFzzWiJZ1FeMwVoCPq4e5QJoA7TZUFW8RStxpc0okGiJ1ObABy+3g+gMwzm
         9FHA==
X-Gm-Message-State: AOAM533A8gNg+1gmP9BjSoOnsZQppXj/NaUJxOGmjXa1/weNOG7JdZBu
        w8dVyKcKKEY12OlMVkcl296/E7cssVWp+3HvmYZKmhl7
X-Google-Smtp-Source: ABdhPJyccpQzlyd3ktf+ui2xLz7AVePTknEO8/EqIES7aQYQmNQkwKpZksqHJxBgkTA8RdlIaRcVStsCregS0ibwOYo=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr19436379ott.254.1635254274335;
 Tue, 26 Oct 2021 06:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211019050908.449231-1-alison.schofield@intel.com>
 <CAJZ5v0h3vwrNQrs8F5KQcFoNy+KyAfg6k99cwTO19g-ra7kzFQ@mail.gmail.com> <CAPcyv4jymqC5GG36YAZmoB-xm-cPdTsHkpnzGvM=mzJDYi7oHg@mail.gmail.com>
In-Reply-To: <CAPcyv4jymqC5GG36YAZmoB-xm-cPdTsHkpnzGvM=mzJDYi7oHg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:17:38 +0200
Message-ID: <CAJZ5v0gJbAM8QUaCfSPtOoW3BVhWQuvC+n2UPwrOqtQYDsiNwg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 3:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Oct 20, 2021 at 8:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 19, 2021 at 7:01 AM <alison.schofield@intel.com> wrote:
> > >
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > > subtable may be assigned to a NUMA node. Since there is no
> > > requirement that the SRAT be comprehensive for CXL memory another
> > > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > > in the SRAT.
> > >
> > > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > > Create a NUMA node for each CFMWS that is not already assigned to
> > > a NUMA node. Add a memblk attaching its host physical address
> > > range to the node.
> > >
> > > Note that these ranges may not actually map any memory at boot time.
> > > They may describe persistent capacity or may be present to enable
> > > hot-plug.
> > >
> > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> >
> > Dan, this seems to fall into your territory.
>
> Rafael,
>
> Sure, I'm happy to take this through the CXL tree with your ack.

So please feel free to add my ACK to this patch, thanks!
