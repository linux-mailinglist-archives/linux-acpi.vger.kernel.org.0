Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2C1D75E2
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgERLHG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 07:07:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40826 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgERLHG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 07:07:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id v128so8598439oia.7
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 04:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmJIEp+kiSI8MxrxJgq0AuNakTvh0ueYA1Hz0tZ7A1g=;
        b=VpjHWSRCHFkjnEVZ/yNWE1kew4aWFU9bVrS2H7hQEE1ksPD0zjXCC2xsGwYP4fev9+
         QpgbBeC88Iy8Yb0okZHBbVCICR/ZK7jjI20eGLskaL9otVW/MQP3fepdt2ZTNcgHU3ri
         ZtiKPpLnckbtsb6yTVygWLAyroBQRYbD/rbBnci3LEVgRa/89QuAWn6GXK9w++OfHk5s
         9rgkjf9jbwBs8c3pgWcNvjS6GkfuIkXseUdkkRM6a2X9mjDcoU+Ubmww4YHuEsfZB5w/
         VJXAm15nABF+KkrXaqekbESZLd6Tp8+WX7v56gbWWt5kVxpJM6gCn69BaDpSPMWUOWPd
         iy9g==
X-Gm-Message-State: AOAM533CkJz3vVvCBwmiBnrPWmLDxYeewtlHHumKdjQJIjOFwla6runs
        vEZqm3dwNXV13zXpcjGmZY/HUWKO1e2g4PedyiY=
X-Google-Smtp-Source: ABdhPJyO7qj9urHg5mFVtUCuSaO3piwA11qlqpAMBinji3EbviBFsC2R0Ew7QVX3YcdhPsOxsE0dCMTibQXzwldtoWA=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr576935oid.103.1589800024528;
 Mon, 18 May 2020 04:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
 <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
 <CAJZ5v0gRScLoBGr6546=zJBtZj2D0-Yv48RZobN-0eih01L29A@mail.gmail.com>
 <89fd7ece-ab9c-cee0-e575-7652a992fe3a@redhat.com> <20200518101845.65da0634@coco.lan>
In-Reply-To: <20200518101845.65da0634@coco.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 May 2020 13:06:53 +0200
Message-ID: <CAJZ5v0hGyRRPkh+79ApUk97UXx6nEjia4XKfqBijVD23hbi3sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 18, 2020 at 10:18 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Mon, 18 May 2020 09:22:53 +0200
> Hans de Goede <hdegoede@redhat.com> escreveu:
>
> > Hi Rafael,
> >
> > On 5/15/20 6:28 PM, Rafael J. Wysocki wrote:
> > > On Tue, May 12, 2020 at 7:52 AM Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:
> > >>
> > >> On Asus T101HA, we keep receiving those error messages:
> > >>
> > >>          i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
> > >>          intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
> > >>          intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
> > >>
> > >> Because the opregion is missing the I2C address.
> > >>
> > >> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > >> ---
> > >>   drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> > >> index 7ccd7d9660bc..a5101b07611a 100644
> > >> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> > >> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> > >> @@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
> > >>          .power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
> > >>          .thermal_table = chtdc_ti_thermal_table,
> > >>          .thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
> > >> +       .pmic_i2c_address = 0x5e,
> > >>   };
> > >>
> > >>   static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
> > >> --
> > >
> > > This appears to be part of a series, but the second patch has not been
> > > CCed to linux-acpi.
> >
> > Mauro send out 3 patches related to the PMIC, this one and 2 MFD patches.
> > I think his intention was to send out this standalone and the 2 MFD patches
> > as a series, but instead he send out this 1 + 1 MFD patch as a series and
> > the other MFD patch as a standalone patch.
> >
> > Either way this patch is a standalone patch, the 2/2 patch is almost
> > completely unrelated, so if you can pick this one up, then that would be
> > great.
>
> Yeah, patch 2/2 is independent of this one. It touches only drivers/mfd/Kconfig,
> addressing a problem when building with INTEL_SOC_PMIC_CHTDC_TI=m.
>
> The third patch for the MFD tree addresses similar issues with drivers that
> register an OpRegion, but won't work properly if compiled as module.
>
> Please pick this one via your tree.

OK, applied as 5.8 material, thanks!
