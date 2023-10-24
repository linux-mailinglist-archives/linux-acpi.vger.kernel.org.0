Return-Path: <linux-acpi+bounces-940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A241C7D5C81
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596DD2819A5
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404E3D39B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE78266AD;
	Tue, 24 Oct 2023 18:52:09 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063BA6;
	Tue, 24 Oct 2023 11:52:08 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ea1742c1a5so1380458fac.0;
        Tue, 24 Oct 2023 11:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173528; x=1698778328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b47eW1W1ZA3iY9fGQWptMYQkO14e99bJy5u+/oy5i2Y=;
        b=aZEwBny9h18y3Sexpm1gP6WTOHnyV+grEkCz6WuZVsCCwZ2JVuDM/GR3oH2n2MVgMD
         LMBQCQfVWdV92nSSvAl2DZXuMIyxyToOV8EuiEVpohVVvZZQs0wIDl6ntkLK/jEWlva3
         6IaMeyzOO0loI1COrMmRKa6SzTehfiZeOoRb9o6Blu6BNbO8iPIjX1rX81lZ2h/R6yQK
         /YtksuEUYxoJM3KCIaW9z55oPKD1O5F1Hy8XmzvOgSxXYD/hBxQjZLeZiUqdr5cRlDV6
         sBWjeBgQgbHpak/qLLWZ+7+6fbhI+pbyo9zyEbPFDDSXtrif6mpxwrR9gEt0qt4GYXSt
         iVVA==
X-Gm-Message-State: AOJu0Yw04wr7yV0HId29biuCd9JJWS9GVl7/RWdLVvMRccapd6clWVIQ
	gL4fvXGmmZnXr4XK5ctYVGhDuJt0pUTfNjcawZg=
X-Google-Smtp-Source: AGHT+IGEyL46Vaabh0PQgToQaEorF+rTwJ2e/VuAsoUSTFafddKjwzGKWYy/ed+ekhC8GDeNVIsCZEpkTFfXDb/+gKo=
X-Received: by 2002:a05:6870:9a98:b0:1e9:9e04:1d24 with SMTP id
 hp24-20020a0568709a9800b001e99e041d24mr16645138oab.5.1698173528060; Tue, 24
 Oct 2023 11:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712223448.145079-1-jeshuas@nvidia.com> <ZTfhpRRA4bga0qSI@agluck-desk3>
In-Reply-To: <ZTfhpRRA4bga0qSI@agluck-desk3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 20:51:57 +0200
Message-ID: <CAJZ5v0j2mbKOqDaL_31fL9ftTZRhUiURx3nubLmLUo3-R_w3gw@mail.gmail.com>
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
To: Tony Luck <tony.luck@intel.com>, Jeshua Smith <jeshuas@nvidia.com>
Cc: keescook@chromium.org, gpiccoli@igalia.com, rafael@kernel.org, 
	lenb@kernel.org, james.morse@arm.com, bp@alien8.de, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-tegra@vger.kernel.org, 
	treding@nvidia.com, jonathanh@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 5:27=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> On Wed, Jul 12, 2023 at 10:34:48PM +0000, Jeshua Smith wrote:
> > Slow devices such as flash may not meet the default 1ms timeout value,
> > so use the ERST max execution time value that they provide as the
> > timeout if it is larger.
> >
> > Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
>
> > +/* ERST Exec max timings */
> > +#define ERST_EXEC_TIMING_MAX_MASK      0xFFFFFFFF00000000
> > +#define ERST_EXEC_TIMING_MAX_SHIFT     32
>
> I've recently become a fan of <linux/bitfield.h> I think this would
> be easier on the eyes as:
>
> #define ERST_EXEC_TIMING_MAX    GENMASK_ULL(63, 32)
>
> > +static inline u64 erst_get_timeout(void)
> > +{
> > +     u64 timeout =3D FIRMWARE_TIMEOUT;
> > +
> > +     if (erst_erange.attr & ERST_RANGE_SLOW) {
> > +             timeout =3D ((erst_erange.timings & ERST_EXEC_TIMING_MAX_=
MASK) >>
> > +                     ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
>
> then this becomes:
>
>                 timeout =3D FIELD_GET(ERST_EXEC_TIMING_MAX, erst_erange.t=
imings) *
>                           NSEC_PER_MSEC;
>
> > +             if (timeout < FIRMWARE_TIMEOUT)
> > +                     timeout =3D FIRMWARE_TIMEOUT;
>
> But that's just a matter of style.  Otherwise the patch looks fine.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.7 material, thanks!

