Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903C536FBB2
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhD3NrR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Apr 2021 09:47:17 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:39579 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhD3NrR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2021 09:47:17 -0400
Received: by mail-oi1-f177.google.com with SMTP id i81so70030592oif.6;
        Fri, 30 Apr 2021 06:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23Cu9KSqZraf6jKgVljZ07ZKA5SNMbl2WUEnfc+pS6A=;
        b=tjrm2pr4bhFMGa+3L/zVeSw80IQOETz/iJZKArko55nZUSk4+54a17Iir7W9P1Og1U
         oNg23pB9a+sUSe3Zho2PN+eXC8Dkgr5kPeb8GSf+EYs7XwpE9HE3lmB1wing8eMWf7zk
         ZVbv3x4jYkUb6wF5O405GgAqhjAeVj+sWTj9qECGu0I65oGzJP05cb3AhBegHk8pVjV3
         ybTiSTL6zU8hq61Q+jKE9ZDlL6tFcEqdAB6rKB+ZrWNNjRwU2v+I+Jfo2hntyCAiD9wY
         Ar1Q5obzVEAD919WYgTsct4pik7c8QjTH4suygPNxH2bxBfT0k1ZBQNeCoW3rgJc3THz
         iN2A==
X-Gm-Message-State: AOAM530E9nJFBAcmbPXh/HMw/RfMXCe1ZiepqHjcY1m2EspsUZ8KStbR
        CxXRb8JGxI4DWhf02SbEP0zg9F/Es/4ekv16QvcdthJvOuI=
X-Google-Smtp-Source: ABdhPJxKaeMhfWwTS4ks8wXKOx9bwGd2QpZj+kmmGSGhj0c2GiGPvHQVoi3m+agYxyVTDC/qPYzVkh/2Gzv9RG82Gmk=
X-Received: by 2002:a54:4501:: with SMTP id l1mr11398748oil.157.1619790387693;
 Fri, 30 Apr 2021 06:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210430124224.6383-1-wsj20369@163.com> <CAJZ5v0jk+wYtJwqTh-RiwOxE+57BM+T-f=2jAVTjz_ZGHx0ehw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jk+wYtJwqTh-RiwOxE+57BM+T-f=2jAVTjz_ZGHx0ehw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Apr 2021 15:46:16 +0200
Message-ID: <CAJZ5v0geAS7aXRW8UGWd+7nhE5roCb=WOJw7sPQvFiiGJum6Hw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: power: Turn off unused power resources unconditionally"
To:     Shujun Wang <wsj20369@163.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 30, 2021 at 3:31 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Apr 30, 2021 at 2:43 PM Shujun Wang <wsj20369@163.com> wrote:
> >
> > This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.
>
> OK, I'll revert that commit, thanks!

That said I'm assuming that this patch:

https://patchwork.kernel.org/project/linux-pm/patch/3219454.74lMxhSOWB@kreacher/

is present in the kernel that you have tested.
