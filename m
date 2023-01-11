Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0A66581B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 10:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjAKJvJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 04:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjAKJtw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 04:49:52 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E67C76F
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 01:48:45 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id ss4so28133482ejb.11
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 01:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJSdKNiozoQ/fKT44b3RPqNb6mGyt9zq/l5dYOnFE84=;
        b=6xzqOkabUj/AUynyD5BUAQoQ8qbzsQaTZ5TvIvMn325D0M8O2II+zYl1HdLy5PPKwy
         iQx42kFb20dy+kcqJwayiRRoHEKIBO8ucqJ7sz2u3IwmorHaTO411xtILSYlqozWn7kJ
         Lv+ujK4nmdeYjHy0T5ySwsgGKdAr+KojAD/uTuti/uzmQ+0BwJo14ZW6vXZfs6hQd+Hv
         qDSqgDg7j+wd17+ZzTJye8MhsIbIAnBNUPcnqP8vgV0MzEQxvd9hb0OLx5OaefLSlF5C
         X6k79WXKOSal99ctIk5jGBh/aCVaZJzBrZ7JMXlUE9Lets1wBVV5AiBvvEBPp35X4TUC
         13Ew==
X-Gm-Message-State: AFqh2kqmMS+9Nzm1tTsw7lnCliUB5P461/EVu5JtyJTJ1uPUXBG8X5kR
        nLxv/zqzBZFUY+pXkCzcgwBrmpWXwPZTSgXtBpc=
X-Google-Smtp-Source: AMrXdXvuT3LCiP/+pckmfubDwy/CrownSWm00zhuRod81cBaQl9cNT1xGgqkYba3e6dGwEBUTMC/Cc3wyGqrLkkFbrc=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr1760489ejx.509.1673430524098; Wed, 11
 Jan 2023 01:48:44 -0800 (PST)
MIME-Version: 1.0
References: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
 <1987c2d2-1246-b172-985f-360e5c2c437a@oracle.com> <Y73zkXlPqiMFeT6V@zn.tnic>
In-Reply-To: <Y73zkXlPqiMFeT6V@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 10:48:32 +0100
Message-ID: <CAJZ5v0iN1ZnBwrX6LxwCy+5iUrEzBCEUxmvCyVhkMJNofmTTbg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Puthukattukaran <james.puthukattukaran@oracle.com>,
        linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
        lenb@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 11, 2023 at 12:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jan 10, 2023 at 05:43:41PM -0500, James Puthukattukaran wrote:
> > Adding others that I missed on my first email.
> >
> > James
> >
> > On 12/22/22 13:26, James Puthukattukaran wrote:
> > > Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
> > > online capable") to include acpi_parse_x2apic as well.
>
> This doesn't look like an extension to some existing commit but like a separate
> fix.
>
> > > There is a check for invalid apicid; however, there are BIOS FW with madt
> > > version >= 5 support that do not bother setting apic id to an invalid value
> > > since they assume the OS will check the enabled and online capable flags.
>
> Which BIOSes are those?
>
> Also, I'm no BIOS guy but I don't see you checking MADT version anywhere?
>
> > > Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
> > > Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
> > >
> > > v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
> > > v3 : updates as per Rafael's comments
>
> Yah, I'd like for Rafael to decide what to do here...

I've just sent my comments to the patch, but you have not been CCed, sorry.

IMO the MADT version should be checked too and I would like to have at
least one example of a platform affected by this problem in the
changelog.
