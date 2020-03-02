Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913331757BD
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCBJzo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 2 Mar 2020 04:55:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35900 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBJzn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 04:55:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id t24so2490994oij.3;
        Mon, 02 Mar 2020 01:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HAlb9wvoP40MDw06uLOyqoy8XCZGxiaSUpH+LIJxvNs=;
        b=Ob2Y94o+S16AD3Wck5E0l/u/YMBfhagZc27nYw7JKixy7tC1sirUr1DeMHw47nKxXt
         uEI9TTJoZjNYWfiCjzNVvXYaIJSy801GoyAeXKlviudZeJWUUSR5k4OSlcVjXxcGtJ8x
         XN95MzBnIp17/z73savlcwHdmeVlAO3aDXIR7iatYJvS3K/IeMQ6smg/BjIsEgdSGmts
         481dA5sbyTTVEcJIs5BAzGvIcJMxCFw0Y8tz9LG+6Y/cXAwJm7oohqv/dNC97tG8dW2Y
         RzIu1bH/pUUCjKHL/zTSmphn3bU35ZV/0O44C6pihx8By432/mCyXilHZ4v989lRbnkH
         qusQ==
X-Gm-Message-State: APjAAAUZ/wLGcX9wVEf+o46bJQAR7U40f6P9Pog/LNuAybgAwCiI0QNh
        2rmQ6iE1H9czeIZ4z/uTWk1d1+qaXCXRvq8iGm0=
X-Google-Smtp-Source: APXvYqx7k18dMGDkgSbaxcXKSBdPlMqC2Jd5OzgWMeEKHtndONisZj6Wr8JAWJPAUGZmLk03a/ocOmG5AblrkHQDix8=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr11319755oif.57.1583142943281;
 Mon, 02 Mar 2020 01:55:43 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
In-Reply-To: <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Mar 2020 10:55:31 +0100
Message-ID: <CAJZ5v0iCL70b3b=wwB8dX8yvLjE_w79f6anHyDn2Yv4A1-VEew@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 2, 2020 at 6:54 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> Daniel Drake <drake@endlessm.com> 於 2020年2月28日 週五 下午5:43寫道：
> >
> > On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > The purpose of this series of update of the ACPI EC driver is to make its
> > > initialization more straightforward.
> > >
> > > They fix a couple of issues, clean up some things, remove redundant code etc.
> > >
> > > Please refer to the changelogs of individual patches for details.
> > >
> > > For easier access, the series is available in the git branch at
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >  acpi-ec-work
> > >
> > > on top of 5.6-rc3.
> >
> > Jian-Hong, can you please test this on Asus UX434DA?
> > Check if the screen brightness hotkeys are still working after these changes.
>
> Hi Rafael,
>
> Thanks for your patches, but we found an issue:
> The laptops like ASUS UX434DA's screen brightness hotkeys work before
> this patch series.  However, the hotkeys are failed with the patch
> "ACPI: EC: Unify handling of event handler installation failures".

Thanks for checking!
