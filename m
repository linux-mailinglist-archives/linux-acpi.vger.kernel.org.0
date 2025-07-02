Return-Path: <linux-acpi+bounces-14954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB99AF60CC
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A821352507F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5830E836;
	Wed,  2 Jul 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHHKi4ac"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85183253351;
	Wed,  2 Jul 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479651; cv=none; b=f8bK+N1M1Klg7YlxsrAipIhp0r8mcLuWY+qQNCW7JM96rSQQcsXEpKcHHtge3jUMTcv/9C/SIMDrXUjnxF9Ud7qFJb7wM43CHj5UA3Ghne9w+eJUfxZqE/fuVFPcWvkXPukR9daBKZfh6+FbCg9BnaMOwFfo2LpbQdY+ArP/bps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479651; c=relaxed/simple;
	bh=CAna35rJ6GALV6IbfjyVSBAdiNUhdYkS0obyApasYHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN8kBiXgWdFf3biCsqxa6YYdfxmduGZvXDHEZ0UpUHVPWxSEgRsVi6j6QDwMcrdfWJ66SHjpJDhrzXwp2aRa5Rt/3p4WiRzlUNTveDMPad1+ziv4WB79VaqcAoHtJi/MtqmsVLeT6/Noj/lic1sLSXHvhu378NPzcmhXEpvJ7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHHKi4ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D6C4CEE7;
	Wed,  2 Jul 2025 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479651;
	bh=CAna35rJ6GALV6IbfjyVSBAdiNUhdYkS0obyApasYHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cHHKi4acxaVV+tHbNmbzBpn4Mk/9YnVaqvDchgSyWT/eNrKngO0RsSspl7QAz4tMK
	 gF4sWTsWC8mmP56QNElLuJlxTbd5V9c7rx3MfLYwQmJhhwtA5XwGfGjBABdMsEPKnN
	 +EOpvVtGVflL9qmsoQBen+If6Bc/Z/0ggJmTvRbrtiZJaJh+YaFPbywCdAGpoCPOhU
	 eL2KYTeOEsGvOngjx16OS+fijy4ZhFSC6NyN5Hjo6yBeZNSWxnjbqQ3crh5Q5mWDuI
	 +fthoLiHL2d41Z5q/0e575CwbbZVi4zdcFqCmG4050KKpPQuOP2BqEikASPqqt2yIz
	 IcoY+W4Qe7OHQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c47631b4cso3482617a34.1;
        Wed, 02 Jul 2025 11:07:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAhFjTrjYT+NbLThP0u+87xqE5ssc1nOY39yJ1sv4dpBmEM+ffRK3q9TXOhdOkKu5m3TZ3VbDmRiPBrjj9@vger.kernel.org, AJvYcCVZtRY+mj3TgcmT/XP0Kay5lRyUpIrTFXnURJYX/GY4o9u1bs/MI/GxtQ0Rj9DPdk7MHr2OmEwAEu+d@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzXYaL2RDSUNxg1hqZWYbL+H990OVD600i/sg5aeQn6x+h7jM
	g2zb7V6C6UghOm4oGRMVbXHg3e38vvQSAVTyvHY2pwP6mGgh7n+Ro5y9lJKM22Fq6f7CxoXX9rA
	ZGE4O+QR5eSnlCbVr29KR2WpL1iTtEzA=
X-Google-Smtp-Source: AGHT+IGWKwFOYlhIbYrgckIt5yGU/A31JTxlNE8phOBfmGIbSbxfaWqy7svZGEFTnrGzcmkJ4G0we3c4LZ92Xt3Tj0Y=
X-Received: by 2002:a05:6808:f88:b0:40a:52e5:37df with SMTP id
 5614622812f47-40b8911371amr3195467b6e.39.1751479650323; Wed, 02 Jul 2025
 11:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626130109.215848-1-andriy.shevchenko@linux.intel.com> <20250627044722.GN2824380@black.fi.intel.com>
In-Reply-To: <20250627044722.GN2824380@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:07:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j08S-Q9bXV-CyEFfVuTgDMjhqF+WnKuDCAq=zr_=PUiQ@mail.gmail.com>
X-Gm-Features: Ac12FXwsUsP4b5PpYllMsXAo2qo1Wl8GWy5NaokNmmPhjzm31VnJ5-8owbQiAT0
Message-ID: <CAJZ5v0j08S-Q9bXV-CyEFfVuTgDMjhqF+WnKuDCAq=zr_=PUiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties:
 Spelling and style fixes
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 6:47=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Jun 26, 2025 at 04:01:09PM +0300, Andy Shevchenko wrote:
> > - Use consistent style for active-high and active-low
> > - For C and ASL code snippets use 4-space indentation consistently
> > - Interleave case examples with the explanations of the certain case
> > - Remove or add commas when appropriate
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied as 6.17 material, thanks!

