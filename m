Return-Path: <linux-acpi+bounces-401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A879F7B728D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 556B12811C6
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5AC3D960
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71D3CCF9;
	Tue,  3 Oct 2023 19:26:41 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB99E;
	Tue,  3 Oct 2023 12:26:40 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bf106fb6a0so173618a34.0;
        Tue, 03 Oct 2023 12:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361199; x=1696965999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cJJaH8b1u/qRRvI+ZMuh5sNNJkEekWhJ7wzLow6kXk=;
        b=ZFPRMPrB8+qDVzbzhwEBGjEIUOWMCenk8XTwxlCmlaftP9pE7JwZUDPeY7nZFh1nB1
         igCPPQYVSA6w36g3JBawoHXiFBoyY8RlguqMOExb8haRN1h1WMy5Y+WSCxvPZMCyEbfW
         SKnybNnUHDwYToQMgyTAtJ692+tbjn7Gev4UL0yphhOGz5BcQjPmcIBMrBf0F7GcY0Dx
         M0bgJlddsG2OtAXgDKGvM/4iXJVCcvfB0oID37CddN+naSoHgoWJ57nrkWdQafKXBfyU
         Qs71nEDkPOt+iI2LJQ6pNxfxqAeBx1Zm6MNIjb1SjNDgPeWVcfUqae8p3rYOTmodA19g
         BFSQ==
X-Gm-Message-State: AOJu0YzmlQLx8G2XGQAVN5gRuvA4axVH/+nhJu8WWKh6REZEso8M+JPt
	ETMkxNFbuO8yAnSRTu2E3eVq4AUNAuNys1fzjSU=
X-Google-Smtp-Source: AGHT+IFjyx71PMx2N+wDN30hM/HJ7/ySds49msMYXwi2gb67HIgd8KqAVePwVPPg5Hs9izeUDwaaWPBxodNT4q5lk78=
X-Received: by 2002:a05:6808:3008:b0:3ad:af12:2fe0 with SMTP id
 ay8-20020a056808300800b003adaf122fe0mr491609oib.3.1696361199765; Tue, 03 Oct
 2023 12:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175315.work.877-kees@kernel.org> <728fc315-4761-f56c-cd06-9c907a53b46c@embeddedor.com>
In-Reply-To: <728fc315-4761-f56c-cd06-9c907a53b46c@embeddedor.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 21:26:28 +0200
Message-ID: <CAJZ5v0haZmhJ6OLNiJHuxLaYRrBschL4Cm7H6acFmGb0Et5_MQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Annotate struct prm_module_info with __counted_by
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
Cc: linux-acpi@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 11:41=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 9/22/23 11:53, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-famil=
y
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct prm_module_inf=
o.
> >
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied as 6.7 material, thanks!

> > ---
> >   drivers/acpi/prmt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index 7020584096bf..c78453c74ef5 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -69,7 +69,7 @@ struct prm_module_info {
> >       bool updatable;
> >
> >       struct list_head module_list;
> > -     struct prm_handler_info handlers[];
> > +     struct prm_handler_info handlers[] __counted_by(handler_count);
> >   };
> >
> >   static u64 efi_pa_va_lookup(u64 pa)

