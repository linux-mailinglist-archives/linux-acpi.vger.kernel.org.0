Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBA74BD17
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jul 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGHJ0H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 8 Jul 2023 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGHJ0G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Jul 2023 05:26:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A7C1BF5
        for <linux-acpi@vger.kernel.org>; Sat,  8 Jul 2023 02:25:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso4235936e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 08 Jul 2023 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688808339; x=1691400339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCpw0lHr+AbvSxnzg9XtiBC/ZvwrmfnPkPx+Fvg8o70=;
        b=Sci15XqiYLbNecBF/GuJ1mM8D+s4WOJZXJfxW8Z52ck4SGtgemoHvh4I7FzZLDFoOV
         TdULymacrA5sseAvwHHjKEaYwt/TbHiVTGqpSUoH2xneze0cyTZ4ZLySNI/Ju3khNO5h
         GNwfl37PL6lEHeU3ZU3fzAzRVyMJKgNtXJKcRKz315onxSOllkJRxOh7uyQhH+g/EqWW
         Y/WIb/tQ/64Lz7i8ClXlta4eLq3cd08TJTKe/MRB89kB1NlhMbm+n1e4toD8fU9DrveR
         XAC4U5V1f6+4wxr5Lo20Bq0Bi+EA3ieGMQ7BUtvmKDhifyoEN8WOvXrHc9QXQk+4/0ce
         XJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688808339; x=1691400339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCpw0lHr+AbvSxnzg9XtiBC/ZvwrmfnPkPx+Fvg8o70=;
        b=IHiIFreNlzjYJvxbKCV5aJ6uOMR+cmJ/9pzmgCnApxuvU4ihiytVg/6fILxgHe+lnX
         Ljp81jDMWk/TOFwYIjRY4vEmfhLmamwRSNVLI+wOntEzMmKvLWmWJXeXRKFPp/FPJOfr
         haRNe2sucV1d0/dCk/Kez1S66PzvtNM/RoXohLXPx1EvwPVNbnMzlSxLiTcYicIXdChB
         1H3MJJWa1rf1dB1Wg76rSy/SXvHuew+2tg1+/nI944gGzoMtzdFxnMIwphCglnt4OIdw
         rpCNqJ4VNaOlHn6gbs+77NO7O3p/6l0dOfyttuWUS/OEJw2wojThl2qRiQdx1qjg6NYG
         LNvQ==
X-Gm-Message-State: ABy/qLb+yIzIL4vMA0QuocgCh5fdySEcQ+lQyhEVmGneRjr8192XavNt
        6ZgJSHyi9JIHk5G32cFwvBx5E+UqykphMbUADI72Lw==
X-Google-Smtp-Source: APBJJlHpHpNEOzljGNGhzdKqzZd0Exi6/n/y9u220POKtKz5wP6CjZdUf4rogMBsc3/lnCmEcMP/2G7SNboW104YScI=
X-Received: by 2002:a05:6512:3112:b0:4f9:5519:78b8 with SMTP id
 n18-20020a056512311200b004f9551978b8mr5030415lfb.63.1688808339073; Sat, 08
 Jul 2023 02:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop> <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud> <DBAPR08MB57836AE63A1F5D3902B95BFE9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
 <CAEEQ3wnhCRnDsa2Un=J_VOo2JZqf0nMXX11okqpyhMbLAWsKJQ@mail.gmail.com> <9F6A932E-6FFE-4CF1-BF20-D5D80AC26F37@jrtc27.com>
In-Reply-To: <9F6A932E-6FFE-4CF1-BF20-D5D80AC26F37@jrtc27.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Sat, 8 Jul 2023 17:25:27 +0800
Message-ID: <CAEEQ3wkJ4GkrzwasesjqKmEns3HpQrTYOxe=o3Mw0Qe2nb=mVA@mail.gmail.com>
Subject: Re: [External] [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Dong Wei <Dong.Wei@arm.com>, Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "yc.hung@mediatek.com" <yc.hung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "allen-kh.cheng@mediatek.com" <allen-kh.cheng@mediatek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tinghan.shen@mediatek.com" <tinghan.shen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "weidong.wd@bytedance.com" <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jessica,

On Sat, Jul 8, 2023 at 11:59=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 8 Jul 2023, at 04:22, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedance=
.com> wrote:
> >
> > Hey,
> >
> > On Sat, Jul 8, 2023 at 12:39=E2=80=AFAM Dong Wei <Dong.Wei@arm.com> wro=
te:
> >>
> >>
> >>
> >>> I don't think that's the limitation on RISC-V. BTW, how does OSPM fin=
d the
> >>
> >>> RSDP on ARM systems? Does it meet 5.2.5?
> >>
> >>>
> >>
> >>
> >>
> >> On Arm systems today, the ACPI RSDP is found using the UEFI Configurat=
ion Table. This is true for all Arm SystemReady compliant systems: 1) Syste=
mReady LS: LBBRv1 is using a minimal UEFI FW to load LinuxBoot, that minima=
l UEFI FW is producing the UEFI Configuration Table. We are working on LBBR=
v2. LBBRv2 is based on Coreboot loading LinuxBoot. But we do not have a way=
 today to get CoreBoot to produce this pointer to ACPI RSDP. Arm does not s=
upport x86 E820 BIOS interface. 2) SystemReady IR: this solution uses DT ra=
ther than ACPI. 3) SystemReady ES: this solution can use UBoot or EDK2, and=
 it requires ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSDP=
 can be found using the UEFI Configuration Table. 4) SystemReady SR: this s=
olution typically uses EDK2 and requires ACPI, so no issue finding RSDP via=
 UEFI Configuration Table.
> >
> > Looks like ARM has a similar problem,
>
> If by =E2=80=9Cproblem=E2=80=9D you mean =E2=80=9Cthere=E2=80=99s only on=
e standard that I=E2=80=99m choosing
> to not follow=E2=80=9D.
>
> > Indeed, as Ron said, many companies may encounter this issue. More
> > developers are embracing Coreboot. When the platform guided by
> > Coreboot requires ACPI support, they are faced with how to pass ACPI
> > RSDP to Linux.
>
> It=E2=80=99s called UEFI. EBBR=E2=80=99s requirements are pretty minimal.
>
> Please just follow the one standard. Having one standard is good for
> compatibility; there needs to be a very good reason beyond =E2=80=9CI don=
=E2=80=99t
> like the standard=E2=80=9D to introduce a competing one and the fragmenta=
tion
> that results from it that becomes shared pain for the ecosystem.
>

Which specification stipulates that all Bootloaders must implement (U)EFI?

We approve ACPI's hardware-related description specifications.
In the FFI scheme, Coreboot also follows the ACPI specification and
realizes the construction of the table.
We do not follow (U)EFI and ACPI bindings.

Of course, it is best to have specifications, and it is also what we
all expect together.
According to the actual situation, if the specification is
unreasonable, should we optimize it?

Please tell me some specific problems brought about by FFI?

> Jess
>
> >> So the ACPI RSDP issue only exist if we want to remove the minimum UEF=
I FW and go to CoreBoot completely to load LinuxBoot. We are currently expl=
oring how to solve that issue=E2=80=A6
> >>
> >>
> >>
> >> -DW
> >>
> >>
> >>
> >> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
> >
> > Thanks,
> > Yunhui
>
>

Thanks,
Yunhui
