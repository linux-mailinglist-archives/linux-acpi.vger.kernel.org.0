Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC40821615F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 00:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGFWRV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 18:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGFWRV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2020 18:17:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29529C061794
        for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2020 15:17:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so23603502lfb.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VcTg7znjs5NM9gvezTd2PmxFMdpOTVCMT/3yPB+Qgb4=;
        b=vNzVRDUl4U537XT+jFySQw2TYQYIYbNVvMi2vI75OS8G/oHkzYqETbWDdsyWrqnJvB
         ZDagRVkHhKD8zrtLYJJ8qIXo0AuuWaJckY5WFye6ln6rpJlD+AplVS4Ho5fxKhazVYd+
         WwNgl/fOyzqH2mIWWEgJom7RS2Ys5J/RcL078JbEZFoB+AoMeXlDAL/+dvD25aT6hP7g
         cRY8zFElRYhBxqOzi9A+D7S29ctaddBPIC5OT/Ic4cekOp6Ldlh3Lmc0aMJePc/BbAgT
         305sc89OsH87ksxbW1okc8uaJtthTw6avN9JtPmDdA9CbRbhBy4vF/SiokD2ssfDaKPU
         KjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VcTg7znjs5NM9gvezTd2PmxFMdpOTVCMT/3yPB+Qgb4=;
        b=acWrMbz3v+6697GYQv5FWn+ZuFAkaJcVihkRdP/JgrjTefsFAakL0V1MNN/ppoedNO
         81u7pGYH90BOhpWDU/Y7ZDj5nDjhjcuPyWlhvDA3oPU5EKFTQLWkjAyeIXoMYAt8wlEq
         5821xn/auC8FvTJSq64gkLmoumOGenh7ef0bSWSzYvQegbJ7MvqTSoDf2PD8CBE+UdN2
         vZdwCQlEeA2EHvLIobP2jNVLUeN+JIhJEk8TfI7xp7GEsVRlCKLoxOgRbwqMdB3ZjiS5
         aZPFwnKqVfn0FEwBUw+ZkHofThH7otK8hhbvkpeuLGskbJ8lNHVU6IMroO2QZbsNQe51
         98uw==
X-Gm-Message-State: AOAM530G/uoSa78JCXIa2aGDVOtXEiEUutwPQKDOTqxDbRJ58DZY2xRL
        vwOIT6F1EXriCiy9USxxYb3EiFxoSiKwVViC6Cd+NQ==
X-Google-Smtp-Source: ABdhPJwe3ex8kcVRA0T8G22gfsoP7JF+/rquu8J+b6ju8abD2HlCAo8f1V+eED2pMxSAfWVXjFqnh6BvhytT/R+z9+8=
X-Received: by 2002:a19:435b:: with SMTP id m27mr31417703lfj.40.1594073839263;
 Mon, 06 Jul 2020 15:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-2-rajatja@google.com> <20200706155815.GA119406@bjorn-Precision-5520>
In-Reply-To: <20200706155815.GA119406@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 15:16:42 -0700
Message-ID: <CACK8Z6GtOH4o6J17YXnesf0VvQSQRTCR011RRD2U7gkrwA8ziQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bjorn,

Thanks for taking a look.

On Mon, Jul 6, 2020 at 8:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:37PM -0700, Rajat Jain wrote:
> > Currently this is being looked up at a number of places. Read and store=
 it
> > once at bootup so that it can be used by all later.
>
> Write the commit log so it is complete even without the subject.
> Right now, you have to read the subject to know what "this" refers to.
>
> The subject is like the title; the log is like the body of an article.
> The title isn't *part* of the article, so the article has to make
> sense all by itself.

Fixed.

>
> > +static void pci_enable_acs(struct pci_dev *dev);
>
> I don't think we need this forward declaration, do we?

We need it unless we move its definition further up in the file:

drivers/pci/pci.c: In function =E2=80=98pci_restore_state=E2=80=99:
drivers/pci/pci.c:1551:2: error: implicit declaration of function
=E2=80=98pci_enable_acs=E2=80=99; did you mean =E2=80=98pci_enable_ats=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
 1551 |  pci_enable_acs(dev);

Do you want me to move it up in the file so that we do not need the
forward declaration?

>
> > @@ -4653,7 +4653,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci=
_dev *dev, u16 acs_flags)
> >       if (!pci_quirk_intel_spt_pch_acs_match(dev))
> >               return -ENOTTY;
> >
> > -     pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> > +     pos =3D dev->acs_cap;
>
> I assume you verified that all these quirks are FINAL quirks, since
> pci_init_capabilities() is called after HEADER quirks.  I'll
> double-check before applying this.

None of these quirks are applied via DECLARE_PCI_FIXUP_*(). All these
quirks are called (directly or indirectly) from either
pci_enable_acs() or pci_acs_enabled(),

EXCEPT

pci_idt_bus_quirk(). That one is called from
pci_bus_read_dev_vendor_id() which should be called only after the
parent bridge has been added and setup correctly.

So it looks all good to me.

Thanks,

Rajat



>
> Bjorn
