Return-Path: <linux-acpi+bounces-2126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382AB803A75
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B8A280FE8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DF2E65B
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 16:36:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CE99;
	Mon,  4 Dec 2023 08:32:53 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d7ea8b4581so492351a34.1;
        Mon, 04 Dec 2023 08:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707573; x=1702312373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn4pD1gA2GtmA9HlH0C0U9ulVAJ/43nKIwnaRGSr6IQ=;
        b=V75jmcQJiNVacjtVlHzbh9Q8YhtAXXD0Z3B1ez9f4FXhu+XOsKGi1OFAY5GMUSAoO7
         69BryOzOR+M2N28knJj9y8xOlHNl4/wcXkBj0iXu31SXiqjwQb+yt4NaMwESqD8XC6pX
         yf6C7SohNyo+Ig1H5+kz39Qr5VcmvKWbvfAtvXDagkyjxKM5egrCbVckQ0jYbDq08SZX
         pxyktez0P7fvY55LwNYntRcly3Vy0cwojQFJRJ9F1Fjfrfici9lJuLnnrrsOVkGK3+qh
         KYTUZKacTGOa3DKpfIWiSWqkiJgd9YT5p6sgJ6Sh8pcDDyP1ikQ2tYdM6wPDuxhOk0b2
         LBwg==
X-Gm-Message-State: AOJu0Yxwvro5KyJU4FVW4B9TTsr38xmx6V0MGMNp9Upa8RHUAHCxZs9c
	ZojFvUCyOOIwe0rspUWP1ImX1eB+wHfidwt9mlg=
X-Google-Smtp-Source: AGHT+IG6HzJNK+5zbjAVWt3hnnTgEX1LXL/Hj5C1l5v8CgJzaA0RFK6zejwqjK5B0wbjpLqeH/kjVGFBKb900kCTFBI=
X-Received: by 2002:a05:6871:528a:b0:1fa:f404:b958 with SMTP id
 hu10-20020a056871528a00b001faf404b958mr12686542oac.3.1701707572969; Mon, 04
 Dec 2023 08:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3281896.aeNJFYEL58@kreacher> <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
In-Reply-To: <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Dec 2023 17:32:41 +0100
Message-ID: <CAJZ5v0j1fHebN0w0oYFv0CapkF1XvQ-0xWtQtuLtx0So50hzsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Dec 2, 2023 at 3:31=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 11/29/23 14:45, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This series improves acpi_os_execute() on top of
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLo=
T@kreacher/
> >
> > but only the last patch really depends on it.
> >
> > The first two patches clean up the code somewhat and the third one modi=
fies
> > the function to allow Notify () handlers to run on all CPUs (not on CPU=
0 only).
> >
> > The last patch changes it to use GFP_KERNEL for memory allocations, as =
it does
> > not run in interrupt context any more after the change linked above.
>
> I have added this series, as well as the preceding
> "ACPI: OSL: Use a threaded interrupt handler for SCI"
> patch to my personal tree now, so that it will get tested on various
> devices when I run my personal tree on them.
>
> I'll let you know if I hit any issues caused by this series.

As stated here

https://lore.kernel.org/linux-acpi/CAJZ5v0jkHLGa2XxB4TMqzrBBdZYXY79+sh1Z0ZF=
6keYdLDyfkg@mail.gmail.com/

the last patch in this series is not really a good idea just yet, so
please drop it.

Thanks!

