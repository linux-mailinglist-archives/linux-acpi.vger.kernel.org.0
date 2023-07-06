Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5917495F3
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGFGzy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 02:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGFGzx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 02:55:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F9E54
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 23:55:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so347105e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2023 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688626525; x=1691218525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIWuZ4QjmJeFmnk76baX9ZdxXV9vrusq9Mf9jFE8ve0=;
        b=aHYGgcWXcjnUyBoSgqcUlmMYoz6SVQE+Zc2KoE5+MR8W87NF2VYIRITvNq0nXK8Zw5
         IHre5XvZi6OeQT5Zk/aUVx75x2M/ViPm6MEz7BZ34h3Rwu/hiz5ziJBXHQdD0XGXEo/K
         LcSwWb5k5AA1ggnyZm/RDdE0sZBHKIR9y/pLt+72wWl84x/RAXTY6B7zKoO7eFaL+XaE
         f6GARDNNCN4JRti2n5Byl1EcJEETKRrnoa/0ul7SDO00jjCMChHyhHCXGVNwJBKwqIci
         bPMOszxdkVdpt8bmZWktV+vQCdueiYGr1jtAeeY+wPialubWoXssS7qaFSoE3k23Np6R
         qxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688626525; x=1691218525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIWuZ4QjmJeFmnk76baX9ZdxXV9vrusq9Mf9jFE8ve0=;
        b=XYWlVWoCWBzkNqniqUHIja4AS9Rd+R4z6XxlcfVTfSixh6zSkY+kR25gwgwfD3/gxD
         0uv2fhtBz33n/okn77TZb59N3QjB98UWVmiQrfkSmbFeKsAVmsONroSH0LmhDNyt9vM7
         2/gwWu5GCCXk05rPmjxaH2nOdBxqB0Xpetx9rNWionv8qrr+uukvMD8mhma8dRKFjn+e
         3OTZ1MztoElAVzV8uFz8/rh8h/EeCuJ2n39f4nRF3Pa7AG/Nd0ts0yfJaFxI6Y7kG2QV
         SadiNUbKpdi+5xD04DoOrmV7BwD07ozD4XKIoYT4Qr0+JMR57c/O0jL1AhWVbA5N+3gr
         fdfw==
X-Gm-Message-State: ABy/qLYSjSssyBrmChdqE6RX0M7tWkzxBrzyiXhjlQL9lvYjMiybgM9p
        gBpuHZKhkwYuF/DG1nrCbUgi55SQBuexLeC4C6IiCQ==
X-Google-Smtp-Source: APBJJlGJYnknpmC9Qq3WbZ7UUCJ6LFuD0JCKZFeaAAuo/1MAE66QYPEZ54lv3/+/BUGQMF/UQxBgzxELpSIcGO6IS7Q=
X-Received: by 2002:a05:6512:2098:b0:4f9:5711:2eb6 with SMTP id
 t24-20020a056512209800b004f957112eb6mr693785lfr.28.1688626525145; Wed, 05 Jul
 2023 23:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <20230705114251.661-5-cuiyunhui@bytedance.com>
 <20230705-oblivious-unstuffed-8e028a5b243c@spud> <CAEEQ3wmG1OiE3GFqQp9SP+oKUbTfuTPx=rNGd-sjKsW7vv3bew@mail.gmail.com>
 <07f88065-b9ca-5233-4048-5e61e1cdbe0c@linaro.org> <CAEEQ3wmY3YrdBEZ_V0+rC-3zbMLRgnL3xt-RtwzPxev5P2h48g@mail.gmail.com>
 <df87a707-ed17-0629-308a-d9435ebd3227@linaro.org>
In-Reply-To: <df87a707-ed17-0629-308a-d9435ebd3227@linaro.org>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 6 Jul 2023 14:55:14 +0800
Message-ID: <CAEEQ3wnbKHkoTUcd4n9mKF4c4bxqU23uMTexeSTY9d=owLgtEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 4/4] dt-bindings: firmware: Document
 ffitbl binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sunilvl@ventanamicro.com,
        ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Krzysztof,


On Thu, Jul 6, 2023 at 2:41=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/07/2023 08:24, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> > Hi Krzysztof,
> >
> > On Thu, Jul 6, 2023 at 2:01=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 06/07/2023 05:43, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> >>> Hi Conor,
> >>>
> >>> Added dts Maintainers,
> >>>
> >>> On Wed, Jul 5, 2023 at 11:07=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> >>>>
> >>>> Hey,
> >>>>
> >>>> On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
> >>>>> Add the description for ffitbl subnode.
> >>>>>
> >>>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++=
++++
> >>>>>  MAINTAINERS                                   |  1 +
> >>>>>  2 files changed, 28 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/firmware/ffit=
bl.txt
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt =
b/Documentation/devicetree/bindings/firmware/ffitbl.txt
> >>>>> new file mode 100644
> >>>>> index 000000000000..c42368626199
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
> >>>>
> >>>> Firstly, new dt-bindings need to be done in yaml, not in text form.
> >>>> Secondly, you didn't re-run get_maintainer.pl after adding this bind=
ing,
> >>>> so you have not CCed any of the other dt-binding maintainers nor the
> >>>> devicetree mailing list.
> >>>
> >>> Re-run get_maintainer.pl and added maintainers into the maillist.
> >>
> >>
> >> This does not work like this.
> >>
> >> Please use scripts/get_maintainers.pl to get a list of necessary peopl=
e
> >> and lists to CC.  It might happen, that command when run on an older
> >> kernel, gives you outdated entries.  Therefore please be sure you base
> >> your patches on recent Linux kernel.
> >>
> >> You missed at least DT list (maybe more), so this won't be tested by o=
ur
> >> tools. Performing review on untested code might be a waste of time, th=
us
> >> I will skip this patch entirely till you follow the process allowing t=
he
> >> patch to be tested.
> >>
> >> Please kindly resend and include all necessary To/Cc entries.
> >
> > This set of patches is applied on the tag next-20230706, and to
> > generate the mail list by scripts/get_maintainers.pl on the tag
> >
> > ./scripts/get_maintainer.pl
> > ../riscv/linux/v3-0004-dt-bindings-firmware-Document-ffitbl-binding.pat=
ch
> > Yunhui Cui cuiyunhui@bytedance.com (maintainer:FDT FIRMWARE INTERFACE (=
FFI))
> > Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS)
> > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> > Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS)
> > devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS)
> > linux-kernel@vger.kernel.org (open list)
> >
> > What am I missing ?
>
> I did not receive the original patch. Neither did Patchwork. You cannot
> just reply to some comment and hope it will fix something. We don't have
> this patch simply.

Oh, I see, you only received the middle mail, and did not receive the patch=
.
Okay, I'll post it after the next version is updated.

>
> Best regards,
> Krzysztof
>

Thanks,
Yunhui
