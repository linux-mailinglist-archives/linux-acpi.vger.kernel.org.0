Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6644523B
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 12:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhKDLeM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 4 Nov 2021 07:34:12 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:47036 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDLeM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Nov 2021 07:34:12 -0400
Received: by mail-ot1-f54.google.com with SMTP id w29-20020a056830411d00b0055abaca9349so7709033ott.13;
        Thu, 04 Nov 2021 04:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MgdOLOPcs/A9vtxa4IU81lPxBsuAOPrUSmt5KTVFe1c=;
        b=RtuDRnKoaWUaVIaowkmuA15hLT+FcMOycmX+bE2SSjqRZ/Lxbm/fxOFiLC4g2qLq3s
         f0r6iG2TD9/7CM+Gv7gkAu8krGhVjAbYxbE7HmRiSQ82ZXXE3+z4az302GYRf6+3C4as
         iwelHik7ip/h7YjHCZG/e6Q0oWW8HfpCSOX3kDNLuR82o9tO7KdQW6ylnGYggOoj42JB
         vG0TD9xYZyIaDXTDD5K1yf9FeALFepTRfX41xPS1iOiZgFSmkqxmxQt7wY/jM/FF9dLd
         0eWEfkCryenle2J3IAapzjCPQCTiwTGm4/ESpmOkS6ONPGSQpTFB1SuVfpjSNeoTXt83
         VIJw==
X-Gm-Message-State: AOAM531/jdWSkE0yMHlqOtAFmuOxpoyiLRmg9TmCypGRskPoZy40rx4T
        3aGp+vZKNYx4EYA7cVSFbsBbTH+FMRmwzgxo1EM=
X-Google-Smtp-Source: ABdhPJyz+c5mJx35EqCu2zCOmAMuHJd58bEGPCbjF/ZRaisv3JU+s3sWzlmd8eR1Gg5qsKPAA7e55XEGx8XMc0QzcX8=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr30941382otg.198.1636025493924;
 Thu, 04 Nov 2021 04:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211026075257.3785036-1-ishii.shuuichir@fujitsu.com> <TYCPR01MB6160403C510AE93C1EC2635DE98D9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB6160403C510AE93C1EC2635DE98D9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Nov 2021 12:31:22 +0100
Message-ID: <CAJZ5v0j4ZvbkdF2Az_5MLFY=Vt7835LA-U2N2qKbZVk9KDx7QA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Add AEST in ACPI Table Definitions
To:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 4, 2021 at 8:14 AM ishii.shuuichir@fujitsu.com
<ishii.shuuichir@fujitsu.com> wrote:
>
> ping?
>
> P.S.
> We should have added the maintainer of ACPI FOR ARM64 (ACPI/arm64) first,
> but since AEST is an arm-spec ACPI table, added the concerned persons
> as new e-mail addresses.

Please resend the patch, then, with all of the requisite addresses
present in the CC list.

> > -----Original Message-----
> > From: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> > Sent: Tuesday, October 26, 2021 4:53 PM
> > To: rjw@rjwysocki.net; lenb@kernel.org; linux-acpi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; robert.moore@intel.com; erik.kaneda@intel.com;
> > rafael.j.wysocki@intel.com; devel@acpica.org
> > Cc: Ishii, Shuuichirou/石井 周一郎 <ishii.shuuichir@fujitsu.com>
> > Subject: [PATCH] ACPI: Add AEST in ACPI Table Definitions
> >
> > When We added AEST using the Upgrading ACPI tables via initrd function, the
> > kernel could not recognize the AEST, so We added AEST the ACPI table definition.
> >
> > Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> > ---
> >  drivers/acpi/tables.c | 2 +-
> >  include/acpi/actbl2.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> > f9383736fa0f..ab0fb4c33e07 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -499,7 +499,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE]
> > __initconst = {
> >       ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> >       ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> >       ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> > -     ACPI_SIG_NHLT };
> > +     ACPI_SIG_NHLT, ACPI_SIG_AEST };
> >
> >  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > a47b32a5cbde..b586e40d4b86 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -48,6 +48,7 @@
> >  #define ACPI_SIG_SDEV           "SDEV"       /* Secure Devices table */
> >  #define ACPI_SIG_NHLT           "NHLT"       /* Non-HDAudio Link Table
> > */
> >  #define ACPI_SIG_SVKL           "SVKL"       /* Storage Volume Key
> > Location Table */
> > +#define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
> >
> >  /*
> >   * All tables must be byte-packed to match the ACPI specification, since
> > --
> > 2.27.0
>
