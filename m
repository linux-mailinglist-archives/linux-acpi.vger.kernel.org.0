Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A356195F
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jun 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiF3LkX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jun 2022 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF3LkV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2022 07:40:21 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03ED52383
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2022 04:40:19 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3137316bb69so175802117b3.10
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2022 04:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZAvrxWfoixzkGsGiWemPhiC/8VpEB2M1AwjZHpERrU=;
        b=JfiyhOP8Y/Oqa7n93ZApQdharSNRQZeSPbX3dgH0LaeWEVj5kWvpL4pbuQFeBjbDgw
         FbtTcZQHU1vK5IR0Qu7AE2P8LXhP6TQXviBuXvJsErcGUCRxCLaJum23CpXn2AzRFDaI
         YEKyY1sBQFMALXgFoL+j61MXt0i+6NRjNYDfyX2Q+8t2D815EXPQU7PpoI1LNjBxekKR
         E8OWVyI77ZZkH1V3Pr/mlA1npHSm1LQEm0DnBvfZl8g9YMvJu51c73EqVythzileIKoD
         SZqjZy1IugeLhgfjtK1mZHtxuLH3xIFHl9mVAzbTtW/diVZB7IBneiOj1o1m4htsD8zo
         5YcQ==
X-Gm-Message-State: AJIora9PPYbyyx2Kiof476vvG7Tq0dzqB5JJQFgnihdVcn1wZfFwOQBp
        BJvbvA0IyVOLQ4PrJS9YbPmSK+DqZxP8fBZR784=
X-Google-Smtp-Source: AGRyM1vY+ZyHfn9IDh2AcZMeeHgBsc63tlWSYAPoRSJjel8Cj68pCJsjo2tWMOJT4aGK7idMQCTGAN+Z0v4jpHKRR3w=
X-Received: by 2002:a0d:d811:0:b0:31b:ddc4:c0ac with SMTP id
 a17-20020a0dd811000000b0031bddc4c0acmr10071951ywe.149.1656589218109; Thu, 30
 Jun 2022 04:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
 <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com> <YrRrwqc69MgpA9kl@kroah.com>
 <MN0PR12MB61012088C50712D48968327CE2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
 <MN0PR12MB6101DA54A802A06CDD0618E5E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101DA54A802A06CDD0618E5E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jun 2022 13:40:07 +0200
Message-ID: <CAJZ5v0hsJki1nmpdCe+4tHh2atmPNT_=13ErWD00jiGytDapVg@mail.gmail.com>
Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2022 at 10:12 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Thursday, June 23, 2022 08:34
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
> > > <rjw@rjwysocki.net>; linux-acpi <linux-acpi@vger.kernel.org>;
> > > regressions@lists.linux.dev; Thorsten Leemhuis (regressions address)
> > > <regressions@leemhuis.info>
> > > Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
> > > of the query flag"" is causing regressions
> > >
> > > On Thu, Jun 23, 2022 at 07:24:34AM -0500, Mario Limonciello wrote:
> > > > On 6/23/22 05:06, Hans de Goede wrote:
> > > > > Hi Rafael, Mario,
> > > > >
> > > > > Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the
> > > > > _OSC regardless of the query flag"") is causing the issues fixed
> > > > > by the reverted commit to show up again, see:
> > > > >
> > > > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> > > illa.kernel.org%2Fshow_bug.cgi%3Fid%3D213023&amp;data=05%7C01%7Cm
> > >
> > ario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C3d
> > >
> > d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7CU
> > > nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > > 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=KxmNvCfdm
> > > qvk5gXteXUDXHVTK45yEt%2BUYO4vaBbLXis%3D&amp;reserved=0
> > > > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> > > illa.redhat.com%2Fshow_bug.cgi%3Fid%3D1963717&amp;data=05%7C01%7C
> > >
> > mario.limonciello%40amd.com%7C0040716e869d4021ce3208da551d082d%7C
> > >
> > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915880426388833%7
> > > CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > > BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=pZRqAG3
> > > %2Bg0QevLOGZ8m9PNxcmkmh58soT2dSLg%2B6qWc%3D&amp;reserved=0
> > > > >
> > > > > both of which have comments from the reporters that
> > > > > the error message is back again; and presumably also
> > > > > that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
> > > > > again.
> > > > >
> > > > > Can you please take a look and see if we can come up with
> > > > > something which fixes both the re-surfaced issue, as well
> > > > > as the issue which the revert tries to address ?
> > > > >
> > > >
> > > >
> > > > Is it possible that c42fa24b44751c62c86e98430ef915c0609a2ab8 didn't
> > > backport
> > > > to the stable trees it popped back up again?
> > > >
> > >
> > > It is only in 5.18, no stable releases that I can see.
> >
> > I think that should probably come back to stable along with everything this
> > revert went back to, but before doing that perhaps we can get someone
> > affected to confirm cherry-picking it helps.
>
> Users have reported to the Kernel Bugzilla that just picking that patch didn't
> help.  At it's core it "seems" to me the firmware masks CPPC support in the _OSC
> and previously that was actually ignored.  Since the final SSDT with the PR0._CPC
> is loaded dynamically based on whether CPPC was supported this runtime error
> happens.
>
> As multiple people have been duplicated into that bug let's work through some
> ideas on it there.  To start out I've left a suggestion in there for users to have a
> try with.

Honestly, at this point I'm inclined to revert the commit in question.
