Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F433B1F78
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWRcS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 13:32:18 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42613 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFWRcR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 13:32:17 -0400
Received: by mail-oi1-f176.google.com with SMTP id s23so4140720oiw.9;
        Wed, 23 Jun 2021 10:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uL4OeCof1O3VCffukg7OOAMuEHlzWUS97O2lsZYQKCc=;
        b=aQoElZhxLjifKGq5Jm/BeqSvOWf9O2tAg7/sXmAHRNJyXPn8FYPyE/zKTjasvPKRAT
         NRNZJDSqUU8APOPdKXMxV9dtqULemFvioIvnz1mFfIuqmcl6nk+RrT47Ff+MQUBPqFlA
         BzSwTOQvVkBzF1b4NmS+HY/CwBNI+xtdL5ApOoMjOy/x2hfh/mYwVczBXXvI+yTO+oWs
         v1UXzrUSMaAmZvd3BZwKQKHVXILb7vH0oGCjWy0xFh5YaODZbfZ97Fblk9El923unaPE
         EZNKMcb/LYVJCRfT0uuPuzA73RdVd+S0UFCtZEjJTUNbz7fU9QI+MfPnPyp5yT2VF3U8
         +gxA==
X-Gm-Message-State: AOAM531rqIAI/5fFyONxOCjJL9J7jaedyM1F+sjhyG2DSkY+BeUzNwT7
        B/12bHPo7qh9KBs4pV6Q/kp9qUJ3sScul1ChoHc=
X-Google-Smtp-Source: ABdhPJwbiPQqGwFIcUNl4l/6kdARitMtkOA4F4mgoR15canAR9+PiTPwezeXr3x2W9V51042VY1iiwSM2JzlU5bDpKU=
X-Received: by 2002:aca:f0d5:: with SMTP id o204mr754770oih.71.1624469372192;
 Wed, 23 Jun 2021 10:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210623013802.1904951-1-nathan@kernel.org> <20210623013802.1904951-2-nathan@kernel.org>
 <202106222250.7BD80A12FF@keescook> <a155e3ee-69aa-408d-208b-06144cf6cf8f@kernel.org>
 <202106230932.96179173E@keescook>
In-Reply-To: <202106230932.96179173E@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jun 2021 19:29:21 +0200
Message-ID: <CAJZ5v0hgk1_uofRKwQvOPgBqsMsBombAS5SpSo_FoeAXcBArWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: bgrt: Use sysfs_emit
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 23, 2021 at 6:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 23, 2021 at 09:28:55AM -0700, Nathan Chancellor wrote:
> > On 6/22/2021 10:51 PM, Kees Cook wrote:
> > > On Tue, Jun 22, 2021 at 06:38:02PM -0700, Nathan Chancellor wrote:
> > > > sysfs_emit is preferred to snprintf for emitting values after
> > > > commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
> > > > sysfs output").
> > > >
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > Perhaps just squash this into patch 1? Looks good otherwise!
> > >
> >
> > I thought about it but sysfs_emit is a relatively new API and the previous
> > change may want to be backported but I do not have a strong opinion so I can
> > squash it if Rafael or Len feel strongly :)
>
> Fair enough. :) I figured since CFI is even newer than sysfs_emit(), it
> didn't make sense to backport. Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied along with the [1/2] as 5.14 material, thanks!
