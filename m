Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4513332806A
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhCAOMh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 09:12:37 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46003 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhCAOMU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 09:12:20 -0500
Received: by mail-oi1-f173.google.com with SMTP id m25so5118738oie.12;
        Mon, 01 Mar 2021 06:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lod01F2gi753lgz6hSX8V0Vv54kwq8xzww6I7WJ5rRk=;
        b=Crx+BjlP7h+OqWHlOzoQhHiogf6bRv72mq8RTpf62LeGUuWCRL0AwaYrnAxOK3Thgs
         KmXl9/L+bFOCytpabuW9wHZmhiozNFBMtuye3mo6aISN2EwsvzgP0zWo0ySbI/r+038a
         32hv0aym2HxXtCwnVKWjbsrtaS71maEz3Vi3Cry5feBrPn59eyaaQAPcXmY/4w0uOw9E
         Sb+NVj5V4l9Eiwd0G6A7bP97gGmEC+6bZwF4v/e/KuTE/gPMo4N/PSpuXioh/FRxpN0n
         dxDz9qzAfu/50w+pwWAoltH6+KEbYY1gwoJl/y3qJAtSc5+YXsxoGTCbuexqLgyYzil6
         ZljA==
X-Gm-Message-State: AOAM5306fY6BtoUNoVisxuzmc0T60Wnkkk16r02GavEiXmp9vWAa7MWc
        ixkNk9agz8M+1DRqBOGODUGOMIzdSecl/i2B/knF3TBN
X-Google-Smtp-Source: ABdhPJznWYEz0nSJMAIKsm/EiLQc07fLscL4z3c1Nc5/ixWrTp2TGuNmjEBDbNVT+qpzuvGPQkXfa3Wu2bCv3qYBF9w=
X-Received: by 2002:aca:5dc4:: with SMTP id r187mr11284327oib.69.1614607898492;
 Mon, 01 Mar 2021 06:11:38 -0800 (PST)
MIME-Version: 1.0
References: <1709720.Zl72FGBfpD@kreacher> <eaeba4a0-7bb9-7b17-9ba6-49921f6e834c@oracle.com>
In-Reply-To: <eaeba4a0-7bb9-7b17-9ba6-49921f6e834c@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Mar 2021 15:11:21 +0100
Message-ID: <CAJZ5v0jr5Mxs9NYBz1ot8O+6dKYbfAo=cJqSVAOnrFEqUNwuTA@mail.gmail.com>
Subject: Re: [PATCH v1] xen: ACPI: Get rid of ACPICA message printing
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        Konrad Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 28, 2021 at 2:49 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
>
> On 2/24/21 1:47 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI_DEBUG_PRINT() macro is used in a few places in
> > xen-acpi-cpuhotplug.c and xen-acpi-memhotplug.c for printing debug
> > messages, but that is questionable, because that macro belongs to
> > ACPICA and it should not be used elsewhere.  In addition,
> > ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
> > print the message and the _COMPONENT symbol generally needed for
> > that is not defined in any of the files in question.
> >
> > For this reason, replace all of the ACPI_DEBUG_PRINT() instances in
> > the Xen code with acpi_handle_debug() (with the additional benefit
> > that the source object can be identified more easily after this
> > change) and drop the ACPI_MODULE_NAME() definitions that are only
> > used by the ACPICA message printing macros from that code.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/xen/xen-acpi-cpuhotplug.c |   12 +++++-------
> >  drivers/xen/xen-acpi-memhotplug.c |   16 +++++++---------
>
>
> As I was building with this patch I (re-)discovered that since 2013 it depends on BROKEN (commit 76fc253723add). Despite commit message there saying that it's a temporary patch it seems to me by now that it's more than that.
>
>
> And clearly noone tried to build these files since at least 2015 because memhotplug file doesn't compile due to commit cfafae940381207.
>
>
> While this is easily fixable the question is whether we want to keep these files. Obviously noone cares about this functionality.

Well, I would be for dropping them.

Do you want me to send a patch to do that?
