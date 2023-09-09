Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B6C799BF4
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjIIWkk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjIIWkk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 18:40:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360A19E
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 15:40:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so4168319a12.0
        for <linux-acpi@vger.kernel.org>; Sat, 09 Sep 2023 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694299234; x=1694904034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH/+pshZkTpZv3Y+FJdhNHQVmmCQFNeFe7HWpElLmzU=;
        b=nVRUAXc1Tl4G3o2d+Aue8ZeCVVUMIzAB3IN+/AqiY+UBdtk/GY+3QiccsluytsLDCR
         nL93cYVaSU6G8aV7W7sN8mmaKhUYATAtEKWdfxAHP6kCad0HwxM1xpHC+NKmXRSkxPJc
         2Nhe+Ja0DTey6aH5C926mQ3t3JPNIUT6UZnd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694299234; x=1694904034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH/+pshZkTpZv3Y+FJdhNHQVmmCQFNeFe7HWpElLmzU=;
        b=oBUE5yH0Z/4yiLVAdnlvnWOi3WAQoxN3/7ZNLFkiUwY7DkDAK6+o6V91nHhGLyZi1b
         j67vs0m9X6v0rHi//kfgJda4vf4PokJCSf6zcjc7aJCLJHeaKHlSFv5TmYn9ExAc9xsg
         /BdWNVkqQ0LHTIzKus+t5UIC7hiTGpkiAnD1f10qeT7N5tWwHudLRA3nv7waF035BKuk
         ezCA+0g4rVjrpOTI8Dtfzix7GMEnDBN2RQfKn/kPX3kSNOOkuVP4zYH1NqRONnkJ0xlc
         YfzhXNsKjXHWOvrGiZvFiGl0zGBiU9Mlm1PiBB3JG+g4iFhT6uJVpvD7byq+bibb5kAK
         ojWQ==
X-Gm-Message-State: AOJu0YyPw7nKIuqBKxcvoMmsHM1GheqROmrV1off0YE6s/5hVi4jZQcf
        9Bf1EGG2JyGJpX07oOPEonAPePExzwOM3GoOQ+0IjA==
X-Google-Smtp-Source: AGHT+IFrWRpLbl5VBDOHv1Jgv+ESvlzO8fGQiu6W79llnlicsuRBSroLYNnBj0sNU7nbGU/xUQ4DSmg87aO838h2YZM=
X-Received: by 2002:aa7:ce05:0:b0:523:3853:e01a with SMTP id
 d5-20020aa7ce05000000b005233853e01amr4473909edv.36.1694299234153; Sat, 09 Sep
 2023 15:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org> <20230907214012.74978-2-sjg@chromium.org>
 <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Sat, 9 Sep 2023 16:40:22 -0600
Message-ID: <CAPnjgZ1eE6s_07OAdNeWYEDVbPg-tz7S5jk15i0OJhHTrwBaMQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] schemas: memory: Add ECC properties
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>,
        Guo Dong <guo.dong@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-acpi@vger.kernel.org,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rob,

On Fri, 8 Sept 2023 at 05:46, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Some memories provide ECC detection and/or correction. For software whi=
ch
> > wants to check memory, it is helpful to see which regions provide this
> > feature.
> >
> > Add this as a property of the /memory nodes, since it presumably follow=
s
> > the hardware-level memory system.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Use a number of bits instead of a string property
> > - Fix inidcates typo
> >
> > Changes in v5:
> > - Redo to make this property specific to ECC
> > - Provide properties both for detection and correction
> >
> > Changes in v3:
> > - Add new patch to update the /memory nodes
> >
> >  dtschema/schemas/memory.yaml | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yam=
l
> > index 1d74410..1a48b1c 100644
> > --- a/dtschema/schemas/memory.yaml
> > +++ b/dtschema/schemas/memory.yaml
> > @@ -31,10 +31,21 @@ patternProperties:
> >
> >        numa-node-id:
> >          $ref: types.yaml#/definitions/uint32
> > -        description:
> > +        description: |
>
> Why? '|' is not needed for any of these.
>
> >            For the purpose of identification, each NUMA node is associa=
ted with
> >            a unique token known as a node id.
> > -
>
> blank line between properties.
>
> I can fix these up when applying.

OK thank you.

>
> > +      ecc-detection-bits:
> > +        default: 0
> > +        description: |
> > +          If present, this indicates the number of bits of memory erro=
r which
> > +          can be detected and reported by the Error-Correction Code (E=
CC) memory
> > +          subsystem (typically 0, 1 or 2).
> > +      ecc-correction-bits:
> > +        default: 0
> > +        description: |
> > +          If present, this indicates the number of bits of memory erro=
r which
> > +          can be corrected by the Error-Correction Code (ECC) memory s=
ubsystem
> > +          (typically 0, 1 or 2).
> >
> >      required:
> >        - device_type
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

Regards,
Simon
