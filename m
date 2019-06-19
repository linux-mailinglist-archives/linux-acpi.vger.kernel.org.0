Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1133E4B5D1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfFSKCt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 06:02:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45302 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFSKCt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 06:02:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so18639144otq.12;
        Wed, 19 Jun 2019 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+J6dUZAOVU0wocsI4fIvFAeyHih7IFO3MdBbh8opiY=;
        b=fyB4gXqMM7iV4meiZBAerEOMFrNp/CQMTyLnorcFf/zxxGP3XkClyQc0406z0jOexV
         IXUjpw6V8Sa6NuQ8gVOlJo22jfkOXClZhJ/1Nhnk/WlcMSUv0UN4+xsGiL83xZL2djTH
         SQd33fLxuMCA6DSrZhGDoQR2ZlHrrZ/PfnsRt6j8p9L14rNV3TWAdyrDkMhu2yPXhm+1
         g6+R9HrSjc6dNnohR9LsX4+kIDoRvSE4ztc7ReSS5SjRZh+JKlGxI0WfW4Liy7X0Iwsg
         /O72Mj168o1aB6O/xTDOogPMQLAsnio01O6bS2LX5GrdfgQnmxy0gz9dbnD4PgXOEqy1
         xfMg==
X-Gm-Message-State: APjAAAVd90uBEu74Yh/PHngmNzqbhUOZXbpwqh3FncihZ7l9uWNEl/ps
        DRBK2tmi4atIwPFrxDbHPnqBJrJ4BJ1ust/4K2oltw==
X-Google-Smtp-Source: APXvYqwP3cl58o+XyB3sUQ1Z2B/Jsq4XNbW2J3uADfhQkmT9LDrq4vJj1m6RCrsLzpwBsXcs1gpzli/I9nCO4waJ2yY=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr44802290oto.118.1560938568448;
 Wed, 19 Jun 2019 03:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
 <b6d199c3e7c8c868acbb313a1a516ea8aed042ee.1560891322.git.mchehab+samsung@kernel.org>
 <4701210.Ilfu9VLqBR@kreacher>
In-Reply-To: <4701210.Ilfu9VLqBR@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 12:02:37 +0200
Message-ID: <CAJZ5v0ht6d23w=bpodn_wtdovb1kjKaVMtUOrAZKZ=SvmGVgWw@mail.gmail.com>
Subject: Re: [PATCH v1 20/22] docs: extcon: move it to acpi dir and convert it
 to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 19, 2019 at 11:59 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, June 18, 2019 11:05:44 PM CEST Mauro Carvalho Chehab wrote:
> > The intel-int3496.txt file is a documentation for an ACPI driver.
> >
> > There's no reason to keep it on a separate directory.
> >
> > So, instead of keeping it on some random location, move it
> > to a sub-directory inside the ACPI documentation dir.
> >
> > For now, keep it with .txt extension, in order to avoid
> > Sphinx build noise. A later patch should change it to .rst
> > and movin it to be together with other acpi docs.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Which said, the changelog appears to be outdated, because the format
of the doc *does* change.

> > ---
> >  .../acpi/extcon-intel-int3496.rst}                 | 14 ++++++++++----
> >  Documentation/firmware-guide/acpi/index.rst        |  1 +
> >  MAINTAINERS                                        |  6 +++---
> >  3 files changed, 14 insertions(+), 7 deletions(-)
> >  rename Documentation/{extcon/intel-int3496.txt => firmware-guide/acpi/extcon-intel-int3496.rst} (66%)
> >
> > diff --git a/Documentation/extcon/intel-int3496.txt b/Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
