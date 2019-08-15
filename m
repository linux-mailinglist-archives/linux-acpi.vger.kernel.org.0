Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAB8EDCA
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfHOOLN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:11:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43282 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731849AbfHOOLN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Aug 2019 10:11:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id y8so2089102oih.10
        for <linux-acpi@vger.kernel.org>; Thu, 15 Aug 2019 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoGosoNZCrkvvmYn2s5nj1f5F7hDnA1u4nMizuQrZrY=;
        b=ZXn1m1FH5gKNEJpDzbYEQ/TeOQBFIvpbkI0YuusZkSaNu++nHT1eLRd2C0K7SmEAgt
         jcz2rhXJ7QOxzzGjCvG5GHfReRUVq1aSjj24gtd7eoYRZGB5E3+Qbmxj6k0AyKDjw0TD
         z1yiA/d8MOlh5J7FDAOEg7RTXNhViOukHDi9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoGosoNZCrkvvmYn2s5nj1f5F7hDnA1u4nMizuQrZrY=;
        b=NBQztJndmrOHlRFHGSdHG8FE+YmbCLB5jgmFbNrCH3BnmrQhTGqrptd7sH26rmbE2V
         2AcE9s6790MRQQPuI/gMnMxnUPUhQPDfSGrnHhLz5Hd7s8cM06yflE1K6RURA4VM3AAq
         AcdNdKus5xa48enrs75wQ1VRZru7sKDwHMzwiuGK9lrXeXhkfiJ1DgVyLneP/FFPyQn5
         y4SItjoQj1K0GUEgzE0YMkxUujBT1WMXz+ThWrKMzjnFjammDWiU/EVytDMOEgqP8w+f
         +Ae8CGO+rVqmAzIN85IyI8dNpxHs88igLWinkhhTjzCM4B8OwiO2je/om/nDyU6Vz3kU
         0bCw==
X-Gm-Message-State: APjAAAUxt3xfOf4dv1tB7oKFJ5iFWOH21xsCw37ozemAWHTfzKKqpwuM
        Ih1nkD2VgHQ4VV3TPnvNYV1Um+JjC1YfHHYJXH0IsthlP/4=
X-Google-Smtp-Source: APXvYqxHHuZUJHutmpU1PxQt0uV2+Ykat106aSv9mv+sZohSCF2iaIS7JJIHSD9E9jn0yYbTdunJelrlspa8xiz2IJo=
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr1746505oia.128.1565878272617;
 Thu, 15 Aug 2019 07:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
In-Reply-To: <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 15 Aug 2019 16:11:00 +0200
Message-ID: <CAKMK7uG1cugQvYLpEivDGg7+D0tUp5B9Jo7hWQCsmbXe3TC3nQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Dave Airlie <airlied@gmail.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2019 at 12:47 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> >
> > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> >
> > The original commit message didn't even make sense. AMD _does_ support it and
> > it works with Nouveau as well.
> >
> > Also what was the issue being solved here? No references to any bugs and not
> > even explaining any issue at all isn't the way we do things.
> >
> > And even if it means a muxed design, then the fix is to make it work inside the
> > driver, not adding some hacky workaround through ACPI tricks.
> >
> > And what out of tree drivers do or do not support we don't care one bit anyway.
> >
>
> I think the reverts should be merged via Rafael's tree as the original
> patches went in via there, and we should get them in asap.

+1

> Acked-by: Dave Airlie <airlied@redhat.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also fully agreeing with Karol's reply further down, if this doesn't
work we need to improve the drivers, not pile stuff on top in some
ACPI hacks.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
