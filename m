Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA76F3831BA
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhEQOkY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:40:24 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42598 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhEQOhy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:37:54 -0400
Received: by mail-ot1-f50.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso5705213otg.9;
        Mon, 17 May 2021 07:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NckZasYwppczdByDqqFewgoeWqW3ZlCi71o1s2rUwaY=;
        b=KfA15S5sdGPsjAk9coVCjszEkArnwEuPK6U8RsBqyphpEY4AgFlO7C9tSEWEb7YQdT
         Uo7GpTNij31zFQ4QLSpQX73KOgaWvYwpwac3ag63Usk3FJoSn98WOBqows88X5H0p3tK
         5Mw0Iyh0Av6JBe3MROIpF5Hh8Q0X6UmSeNTzYxssXZ/wVLQiXiTeuHnRH17WU5aWpTQ2
         VHYsHzf3zdK0BKqvynDn4oNsCcPFGAaboiIVZbQodhYmdZDwbek0Mkb3bPk7R6JxaVTD
         MoA4O0o0+xyk8V2baxsI0Ez2Fs3R0wQdA4kHxx1pyyxLZLtPafvAj0Oef0p5BRPa66q3
         iZow==
X-Gm-Message-State: AOAM532R9tjgLoS0JU2V74MkXCrvsS/wof5kkBpNUcLYNNVfQHFqhtG+
        OIip++CCFZXaLFHDXvqQjX/m7WjGCacLiRGUCQ4=
X-Google-Smtp-Source: ABdhPJwhVqoBYNIct/wNc+DRDIxz7kt6HXUIBG5QLvj9XI6ejhHdyqVlLPCg5r726gZEIOfgOTy57M7GuFgYsqydXbk=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr52576774otc.206.1621262196656;
 Mon, 17 May 2021 07:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
 <20210514103912.GA16131@lpieralisi> <YJ53eBRGXtabyT5K@kuha.fi.intel.com>
In-Reply-To: <YJ53eBRGXtabyT5K@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:36:25 +0200
Message-ID: <CAJZ5v0huzEY=hHVrtkGsxy7sR5kPGFAr6=R5_khA=WFLhSMgtg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/IORT: Handle device properties with software node API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 14, 2021 at 3:13 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, May 14, 2021 at 11:39:12AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, May 11, 2021 at 03:55:28PM +0300, Heikki Krogerus wrote:
> > > The older device property API is going to be removed.
> > > Replacing the device_add_properties() call with software
> > > node API equivalent device_create_managed_software_node().
> > >
> > > Fixes: 434b73e61cc6 ("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")
> >
> > Is this really fixing anything ? I am not sure I understand what you
> > would like to achieve with this tag.
>
> Right now it's not possible to simply remove the old API because some
> of the maintainers want to take care of the conversion themselves, but
> at the same time I also do not want to see any new releases of the
> kernel that introduce more users for it. That's why it's a fix.

With the assumption that the above clarification is sufficient,
applied as 5.14 material, thanks!
