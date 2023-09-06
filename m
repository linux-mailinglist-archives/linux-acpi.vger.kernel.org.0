Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E195793F6A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Sep 2023 16:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjIFOsq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Sep 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241996AbjIFOsn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2023 10:48:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E41989
        for <linux-acpi@vger.kernel.org>; Wed,  6 Sep 2023 07:48:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so225598366b.1
        for <linux-acpi@vger.kernel.org>; Wed, 06 Sep 2023 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694011712; x=1694616512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM31Omv2VF1wbkMub+dDYlOZRCfHD1+o+lV3RVrjZoc=;
        b=GGBWcBMmyAVjbwKOSqmOjtk9iNRrcS11SzgeeIT6wBqAckCOBB+oyF0oU0hwkMDqXT
         lFfKEmWF0aOI/DccPx927CzmcY5r6Ph2Sn2CgZacCi/f3Na0hYoWnQCP43Dh4unxSWPZ
         ZvXqzeSq2lgyCUwYIAa/C5BBwC+JOpgXnW9v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694011712; x=1694616512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM31Omv2VF1wbkMub+dDYlOZRCfHD1+o+lV3RVrjZoc=;
        b=ahGW/7/EO+SAby1xdudx+TMsHHMNIRCsaiXy1wD5sZWgi6bJMhAPoDxCiFdSjQiqwT
         sIm6vltcCz/O1bVtupIlqgUf9mm16pYZyIywa28h4G+BNWR62jYtE8oTlyyCcVInkl/N
         BjW/O5gEqyn7nLmMXta5AiNZX7fX2JXm+gsgKxNwYhprdDEUkzxnofdKYwf9HiSHFp6e
         oZ1yC3Ek8Jnx84e3qDi7nqJmEPrptQuMpNTiKeRjf2phio1nLhcvjlntGXCEyEFTDv9S
         xhKiLZDE0lFWe7cHP5HBXYrSWN+6MlEyxcOqhmZ06eWMxbqv7q9GkqLtSMCbpstWbbe8
         KOqQ==
X-Gm-Message-State: AOJu0Yx/pgkIrEW3WW3+K8Fk8IGT/UxUpKxGzWiR97kNYnwYfvWdYSOf
        H9zm3B8366aqKA4j5jP0Pf79ZXizpSdJqCXMJnrWig==
X-Google-Smtp-Source: AGHT+IHNMWaasVkgp44pFNPVHkyJontSd/vvGQZX5Wxd2x9pX7I8Zx1MV/UPgxQHR/mIRxbiRhQ5295jv/BnGFJcWSk=
X-Received: by 2002:a17:906:9754:b0:9a5:9b93:d60d with SMTP id
 o20-20020a170906975400b009a59b93d60dmr3084119ejy.36.1694011712458; Wed, 06
 Sep 2023 07:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org> <20230829191812.135759-4-sjg@chromium.org>
 <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com> <CAMWxwJ13-itCyyKaH21nncaX2OUesGwpfMNHocvDEKHzZ1_F4Q@mail.gmail.com>
In-Reply-To: <CAMWxwJ13-itCyyKaH21nncaX2OUesGwpfMNHocvDEKHzZ1_F4Q@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 6 Sep 2023 08:48:16 -0600
Message-ID: <CAPnjgZ2NacjTmMB4fUL+ttAmMvn+3oJS8fA+Lu94zgMOt4rKCw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] memory: Add ECC property
To:     Lean Sheng Tan <sheng.tan@9elements.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gua Guo <gua.guo@intel.com>, Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        ron minnich <rminnich@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Guo Dong <guo.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sheng,

On Wed, 6 Sept 2023 at 08:47, Lean Sheng Tan <sheng.tan@9elements.com> wrot=
e:
>
> Hi Rob,
> Sorry for missing this:
> regarding your question on whether if the memory can support both single-=
bit and multi-bit ECC, i think the answer is yes.
> @Dong, Guo or @Chiu, Chasel could you help to confirm on this?

I sent a v5 series which breaks these out into separate properties.

Regards,
Simon

>
> Thanks.
>
> Best Regards,
> Lean Sheng Tan
>
>
>
> 9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
> Email: sheng.tan@9elements.com
> Phone: +49 234 68 94 188
> Mobile: +49 176 76 113842
>
> Registered office: Bochum
> Commercial register: Amtsgericht Bochum, HRB 17519
> Management: Sebastian German, Eray Bazaar
>
> Data protection information according to Art. 13 GDPR
>
>
> On Tue, 29 Aug 2023 at 23:38, Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Aug 29, 2023 at 2:18=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
>> >
>> > Some memories provides ECC correction. For software which wants to che=
ck
>> > memory, it is helpful to see which regions provide this feature.
>> >
>> > Add this as a property of the /memory nodes, since it presumably follo=
ws
>> > the hardware-level memory system.
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > ---
>> >
>> > (no changes since v3)
>> >
>> > Changes in v3:
>> > - Add new patch to update the /memory nodes
>> >
>> >  dtschema/schemas/memory.yaml | 9 ++++++++-
>> >  1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.ya=
ml
>> > index 1d74410..981af04 100644
>> > --- a/dtschema/schemas/memory.yaml
>> > +++ b/dtschema/schemas/memory.yaml
>> > @@ -34,7 +34,14 @@ patternProperties:
>> >          description:
>> >            For the purpose of identification, each NUMA node is associ=
ated with
>> >            a unique token known as a node id.
>> > -
>> > +      attr:
>>
>> Kind of vague.
>>
>> > +        $ref: /schemas/types.yaml#/definitions/string-array
>> > +        description: |
>> > +          Attributes possessed by this memory region:
>> > +
>> > +            "single-bit-ecc" - supports single-bit ECC
>> > +            "multi-bit-ecc" - supports multiple-bit ECC
>>
>> "supports" means corrects or reports? Most h/w supports both, but only
>> reports multi-bit errors.
>>
>> > +            "no-ecc" - non-ECC memory
>>
>> Don't define values in free form text.
>>
>> This form is difficult to validate especially when non-ECC related
>> attr's are added to the mix as we can't really define which
>> combinations are valid. For example how do we prevent:
>>
>> attr =3D "single-bit-ecc", "multi-bit-ecc";
>>
>> Or maybe that's valid? If so, how would we express that?
>>
>> Why do we need "no-ecc"? Is that the same as no "attr" property?
>>
>> I think it's better if we have 'ecc-type' or something? Or generally,
>> a property per class/type of attribute.
>>
>> Rob
