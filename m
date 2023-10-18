Return-Path: <linux-acpi+bounces-720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E537CDBD9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F42813F4
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDAC3588E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC118E30
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 10:59:42 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3550EA;
	Wed, 18 Oct 2023 03:59:40 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6c61dd1c229so1196938a34.0;
        Wed, 18 Oct 2023 03:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626780; x=1698231580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RxnS7co15+PdbAYZNmOdkHSp2nhCKu09GQRS7+mII8=;
        b=uEYoAeTu/+7XRHvqC1rgohHkZWMF8acMxDdw8pGxplTA3aV5QhJe9/LYFN53khuV99
         duetJyDdg81KK6SDQ9ApReumbJBvvVM+/vT1QkMfkJRw0REvXogwEzAo1YWYlusXeRmK
         AJQIhTCFWvRaTlfY6YHZAREvGk3SrxLLBDaMa3VN7QOgK4qSRlD6k1r1hwI6++OWLt8k
         C9Lqa2RCFNUdywmvg5pvaV0P8ZUwBdSJJVHfr5WhA8cfSaqYCHtDThsF8mut3lp9CPll
         GT38gGg3nvODPT+a9Pl/srsPvegYw0pb2rKp/yK/i2x+vWWiSt/DNCV5JUnnudz20jFD
         nq1w==
X-Gm-Message-State: AOJu0YyIIfVPo3OdNML/H0CovvbN52cwnFy8Gfmi/kt242eCSgGS1Ac6
	CkuClHpYz4hWCjhi9EhHCOrdq77wxRrQDoc/lCs=
X-Google-Smtp-Source: AGHT+IHUwyamyh2hd8Z7ZR5yD79FUnXUBCgxGIK2Artnmhw8W14mvD0k7ctS4CTlv4If9RIGmL8TgoGAtmAgPE350Jk=
X-Received: by 2002:a4a:e1cd:0:b0:581:feb5:ac87 with SMTP id
 n13-20020a4ae1cd000000b00581feb5ac87mr906319oot.1.1697626780092; Wed, 18 Oct
 2023 03:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160828.373599-1-wse@tuxedocomputers.com>
 <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com> <1c5b051e-8ee2-6f61-dc18-3c6f75b428d5@redhat.com>
In-Reply-To: <1c5b051e-8ee2-6f61-dc18-3c6f75b428d5@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 12:59:29 +0200
Message-ID: <CAJZ5v0hMZh2vYKKRwBzf=D46-GWqNANF7VR3qqRo_zkWO-MRaQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To: Hans de Goede <hdegoede@redhat.com>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 8:38=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 10/16/23 19:33, Rafael J. Wysocki wrote:
> > On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Werner Sembach <wse@tuxedocompu=
ters.com> wrote:
> >>
> >> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overridi=
ng
> >> for the keyboard to work. Adding an entry for this laptop to the
> >> override_table makes the internal keyboard functional.
> >>
> >> v2: Rebase onto linux-next
> >
> > Hans, any comments?
>
> No comments, the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.7 material, thanks!

