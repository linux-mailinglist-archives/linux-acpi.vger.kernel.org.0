Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A888E379575
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEJRZ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:25:58 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:42809 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhEJRZz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 13:25:55 -0400
Received: by mail-oo1-f49.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so3623255ooj.9;
        Mon, 10 May 2021 10:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SXuLvWg3KjN+JqmbvmLSLywnYwrjuAJqCkQskXCj0c=;
        b=aR/9/s78mR5UrX+gr0APivX7j3pL1Yg4d20QWgnXxLge7UpwhKXOHBgPpYJUerhbXP
         nsDi8ugvHIHftDAzkztdg+ybgqxH40asdbNPZsQOeyw5uba+kZUJVGEHo625bQrhyF7A
         PseN6L9FxA9ou7G+z9DNDCHiXplUKcmK89LIu81nm2GcxgYze/xwTucB9WyaVy6TX/0k
         VTHpsRCq2NLpW6zLYW7Duny4NqmiYI3OFWLoddfAMOigAWx/IrzdmqzvytNIQBaZNdr+
         fjLuNFNHRGFqC6W2ddz0b0LLrp/OA71gXSrvQ53trwH5PmUD4j37IBji2GxVpJpWydCd
         rO+w==
X-Gm-Message-State: AOAM532P5QhTWjMaPzN74AjsfDuRLiFDP5b7BRShUQ2F98lalIu8d5Md
        scLZz2duDBHkuogX6yRAD0taNliBn5Z8m+lZxNc=
X-Google-Smtp-Source: ABdhPJzwswJbWq9pBS/asjw2XXIwyKlMuYXJI2Y1gk1Yxte0zCZydzcU2dUf5kBLVvZdwuYdtU6sWEV1HxZ0wSIlbUc=
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr6209836oon.2.1620667489272;
 Mon, 10 May 2021 10:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com> <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
 <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com> <20210510172237.GU4032392@tassilo.jf.intel.com>
In-Reply-To: <20210510172237.GU4032392@tassilo.jf.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 19:24:38 +0200
Message-ID: <CAJZ5v0iFsBWwXhqtLbTMicBSFme0HCvg+2xgtMgpkFMupk_Rkw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 7:22 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Mon, May 10, 2021 at 10:10:24AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> >
> >
> > On 5/10/21 9:55 AM, Rafael J. Wysocki wrote:
> > > I'm not sure how my comment regarding the fact that for a given CPU
> > > this function is only usable once has been addressed.
> > >
> > > While it may not be a practical concern in the use case that you are
> > > after (TDX), this is a generic mechanism and it needs to cover other
> > > possible usage scenarios.
> >
> > For the same CPU, if we try to use mailbox again, firmware will not
> > respond to it. So the command will timeout and return error.
>
> Right because the firmware code doesn't run anymore.
>
> The only possibility would be for Linux to put back some code that spins
> and waits again, but that would be quite pointless and wasteful.

The wakeup function can return an error when it is called for the
second time on the same CPU.
