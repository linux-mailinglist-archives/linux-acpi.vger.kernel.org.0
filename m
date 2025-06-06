Return-Path: <linux-acpi+bounces-14201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF8AD0655
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24853A7B4D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C100289824;
	Fri,  6 Jun 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9UA2sTy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05A28937F;
	Fri,  6 Jun 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225604; cv=none; b=pC72WFmPudjiyv8RTvNtypd2bxj8FPlU4FwLqMd4qgFEGRdY9syQTDsiOzBOUu9Za5blsQ/k4TQ3UDWMEK7Atgf3oZuXb6mtgc7FPuOWD//bX7l6e7ka0P7TLMTdbDQ/786QoCNFMYvbNVY3vNx0PU9ej1+6V7ms1WlOS7Swp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225604; c=relaxed/simple;
	bh=0dJFOIZZI3h9+CUlJttgkI830u/vDy1QTXEgLX9l6xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ8YSrjtWrQhtuNgt0II0BODNcf4AvzgGWaf/T/VDBBPtgQYeWJncS3yJ014q0RMfnxN/rrHYXJkCLtXQlnxyZr0eWHKozYFlpV1Sv9wQOzM7XoZFXQkag9LyqTdwaqDeJJM47qjdQuU8+TKWk+3RT1OP5gzIf3iB9yfNz0LTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9UA2sTy; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87dfe906a87so733435241.0;
        Fri, 06 Jun 2025 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749225601; x=1749830401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dJFOIZZI3h9+CUlJttgkI830u/vDy1QTXEgLX9l6xU=;
        b=k9UA2sTygpXiiMr5DZFITuw3wrV2wyh1PV5Yt0arRjCOfauVccM6aD5By2zsT/fN0N
         SV/1ygvXF4P+GfcNShRLDauYsoN0v4aa2H+pVFo7TiCEAKJk8A2fbv5Nbk/J1iAxacl8
         3TwaulPXZgj/rs0sy7mKTbDbYQxzctBYXxZq7DmaRJ+df1XWi1M4VTZM9dyzCueA+UEF
         Sb2CYBiejgdqd4sdhBqfKbKXAeQKSUqn+Wh3L7lt/Is7vw3S5/CF2bzWEHiD9H+7G/Xx
         unqEZROhsikJC3bASkMfTTUOzBRLIhXIYypufeq50fMdcS80V+QEszoQ9t44mRbaPZqO
         Hmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749225601; x=1749830401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dJFOIZZI3h9+CUlJttgkI830u/vDy1QTXEgLX9l6xU=;
        b=rawh2I2m9UuUM00VicD74gh0cU0n9mvlFf6BTLHaGGCrnBOqrTcnI+Nh/nkcXUkNvG
         9bAq5+ufsXjG7xfG5M4+rnMSYkxXEOGL21ZevV4MHJJHnomFOQgh2iAAXks59jhVRvpV
         ePGvyg+4kbiNbygNnm6JIrVVfe71GONiHCn1yPVej12oeaA1a3ro5DF5leWoNjUv/T1w
         rg4qfUrWqyXg3O9M5G96SrmWyhWEUS4wksBN/tJok4GzyzfE3e4klbWQbLwzDcICuxzN
         Hww7FmXIbAiOwPIvmpHK0w2Ag4aoGmwk37Y3q4BYys9l/bz39FqfOGHy7P6W3jYFSnqL
         Q7oA==
