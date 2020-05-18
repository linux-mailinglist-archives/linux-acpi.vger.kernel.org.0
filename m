Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEC11D72CC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERISv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 04:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgERISu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 May 2020 04:18:50 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854B7206D4;
        Mon, 18 May 2020 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589789930;
        bh=yDfS8c4N/SpGiovX7gFG42rDeUyPq38+mXhSWeh847Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h+YfJoXk+l0nWV3YAQ96POVzARIlaC6QX9aYk9hyrbPqwIRqUM0yRecxO4dOh+ya6
         66aPwWa0aNoKNr0wYYQAO3dim4WIECE6iD5w0Bsus/85r9IJBr4+1ZBRtgghpkH9DK
         9wmhUzkuQgFechswrCGGmnAOeXg/hoLSrRKJb9qI=
Date:   Mon, 18 May 2020 10:18:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
Message-ID: <20200518101845.65da0634@coco.lan>
In-Reply-To: <89fd7ece-ab9c-cee0-e575-7652a992fe3a@redhat.com>
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
        <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
        <CAJZ5v0gRScLoBGr6546=zJBtZj2D0-Yv48RZobN-0eih01L29A@mail.gmail.com>
        <89fd7ece-ab9c-cee0-e575-7652a992fe3a@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Em Mon, 18 May 2020 09:22:53 +0200
Hans de Goede <hdegoede@redhat.com> escreveu:

> Hi Rafael,
> 
> On 5/15/20 6:28 PM, Rafael J. Wysocki wrote:
> > On Tue, May 12, 2020 at 7:52 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:  
> >>
> >> On Asus T101HA, we keep receiving those error messages:
> >>
> >>          i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
> >>          intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
> >>          intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
> >>
> >> Because the opregion is missing the I2C address.
> >>
> >> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> ---
> >>   drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> >> index 7ccd7d9660bc..a5101b07611a 100644
> >> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> >> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> >> @@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
> >>          .power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
> >>          .thermal_table = chtdc_ti_thermal_table,
> >>          .thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
> >> +       .pmic_i2c_address = 0x5e,
> >>   };
> >>
> >>   static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
> >> --  
> > 
> > This appears to be part of a series, but the second patch has not been
> > CCed to linux-acpi.  
> 
> Mauro send out 3 patches related to the PMIC, this one and 2 MFD patches.
> I think his intention was to send out this standalone and the 2 MFD patches
> as a series, but instead he send out this 1 + 1 MFD patch as a series and
> the other MFD patch as a standalone patch.
> 
> Either way this patch is a standalone patch, the 2/2 patch is almost
> completely unrelated, so if you can pick this one up, then that would be
> great.

Yeah, patch 2/2 is independent of this one. It touches only drivers/mfd/Kconfig,
addressing a problem when building with INTEL_SOC_PMIC_CHTDC_TI=m.

The third patch for the MFD tree addresses similar issues with drivers that
register an OpRegion, but won't work properly if compiled as module.

Please pick this one via your tree. The other two patches should probably
go via MFD tree.

Thanks,
Mauro
