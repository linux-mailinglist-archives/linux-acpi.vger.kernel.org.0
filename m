Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86D56F10CA
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Apr 2023 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbjD1DSu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Apr 2023 23:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjD1DSm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2023 23:18:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D271FEC
        for <linux-acpi@vger.kernel.org>; Thu, 27 Apr 2023 20:18:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so65926605e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 27 Apr 2023 20:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682651895; x=1685243895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDCuPvcaDi9+iw8/KxLgNKP2gNwI8pEaXx9HTEyfXDQ=;
        b=gij0vRbjt5XZOxE1P0cS9+uvr6CgTr9hO1Jh1w9KYmM86w93KZOIW3jPF+uQAHE518
         OW0baTo8/QYMDG3vR3YS4Rabzy5wNuDTGsMQEOl+ng3i6BOwFms4IDZo4CGL/IT9NmuP
         2WYPSaFGFbXBYnyv6oo0BcNwoEi7O9G6QSUQvdMKpidv2eVeT+245DNysYjbg9p8nQQo
         BXurdBENm4TF4lsULnXG2BVDa/uMqxuEb7fr9VWq2wYA4Fumt8U0KHgigGVg6dm5GqM3
         pNHAscMRQXKH2caQtoEtd3Cdl3OjsI4UHQSX0q6u3F+E9HPtqmAK3dohOv4MVfE3Siql
         pDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682651895; x=1685243895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDCuPvcaDi9+iw8/KxLgNKP2gNwI8pEaXx9HTEyfXDQ=;
        b=cT/CL89UVfgDtp5FhgQ5vzUQzx6d1dg85ITsU8Dtt5iK0ZY1uAPmbbPWcl9dbM0jcY
         kVw12e+HoY8IQCU+kf5LzG4Ow0/xo0H+IzxRONflMsuceGevmM3qfyqVKJkJ1cjXOHIA
         143bIet+CpNi0I2uAYs8P5x6C1jaf5lfbjsb197knjCqBjzKqVQSAm+fdO0bzEzFrb09
         b1R0Y/6Dgk/KpzsSRD5hYBU5YyPKMvjjz4pJgBAn9wRBlPqXqPTD6TH/5I6gzkFkBcYM
         DJaI/2TvYq96vvzWxmvgAr3gZcg9Xbnxs9V9sT2caLdul1KD3vojtQwJR0yfIVSVbDb5
         g/eg==
X-Gm-Message-State: AC+VfDyG/z9R5SJiPDm66g9wQ1h23YklqwkP5JJ4EZh/rpfkvpuunLkw
        lLI/ZpYV8GoXl+QGuIBW9VJmJxhhCW2d5Ic+LMp01A==
X-Google-Smtp-Source: ACHHUZ5PU71pHgLp9qLdMakaUiK97hXIQqxMNfRbIqJEYL9LVLm5i6Bvy+iXklETlcPpdexefJ5NXYalGGSN9r8J33g=
X-Received: by 2002:adf:f5c2:0:b0:2c9:e585:84b0 with SMTP id
 k2-20020adff5c2000000b002c9e58584b0mr2751464wrp.1.1682651894858; Thu, 27 Apr
 2023 20:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <ZEpbTE4gcsf8meXc@FVFF77S0Q05N> <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
In-Reply-To: <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Fri, 28 Apr 2023 11:17:56 +0800
Message-ID: <CAEEQ3w=495snOz3UNBO4dpgyfZs3jQoRKo4QRAXXqR5-0j4SWA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        ron minnich <rminnich@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ard, Mark,

On Thu, Apr 27, 2023 at 8:52=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> and the only combination we do not support is ACPI without EFI, as
> ACPI on arm64 depends on the EFI memory map.
>
> What this patch seems to be proposing is a combination of all of
> these, i.e., doing a pseudo-EFI direct kernel boot where the EFI
> dependencies of ACPI are being fulfilled by ad-hoc descriptions passed
> in via DT.
>
> I am concerned that this will result in a maintenance burden for Linux
> with very little gain, so I feel we should not go down this road.

Judging from the current kernel, getting acpi smbios, memmap tables is
not just a way to have EFI, right?
smbios:SMBIOS_ENTRY_POINT_SCAN_START
acpi:CONFIG_ACPI_LEGACY_TABLES_LOOKUP
memmap: e820

Our current situation is that coreboot does not support EFI, but supports f=
dt,
but we need to support ACPI,  and riscv does not have a reserved
address segment
like x86 that can be used, so our current solution is to pass acpi and
other tables through fdt.

Based on this, do you have a better suggestion ?

Thanks=EF=BC=8C
Yunhui
