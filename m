Return-Path: <linux-acpi+bounces-974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD47D734F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A8BB20CF5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399231A76
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F01C6B0
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:04:59 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575519F;
	Wed, 25 Oct 2023 11:04:56 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5841a3ffd50so8825eaf.1;
        Wed, 25 Oct 2023 11:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698257095; x=1698861895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2qcjwUXE1aKiq13mvrfsyqSxcTHIv2JD77GGB4bQZM=;
        b=aqVQUZQbaWH65Kp4jCdJSTC6I0sfeesUaNsT8rzfhaPwueedSpXazrap/81OlRIzhR
         kuSjcQ6fkebvpak8Tm6il4uJMFCF96divIVdbzbx2R8bxV+5JqJP1NuX2aE8lKHUiPil
         VsYeDZspdKQ6FvCinGoP3NW3JAouGVcu7XHAkDxmQbOqxMRlf+/k76B9k9J4de+oKUhk
         Uphn2Vlu9TkxxeTcz/bxUlUE4O/SkVlgvC/qGeZRY1yOVcsYx8ia6YqmM56NUIEmCSxJ
         4SmY06Mi/DAKdmaiJXXVqswX6XfD5wgeRIBKAquBG490vfk/kohWu+Bg/Lvf8v55O0Kl
         knHw==
X-Gm-Message-State: AOJu0YxbBVBmwTaGJxa6HiT0I8hg5oxXtLxdJI90p1dKXPpFHNzoWwQt
	8Ui8dHFbaYWkNp+f+hfFwxpdgKHxOwijAGHQRah8epYm
X-Google-Smtp-Source: AGHT+IF7JItGzgyIVJoHtTNv9nGYOjuQsTwQ+v5Cz0+5FDzryJknCl50lwAiVPrlGeQZFqgV/RZez0upfQ/ZVpVU6H8=
X-Received: by 2002:a05:6871:3319:b0:1ea:bb5:a534 with SMTP id
 nf25-20020a056871331900b001ea0bb5a534mr17179043oac.5.1698257095227; Wed, 25
 Oct 2023 11:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025053833.16014-1-raag.jadav@intel.com> <20231025055345.GI3208943@black.fi.intel.com>
In-Reply-To: <20231025055345.GI3208943@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Oct 2023 20:04:44 +0200
Message-ID: <CAJZ5v0iYA3Qh=KQm_+XGm=jvLO=ZN-AyYx7DW=-EiqkE5LS19Q@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, andriy.shevchenko@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:53=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> > Use acpi_dev_uid_match() for matching _UID instead of treating it
> > as an integer.
> >
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I was about to apply this, but then I realized that it might change
the behavior in a subtle way, because what if the _UID string is
something like "01"?

