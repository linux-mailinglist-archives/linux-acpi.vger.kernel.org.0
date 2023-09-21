Return-Path: <linux-acpi+bounces-15-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5C7A9547
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201ED1C20AD3
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C81304E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 14:30:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA8B641
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 13:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75009C4E683;
	Thu, 21 Sep 2023 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695301757;
	bh=yAwCJjSMFMlMIBKVIk7qYPpTeU00hSIhJXw0KgaQv2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dDCs0y4leKCNNse29XK/7s764dl4ZcWvG6Hb8WhFv6KK7PYG+DZuqnEguLf+latrX
	 KAW2BXC56oalCI/mEqVzwtPZzvZXWIhUc0+57ynKi0y3ynxddV4MBI6GOkJG2KNLj4
	 Cirhtpzbm8OKfKqUKtE0CHvJSyJCsYn8uE7cO8LXPcHcGrQ3RhxC8OHOmYS52C/L9e
	 dess+NkUw3Fsn6mnBkRX8UPAuoouxnAD3syS2qgtRwDMxGZYw14PFj8WvyWgDz3BLO
	 I9SyfuoeL5eGVrRI3/v799+c4Z2UkqfRpe14Vcv8jMVhYuiOCddweVn7V+wcfBxe04
	 3ef/huaSztenQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-503012f4e71so2472744e87.0;
        Thu, 21 Sep 2023 06:09:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxMTwmOpkebywUITTo0vhyqJ4tTzamplGpSHOgSJxnAHfJ0/XU5
	hpoUBpWt85Ey2ioXu+U0a+Rl8TpvoJ8iJnErplU=
X-Google-Smtp-Source: AGHT+IE+A0IgOmBYCfeOwtLKlr2k/PnxkhL5xbSIL6oTs0ZhBPO/aaWneyxH5hDNwCWUTuzRJ5B88jpK/YlPDdeG6yI=
X-Received: by 2002:a05:6512:239c:b0:4fe:13c9:2071 with SMTP id
 c28-20020a056512239c00b004fe13c92071mr3278684lfv.2.1695301755687; Thu, 21 Sep
 2023 06:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12299447.O9o76ZdvQC@kreacher>
In-Reply-To: <12299447.O9o76ZdvQC@kreacher>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Sep 2023 13:09:04 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
Message-ID: <CAMj1kXHpVroVqXxH72XNJP5=dYDcfBiZex2wE2jOsSFNEAYqxg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Sept 2023 at 13:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of
> acpi_processor.c") added acpi_proc_quirk_mwait_check() that is
> only defined for x86 and is unlikely to be defined for any other
> architectures, so put it under #ifdef CONFIG_X86 and provide
> an empty stub implementation of it for the other cases.
>
> Link: https://lore.kernel.org/lkml/c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
> Fixes: 0a0e2ea642f6 ("ACPI: processor: Move MWAIT quirk out of acpi_processor.c")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Frank Scheiner <frank.scheiner@web.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is kind of orthogonal to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=remove-ia64&id=a0334bf78b95532cec54f56b53e8ae1bfe7e1ca1
>
> because if any architectures other than x86 and ia64 decide to use the
> processor _OSC, they will see the reported build error.
>

You mean when other arches #define CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC too, right?

In any case, this is going to conflict with my change, which is
already in linux-next (you were cc'ed on the PR to asm-generic). What
do you propose here?






> ---
>  drivers/acpi/internal.h |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -148,8 +148,11 @@ int acpi_wakeup_device_init(void);
>  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>  void acpi_early_processor_control_setup(void);
>  void acpi_early_processor_set_pdc(void);
> -
> +#ifdef CONFIG_X86
>  void acpi_proc_quirk_mwait_check(void);
> +#else
> +static inline void acpi_proc_quirk_mwait_check(void) {}
> +#endif
>  bool processor_physically_present(acpi_handle handle);
>  #else
>  static inline void acpi_early_processor_control_setup(void) {}
>
>
>

