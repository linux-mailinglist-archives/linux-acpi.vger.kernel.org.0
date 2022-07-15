Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C3576369
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiGOOHr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiGOOHq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 10:07:46 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8003F33E;
        Fri, 15 Jul 2022 07:07:40 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31d7db3e6e5so47714617b3.11;
        Fri, 15 Jul 2022 07:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mB8MshyZQ3H+5jGI7wEpF7cyzflD4Jja5pM/YkTK85U=;
        b=rSQHJy5YYQWvxis6y5xAezdl61t74BENTD5KMhTrkmil+Kw/QrYsvwkSep2ep4sFjZ
         52ev2IQnVehsDR2YnyfoZI2wvFAaZxj//1TTiTtxy7LwoX8Qopa+5mGWxznAXjhItVOP
         eTH9awuPKj1hTkiI3Yw5EXa7WFjs03NIFzUQpS4Yq5LxJnk267IulvSv2hKWXxtvMl2F
         a8Jo0nD36xkD1D3AU8DEW4z3mh08NxCGGgLpsFnJG7ulySUlf7OgcbCaD85OKqaQmbL0
         WB6X08RwqNXOk83z+XNRXAm//qxcgx5eJZVpbK6Bh8kIEagV6yNYAzoKWDWs68QPhlPB
         QzRg==
X-Gm-Message-State: AJIora83A0ZScZnyCRvofXuPjKhPZ31armzFnvuFiGmmiMFZYZwhw+zv
        zYcwsTCDTARwkEbbc3lP+zKhwT/ZnPPDiMwFrcM=
X-Google-Smtp-Source: AGRyM1tyOFeqyd64Y70bmE0mmcv6bkgrBNmUysaRjyZ/ZYypiW98S5p8M+DjLrKlHhNFgPHH6VfcwRkQyy7evQQGUWE=
X-Received: by 2002:a81:cd6:0:b0:31d:72e3:8b81 with SMTP id
 205-20020a810cd6000000b0031d72e38b81mr15877408ywm.301.1657894059985; Fri, 15
 Jul 2022 07:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220713112612.6935-1-limanyi@uniontech.com> <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
 <62d11a02.1c69fb81.ee60c.b0efSMTPIN_ADDED_BROKEN@mx.google.com> <CAJZ5v0gKMqOwg3JLx4PBksnpUhgaDDfahmE5RjJMTByOLAQOFg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gKMqOwg3JLx4PBksnpUhgaDDfahmE5RjJMTByOLAQOFg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 16:07:28 +0200
