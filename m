Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA874BB86
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jul 2023 05:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjGHDEp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jul 2023 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjGHDEo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2023 23:04:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32E1B9
        for <linux-acpi@vger.kernel.org>; Fri,  7 Jul 2023 20:04:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso28293305e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jul 2023 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688785457; x=1691377457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsK2X5Mi4VaOfX4KhvaFuW1M9mUzdFAp+0gGgg3mXQM=;
        b=RpH0HZmWgIVcQSeBvJXl/PSJNrQ8wdXr2kDeU3tw8ebfDYoia/IqFvIBFbVeb9y8IJ
         Zcy806Hmxrt/RrSTcB8IwUlt5rebFkh+u3jFtKlmmc9L5S0Vfhto5Mao+6iar90tHb/v
         Y1Gsm2ZJQhPJfJZ8sXMdqoN/6fYwYbPuT7K7+/9qKkZRM026OaHO0AHPNxJvLESJBafd
         Egj9bhWJJnfKUCsDDG3cb1RecceS8WNhKWeWVlOuPAuFOQf3WkyyOH8fyfPSxCvYwtoK
         YbYd1dRRzVcQ+1YJoNFQvjjZukVmV2+SSr/yn7bIxmaj8f5i2NVq85LJixfNy1jHe7XL
         6k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688785457; x=1691377457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsK2X5Mi4VaOfX4KhvaFuW1M9mUzdFAp+0gGgg3mXQM=;
        b=PLLSJleJnXk3wD5DvDHln6FLdewZS+j9dYY0oHMJWFdd6odrWm2llKHjR2GAU7+01s
         ptqkY2RSVPXxRI9FKVuUvnpP87yW3fiQv69zI5p5/YgNy2+Ps3ijFXNtw7V+y5vPi/cT
         H4KgE23kaxuU+5VoLh97rIKDlt2SxUz92CeaakhhXWuVXXXthwReYzY8Z+4BLg5y/Pa+
         mCRcunlLgutDrEjXtuLDk6BwhHnD2+EweR3vOAJx/3wqktlCr5IfsScyZXrK7xhqLCoZ
         pBiJIzjGOEosMSrJYCA0bhKZ4PbqC2DIKVK83uycdNgRs9qN02cNCsqIArBppWo4K8Kg
         V58A==
X-Gm-Message-State: ABy/qLZiwl9qkdAi2mTz/98bwVCG59AzdYXRVV9cwhF+mc/XwGdJ3SLs
        FhP3GER8gMzEKrtzK2f3IGYCBl/EgSdbxqWxXQJ5Qg==
X-Google-Smtp-Source: APBJJlHyrMBQ4oDOG1/I261/e9nCarKyLKdj6vxCkIjkby4/wtevtnk/4rpSHeC4yLj7JdHbyO85En3DatZNntn/8yw=
X-Received: by 2002:a1c:7416:0:b0:3fb:b3aa:1c88 with SMTP id
 p22-20020a1c7416000000b003fbb3aa1c88mr774777wmc.26.1688785456793; Fri, 07 Jul
 2023 20:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <20230705114251.661-5-cuiyunhui@bytedance.com>
 <20230707-brigade-myth-86ee252b2e4a@spud> <CAN3iYbP_dQOOJKLjAf+pVeYUZRBqwZBG7eq6=pR0upsjT2GpOA@mail.gmail.com>
In-Reply-To: <CAN3iYbP_dQOOJKLjAf+pVeYUZRBqwZBG7eq6=pR0upsjT2GpOA@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Sat, 8 Jul 2023 11:04:05 +0800
Message-ID: <CAEEQ3wkgxagOPYrg3g8apLHHDOcAR3hFKpHA3ZQDm9PKvO1xUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 4/4] dt-bindings: firmware: Document
 ffitbl binding
To:     =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
Cc:     Conor Dooley <conor@kernel.org>, sunilvl@ventanamicro.com,
        ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, weidong.wd@bytedance.com
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

Hi Conor,

On Sat, Jul 8, 2023 at 12:53=E2=80=AFAM =E8=91=9B=E5=A3=AB=E5=BB=BA <geshij=
ian@bytedance.com> wrote:
>
>
>
>
> On Sat, Jul 8, 2023 at 12:16=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
>>
>> Hey,
>>
>> On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
>> > Add the description for ffitbl subnode.
>> >
>> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> > ---
>> >  .../devicetree/bindings/firmware/ffitbl.txt   | 27 ++++++++++++++++++=
+
>> >  MAINTAINERS                                   |  1 +
>> >  2 files changed, 28 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.=
txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt b/D=
ocumentation/devicetree/bindings/firmware/ffitbl.txt
>> > new file mode 100644
>> > index 000000000000..c42368626199
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
>> > @@ -0,0 +1,27 @@
>> > +FFI(FDT FIRMWARE INTERFACE) driver
>> > +
>> > +Required properties:
>> > + - entry             : acpi or smbios root pointer, u64
>> > + - reg                       : acpi or smbios version, u32
>> > +
>> > +Some bootloaders, such as Coreboot do not support EFI,
>> > +only devicetree and some arches do not have a reserved
>> > +address segment. Add "ffitbl" subnode to obtain ACPI RSDP
>> > +and SMBIOS entry.
>>
>> Since the conversation on this stuff all seems to be going absolutely
>> nowhere, the ACPI portion of this is intended for use on RISC-V in
>> violation of the RISC-V ACPI specs. It also goes against the
>> requirements of the platform spec. Quoting from [1]:
>>
>> | > Just so we're all on the same page, I just now asked Mark Himelstein
>> | > of RISC-V International if there is anything in RISC-V standards tha=
t
>> | > requires UEFI, and the answer is a solid "no."
>> |
>> | Huh? Firstly, running off to invoke RVI is not productive - they don't
>> | maintain the various operating system kernels etc.
>> | Secondly, that does not seem to be true. The platform spec mandates UE=
FI
>> | for the OS-A server platform, alongside ACPI:
>> | https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform=
-spec.adoc#32-boot-process
>> | and the OS-A embedded platform needs to comply with EBBR & use DT:
>> | https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform=
-spec.adoc#32-boot-process
>> |
>> | EBBR does say that systems must not provide both ACPI and DT to the OS
>> | loader, but I am far from an expert on these kind of things & am not
>> | sure where something like this where the DT "contains" ACPI would stan=
d.
>> |
>> | The RISC-V ACPI spec also says "UEFI firmware is mandatory to support
>> | ACPI":
>> | https://github.com/riscv-non-isa/riscv-acpi/blob/master/riscv-acpi-gui=
dance.adoc
>
>  UEFI firmware is mandatory to support ACPI and coreboot is an option to =
support ACPI as well. i think it works well for both, I don't think UEFI an=
d ACPI need to be binding together, each UEFI and ACPI also works well with=
 other solutions.

Thanks for shijian(Nill)'s suggestions.

Hi Conor,
Thank you very much for your valuable comments on this set of patch
codes, which are very helpful.

Judging from the current specifications, maybe yes, you can NACK, but
it's better not to rush to conclusions.
The so-called specifications represent the ideas of FFI opponents.
What we have to do is to discuss with them and get an effective
consensus, so as to achieve the purpose of updating the specification.

>>
>>
>>
>> NAKed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Cheers,
>> Conor.
>>
>> [1] - https://lore.kernel.org/linux-riscv/20230707-attach-conjuror-306d9=
67347ce@wendy/

Thanks,
Yunhui
