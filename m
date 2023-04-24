Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9B6ED3A3
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Apr 2023 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDXRhA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjDXRgw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 13:36:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3278A24E
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2023 10:36:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so35396524a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2023 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682357793; x=1684949793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixBLe3NtbULr+G7HNCZvSVu77/ESFEdi1SlI0hk10s0=;
        b=Vop/A+ltDUrXNIDXCB1UYGC7Bmhv6UtKIIjeOO/eGUfPc00HIjgiBXwR7SyjfWMYHq
         dLPXjcwnO0S/SO2hgwgoTIRTdBUaxlrG3DO+acSE/o+kRsR75kh9r1KRQEMVg7oAS/jh
         s+oGQre943RTut1OQTAUAx3nJmEsPBWU255eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682357793; x=1684949793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixBLe3NtbULr+G7HNCZvSVu77/ESFEdi1SlI0hk10s0=;
        b=LJnBoXUqZFMivhqVONvE+L948XaoHWXJAVgF0W99ZUj2z9LXAbd8nbAqUSk0zyr9Ri
         oz8Lx79LVcuV1xd1FJkC4E90VA5NjUTFPjRSSjKtvmho7e2t2h5KWfNjaPRu84YQ84PB
         jl6y6gO+1cieVRL8PcEkh9CSErUwEjxUwv0nKUY9mOfCheHz50eWY8t4KYZVmMbqoNrw
         cH8hsm62owJxLnnm4cBZOVfg19kYWdpzeHjVkE6NRNxg42wAYI3naZI7R0xTEqp/QCfo
         VhOuPoEnknfLwKBCANATZZGYie2fmemB3CJUQCUBuwzQW2InxmmkFGifujehGA/foKE+
         1k0w==
X-Gm-Message-State: AAQBX9f2aQeblV7GiwDIdJu7LE8KeaNa9d2v2lVlrpT0U8vS157o1nbH
        wtaHJyvaTePx7taUVAu5ryNq6YQ/smEwLmx1CqMjqQ==
X-Google-Smtp-Source: AKy350YjKTaa624zkLdgaXxJJWkQZ/PDzmNkw2zjC+zFauLKUMo8uC52DKC0ujCIvTO7LHSmwS8lYg==
X-Received: by 2002:a17:907:a41:b0:959:c6cb:8546 with SMTP id be1-20020a1709070a4100b00959c6cb8546mr2320050ejc.28.1682357793468;
        Mon, 24 Apr 2023 10:36:33 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c30f000000b004af73333d6esm4833415edq.53.2023.04.24.10.36.32
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 10:36:32 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so35396246a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2023 10:36:32 -0700 (PDT)
X-Received: by 2002:a05:6402:d1:b0:506:c238:4067 with SMTP id
 i17-20020a05640200d100b00506c2384067mr13659251edu.8.1682357791917; Mon, 24
 Apr 2023 10:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221016182349.49308-1-masahiroy@kernel.org> <20230424162110.11082-1-lrh2000@pku.edu.cn>
 <CANiq72=Kb6ckhU8Ss9=Dg4Zn11Us+DLbKnNWAVaTb-nv7Y=ARA@mail.gmail.com>
In-Reply-To: <CANiq72=Kb6ckhU8Ss9=Dg4Zn11Us+DLbKnNWAVaTb-nv7Y=ARA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 10:36:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDAYoWVEPSn2cD5YMjPN+nNYbHw3t8_=UiRi5V7WKgaA@mail.gmail.com>
Message-ID: <CAHk-=whDAYoWVEPSn2cD5YMjPN+nNYbHw3t8_=UiRi5V7WKgaA@mail.gmail.com>
Subject: Re: [PATCH] scripts: Remove ICC-related dead code
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ruihan Li <lrh2000@pku.edu.cn>, masahiroy@kernel.org,
        arnd@arndb.de, bp@alien8.de, dave.hansen@linux.intel.com,
        devel@acpica.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mingo@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, rafael@kernel.org,
        robert.moore@intel.com, terrelln@fb.com, tglx@linutronix.de,
        trix@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 24, 2023 at 10:27=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

I took that patch before this email came in, so that reviewed-by will
be missing in the tree, I'm afraid.

                     Linus
