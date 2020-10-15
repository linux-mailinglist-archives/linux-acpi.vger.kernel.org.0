Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B428F788
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbgJORPm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 13:15:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40479 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390447AbgJORPm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 13:15:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id m128so3891672oig.7;
        Thu, 15 Oct 2020 10:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrn17b+ntKHq1CA8pT0i8xm7h9nTQC4aTvhOh2R5n9A=;
        b=qJrGjgZPOSKOdEREe/tgkyMw3y/XbGkk/E2HjVdr8f/0YNOdg/ldUgn6f8mJxxiakk
         yrjSnMysBpi5gxQLTTcn/u7V63tFRWOsvYNkzjI4CM8TwH+VgBgKz1pfS/DOk431YFdS
         YklU/QvRL7yJ3dqop0gbrXAU4bwM5zxxQ9GxPOUCx+IO/bZJP1Fo3PFGnyUyHTCCKk+e
         wtexUDdLIS6DbQM4EPEV9zW1jr72DyH678Jc2N2jy+1r1TtkqDlkNqDRhNMAxjXu4MIz
         +KPPJXE3ief92obkUfPK2TYEcVMn5bCViGDeeTrCrImY76P2DRYMYtjIFtg9vIAyNWcL
         BgOg==
X-Gm-Message-State: AOAM532QEU4otNXto8xTIFLQsNnm4aqjodd12+JWxnrc/+IGxeR5p9hi
        z7S7fqxNyTfuJvtwMdAtiblwfNDw86YJ5JrVB0I=
X-Google-Smtp-Source: ABdhPJwP1VN0hVmGR9VvMd4jsO2Uxp3lS5dItaBhvW1Gre8RadYL9qa+3YdDWZWBdpO0+PLrofLxqMEowmRXzVQY+9k=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2828767oii.69.1602782141621;
 Thu, 15 Oct 2020 10:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
 <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
In-Reply-To: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 19:15:30 +0200
Message-ID: <CAJZ5v0ir9KV2cMwRb9Q0oTE0HAeQz0aXssj9Ejex2je4_Y2ZCA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 14, 2020 at 8:52 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Oct 13, 2020 at 10:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > ACPI updates for 5.10-rc1.
>
> So these clashed with Andrew's patches that I merged earlier
> (particularly commit c01044cc8191: "ACPI: HMAT: refactor
> hmat_register_target_device to hmem_register_device").
>
> I think I sorted it out right, but it might be best to double-check my
> end result.

That looks good to me, thank you!
