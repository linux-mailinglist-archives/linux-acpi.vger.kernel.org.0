Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358D539E4B7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFGRHA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 13:07:00 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:50876 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhFGRG7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 13:06:59 -0400
Received: by mail-pj1-f48.google.com with SMTP id g4so778322pjk.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyajxUxD+qII3ozGjsYJB4YKIUgJgPWfBGe14Hw5m2s=;
        b=ed/0PzMWKcKEyHTP/yKjwBx0JvITUSJQcZm8zLlSmnLmTn3XfbBvCvTUprBKit9LiI
         mEfZstpZ3HjM4s5khmBvBsJH5XdDYs75OEPphft1zPtGdG19kU5l7Qlu/lko9AmpgoK9
         qknyWnlJ8aIDK5ItieJ1cII0XqSLwUe6h7PBLQ0xnTzzzeGgARou9TXEx6NJ1mTWa+dz
         PboVozhKwY82GAQ/HNVbBi4ykNnfwnOjefgWT/P3nMz8jalTcpRqQ6XxZitfCdIbOMHG
         8HGzmoRQp53yAfDM6W+uPM3XfWtvsu2WRGhyqB9p6ocpzivvWRB6d16bwdVDKhCqDrsQ
         UTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyajxUxD+qII3ozGjsYJB4YKIUgJgPWfBGe14Hw5m2s=;
        b=lTiNJwY6NqqMOX0plLo9CElDZiqHd6wSNig7n/ApDZkTSo2Uv8SFxKXbs0CI+xGfd3
         s/kkZaJuUmiCoT1ifXZVLz44Xp5IrskDf6kEhqUul3GpU9Pzudu/w5yKzbiGOgWSy5+e
         HcnIjtZFA019gd3JRuIdEPUJ253xaRbLuIy2UZKNvhwMZrFjiJ/eCB948Q//iWiaRE/5
         ZrPnzUiqiUKfhlkRd5y3Q1oUZ6N9RQfeF5RMxZpageg2DZQzy4jp4hqn7pcYuQ6RBSOG
         r6yl+1gXc03vrXlKska/wr06hr8Uy8ENQHKmLslkAjrKAAseRmP4o4gK9sCX9pyiFTLD
         cMdA==
X-Gm-Message-State: AOAM532liSl9AsqcPSPrhjUrtEH9Ay3Y8vxx/QhKqa9lQeVFWARCyVgG
        LAPA+rLVX9OuLgdIDatw2orwQP/WMhIu5zPDRCwLOA==
X-Google-Smtp-Source: ABdhPJxYAfvSMbKm5tmzBj3vnoPe4a8Paiz65/ivTITcRl25ajJ+YtxumvZdZK55xIyWjmiQ3dvqnRN/amfMUhHvDrM=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr114198pjb.13.1623085448150;
 Mon, 07 Jun 2021 10:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jun 2021 10:03:57 -0700
Message-ID: <CAPcyv4hZTrf8a-Ga6yWxMqeg7xy=p5_m6CXKssXY-eKG9otsqA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] cxl/acpi: Local definition of ACPICA infrastructure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 7, 2021 at 5:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The recently released CXL specification change (ECN) for the CXL Fixed
> > Memory Window Structure (CFMWS) extension to the CXL Early Discovery
> > Table (CEDT) enables a large amount of functionality. It defines the
> > root of a CXL memory topology and is needed for all OS flows for CXL
> > provisioning CXL memory expanders. For ease of merging and tree
> > management add the new ACPI definition locally (drivers/cxl/acpi.h) in
> > such a way that they will not collide with the eventual arrival of the
> > definitions through the ACPICA project to their final location
> > (drivers/acpi/actbl1.h).
>
> I've just applied the ACPICA series including this change which can be
> made available as a forward-only branch in my tree, if that helps.

Yes, please, that would be my preference. When I created this patch
the concern was that a stable branch was possibly weeks away.
