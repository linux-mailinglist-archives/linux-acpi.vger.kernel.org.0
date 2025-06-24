Return-Path: <linux-acpi+bounces-14567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F5AE6DF5
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767EB4A0C1A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4E2E3B16;
	Tue, 24 Jun 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuZWFt6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFB2DAFB9;
	Tue, 24 Jun 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787804; cv=none; b=F6Yrbznrm3DwrEIqwl/kH/qhJfKM8nryl3yb0ibM8sxgKXPUIuvpD6L6n+fnnd4wjzkRrrRIxf5aAkGImFKWLWNudVblKVmtHSUgQ4tkW4bkHE2iWV+J+mG98qXlJDx18wbYWTfOgNR0RWLyYQSh6idDHUlfkeeFrkzegFZBews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787804; c=relaxed/simple;
	bh=STdjH06ZEoi9PRmrLJP7FLKxed9+IlHUbKgbwftgTek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WETA2VjBrknumLayat/JPRL9C2MaTBz8Ynh/Y95BQxAk/8mSPu7GdrqXlSFML568ZFJm5G/WDfVgKKikRJ5g3fyrG2wuZFRdPSMDnbx09Js7RVNvAayEhXB2+n+/kyhn0Cf5WM/toEUEIE4JZKYP25zH6xQQmonYlpXDPyohApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuZWFt6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DD3C4CEF4;
	Tue, 24 Jun 2025 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787803;
	bh=STdjH06ZEoi9PRmrLJP7FLKxed9+IlHUbKgbwftgTek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iuZWFt6yt3SnNPdQqHHkfWb5c/6qcFToxw9CVQBpihM0nFhHuYLaaMe6FfGfTtBiv
	 rH5iktqyrE6a5iniGtlrDmpNojLpXeqiBXTcHLPNsHC9gp7EV2DTM6VcObEU3BSVxl
	 U36zx0MZZxSKxIwAQAkaIFk8AZxCggXtOi4RyIfNhLuY0fsnUanTCbIhC0bUptx0Rp
	 XcUv1HnjCQbmqBdOFLjurtJY446q3YWEJ1foBeO2eXJLgqHqaU/Sw7PzLlX8daENeU
	 fC6sS564B57ksOwTobmu4jaNYJp5shaTRSkzLhqvbZ7or/u9QKZnLncWUqVmMcWns/
	 +iIPREtbKN6DA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60f24b478e3so2908153eaf.3;
        Tue, 24 Jun 2025 10:56:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjBCyPFAgWVbBjPX5yYuj9zLh3dhOzQpEaXOkHR0/bpIj2v6X523gNXm5CKYtX5zf0pJkOx4qRvwU3Goji4dk=@vger.kernel.org, AJvYcCUrLY9SkWvW22Bh/LSvCjKApT1V30Xu9GBF0VEhxLNYW1RHa3+l/WiDMpXtPX7h0AXaTDQ1cbfEDpoZ@vger.kernel.org, AJvYcCX85fACMm2z5pgZWxvvtQYrO3/NY8zTLoPXZmtTIE/rhYM4ohYItiPvw7HdRS4Wuu/+Jd4XbPsuFfh1DEOj@vger.kernel.org, AJvYcCXbIM0sgL/Oxjz8OygIL/G2VfkULr7b9UHM5qHZB6xDCKXI/ZvRaIEbNUk2Lk+OrNnRzv4gFoLNl/hPBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDivGbmgn7dP5qkHGWr/8uzoVx6O3IwrmrK7IX5wla0qdy1Bm
	3n7iTNrGX5F07rTS1oxqIWJwE8moik4ywVjRS4lp8NF+ntJwnbT72eTwnMRAhleBbM7xiqZSb4k
	EA1k70rJdl/wvc94Ss6MbMu9mlBCuzxU=
X-Google-Smtp-Source: AGHT+IGtZmw+qiUqob8uolYYHaLvj7zQCRMrhowwkQ6uaCuY6yqPQStnuSx1CMSohXJmqc1ErtElSyNm5m+nxc2StOA=
X-Received: by 2002:a4a:e90a:0:b0:611:31a:6ff5 with SMTP id
 006d021491bc7-6115ba3ea53mr12497524eaf.7.1750787802958; Tue, 24 Jun 2025
 10:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620152425.285683-1-igor.korotin.linux@gmail.com> <aFXbcDKP_jw_Sg5k@cassiopeiae>
In-Reply-To: <aFXbcDKP_jw_Sg5k@cassiopeiae>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Jun 2025 19:56:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggAFg-pcujf5BysNNp3ncStOWruyAemFLJB5=95uu9XA@mail.gmail.com>
X-Gm-Features: AX0GCFsuxGTM77WPv_Ty8PU9EPeo6p7qzhGvatJp50zVE0gHymfHgjEibVHegIQ
Message-ID: <CAJZ5v0ggAFg-pcujf5BysNNp3ncStOWruyAemFLJB5=95uu9XA@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Alex Hung <alex.hung@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Remo Senekowitsch <remo@buenzli.dev>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Len Brown <lenb@kernel.org>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:06=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Fri, Jun 20, 2025 at 04:24:25PM +0100, Igor Korotin wrote:
> > `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
> >
> > This is used by subsequent patches, in particular the i2c driver
> > abstractions, to create ACPI device ID tables.
>
> I think this should say something like
>
>         "Enable drivers to build ACPI device ID tables, to be consumed by=
 the
>          corresponding bus abstractions, such as platform or I2C."
>
> instead.
>
> If we agree, I can change it when applying the patch -- no need to resend=
.
>
> >
> > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
>
> @Rafael: Can I get an ACK for this one, such that I can take it together =
with
> all other patches through the driver-core tree?

I don't see anything objectionable in it, even though Rust code is
still kind of outside my confidence zone ATM.

Anyway, please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to this.

Thanks!

