Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8348F36A
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jan 2022 01:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiAOAQ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jan 2022 19:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiAOAQ1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jan 2022 19:16:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51E5C06173E
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jan 2022 16:16:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k15so39666684edk.13
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jan 2022 16:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YMjl+BxlkAj0ocutgxgneZ3nnXQxRxjy7+A3Hb6S6MM=;
        b=gwjMmUAyK1GBKkWHyvVu/xpiD3h5QUoGKZHkfi/GNbhoRcGZgtJ6G2cJZNrw6PFEbk
         ZfnuHgUF+YbnFIUfw73vXqakRjBml+BD1K5MNNoUf+aJAlGTozdLQFskh1C3Vmibmipl
         QsZJamvr0/jzhnpyxpxfI1PaQBVGpqt/2HaEc+U1/kOz3aGCHvCJfFSHHw71YnzulfPs
         M5h1tsShnmFgJGJdDyvLaq19ZAq+ieaui6JMHsx+SDmvdUEApmuxTIRAVsFl0Jbvh4kv
         YbZGkkjG0rmlsG86Sb0UF0zT6fpNcAA+ggFhCmCJJfDtbtsVBmXboJNfohpUI2QtZdh2
         3s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YMjl+BxlkAj0ocutgxgneZ3nnXQxRxjy7+A3Hb6S6MM=;
        b=flcYBxnidTC2r0QaIck9Wl9zGT60mAdBX9ftBYPGbyyrRanc5PMCHUy0u3ALFWdfHz
         KGXPbysoZHP0aAZVJxqe8wXshjlthiQ0AkGqc49Wu1R5/y0GSguQAvaaASdRItOLQxlC
         YzvahpROe8mtPm08TVQX2BOli9Cba4XLvYbNjcnB+TIXpB0sNEriOCYst3yq11CGLQ1V
         E5l3MatLUHdPPTmpcFrPNuc/cMlF2NJzw/G0ZTfv+vrLCPm9DTlkZprEbSZwNQgXHhqv
         qtT5VeUG+DmpwygdrIfGYxHHjgTe5o6XAcSIdkAxjcsdkeH6nYfDKb0SWrTbSbTaCJlw
         BjpA==
X-Gm-Message-State: AOAM532+S+wI0LT+VCjXrGxQw2GLKGkShymqn99Q1FWp7zm0JJP77gqc
        96Atn7Rq98TjqAzt72xQBc4avb7L9Xx5nyLNCebF/w==
X-Google-Smtp-Source: ABdhPJwGD8I5X1TpOUXOIHpLfyEMYmXxOu6zyTxcLiks7tT8Zu+YtFx3OahdHMkXU/r/aM6sxcdmOzif5pcpDGMozNg=
X-Received: by 2002:a05:6402:f02:: with SMTP id i2mr11194504eda.97.1642205785204;
 Fri, 14 Jan 2022 16:16:25 -0800 (PST)
MIME-Version: 1.0
References: <CAAJ9+9fq1=EcOaSoo3oD_5QjYNAv6PPDjKS+gC9o7XDp2p1XpQ@mail.gmail.com>
 <CAAJ9+9ct3+N0LyH+9N03ZQYUZnF23LFAyWFcnNK4bD7SvaohrQ@mail.gmail.com> <20220113092512.000011d6@Huawei.com>
In-Reply-To: <20220113092512.000011d6@Huawei.com>
From:   Zayd Qumsieh <zaydq@rivosinc.com>
Date:   Fri, 14 Jan 2022 16:15:00 -0800
Message-ID: <CAAJ9+9df5HCawwDJA2nJ2M=EXQ2LWhZQUSau0DPtFmD0zNoiDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     alison.schofield@intel.com, ben.widawsky@intel.com,
        cbrowy@avery-design.com, dan.j.williams@intel.com,
        f.fangjian@huawei.com, helgaas@kernel.org, ira.weiny@intel.com,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, vishal.l.verma@intel.com,
        Dylan Reid <dylan@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 13, 2022 at 1:25 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 12 Jan 2022 14:16:18 -0800
> Zayd Qumsieh <zaydq@rivosinc.com> wrote:
>
> > Hello all,
> >
> > Due to issues with vger.kernel.org marking HTML emails as spam, I'll
> > be resending the email in plain text:
> >
> >
> >
> > Hello all, First off, thanks for your work on implementing PCI Data
> > Object Exchange in QEMU and Linux.
> >
> > 1. Are these patches still being worked on? If not, I=E2=80=99ll try to=
 get
> > them rebased and finished.
> >
> > 2. Are there any notes not mentioned in the emails you feel are
> > important to know about?
> >
> > 3. I'm particularly interested in the testing framework - the emails
> > mention that a lot of testing has been done through QEMU but how can I
> > carry out these tests on my own? What tools did you use?
> >
> > Thanks,
> >
> > Zayd
>
> https://lore.kernel.org/all/20211105235056.3711389-1-ira.weiny@intel.com/
> Is the latest version of this.  For basic testing Ben's qemu branch shoul=
d
> work for you.
> https://gitlab.com/bwidawsk/qemu/-/commits/cxl-2.0v4/
>
> Note there are some big questions over the approach used for integrating
> this with the PCI subsystem (auxiliary bus vs library) which I'm not sure
> we've reached a conclusion on yet.
>
> One minor thing on the wish list is lspci support to at least identify th=
e
> presence of a DOE.  I have patches for that and will send out fairly soon
> once I've cleared a backlog of other stuff.
>
> My main focus right now is on resolving some of the opens around the
> QEMU support for CXL emul in general, but I haven't touched the DOE stuff
> beyond rebasing.  *fingers crossed* I should have an updated qemu tree
> out sometime in next week or so.
>
> Thanks,
>
> Jonathan

Hey,

I did some experimenting with Ben's QEMU branch and integrated your
patch locally. I'll be doing some testing of my own. If I run into
anything noteworthy I'll let you know. Again, thank you for all your
help! :)

Thanks,
Zayd
