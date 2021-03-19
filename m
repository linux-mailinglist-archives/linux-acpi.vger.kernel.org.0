Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E2342263
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSQrg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 12:47:36 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37705 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhCSQrO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 12:47:14 -0400
Received: by mail-oi1-f180.google.com with SMTP id k25so5403586oic.4;
        Fri, 19 Mar 2021 09:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTy0N2kLwo2MaKdr3l1+uHW8aX1Zzc9k5ZgJRCx9u0Q=;
        b=gNbEQDOzG3lWzeuqQCkdNadccH7DjM5xY0BlI4Of12tCT5h0uezxHQyc5t4/ZCAqC0
         251eTq3DSuIZ4Sg+pPpAX8ubK4hhqENlbAKk4b1yExqxR09taFlN9opH7pd1luHBYb3b
         RmqAMQrtPrhjPQXm67KQtV9cIS0yO98Y2/bXquwmuaXr1PDXHwNiJRZ8HvPBT5kjdVx4
         XWg1VNT3p2ToP37i7N15Y+mBQMab+GmrDOibJsYZcpVPR32QWvzbamL161t1wAsMvERY
         f6S/pMbFdvM7iWXf6BrnWectUUH2bqdQjoqVr8thBHTCVRMkKr6RHIZ8bGOEA3ajS2f5
         Auvw==
X-Gm-Message-State: AOAM531UFOe3eFSAxQlUoa3ryRHoPnWAd17xGnzxXiHNppmPsIvhEw6r
        zvITtgKDGCCDPGI0KUuCRkdKXCtFTwuuuWhne6egOCqG
X-Google-Smtp-Source: ABdhPJy1nDN4HbkYx5oYroiZA78zNXDiCIm0IGc0AcrKupHS59jnNwDMxpZtXRH9ZD4dJtQpmUUIfACFzvyCF47VJVI=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr1656701oie.157.1616172434177;
 Fri, 19 Mar 2021 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <fa193b3c9e346ff3fc157b54802c29b25f79c402.1615597995.git.tom.saeger@oracle.com>
 <5320781b-6328-0dc0-3a2b-02955e688b18@infradead.org>
In-Reply-To: <5320781b-6328-0dc0-3a2b-02955e688b18@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 17:47:03 +0100
Message-ID: <CAJZ5v0hDr1+wGGJ3xwvH91wjpKLFpBf-N26K12uv4gJaw_L9SA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fix various typos in comments
To:     Randy Dunlap <rdunlap@infradead.org>,
        Tom Saeger <tom.saeger@oracle.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Mar 13, 2021 at 4:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/12/21 5:55 PM, Tom Saeger wrote:
> > Fix trivial ACPI driver comment typos.
> >
> > s/notifcations/notifications/
> > s/Ajust/Adjust/
> > s/preform/perform/
> > s/atrributes/attributes/
> > s/Souce/Source/
> > s/Evalutes/Evaluates/
> > s/Evalutes/Evaluates/
> > s/specifiy/specify/
> > s/promixity/proximity/
> > s/presuambly/presumably/
> > s/Evalute/Evaluate/
> > s/specificed/specified/
> > s/rountine/routine/
> > s/previosuly/previously/
> >
> > Change comment referencing pcc_send_cmd to send_pcc_cmd.
> >
> > Cc: trivial@kernel.org
> > Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> > ---
> >  drivers/acpi/ac.c                     |  2 +-
> >  drivers/acpi/acpi_video.c             |  4 ++--
> >  drivers/acpi/apei/erst.c              |  2 +-
> >  drivers/acpi/apei/hest.c              |  2 +-
> >  drivers/acpi/cppc_acpi.c              | 10 +++++-----
> >  drivers/acpi/numa/hmat.c              |  2 +-
> >  drivers/acpi/pmic/intel_pmic_chtcrc.c |  2 +-
> >  drivers/acpi/power.c                  |  2 +-
> >  drivers/acpi/processor_perflib.c      |  2 +-
> >  drivers/acpi/resource.c               |  2 +-
> >  drivers/acpi/scan.c                   |  2 +-
> >  11 files changed, 16 insertions(+), 16 deletions(-)
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 5.13 material, thanks!
