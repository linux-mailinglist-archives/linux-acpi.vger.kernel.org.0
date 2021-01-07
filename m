Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7756A2ED12F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbhAGNwJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:52:09 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35286 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAGNwJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:52:09 -0500
Received: by mail-ot1-f50.google.com with SMTP id i6so6326331otr.2;
        Thu, 07 Jan 2021 05:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMWuGz3d4Qig577O3FdlCU+qyCG2EaepFu5Glz45Sg4=;
        b=XBaSAzT4Tc8j0MickH0r/N1zNOSlDVm8C/qJZG7Ki1bzANZY3XVaiXOPkskkL1BIgs
         JVCrwr9zuwyxn542lUKGCT4qq8by3qiP5CocqxYJFqvPkoeFbdinAhylClxbFPX24k7e
         TC9IY3yboCd1SLTHuJq07CRbYRT47hN7OGnzMNRuJ+hzZra5Dzkx5Esg4Z6CG5q7UYCI
         3HxdHEy7E48CGLIoj14/2PAIcweOPISVXuYeucj3LMwgCZ6QAefGJMS499z1iuw8sC0M
         EgGLA0MtNuAOOZI9xv5UE9lERWu+KnY5b5W53XRIpQ22C0mOj6kitC+/LwnOaJrK8jFE
         Tmjg==
X-Gm-Message-State: AOAM531ctlVhCQA8U9M/AAGiBkMcdlocBkVyzE9e0Nget46UrP8hssD1
        m0fWA3RSjdyhJRS1dduYNdQakeJjIZehn8xpgEk=
X-Google-Smtp-Source: ABdhPJw7thMotG+kLxNi6hR91Eh41PYqaTrzXs93IWXGnkZxQEZY9mKCQCaBD2A8QaIWhZE2tUGwEPq0qy+dEL/k0dA=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr6708467otn.321.1610027487936;
 Thu, 07 Jan 2021 05:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com> <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
 <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com> <CAJZ5v0je41iXQnr3m-RY9fD_C-qnqbLdqYMvUzp0qgBwEvVoJA@mail.gmail.com>
 <9e745724-d704-6250-9bfb-e347f3611ec4@redhat.com>
In-Reply-To: <9e745724-d704-6250-9bfb-e347f3611ec4@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 14:50:51 +0100
Message-ID: <CAJZ5v0gSCpZ6O+o7uXQKyQN+xOWhQSjiRqdqSdkez=ZsgCaOjg@mail.gmail.com>
Subject: Re: [PATCH 0/2] IdeaPad platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 6, 2021 at 10:17 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/5/21 6:18 PM, Rafael J. Wysocki wrote:
> > On Mon, Jan 4, 2021 at 9:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> <snip>
>
> >> Patch 1/2 does use a slightly different approach then I suggest above,
> >> thinking more about this it would be cleaner IMHO to just pass the
> >> cur_profile pointer to the callbacks as the pseudo-code patch which I
> >> wrote above does. Drivers which use globals can then just ignore
> >> the extra argument (and keep the platform_profile_handler struct const)
> >> where as drivers which use dynamic allocation can embed the struct in
> >> their driver's data-struct.
> >
> > Agreed.
>
> Note that Jiaxun has provided a v2 of this patch-set with patch 1/2 implementing
> the new approach.
>
> Can you merge merge that patch please and then once you're happy that this
> has seen enough exposure in -next, provide me with an immutable branch with
> the 3 platform-profile patches in it ?

I will, thanks!
