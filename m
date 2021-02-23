Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3B322CAF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Feb 2021 15:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBWOqj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 09:46:39 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:37962 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhBWOqi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2021 09:46:38 -0500
Received: by mail-oo1-f44.google.com with SMTP id f26so3895687oog.5;
        Tue, 23 Feb 2021 06:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wlqU5gFpV97zZnVyyRZleFZ9BWrIgZ2Rdcv8uzTHfM=;
        b=izqpbqAQoHWERsUlLgCvQl2ltizRssvGosn5JHs3fxCkK7IDsw9/DMyw0d0l+lmpMU
         ZTDZ6k/4WOfqEH9v6uCGixbuQy9Kc61HGZhiUwERnOUFLILzHpf616PVOG09qjL3rIbL
         qSPyRZ5y+oADul1PhQL7kcBz5EzrociapohB0wT9NrJscoPHa5qxhbw2evkyWbUK1Exb
         qBr/bYm+gB+T7pYo2LC1Kq0gzow67HGKmHkxKJG3elg15m+IHGqfnlxXepXnTQdJj2In
         xvd662pRlgmJ9slqqptGRrsNTIFVfB5QcezsoVZJno7yKDmz5wVArlh+f7DnihoZv3AX
         MQpA==
X-Gm-Message-State: AOAM532w6MDpFTGdxvMCy1KWQV6bSuoGd79OvuJEGPnsryCv1rKFphzE
        znuReNSTbRdoHEY6Ut0khKiR//LQaPjg0NVx79GSBqCW
X-Google-Smtp-Source: ABdhPJwfbF7b/OCPMJaoTlBR5XDAWd6jhh1U74IHQx1E+yIxafmNB1Y0yypJR+U1IIrawU8zOKzF7Veu7yaSNnskD5E=
X-Received: by 2002:a4a:3bcb:: with SMTP id s194mr20310533oos.1.1614091557912;
 Tue, 23 Feb 2021 06:45:57 -0800 (PST)
MIME-Version: 1.0
References: <5138173.kHyPcihzTF@kreacher> <10245832.OiMb8u2cOm@kreacher> <0faea0bd-107b-5c4c-5324-e0cd5e5cfba4@huawei.com>
In-Reply-To: <0faea0bd-107b-5c4c-5324-e0cd5e5cfba4@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Feb 2021 15:45:46 +0100
Message-ID: <CAJZ5v0i01rX0b-=dDJEdGsK2=6D3tXbC_wdOByTF_mJ0ggTPJQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Get rid of ACPICA message printing
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 23, 2021 at 12:31 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2021/2/23 2:59, Rafael J. Wysocki wrote:
> > Index: linux-pm/drivers/acpi/processor_idle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/processor_idle.c
> > +++ linux-pm/drivers/acpi/processor_idle.c
>
> In this file, function acpi_processor_cstate_first_run_checks()
> has a wrong pr_notice():
>
> pr_notice("ACPI: processor limited to max C-state %d\n",
>                 max_cstate);
>
> Since we have pr_fmt() for this file, "ACPI:" is duplicate,
> we'd better cleanup this as below:
>
> pr_notice("processor limited to max C-state %d\n", max_cstate);

Thanks for pointing this out, I'll make this change when applying the patch.