X-Forwarded-Encrypted: i=1; AJvYcCU44jj+nuY1rIPBX7dFr1euhg7eMUd9vMRJOe4iCkYAspkfDUAUNKArrUSEfdgNlgbM3AhiDedQVy9INAHe@vger.kernel.org, AJvYcCU8B0V93UQGqgTBYItprKoeSPgB4EAjCsSlbfXEOMxerWSPvN6XvEveLZxpd9/+DWjzKCEY5xER5de9EA==@vger.kernel.org, AJvYcCUsCM6NEp/TXluanTlqcrRHfeZMm4GTi3uCx5b87e6oAQDy9C3iEZX93vUPztzsWGXA8td6tc7qjgm7@vger.kernel.org, AJvYcCWPLbf+5zzuVTa2KizUCJkeBXI7PeBjiek1lYDBIgHesd6Qv56nNaW0VYiCq9jom0vuIKNQ9Hp/VD0nrvjRrA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycjXjK4VXyqlVbrNT+/mYE7IAh2n947280rtG5xHpNHTzkNsac
	1WZTs6BI5Vsl5kHXCYQuWQNzlyC6qrEHtmgEp868dbVZdjj12G52Rfp5tlMOqUv0qZsRCU2/bMA
	xw2QhrqHZHxEAaPhG55XrY75czpxL/o0=
X-Gm-Gg: ASbGnctifktE0K3uvnVbVLUiIj772e7/+yzF4fZ10L5xC4z5u4amOfmhFkMu5Yvk/VL
	/n1HkCDcuWxNoTMJbmLLSiaPYv0HU/FbtzTQ4idnwnQMFUTsmaMTbVUGBwJZBTBlQtet+RcX3b9
	oo1JSMNT5chgNOzzdHAFqH4r/ojwm61Q==
X-Google-Smtp-Source: AGHT+IGIT8pKAwvT3E053ka5rCKmDZMWVRQ8M3uHmHMzX5aPj1CCrXxaJlYwiNxduBr8mvHv8BvYl+bYAcSqHDeOWjo=
X-Received: by 2002:a05:6102:fa7:b0:4e2:ecd8:a1a with SMTP id
 ada2fe7eead31-4e7728cd536mr3574282137.4.1749225601602; Fri, 06 Jun 2025
 09:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com> <aELyEqg0GrkC8oZY@pollux>
 <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com>
 <2025060635-unleveled-drowsily-a192@gregkh> <ce134894-f33e-4810-97ab-76270438fff7@kernel.org>
In-Reply-To: <ce134894-f33e-4810-97ab-76270438fff7@kernel.org>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Fri, 6 Jun 2025 16:59:49 +0100
X-Gm-Features: AX0GCFvSY0Jr_aDmFg6bKOfCHKOl-4OvqCPqVnrQ__eHQ2WfgIUMY8esXLD5Y0I
Message-ID: <CAG7QV91opwxQ=VH4A_4f8NdopW9zFuw8EnknRX1YrTpMSw5AiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to Adapter trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@yahoo.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	devicetree@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:39=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On 6/6/25 5:29 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jun 06, 2025 at 03:26:13PM +0100, Igor Korotin wrote:
> >> On Fri, Jun 6, 2025 at 2:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> >>> However, I don't understand why we need this and the subsequent
> >>> is_acpi_device_node() and is_of_node() checks.
> >>
> >> The idea is to avoid unnecessary table lookups when both OF and ACPI
> >> match tables are present. If we already know the fwnode type, these
> >> simple pointer comparisons (is_acpi_device_node() / is_of_node()) let
> >> us skip the irrelevant match function.
> >>
> >> Those checks are cheap (just pointer comparisons), while
> >> acpi_match_device() and of_match_device() iterate over tables.
> >>
> >> So yeah, it=E2=80=99s a bit ugly, but it can save some CPU cycles duri=
ng enumeration.
> >
> > You have loads of CPU cycles during enumeration, keep things simple
> > first, only attempt to optimize things later on if it is actually
> > measureable.
>
> I'm fine either way, I don't expect much value in optimizing this and at =
the
> same time I don't see doing it adds significant complexity either.
>
> If Greg prefers not to have this optimization to begin with, let's go wit=
hout
> it please.

I'm ok with this as well. Will remove those checks. I assume that I
don't need to align with `FwNode` abstractions in that case. Also I'll
drop `is_of_node` rust helper in v3.

Thanks for the review and your comments, guys

Cheers
Igor

