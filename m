Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5387236B2A8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDZMB6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 08:01:58 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37618 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDZMB5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 08:01:57 -0400
Received: by mail-ot1-f42.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso37753726otm.4;
        Mon, 26 Apr 2021 05:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxIyZImAjQiKb779pF2r0agNe8VB6ArmqFWX32Kk7RQ=;
        b=g9Lu9eXecQp41pTWulDd0EQ2If0lWJqXtqTQudGJU8JblIZNbRWo7Wp/G8F8uG/qkK
         rtF0087Iix+BCCyjueTCpJHihmwS2gLQK9LqfI6VIymfNuGFKxpAjxoiXzbaeWuKuMtn
         H82yDjzcfvyHUpCL4FgYaNbTvGMS1qFvDkJa1Ds5iQLaKi/gUwrPZkjJ+S/0Kgl7fcml
         knXHgmRGX9Ga0aKfMdcOFxihqg+lNhiTYUdt0iT0hmqISj8w2jK0r2Dlsy0rhB+n9C3m
         FVtEsAa0/WpGvjdlOYwwNMQ2zVbuvLApQQWgy9OiCnSfrGNjjm47o0KPNtbVqXCGAM13
         g0uA==
X-Gm-Message-State: AOAM532vpY0mMbUWGmKPlIldQ1hR/vIuzRIqB3/9T134UmxGqynq2H33
        SJwgCzGUwXj8O2zg+yb/mT7F/Sl+g/4rKBHq/8g=
X-Google-Smtp-Source: ABdhPJydX+PqSQ6N7W5WWSg0dAngJ4Psu2SduGfyCPpLs36pyCJue6ExqSiASIYQpVrKVzUuDwEF7jEN91qwbA+wOXo=
X-Received: by 2002:a05:6830:2458:: with SMTP id x24mr3478004otr.206.1619438473197;
 Mon, 26 Apr 2021 05:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu> <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
 <YIZIHR0ZQPXFkOH1@unreal>
In-Reply-To: <YIZIHR0ZQPXFkOH1@unreal>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 14:00:58 +0200
Message-ID: <CAJZ5v0gRv-1qYiN8EXx12iOiJvX7ORzqQfHvtWDnZLtpg6Aijg@mail.gmail.com>
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam <developer@arusty.dev>, bkkarthik@pesu.pes.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2021 at 6:57 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Apr 23, 2021 at 03:08:03PM -0600, Shuah Khan wrote:
> > On 4/22/21 12:03 PM, Anupama K Patil wrote:
> > > de, e are two variables of the type 'struct proc_dir_entry'
> > > which can be removed to save memory. This also fixes a coding style
> > > issue reported by checkpatch where we are suggested to make assignment
> > > outside the if statement.
> > >
> >
> > Sounds like a reasonable change.
>
> It is unclear how much changes to ISA code are welcomed.

Real fixes and obvious cleanups are, not much more than that.

> According to the Wikipedia, even Windows Vista disabled ISA PnP by default.
> https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications

It is indeed unclear how many systems with this interface still run
Linux, but as long as the code is in the tree, there's nothing wrong
with attempting to improve it.  There's no assurance that all such
patches will be applied, though.

Thanks!
