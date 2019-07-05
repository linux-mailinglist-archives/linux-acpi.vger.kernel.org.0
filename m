Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D389160880
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfGEO4e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 10:56:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46086 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfGEO4d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 10:56:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so6491510lfh.13;
        Fri, 05 Jul 2019 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpw4LgWQl3djVQ004uCiznSAE3f2lS3lt+2VhGBgUdM=;
        b=K2RTEoHWrkysJOEr8bRg39piVLUBiEwgZmyaDLiNcAoFoS7hFr1DUiw7+TjeoWI13M
         SWzay62c5nkIPTR7tjhpRtDbmikzkcjcPmFr139zY4uI8p/Car0kUx6daJ1Ut/ES9se3
         yjmqUum/Z4D7Xj8O+prZzkJj11uR/xO3Vu66JfTP4+CG4D1LXEKM5UcpnoYhoVFb4zcS
         uZNYC+HY9Eyp4NdE43/yULha9sMWLx0oLNrm89Riy95vlN485/OG1S9wy4DEpQnhujrO
         v3VKJ1KueIvt+3md+es1oqTif2TzVR6DRYr2P1eju3HdBVgNy1VN7GXy1htNi8iS9+Cz
         s22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpw4LgWQl3djVQ004uCiznSAE3f2lS3lt+2VhGBgUdM=;
        b=ovM9liesw69qoiJnIOvBv01vC203gMpnebCSqGex7IMOVq1FJXvgEeqXf5h8Xy1mAH
         WWBDUJFL4UvyX5cqDvUlAXl7PX9mjP8gi6/lw8xfylJC1kV3Zb4rDv+/nxEz3Vi3qPTi
         z6mezmo7Q2DSXz4f0K+uIFvW6H/ZMnp6g+b5v2lPCHKdJG00dbGNbS6toQ2qbpzuDAPg
         FUODyqF7kdDyxaSN2pfa3Lf9MU/Iga1henqGdpISv6RYWSpTAAVtEVLFw2jrpDUfW/KL
         aPTt3as/sAw6e1sL0xRp/FqueOrhTJUWycdstMMvhiemuXKohFBj66wzw8/qa9/KyMlX
         RviQ==
X-Gm-Message-State: APjAAAVURBODjI3TBcZFRXTj8Cvl3mP5MyVtevgiqTQKpz3LBmbxWf/C
        hn7mRzrngEKoR29zMqbKZMEKi7dmbb09AmU1qE0=
X-Google-Smtp-Source: APXvYqyNSqy5Xj1GQHiytKh7BGJ72lnNUhK9BSvrm53RpANaw+wUHPvfD4Lq7KetpxgyRB9gb5T59LFa+sfv/cehRko=
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr2213498lfl.1.1562338591550;
 Fri, 05 Jul 2019 07:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com> <20190705103314.GS2640@lahna.fi.intel.com>
In-Reply-To: <20190705103314.GS2640@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 5 Jul 2019 17:56:15 +0300
Message-ID: <CA+CmpXsfSQ3hVW4cAM2ixOm4C8yVLOzxXMM2ow1GVwkQpgAbWw@mail.gmail.com>
Subject: Re: [PATCH 0/8] thunderbolt: Intel Ice Lake support
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 5, 2019 at 1:33 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, Jul 05, 2019 at 12:57:52PM +0300, Mika Westerberg wrote:
> > Hi all,
> >
> > With the exception of the first patch which is fix, this series enables
> > Thunderbolt on Intel Ice Lake. Biggest difference from the previous
> > controllers is that the Thunderbolt controller is now integrated as part of
> > the SoC. The firmware messages pretty much follow Titan Ridge but there are
> > some differences as well (such as the new RTD3 veto notification). Also Ice
> > Lake does not implement security levels so DMA protection is handled by IOMMU.
> >
> > This is v5.4 material but I'm sending it out now because I will be on
> > vacation next 4 weeks mostly without internet access. When I get back I'll
> > gather all the comments and update the series accordingly.
> >
> > Thanks!
> >
> > Mika Westerberg (8):
> >   thunderbolt: Correct path indices for PCIe tunnel
> >   thunderbolt: Move NVM upgrade support flag to struct icm
> >   thunderbolt: Use 32-bit writes when writing ring producer/consumer
> >   thunderbolt: Do not fail adding switch if some port is not implemented
> >   thunderbolt: Hide switch attributes that are not set
> >   thunderbolt: Expose active parts of NVM even if upgrade is not supported
> >   thunderbolt: Add support for Intel Ice Lake
> >   ACPI / property: Add two new Thunderbolt property GUIDs to the list
>
> Forgot to Cc Raanan and Raj, now added. Sorry about that. The patch
> series can also be viewed here:
>
>   https://lore.kernel.org/lkml/20190705095800.43534-1-mika.westerberg@linux.intel.com/T/#m9cb5a393dfc79f1c2212d0787b6bad5b689db6bd

Besides a few comments, LGTM.

For Thunderbolt patches,
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
