Return-Path: <linux-acpi+bounces-857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F77D4119
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F65281443
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79023753
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53241B26D
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 20:09:37 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7712F9;
	Mon, 23 Oct 2023 13:09:36 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57de3096e25so325511eaf.1;
        Mon, 23 Oct 2023 13:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698091776; x=1698696576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBRQn/+2CoCnRG/UpsIRpdz1Uxer0EBXhtYg8c4HrP8=;
        b=F+8EPtuKJhSXVT9MmCijhEFG4yMGPV1ARLDfhI/l8H1gnrPrTvDkiyd3LycBMvnCfa
         an4nAgSp+R9JAAdujvSvVjXAOePzdgZrUHHP6ytdkbkoY+JrXhHhpoXEVM5Ai/eAHkfX
         ZQen0K+jpfV85aTmGncaOFha0JSEjqSgAp2YKVgrZe1hZEEp5hKGbU8asloQIjnuPCPa
         UbdZXPDMoHn7XJuERK8nwXi2L2m5uwwTTOdJogTrxHFzopIXtgsilEg9oz7jSfmzP78A
         UlBwFVtr9h/SoAoCj1luVM2jlz2tNdS8AI37qdUgUlLbD5DE01kKMIlLIpJFLAYND7gh
         CLoQ==
X-Gm-Message-State: AOJu0Yy3q/qrlDQrSiJWna1JMAgWAhips231IrVjqXux4a/JB9tGfXxE
	5PXXCrMXVMbOkVMKxVhWpGOTPsnlqqFZxtlTUzvnI26p
X-Google-Smtp-Source: AGHT+IGoqvQxwQn+qvVRNOgCRCySjLvm7UySkMEB0RQE4CLReVM7ZkEekFHMAZs1YAuLbjHJQCbuu6gpb0jhlXEaAsE=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr10230228oov.0.1698091775886;
 Mon, 23 Oct 2023 13:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Oct 2023 22:09:24 +0200
Message-ID: <CAJZ5v0h9mfQoiok6URGaw7OHjHCFxPWDxiP68NGe9Ow-8PY0jA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: sysfs: Fix some issues in create_of_modalias()
 and create_pnp_modalias()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 7:32=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> All issues have been introduced by the same commit, 8765c5ba1949 ("ACPI
> / scan: Rework modalias creation when "compatible" is present")
>
> The first 2 patches fixe some issues related to string truncation checks
> and to computation of the available space in the output buffer.
>
> The 2 others are just some clean-ups.
>
> Christophe JAILLET (4):
>   ACPI: sysfs: Fix the check for a potential string truncation
>   ACPI: sysfs: Fix a potential out-of-bound write in
>     create_of_modalias()
>   ACPI: sysfs: Remove some useless trailing NULL writes
>   ACPI: sysfs: Remove some dead code
>
>  drivers/acpi/device_sysfs.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> --

Thanks for the fixes!

I would combine patch [1/4] with patch [2/4] and patch [3/4] with
patch [4/4], though.

If that's OK, I can do that while applying the patches.

