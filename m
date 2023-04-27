Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70D6EFFE4
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Apr 2023 05:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbjD0Dil (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Apr 2023 23:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbjD0Di3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2023 23:38:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255C3C00
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2023 20:38:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f6401ce8f8so4944916f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2023 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682566684; x=1685158684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/XooUh+csvdWa3vzofKpL2GRkQ1QHE5UdXL59bbqA0=;
        b=YnQSFS3w1ji+/2ubD0VP59khVu1Wna+t+VTMi0UCGviJuEVO+2nLZGd+IksVJTlHMr
         0fStq9Mze4eXwc3k32nIXhZ4FNDF6FX1WYQFvGqKQ7haYiU5RavTxeq20vuvxH2PaXd2
         XdEk23f2TSJoRLV/yFvRms+DWbjGbonWThAVSMrml8yjlz+0OBAjEaG+UYwbyLScFGoY
         mBL8uwk0tk1VoGwTFYOnGINVvBWyMnkxvi6NFY8q1qL6JLHL6WoU7e1BGT36KDf7wCH8
         GulXbKEsUflh4f7xhEbWgtKMrAgcJ1IAgFGnTaik3EnBF3xYXLlupUNMOUm+w0O7lHi0
         58Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682566684; x=1685158684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/XooUh+csvdWa3vzofKpL2GRkQ1QHE5UdXL59bbqA0=;
        b=bLMJaL8vPLfY1hieOyivZnWrrpAJ3r3u4Fh9vuUVzD9wyZsI38IaLYeYhQ1cmvB23e
         vy920cG86PS7AJdXrCXLQK1Qo5clRhYH6EByGlXopxysPF3/CrUrL48QvBApIXu1jHyC
         M0Ot1SpYsM4qfWfHESzaaU18hlMC7IU4GqPCiesRQjYPbiCH1wrexexiSBA9AS46CVBY
         GdXe9FIOZpHPs1Nk/e3dtTs1WAU91ql5DOOsKlVoGUxs1D8cfa6WQk8S2Eqgp/3TjUda
         e8HvHERBoYHK+pSHoNsR0zMjmJldXDYk6XrSb5M8+SX0wNhfVKGqqgRmpwJtpw5F7768
         Vvcg==
X-Gm-Message-State: AC+VfDwY0J00AfkiT+5F1tfEEA8iHgO2+MhU7t0hWZaFyqq69zO5FYiY
        CKg2bDZYjc59vAln1ko9wVWuyfeC0rn0hZGE/BZ8iA==
X-Google-Smtp-Source: ACHHUZ5FNgCvbijAsEyvrrjP4F8fqmPrGV/LNA6QDjO9UUnOYuobRnUeaHaHRl+iI82rI/BQ5RYaCgS6KQXRjWzRso8=
X-Received: by 2002:adf:f24e:0:b0:2fb:283a:1754 with SMTP id
 b14-20020adff24e000000b002fb283a1754mr75781wrp.32.1682566684270; Wed, 26 Apr
 2023 20:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com> <ZEj33QLZqEeL+/y4@FVFF77S0Q05N>
In-Reply-To: <ZEj33QLZqEeL+/y4@FVFF77S0Q05N>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 27 Apr 2023 11:37:46 +0800
Message-ID: <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rminnich@gmail.com
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

Hi Mark,

On Wed, Apr 26, 2023 at 6:07=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Ard's point is that the device tree doesn't have all the same information=
 (e.g.
> nothing in DT describes the memory type attributes), and so this isn't
> sufficient.

The device tree only needs to complete the parse of the memory type attribu=
tes,
it should not be very complicated.

>
> We'd have to create entirely new ways to pass that information, which is =
not
> very desirable.
>

>
> Can you extend coreboot to provide EFI services, or to chain-load an EFI
> payload?

Currently, coreboot does not support UEFI, and it may not support it
in the future.
Hi rminnich, what do you think?

Thanks,
Yunhui
