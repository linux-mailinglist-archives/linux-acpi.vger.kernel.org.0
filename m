Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC96248B2D2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiAKRFy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 12:05:54 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:36646 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiAKRFy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2022 12:05:54 -0500
Received: by mail-qk1-f175.google.com with SMTP id h16so4794694qkp.3
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 09:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXxoyCJTaS1oI03+iFr3/xEXvvz8ocLTsQNKlE8UaZI=;
        b=ixOpZeAIbrGAQRsosVD29tETXp1mGIzzodKNgC6WOIEubd63gJkkW0hN9MnMfyDqBZ
         tGVQy6bvs/qNfZm+RbEKZ3nDNgPhyidp8o2DfijAlCYIjmIPuw9QfIflt7/4N0nQt4jM
         7lRNEMywr67gBMHIIPRmDWeIouEg7HPXAToYWWxaWQft+/9Nh5nkz/x/5YVuHPEfpsd/
         cGQXwzRVqmUYlLW29SNhmiRpzhT7OPaeHkK4WZFBo7jRf6pPzTYRyyAjqB43ID/JvWZV
         ToFaJzWvVV8CsGS541oneVotI76XUPh5mdu4IdBdF4o3+xqFru3EOLOsuUD3u201+izf
         +/Cg==
X-Gm-Message-State: AOAM530mfKYbiqcHZq1Y2Ogxnh88Vke6VAt0NG40DH08e+ikrZq8PiI9
        6U26Tn3BiJwLk5uMhUL0C7Zx1NZsC+V9WS2TKQGnEFT5DKE=
X-Google-Smtp-Source: ABdhPJwq1xGDmHg5RGl7aDWHdmhGcwyDdQfcL7oA6samnIvv7KCEKCXk6aLKozBt4/GxcJDAg70rwrQCWFlAvlqyzY8=
X-Received: by 2002:a05:620a:2001:: with SMTP id c1mr3833837qka.374.1641920753750;
 Tue, 11 Jan 2022 09:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com> <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
In-Reply-To: <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jan 2022 18:05:42 +0100
Message-ID: <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        bjoern.daase@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 11, 2022 at 5:23 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> +Alex
>
> On 1/11/2022 09:52, Rafael J. Wysocki wrote:
> > On Wed, Jan 5, 2022 at 8:39 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Currently the Linux kernel will offer s2idle regardless of whether the FADT
> >> indicates the system should use or on X86 if the LPS0 ACPI device has been
> >> activated.
> >>
> >> On some non-AMD platforms s2idle can be offered even without proper
> >> firmware support.  The power consumption may be higher in these instances
> >> but the system otherwise properly suspends and resumes.
> >
> > Well, the idea is that s2idle should not require FW support at all. >
>
> May I ask - why?  It's an intentional design decision?

Yes, it is.

> > It may not be possible to reach the minimum power level of the
> > platform without FW support, but that should not prevent s2idle from
> > being used.
> >
> >> On AMD platforms however when the FW has been configured not to offer
> >> s2idle some different hardware initialization has occurred such that the
> >> system won't properly resume.
> >
> > That's rather unfortunate.
> >
> > Can you please share some details on what's going on in those cases?
> >
> > Technically, without FW support there should be no difference between
> > the platform state reachable via s2idle and the platform state
> > reachable via runtime idle.
>
> During resume there is a number of page faults that occur and during
> initialization the ring tests fail.  The graphics is unusable at this
> time as a result.
>
> The amdgpu code actually *does* distinguish between the 3 different
> cases of S3, S0ix, and runtime suspend.

But s2idle doesn't guarantee S0ix in any case.

> The function "amdgpu_acpi_is_s0ix_active" causes different codepaths to
> be used during the suspend routine.

Well, as I said, s2idle need not mean S0ix.

> In this particular case that FADT doesn't set the low power idle bit
> and that function returns false meaning the s3 codepath is taken but
> the hardware didn't go through a reset.

If there is a separate S3 code path, taking it when
pm_suspend_target_state == PM_SUSPEND_TO_IDLE is incorrect.

> It *might* also be possible to solve this by mandating an ASIC reset in
> such a case (we didn't try).

I'd rather do a PM-runtime path equivalent if the target sleep state
is PM_SUSPEND_TO_IDLE and there is no FW support for S0ix.

> However it comes back to my first upleveveled question - is this a case
> we really want to support and encourage?  This type of bug and
> combination of codepaths is not a case that is going to be well tested.
> This patch series will align the kernel behavior to only what AMD validates.

But this does not follow the definition of s2idle and its documentation.
