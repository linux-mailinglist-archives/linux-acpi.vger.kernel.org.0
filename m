Return-Path: <linux-acpi+bounces-820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E798D7D15E2
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF63B2132E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5922230F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08F1DA22;
	Fri, 20 Oct 2023 17:49:35 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A0D71;
	Fri, 20 Oct 2023 10:49:33 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57de3096e25so98332eaf.1;
        Fri, 20 Oct 2023 10:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824173; x=1698428973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djo7Gv3TAmGl0r7mxIaBCLdombc4a5LIQixNSwzrvLk=;
        b=F1kZc6JGYhYVxrh/IvSP4teU5mqTOu5dyn8P7QBx+RcY0Ydkt8M+ZjBoSupsF2lHvk
         7yMa9csaKY3/d7oVCMTkqOCgC2JIyYRUGFoFgg9Ngn1Rewgkhga7Lv1sd84612X6NpuC
         kCzJWGzhVJDLsULjz77t/irLZx2QPl2/ruAIsilWZFEAWFbAJcui1F/C0Xc7yb3ew5YM
         uEq62Duh/rV1D/4TrJgFQKw3ORli4GjoCYCBnTNKBwaEPLQxAq101zurOm9fO2Gpyi5W
         XMmG7/Sx+eFR8P4oxwErqcdd1Fru0qQGK1YNWIv3VHy5LoNAH+wJCOMvGR1HelFH9sGq
         Nv7A==
X-Gm-Message-State: AOJu0YwL9MtAkQphXtlEAuvSZwVkr2c2XQX6EjjBsnR1VnLsgM//0I98
	uefIAbey6I0FKjgfu4XAh1gW5UrlfC2m8AqFpyU=
X-Google-Smtp-Source: AGHT+IGTGyayG5peke+8T5K+jl5x/DBCQp7C3sOAWMr2yvZBkwWCjWnPDSXMNQ118ALca7MWuxclzMDs9wTEULtm2Z4=
X-Received: by 2002:a4a:bd18:0:b0:581:e7b8:dd77 with SMTP id
 n24-20020a4abd18000000b00581e7b8dd77mr2986747oop.1.1697824173256; Fri, 20 Oct
 2023 10:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
 <202310191606.93920741B@keescook>
In-Reply-To: <202310191606.93920741B@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:49:22 +0200
Message-ID: <CAJZ5v0j5bk+RM3Tvixp5oX48EE_7hDoO5sd-Vrmwu=iz5kO7jQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: replace deprecated strncpy with strscpy
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:06=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Oct 19, 2023 at 10:47:58PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > We know dev->name should be NUL-terminated based on the presence of a
> > manual NUL-byte assignment.
> >
> > NUL-padding is not required as dev is already zero-allocated which
> > renders any further NUL-byte assignments redundant:
> > dev =3D pnp_alloc_dev(&pnpacpi_protocol, num, pnpid); --->
> >   dev =3D kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
> >
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding. This simplifies the code and makes
> > the intent/behavior more obvious.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Looks clean to me!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied as 6.7 material, thanks!

