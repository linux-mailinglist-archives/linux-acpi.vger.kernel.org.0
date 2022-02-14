Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518174B5B25
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Feb 2022 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiBNUon (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Feb 2022 15:44:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiBNUom (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Feb 2022 15:44:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B123E5DF
        for <linux-acpi@vger.kernel.org>; Mon, 14 Feb 2022 12:41:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s10so15252207wrb.1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Feb 2022 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjcuYbRwWWmuJzFbZA9czi246l9iMfB3hN39OZCcURQ=;
        b=MHuq6dC0WgFLoTBZwDrEvzDTLrMlt8pOAw0JJp+I9HVXJVVwP3aors1ejF47S75KPZ
         VrIaoEC+CJ6m0CU9UJmzq32DqQpd4Ow9tDDnSVzunlA+v8hWBqprofAriEWRiEERU4z0
         CrtxmvBttjGJUoICZJZn6M4IzIKKil/pFXDBxiGoT8/0NHTT10407mrSg33Wkocd16Xx
         nZCfqlHRa3cdR4evQ7dKLxI0ptrfpxqz+aVT2Gg/yk0GdsBfYvvL6TIM/0/RSkUH0/m3
         SqiGAEdkU81mm7r+Ou6EtZ3LjOSocWYnEuJ9QhVHTKX96VbD/QqWJhtt1yD3gj3OCUJx
         fP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjcuYbRwWWmuJzFbZA9czi246l9iMfB3hN39OZCcURQ=;
        b=KUyYZGmgrKbxr9K2/ls9sdw4o4YZPpp7I5B8z/NUTZ5A/xR66LonllS+VWyeq2CMJv
         2CrmbUE4CxuF30mBaObr1ecM5Fc/+QPXiuYAfY7mNJzMGyVgHTz8t37cDTF86X6lmXCQ
         NWgFUDvsCXlRL2H1XIWfGlyoUqvawLP+X9iWhCwvscOXC/los/U7J1E+6lJT2lfC8b8h
         /QKQO2dNPV9/sWO3/Joca9t8X1dTt+/4B6qwsTfut7wsESJ9Sjf9cMyuk90TcYdy3fsL
         O/07LTJPIJwagtnxTWT0h2QS0PcdzBoKLCZa7DgqX11GVGYQwnRu9j2aeFWAB3ogKSo3
         Qi/w==
X-Gm-Message-State: AOAM532cEGClq2wdic3BRH7z4c7hmMt6C1uecfuYMJja8VyKFeMpPRHU
        BtmDANRKXaU2lbLXDQCl6b7hgl/p7UAOWbXjBg8VRMCCgaY=
X-Google-Smtp-Source: ABdhPJzwSaqsvXVP+Hi+ApjfDFCcQUAVGWkV2y70lOE8d8i8sGXfVuasQz6awpiLZ25mrRfcn7sZyBxrhSpEu9IcJx4=
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr441287ejc.758.1644870628490;
 Mon, 14 Feb 2022 12:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20220211023008.3197397-1-wonchung@google.com> <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Mon, 14 Feb 2022 12:30:17 -0800
Message-ID: <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 14, 2022 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
> >
> > When ACPI table includes _PLD fields for a device, create a new
> > directory (pld) in sysfs to share _PLD fields.
>
> This version of the patch loos better to me, but I'm not sure if it
> goes into the right direction overall.
>
> > Currently without PLD information, when there are multiple of same
> > devices, it is hard to distinguish which device corresponds to which
> > physical device in which location. For example, when there are two Type
> > C connectors, it is hard to find out which connector corresponds to the
> > Type C port on the left panel versus the Type C port on the right panel.
>
> So I think that this is your primary use case and I'm wondering if
> this is the best way to address it.
>
> Namely, by exposing _PLD information under the ACPI device object,
> you'll make user space wanting to use that information depend on this
> interface, but the problem is not ACPI-specific (inevitably, it will
> appear on systems using DT, sooner or later) and making the user space
> interface related to it depend on ACPI doesn't look like a perfect
> choice.
>
> IOW, why don't you create a proper ABI for this in the Type C
> subsystem and expose the information needed by user space in a generic
> way that can be based on the _PLD information on systems with ACPI?

Hi Rafael,

Thank you for the review.

I was thinking that _PLD info is specific to ACPI since it is part of
the ACPI table. Could you explain a little bit more on why you think
exposing _PLD fields is not an ACPI-specific problem?

I gave an example of how _PLD fields can be used for specifying Type C
connectors, but it is not Type C specific. For Chrome OS, we plan to
initially add PLD to not only Type C connectors but also USB port
devices (including Type C and Type A). Also, PLD can be used in the
future for describing other types of ports too like HDMI. (Benson and
Prashant, please correct or add if I am wrong or missing some
information) Maybe my commit message was not detailed enough..

I am also curious what Heikki thinks about this. Heikki, can you take
a look and share your thoughts?

Thank you,
Won