Message-ID: <CAJZ5v0gt761WUPn-3HQ3sA+8N_s_yHrSkk6CH1gBW0gy1c_+KA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manyi Li <limanyi@uniontech.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 15, 2022 at 2:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 15, 2022 at 9:40 AM Manyi Li <limanyi@uniontech.com> wrote:
> >
> >
> >
> > On 2022/7/14 11:20, Kai-Heng Feng wrote:
> > > [+Cc Matthew]
> > >
> > > On Thu, Jul 14, 2022 at 2:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >>
> > >> [+cc Kai-Heng, Vidya, who also have ASPM patches in flight]
> > >>
> > >> On Wed, Jul 13, 2022 at 07:26:12PM +0800, Manyi Li wrote:
> > >>> Startup log of ASUSTeK X456UJ Notebook show:
> > >>> [    0.130563] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> > >>> [   48.092472] pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> > >>> [   48.092479] pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> > >>> [   48.092481] pcieport 0000:00:1c.5:    [ 0] RxErr
> > >>> [   48.092490] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> > >>> [   48.092504] pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> > >>> [   48.092506] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> > >>
> > >> Can you elaborate on the connection between the FADT ASPM bit and the
> > >> AER logs above?
> >
> > Sorry,I don't know about that.
> >
> > >>
> > >> What problem are we solving here?  A single corrected error being
> > >> logged?  An infinite stream of errors?  A device that doesn't work at
> > >> all?
> > >
> > > Agree, what's the real symptom of the issue?
> >
> > Please see the details of this issus:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216245
> >
> > >
> > >>
> > >> We don't need the dmesg timestamps unless they contribute to
> > >> understanding the problem.  I don't think they do in this case.
> > >
> > > According to commit 387d37577fdd ("PCI: Don't clear ASPM bits when the
> > > FADT declares it's unsupported"), the bit means "just use the ASPM
> > > bits handed over by BIOS".
> > >
> > > However, I do wonder why both drivers/pci/pci-acpi.c and
> > > drivers/acpi/pci_root.c are doing the ACPI_FADT_NO_ASPM check,
>
> Because pci_root.c doesn't read aspm_disabled.

I've recalled a bit in the meantime.

First off, ACPI_FADT_NO_ASPM forbids the OS from enabling ASPM control
(quite literally).  It doesn't mean that the OS should not enumerate
ASPM and it doesn't mean that it should not report ASPM support to the
firmware via _OSC.  Moreover, there are (or at least there were)
systems where the firmware expected ASPM support to be reported via
_OSC anyway (see commit 8b8bae901ce2 PCI/ACPI: Report ASPM support to
BIOS if not disabled from command line).

Thus, if ASPM is not disabled from command line, it would be
consistent to carry out the _OSC negotiation as usual regardless of
ACPI_FADT_NO_ASPM and then handle the case in which it is set in the
same way as the case in which the firmware doesn't grant the kernel
control of some PCIe features.  Does this sound reasonable?

If it does, I think that ASPM should be enumerated regardless of
ACPI_FADT_NO_ASPM, but we need to ensure that its configuration is not
changed in any way if ACPI_FADT_NO_ASPM is set and I'm not sure if
that is the case now.

Of course, the same needs to happen when the kernel doesn't get full
control over PCIe features via _OSC, but AFAICS that case is handled
in the same way as the above already.

> > > maybe one of them should be removed?
>
> Arguably, pci_root.c could look at aspm_disabled instead of looking at
> the FADT flag directly.

Second, if the former does sound reasonable, I'd rather avoid setting
aspm_disabled from drivers/pci/pci-acpi.c upfront when
ACPI_FADT_NO_ASPM is set, because doing that is not consistent with
the above.

Now, there may be BIOSes that don't expect to be informed of the OS
support for ASPM via _OSC if ACPI_FADT_NO_ASPM is set, and the
question is what to do with them.  They clearly are at odds with the
BIOSes that do expect that to happen (mentioned above), so honestly
I'm not sure.

> > I think duplicate work has been done, but comment
> > in drivers/acpi/pci_root.c is
> > * We want to disable ASPM here, but aspm_disabled
> > * needs to remain in its state from boot so that we
> > * properly handle PCIe 1.1 devices.  So we set this
> > * flag here, to defer the action until after the ACPI
> > * root scan.
> >
> > I don't understand this logic.
>
> This is about the case after failing acpi_pci_osc_control_set() and
> generally we need to defer setting aspm_disabled because of
> pcie_aspm_sanity_check().
>
> > >
> > >>
> > >>> Signed-off-by: Manyi Li <limanyi@uniontech.com>
> > >>> ---
> > >>>   drivers/pci/pcie/aspm.c | 1 +
> > >>>   1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > >>> index a96b7424c9bc..b173d3c75ae7 100644
> > >>> --- a/drivers/pci/pcie/aspm.c
> > >>> +++ b/drivers/pci/pcie/aspm.c
> > >>> @@ -1359,6 +1359,7 @@ void pcie_no_aspm(void)
> > >>>        if (!aspm_force) {
> > >>>                aspm_policy = POLICY_DEFAULT;
> > >>>                aspm_disabled = 1;
> > >>> +             aspm_support_enabled = false;
> > >>
> > >> This makes pcie_no_aspm() work the same as booting with
> > >> "pcie_aspm=off".  That might be reasonable.
> > >>
> > >> I do wonder why we need both "aspm_disabled" and
> > >> "aspm_support_enabled".  And I wonder why we need to set "aspm_policy"
> > >> when we're disabling ASPM.  But those aren't really connected to your
> > >> change here.
> > >
> > >  From what I can understand "aspm_disabled" means "don't touch ASPM
> > > left by BIOS", and "aspm_support_enabled" means "whether ASPM is
> > > disabled via command line".
> > > There seems to be some overlaps though.
> >
> > According to commit 8b8bae901ce23 ("PCI/ACPI: Report ASPM support to
> > BIOS if not disabled from command line"), "aspm_support_enabled" means
> > whether or not report ASPM support to the BIOS through _OSC.
>
> Right.
