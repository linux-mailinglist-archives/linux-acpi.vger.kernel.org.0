Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6E73D91B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jun 2023 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFZIFi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Jun 2023 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFZIFh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2023 04:05:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C8126
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jun 2023 01:05:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31272fcedf6so2570842f8f.2
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jun 2023 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687766715; x=1690358715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRzmdoMOtwkf0T97YbD2JaDd570KRK5k9OjuvNurjw8=;
        b=XeB3HoE8oMKBsezzW5LgcB9DcBXwyNp3TCTl63jec1OkUmWQoPRDnM8T8j5tk2EODK
         eAIftr0uWaFzQ5LZWXCpMPe2pmJ8E6VRQHvEofQScu9rtyUSmhSurvndmJ3Gn0/ULHA9
         1540fICw2DmnEMWkdl5jZe/h8lya1AZF4IxTd+gajLlzIe8MHlPevohJ72v3MqB3Su/Y
         C8GSzDfLFPwPMp06mlq71dM9h/K72L5Mem1dOeZ2Los3FRw3+cRM2ALCs3JY8IYChqmC
         HhHrHc1z0jTNj8PBMXLYdNldipHV7Yr2L/0CJvbIysheBhr3NoaAzsKC0UbW2+VANiJa
         qMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687766715; x=1690358715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRzmdoMOtwkf0T97YbD2JaDd570KRK5k9OjuvNurjw8=;
        b=VVDO9P3JyYkGl5UVHCkNAPtoiMlp3tXjbxXYRk7TyA1tha5nxs4r2FYdCsezhJhttE
         5q6FXAKEqdRnNgnnG7DpbotBqioxwf2JnVvfscLr8wllVSR50QldDFGqIxPU3yBxj0of
         JL9rZTQqlzMUseZEAtiRKleOUigAgVhDfM95wLQ4vQoBrfvbJ3KLnC5Si7STSuiGAdmP
         hYb6UU87mbBK0NSA18L/iYO23BikVxZ7wRXTTR19NvaROxl1jedjH+gDmh9wt7HqM28d
         edHTUfzJQHJ0FR+9LfblVLGNWG+cifSLU9k350O14gag1/oKyV2DlYDbEExXz2AVI+F8
         PdWg==
X-Gm-Message-State: AC+VfDwYY35gkkKz/F1rs4JP9HXRPCcbvzE5lcgYPM3O+kuASNjpIFdl
        a9C3FclS9niOJEXDdeABo17PxV/C73Wv26lQVTl1Ag==
X-Google-Smtp-Source: ACHHUZ6srR5n1hfE/ujkiDx2OVuKCraquwPXnR8VYkKk9WgEeorrj44802tRcCvvefKDWYtGcXR2XxP3ak5xsTpC1mk=
X-Received: by 2002:a5d:674b:0:b0:313:ebbf:3696 with SMTP id
 l11-20020a5d674b000000b00313ebbf3696mr2389037wrw.46.1687766715552; Mon, 26
 Jun 2023 01:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
 <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
 <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com> <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
In-Reply-To: <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 26 Jun 2023 16:05:04 +0800
Message-ID: <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
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

Hi Ard,

On Mon, Jun 26, 2023 at 2:43=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> I think all of this belongs under arch/riscv

Could you look at the content of the patch again? As we discussed
before, we need to connect to the ACPI and the SMBIOS entry
At least this part of the code has to be placed in the corresponding place:
drivers/acpi/osl.c: acpi_os_get_root_pointer()
drivers/firmware/dmi_scan.c:dmi_scan_machine()

Because obtaining firmware information through DTS belongs to the
content of the driver firmware, it is appropriate to put this piece of
code in drivers/firmware/ffi.c.

So I insist on the current revision, what do you think?

Thanks,
Yunhui
