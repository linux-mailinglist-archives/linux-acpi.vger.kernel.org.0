Return-Path: <linux-acpi+bounces-939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685057D5AAA
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C54280ECC
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E953CCEA
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AC3B7BF;
	Tue, 24 Oct 2023 18:27:13 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC81A2;
	Tue, 24 Oct 2023 11:27:10 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1e99a55a9c0so734273fac.1;
        Tue, 24 Oct 2023 11:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172030; x=1698776830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZB5g9jVTVNd81eeii8uxLo5X0yRuiVq8WyebZu9f0ok=;
        b=UcaLjFkedGJtoYFbqpwb05Tte1Y6/Qz++/THENR/+Q1+tpmb0yrYlEK+mBz+bN2AOA
         x1W947p3WbL63fXeo+rTURUlBh9+jGgVtaBwebJ7z58rJvWev03+YadpEL3k2c/X/490
         C3W1TgyH6dVe0kMDya5Jc4v9WnOWbqTt3nmxuh6JLgsPtf+4NqrcLeHsJWFSzDhJASsa
         uySO7Z7khjvNTf+jTrGHB23UIG5wFC5yAl1/Akbf8QkWvJzYr8BVC5VPGkbIoztydEVB
         ml0rRhF3iAljspTb4hzX+yRHlEK/G1XeUIrxksDnKx98geCo0i+ybksHUYxzR4wZT/Mx
         SyWg==
X-Gm-Message-State: AOJu0YzurFXh+OQ2r/NxgtzNzOMTnTsbSicmIKQ4KRFRN7iC8VDZLt1Y
	McYuUqSvj23dT2zYeftgYzNbcw/PpFsAzbJiCFI=
X-Google-Smtp-Source: AGHT+IHYw04Ty/CGd2NctaMoui4YrLNgBZQzIhNXmipd8DpS8HZWntl33os4cOY1dCw/clSDDFMROR1KkS5avBsdGCU=
X-Received: by 2002:a05:6870:cb81:b0:1d6:4c63:7ba9 with SMTP id
 ov1-20020a056870cb8100b001d64c637ba9mr17269512oab.3.1698172030159; Tue, 24
 Oct 2023 11:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 20:26:58 +0200
Message-ID: <CAJZ5v0j-73_+9U3ngDAf9w1ADDhBTKctJdWboqUk-okH2TQGyg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual cpuhotplug
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 5:15=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> I'm posting James' patch set updated with most of the review comments
> from his RFC v2 series back in September. Individual patches have a
> changelog attached at the bottom of the commit message. Those which
> I have finished updating have my S-o-b on them, those which still have
> outstanding review comments from RFC v2 do not. In some of these cases
> I've asked questions and am waiting for responses.
>
> I'm posting this as RFC v3 because there's still some unaddressed
> comments and it's clearly not ready for merging. Even if it was ready
> to be merged, it is too late in this development cycle to be taking
> this change in, so there would be little point posting it non-RFC.
> Also James stated that he's waiting for confirmation from the
> Kubernetes/Kata folk - I have no idea what the status is there.
>
> I will be sending each patch individually to a wider audience
> appropriate for that patch - apologies to those missing out on this
> cover message. I have added more mailing lists to the series with the
> exception of the acpica list in a hope of this cover message also
> reaching those folk.
>
> The changes that aren't included are:
>
> 1. Updates for my patch that was merged via Thomas (thanks!):
>    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
>    rather than having this change spread through James' patches.
>
> 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
>
> 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
>    and "ACPI: Rename acpi_scan_device_not_present() to be about
>    enumeration" to the beginning of the series - these two patches are
>    already queued up for merging into 6.7.
>
> 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
>    a helper" to the beginning of the series, which has been submitted,
>    but as yet the fate of that posting isn't known.
>
> The first four patches in this series are provided for completness only.
>
> There is an additional patch in James' git tree that isn't in the set
> of patches that James posted: "ACPI: processor: Only call
> arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> be a workaround for arch_unregister_cpu() being under the ifdef. I've
> commented on this on the RFC v2 posting making a suggestion, but as yet
> haven't had any response.
>
> I've included almost all of James' original covering body below the
> diffstat.
>
> The reason that I'm doing this is to help move this code forward so
> hopefully it can be merged - which is why I have been keen to dig out
> from James' patches anything that can be merged and submit it
> separately, since this is a feature for which some users have a
> definite need for.

I've gone through the series and there is at least one thing in it
that concerns me a lot and some others that at least appear to be
really questionable.

I need more time to send comments which I'm not going to do before the
6.7 merge window (sorry), but from what I can say right now, this is
not looking good.

Thanks!

