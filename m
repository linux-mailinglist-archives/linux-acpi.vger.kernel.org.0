Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB77320685
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Feb 2021 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBTRtN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 20 Feb 2021 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBTRtM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Feb 2021 12:49:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C047C06178A
        for <linux-acpi@vger.kernel.org>; Sat, 20 Feb 2021 09:48:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t11so21956873ejx.6
        for <linux-acpi@vger.kernel.org>; Sat, 20 Feb 2021 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=SJiJGOm92EOLuEmD8ZxINHCPgWL9FHxOSQ3VIYWX9zoyH2E9wOjXIS9rFt4qflATpv
         hSN/bjk3gMWmOoic96yidZvVl7/B4XMCsqfh0PkuMvTvPzxsbnnAAzqFwvJBX/EHx6Jq
         lEXEZ04J4mAMFF3qpTPsBe+t1d1hZCpoZ1tHexVfyV6BEj3IJZ6FxOnS5w7SFjV4xaQB
         bzdJovpxJgMpQMBdOPWU4kOe8uTftngZHfL80X3V4NBKw6dQvwl3+V0eAaAFtkaj7Nyw
         q6pWkVkKDyqb9Tw8d5bxJN+VZ9kPSu7gfMjLM+uXAWL9W050qu1qq3zAwkiaymsFO0Qm
         BLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=dYE9Fd49biWcji/ROgIcjVgzhCA5tn9u+/4d7qxWOmssE3U3X0RBGYwX7StbmE/2+H
         yVMYPrUl7nic31IO5Px31Jp2izA+iVmmdagzrK25yrXqXzOOoJO4Uks6lumdrYnXbczJ
         O2n92+yW/QXIkww9+mGBV3lsygaY3GoeAT6BXo7lKXm1DhA2xmSDDzC46NSV9ReLkIEr
         CFUB0kfpSUGpj3dYZsM7RfCKYRTeF3F9JLBtrRp98bBVpbtqx2yDXLSrFWZtSaI0sdxE
         W3AA0r/sTe6E2IzPeqKPd1y1si5K3p3IKXF40MekoVXxJW/qRFUIx8DhGS4UgTm3I4a2
         PsCg==
X-Gm-Message-State: AOAM532boDVPQKghJayo3Vh28xIRvTDxPJfxuE0+UHKCkEVVIhRnn71Y
        tMeYVoe9EF02cp5cVu63R1PQw4FGGOoFjEAH68Gm8Q==
X-Google-Smtp-Source: ABdhPJzMFtM3V/tSlVTUOFi/gy4tLf3ErLDeRmJYFtXE81s7f90uq338SYuA8goZna9AO+QqkY89+APsjw6TJdTe694=
X-Received: by 2002:a17:907:373:: with SMTP id rs19mr1248541ejb.341.1613843310167;
 Sat, 20 Feb 2021 09:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com> <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
 <20210220163344.csczmkyxkpu4fxah@intel.com>
In-Reply-To: <20210220163344.csczmkyxkpu4fxah@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Feb 2021 09:48:22 -0800
Message-ID: <CAPcyv4jWnW_i=jaGP_nXRuGgwmngObw_V8AOPY3k_YMHkL-8Eg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 20, 2021 at 8:33 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-19 20:22:00, Konrad Rzeszutek Wilk wrote:
> > ..snip..
> > > +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> > > +                                   const struct cxl_mem_command *cmd,
> > > +                                   u64 in_payload, u64 out_payload,
> > > +                                   s32 *size_out, u32 *retval)
> > > +{
> > > +   struct device *dev = &cxlm->pdev->dev;
> > > +   struct mbox_cmd mbox_cmd = {
> > > +           .opcode = cmd->opcode,
> > > +           .size_in = cmd->info.size_in,
> > > +           .size_out = cmd->info.size_out,
> > > +   };
> > > +   int rc;
> > > +
> > > +   if (cmd->info.size_out) {
> > > +           mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> > > +           if (!mbox_cmd.payload_out)
> > > +                   return -ENOMEM;
> > > +   }
> > > +
> > > +   if (cmd->info.size_in) {
> > > +           mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> > > +                                              cmd->info.size_in);
> > > +           if (IS_ERR(mbox_cmd.payload_in))
> > > +                   return PTR_ERR(mbox_cmd.payload_in);
> >
> > Not that this should happen, but what if info.size_out was set? Should
> > you also free mbox_cmd.payload_out?
> >
>
> Thanks Konrad.
>
> Dan, do you want me to send a fixup patch? This bug was introduced from v4->v5.

Yes, please, incremental to libnvdimm-for-next which I'm planning to
send to Linus on Tuesday.
