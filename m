Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A4340430
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCRLHb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 07:07:31 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:33319 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCRLH2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 07:07:28 -0400
Received: by mail-ot1-f43.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so4814439ota.0;
        Thu, 18 Mar 2021 04:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TinDs4EVQQqlZ2LTjeSZTwhvPWfcUIiPPlSq9X257dw=;
        b=tfmFrxXJy4TLmrn7HhjWFIFDumXictJZiezr7nyZRSvknfo3R+85nG7fk2sU+nucLt
         JDtUcqnbhxUPtjGseQKBzAShWHau9kTvJtn/vwpB66gL11G+x8512ngz0cb35ztC8i1S
         NpB9qCOrCBf9K/DfD3NpbgOYIp/rNZFOnnBg7phvdS4eIbux4dplEPgHar9rC6dz9e3d
         ujlYk6hPk2O+ZQVUYSKBwW+D0Mseggi5HNjRPYcnvLRgY1tbJaF+YBem1iacyUdRPSpC
         wWh48XrhT1dxr1qGawFQDEwx7d6G3cIAlpGQMluKiEkrwOGPN0IHTQgG2hfbwWgVBJrw
         WB1g==
X-Gm-Message-State: AOAM530NDVTE4JLPQQ9HloskI4UAuNdi5x0jP52PcYaKlz7Mar6h+6S+
        OoAuiCm8IsnBffRyvlw/mwBNtBggfXKHqJ4XQ6o=
X-Google-Smtp-Source: ABdhPJyRFfzU8LNxXDIE+4/TGFcKz89L9zU3zWmRmqa1qdIli/E9TD8Hr3RUJtRnXAYxbyFfxA8BrVt7LeHkuy/F/U8=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr4799994otf.206.1616065648247;
 Thu, 18 Mar 2021 04:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <2527835.vZkJICojNU@kreacher> <8b35de7b-072f-128c-6a3f-c7da5a1b91b8@molgen.mpg.de>
In-Reply-To: <8b35de7b-072f-128c-6a3f-c7da5a1b91b8@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 12:07:16 +0100
Message-ID: <CAJZ5v0iDofnMTO8-GkBMGeQJkr1hSKU_uihKR87xTT1zJ2J_MQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Turn off unused power resources during initialization
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 17, 2021 at 10:27 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Rafael,
>
>
> Am 17.03.21 um 17:49 schrieb Rafael J. Wysocki:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that on certain platforms unused ACPI power resources
> > that have not been explicitly turned off prevent the platform from
> > reaching the lowest power state in suspend-to-idle which leads to
> > excessive power draw.
> >
> > For this reason, turn all of the unused ACPI power resources off
> > at the end of the initial namespace scan for devices in analogy with
> > resume from suspend-to-RAM.
> >
> > Reported-by: David Box <david.e.box@linux.intel.com>
>
> Thank you for the patch. Could you please add more details to the commit
> message, saying what device this was on, and if there were some
> error/warning messages pointing to the problem?

The actual report is not public, so I cannot quote it.

In essence, there is a power resource in the affected system that
would be dedicated to a specific device, but that device is not
present in that variant of the platform.

However, the behavior introduced by this patch is generally mandated
by the spec and evidently depended on by firmware developers (see the
second paragraph in
https://uefi.org/specs/ACPI/6.4/07_Power_and_Performance_Mgmt/device-power-management-objects.html).
