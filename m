Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B833E704A2F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjEPKMa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 16 May 2023 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjEPKMa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 06:12:30 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75509E6A;
        Tue, 16 May 2023 03:12:28 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so3465666a12.1;
        Tue, 16 May 2023 03:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231947; x=1686823947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F3t+I70HkGPNqWn1Cxy/keylC97OBDE6YM4DG0f+rk=;
        b=PQT8DrH4ZP1HFMPAyg7CmTaqZDt2D2njsJFH46R0oYJvgO30f2iHwehhbsOjTI4hoF
         +Q3VWwYMXPtePDuXavhexUsrwweFL7f5CudmyWUdC7AwW0aYJTx10qj6GJxpOtS00uQY
         8FOBg8IrEIPFlMiuZacacPKksT4w/YPiQhf8qKu3oMIjkFMgfNDKw9dCkPn1Nus+qkjR
         i380l0kOKlu/jU5bCHlfiMDTgjTP0SixjtNBap/Eykil4Q+R8uAPmTmybeo6f0sH5NzM
         iwVGqY4aXRsXtbKClBIzVS/jA9gFoE6R7f8zzhxsYfMrluYXq3WX26MWFrTHAd0JmOl+
         b9ng==
X-Gm-Message-State: AC+VfDz4Hj3jgkTC7jmhMuIZoaW9GnLo3rVPp28u6phZStUjz620xlUC
        7FG6WGHb68NQKbJQdZxZQeWYkIxXb6Kxk8AkMpE=
X-Google-Smtp-Source: ACHHUZ5yjVAJpur1QhPthzZl9+7b01OXZNKtWF/FtkuaM/uZwU381npEbIc/6Tyi0jSlY7DOzaDgHdPk71BSVXpKsTs=
X-Received: by 2002:a17:906:73dc:b0:94f:4ec3:f0f5 with SMTP id
 n28-20020a17090673dc00b0094f4ec3f0f5mr8908817ejl.4.1684231946583; Tue, 16 May
 2023 03:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-4-sakari.ailus@linux.intel.com> <1865464.tdWV9SEqCh@kreacher>
 <ZGNFgXM/463ycI6R@kekkonen.localdomain>
In-Reply-To: <ZGNFgXM/463ycI6R@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 May 2023 12:12:13 +0200
Message-ID: <CAJZ5v0jcZsANJr5n7pAM2KR4c_kLkhbDC_docOA8iTVNq_WshA@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On Tue, May 16, 2023 at 10:57 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, May 15, 2023 at 06:45:10PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, March 29, 2023 12:09:44 PM CEST Sakari Ailus wrote:
> > > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > > configuration, associate it with appropriate devices and allocate memory for
> > > software nodes needed to create a DT-like data structure for drivers.
> >
> > It occurred to me, that there would be so many things I would like to change
> > in this patch, so it would be better to create my own version of it, which
> > is appended.
> >
> > It is based on
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/2694293.mvXUDI8C0e@kreacher/
> >
> > that has just been posted.
> >
> > IIUC, the idea is to extract the ACPI handle for each resource source in every
> > _CRS CSI-2 resource descriptor and count how many times each handle appears in
> > a CSI-2 context, either because it is referenced from a _CRS CSI-2 resource
> > descriptor (as a "resource source"), or because its device object has CSI-2
> > resource descriptors in _CRS.
>
> Correct.
>
> >
> > This allows a set of software nodes to be allocated for each of these handles.
> >
> > If I got that totally wrong, please let me know.  Otherwise, I will rework the
> > remaining patches in the series to match this one.
>
> It seems about right. I mostly see renames, moving the code around,
> using the existing dependency list and then parsing sub-tree for _CRS CSI-2
> objects right from the bus scan callback.
>
> It seems you've also moved the structs from internal.h to what is now
> called mipi-disco-imaging.c.

No, I haven't moved anything in this direction, I've just dropped them.

They can be added in the next patches if needed.

> They'll be later needed in e.g. scan.c. At
> least I'd use names that indicate they're related to scanning the bus:
> they're not needed after this is done.
>
> I don't have objections to you reworking the rest, but given the number of
> non-trivial changes, will it work after this? :-)

Probably not right from the start, but after some minor adjustments it
should work, unless I've missed something significant.

> I can also do this, although I would un-do some of the changes in this patch in order to
> prepare for the rest (such as moving the structs from internal.h).
>
> See e.g. "ACPI: scan: Generate software nodes based on MIPI DisCo for
> Imaging", I think it's the 6th patch.

I will.

Thanks!
