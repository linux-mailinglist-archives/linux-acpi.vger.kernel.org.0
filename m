Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072D074958C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGFGZ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 02:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGFGZ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 02:25:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D740A10F2
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 23:24:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3141c3a7547so241246f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2023 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688624697; x=1691216697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmK8JROVVa8cXcfoU1tcKioXbFqka5rqn6GwgjmSHzI=;
        b=BZUStLrjb+CVfu9O0PBQXLZAWwmRpugb4UPi1jETsjk79i+UQ4NMv5cPq8nvfTOXDO
         SrGzIJKb4jgvGH2BQDJCtEOyw/0C1g0DyXVcdSzimIohzJs0zItofWOP8YAolVFramCv
         zPe4N4DVF1FMTCY9uYfd9BwJNU8bgHN1QtC9/SwBXonThR5IJ6qggggwcLBRq3mBMlv0
         TA3fFn11ADRWeF+kFhSs9xxI4BgUUN+cI0YiCkyrmF67m+Tw95EWYldY2dY9XA5M7wdb
         yoJu/Z0Hg5V850H9FEhUVQK5V6B3oc8CqL6W9367cmGqWwMT9Bg7SFgvRgSF7NOKp1Kt
         4g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688624697; x=1691216697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmK8JROVVa8cXcfoU1tcKioXbFqka5rqn6GwgjmSHzI=;
        b=WrlZXtVcUEZpEsY2I/TOiQBXnWQDcUHEadWi4bn9qM0Gg9j/ELqurve5HhH1VxNkrE
         FR4vJN1HYE7444tlQVSsQF/7WtqHkR9HDsGVBs2ZX3dpDAI/vidIFEa6l/lucrRqhRpu
         iVdveZb0aA5eopokcJFM/LW6qLVx0E5YVGYqeD/Nijd0mTTrr58PhP0eIiQMG8mpuMxH
         1xLjWHVAr7ZcAgixIn36XXhzy2EfqHeNZUvPL0e4EpVCYKHs7mxQoJE9eR67Ya6LW7l5
         cjS/easTc0YroIYurP9TA7AYmjuNKXhRljsTk9iLC503/tPUorGd+AypDTQGzUMccwYU
         ikZQ==
X-Gm-Message-State: ABy/qLa+hfzAF7pY5ABiPwdkSlG1tfmi5HvnKqHkZG3g9ceFTE6X1C+Z
        7g8CnrlnW+acnN/NgFUjgATtmQR9gx1iL8DZH5LV5w==
X-Google-Smtp-Source: APBJJlGCbQSscD3J4zU2LybpPeyh6sErh2NjQ91rqSP1OSDL0YqnkrhTZH9VgepEXOd6j7o74TW2PpGZhj2mjamraqE=
X-Received: by 2002:a5d:568f:0:b0:314:5376:f0d6 with SMTP id
 f15-20020a5d568f000000b003145376f0d6mr367792wrv.52.1688624697342; Wed, 05 Jul
 2023 23:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <20230705114251.661-5-cuiyunhui@bytedance.com>
 <20230705-oblivious-unstuffed-8e028a5b243c@spud> <CAEEQ3wmG1OiE3GFqQp9SP+oKUbTfuTPx=rNGd-sjKsW7vv3bew@mail.gmail.com>
 <07f88065-b9ca-5233-4048-5e61e1cdbe0c@linaro.org>
In-Reply-To: <07f88065-b9ca-5233-4048-5e61e1cdbe0c@linaro.org>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 6 Jul 2023 14:24:46 +0800
Message-ID: <CAEEQ3wmY3YrdBEZ_V0+rC-3zbMLRgnL3xt-RtwzPxev5P2h48g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Krzysztof,

On Thu, Jul 6, 2023 at 2:01=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/07/2023 05:43, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> > Hi Conor,
> >
> > Added dts Maintainers,
> >
> > On Wed, Jul 5, 2023 at 11:07=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> >>
> >> Hey,
> >>
> >> On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
> >>> Add the description for ffitbl subnode.
> >>>
> >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>> ---
> >>>  .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++++=
++
> >>>  MAINTAINERS                                   |  1 +
> >>>  2 files changed, 28 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl=
.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt b/=
Documentation/devicetree/bindings/firmware/ffitbl.txt
> >>> new file mode 100644
> >>> index 000000000000..c42368626199
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
> >>
> >> Firstly, new dt-bindings need to be done in yaml, not in text form.
> >> Secondly, you didn't re-run get_maintainer.pl after adding this bindin=
g,
> >> so you have not CCed any of the other dt-binding maintainers nor the
> >> devicetree mailing list.
> >
> > Re-run get_maintainer.pl and added maintainers into the maillist.
>
>
> This does not work like this.
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You missed at least DT list (maybe more), so this won't be tested by our
> tools. Performing review on untested code might be a waste of time, thus
> I will skip this patch entirely till you follow the process allowing the
> patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.

This set of patches is applied on the tag next-20230706, and to
generate the mail list by scripts/get_maintainers.pl on the tag

./scripts/get_maintainer.pl
../riscv/linux/v3-0004-dt-bindings-firmware-Document-ffitbl-binding.patch
Yunhui Cui cuiyunhui@bytedance.com (maintainer:FDT FIRMWARE INTERFACE (FFI)=
)
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
(maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

What am I missing ?


> > emm.. There is some *txt in
> > Documentation/devicetree/bindings/firmware/, isn't it?
>
> And what about it? Do you claim they were added recently?
>
> Best regards,
> Krzysztof
>

Thanks,
Yunhui
